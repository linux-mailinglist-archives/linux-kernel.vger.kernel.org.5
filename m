Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2AB757AAF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbjGRLmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjGRLmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:42:01 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08BE19BD;
        Tue, 18 Jul 2023 04:41:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1689680438; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=e+tKi+G+OUCduOiE36fr0hOf70/pDMOhg57WzMnIiGLjiqkrVyOXeBjr+cmMX+BRuP
    don5r8kXx7r40FG5AEHbFvPbo24XY0UPtOEHxF1iUdeq3Wg//+WOvWTSs2Yl6BTsQdv8
    iM+fI1h4s7PQ0+bgZSAOu8+dYhxQktOWgnYU+wOirZesdMVoivWLxde8Ylg8jK818YoM
    FXma+1bGNTn0+STQwzhYS07pT4I3M11BBXwK73otTC5dcm1FtsOta+1qXrTpQnvAuqm+
    WaEryXWFPOTSY9OFz7p5IBWzT9NxmBlSanG8ldlv+iJ14Wp6wnjidNlyrnAquEWtRI0m
    SuOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1689680438;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=leKm6XQrXU4OSZeVodhbqX/6PYvddpq/c+MRNpyVB+c=;
    b=jM7bOn7SHkCta1CeOG3K9XzGSE2v6Kgc4BinVVPKFpauGRWacRkkYzaBFxg10Xp8+N
    dhXc/Qm8Yh/0j/aGllvzvC6hJ06q7RI7Owt+kMHL0btX94p9qkvHb9YfisBB96gRWd4h
    fLbH0sewC862yfBAVMhlMFYxKOgB/6CqgVTACVHlHaf8+yS86ldC/zH86KDkJUwFI2tI
    emJoxFubUjvzt6RsNyyYKOJuEJIYnh/0Oc2JFFdaIda1OfgoOZ/MfHwjzh6HpBNUk8Bd
    41WSV7qdgJi/mg8i1E1k3NHswa7sLvVheyaDu9ehnoRMx1yiicRlS0ZmIWQ2U7Li7vcd
    KMpQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1689680438;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=leKm6XQrXU4OSZeVodhbqX/6PYvddpq/c+MRNpyVB+c=;
    b=pgoGK3Md/dyUiwFPly13Eix0Yue9s6nmSwIhfGdvKF837oshp8dAZv35mtqa7YYSPh
    wKvilhLIKIFgDJlsmA39ks0dthN41tD2RjWnl/mVDthcyInqVmHAhN2XWz4ZT+/Yl4yC
    iIPCHdK+YGcdU754BoTiTVlR2pmtTFVpEP2L0KxSvxqxi82YopPdEktNOCDCxS8Z+jx5
    IAR05KdH4fsKGGKwHJMH+hUI2bFafBZqusQOpfeU+OmDCwH1nbmZXKxW8jcTQk+FPGHP
    9Nwms6MLR1GHHp5cW9O//9cIq5rZPpI8GPFeCvUaJHpsdLIJkHPjuVaihXjgWXgp8sHU
    S60A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1689680438;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=leKm6XQrXU4OSZeVodhbqX/6PYvddpq/c+MRNpyVB+c=;
    b=UfW6+4wbdcSNBAw4H5m5PIqRZHem5awRXYHQhZWacO6F2tMrCEYBeLKbcf7+KHkFyv
    0W/Mhi+VzbSUZed75aAw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u45/mw=="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z6IBebbpL
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 18 Jul 2023 13:40:37 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Tue, 18 Jul 2023 13:40:14 +0200
Subject: [PATCH 2/6] ASoC: dt-bindings: pm8916-analog-codec: Drop pointless
 reg-names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230718-pm8916-mclk-v1-2-4b4a58b4240a@gerhold.net>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm8916-wcd-analog-codec has just a single reg region, so having a name
for it provides no additional value.

Drop it completely from the schema and example. There is not really any
point in keeping it (even as deprecated) because it was never used. In
old DTBs it will just be ignored as before.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../devicetree/bindings/sound/qcom,pm8916-wcd-analog-codec.yaml      | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,pm8916-wcd-analog-codec.yaml b/Documentation/devicetree/bindings/sound/qcom,pm8916-wcd-analog-codec.yaml
index 77e3cfba4746..5053799c88b5 100644
--- a/Documentation/devicetree/bindings/sound/qcom,pm8916-wcd-analog-codec.yaml
+++ b/Documentation/devicetree/bindings/sound/qcom,pm8916-wcd-analog-codec.yaml
@@ -19,10 +19,6 @@ properties:
   reg:
     maxItems: 1
 
-  reg-names:
-    items:
-      - const: pmic-codec-core
-
   clocks:
     maxItems: 1
 
@@ -126,7 +122,6 @@ examples:
       audio-codec@f000 {
         compatible = "qcom,pm8916-wcd-analog-codec";
         reg = <0xf000>;
-        reg-names = "pmic-codec-core";
         clocks = <&gcc GCC_CODEC_DIGCODEC_CLK>;
         clock-names = "mclk";
         qcom,mbhc-vthreshold-low = <75 150 237 450 500>;

-- 
2.41.0

