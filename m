Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C737B32D3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233195AbjI2Mvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 08:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbjI2Mv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:51:29 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 961071AB
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 05:51:26 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9b281a2aa94so1278441766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 05:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1695991885; x=1696596685; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EI438PYIEEC0yZbJV+nRv633MGKe+mzYP5eVL8hC+74=;
        b=Juy46aSv4W1nmv0htKDhdDZzEQoRE+4/VIe0kZVYZU8z9OdrRqRR2Eqh7RIoWkrYPW
         KNICSbfVipxoR9L2Q9E61V+NYP2HbI5nqLbLfV1NKEIknYcd0Ucub54fC+R3o71mf26Z
         GHbDdOSydOP7xxhW6g4Rw0XZ0RE5ermF7UqF0oH4erqIQU2lvPp77Sxn8tELXD2YMxKi
         O+2Y337AWv7YAhwCQSjh1Mpjr5SI3Lnu00fjvO5wx/Kl2wZWfSxK7ujoG1kDpvWvWXX9
         8BYxhCFkCUSF2G0vPMPu+cY0kzM28rfCZcGcLerPjvb5/KM8U436wPEL4FGQUaPmckOz
         k36g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695991885; x=1696596685;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EI438PYIEEC0yZbJV+nRv633MGKe+mzYP5eVL8hC+74=;
        b=hPq9Bhk9m6sMBRUcWSQ8dKLs7aCT7jyOsrJVtj3iMkPYiFTnVJxDqZqx2l+FwCW8RI
         URBpPQRAbjtNDi+5hF0IwFLmrqr6/8n/p3W0XmZ6a/iXmTDfeGvN/lifvJyqSXt6Tnzh
         GbF81X6nc7XZUKywNieU+4Z8xnkmkPE167SMch73oIyQhJHhWfmKzAORHQrjkedk4oSX
         a4CkHmhPGvdM3Eyhig+YFbJPCKw6yonviyrFywNIjFwog3pxjZhJ5FINo9ruRVcptOz+
         MuRawIjBrxBUCPHdtct3EHRmyQbGQ/7B7XNaVPN1xFHyDu0lMyhhHyS6+Kn+ocqT5KNq
         RKog==
X-Gm-Message-State: AOJu0Yxf4uoYtxNrwJIXZc2hhcdeQ/iRYdwpqA2r8WNXxNk9F+sB54wh
        bBTF/kEZPUytloPpNU3tmCO5uQ==
X-Google-Smtp-Source: AGHT+IE+FyINlL0BYhMjlwcWx3oUO/MpcSU9nmTCH6i8a0GlO/Xu2VvK2PSHYJSgwTraUKyqbcDikQ==
X-Received: by 2002:a17:906:1dd:b0:9ae:6355:64bb with SMTP id 29-20020a17090601dd00b009ae635564bbmr3190165ejj.73.1695991884873;
        Fri, 29 Sep 2023 05:51:24 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id ck17-20020a170906c45100b00982a92a849asm12289551ejb.91.2023.09.29.05.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 05:51:24 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 29 Sep 2023 14:51:22 +0200
Subject: [PATCH v2] arm64: dts: qcom: sc7280: Add ports subnodes in usb/dp
 qmpphy node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-sc7280-qmpphy-ports-v2-1-aae7e9c286b0@fairphone.com>
X-B4-Tracking: v=1; b=H4sIAEnIFmUC/32NQQ6DIBBFr2Jm3WlgtKF25T0aFwShzEKhYEiN8
 e6lHqDL95L//g7ZJrYZHs0OyRbOHJYKdGnAeL28LPJUGUhQK3rqMRtFd4HvOUa/YQxpzUhCu6k
 jSZ0SUJcxWcefs/ocK3vOa0jbeVLkz/7vFYkS1a0lI2WvWu0GpzlFHxZ7NWGG8TiOLxHJGyO6A
 AAA
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the USB3+DP Combo QMP PHY port subnodes to facilitate the
description of the connection between the hardware blocks.

Put it in the SoC DTSI to avoid duplication in the device DTs.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v2:
- Update commit message after feedback from Konrad
- Pick up tags
- Link to v1: https://lore.kernel.org/r/20230929-sc7280-qmpphy-ports-v1-1-7532c11973af@fairphone.com
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 66f1eb83cca7..4e34d00e246b 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3399,6 +3399,32 @@ usb_1_qmpphy: phy@88e8000 {
 
 			#clock-cells = <1>;
 			#phy-cells = <1>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					usb_dp_qmpphy_out: endpoint {
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+
+					usb_dp_qmpphy_usb_ss_in: endpoint {
+					};
+				};
+
+				port@2 {
+					reg = <2>;
+
+					usb_dp_qmpphy_dp_in: endpoint {
+					};
+				};
+			};
 		};
 
 		usb_2: usb@8cf8800 {

---
base-commit: df964ce9ef9fea10cf131bf6bad8658fde7956f6
change-id: 20230929-sc7280-qmpphy-ports-20afd4212470

Best regards,
-- 
Luca Weiss <luca.weiss@fairphone.com>

