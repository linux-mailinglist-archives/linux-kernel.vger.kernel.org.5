Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E318757833
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 11:38:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjGRJhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 05:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjGRJhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 05:37:46 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC9ECF
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 02:37:41 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4v4c1QRQzBR1PD
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 17:37:36 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689673055; x=1692265056; bh=6zOPQz80Mv/HWERPJeIchOiif9I
        O5sqEE8rXdj84adc=; b=p/Tb6cCj2ZdphLNkvYWO15gt6el6IQdTLxKV+lvlNNM
        iDR0zw2mpwuvnRaIPNcGqBU/CYPgyb6hfLRJm9QjkApvivu22q/d1dnhHASY2GHC
        jVWpPaq0SC0dzm+Q1l/ZlOBs3naNpOATFHA9VjQArMgbXnEq2ixiHg3EUW1agmY7
        2pokM9+105WlvQx9tRV9s234AgvL01lc2DjcjyKrd3UhxnTj6KzvEepSUlD8avzN
        f2eaCkMTO7vEZtV1UFdM0o7+uw1LnZgaUBy700YsSkQzt/FvW/+pVy3N8vGbWAvc
        waMBVVhlCJx8yuFJUfC1Giuse5UKhMsTXkBUiQrF62Q==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HMHUuEKzyjfm for <linux-kernel@vger.kernel.org>;
        Tue, 18 Jul 2023 17:37:35 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4v4b3dVlzBJBfd;
        Tue, 18 Jul 2023 17:37:35 +0800 (CST)
MIME-Version: 1.0
Date:   Tue, 18 Jul 2023 17:37:35 +0800
From:   hanyu001@208suo.com
To:     benh@kernel.crashing.org, mpe@ellerman.id.au, npiggin@gmail.com,
        christophe.leroy@csgroup.eu, robh@kernel.org, axboe@kernel.dk,
        chenlifu@huawei.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] platforms: powermac: insert space before the open parenthesis
 '('
In-Reply-To: <tencent_3EB579E7E40217D5639568E3324407B49E08@qq.com>
References: <tencent_3EB579E7E40217D5639568E3324407B49E08@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <0941033d34b2403020f9e4cc17765381@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes checkpatch error:

/powerpc/platforms/powermac/setup.c:222:ERROR: space required before the 
open parenthesis '('

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  arch/powerpc/platforms/powermac/setup.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/powermac/setup.c 
b/arch/powerpc/platforms/powermac/setup.c
index 0c41f4b005bc..a89f3022f3a8 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -219,7 +219,7 @@ static void __init ohare_init(void)
                  sysctrl_regs[4] |= 0x04000020;
              else
                  sysctrl_regs[4] |= 0x04000000;
-            if(has_l2cache)
+            if (has_l2cache)
                  printk(KERN_INFO "Level 2 cache enabled\n");
          }
      }
