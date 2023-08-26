Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A94178952D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 11:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjHZJdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 05:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjHZJci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 05:32:38 -0400
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEF81BD9;
        Sat, 26 Aug 2023 02:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1693042349;
        bh=ENxAcgMLJj+l/WH28kfC2QbyQgKt+/UZ1l+NFjDswjI=;
        h=From:To:Cc:Subject:Date;
        b=myT+cyeEYni0Nsw3J916Rxr0pk4vXLmLx5wUXUUnca9Mg2CTxWYuMq7vWb73Jc7f0
         0rtTf/M9KZ+jvgnHL1nGBN/KlT76FJhHYtNlBVtLA8X4G8idBcuPMt/EJnQE7Jn24V
         7LllCYB8ZcpJK+1AmEBu5UldFrEUNKepmFHh0u9E=
Received: from KernelDevBox.byted.org ([180.184.51.70])
        by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
        id 81B0E42E; Sat, 26 Aug 2023 17:32:27 +0800
X-QQ-mid: xmsmtpt1693042347t4nhuq2rn
Message-ID: <tencent_234B0AACD06350E10D7548C2E086A9166305@qq.com>
X-QQ-XMAILINFO: MyIXMys/8kCtM/ppar++8yF/RwEDgZmEuhGYj5JWg0C2pqy18TPCgd1b0cBIul
         oFA4Ud/FbTb0cozyRdM9Cxf6AVkPKxbwNc5C24ve1mt45J60JmEycewj/5IqqGpnlngPcHPy0B60
         tzccwB95YsO83zP+hd+5k0HrX2j2ZiM2HdedI5n+8NSIjecDqAiuRnJSefY3FZ1Fp/D8F2Vl4/Gu
         KNB4pO/ciYLEj1W3e92TxbdpImEQBvKXT1AzJOpH533dvVphz76AG17jaZvvB3IbrVKxdBshHs2d
         G4Xe+eRyz0XgI/ongwFJKetJCrUd6EcgjHif1c65v1UyBXFo93gsMqNDDhSHVNavInELDNIJ617j
         Ix5JJrLfIpKygrDcudUSsZqgZ149tAu8lhGtdxaCI86KsEB59t+ZGmajbWPCV3Q79yCecBP1jQkF
         G8y28HaTglJj6snLRyzhVZ5lql6kBRqAFvjOeBMhCuB5YmZV8hF6DMZHHyksx5rGsG+DbQYavgoA
         mkdswERKHXUa/O76ilyYQZreQ0V4i+IYGHjGtHX+/hE3cqod+LpmSc+vdhANFib8UpkdjOXfhnFU
         9TzCZ0qfigSspOCGd20TnuDeh1V3FJZ9Yw+EdAAqFxtaNYBNPM8AWSy8cEBkvC0UiSh55zAUMku/
         ulOz9DuQZlRdeaUDudDy2n4XT4woonHMS7j1+IYb/km651QzF+X4uJI4myWr2VAlESCX4ig80YT+
         klcbCzp/13Fzaev/+O9ixWR3nP1G5CP5QqgFp/H232rgqaS9C3Mlzh3yCkwNFjs07I9aK+zoiUI/
         CCb3oRWLvvLd1h5dXFAUnAAUg7bgR//Pi2SDg1MMTC44M6Obu9KRkxaaHlj3jJtrnauDbWPoM5Z7
         7SfyXlwBW+44th7LcupmEaLLST1jpBSI6qEjI4DLLoUwRNyXFgmL9xCrmHKPJ72BOevWKFvABPtq
         TIok0O2MMAihagbDYLtcXGkbSGmt9zB4vQUDJIJKy0c9XQYdfS3BDcxL5W9wtAKahbpmk04xk=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     gregkh@linuxfoundation.org
Cc:     jslaby@suse.com, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] tty: serial: linflexuart: Fix to check return value of platform_get_irq() in linflex_probe()
Date:   Sat, 26 Aug 2023 17:32:24 +0800
X-OQ-MSGID: <20230826093224.2150838-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The platform_get_irq might be failed and return a negative result. So
there should have an error handling code.

Fixed this by adding an error handling code.

Fixes: 09864c1cdf5c ("tty: serial: Add linflexuart driver for S32V234.")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/tty/serial/fsl_linflexuart.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/fsl_linflexuart.c b/drivers/tty/serial/fsl_linflexuart.c
index 3e28be402aef..7a7461543bb4 100644
--- a/drivers/tty/serial/fsl_linflexuart.c
+++ b/drivers/tty/serial/fsl_linflexuart.c
@@ -850,10 +850,14 @@ static int linflex_probe(struct platform_device *pdev)
 	if (IS_ERR(sport->membase))
 		return PTR_ERR(sport->membase);
 
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0)
+		return ret;
+
 	sport->dev = &pdev->dev;
 	sport->type = PORT_LINFLEXUART;
 	sport->iotype = UPIO_MEM;
-	sport->irq = platform_get_irq(pdev, 0);
+	sport->irq = ret;
 	sport->ops = &linflex_pops;
 	sport->flags = UPF_BOOT_AUTOCONF;
 	sport->has_sysrq = IS_ENABLED(CONFIG_SERIAL_FSL_LINFLEXUART_CONSOLE);
-- 
2.30.2

