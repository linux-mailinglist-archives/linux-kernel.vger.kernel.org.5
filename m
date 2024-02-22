Return-Path: <linux-kernel+bounces-76095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 287AC85F2DB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:25:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C90F1C22906
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796821B59A;
	Thu, 22 Feb 2024 08:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D10juOyo"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F931B298;
	Thu, 22 Feb 2024 08:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708590334; cv=none; b=tzGFK7SFRzkyJf6Wsb7CrB8hQPIDAXQbmZkCI4BL5cJvvZi96IkUrYRGLgKQXs7xHzbI/jS/dOg2uppG8PnqGm44sCpyg9WoPfhMQae3fsyJfhlS1dCvWjIrGVb+V3jF30G/qB/OjnRGMwzyVwwI//Jw8jWo50op/4mxx4pIcB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708590334; c=relaxed/simple;
	bh=wLPDt9thh0VhahyURR86SOYCNjG+rD2ehy3AqVby9eA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YsjP+FVOs2zzvup+GeLIcjTU0b2CilCApnx1IwDec+lg23ZFM28aC1KXKLSX7DMZ/FqnnRRwtd5h1JkvWNe2Of5Z8dqNs3ww/JAVszSLRpXUYayTx94DRTxRV3bQhY+2ezu5Sh3wrH5Vbr4zYvTBhlqorwogdcpauM/GupiGMsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D10juOyo; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412730e5b95so15441405e9.3;
        Thu, 22 Feb 2024 00:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708590331; x=1709195131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D5emx/U2oYhPeHt5StfEB6Fse+tRMmiJLxAKZrtTj2k=;
        b=D10juOyoaPliiwONicdYzbkSz4fB2kiNGsspVb5BrjsE7wAtjsGSSLi7cET9XN6Q2q
         4xKr+S3HpQiaJ0aMo5MGkEi678rI6nd6Z9D4LO2QPsAsuakyyzuNZ/6c3CeU+bph7Fst
         c/+NEZ3x65/RzmjG3Vyz6zbMhkdqORvHVlVQIV3ymxZPNC5XWa2RTO7H5xRJti4AAG3v
         xivfvND4hfNtIanS1PeXGCvIivLp30xSVyDNp1Q0Z1EXw6W0VNKxzYNBiR1LK3VFgEFo
         66sRKOCpLuSbBk4uYFkSQrtm3uwQAwTQmhr1dFBWfeXLntqFaXr8LwapssfWkSkldQJg
         W26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708590331; x=1709195131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D5emx/U2oYhPeHt5StfEB6Fse+tRMmiJLxAKZrtTj2k=;
        b=cLS1HB0aTBPtQYIjVKYs4N9sNbvWv4DnZuYcbUcck6Mvvn6Hguv0Z45hUcj3aZSJMw
         DkUBd6a+8+Pgfs4fKpDZxU0jGGNajdmUKAachCC+e1fXyR23QSEDKfgGvobvb56TYZvh
         MSGb2bf743T7dxBAPn2so34MoE7cw10iIwWY8/wb9L1+M0sC+LSwo/i2CD9OS0U38QAc
         Y3VLnmRuqpiBRWOOMqI4QXutXh0P/0QBnUaciF9ixY2OTNiHT7UUb/0VdNywX/RND/kw
         blGsDVtJQhRNWz1KJ1H3x+qknUtfYezsNBRNUxkAXAbQUcwSZnJZ+iM9kxNSHh1J4FZy
         dI0A==
X-Forwarded-Encrypted: i=1; AJvYcCXF6CF12j7tNgIWYeVfqMYVGmjGKZKUvVvBhssvs63rLzfBGtd40/s16aUv9O5pC/P3XbV3SIsALgZ316aCB9tE7BqFvB+XNdUvP7u2dDqzHr8Drrgo8Lca0lOwZmaSICsPlQAYXNxD2g==
X-Gm-Message-State: AOJu0YzDlztfqRwc8x9MGZwVx4FObjURz0T/9IJ5UHKvR7pqt0YmnnTC
	Hz6BlNcmr4aP5h8qPmXqeg/N7DKT+FGRQua5QGxm78pRQ3N/MCdB
X-Google-Smtp-Source: AGHT+IFG7HpvoJfvcho61ZilkRh4f43EQKTRBGVQohjbw13VTUNFyeF+ZKY8ZpAdb6cG9jZdIBAEPg==
X-Received: by 2002:a05:600c:4711:b0:412:64ea:8f3d with SMTP id v17-20020a05600c471100b0041264ea8f3dmr8386573wmo.41.1708590330899;
        Thu, 22 Feb 2024 00:25:30 -0800 (PST)
Received: from localhost.localdomain ([90.255.110.157])
        by smtp.googlemail.com with ESMTPSA id o20-20020a05600c4fd400b00412590eee7csm18155822wmq.10.2024.02.22.00.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 00:25:30 -0800 (PST)
From: Adam Green <greena88@gmail.com>
To: Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: greena88@gmail.com
Subject: [PATCH] arm64: dts: meson-g12b-odroid-n2*: Add support for overclocking Hardkernel ODROID-N2 boards.
Date: Thu, 22 Feb 2024 08:25:23 +0000
Message-Id: <20240222082523.1812-1-greena88@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hardkernel actively supports overclocking these boards in their own
documentation. (https://wiki.odroid.com/odroid-n2/hardware/overclocking)

This aligns the SoC opps with those in the board vendors bsp source.

Signed-off-by: Adam Green <greena88@gmail.com>
---
 .../dts/amlogic/meson-g12b-odroid-n2-plus.dts | 25 +++++++++++++++++++
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dts | 17 +++++++++++++
 .../dts/amlogic/meson-g12b-odroid-n2l.dts     | 25 +++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
index ce1198ad34e4..1731d542a00c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
@@ -15,6 +15,31 @@ / {
 	model = "Hardkernel ODROID-N2Plus";
 };
 
+&cpu_opp_table_0 {
+	opp-1908000000 {
+		opp-hz = /bits/ 64 <1908000000>;
+		opp-microvolt = <1030000>;
+	};
+	opp-2016000000 {
+		opp-hz = /bits/ 64 <2016000000>;
+		opp-microvolt = <1040000>;
+		turbo-mode;
+	};
+};
+
+&cpub_opp_table_1 {
+	opp-2304000000 {
+		opp-hz = /bits/ 64 <2304000000>;
+		opp-microvolt = <1030000>;
+		turbo-mode;
+	};
+	opp-2400000000 {
+		opp-hz = /bits/ 64 <2400000000>;
+		opp-microvolt = <1040000>;
+		turbo-mode;
+	};
+};
+
 &vddcpu_a {
 	regulator-min-microvolt = <680000>;
 	regulator-max-microvolt = <1040000>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
index a198a91259ec..0c71e8bc0124 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dts
@@ -13,3 +13,20 @@ / {
 	compatible = "hardkernel,odroid-n2", "amlogic,s922x", "amlogic,g12b";
 	model = "Hardkernel ODROID-N2";
 };
+
+&cpu_opp_table_0 {
+	opp-1992000000 {
+		turbo-mode;
+	};
+};
+
+&cpub_opp_table_1 {
+	opp-1908000000 {
+		turbo-mode;
+	};
+	opp-2004000000 {
+		opp-hz = /bits/ 64 <2004000000>;
+		opp-microvolt = <1022000>;
+		turbo-mode;
+	};
+};
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2l.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2l.dts
index e26f3e3258e1..b16a69d0cad6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2l.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2l.dts
@@ -97,6 +97,31 @@ codec {
 	};
 };
 
+&cpu_opp_table_0 {
+	opp-1908000000 {
+		opp-hz = /bits/ 64 <1908000000>;
+		opp-microvolt = <1030000>;
+	};
+	opp-2016000000 {
+		opp-hz = /bits/ 64 <2016000000>;
+		opp-microvolt = <1040000>;
+		turbo-mode;
+	};
+};
+
+&cpub_opp_table_1 {
+	opp-2304000000 {
+		opp-hz = /bits/ 64 <2304000000>;
+		opp-microvolt = <1030000>;
+		turbo-mode;
+	};
+	opp-2400000000 {
+		opp-hz = /bits/ 64 <2400000000>;
+		opp-microvolt = <1040000>;
+		turbo-mode;
+	};
+};
+
 &eth_phy {
 	status = "disabled";
 };
-- 
2.34.1


