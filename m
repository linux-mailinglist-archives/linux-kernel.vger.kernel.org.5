Return-Path: <linux-kernel+bounces-59010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BF384EFCA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 06:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4D1F1F2311D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 05:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1446258AC8;
	Fri,  9 Feb 2024 05:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfB/WcQJ"
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF5D58AAC;
	Fri,  9 Feb 2024 05:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707455090; cv=none; b=kCGP25nutwty1l1m6hR2eM394xXNK31qEdlmtiLTl8GPsztvir4rih2Mu+Lxfu/XfKr2Ln2Ikc+M7z/e94BUH5OmEVPZREpfk80e0hagOWeKCU6xKJTYBMUkVO/haKp4HjKuulaGlF3PKEXIsQwpF1poukZCkWdTcFwyebEv4o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707455090; c=relaxed/simple;
	bh=oSljXLwC9HAU2V1FBm+15SBnLdbMf1Dpq4x7+PIoUqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fI7NejsBmo9X39Z1sYBF2uMMEvlZE7UGQbFlKzRbfmvyq5R8rlP+6Z8zzcl6f4+uQ9TBHIr/WCfNu58v+ocuf73zf1omkX4/QBiJ/aou7VoxGL9G5JbfWrGsssfOVGEzU4qhk/bjx+BRPg+GBRdP79Qhna8AqvOjBtyvQzv49pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfB/WcQJ; arc=none smtp.client-ip=209.85.167.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3bbbc6b4ed1so349590b6e.2;
        Thu, 08 Feb 2024 21:04:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707455088; x=1708059888; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/VcEDmubNqh5Qc75TMi6e2g+Prcd3QWY8lbgT5MxNYg=;
        b=FfB/WcQJDXf6yHAzB2ph8f5vYTzA1hHSo4GAcQG9FVEW9Gv9Y0oSvnDTIH7EdxVWCb
         YShTLecETDGcBooqCl+gLs7CvwrLD1eNaAufze7A9uH4WHiFGHiZ7FXtmWjdzNlB8odF
         bXjM1osdzZtie32IiSwkfYXcBHRNy+NIjugeGyrnJi7QRNPSTWLoDhYoOyeZWFmTPtwJ
         ErA8+ok7MW45JODTJ5/dGDXXTXDZWlsVJ3PSzg0f4uHQY2fjvFShbdO/jxsL8tb9AlmU
         Q68U2pgcAgHNoFLE3/GFXhDawbA07ufCT92MT60BgYlGSTUeYB3AMnNaKfRbLgUNGuEa
         adGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707455088; x=1708059888;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/VcEDmubNqh5Qc75TMi6e2g+Prcd3QWY8lbgT5MxNYg=;
        b=QK4HwCkTV9752b31EOuMC2pEbEkIh5Akwpg8bL0xw8SNP4VL1XKD3n/NQpeMX6GSMZ
         KSIMA9t3EraS9q1pZg5z39nNalhI1rqOSOjTFrBwU0KfDHE7h1ieoenaNL99GjWuaGj4
         PGbfMoGw3YCQ1zF7J8JvL1YRexJJj0U49cqQceWMW3T1GC3OGdcMtECqV9lWngGG/Afc
         2oH8MEMHatKpAJcB6AXr1eVcK3fBxfcB8USw2q16554uH6dVTVzzHmEDmuuV9ZI/RIVw
         BHMIlCP6XkFod5Owy8JE5rzHWAqvRLQZnMAefmpz07NpYdnPAxkt9KxFhfN032qOOyPC
         yUNg==
X-Gm-Message-State: AOJu0YyW5Zg61IRIZlnud0sz6QVS95g8w0tVG9+0JaWQXY3ozHb4YSzL
	SJv3cyVopnL7Qg1Rqt1o4mHhujg+fSfuQ1BQqIMfnXvUUQl1+wMp
X-Google-Smtp-Source: AGHT+IG2vahMHnW9nEaDPxmiq8/mNzL1JIiWJijxBDjmWd5SuMxr/8Tr1xh0hhUTx8FqgdV1uh8adQ==
X-Received: by 2002:a05:6808:308c:b0:3be:41d5:9510 with SMTP id bl12-20020a056808308c00b003be41d59510mr667581oib.43.1707455087786;
        Thu, 08 Feb 2024 21:04:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWCmXgBkNJ20DJKMjV/HU9XZQQrzyNuxv/DA2/IDODMapA0IX+XRz/QPfMb9ejocAZXyJWWZIKXJRqPzTzLE0kVLSucPIUN68YdSsFBffseCZn2sbwNqTI50OoYx46bTx5egyVRRkbbqwumUCH+gY3EbWFFkbNmbufVhivWoYyLSwdmhMZTKsSS8aAmukBVmz2UxWROAMZr7qy3Ls+LCbf/WQV52TUw4HA7KTqswJhw2N640KuOVOh+71nwTCbuWF3XMPJD0oDN0xb2r17h6diXRfqcXX/r30y1D0NxntZq6Xs/rp9ob/bjQfhYZlp/niF/A9VzBQWa6kBo9C+yWhDNNz8h60/eUBG4lzsyy9DLrfGnjlhdc0Hn9XIvHq6jIzwim6YyD5RLxzxJIawQvsRlI3G/
Received: from tresc054937.tre-sc.gov.br ([2804:3b0:4104:200:2be:43ff:febc:c2fb])
        by smtp.gmail.com with ESMTPSA id d1-20020a634f01000000b005cda7a1d72dsm793616pgb.74.2024.02.08.21.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 21:04:47 -0800 (PST)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 09 Feb 2024 02:03:43 -0300
Subject: [PATCH net-next v6 07/11] net: dsa: realtek: get internal MDIO
 node by name
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240209-realtek_reverse-v6-7-0662f8cbc7b5@gmail.com>
References: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com>
In-Reply-To: <20240209-realtek_reverse-v6-0-0662f8cbc7b5@gmail.com>
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
 h=from:subject:message-id; bh=oSljXLwC9HAU2V1FBm+15SBnLdbMf1Dpq4x7+PIoUqo=;
 b=owEBbQGS/pANAwAIAbsR27rRBztWAcsmYgBlxbJL++MEDW3ZGpjQEAZLzD4ZGG+zNdIHiRBtb
 m4cVgZ1pgKJATMEAAEIAB0WIQQRByhHhc1bOhL6L/i7Edu60Qc7VgUCZcWySwAKCRC7Edu60Qc7
 Vul+B/9srDuW9N18J8dqLQYLRpFU3RMYWsG+M7AxfoB9dVhlLoMAyWnWOkaHzTe2mUbcZUU8v7n
 z+67/2jDM9SZrvSEpa+9divndnAn10ZZ6vTatxH3Rj+9CBr8JYWiVN4UcGOinfZsIwMDnu6BEzV
 h/FQaugLTe3DCdJdzXw99jnU1wuv3KBQ1K+ogaeYcvN/ZDhyyZSAhpHA5h/dX+Ha/ZsdpEpYL7C
 ElFRicALy0oDLMENyly4WFongA0vGi4afAT1vS9UHptUTk71bOirZ3RahOU6Ee7LrkmdRzlcqfe
 Pxrc772b8fLTlg312Xgpi3ahncc2g3BWpCV+7XlPzc38eFlu
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
index 10de30d3e044..1fa8e9cb1a10 100644
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


