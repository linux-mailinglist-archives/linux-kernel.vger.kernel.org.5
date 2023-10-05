Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 947C77BA5FC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:22:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243098AbjJEQW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241892AbjJEQQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:16:45 -0400
Received: from out203-205-221-192.mail.qq.com (out203-205-221-192.mail.qq.com [203.205.221.192])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A14C769F
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 09:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1696521743;
        bh=SXOUgbldgZBCY3GyES22l+Ixl/lk+hf9+Aq9JS/F44U=;
        h=From:To:Cc:Subject:Date;
        b=afM+R1ccM7DcSKRckSaynSphXAhTeA88c++rpLb25aj29phHO/ITshw7d9srReRuF
         5Bs+LqSeQZMGizVMdgbYeXyWZ//2zYMwoaierUHEPChJXG4CiTeB7cwhBzP7ang5FC
         sm6f7OL36+P2V0ZC2zVeej8PUfTPz/mqiyZt+8M8=
Received: from KernelDevBox.byted.org ([180.184.103.200])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id C7005A1E; Thu, 05 Oct 2023 21:49:48 +0800
X-QQ-mid: xmsmtpt1696513788t2552ounz
Message-ID: <tencent_6BA8EA125537CBB5D65B05605E1E960AA708@qq.com>
X-QQ-XMAILINFO: MILSKRzDrLPb9EuLXmTn57oGreBCkYaFwc9IUcG6/5HF5vHFojYNqHhnEx5ycG
         J2FoBqQxKuVm8bD5TlMpxToHTmBj3N0FQjHU/8vHoMtdHdOSLuixdQxVWyJ+QASvQbAEIbkvO4/j
         r8H3zEEUWGT6D2p5kIYAN+HnOUEi1LVD/hskoQvnIELONuoJpgGFylV/wLa6XQMUe6u3F4lSZ+LJ
         uk/Jv0sSJcmkNQ+u4ZsTsIVepEX1QcdbUJWKulmeY9O3p5u9rbe1lk+MICpeZJqVctfi5IwnXjTh
         FBJe3AqbZD7cyQ5M2BE+4mq8nDiRwGgxjPbCAQkzVQ6PkeyrvzTr2UkB8i0pE4A40r07HvrRVm6r
         4rIvBSBj7OsXv+n7vei0du/773JvOUm4G+SRKlU6CMP7XZykKFlKkSnAcqF0sva20v+0+LhEEj8N
         s6kNU+GmOSEYFh8E+O/d9Y3dOF7J4WbU19Zn0kFPPGUpi9vWwmMNrYnO04iW/aDXI4FEwEzVHAt4
         QekwZSY4LAfLvKyULVuzneot2gOTQE8zqwNMxYyoHN3yC/nl9h6k0XvqAkEPVCYmbvZnRPO9vPhV
         7+73//LgD6yaYmcm6MtgAB7nq+E5dUaARkw4ej5nXbT5do34NKD8PLCLT4qIu50k4lPx3Sp+4jGK
         lkawqTtY9IAlLqSQX7txS6BqP02Cti421bKZ28iJN/4er0xIqJ0QlPhua+ZnJFcx0KYJh+TiblbM
         cZrOIdNEfj0mpvLx3yfxoMUu2xE4v0caVCFitQb4NJHmgrFqB7L/NKroOdjzAQKvawFmvn3ImT4P
         q+gd2Gm9MvdrvXW9vEKdJPd97/SC+sDM9Qk/kKORdaKJZmpekb5WRT+r1RoTEbK+intAVmIN22J9
         NPyUDx1Sx0HtnWTfKxgReIK610bhXSe6uAZdcG+j4jAUXD0hxifiPyP/yN3HHl4ASwKvF4dseb58
         Sn+yaI7fCm9bhDyfGCaD7GMi4qkt/MvwStO0GFPlboTnIWb8l8yznghXiqFvMQHXppFVc2kac=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     Thinh.Nguyen@synopsys.com
Cc:     gregkh@linuxfoundation.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] usb: dwc3: fix possible object reference leak
Date:   Thu,  5 Oct 2023 21:49:46 +0800
X-OQ-MSGID: <20231005134946.2197459-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_find_device_by_node takes a reference to the struct device
when find the match device,we should release it when fail.

Fix it by calling by calling platform_device_put when error returns.

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/usb/dwc3/dwc3-imx8mp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/dwc3-imx8mp.c b/drivers/usb/dwc3/dwc3-imx8mp.c
index a1e15f2fffdb..af5302c3f7a9 100644
--- a/drivers/usb/dwc3/dwc3-imx8mp.c
+++ b/drivers/usb/dwc3/dwc3-imx8mp.c
@@ -244,7 +244,7 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
 					IRQF_ONESHOT, dev_name(dev), dwc3_imx);
 	if (err) {
 		dev_err(dev, "failed to request IRQ #%d --> %d\n", irq, err);
-		goto depopulate;
+		goto err_device_put;
 	}
 
 	device_set_wakeup_capable(dev, true);
@@ -252,6 +252,8 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_device_put:
+	platform_device_put(dwc3_imx->dwc3);
 depopulate:
 	of_platform_depopulate(dev);
 err_node_put:
-- 
2.30.2

