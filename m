Return-Path: <linux-kernel+bounces-98116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC0B87754F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 05:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FC9CB21C41
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 04:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3CA2554B;
	Sun, 10 Mar 2024 04:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3Bp7kMW"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24877470;
	Sun, 10 Mar 2024 04:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710046346; cv=none; b=W4XofIEjMjQQyEPAw+Dyh45/oHF74LgPmbe6//GJqh+Q9x7UG/H4853AsjcWav3EzBmcZ+n5IvTFq352aPG8PlUvXNN07rUcA5e98cz5ow79vdUQI/ktfC4grf/Hrv832Zc1em7B5L217u0+w1rNfvIoRQiUVF91/5X+nP8o3T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710046346; c=relaxed/simple;
	bh=7f/5d43WPVEjlJpJuyxvmDK6WGVzj/6ZalhsBvLwlco=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sczYN6hCwt+Dmda0/1asEXxro9sj1qJdPy5FJkPxnzo/49z/fkG0C8r53yacahQSc00R5F7jXXeqdE7dsjPueKJUBKWQfjalZzkMKaP0RC4YOM5jKz1ub8l6ZNS9JOyx2wZ0/1UzZntDUWNANGpTHdCQ0MMnv3Z3hyjzN2bpRFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3Bp7kMW; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e655a12c81so2477989b3a.1;
        Sat, 09 Mar 2024 20:52:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710046344; x=1710651144; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfntijmQgp1O3WIpkJBpEgwRwttiIgBYxL9mf5xJS3A=;
        b=A3Bp7kMWlDRZG4SSAkuREufrIIO420Z6tFrJUHcOYzmXHArSS+WcT06Q1gynr8VfLP
         +OFytZDr5Ltqhe2G21RbupfJOdEfWiZmQgPHohghbKwPiM2kMrc/D9bhc2oWgs2unK+R
         I12XpXV7X70f5vwlWKO83itHLTKCujNY8BjH/D9B+bg6nFuC0QhynFVb9khE4IKmNra+
         FDeALZUMEicIEas/OPMql0nRvxVPZnaO55tRAnCfgW0SReH2AIJpBjQo0ogrsgnqj7vT
         E4t0SrbMQyC8laNNC0Y8zWx4AK8pWfP4azbQHI2MzyEH8Z5SB+NiZKrGPyPu+q55vfzD
         C0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710046344; x=1710651144;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lfntijmQgp1O3WIpkJBpEgwRwttiIgBYxL9mf5xJS3A=;
        b=NNoxSgn6Os4Uym6YGDM3j0Znl+lGuxZUdaKd3g6khHXmhdJcmChmWpxaZy0mTFQsU1
         19zV+R0+/Wv5dL6YQgzDCHP8UXgIk0L/Iv7b2sVOAabZLdiFSbNv3Wr8a71qBLNC1RhD
         bCMzserGAbABnteuHYU8BvPeqTXJh115zDfK3Wt9nLixbVGE75qcwzhNowcrdQpAsyvk
         98lxzJ5Jj9Gc/8CybokdpNUAniNkv7G0S0CexKmWBk+qNFW9BPt/6heRRaBbveS+Dv2H
         qHmQMkmN0YuW+fM8v8yrP8bM8OXcjAxd6ZHutzHUVc7C2ZxO64Kpc1YhJYurSAiaR0dx
         grwQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQaBqvcEJ/GvkJ+oW2g+QqDeIch9TpDpKJOWBWJTPEctS92Dc1D/Pa/NJIdmWn0KRW+pE/wC8YnVDZmGrxa5qRLIsYieQX4qN6PI5P
X-Gm-Message-State: AOJu0Yyl2wagZ9uNACZyS6WpG6UCWuCN9UizaAnx21UYPR2XnkXzmGAI
	qDr3IMjuCEMMtdxBF4+EhklxlwHMI71eWHYaQ8ox+ha0gKiUKj2z
X-Google-Smtp-Source: AGHT+IGlO5NG5Z6lacAc90S8PbqOJsioRUsqZHEizpzjZ7cuHLUqCa1+RBoaiYIQchK/SsCkmnEb3Q==
X-Received: by 2002:a05:6a21:328b:b0:1a1:89e3:9550 with SMTP id yt11-20020a056a21328b00b001a189e39550mr3875264pzb.10.1710046344325;
        Sat, 09 Mar 2024 20:52:24 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([2804:3b0:4104:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id e11-20020a63e00b000000b005dc48e56191sm1984659pgh.11.2024.03.09.20.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Mar 2024 20:52:23 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 10 Mar 2024 01:52:00 -0300
Subject: [PATCH net-next 3/4] net: dsa: realtek: do not assert reset on
 remove
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240310-realtek-led-v1-3-4d9813ce938e@gmail.com>
References: <20240310-realtek-led-v1-0-4d9813ce938e@gmail.com>
In-Reply-To: <20240310-realtek-led-v1-0-4d9813ce938e@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1590; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=7f/5d43WPVEjlJpJuyxvmDK6WGVzj/6ZalhsBvLwlco=;
 b=owGbwMvMwMG4W/D2rovs1mGMp9WSGFLf2pQt+X0jyVh9Bes/wcD0V7un5v0tlV/gymlkcTI1/
 ZardOCsTkZjFgZGDgZZMUUWQXYN99az0VZCv/R/wAxiZQKZwsDFKQATiVvF/j+mTPf0T5c0r+R/
 lV/O865d9tsv5sW6WQ83GG6VY9tRmJBrtSugv9Jzoud8hV5+jZo6lvxat1Tex/enJ+xqEN764Of
 EYMVrtVPDZ6QbxaQ2sKYqXZrbJcv4zerUJ5mi5wZLZ2dVffM0cDfeKlwVvCjwf1RTxM7Pvunsqx
 MZTkhr3Ha1MCj4w3dI/+iEhdxJr1j0fXRnWAi2cf0Le//xd/z1yCv11YK/ig8IfF2bYRDdf1+/N
 eb9AT62Z0q9uwW4/87M3nHVQOLs4lxjEQ6eCWHTGoSebVDNkE7WmSohNruGWeuDe23fin3X3vQ9
 FFdbofavSsM36xcP5wWOrq039K/e2Xx77WG1CbXyHn4NAA==
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

The necessity of asserting the reset on removal was previously questioned, as DSA's own cleanup methods should suffice to prevent traffic leakage[1].

When a driver has subdrivers controlled by devres, they will be unregistered after the main driver's .remove is executed. If it asserts a reset, the subdrivers will be unable to communicate with the hardware during their cleanup. For LEDs, this means that they will fail to turn off, resulting in a timeout error.

[1] https://lore.kernel.org/r/20240123215606.26716-9-luizluca@gmail.com/

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/rtl83xx.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index d2e876805393..a9c1702431ef 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -290,16 +290,13 @@ EXPORT_SYMBOL_NS_GPL(rtl83xx_shutdown, REALTEK_DSA);
  * rtl83xx_remove() - Cleanup a realtek switch driver
  * @priv: realtek_priv pointer
  *
- * If a method is provided, this function asserts the hard reset of the switch
- * in order to avoid leaking traffic when the driver is gone.
+ * Placehold for common cleanup procedures.
  *
- * Context: Might sleep if priv->gdev->chip->can_sleep.
+ * Context: Any
  * Return: nothing
  */
 void rtl83xx_remove(struct realtek_priv *priv)
 {
-	/* leave the device reset asserted */
-	rtl83xx_reset_assert(priv);
 }
 EXPORT_SYMBOL_NS_GPL(rtl83xx_remove, REALTEK_DSA);
 

-- 
2.44.0


