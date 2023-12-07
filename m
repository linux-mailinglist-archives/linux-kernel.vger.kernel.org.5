Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1B380871D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:56:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379105AbjLGLzQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:55:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjLGLzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:55:14 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B781AD
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 03:55:18 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5d7b1a8ec90so5380707b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 03:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701950118; x=1702554918; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=F/q6TRKeG5wf/WNF8oKO4x0xnN5GpvnAL5Al210CdFM=;
        b=GRX4SxXQkB+6+W9DXR4iUGyfV/07y4Rqu94u7S/y9+xVP/d11HZZ8yb6k1p3TRI2wA
         Py0jnAhlYMwwX3pw5hZDU03SrU/lwU/CxFHaLmjsfD6EW96vz2gYu4i+wMCLTGSJ3DQ/
         4rrXAyHG4S82K4F+TJLD10ECSCenq+KBLCbgXIG/5oMJQ2OjfLpuP6TybyibO75NLWiG
         rUTXj898OF0polYr5qnHeh0Zh5Xx0OLCHpc01nkVT7lOeGlqCYzrNwJCKhvG/cwuyvE6
         3tzemw/Y5HjDkWyOFasVQalU2Uy0a3If3M0Z85wI+DwBXlDO/mZg1Z8NEgLjzutG/HG7
         QUOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701950118; x=1702554918;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F/q6TRKeG5wf/WNF8oKO4x0xnN5GpvnAL5Al210CdFM=;
        b=mpXj2yoEV8PxaE+TREe1BphN+rdUKU2FGjffAR2OKZGCSMGbpL6TcO1AEqKKPBPt3C
         beU3YAaZlGEpCMdgpPIId/xFnX70pN6i6dv2569LnEk7B437XEy+As+9bwh12fCeJWBT
         sUCodPe5DMOtrg3uPv3gAFJ9X35phWmGBbNShz45alf+BdQgYaus7ru+sGBga9AbXrUn
         VMp6cJ9a978bPitlsAQ+1Mhz4G09L3ooQsQFcr8pZ92EmJ5oXLTlhH48LRV8U3ld8uHJ
         vkL3EVUG0GiaDyeJ1V/BqcEohIF0/JRQ5TfvFlQ6XehHh/ixbxNkl4Zu4vNqolSYkufV
         n7aw==
X-Gm-Message-State: AOJu0YxAlKucV/oTcEky+22be/oEuSAxUHkdamxFKX8wjhOBVP2ezkrm
        4U+2UohXeTLh1yw1bsrL+n0p9lB2EDX388zv0rLFJA==
X-Google-Smtp-Source: AGHT+IHVT1d6I3NT15slfWj2OyLzxCga6bksIcWJ0Ex4SeTvFw8STagdoTadd/IyScYtLxzKq6+8sFaTXZxksDGB968=
X-Received: by 2002:a05:690c:360a:b0:5cc:29fc:9b38 with SMTP id
 ft10-20020a05690c360a00b005cc29fc9b38mr2021839ywb.35.1701950117961; Thu, 07
 Dec 2023 03:55:17 -0800 (PST)
MIME-Version: 1.0
References: <20231206123828.587065-1-arnd@kernel.org> <ZXGySCtdsxW4qCel@kuha.fi.intel.com>
In-Reply-To: <ZXGySCtdsxW4qCel@kuha.fi.intel.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Thu, 7 Dec 2023 13:55:06 +0200
Message-ID: <CAA8EJprV3O24V0+MnPK1OdQZQ_7F2aMfN1Um13eH9ux4J+ucMw@mail.gmail.com>
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2023 at 13:53, Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Wed, Dec 06, 2023 at 01:38:14PM +0100, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >
> > DRM_AUX_BRIDGE depends on CONFIG_OF, so the same dependency is needed
> > here to avoid a build failure:
> >
> > WARNING: unmet direct dependencies detected for DRM_AUX_BRIDGE
> >   Depends on [n]: HAS_IOMEM [=y] && DRM_BRIDGE [=y] && OF [=n]
> >   Selected by [y]:
> >   - TYPEC_MUX_NB7VPQ904M [=y] && USB_SUPPORT [=y] && TYPEC [=y] && I2C [=y] && (DRM [=y] || DRM [=y]=n) && DRM_BRIDGE [=y]
> > x86_64-linux-ld: drivers/gpu/drm/bridge/aux-bridge.o: in function `drm_aux_bridge_register':
> > aux-bridge.c:(.text+0x13b): undefined reference to `auxiliary_device_init'
> > x86_64-linux-ld: aux-bridge.c:(.text+0x14d): undefined reference to `__auxiliary_device_add'
> > x86_64-linux-ld: drivers/gpu/drm/bridge/aux-bridge.o: in function `drm_aux_bridge_drv_init':
> > aux-bridge.c:(.init.text+0x15): undefined reference to `__auxiliary_driver_register'
> > x86_64-linux-ld: drivers/gpu/drm/bridge/aux-bridge.o: in function `drm_aux_bridge_drv_exit':
> > aux-bridge.c:(.exit.text+0x9): undefined reference to `auxiliary_driver_unregister'
> >
> > Fixes: c5d296bad640 ("usb: typec: nb7vpq904m: switch to DRM_AUX_BRIDGE")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  drivers/usb/typec/mux/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
> > index 5120942f309d..818624f59120 100644
> > --- a/drivers/usb/typec/mux/Kconfig
> > +++ b/drivers/usb/typec/mux/Kconfig
> > @@ -40,6 +40,7 @@ config TYPEC_MUX_NB7VPQ904M
> >       tristate "On Semiconductor NB7VPQ904M Type-C redriver driver"
> >       depends on I2C
> >       depends on DRM || DRM=n
> > +     depends on OF
> >       select DRM_AUX_BRIDGE if DRM_BRIDGE
> >       select REGMAP_I2C
> >       help
>
> Shouldn't DRM_BRIDGE depend on OF instead?

No. DRM_AUX_BRIDGE depends on OF, DRM_BRIDGE framework doesn't.


-- 
With best wishes
Dmitry
