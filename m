Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0914780B58A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 18:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbjLIRay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 12:30:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjLIRar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 12:30:47 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969331700
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 09:30:53 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54917ef6c05so4397613a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 09:30:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702143052; x=1702747852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oi6zjNJ0tkdcdWyt4uob3FWVkKt/0zdiNoz3WNfhreM=;
        b=kBrqIJu0UrRpjnr6h1LvAVVKwDAZn5PCPrsfNVHLkCBFJjWbCORMac1+262ndyqkac
         ah9upcam68vUKWYBYfH8IBUMAEwfdEFdKRAT0K+HUvYPafSYzF1M3KIs2j0R4MCq4QPm
         aPxMTbc8B05Nv2DOkpNoVeIOaSaJgbRZrlpXT9M4U4wVPGVF8JEvZr2U2l9CnBm2RkzZ
         mPMKXEbqxyewJAGWHSLlRNlTY0a/LT+UN7u+r3mWP6uUmpMZ1f2DCaXTQH6UaqX6My2i
         H77dkDVe87WgArLiefWKZ44xM1rFFSb4vyChtSeXJz6FSKmiSdi3eftDn14v6U/KSBcy
         phsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702143052; x=1702747852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oi6zjNJ0tkdcdWyt4uob3FWVkKt/0zdiNoz3WNfhreM=;
        b=sXUj3eb1BmtUjpRSsHTiyEdRmCswvYFAANs8xF2tfSPpaNS7B7uM75r1uB2tNlx4ZV
         pjDuxygoHM6k5hQtboA4v8tQowuDEia8ds6+heWBcTT9z6FzaF/mZ9K8aPBn6HDyaf6b
         rjH6vOF6vjbdQh4xZYNszE0FZpxa02jjT9cHbwF77LcflsVLvawuFMzWDASaXcYL8bTl
         ufQcMQokT2u1OYIDqi9IKKebZCRWvyO7MAle4p3xhoMVFhq/pDJZneCZFgGNYBKDqd7M
         pUKGo2fV8p8RrGy+2+baASAAaGEgaLKo3RmEiu7h+g33IVz5vulWlUVe4DcidukLxMb2
         31HQ==
X-Gm-Message-State: AOJu0YwRKurYiUDiCwQKILiTnvVRWrbd55MLKXJPugHrdwVa/qOpGzEd
        6F/5WAANSeNpg65/PT5m8OdfSw==
X-Google-Smtp-Source: AGHT+IFtkVuwCzGuETlG5QpL41KJmafJfxmhbkSW9IsoDZa/ET3Fi8eQ7SCvtI/E8kmWLMc3t2DSow==
X-Received: by 2002:a05:6402:2152:b0:54c:4837:7d0a with SMTP id bq18-20020a056402215200b0054c48377d0amr740518edb.73.1702143052021;
        Sat, 09 Dec 2023 09:30:52 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id m26-20020a50931a000000b0054ce5c00e74sm1926621eda.88.2023.12.09.09.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 09:30:51 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 04/15] arm64: dts: socfpga: stratix10: add clock-names to DWC2 USB
Date:   Sat,  9 Dec 2023 18:30:33 +0100
Message-Id: <20231209173044.257684-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209173044.257684-1-krzysztof.kozlowski@linaro.org>
References: <20231209173044.257684-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DWC2 USB bindings require clock-names property, to provide such to
fix warnings like:

  socfpga_stratix10_swvp.dtb: usb@ffb40000: 'clock-names' is a required property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
index 439497ab967d..1a743787fef6 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
@@ -510,6 +510,7 @@ usb1: usb@ffb40000 {
 			resets = <&rst USB1_RESET>, <&rst USB1_OCP_RESET>;
 			reset-names = "dwc2", "dwc2-ecc";
 			clocks = <&clkmgr STRATIX10_USB_CLK>;
+			clock-names = "otg";
 			iommus = <&smmu 7>;
 			status = "disabled";
 		};
-- 
2.34.1

