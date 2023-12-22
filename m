Return-Path: <linux-kernel+bounces-9645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CAF81C8E3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 12:15:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49A6A1F22FC4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DD3F17751;
	Fri, 22 Dec 2023 11:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kySwk9Nz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC961642B;
	Fri, 22 Dec 2023 11:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-54cb4fa667bso2197742a12.3;
        Fri, 22 Dec 2023 03:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703243705; x=1703848505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BvelMzmtyu1Sqb0MGaQ3BVDecc44IV/AoEGKsA1SR0=;
        b=kySwk9NzAbdkfRJU0+f48Ue96QJ9P1R0KlziIm64MqncRQEjeEU4+GxKQZ7at7ArVf
         Zh7E+npUe4KuQ/OAaA2VsdR0IBWztA86VTvhiiAOr/2K7aWvpDxugwXqCM7IgXydtahW
         ewsZ5uBGP+Xxv8lO1JZAtob9zRGnYUvugn1j0hjATG40FRAlw4Y8jZz4LRkuJ0/TGv2v
         Uzk2ly3XuUnLKKXhJ9pZogq9KOiwDw1388yn3eIXwVsls3li05sYs8aYXNCaXtbl6+9I
         5nr7ug7bKSdH7Z+9D1exGVLpzzzBhiYTjPMRTX2JI+bJO8Wu7EQXQZ82KEsZzmfbVuyS
         RFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703243705; x=1703848505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7BvelMzmtyu1Sqb0MGaQ3BVDecc44IV/AoEGKsA1SR0=;
        b=tcxcdq6MmVaSpdVTXMOFlyIK//bDNmQfUuPEfi1mITaSuz/snke/hlRuTYksnJ6LSM
         G46TI0CYISmexC/m8GILIYPkF4W3OxPIujSr/RaSjRyEUcJXjoHzXLXMkrreEkdUPgVN
         ciJ3VYRvawjNVUlbIbV0vJd7SyHSe8ufKjoCbaCwn2lA8gwqYOxfBtYLuBjodxMd6Gow
         CfQ9zHh9lvSyo1jRMLUPD3drP2PGGSkTDYIlkP5t0dGFZxbml2thCazO/HsZgR4CHiMm
         utSpTsFc2vLfQR6beC0s9fKs0pKz+60TLsFJJzenCXf5trzFRtkkbtwwd0pSWhheFAqs
         1qNQ==
X-Gm-Message-State: AOJu0YzsrDmxwIvPxFPlPAZS+NP9wiwBhLnuWdUvmSwvWx45J13jYglO
	bzhGMydFXLt71HZYvqj/1tg=
X-Google-Smtp-Source: AGHT+IGWir11b4gGwRl3NO7lj7pMTMBbWgNmeSbRuM9TWOJnnwaniRMrtaZLnxpLWHffPO330BSmbA==
X-Received: by 2002:a05:6402:124b:b0:551:ab9e:53c6 with SMTP id l11-20020a056402124b00b00551ab9e53c6mr575373edw.52.1703243704565;
        Fri, 22 Dec 2023 03:15:04 -0800 (PST)
Received: from localhost.localdomain ([154.72.162.91])
        by smtp.gmail.com with ESMTPSA id es15-20020a056402380f00b0055267663784sm2420469edb.11.2023.12.22.03.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 03:15:03 -0800 (PST)
From: Brandon Cheo Fusi <fusibrandon13@gmail.com>
To: Andre Przywara <andre.przywara@arm.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Yangtao Li <tiny.windzz@gmail.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Cc: devicetree@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Brandon Cheo Fusi <fusibrandon13@gmail.com>
Subject: [RFC PATCH v3 3/3] riscv: dts: allwinner: Fill in OPPs
Date: Fri, 22 Dec 2023 12:14:07 +0100
Message-Id: <20231222111407.104270-4-fusibrandon13@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231222111407.104270-1-fusibrandon13@gmail.com>
References: <20231222111407.104270-1-fusibrandon13@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Specify two voltage ranges, in order of increasing stability,
for each OPP.

Also define an nvmem cpu speed grade cell of length 2.

Link: https://github.com/Tina-Linux/linux-5.4/blob/master/arch/riscv/boot/dts/sunxi/sun20iw1p1.dtsi#L118-L133
Link: https://github.com/mangopi-sbc/tina-linux-5.4/blob/0d4903ebd9d2194ad914686d5b0fc1ddacf11a9d/arch/riscv/boot/dts/sunxi/sun20iw1p1.dtsi#L118-L182

Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
---
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
index 64c3c2e6c..7e2e015e0 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
@@ -39,16 +39,23 @@ cpu0_intc: interrupt-controller {
 	};
 
 	opp_table_cpu: opp-table-cpu {
-		compatible = "operating-points-v2";
+		compatible = "allwinner,sun20i-d1-operating-points";
+		nvmem-cells = <&cpu_speed_grade>;
+		nvmem-cell-names = "speed";
+		opp-shared;
 
 		opp-408000000 {
 			opp-hz = /bits/ 64 <408000000>;
-			opp-microvolt = <900000 900000 1100000>;
+
+			opp-microvolt-speed0 = <950000 950000 1100000>;
+			opp-microvolt-speed1 = <900000 900000 1100000>;
 		};
 
 		opp-1080000000 {
 			opp-hz = /bits/ 64 <1008000000>;
-			opp-microvolt = <900000 900000 1100000>;
+
+			opp-microvolt-speed0 = <1100000>;
+			opp-microvolt-speed1 = <950000 950000 1100000>;
 		};
 	};
 
@@ -115,3 +122,9 @@ pmu {
 			<0x00000000 0x0000000f 0xffffffff 0xffffffff 0x00020000>;
 	};
 };
+
+&sid {
+	cpu_speed_grade: cpu-speed-grade@0 {
+		reg = <0x00 0x2>;
+	};
+};
-- 
2.30.2


