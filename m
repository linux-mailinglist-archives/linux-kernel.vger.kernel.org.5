Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2278877A961
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233086AbjHMQL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbjHMQLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:11:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F17C270F;
        Sun, 13 Aug 2023 09:11:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1C8BE63A6A;
        Sun, 13 Aug 2023 16:09:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB03C433C7;
        Sun, 13 Aug 2023 16:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691942985;
        bh=MAbDjF2njdOYNg9tRPhy20/cP3ibwHDePgjiAVqI1xA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uhvxm8z+sh82Ihie1SsgiG13AAh6aZfPcIl8IimyAnEFpheqp3c75cDI5hjnuy7ja
         04wIl/iWeAlDuknQM34x1JGJ4RCAyvL9VVXW16o06wDu/Ic5Mo8zoAGonKGQtS8eBG
         uyfVq5DqCAVNxsTicngOgVDeD3DjIextFsesFpM7g+ufchw9ZFUp7nznP4orgihwcu
         UcmgdT3ZbZaq55DNoelUrnuMXsT4xLpPrqPaMlzKnt96lsgrJNjJ0rvH3kIL1s2Iij
         iU3vwSqwdPyMxIglPJCIfSnzUbnB2JQaFQZw6C9cLpU3yy2dhPV2r2LCgUi6gmTHLs
         xy0RMHC5LPGuw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Adrien Thierry <athierry@redhat.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        kishon@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 02/25] phy: qcom-snps-femto-v2: use qcom_snps_hsphy_suspend/resume error code
Date:   Sun, 13 Aug 2023 12:09:13 -0400
Message-Id: <20230813160936.1082758-2-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160936.1082758-1-sashal@kernel.org>
References: <20230813160936.1082758-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.190
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrien Thierry <athierry@redhat.com>

[ Upstream commit 8932089b566c24ea19b57e37704c492678de1420 ]

The return value from qcom_snps_hsphy_suspend/resume is not used. Make
sure qcom_snps_hsphy_runtime_suspend/resume return this value as well.

Signed-off-by: Adrien Thierry <athierry@redhat.com>
Link: https://lore.kernel.org/r/20230629144542.14906-4-athierry@redhat.com
Signed-off-by: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
index a107f98c662d5..68c21c08a0397 100644
--- a/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
+++ b/drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c
@@ -139,8 +139,7 @@ static int __maybe_unused qcom_snps_hsphy_runtime_suspend(struct device *dev)
 	if (!hsphy->phy_initialized)
 		return 0;
 
-	qcom_snps_hsphy_suspend(hsphy);
-	return 0;
+	return qcom_snps_hsphy_suspend(hsphy);
 }
 
 static int __maybe_unused qcom_snps_hsphy_runtime_resume(struct device *dev)
@@ -150,8 +149,7 @@ static int __maybe_unused qcom_snps_hsphy_runtime_resume(struct device *dev)
 	if (!hsphy->phy_initialized)
 		return 0;
 
-	qcom_snps_hsphy_resume(hsphy);
-	return 0;
+	return qcom_snps_hsphy_resume(hsphy);
 }
 
 static int qcom_snps_hsphy_set_mode(struct phy *phy, enum phy_mode mode,
-- 
2.40.1

