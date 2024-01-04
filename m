Return-Path: <linux-kernel+bounces-16726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 856F8824302
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2470C1F25057
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9754E22F04;
	Thu,  4 Jan 2024 13:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UsOoaoTi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36EF22EED;
	Thu,  4 Jan 2024 13:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-28b400f08a4so375887a91.1;
        Thu, 04 Jan 2024 05:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704376062; x=1704980862; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pegTGAgIl7701EaFNdsQSg89lpjeCGj36MeNrr3t5wk=;
        b=UsOoaoTiaLKeMSLkXmDPUOx8d8LNWoOSVr8PMWB/ufMBVH/Fik5hjnV4it8GpE6B8R
         ZGH1+nu8IhaU6E/vwErJSB1926nXDNrW9mBJFmRyQINjQUDCp9gPTJzbRCoSoYxQUpXU
         ojVBZqtLagMVxcICXzIiW9fOoq8BK6+1R5BpMsCRdJJszCMax5jD1Tx9dxxkUUpyOWva
         ve2NTAQVCnWdMak1LNZ45CQc0E3S3QHqaXDhAh+Jb8Bjaf2PpPrI0+uS4ITuziIjxkAX
         2Y8m9MzInpSKOLcvtzMRXrLYrhgHiLEYxrFZ+DCnVIGB2PBHgBr/PhWxUDSRbUAL38n3
         0ZzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704376062; x=1704980862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pegTGAgIl7701EaFNdsQSg89lpjeCGj36MeNrr3t5wk=;
        b=j3o9hKpGh/CNsvCXHMwizCZOyWg6YbteiOMCNzLN1Alc7Bah+6sLsb7m2GRbrAUeZd
         9hAID0p/iSu54vcZIkCPjC9kaSHRZqMEEABmRbmiZkefH0t2djz1oivCZZidiegqLkVB
         cnE+4OJ7VU2s/MRYvZsnU3DsDsr09XZ+jpIHJrxAK+7Zibv3IMpH56pKGTaa/7dwVpbu
         oyrMJZFruIjjVkkEWK96EGAk7obydrqbCD+8KfJNcZQ5UKXxI29cCBwTZNdWfbfWnSTN
         IqkWDJNTp4UHdhMfb+gnyfhPJCjUuxZ/QrQU5hITDLvAWDn5it0kE5Q92TEHt5JZK+Vu
         BdsQ==
X-Gm-Message-State: AOJu0Yz0Ta6yeMSQDlJPbglY7joSlbMon2E9RQtJNJC5sLStWrF+ej1N
	17nwH/1cpMMJuYRsSiB7eYA=
X-Google-Smtp-Source: AGHT+IFCbGdnPEtxJYKYWC3wH6B6pOmF3J7YVEBHF0oMLhCvgGy2SmtHvjHpNVtfg0AjaZGf0RoPqg==
X-Received: by 2002:a17:90a:d149:b0:28c:2786:48be with SMTP id t9-20020a17090ad14900b0028c278648bemr535511pjw.49.1704376062106;
        Thu, 04 Jan 2024 05:47:42 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id a22-20020a1709027d9600b001d425d495c9sm22990550plm.190.2024.01.04.05.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 05:47:41 -0800 (PST)
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
Subject: [PATCH v2 2/6] ARM: dts: aspeed: Harma: mapping ttyS2 to UART4.
Date: Thu,  4 Jan 2024 21:45:28 +0800
Message-Id: <20240104134532.536793-3-peteryin.openbmc@gmail.com>
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

Change routing to match SOL(Serial Over LAN) settings.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 8a173863ef24..a0056d633eb1 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -12,8 +12,8 @@ / {
 
 	aliases {
 		serial0 = &uart1;
-		serial1 = &uart6;
-		serial2 = &uart2;
+		serial1 = &uart2;
+		serial2 = &uart4;
 		serial4 = &uart5;
 
 		i2c20 = &imux20;
-- 
2.25.1


