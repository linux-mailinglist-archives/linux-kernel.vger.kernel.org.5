Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8772792CDF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239448AbjIER5X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 13:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239794AbjIER5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 13:57:02 -0400
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116781B35F
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 10:51:34 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-501bd164fbfso1836850e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 10:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693935924; x=1694540724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7lliAJnjKGrKN2HdJy1Zp01oKeEF+jouNcZc6sxAEmg=;
        b=HUxNeoX84biTbClmmR63wWP7vjdYGsfovIXb8mnbHjVvz4bp7E2Nnqt97bJnEp/nL2
         Xbvg5DXnzvnZsmKm4BIIEpeQLCOTtbsFCFJ7Pn+RVyQmYz63H7P5gXACzdPUGOg+Xfli
         SVWkQisLaKIGyIHu5xmZvuNXEhKt9IwzwyQqc2e1iYJukDQT+Vocc6X+OU9aDZxJFUPM
         tQtf7Pw9Mbqdp1kySpma3ulmnq0+dFOvJQ5AYp0e1ox/LLNaaqEQMNJj8gCaTzbs7RhV
         jdLh7sz1OmgLATkbpkoKVVp43lazNcb4ZPdmikAl0d4wxeQHbwmViIGOY638qX7fvrfo
         6WZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693935924; x=1694540724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7lliAJnjKGrKN2HdJy1Zp01oKeEF+jouNcZc6sxAEmg=;
        b=l7o6G7aUSgimCMV+elPStiXQNhPwRXgV9SIaF7/5e1fpZ7E/QBsY49pPyoiAUbZ87E
         HARCRkQvHbuPbcwz/MeoIRFBGZEfOrTIMie7h3mdt8IiTzyd8O5g46pMPj0kE82DPUqQ
         2qAcyjxolYcYcGxKPuqJsW2cxKsB462xfsT2HnDjHpOxWoDqKT+tnjfGA3LSV3Il/XSg
         r0E0N2cXaFQIz4aA0vWfbIdSF3UBxaAjPkwcB+hdXLD4VXvpxSvdCjQbeI1yO4bc5nl4
         NYYKyHvhw/VHz/xTZsJf9V4vKjW1l7oEt7GaWxffY7Em/0kkzTsAzToS+jfb4N2wjEj8
         pbLg==
X-Gm-Message-State: AOJu0Yzmbk8xmDJoTg/7ojzt07cl10q7x1s1XvLE6QuPs2aKB6AJPCOu
        7oZTo2RzqhLv2bExHY3xiod516bfNmXpnk0wgBg=
X-Google-Smtp-Source: AGHT+IGc9ZoOkCPrWQHAvmzavnP932KKSQltJbJVFwE5KtY8VTlctUL6wrsqrWGa8tPg0SULxnh2RA==
X-Received: by 2002:a17:906:3054:b0:9a6:8219:6e0b with SMTP id d20-20020a170906305400b009a682196e0bmr307473ejd.35.1693931465798;
        Tue, 05 Sep 2023 09:31:05 -0700 (PDT)
Received: from krzk-bin.. (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id g24-20020a170906395800b00992e265495csm7796187eje.212.2023.09.05.09.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 09:31:05 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rohit Agarwal <quic_rohiagar@quicinc.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] arm64: dts: qcom: sdx75-idp: align RPMh regulator nodes with bindings
Date:   Tue,  5 Sep 2023 18:31:03 +0200
Message-Id: <20230905163103.257412-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device node names should be generic and bindings expect certain pattern
for RPMh regulator nodes:

  sdx75-idp.dtb: rsc@17a00000: 'pmx75-rpmh-regulators' does not match any of the regexes: '^regulators(-[0-9])?$', 'pinctrl-[0-9]+'

Fixes: 8a2dc39d1043 ("arm64: dts: qcom: sdx75-idp: Add regulator nodes")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Really, I can't believe I am still fixing this stuff. New boards bring
the same mistakes we fixed half year ago. Or even earlier...
---
 arch/arm64/boot/dts/qcom/sdx75-idp.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdx75-idp.dts b/arch/arm64/boot/dts/qcom/sdx75-idp.dts
index 10d15871f2c4..a14e0650c4a8 100644
--- a/arch/arm64/boot/dts/qcom/sdx75-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sdx75-idp.dts
@@ -44,7 +44,7 @@ vreg_bob_3p3: pmx75-bob {
 };
 
 &apps_rsc {
-	pmx75-rpmh-regulators {
+	regulators-0 {
 		compatible = "qcom,pmx75-rpmh-regulators";
 		qcom,pmic-id = "b";
 
-- 
2.34.1

