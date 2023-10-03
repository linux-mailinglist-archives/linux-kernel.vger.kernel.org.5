Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F017B6A2C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbjJCNSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbjJCNSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:18:50 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8610A6;
        Tue,  3 Oct 2023 06:18:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1696339125; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=GRkXnFQBMI3C6pufZHuf7L7dYme3EGvJTbnmew385D1YsNuDZxQqWhXUvVNiYHg/Da
    Aw+uCumPsL7ZUcVM4qKjReVFI1f65S959ZGtWdw7Uq5P00L373m5pC64AtBOGOlGdQeY
    GR4bhSVjWSUmU7Mpnr5+wtDxZbHReTd5oVk4UJOcpkvv70estx4eF6nedGEWvb3/hDhF
    ZNPp7A1NmD60plsa5rRa4Gx/MS4I/AMuub1VmMx+mO3rnV4zEG6xPyBPEN8mQTihKmx7
    wA3gYtxWTSkM8OTy/svfyXCnZgb+5FxHB40OsAHSjXSE5ZzQouo07AtNU/92HuhvQpGU
    qEDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1696339125;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=5tOaNBnZIp76aCZehJuiHTr9zQUl8dzXjSzMfoXuOec=;
    b=IeB0CnFklh5LGJ1OMiA2mK7JZM/NWAK+ziEigROZq9BDvl7ikr8eaJNC+GNiZP+H4y
    C+4F4HfNApMO+iqOEAiiyrJPBLBe3X4E/Yv2NJQSMWNKE8+T+aBG+dC4bggsG3YgdT0/
    l1aTYW2asWeGY8HbTpKkkkJj02GN86QFx9N60q0xtxQGUddwezs9QDXL0tb9F3Uu931S
    dhlXVL9qNmWOAX9khV47+yS9RZcKQ8xO9X09TBrOYqbJRDJptaQpNdH9HQhSQilIDIL8
    dnipR93IYDXqTCc2LnNeify7Uto2g6ZU7dHT/NjLWxjlZJS/bwTbByTx+L9HiRSraEL5
    GvCQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1696339125;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=5tOaNBnZIp76aCZehJuiHTr9zQUl8dzXjSzMfoXuOec=;
    b=ji+N9xk0EAk9NVXHJKl69Sz1HfUW5Vand9bimnxpgV83/ojJHbxsTjhaNb2bkNQlgb
    5JwlfQMfBzDJM8I9XDe/4itpSe+ENp8nSz6XIZhMuuJeCXK6ssBf47U6kiqkT2cg2xXS
    zhbYHv3EEkJ943p48vdoERn4j6pF01trv1PBXco6Tf1drPCqdK42oVUZS1l7M17icvjX
    shu1MKAsjMc0sPHUiYqvzsicNjZKPiigE2o6oiNPvPHc5WxDFXDnvnAFjj966td0AFMP
    bmfGRrAPUO3lC8+MIa+DB6UlgnTdq8SNGfkH2nsLxRJjkJCH29aPfpd9JYJ79fTWScwz
    5UJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1696339125;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=5tOaNBnZIp76aCZehJuiHTr9zQUl8dzXjSzMfoXuOec=;
    b=EsyIxqIcj/QY/mf4vEHjknXo26GA7GjV5YePYzLtELiZt8xt/bg2YbnNHiyVPVHk23
    T/5CsOg2MS1rdEdXRBDQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4l+/zY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z93DIi2OE
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 3 Oct 2023 15:18:44 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 03 Oct 2023 15:18:20 +0200
Subject: [PATCH v2 02/14] arm64: dts: qcom: msm8916: Add QDSP6
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231003-msm8916-modem-v2-2-61b684be55c0@gerhold.net>
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
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSM8916 does not have a dedicated ADSP. Instead, the audio services via
APR are also implemented by the modem DSP. Audio can be either routed
via the modem DSP (necessary for voice call audio etc) or directly sent
to the LPASS hardware (currently used by DB410c). Bypassing QDSP6 audio
is only possible with special firmware (on DB410c) or when the modem
DSP is completely disabled.

Add the typical nodes for QDSP6 audio to msm8916.dtsi. The apr node is
disabled by default to avoid changing behavior for devices like DB410c
that use the bypassed audio path.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 49 +++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 4f799b536a92..e8a14dd7e7c2 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/reset/qcom,gcc-msm8916.h>
+#include <dt-bindings/soc/qcom,apr.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -1989,6 +1990,54 @@ smd-edge {
 
 				label = "hexagon";
 
+				apr: apr {
+					compatible = "qcom,apr-v2";
+					qcom,smd-channels = "apr_audio_svc";
+					qcom,domain = <APR_DOMAIN_ADSP>;
+					#address-cells = <1>;
+					#size-cells = <0>;
+					status = "disabled";
+
+					q6core: service@3 {
+						compatible = "qcom,q6core";
+						reg = <APR_SVC_ADSP_CORE>;
+					};
+
+					q6afe: service@4 {
+						compatible = "qcom,q6afe";
+						reg = <APR_SVC_AFE>;
+
+						q6afedai: dais {
+							compatible = "qcom,q6afe-dais";
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#sound-dai-cells = <1>;
+						};
+					};
+
+					q6asm: service@7 {
+						compatible = "qcom,q6asm";
+						reg = <APR_SVC_ASM>;
+
+						q6asmdai: dais {
+							compatible = "qcom,q6asm-dais";
+							#address-cells = <1>;
+							#size-cells = <0>;
+							#sound-dai-cells = <1>;
+						};
+					};
+
+					q6adm: service@8 {
+						compatible = "qcom,q6adm";
+						reg = <APR_SVC_ADM>;
+
+						q6routing: routing {
+							compatible = "qcom,q6adm-routing";
+							#sound-dai-cells = <0>;
+						};
+					};
+				};
+
 				fastrpc {
 					compatible = "qcom,fastrpc";
 					qcom,smd-channels = "fastrpcsmd-apps-dsp";

-- 
2.42.0

