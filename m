Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB857806A26
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:53:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377006AbjLFIxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjLFIxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:53:15 -0500
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F997EC8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 00:53:15 -0800 (PST)
X-QQ-mid: bizesmtp72t1701852751tgg4m88o
Received: from DESKTOP-OVH8HPO.localdomain ( [202.96.137.210])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 06 Dec 2023 16:52:26 +0800 (CST)
X-QQ-SSF: 01400000000000F0Z000000A0000000
X-QQ-FEAT: rZJGTgY0+YMD+3U55AenSaw2tFLFkjb8Xwx5ksxfYBO+eX5zMssxokjr0DQjv
        /Y191beYdUj42IoCevqmcCzBjRgIb4JFua5iN9rTwi7CYg5dTURs9Bnmc2VgEhSR9yLYEHL
        ZHdJa0dwW3hlryIF6ulQG2OfWicjIs/V1uHcwAIDluaN9y4u47k28fqIWl9Z8xDwBYoacCC
        d0QbgeHweQfJtXtQZ2CUy7ibxQVD+ThoocHDWO2d5L0N425lijpnw+ET5h6SoE3Ve1UA6nW
        f83X7vXNcdUjzzu5nU6F281TnmfwhQouhNfYRjo3H6DOxiVSIrymI5eVTjPVKZ3zlbPIS4k
        32DGKiMcrcbWmmLen0PBKqRdMDedmxjHQPWqsM7p891S5KV7VFKKx0G/RCc3g==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 12475080599687696515
From:   Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
To:     akpm@linux-foundation.org
Cc:     brauner@kernel.org, surenb@google.com, mst@redhat.com,
        michael.christie@oracle.com, mathieu.desnoyers@efficios.com,
        mjguzik@gmail.com, npiggin@gmail.com, zhangpeng.00@bytedance.com,
        hca@linux.ibm.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org,
        Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
Subject: [PATCH] fork: fix a typo
Date:   Wed,  6 Dec 2023 16:52:23 +0800
Message-Id: <20231206085223.2333-1-caoyixuan2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybglogicsvrgz:qybglogicsvrgz5a-2
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I fixed a typo in the function copy_mm() where "a active" should be
"an active".

Signed-off-by: Yixuan Cao <caoyixuan2019@email.szu.edu.cn>
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index c78e65757eb5..18f0b84bd2ef 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1719,7 +1719,7 @@ static int copy_mm(unsigned long clone_flags, struct task_struct *tsk)
 	/*
 	 * Are we cloning a kernel thread?
 	 *
-	 * We need to steal a active VM for that..
+	 * We need to steal an active VM for that..
 	 */
 	oldmm = current->mm;
 	if (!oldmm)
-- 
2.34.1

