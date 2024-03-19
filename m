Return-Path: <linux-kernel+bounces-107945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3358803E2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:50:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3CBAB2355C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01B02C183;
	Tue, 19 Mar 2024 17:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4rMKBbd"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447D125777;
	Tue, 19 Mar 2024 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710870630; cv=none; b=SAQ+t6vU6ok4b23s7sA6rDZLVsmf/uSCOlJbMHVt4FXMVEukeV5a1aAOy3rtlsc8k1wgtEB65Udfnz2ZJgTRJ72qvI2Y2CW0oBppxF3ebiis33zhrLwptTGzi0PWbZRWn6CnwufctSVHUOyxMnzALTRjc3MSKZNYToXqK69U6gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710870630; c=relaxed/simple;
	bh=FC9qHgACVBuEChJbgc+E+ma8kD4QWpYsJ/CWRaVS0Pc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=YWGOu0SJ3tFnmqGldrafuT1t++CQVGhDEZZ0aXCEKS1uKeK5ts+aNbg6vU3nI/HVEs2ri5RHpKi1WPDqxR3NNsKGlImNSvVFgBAAN4vpFTtie7LsCzWQsUPUqPzlLpzJ2StcESHpV+PNKWxox7/mCoX2V/2HtNiuJkEZalN7oPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V4rMKBbd; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5688eaf1165so8506222a12.1;
        Tue, 19 Mar 2024 10:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710870625; x=1711475425; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=90Uve//wIswBhTh9MRoH8u7ai/wsqyznS8g3f0fG1ps=;
        b=V4rMKBbdlYUU9c8rxsZxxVaXRWKjhckUP5g/uNi+dX1NpZhG9lkaoSeIlts/3xhMzJ
         y2nzspcheEjUo+Hjc1j3Xn9QKNQgHN1/23UHe9uHSaEeaOzq0um5euV6Mwllh0LOeKkT
         CnbgUICI6nrS0mL5R1QFJ4kxH+UYkqj3UX0QNlF05yYXz3Gz3quHrCPSrRDcDOLKthS1
         zkhFrXcPf714PT81+acA9mO+TbKnDeAhs4Drq9La16hgFDa5qLgC/FSGPBualxouu7Ot
         Rn3LXA25AOWbxLJKGWysqPFIy/7gRTFQVvNhQEUGfiE4/2O7NGeg4bGf3QwwhFjLX7Bn
         AIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710870625; x=1711475425;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=90Uve//wIswBhTh9MRoH8u7ai/wsqyznS8g3f0fG1ps=;
        b=XMtngchyAHYSP892dl7UtIUwpfYFNSccH3XegyAKEWgG7bYNfy8LkkxvNvLcqDsA6K
         CtdwTiie37EiLFy0OnajME+eGT0d7NvFI5D1+JWGyBSwKUz9HS4axk2700bFA/hUVmPj
         ZojzOm72h68VLgBjKX/oQBYKdMmV4P6ohaLBtzhf8aYLyBln0EDIC059KC2rRo574Vf7
         9xmPo+Jb1i53y8Pn3plQ2nEvS+d5meVpRNLPeDB2LA/JgMnri9meWo6uJr2MbPA5KFjP
         mQt3VATL7kCPKrVutL+Bf/J1+80AJBp5/HkVyFLyQFjVwc2VxaAzFVycOGLj2Pq9duaI
         kGTA==
X-Forwarded-Encrypted: i=1; AJvYcCVQU0ZWUpGwPRIhcfNqiBaBkKcVuXx7ILvof8KlxRPXQNiu1qan54jCVerZlwuUOVynj/bvyLjOrGfqpfKL8A125WqpkGBc0Ymj49+k
X-Gm-Message-State: AOJu0Yz8QBy8un8LAmbOCzko9cam0ou9DKjJxtIUJ9zOAe0Ci03JJ5au
	+ryUaIw6euzz2K6BsZUWwQ0UEhmE/2Hm0Yb1841urUS5QEFVXaAz
X-Google-Smtp-Source: AGHT+IF7vuhT7/C4Fxt4OmDcbKvKSoBM91Kwo4Ruhq+2j1nPzidv7MHrmILAqwkpq6LYy5E38Gxm7w==
X-Received: by 2002:a05:6402:500e:b0:567:9fef:f7ee with SMTP id p14-20020a056402500e00b005679feff7eemr3011457eda.16.1710870625386;
        Tue, 19 Mar 2024 10:50:25 -0700 (PDT)
Received: from ALDERLEJK. (89-76-44-138.dynamic.chello.pl. [89.76.44.138])
        by smtp.gmail.com with ESMTPSA id et5-20020a056402378500b0056ba8b68505sm84329edb.92.2024.03.19.10.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:50:25 -0700 (PDT)
From: Kamil Kasperski <ressetkk@gmail.com>
Subject: [PATCH v4 0/3] Add initial support for T95 TV boxes
Date: Tue, 19 Mar 2024 18:50:21 +0100
Message-Id: <20240319-add-t95-axp313-support-v4-0-6204b6d23229@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAF3Q+WUC/43NwQqDMAyA4VeRntfRNmrrTnuPsUMxVQvTltYVh
 /juq8Jgl8FO4Q/ky0qiCdZEcilWEkyy0bopR3kqSDvoqTfUYm4imCgZ8IpqRDo3eS4eOND49N6
 FmVYdoFZNUxtEko99MJ1dDvh2zz3YOLvwOv4ksW8/pPxFJkEZNaAYCMW5rNS1H7V9nFs3kp1M8
 B8DmWFYQydbAQjym9m27Q2ElnE6AwEAAA==
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

Changes in v4:
- change wifi pwrseq node name to 'pwrseq' in sun50i-h616-t95.dtsi
- replace vcc-pg-supply value to reg_aldo1 in &pio

- Link to v3: https://lore.kernel.org/r/20240317-add-t95-axp313-support-v3-0-0d63f7c23d37@gmail.com

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
 .../dts/allwinner/sun50i-h616-t95max-axp313.dts    |  84 ++++++++++++++++
 5 files changed, 201 insertions(+)
---
base-commit: 4138f02288333cb596885e9af03dd3ea2de845cb
change-id: 20240315-add-t95-axp313-support-5f3da8996edd

Best regards,
-- 
Kamil Kasperski <ressetkk@gmail.com>


