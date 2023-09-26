Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41CD67AF129
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 18:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbjIZQv7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 12:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjIZQv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 12:51:58 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA68F136;
        Tue, 26 Sep 2023 09:51:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695747098; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Xk4+uFMuPXrdK9kPdhFIG7bwBV9I7VU3dM2KHFwJgqken2GuFWmLxgk/U8BftlubPV
    j8jtiMHv/wmOViqIt/sgD+hmyxtBMCGIciTsarIWb4HWQ6M89JTaDsosdo9RBKZWmF6v
    1MGmUQ/gilxgfougNFcPJDF/UsGQ2+v/nW88YzOPFSFV1ZrcAHKCE9/tUTviweyTL2U0
    mrRJJIHXXsYNTsXsf6q6CcYT0NTkXR4HlbiS67SjtwBSG1QaVcU31Lta6VPc3zhD8Lp/
    wW4Tpcu6ep+8RRPmJgCZcr6zQc7qgvfaFhURB15lWuNyLXeBPVGq0AtJSN7UOvuBX6Yx
    9DKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695747098;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=qFtKSiZynUSedTLMAKU165/f1jdDEGvPsLRJR3qqVJc=;
    b=bGvmX4/6Sfh+xTGv6JUa63KTUX/isKepvGc3Fzzeo1PsqQVufj9SToL6b3MHoAX2AH
    GzpYfbP3ndtnw4gyT6HlvshR/BvBF8A7qcwzs3cD1p3PN8Z/JmtENL3oxkk6dfyWAMXr
    h69RzkzU8t543jjd68cisiyaCwHISXFv03s0PaD9Oqc64943yo/7arVHmiqODlCaDWX8
    ngBXHg58YVZ+uI6DrnPhBMCiQnkWqvOZ0pRDWjo2qz4EdWxauQtj4edx3RKu9/YlooEQ
    2Jt6G6pMTCnbSAtUKff2svvstRDsojesBOQZdCp5AM5pXbM2Wywsk6N06alDtGBomYX0
    NhNw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695747098;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=qFtKSiZynUSedTLMAKU165/f1jdDEGvPsLRJR3qqVJc=;
    b=ntYXhbqp4cMmiQJr3YNfbQ/ATtcq81KqovYUhjDTIrSq0sX5gvsW73IKLPPCJjPn/A
    yWfuqkn7d7TszNUMyS0wXQtV/ChS0ZeSUlF5SJ7EqbGonXoJSQHJAI4MCBeiFCe+job2
    5OgQ93gjLXzSsLqmq3kBNdwnCfjkf7AaitsCwUsN4qpABcg0LM51U38tH6HymNYnuIKM
    MsEJLsvMiB9NQNWOeihBOP06UI1efh4yryq+D9j386y922NcLz6ZpDjkUOA7aM63OuYo
    7tuF4zMefEX3YAiI3wFtHpVpiHWupZz1mMUeNvlN2AEWP5UWUub18mm3SVXCi/G5evW/
    iT1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695747098;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=qFtKSiZynUSedTLMAKU165/f1jdDEGvPsLRJR3qqVJc=;
    b=Tw/Mj7fBTyaddFKP74FCIr/0BgmSaN7FhnOreVAwQIAu67ZyTxj/5/7oyFxglu0CPd
    MXH0k1kJKXO0oIqV6WAw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn9VOH+nz0="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 SBL|AUTH)
    with ESMTPSA id R04c57z8QGpbg5Z
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 26 Sep 2023 18:51:37 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 26 Sep 2023 18:51:16 +0200
Subject: [PATCH 02/13] arm64: dts: qcom: msm8916/39: Add QDSP6
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230926-msm8916-modem-v1-2-398eec74bac9@gerhold.net>
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
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MSM8916 and MSM8939 do not have a dedicated ADSP. Instead, the audio
services via APR are also implemented by the modem DSP. Audio can be
either routed via the modem DSP (necessary for voice call audio etc)
or directly sent to the LPASS hardware (currently used by DB410c).
Bypassing QDSP6 audio is only possible with special firmware
(on DB410c) or when the modem DSP is completely disabled.

Add the typical nodes for QDSP6 audio to msm8916.dtsi and msm8939.dtsi.
The apr node is disabled by default to avoid changing behavior for
devices like DB410c that use the bypassed audio path.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 49 +++++++++++++++++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8939.dtsi | 49 +++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

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
diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index 65c68e0e88d5..95610a32750a 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -10,6 +10,7 @@
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/reset/qcom,gcc-msm8939.h>
+#include <dt-bindings/soc/qcom,apr.h>
 #include <dt-bindings/thermal/thermal.h>
 
 / {
@@ -1615,6 +1616,54 @@ smd-edge {
 				qcom,remote-pid = <1>;
 
 				label = "hexagon";
+
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
 			};
 		};
 

-- 
2.42.0

