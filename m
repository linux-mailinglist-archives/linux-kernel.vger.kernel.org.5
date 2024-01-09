Return-Path: <linux-kernel+bounces-20642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9C238282DA
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 10:17:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6286B1F22915
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9222E636;
	Tue,  9 Jan 2024 09:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/6ErUjh"
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78967328D0;
	Tue,  9 Jan 2024 09:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6dde290d09eso272241a34.2;
        Tue, 09 Jan 2024 01:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704791860; x=1705396660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXs4eXFLnV8TiKAn9u+8OI+mgIAVMlsd0Rv7wG5W1mg=;
        b=Y/6ErUjhUUps4dMcxH/u2u7JSSzhW6pkwnrXjt+wYA6Ngq7DWyQhrqU359aI6KZbmM
         4JnHkc8aFKo2DExPbQlEhWroNpt/a/twBoxB6Eib0hEHsln3Wt35Q7bh0atoUhs0pFvQ
         77sqEQCSvb8NARo50XHgdOB2apVwPqO7aY4Itg4X/sA4LZQZ5VA9h+zARDAZpl88hv0p
         W3UXc779lK92eLTR2lC0oPHF51Xq+5Jd2CVr+Bivb7dl5DlVGBZjaZpjc58Y8YK9PdL8
         91zdNS3mzM9smOr7LU+BqmH0376Bmz3tPotz0pG1HNmKo2mx13BVpCOmu78qLzEN+bxy
         fo+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704791860; x=1705396660;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mXs4eXFLnV8TiKAn9u+8OI+mgIAVMlsd0Rv7wG5W1mg=;
        b=EdQWfzkXUkHh7KXTjg5rMz3ToUM//DIzG2buJ6a/IC3r0Q/8PHxS0AHkPD4gFyHHUa
         Bd4WVXu1orBBNqBoDlnEL47g7YIRoBsFROv7x1l8ct2pVwGFxigHXo/Z2+x7OjFTNNKY
         cvkSppBcwzzqUK2sa6HJuoX71hOHQsNFpdh+zyhORG5Xsk8P4oM4MT5oIIHO96D+KwPR
         3/UXzKy+yVe6Q25T4nQsbZC30ml/psYkNan0w4my6meZwJMBuFBGB8B+T76f9ePoLPhK
         YITMp8EEpTmJw6pOampOxu8ZRRazStha1Sv2iN6NmCNx3OlBSPgydyq3BbxSItZJvqfj
         n4QQ==
X-Gm-Message-State: AOJu0Yykd3FJwrJopprXkmPnA/Yq13gUCM3d29n2P8MCWOkCLf0bOobi
	XL0FJUC403zmiqLaxMcQPTg=
X-Google-Smtp-Source: AGHT+IG5TJb1vDclA0CAeMnXEGX5CF/pIpS0qcbrdsN3/Y771f6XsB4pMSwsM6DHFg7COEhjJpI10Q==
X-Received: by 2002:a05:6870:1686:b0:204:762a:f8a1 with SMTP id j6-20020a056870168600b00204762af8a1mr6833578oae.111.1704791860339;
        Tue, 09 Jan 2024 01:17:40 -0800 (PST)
Received: from localhost.localdomain ([122.8.183.87])
        by smtp.gmail.com with ESMTPSA id dh1-20020a056830484100b006dbaf72af27sm305243otb.1.2024.01.09.01.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 01:17:40 -0800 (PST)
From: Chen Wang <unicornxw@gmail.com>
To: aou@eecs.berkeley.edu,
	chao.wei@sophgo.com,
	conor@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	robh+dt@kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	haijiao.liu@sophgo.com,
	xiaoguang.xing@sophgo.com,
	guoren@kernel.org,
	jszhang@kernel.org,
	inochiama@outlook.com
Cc: Chen Wang <unicorn_wang@outlook.com>
Subject: [PATCH 3/4] riscv: dts: add reset generator for Sophgo SG2042 SoC
Date: Tue,  9 Jan 2024 17:17:33 +0800
Message-Id: <66a3c846d26ab73227dfcd141d021a46cad6672b.1704790558.git.unicorn_wang@outlook.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1704790558.git.unicorn_wang@outlook.com>
References: <cover.1704790558.git.unicorn_wang@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Wang <unicorn_wang@outlook.com>

Add reset generator node to device tree for SG2042.

Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
---
 arch/riscv/boot/dts/sophgo/sg2042.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/sg2042.dtsi b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
index 93256540d078..f59081d4f0ee 100644
--- a/arch/riscv/boot/dts/sophgo/sg2042.dtsi
+++ b/arch/riscv/boot/dts/sophgo/sg2042.dtsi
@@ -6,6 +6,8 @@
 /dts-v1/;
 #include <dt-bindings/interrupt-controller/irq.h>
 
+#include <dt-bindings/reset/sophgo,sg2042-reset.h>
+
 #include "sg2042-cpus.dtsi"
 
 / {
@@ -311,6 +313,12 @@ intc: interrupt-controller@7090000000 {
 			riscv,ndev = <224>;
 		};
 
+		rstgen: reset-controller@7030013000 {
+			compatible = "sophgo,sg2042-reset";
+			reg = <0x00000070 0x30013000 0x00000000 0x0000000c>;
+			#reset-cells = <1>;
+		};
+
 		uart0: serial@7040000000 {
 			compatible = "snps,dw-apb-uart";
 			reg = <0x00000070 0x40000000 0x00000000 0x00001000>;
-- 
2.25.1


