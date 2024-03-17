Return-Path: <linux-kernel+bounces-105317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 033CB87DC2F
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 02:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B0DC2823C5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 01:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5873FC2;
	Sun, 17 Mar 2024 01:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2+WFbno"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32D37F6;
	Sun, 17 Mar 2024 01:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710639368; cv=none; b=nxf0PleQimQjiSurjjPXoa6jiJfH9Oocn76Tpe5SHCvwOYiBnhvspqSP4CkQ9V/omjahz+T6pgTBWjEPIwGke4xALncOdBzKK80Z3HzRj3jMzsiJu3YemCHAllI8n5jP6tVifMO7qkAL3cbQBUhZUN8XIUT41p8917IGx5wn30U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710639368; c=relaxed/simple;
	bh=wT90xc5MN9pWYiCuET6gJiyUQOhBicpNzpjQPVvsBE0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=B0hXPf823jVfcA4ewmZMxkKTGiNLFnclW7HQGFrx5hPHuAi3gt5GjHYHVOYZxn6GBeFQUAlyZbVDKg7CoWy9FkiVmhxaOMSOfAdlOFn7Rhux2T1YntabLRcHk7B4xoYmM2D7JDbWnlW5gr6+9Als+K87sYEysDoJG8eFmY2jhyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2+WFbno; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a46aaf6081fso71780566b.2;
        Sat, 16 Mar 2024 18:36:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710639365; x=1711244165; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XJOPQTPZIdoYGlOmY3Fy/8dzV0uwF8EKc4H6FIgjX5I=;
        b=P2+WFbnoWsBlGIrnRkW9PnYzIG5rriB55ab61XpahvjJR/LMlRabRjdgUp49jzxd7k
         V09sd45UWzjrLW6gXs/WUpCxbKue2qOrxqdo+feCQ3xAorS475Vxw0dbaNuZpxHBrfIb
         sB7C+F19/WlYYIHkTVwaq79kfQaEqu7QVuXt5ZmSU6aVvmiAevDm3yRFhvToVUSYLAHZ
         mmLRkmdMNzLi6atLu8wrOV8WsKLcIAePEm74LJMD7mIhSHElclLO5yMenjS8ENFDxtdB
         wFYIox5YLfvB7RJgoEie4HTcJ/zNiHmAaLI7zkGXGGkiu46bFdEzTFwbQhqeuw8TGRRw
         4cBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710639365; x=1711244165;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XJOPQTPZIdoYGlOmY3Fy/8dzV0uwF8EKc4H6FIgjX5I=;
        b=SxshFwIqHgbT13pm4mzm58VJylBhdjNOBHWWDi6pRyKnZMpAMDN4PVygifVYHZa1yD
         O7V6l/WNziuio6U3PE5DGRur7B+q7CSYVgw2Zd5EJq8hBT7vr9rg+CHPMXoTFbVaAHoP
         EuwLq5NkF2G0fikhxe93Tebf+aBxDFlrOU9qDYg2b0ROUh4zUfuX04n1da9upCuPC46s
         18NL5MtFYF0ZyvU/91fhURxO9xOI3ltvROe6aWXSHY3b+z2Y78hyA/eLAHB7D4JDtInX
         LK2B94ItewUdZhGKj6WKhmfmdlyuwAiNlrVJQpvz0EVqKZupN/epIK9+C90kA9U6Zghn
         S2Bw==
X-Forwarded-Encrypted: i=1; AJvYcCXU7rkjUZcUdEiTp6jsDzumzKwySvBr4P24jM/G7c3/q15g+sO1C7uAvuoptDZp1bZhwQXOZNdEvURY00pFLh6muwWpT4NDoImq4pTu
X-Gm-Message-State: AOJu0YwEs7FwRB1c9M1NT/SnqM3ejN/x5THzh/PkHSM0Xt5oA0QGkTUf
	pgU0Tx/smUO9fJ2RiUACaVTa4i7Qn2X95P9hyRO3Le2ueXMtAMPu
X-Google-Smtp-Source: AGHT+IFoKk63r+2w89jQKSp8O06gxrMvN6aVFZ3hTGDXG5DWJLum92uJwZd39+ipO+It2noY/ika0g==
X-Received: by 2002:a17:907:77da:b0:a46:5de0:6efa with SMTP id kz26-20020a17090777da00b00a465de06efamr5369324ejc.66.1710639364819;
        Sat, 16 Mar 2024 18:36:04 -0700 (PDT)
Received: from ALDERLEJK. (89-76-44-138.dynamic.chello.pl. [89.76.44.138])
        by smtp.gmail.com with ESMTPSA id p7-20020a17090635c700b00a465b6c9a67sm3273109ejb.6.2024.03.16.18.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Mar 2024 18:36:04 -0700 (PDT)
From: Kamil Kasperski <ressetkk@gmail.com>
Subject: [PATCH v2 0/3] Add initial support for T95 TV boxes
Date: Sun, 17 Mar 2024 02:33:58 +0100
Message-Id: <20240317-add-t95-axp313-support-v2-0-e38032811758@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIZI9mUC/x2MQQqAIBAAvxJ7bqE0I/tKdJB2rb2UaIUQ/T3pN
 Mxh5oHEUTjBWD0Q+ZYkx15E1RUsm9tXRqHioBrVNbo16IjwtIU56FZjukI44onGa3KDtT0TQYl
 DZC/5H0/z+34i/XIUaAAAAA==
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 Kamil Kasperski <ressetkk@gmail.com>
X-Mailer: b4 0.13.0

changes since v1:
- introduce sun50i-h616-t95.dtsi for common nodes in t95 boxes
- validate and add cd-gpios for microsd card detect
- add wi-fi node
- remove mmc2 node - it's not used
- add uart1 for bluetooth device
- update copyright

T95 is a most commonly known for being a box with a pre-installed 
malware. It uses Allwinner H616 and comes with NAND, and DDR3 
memory.

Those TV boxes usually come with common hardware:
- Allwinner H616 SoC
- 2/4 GB DDR3 SDRAM (Hynix H5TQ2G43BFR)
- 16/32/64 GB NAND flash
- microSD slot
- AXP305 or AXP313 PMIC depending on board revision
- 3.5mm A/V output
- HDMI port
- 2x USB 2.0 ports
- 100M ETH using Internal PHY
- LG642 Wi-Fi and BT chip (rebranded BCM43342)
- 7-segment display
- DC 5V barrel jack port

The board contains holes hor UART header wired to &uart0.
&uart1 is used by bluetooth module

From the DRAM specification its operation voltage is 1.5V.

To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>
To: Jernej Skrabec <jernej.skrabec@gmail.com>
To: Samuel Holland <samuel@sholland.org>
To: Maxime Ripard <mripard@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-sunxi@lists.linux.dev

Signed-off-by: Kamil Kasperski <ressetkk@gmail.com>
---
Kamil Kasperski (3):
      dt-bindings: vendor-prefixes: add t95 string
      dt-bindings: arm: sunxi: add T95 AXP313
      arm64: dts: allwinner: h616: add support for T95 tv boxes

 Documentation/devicetree/bindings/arm/sunxi.yaml   |   5 +
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 arch/arm64/boot/dts/allwinner/Makefile             |   1 +
 arch/arm64/boot/dts/allwinner/sun50i-h616-t95.dtsi | 109 +++++++++++++++++++++
 .../dts/allwinner/sun50i-h616-t95max-axp313.dts    |  85 ++++++++++++++++
 5 files changed, 202 insertions(+)
---
base-commit: 4138f02288333cb596885e9af03dd3ea2de845cb
change-id: 20240315-add-t95-axp313-support-5f3da8996edd

Best regards,
-- 
Kamil Kasperski <ressetkk@gmail.com>


