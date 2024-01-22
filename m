Return-Path: <linux-kernel+bounces-33025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5642183635B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8641F22A70
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B083C6A6;
	Mon, 22 Jan 2024 12:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crbCSUpD"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9FA3BB4D;
	Mon, 22 Jan 2024 12:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705927047; cv=none; b=We7QZ0doqoKF6aYy6hwIjRSp8kEKSNvi2EZW41R6CN0LS3iSjbebtqALXXxaKg9M8TgdDJTjbGC5LN+Rk7AoDJ+P7XeO+DD4+Iea8EScpZkAgx2qcW2CInPdaFrGmYxHOj8daBvb5CgOEXob/ng2OrR6D4655K6XGZTA+FMWvng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705927047; c=relaxed/simple;
	bh=x6loXWDVRtfuiFTLwtCRThF3oNujQwD3Fg7mfB3dk9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbsnl/B/B8AIJHa0JVWJT2QB8CGLzol8u4vA2+I7IQi1rGm7BLYdGRnHyzMCaBD3OVdDJvhFSDCg/nGhlBSNFMgH4vjY3Jvm82uof6g58bVzsmz37grC4Lnt1BXicVLj1WQGxgCN40rA/NhHCPD8H1lU+5tDV9nG/X2rqJ6z5X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crbCSUpD; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6daf694b439so1881503b3a.1;
        Mon, 22 Jan 2024 04:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705927045; x=1706531845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYr3TcIvwaw1Yf4qTSJ/7dEW2NOqQXM+qGSWe4TjN3k=;
        b=crbCSUpDgNcijitoYp9AzszHlzT069yJaxM9qr7R0HNGouFie9KHpUOM6Ehl/W7pXD
         kbnJxsvCn5w5gC6Z6WgecmjMZVkTbAwitrPXcrzrRKlx17F7Rj4KeAtyjwa4DPYeTRnl
         0xAnpR+QC/8f5P4jrr6Ok8KUn/StY4DKW+iZ4lY1Tmi3LjHJ/TDnDeO1L9afLYRWIjzH
         urgxIsjsEaf2RQWabXWmGkC4kf3KsgGU5DM6bk3NOL60sMTAajVQCUbTY3qS8cN9qEFU
         ElZutQ/txwMiN5SeT73PFf4zJ/zPQj0N8rYbk4A7PrLAnBOMNjBGNtoqwF4G8LrMYFOk
         7rcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705927045; x=1706531845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gYr3TcIvwaw1Yf4qTSJ/7dEW2NOqQXM+qGSWe4TjN3k=;
        b=hpqDEvp1HJlUpF+3kfb+2BM3BZ2cXzjACN1I93Cr88N9TXRV0h4rhZwPXJGw0OU6Qb
         WRptywch5mTiQZGbkviNkYkzMCjkEd9iOwHBeBg1HCP+K3eIFfvOX/6nSkikJxbyscN1
         RPCTU+mQFISHPSdBl28hTZv5K0RIZknOQkYyVwm3A7BAME1TNY3VclzPHJTi2jOHpX1P
         CTg2dJfHy2q+5K1RMe7ZxktGYMT0bo9VSRi7zwSF1McAK7pXeOv90k2ho1irEo/qZzP4
         L7onbZDlNDzXFqO7Yo9H4aW2Lk+otRAjKF+RF0gN0BCKT4EzPhHBVaGFKWKMQai74ood
         0tig==
X-Gm-Message-State: AOJu0YzsvXMolSToeSw5KuBV0OuWcQHU7GzEOV1FrOhQJ1b3Qs7qu6q9
	tXxzhAr+PGJrn2wr76pdLmeD0sfzCpdVyTqufCADsHdo3n/wOdVa
X-Google-Smtp-Source: AGHT+IGGFJiEf8OeEEsvzhrM2WIE6DhMMQpvj3Q1AJLVLgul6bR3jSqJGM8UemZMeCN7caI34i2r5w==
X-Received: by 2002:a05:6a00:238d:b0:6d9:8c7a:715d with SMTP id f13-20020a056a00238d00b006d98c7a715dmr1845153pfc.64.1705927045457;
        Mon, 22 Jan 2024 04:37:25 -0800 (PST)
Received: from hdebian.corp.toradex.com ([201.82.41.210])
        by smtp.gmail.com with ESMTPSA id t19-20020a056a0021d300b006d9be753ac7sm9452933pfj.108.2024.01.22.04.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 04:37:25 -0800 (PST)
From: Hiago De Franco <hiagofranco@gmail.com>
To: Shawn Guo <shawnguo@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Cc: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hiago De Franco <hiago.franco@toradex.com>
Subject: [PATCH v1 1/2] dt-bindings: arm: fsl: Add toradex,apalis_imx6q-eval-v1.2 board
Date: Mon, 22 Jan 2024 09:34:59 -0300
Message-ID: <20240122123526.43400-2-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122123526.43400-1-hiagofranco@gmail.com>
References: <20240122123526.43400-1-hiagofranco@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hiago De Franco <hiago.franco@toradex.com>

Add the toradex,apalis_imx6q-eval-v1.2 compatible string for version 1.2
of the Apalis Evaluation Board.

Version v1.2 includes the following changes compared to v1.1:

- 8-bit MMC connector replaced with a 4-bit uSD connector.
- Audio codec NAU88C22 added.
- M24C02 EEPROM i2c added.
- MIPI-CSI-2 connector directly to the board added.
- PCIe switch PEX8605 removed and PCIe now is routed directly to Mini
  PCIe connector.
- Power measurement IC INA219 added.
- Replaced DVI with HDMI connector.
- Single-channel USB to UART converter replaced with four-channel USB
  to UART/JTAG.
- Temperature sensor TMP75 added.

Please note that version v1.0 (which reached EOL) is compatible with
v1.1, therefore toradex,apalis_imx6q-eval compatible string should be
used for both v1.0 and v1.1.

Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
 Documentation/devicetree/bindings/arm/fsl.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
index 228dcc5c7d6f..9502a2946071 100644
--- a/Documentation/devicetree/bindings/arm/fsl.yaml
+++ b/Documentation/devicetree/bindings/arm/fsl.yaml
@@ -384,7 +384,8 @@ properties:
               - toradex,apalis_imx6q-ixora      # Apalis iMX6Q/D Module on Ixora Carrier Board
               - toradex,apalis_imx6q-ixora-v1.1 # Apalis iMX6Q/D Module on Ixora V1.1 Carrier Board
               - toradex,apalis_imx6q-ixora-v1.2 # Apalis iMX6Q/D Module on Ixora V1.2 Carrier Board
-              - toradex,apalis_imx6q-eval       # Apalis iMX6Q/D Module on Apalis Evaluation Board
+              - toradex,apalis_imx6q-eval       # Apalis iMX6Q/D Module on Apalis Evaluation Board v1.0/v1.1
+              - toradex,apalis_imx6q-eval-v1.2  # Apalis iMX6Q/D Module on Apalis Evaluation Board v1.2
           - const: toradex,apalis_imx6q
           - const: fsl,imx6q
 
-- 
2.43.0


