Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1CD80E7E3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 10:40:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346032AbjLLJkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 04:40:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjLLJj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 04:39:58 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D78DE3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:40:04 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-54cde11d0f4so7582642a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 01:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702374003; x=1702978803; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T7WSPbehcijEKgEJWzyVTs2cXCZ1wk5EWf1JMP+vpZw=;
        b=uhjbM8JpQ5gJdMeBgxEi+hfHJmDWQeFVjq0k9Ld0LAzC/fsoNKUfSzLb9bp6DIqXln
         3FpeX8h806MQW7gXHh0/Z+WuMGExkpojuFDWc0KmlN4h1rxVx2TDvgVjNrFoXCK/UQz2
         8onqZZeeQCfJgF5MyE7VLp7zJqbSp1ucFIbss75NO26Fne2TAc6bbXbqFKz3NCo91aRU
         DwLLq7eRqJUMyCRZu8OlBdrJS3M7EfXfC5cgCY4rrEB1NTD1Aux9ii6xKGqf9x2ybyvk
         z6qaA8/ADyYDbOoznIjYaqZtB0/3DNSjNlmo9s6dIzf2TQwjPwbBBeUldki5BjDGdd8p
         uM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702374003; x=1702978803;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T7WSPbehcijEKgEJWzyVTs2cXCZ1wk5EWf1JMP+vpZw=;
        b=IjEEKp0NK1+OERwTXuGvOUolS80daDzeepMm/0o/z6INIuaD6SxlAeREdjTy6SzWwl
         1HHYvZG8XpngPk74TGmwDg770YOc9uMFQoJbZbWeA/9BhGoO4NSBcMgtgBXvXC7f8rKf
         31T1/fH957exNbdoUw6ft9HpgxaEwGWVgfsvvMQ9HmRcIrX0DEqMYQkOFImvAYqlvxpe
         vMKpLrqHQPV81/z3k+Shk93RsAQlGRzj5KkqPIDJBlZS8hNAc2uIy/Ykj86aCgLzS4Wf
         KMUQo9weyTeBETLuwfPtTeaMNiDUAjmimUU+lu0Pn3q5uNbLlbWznDa+ua21rzfvZXa7
         ZaKg==
X-Gm-Message-State: AOJu0Yx3BL38BOmu3KGFfuvj3yjcR50EcyUWVJvzfEqNqhqoN7/VFaGY
        wq+Kqp348Y6ikv7bWy4GBN9xlw==
X-Google-Smtp-Source: AGHT+IFzFmwY5xwsSBjeFaYogBsab8uI25xMWlwPgCNrjrXjwWM9aMvv9w1//6BcPicBY41+tDiU/A==
X-Received: by 2002:a17:907:3d8e:b0:a19:a1ba:da4b with SMTP id he14-20020a1709073d8e00b00a19a1bada4bmr3632691ejc.114.1702374002701;
        Tue, 12 Dec 2023 01:40:02 -0800 (PST)
Received: from [127.0.1.1] ([79.115.23.25])
        by smtp.gmail.com with ESMTPSA id ub26-20020a170907c81a00b00a1c96e987c4sm6037240ejc.101.2023.12.12.01.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:40:02 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
Date:   Tue, 12 Dec 2023 11:39:52 +0200
Subject: [PATCH] arm64: dts: qcom: Add SMB2360 pmic dtsi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231212-x1e80100-dts-smb2360-v1-1-c28bb4d7105e@linaro.org>
X-B4-Tracking: v=1; b=H4sIAGgqeGUC/x2NQQrCQAwAv1JyNpCkaMWviIfdbWoDdZWNSqH07
 waPMzDMBq7N1OHSbdD0a27PGsCHDsqc6l3RxmAQkp6FGFfWMzERjm9Hf2TpT4RUhiLHSZTSAJH
 m5Iq5pVrmiOtnWUK+mk62/l/X277/AMpXxoF7AAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=cENQN0lGVHkALBwjCWgcaICqf2Y63xNy5bQr8heDzrk=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBleCpslNoWRkn7+O49nH1Q8ovNlCDxqv5SowLTF
 dqdYY0TDS+JAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZXgqbAAKCRAbX0TJAJUV
 VsBSEADFIrPMRJ/aVC7MlIn49AwHaxVBk6HCuBNApbP82miRDGenqLS1IbGX2x+K8bIczuml1lX
 MfI4P9guC3gn+lONJ8YIqAQVQW6v6UhS9nCJvSbkGFPYarnkT3QaDkm/xZ+YZVDJIRhtmZZbWZ7
 XjT9P3NIf0vQf5s9p2MiBPhzEwK2rQUK0I48kEIhSzx4KGktO+TToQnVMhy1LyCz3L08oYXJtxm
 sYzklmvwTOGQo8xiqgzveaUhJfgyQD/S6CRFplaCS0Z0/lPVbWLi7quw11SVbQftTYZoCNEz0wN
 zXHP6RrIuPzCvmuQ7NnP/WxuZ3cGwrk54tF6IuA2ruQv800OLInJTkN1J3joPT5ieBt9ICSJmfO
 Tn0XMmExWzSPr7sAe57E+Apv/czMvZGlt92BVMa/YX1gLHuE/cAEFNnN7r30jEOfSt0IJsW6Lsy
 IwZZvkuubVNm7p0JJxhF++5apJTjV45nxPlpJS8gGhMx8JZWS2sXrJxIgVfXU5BqfnrPZW8/0i9
 azs2DjW5XxlKKjpXezYzrQtD8ComuTaddbxWKF6pHEBisqTSW9i14GfxdevFxUxJJ4+cV4cIDAS
 J41bS5uLg4pmTMBPtyuhhRd/ug+D2ZLYwHzgzysnLVNhb5w93+PfwAczyB14g5Oj7RTHlPxH/1i
 ZJHSk97VOCoHzRQ==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add nodes for SMB2360 in separate dtsi file.
Also add the eUSB2 repeater nodes.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 arch/arm64/boot/dts/qcom/smb2360.dtsi | 51 +++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/smb2360.dtsi b/arch/arm64/boot/dts/qcom/smb2360.dtsi
new file mode 100644
index 000000000000..782746a20403
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/smb2360.dtsi
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+/ {
+};
+
+&spmi1_bus {
+	smb2360h: pmic@7 {
+		compatible = "qcom,sm2360", "qcom,spmi-pmic";
+		reg = <0x7 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		smb2360_1_eusb2_repeater: phy@fd00 {
+			compatible = "qcom,smb2360-eusb2-repeater";
+			reg = <0xfd00>;
+			#phy-cells = <0>;
+		};
+	};
+
+	smb2360k: pmic@a {
+		compatible = "qcom,sm2360", "qcom,spmi-pmic";
+		reg = <0xa SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		smb2360_2_eusb2_repeater: phy@fd00 {
+			compatible = "qcom,smb2360-eusb2-repeater";
+			reg = <0xfd00>;
+			#phy-cells = <0>;
+		};
+	};
+
+	smb2360l: pmic@b {
+		compatible = "qcom,sm2360", "qcom,spmi-pmic";
+		reg = <0xb SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		smb2360_3_eusb2_repeater: phy@fd00 {
+			compatible = "qcom,smb2360-eusb2-repeater";
+			reg = <0xfd00>;
+			#phy-cells = <0>;
+		};
+	};
+};

---
base-commit: bbd220ce4e29ed55ab079007cff0b550895258eb
change-id: 20231201-x1e80100-dts-smb2360-0c7c25f2e0a7

Best regards,
-- 
Abel Vesa <abel.vesa@linaro.org>

