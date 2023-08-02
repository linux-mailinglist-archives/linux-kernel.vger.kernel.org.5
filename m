Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5102076D3B6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 18:32:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbjHBQce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 12:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjHBQcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 12:32:31 -0400
Received: from frasgout11.his.huawei.com (ecs-14-137-139-23.compute.hwclouds-dns.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CED52137
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 09:32:30 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4RGHK54vnXz9xGgc
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 00:20:57 +0800 (CST)
Received: from A2101119013HW2.china.huawei.com (unknown [10.81.207.228])
        by APP1 (Coremail) with SMTP id LxC2BwCnWbn9hMpkgNcsAA--.36049S2;
        Wed, 02 Aug 2023 17:32:06 +0100 (CET)
From:   Petr Tesarik <petrtesarik@huaweicloud.com>
To:     Juergen Gross <jgross@suse.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>,
        xen-devel@lists.xenproject.org (moderated list:XEN HYPERVISOR X86),
        linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND
        64-BIT))
Cc:     Roberto Sassu <roberto.sassu@huaweicloud.com>, petr@tesarici.cz
Subject: [PATCH v1] xen: remove a confusing comment on auto-translated guest I/O
Date:   Wed,  2 Aug 2023 18:31:51 +0200
Message-Id: <20230802163151.1486-1-petrtesarik@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwCnWbn9hMpkgNcsAA--.36049S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw1fCF1DKFy5Ary3AFyUGFg_yoWDKwcE9F
        4xZF48Ww45tr93X34UKr4avaySyan3trWF9Fn2y34YyFWxXFs7XFs2g3Z0kw4xXFWrCrZx
        XF9xXry7Jw40kjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUIcSsGvfJTRUUUbSAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
        6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
        A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
        Gr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJV
        WxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
        Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc7CjxVAKzI0EY4vE52x082I5MxAIw28Icx
        kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
        xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42
        IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY
        6xAIw20EY4v20xvaj40_Zr0_Wr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
        IEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUxUUUUUUUU=
X-CM-SenderInfo: hshw23xhvd2x3n6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L3,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Tesarik <petr.tesarik.ext@huawei.com>

After removing the conditional return from xen_create_contiguous_region(),
the accompanying comment was left in place, but it now precedes an
unrelated conditional and confuses readers.

Fixes: 989513a735f5 ("xen: cleanup pvh leftovers from pv-only sources")
Signed-off-by: Petr Tesarik <petr.tesarik.ext@huawei.com>
---
 arch/x86/xen/mmu_pv.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
index e0a975165de7..804a5441324c 100644
--- a/arch/x86/xen/mmu_pv.c
+++ b/arch/x86/xen/mmu_pv.c
@@ -2310,12 +2310,6 @@ int xen_create_contiguous_region(phys_addr_t pstart, unsigned int order,
 	int            success;
 	unsigned long vstart = (unsigned long)phys_to_virt(pstart);
 
-	/*
-	 * Currently an auto-translated guest will not perform I/O, nor will
-	 * it require PAE page directories below 4GB. Therefore any calls to
-	 * this function are redundant and can be ignored.
-	 */
-
 	if (unlikely(order > MAX_CONTIG_ORDER))
 		return -ENOMEM;
 
-- 
2.25.1

