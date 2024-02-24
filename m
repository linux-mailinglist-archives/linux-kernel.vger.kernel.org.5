Return-Path: <linux-kernel+bounces-79558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9A186241E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9C01281FFE
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 10:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03843F8FF;
	Sat, 24 Feb 2024 10:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PltfZ/dg"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A693EA8A;
	Sat, 24 Feb 2024 10:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708769728; cv=none; b=SRlUS77PuYAmrWXIXYUMQuN4RJ0S5Om0GyYXirxO3+RE3XRbSpMPH/yclAN8qaLoB2abRdFnMRr46W7cpU6m7ykBRyL92OL6rKqXRNJsqgOjPti5NyWuq6P9HAO6A1TmNfsRr7JxsDEHBYoyZ3u25cMfYU4CeWDbzwozQQpF2k4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708769728; c=relaxed/simple;
	bh=Oq6f4EUAeMtUNAncKQaFBl9MwPBf6Bhnx70XCRpCmPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WDIo3OVAsN3EbYd1eedl/FKtJPovV34vgpVB9u5mXCHuj1WN6iY8nhYLGsx/Y+CWVW/SEHvxLzZGk/f4h38t9vKV1QXtIsAneoQrcFc0WA21+ofTiVrF13VsW1iDlwRveVY/rrnq9twEYTphZeCx9zVSYon+ORfWz9GuWkAdPos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PltfZ/dg; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3d484a58f6so230021466b.3;
        Sat, 24 Feb 2024 02:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708769724; x=1709374524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D2ZXF0iZo/6iAjeOarlGvbT9yJV0/dj7cjkGOEKn2Lw=;
        b=PltfZ/dglFuakAQBqGHgH6JCOcSfPcqRrymcTohSCBWlXjeFu9oLzQ05sFpaNa4+4x
         3OmVeFznd0iYT4IVqwjhLxsgOP7Vxu4XGn65QqbpcDoYXZ5AEQtDDuBbThiTWw6X6sMp
         4k1cJyhhoWMcuEb0RM0YY5bHcafrkwFg1OUFtsOeAw86YSMvhBBilIkklZlnN/bZWTTe
         YZ7Pvj6+eyxyJtpawbJp/8eJzP+rcmFc5OSa5hkKeU2dbHJ+jSJ/3jFTUbE0w/pZkV63
         pxfdLKBTTng2VFjeY1fwvkH9hBzhGHa2saTpXVhDSeVtfkuF5IdmhRu8UPycrdyV+gGB
         TVDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708769724; x=1709374524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D2ZXF0iZo/6iAjeOarlGvbT9yJV0/dj7cjkGOEKn2Lw=;
        b=mPFS07wDOUpamf4ez03D3bBrwdseDvtzruNVNdIi766UK9TSxIZ2VbnVntQswdKXt6
         HfoznjAJK8LVIzGXUcVGEyOecaHquvofMpWSCDgjPhhCfy7qGCOKzJSTcjULNcr7B/oi
         Lm68B1PlU7UwDRCiixHyiqaXNs+TZWEPa6OWVmIKI7NG7epnx6rxc87PGsvJq0FGJzK1
         AONZbjNxzm087MQsP6H5ucQ1nY1kY+9qLU0X17/kQI0T89Jgh71EGbKSd3dJ5pWt64DL
         gont+OQtfoNHvBm1PkojnR89px3p9o9v87YLO4Y5859BXKYWAVvOpayz+3z2Qjr8dcl/
         c9Sg==
X-Forwarded-Encrypted: i=1; AJvYcCWhb5eNTqtrhy5h+zd7DpIki59lbVW5N+cT1ty7XEV+Yb23o3GOaV4IgwtecHzrbiq8YyHfKrLWKj6+TzpoNfa4OUYVrL3w3uqEyz7KGeYRirF7+0GSzWlv5fi7xM3KyPyq+k6reHb7FQ==
X-Gm-Message-State: AOJu0YxexTZYHHr8CuosVdUb8lUBi45rtNk8V3KGMIlVJSWe3eJDpJt2
	sCuETY159K0oRPrsMLdZTAYcNJjbXS7uai/xUdcx9nXeiUM+doeL
X-Google-Smtp-Source: AGHT+IE2QVjQtd00qRPl37+Uigu3zm7B9dKnDCH1vosAVNiPcNTfRePbtu0xj8Dchv/cJ4J9TyQPxA==
X-Received: by 2002:a17:906:2508:b0:a3e:4f8b:bcc5 with SMTP id i8-20020a170906250800b00a3e4f8bbcc5mr1366807ejb.34.1708769724211;
        Sat, 24 Feb 2024 02:15:24 -0800 (PST)
Received: from mehdi-archlinux ([45.156.240.98])
        by smtp.gmail.com with ESMTPSA id lv21-20020a170906bc9500b00a3fd98237aasm447906ejb.156.2024.02.24.02.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 02:15:23 -0800 (PST)
Date: Sat, 24 Feb 2024 11:15:19 +0100
From: Mehdi Djait <mehdi.djait.k@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Mehdi Djait <mehdi.djait@bootlin.com>, mripard@kernel.org,
	maarten.lankhorst@linux.intel.com, airlied@gmail.com,
	daniel@ffwll.ch, krzysztof.kozlowski+dt@linaro.org,
	robh+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	alexandre.belloni@bootlin.com, luca.ceresoli@bootlin.com,
	paul.kocialkowski@bootlin.com, dri-devel@lists.freedesktop.org,
	geert@linux-m68k.org
Subject: Re: [PATCH 2/2] drm/tiny: Add driver for the sharp LS027B7DH01
 Memory LCD
Message-ID: <ZdnBt1MvqBqu3j9z@mehdi-archlinux>
References: <cover.1701267411.git.mehdi.djait@bootlin.com>
 <71a9dbf4609dbba46026a31f60261830163a0b99.1701267411.git.mehdi.djait@bootlin.com>
 <078cdd6f-7b38-497d-8480-00569c63f843@suse.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <078cdd6f-7b38-497d-8480-00569c63f843@suse.de>

Hi Thomas, 

Thank you for the review.

On Wed, Nov 29, 2023 at 05:21:19PM +0100, Thomas Zimmermann wrote:
> Hi,
> 
> thanks for the patches.
> 
> Am 29.11.23 um 15:29 schrieb Mehdi Djait:
> > Introduce a DRM driver for the sharp LS027B7DH01 Memory LCD.
> > 
> > LS027B7DH01 is a 2.7" 400x240 monochrome display connected to a SPI bus.
> > The drivers implements the Multiple Lines Data Update Mode.
> > External COM inversion is enabled using a PWM signal as input.
> > 
> > Signed-off-by: Mehdi Djait <mehdi.djait@bootlin.com>
> > ---
> >   MAINTAINERS                              |   7 +
> >   drivers/gpu/drm/tiny/Kconfig             |   8 +
> >   drivers/gpu/drm/tiny/Makefile            |   1 +
> >   drivers/gpu/drm/tiny/sharp-ls027b7dh01.c | 411 +++++++++++++++++++++++
> >   4 files changed, 427 insertions(+)
> >   create mode 100644 drivers/gpu/drm/tiny/sharp-ls027b7dh01.c
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 012df8ccf34e..fb859698bd3d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6832,6 +6832,13 @@ S:	Maintained
> >   F:	Documentation/devicetree/bindings/display/panel/samsung,s6d7aa0.yaml
> >   F:	drivers/gpu/drm/panel/panel-samsung-s6d7aa0.c
> > +DRM DRIVER FOR SHARP LS027B7DH01 Memory LCD
> > +M:	Mehdi Djait <mehdi.djait@bootlin.com>
> > +S:	Maintained
> > +T:	git git://anongit.freedesktop.org/drm/drm-misc
> > +F:	Documentation/devicetree/bindings/display/sharp,ls027b7dh01.yaml
> > +F:	drivers/gpu/drm/tiny/sharp-ls027b7dh01.c
> > +
> >   DRM DRIVER FOR SITRONIX ST7586 PANELS
> >   M:	David Lechner <david@lechnology.com>
> >   S:	Maintained
> > diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
> > index f6889f649bc1..a2ade06403ca 100644
> > --- a/drivers/gpu/drm/tiny/Kconfig
> > +++ b/drivers/gpu/drm/tiny/Kconfig
> > @@ -186,6 +186,14 @@ config TINYDRM_REPAPER
> >   	  If M is selected the module will be called repaper.
> > +config TINYDRM_SHARP_LS027B7DH01
> > +	tristate "DRM support for SHARP LS027B7DH01 display"
> > +	depends on DRM && SPI
> > +	select DRM_KMS_HELPER
> > +	select DRM_GEM_DMA_HELPER
> > +	help
> > +	  DRM driver for the SHARP LS027B7DD01 LCD display.
> > +
> >   config TINYDRM_ST7586
> >   	tristate "DRM support for Sitronix ST7586 display panels"
> >   	depends on DRM && SPI
> > diff --git a/drivers/gpu/drm/tiny/Makefile b/drivers/gpu/drm/tiny/Makefile
> > index 76dde89a044b..b05df3afb231 100644
> > --- a/drivers/gpu/drm/tiny/Makefile
> > +++ b/drivers/gpu/drm/tiny/Makefile
> > @@ -14,5 +14,6 @@ obj-$(CONFIG_TINYDRM_ILI9341)		+= ili9341.o
> >   obj-$(CONFIG_TINYDRM_ILI9486)		+= ili9486.o
> >   obj-$(CONFIG_TINYDRM_MI0283QT)		+= mi0283qt.o
> >   obj-$(CONFIG_TINYDRM_REPAPER)		+= repaper.o
> > +obj-$(CONFIG_TINYDRM_SHARP_LS027B7DH01)	+= sharp-ls027b7dh01.o
> >   obj-$(CONFIG_TINYDRM_ST7586)		+= st7586.o
> >   obj-$(CONFIG_TINYDRM_ST7735R)		+= st7735r.o
> > diff --git a/drivers/gpu/drm/tiny/sharp-ls027b7dh01.c b/drivers/gpu/drm/tiny/sharp-ls027b7dh01.c
> > new file mode 100644
> > index 000000000000..2f58865a5c78
> > --- /dev/null
> > +++ b/drivers/gpu/drm/tiny/sharp-ls027b7dh01.c
> > @@ -0,0 +1,411 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Sharp LS027B7DH01 Memory Display Driver
> > + *
> > + * Copyright (C) 2023 Andrew D'Angelo
> > + * Copyright (C) 2023 Mehdi Djait <mehdi.djait@bootlin.com>
> > + *
> > + * The Sharp Memory LCD requires an alternating signal to prevent the buildup of
> > + * a DC bias that would result in a Display that no longer can be updated. Two
> > + * modes for the generation of this signal are supported:
> > + *
> > + * Software, EXTMODE = Low: toggling the BIT(1) of the Command and writing it at
> > + * least once a second to the display.
> > + *
> > + * Hardware, EXTMODE = High: the alternating signal should be supplied on the
> > + * EXTCOMIN pin.
> > + *
> > + * In this driver the Hardware mode is implemented with a PWM signal.
> > + */
> > +
> > +#include <linux/delay.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/pwm.h>
> > +#include <linux/spi/spi.h>
> > +
> > +#include <drm/drm_atomic_helper.h>
> > +#include <drm/drm_damage_helper.h>
> > +#include <drm/drm_drv.h>
> > +#include <drm/drm_fbdev_generic.h>
> > +#include <drm/drm_fb_dma_helper.h>
> > +#include <drm/drm_format_helper.h>
> > +#include <drm/drm_framebuffer.h>
> > +#include <drm/drm_gem_atomic_helper.h>
> > +#include <drm/drm_gem_dma_helper.h>
> > +#include <drm/drm_gem_framebuffer_helper.h>
> > +#include <drm/drm_modes.h>
> > +#include <drm/drm_probe_helper.h>
> > +#include <drm/drm_simple_kms_helper.h>
> > +
> > +#define CMD_WRITE BIT(0)
> > +#define CMD_CLEAR BIT(2)
> > +
> > +struct sharp_ls027b7dh01 {
> > +	struct spi_device *spi;
> > +
> > +	struct drm_device drm;
> > +	struct drm_connector connector;
> > +	struct drm_simple_display_pipe pipe;
> 
> Could you please replace the simple pipe and its helpers with regular
> DRMhelpers. It should no tbe used in new drivers. It's an unnecessary
> indirection. Replacing is simple: copy the content of the data structure and
> its helpers into the driver. Maybe clean up the result, if necessary.


Could you please further explain where to copy the helper functions or give me
an example driver ? This is my first DRM driver and grepping did not help me much.

(Sorry for the delayed response)

--
Kind Regards
Mehdi Djait

