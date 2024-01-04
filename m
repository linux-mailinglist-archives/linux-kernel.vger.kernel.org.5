Return-Path: <linux-kernel+bounces-16727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E543B824304
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 170441C23F07
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:49:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D3C022F1B;
	Thu,  4 Jan 2024 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wo0jgfd2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B5D22F0B;
	Thu,  4 Jan 2024 13:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1d4414ec9c7so2879085ad.0;
        Thu, 04 Jan 2024 05:47:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704376064; x=1704980864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHfABZko5E3OyVpk0Pm7Tx9/GwQM3X5Y0l7yapoWLPM=;
        b=Wo0jgfd25f+tiAMVFm1YcW7fCZVtZPWD6PPs2FMcVnEMEeX98PNgzfKLy5XCGGbf5a
         jfnf7TNuXl/xA1hoVHFWbuszQoiqtyjkG7A9LsDr4D64hizCMN4MrxVs8NETBcuyNk+f
         RoksPz5cbdJmbriwalhnd9GouhucN2nUFL9kTBhFOtn/+ppHteGuWgZbZJpn8X8UsVDr
         wATh6wzO99sw7P2YqomXFTWok9FcsLPUgD6FAir6EKyXEtBvW6axgLM2F+fGMPoMh9Th
         yRuLnq2sfypcbMWZiQRWpPGnCjX3hS5hdKdZSas7Ggtgj/+3YVZUfL+BNvncIq9rDPbw
         v5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704376064; x=1704980864;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHfABZko5E3OyVpk0Pm7Tx9/GwQM3X5Y0l7yapoWLPM=;
        b=TRmEI3Ij0nVyHr/XbtIuDur55o9z8oEZc2+w1FdoXwPKRDgkt4O0wTqqnuB10j7Y1n
         kFrAatSm86MScw/7vao4ZldqB9ARv049fJlhj241s6+KNsj+dNtrPKTNJTChT/LH1GjQ
         8qn3kHEHmKYxIid3BXjyDMnz9klFkr2hac0DCZuyZKKGati68hvWageYJCuJwyes6Oa7
         CzLhd5VkyNZ2ZwLMHTZbcBIV35oscrM8vs0p/pWImw+DnUlsUbS6FSHN5PJCNm29bdyz
         L1/9XQWszWqv0sugIpFwtKBF0QxGCeDd8zpKHXqwWWppLPCYhJXP6E7UFlt5qwBl6Vce
         XldA==
X-Gm-Message-State: AOJu0Yw/3usK72QxZurCgrkqjp3NPZ7qSWZkWeGsQ6aVcOLGZV3Al339
	xuW2sZvctzQPFrV/VQkBQjn5gFRgdgI=
X-Google-Smtp-Source: AGHT+IHUiOTg4zCNAIBM0tpqHX3KafYYflpL77hic8vey7JDTAmJ354vcnuYX8fns2HYsVVBMeoeQw==
X-Received: by 2002:a17:903:1c3:b0:1d4:cea8:5d6a with SMTP id e3-20020a17090301c300b001d4cea85d6amr595332plh.4.1704376064558;
        Thu, 04 Jan 2024 05:47:44 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id a22-20020a1709027d9600b001d425d495c9sm22990550plm.190.2024.01.04.05.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 05:47:44 -0800 (PST)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@aj.id.au>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] ARM: dts: aspeed: Harma: Remove Vuart
Date: Thu,  4 Jan 2024 21:45:29 +0800
Message-Id: <20240104134532.536793-4-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240104134532.536793-1-peteryin.openbmc@gmail.com>
References: <20240104134532.536793-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove vuart to avoid port conflict with uart2

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index a0056d633eb1..5d692e9f541e 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -100,10 +100,6 @@ &uart_routing {
 	status = "okay";
 };
 
-&vuart1 {
-	status = "okay";
-};
-
 &wdt1 {
 	status = "okay";
 	pinctrl-names = "default";
-- 
2.25.1


