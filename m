Return-Path: <linux-kernel+bounces-143863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B7C8A3E75
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 22:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 985151C20FFE
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 20:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575F955C3E;
	Sat, 13 Apr 2024 20:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g03FBwMw"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324F83FE55;
	Sat, 13 Apr 2024 20:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713039769; cv=none; b=bT00fwi/4+Wnjg8f1lQRuJBKCzn0/EkHfql5aVEHedEEhxNZ/bEz+lDefF14J/wc6yFlQdyZulQ5I4OfYzWPhoco8/2sPMsfs7A6OLArNq1Cs0Xh/YKD3FFXnrlMvIGUu/cKPI9kKmFVnT/WqHnSNwQ4DIze4xQRXqLZ+cgDJPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713039769; c=relaxed/simple;
	bh=Q2/PcLOdGvifsb0OrilHhlY/IiPhNM4DytJOdAt+KtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=asdAKsJEpCQY8r3nVP0abHXfFnHSXV7A88Ka73qhCixDY3Awzemjf9P1+bl+7bNEbgeq61HonEJ/jyIjTiCvULfaz42dhRvu46e96RPy5/hY5cQuy3+fkfSdn4cg/FLjJvI1Ouy0rEhcSrp8NF5/l2Tp2pV6gerQ2IfLFSiqTGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g03FBwMw; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-56fffb1d14bso2661324a12.1;
        Sat, 13 Apr 2024 13:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713039766; x=1713644566; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mlncqStkvETVCUs6zj718afM59TCNUlcR1fhhEtKfCE=;
        b=g03FBwMwJtFhLBbY2D5ptOJaEXY+OxZQsqkwe1VfMxCwmEb0exnPKVemc9uwxSeiEu
         eECtf2JQxvdWcRtHhx1H/+TYmbYErIM1lblUm3u1GzZOLtonQiHEoyTg9bjEIScniaEW
         lcxwW+w24O/PL68DB+PMNA8ucBbUlSyjoqsVJYo9fppl7DLPKhaem6MzEui9CtgJ4sQ/
         zW3JjRDpoeD6OBJNm2MKT/ArYHUvKvUWOZNBFtBQaxNSwxLtkKRXUUujBQrGzw3AoPx+
         SISOC/2tME4HeqIv+XQbLGOqlGLITWQwK1wsk8ItXYD3fq5HqcYh0QAIeT9yAkUV2JJv
         cV2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713039766; x=1713644566;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mlncqStkvETVCUs6zj718afM59TCNUlcR1fhhEtKfCE=;
        b=TARaNoxyoMNo0WdXXepz7ctZRRS/laHL9AhuDjfUOq5q6VQmQdsvHXcVgULwu7mKAu
         3JRhH93Vx0M5KBa23r3QMb72vPjor38qrOoy9OukqcNyfkYRZLLTsGj9RZsJuwQZUM7A
         22sx+aLyh4KQFNrx9DvQLsnRJ+Es6zW7A4AK5S29xI47SmHR6AizGK0NFa3qW6EZDGYT
         mvv6jFW3G8jFZt3QFUK8DsqqT9/lnSnReZWf7osPONEbspEAToC8BfdwmOK+2oqo3o09
         UuGD1hizhjMdEAEckoYy59vzPSoeNnrdwEIRvSQ3MdQHg3m1Oeb/W69cjhNtbnUVQ/te
         F5Cw==
X-Forwarded-Encrypted: i=1; AJvYcCUDAwxUvSmkOHb99+0oZgyOfyJ/ZFPqt/FymSM1BJbQZv/U7ch8MbDqtWfQh7qaw+WjuIKTh99ANS3KDsnGRl9wMIqXlvJ1Jg73+RUyuP26j0vMiFczVOXkxaUyoBECRrmTzpn+Qkfq0Q==
X-Gm-Message-State: AOJu0YzO3eJ+z093v/+ki9aqVWIt5qFbUn2PPFPopnw/JfE/Qxpkq1ur
	9fCZCetdcW295LzldqaO7sDFa/0i2ynNNT0l9KH7JlIifjM8SLke
X-Google-Smtp-Source: AGHT+IFxJMdB4pyARx3Aawi3IFzs2nXj+ryWbAKjAxJvsPXVxaHcoc6IA0BRjiO7OEU63KcFBwK6Vg==
X-Received: by 2002:a05:6402:2483:b0:56f:e7fe:6416 with SMTP id q3-20020a056402248300b0056fe7fe6416mr7532268eda.5.1713039766540;
        Sat, 13 Apr 2024 13:22:46 -0700 (PDT)
Received: from [127.0.1.1] (84-115-213-64.cable.dynamic.surfer.at. [84.115.213.64])
        by smtp.gmail.com with ESMTPSA id f16-20020a056402161000b0056e2f1d9152sm2881222edv.93.2024.04.13.13.22.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Apr 2024 13:22:46 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sat, 13 Apr 2024 22:22:16 +0200
Subject: [PATCH v3 1/4] arm: dts: nxp: lpc: lpc32xx: drop 'clocks' form rtc
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240413-rtc_dtschema-v3-1-eff368bcc471@gmail.com>
References: <20240413-rtc_dtschema-v3-0-eff368bcc471@gmail.com>
In-Reply-To: <20240413-rtc_dtschema-v3-0-eff368bcc471@gmail.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Vladimir Zapolskiy <vz@mleia.com>, Joel Stanley <joel@jms.id.au>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-aspeed@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713039763; l=881;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=Q2/PcLOdGvifsb0OrilHhlY/IiPhNM4DytJOdAt+KtY=;
 b=vW9T9O08KRg4Tk31a33U5au8ur+G1CxQM5yQmbHVaTcG7YJwzkC5L6cslsx1y2Cb6oKXWEHMV
 4EKBRC1ug7EBOBJOMAYRJc1q9ceXcMmj0g12hxQk14EElmgr3JwLwzl
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

The RTC does not provide a controllable clock signal (it uses a fixed
32768 Hz crystal, the input clock of the SoC). Remove the 'clocks'
property to better describe the device and avoid errors when checking
the dts against the nxp,lpc3220-rtc binding.

Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi b/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
index 974410918f35..f78d67e672b4 100644
--- a/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
+++ b/arch/arm/boot/dts/nxp/lpc/lpc32xx.dtsi
@@ -384,7 +384,6 @@ rtc: rtc@40024000 {
 				reg = <0x40024000 0x1000>;
 				interrupt-parent = <&sic1>;
 				interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
-				clocks = <&clk LPC32XX_CLK_RTC>;
 			};
 
 			gpio: gpio@40028000 {

-- 
2.40.1


