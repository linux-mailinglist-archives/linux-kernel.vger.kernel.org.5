Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E232978635D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 00:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238615AbjHWW2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 18:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238606AbjHWW2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 18:28:04 -0400
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ABA610C4;
        Wed, 23 Aug 2023 15:28:01 -0700 (PDT)
Received: from newone.lan (unknown [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 3AAEA1603B2;
        Thu, 24 Aug 2023 00:27:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1692829678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JbOL1aGGjwcYcYAlPjSGO3BzDzosz58Vc9m2mNQjvlU=;
        b=txdfsP08hqntqa7PzuK+hevWAcdtRQ5TuT88rfSagLH+CRYO56NDLMzGlg98dpqZUpETjM
        d+f23zG3XbWsT/wQ3FlI8GIAVM/tWZ/aXoHlP0qXcaYkKCJjdcR1nBxgINqJd+eg+O36oV
        gVyjq+i3jWoiWIhKdhgDZGHkFukLivY=
From:   David Heidelberg <david@ixit.cz>
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     David Heidelberg <david@ixit.cz>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: qcom: sdm845: Fix PSCI power domain names
Date:   Thu, 24 Aug 2023 00:27:40 +0200
Message-Id: <20230823222741.89584-1-david@ixit.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original commit hasn't been updated according to
refactoring done in sdm845.dtsi.

Fixes: a1ade6cac5a2 ("arm64: dts: qcom: sdm845: Switch PSCI cpu idle states from PC to OSI")
Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
 arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
index 7b8a359d88c0..d86b0d112110 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845-cheza.dtsi
@@ -144,15 +144,15 @@ panel_in_edp: endpoint {
 };
 
 &psci {
-	/delete-node/ cpu0;
-	/delete-node/ cpu1;
-	/delete-node/ cpu2;
-	/delete-node/ cpu3;
-	/delete-node/ cpu4;
-	/delete-node/ cpu5;
-	/delete-node/ cpu6;
-	/delete-node/ cpu7;
-	/delete-node/ cpu-cluster0;
+	/delete-node/ power-domain-cpu0;
+	/delete-node/ power-domain-cpu1;
+	/delete-node/ power-domain-cpu2;
+	/delete-node/ power-domain-cpu3;
+	/delete-node/ power-domain-cpu4;
+	/delete-node/ power-domain-cpu5;
+	/delete-node/ power-domain-cpu6;
+	/delete-node/ power-domain-cpu7;
+	/delete-node/ power-domain-cluster;
 };
 
 &cpus {
-- 
2.40.1

