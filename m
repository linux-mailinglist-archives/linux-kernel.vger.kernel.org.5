Return-Path: <linux-kernel+bounces-11471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D8CB81E6D5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 11:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDD0F2830EA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB8D4D5A5;
	Tue, 26 Dec 2023 10:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8QONvcx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971564E611;
	Tue, 26 Dec 2023 10:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6d9aa51571fso1452985b3a.3;
        Tue, 26 Dec 2023 02:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703585096; x=1704189896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3IEhPd/dkELLSWHx9/UI11WCb/nRm3sD9uo5W9HMdhI=;
        b=e8QONvcxxxBLJkEOa8axvE4dTup+gYAYy5gNuDKmxxMwEsBBF7pgu+p7RyVuM2YLSG
         R7vtqwt5hCI3uhIZFbKjEP+QD7u2wNky8ewDCKo6zimUr+4Kn4yF4pSiaL4pEESWstfy
         SoTBtU/MHv9zU7rZeR7TkEipt2O5ebEttpQte77dKlACuDYJ2m8UKdRJgnn0SFCzkuSs
         mUBqBxUEvl8AQWS6Gkp+T6P3ahy4w/ztYvqRjiWFeIwPn3lLx8JTS8a5W7RtFRMGGKop
         fUUaos7J+cFgo1BwlfjjKQJLN0P5UMbu2rZFlV4UUIo1Kt+XdFIc/k/hjFFbMjdtywKP
         Ab3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703585096; x=1704189896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3IEhPd/dkELLSWHx9/UI11WCb/nRm3sD9uo5W9HMdhI=;
        b=ZltWDvpStTql2AvXQroDg+dBVY4VkUv/UHpmFu5I/B+3LIrDpYlhS8kLFSTFyoB9ib
         Zy4h1/eI19IHqHpZmHyii9UN955vnweDlZAXHtMqbDPV+o4yw62BAqdk6UTcRDOQ/qFV
         TlVjKndFD5ah/mzY79ta87fbs0NCOJ8oX1TOw6LcHcprvpJI/zJN971H0+wK3kIEq9Sf
         i5uaCM/fAahgzSdbECW3o0gILEaiDEgutpbdvSs0lhH8Q2emQQGU3aaX0Zw+QrI1GFoP
         m9HVt9FPx+i+qJm+tpjSFO0aMlmFyrbr3TPlW8e7hDREWRmpPNe88EX+Rw7B6Kq+2k+7
         qmKw==
X-Gm-Message-State: AOJu0Yz2haspqUdoZ+LdGUrbm+l7DQBLsG73FnY1QbxI7pg3zdbNmdH2
	VYpDU+x7wB+dpcaIFHSGies=
X-Google-Smtp-Source: AGHT+IFtcHmMvkIWZm0XAGMd4iDHhcps9Xe+KIP0yPpek9VntKwqgfRD9kl0KXQ5yHAgI0IB24JL8w==
X-Received: by 2002:aa7:9828:0:b0:6d9:9793:37c6 with SMTP id q8-20020aa79828000000b006d9979337c6mr7300174pfl.8.1703585095520;
        Tue, 26 Dec 2023 02:04:55 -0800 (PST)
Received: from localhost ([46.3.240.105])
        by smtp.gmail.com with ESMTPSA id z65-20020a636544000000b005b856fab5e9sm9040962pgb.18.2023.12.26.02.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Dec 2023 02:04:55 -0800 (PST)
From: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To: a.zummo@towertech.it,
	alexandre.belloni@bootlin.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor@kernel.org,
	conor+dt@kernel.org,
	chao.wei@sophgo.com,
	unicorn_wang@outlook.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu
Cc: linux-rtc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dlan@gentoo.org,
	inochiama@outlook.com,
	Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: [PATCH v3 4/4] riscv: dts: sophgo: add rtc dt node for CV1800
Date: Tue, 26 Dec 2023 18:04:31 +0800
Message-Id: <20231226100431.331616-5-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231226100431.331616-1-qiujingbao.dlmu@gmail.com>
References: <20231226100431.331616-1-qiujingbao.dlmu@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the rtc device tree node to cv1800 SoC.

Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
---
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
index df40e87ee063..da9c42ef6fd4 100644
--- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
@@ -114,6 +114,17 @@ plic: interrupt-controller@70000000 {
 			riscv,ndev = <101>;
 		};
 
+		syscon@5025000 {
+			compatible = "sophgo,cv1800b-subsys", "syscon", "simple-mfd";
+			reg = <0x05025000 0x2000>;
+
+			rtc {
+				compatible = "sophgo,cv1800b-rtc";
+				interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&clk CLK_RTC_25M>;
+			};
+		};
+
 		clint: timer@74000000 {
 			compatible = "sophgo,cv1800b-clint", "thead,c900-clint";
 			reg = <0x74000000 0x10000>;
-- 
2.25.1


