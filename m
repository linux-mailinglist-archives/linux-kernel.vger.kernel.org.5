Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEE675A7E1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjGTHex (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:34:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjGTHev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:34:51 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7031BC0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:34:49 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R64Fy2CGpzBRDsM
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 15:34:46 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689838486; x=1692430487; bh=mo1EPzzbB1CtIWdWKzQA3xIryWc
        yJGZHiG1dyCtVH0E=; b=it5qt/70QvKfOLoQndmo/tLrM1SjGXLu4oDt8JEq/WQ
        pegzzctXB99PN7+MR7+ixcKG0iUzW9V1iQTW6bzt+I3N5qX7v+VF1mMsXm37XULu
        td/ZzVV4EMMpjSSZIIbiad3OKdZiqEQg3vDdB8asXFhw3VAtjsU96HpHjggySog/
        dzI0mHss+tITOK6+b9vwM/4En6089mf5u64rnvziPXLV+ru2LVvk80qGl0A8SqTN
        lnEgP57OeWkbglx4cTdg5BNtMq1TEvNpluwtROPpG1v/IsDLjsaQzhFcmKe5UXrZ
        u3aeXV0TqbPCjkbMbrUrIJx42wxmpqQPXZslBtvS7jQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WXejL9co5UlB for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 15:34:46 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R64Fx6P7qzBRDs1;
        Thu, 20 Jul 2023 15:34:45 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 15:34:45 +0800
From:   hanyu001@208suo.com
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        Liam.Howlett@Oracle.com, vbabka@suse.cz, akpm@linux-foundation.org,
        dave@stgolabs.net, willy@infradead.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm: book3s32: add require space around that '?' and ':'
In-Reply-To: <tencent_78C62F88E268136A2FCE91042CAB212A7709@qq.com>
References: <tencent_78C62F88E268136A2FCE91042CAB212A7709@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <44c1e39667c838d00c9dbb007184ccf1@208suo.com>
X-Sender: hanyu001@208suo.com
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

Fix below checkpatch errors:

./arch/powerpc/mm/book3s32/tlb.c:102: ERROR: spaces required around that 
'?' (ctx:VxW)
./arch/powerpc/mm/book3s32/tlb.c:102: ERROR: spaces required around that 
':' (ctx:VxW)

Signed-off-by: Yu Han <hanyu001@208suo.com>
---
  arch/powerpc/mm/book3s32/tlb.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/mm/book3s32/tlb.c 
b/arch/powerpc/mm/book3s32/tlb.c
index 9ad6b56bfec9..de4abfe3d06b 100644
--- a/arch/powerpc/mm/book3s32/tlb.c
+++ b/arch/powerpc/mm/book3s32/tlb.c
@@ -99,7 +99,7 @@ void hash__flush_tlb_page(struct vm_area_struct *vma, 
unsigned long vmaddr)
      struct mm_struct *mm;
      pmd_t *pmd;

-    mm = (vmaddr < TASK_SIZE)? vma->vm_mm: &init_mm;
+    mm = (vmaddr < TASK_SIZE) ? vma->vm_mm : &init_mm;
      pmd = pmd_off(mm, vmaddr);
      if (!pmd_none(*pmd))
          flush_hash_pages(mm->context.id, vmaddr, pmd_val(*pmd), 1);
