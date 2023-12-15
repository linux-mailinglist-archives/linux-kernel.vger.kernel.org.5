Return-Path: <linux-kernel+bounces-1113-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7781814AAC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:40:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4200D1F21D19
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 261B436B17;
	Fri, 15 Dec 2023 14:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="JveIQFn2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D72F358BD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 14:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 3CB0D3F2BA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 14:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1702651154;
	bh=RobAsopvkyaJG4ZlGH6Q+ihyPFqhE+HxeBCHD/K5fRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=JveIQFn2hQtiyEGthTh3fz27PLBh02oceELhU88h2YjgRTXCJYOY0JUZ+vYeU3i3W
	 d8ToUf4a3ADU9cvRYxnL7sp7OnVFU+kdzfBlHhAXj/cLKY+DhCgEklXlR5MiWV1IQG
	 K4OTjk1gGeDQNunql/fABmy0Pt9168sPtJz8DnDnLSium2duC9Ysvaz62cTPyo3uNw
	 qRoCmrbIQLAeRFfO0WNhWAZVi7u1RsihmSVxcBNt8p4vCHJilN+ACd0DdzB/LUd/GQ
	 6wBgNRZ090lYheME1O2MGw6c089o0Cz3wcVzR3C5k9dcd26eJTENBpHPvZFZLb4Kwe
	 ywC/z0ICQJ51Q==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9fffa4c4f28so28484766b.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 06:39:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702651153; x=1703255953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RobAsopvkyaJG4ZlGH6Q+ihyPFqhE+HxeBCHD/K5fRk=;
        b=c457mgBgjvJ8NnQm1S4kBNmiQYWnWhVPlc1RyB1E4MCSwWgAYc/cQ4O8nRwn8UVhmU
         gYlrZQcCXRXMVFZ5k6y/k2GOmqd46ACRmbZqdE71hcBybcR3WaQqep/1L5UA+kninAvx
         7tVXYiPkhwpddyUWlbZBdb0FtR/F6FjXxSMDNB1/9QQhCEBCLjhsGQx2pA/KDgt22aox
         LCFGPaZsEFpmJb5orPaV9MlNgSsVeeyZ2DXMNcGTTIv3+3epjWiuY9Aj6mVP9sJmoXAM
         60OslimpLxMKhOUVje/LiODNi3zg+bBiBKeR94lED3oThL9nbd+bVjzSuN2LeFguih24
         IQEw==
X-Gm-Message-State: AOJu0YxeVgCGhOE6nK3ktDEXHWVtXDzE4ZWpFqfVTXw9jBUFRNrO43jE
	4y64ADcMKgbyKidZFbkT2P6l70iQ+3XqXVzHj/KheF/lv3YkE2jAYiUdv7fo7xbivbazswA8/8O
	rBBIfX5hBRtqyfIxe2c+se7DZbls1b92MRSmmCsyiEw==
X-Received: by 2002:a17:907:9714:b0:a04:bc39:c1c7 with SMTP id jg20-20020a170907971400b00a04bc39c1c7mr8341365ejc.36.1702651153751;
        Fri, 15 Dec 2023 06:39:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMJ/XNk1OcnlxBlTONG8qxR+NbDMfjb9FP+RE/bMN9YTONgYiMhiDoaYwky2i3vk37hslVhA==
X-Received: by 2002:a17:907:9714:b0:a04:bc39:c1c7 with SMTP id jg20-20020a170907971400b00a04bc39c1c7mr8341347ejc.36.1702651153594;
        Fri, 15 Dec 2023 06:39:13 -0800 (PST)
Received: from stitch.. ([152.115.213.158])
        by smtp.gmail.com with ESMTPSA id tm6-20020a170907c38600b00a1db955c809sm10789122ejc.73.2023.12.15.06.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 06:39:13 -0800 (PST)
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
To: linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Cc: Hoan Tran <hoan@os.amperecomputing.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jisheng Zhang <jszhang@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Fu Wei <wefu@redhat.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH v1 3/8] riscv: dts: thead: Add TH1520 pin control nodes
Date: Fri, 15 Dec 2023 15:39:01 +0100
Message-Id: <20231215143906.3651122-4-emil.renner.berthing@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231215143906.3651122-1-emil.renner.berthing@canonical.com>
References: <20231215143906.3651122-1-emil.renner.berthing@canonical.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add nodes for pin controllers on the T-Head TH1520 RISC-V SoC.

Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
---
 arch/riscv/boot/dts/thead/th1520.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/riscv/boot/dts/thead/th1520.dtsi b/arch/riscv/boot/dts/thead/th1520.dtsi
index ba4d2c673ac8..397d5c71bd3d 100644
--- a/arch/riscv/boot/dts/thead/th1520.dtsi
+++ b/arch/riscv/boot/dts/thead/th1520.dtsi
@@ -242,6 +242,11 @@ portd: gpio-controller@0 {
 			};
 		};
 
+		padctrl1_apsys: pinctrl@ffe7f3c000 {
+			compatible = "thead,th1520-group2-pinctrl";
+			reg = <0xff 0xe7f3c000 0x0 0x1000>;
+		};
+
 		gpio0: gpio@ffec005000 {
 			compatible = "snps,dw-apb-gpio";
 			reg = <0xff 0xec005000 0x0 0x1000>;
@@ -278,6 +283,11 @@ portb: gpio-controller@0 {
 			};
 		};
 
+		padctrl0_apsys: pinctrl@ffec007000 {
+			compatible = "thead,th1520-group3-pinctrl";
+			reg = <0xff 0xec007000 0x0 0x1000>;
+		};
+
 		uart2: serial@ffec010000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0xff 0xec010000 0x0 0x4000>;
@@ -414,6 +424,11 @@ porte: gpio-controller@0 {
 			};
 		};
 
+		padctrl_aosys: pinctrl@fffff4a000 {
+			compatible = "thead,th1520-group1-pinctrl";
+			reg = <0xff 0xfff4a000 0x0 0x2000>;
+		};
+
 		ao_gpio1: gpio@fffff52000 {
 			compatible = "snps,dw-apb-gpio";
 			reg = <0xff 0xfff52000 0x0 0x1000>;
-- 
2.40.1


