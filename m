Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83295799ABE
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 22:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244941AbjIIURu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 16:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244826AbjIIURr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 16:17:47 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FA51BC
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 13:17:41 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 68E34320090E;
        Sat,  9 Sep 2023 16:17:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Sat, 09 Sep 2023 16:17:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1694290659; x=
        1694377059; bh=HyKF8F/MhKP+/+HfUHmiXOs6fZCNU+XAaKpYQdP8b5o=; b=J
        kDfNIKb5OoXzQdKkTgNCXeFNXCpiqW915uClF5iObI79vo7f9KW1Oh4HGJX2fdDc
        FPCHVatGnaFaAlAgyLyGtZzbsLIaQWHH7iPoANcK791yNmKKu5RVi6V/QynxemzS
        9monY3DvscjJUv3HIne/CVYPeBIsoH6jlmGSlsqD26JgXo+SAFgzQmy36f3E2OU2
        LQ9cK5jE9nFkIoViqQQHHBUq4luDwnBWdHCU9UzEAdtgKI1W82x3CkbZo1jLqHIY
        PKbuXclW1at0SLW9cBQEpGMPFwBs7o1D0p7KCJ5P8elIVm3US6fNhwdD3dssW/7e
        LqEL3+hsdeSyUd3ulfZKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1694290659; x=
        1694377059; bh=HyKF8F/MhKP+/+HfUHmiXOs6fZCNU+XAaKpYQdP8b5o=; b=N
        GLiUn6J/oadG0HJX2fg9RyrdTv40GynBxcSwJzMBTpgX9CssXqBIHR3YkQQTcvPM
        f/zVsR8nU1eDqhte1SDK47QoMsAmiFKU3cbnTCOxlMf85tywSHvFcicsnb90A/lX
        AmMRLVKdOTJy2Q1bbjaDYxbrZs+RWZVuhripR6HiIDThEFArWjRWs49+0fMS+/5J
        BIBL1TxmT25fKm4qStV573bJdKmt3adGucn1QNZm2giqSiQ/m58+wtk5AdPw4x+H
        B8ky8qdfvjGGulnOCMfE6kJLFdsjLxoBSd77bsbHctJlyNembZZg+ep7W6Kf2lpj
        X93SgqnkADSG/m/0yvoHQ==
X-ME-Sender: <xms:49L8ZCzVQL84ALiuQEP0Ead93a8Krd2Nc6JQ8M2XfEv9etvh1_UQMw>
    <xme:49L8ZORnpqKsLuHFUA-lAmo1uKCOcqjSzssS-7wHgDLnIFKXvjpIUxMcCq_qVwido
    sUD6FKvwI1FiIvo9A>
X-ME-Received: <xmr:49L8ZEVswTfojHHcMN97n83bqnPjpxpbU_nGHfkL9xthl67SCy9lEs377Fl2CyBTp2bZzT9pIEOXJ83bPTqlR4jb0Asky6pvYaaAa2mgamF4kjseO7Q0U0Ep3DW9Fl6ei9ozdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehledgudegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:49L8ZIiDIG98txURAyYMLGs9QZIb2FEeIZlasS9UfIucV--eczHMPQ>
    <xmx:49L8ZED1p_QLgaFCY3d3W5ywNFfq5zhk4YBkOZ4KRHjKfRvcvLBqpA>
    <xmx:49L8ZJKIwSmEZj9d-xz-QWPwVITZI7SwOxt_VikvCdgyFwWoPu8z_w>
    <xmx:49L8ZH84GHPzaKdux-COeCYp2MU-glpjJ-N-1szOATamQ-bhFIduiw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Sep 2023 16:17:39 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 5/7] riscv: mm: Preserve global TLB entries when switching contexts
Date:   Sat,  9 Sep 2023 15:16:33 -0500
Message-ID: <20230909201727.10909-6-samuel@sholland.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230909201727.10909-1-samuel@sholland.org>
References: <20230909201727.10909-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the CPU does not support multiple ASIDs, all MM contexts use ASID 0.
In this case, it is still beneficial to flush the TLB by ASID, as the
single-ASID variant of the sfence.vma instruction preserves TLB entries
for global (kernel) pages.

This optimization is recommended by the RISC-V privileged specification:

  If the implementation does not provide ASIDs, or software chooses
  to always use ASID 0, then after every satp write, software should
  execute SFENCE.VMA with rs1=x0. In the common case that no global
  translations have been modified, rs2 should be set to a register
  other than x0 but which contains the value zero, so that global
  translations are not flushed.

It is not possible to apply this optimization when using the ASID
allocator, because that code must flush the TLB for all ASIDs at once
when incrementing the version number.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 arch/riscv/mm/context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 43a8bc2d5af4..3ca9b653df7d 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -200,7 +200,7 @@ static void set_mm_noasid(struct mm_struct *mm)
 {
 	/* Switch the page table and blindly nuke entire local TLB */
 	csr_write(CSR_SATP, virt_to_pfn(mm->pgd) | satp_mode);
-	local_flush_tlb_all();
+	local_flush_tlb_all_asid(0);
 }
 
 static inline void set_mm(struct mm_struct *prev,
-- 
2.41.0

