Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFAD751378
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 00:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbjGLWQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 18:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjGLWQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 18:16:47 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0980E199D
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:16:46 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b701e1c80fso118069271fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 15:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689200204; x=1691792204;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4qtQZvewa01bd3WNJlBR7VuLAaPubF3IprbkAp3R6jI=;
        b=T2altrG6dNzTVxPdyClkJw6UuED6zHa7UCunHa6cLY+LwlFbTD3B2BwAfohvJe8gh6
         pTpmZnkjw+1X0M/uNMTIcatfVlQVrJ4hHuYZX66VPchGp47Fy2Et2R1uSsNPhAcObUzM
         EX6ErPJGyHFHkPASUn6xIGmsxQ21uw7hTq222rCrwEvDOv55J5sjJDARy+7g45MGtgnf
         mGkCAuMQfUCz7W6wMxDGQiuexXt6/oA9yM7TgjqL0o2NsX+abR7jEhqQHSEZ5cIR6ib/
         wwOkb+EpaQ4b2toTE7CfeK1QltRTAJrFqE37roVWqf7tJH/Is6ameSiB+FJo1mcz/e5f
         S8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689200204; x=1691792204;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qtQZvewa01bd3WNJlBR7VuLAaPubF3IprbkAp3R6jI=;
        b=SaHWAHkciXDrM/UaITaD5zDASSe5Ddy/PYLSjmq9uwSBezBBua3Mcsn3t8/f1ogxcQ
         OSbqeTFsZg+U9/HhkC0vVtFpDIzwdTpIeihzJm8EdNHyQUEB2v5jjsH1M5FMZjb8Ohqm
         MrZFUkZQUCb6lEO1Q41u6gmBtnq8JYaDT/M5xv3oPPnN/QMr6JwFZ30Krd4r7OEAY+lr
         HSc/DIctmOK+aNtX5R/9QQMuryMnpfQodE10nJEoEgQ1SKhKTJWDuCEbRSuw7CpWRR+j
         v2M6mKc7ze59b3/raE4fSygRTg/PzZVpbW13tTx5iLFaXaGSQTHd8CyS1G7DaPYqd+R9
         4JWw==
X-Gm-Message-State: ABy/qLak9LRcAX6j4oHOrR5q15wmi6SDh65TMOwaGMTEjhnUCuf8H69G
        n+9JRmQlloF+OfrY46beQlwkrQ==
X-Google-Smtp-Source: APBJJlFlg0wg+oLTe0osO+qC/fBLQfjtsicmaKbj2TfVUiwnMm2ZtNyVk0imiu82DR14aN/jJPhZLw==
X-Received: by 2002:a2e:9d04:0:b0:2b6:e8a0:a7f8 with SMTP id t4-20020a2e9d04000000b002b6e8a0a7f8mr16540965lji.31.1689200204409;
        Wed, 12 Jul 2023 15:16:44 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id b19-20020a2e8953000000b002b6e00a3e19sm1177774ljk.132.2023.07.12.15.16.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 15:16:43 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 13 Jul 2023 00:16:42 +0200
Subject: [PATCH v4 2/2] ARM: dts: bcm5301x: Add SEAMA compatibles
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230713-seama-partitions-v4-2-69e577453d40@linaro.org>
References: <20230713-seama-partitions-v4-0-69e577453d40@linaro.org>
In-Reply-To: <20230713-seama-partitions-v4-0-69e577453d40@linaro.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds SEAMA compatibles to the firmware partition of these
two D-Link devices.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts | 1 +
 arch/arm/boot/dts/bcm47094-dlink-dir-890l.dts | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
index 555fbe41dd8f..cf3000b07eea 100644
--- a/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
+++ b/arch/arm/boot/dts/bcm47094-dlink-dir-885l.dts
@@ -33,6 +33,7 @@ partitions {
 				#size-cells = <1>;
 
 				partition@0 {
+					compatible = "seama";
 					label = "firmware";
 					reg = <0x00000000 0x08000000>;
 				};
diff --git a/arch/arm/boot/dts/bcm47094-dlink-dir-890l.dts b/arch/arm/boot/dts/bcm47094-dlink-dir-890l.dts
index d945a20b06e0..3551f855ff20 100644
--- a/arch/arm/boot/dts/bcm47094-dlink-dir-890l.dts
+++ b/arch/arm/boot/dts/bcm47094-dlink-dir-890l.dts
@@ -149,6 +149,7 @@ partitions {
 		 * partitions: this device uses SEAMA.
 		 */
 		firmware@0 {
+			compatible = "seama";
 			label = "firmware";
 			reg = <0x00000000 0x08000000>;
 		};

-- 
2.34.1

