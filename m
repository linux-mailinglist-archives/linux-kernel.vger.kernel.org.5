Return-Path: <linux-kernel+bounces-89808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA2D86F5F2
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 16:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 879F21F22D38
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 15:44:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8D467C5C;
	Sun,  3 Mar 2024 15:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0qOn8Wt"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F51BE66;
	Sun,  3 Mar 2024 15:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709480656; cv=none; b=DFZs4aXyZyD+MqXjKb3eGcus2CWei8/fznJWShqHLtfZHmklq3vmtpUtCjchvIDpyAUjaSv8kvLTCM1uRQ8LjholQOm7eR7P7OLKgUQcJ/OluPW8VLmtAvfc/MI4CxU9kzDIqq7bUBhmgHjR0rmZ+iNo0XG7t/CFtGdgnNVILZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709480656; c=relaxed/simple;
	bh=Pq1xs9swixQ3S4BcqZ6BTxVKKAgiy8m15Wu0wILEoqo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nYQk+UuMEarAE/W9wJw0HI3wEglAsIe7C+eMTtBA4lABeNGwRhJ+Za29i+TrbhTbACgKWFDa3VIyef8F6hxVlg35obHydwBJYvdjCnEpflJZVrxqPIjmDJgkOjlUtdHrHHfDFB3XaUPof/KwIM/bciyROU4yFBweBMQ9S6i7dxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g0qOn8Wt; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dcce5e84bcso29488525ad.1;
        Sun, 03 Mar 2024 07:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709480654; x=1710085454; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eS5rXsUD0/yP0O/b336cGPihzWh42DmpRxXHDyRlWmk=;
        b=g0qOn8WtUI6GN/E8Z2atSLut+4+UXZ31x+4bF5vlyXZihF9Usk3W3jrXK3LsLinLym
         u50N9vA8gJIMw/0cVr2R60S/iA4Q8zNtA21TT4c0yzHdsS6SdOBviRbQjC2z88IYC3cG
         1TbtmYkxaKIfvhsoOP5RlQQXjeNfhLkbi3VEWrGJv7I2Wvqi12O2tM/ajOt4tHD32I2G
         BnLocGnRxOpQcW6I4kCnFpiEfj3tkOmGpAtKsCUwfrZSzrKFr9tC98dxiqLxYsSJuXsD
         1xG2Ytg2Qo2vrzKuVput7PGTJorrYXAmuNVQYrY0WyuCodhrjTyivx2mwbZQlFNOl/f7
         +Plg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709480654; x=1710085454;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eS5rXsUD0/yP0O/b336cGPihzWh42DmpRxXHDyRlWmk=;
        b=q57Vir7oUuOYfPDH1QPFjukWKwT4IiUSlmouL1ucsuEWY6dsm+/Dc6AtJIe48JmMa7
         gg0hbTYk89Gp/FH+42u/KEOBE3Vgxl71ynspQuL68HeFupR/hvzpCuLbbJY/j2plOUS2
         KNR2Sd0HrNQRwYz+McoFqlF9VJ8Ln7HCuClOzP+LIYhQ8HisEOuPaqEmOat0dP7oPL2D
         pZIrgNYjKzMKsRKXWOKshRCLg87hEBhXPUpfldxAyTrGSaeV8g6dnFY85rhhGAGYIcCh
         YRDdKQtCu37OC9yywxIaIEI5dfm4PE/egu2AK9tWKtetxYlQ63LVlY6PikbLyhg3qaeG
         ju/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVjlNTXtYTlc8JISUTArqdURiWjd7fA4uvZoPf1qhWik7VTcOAYIAU856TZn9KtEOwlpc7XmJV2xG44qyJuaVe2SSKcHetr69gppl3OmbAXO/D5jttUYZIqh8Je+oF21HCoQ9WnRLjwYw==
X-Gm-Message-State: AOJu0YxxaOrptAPJmaTBApZ5bqkcIVteo9OxWhuygNl4zpcoYF8UZzTQ
	0kQjwNP4PfyzP/1N876UX/0NOhF+C1cb7ay0yMPysxne1hS7PdZ+IJwImg5t9QIiEc3PeP2QwpF
	RuDKz3i8/G8jz5wXMLtCBSVS3Zn0=
X-Google-Smtp-Source: AGHT+IGS6ew4nXt5BAU7Sc1tW8kxz61GMLFbWf8a7QA3VlraCLCBHo9R/O9Y4HzIfJGI2oHtZRtm2+wi4R98LC4v56A=
X-Received: by 2002:a17:902:db0e:b0:1dc:524:6da4 with SMTP id
 m14-20020a170902db0e00b001dc05246da4mr6348460plx.8.1709480654469; Sun, 03 Mar
 2024 07:44:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228113737.43434-1-aford173@gmail.com> <20240228163153.GH9863@pendragon.ideasonboard.com>
In-Reply-To: <20240228163153.GH9863@pendragon.ideasonboard.com>
From: Adam Ford <aford173@gmail.com>
Date: Sun, 3 Mar 2024 09:44:03 -0600
Message-ID: <CAHCN7xLGL5gMhd7Fo907gPScdD15KW==BHSorQMjbd-=k-E9OA@mail.gmail.com>
Subject: Re: [PATCH 1/2] drm/bridge: adv7511: Allow IRQ to share GPIO pins
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
	aford@beaconembedded.com, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Pengutronix Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Robert Foss <rfoss@kernel.org>, Jonas Karlman <jonas@kwiboo.se>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 10:31=E2=80=AFAM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Adam,
>
> Thank you for the patch.
>
> On Wed, Feb 28, 2024 at 05:37:35AM -0600, Adam Ford wrote:
> > The IRQ registration currently assumes that the GPIO is
> > dedicated to it, but that may not necessarily be the case.
> > If the board has another device sharing the IRQ, it won't be
> > registered and the hot-plug detect fails.  This is easily
> > fixed by add the IRQF_SHARED flag.
> >
> > Signed-off-by: Adam Ford <aford173@gmail.com>
> >
> > diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu=
/drm/bridge/adv7511/adv7511_drv.c
> > index b5518ff97165..21f08b2ae265 100644
> > --- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > +++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
> > @@ -1318,7 +1318,8 @@ static int adv7511_probe(struct i2c_client *i2c)
> >
> >               ret =3D devm_request_threaded_irq(dev, i2c->irq, NULL,
> >                                               adv7511_irq_handler,
> > -                                             IRQF_ONESHOT, dev_name(de=
v),
> > +                                             IRQF_ONESHOT | IRQF_SHARE=
D,
> > +                                             dev_name(dev),
>
> This looks fine, but the IRQ handler doesn't.

Thanks for the review.

>
> static int adv7511_irq_process(struct adv7511 *adv7511, bool process_hpd)
> {
>         unsigned int irq0, irq1;
>         int ret;
>
>         ret =3D regmap_read(adv7511->regmap, ADV7511_REG_INT(0), &irq0);
>         if (ret < 0)
>                 return ret;
>
>         ret =3D regmap_read(adv7511->regmap, ADV7511_REG_INT(1), &irq1);
>         if (ret < 0)
>                 return ret;

If I did a check here and returned if there was no IRQ to handle,
would that be sufficient?

--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -477,6 +477,11 @@ static int adv7511_irq_process(struct adv7511
*adv7511, bool process_hpd)
        if (ret < 0)
                return ret;

+       /* If there is no IRQ to handle, exit indicating no IRQ handled */
+       if (!(irq0 & (ADV7511_INT0_HPD | ADV7511_INT0_EDID_READY)) &&
+          !(irq1 & ADV7511_INT1_DDC_ERROR))
+               return -1;
+
        regmap_write(adv7511->regmap, ADV7511_REG_INT(0), irq0);
        regmap_write(adv7511->regmap, ADV7511_REG_INT(1), irq1);

With this, I would expect adv7511_irq_handler to return IRQ_NONE.  If
you're OK with that approach, I can do that.  If you want me to merge
adv7511_irq_handler, and adv7511_irq_process, I can do that too to
make the return codes a little more intuitive.

adam

>
>         regmap_write(adv7511->regmap, ADV7511_REG_INT(0), irq0);
>         regmap_write(adv7511->regmap, ADV7511_REG_INT(1), irq1);
>
>         if (process_hpd && irq0 & ADV7511_INT0_HPD && adv7511->bridge.enc=
oder)
>                 schedule_work(&adv7511->hpd_work);
>
>         if (irq0 & ADV7511_INT0_EDID_READY || irq1 & ADV7511_INT1_DDC_ERR=
OR) {
>                 adv7511->edid_read =3D true;
>
>                 if (adv7511->i2c_main->irq)
>                         wake_up_all(&adv7511->wq);
>         }
>
> #ifdef CONFIG_DRM_I2C_ADV7511_CEC
>         adv7511_cec_irq_process(adv7511, irq1);
> #endif
>
>         return 0;
> }
>
> static irqreturn_t adv7511_irq_handler(int irq, void *devid)
> {
>         struct adv7511 *adv7511 =3D devid;
>         int ret;
>
>         ret =3D adv7511_irq_process(adv7511, true);
>         return ret < 0 ? IRQ_NONE : IRQ_HANDLED;
> }
>
> The function will return IRQ_HANDLED as long as the registers can be
> read, even if they don't report any interrupt.
>
> >                                               adv7511);
> >               if (ret)
> >                       goto err_unregister_audio;
>
> --
> Regards,
>
> Laurent Pinchart

