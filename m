Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D2F79B0A8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344243AbjIKVNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243772AbjIKRmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:42:18 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E681BE;
        Mon, 11 Sep 2023 10:42:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694454123; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=pDIPJkfT0cEwV+CoJX1B2IhRFQVzbhnEubgz0fbw7JKMAHGgMFmMUEfQ0PxYPEfuFy
    f97F3YjsLFoGbYfCT+WcNN8q2cQFXCk0RXpW0IKifBbGPeyQLQwPN/mjLczcAXDZbIGF
    X+Nhnp6rrbBGXlqqWdwH8qI8m35eOS4wYOwODeLXahR40yD0oxx3AFqKuDIr+iyggD9U
    q5Ed7swSvyPBKF9Qw9iFCX0IeJGRibgXFk4aV8CCdUp8dCGsgjuk9rx7ge4R4Mand99R
    Uz0L80+65P3Zc/rEDsvh0gNX7q/RID7VWSkOHCMnTmuoxeE32Eb8jr9EGoOBn/+1/tU+
    j/Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694454123;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=ShrofkfKMpSbFwfO0X9kQ0kj/RhvfPGBMpcNqkTeAQY=;
    b=OwPd+XEoTvILtvWUZKerhxLMAtcgSLF/bQ6Ezba+oRErMPlCV50C24JJENuHDK38Vp
    D/UmfA5aYhM3Gl37naN7qbmu8XZAzN9PGSr3Ex2zUdpZjCnRncv+nxn51MgM0/OzYusc
    y5hMp8BPk/XFG9ohaFW98TlXsy8vRt2mAg6QYio3Hc075werX9CtsiIxelUo2B4j6CSf
    AW3H+uDGKzzin8Z5F4kaVx64S2vX0LmcSPMGZOjT/gxi++AHyREZKxvw6hlsZLZUggz2
    8XJ8H3f2VsglzFdnYbj6W8CtCiABKF4qXwdEwP9bHsNf7g9Y9t/FY5S2gcGgN/9OkGjw
    NAgw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694454123;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=ShrofkfKMpSbFwfO0X9kQ0kj/RhvfPGBMpcNqkTeAQY=;
    b=cTu+U7/cbGgiC4zutzo34fDlTA7hu0MQMI9+9Xu935vADnzVVd0RM/ipYbNiOymwlA
    0FGEfXIvV0C99Uu0BHoY9wWTBJRPEPStYC3jNZ2VyHgK0fXzGWYzCUqFTC0Bxif5gSCA
    Qb91km8vNWj5CC5zUs0K4eADQUMx6q3zREXouB46VT7WE126vgrK2UUamo84kgUAIKcK
    jOFY/tzZBUshIpZdY3cdmAahY1JYiTzKxXza+MMZTmMNpmYUiIHpJjuZz1GC5uIkfdzk
    RBp16ie2GPzaFiYViZap//Jefw9NuW14oP+aBwUlIJTYq+KcUKq7t3ZcW80wLe6G2SB8
    zJDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694454123;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=ShrofkfKMpSbFwfO0X9kQ0kj/RhvfPGBMpcNqkTeAQY=;
    b=JAlTjNjQ613e4IXroFSc7IoKPDGm64/AH0KUJ+YoSZhkkalxaoExrTIFngkwm/d9u/
    +/NNq77RfC5TlqIT1WBQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4l38TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id 60372az8BHg3awP
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 11 Sep 2023 19:42:03 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 11 Sep 2023 19:41:47 +0200
Subject: [PATCH 5/9] arm64: dts: qcom: msm8916: Reserve MBA memory
 dynamically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-msm8916-rmem-v1-5-b7089ec3e3a1@gerhold.net>
References: <20230911-msm8916-rmem-v1-0-b7089ec3e3a1@gerhold.net>
In-Reply-To: <20230911-msm8916-rmem-v1-0-b7089ec3e3a1@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
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

At a first glance the MBA memory region on MSM8916 looks intentionally
placed at the fixed address 0x8ea00000. This is what the ELF headers of
the firmware specify as base address, and the typical Qualcomm-specific
bits suggest the binary is not relocatable.

However, on a closer look this is pointless: Unlike other firmware
images the hardware expects to have the raw ELF image loaded to the MBA
region, including the ELF header (without parsing it at all). This
means that we actually just load the ELF header (not the code!) at
0x8ea00000. The real LOAD segments follow at arbitrary aligned
addresses depending on the structure of the ELF binary.

In practice it looks like we can use an arbitrary 1 MiB-aligned region
for MBA. The downstream/vendor kernel just allocates this dynamically
at an arbitrary (aligned) address.

Drop the pointless fixed address and use the new dynamic reserved
memory mechanism to allocate a region close to the others. This reduces
gaps in the memory map and provides Linux with more contiguous memory.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index c237f3e48c86..38f6c8ea605a 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -102,9 +102,11 @@ venus_mem: venus {
 			no-map;
 		};
 
-		mba_mem: mba@8ea00000 {
+		mba_mem: mba {
+			size = <0x0 0x100000>;
+			alignment = <0x0 0x100000>;
+			alloc-ranges = <0x0 0x86800000 0x0 0x8000000>;
 			no-map;
-			reg = <0 0x8ea00000 0 0x100000>;
 		};
 	};
 

-- 
2.42.0

