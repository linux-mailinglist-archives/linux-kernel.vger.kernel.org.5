Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB1D079E27D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 10:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238897AbjIMIrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 04:47:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbjIMIrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 04:47:07 -0400
Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B333B196
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 01:47:02 -0700 (PDT)
Received: from localhost.localdomain (unknown [124.16.141.245])
        by APP-01 (Coremail) with SMTP id qwCowADnSYiKdgFls8YdAQ--.25252S2;
        Wed, 13 Sep 2023 16:44:58 +0800 (CST)
From:   sunying@nj.iscas.ac.cn
To:     lee@kernel.org
Cc:     linux-kernel@vger.kernel.org, renyanjie01@gmail.com,
        pengpeng@iscas.ac.cn, Ying Sun <sunying@nj.iscas.ac.cn>
Subject: [PATCH] mfd: ab8500: remove non-existent configuration "#ifdef CONFIG_AB8500_DEBUG"
Date:   Wed, 13 Sep 2023 16:45:59 +0800
Message-Id: <20230913084559.18141-1-sunying@nj.iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: qwCowADnSYiKdgFls8YdAQ--.25252S2
X-Coremail-Antispam: 1UD129KBjvJXoW7XFWfGF47tF43Cr13WryfJFb_yoW8JF15pF
        93Gr1kJFWDJryDC3yxCrWxAa15JrZ5Kr47ArWDKw1xG3Zxtw4IyrZ8CFyvv3WDCry8ArW8
        Aa4fGr97uw4UJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvI14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r1j
        6r4UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
        W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr
        0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC
        0wCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2
        IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
        6r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2
        IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf
        9x0JU65lbUUUUU=
X-Originating-IP: [124.16.141.245]
X-CM-SenderInfo: 5vxq5xdqj60y4olvutnvoduhdfq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ying Sun <sunying@nj.iscas.ac.cn>

The CONFIG_AB8500_DEBUG has been deleted in
 [PATCH]mfd: ab8500: Drop debugfs module.

The condition "#ifdef CONFIG_AB8500_DEBUG" in
 include/linux/mfd/abx500/ab8500.h:502
 cannot be valid. It is recommended to delete redundant code.

Suggested-by: Yanjie Ren <renyanjie01@gmail.com>
Signed-off-by: Ying Sun <sunying@nj.iscas.ac.cn>
---
 include/linux/mfd/abx500/ab8500.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/linux/mfd/abx500/ab8500.h b/include/linux/mfd/abx500/ab8500.h
index 09fb3c56e7d7..76d326ea8eba 100644
--- a/include/linux/mfd/abx500/ab8500.h
+++ b/include/linux/mfd/abx500/ab8500.h
@@ -499,13 +499,7 @@ static inline int is_ab9540_2p0_or_earlier(struct ab8500 *ab)
 
 void ab8500_override_turn_on_stat(u8 mask, u8 set);
 
-#ifdef CONFIG_AB8500_DEBUG
-extern int prcmu_abb_read(u8 slave, u8 reg, u8 *value, u8 size);
-void ab8500_dump_all_banks(struct device *dev);
-void ab8500_debug_register_interrupt(int line);
-#else
 static inline void ab8500_dump_all_banks(struct device *dev) {}
 static inline void ab8500_debug_register_interrupt(int line) {}
-#endif
 
 #endif /* MFD_AB8500_H */
-- 
2.17.1

