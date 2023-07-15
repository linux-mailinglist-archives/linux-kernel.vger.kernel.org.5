Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A72754935
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 16:13:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjGOONu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 10:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjGOONt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 10:13:49 -0400
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4259CC0
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jul 2023 07:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1689430423;
        bh=xGxK1cvW6cOfjTu72horDhpvMVkb2N176vRYgCiWWTw=;
        h=From:To:Cc:Subject:Date;
        b=ElNVIl7reL2c/2TriQPekLj2i1S+H/5LH+fM33hQeDf1SobddXq4FQFVF5Im/hSzr
         lmvDZbcSCU9XttH8gVBgBnaj2v166vliXVcZ8UxCNdbUMSq5gmu41msvm/3bg48Fwa
         dsh8xHNUf+1NSzgHvnuT+Fh0vjOkoHflpBuchuL8=
Received: from KernelDevBox.byted.org ([180.184.51.142])
        by newxmesmtplogicsvrszb1-0.qq.com (NewEsmtp) with SMTP
        id 368194FD; Sat, 15 Jul 2023 22:13:40 +0800
X-QQ-mid: xmsmtpt1689430420t5nfc4db9
Message-ID: <tencent_AA08AAA6C4F34D53ADCE962E188A879B8206@qq.com>
X-QQ-XMAILINFO: MRkw0hrPPfAMGBCrk+wMJiM6ioZMtsRfOcVM8cXdTQ9IkavRTQokoDr3blTQfV
         IhEZErFL/DWasE8t+6zohgoEZk95Yy6UtvX3qvY8BzarLybQ6QILWTNtxIPJEbXpDEJkGBkoFunv
         ividpbyYfuQ6gVJe4wM1239yFovMPL0221HD5jlLMs0zbLQyIe2HyacD67f+jFotvXkAiLrOKPL3
         4xf6F/X5GX3Z2pBcbAyyjyCgvbCOP3B62EaAkSCUJrEea8BSitgxr4jNBeYh905IpEgI7p6mV5tU
         uYpKW0iFKVwN7fCV29nNdNmy7kc6qLAJOPpgro4PabmqD1Agrkj5wbtoge4kfht6dLmnzuryQ0Zb
         vU9IIzHv7BXzQAY9CatezT5RmFJsBcVfLssUtd8QF2ZEeGQfe4rPTjNq9QFMt80r9watp68RV+Zc
         byxFMivaGaMglOJFkm5598Eg5gLlpx64UbqZsyptd58uWbLWAeRhOcT4HriR6zrRtFodu9z3Cu+R
         8tRs0ISCL332Ews4hAzkaRrjJb2tpNnVtR+nOIMk7IvKH4ZQQN9J0n4EK3Q6XfxuabSegLHCYwXW
         8vmpgnchvVQNXXCzusJ3LCApL1N4qUsNeipZf4YkLm76n1/rFyeyMkXLlXy2OeM+TOpFCkNHqTWw
         +FkiJXcb9S6M+QeyHj+pzujfwdMR5nlFqB1oUJoLLmgD2lFZ+FAfwfhACbH4vA5L+0Hey4jkoo4m
         /wehFtHjFC5RgZIFbEFVVXYqp3xF2RsQt/og6Qt/FsE6F+YeHdku9hrJZ2Tl7SIzo2YBcXSGVi8p
         g9O7RLDM//zsQhRtIlSVQ9F76GuIf/dUZ3wCtFFgrXdnKOK2PqybeLRvZWFNjlPV2jkjs4C5+oga
         hOWgZwKlVoZ/nCv4YDRXekg7SYKTOtH5qgH8rKZazpkhXpvzT4xgZs2idmkk3xoturWAw10dKSGm
         vPdu137X3a+CJJS2WrXYl6DHqawL0ZPYWsLkohhKONRRUq3pDpGgWs1ms/P4cdVYWheLvSV1ABZW
         ynI+vZn8/qjkyOnl4/
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     neil.armstrong@linaro.org
Cc:     khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] firmware: meson_sm: fix to avoid potential NULL pointer dereference
Date:   Sat, 15 Jul 2023 22:13:38 +0800
X-OQ-MSGID: <20230715141338.1895496-1-zhang_shurong@foxmail.com>
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

Fix this by checking the return value of of_match_device.

Fixes: 8cde3c2153e8 ("firmware: meson_sm: Rework driver as a proper platform driver")
Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/firmware/meson/meson_sm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firmware/meson/meson_sm.c b/drivers/firmware/meson/meson_sm.c
index 798bcdb05d84..9a2656d73600 100644
--- a/drivers/firmware/meson/meson_sm.c
+++ b/drivers/firmware/meson/meson_sm.c
@@ -292,6 +292,8 @@ static int __init meson_sm_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	chip = of_match_device(meson_sm_ids, dev)->data;
+	if (!chip)
+		return -EINVAL;
 
 	if (chip->cmd_shmem_in_base) {
 		fw->sm_shmem_in_base = meson_sm_map_shmem(chip->cmd_shmem_in_base,
-- 
2.30.2

