Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB0D79B458
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354293AbjIKVxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243775AbjIKRmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:42:19 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308E61BB;
        Mon, 11 Sep 2023 10:42:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1694454123; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=eTb0gE9hU8uBDBkpRRFbKGEuQ2RS1XoW45bbfW/aqGrghAmUJqN27msK+Sn7jDYL9j
    OF/Xo9bjunBJXqDX1RYIdsxHsnKxKJyMEt01k7OL8zhRpkU/7FaX0PblT9+bkctOSOOm
    U5bD6cPQ7GjTg05ZVCaWPjBcEn+Qpzg2z3xvIJviyIpBsA+j74ipmxbTElAoktEpg+A/
    Q3ICuEcyczDXvbLMLzNunQmfVPc/cEJVDZ1adRYWNZI7LR+chFtssdMeh1UKBXclYLwx
    MF+qYQNnrThY12DHi3925VUpfdKxtBb0Pyx59Vto8LZj/0wJ5U3wBmSlE0dg3s7RGF+V
    m+Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1694454123;
    s=strato-dkim-0002; d=strato.com;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=53ctMRM8ae+O8gJORVGlhrL6VfPj4kCfzWruA73aqMI=;
    b=Qw3ftjW9e+rPBAXCpZ2kwGvvgZVLriLV47hqLOzHnk9nH1K/2POga+DzkXKGrgzYwY
    xmDwXaQfvi8XPhQQvOP9gHUWGFale4KmaGvFn7pCZL++d0tm9pDSuFEoKJGerUpLImi5
    b7u9cIQRdHEbRAF7LV40VvLC6v16BeEf7KSsGgkpM8mIi88z9plGtnpFxcX0OmWWsNha
    UFwtqs/1AMvdaGNHXbCPUX4Q72oZEmXFZebnUH05MPNDEr5IFfcfqOfzaiek+GiXnFWy
    f1RRjTzVdwiuJ5hN3T78GO+gj003NBS68XGOBsNyH4Y/4JFzY+YzMEIq6bceHaMQu8RA
    fTFA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1694454123;
    s=strato-dkim-0002; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=53ctMRM8ae+O8gJORVGlhrL6VfPj4kCfzWruA73aqMI=;
    b=B/g1M8tzFu5ZMhydu2fK9KclEHt/rWeXPwf3VkQzyA7o3/qQdDpFmPSnCH05Q72kyd
    4jsqzE+CehyIrU3YLa9O6sV+a5qD2oqzEuF9sEPuNM1FkT2Ju06CJ38D6uSucIkp8MqA
    jlfrmQkQl0JsUbUE74BjtmlUmkXTZhwB8jXGclp4klbc6iZaasnGT8CKb2ChcHZ2d3o/
    ugEVtxl1bzvjN/rXitDLJpfPR1/5S+fxY2xEbuUeQqofvsks3H8ZnMAJgM/xJzAKgfGU
    BNozXZxUop2HZCcsYSwehG0ar+Sxm0CE+JTk3kn7zzq3WQIo+RQijAK4u9zf4WB8PYID
    8oIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1694454123;
    s=strato-dkim-0003; d=gerhold.net;
    h=Cc:To:In-Reply-To:References:Message-Id:Subject:Date:From:Cc:Date:
    From:Subject:Sender;
    bh=53ctMRM8ae+O8gJORVGlhrL6VfPj4kCfzWruA73aqMI=;
    b=vFB0HqYAUyPKZY/BAlA8jKRJyuQobCDHMjcUhiayunLFegR2BReZxQq7yJDBqWhJZx
    bEwOHmFuYbwAAdY9A5AQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQjVd4CteZ/7jYgS+mLFY+H0JAn8u4l38TY="
Received: from [192.168.244.3]
    by smtp.strato.de (RZmta 49.8.2 DYNA|AUTH)
    with ESMTPSA id 60372az8BHg3awO
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 11 Sep 2023 19:42:03 +0200 (CEST)
From:   Stephan Gerhold <stephan@gerhold.net>
Date:   Mon, 11 Sep 2023 19:41:46 +0200
Subject: [PATCH 4/9] arm64: dts: qcom: msm8916: Reserve firmware memory
 dynamically
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-msm8916-rmem-v1-4-b7089ec3e3a1@gerhold.net>
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
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the reserved firmware memory on MSM8916 can be relocated when
respecting the required alignment. To avoid having to precompute the
reserved memory regions in every board DT, describe the actual
requirements (size, alignment, alloc-ranges) using the dynamic reserved
memory allocation.

This approach has several advantages:

 1. We can define "templates" for the reserved memory regions in
    msm8916.dtsi and keep only device-specific details in the board DT.
    This is useful for the "mpss" region size for example, which varies
    from device to device. It is no longer necessary to redefine all
    firmware regions to shift their addresses.

 2. When some of the functionality (e.g. WCNSS, Modem, Venus) is not
    enabled or needed for a device, the reserved memory can stay
    disabled, freeing up the unused reservation for Linux.

 3. Devices with special requirements for one of the firmware regions
    are handled automatically. For example, msm8916-longcheer-l8150
    has non-relocatable "wcnss" firmware that must be loaded exactly
    at address 0x8b600000. When this is defined as a static region,
    the other dynamic allocations automatically adjust to a different
    place with suitable alignment.

All in all this approach significantly reduces the boilerplate necessary
to define the different firmware regions, and makes it easier to enable
functionality on the different devices.

Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 .../boot/dts/qcom/msm8916-longcheer-l8150.dts      |  9 +++++++--
 arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi          | 11 ++++-------
 arch/arm64/boot/dts/qcom/msm8916.dtsi              | 22 ++++++++++++++++++----
 3 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
index a0bb8de54fb6..503155aefa55 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
@@ -23,9 +23,14 @@ chosen {
 		stdout-path = "serial0";
 	};
 
+	/*
+	 * For some reason, the signed wcnss firmware is not relocatable.
+	 * It must be loaded at 0x8b600000. All other firmware is relocatable,
+	 * so place wcnss at the fixed address and then all other firmware
+	 * regions will be automatically allocated at a fitting place.
+	 */
 	reserved-memory {
-		/* wcnss.mdt is not relocatable, so it must be loaded at 0x8b600000 */
-		/delete-node/ wcnss@89300000;
+		/delete-node/ wcnss;
 
 		wcnss_mem: wcnss@8b600000 {
 			reg = <0x0 0x8b600000 0x0 0x600000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
index 69f268db4df9..1d92c2e57216 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-ufi.dtsi
@@ -17,13 +17,6 @@ chosen {
 		stdout-path = "serial0";
 	};
 
-	reserved-memory {
-		mpss_mem: mpss@86800000 {
-			reg = <0x0 0x86800000 0x0 0x5500000>;
-			no-map;
-		};
-	};
-
 	gpio-keys {
 		compatible = "gpio-keys";
 
@@ -91,6 +84,10 @@ &mpss {
 	status = "okay";
 };
 
+&mpss_mem {
+	reg = <0x0 0x86800000 0x0 0x5500000>;
+};
+
 &pm8916_usbin {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 0257cbbb4971..c237f3e48c86 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -74,17 +74,31 @@ rfsa@867e0000 {
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
 			reg = <0x0 0x86800000 0x0 0x2b00000>;
 			no-map;
 		};
 
-		wcnss_mem: wcnss@89300000 {
-			reg = <0x0 0x89300000 0x0 0x600000>;
+		wcnss_mem: wcnss {
+			size = <0x0 0x600000>;
+			alignment = <0x0 0x100000>;
+			alloc-ranges = <0x0 0x86800000 0x0 0x8000000>;
 			no-map;
 		};
 
-		venus_mem: venus@89900000 {
-			reg = <0x0 0x89900000 0x0 0x600000>;
+		venus_mem: venus {
+			size = <0x0 0x600000>;
+			alignment = <0x0 0x100000>;
+			alloc-ranges = <0x0 0x86800000 0x0 0x8000000>;
 			no-map;
 		};
 

-- 
2.42.0

