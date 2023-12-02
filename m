Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9DA801FCC
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 00:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232706AbjLBXsl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Dec 2023 18:48:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjLBXsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Dec 2023 18:48:39 -0500
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A26107;
        Sat,  2 Dec 2023 15:48:45 -0800 (PST)
Received: from newone.lan (unknown [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 8E8431611A1;
        Sun,  3 Dec 2023 00:48:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1701560923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bWhsY9l1ul1TFOq+Nt11jGbkxh3H06G6lnOQM1rmf3Y=;
        b=KXGRR7So4SCHSjH0VWHnTzyf3UoqOZHnkkUB0bjJQaZYawCtEKVftgdJeH3rzUMctu1+o5
        t2nQeSmFq827RKRzriWxM0zl7kRWGNrwqdrjXvBEZ8xIa4m1ANu+OYpJ0ijpuKWcKN3msd
        +z2/eg5ZZHN0YtskM+EhYJukkAfjdaQ=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>
Cc:     Luca Weiss <luca@z3ntu.xyz>, David Heidelberg <david@ixit.cz>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/3] ARM: dts: qcom: msm8916: idle-state compatible require the generic idle-state
Date:   Sun,  3 Dec 2023 00:47:19 +0100
Message-ID: <20231202234832.155306-3-david@ixit.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231202234832.155306-1-david@ixit.cz>
References: <20231202234832.155306-1-david@ixit.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

compatible must be qcom,idle-state-spc AND arm,idle-state.

Fixes: d468f825b3fd ("ARM: dts: qcom: msm8916: Add include for SMP without PSCI on ARM32")

Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm/boot/dts/qcom/qcom-msm8916-smp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8916-smp.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8916-smp.dtsi
index 36328dbe4212..1ba403b83cb1 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8916-smp.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8916-smp.dtsi
@@ -26,7 +26,7 @@ psci {
 };
 
 &CPU_SLEEP_0 {
-	compatible = "qcom,idle-state-spc";
+	compatible = "qcom,idle-state-spc", "arm,idle-state";
 };
 
 &cpu0_acc {
-- 
2.42.0

