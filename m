Return-Path: <linux-kernel+bounces-142379-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C3C8A2AE7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AE4C1C228BF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E528D502BB;
	Fri, 12 Apr 2024 09:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N0ZQH64Q"
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED99C54BFE;
	Fri, 12 Apr 2024 09:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913508; cv=none; b=i3rzwJoEgEfhw9PySZHIJlmRZSBhrbD6jqWkPXl7D4W5ZB55cwrr4uOkRNaggow0yLh4I/F90bq3njbvUgd69c1Axalba+zlMl1VxPEPcMgJ/3IF5N40PBkxJpKtaY1R8HzHposSLtMmgAl2paeEEOWPc39mhpuGyzQGtHDREks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913508; c=relaxed/simple;
	bh=4wNrfxiYKtY4M7WYePoTXsUe2Iy0vCdtu10ZMPGGq3Y=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JswcBgJgO291XQZPiDUAT6vqQeY3P/ZVbn58UIVm8OWIGtALfdgf9q/Tl5NCuuGvPsPUVmRDEVl+KUcpB7zi+SHSpOL03EFwKLSy2oz2IfJsw8SZBsC+XnwTsra4yMCLjZZTAXdhJ719ZPGCLzaaF4NR4aLYS783HyalN8LjGjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N0ZQH64Q; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5a7d6bc81c6so558589eaf.2;
        Fri, 12 Apr 2024 02:18:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712913506; x=1713518306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hs0kTt521WxQulVTrFgJYAGsV52YNUczVxWl9CdT+ko=;
        b=N0ZQH64Q4u0tIfB2p+KL2fpSHFqAMIQ/qLCZzwyfl3vAfKdiGc69CASiqExU83/O9n
         iDCIh/ZfPVEmKguoXEWGR3Cvkp4FDB9QWBN7CO0DdXPsR0gl84lXVt+LFF5pZo1w/Y7g
         /wXaHLRqdmmE/Ft5pSfb1xRyl0eBggEaz1FDk5i5O8RJvZxhaW+1JOaJ663ht+zFyITJ
         8sQy0HW10H/cyUEYU6KHTxx4jJRWmR2zoSu9MX845M0ZJqM/fC4dtgeyr+79/oejiZy7
         LFgRhnDDFxe1AYDG9FeZ08udcOqlRLFVR7YEb+pd/sdJw0ieoVef4bT87lTxOZh6seFw
         xp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712913506; x=1713518306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hs0kTt521WxQulVTrFgJYAGsV52YNUczVxWl9CdT+ko=;
        b=J/uc8+mjDqH6a8wgP0/Xmop9TATCRwPpLcYDLEGw6VtgAHWliyQ54iUbRw6wOVJR0b
         Br9NBcgWKBZDkxYvsqaMk2ywEGEuiVS5lM8IkltG1YLeo15bsHjHasL4etYtF1H9r9XS
         QTrrDCoNR6sjkQR62cZsaLtdxSgsaH6YsI3gdmU6/yST3MqgRgmon7PE0ve/jLZBJahv
         PBMihM1bT3sI77qUA5QbMxHrM/yUg64kDJ2oPz5jkbvxqC/rNqXSqnFh6Znlw0PAFgwb
         5jpdBOVj8M0Q61a94GR/HKT4PQT2ghOrt6SQWYdU9TABHo8wp43vZQYuc9tXgy6+pebP
         5dEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUonMs6yhCFTz1GoB/ZOtJHPrtPuxnTgDrCkJWufvI+QTVSr4plB4OVGIWZc46MmBCnAmwTOvxewt7y6e7sMoSLIJyjMMq8fk9KsjS5KZIkjn9TXdzjQwounv/x+lgRzhX/WnY71EeSXw==
X-Gm-Message-State: AOJu0Yxz0JQPHadpkWG2TMQGWRV616RF23hkQITHxPbkiZrs/HYqcK4u
	Cuom2uoVRalW1/A3gO6ME52oSAAL6HLSVR6MxI0Y5RNWuaWBI2ee
X-Google-Smtp-Source: AGHT+IFPaoFMQ3pSNr8OKGxksHpnsLzy0ObJfgdGfnPuEiUxvrzSOGBsWdlo6ujZAsQCPVKC5l735g==
X-Received: by 2002:a05:6358:2889:b0:17e:7c4b:bb56 with SMTP id n9-20020a056358288900b0017e7c4bbb56mr2098863rwb.15.1712913505921;
        Fri, 12 Apr 2024 02:18:25 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id b25-20020a63a119000000b005e840ad9aaesm2332711pgf.30.2024.04.12.02.18.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 02:18:25 -0700 (PDT)
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
Subject: [PATCH v5 08/12] ARM: dts: aspeed: Harma: Add NIC Fru device
Date: Fri, 12 Apr 2024 17:15:56 +0800
Message-Id: <20240412091600.2534693-9-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240412091600.2534693-1-peteryin.openbmc@gmail.com>
References: <20240412091600.2534693-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add MB NIC Device

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 7e98af5836cf..6e9e6e559838 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -207,6 +207,12 @@ temperature-sensor@4b {
 		compatible = "ti,tmp75";
 		reg = <0x4b>;
 	};
+
+	// MB NIC FRU
+	eeprom@50 {
+		compatible = "atmel,24c64";
+		reg = <0x50>;
+	};
 };
 
 &i2c2 {
-- 
2.25.1


