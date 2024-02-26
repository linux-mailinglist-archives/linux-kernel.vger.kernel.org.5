Return-Path: <linux-kernel+bounces-80694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D35C866B5B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:49:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACBAA1C227B2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 07:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B45B1CA91;
	Mon, 26 Feb 2024 07:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZzhwEdk"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A95FD1BF33;
	Mon, 26 Feb 2024 07:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708933733; cv=none; b=u6S5eXRK2nIP1P2hOapyCDTn78vG1eyR0OzG3s8dcvNw0wG8ljxuljONPgincusZ9GEtMeybkax8T3neVfK3mToV0AJI386Bxv/gdS0kCxL//NnfCzajoW7hUD0ZtRegyRIepICFlfonVtmwEVjtw+m58EWTnEsLJG3eEH9BMsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708933733; c=relaxed/simple;
	bh=uP0MS5a00nAzP+9tQ+LCTr4sG1JbDOljmNcqcWIv+C0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IzOeDN4JYGVlxU1kK1TEY4nkH7mxhk7RvyzOSbIQScDKJZ41IqeclZeJh5GbrjMJn/yEZZX216w4lfVSo6ZzZLVKOsTMDjwYFYt8cPSE5BdZL+XqW0ZIMkzmhz/FzCQH8m7YHl1CbN0hzTfXWZ4DbJQJsC4DCvkBz5l4taAOYrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DZzhwEdk; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-412a390347dso6039785e9.3;
        Sun, 25 Feb 2024 23:48:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708933730; x=1709538530; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kBudS8pduB+JnQNCiuQyA0sgsK2wbQ0gKDhX+xdHCYQ=;
        b=DZzhwEdkCdvQ0fzOFBI664mgVC4aRvNxflJJUePWOZMXIfZkp0Q0zs88MAzSzStR8S
         FSf92xEuvBB6vKQH3xaKDRugHbXvzvgtrxaZJdcQNbiyuK+V6NuVOu8f9gfsvy7XdC0n
         9mrZpYmj+7Ug/Wc+qfkxfGrOlVh6JHF3AvseI7yD1IyeFxjVLGTe2gJfPxDYh4Bq/OFs
         Jj6G83tyzLlVdHTx4004cyKe+RxfK6LlNaXJw5SnyUSFSjBf3Vy8La3N38MiW55UsWej
         NknmN+v1hxS2EDApBdX1kAZ1nVdRnXLKvFaTiJyCvDMRAJwz8IAM3WKDaHxzoKa8usQo
         Qzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708933730; x=1709538530;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kBudS8pduB+JnQNCiuQyA0sgsK2wbQ0gKDhX+xdHCYQ=;
        b=RTRlGyMux7uPkDtBsIFcr05PvCUkkOtRu2TTFDXGHwWytLE67tB/+5CJHcIZ3aG8jP
         xAIbmv66THLTHitXS3SdPvMCw0aAXd0ch30BY5i6Q164AIebCBTUvbMZTVqR/WnkKUSQ
         qPRdbWFdLp6r56fUEl4hvJW5Y5ileLsspBuB74avMXDe6oQduXkZfKeeXrsXdBG+PyaO
         I0eZG40nVJFcjJFAbxTqQKUZbsDzLN+Os7O3hn+bKMo1oiu20AVkwDmRjHtojZS9NSP+
         WAJsuxvqdCCFPo7A6dW89BxMbWzdlQYJdiz0imMzVxEkjE/gDhuqZbHFmttS1g+Yr7Cw
         8X9g==
X-Forwarded-Encrypted: i=1; AJvYcCU24UB31OAQGHrA68qAasqEhFOTAnHQlmY+LY1d6EWspVZJ/of9GgLEuyjQtAkB4A/DaT9EMkH7tdNlrJVb0S0CWXIG1WDmTnnKuPYLyrbc2ju6/H+pGDXlqdSE08O9as5rgFdZN4kWHQ==
X-Gm-Message-State: AOJu0YzOXiTBsRxIjz+t2scwh+wlY8AF/U+WXekcIfEWkIIxN0q8fW9k
	9vmCI8l6vJ0zlEj2wTNGFcJ68LiIZv+5oEyeyv0Pat0OOWsLeNQxQ6/cJm/F
X-Google-Smtp-Source: AGHT+IEXcDk7P9a8aCttVoCtQxLZ0Uzp44RGGS8NQoqbv9ZdSzUiG/XAntntAmTmivSIdul1erLtDg==
X-Received: by 2002:a05:600c:1989:b0:412:9c29:e6b3 with SMTP id t9-20020a05600c198900b004129c29e6b3mr4401757wmq.12.1708933730141;
        Sun, 25 Feb 2024 23:48:50 -0800 (PST)
Received: from localhost ([2001:861:3385:e20:6384:4cf:52c5:3194])
        by smtp.gmail.com with ESMTPSA id l6-20020a1c7906000000b0040fddaf9ff4sm10995788wme.40.2024.02.25.23.48.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 23:48:50 -0800 (PST)
From: Raphael Gallais-Pou <rgallaispou@gmail.com>
Date: Mon, 26 Feb 2024 08:48:39 +0100
Subject: [PATCH 2/2] ARM: dts: st: add thermal property on stih410.dtsi and
 stih418.dtsi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-thermal-v1-2-8b03589ece73@gmail.com>
References: <20240226-thermal-v1-0-8b03589ece73@gmail.com>
In-Reply-To: <20240226-thermal-v1-0-8b03589ece73@gmail.com>
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


