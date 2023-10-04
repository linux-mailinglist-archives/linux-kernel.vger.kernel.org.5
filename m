Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D3D07B786B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 09:12:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241367AbjJDHMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 03:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbjJDHMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 03:12:19 -0400
Received: from out162-62-57-252.mail.qq.com (out162-62-57-252.mail.qq.com [162.62.57.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D686AB
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 00:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1696403530;
        bh=nnsazRl0VawtG0Ot+fpS8kiTavsPsKlA4kc+rHNHQmU=;
        h=From:To:Cc:Subject:Date;
        b=hdIiuHX+JSQipiYLgLufs4vbNdi2C/znrA9pbkdQ49mAJZCxxaHdnrBtytiZslGq7
         NB0IWLDtOsg69qHWOEpd/kxpKXZ6OpFkcTe2ZDM3HU0e3EfHTviT3YDztMcDk0pslE
         gBXa08c8RmGCU33UwDrUGo62+yogqH5zV510Xxds=
Received: from KernelDevBox.byted.org ([180.184.49.4])
        by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
        id 3071DA8C; Wed, 04 Oct 2023 15:12:07 +0800
X-QQ-mid: xmsmtpt1696403527tq1y2h3b8
Message-ID: <tencent_681B0528D436898B1B945A8B2D46300C0F07@qq.com>
X-QQ-XMAILINFO: M5ZQ+xctoGy32JF2BS+69Ng/YkDt5B0Lg7DW4BkRYST/lLCvbYHJTGm0NllUmu
         D69sI1B/XbiUDrolkyjamC4AYqdlhGJvMdGX+BaoYDGEhmdDg8hisMOlN9/D6M0Xg2loqGHDBGkx
         Jbt5lrV0JxzxQU47wEKg5RkKBCVQLafviOR0h+ftgTNpHBS0kWLj8Ht5WC3Jp6YaNmgJsAEV0UrE
         M7LLS+lZAX4bRzNFOXLxlnlYKjbVsPf29BfXF3YxcZkZM26aIfY5bNfcPAZBzzV7RNWsLsCJCDBZ
         I08mmmNrBiCezn6iZXFMiAcHUNdRQZSryKV4geVq0Ur51WDhjq76d6FAe3K0EF6kSHgAV1cIF1eU
         eR1GaEIU5z2FgC6Cx8mkJopFZbxbjR4m/r0uCA/jUaw5YNN0HaMcpl4EtDD5zCOmRPZAnJmibh6p
         3VfZcXxbsB8fcfsKnXEmbiu06tVmSujcpCO4nGDuj5MOOUlA7OtuGE4eSyoqi7Drit+cLDhAFMmR
         Rn/5Aan1+PxrMn1wu6lSFavUdcx3Jekp2bJBElfzShplchKK0MEmUrUn5AI6WfHZAWQwdWyb0Ys7
         OD2jakV3BMJmmIn/Llguqn1PEM+s5BJ6svDtDYwAcoOnnAkTk9ZktdSKmwSlG0rkKgYORO/kNdRB
         n3fNM8brtoaT49CskpiVAMO86Y8VfZ8noNTktPyqX/N4PdVAO88o+GPey2LLvzUFQ18bJRdJD5Tm
         XEnpxuzUDja0UzyMD7hQWFTrQuq18gNyxjwRjLepDzEcBCOAXW7zRW/rWh1iI0ZhxOMDEmOctoqN
         DJEGcovROsDoaaL3C/wLrOCdVDkPnH1jYTgZr0k9dRL2NyGwvyrHGAS5fbhmKcJxH47Cs1W/lu3L
         B+LztfDUYpLw+8ViKP8CMN9RNG1iLgp7YXo/+dxeaxRs28m8FkMQ+1k+TBlHDjosqn2hHus+enMW
         r60evUAPfdYRqsFWNtjjDFk7QS2gQEX4CgdPBtCEAdvFRXiLVOfGJu9bCbmTfX
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     shengjiu.wang@gmail.com
Cc:     Xiubo.Lee@gmail.com, festevam@gmail.com, nicoleotsuka@gmail.com,
        lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz,
        tiwai@suse.com, alsa-devel@alsa-project.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] ASoC: fsl: Fix PM disable depth imbalance in fsl_easrc_probe
Date:   Wed,  4 Oct 2023 15:12:05 +0800
X-OQ-MSGID: <20231004071205.3857082-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pm_runtime_enable will increase power disable depth. Thus
a pairing decrement is needed on the error handling path to
keep it balanced according to context. We fix it by calling
pm_runtime_disable when error returns.

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 sound/soc/fsl/fsl_easrc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_easrc.c b/sound/soc/fsl/fsl_easrc.c
index ba62995c909a..ec53bda46a46 100644
--- a/sound/soc/fsl/fsl_easrc.c
+++ b/sound/soc/fsl/fsl_easrc.c
@@ -1966,17 +1966,21 @@ static int fsl_easrc_probe(struct platform_device *pdev)
 					      &fsl_easrc_dai, 1);
 	if (ret) {
 		dev_err(dev, "failed to register ASoC DAI\n");
-		return ret;
+		goto err_pm_disable;
 	}
 
 	ret = devm_snd_soc_register_component(dev, &fsl_asrc_component,
 					      NULL, 0);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register ASoC platform\n");
-		return ret;
+		goto err_pm_disable;
 	}
 
 	return 0;
+
+err_pm_disable:
+	pm_runtime_disable(&pdev->dev);
+	return ret;
 }
 
 static void fsl_easrc_remove(struct platform_device *pdev)
-- 
2.30.2

