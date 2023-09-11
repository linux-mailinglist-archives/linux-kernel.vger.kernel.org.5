Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994E379ADA4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344353AbjIKVN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243773AbjIKRmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:42:18 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27E341A7;
        Mon, 11 Sep 2023 10:42:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694454123; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jb7zf8OTlRokZeA43Vsusc/wSRwJZ3ko79ZM8bSJ95dC1zSdaZ5tJi8rK8lP7C8Qdi
    CDtbg2Q/9mh04Q637R6u6h6ilIQJRhxS3AoGXBfUub2ekGV7YRmuGGDuJsLNbH38z8HB
    QXmkEp/sKL19FnnTQR9zMxp+O0GRkdhb16SbcVrBMnhcLfgWof0pYJWMz7tnw7szdqTv
    ZtnvxIMrUMnUS6vXTgBqOwkL4q9+8CA+7TiDvbTZOEa2LdPEPgZ45+3QMjgjKtFCB7UD
    Q5Lsmg0yYEwGgIUnlrxlPMYrYO+Tm6V3/2dh59z6+6ifVEKtY4r5C3Eg3UV3yaUtBv6p
    z+xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694454123;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=zid5A9mrDBDiMz5qTZXzLHu4gdhlVK+coBW08Vfgozg=;
    b=G/xPkPmAmQPZ4Vbeqn0UE3Uu9K/dz45fNrbmmOlYx1UHSYiCwwfTlzK3kEPQuE89cq
    KrYYHd6/MvCNl5HFmDbjY/ZbB+fK92zixGwPz/b0DdsVyMJeO4V7KVn3RJ2lm7SQgIuo
    3IFVyf2Ir95Ud/FzGwF3Tonm3OdEdcdv7MOmHIlGYM5lv5+559KrHNWZ0K8qoox889bS
    7cY0fGfGGmkclMcIIjTRbcd9mC6/HJgpit1JOw5wLIHp3l1GOlQSGAXNZ8X/jJGtBdv7
    51dXH2ebKq6OKAPaY6hTQUoaIqB+X4p0/XsY420844gN3JNY5bDwvT+zySNI1jjuQU3p
    WIrQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694454123;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=zid5A9mrDBDiMz5qTZXzLHu4gdhlVK+coBW08Vfgozg=;
    b=TpAc71yn1FFhuqSQOLqpkGZW4TAC2wn+WSljMx3nYPRreob2+Mt1XO7u8LwWcK2WZb
    59Nyps+3TlvzVFDYTWRlPApTQt3Tmp3uR5BquDgsBpDyU/4sb6yj9ushrFna7Atg4pdd
    wWdP3tTCJ9hIE1P1NFry2WICJrW6mxXkgXK6QVY0t+U6EzdDwkVXqiAJnjSn1elzZ300
    YHjJByniSObpw8SNM+z2ZrQGJx8Ttddc5gKh3NxSVThiLY81BWQAfZkqVZ8d/DNb/CSe
    xk1MkVda0hSbEYA1Cw/vl5/mtbpv2pPBIXRNKV+iqIWMi0L/Nr71uuLxXNolVoX1v/2p
    k0aQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694454123;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=zid5A9mrDBDiMz5qTZXzLHu4gdhlVK+coBW08Vfgozg=;
    b=GkdhUeCrXpn+AfGZxQjWI8DA4aETARMIqcwCcXXKAeOH80wEbW6qxNk2bBbZjsfESE
    J2oPEVjmnWQAqfwuVXDA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4l38TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id 60372az8BHg3awQ
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 11 Sep 2023 19:42:03 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 11 Sep 2023 19:41:48 +0200
Subject: [PATCH 6/9] arm64: dts: qcom: msm8939: Reserve firmware memory
 dynamically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-msm8916-rmem-v1-6-b7089ec3e3a1@gerhold.net>
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

Follow the example of MSM8916 and reserve the firmware memory regions
dynamically to allow boards to define only the device-specific parts.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/msm8939.dtsi | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index b0a64e468629..ebea6de1177b 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -346,22 +346,38 @@ rfsa@867e0000 {
 		};
 
 		mpss_mem: mpss@86800000 {
+			/*
+			 * The memory region for the mpss firmware is generally
+			 * relocatable and could be allocated dynamically.
+			 * However, many firmware versions tend to fail when
+			 * loaded to some special addresses, so it is hard to
+			 * define reliable alloc-ranges.
+			 *
+			 * alignment = <0x0 0x400000>;
+			 * alloc-ranges = <0x0 0x86800000 0x0 0x8000000>;
+			 */
 			reg = <0x0 0x86800000 0x0 0x5500000>;
 			no-map;
 		};
 
-		wcnss_mem: wcnss@8bd00000 {
-			reg = <0x0 0x8bd00000 0x0 0x600000>;
+		wcnss_mem: wcnss {
+			size = <0x0 0x600000>;
+			alignment = <0x0 0x100000>;
+			alloc-ranges = <0x0 0x86800000 0x0 0x8000000>;
 			no-map;
 		};
 
-		venus_mem: venus@8c300000 {
-			reg = <0x0 0x8c300000 0x0 0x800000>;
+		venus_mem: venus {
+			size = <0x0 0x800000>;
+			alignment = <0x0 0x100000>;
+			alloc-ranges = <0x0 0x86800000 0x0 0x8000000>;
 			no-map;
 		};
 
-		mba_mem: mba@8cb00000 {
-			reg = <0x0 0x8cb00000 0x0 0x100000>;
+		mba_mem: mba {
+			size = <0x0 0x100000>;
+			alignment = <0x0 0x100000>;
+			alloc-ranges = <0x0 0x86800000 0x0 0x8000000>;
 			no-map;
 		};
 	};

-- 
2.42.0

