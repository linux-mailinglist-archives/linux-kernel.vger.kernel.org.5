Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0600E7886A3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 14:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243472AbjHYMIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 08:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244278AbjHYMIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 08:08:41 -0400
Received: from ixit.cz (ip-89-177-23-149.bb.vodafone.cz [89.177.23.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A797D1FD7;
        Fri, 25 Aug 2023 05:08:35 -0700 (PDT)
Received: from newone.lan (unknown [10.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 2315E160DEB;
        Fri, 25 Aug 2023 14:08:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1692965313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=pae7jNEUWIbCA6Cxpla8nGwVfRkepono+Bcu36eDc9E=;
        b=1/7lSlDNPD3AiIYfLTd20Kc+Mg702/XPsgGnwAD0kIHvKqzMyzIVeQ5MzBT8+3adae0Qp3
        Sbmk2rT3DIzrFNjdiLURz9lin4kEK6BGzL6/jV2eG1C1yWWfCKC34wFDcttEgiwLua+lg0
        2kaL9JkSsQoaPoDXn5elo2OC72nk3BI=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     David Heidelberg <david@ixit.cz>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ARM: dts: qcom: msm8660: drop 2nd clock frequency from timer
Date:   Fri, 25 Aug 2023 14:08:31 +0200
Message-Id: <20230825120832.10732-1-david@ixit.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The driver reads only one clock frequency, and the schema does not
allow more than one frequency here.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
v2:
 - fix typo in commit message s/msm8960/msm8660/

 arch/arm/boot/dts/qcom/qcom-msm8660.dtsi | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/qcom/qcom-msm8660.dtsi b/arch/arm/boot/dts/qcom/qcom-msm8660.dtsi
index 78023ed2fdf7..23f7b67d9d61 100644
--- a/arch/arm/boot/dts/qcom/qcom-msm8660.dtsi
+++ b/arch/arm/boot/dts/qcom/qcom-msm8660.dtsi
@@ -109,8 +109,7 @@ timer@2000000 {
 				     <1 1 0x301>,
 				     <1 2 0x301>;
 			reg = <0x02000000 0x100>;
-			clock-frequency = <27000000>,
-					  <32768>;
+			clock-frequency = <27000000>;
 			cpu-offset = <0x40000>;
 		};
 
-- 
2.40.1

