Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C69757A9E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:40:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjGRLkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbjGRLkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:40:49 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811611AC;
        Tue, 18 Jul 2023 04:40:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1689680438; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WAvl8colgcEn9XPus/OWN2RH5IR6MBoUqGQhvVaH2dkf3/jBZmvYpQ9rZDR6Ddj8PK
    aUBsMvnySD4nDTyN9y5z9idhhqVECskeF9RQtQ2hyZk2UjiArFxGVa7gMqkYhdBBq6GP
    48yMeT1ppQMZSerBbL9yzbwzoo/H6NuF4GAujyQVMVzpXRct5bTmP1gRCitwX9yn0EN4
    VkDh0HoAol59+q86lpp5UwAIWuQ1xMZ5Yax1azdOUqpm+QHkOnTEX/9vJrgZ5IincCwE
    ivvTawqSInriOf+dDPXnRfLzm0M8VK6Ga3aZY/hcZ1CKecpq2OPwLcWHM6UlZXfQ1t8Q
    WHDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689680438;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=9nAs4PEgRZ836zl1pP7Ag3osiO18Y/hoNYTgzgYWHqA=;
    b=XsofbCqBXy8YpVX0e/H+cZISu4Ajlk/UI1BdTSbnPI+FT5l6dSGR+hjN+QNS7kFN16
    XugzXtrLZYg/xzxMF7Xah6CXu7kYmkRHi7Y/byuMUvSageUzwPGNrxZjsY4/1foHpHqa
    s6H9zSOdQ010vh5OLhJ0gEpI/FYQaB6M492tiEEYJgDbjK0PGgKckcqm0t92qIsUBBR6
    bW6GN1S3KdwV5RerRIQPCwzsZdWIYDWwmPpFr+acJ/fiKtFOJwfM8/KM2CwrTg+KOul0
    c1OOaIVHdKuFmCC8G+L164aAtJ5SBaL50gr0ghYpTJ8SZEHWT+m9QQISjUTD4ApZ4OY0
    5PtA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689680438;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=9nAs4PEgRZ836zl1pP7Ag3osiO18Y/hoNYTgzgYWHqA=;
    b=LQjsNuC2/pCXild6nQBwXP6z1nuWeJV9Txv/v8QCqDHLUrrqB2OBTcwuiCNdqXdRZz
    0l3snnIPiJO/XCFE5zge05Kle91Tk2w8Pnt2X/+7FkYOyRUKLcN3FeFOiAyODgCB2tNJ
    uN++fzANPiemayQLASS+Qz/oc8UEFiWjvf4tjE7Mvceb76kJEEQrh5/KKH1PBrtxyCKN
    TLq6FthrLa5+DD60UcsPy2ocBmU+YQ9Sv0ilKwuu/obJuOKZVkWVtfQJLJqwD8VdHDDU
    JVTP2MqEtCnaux8O5fYXv8qcA36/WzaBKF7HV1xeQNESwKUMNL3tMPChmaWqY5Q7pnlZ
    1vYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689680438;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=9nAs4PEgRZ836zl1pP7Ag3osiO18Y/hoNYTgzgYWHqA=;
    b=4FwUFruobAz9C6hytkLEZnDkinKpiqm2PvMkbbrNh0xliDVVoghtIGAFwCp3suYhk7
    lwFw6C13IZ5Uc/UUEJBA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u45/mw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z6IBecbpM
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 18 Jul 2023 13:40:38 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 18 Jul 2023 13:40:15 +0200
Subject: [PATCH 3/6] ASoC: dt-bindings: pm8916-analog-codec: Drop invalid
 mclk
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230718-pm8916-mclk-v1-3-4b4a58b4240a@gerhold.net>
References: <20230718-pm8916-mclk-v1-0-4b4a58b4240a@gerhold.net>
In-Reply-To: <20230718-pm8916-mclk-v1-0-4b4a58b4240a@gerhold.net>
To:     Mark Brown <broonie@kernel.org>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The audio codec typically used for the MSM8916 SoC is split into two
parts: the digital codec is part of the SoC, while the analog codec is
part of the PM8916 PMIC.

The analog codec in the PMIC has no direct connection to the mclk of
the SoC (GCC_CODEC_DIGCODEC_CLK). As the name of the clock suggests
this is supplied to the digital part of the codec. During playback it
will use this clock to transmit the audio data via the "CDC PDM" pins
to the PMIC. In this case the analog codec indirectly receives the
clock signal through the digital codec.

GCC_CODEC_DIGCODEC_CLK is already managed by the driver of the digital
part of the codec in the SoC. Having this clock on the analog PMIC part
additionally is redundant and incorrect because the analog codec cannot
receive the clock signal without going through the digital codec.

Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../bindings/sound/qcom,pm8916-wcd-analog-codec.yaml           | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,pm8916-wcd-analog-codec.yaml b/Documentation/devicetree/bindings/sound/qcom,pm8916-wcd-analog-codec.yaml
index 5053799c88b5..94e7a1860977 100644
--- a/Documentation/devicetree/bindings/sound/qcom,pm8916-wcd-analog-codec.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,pm8916-wcd-analog-codec.yaml
@@ -19,13 +19,6 @@ properties:
   reg:
     maxItems: 1
 
-  clocks:
-    maxItems: 1
-
-  clock-names:
-    items:
-      - const: mclk
-
   interrupts:
     maxItems: 14
 
@@ -109,7 +102,6 @@ additionalProperties: false
 
 examples:
   - |
-    #include <dt-bindings/clock/qcom,gcc-msm8916.h>
     #include <dt-bindings/interrupt-controller/irq.h>
     #include <dt-bindings/spmi/spmi.h>
 
@@ -122,8 +114,6 @@ examples:
       audio-codec@f000 {
         compatible = "qcom,pm8916-wcd-analog-codec";
         reg = <0xf000>;
-        clocks = <&gcc GCC_CODEC_DIGCODEC_CLK>;
-        clock-names = "mclk";
         qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
         qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
         interrupt-parent = <&spmi_bus>;

-- 
2.41.0

