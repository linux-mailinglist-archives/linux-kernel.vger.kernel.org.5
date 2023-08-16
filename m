Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D2577E628
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344607AbjHPQPn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:15:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344650AbjHPQPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:15:22 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353AC2D48;
        Wed, 16 Aug 2023 09:15:01 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so8809020a12.2;
        Wed, 16 Aug 2023 09:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692202499; x=1692807299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRo0wEOJdVr9FA/EkBIE4ny8xfP0f3fZo+lmUorR//E=;
        b=EASagsdEq1KtdOkLHAqPqNj2uQcHAXKB7YwY9qYO3vgXGxlMUsqkbGNQ1+wk//wD+4
         boPrK/9hhwh1DcGJnN1ko3Pw/pfjS79JlbjtUmiK2phLRQ5qiQZEXG6QYg8/vMXeZW2n
         Mws7KDeJ+A7tKfliMYArO39D7tyAX+jgIY//AZJPch9v8RapOAcB6U1NwnOuMllCXIyV
         TD0QvaY8l+jkSc93IiC6PC196nSqSEutBq6OjVDrId8Mjp/4wb7PGB0CxfcNtaiI+pjU
         9S6lrC4jhWxi6JEHL+YBqZMNfZ8m8lgwaNyzCdPLc/CSveRaY2JaSwTMATtYSTo4DO3o
         8ZYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692202499; x=1692807299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRo0wEOJdVr9FA/EkBIE4ny8xfP0f3fZo+lmUorR//E=;
        b=BPd4SM7Xzyq9gqQzgbOnJKvI8Lfr1/pTo/W5xq6kCBOBX30tZIFuabHpTXtXfDc6OQ
         7AaZKozn/R5qTFF07zdsBHQbb1FeCLxWX3+axMNQ0Eb6vCLgDeQz38Lsfd9lbxf4bkzz
         JRYdojHlhD2JC2IqBh//JVef1ZzWrDtHlwaUWjL+NTKLW3/ZZBu0TLIv/Dh/HVaJ4QLV
         AMxo7EJc7AsrcDoE4Dwv9VYunBlsEng0o5+e7rJXt95ru0F3oiDh+fG2Vv4l6xnvh+B1
         9+69KUXOPe67nU/4RB3OWdwRCnO+zGKP/jqcApAOC0svT5UiRuJdP8fX0EgpYun9pt2Z
         FW6A==
X-Gm-Message-State: AOJu0YynoXDdo/inRgTtEwzbCXdFSFaRMBl3baGHF48Wjs3pg+0RfdOI
        eU6DyecEsT/BdXMiwHP6C3s=
X-Google-Smtp-Source: AGHT+IHDWW53CVY1YSIMx8RTzPqBIOpg4G2M/Enrgr0AHd1W2mdUUoAT0mjUn93SnLQ05/EFxGJKVw==
X-Received: by 2002:a50:fc10:0:b0:523:4d60:71c0 with SMTP id i16-20020a50fc10000000b005234d6071c0mr2037441edr.33.1692202499564;
        Wed, 16 Aug 2023 09:14:59 -0700 (PDT)
Received: from fedora.. (dh207-98-254.xnet.hr. [88.207.98.254])
        by smtp.googlemail.com with ESMTPSA id bo6-20020a0564020b2600b0052574ef0da1sm2536733edb.28.2023.08.16.09.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 09:14:59 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        wim@linux-watchdog.org, linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        quic_saipraka@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>
Subject: [PATCH v2 2/2] arm64: dts: qcom: ipq5018: add WDT
Date:   Wed, 16 Aug 2023 18:14:00 +0200
Message-ID: <20230816161455.3310629-2-robimarko@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230816161455.3310629-1-robimarko@gmail.com>
References: <20230816161455.3310629-1-robimarko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the required DT node for WDT operation.

Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v2:
* Put the reg property as second in node
---
 arch/arm64/boot/dts/qcom/ipq5018.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/ipq5018.dtsi b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
index 3285c86824cf..b3fa7911788c 100644
--- a/arch/arm64/boot/dts/qcom/ipq5018.dtsi
+++ b/arch/arm64/boot/dts/qcom/ipq5018.dtsi
@@ -182,6 +182,13 @@ v2m1: v2m@1000 {
 			};
 		};
 
+		watchdog: watchdog@b017000 {
+			compatible = "qcom,apss-wdt-ipq5018", "qcom,kpss-wdt";
+			reg = <0x0b017000 0x40>;
+			interrupts = <GIC_SPI 3 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&sleep_clk>;
+		};
+
 		timer@b120000 {
 			compatible = "arm,armv7-timer-mem";
 			reg = <0x0b120000 0x1000>;
-- 
2.41.0

