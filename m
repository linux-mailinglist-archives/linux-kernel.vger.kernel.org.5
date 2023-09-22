Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FDF7AA623
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 02:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjIVAgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 20:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjIVAgE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 20:36:04 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB19A192;
        Thu, 21 Sep 2023 17:35:58 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2c012232792so26786441fa.0;
        Thu, 21 Sep 2023 17:35:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695342957; x=1695947757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AfoMHihfovaHfyKxqDS+0qJZLmze+vosMqpYMgWqQy4=;
        b=D47y6dOwMus8BRmoCGQQtJnHTlBHZzFrfbS18Zl1mbGueDjMbarsWzWBUQfA5z3eqA
         kXUgvi4RcNGED90d80mQS6+sFqen41mEA9a81x+LQoqrDv/nrIZzvw9qgWDEBSOhgvFP
         U+mg6OXC6VfzMYuJpWf02TXHN3KKy4SdjymZIfRiB/gDicBdEmU0mFnwpHkW+PV5ENI3
         te3LtE6v8ImaDHc9TR7WqjtRTMn4YVePfqB8QQUZWavn6EElYiMQ1agcqRSOsjbGqMve
         XZmAlAXRsfGTAGAwhdu+RSiLAKYXc8/qyuVk4qBcG1M1L4N+q1Ajrk3LclXHSs13bbkH
         e9NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695342957; x=1695947757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AfoMHihfovaHfyKxqDS+0qJZLmze+vosMqpYMgWqQy4=;
        b=NfaaCzcloLAdfF8ttkgq7w/sRQVeVt1KooVjU7jCXyJG/3CSlguAJ2iQUDyo2kgJ4S
         VuUy4HsgZQVGOcQRzQOYxTJihcmUMhPBj5/SIk4lyOZ5yadgpJ6Z8CUo3BQ0++lCKm9Q
         U2xwblHegnAkqR/xdiJ5tjr5Sz/HOwMQaCz2WrlgoBmcAEajam0oRsuzUSs3b9T5bG7S
         qUzIUYs/j+lhE7vkyanN3LJmNawJnpTi3kmhKEg0yRyXdedKJoYn+K7o34EGUkzlsbYD
         ClI1qshxWVwZVyHYtVj9bh6O6MsNLfC5YAABgOcXnLTzTJVI4sFy3Kw9IMn0QDoVQo++
         V1RA==
X-Gm-Message-State: AOJu0YzES0Jp/YqUPvddBeyWoLjeoNCRI87113IaMb7ewvmMvBQwMEsI
        xn1KOpLQzBR88jiw8IbvoyxsaKC2kDQVGQ==
X-Google-Smtp-Source: AGHT+IE8jLPzi93ThtNWNZKAEOE4YXeG4ZcjOzA8Mse4BqvWpUBAD/Q7FFbDe8eaPhRKlTj9J/xHLQ==
X-Received: by 2002:a2e:b605:0:b0:2c0:33be:3530 with SMTP id r5-20020a2eb605000000b002c033be3530mr6370803ljn.45.1695342956926;
        Thu, 21 Sep 2023 17:35:56 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id j23-20020a2e3c17000000b002bff365c7bfsm615462lja.35.2023.09.21.17.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 17:35:56 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: qcom: msm8974: Add rpm-master-stats node
Date:   Fri, 22 Sep 2023 03:35:33 +0300
Message-Id: <20230922003533.107835-3-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230922003533.107835-1-matti.lehtimaki@gmail.com>
References: <20230922003533.107835-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add rpm-master-stats node for MSM8974 and the required RPM MSG RAM
slices for memory access.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 arch/arm/boot/dts/qcom/qcom-msm8974.dtsi | 32 ++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
index 706fef53767e..0bc2e66d15b1 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8974.dtsi
@@ -116,6 +116,18 @@ pmu {
 	rpm: remoteproc {
 		compatible = "qcom,msm8974-rpm-proc", "qcom,rpm-proc";
 
+		master-stats {
+			compatible = "qcom,rpm-master-stats";
+			qcom,rpm-msg-ram = <&apss_master_stats>,
+					   <&mpss_master_stats>,
+					   <&lpss_master_stats>,
+					   <&pronto_master_stats>;
+			qcom,master-names = "APSS",
+					    "MPSS",
+					    "LPSS",
+					    "PRONTO";
+		};
+
 		smd-edge {
 			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
 			qcom,ipc = <&apcs 8 0>;
@@ -1067,6 +1079,26 @@ gcc: clock-controller@fc400000 {
 		rpm_msg_ram: sram@fc428000 {
 			compatible = "qcom,rpm-msg-ram";
 			reg = <0xfc428000 0x4000>;
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0 0xfc428000 0x4000>;
+
+			apss_master_stats: sram@150 {
+				reg = <0x150 0x14>;
+			};
+
+			mpss_master_stats: sram@b50 {
+				reg = <0xb50 0x14>;
+			};
+
+			lpss_master_stats: sram@1550 {
+				reg = <0x1550 0x14>;
+			};
+
+			pronto_master_stats: sram@1f50 {
+				reg = <0x1f50 0x14>;
+			};
 		};
 
 		bimc: interconnect@fc380000 {
-- 
2.39.2

