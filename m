Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C6679AD83
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379090AbjIKWla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242710AbjIKQLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:11:10 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7208E1B8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:11:05 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-501be2d45e0so7779865e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694448662; x=1695053462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+QeZPdiVCIBARaAlW5frnuN99j3rzp4a9OMhyKJX2M8=;
        b=lLQZ0I63WuBe4AasGpOPDr2nXXBQeM8jXgrfxEH2M7ajrqYBUzCOpkzOR081WvJqDe
         3UKXAyK18Tsn98syEDTkLBUxUVgcJMPezus7jmQLk0Cwd93X1Gr/mjCxbej4d7R+kjQT
         5opnZf6BrdOLDsDXo9Yppfzyp8lxZpCRcwo5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694448662; x=1695053462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+QeZPdiVCIBARaAlW5frnuN99j3rzp4a9OMhyKJX2M8=;
        b=E6eXoQ6YQ4voGOCfA5BUjrSjqBF8ctfCu9XDU7e5SKtNwYYpSgr6vW/KCUtIgIPE7C
         q4fIb4olRSa3EKF9LY3YnLhkKx89KFqMH7XUyZEH6IZlMHjBlMQpOzzy7zrHIh/d54ZG
         ca30zc/CCvqsGYQ5oGZbeztUZLrDm4XMhpS86ljToaBkMIm8JuelgVR4g/K0F+0NDHlV
         Oj5VsOiOh72qVwNyhieXq29qNkjsHEFEdKwWvk1t+dMyGFZ4jPLDQNETBNHn8e2pOo9K
         E2Dc14WMpiDTYYuSyj6FTu6G6GcVNYKMhmyUh501d7C0CA3bvpbUxVrfUDc7mSby/i4T
         zOcw==
X-Gm-Message-State: AOJu0Yzqsbw5eMA2QMa6+KoRtwAI48LvKoJS3kEM3u2lxf13rxFxiY1z
        HchpuxB7r3JPZX062op0PhabU9AInCWD61HH0SjC+g==
X-Google-Smtp-Source: AGHT+IHCfG7+ZQQVyGknh6ihvpW/m36tavfyZNiaqMyN636KQhdvOKK0YsrXIeuIr3nIDfsMOWh+JQ==
X-Received: by 2002:a19:4f10:0:b0:501:c49b:7673 with SMTP id d16-20020a194f10000000b00501c49b7673mr6175619lfb.28.1694448661864;
        Mon, 11 Sep 2023 09:11:01 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id qp2-20020a170907206200b0098748422178sm5560483ejb.56.2023.09.11.09.11.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 09:11:00 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-52f1f1f5125so18157a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:11:00 -0700 (PDT)
X-Received: by 2002:a50:9faa:0:b0:525:573c:6444 with SMTP id
 c39-20020a509faa000000b00525573c6444mr340372edf.1.1694448660156; Mon, 11 Sep
 2023 09:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230901234202.566951-1-dianders@chromium.org>
 <20230901164111.RFT.5.I2b014f90afc4729b6ecc7b5ddd1f6dedcea4625b@changeid> <CAC=S1niYAC3PFQoAmwVc=1FcK29uu5sC9c1pGo-mku__y7eHcA@mail.gmail.com>
In-Reply-To: <CAC=S1niYAC3PFQoAmwVc=1FcK29uu5sC9c1pGo-mku__y7eHcA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Sep 2023 09:10:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VT8ZQkcLn4nsxCygC5SG16qYW5igFfwM762jEK42p12g@mail.gmail.com>
Message-ID: <CAD=FV=VT8ZQkcLn4nsxCygC5SG16qYW5igFfwM762jEK42p12g@mail.gmail.com>
Subject: Re: [RFT PATCH 05/15] drm/mediatek: Call drm_atomic_helper_shutdown()
 at shutdown time
To:     Fei Shao <fshao@chromium.org>
Cc:     dri-devel@lists.freedesktop.org,
        Maxime Ripard <mripard@kernel.org>, airlied@gmail.com,
        angelogioacchino.delregno@collabora.com, chunkuang.hu@kernel.org,
        daniel@ffwll.ch, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de
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

Hi,

On Fri, Sep 8, 2023 at 4:51=E2=80=AFAM Fei Shao <fshao@chromium.org> wrote:
>
> Hi,
>
> On Sat, Sep 2, 2023 at 7:42=E2=80=AFAM Douglas Anderson <dianders@chromiu=
m.org> wrote:
> ...<snip>
> > @@ -952,6 +960,7 @@ static const struct dev_pm_ops mtk_drm_pm_ops =3D {
> >  static struct platform_driver mtk_drm_platform_driver =3D {
> >         .probe  =3D mtk_drm_probe,
> >         .remove =3D mtk_drm_remove,
>
> I think this patch, and perhaps some others in this series, will have
> a trivial conflict to Uwe's work about the remove callback conversion
> e.g. [1], so you might want to rebase the series onto the latest
> linux-next.
>
> On the other hand, I tested this patch on MT8195 and MT8188
> Chromebooks and I don't see issues during boot / reboot, so
>
> Reviewed-by: Fei Shao <fshao@chromium.org>
> Tested-by: Fei Shao <fshao@chromium.org>
>
> [1]: https://git.kernel.org/pub/scm/linux/kernel/git/chunkuang.hu/linux.g=
it/commit/?h=3Dmediatek-drm-next&id=3Db3af12a0b46888340e024ba8b231605bcf2d0=
ab3

That makes sense. I had based this series on drm-misc-next which
didn't have those, but now that a new -rc1 is out it then
drm-misc-next should rebase shortly. I'll make sure that the next
version includes Uwe's changes as much as possible.

That being said, I also wouldn't object if the maintainer of this DRM
driver wanted to resolve conflicts themselves and land the patch
without me needing to resend. The conflict is trivial, there are no
dependencies and no reason to land the series all at once, so landing
this patch early would mean less spam for the maintainer since they
would no longer get CCed on future versions. :-P Just sayin...

-Doug
