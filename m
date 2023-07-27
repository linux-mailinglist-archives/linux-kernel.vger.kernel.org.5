Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77392765E7C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 23:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjG0VyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 17:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232738AbjG0Vxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 17:53:34 -0400
Received: from qs51p00im-qukt01080301.me.com (qs51p00im-qukt01080301.me.com [17.57.155.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CE712C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 14:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1690494782; bh=3kWvcrRZqrEhuwXPUYQrUx6oSTk+cnm7yyjGHHndlRg=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=tXByRccHdiI3EmwUsaLAlYJyszMLKXX3ZRlSDHvCz0AgsRykXtjenQV/C/wou70+1
         pJrRY504Dvp9FNt95Wx93fH/Fuxo8EfD/xH7C7Ffna/YF5LOqUacGXXtV/rIdAyccl
         lW98l0b4VjicyQ26W7WOoNLI9cFGyXNfGk26sWf4LYXr9AGXsIf4H99jpXu/y2VsQr
         nfRFyqDlMuQLPf/+GdB4tGUPQkZg0to9rpfkApDEDRl4M/CZAUnXO9EaKE2MfaIL+n
         q4iEbq5WZWP7UEtwv/KcM83/GYH7QnpF1jbuaQGDHgBz9FwPotoMZIr2pim6B5PZ7x
         hZQqhQAcOsUjA==
Received: from localhost (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
        by qs51p00im-qukt01080301.me.com (Postfix) with ESMTPSA id 67A955F001F2;
        Thu, 27 Jul 2023 21:53:01 +0000 (UTC)
From:   Alain Volmat <avolmat@me.com>
To:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Alain Volmat <avolmat@me.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/14] ARM: dts: sti: enable basic display on stih418-b2264 board
Date:   Thu, 27 Jul 2023 21:51:38 +0000
Message-Id: <20230727215141.53910-15-avolmat@me.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230727215141.53910-1-avolmat@me.com>
References: <20230727215141.53910-1-avolmat@me.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: IPn38HjAvHusKsp4REsH8ccctzKfyPyL
X-Proofpoint-GUID: IPn38HjAvHusKsp4REsH8ccctzKfyPyL
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.138,18.0.790,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-12=5F02:2020-02-14=5F02,2022-01-12=5F02,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 suspectscore=0
 spamscore=0 mlxlogscore=743 adultscore=0 mlxscore=0 phishscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2307270199
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable the compositor, tvout, hdmi and gpu on the B2264 board.

Signed-off-by: Alain Volmat <avolmat@me.com>
---
 arch/arm/boot/dts/st/stih418-b2264.dts | 34 ++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/st/stih418-b2264.dts b/arch/arm/boot/dts/st/stih418-b2264.dts
index fc32a03073b6..35bf618e0783 100644
--- a/arch/arm/boot/dts/st/stih418-b2264.dts
+++ b/arch/arm/boot/dts/st/stih418-b2264.dts
@@ -96,6 +96,14 @@ st,pins {
 			};
 		};
 
+		hdmiddc: i2c@9541000 {
+			/* HDMI V1.3a supports Standard mode only */
+			clock-frequency = <100000>;
+			st,i2c-min-scl-pulse-width-us = <0>;
+			st,i2c-min-sda-pulse-width-us = <5>;
+
+			status = "okay";
+		};
 	};
 };
 
@@ -149,3 +157,29 @@ &spifsm {
 &st_dwc3 {
 	status = "okay";
 };
+
+&sti_compo {
+	status = "okay";
+};
+
+&sti_tvout {
+	status = "okay";
+};
+
+&sti_hdmi {
+	ddc = <&hdmiddc>;
+
+	status = "okay";
+};
+
+&vtg_main {
+	status = "okay";
+};
+
+&vtg_aux {
+	status = "okay";
+};
+
+&gpu {
+	status = "okay";
+};
-- 
2.34.1

