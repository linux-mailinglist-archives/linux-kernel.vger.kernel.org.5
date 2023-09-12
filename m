Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501ED79C263
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235109AbjILCJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244864AbjILCH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:07:29 -0400
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295CCEADD2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 18:39:44 -0700 (PDT)
Received: from localhost.localdomain (unknown [124.16.141.245])
        by APP-05 (Coremail) with SMTP id zQCowACHoQhdwf9khftEDA--.55821S2;
        Tue, 12 Sep 2023 09:39:41 +0800 (CST)
From:   sunying@nj.iscas.ac.cn
To:     lgirdwood@gmail.com, broonie@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     pengpeng@iscas.ac.cn, renyanjie01@gmail.com,
        Ying Sun <sunying@nj.iscas.ac.cn>
Subject: [PATCH] regulator: mtk-dvfsrc: remove non-existent configuration dependency "MTK_DVFSRC"
Date:   Tue, 12 Sep 2023 09:39:29 +0800
Message-Id: <20230912013929.658-1-sunying@nj.iscas.ac.cn>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: zQCowACHoQhdwf9khftEDA--.55821S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XFWfJw13tr1kZr4UJr1fJFb_yoWfJwb_Ca
        y5A3WxJr4UurZ8KF10gFsYvayYvayUZayxJF1UKrWaqa47Z3W3GasxJF17Cr47Gw47GF1a
        q3yxZr4UAr18XjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbxkFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
        Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr
        1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
        jxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
        1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4kE6xkIj40Ew7xC0wCY
        02Avz4vE14v_KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_
        Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v2
        6r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUb
        b4S5UUUUU==
X-Originating-IP: [124.16.141.245]
X-CM-SenderInfo: 5vxq5xdqj60y4olvutnvoduhdfq/
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ying Sun <sunying@nj.iscas.ac.cn>

The definition of the configuration option "MTK_DVFSRC" cannot be found,
 so that the configuration option "REGULATOR_MTK_DVFSRC"
 that depends on it cannot be enabled.

Suggested-by: Yanjie Ren <renyanjie01@gmail.com>
Signed-off-by: Ying Sun <sunying@nj.iscas.ac.cn>
---
 drivers/regulator/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index 965d4f0c18a6..80560e3a13f7 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -906,7 +906,6 @@ config REGULATOR_MT6397
 
 config REGULATOR_MTK_DVFSRC
 	tristate "MediaTek DVFSRC regulator driver"
-	depends on MTK_DVFSRC
 	help
 	  Say y here to control regulator by DVFSRC (dynamic voltage
 	  and frequency scaling resource collector).
-- 
2.17.1

