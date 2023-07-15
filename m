Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72B0E7549F0
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 17:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbjGOP4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 11:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230084AbjGOP4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 11:56:03 -0400
Received: from out203-205-251-66.mail.qq.com (out203-205-251-66.mail.qq.com [203.205.251.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA56030E4
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 08:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1689436554;
        bh=Q4AIE3ORkFkez9a9uTEasaw5aPDPog8DGCyhlYhijtQ=;
        h=From:To:Cc:Subject:Date;
        b=GMWOWCEdxyejehSeGxTCRvzUMZwIhu9T9aiQ1nVL+8sqyLNglqhdWuEAt3pVdNLcm
         pAFEtt97vhItDuKe7KToiipwerj1PxkMVxUqSsjTkE7A4LNPQWbj/BEwBUZ08+ZD/2
         XiyZ5bdHyQWCkZ2KrPXsH2RxDEXdE2buIxQ7uD2E=
Received: from KernelDevBox.byted.org ([180.184.49.4])
        by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
        id DF305C36; Sat, 15 Jul 2023 23:55:51 +0800
X-QQ-mid: xmsmtpt1689436551toyuslagu
Message-ID: <tencent_994DA85912C937E3B5405BA960B31ED90A08@qq.com>
X-QQ-XMAILINFO: Mh1dUllL/+A2vhqHkhb7/gbp7caHWu3yMPEaqAyj5XA8papyHBSXtvAfD/ZjW3
         C4kT0qRyiZZKbdkqCYuxPuM9KQO8fzJ/ju1Ab8Pds4sdFaTl3RnLpBWT7mFN3HJaq9Bo/MPvh31B
         VfUEXkWQR6WzB2VrYboWIhWpWuwmnZSIIpn0ZFVQqcxixa3Iam3ai8+k1ZrCM/tZwAQF328cdCNi
         zM6z6E0JnfFqyAPER780NcHNyGGxIbhabC4r674y17MelD9RJRL74b2TFr60cvR1ZthrcGfn1GFP
         UGkGu++cyhOF37to76jS4umSneMTn4JmLH33y7G1yO6x1HpynmCNj+G8Oc3dRXQux2/kcP8MXKRx
         15jmN5YKDvnjstk4WGF6GJCcGT0oZ9VnyQOdt6ikh+RzjPMM/L8C8JcEM+FbeMIUba2giTmurVj+
         REJnfM3DiZH5YrTNUvIR0zeZVjwJGNjkGRlMZkY6aQnzXsb8wthhjdBlHYMxHNDS5FPElAESdN5+
         /tp0YWENXjW/F1vn7FhBxor7suyS6+UdXy8+gYu8wA8NpEXjoIfRBhQDpX1ZoQc3b537VxBR5IUu
         uF+Ke1KSmyuMSYY/KnCzLPCBmOAXvJb8IOUH5CScml1b7Xh9BujIqIGK792Q6lgH7A9UddFC9AzB
         TAEXPefm+fLuN6Y3mC/ek0jjWgpgVN30AZgR3BW9WB5Gq/PfOggAgzcVLRpqthSzqUaY0GAkXMho
         zxMQTeuGFc9aX3I3cFmTWODlrX69jiO5+eap74ZB2NeMnH93qKhK79o267XTzhnK8z7S/+xzz1VT
         oUxa1pYgGLmT5l/4FHiBTIrrFlRFNOQrf4fo78r+Cha5Zy3km/qSULIqXl8LsLGu8MTr8j+hzChM
         tKUuUcUe/xhWmPv3Hy7YVfnwa/vWSowwY+gR1CeYGoAL/CwIqEugA3m5945C883OYJ/fON0b3L3t
         0zTxRDb/JE+35a3SbEPet/LUVTXHPsr5U187AvQTrktEn0jD01flhEtxGgcXnPdJzfCgV+/gqlLz
         pL2Cqzuw==
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     jic23@kernel.org
Cc:     lars@metafoo.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, lgirdwood@gmail.com,
        broonie@kernel.org, linux-iio@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] io: adc: stm32-adc: fix potential NULL pointer dereference in stm32_adc_probe()
Date:   Sat, 15 Jul 2023 23:55:50 +0800
X-OQ-MSGID: <20230715155550.2306245-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_match_device() may fail and returns a NULL pointer.

Fix this by checking the return value of of_match_device().

Fixes: 64ad7f6438f3 ("iio: adc: stm32: introduce compatible data cfg")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/iio/adc/stm32-adc-core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 48f02dcc81c1..70011fdbf5f6 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -706,6 +706,8 @@ static int stm32_adc_probe(struct platform_device *pdev)
 	struct stm32_adc_priv *priv;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = pdev->dev.of_node;
+	const struct of_device_id *of_id;
+
 	struct resource *res;
 	u32 max_rate;
 	int ret;
@@ -718,8 +720,11 @@ static int stm32_adc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	platform_set_drvdata(pdev, &priv->common);
 
-	priv->cfg = (const struct stm32_adc_priv_cfg *)
-		of_match_device(dev->driver->of_match_table, dev)->data;
+	of_id = of_match_device(dev->driver->of_match_table, dev);
+	if (!of_id)
+		return -ENODEV;
+
+	priv->cfg = (const struct stm32_adc_priv_cfg *)of_id->data;
 	priv->nb_adc_max = priv->cfg->num_adcs;
 	spin_lock_init(&priv->common.lock);
 
-- 
2.30.2

