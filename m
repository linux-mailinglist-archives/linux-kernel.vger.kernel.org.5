Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7BA780F0F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 17:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378135AbjHRPX7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 11:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378112AbjHRPXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 11:23:53 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A033C1F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 08:23:51 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so16310611fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 08:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692372230; x=1692977030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c6CtJZa/AQu9J0Kld480ZWxBu5BwWXbF9kOTOoaJUEo=;
        b=hNvMKcE9iXe4JChLBzvJ/TaIGp18ypRKvWNxEQsIeQZPzQ8L0Zk4ZbX3MNfYS0zj0e
         uPAL/8E6VDs6wx8JkK02+KwZRQHXezCWQF+Af1T6NJ1d9VmscZM0tz3oYMEn7ncrwFaz
         6e4sHu7bhwFyljtEDHJ3kW2M7N3nzjUMm9yVgGDh3MINFBMitLSRnFSRoVMQFgLVZfbi
         EXYgYP0CfIYPjYp7aiRC41Opp/BPOpGYLO5gNtbdRItuIkZkYF9lV1FqlBsW0cNx3xpW
         oerwV0RYk9f1buhztqmHeJVgdp/9McPRFYZ7RgNNAbRTWtO4k6AhRCnlQm48v+mkih1d
         IXSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692372230; x=1692977030;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c6CtJZa/AQu9J0Kld480ZWxBu5BwWXbF9kOTOoaJUEo=;
        b=eZcyAJYPObIrmTYBNg1cVmUdgK/5fEi9wdOkd4K83N7zHeJx0QXysnhzncCMF4OGel
         WqD9ng+EOl//gWphXZGrohXbME7lsbONtMjd/S3nTRrcasvul5QMiKPsZzgmfIVUQYk7
         P3wlNgBpG8PZ0LwbpFctY5jyoojQAKb7OrmV8ZP1sZ6nNObK3FNffEcQQH9Av7ZLCzVg
         yzPVD+O5fm6ZXXPAIGJYh1B02vlKbjlaMcpmdetMQPgD9gh2Fd/xZh+q8LBJJKBNrLdd
         ng58Q53v9kOB2TQzyTrqPaxjEWOkHz/UVBiuj5tS4edkck++hVRZ+Ihzhfxg5xfhI4W+
         tN/A==
X-Gm-Message-State: AOJu0YzJzURMssi3c0h5TP0IjuxR77fPTXMV1JQKpHAFAZcUADZQwZ30
        0p0pKQqqV4G/QcDvl/NK7Y30uw==
X-Google-Smtp-Source: AGHT+IFIgOf5qG7QIjlRFlsPGcVULHL0fPWgMWpi7fEWFqlQiCmr1iT80HFjOPrt1+NQQogpae0Sfg==
X-Received: by 2002:a05:6512:3b28:b0:4fb:89b3:3374 with SMTP id f40-20020a0565123b2800b004fb89b33374mr2405957lfv.54.1692372230288;
        Fri, 18 Aug 2023 08:23:50 -0700 (PDT)
Received: from [192.168.1.101] (abxh52.neoplus.adsl.tpnet.pl. [83.9.1.52])
        by smtp.gmail.com with ESMTPSA id y2-20020ac24202000000b004fe4d122a66sm383715lfh.187.2023.08.18.08.23.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 08:23:50 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 18 Aug 2023 17:23:25 +0200
Subject: [PATCH 2/5] arm64: dts: qcom: sm6375: Fix I2C10 GPIO function
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230818-topic-10v-v1-2-dbb6464223c6@linaro.org>
References: <20230818-topic-10v-v1-0-dbb6464223c6@linaro.org>
In-Reply-To: <20230818-topic-10v-v1-0-dbb6464223c6@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-hardening@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1692372226; l=947;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=MIwq+pDyGnrHjet8pcjzzvliK2BSL87L5F0gT3kHAkY=;
 b=0ZKUlIALmo4upl+QkKnlQDx0/mWzWhG/TFD67I6/V/bIThOq7IphrZaSAkZ00LsxJXOLX/EMt
 l/HBWSlH0p5Bm0KmdeIO+oHFdGhQbcPWAuFikP+uvDyLJqecOTPnr+3
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

Unfortunately, as mentioned in a comment under a different node in the
device tree, the pinctrl driver's naming doesn't really match up with
actual QUP indices..

Assign the correct one for I2C10.

Fixes: 704edf03c022 ("arm64: dts: qcom: sm6375: Add pin configs for some QUP configurations")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6375.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6375.dtsi b/arch/arm64/boot/dts/qcom/sm6375.dtsi
index e7ff55443da7..4364b144eb93 100644
--- a/arch/arm64/boot/dts/qcom/sm6375.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6375.dtsi
@@ -885,7 +885,7 @@ qup_i2c8_default: qup-i2c8-default-state {
 
 			qup_i2c10_default: qup-i2c10-default-state {
 				pins = "gpio4", "gpio5";
-				function = "qup10";
+				function = "qup14";
 				drive-strength = <2>;
 				bias-pull-up;
 			};

-- 
2.41.0

