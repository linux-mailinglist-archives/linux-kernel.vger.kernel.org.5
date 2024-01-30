Return-Path: <linux-kernel+bounces-45457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C75268430F9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:16:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F16FDB24C2C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 23:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C11282880;
	Tue, 30 Jan 2024 23:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1lwVjVJ"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D117D7AE78;
	Tue, 30 Jan 2024 23:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706656470; cv=none; b=dAfuDRlwtg5kfLuMrDr/qby7DeizgtvIdKgbZmorsyQphicPAcqY8yNEDqU6u0FjxtamAGLCLEfXy5vY4vuvy1UPYpqeb7R0oZ/5w0F6Jf5SThtrAmzvw95cPTXtzDHzUBtF/VqwnfXW87GGfK0kuLpqqsdBV5dqWHMwP85Eb4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706656470; c=relaxed/simple;
	bh=rr8xQvtJixOVQM1jIrzeBaNMkqLLFdYjxxibLVAJQxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aftYDvW/1w0rHSRnKylotYMhamoUrvsZinTZiY9ED7L4pkFYFzxHtteiA9qWOC8YWWIWuU7gRTC2gbZRnhGK9BkcmZ1FlIV1X1zQS52VZzeKmSj4o6qh7C64skYYSKeGncJ3DrMcEBabq/JlpC+4LB/cb2K66nAOleySu8oBErI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1lwVjVJ; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d7881b1843so37899435ad.3;
        Tue, 30 Jan 2024 15:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706656468; x=1707261268; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N1mjFuPg/MxcVhVNj/JxV8kjGLlrUjAjAv4TnVDkwZs=;
        b=P1lwVjVJesHh/EuehLL9U+qIi4jVm/7Atr3Raq9BTOiqJGPgALevy7HMpn0+/NpftD
         KUo52yf6FrPUFED9kCrzVDrfxtXmu0z7nCoaf1skucyWBf7CWtlZLtq0YlcazMB6slGY
         AL/ohSHDfn7sYHud0fWwE3Gg2xhXbgXLCnCr0MrTRHz7gPcKlmMMttBQSGd4HuWL1LI2
         LkdG89aOxCYJf5636wH9wHBm2Tn9sUbJ3A60yFhzfeN06OBlCKx6BDfp3TQkz9QTC0my
         jfAPb2ow8TtH2Xkl6JqLbrkpqHVct1gOLmFlKin4L/RgFzSvm2mf4Zz+iNu3esFMCwbu
         XEAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706656468; x=1707261268;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N1mjFuPg/MxcVhVNj/JxV8kjGLlrUjAjAv4TnVDkwZs=;
        b=GA3shKIPlWLpZRJwWEFxNpvlBNqlbkCHDCzd5zX6uDEH2/jxPgEMU1JbKRcw+Gdg5e
         lqaLB/qAsEE2+gDzKtuJSctTSpOs61waaqWBlSUoTmEI6n5H2C/Og7XxwKGmT7MvUCxC
         SHkJMYdOA1ezNlJ3T0X48M0TixbX1afPlnKHfYiRYUpCxV2JeWL2zGsgIMbAP0TGnsPH
         +sUShXi2qybY1cekyq0SPinuIftJZNRFK+j4TKNlOzVn7qREJX5J0NkeSY6Qf4Mb5EYn
         5QWlxoGdns0CdsZx7CcxxPEfIwEMcPEpJDCXsdCvLh86WLPXr+PuVWaKQg74kxfyRcZA
         KyHQ==
X-Gm-Message-State: AOJu0Yx309zYY1mW19cXfcRau8P5dKtJvJ83Y8oI3hCpt+PHc9TKQyVc
	EJImDmK+y5plLeGXHo+uG+++ejKCNameGW+vQFmXNzHB/D7ahFmS
X-Google-Smtp-Source: AGHT+IFwsB44AjkMQAkl+d4Omih8JQMHbN4EsYOJHjZIuvF393B38+zqMNJDRVQWZ+TsrWV/Qks0xw==
X-Received: by 2002:a17:903:124a:b0:1d8:f06a:9d68 with SMTP id u10-20020a170903124a00b001d8f06a9d68mr21517plh.33.1706656468108;
        Tue, 30 Jan 2024 15:14:28 -0800 (PST)
Received: from tresc054937.tre-sc.gov.br ([2804:c:204:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id jx2-20020a170903138200b001d8f251c8b2sm3473203plb.221.2024.01.30.15.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 15:14:27 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 30 Jan 2024 20:13:26 -0300
Subject: [PATCH net-next v5 07/11] net: dsa: realtek: get internal MDIO
 node by name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240130-realtek_reverse-v5-7-ecafd9283a07@gmail.com>
References: <20240130-realtek_reverse-v5-0-ecafd9283a07@gmail.com>
In-Reply-To: <20240130-realtek_reverse-v5-0-ecafd9283a07@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1279; i=luizluca@gmail.com;
 h=from:subject:message-id; bh=rr8xQvtJixOVQM1jIrzeBaNMkqLLFdYjxxibLVAJQxg=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBluYKxzQADkmpv2X0xDHsziofDV4WDLhdy6ZrAy
 JP+c7hDHHqJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZbmCsQAKCRC7Edu60Qc7
 Vq02B/9PguUEnNSYkD5vsKNSR8mJdqvBvuAqwQiGRt5o5zcB33liUOGpFk4DNO8ZeS20SSr2ka3
 4ajaD1xMA5bq2FQSerZW3a2+ujlg0Yu1sGPPAr8mFpGhloyGK4ZoXUO9occIO9uEfkTShEeu8Zt
 U+W42Nq/4E/YXHTsRwBWe4Av6a4eksSxIKQ/jLi4ALD1VOtVWuNXc0U1dYusSTOTJzkwkGYibki
 3ySg6MXQ3FccleZRv4zTOBDgGnMEICuPoVXt6sG+ON7OaLrzc6fNN0j7Qr/M09qwMgZSnXO6gl5
 kSjRav9WlXI5+5wF1pXf10LmHcBY4O3uEUzarpGgbKXfh2g5
X-Developer-Key: i=luizluca@gmail.com; a=openpgp;
 fpr=1107284785CD5B3A12FA2FF8BB11DBBAD1073B56

The binding docs requires for SMI-connected devices that the switch
must have a child node named "mdio" and with a compatible string of
"realtek,smi-mdio". Meanwile, for MDIO-connected switches, the binding
docs only requires a child node named "mdio".

This patch changes the driver to use the common denominator for both
interfaces, looking for the MDIO node by name, ignoring the compatible
string.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/realtek/realtek-smi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/realtek/realtek-smi.c b/drivers/net/dsa/realtek/realtek-smi.c
index 67bdad7ac910..ad47dcbbd2b2 100644
--- a/drivers/net/dsa/realtek/realtek-smi.c
+++ b/drivers/net/dsa/realtek/realtek-smi.c
@@ -333,7 +333,7 @@ static int realtek_smi_setup_mdio(struct dsa_switch *ds)
 	struct device_node *mdio_np;
 	int ret;
 
-	mdio_np = of_get_compatible_child(priv->dev->of_node, "realtek,smi-mdio");
+	mdio_np = of_get_child_by_name(priv->dev->of_node, "mdio");
 	if (!mdio_np) {
 		dev_err(priv->dev, "no MDIO bus node\n");
 		return -ENODEV;

-- 
2.43.0


