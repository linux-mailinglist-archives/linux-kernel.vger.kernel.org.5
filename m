Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23D577A8E6
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Aug 2023 18:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232580AbjHMQHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Aug 2023 12:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232543AbjHMQHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Aug 2023 12:07:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B100730F5;
        Sun, 13 Aug 2023 09:07:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A618863822;
        Sun, 13 Aug 2023 16:06:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287D0C433C7;
        Sun, 13 Aug 2023 16:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691942776;
        bh=MAbDjF2njdOYNg9tRPhy20/cP3ibwHDePgjiAVqI1xA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NGMcwE1LEEYdNXGrupdVZNRcBCxh/27SysaxlAgfq4W3yE0V9MnvtrJgLREtYxwSJ
         RddA77M2TZwu+k9GB00dP8KE9KYcU2kXn9ZwY4YWBqXeopiTDhVyL6WgtwBuw2x3fb
         7TZ7ZO1JQjyYI/CFXeyHy4y/P+FVqGBc+6Az8RBrMXlw1wczNbh53NY9UkY2pUAYd+
         k5yyjh1pEuHRNVGlgCYrAwQCydMa67BCaZ1uqz5tfF1XtkAnKXf8RzFUhM7zmoqSyt
         hbBTwaDRrJzz2ad6ZP5J0KzE5k8KByF0jIa3g6Wfinz0hT/5X28fnj4ozMb/Afjx+6
         4yTrNRE7364lQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Adrien Thierry <athierry@redhat.com>,
        Vinod Koul <vkoul@kernel.org>, Sasha Levin <sashal@kernel.org>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        kishon@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 02/31] phy: qcom-snps-femto-v2: use qcom_snps_hsphy_suspend/resume error code
Date:   Sun, 13 Aug 2023 12:05:35 -0400
Message-Id: <20230813160605.1080385-2-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813160605.1080385-1-sashal@kernel.org>
References: <20230813160605.1080385-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.126
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

