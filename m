Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C91801CE0
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 14:05:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjLBNFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 08:05:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbjLBNFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 08:05:13 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3699B12D;
        Sat,  2 Dec 2023 05:05:20 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-a1975fe7befso291652566b.2;
        Sat, 02 Dec 2023 05:05:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701522318; x=1702127118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BXnPXvkgEdAqlxa28rDWBIXJg5QYtD+xYZlakCzCIA0=;
        b=ey+6joeiKw3fEBMXDgqo8VJ35Zk49VXYP+hMHIPXaqO11pvnusd4ga6JF5wfuGy6dk
         lb9rkaG3fLZVjZmzgdh/nTUhlrIYBtkKkOaBFmzIVo8M4KnsFI3WsamLlZhNVbJWwzkc
         Ldb87csBtzBqkGHRmgPZrvhl14FoucOsoQn/iLWZnRKYvJeYm/xSqmiVVVYF9FJy4SOu
         A/J+McGP17ngyzGopWDR5PPXw4ZwylPtL1J3ctkqmNKM0y9fCGkwcw9aqBeNJWpIA/Z4
         hnm0vNWMHuryP6pN7vQZIDlA6o8Rml7Phrkrwj4G7BtlcdZYaNCWk2vmTPcVmV31SBgN
         SR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701522318; x=1702127118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BXnPXvkgEdAqlxa28rDWBIXJg5QYtD+xYZlakCzCIA0=;
        b=ZcYs0rwHo8VK7YSP/c6PsVFWfTkD7CY4bdSR+oj1DwljTzjTKfQntL7fN9hjH+w5FQ
         P5o90H7QChXceFNbhQZwIt05GoT4qbKHbBjfDIw7J3hsqtYJ1uJXqh+L9iQ3W4tOZQlZ
         X3Y4VEDQJC+37sEqbPKVrqyQpnW4hzEzXumUGBNUY7/FGSYdY1jFeTbHGQlNILz6VheF
         RqAwAfra9ZpkaR6JIhdqXZoM/eXQY1QUOrq4g9nxNnCY8+zY3B3WAt4GG6A0usznJWnc
         OCnhAaIjRMf+UQeUEdbekEMq/S10VEOgIGbvkagrEFaIV25QbsDZDoTild0ttmAaOnF0
         2VrA==
X-Gm-Message-State: AOJu0Yx2OVQQWJqES9UEyWYwNajE5i1U2iN7UI+Qk1pLj4vIF7BJx3EA
        NTWjZ9+G/i5pBa4nAgHriSO4mv9GeQ==
X-Google-Smtp-Source: AGHT+IGoxNPqrzQnvQpxf09ljrKJcuFDtZ22xCNQN1xzBMU7KhiOpt13wtWf8ZZHmxNTvvRlv9Nqew==
X-Received: by 2002:a17:906:28d:b0:a19:a19a:eaa1 with SMTP id 13-20020a170906028d00b00a19a19aeaa1mr1635582ejf.90.1701522318738;
        Sat, 02 Dec 2023 05:05:18 -0800 (PST)
Received: from U4.lan ([2a02:810b:f40:4300:908e:b829:354b:f8ee])
        by smtp.gmail.com with ESMTPSA id bs5-20020a170906d1c500b00a0bf09c9483sm3045324ejb.35.2023.12.02.05.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 05:05:18 -0800 (PST)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH 2/3] ARM: dts: rockchip: Move i2c aliases to SoC dtsi for RK3128
Date:   Sat,  2 Dec 2023 14:05:06 +0100
Message-ID: <20231202130506.66738-4-knaerzche@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231202130506.66738-2-knaerzche@gmail.com>
References: <20231202130506.66738-2-knaerzche@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SoC TRM, SoC datasheet and board schematics always refer to the
same i2c numbers - even if not all are used for a specific board.
In order to not have to re-define them for every board move the
aliases to SoC dtsi for RK3128 like it's being done for all other
Rockchip ARM SoCs.

Signed-off-by: Alex Bee <knaerzche@gmail.com>
---
 arch/arm/boot/dts/rockchip/rk3128-evb.dts | 1 -
 arch/arm/boot/dts/rockchip/rk3128.dtsi    | 4 ++++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rockchip/rk3128-evb.dts b/arch/arm/boot/dts/rockchip/rk3128-evb.dts
index 776a483cc26b..c7ab7fcdb436 100644
--- a/arch/arm/boot/dts/rockchip/rk3128-evb.dts
+++ b/arch/arm/boot/dts/rockchip/rk3128-evb.dts
@@ -12,7 +12,6 @@ / {
 	compatible = "rockchip,rk3128-evb", "rockchip,rk3128";
 
 	aliases {
-		i2c1 = &i2c1;
 		mmc0 = &emmc;
 	};
 
diff --git a/arch/arm/boot/dts/rockchip/rk3128.dtsi b/arch/arm/boot/dts/rockchip/rk3128.dtsi
index 5b751284d6ca..dc149d98cf9e 100644
--- a/arch/arm/boot/dts/rockchip/rk3128.dtsi
+++ b/arch/arm/boot/dts/rockchip/rk3128.dtsi
@@ -20,6 +20,10 @@ aliases {
 		gpio1 = &gpio1;
 		gpio2 = &gpio2;
 		gpio3 = &gpio3;
+		i2c0 = &i2c0;
+		i2c1 = &i2c1;
+		i2c2 = &i2c2;
+		i2c3 = &i2c3;
 	};
 
 	arm-pmu {
-- 
2.43.0

