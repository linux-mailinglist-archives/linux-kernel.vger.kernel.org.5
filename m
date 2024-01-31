Return-Path: <linux-kernel+bounces-46453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F39A1843FDD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 317631C27B98
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CDC67AE6E;
	Wed, 31 Jan 2024 13:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWryhVC6"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A4B7AE77;
	Wed, 31 Jan 2024 13:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706706004; cv=none; b=NWD/r6mat4lxyeULnFo7Kdk/Z5/skFY48Taw1lSyVTclohbYsO2IQKcYztMDIMn4L4iGptsDQmgwl9rfrM60qJzDFuNgzXfPl+gt+p5Vl93t/Q7Q8R/uo4TNVxj4B5Hbx6JcSVaD8iydp8vcDEl7g198+dy969ILh7IihLrdC68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706706004; c=relaxed/simple;
	bh=o9E9ecVEg59roajJUTj0tBIXTNYmbmyw1ntarzjaXAA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WLdX7pzu8TR9h+3iUuq0yM3mjDRSjUMXTnDDjp+nweKOIsIObJ8sTcE/InS6R1Dws3SbkzqHnkdGKIN9XzKDJ+Q8RsKR/eWjWKcP39f6WpJvQ1XddccJBovgsiu07RXj4IB4N8xvuvtRj5hZe/T49XBPxhg7CuJuAWzjbtLIdcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWryhVC6; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d043160cd1so41995511fa.1;
        Wed, 31 Jan 2024 05:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706706000; x=1707310800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qk5axihAKFS9+0dIUTMZ/jrL2YTkFropx3eyJ2mG6qU=;
        b=TWryhVC66Q3S0YPXg3zoZJMIvLpNudHoTn2NUWbTvVFxELIGKK6PA0IK1oAUPxeoOP
         ZCstzxmsfSkyr+rsRdXE4/n1QKidHq1lZKrIJBZbVc6ibZWUmO4b+iTOUTeUzr8n5316
         WRUER4qODGIzSXXJzGUaLiiZSStX29yTrt+f38bbOpiOmlmyLmdL4STywrDT2kG16tof
         FdzpVjL57Ciq4p5T1fEpsCysJLX3T9yb2LlCEk3od2iNYq10jJdv2u5WBfeV0FRo+LV/
         ln+I7YytLa2vtvNE/eQwJXV9xoDwOyNCLVgnIQKZ8UsaUvxc25JMGyqDrUBE6l9VlsjV
         pz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706706000; x=1707310800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qk5axihAKFS9+0dIUTMZ/jrL2YTkFropx3eyJ2mG6qU=;
        b=a60JoV5vS7xovzPWoJukXVpau2iur8Av7yyNyUrW0jdNP0qqWTdKv5aAIov7VepbrL
         QMS3tw6DyVLsUVZqYqnU+9OYRIyh6yQwDelI/NSy3LoNX7dTkT62bM9K/KurAMvOmPmq
         4ZQ9vCKMQ/r03gZIH++4u1kjBcGDqL/t/MyvCoXxL2Or5tM0Qs2dgZk/OUQPZNZqWJnY
         e/Z8EXeZSCweNQ4rG/44p3X02UOZAIffk5fi4wpHZwbZim1WY0WobjuAamCq5uc+UvXy
         xjWUfC551B68gu5Vlq1SdM2otI7WxwpjwbplHVSwXheRHSUZCgJmyZQVxfDzXdJi8WVe
         ABZw==
X-Gm-Message-State: AOJu0YzNplm8IyXrXhune1BvFjarkLWnZ4771zIcEuG6ZCIGdD7Fzo6s
	EWxkr1G/5rwZDvefHr0F5UeshjlwkA3wdIPI+bFJtZJtnkypVJFbhmHKTvNd8OsIKyo=
X-Google-Smtp-Source: AGHT+IFlj/2UQlXVTsP85U+sX9Z4Xg+m+7M8urgFGxXNNIrMtV2ixCb6BE8A2Y9DZeChVhyFjSIIgA==
X-Received: by 2002:a05:6512:3b93:b0:511:1ed7:61bd with SMTP id g19-20020a0565123b9300b005111ed761bdmr1608967lfv.54.1706706000644;
        Wed, 31 Jan 2024 05:00:00 -0800 (PST)
Received: from localhost.localdomain ([188.162.49.60])
        by smtp.gmail.com with ESMTPSA id h25-20020a19ca59000000b00510faaa62cfsm1361135lfj.222.2024.01.31.04.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 04:59:59 -0800 (PST)
From: Aleksandr Shubin <privatesub2@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Aleksandr Shubin <privatesub2@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Maksim Kiselev <bigunclemax@gmail.com>,
	Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	John Watts <contact@jookia.org>,
	Cheo Fusi <fusibrandon13@gmail.com>,
	linux-pwm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-riscv@lists.infradead.org
Subject: [PATCH v8 3/3] riscv: dts: allwinner: d1: Add pwm node
Date: Wed, 31 Jan 2024 15:59:16 +0300
Message-Id: <20240131125920.2879433-4-privatesub2@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240131125920.2879433-1-privatesub2@gmail.com>
References: <20240131125920.2879433-1-privatesub2@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

D1 and T113s contain a pwm controller with 8 channels.
This controller is supported by the sun20i-pwm driver.

Add a device tree node for it.

Signed-off-by: Aleksandr Shubin <privatesub2@gmail.com>
---
 arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
index 5a9d7f5a75b4..435a1e66aa6a 100644
--- a/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sunxi-d1s-t113.dtsi
@@ -145,6 +145,18 @@ uart3_pb_pins: uart3-pb-pins {
 			};
 		};
 
+		pwm: pwm@2000c00 {
+			compatible = "allwinner,sun20i-d1-pwm";
+			reg = <0x02000c00 0x400>;
+			clocks = <&ccu CLK_BUS_PWM>,
+				 <&dcxo>,
+				 <&ccu CLK_APB0>;
+			clock-names = "bus", "hosc", "apb0";
+			resets = <&ccu RST_BUS_PWM>;
+			status = "disabled";
+			#pwm-cells = <0x3>;
+		};
+
 		ccu: clock-controller@2001000 {
 			compatible = "allwinner,sun20i-d1-ccu";
 			reg = <0x2001000 0x1000>;
-- 
2.25.1


