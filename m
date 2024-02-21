Return-Path: <linux-kernel+bounces-74431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 107CF85D3F8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0B1C285969
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9363C3F9E5;
	Wed, 21 Feb 2024 09:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6AG8oLf"
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860963F9CF;
	Wed, 21 Feb 2024 09:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708508508; cv=none; b=UcB3Fw0kHJsqS2CiDm1buDUccsIrDO1ImiVFLgqr2mXvuDOF3OtB6TC/nhDqKNIiHrK/oJ8nC8Cjgu2ZBpHc/DmLbVFaIUuh57KtakTdoqV8dNxGpw3U4i1QLo5ek0D/jArCNDcngMR0dSZd3l5rBBynOkdoGFiVV5DW4p34FCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708508508; c=relaxed/simple;
	bh=s/Bg2DFovGSCzt6KozJRliFQcjlVDLNvyVoJYxjtAJY=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=huD7xlj0fYk/6banhCbuYXbojEio72+TH7mBqhqkWz13SVishPxPSDRG+DkAWjL104ZwPdJ+6hbvyAPjxSKP6cMpltRB/WhWHb4S9mlBVxywLeAjJ39SJea1s4Zq9pZsO3zrcWMUmXLt9+07Qnn8LogghaZRo1OQ5AVry6zqMRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M6AG8oLf; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-59d489e8d68so1937788eaf.2;
        Wed, 21 Feb 2024 01:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708508506; x=1709113306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwaPddAHaW12NHPZqCdSQa33972trzIVhKPHEitazSE=;
        b=M6AG8oLf8GLscEkhwB3vjUFyaT83W9jnoeHxuJPSYpcQb0Um/2LyBd8OmYGH4Ihx4u
         GzULzcmHrsalCaYWXLaYNXwvYcBHvuEYgaCLeodmB7OidUaMQvYqaR3k1NmS7QZJLqck
         8ChsZJyV2KTEzLoBuA6ZnV0lHE6DwH1HwiggOZjKTXwk5ej01WucP9HfTSIh/gmslWhp
         hccIB9399uNxO2e8ilp7WELmD4GiI10uGFOzihDwb2wbHustiS5utQGgO+oG4V211aGI
         e8GAcsV7AZ6xBSD74XWk63Q9JliWCE+sVEVzqJJCEGN9mt5JhuPrLPZwOXZINJ/9RpLz
         0zxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708508506; x=1709113306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kwaPddAHaW12NHPZqCdSQa33972trzIVhKPHEitazSE=;
        b=BWmfJkYSfJx6OArPNa8+chx+esUv5mcKG9hzXtMMZ+658sKEblQwXV/Z14uYpC4iBk
         vecIqVDx9eTprWyDGsLdO6wDQULC1o2bNLUlZimkfCgzY8RqE+WdMXjrsGGP96Mjvt45
         Vcc8WFDIr2qx+joJrfraba7G1SWw5G0XBMskM361DKFP50ScSUULs5dLn3i6sc2YDN6X
         wsUHAF3iYQgJts9vZw01RPUAgKkkNyCuy5BstxWdq2CWT2C9SkWYhqIWzqa5IHh5K9JC
         yBnBl/ezHVkA1dDMPLEYYnUQ1vhWigVji+7CTIwhPs5A/XMJdLM4R3qgT3UqhWPiIwAT
         eGzQ==
X-Forwarded-Encrypted: i=1; AJvYcCURSIrzvcfBGOUmR8CvOcr5SOmHGbG0SWWM4vqWQEllTtZoWmmvWN4b+v1OhAnAgg5LFkx0qe3dsRYWar/w4TYM0C6fEABLDG41C1qGfoFr6l38dgXIYeFROnv7CnB0h4dp1ONo2bY/sA==
X-Gm-Message-State: AOJu0YzUm4r6WichGnTaLTftbveFS5FTWNbaefxY7nwnDJauGjLLWo1b
	Ghedlnl5hEXQPtOR+eOcSVGaUMUngKjiuI/NQpmj12fhVDp1Zvxc
X-Google-Smtp-Source: AGHT+IH9KausZCmEwF7YcdF99VdVzBOSScc7I1ThUC1gnUhh1vP5Hczr8cX8G0iOAghG0hmI5AWQaA==
X-Received: by 2002:a05:6359:412a:b0:17b:5529:d9d8 with SMTP id kh42-20020a056359412a00b0017b5529d9d8mr2408847rwc.9.1708508506595;
        Wed, 21 Feb 2024 01:41:46 -0800 (PST)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id lm4-20020a056a003c8400b006e488553f09sm1645026pfb.81.2024.02.21.01.41.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 01:41:46 -0800 (PST)
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
Subject: [PATCH v3 7/9] ARM: dts: aspeed: Harma: Revise max31790 address
Date: Wed, 21 Feb 2024 17:39:22 +0800
Message-Id: <20240221093925.2393604-8-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240221093925.2393604-1-peteryin.openbmc@gmail.com>
References: <20240221093925.2393604-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Revise max31790 address from 0x30 to 0x5e

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 4d5d1c822fa3..83da7e46bb42 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -192,9 +192,9 @@ &kcs3 {
 &i2c0 {
 	status = "okay";
 
-	max31790@30{
+	max31790@5e{
 		compatible = "max31790";
-		reg = <0x30>;
+		reg = <0x5e>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
@@ -212,9 +212,9 @@ tmp75@4b {
 &i2c2 {
 	status = "okay";
 
-	max31790@30{
+	max31790@5e{
 		compatible = "max31790";
-		reg = <0x30>;
+		reg = <0x5e>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};
-- 
2.25.1


