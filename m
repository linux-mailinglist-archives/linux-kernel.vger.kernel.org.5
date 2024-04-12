Return-Path: <linux-kernel+bounces-142381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 795778A2AED
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3514428537C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028BE56B89;
	Fri, 12 Apr 2024 09:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fsz74Jm6"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4AB56B68;
	Fri, 12 Apr 2024 09:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712913513; cv=none; b=k92ILBf5oCYq93Z7yjDmQuT6d08DUZvf+ATPwvgVEeEBkGNAa3LoeRH6UjR2DkmWwK/63z0bE0h/hzOJAu0LQvAUDBmTLVrEepT+PYGRmQEUsVanOY5/I9mOcZg0b+JMDxn1EttXjUUXMOvdkDttXq0TEb+9kCTFbHPBo0poKNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712913513; c=relaxed/simple;
	bh=X0UY5Fy16i6PgOrRoeHTZtsituUOV5zLRDOsElqb+1M=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jeHpNL02PfOFg1ILlg0EKcLmiZLvHQJ1LTGl4M3z2njeeQZ+h7Pt7OuaiNiM35tm57ezeaLvgi3EwZKrmBN/H3yAvZIJ4S4StePqHqoTD01qjdwvdKNrVAO6fmhy+fzHOa2c+gY61JHPfz3Zf6N6EpUW0fImvEtxBnl0QjbB/QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fsz74Jm6; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7d5ee54dcecso29126539f.0;
        Fri, 12 Apr 2024 02:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712913511; x=1713518311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xrsvdI1lEYG0uIgU/VTd61D6Q1rZXhoZ89VFb5WgrsQ=;
        b=Fsz74Jm6XkFdvjiPmWPI0iAr71Tt7rBqbQXpp59DiMoprgJ3r2DC2A0b2miMXLS2H3
         oz5VQuG7i+oibkb4b5bmOVxrkx3fI9jUGylCEyvWAxJzEsnWFWQIGF6/OpB6PBCcna/G
         rWsNT5OY+pzsJ1JV9XoJ/R61GHMebx4qN9LWGteX0QJtyI9p10rG9Zw97Q5G8hlSAd5n
         jQOL66KZjQ9ZI+nH6oX+Ud3A2acbYUX+UWD9DzuY8uURFVV7cD5q+AVY51kFVYEJsqSM
         rTX1xnMdSMYf1TgMyx3UWcfOVNdX421TvlETIOyG2YXd5JjwLtaBarudl5jY/6M9bu96
         J/KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712913511; x=1713518311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrsvdI1lEYG0uIgU/VTd61D6Q1rZXhoZ89VFb5WgrsQ=;
        b=U8mREzrBFqnfYxcX+lVsfTcSM9ApebpT1cUUMKkZWXtohbl93qmTNUi62yfAI1FWZQ
         r30QZVG4T/efAO5BIz6H2gJr08zvs7ddBwvXiGaB1ze7I6ev2PBC0IxX9Nf/CZWXr2sF
         1ROCwjRw5oTpvNk4XYZkVxJDSdkKS30ynYhr7NyrX+amyIgACoghHjO3nyeoW9IiE05P
         eB7oFIIWMzuPfBeRaUBdvlT8ZUqsb9sULondEoD/OWr+Vg01KJilGf9QS59u29MgUVsy
         IzUsrEvnQ6Z+SJM1j6gbBVzcijucOJxXueBm5nYiHzzEF1CI0wTQeKomZskKN69Pn9lk
         9PAw==
X-Forwarded-Encrypted: i=1; AJvYcCVCRochxZSjN3mupnD70tI4aPM6RjLUdd9k5M2Fnc6t6Fd4IwfWQ9A+wGM2f656qlkKO6WQmYWYqSHOUROjKgYQXRYl7kjQFZw3Ng1z7I7ysS05ZHT5wtDmR5xfveft8x0QGRAddH+vWA==
X-Gm-Message-State: AOJu0YwFXgMNkCBKZa4E3xZsmGKDoHDAuq6G7xFZ5R5sf1Pblo1pZw7z
	MO4mtGTNH499odxMtDdIFcHg0+PtZQ7YSOKViqlrnldTQ3YxBTMJ
X-Google-Smtp-Source: AGHT+IEGmA2j+bho3mUExB5XbbPY7HsXPCIrX7u2g7/zilrGNxmZEgiTMx2EcNNyUVmKSP+iORhPnA==
X-Received: by 2002:a05:6e02:1807:b0:36a:fe3d:157d with SMTP id a7-20020a056e02180700b0036afe3d157dmr2354709ilv.25.1712913511254;
        Fri, 12 Apr 2024 02:18:31 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (1-34-21-66.hinet-ip.hinet.net. [1.34.21.66])
        by smtp.gmail.com with ESMTPSA id b25-20020a63a119000000b005e840ad9aaesm2332711pgf.30.2024.04.12.02.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 02:18:30 -0700 (PDT)
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
Subject: [PATCH v5 10/12] ARM: dts: aspeed: Harma: Revise node name
Date: Fri, 12 Apr 2024 17:15:58 +0800
Message-Id: <20240412091600.2534693-11-peteryin.openbmc@gmail.com>
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

Revise max31790 and delta_brick node name.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
index 7dd48c384a4d..530f69005857 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-harma.dts
@@ -192,7 +192,7 @@ &kcs3 {
 &i2c0 {
 	status = "okay";
 
-	max31790@5e{
+	pwm@5e{
 		compatible = "max31790";
 		reg = <0x5e>;
 		#address-cells = <1>;
@@ -218,7 +218,7 @@ eeprom@50 {
 &i2c2 {
 	status = "okay";
 
-	max31790@5e{
+	pwm@5e{
 		compatible = "max31790";
 		reg = <0x5e>;
 		#address-cells = <1>;
@@ -262,7 +262,7 @@ eeprom@52 {
 		reg = <0x52>;
 	};
 
-	delta_brick@69 {
+	power-monitor@69 {
 		compatible = "pmbus";
 		reg = <0x69>;
 	};
-- 
2.25.1


