Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED6387B5346
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 14:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbjJBMa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 08:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236982AbjJBMay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 08:30:54 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07C68AD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 05:30:50 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9b64b98656bso113028366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 05:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1696249848; x=1696854648; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oUM3IeGYooZNDk2CRvBMQ1vJndezulmjEoPqwHgdaxM=;
        b=R94eh1WOYcJB04MPrp/P9ViOr1A4TlCCMpTY3PY+1NqMs2lOPuoqyI4Cq320h2C/VQ
         QpYfQbyzfjA70Z/kKgjiTbs/cVzUOOTa5JhRXQ5nltQ4LlNjVWbOkc+VsBU9IQOVaqV5
         qazyByFrY2IvTMPMxIjwcXc5W48idpV0oP9enPh0GHi4qgpRQ0bQLZc4o3plN+fI9K4I
         1z+9Eb41cKGXFRbAqwAQYLvN/BvcSGVyFCMJyGTAT92VRZLrU1wVa5ZlMav6ifRKDuyt
         YioKWAFBfTNegKoyqGSZkWQvT+Af18AIG8PHiGEUMKxxHILfqfYkD90/dPYH5+t73T+j
         EGRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696249848; x=1696854648;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oUM3IeGYooZNDk2CRvBMQ1vJndezulmjEoPqwHgdaxM=;
        b=u8J9K94E1yuWR3qiOKkjUNnQkQXXXnPOLJAwBf56RgJd6YAQG/okPGMUHE96K9AMSS
         1FrNcyJHiCmEIWvVXiLzz1CI/kb7ntvv4qYBqAI7sTzu1lXsyggsCcuY8fI6widjQzAX
         J/uegYtESE6ffOqgDJ7RHxumPgqDF6dwosl1D+ORhgRGKiZ3azZjEvmqMzXAolx6Bdln
         o4p04ISza/cBXjVIeaTos1TFWUu+jc58aQdf2OHnd9ct8DKfE7suUXNfYW5rt9JItWh4
         RWkBElRs6aNZVKMelNZyFa7ZSDa8hEzIMns+hPO9MHKRQaZLScvz1GN0nWtAQYwtcEnZ
         NmnQ==
X-Gm-Message-State: AOJu0Yzwl5ifKu6k8/DR6xCZA3EnlOkc4gbtcsLYLbS1HGmorx1dliYt
        97gQACkikgLb5NNya3DyIcFCGx/yRjiHYKLdn8X7aw==
X-Google-Smtp-Source: AGHT+IE3YTg0aW8wLSZxL54dovsNHca4kmWOjfPQQNWlq8cjQLvkLT7CIl3iAVUgcPvXk9q6mScVSw==
X-Received: by 2002:a17:907:75d9:b0:9b2:7148:dd5e with SMTP id jl25-20020a17090775d900b009b27148dd5emr10317571ejc.16.1696249848444;
        Mon, 02 Oct 2023 05:30:48 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id gx10-20020a170906f1ca00b0099cb349d570sm16957197ejb.185.2023.10.02.05.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 05:30:47 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Mon, 02 Oct 2023 14:30:41 +0200
Subject: [PATCH v2] arm64: dts: qcom: qcm6490-fairphone-fp5: Enable UFS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231002-fp5-ufs-v2-1-e2d7de522134@fairphone.com>
X-B4-Tracking: v=1; b=H4sIAPC3GmUC/2WMQQ7CIBBFr9LMWgyM1Ygr72G6QBxkFgIBJW0a7
 i52a/7q/by8FQplpgKXYYVMlQvH0AF3A1hvwpMEPzoDSjxIjVq4dBQfVwShlYTKSDUidDtlcjx
 vpdvU2XN5x7xs4ap+73+jKtGHqEdFeL7L09UZzsnHQHsbXzC11r4zB49NogAAAA==
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nitin Rawat <quic_nitirawa@quicinc.com>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the UFS phy and controller so that we can access the internal
storage of the phone.

At the same time we need to bump the minimum voltage used for UFS VCC,
otherwise it doesn't initialize properly. The 2.952V is taken from the
vcc-voltage-level property downstream.

See also the following link for more information about the VCCQ/VCCQ2:
https://gerrit-public.fairphone.software/plugins/gitiles/kernel/msm-extra/devicetree/+/1590a3739e7dc29d2597307881553236d492f188/fp5/yupik-idp-pm7250b.dtsi#207

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Depends on: https://lore.kernel.org/linux-arm-msm/20230927081858.15961-1-quic_nitirawa@quicinc.com/
---
Changes in v2:
- Constrain UFS voltage to only 2.952V
- Link to v1: https://lore.kernel.org/r/20230929-fp5-ufs-v1-1-122941e28b06@fairphone.com
---
 arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts | 27 ++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
index 2de0b8c26c35..762c5db29520 100644
--- a/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
+++ b/arch/arm64/boot/dts/qcom/qcm6490-fairphone-fp5.dts
@@ -182,8 +182,9 @@ vreg_l6b: ldo6 {
 		};
 
 		vreg_l7b: ldo7 {
-			regulator-min-microvolt = <2400000>;
-			regulator-max-microvolt = <3544000>;
+			/* Constrained for UFS VCC, at least until UFS driver scales voltage */
+			regulator-min-microvolt = <2952000>;
+			regulator-max-microvolt = <2952000>;
 			regulator-initial-mode = <RPMH_REGULATOR_MODE_HPM>;
 		};
 
@@ -632,6 +633,28 @@ bluetooth: bluetooth {
 	};
 };
 
+&ufs_mem_hc {
+	reset-gpios = <&tlmm 175 GPIO_ACTIVE_LOW>;
+
+	vcc-supply = <&vreg_l7b>;
+	vcc-max-microamp = <800000>;
+	/*
+	 * Technically l9b enables an eLDO (supplied by s1b) which then powers
+	 * VCCQ2 of the UFS.
+	 */
+	vccq-supply = <&vreg_l9b>;
+	vccq-max-microamp = <900000>;
+
+	status = "okay";
+};
+
+&ufs_mem_phy {
+	vdda-phy-supply = <&vreg_l10c>;
+	vdda-pll-supply = <&vreg_l6b>;
+
+	status = "okay";
+};
+
 &usb_1 {
 	status = "okay";
 };

---
base-commit: d85348daa4407216e47198ed35a43a66883edab6
change-id: 20230929-fp5-ufs-e2c0e21a0142

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

