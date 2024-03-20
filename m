Return-Path: <linux-kernel+bounces-109438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9422E88192F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 22:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5CAF1C20ED8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 21:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32B998613E;
	Wed, 20 Mar 2024 21:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NueZmtsN"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D947385295;
	Wed, 20 Mar 2024 21:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710970438; cv=none; b=ebi8F6Y2eczxjDngjekn4cKSoj+gzTiEb2XCh2z7Rph2omlO14grwfu9ZLrkrRbwoMWFjWh6nuVXnFMLwLWuLlCePco1V7B2O2ju5f0wI63RS2qcd9yOaXHg2Z7U/tceCBjF+m3+eC8MUHBxo5+v7o2x6z325rtoMGvsgqMQz6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710970438; c=relaxed/simple;
	bh=s5E1qvSYEd/GOc4QJBEGVXbenNJCECzx/wZu8bTdnTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B/RD1CAmtbUkHIELEjHB+93gdf0amND33knapE2FEBgluAIUxic9ZigRwB2FDjm+2N7V3Y2a7fcVc42UC6F1NQjrBo87hgGPQMWtSXBGWHdrRrUPnpyWhqEVF210FqgGrn7dK1Ek1sSKiteLMlPWplwIlcBv1RiTNl9CLf3CGjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NueZmtsN; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33d90dfe73cso201765f8f.0;
        Wed, 20 Mar 2024 14:33:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710970435; x=1711575235; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zO2E2GClWBnOraTMVHKXlSY8ldIuEQRndWqb5IE+w6c=;
        b=NueZmtsNvZNDo2HEGPWFwtpLDA4b9ljtwOrsmIGclXkxxJOcsgJXi74t65g7ukXvTo
         FyHzmWfi4LzTzpODOkQUa7fcxHdI23WDo2Jgpp27IxWEiU+A5EoFN4tjHjNce4clvjEu
         bMafXOQUAr+EpWo9g2PsS/bnKeMIk6JeCxy9fI1/S91v4Am4aQmEG0biHWbC5YB0iLvo
         xjDDTq0eL+BaErdsMj9r8a6APq/EyC2GQxBMOMTBv78lJ1xdorpeNSEVvlPqrm3tIiO4
         Jxma5r6wDRLUCwqw9ISWZKezkxWSZu2uHiiA8C2MJvX6EYxO3AaexaxTTTbYueJYrq57
         CQyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710970435; x=1711575235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zO2E2GClWBnOraTMVHKXlSY8ldIuEQRndWqb5IE+w6c=;
        b=FT4bq1ZquAEvcBicdbkIKBVE6TpXutuGqyVVfB5nwAaXc821AfLmM5LGhSuuU1Q4Yt
         6j4tZgKsUBLbXEUeDDybmOCoggCQzDnCCkY9Uw9zBHjnilwO3MiGHoPYkdbq53sIIH3W
         caPFi9eFve1dLvkFRwR90u9h2DYtdzerrr3AJP+1j4Jr9jidTCvVHAPvMPZa7eIyh6i6
         4obfgiblJmpM75Z9VNypmW0wGMunulBCZ7Pg3p6/KcNzLD1iSyocppkkMe3z3GB6+8wh
         M7ZPnkQka/4yeJibEaZ+82X4sdMGAymzZuM4dRVZbFBTesXA9HYK9fRQtpIgsgJT1OwN
         L0Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVxuM/MzLtlMa1HcLCU+w8jRHZpDoGHjxkqz2OjPvMOTM0XztONwytTOtQcyGZg0ADBaB5D5P7ACsM+T/ortpCz+LwGNzKIPAtISOYLbPyNf8JZorZvcFv7pScux3O+QY1iKq71DQcdyw==
X-Gm-Message-State: AOJu0YzNIhAD7iUGhmHCvPSBYQ5SE6OSyVvg1prdJ2LK9Ub5ZluSKZop
	o5LH44lwg1LzKbdgvqfWyX6VTWkj/QhWSspOhaibW6hF7lW+cIgOE0YYjL9aHgU=
X-Google-Smtp-Source: AGHT+IF+yCzfTSAs0Xl9quHvnFnE2sf/uloR005a1iCcsM2w0FKXj7jsilFC2RcBCO19mN7UBryDrQ==
X-Received: by 2002:adf:e6c9:0:b0:33e:5970:e045 with SMTP id y9-20020adfe6c9000000b0033e5970e045mr730314wrm.21.1710970435237;
        Wed, 20 Mar 2024 14:33:55 -0700 (PDT)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id a5-20020a5d4d45000000b0033e03a6b1ecsm15547567wru.18.2024.03.20.14.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 14:33:55 -0700 (PDT)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Wed, 20 Mar 2024 22:33:49 +0100
Subject: [PATCH v3 2/2] ARM: dts: st: add thermal property on stih410.dtsi
 and stih418.dtsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240320-thermal-v3-2-700296694c4a@gmail.com>
References: <20240320-thermal-v3-0-700296694c4a@gmail.com>
In-Reply-To: <20240320-thermal-v3-0-700296694c4a@gmail.com>
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
2.44.0


