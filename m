Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C5C751A0E
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbjGMHiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjGMHin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:38:43 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703952102
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:38:42 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1mgd0GWnzBS5q3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 15:38:37 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689233916; x=1691825917; bh=b/DYbpuR31khnz+Yc+dmvF6T2Mm
        WkWaohboD++UybaI=; b=tpLpRYwPe7M7bU+eFAVTHjmNZLx5eUko4+VJO0ifsvL
        EzKABwbL4Zax3JfnfTnxrQnxCt1aM/OqeyFfih9f/vs4pLYTjv50ao3eRuyr+wej
        EWIT46i7D+qKGP5GLQ8h/ca+q4R+65mgRM7MPKZBuSxASjz912xXXYGm05nlwhJU
        yr4s03sX4zAC+vFO4GeJLl52uTrpYOdE6nNGj9NsuszyvJZAmGJU692VPPOTywDh
        HEp7qHjiiND4dxnuFxyIcgz3Rta3n5XF/FN2uEu9+e2rZirVYLz03L4u+rCRDU64
        JX4Zjo1MInem/nKuJfaOja0QFmNmoJjcR3lfkfHQ5qA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id ID_dqNmHINdg for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jul 2023 15:38:36 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1mgc56qMzBS5pk;
        Thu, 13 Jul 2023 15:38:36 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 13 Jul 2023 15:38:36 +0800
From:   hexingwei001@208suo.com
To:     sammy@sammy.net, geert@linux-m68k.org
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mk68: sun3: mmu_emu: ERROR: "foo * bar" should be "foo *bar"
In-Reply-To: <20230713073600.61987-1-panzhiai@cdjrlc.com>
References: <20230713073600.61987-1-panzhiai@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <7bc2884553156ddf975c3b00c7f5b850@208suo.com>
X-Sender: hexingwei001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix one occurrences of the checkpatch.pl error:
ERROR: "foo * bar" should be "foo *bar"

Signed-off-by: Xingwei He <hexingwei001@208suo.com>
---
  arch/m68k/sun3/mmu_emu.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/m68k/sun3/mmu_emu.c b/arch/m68k/sun3/mmu_emu.c
index 7321b3b76283..39b5eb120376 100644
--- a/arch/m68k/sun3/mmu_emu.c
+++ b/arch/m68k/sun3/mmu_emu.c
@@ -355,7 +355,7 @@ int mmu_emu_handle_fault (unsigned long vaddr, int 
read_flag, int kernel_fault)
      unsigned long segment, offset;
      unsigned char context;
      pte_t *pte;
-    pgd_t * crp;
+    pgd_t *crp;

      if(current->mm == NULL) {
          crp = swapper_pg_dir;
