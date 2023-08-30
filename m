Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C2278E30E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 01:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239347AbjH3XKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 19:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbjH3XKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 19:10:41 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12EF8F
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 16:10:36 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50087d47d4dso585331e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 16:10:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693437034; x=1694041834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1He+K1JiC8cosFsoTmSeNWYx/xdJJEuHrtfUOyTaJ8=;
        b=GsZJ022/++aeTu29tRi4njodlOavULOgcxq1DQaN7dy0Y+XHiV4z7kXO0gWkv0fFu3
         dBzBDHXwi7Pp5H8LXEgTxVQvT+EKM1l8oCNIBTJxHqhxJMRRWdUpLAuRyK0+6+18DZB8
         U+MRvQf1ttTWv8fqRondyt0P0KGsH5RRtGOG8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693437034; x=1694041834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f1He+K1JiC8cosFsoTmSeNWYx/xdJJEuHrtfUOyTaJ8=;
        b=ctHQx5/RVeJ2p41o1x8Kbl9/amGqm+zFzlItu5b/mEk0Z/M9gP8wHGIWCjfktluraA
         wMV3v2kEYlLSHadMl4QbBxHeuYDRbUbVKbqVuNTaTMTcN31A1hxFsZDZnQbf7YCMrgds
         byKChEUjtkYh2At5KHLL2RkfyE+2IZ4ffg6FhbI2CuPzrKX0AGgdxjuRAtTvPIhlSTMt
         kqowY+Y661BXl3nBlNDfYgW4bM0DAeUxYM1i0SQgsWIjbVpLTGWgs9qCMvgIw509grxC
         NniEX4XOHYn9S9sHtdiMQ2m4NK/W/4SnVqtRylzb/MWNTgQvARE6v2UG0w8Z7T4e4lhn
         JWtA==
X-Gm-Message-State: AOJu0Yyf1WvUcjdO1QGObXVT/vn5dY3nWLaWf70gPYFSckPHnFZNsMNZ
        AfQVL6Ls9AJt/qievRKWNx7/vFZKUlHdjoJJlwopu94j
X-Google-Smtp-Source: AGHT+IHvMh9mhYkhXhh62sGsrVuz6ujwAC59M8yj6vHJUQ2tEyLYZeSwjXi03lSzl6rJ7GDdx4WAcw==
X-Received: by 2002:a05:6512:a83:b0:4fb:8bab:48b6 with SMTP id m3-20020a0565120a8300b004fb8bab48b6mr2810026lfu.52.1693437034282;
        Wed, 30 Aug 2023 16:10:34 -0700 (PDT)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id p27-20020a17090635db00b009a168ab6ee2sm70229ejb.164.2023.08.30.16.10.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 16:10:33 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4009fdc224dso18575e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 16:10:33 -0700 (PDT)
X-Received: by 2002:a05:600c:1d19:b0:401:a494:2bbb with SMTP id
 l25-20020a05600c1d1900b00401a4942bbbmr30179wms.5.1693437033358; Wed, 30 Aug
 2023 16:10:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230804210644.1862287-1-dianders@chromium.org>
 <20230804140605.RFC.4.I930069a32baab6faf46d6b234f89613b5cec0f14@changeid>
 <bphkopaq76imqzut7xrx7aprqybhx3veajdympqhig2wqlix6c@64ck23rc5cv7>
 <CAD=FV=XiVkoCsjin4R74nkcd8vzOq9uPq+o5cRjd=YOoPXuQkg@mail.gmail.com>
 <lhd6ai7d6swlxhisjhikytguor7pptrymo3bmfwej4k7zqrnv4@hp2gvhw7mh3m>
 <CAD=FV=XUhzguFCC=aKzHFMV0bBnZzkHXP_tx+P=PNkVr=8SnTA@mail.gmail.com> <mumiep5q7x7qj7k64h3cyodxrgk737iy5rum5keguquwymf2gy@3qruwfrqjgy7>
In-Reply-To: <mumiep5q7x7qj7k64h3cyodxrgk737iy5rum5keguquwymf2gy@3qruwfrqjgy7>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 30 Aug 2023 16:10:20 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VEene+nr1us87iA+bomxzQ039r-E+wqvizvFGbxXjDvA@mail.gmail.com>
Message-ID: <CAD=FV=VEene+nr1us87iA+bomxzQ039r-E+wqvizvFGbxXjDvA@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] drm/panel_helper: Introduce drm_panel_helper
To:     Maxime Ripard <mripard@kernel.org>
Cc:     dri-devel@lists.freedesktop.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Aug 29, 2023 at 1:38=E2=80=AFAM Maxime Ripard <mripard@kernel.org> =
wrote:
>
> On Mon, Aug 28, 2023 at 09:06:29AM -0700, Doug Anderson wrote:
> > > > Shutdown is called any time you reboot a device. That means that if=
 a
> > > > DRM driver is _not_ calling drm_atomic_helper_shutdown() on the
> > > > panel's behalf at shutdown time then the panel won't be powered off
> > > > properly. This feels to me like something that might actually matte=
r.
> > >
> > > It does matter. What I disagree on is that you suggest working around
> > > that brokenness in the core framework. What I'm saying is driver is
> > > broken, we should keep the core framework sane and fix it in the driv=
er.
> > >
> > > It should be fairly easy with a coccinelle script to figure out which
> > > panels are affected, and to add that call in remove.
> >
> > I think I'm confused here. I've already figured out which panels are
> > affected in my patch series, right? It's the set of panels that today
> > try to power the panel off in their shutdown call, right? ...but I
> > think we can't add the call you're suggesting,
> > drm_atomic_helper_shutdown(), to the _panel_'s shutdown callback, can
> > we? We need to add it to the shutdown callback of the top-level DRM
> > driver, right?
>
> I have no idea what happens if we just unbind the panel device from its
> driver.
>
> If we can't, then it's all fine. If we can, then we need figure out how
> to unregister the DRM device (or block the unbinding from happening).

Nothing prevents unbinding the panel driver directly. I just confirmed
on my sc7180-lazor:

cd /sys/bus/dp-aux/drivers/panel-simple-dp-aux
echo aux-2-0008 > unbind

...no errors happened and the panel unbound. I think this is as
expected since I'm not aware of a way to prevent unbinding a driver. I
think the relevant function is unbind_store() in bus.c, right? There
is no failure code returned by device_driver_detach(). Presumably this
is by design?

FWIW, also trying to re-bind didn't work, also as expected (I think).
I think the whole bridge chain would need to be resolved again and
nothing I'm aware of makes that happen. Maybe I'm simply missing
something in my understanding, of course.

If you want to attempt to tackle some of these issues then I'd be more
than happy. I'm already waist deep in yak hair and I think this is too
big of a task for me to add on.

Should this issue block my work, then? Today, panels will at least
cleanly power themselves off if someone tries to unbind them like
that. If I remove the clean power off at driver unbind time and rely
on the DRM driver to power panels off cleanly then if someone directly
unbinds a panel like I've done above then it won't be power sequenced
properly, right?


> > > > Panels tend to be one of those things that really care about their
> > > > power sequencing and can even get damaged (or not turn on properly
> > > > next time) if sequencing is not done properly, so just removing thi=
s
> > > > code and putting the blame on the DRM driver seems scary to me.
> > >
> > > Sure, it's bad. But there's no difference compared to the approach yo=
u
> > > suggest in that patch: you created a helper, yes, but every driver wi=
ll
> > > still have to call that helper and if they don't, the panel will stil=
l
> > > be called and it's a bug. And we would have to convert everything to
> > > that new helper.
> > >
> > > It's fundamentally the same discussion than what you were opposed to
> > > above.
> >
> > I think the key difference here is that, if I understand correctly,
> > drm_atomic_helper_shutdown() needs to be added to the top-level DRM
> > driver, not to the panel itself. I guess I'm worried that I'll either
> > miss a case or that simply adding a call to
> > drm_atomic_helper_shutdown() in the top-level DRM driver will break
> > something. Well, I suppose I can try it and see what happens...
>
> The more I think about this discussion, the more I think that the
> original intent of the prepared/enabled flags were precisely there to
> prevent a double-disable for drivers with drm_atomic_helper_shutdown(),
> while still shutting down the panel resources when the panel is used
> with a driver that doesn't call it.

Sure, that makes sense.


> Honestly, I think the right thing to do here is to make every driver
> call shutdown, and then you don't need the reference counting anymore.
>
> I had a shot at a (possibly very suboptimal) coccinelle script to look
> for drivers that are KMS drivers but don't call
> drm_atomic_helper_shutdown() at shutdown.
>
> https://paste.ack.tf/bb42e6@raw

Your paste seems to have expired. Maybe you used the default and had
it expire in 1 day? Maybe you could just paste the script in email so
it'll be archived for posterity on lore?


> The result is:
>
> $ make coccicheck COCCI=3D./test-drm-shutdown.cocci MODE=3Dreport
>
> ...
>
> ./drivers/gpu/drm/sti/sti_drv.c:262:30-49: ERROR: KMS driver sti_platform=
_driver is missing shutdown implementation
> ./drivers/gpu/drm/armada/armada_drv.c:245:30-56: ERROR: KMS driver armada=
_drm_platform_driver is missing shutdown implementation
> ./drivers/gpu/drm/vmwgfx/vmwgfx_drv.c:1637:25-39: ERROR: KMS driver vmw_p=
ci_driver is missing shutdown implementation
> ./drivers/gpu/drm/vboxvideo/vbox_drv.c:163:25-40: ERROR: KMS driver vbox_=
pci_driver is missing shutdown implementation
> ./drivers/gpu/drm/tiny/arcpgu.c:424:30-52: ERROR: KMS driver arcpgu_platf=
orm_driver is missing shutdown implementation
> ./drivers/gpu/drm/omapdrm/omap_drv.c:856:30-34: ERROR: KMS driver pdev is=
 missing shutdown implementation
> ./drivers/gpu/drm/fsl-dcu/fsl_dcu_drm_drv.c:361:30-57: ERROR: KMS driver =
fsl_dcu_drm_platform_driver is missing shutdown implementation
> ./drivers/gpu/drm/tve200/tve200_drv.c:261:30-43: ERROR: KMS driver tve200=
_driver is missing shutdown implementation
> ./drivers/gpu/drm/stm/drv.c:235:30-53: ERROR: KMS driver stm_drm_platform=
_driver is missing shutdown implementation
> ./drivers/gpu/drm/qxl/qxl_drv.c:267:25-39: ERROR: KMS driver qxl_pci_driv=
er is missing shutdown implementation
> ./drivers/gpu/drm/logicvc/logicvc_drm.c:494:30-57: ERROR: KMS driver logi=
cvc_drm_platform_driver is missing shutdown implementation
> ./drivers/gpu/drm/sun4i/sun4i_drv.c:439:30-55: ERROR: KMS driver sun4i_dr=
v_platform_driver is missing shutdown implementation
> ./drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.c:827:30-60: ERROR: KMS driv=
er atmel_hlcdc_dc_platform_driver is missing shutdown implementation
> ./drivers/gpu/drm/mcde/mcde_drv.c:471:30-41: ERROR: KMS driver mcde_drive=
r is missing shutdown implementation
> ./drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c:366:25-41: ERROR: KMS d=
river hibmc_pci_driver is missing shutdown implementation
> ./drivers/gpu/drm/aspeed/aspeed_gfx_drv.c:365:30-56: ERROR: KMS driver as=
peed_gfx_platform_driver is missing shutdown implementation
> ./drivers/gpu/drm/ingenic/ingenic-drm-drv.c:1607:30-48: ERROR: KMS driver=
 ingenic_drm_driver is missing shutdown implementation
> ./drivers/gpu/drm/arm/malidp_drv.c:982:30-52: ERROR: KMS driver malidp_pl=
atform_driver is missing shutdown implementation
> ./drivers/gpu/drm/arm/hdlcd_drv.c:400:30-51: ERROR: KMS driver hdlcd_plat=
form_driver is missing shutdown implementation
> ./drivers/gpu/drm/kmb/kmb_drv.c:622:30-49: ERROR: KMS driver kmb_platform=
_driver is missing shutdown implementation
> ./drivers/gpu/drm/exynos/exynos_drm_drv.c:356:30-56: ERROR: KMS driver ex=
ynos_drm_platform_driver is missing shutdown implementation
> ./drivers/gpu/drm/tiny/bochs.c:718:25-41: ERROR: KMS driver bochs_pci_dri=
ver is missing shutdown implementation
> ./drivers/gpu/drm/tiny/cirrus.c:746:25-42: ERROR: KMS driver cirrus_pci_d=
river is missing shutdown implementation
> ./drivers/gpu/drm/mediatek/mtk_drm_drv.c:954:30-53: ERROR: KMS driver mtk=
_drm_platform_driver is missing shutdown implementation
>
> It's a significant number of drivers, but it's not the end of the world,
> really.

My own analysis shows more than that, actually. I can't look at your
script since it's expired, but as one example your list seems to have
neither imx/ipuv3 nor imx/dcss. imx/ipuv3 seems to be missing
drm_atomic_helper_shutdown() at both unbind and system shutdown time.
imx/dcss seems to be missing drm_atomic_helper_shutdown() at system
shutdown time, though it does have it at driver remove time. Did I
mess up in identifying those two drivers as ones that need fixing?

I can't give you an exact list because I don't have a great search
that identifies the problem. I'm mostly looking for all instances of
drm_dev_register() where the driver is "DRIVER_MODESET" and then
manually checking their use of drm_atomic_helper_shutdown(). Until I
get through them all I won't know the count, and it's a manual
process.


-Doug
