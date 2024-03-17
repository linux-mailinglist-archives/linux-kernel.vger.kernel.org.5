Return-Path: <linux-kernel+bounces-105532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D80C587DFCD
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9319B28165B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F8C1F61C;
	Sun, 17 Mar 2024 19:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cypa7KjC"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0431CD3F;
	Sun, 17 Mar 2024 19:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710704876; cv=none; b=OH0poYIbZXO6xcnAaUo1YrwTgkU7k/aEGxzfQW54tKuxEnb94xz0mOFQVJyZLeuu9kuUP6aXK7KsvBrFWiQM/WmcTCapf3zOFf/SYhJTXM532cUjC3fy5no0jZdOQDTT31iHOJigu0B+La0mJd6M6pU2n0IT4imMmlU9miIQUDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710704876; c=relaxed/simple;
	bh=EOE2bo0zJ9hf89Q0Q5I8PD2WdBZOnIxrXxn41GaOEo0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=MfXE6m+2tAud5DHyZIm9+dJAZ7Nn3w2tNXrd+djVFMb2Av5joygaTCiZiGDYQ0UdXF21QDtMLLO7ykHiSZ5WPgPabdFh8Ptr3G66JhhwIB8QZldNvj6gPbcGpQvjratq+yEZfEV0TD5JQ6/BSebmGJSEXgiol0ZGOQXYz1JqgdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cypa7KjC; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a466a1f9ea0so275244966b.1;
        Sun, 17 Mar 2024 12:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710704873; x=1711309673; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HxxAZWybaK0nfNhYMPJ2x8WOCyodnruQ7jiYPVCHHZo=;
        b=Cypa7KjCgDxlrBt33+RHGw1dCbWfpWjxXXphQTcon8Yfc/N52Sk3dhgy5NB1TAKsP/
         xgJa3AQh5mqTuYMG1lIEMlM8ET+sOcn9JcaixtiSOaxjLXe4M8j+XvI5ONpnMIOy4PeZ
         9Drqel3RyuRQg24duro9ECp6/9icUCE7/PfvFb8BFa2hSuC7DGehPIVSmUDROz7Ikeea
         XCOnGois4az07eT7vJxMlF1q4ob3K7FqC/l5xkOBYAqZqM0fxPFXLfV0QQLoZlDQn6et
         TgrZEE/CBnjFmGq3n6rDwqgkumzUNF2VhLJi8ScA2qXfjRlp3iZ+Rm+GFtSL3cJ01fXQ
         NerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710704873; x=1711309673;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HxxAZWybaK0nfNhYMPJ2x8WOCyodnruQ7jiYPVCHHZo=;
        b=JxDxCe6NV7eArzaGhqbsp0H601XyPGwfPQJkotLLwPyWRtB78Rli8t9dmcgzZO429q
         tKfmXWFMlTw7YXid+uK07VHEFbSh2gzhEDtagrKsnFW4WMVZay66MaiHPq19abvLlTcz
         y+/r8qOwP7ma2+T9oKpU8PsvaR+blprpYT3a0lNW/XbtFDchDNX5P7jweJ6Y1KGdUpsx
         G54GrZmKM/81FbgnyAhiJKEgeIRXFIaFJ+PpztJ5Dbq6S9hRvndhYRWC6eSXp4/ZPWls
         3n8o1t4RG9wPsTaei2cdl2qLSlI04/oZpAjm7CdoRzRUE77EJ6w13nqVBykEwcpOGTGR
         OZMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVg96/EEWPsk+/x9SDZN9C3xn0TDekC6932JHy49leIno1rc812+v0a1uVM0Favt2VLBm0qWi758fl4r4rHyzhbWvPrQA3FBxAcGKKt
X-Gm-Message-State: AOJu0YxXQU+o1ebGbDcm5QbvRHkIQorABELcQzVKKV0ZRbZ8px0l8czx
	iDjprRs7u3ZcrTRpfl43xw/keh3bg0LHr8D8Cc1ZIJ+dRtj7Fdyx
X-Google-Smtp-Source: AGHT+IHjw5wdNqqRL84aIea6Y6j91etevio8AN75lq5QpKtW8Dns821V1ojkFQvjPK+sDFAgkX8Ikg==
X-Received: by 2002:a05:6402:2079:b0:567:6bf:e92d with SMTP id bd25-20020a056402207900b0056706bfe92dmr3367835edb.29.1710704873001;
        Sun, 17 Mar 2024 12:47:53 -0700 (PDT)
Received: from ALDERLEJK. (89-76-44-138.dynamic.chello.pl. [89.76.44.138])
        by smtp.gmail.com with ESMTPSA id i24-20020aa7dd18000000b0056ac092a7fasm8234edv.87.2024.03.17.12.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 12:47:52 -0700 (PDT)
From: Kamil Kasperski <ressetkk@gmail.com>
Subject: [PATCH v3 0/3] Add initial support for T95 TV boxes
Date: Sun, 17 Mar 2024 20:44:48 +0100
Message-Id: <20240317-add-t95-axp313-support-v3-0-0d63f7c23d37@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADBI92UC/3WNwQqDMBBEf0X23C1JttbYU/+jeAgm6kI1IbFiE
 f+9qdBjT8MbmDcbJBfZJbgVG0S3cGI/ZaBTAe1gpt4h28yghLoIkiUaa3Guc66BJGF6heDjjGV
 H1ui6vjprIY9DdB2vh/jRZB44zT6+j59FfdufsvqnXBQKdKQFKS1lVep7Pxp+nls/QrPv+wfWR
 6vCvAAAAA==
To: Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 Kamil Kasperski <ressetkk@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0

Changes in v3:
- remove underscore from wifi_pwrseq node name in sun50i-h616-t95.dtsi
- fix line wrap in commit message
- Link to v2: https://lore.kernel.org/r/20240317-add-t95-axp313-support-v2-0-e38032811758@gmail.com

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


