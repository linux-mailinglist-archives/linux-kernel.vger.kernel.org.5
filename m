Return-Path: <linux-kernel+bounces-14022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1877E8216FB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 05:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ADA42B21524
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 04:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0944C91;
	Tue,  2 Jan 2024 04:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A65vGxek"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7DA4433;
	Tue,  2 Jan 2024 04:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-28c0536806fso6607241a91.0;
        Mon, 01 Jan 2024 20:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704170780; x=1704775580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KHfABZko5E3OyVpk0Pm7Tx9/GwQM3X5Y0l7yapoWLPM=;
        b=A65vGxekraCfDnniY15cSbOtxbhLkRZ9t7iMsd2kngKj4yyyWf/37ziP6JCzdQ2Lvv
         05LTEi1zaydNgW1PUMRRnVdpwh8WE8yZhQOVMsO21G2dANZ4M0kFZv6f8qQ7IkNJGMNc
         SCjfgmUC0jnosUrMZ9ZvjBrqKeE9CLoGBjsAanKHC4rWrou692F6mpCl/AwT+RnQWZ/B
         FEoR7aSOYMs1K5IWtEUVeXUlGrL9SL//KxSjqtrZJx0PAZ8sZ0l+ejDd6ZWKZsNNohOw
         qCgW1KHHAzah6PWVcuSBdnDQ7tTfNVbGNcU6aky3+pRd/Y3+2xQcPjMqV0ESJuPJKZqY
         zr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704170780; x=1704775580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KHfABZko5E3OyVpk0Pm7Tx9/GwQM3X5Y0l7yapoWLPM=;
        b=W27tsAsEAPJuOxVBF2DZX6YorQBDtaCPLLHkaTa7y5qnLrI/+HlANeECvMabwi1Xcj
         FuuXQNxpoRf8iz52EfiQWuKKj4g6qe0u+GXTAg6pGQERZX2tK0aeN/XL7/g2B7SicaDs
         sPyIidgHG7vM4eLntofpKgWPz31tLhrjIpDMhRF6zD3elCus9Zy/kypDlQrxOdevEr5M
         deWrkJKBTtDjnGVVCS9KzYMZ925lq7cRr/3bZlUl8lcL2UYqCUaowM6cVxoFVpnf1I07
         RTDfkkLGyWfr0BOoKGy/VEtipJS/xNQlqzaMf5hbHs63F43PKv8eR1VmL38T2jO/HKHy
         Ml/g==
X-Gm-Message-State: AOJu0YyFFsIydWXycNCSE+kmybFMOOkyzVxbw7g3vBCMB2sTeRZsv7dg
	gOyjRLLVKy+5Byj42VCNYJ0=
X-Google-Smtp-Source: AGHT+IEzzDEg3r0oZfdhsV1Nr6yrEvbWCtjZygtLmN2XYZpEq4qUatFFkmkI9O0r7Lsjjffya75KzA==
X-Received: by 2002:a17:90a:8f03:b0:28b:904a:93f2 with SMTP id g3-20020a17090a8f0300b0028b904a93f2mr8478432pjo.32.1704170780021;
        Mon, 01 Jan 2024 20:46:20 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id d21-20020a17090abf9500b0028c2b2b76c0sm17308392pjs.22.2024.01.01.20.46.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 20:46:19 -0800 (PST)
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
Subject: [PATCH v1 3/5] ARM: dts: aspeed: Harma: Remove Vuart
Date: Tue,  2 Jan 2024 12:44:07 +0800
Message-Id: <20240102044409.3810873-4-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240102044409.3810873-1-peteryin.openbmc@gmail.com>
References: <20240102044409.3810873-1-peteryin.openbmc@gmail.com>
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


