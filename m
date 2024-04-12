Return-Path: <linux-kernel+bounces-142380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4008A2AEA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 110FC283A4C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32C8856772;
	Fri, 12 Apr 2024 09:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkNl2KDL"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D0253E06;
	Fri, 12 Apr 2024 09:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913510; cv=none; b=Ebbl8xBMtA04/1r/ApLLGSmMgoI7wZrGE7j0kx2UmbIabo53g0P6fDxtFZyfZS4S22V1ogC6LNuuXV9u6DPBADSNp/FAEH2svykh1mpDMf+ye/YMRRzf09/ld6oMmtWr/S00v+GGnAsPuYlYbde+9tjjfxm6RgRu5onCDYsa7to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913510; c=relaxed/simple;
	bh=t8JcB3RZX13P1Si04c29fA1T7OnQW4aKxCQBN7Uqsgk=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=J4lPzi2qIfoh7vfCSDQNga7BIze8o/sjFqJXrtyS7FWxYxcPz87NB0yEhAN21qhGbBkKrmdmm3DbclPg+XUrRTEtHp2zWV8zBwEzZfNch8b3FNymhLr+MmsneajsT7ZfTXYZrHYZ4eN03RQQpEyCy9Fcim06PYeDAIcpYpE8X88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkNl2KDL; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ed2170d89fso1120691b3a.1;
        Fri, 12 Apr 2024 02:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712913509; x=1713518309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aW3rP8p4z3TO0Ihdn0FuHfBWSAl8GOUADIxx8TKfnls=;
        b=mkNl2KDLJE0TdeJ0PZ7gSrC6eL8cek73tOZpmhBkW/4+el/oHQaMbVnjFjq2gVS0zD
         dAquWjtGd5iA1sOmwVmviLYm9Tqr73SsA7PljXYXpl/pMeuGktiPgI/w2tkd7FN7m1Xa
         0KOw7M8lKHuCeGmSZvlJt6hor9q4i6Vf6I7P7kBTZBuXJSYlMH4nWtKb8rXzrcFpDpnP
         K3nX9NHLEfLwzdolidjHBvKqry/2Ubgs8wKeDmCx3O5CM+jP7rpDHqkJf/naNU1L3z1h
         7o4ZJEueZGYpV+k1B0lm8Sw/AJLtwgqxiDLXZHWHVbUCrSTVgGJYaqYtkMTgIke7KGAS
         2O7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712913509; x=1713518309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aW3rP8p4z3TO0Ihdn0FuHfBWSAl8GOUADIxx8TKfnls=;
        b=A4ziqsqAknNG8Y/Iy5VwG8VOlJsc5d4HXli2rtj8vZZVtwIkd2GIyQWGz3LFqSp0j9
         32YR+Zg/PKEy7Gvbjv+Ay58siBvbeo8UweF+maUCOCXNquMbOcuLao8xOR/GN1Ptvhl/
         bFoqHOoJiHEn2ixqsBd5EgDCbYbWw0dsoxzYSk5kKh0oe33uLO0/z3F34ihUWC32AC79
         mg+Kr0F4UFj09MR58X+Cr8U+jLbynXWjLLk2QQWYGGJOk9Iv178TqR+NiMooAjt8kYmQ
         SFOzBx6y1unBw7GMpje84NXnkg0KMtsb5LpPiFQkheQvQ54XtZhLLAOOlQobiaokJlL2
         WcTg==
X-Forwarded-Encrypted: i=1; AJvYcCWyQGpyzyxpa7Yzs+4q8kCRh/jMql/XauTwaYaTA26ridp5yCoFdmyNKPgdBPP8l+d+cgHFRQCQYrA627M1WpWjcroIITlYSITGIfd1lMtx71UfglkMWcjTmhCDMp0jTM4Hxh7YvDvRhg==
X-Gm-Message-State: AOJu0Yy9m4TdPuoRDzUAQ+wCPveolO30WChe+WUGB+6lhxDArzbeicVU
	cGeJrzZA7So1LviYLFewvn1mGfFzRT9Quw5wrC4k81iuBJNdRg7B
X-Google-Smtp-Source: AGHT+IGNVugvPemv29ATP+GSohH3oVVJHymL0x51x1Nragz+Vk4X+Jk1g5T53aDsbWhGBUZM1l8H6A==
X-Received: by 2002:a05:6a21:164a:b0:1a7:5413:1e6d with SMTP id no10-20020a056a21164a00b001a754131e6dmr7274993pzb.4.1712913508603;
        Fri, 12 Apr 2024 02:18:28 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id b25-20020a63a119000000b005e840ad9aaesm2332711pgf.30.2024.04.12.02.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 02:18:28 -0700 (PDT)
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
Subject: [PATCH v5 09/12] ARM: dts: aspeed: Harma: Add ltc4286 device
Date: Fri, 12 Apr 2024 17:15:57 +0800
Message-Id: <20240412091600.2534693-10-peteryin.openbmc@gmail.com>
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

Add ltc4286 device.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 6e9e6e559838..7dd48c384a4d 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -271,6 +271,13 @@ temperature-sensor@49 {
 		compatible = "ti,tmp75";
 		reg = <0x49>;
 	};
+
+	power-monitor@22 {
+		compatible = "lltc,ltc4286";
+		reg = <0x22>;
+		adi,vrange-low-enable;
+		shunt-resistor-micro-ohms = <500>;
+	};
 };
 
 &i2c5 {
-- 
2.25.1


