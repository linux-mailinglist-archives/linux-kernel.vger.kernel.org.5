Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 342617573C5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjGRGMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjGRGLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:11:49 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E09C19B1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:11:31 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id 46e09a7af769-6b71cdb47e1so4055756a34.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689660691; x=1692252691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAuP6Q6TKNDuCaUlFKpJeNeF9nU9XbWAvICkpXnR+AQ=;
        b=x+5WymiQZ1UPzI5nXXDnzXCsOpSrsBG4R9eDcI6DvRb2WJ15tRDCs9S86Kz8oK8vBE
         Qx5/QrJafx9jp8G05QiFzLkFQDD0DKhf1X8or2B11wirOiY+737sixMT4vCx6u7jAq9w
         rtw5fKXvX5VmALQynVqUhi7Bg3z7a4xH2q58MMkeSlwnXJwt6g3iV5sDGvy1sVzzu+ig
         cS7qQDUktFv8xCiLuw9Gw/cJm1t8e6BhETmm+Cnth0gxkCXA/BeiKRu9jwu7AToqLO/c
         X4+1abZeGaHkdCEIeU/duvpeRtM29+o2Mh1kIqATWl6QVOVPszD0DCStRR9GVD5xUn/R
         idwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689660691; x=1692252691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAuP6Q6TKNDuCaUlFKpJeNeF9nU9XbWAvICkpXnR+AQ=;
        b=UPeMZphI0p6EkJkiv2cHXJLWALDi1DqOmzPqKsJzyhC35trYMsEhH3V4ZWXMlNZ513
         w3SlGexhBuo13xv87auS9iKwLG/fGW1I8McsNaRXcxgcz/wyJ3ZHVyGzNIn288p1CQxK
         /DEwXDheIYWoXzuprtsXsavNFglnajHYXmjwQt+7SBJ9L0dZEuOB0lBZ+chWgcq3cHO3
         ktoIwQp8D+PhHTnpa3JpbbEi/k2hmtPU6wJaL/d0pcGwzcquLmWlUAQn0W+7NaqsySHb
         IgsVe+fL23qmg9a9dt5MloZfYeFQMJ+9t1j1m4OroOzeI0Ld5lWoKKbVZWdAwDLsTsfC
         cMnw==
X-Gm-Message-State: ABy/qLZi7liTSlvsTMqEB7j/3UDBUsW0REWUI7wOb6aVMSlzkhf+ZBdY
        8Jn7VOdiMBhYFwOYbdEsSB+xUg==
X-Google-Smtp-Source: APBJJlH7RaOvviXR6lEGhQgEPRJzVuo+l7y+KQXufnQRHXmbjIRlVaZORbrJXV3IFdDmRFmV8taEKg==
X-Received: by 2002:a05:6358:c02:b0:133:a55:7e26 with SMTP id f2-20020a0563580c0200b001330a557e26mr2150537rwj.7.1689660690682;
        Mon, 17 Jul 2023 23:11:30 -0700 (PDT)
Received: from localhost.localdomain ([223.233.68.54])
        by smtp.gmail.com with ESMTPSA id h21-20020a62b415000000b0067db7c32419sm778106pfn.15.2023.07.17.23.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 23:11:30 -0700 (PDT)
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
To:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        bhupesh.sharma@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
        quic_schowdhu@quicinc.com, gregkh@linuxfoundation.org,
        stephan@gerhold.net
Subject: [PATCH v9 5/7] arm64: dts: qcom: sm6115: Add tcsr syscon node
Date:   Tue, 18 Jul 2023 11:40:50 +0530
Message-Id: <20230718061052.1332993-6-bhupesh.sharma@linaro.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230718061052.1332993-1-bhupesh.sharma@linaro.org>
References: <20230718061052.1332993-1-bhupesh.sharma@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the TCSR syscon dt node for SM6115 / SM4250 SoC.

Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6115.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6115.dtsi b/arch/arm64/boot/dts/qcom/sm6115.dtsi
index 839c603512403..3be0b54fc3628 100644
--- a/arch/arm64/boot/dts/qcom/sm6115.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6115.dtsi
@@ -591,6 +591,11 @@ tcsr_mutex: hwlock@340000 {
 			#hwlock-cells = <1>;
 		};
 
+		tcsr_regs: syscon@3c0000 {
+			compatible = "qcom,sm6115-tcsr", "syscon";
+			reg = <0x0 0x003c0000 0x0 0x40000>;
+		};
+
 		tlmm: pinctrl@500000 {
 			compatible = "qcom,sm6115-tlmm";
 			reg = <0x0 0x00500000 0x0 0x400000>,
-- 
2.38.1

