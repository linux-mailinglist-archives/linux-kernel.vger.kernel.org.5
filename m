Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1019979B0AF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378941AbjIKWiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243777AbjIKRmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:42:19 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFDECCA;
        Mon, 11 Sep 2023 10:42:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694454124; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=TJuivGTS3gMxi5ijhqwVUJeLNISoDTTiT3MsrM6c1j0tjn82/GwgyP9eRBviFA2lVT
    uqrCyxLqtKrI/80KxZUQ5wCKY9rIqO6WMNiR8FdsOL1XycbXRTlvL0pjhcSvH+0YzIPt
    2vbEOtkmMfBZgssQitCcXVfiQ1x6NZunDTGeOpEkoF/aE3IxEK7CO+5mmCF2nsDhRLSE
    F5BheBYWfy6VWs3XC89p4jmTpu+8QtSJ9jrGXpkDGEF0qYwLjU1JprbeTaDn8QCybVcA
    nxZiJRRH4hOa5PwUcdqKDiI0YOEyrq38oWWGBIzASSTgyVvkCQjtBrSUqWdqOYprAVk0
    V39A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694454124;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=X9g3iLRlx0W4EEcfM/wQIFM4jrKGu03h91oMBbwEEnI=;
    b=cOSaW32QlXsRyHrpKdR0Us3CKu71L3IGKLBJFmRI4twZZeo6nLl1r6IFC/P+VyA+iw
    LBj2X8p0ef35XKDnmaeGot42/57fKjYZBj0NswANTxwnPO6lrKVF9T226SZnx3+iNtPs
    HWPLTlYTnNMh+waejffOfNITbs59/A0mc5nbYw4MbbNJ09OiE2OLVj2x5jsXVAakvxV5
    J//7Ai9nPT6+kKzNXkgoTnXXmklkDjOVXNzTaWMxMDk4amLIDD2Nq71gF8CWymAFiLiz
    gCtlX3HubcEYqJSm3cNXhrkhLq07gSDxWTxNoUj2JkYkH0AXO5ICciNE6dyHrTjScIRw
    9WqQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694454124;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=X9g3iLRlx0W4EEcfM/wQIFM4jrKGu03h91oMBbwEEnI=;
    b=X5aPviOXyTunGLrwQyT1ha+CUOS6d362nT5VmGxeIK9HNxb0usGyfA6xi6ZZrYYS6M
    K+qFFeqa1LhnG/jQ+Sz9uVESDikUdi+uGPSFNqVtFGgFmIquXL86+2yJ347HqAjjM3p1
    lR+h+VtrYDUz4Ejp37r5cekCOwo59YYa1BN221HJY2KHuqVctRL5EF0JeVw7VsxKlv8W
    TCBiKt/YT2JGl6usBNehe2yyrke2OIDn+8SpW+jGGJHNkap/Ii3pTl/EN/yeY3sQ3eiE
    NtNlQ8F1SUW3YT+GiBujI6LJg4JB5G+xL98fjfAY8xcNCyQTJqttw6n1lUH9i5cGvHw8
    fyIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694454124;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=X9g3iLRlx0W4EEcfM/wQIFM4jrKGu03h91oMBbwEEnI=;
    b=eXFpZQt4NxVxMB2pXdOMBy5tkxMLYb4O/SuY+8f/LAEd/lT1yxit2nQFLyWEkFvm71
    wOV48+m2XXv37zxZRvBw==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4l38TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id 60372az8BHg4awT
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 11 Sep 2023 19:42:04 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 11 Sep 2023 19:41:51 +0200
Subject: [PATCH 9/9] arm64: dts: qcom: msm8916/39: Fix venus memory size
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-msm8916-rmem-v1-9-b7089ec3e3a1@gerhold.net>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both MSM8916 and MSM8939 have unnecessarily large reservations for the
venus firmware for some reason. According to the ELF headers and
downstream [1] 5 MiB is enough. Let's set the minimum size as default.

With the dynamic reserved memory allocations boards can easily override
this if needed, although in practice there does not seem to be any
device with a different venus firmware size.

[1]: https://git.codelinaro.org/clo/la/kernel/msm-3.10/-/blame/LA.BR.1.2.9.1-02310-8x16.0/arch/arm/boot/dts/qcom/msm8939-common.dtsi#L69

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 2 +-
 arch/arm64/boot/dts/qcom/msm8939.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 4d867078388d..1e94e26b8fb0 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -98,7 +98,7 @@ wcnss_mem: wcnss {
 		};
 
 		venus_mem: venus {
-			size = <0x0 0x600000>;
+			size = <0x0 0x500000>;
 			alignment = <0x0 0x100000>;
 			alloc-ranges = <0x0 0x86800000 0x0 0x8000000>;
 			no-map;
diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index ba177725f3d7..715c86c217c5 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -370,7 +370,7 @@ wcnss_mem: wcnss {
 		};
 
 		venus_mem: venus {
-			size = <0x0 0x800000>;
+			size = <0x0 0x500000>;
 			alignment = <0x0 0x100000>;
 			alloc-ranges = <0x0 0x86800000 0x0 0x8000000>;
 			no-map;

-- 
2.42.0

