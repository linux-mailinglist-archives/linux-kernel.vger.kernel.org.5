Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E9B7AF143
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235431AbjIZQwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235401AbjIZQwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:52:04 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B11DE;
        Tue, 26 Sep 2023 09:51:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695747098; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=H5P4gPqWPdASQgN0J9MvA38y9FS++YGC0baFALLTTJGLOx4v9OZJ6ENtfLVnIxjYeN
    MAJ+fabaeG7kolEBB5c/yK+gHExClvA4bPYE2RPoTOxd6ZP4ApUdnT5FNabHdXjeU8bz
    6u0Dzv6vlqR9uMzM3YVYoqg2MdBzuFPzOYPjK5axKfFpZ+cxCLVGxy8laf3RMibDQnc7
    fJcSN3u6fs4gWBcNp7PwS8RmMrxs+HzXTWqbz3mwBfKwxbxjzFRnfnZMvfL1McycRpt9
    yBhYgj2nB1JgCuBqC5QLnZRmqADmnSjGOLjlDSidk7Rg09gNaIZYkdRMxpPuNAMTC+vm
    N+cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695747098;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=1536gHXq9U1hhAc8goTXUqrlTguEtR9wsGCkW3wI2Aw=;
    b=Vn991DqjgxgrIB2jKIFc5e1l1lFbIY9HiGwj8rw4fwHy+hGIdTu7z/NeyLAKSHXOTl
    OGFzH5ApKsW9qMZTXovsKPHtEAGQmQ0wGtiquCLFTQHlitwWf93bWTaOSKJ83d9BHuEy
    EsjimAWELsG+nHXccLteRjELpj8D0r5rMntfny6muE0BKxj2IikCWPTYmJUwDAdyJ2HF
    asuiF4S511dx6+CXB7+e649KBJilKAZz69nwI5CvY3CycbcGa4PgV5miBuiYD67yL2hI
    n7pdoVM81WFzYpgmTSmFQ4BBxltmthkbJfpwexgOWsCoM0nOPjiJpPvZo/LQngnU5Q0+
    UTOQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695747098;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=1536gHXq9U1hhAc8goTXUqrlTguEtR9wsGCkW3wI2Aw=;
    b=rma6xtcgISk3dsIn3b60GbvrLLl4ScGfdKqkwBNjMaz6LwSBnWY32hjARGtA4wlUG1
    o8UYGZHZjQX3OjVP+Md+lGIV9UvPbgIzZIM6g2MxwgPmDDVoMH8Arb5pGzgX5KJ9eYah
    zln5xZu2+nTfrjBkFmWqnpGJasSB3ZfGxmFpHJeqQYwNV1hwxxo2UKWkxiD4g7ZSVtTh
    Hw9xQDRZZSgnpNCjH1USs2GQMuMCjkJvDl1NTelb6GGdHwJZbktiJ+3UujDNROvBXnZs
    7sEHhLO7d4T9YROnmUc3S/NaRYwtZjOhnIRzRZaSnN5Tb9ou2hYAgUh6hwtwzdIs2otY
    GBDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695747098;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=1536gHXq9U1hhAc8goTXUqrlTguEtR9wsGCkW3wI2Aw=;
    b=YeV2s4BkV493tIvEnXZDtJjLe8tGu3qobpBweQdIlZJfgUmMwoVLGiuWMP38Nt2H+z
    EwmkH8AY+cxK6exDc6Ag==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOH+nz0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 SBL|AUTH)
    with ESMTPSA id R04c57z8QGpcg5a
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 26 Sep 2023 18:51:38 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 26 Sep 2023 18:51:17 +0200
Subject: [PATCH 03/13] arm64: dts: qcom: msm8916: Add common
 msm8916-modem-qdsp6.dtsi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230926-msm8916-modem-v1-3-398eec74bac9@gerhold.net>
References: <20230926-msm8916-modem-v1-0-398eec74bac9@gerhold.net>
In-Reply-To: <20230926-msm8916-modem-v1-0-398eec74bac9@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most MSM8916/MSM8939 devices use very similar setups for the modem,
because most of the device-specific details are abstracted by the modem
firmware. There are several definitions (status switches, DAI links
etc) that will be exactly the same for every board.

Introduce a common msm8916-modem-qdsp6.dtsi include that can be used to
simplify enabling the modem for such devices. By default the
digital/analog codec in the SoC/PMIC is used, but boards can define
additional codecs using the templates for Secondary and Quaternary
MI2S.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/msm8916-modem-qdsp6.dtsi | 163 ++++++++++++++++++++++
 1 file changed, 163 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-modem-qdsp6.dtsi b/arch/arm64/boot/dts/qcom/msm8916-modem-qdsp6.dtsi
new file mode 100644
index 000000000000..ddd74d428406
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-modem-qdsp6.dtsi
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * msm8916-modem-qdsp6.dtsi describes the typical modem setup on MSM8916 devices
+ * (or similar SoCs) with audio routed via the QDSP6 services provided by the
+ * modem firmware. The digital/analog codec in the SoC/PMIC is used by default,
+ * but boards can define additional codecs using the templates for Secondary and
+ * Quaternary MI2S.
+ */
+
+#include <dt-bindings/sound/qcom,q6afe.h>
+#include <dt-bindings/sound/qcom,q6asm.h>
+
+&apr {
+	status = "okay";
+};
+
+&bam_dmux {
+	status = "okay";
+};
+
+&bam_dmux_dma {
+	status = "okay";
+};
+
+&lpass {
+	status = "reserved"; /* Controlled by QDSP6 */
+};
+
+&lpass_codec {
+	status = "okay";
+};
+
+&mba_mem {
+	status = "okay";
+};
+
+&mpss {
+	status = "okay";
+};
+
+&mpss_mem {
+	status = "okay";
+};
+
+&pm8916_codec {
+	status = "okay";
+};
+
+&q6afedai {
+	dai@16 {
+		reg = <PRIMARY_MI2S_RX>;
+		qcom,sd-lines = <0 1>;
+	};
+	dai@20 {
+		reg = <TERTIARY_MI2S_TX>;
+		qcom,sd-lines = <0 1>;
+	};
+};
+
+&q6asmdai {
+	dai@0 {
+		reg = <0>;
+		direction = <Q6ASM_DAI_RX>;
+	};
+	dai@1 {
+		reg = <1>;
+		direction = <Q6ASM_DAI_TX>;
+	};
+	dai@2 {
+		reg = <2>;
+		direction = <Q6ASM_DAI_RX>;
+	};
+	dai@3 {
+		reg = <3>;
+		direction = <Q6ASM_DAI_RX>;
+		is-compress-dai;
+	};
+};
+
+&sound {
+	compatible = "qcom,msm8916-qdsp6-sndcard";
+	model = "msm8916";
+
+	pinctrl-0 = <&cdc_pdm_default>;
+	pinctrl-1 = <&cdc_pdm_sleep>;
+	pinctrl-names = "default", "sleep";
+
+	multimedia1-dai-link {
+		link-name = "MultiMedia1";
+		cpu {
+			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
+		};
+	};
+
+	multimedia2-dai-link {
+		link-name = "MultiMedia2";
+		cpu {
+			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA2>;
+		};
+	};
+
+	multimedia3-dai-link {
+		link-name = "MultiMedia3";
+		cpu {
+			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA3>;
+		};
+	};
+
+	multimedia4-dai-link {
+		link-name = "MultiMedia4";
+		cpu {
+			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA4>;
+		};
+	};
+
+	sound_dai_primary: mi2s-primary-dai-link {
+		link-name = "Primary MI2S";
+		cpu {
+			sound-dai = <&q6afedai PRIMARY_MI2S_RX>;
+		};
+		platform {
+			sound-dai = <&q6routing>;
+		};
+		codec {
+			sound-dai = <&lpass_codec 0>, <&pm8916_codec 0>;
+		};
+	};
+
+	sound_dai_secondary: mi2s-secondary-dai-link {
+		link-name = "Secondary MI2S";
+		status = "disabled"; /* Needs extra codec configuration */
+		cpu {
+			sound-dai = <&q6afedai SECONDARY_MI2S_RX>;
+		};
+		platform {
+			sound-dai = <&q6routing>;
+		};
+	};
+
+	sound_dai_tertiary: mi2s-tertiary-dai-link {
+		link-name = "Tertiary MI2S";
+		cpu {
+			sound-dai = <&q6afedai TERTIARY_MI2S_TX>;
+		};
+		platform {
+			sound-dai = <&q6routing>;
+		};
+		codec {
+			sound-dai = <&lpass_codec 1>, <&pm8916_codec 1>;
+		};
+	};
+
+	sound_dai_quaternary: mi2s-quaternary-dai-link {
+		link-name = "Quaternary MI2S";
+		status = "disabled"; /* Needs extra codec configuration */
+		cpu {
+			sound-dai = <&q6afedai QUATERNARY_MI2S_RX>;
+		};
+		platform {
+			sound-dai = <&q6routing>;
+		};
+	};
+};

-- 
2.42.0

