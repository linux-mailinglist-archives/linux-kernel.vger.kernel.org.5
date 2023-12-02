Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15309801E14
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 19:32:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjLBSW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 13:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBSWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 13:22:54 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F51AFF;
        Sat,  2 Dec 2023 10:23:01 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54af4f2838dso3948009a12.2;
        Sat, 02 Dec 2023 10:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701541379; x=1702146179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ptQy7vIkYjCFB+aa3cCw2vsywB20J1NTnue46LWtMms=;
        b=klk+KLJEUfsH9RnEPdSz4HCczyOyTIcqog5ZN7qVFv1zsz9yoBeaRqygN6WRn1AXLX
         Lk3dJ1X4jcPVQVMogLryAu1JbQtRAyq+lJ1wu1YN/LyR+rDR5/ZlnA5ktVrUzWQSzIvv
         tzb5FCEToIohZPqwmv3nAb5kDqduaYypPtCr9XeWHOH2PA5IW2mDYq9rsyDZSMaho98r
         DRo3WYQPLQlV6Fe+EWs//jRguxCs3PPbpRtWweXv9nqxlHy8QP0BX+lJW0ahh/vKpwbB
         Ne5mgX5JMyOKnx5WY3eboBImG3QlXEq0Y/LktOTV8dGIvyXrb5vMsEl0m2/WwegMl851
         P6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701541379; x=1702146179;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ptQy7vIkYjCFB+aa3cCw2vsywB20J1NTnue46LWtMms=;
        b=RWEE3+FzQe31f0+ClB9j0/wnFdYuzQ0GYrMtAdcu5Ngsr9e1zPWQMXKiSWyFPaj2Aa
         4MzTkdcaQaUrhSY55CbdsFjkWreZ9MQ42MQEo27c/F8KBPQllxRDj8ojJtYuZBqGAZ1L
         1950rOyHBrR35Hc5VTvj/WQ2t4eTwRjeoOQ+Xkif2DoPtJ6DqiqYoOerWF8sl0UBCLzO
         FnzueVTDmJDC/KrruZfyurVrZsEyFRf0nIOUD5N7Mu2U+Ey+dYtv6CraSF6WX1pTcmEY
         m4EeWx8QR7p4AGP+Z1RvOWxzWFnFsn93VEtZjEYijfnjo0/BT9dt43xDmHo2MpOl77q4
         dqEQ==
X-Gm-Message-State: AOJu0YxhJsoVVWHs5vDJkPEhCG6rfUKaH7M9Qpe8x2tFqLsVYG13w7An
        y92T15+QesjQw6RVuhihTyk=
X-Google-Smtp-Source: AGHT+IGFJofaaySUB8o0CkLPtrCC8WKyR8dvy8zqfrOR6kgqZUxVxqimQVEZGEmQTeq0qQ0rgDoQiw==
X-Received: by 2002:a50:8d06:0:b0:544:b0f4:f13 with SMTP id s6-20020a508d06000000b00544b0f40f13mr2025975eds.23.1701541379341;
        Sat, 02 Dec 2023 10:22:59 -0800 (PST)
Received: from [192.168.2.1] (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g9-20020aa7d1c9000000b0054bc8d34a23sm2876924edp.93.2023.12.02.10.22.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Dec 2023 10:22:59 -0800 (PST)
Message-ID: <56daeead-1d35-44bb-00c0-614b84a986de@gmail.com>
Date:   Sat, 2 Dec 2023 19:22:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   Johan Jonker <jbx6244@gmail.com>
Subject: [PATCH v1 2/2] arm64: dts: rockchip: add gpio alias for gpio dt nodes
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jay.xu@rock-chips.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <89f2a229-9f14-d43f-c53d-5d4688e70456@gmail.com>
Content-Language: en-US
In-Reply-To: <89f2a229-9f14-d43f-c53d-5d4688e70456@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
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
 arch/arm64/boot/dts/rockchip/rk3308.dtsi | 5 +++++
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 4 ++++
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 5 +++++
 4 files changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index 2ae4bb7d5e62..cfc0a87b5195 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -20,6 +20,11 @@ / {
 	#size-cells = <2>;

 	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+		gpio3 = &gpio3;
+		gpio4 = &gpio4;
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index e18f7c1c0724..76ea18bf11a0 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -20,6 +20,10 @@ / {
 	#size-cells = <2>;

 	aliases {
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+		gpio3 = &gpio3;
 		serial0 = &uart0;
 		serial1 = &uart1;
 		serial2 = &uart2;
diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index a4c5aaf1f457..fc7e3f2bc786 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -20,6 +20,10 @@ / {

 	aliases {
 		ethernet0 = &gmac;
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+		gpio3 = &gpio3;
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index da0dfb237f85..dec2705d035d 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -20,6 +20,11 @@ / {

 	aliases {
 		ethernet0 = &gmac;
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		gpio2 = &gpio2;
+		gpio3 = &gpio3;
+		gpio4 = &gpio4;
 		i2c0 = &i2c0;
 		i2c1 = &i2c1;
 		i2c2 = &i2c2;
--
2.39.2

