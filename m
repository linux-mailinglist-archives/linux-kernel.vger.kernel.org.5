Return-Path: <linux-kernel+bounces-120572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A188888D98E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E5021F2C750
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105D3376EE;
	Wed, 27 Mar 2024 08:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELVT7bFv"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B143374C6;
	Wed, 27 Mar 2024 08:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711529622; cv=none; b=uIWzS1sSEnHS5kncaHM5nsYEIg3lBoqqXiWg4Wm+vzsKQnDJPf4/sWyiBpJFKL72XJV6BZnAzpQ6MXR3xVpEZliqp5mpJC15zltRT17mOeskuhnLfjX2Y7KBTE8mMOzJPl0KMXP4bcHi9ppaYBXtL27E/AZsnKaJMWJNUpRwLdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711529622; c=relaxed/simple;
	bh=i2IRRjTZyiYex34MyWLMNAUhtzs5XV3CN9xcafzB4wU=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gQSCSTVvb9FHlXCRSGdpoCaCqzZpfPccTD2NBeauXQaH2qtrraJ/Ub6DLy+daPM21rVzFqbnJ6iM/UcVSCY1ixmbS54HWdN8UQlyKaQmTUQbcd7lietKtJZXVndKLUdLQ/gffu946iFg0ePxKqnefLpTsnSFv8x8gkthJ5nytkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ELVT7bFv; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5e4613f2b56so4256304a12.1;
        Wed, 27 Mar 2024 01:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711529620; x=1712134420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=axYCeiGWmH5zGIGoROlm87X0Iv4FCoHgVdnjtyDTc9Q=;
        b=ELVT7bFvI83iN8TrlS1hs3NSMOxSRZGX4nP/DqnMJZPzpfOgnnPAu20agUWl37zxOo
         pxJ4wh6ydhBVG1IGQB9VjVDlYoqEIYJGzqkLtiRC5XXiGwHtiVzaNynmXbfciQXlWL4P
         zfpHngcotjlpBp20+1zHAZl4UqzSvs2oL8j7aExihQceF34eKq4w6Uv4fcv5mT3QMtwX
         MKTeB+qRxwikW6zy/Rm0z+Hxv2Bw6apL8yabwmZ7MPnG0N5Qsz0qSyyKctmFYtzDFsTx
         UuaTBWL7d3MD5h4YUMSFNGssgb/jAD5iFyxY2uuOayoKRFlNNnNQqwawi2hrEZQMQHrj
         yigw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711529620; x=1712134420;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=axYCeiGWmH5zGIGoROlm87X0Iv4FCoHgVdnjtyDTc9Q=;
        b=dcY+dwqIIEMV38eftHOWpgSzVOfMybL1h2taiSdFkCjULg/StJXb/jV8F4jLn4vneb
         87yRdwjrjC1ttGpnSt0WAcAJ42GV7dK05zYsS6me2ufEZ6nkTEo/BJlPWoi87Rtp/sOv
         BmGkdYzSOfxJ1rg9YS1HvqtPbFHBL42vSRf/yExDEi6g6aTYVhpNo20zXc3KLC9jg5Iy
         XY/xkWa8BEAPB2f0CJaCF8kZT+5sm2EA+98erjj+aJpf7rblwKEZJc4YIpbEZ85U5hF6
         RJl7r0cjzUJ8BIG3bUqpX1kC8Rg6qePtfHkTH/7yWdI/tJy5qjqphMLBXPPSm92FJny2
         yvKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVqXlo28vIIw6w4jNXAud5OcQWEq63TnR913Wj6m48oiHzXUfNoI82Kw6k3SQpjbpesCCi5FbCR3MTReFqbf4J/h0xG6HfE4c9jtfD19UMaM15vnNn3kMvfgVs8lP+ESi4HCphX10bHpAnVP/vdjQOV6EOUyNEjaQLqC0/qN14sZOl5yjhK9QSZ
X-Gm-Message-State: AOJu0Yxh//i1jNWtKnNPCfg1xn3saGMHxlKfSj3XztmKdX8vTnM7M5C0
	R8OFJI9nvv+TC2WyXYmWG1bOrxp9q4xaMUhoiuvMMLAepbmULKg1
X-Google-Smtp-Source: AGHT+IGb/Tw3XGNhOyfvK3yRw4V3NFMG20lg3pc2PVS38GELaklkOPObegfstg6VozJB2qusMOgTAw==
X-Received: by 2002:a05:6a20:c888:b0:1a1:87c7:2d03 with SMTP id hb8-20020a056a20c88800b001a187c72d03mr2484994pzb.33.1711529620366;
        Wed, 27 Mar 2024 01:53:40 -0700 (PDT)
Received: from peter-bmc.dhcpserver.bu9bmc.local (2001-b400-e383-3566-013c-5a87-9abc-381e.emome-ip6.hinet.net. [2001:b400:e383:3566:13c:5a87:9abc:381e])
        by smtp.gmail.com with ESMTPSA id h12-20020a170902eecc00b001e0501d3058sm8356848plb.63.2024.03.27.01.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 01:53:40 -0700 (PDT)
From: Peter Yin <peteryin.openbmc@gmail.com>
To: patrick@stwcx.xyz,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	linux-watchdog@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] ARM: dts: aspeed: Add the AST2500 WDT with SCU register
Date: Wed, 27 Mar 2024 16:53:27 +0800
Message-Id: <20240327085330.3281697-2-peteryin.openbmc@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240327085330.3281697-1-peteryin.openbmc@gmail.com>
References: <20240327085330.3281697-1-peteryin.openbmc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AST2500 WDT references the System Control Unit
register for its operation.

Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
---
 arch/arm/boot/dts/aspeed/aspeed-g5.dtsi | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
index 04f98d1dbb97..5fd12c057c31 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
+++ b/arch/arm/boot/dts/aspeed/aspeed-g5.dtsi
@@ -410,12 +410,14 @@ wdt1: watchdog@1e785000 {
 				compatible = "aspeed,ast2500-wdt";
 				reg = <0x1e785000 0x20>;
 				clocks = <&syscon ASPEED_CLK_APB>;
+				aspeed,scu = <&syscon>;
 			};
 
 			wdt2: watchdog@1e785020 {
 				compatible = "aspeed,ast2500-wdt";
 				reg = <0x1e785020 0x20>;
 				clocks = <&syscon ASPEED_CLK_APB>;
+				aspeed,scu = <&syscon>;
 			};
 
 			wdt3: watchdog@1e785040 {
@@ -423,6 +425,7 @@ wdt3: watchdog@1e785040 {
 				reg = <0x1e785040 0x20>;
 				clocks = <&syscon ASPEED_CLK_APB>;
 				status = "disabled";
+				aspeed,scu = <&syscon>;
 			};
 
 			pwm_tacho: pwm-tacho-controller@1e786000 {
-- 
2.25.1


