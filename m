Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F42808734
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 13:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379142AbjLGL6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:58:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232186AbjLGL6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:58:38 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7A510C6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 03:58:43 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5d3c7ef7b31so6143957b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 03:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701950322; x=1702555122; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5XmsrJXJOel1pOwV1DpetQX2xR+tuD3kF6lMHYEW14c=;
        b=dphjGpT8B0pJZWQ9GX011Eyo/IlJzEf52wVaxN7gZ7iRvfXkfeioR+NlJaawaJqW5J
         gqlf9g/NEaGhT6QEGIq4KH0EdMtgjw7y4+oiFgIN+TzeiTuXg0XV7juaH+8h6oOeTjAg
         +wOtH1WxUOyl4iQltWhIzWwkpmx8ytHaw/Tv14iF+ltiEo2DI9A5Jm/OoL+SejzV9i/Y
         suPfWZIEheLesCZQ0WThFOAmEEwUGganzwXkLxUCwWDXn8edqWSoA7FMJinVooorglBS
         WxGtTDdDAoX3pqsPR8PKY/OnpfWpjHCjdoSxNMkulkHDHzOurYmbs3ALro2CrcoRcBDi
         1h7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701950322; x=1702555122;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5XmsrJXJOel1pOwV1DpetQX2xR+tuD3kF6lMHYEW14c=;
        b=TWIzJXKxQi2UxMzUUg8GxG2RZEgBSMrV6XJ7FaBwkfo2aRzSdw00o+JN74Rj9kNCLS
         +S8bLJ8tE/3fqOIcF5ETLH3GDMGiqr2R+hm58n+U/Oe2lACk31a8UihgiCBPzTfR9qw7
         rfLsnBNwJIeVEGS29VlXjmSMUijXqwC25nprK6i8dFRj8LVn0tNzgplCChIgPnT+tlug
         8ABPQmLcB+KV3qwgBZHRg3FRRFmaZGZY3sOjKnYK5eUkdkvbC9NNWk2up4S7syolEKhd
         CKjBoj68ChecyzD1H1egs7E0h3YTv2edaAvY8mHHRDhJaK4QxHbrpCaAv+yuRgKaCrE9
         5BEA==
X-Gm-Message-State: AOJu0YzW+i3UexqIL9k1y25yvGYbSbUUFhmpgaG2v6gD5uKo7ig5bXSd
        MKPMTduXDuOCv95TzeZOMkD2miLozMK9eMfkhFcgfA==
X-Google-Smtp-Source: AGHT+IFukjk7+VvB4cAweU10tWIgWIRNcRODLwuYaC54AWvlj03fe3JTz7XnPc9w7cjNwkd5PEZbF2PppX325vcHp0I=
X-Received: by 2002:a81:b702:0:b0:5d7:1941:3562 with SMTP id
 v2-20020a81b702000000b005d719413562mr2376001ywh.73.1701950322250; Thu, 07 Dec
 2023 03:58:42 -0800 (PST)
MIME-Version: 1.0
References: <20231206123828.587065-1-arnd@kernel.org> <ZXGySCtdsxW4qCel@kuha.fi.intel.com>
 <CAA8EJprV3O24V0+MnPK1OdQZQ_7F2aMfN1Um13eH9ux4J+ucMw@mail.gmail.com> <ZXGzJlv9C3Z9lMeI@kuha.fi.intel.com>
In-Reply-To: <ZXGzJlv9C3Z9lMeI@kuha.fi.intel.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 7 Dec 2023 13:58:31 +0200
Message-ID: <CAA8EJpphJwfL-ZBOirzezBkBQ4E0RhhugtJh_jM0aHsHgp0D8g@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: nb7vpq904m: add CONFIG_OF dependency
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2023 at 13:57, Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Thu, Dec 07, 2023 at 01:55:06PM +0200, Dmitry Baryshkov wrote:
> > On Thu, 7 Dec 2023 at 13:53, Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > >
> > > On Wed, Dec 06, 2023 at 01:38:14PM +0100, Arnd Bergmann wrote:
> > > > From: Arnd Bergmann <arnd@arndb.de>
> > > >
> > > > DRM_AUX_BRIDGE depends on CONFIG_OF, so the same dependency is needed
> > > > here to avoid a build failure:
> > > >
> > > > WARNING: unmet direct dependencies detected for DRM_AUX_BRIDGE
> > > >   Depends on [n]: HAS_IOMEM [=y] && DRM_BRIDGE [=y] && OF [=n]
> > > >   Selected by [y]:
> > > >   - TYPEC_MUX_NB7VPQ904M [=y] && USB_SUPPORT [=y] && TYPEC [=y] && I2C [=y] && (DRM [=y] || DRM [=y]=n) && DRM_BRIDGE [=y]
> > > > x86_64-linux-ld: drivers/gpu/drm/bridge/aux-bridge.o: in function `drm_aux_bridge_register':
> > > > aux-bridge.c:(.text+0x13b): undefined reference to `auxiliary_device_init'
> > > > x86_64-linux-ld: aux-bridge.c:(.text+0x14d): undefined reference to `__auxiliary_device_add'
> > > > x86_64-linux-ld: drivers/gpu/drm/bridge/aux-bridge.o: in function `drm_aux_bridge_drv_init':
> > > > aux-bridge.c:(.init.text+0x15): undefined reference to `__auxiliary_driver_register'
> > > > x86_64-linux-ld: drivers/gpu/drm/bridge/aux-bridge.o: in function `drm_aux_bridge_drv_exit':
> > > > aux-bridge.c:(.exit.text+0x9): undefined reference to `auxiliary_driver_unregister'
> > > >
> > > > Fixes: c5d296bad640 ("usb: typec: nb7vpq904m: switch to DRM_AUX_BRIDGE")
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > > > ---
> > > >  drivers/usb/typec/mux/Kconfig | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
> > > > index 5120942f309d..818624f59120 100644
> > > > --- a/drivers/usb/typec/mux/Kconfig
> > > > +++ b/drivers/usb/typec/mux/Kconfig
> > > > @@ -40,6 +40,7 @@ config TYPEC_MUX_NB7VPQ904M
> > > >       tristate "On Semiconductor NB7VPQ904M Type-C redriver driver"
> > > >       depends on I2C
> > > >       depends on DRM || DRM=n
> > > > +     depends on OF
> > > >       select DRM_AUX_BRIDGE if DRM_BRIDGE
> > > >       select REGMAP_I2C
> > > >       help
> > >
> > > Shouldn't DRM_BRIDGE depend on OF instead?
> >
> > No. DRM_AUX_BRIDGE depends on OF, DRM_BRIDGE framework doesn't.
>
> Okay, so this probable should also be
>
>         select DRM_AUX_BRIDGE if DRM_BRIDGE and OF

Yes, this is what a patch from Nathan does:
https://patchwork.freedesktop.org/patch/570638/?series=127385&rev=1

-- 
With best wishes
Dmitry
