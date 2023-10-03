Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B77327B6A2F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235707AbjJCNTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234590AbjJCNSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:18:51 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812BEAB;
        Tue,  3 Oct 2023 06:18:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696339125; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=RJJJ6c3m9rHxAG2DyN+OMi8V6qhNOzpQXPVMHa3Wz/Qh4EJc/TfNoa0cAQ8BMyqgB+
    Pp3xtnkWqo4qKQwDGVjuBTVOBqyxHMNYM+zHjs3q7SztLM4Acr7DUh6hL+QseaCxIu3c
    AJjXEPiT4jf2qHWaVwJ00UulOFO3o1D3hEG9VYADtzIl1pUf/MFhmKNGhg95higmypk5
    vL6Ajm62sr0GdRo62aSnUIiix6dUcG4FcIptLnyUKlQqDu6scxg4dZKyZXvCby0DqZ+B
    yUdP1MMoB9aF6ETordixoX1BFFzS09pOUMZA2DWmh/QILXEf/kUrVfgbkERJYlAVFA0e
    rhNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696339125;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=axN5JTKzeHnuAwCYNQDx+NKlDEDPR1XqPTp8Vpb9ugo=;
    b=SNOATYAqOZBizfJlp66r2gcRodkOMZ4rwWy2pzc90+f234WwLoaVChimYCrWcqXJEI
    KRk0fjz+HxjJV3uCTMJoDczjZnioO2JGtQO6oRGNYS4672j55P4fkOVOuHXW6N12uym5
    /RazlJu6qStkWwNYZwQ7Gr4THT1yEZkvK9Vm3eKLBr2AavAuCByNgoMzCnns/tsbnCtr
    VJLLENYOBPF6ahFTemxQatJ5JZyK5wULYXYEv6VHtax41mmg8gm5uNOVLRcV8vKyTSKa
    1IsGi/UbOFoWAYWe7qpTMjzGERqmCQQP5FS90fRUj4CFBGvdmCiQrCqDspUUo+0WCOF6
    1yaw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696339125;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=axN5JTKzeHnuAwCYNQDx+NKlDEDPR1XqPTp8Vpb9ugo=;
    b=PJqm4E5guv2vaMi+fMjYoEJlLMRF1ciNE2n34JOqcv2sx4dhr32JyvxYBkNsYoA7o5
    /X8yhdDFPAfru2ag1saVVoHe3OPfOJ47Hdf0Maxrg0WN/XNVvpzAtp1TZXvnu4i0UH3d
    43F3Hjv8KRj+K7Nbin34G1Ajh4D4TCe1/5wUgKTDJmXOBOOASee5YPQPHmAVUMycoemp
    S87csp5qPfCeyClbC7tWNblU0o6ot09l/960LmUo1LlinxFMF5CgqgrSrsUqc4heDIH2
    PlLJeH46Y3Dp6HzqoT1zBHgUHqyU6TMzLjhp9+mcW3i34EYdjoBzNYXmd/LeURj7gk1R
    nMGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696339125;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=axN5JTKzeHnuAwCYNQDx+NKlDEDPR1XqPTp8Vpb9ugo=;
    b=Lru4Q6MDj5yRw8HsZG/E+xkykGPBaoNXE24VxA2E0+OfkP9OL5KE96r+RtXeQ6mSmH
    vEx7PZlAqI2buIg8d6AQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4l+/zY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z93DIj2OG
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 3 Oct 2023 15:18:45 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 03 Oct 2023 15:18:22 +0200
Subject: [PATCH v2 04/14] arm64: dts: qcom: msm8916: Add common
 msm8916-modem-qdsp6.dtsi
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231003-msm8916-modem-v2-4-61b684be55c0@gerhold.net>
References: <20231003-msm8916-modem-v2-0-61b684be55c0@gerhold.net>
In-Reply-To: <20231003-msm8916-modem-v2-0-61b684be55c0@gerhold.net>
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
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
additional codecs by adding additional backend DAI links.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/msm8916-modem-qdsp6.dtsi | 148 ++++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-modem-qdsp6.dtsi b/arch/arm64/boot/dts/qcom/msm8916-modem-qdsp6.dtsi
new file mode 100644
index 000000000000..039961622633
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8916-modem-qdsp6.dtsi
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * msm8916-modem-qdsp6.dtsi describes the typical modem setup on MSM8916 devices
+ * (or similar SoCs) with audio routed via the QDSP6 services provided by the
+ * modem firmware. The digital/analog codec in the SoC/PMIC is used by default,
+ * but boards can define additional codecs by adding additional backend DAI links.
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
+	status = "okay";
+
+	frontend0-dai-link {
+		link-name = "MultiMedia1";
+
+		cpu {
+			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
+		};
+	};
+
+	frontend1-dai-link {
+		link-name = "MultiMedia2";
+
+		cpu {
+			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA2>;
+		};
+	};
+
+	frontend2-dai-link {
+		link-name = "MultiMedia3";
+
+		cpu {
+			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA3>;
+		};
+	};
+
+	frontend3-dai-link {
+		link-name = "MultiMedia4";
+
+		cpu {
+			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA4>;
+		};
+	};
+
+	sound_link_backend0: backend0-dai-link {
+		link-name = "Primary MI2S";
+
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
+	sound_link_backend1: backend1-dai-link {
+		link-name = "Tertiary MI2S";
+
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
+};

-- 
2.42.0

