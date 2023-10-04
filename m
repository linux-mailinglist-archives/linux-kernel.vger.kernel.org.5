Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144EE7B81DC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 16:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242761AbjJDOLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 10:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbjJDOLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 10:11:10 -0400
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B5EC0
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 07:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1696428661;
        bh=IFCQ36qNYlflTBGjiB1GM2HwJb7GMQotoPrkQGvpdeg=;
        h=From:To:Cc:Subject:Date;
        b=Ed75rZf6M+IpUoq5l/7eDz/2l/PFWZOFwxrsqe8QpNOoA0ka8cywnByqou3fsDFvc
         8YEzUxgf6y8PmwywuXQeCjP7JKOapMbwYQ+F+Id7ZczFXfZ2LCP8/WtyNXYDit1XAF
         m9zc5KtGI7Se5d+1wxkzsqQYjW18L7cp7Bvrnr44=
Received: from KernelDevBox.byted.org ([180.184.49.4])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id 2B994C3D; Wed, 04 Oct 2023 22:10:57 +0800
X-QQ-mid: xmsmtpt1696428657tu2n08duz
Message-ID: <tencent_B13DB7F6C0023C46157250A524966F326A09@qq.com>
X-QQ-XMAILINFO: N1rJBQiDRgEyuI+t+UbeNj+Wm8g6/mII93pNgmgQXgZB0grYJnsuHkWW150X/k
         21GnTcWuJzWLUqL8jZqdpOxpfpF6FU1hvRJVCLIRev+ZCgBZ26meJNtlueLs2atXChSz/wu8Uhdi
         1zfLBk6z/TKYpUs1BTpNJ1q8BtuzYOcupt1BvWYF0xFIE0W1XZoFXgXmqSzaRPNrRwfPnR7Cj0AX
         49UJtPqoxp06Y2YAPp48Dk13TNOqGe3QfnSFpjkkiQuALxDjCs4xkJpnEFt6opK4+dFlKDjJTg4n
         /BciY+2ggHBHYTJ+3G6yzl7p/a5nV12/seqZI1BWIncNZK1jWw6GTU97fUOUtmb2we2pYTQ/mS87
         eRIGzLReScHJklIuHkXJeKqya3oZ5fvn2b7hIPASKamKGLjk8/zxtufVn50zffSG7gm6+U4hfOac
         QvRW4+m9bmCD0C3kC/mdf464elnxrcVc8V7bC+ulZljbNYEjlnyaqXpHXphNAia9TV3ehVciUX88
         +hceXyGGaIcmEfX/QiI2A8YzgB2LTOk3eUT+B5o7duNc14v1rcJ5NNri37Ov9VogiuoKZJ9dqRzE
         fPUUHV9G8HRRlp6UDAnpgwPQoDD/R3uJWY+1keSOtjusyk7xHhFFYFO/ZlsrGZa6gtK9rtr73Z7X
         8Ml0ikoD+oy7XOP4TuSn9/3t6tGG4jZeIBkqktbi7D9o4v8hH2oID+uNvRiwr9UNRDLRmZtwengf
         EdswQUo0x47ZX+wdK69OoMk/KReFb8Gw1+JkptQu5nagvWa4pLPzLo/GaBB0TOwMFSZn/deSuCMN
         FbvNdS9PTFiSGWqOBWPUKT+nqoDhFl+PjL1z7FRFREk3+pxZ5hKBpwn7hERWOx0BaRjN0uamYTXv
         cz2XiaCiUgKc53/Q652LG7tOFeV0MH+ZKQJuT9CtuwrdyXITavWIJog4vreckh1kvdAnOaPYLmnL
         Ne7En2TrRiI9wYk9AaeG/mFx81ROVXo3v5v+GJMemlCHx4WzH0CBbBviykDHvckCGb+oNwyEsn1r
         8FxM0qpaL3V0OLf7Am
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     thierry.reding@gmail.com
Cc:     mperttunen@nvidia.com, airlied@gmail.com, daniel@ffwll.ch,
        jonathanh@nvidia.com, p.zabel@pengutronix.de, lgirdwood@gmail.com,
        broonie@kernel.org, dri-devel@lists.freedesktop.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] drm/tegra: dpaux: Fix PM disable depth imbalance in tegra_dpaux_probe
Date:   Wed,  4 Oct 2023 22:10:55 +0800
X-OQ-MSGID: <20231004141055.242982-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pm_runtime_enable function increases the power disable depth,
which means that we must perform a matching decrement on the error
handling path to maintain balance within the given context.
Additionally, we need to address the same issue for pm_runtime_get_sync.
We fix this by invoking pm_runtime_disable and pm_runtime_put_sync
when error returns.

Fixes: 82b81b3ec1a7 ("drm/tegra: dpaux: Implement runtime PM")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/gpu/drm/tegra/dpaux.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/tegra/dpaux.c b/drivers/gpu/drm/tegra/dpaux.c
index ef02d530f78d..ae12d001a04b 100644
--- a/drivers/gpu/drm/tegra/dpaux.c
+++ b/drivers/gpu/drm/tegra/dpaux.c
@@ -522,7 +522,7 @@ static int tegra_dpaux_probe(struct platform_device *pdev)
 	if (err < 0) {
 		dev_err(dpaux->dev, "failed to request IRQ#%u: %d\n",
 			dpaux->irq, err);
-		return err;
+		goto err_pm_disable;
 	}
 
 	disable_irq(dpaux->irq);
@@ -542,7 +542,7 @@ static int tegra_dpaux_probe(struct platform_device *pdev)
 	 */
 	err = tegra_dpaux_pad_config(dpaux, DPAUX_PADCTL_FUNC_I2C);
 	if (err < 0)
-		return err;
+		goto err_pm_disable;
 
 #ifdef CONFIG_GENERIC_PINCONF
 	dpaux->desc.name = dev_name(&pdev->dev);
@@ -555,7 +555,8 @@ static int tegra_dpaux_probe(struct platform_device *pdev)
 	dpaux->pinctrl = devm_pinctrl_register(&pdev->dev, &dpaux->desc, dpaux);
 	if (IS_ERR(dpaux->pinctrl)) {
 		dev_err(&pdev->dev, "failed to register pincontrol\n");
-		return PTR_ERR(dpaux->pinctrl);
+		err = PTR_ERR(dpaux->pinctrl);
+		goto err_pm_disable;
 	}
 #endif
 	/* enable and clear all interrupts */
@@ -571,10 +572,15 @@ static int tegra_dpaux_probe(struct platform_device *pdev)
 	err = devm_of_dp_aux_populate_ep_devices(&dpaux->aux);
 	if (err < 0) {
 		dev_err(dpaux->dev, "failed to populate AUX bus: %d\n", err);
-		return err;
+		goto err_pm_disable;
 	}
 
 	return 0;
+
+err_pm_disable:
+	pm_runtime_put_sync(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+	return err;
 }
 
 static void tegra_dpaux_remove(struct platform_device *pdev)
-- 
2.30.2

