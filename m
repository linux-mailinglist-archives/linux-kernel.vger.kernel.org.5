Return-Path: <linux-kernel+bounces-88860-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E7286E7A4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70A861F22A37
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4482556F;
	Fri,  1 Mar 2024 17:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kEwFpz7z"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1466A8C1B;
	Fri,  1 Mar 2024 17:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709315256; cv=none; b=DaZhMJuousYJHfIqwm7UsnP7PCjzHq28EMA60UI04RsC/Yoo8RjdFc5YBeMeQ0yyGVPyiLBThcA8Gt1/ZcF/lJqAy30v4ybbFiWtXT5OjeoiwqrTmrpeS6abWnkei3tna8rO/moIHrmYpRaa1UcKvNkEN5PKRyPfGgj+du/t2wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709315256; c=relaxed/simple;
	bh=uP0MS5a00nAzP+9tQ+LCTr4sG1JbDOljmNcqcWIv+C0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M74IPbXLrJMKEajEnwsaaQOfvk4MURBjF8QeH/YlWa8ups99BgWH3LKYxXLNjg3Bu6VIMYGDCQ/VDBGlLSFVTZSs5KHX+aRwmy63N8CVk42O8inCKPimQ366ZrKODwncQVRYODLKTSy9LaZZpU6Y3v/uTgczNdgUVmgxw18L5dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kEwFpz7z; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412cb60ac7aso3714495e9.1;
        Fri, 01 Mar 2024 09:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709315253; x=1709920053; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kBudS8pduB+JnQNCiuQyA0sgsK2wbQ0gKDhX+xdHCYQ=;
        b=kEwFpz7zyF4Fzc6LkkWAV55HquVjUgZ0jaEszrLJQy2EOudfFDRN8MmC7KIP92rowM
         dcDgQAwNU6fVRkTC1KUOQQ6kDdn8DkgTRvhoBR7+UKsB7m3uJ5WviLGtUjOZavPR6iGy
         a1evu3lRfcPmuFoI5yuE3RGgkG2zyOssC7jTniqQms77/SzjQfv2tqy5qmf6SHw6RgLP
         YlrDZcLHq9+jZmcIvRbi3G1tZnBAXH3JX5E9MBcZBUzppe1c0uoerlOqaHwO/cBmp+9k
         4thC5v1DgfvPJSilPT33tr0Ad20y/Teji/Yh0dpi8erqnnE0V1VY9gltcfr6jx69bKV9
         cEIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709315253; x=1709920053;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kBudS8pduB+JnQNCiuQyA0sgsK2wbQ0gKDhX+xdHCYQ=;
        b=fMdLk/05VyjzLZB21LwvuDvgjicPogj63GWV4KCxoq+5OPaQlffhxpXmjR/+yGkjZi
         bTFAxCFJsFInUDHxAPUNDtWPDn0qcuIvbzdVrF8aeAlFv7pU/0MhpITEdn7z9jtqr0lB
         zBx0n6o+pjBSasEV9yHOIzTKqqdZb2Ur+sOdERIsuf7yUc21RW5pMFMEY/F693idYg+v
         nvM5za93JSAu1D66UF+pd9itrIYU/x9uKjQtfsHejiTWwd1K7DzHnhlgUyRCWE6gfAam
         DTkUv5mkDlK2Q/Ga1gAaRibPuE/pKQvu10FrxH3Jd7qzXCJVbyFwsnFYaKVtcOkj3w8M
         RHxw==
X-Forwarded-Encrypted: i=1; AJvYcCUsf2o6702MvW8uJdzaoBME6A78NmyGuR2JXZfnIkrH0ZvDIMal9D5MduNaXK/ckvbNXzlJ+WsYf2wgTdZ/YkWkgwmWV7w+L58xbdibrPslpWFaHh3fB3Gtud/XtLGG4BPMTna5y1MiZg==
X-Gm-Message-State: AOJu0YySZP5GzB1c75NmXfgag4V5SXDaOa5aEwf7Uoyc2K5B8xqa9ugP
	MvKxV9e5Pb5pkvpLlU16dgckaQ7ZHm3m14CvbVOKiPE7DDkoKWHu
X-Google-Smtp-Source: AGHT+IG6sgBestRPxfhvYAGndynjIIz7DR2FrxGpqOAtytLHPLZ9H+YT0LBkU27ikJawlDPjCVBBeg==
X-Received: by 2002:adf:f6c7:0:b0:33e:1e0e:69a with SMTP id y7-20020adff6c7000000b0033e1e0e069amr1955278wrp.13.1709315253246;
        Fri, 01 Mar 2024 09:47:33 -0800 (PST)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id h18-20020a5d5052000000b0033cf4e47496sm5061786wrt.51.2024.03.01.09.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 09:47:33 -0800 (PST)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Fri, 01 Mar 2024 18:47:29 +0100
Subject: [PATCH v2 2/2] ARM: dts: st: add thermal property on stih410.dtsi
 and stih418.dtsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-thermal-v2-2-1b32752029ec@gmail.com>
References: <20240301-thermal-v2-0-1b32752029ec@gmail.com>
In-Reply-To: <20240301-thermal-v2-0-1b32752029ec@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Patrice Chotard <patrice.chotard@foss.st.com>, Lee Jones <lee@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-Mailer: b4 0.13.0

"#thermal-sensor-cells" is required and missing in thermal nodes.
Add it.

Signed-off-by: Raphael Gallais-Pou <rgallaispou@gmail.com>
---
 arch/arm/boot/dts/st/stih410.dtsi | 1 +
 arch/arm/boot/dts/st/stih418.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/st/stih410.dtsi b/arch/arm/boot/dts/st/stih410.dtsi
index 29e95e9d3229..a69231854f78 100644
--- a/arch/arm/boot/dts/st/stih410.dtsi
+++ b/arch/arm/boot/dts/st/stih410.dtsi
@@ -270,6 +270,7 @@ thermal@91a0000 {
 			clock-names = "thermal";
 			clocks = <&clk_sysin>;
 			interrupts = <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells = <0>;
 		};
 
 		cec@94a087c {
diff --git a/arch/arm/boot/dts/st/stih418.dtsi b/arch/arm/boot/dts/st/stih418.dtsi
index b35b9b7a7ccc..0f0db988a907 100644
--- a/arch/arm/boot/dts/st/stih418.dtsi
+++ b/arch/arm/boot/dts/st/stih418.dtsi
@@ -113,6 +113,7 @@ thermal@91a0000 {
 			clock-names = "thermal";
 			clocks = <&clk_sysin>;
 			interrupts = <GIC_SPI 205 IRQ_TYPE_EDGE_RISING>;
+			#thermal-sensor-cells = <0>;
 		};
 	};
 };

-- 
2.43.2


