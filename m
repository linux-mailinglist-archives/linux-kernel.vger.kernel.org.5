Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67237A9EF2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231317AbjIUUP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230469AbjIUUPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:15:15 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C553E6E446;
        Thu, 21 Sep 2023 11:56:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1695322581; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=ZH/ntUDBs6vUR28SchkmOUHzm3tf9X1Urlq+tMkoJXtu4JcPuwqvmDL4SDgEF+yuYf
    CVgJVgp+eBVRn8CrFZukGt8+2MlJdrPG6nxyRm9SXf9Mzgu7y8N2IJWBPPSl5MGo7qri
    U9H1AiNgmxqpW7h7iEgU7zI8SxmclPWcruEbod7wwke2MsR4CAzZ8q3Zz3+9dYtBvWsZ
    qNrJRc1qI4tDNPqlWf6Jf0A6nNIoQhpvCqRzv1i2Mry0rH1LCF1BxNwweIaK9qhUX9Ov
    iDiigmHnOTQPEKUKpqD/NZ8apDy12JS+MGsucHjESGJ064B/BMSa1dh46dJrv/Rbsumq
    rE/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1695322581;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=1DsvpJDBZTqVx22dib/2ldD2B4NWjnue07okTeP74I4=;
    b=nLZ3E3u7xWxD7HILa/b+w2ZAD6aU5hy+T3ohCrOk6OaXyDiNlRjxIglwAnTmsXv5Iy
    Jmel6eTGm1KSHkXh1IUv5GmtQBeSZMi3KXiI/KHJB00CcmeIbkDFkE6S2e48mVsZY31z
    3GBNEWNAEzwmcxKBjZa0HEV8IMWaX6GPak7PD+/afoZvXDohx534VAelpdBUGEsNM5zI
    U/gu6qXkN+toXc7almPefmwzGHy9+YSzl1pJ5ehTKlb+FAu+v/JA8rwYyDXpjVeMd85w
    wjPxFYeAJyC5Mf4RWGggbxezGqVwyofGRiG163jRAVi0rhrUs7Ez/HkoJmaoMOE6q7qJ
    Pnjw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1695322581;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=1DsvpJDBZTqVx22dib/2ldD2B4NWjnue07okTeP74I4=;
    b=gTFbcysihg1u1a9kVDoGjdeRxrIq9+tGHNUfyCI9QALIhFYwkwDV6LRKu3cZ/uSLKk
    jrM0vrPM5KPfim6sQ4kAvIYo1ujSPgQTilxa6e85RclruZl61daL8BeiwvtbDpsHEuCS
    qLkfelrrtc18mOkytXISO4ji13yUNSDD4RPVfmc5VCwJJxBHWVMOKOqBJWGmO+sVt57S
    jkYqIwxoyXdXmAQoA131RVcjP36XR08Av/TeVEh64KdCAhwpw1af5Lwtn8ik9Z3ve3MW
    y1cScCl4LmZMr7KsAMhFU1TjW5yoyL2FNBvSJJeMRYCxbdJkV0WY+Cttzmybkg78Qhro
    25lA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1695322581;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=1DsvpJDBZTqVx22dib/2ldD2B4NWjnue07okTeP74I4=;
    b=s8oa36+LycA3OvNEDiSKDa/A9zYkz+aUttwSy3NerSWs/6cVhEaqLNuwwT30huIHLm
    haiQgNU4gcMs7PUlxvDA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4p39TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id R04c57z8LIuLRS0
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 21 Sep 2023 20:56:21 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Thu, 21 Sep 2023 20:56:05 +0200
Subject: [PATCH 2/3] arm64: dts: qcom: msm8939-longcheer-l9100: Enable
 wcnss_mem
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230921-msm8916-rmem-fixups-v1-2-34d2b6e721cf@gerhold.net>
References: <20230921-msm8916-rmem-fixups-v1-0-34d2b6e721cf@gerhold.net>
In-Reply-To: <20230921-msm8916-rmem-fixups-v1-0-34d2b6e721cf@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable &wcnss_mem for msm8939-longcheer-l9100. This is needed now to
have WCNSS working. It was missed when &wcnss_mem was disabled by
default because the patch with the msm8939-longcheer-l9100 device tree
was not applied yet.

Fixes: 0ece6438a8c0 ("arm64: dts: qcom: msm8916/39: Disable unneeded firmware reservations")
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dts b/arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dts
index 6802714fda3f..a3357513037c 100644
--- a/arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dts
+++ b/arch/arm64/boot/dts/qcom/msm8939-longcheer-l9100.dts
@@ -247,6 +247,10 @@ &wcnss_iris {
 	compatible = "qcom,wcn3620";
 };
 
+&wcnss_mem {
+	status = "okay";
+};
+
 &tlmm {
 	button_backlight_default: button-backlight-default-state {
 		pins = "gpio17";

-- 
2.42.0

