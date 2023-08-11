Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD107798CD
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 22:49:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236743AbjHKUtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 16:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbjHKUsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 16:48:47 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3577E2D5B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 13:48:47 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fe11652b64so3770106e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 13:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691786925; x=1692391725;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hMAmzExWeY7DLaS6HiuDa4H+3gBOsphjz1a09Sd7Fnk=;
        b=HVBUecr05adAwnMy4a+ynJdclZEowV63w0UAeVcHLizxVkSTawy+DasfMKck98yein
         gzlT7LLxwFyvsaLQECn9OUKBGGbEpvmjtYiNvSGu5O4hzodINfPDV+qXCuG7N6Tr9cxs
         UQvsIjJ2ZvwGE4rYsBrnEvhZGgiBlUQ1eSrH7AtBPNWt1krXmsN4uJSAX5m3Jso7j77e
         NLrvknFl84nZJ6cgfKO/0BZJ76zOMrwG9QFYKKzUkAAd+D9UgNtLM3O1SHQA0HkDoaAK
         x3HEPx6tDwVxXSrH7s9O5aqqldWDk43ZwPSNOmDnLxzfa1kJkR4nJltPYoCPez3ZYwAS
         0MtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691786925; x=1692391725;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hMAmzExWeY7DLaS6HiuDa4H+3gBOsphjz1a09Sd7Fnk=;
        b=HpXW9spWuqppdGMbCIR0c5Y6GXJ1CdpqjcUb76N9oxhzF2YYPEUVlJp9jd6HI0rl4C
         VhZCkkKlMAET6SeIbCpjct3XdvYMpq3YqYQtJlptl+UMzR62IALHJevy2KORxaUzcmbw
         TxoLByHNDlLFk4xqT7hLggj/WsOiX4QSO/yuzB6tvmEvAd/m7NDlHnnYnbIT69c6zD+Y
         X17edp9ve1xPNR+RaPfJiyPWALcYasqfQH0VOlNxkHwxIpk0/smrGBYosVfcVXJCK8e8
         Mnt9yghb7XnaQpiaEgYq8f/NUcNM/Byyr/T3RvKvlDjIz328dqVvBgC0ssZLbO6VpHSv
         iRqg==
X-Gm-Message-State: AOJu0YwoZH69zG7vyGJUtdtsYqrs2woRnms9wZ4TynIkqBVjBbc3vzCG
        nT7HRs2FE90TURwgsObcIMvM9w==
X-Google-Smtp-Source: AGHT+IHRgPJW9p2kV7EmOLNfg44H1I04Qyv4gM9bLDGkKp1f4LUr4C+1T2yUDViJ98m5O0gRkT3pQg==
X-Received: by 2002:a05:6512:340c:b0:4fb:a990:bb28 with SMTP id i12-20020a056512340c00b004fba990bb28mr2520664lfr.18.1691786925531;
        Fri, 11 Aug 2023 13:48:45 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id w1-20020ac24421000000b004fe8d684172sm843603lfl.234.2023.08.11.13.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 13:48:45 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 11 Aug 2023 22:48:37 +0200
Subject: [PATCH 4/6] arm64: dts: qcom: sa8775p: Hook up PDC as
 wakeup-parent of TLMM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230811-topic-tlmm_wakeup-v1-4-5616a7da1fff@linaro.org>
References: <20230811-topic-tlmm_wakeup-v1-0-5616a7da1fff@linaro.org>
In-Reply-To: <20230811-topic-tlmm_wakeup-v1-0-5616a7da1fff@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1691786918; l=716;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=beJvqeK4ZNSk+iejw2uYXTpoSvA07gUCVf/WdmENsC0=;
 b=4XKmTOUY2kZyrDx59I91Yj3H7nwVFzWoeTR61SlSPmi84cmUNPXUGw8q0k4OSx3hGQdJaqcTZ
 RZCWZl/p54TBtWb0/uR1X/4EVh4WUn4bKxIPHMYl8axUJTDUNuy07q5
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some TLMM pins are wakeup-capable. Describe the relationship between
these two peripherals to enable this functionality.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p.dtsi b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
index 7b55cb701472..830730c020ba 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p.dtsi
+++ b/arch/arm64/boot/dts/qcom/sa8775p.dtsi
@@ -1934,6 +1934,7 @@ tlmm: pinctrl@f000000 {
 			interrupt-controller;
 			#interrupt-cells = <2>;
 			gpio-ranges = <&tlmm 0 0 149>;
+			wakeup-parent = <&pdc>;
 		};
 
 		apps_smmu: iommu@15000000 {

-- 
2.41.0

