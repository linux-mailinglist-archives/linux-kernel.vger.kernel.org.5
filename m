Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC9180A3A2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 13:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233466AbjLHMnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 07:43:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233460AbjLHMna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 07:43:30 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1901199C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 04:43:35 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a1e83adfe72so202688066b.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 04:43:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702039414; x=1702644214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hq7OTSSO5jL1zKGxG1x1x9EuleHIb2ireoAXlk/78G4=;
        b=bt/OT6BftpmxfmrZdmLWcD44IKMo1plC5Ty2ggONm/epmqqOfvYFRREYCtomJgc643
         2S7yC2InRyPKZxV5dNlf5+nJGAuQ8y907WxOdCFPmwTsB9PmbNbJH73HL5rkFe2YL+yC
         4tmZ4QBTGeqiqiDBndUk3P6z0oUKo0sYYufmykjHHGhnn5mPC+ruuazM+wpEhLhNREO8
         zU9P98QfSpzuAHsdRGhm9y1xdJbyIIwxWsY5ZlC0rw8Bz99p4GiHiiOqjDXbjzq1OefH
         Y61wZfYH+KnMDaFppAfyCdsuXHz5ABrblb+nqFMdBJXO2S9v47YPXkUKbtje6HWGQFmf
         mv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702039414; x=1702644214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hq7OTSSO5jL1zKGxG1x1x9EuleHIb2ireoAXlk/78G4=;
        b=ImQanjdhcIReodn4vSrk2e4L36r6XfTS93EaDc5SOkny42e3B+LNfc9+dgeFY8Qy8R
         EeOaBBMKwQ7cnqamAvQPHQ0FQYuCpgzgXVITz714fcks1l28oVM5+grdckr2tZZr3acI
         7GEqJjSXWHFvylvLyn7MpXOrmZSTeeZLskI2+UUR3vLUKFEUpX4EfMtC+qD7WoucAHhd
         AJLoFvS8k9usdKhlLqSbjZ3JlFu8ZEms7IuaWql2+skoT/tdhz5GmxqdRpTGWSZtPQId
         C6xWMbDAG3wNRLmIjqwn6uK/CeupXxlXKWu9Cxh/U5woZxAgLC91zw4fJicImVnVW1Dj
         VdVw==
X-Gm-Message-State: AOJu0YxOeGITYIANWr7tUiv/RZoOo3NX0+wAhy7kn/zrl2ArjFPiB1KL
        41L+nW+qOsPcMCvCLqYhQQ0kUg==
X-Google-Smtp-Source: AGHT+IFa7aLm3Iljw5/1elYh9fWl8/YSbM+A6pDPRDKw9/FBaWRFdTpLVngwjQVe+S9O/f4BEVF2vw==
X-Received: by 2002:a17:906:2618:b0:a09:e781:97ef with SMTP id h24-20020a170906261800b00a09e78197efmr2237620ejc.73.1702039414441;
        Fri, 08 Dec 2023 04:43:34 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id tl18-20020a170907c31200b00a1da2c9b06asm970989ejc.42.2023.12.08.04.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 04:43:34 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: pm8550: drop PWM address/size cells
Date:   Fri,  8 Dec 2023 13:43:32 +0100
Message-Id: <20231208124332.48636-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The address/size cells in PWM node are needed only if individual LEDs
are listed.  If multi-led is used, then this leads to dtc W=1 warnings:

  pm8550.dtsi:65.19-73.5: Warning (avoid_unnecessary_addr_size): /soc@0/spmi@c400000/pmic@1/pwm:
    unnecessary #address-cells/#size-cells without "ranges" or child "reg" property

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8550.dtsi | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm8550.dtsi b/arch/arm64/boot/dts/qcom/pm8550.dtsi
index db3d5c17a77d..797a18c249a4 100644
--- a/arch/arm64/boot/dts/qcom/pm8550.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8550.dtsi
@@ -64,9 +64,6 @@ pm8550_flash: led-controller@ee00 {
 
 		pm8550_pwm: pwm {
 			compatible = "qcom,pm8550-pwm", "qcom,pm8350c-pwm";
-
-			#address-cells = <1>;
-			#size-cells = <0>;
 			#pwm-cells = <2>;
 
 			status = "disabled";
-- 
2.34.1

