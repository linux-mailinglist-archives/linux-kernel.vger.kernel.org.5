Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4E4E802F66
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjLDJ4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 04:56:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbjLDJ4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 04:56:12 -0500
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B944B2;
        Mon,  4 Dec 2023 01:56:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1701683764; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=UalJ5K5YacFCgSJU9PAOpd9CDIdIt9TFhQybw+eTKhluvuAsSab7o6SfnDp+9dSSCT
    CLAWfw4mwqCuiFfhz787D7swiJ1d5QyFohcAh62NQM+d5+a3KvfLNQi2jN5QO1yRDciQ
    WHUQBvnsV/Fw6ZZEnw3IDXLCD62R5cKuz5Tq5VrjIfsfrnzET5vA9h6T6SMLT6jeQUpu
    cUjdpN8Zx0XDFfzdJrOHMlEV/WPA8KoGqcLFwXoTU1fd+rsJwgYCcvbWFHKLz0zBflit
    2G9Z9VT9hU1QbKZtKMI9MEATaLb5gcrUVnCisX2wwe2PAKuqcDqOXwrwOjiyS3LN46n5
    zqfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1701683764;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=GYSNAjEeGhjGrJ4Pr8zjmuf4tvYXmPYIbiwnZuOFo1o=;
    b=QJQY76CUBe1lchGG+9l2yrBdsCUzfk+UwLdUcdEHVT/RSz4Z8Ddw7hAdm5s26UfhYe
    lhMlU9ZIa8TAiFSgq9nb9ULb5bn7lQE4tuXbtqrxZQhA1Mqnl635qhwODDtpcxvgxqU2
    9WkNSM6cU5GLZrK1VFx210wDX2UyOwnvueBhHU2iKoxka1m5qPSv+dOgbt3JrJxVRbdY
    hWVSYpfbZhzbtDAykYeGjcauL3GdAJJxvWhJmJeGF1XARfGxOkzS6kWv+ci2FmOIBA0j
    zjYCVpfU/PENFI7GI9u1jayxDdQqghd/FK8xkUe7nqD/1efaxGpfYojwDkBG4lGJAe7i
    vrwA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1701683764;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=GYSNAjEeGhjGrJ4Pr8zjmuf4tvYXmPYIbiwnZuOFo1o=;
    b=qFYe8pjEWIoUclSglV6qztxn8PH8O6H6PpZ/efqBNiln83QGcyNqjq74Of7rus3jUX
    xuvm5ax7IXYPv4DCgf4u4UTEZMJij7q2U6A1foT7G5ZiqoA9CVrNbAskhH+XdB0bAaJW
    1/f/jbIYkUmbozGNJft+So3dg/v+JSew/pUxdOLrAgg3epAh2Bf2Tm39edO5/DzRjCFs
    3D0W1Qk5OSyTn+F0nbuyM9gw2gfoYVDf1rpEq81zqo/iPIF6ABYDbWuT5gp6trC4pRG8
    /3cnZ2O+YOrPjrHW/bEm1x1Ow3Q+hFkaaBhZAjdnFwgoHMYFa4Le/XlG3i3JW1AIO+VE
    BzxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1701683764;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:Message-Id:Subject:Date:From:Cc:Date:From:Subject:Sender;
    bh=GYSNAjEeGhjGrJ4Pr8zjmuf4tvYXmPYIbiwnZuOFo1o=;
    b=Y/xhm7w4/L4kPflg5D6PrVepE9A074Di3rHwGQcw2CWW59beRmxW2V5Xk7PPwLjQMn
    jGLegN1dn3Yjldf4wnCA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4l+/zY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.9.7 DYNA|AUTH)
    with ESMTPSA id R5487bzB49u39nd
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 4 Dec 2023 10:56:03 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 04 Dec 2023 10:55:53 +0100
Subject: [PATCH] arm64: dts: qcom: msm8939: Add clock-frequency for
 broadcast timer
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231204-msm8939-timer-v1-1-a2486c625786@gerhold.net>
X-B4-Tracking: v=1; b=H4sIACiibWUC/x3MQQqAIBBA0avErBN0dKFdJVqITTULLTQiEO+et
 HyL/ysUykwFpqFCpocLn6lDjQOEw6edBK/dgBK1QmlELNE67cTNkbIINqCy3qMxEnpzZdr4/X/
 z0toHwTNaEV8AAAA=
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Benjamin Li <benl@squareup.com>,
        James Willcox <jwillcox@squareup.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Jun Nie <jun.nie@linaro.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephan Gerhold <stephan@gerhold.net>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like not all firmware versions used for MSM8939 program the timer
frequency for both broadcast/MMIO timers, causing a WARNING at runtime:

WARNING: CPU: 0 PID: 0 at kernel/time/clockevents.c:38 cev_delta2ns+0x74/0x90
pc : cev_delta2ns+0x74/0x90
lr : clockevents_config.part.0+0x64/0x8c
Call trace:
 cev_delta2ns+0x74/0x90
 clockevents_config_and_register+0x20/0x34
 arch_timer_mem_of_init+0x374/0x534
 timer_probe+0x88/0x110
 time_init+0x14/0x4c
 start_kernel+0x2c0/0x640

Unfortunately there is no way to fix the firmware on most of these
devices since it's proprietary and signed. As a workaround, specify the
clock-frequency explicitly in the DT to fix the warning.

Fixes: 61550c6c156c ("arm64: dts: qcom: Add msm8939 SoC")
Reported-by: Vincent Knecht <vincent.knecht@mailoo.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 arch/arm64/boot/dts/qcom/msm8939.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8939.dtsi b/arch/arm64/boot/dts/qcom/msm8939.dtsi
index 95610a32750a..4ba115eecfd5 100644
--- a/arch/arm64/boot/dts/qcom/msm8939.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8939.dtsi
@@ -2195,6 +2195,8 @@ timer@b120000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
+			/* Necessary because firmware does not configure this correctly */
+			clock-frequency = <19200000>;
 
 			frame@b121000 {
 				reg = <0x0b121000 0x1000>,

---
base-commit: adcad44bd1c73a5264bff525e334e2f6fc01bb9b
change-id: 20231204-msm8939-timer-c8c218aa2440

Best regards,
-- 
Stephan Gerhold <stephan@gerhold.net>

