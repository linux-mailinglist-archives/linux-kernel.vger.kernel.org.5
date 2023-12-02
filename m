Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C32801E17
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 19:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjLBSWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 13:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBSV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 13:21:59 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA54BFF;
        Sat,  2 Dec 2023 10:22:04 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54af4f2838dso3947599a12.2;
        Sat, 02 Dec 2023 10:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701541323; x=1702146123; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TyFCiKZiHWD5dcEIPfQHHPlDxT1woqLl54OWaAFXfos=;
        b=FfvvRKPCccA6kFiUOHkD1J4+b/HM0jj9Q10nUfqnJkNent3Fg7za7i6mMDjpd4j7as
         7QTutoDDY4iuVg73nxGfkm1fX7S7e9Be65DZQTJYhkgcgUtrdWXpiiGyPVSSjqpBxW+6
         E8JPztVyVX4UQAIp7GJvjKWS1wfRjr0A7rniO4OyxkDdOnVMuSwpRKG8DPdJehZcoFM0
         0+8ahklCPC/wJ7upuWRB5r3uuq20M+3PNRX2Y2v9VRUobDMKV1xMpJcfPhA4ECLv9wnm
         nNyXjUHJV+K9fJx+LOhoo/1AwCEaxaot3jUkwcx+8rPzBdEF8bd0U4TiyvHDNY2GPASe
         jEkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701541323; x=1702146123;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TyFCiKZiHWD5dcEIPfQHHPlDxT1woqLl54OWaAFXfos=;
        b=bEaypq72eo78RaRFd9QuN+4GMUJ+ub10gB/pu4C6p36WYz8cBaMrZBl4oXcRhSZmcG
         XVBeXVqDRMQ+caAIS9NRypSB3Qsvkxu7oRrRDUe1p29zOMsY6bCMkE2xUZTnvqW2/jWn
         PMkY7SXF0lJ52a6w4PXJ+mVkeYiYdG408XQ8Jehh96Tp3ZxwgNVtLFvsLt+TeNo2LG2z
         ERWhgJIF6KNK3/3ib7/GNONPCwyuZgumSMQZes72jRMNjuV6lYID/LfE7bWOno5dO+uW
         Px7/4eAgHTHkvEFrd+k6sXDGrB23emBQow7P9CD85m09+fBehusU6qojFeWDyPitdlVF
         TqFg==
X-Gm-Message-State: AOJu0YzhinLXFZm3FQVBcvoDhgWN1G4CicPWnjy/RqhHOfP9o/zGBoYW
        7BdPQsmXbRE0VQHfaAWaEpk=
X-Google-Smtp-Source: AGHT+IGjhja9zQfmHEPloTPetsXirLklrAI+SSzAqtY1tPIIcu8nnQ8h24bB3rkMbTIyy3R/7qu9Hw==
X-Received: by 2002:a50:bac5:0:b0:54c:4837:93fc with SMTP id x63-20020a50bac5000000b0054c483793fcmr1938993ede.67.1701541322838;
        Sat, 02 Dec 2023 10:22:02 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q11-20020a50c34b000000b0054ca7afdf35sm57615edb.86.2023.12.02.10.22.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Dec 2023 10:22:02 -0800 (PST)
Message-ID: <89f2a229-9f14-d43f-c53d-5d4688e70456@gmail.com>
Date:   Sat, 2 Dec 2023 19:22:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 1/2] ARM: dts: rockchip: add gpio alias for gpio dt nodes
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jay.xu@rock-chips.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rockchip SoC TRM, SoC datasheet and board schematics always refer to
the same gpio numbers - even if not all are used for a specific board.
In order to not have to re-define them for every board add the
aliases to SoC dtsi files.

Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---

Changed V1:
  rebase
  remove rk3066 gpio5 alias
---
 arch/arm/boot/dts/rockchip/rk3036.dtsi  | 3 +++
 arch/arm/boot/dts/rockchip/rk3066a.dtsi | 5 +++++
 arch/arm/boot/dts/rockchip/rk322x.dtsi  | 4 ++++
 arch/arm/boot/dts/rockchip/rk3288.dtsi  | 9 +++++++++
 arch/arm/boot/dts/rockchip/rk3xxx.dtsi  | 4 ++++
 5 files changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/rockchip/rk3036.dtsi b/arch/arm/boot/dts/rockchip/rk3036.dtsi
index 78686fc72ce6..8aa2e0864fed 100644
--- a/arch/arm/boot/dts/rockchip/rk3036.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3036.dtsi
@@ -17,6 +17,9 @@ / {
 	interrupt-parent = <&gic>;

 	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
diff --git a/arch/arm/boot/dts/rockchip/rk3066a.dtsi b/arch/arm/boot/dts/rockchip/rk3066a.dtsi
index de9915d946f7..30139f21de64 100644
--- a/arch/arm/boot/dts/rockchip/rk3066a.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3066a.dtsi
@@ -13,6 +13,11 @@
 / {
 	compatible = "rockchip,rk3066a";

+	aliases {
+		gpio4 = &gpio4;
+		gpio6 = &gpio6;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
diff --git a/arch/arm/boot/dts/rockchip/rk322x.dtsi b/arch/arm/boot/dts/rockchip/rk322x.dtsi
index a721744cbfd1..831561fc1814 100644
--- a/arch/arm/boot/dts/rockchip/rk322x.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk322x.dtsi
@@ -15,6 +15,10 @@ / {
 	interrupt-parent = <&gic>;

 	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+		gpio3 = &gpio3;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
diff --git a/arch/arm/boot/dts/rockchip/rk3288.dtsi b/arch/arm/boot/dts/rockchip/rk3288.dtsi
index cb9cdaddffd4..ead343dc3df1 100644
--- a/arch/arm/boot/dts/rockchip/rk3288.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3288.dtsi
@@ -19,6 +19,15 @@ / {

 	aliases {
 		ethernet0 = &gmac;
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+		gpio3 = &gpio3;
+		gpio4 = &gpio4;
+		gpio5 = &gpio5;
+		gpio6 = &gpio6;
+		gpio7 = &gpio7;
+		gpio8 = &gpio8;
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
diff --git a/arch/arm/boot/dts/rockchip/rk3xxx.dtsi b/arch/arm/boot/dts/rockchip/rk3xxx.dtsi
index cb4e42ede56a..f37137f298d5 100644
--- a/arch/arm/boot/dts/rockchip/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3xxx.dtsi
@@ -16,6 +16,10 @@ / {

 	aliases {
 		ethernet0 = &emac;
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+		gpio3 = &gpio3;
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
--
2.39.2

