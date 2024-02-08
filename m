Return-Path: <linux-kernel+bounces-57900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 647E384DECB
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFD11285BC9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C5B71B3A;
	Thu,  8 Feb 2024 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YXd0hQMb"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207FD71B25
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707389545; cv=none; b=aHQ+vdYM4fMGIUNWT7JuHSsNRhgLmyihCVbSALObcR9y8nCTFx4Xo7dH7KXhZUIKxjziP5qcusEW5J518bsi5XdbN+C8I8nA28jNrINS02UDLe72TxlDzIljVRdYcrUP89H6w8WNWvocHHFrAsPPKh9AzByejzlSfRsf263Uf7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707389545; c=relaxed/simple;
	bh=k7KlLAM74mtRXmGluXHTGtPFb6smigMM6Sfa5RFt3lU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Xckex9Dn0NUPNCxwbelskgMa0FLqQyDDas4490j7hbopV+1jBYvqOiMxXMAS48eRx0AqBrPULd9e9qtf9D4LQPc7xAB5frxihnGO0fBxyYgh4/AhXyDT70O2QQXXo4YXj8xZy6YXQctf+jpGTbaUzWCG0wD8bUNW9qn28miBHi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YXd0hQMb; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40fc22f372cso13936785e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 02:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707389542; x=1707994342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=smSo7VSgJLNAbISWU6mt+SaBuWP5qaKLkVu4Ojrrp3o=;
        b=YXd0hQMbnphxHC3VgnGC/1myzUfuIijsArVvLRqVGsKquuJ0r1aAHKV8uUbV69rcda
         QntAQIDsELSL23mxm52Im48FNBWvJpi/YjyC2VIXK0d/zhEtjsYBfXSIci36vIvawf6u
         0gdQ+HLVHpWD4eg4HHwIemJ8hePpHqAqvAhvzUHVgCm9Ju8dmKBeYFjX/8FQDAhp7yEI
         HjnzzFeXpp9OHNOS6K6jhJRxk+kqjHby090C+WvIJbWCz9mPzFqdNL66QWkqIQzug9vm
         OqQNYt2a4XmXTePGIIGeDFPZecrm8/TM5C1iQaNcLZicKszW8GX5EOloVUt4Wqu7N6bx
         JOsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707389542; x=1707994342;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=smSo7VSgJLNAbISWU6mt+SaBuWP5qaKLkVu4Ojrrp3o=;
        b=I8XJrflR9Rjx4HnbblpixYYCbY5NylFNzc2v3xhwcFU4DKyKOmcF/E+YVy2jNnJZK+
         xuuZodyEMcUC9mbZmplQs6WNPtuuGX2ioiN3W8odT8p4FC/isAtddWIprRXqNhrWXQfj
         EMzRAYZ97X9n9fr9V/XaiLGmaXVsvlPAYlZhgKPUfhHnDRYldH2tJHnFJ8aWdXdRrPEU
         xaxJ2z04VQbXZXgO2LPKsdoSS+dChz9MEQS1UHr42+9fgC0MvlgQ/JAZMJm6OY1o7ae8
         0oUzi8Iiy+Gix10jpqkKz1eEzhsNTre85WE6MwjUnXGk89NuAc6YfutbcSOen5gYpLFI
         KRcw==
X-Forwarded-Encrypted: i=1; AJvYcCX9vIExG8bZNK1FqgxMJe/+9xEfsIawVe4v6DH8Ma9X+NODBDEK6+FF9/+alRUszNZ9h1qkwBwGHz0+CdE0LEkpCq3NdWOKinaGexiS
X-Gm-Message-State: AOJu0YzovNSpjY2bTnRdl9FdDBQDHQhg7P+ejUjBf3DLXLiebyN0DBWY
	SmNcuCvmFCIMNVflQIBVqsqLYzehpTJLk1hrXwTTxfMSCh+kgTqFpzdtQYvf7BA=
X-Google-Smtp-Source: AGHT+IE8W9OBM/Gv6ShRxJOzND/DCObKC34pGKVZq/mINvLljLAlgrSMTn8tquOchi6JM7gxMstCyg==
X-Received: by 2002:a05:600c:4ec6:b0:40f:d25f:718d with SMTP id g6-20020a05600c4ec600b0040fd25f718dmr6035814wmq.37.1707389542396;
        Thu, 08 Feb 2024 02:52:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWdks/CWLFffQPVEFFoXiAMQlf9pFm5WKlMP2xexqyH267x34CDNWkY87Qv9UXbo2Vg3kVh5GCWkMQJKMvqkxGHpw5GMI/YSvYK0fpkWkufeD9ZB9YzKl56eOaTV4jZU8ah7ZvJqmFi7GqLnhapLG42xfbnh27fumzYyjF+fBRmRxhR9Twx6pm2BFvVBR+g/dqLik0HgPNa9UFa9S9KhIgn9GRDdhn/Ez8sMayJDC3IsgTEnamPh8/qfk+8vq0Oc2AGK9ETb98qV5tj6KEChfsWnEw9BAZFGYg52AO/2aLIpN6+UPKJkHsy1VcC0zVVoFwT3jGUeuz3Ka++KBPeB2CduXPUZKIadP0/8LADnE2vp5yC42cyegyJPyp4v2OkgSBGCHda2w==
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id az6-20020a05600c600600b0040fdc645beesm1266110wmb.20.2024.02.08.02.52.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 02:52:21 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux@ew.tq-group.com
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: freescale: minor whitespace cleanup
Date: Thu,  8 Feb 2024 11:52:17 +0100
Message-Id: <20240208105217.128748-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The DTS code coding style expects exactly one space before '{'
character.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/freescale/imx8ulp-evk.dts | 2 +-
 arch/arm64/boot/dts/freescale/mba8xx.dtsi     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
index 69dd8e31027c..24bb253b938d 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8ulp-evk.dts
@@ -37,7 +37,7 @@ m33_reserved: noncacheable-section@a8600000 {
 			no-map;
 		};
 
-		rsc_table: rsc-table@1fff8000{
+		rsc_table: rsc-table@1fff8000 {
 			reg = <0 0x1fff8000 0 0x1000>;
 			no-map;
 		};
diff --git a/arch/arm64/boot/dts/freescale/mba8xx.dtsi b/arch/arm64/boot/dts/freescale/mba8xx.dtsi
index 6164fefb9218..3b4c5fa21f31 100644
--- a/arch/arm64/boot/dts/freescale/mba8xx.dtsi
+++ b/arch/arm64/boot/dts/freescale/mba8xx.dtsi
@@ -466,7 +466,7 @@ pinctrl_pca9538: pca9538grp {
 		fsl,pins = <IMX8QXP_USDHC1_RESET_B_LSIO_GPIO4_IO19	0x00000020>;
 	};
 
-	pinctrl_pcieb: pcieagrp{
+	pinctrl_pcieb: pcieagrp {
 		fsl,pins = <IMX8QXP_PCIE_CTRL0_PERST_B_LSIO_GPIO4_IO00	0x06000041>,
 			   <IMX8QXP_PCIE_CTRL0_CLKREQ_B_LSIO_GPIO4_IO01	0x06000041>,
 			   <IMX8QXP_PCIE_CTRL0_WAKE_B_LSIO_GPIO4_IO02	0x04000041>;
-- 
2.34.1


