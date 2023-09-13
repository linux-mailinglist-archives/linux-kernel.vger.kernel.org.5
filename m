Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 328D379ED2A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjIMPfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbjIMPfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:35:09 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B7DB1990
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:35:04 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9a9d6b98845so246148666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694619302; x=1695224102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tQS1uLzGm/YC/GzivOaGJCClvgDA4y68ZbPZk06T4sQ=;
        b=JeFzwbmIYaDZpQXB9ErYm8gocscixOjGIXDTDz1GHOQpvUBLheDs65u1B/wKvP9Pfi
         wlH81SM7Q9VrB+INRQySs3Ruo2Nt4LMivBZ/qJttGqaa1KdU5j3cn/4q8FAkgUr3W7dv
         sBSS+MtpCgyxMrdDJ6L3/48Z7tgpSIgd5qR5s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694619302; x=1695224102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tQS1uLzGm/YC/GzivOaGJCClvgDA4y68ZbPZk06T4sQ=;
        b=sbfwlyZIcT7QB+7ILOiA0MfIH7QBLz8bUsqhEp40xLByESLPnt5/+3HGlvvPQghtIr
         9n5nQlEHP0lKQo7FNTFkRk7jxjjf2LsywRudNoRpyErg/dgfk7+Tp610TtbH58Lv0c93
         /D943DrnY6jH+1GgtO0nbq3j8I/4izcgHFrnbQHc0PGWN9Jk4D61LUw3E0uoA6QuVTzQ
         JXLWzN0auxAOgl0LegEsk/4ykrYL7v3VaMyTFrHBJhbficKaq3FLfusG6zvVru/EvyWq
         v36XQ3P7X+vqZWFrP+88ETTXz5woy3XSPAzRwrC3/XlNEmj6YJB0QzMwmEoKJEmlG+ZL
         7Vcw==
X-Gm-Message-State: AOJu0YzBr8hoA1sJixWrCJqVQ2HunEc4AADyEB6T+HUh+6EqPmmuuHsT
        efFVquU1M2RqDRKYlJH1qKeEcpIVf+2+I1NEBQx4Dg==
X-Google-Smtp-Source: AGHT+IF/If8otc4vLlPpJ2LEC/z92afthORaT8ukrdavONavSW5hAf8Y5wT5uSNKn3NAYjOedkjeZw==
X-Received: by 2002:a17:907:3e9e:b0:9a5:7d34:e68a with SMTP id hs30-20020a1709073e9e00b009a57d34e68amr8203281ejc.28.1694619301733;
        Wed, 13 Sep 2023 08:35:01 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id fx12-20020a170906b74c00b0099ccee57ac2sm8596987ejb.194.2023.09.13.08.35.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 08:35:01 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4005f0a6c2bso78075e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:35:01 -0700 (PDT)
X-Received: by 2002:a05:600c:34d4:b0:3f7:3e85:36a with SMTP id
 d20-20020a05600c34d400b003f73e85036amr122941wmq.7.1694619300711; Wed, 13 Sep
 2023 08:35:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230901234202.566951-1-dianders@chromium.org>
 <20230901164111.RFT.1.I3d5598bd73a59b5ded71430736c93f67dc5dea61@changeid>
 <ZPSsBhbekKY7VyDg@shell.armlinux.org.uk> <CAD=FV=WT4Hf1XVA641WtNFg4WRYFKarU1WOkLPEbr0eiVQuZPg@mail.gmail.com>
In-Reply-To: <CAD=FV=WT4Hf1XVA641WtNFg4WRYFKarU1WOkLPEbr0eiVQuZPg@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 13 Sep 2023 08:34:45 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UpJEFKcsnHSzPqEiGaWusp50DrcEh=mcra4eLeRQT5NQ@mail.gmail.com>
Message-ID: <CAD=FV=UpJEFKcsnHSzPqEiGaWusp50DrcEh=mcra4eLeRQT5NQ@mail.gmail.com>
Subject: Re: [RFT PATCH 01/15] drm/armada: Call drm_atomic_helper_shutdown()
 at shutdown time
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>, airlied@gmail.com,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Sep 5, 2023 at 7:23=E2=80=AFAM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Sun, Sep 3, 2023 at 8:53=E2=80=AFAM Russell King (Oracle)
> <linux@armlinux.org.uk> wrote:
> >
> > On Fri, Sep 01, 2023 at 04:41:12PM -0700, Douglas Anderson wrote:
> > > Based on grepping through the source code this driver appears to be
> > > missing a call to drm_atomic_helper_shutdown() at system shutdown
> > > time. Among other things, this means that if a panel is in use that i=
t
> > > won't be cleanly powered off at system shutdown time.
> > >
> > > The fact that we should call drm_atomic_helper_shutdown() in the case
> > > of OS shutdown/restart comes straight out of the kernel doc "driver
> > > instance overview" in drm_drv.c.
> > >
> > > This driver was fairly easy to update. The drm_device is stored in th=
e
> > > drvdata so we just have to make sure the drvdata is NULL whenever the
> > > device is not bound.
> >
> > ... and there I think you have a misunderstanding of the driver model.
> > Please have a look at device_unbind_cleanup() which will be called if
> > probe fails, or when the device is removed (in other words, when it is
> > not bound to a driver.)
>
> ...and there I think you didn't read this patch closely enough and
> perhaps that you have a misunderstanding of the component model.
> Please have a look at the difference between armada_drm_unbind() and
> armada_drm_remove() and also check which of those two functions is
> being modified by my patch. Were this patch adding a call to
> "dev_set_drvdata(dev, NULL)" in armada_drm_remove() then your NAK
> would be justified. However, I am not aware of anything in the
> component unbind path nor in the failure case of component bind that
> would NULL the drvdata.
>
> Kindly look at the patch a second time with this in mind.

Since I didn't see any further response, I'll assume that my
explanation here has addressed your concerns. If not, I can re-post it
without NULLing the "drvdata". While I still believe this is unsafe in
some corner cases because of the component model used by this driver,
at least it would get the shutdown call in.

In any case, what's the process for landing patches to this driver?
Running `./scripts/get_maintainer.pl --scm -f
drivers/gpu/drm/armada/armada_drv.c` seems to indicate that this
should go through the git tree:

git git://git.armlinux.org.uk/~rmk/linux-arm.git drm-armada-devel

...but it doesn't appear that recent changes to this driver have gone
that way. Should this land through drm-misc?

-Doug
