Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 005B77F584A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:34:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344796AbjKWGeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344769AbjKWGep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:34:45 -0500
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39C28D44;
        Wed, 22 Nov 2023 22:34:49 -0800 (PST)
Received: from hust.edu.cn (unknown [172.16.0.52])
        by app1 (Coremail) with SMTP id HgEQrABnDG1g8l5lTI4qAA--.60110S2;
        Thu, 23 Nov 2023 14:34:08 +0800 (CST)
Received: from pride-PowerEdge-R740.. (unknown [222.20.126.131])
        by gateway (Coremail) with SMTP id _____wAXoEpW8l5lbogNAA--.10822S2;
        Thu, 23 Nov 2023 14:34:06 +0800 (CST)
From:   Ren Xiao <u202112004@hust.edu.cn>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Ren Xiao <u202112004@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-usb@vger.kernel.org,
        usb-storage@lists.one-eyed-alien.net, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: storage: transport: Fix indentation typo in 'transport.c'
Date:   Thu, 23 Nov 2023 01:33:38 -0500
Message-Id: <20231123063339.2625684-1-u202112004@hust.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: HgEQrABnDG1g8l5lTI4qAA--.60110S2
Authentication-Results: app1; spf=neutral smtp.mail=u202112004@hust.ed
        u.cn;
X-Coremail-Antispam: 1UD129KBjvdXoWrtw47tr4kKrWxWFW5Gw4Uurg_yoW3urbE93
        WfW34xZr15CFZav3W7KFyfurWIkw1FqF1q9Fs2q343Ga47Z3yrJrWqqw4Fva45Gwn8ZFWk
        Aw1DXrWrZr4rKjkaLaAFLSUrUUUU0b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbmxYjsxI4VWxJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
        s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
        8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
        x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_JF
        0_Jw1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF
        0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0EF7xvrVAajcxG14v26r
        4UJVWxJr1lYx0E74AGY7Cv6cx26r4fZr1UJr1lYx0Ec7CjxVAajcxG14v26F4j6r4UJwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42
        xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uFyUJr1UMxC20s026xCaFVCjc4AY
        6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
        xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
        jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
        0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
        67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUVWSoDUUUU
X-CM-SenderInfo: rxsqjiarsqiko6kx23oohg3hdfq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed excess spaces before the label at line 1063.

Signed-off-by: Ren Xiao <u202112004@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 drivers/usb/storage/transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/storage/transport.c b/drivers/usb/storage/transport.c
index 7449e379077a..8f236854c83b 100644
--- a/drivers/usb/storage/transport.c
+++ b/drivers/usb/storage/transport.c
@@ -1060,7 +1060,7 @@ int usb_stor_CB_transport(struct scsi_cmnd *srb, struct us_data *us)
 	 * the CBI spec requires that the bulk pipe must be cleared
 	 * following any data-in/out command failure (section 2.4.3.1.3)
 	 */
-  Failed:
+Failed:
 	if (pipe)
 		usb_stor_clear_halt(us, pipe);
 	return USB_STOR_TRANSPORT_FAILED;
-- 
2.34.1

