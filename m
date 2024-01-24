Return-Path: <linux-kernel+bounces-37102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7219883AB8E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:21:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF39F1C25495
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397FA7C089;
	Wed, 24 Jan 2024 14:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBo56gyr"
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADD47A735;
	Wed, 24 Jan 2024 14:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706106075; cv=none; b=BnCigaYMQ3HYzjhJoIgAfqjf2n6GSoymdPq6cK81rZ/GhveKXfH2LmQ6mMK7oKhxWCsqT2NN2LuD8uoWXH/aZfTr35ZrvZYtjKTVoxUGykEgZXnricaQV7WMdIjZTGkyq13Mlxm+fVgbUay93ee4/NmYuAEz+6BZHFjqKLfV0vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706106075; c=relaxed/simple;
	bh=t3+VK3j2R4bb1oUxd23jTVF5Qev2DcQx3oXwWbd8Ra8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICof8wQaA5Tie+U8yho4Vfm4WRNp0MXX7uo0mFrcKyyoVoFH4cb/06qsvaPK1ieBBP67fc1vuELYVQbYxlAVJXFg0G8r/8hVKebf91kv4CuB3cGiSxYG9w9ALM8NY/xOK5mQWvfqeYL5UwAQ4bxqMiq2jx61MEBm8rG0bTE67C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBo56gyr; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6dc6f47302bso2367667b3a.1;
        Wed, 24 Jan 2024 06:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706106073; x=1706710873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BxGn4WrOc3WFp6MYbJqTJXsjcKBvR5o5znq5DWwx5UA=;
        b=iBo56gyrSBU/hxbRPviCw2j3M47rExyRui0Nq/tpGvI8dJBM/3rFG+2FysffBvO/Vg
         wZ+c+eBQc2uggvDb6DzZEA7kgy7YWwfuHgoixE5Du9axaCytWOqleOJyw2iJiD+q3Ytx
         oWx8DOv3KGfQT6Titg+qgAw7hhxVAJLSIDZ+GBjujA1yUH6fGoxsuiyFPd3Dn2SV2W9E
         LA2KtBOS7gZr4/mfkm4rB5zhUc3COkq7FUme3Ew+qpxYNXZX032NdOTOl0UIy2VCQTmg
         n9uID66Pl71JQ3Wzl7HKNk0VlDdWVYrk1TUTmnJr7VdlqcJ4ZWZuaPhILQhOI2QJM0xe
         2vrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706106073; x=1706710873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BxGn4WrOc3WFp6MYbJqTJXsjcKBvR5o5znq5DWwx5UA=;
        b=nZZpqhEjgvZxozjoWP4ukkUO2h0R0oxzWPN1toFtXouRZfcgFLNZrM+Zf3nrYG24cB
         4F+20bIG+cDIL2ma491Yus+CTYjdnJjpYVWkGTMmRnceprhV6/+pu+q4xuClT4r+VTT+
         PkChVYo9KWNQkvNf0kQzXNAUUn7zGVdgTIem6iVNr4PGhK5Opgfsnc0P2yEWAsgOKek1
         A1a2tqn3prgOxcODM61osBfj7TesnDyIU1FeP9UXxiKQqIHOtRLgeXNOJiRMFMcTF3ds
         YsKyq6wmmxYv3iDtmyJWpGQDN/n9DNRlco7P49ReQMfAJipO8ilF/0BUNwaLxDnW4q0d
         T2/w==
X-Gm-Message-State: AOJu0Yx0/W9N4meR0FjSgyTiS1/vwn0in3q0vNnsTFn3dT5rmqW/c5ec
	C0kNnioigqpwpz4qJmFggWQ/wXb/omx4Ee2OcKvr+UET4gjfszJg
X-Google-Smtp-Source: AGHT+IHwIDMmzpSMkdEfZFwyWdQwhHw0Q1OyZEVHtzQo9az46wLsyMLAPk6CMSCVIkspAIpcpeUzUw==
X-Received: by 2002:a05:6a20:3b28:b0:19c:495e:3c40 with SMTP id c40-20020a056a203b2800b0019c495e3c40mr692199pzh.124.1706106073430;
        Wed, 24 Jan 2024 06:21:13 -0800 (PST)
Received: from hdebian.corp.toradex.com ([201.82.41.210])
        by smtp.gmail.com with ESMTPSA id j2-20020a056a00234200b006ddb77d443asm634848pfj.209.2024.01.24.06.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 06:21:13 -0800 (PST)
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
	Hiago De Franco <hiago.franco@toradex.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: arm: fsl: Add toradex,apalis_imx6q-eval-v1.2 board
Date: Wed, 24 Jan 2024 11:13:19 -0300
Message-ID: <20240124141849.26254-2-hiagofranco@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124141849.26254-1-hiagofranco@gmail.com>
References: <20240124141849.26254-1-hiagofranco@gmail.com>
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

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Hiago De Franco <hiago.franco@toradex.com>
---
v2:
  - Add Acked-by: Conor Dooley.
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


