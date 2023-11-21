Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109677F2551
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 06:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjKUFgH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 00:36:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbjKUFgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 00:36:01 -0500
Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4387DE7;
        Mon, 20 Nov 2023 21:35:58 -0800 (PST)
Received: from fews02-sea.riseup.net (fews02-sea-pn.riseup.net [10.0.1.112])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mx0.riseup.net (Postfix) with ESMTPS id 4SZCld4B57z9vdw;
        Tue, 21 Nov 2023 05:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1700544957; bh=MmG76V6PDrwhqMIcwgqGcDAMHsJSPVsWoCHsN6e0BTk=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=aTPIDFXB5ClBTAfjwfhU6lCB4KyM4cz+0gz24/nEB79UsBxW14ngzMr8mpy2s671q
         9CFaA62z4QgJvyiJgRVVwIZZfNFF1WZccFuPYU0BPHNsg/x9N+jYef/G5YB3WAWiAZ
         +KL5DCcviA1uDPT0VIJqgLpRzgiQs4QTreWany0o=
X-Riseup-User-ID: DAF623205CCF3F05344EF028622BDF111F6D6E5F4AC9744D2562F0232B3ACAC0
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews02-sea.riseup.net (Postfix) with ESMTPSA id 4SZClZ4yg3zFrxv;
        Tue, 21 Nov 2023 05:35:54 +0000 (UTC)
From:   Dang Huynh <danct12@riseup.net>
Date:   Tue, 21 Nov 2023 12:35:00 +0700
Subject: [PATCH v2 2/4] dt-bindings: mfd: qcom-spmi-pmic: Document PM8937
 PMIC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231121-pm8937-v2-2-b0171ab62075@riseup.net>
References: <20231121-pm8937-v2-0-b0171ab62075@riseup.net>
In-Reply-To: <20231121-pm8937-v2-0-b0171ab62075@riseup.net>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Dang Huynh <danct12@riseup.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add bindings for PM8937 PMIC (qcom,pm8937). This PMIC is found in
boards with MSM8917, MSM8937, MSM8940 and APQ variants.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Dang Huynh <danct12@riseup.net>
---
 Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
index 9fa568603930..8f728920df9e 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,spmi-pmic.yaml
@@ -66,6 +66,7 @@ properties:
           - qcom,pm8841
           - qcom,pm8909
           - qcom,pm8916
+          - qcom,pm8937
           - qcom,pm8941
           - qcom,pm8950
           - qcom,pm8953

-- 
2.42.1

