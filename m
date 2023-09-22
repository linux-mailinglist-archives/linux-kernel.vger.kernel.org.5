Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2C17AA666
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 03:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjIVBMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 21:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjIVBMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 21:12:24 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB9DFCC;
        Thu, 21 Sep 2023 18:12:18 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2c00b37ad84so28144111fa.0;
        Thu, 21 Sep 2023 18:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695345137; x=1695949937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+Rq82wx/J2BnMt9Mh1FLCBxp+NcwkPBk3LgXjrklglE=;
        b=fNBqvxnKsSSWVewrSz8ANnaRPSA+vYHsGWDqzpjqBx1U34KhT38p8vgh+qVUyDfR3b
         j0W8Vf8EbBssackNH64pV7Hjl0d+iU8aMe6p1ran1AjApv0Su09SAYLDtF9BJWCdWIpZ
         6xgoFLPvqaRci4mdEOwWHsqFsKuXNcn9VdcLvOpAsu+GvuC47ty9rblxhtpGPtiRxjU3
         ZqihiLJ1LjeKIlvC4RNoDbYixAwWVs2a/G85ZGVC8wDapvrsJMK3bIwuqDKoHNpNMChc
         MLYXi7XJgdnXoQp8c0g90GijfPAqP12MD1/yHnW8qZ2JV9IP3i17TAtsoElm96MRgOf7
         rR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695345137; x=1695949937;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+Rq82wx/J2BnMt9Mh1FLCBxp+NcwkPBk3LgXjrklglE=;
        b=FcdFch78L+OB8wbo39o6hCQ2nru/Ep08DlUAoO7lVcCPRuO3Vob70hlM0432Nsq+wA
         LqdUEhL9pVuahPZv87r6ttWqfK5AhWrMeFMedU7nh9jIHWaE5GHdEB7p/4feek3vteBB
         dm9WYP10zoTIAGwhLoZgdCm+52jlsgbXa7vJuwAFByS9T3RELfkj93eUNq2Qc9h+HsdA
         np+pQWlVVKr4gE+zaztiWDLuOEE7pWma8u18d+xVz7eryquCcYcyd3ZkuO3+FsfOulru
         s9zL8n2UgtHZBH0KdipYI+1fMI0M02jt3wLCZrIMkM+aOMkgxMH1590RO1Q1d/JJ9hLL
         +SWg==
X-Gm-Message-State: AOJu0YylfA5FLnxVRhksmSj5JW+uDTan/Y/9EMMZxflgP0SFdBfGGLKc
        A8fDjR1SPh9LhOYsdv/RYbTFL9mvQVe8Dw==
X-Google-Smtp-Source: AGHT+IHcUyeJmxxV2sQ3q19siVjabbSs1LW6kJYyDzbwc1nSxLC9hL0WXQXDMCU3cO/jSZxEAf4CWw==
X-Received: by 2002:a2e:98cb:0:b0:2c0:2124:7a06 with SMTP id s11-20020a2e98cb000000b002c021247a06mr6138901ljj.45.1695345136772;
        Thu, 21 Sep 2023 18:12:16 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id l6-20020a2e7006000000b002b6e77e87fcsm609446ljc.68.2023.09.21.18.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 18:12:16 -0700 (PDT)
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
Subject: [PATCH] ARM: dts: qcom: apq8026-samsung-matisse-wifi: Fix inverted hall sensor
Date:   Fri, 22 Sep 2023 04:12:11 +0300
Message-Id: <20230922011211.115234-1-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Fix hall sensor GPIO polarity and also allow disabling the sensor.
Remove unneeded interrupt.

Fixes: f15623bda1dc ("ARM: dts: qcom: Add support for Samsung Galaxy Tab 4 10.1 (SM-T530)")
Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 arch/arm/boot/dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts b/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts
index 884d99297d4c..f516e0426bb9 100644
--- a/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts
+++ b/arch/arm/boot/dts/qcom/qcom-apq8026-samsung-matisse-wifi.dts
@@ -45,11 +45,11 @@ gpio-hall-sensor {
 
 		event-hall-sensor {
 			label = "Hall Effect Sensor";
-			gpios = <&tlmm 110 GPIO_ACTIVE_HIGH>;
-			interrupts = <&tlmm 110 IRQ_TYPE_EDGE_FALLING>;
+			gpios = <&tlmm 110 GPIO_ACTIVE_LOW>;
 			linux,input-type = <EV_SW>;
 			linux,code = <SW_LID>;
 			debounce-interval = <15>;
+			linux,can-disable;
 			wakeup-source;
 		};
 	};
-- 
2.39.2

