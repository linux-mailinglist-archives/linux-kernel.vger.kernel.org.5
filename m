Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28227E320E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 01:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233436AbjKGAMT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 19:12:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjKGAMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 19:12:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3506BB
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 16:12:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 71E1FC433C8;
        Tue,  7 Nov 2023 00:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699315934;
        bh=IzvDcSXVc6Sv1zIOCJrJxYCGu8IPPHkKg7fcM6qoiKw=;
        h=From:Date:Subject:To:Cc:Reply-To:From;
        b=iS2m562nrCl1RiKX+Sy1RYiunIDGdiPcDySe5O4CZMNtjC83k6cd0IFZQBUoyP6En
         vrvhJ1P4lLueHCUDlA0vqNJnmLZwNsAPscRt1Zx+x3n0xL/NUOk8GjE5oTvn/HqRdQ
         Dd2afZgesSkF0Ox6WEAfoM7jdhVQO8QFsw3LI3h/rxZFhy29zGyft7PTfB/p4oXYxQ
         lqgTq/pqJ33QiB0GNjpSWb9Zk/timrYiIzLFiOWS29ALBzDdJisVc1zYOGe5WEk10I
         /WAEFww3iu25SOTtLJsGHO+cSN5v/U20sR2IzOlAEs6Q7ay/2ZVjT8O+kp0azA4OGw
         IDWMf14m+H7FQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.lore.kernel.org (Postfix) with ESMTP id 54BD3C4332F;
        Tue,  7 Nov 2023 00:12:14 +0000 (UTC)
From:   Steev Klimaszewski via B4 Relay 
        <devnull+steev.kali.org@kernel.org>
Date:   Mon, 06 Nov 2023 18:12:11 -0600
Subject: [PATCH] arm64: dts: qcom: sdm850-lenovo-yoga: Add wakeup-sources
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231106-wakeup-source-v1-1-36b1f39e67fd@kali.org>
X-B4-Tracking: v=1; b=H4sIANqASWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDQwMz3fLE7NTSAt3i/NKi5FRdQ9PENLM000QzYyNLJaCegqLUtMwKsHn
 RsbW1AGuFZptfAAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Steev Klimaszewski <steev@kali.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699315933; l=1648;
 i=steev@kali.org; s=20231106; h=from:subject:message-id;
 bh=XxMr1pRCV6LxTCL9BHo4MJtPNXm2qJQqiz+fIboTk1I=;
 b=vjaUjZqT8uoer/iEV4k7jfxyJNb8OqOWndAP7CAxWb8vSu85CqW+CrAoPCv+59Z0xqc9erI5Z
 +Yjw6KDVd3UCDvzeJtXYgZ7om7X9WAhiQfVPZbUTqH4bva01E/4mHYB
X-Developer-Key: i=steev@kali.org; a=ed25519;
 pk=KY+JnLRNy7Hdf04yfpE5ubOsDBIIfXAWnBijkySXbb4=
X-Endpoint-Received: by B4 Relay for steev@kali.org/20231106 with auth_id=97
X-Original-From: Steev Klimaszewski <steev@kali.org>
Reply-To: <steev@kali.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steev Klimaszewski <steev@kali.org>

The keyboard, touchpad and touchscreen can all be used to wake the
computer up from sleep, so mark them as such in the dts file.

Signed-off-by: Steev Klimaszewski <steev@kali.org>
---
It would be nice to wake up the Lenovo Yoga C630 from suspend by hitting
the keyboard or touchpad or even touchscreen, so this patch enables that
ability.

I'm not married to enabling it for the touchscreen, so if anyone wants
me to drop that hunk, I'd be fine with it.
---
 arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
index 92a812b5f423..9ddffb98408d 100644
--- a/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
+++ b/arch/arm64/boot/dts/qcom/sdm850-lenovo-yoga-c630.dts
@@ -384,6 +384,8 @@ tsel: hid@15 {
 		hid-descr-addr = <0x1>;
 
 		interrupts-extended = <&tlmm 37 IRQ_TYPE_LEVEL_HIGH>;
+
+		wakeup-source;
 	};
 
 	tsc2: hid@2c {
@@ -392,6 +394,8 @@ tsc2: hid@2c {
 		hid-descr-addr = <0x20>;
 
 		interrupts-extended = <&tlmm 37 IRQ_TYPE_LEVEL_HIGH>;
+
+		wakeup-source;
 	};
 };
 
@@ -408,6 +412,8 @@ tsc1: hid@10 {
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c5_hid_active>;
+
+		wakeup-source;
 	};
 };
 
@@ -482,6 +488,8 @@ ecsh: hid@5c {
 
 		pinctrl-names = "default";
 		pinctrl-0 = <&i2c11_hid_active>;
+
+		wakeup-source;
 	};
 };
 

---
base-commit: 3ff7a5781ceee3befb9224d29cef6e6a4766c5fe
change-id: 20231106-wakeup-source-15af6f5a6329

Best regards,
-- 
Steev Klimaszewski <steev@kali.org>

