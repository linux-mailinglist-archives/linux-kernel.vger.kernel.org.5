Return-Path: <linux-kernel+bounces-135196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A7689BC91
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3B29282801
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 10:03:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41EAF52F6C;
	Mon,  8 Apr 2024 10:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DncMdB06"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B836E524D1;
	Mon,  8 Apr 2024 10:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712570574; cv=none; b=TlthsIaiT4KI98F9Hy/2HTzld8KGJn20F5YrzPB//lDDIYKzZGW8p1IsvXSvQJ2tXtUkU1PUhzt/+V/f28tOBxsuWqH/2Tb5oHNojdgnODU93dYKxoN4fK2ogsFWGN7qapRtHuCO+V59YRWBE9SMQFlVI/Nl93olqHiCFkSE3Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712570574; c=relaxed/simple;
	bh=mHSJTdWWpkZznfmNp0qpEczk7Q2SkTM7g44B+5tr5Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=I/kb5iKsqAr+blzf0MWWZ/VPKPLS9/Oml+mHF88QDilh+Kh8ZMi2JWPy5kxE8H9c2vhi/JKcsHAiTEF7n3DH/CNgM4ZBzPyy9yIGQGhIDJY/DmwbzZspp+IGbtNJmxJ8jKcQIcjilCYt9AcQxpGAzVnEdrCRYmfMRmddBxXhsNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DncMdB06; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-516dc51bb72so2015224e87.1;
        Mon, 08 Apr 2024 03:02:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712570571; x=1713175371; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H3Mgk1SHSvr40E6Qtsc7rIIsa/ZHP3312MjvkOOBUb8=;
        b=DncMdB06CkDfVXE6yU/irLXqLUyNN7W58+Dwaj+Dd6Kaur8FjJkROE/PTp6YVU4XhD
         AGYPnDVdqYRYlVXalr6c8Gq68t0zXpHYFADauaHfWwBvwfOiqzWiG1c76pwTsG77o5k1
         hB8hs4xw2dl3rHswGTy20UVUEWcDuJxGmHZQImqQMH7PrzuJwVF2siK0a6AVCrSLDOz5
         rIxEUSpkMoMnM8nmrui2/b6Pu/nLjCWOv0mg2N8ag0ThyXHdohR3mOuY1pEb4Gf9Lg5R
         zqTHgSDF1L2hEqrFrY+AbRza2OjnEmz7bIUqogfIAT50vkBNrUJKXqmD+MAOJ1+xOTYv
         Yz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712570571; x=1713175371;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H3Mgk1SHSvr40E6Qtsc7rIIsa/ZHP3312MjvkOOBUb8=;
        b=HRos9ZagO8iSbxHlZ4tKfAz6hOIcb8fh42F/zeO0To4oNWpYVcbamr8Vsg+UHoJm7M
         bcbwTevG2i4UFXCS/XnjeN2hJz7NdMh8EJzzHUlW0/AKpryqsQCi8ngBJNd+JJco5Toj
         S5TCfPVcW/3YTggMXN7dAMVM1blFbXrJDOuGKsYgntNfkSl2MMJFKDOV0ktWBQlaumOk
         ZuklLDgoNX7AfPSDZAj9rAIScXLTZKuRuPV2pAFFNEpcEasi2qkWGNBRas7OvpFlZvlC
         2xVLo/PIXa2B7y7X40iAQBhKehxmR5VETN4in/6LLptBdM+dXnPXYwVwdxlQo1tLWiaF
         pXvA==
X-Forwarded-Encrypted: i=1; AJvYcCWCQxCQgtc8V3WiZwl6YpIkTveqMYP2nnyMMpyC9BQuw2r4RBiVNLt+nMO7QP/hrUV1I0j3KHY6zOa1vIaSfrN2y9pifMHl9lPg0rChVqjHHqT0akxe0NMT5xzOYroXDTXsB5+OMKyJRITZYLE=
X-Gm-Message-State: AOJu0YyEC19TD0RYiY0YoxeQ0ed4k8UPY6WciHTtjJMjDIoH1pFLwKsA
	aDp0G/QUPKzgtE2Cf+kmufU+QrSpcp5nWTLJtFH+DGHKmUgYVDsBkvcRr/pS
X-Google-Smtp-Source: AGHT+IHf/czK86pLa7cNtNJW7Ej/QI/ef7t+ajoNgfIpR9eNuuHTcyZnC/R6qcsyiznYa660a1/K3g==
X-Received: by 2002:ac2:52a7:0:b0:516:d126:71a4 with SMTP id r7-20020ac252a7000000b00516d12671a4mr4820203lfm.5.1712570570559;
        Mon, 08 Apr 2024 03:02:50 -0700 (PDT)
Received: from fedora ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id b19-20020ac247f3000000b0051596653cb6sm1123150lfp.100.2024.04.08.03.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 03:02:50 -0700 (PDT)
Date: Mon, 8 Apr 2024 13:02:31 +0300
From: Matti Vaittinen <mazziesaccount@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee@kernel.org>,
	linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] watchdog: bd9576: Drop "always-running" property
Message-ID: <ZhPAt76yaJMersXf@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+62XoNjJEtN0LqUZ"
Content-Disposition: inline


--+62XoNjJEtN0LqUZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The always-running (from linux,wdt-gpio.yaml) is abused by the BD9576
watchdog driver. It's defined meaning is "the watchdog is always running
and can not be stopped". The BD9576 watchdog driver has implemented it
as "start watchdog when loading the module and prevent it from being
stopped".

Furthermore, the implementation does not set the WDOG_HW_RUNNING when
enabling the watchdog due to the "always-running" at module loading.
This will end up resulting a watchdog timeout if the device is not
opened.

The culprit was pointed out by Guenter, discussion can be found from
https://lore.kernel.org/lkml/4fa3a64b-60fb-4e5e-8785-0f14da37eea2@roeck-us.=
net/

Drop the invalid "always-running" handling.

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Reported-by: Guenter Roeck <linux@roeck-us.net>
Fixes: b237bcac557a ("wdt: Support wdt on ROHM BD9576MUF and BD9573MUF")
---
 drivers/watchdog/bd9576_wdt.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/watchdog/bd9576_wdt.c b/drivers/watchdog/bd9576_wdt.c
index 4a20e07fbb69..f00ea1b4e40b 100644
--- a/drivers/watchdog/bd9576_wdt.c
+++ b/drivers/watchdog/bd9576_wdt.c
@@ -29,7 +29,6 @@ struct bd9576_wdt_priv {
 	struct gpio_desc	*gpiod_en;
 	struct device		*dev;
 	struct regmap		*regmap;
-	bool			always_running;
 	struct watchdog_device	wdd;
 };
=20
@@ -62,10 +61,7 @@ static int bd9576_wdt_stop(struct watchdog_device *wdd)
 {
 	struct bd9576_wdt_priv *priv =3D watchdog_get_drvdata(wdd);
=20
-	if (!priv->always_running)
-		bd9576_wdt_disable(priv);
-	else
-		set_bit(WDOG_HW_RUNNING, &wdd->status);
+	bd9576_wdt_disable(priv);
=20
 	return 0;
 }
@@ -264,9 +260,6 @@ static int bd9576_wdt_probe(struct platform_device *pde=
v)
 	if (ret)
 		return ret;
=20
-	priv->always_running =3D device_property_read_bool(dev->parent,
-							 "always-running");
-
 	watchdog_set_drvdata(&priv->wdd, priv);
=20
 	priv->wdd.info			=3D &bd957x_wdt_ident;
@@ -281,9 +274,6 @@ static int bd9576_wdt_probe(struct platform_device *pde=
v)
=20
 	watchdog_stop_on_reboot(&priv->wdd);
=20
-	if (priv->always_running)
-		bd9576_wdt_start(&priv->wdd);
-
 	return devm_watchdog_register_device(dev, &priv->wdd);
 }
=20

base-commit: 4cece764965020c22cff7665b18a012006359095
--=20
2.43.2


--=20
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =3D]=20

--+62XoNjJEtN0LqUZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEIx+f8wZb28fLKEhTeFA3/03aocUFAmYTwKoACgkQeFA3/03a
ocVIBAf9FKl8kSmeeJpnRMWSu+0fbMUkNzmAKhcJMFqjbGXxREiDzBpDuclFvd3c
DIDEJuM7enHZr8uKgerYpkqyi7B1QSO06kcbr93MNh6zygTixoLuao1wkCFZVnS8
A/cSSPLinfTNiODuuFC4NYmhswvbZJOXYYAazcpNG7SyrtdjZD7ogZEB5sPznlnA
NfgP9/3lFZjggUk+GgpiOxpdFHkm97yZx7h71lfD1b1wlqg+HJ+Cg4Pta5+P1JCc
kCyVACfIEUvmkSyxTUivdSsNDDD/lExSzTU5t9yRrvZ8mIQphWx1Uuw4KytjLMby
q8Br2NAuQHuAO/KxqGMIb/nl+/7wlw==
=NiNg
-----END PGP SIGNATURE-----

--+62XoNjJEtN0LqUZ--

