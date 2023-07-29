Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF7A767FA4
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 15:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjG2NpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 09:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231326AbjG2NpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 09:45:10 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F38D44B9;
        Sat, 29 Jul 2023 06:44:40 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-68706b39c4cso1554310b3a.2;
        Sat, 29 Jul 2023 06:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690638260; x=1691243060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1yDKZhSFyl6Vqkq5lJY1PJ7SBhTOo01CltEmeQrjW88=;
        b=Ck9iXAzLlAoDyGGjv9AB+7dbgnS2JB2RNp0Qyttqmrn8JhrM3rIjphTHjFLcNbjZwR
         r6ZTVLu+xcJ4Aod11ETn/2aAEOD5P2ioHHkVd5TX6GSBJ1GGUGcUsQvT75ueTm+ku3EQ
         NwmcADS4onEuUT58X0rZotXzVJfDc1/sPRNEWB11KMUNr6TmZQPwoh3vhkQUdsokGXL2
         CbQ36pb2NdNXkALC9MDly9myERrSC+vHx4q6rFRKoR9KRFc7/hrA7RWqOXjHVJ3pZa7o
         dIdgf92FDXc0eiXM0e3oMFiLF+X38tc+DVU7heh89hv7Rqy0MzeoA0eHv6RAh4kRyxKy
         9nqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690638260; x=1691243060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1yDKZhSFyl6Vqkq5lJY1PJ7SBhTOo01CltEmeQrjW88=;
        b=SYWS7+SBbRUXgt7s9KzhtFRQTyu+5RLGQI4bT7d9AHZalG2HHRsahCrKyir4U+rql4
         D47RU1aLmr3nPRrKNf474Pfi3CAkAeGMDMlgAxHyyAtQ32WponfHYoMf9RUWdD4Y4Gfy
         WaKbuygNWjFCiEOX6feHcQste5rD2EygrGKUzBjCzP33WR0H5TXzu0DguiS2HfLN3xFs
         vtS1hVyzLICj6Eq1OQXRVo5Wy125wTAAzpEqd51AViU5HVL74SEH3CkRpScbU7diP2Yr
         po8jBlGNNjwQE6QVPBY3ituo/kLShL1KyI0DxeBSFH29lDZBTZ2OdfUFtCDr/5FsIfXD
         BFfQ==
X-Gm-Message-State: ABy/qLa9l+08HhnRAPzRBKpKuJw0H01GXKUIxzeNPM6fRfuSlTllAe3N
        CFaBQW0iVZREQe1xOCv/RKSyPMfgV+Ox1g==
X-Google-Smtp-Source: APBJJlGX/V/ze/Yj7BsV2vQg3wuknCt0iGvZdnweqqbEUmlCzURJDnCW0CCcGQ0bYnkVGZYvmRlR4w==
X-Received: by 2002:a05:6a00:1150:b0:675:ef91:7922 with SMTP id b16-20020a056a00115000b00675ef917922mr4952193pfm.4.1690638259866;
        Sat, 29 Jul 2023 06:44:19 -0700 (PDT)
Received: from kelvin-ThinkPad-L14-Gen-1.. ([38.114.108.131])
        by smtp.gmail.com with ESMTPSA id x13-20020aa793ad000000b006871bea2eeesm1257166pff.34.2023.07.29.06.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jul 2023 06:44:19 -0700 (PDT)
From:   Keguang Zhang <keguang.zhang@gmail.com>
To:     linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Keguang Zhang <keguang.zhang@gmail.com>
Subject: [PATCH 14/17] mips: dts: loongson1b: Add PWM timer clocksource
Date:   Sat, 29 Jul 2023 21:43:15 +0800
Message-Id: <20230729134318.1694467-15-keguang.zhang@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230729134318.1694467-1-keguang.zhang@gmail.com>
References: <20230729134318.1694467-1-keguang.zhang@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the device node of PWM timer clocksource
for Loongson-1B boards.

Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
---
 arch/mips/boot/dts/loongson/loongson1b.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/mips/boot/dts/loongson/loongson1b.dtsi b/arch/mips/boot/dts/loongson/loongson1b.dtsi
index d7f5cebae0a9..624eb179b6f5 100644
--- a/arch/mips/boot/dts/loongson/loongson1b.dtsi
+++ b/arch/mips/boot/dts/loongson/loongson1b.dtsi
@@ -79,6 +79,16 @@ clkc: clock-controller@1fe78030 {
 		clocks = <&xtal>;
 		#clock-cells = <1>;
 	};
+
+	clocksource: timer@1fe5c030 {
+		compatible = "loongson,ls1b-pwmtimer";
+		reg = <0x1fe5c030 0x10>;
+
+		clocks = <&clkc LS1X_CLKID_APB>;
+
+		interrupt-parent = <&intc0>;
+		interrupts = <20 IRQ_TYPE_LEVEL_HIGH>;
+	};
 };
 
 &ahb {
-- 
2.39.2

