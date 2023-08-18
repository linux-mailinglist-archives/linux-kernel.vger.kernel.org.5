Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E624780AF6
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376578AbjHRLTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376580AbjHRLTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:19:24 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734003AB6
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 04:19:22 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4ff92e369dfso1192380e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 04:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692357561; x=1692962361;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8J+2LJ6gMgX1TcmKQ5rJGED44/gqlNHcs0SShniQNG0=;
        b=hYlYFHdArVhsfczEk8icQ9TW5MFfxfJodfUmfmJnb9KDVW10yuCFY4OH7LF/CUCGHm
         hhG84zOTY4zFApCUMeV9UQUVzcFFOeC7TbwNMBjtgCVqaiD9YfaYOpu+JjPT8kF9vQh/
         A/WvROQN/bUqj2F4tBrM601wmljc7A1XOxCkca0usODFEL5tRpwh6eU2izhUtykqYgKx
         uORdlyWicz513oxqu9P4jLduLoSlSUV5He5T7xnG1SaajSZ0cBzZ05DHORJupaCYQ/LC
         8G4am6CR9GgwWelSAZkdkznOwdzGYm57jfl+cKcWllqq1XDdc6Qk6X888T7FkTwLtRTa
         Bz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692357561; x=1692962361;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8J+2LJ6gMgX1TcmKQ5rJGED44/gqlNHcs0SShniQNG0=;
        b=JLHohcu7LpQMvislc52zIQB/xufZ6zLOJIdT8yykLI8Hm2DJNFCA/tdJ+/J7kt+LYX
         B6sLu7OvgpZgZtJu3bzuOZ5sJlDU+swV4jo1jpkDVpq4hgzPCJaFei6Wa/wo/6ljJ6ri
         PIFe1kZ+tBAPR8DmGkr1QlCcw9pO6Rablp5QHiCa6ydLpQOFVN7jEnwDlXHZzsmKbkpW
         woiTX+Mb9JOZ+BAbN/v/2+MPH+KZr1uYHPYvG6Sy7F/X8FNAEsHsyA2kJ+Kr2GBzNLVB
         ZmeH9IPxsMWQfMuLR59rMz5kh7AKYtC9m/U5C03MDp7kEy1EG1jDq5wF2TUEu3Z/lKy/
         cBFQ==
X-Gm-Message-State: AOJu0YzZouNJ/lCbzZ7C5Jsf3XfV8QcQJKEsTwX8+9zJJwgoH2ZZKk5s
        oA+1KgoMpH656AytxA9uLIFU1Q==
X-Google-Smtp-Source: AGHT+IFJXUAn0p9DErBUyxxlLzFewEeyQfkiHIltQPEyKvMO4VEidblp4mI544OdZsxQuQNSQ0Bf4g==
X-Received: by 2002:a05:6512:2520:b0:4fb:889c:c53d with SMTP id be32-20020a056512252000b004fb889cc53dmr1521339lfb.10.1692357560654;
        Fri, 18 Aug 2023 04:19:20 -0700 (PDT)
Received: from [192.168.1.101] (abxh52.neoplus.adsl.tpnet.pl. [83.9.1.52])
        by smtp.gmail.com with ESMTPSA id i8-20020ac25228000000b004ffa28ef3a4sm304679lfl.100.2023.08.18.04.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 04:19:20 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 18 Aug 2023 13:19:09 +0200
Subject: [PATCH] arm64: dts: qcom: sdm670: Fix pdc mapping
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230818-topic-670_pdc_fix-v1-1-1ba025041de7@linaro.org>
X-B4-Tracking: v=1; b=H4sIAKxT32QC/x2NUQqDMBAFryL73YXElsb2KqVIkt3UBYkhsUUQ7
 +7Szxne8HZoXIUbPLsdKv+kyZIV7KWDOPn8YRRSht70VzPYAdelSMS7M2OhOCbZkIxLgdKNrHu
 AdsE3xlB9jpOW+TvPKktl3f6PXu/jOAH3nfMueAAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Richard Acayan <mailingradian@gmail.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692357559; l=1169;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=pCfQcaauHLSUCltfnHoDTljoC0JWqXFHbNjpyiiD0Lc=;
 b=rhfvECauXBJe2d6lXCOnthc3+VZjyv9qhYOgBlTdTZrKQfjrCMSMqd509UYcyrUrJqXsYl7YF
 hIjG369883ADaZ5qVd39I10TUaNcTLgBpGtfvsrixdtlv4RK4VUwOmU
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As pointed out by Richard, I missed a non-continuity in one of the ranges.
Fix it.

Reported-by: Richard Acayan <mailingradian@gmail.com>
Fixes: b51ee205dc4f ("arm64: dts: qcom: sdm670: Add PDC")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sdm670.dtsi | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm670.dtsi b/arch/arm64/boot/dts/qcom/sdm670.dtsi
index 84cd2e39266f..ba2043d67370 100644
--- a/arch/arm64/boot/dts/qcom/sdm670.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm670.dtsi
@@ -1328,7 +1328,8 @@ pdc: interrupt-controller@b220000 {
 			compatible = "qcom,sdm670-pdc", "qcom,pdc";
 			reg = <0 0x0b220000 0 0x30000>;
 			qcom,pdc-ranges = <0 480 40>, <41 521 7>, <49 529 4>,
-					  <54 534 24>, <79 559 30>, <115 630 7>;
+					  <54 534 24>, <79 559 15>, <94 609 15>,
+					  <115 630 7>;
 			#interrupt-cells = <2>;
 			interrupt-parent = <&intc>;
 			interrupt-controller;

---
base-commit: 7271b2a530428b879443b274c191b34536a4ea11
change-id: 20230818-topic-670_pdc_fix-d07fbdf4d179

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

