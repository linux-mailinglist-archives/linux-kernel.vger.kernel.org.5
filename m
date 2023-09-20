Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020747A8B0C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 20:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjITSD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 14:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjITSDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:03:55 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2C994
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 11:03:48 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso2274466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 11:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695233026; x=1695837826; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wNWpiq1Y/Z/txxjcp0TRMtu8Ee0OMKlu6U++2G9rtSM=;
        b=fsdyJni6lK1O1fUFnXbIkqL3ol6n2HJcM0w8qDDQ+vsrluynxfwxHm08lKPLZDyB/S
         a+n6mqkOv4WyxDOMhgDcKKMqF96WFnxVkHq4EAb0X3UKUlGfcQOFto4pFoLsr/x7jElo
         BB12vXpaNb1ZEAtiV7UwnNDNAKpemVQY1trHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695233026; x=1695837826;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wNWpiq1Y/Z/txxjcp0TRMtu8Ee0OMKlu6U++2G9rtSM=;
        b=UmwwTjrSDjgFZVMVTEPPleaqgl6Dy/HczqhPGLavfGhhq+637PXYtRaLvmMpd1Cf5s
         tq8XtVl8sCwuBWpNSqxxrWb6csohcTAE/JpdjdlDe1Tu93BQTlrXycdAorlRmaoxjlXH
         vRoLvY1yd+CuNgadseY50VkYoy1kQ73KuxUCWbRmTEYEjqso9W8+RlzH+SxTPQ9gaRY7
         tHpZ4j86DDgujR4PdF80AyHqtM07ztGOJvglkD6canf1w+Kpr9kKtxmOafFNL1HxjzSU
         IgvyWuonb16NY+JQYZDhbZt2lkE6nbUUO/UrJfhTdxlBiJhSE9hKM2N5JyPfRcZFW6nc
         kgAA==
X-Gm-Message-State: AOJu0Yxn2Ms9qnicgaRapYVchfX3RKCSoouZUzFiarldFR1B0YgwVoYc
        Pe+imUK6yEYbIYQGGbevycrlosFN9w3VSiQOg20Plnf7
X-Google-Smtp-Source: AGHT+IGKyvSpwlasB7pU6gawqIHhTDUKZgUjOG9kpOe0WK/0jdMebqm8MMcEQCMwWDsEylD8uSmpkQ==
X-Received: by 2002:a17:906:1da:b0:9ae:513d:47bd with SMTP id 26-20020a17090601da00b009ae513d47bdmr1861718ejj.26.1695233025253;
        Wed, 20 Sep 2023 11:03:45 -0700 (PDT)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id kt26-20020a170906aada00b0098f99048053sm9941478ejb.148.2023.09.20.11.03.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 11:03:44 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-404f881aa48so12235e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 11:03:44 -0700 (PDT)
X-Received: by 2002:a05:600c:3b95:b0:3fe:dd72:13ae with SMTP id
 n21-20020a05600c3b9500b003fedd7213aemr6399wms.0.1695233024332; Wed, 20 Sep
 2023 11:03:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230901234202.566951-1-dianders@chromium.org>
 <20230901164111.RFT.1.I3d5598bd73a59b5ded71430736c93f67dc5dea61@changeid>
 <ZPSsBhbekKY7VyDg@shell.armlinux.org.uk> <CAD=FV=WT4Hf1XVA641WtNFg4WRYFKarU1WOkLPEbr0eiVQuZPg@mail.gmail.com>
 <CAD=FV=UpJEFKcsnHSzPqEiGaWusp50DrcEh=mcra4eLeRQT5NQ@mail.gmail.com>
In-Reply-To: <CAD=FV=UpJEFKcsnHSzPqEiGaWusp50DrcEh=mcra4eLeRQT5NQ@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 20 Sep 2023 11:03:32 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WSdp=5DnJinELOSncX=eqrN9y27kw=VFDHowzgnTS6Qg@mail.gmail.com>
Message-ID: <CAD=FV=WSdp=5DnJinELOSncX=eqrN9y27kw=VFDHowzgnTS6Qg@mail.gmail.com>
Subject: Re: [RFT PATCH 01/15] drm/armada: Call drm_atomic_helper_shutdown()
 at shutdown time
To:     Maxime Ripard <mripard@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, airlied@gmail.com,
        daniel@ffwll.ch, linux-kernel@vger.kernel.org,
        "Russell King (Oracle)" <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime,

On Wed, Sep 13, 2023 at 8:34=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Tue, Sep 5, 2023 at 7:23=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
> >
> > Hi,
> >
> > On Sun, Sep 3, 2023 at 8:53=E2=80=AFAM Russell King (Oracle)
> > <linux@armlinux.org.uk> wrote:
> > >
> > > On Fri, Sep 01, 2023 at 04:41:12PM -0700, Douglas Anderson wrote:
> > > > Based on grepping through the source code this driver appears to be
> > > > missing a call to drm_atomic_helper_shutdown() at system shutdown
> > > > time. Among other things, this means that if a panel is in use that=
 it
> > > > won't be cleanly powered off at system shutdown time.
> > > >
> > > > The fact that we should call drm_atomic_helper_shutdown() in the ca=
se
> > > > of OS shutdown/restart comes straight out of the kernel doc "driver
> > > > instance overview" in drm_drv.c.
> > > >
> > > > This driver was fairly easy to update. The drm_device is stored in =
the
> > > > drvdata so we just have to make sure the drvdata is NULL whenever t=
he
> > > > device is not bound.
> > >
> > > ... and there I think you have a misunderstanding of the driver model=
.
> > > Please have a look at device_unbind_cleanup() which will be called if
> > > probe fails, or when the device is removed (in other words, when it i=
s
> > > not bound to a driver.)
> >
> > ...and there I think you didn't read this patch closely enough and
> > perhaps that you have a misunderstanding of the component model.
> > Please have a look at the difference between armada_drm_unbind() and
> > armada_drm_remove() and also check which of those two functions is
> > being modified by my patch. Were this patch adding a call to
> > "dev_set_drvdata(dev, NULL)" in armada_drm_remove() then your NAK
> > would be justified. However, I am not aware of anything in the
> > component unbind path nor in the failure case of component bind that
> > would NULL the drvdata.
> >
> > Kindly look at the patch a second time with this in mind.
>
> Since I didn't see any further response, I'll assume that my
> explanation here has addressed your concerns. If not, I can re-post it
> without NULLing the "drvdata". While I still believe this is unsafe in
> some corner cases because of the component model used by this driver,
> at least it would get the shutdown call in.
>
> In any case, what's the process for landing patches to this driver?
> Running `./scripts/get_maintainer.pl --scm -f
> drivers/gpu/drm/armada/armada_drv.c` seems to indicate that this
> should go through the git tree:
>
> git git://git.armlinux.org.uk/~rmk/linux-arm.git drm-armada-devel
>
> ...but it doesn't appear that recent changes to this driver have gone
> that way. Should this land through drm-misc?

Do you have any advice here? Should I land this through drm-misc-next,
put it on ice for a while, or resend without the calls to NULL our the
drvdata?

Thanks!

-Doug
