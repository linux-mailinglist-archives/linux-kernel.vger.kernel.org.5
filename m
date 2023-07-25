Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C08127609F0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 08:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjGYGCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 02:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjGYGB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 02:01:57 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1587AE69;
        Mon, 24 Jul 2023 23:01:55 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 390395C0125;
        Tue, 25 Jul 2023 02:01:55 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 25 Jul 2023 02:01:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1690264915; x=1690351315; bh=u25UZIhU9Z
        hcvPRhhElxeTtk0KNrK1z5pbqbM0fo0/A=; b=XONI4PHD5lQk4/QiWn5NBq6Ffs
        yIvnQH1hyYH3KMgZYFa04sKWnTROiYaKVAposDcbX16KgjRpp59u+W0TvtfkoKOz
        RXUr1oUzEKBr1ISERtJrLYYbm2zbc+CQivmUAqdp59cr64eRVGNZ5CTnbs6qw3ne
        m+jO+zHmxE6U22tDMIQSkcfToIIn40wwuxjNOVFU07mnrT6paKFvznOsgkySWPJk
        GT+Uqo9aATLj0bJ9DmjmIxZxQIFKwmWVFAYUrIG9BSOPrnI8KKN3YvSpfWn+CxjQ
        MCEXyjrwjrTjEsTngrVXXSA/ZVhEGs1nSyMjYnW4Se4UhjpwC7Q2Vo7F1CFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1690264915; x=1690351315; bh=u25UZIhU9Zhcv
        PRhhElxeTtk0KNrK1z5pbqbM0fo0/A=; b=AeM0MhpYHj6ZmTVX0NcuhXbJiu3Xh
        i1tg9l/0IQPuzakC/M5rQjl+Vdngwp+lb7R8Eo4LdZsBmIpPUlGT7vhk7KEven6N
        q5Qn83R0cre7qZfpwF2hkeswTWCTyAkWlDIGo5WjP1in9p4/x0QkubjskbhI1I4E
        +TsL4pCkahOVxtX2t6nDazFuuyqhqkPP43zirdI+QBJse7oZaSc+ka2Of3xBbu7Y
        zVzljKpYDxJE5z9Uu1nt9B8aEYECEdead+WRUdZWt7UpadSBhrrvFkSURmEJ2NKW
        elaGhWEZixSTYislD3XK6P0QR+Roje48ENY0XXbx8Sgr4Bk2crChJk8Sw==
X-ME-Sender: <xms:UmW_ZCuh8OQu_JZPTOMlQmAAOC7jByDsd-dIZxZUxpBz0R1GM6iaTA>
    <xme:UmW_ZHdd29BTTENwbO8Ia9uTwX1zQlHAipXXDDhDyTCxv3GqNIE3QGjNx4rNz8nXN
    Z5vH-M6IMiA4xMECrI>
X-ME-Received: <xmr:UmW_ZNwNdFZ1PkuzdTBd8K5DDjt3lZrKMx5uEE5Scm7FZAC57LZz_9f_90y9NH9mrkEMGX5OQFj4lQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrheelgddutddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepvdeuteekleeuudfgueethe
    dtuddthfdtleffgefhieehfeeigedvtdeuveetiedunecuffhomhgrihhnpehkvghrnhgv
    lhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:UmW_ZNP6kOcUZltycQ2mTcfNpmZPHE5OgEvj6C3dB5PCnafIpPEXeg>
    <xmx:UmW_ZC8i3EpX2xVEeciq94zGGA9XnOd7EkOc3-yRq6qV4nvnUssSeg>
    <xmx:UmW_ZFVkq2xCbZWn6VP-OcFTB3AAOutvMThGrDhyy7v0jeijM9iiLQ>
    <xmx:U2W_ZGbWm9ee_x0Ts6ajd2F3o_xpMfmapFJWUI-lHuyGiAc12lr0iw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Jul 2023 02:01:51 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, chenhuacai@kernel.org,
        philmd@linaro.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v2] MIPS: Loongson64: Fix more __iomem attributes
Date:   Tue, 25 Jul 2023 14:01:44 +0800
Message-Id: <20230725060144.1501195-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some __iomem type casting being missed in previous patch.
Fix them here.

Fixes: 5bd3990723bd ("MIPS: Loongson64: Prefix ipi register address pointers with __iomem")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202307020639.QCZOKp8B-lkp@intel.com/
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v2: Drop invalid attribute for play_dead pointers
---
 arch/mips/loongson64/smp.c | 160 ++++++++++++++++++-------------------
 1 file changed, 80 insertions(+), 80 deletions(-)

diff --git a/arch/mips/loongson64/smp.c b/arch/mips/loongson64/smp.c
index cdecd7af11a6..e015a26a40f7 100644
--- a/arch/mips/loongson64/smp.c
+++ b/arch/mips/loongson64/smp.c
@@ -187,181 +187,181 @@ static void csr_ipi_probe(void)
 
 static void ipi_set0_regs_init(void)
 {
-	ipi_set0_regs[0] = (void *)
+	ipi_set0_regs[0] = (void __iomem *)
 		(SMP_CORE_GROUP0_BASE + SMP_CORE0_OFFSET + SET0);
-	ipi_set0_regs[1] = (void *)
+	ipi_set0_regs[1] = (void __iomem *)
 		(SMP_CORE_GROUP0_BASE + SMP_CORE1_OFFSET + SET0);
-	ipi_set0_regs[2] = (void *)
+	ipi_set0_regs[2] = (void __iomem *)
 		(SMP_CORE_GROUP0_BASE + SMP_CORE2_OFFSET + SET0);
-	ipi_set0_regs[3] = (void *)
+	ipi_set0_regs[3] = (void __iomem *)
 		(SMP_CORE_GROUP0_BASE + SMP_CORE3_OFFSET + SET0);
-	ipi_set0_regs[4] = (void *)
+	ipi_set0_regs[4] = (void __iomem *)
 		(SMP_CORE_GROUP1_BASE + SMP_CORE0_OFFSET + SET0);
-	ipi_set0_regs[5] = (void *)
+	ipi_set0_regs[5] = (void __iomem *)
 		(SMP_CORE_GROUP1_BASE + SMP_CORE1_OFFSET + SET0);
-	ipi_set0_regs[6] = (void *)
+	ipi_set0_regs[6] = (void __iomem *)
 		(SMP_CORE_GROUP1_BASE + SMP_CORE2_OFFSET + SET0);
-	ipi_set0_regs[7] = (void *)
+	ipi_set0_regs[7] = (void __iomem *)
 		(SMP_CORE_GROUP1_BASE + SMP_CORE3_OFFSET + SET0);
-	ipi_set0_regs[8] = (void *)
+	ipi_set0_regs[8] = (void __iomem *)
 		(SMP_CORE_GROUP2_BASE + SMP_CORE0_OFFSET + SET0);
-	ipi_set0_regs[9] = (void *)
+	ipi_set0_regs[9] = (void __iomem *)
 		(SMP_CORE_GROUP2_BASE + SMP_CORE1_OFFSET + SET0);
-	ipi_set0_regs[10] = (void *)
+	ipi_set0_regs[10] = (void __iomem *)
 		(SMP_CORE_GROUP2_BASE + SMP_CORE2_OFFSET + SET0);
-	ipi_set0_regs[11] = (void *)
+	ipi_set0_regs[11] = (void __iomem *)
 		(SMP_CORE_GROUP2_BASE + SMP_CORE3_OFFSET + SET0);
-	ipi_set0_regs[12] = (void *)
+	ipi_set0_regs[12] = (void __iomem *)
 		(SMP_CORE_GROUP3_BASE + SMP_CORE0_OFFSET + SET0);
-	ipi_set0_regs[13] = (void *)
+	ipi_set0_regs[13] = (void __iomem *)
 		(SMP_CORE_GROUP3_BASE + SMP_CORE1_OFFSET + SET0);
-	ipi_set0_regs[14] = (void *)
+	ipi_set0_regs[14] = (void __iomem *)
 		(SMP_CORE_GROUP3_BASE + SMP_CORE2_OFFSET + SET0);
-	ipi_set0_regs[15] = (void *)
+	ipi_set0_regs[15] = (void __iomem *)
 		(SMP_CORE_GROUP3_BASE + SMP_CORE3_OFFSET + SET0);
 }
 
 static void ipi_clear0_regs_init(void)
 {
-	ipi_clear0_regs[0] = (void *)
+	ipi_clear0_regs[0] = (void __iomem *)
 		(SMP_CORE_GROUP0_BASE + SMP_CORE0_OFFSET + CLEAR0);
-	ipi_clear0_regs[1] = (void *)
+	ipi_clear0_regs[1] = (void __iomem *)
 		(SMP_CORE_GROUP0_BASE + SMP_CORE1_OFFSET + CLEAR0);
-	ipi_clear0_regs[2] = (void *)
+	ipi_clear0_regs[2] = (void __iomem *)
 		(SMP_CORE_GROUP0_BASE + SMP_CORE2_OFFSET + CLEAR0);
-	ipi_clear0_regs[3] = (void *)
+	ipi_clear0_regs[3] = (void __iomem *)
 		(SMP_CORE_GROUP0_BASE + SMP_CORE3_OFFSET + CLEAR0);
-	ipi_clear0_regs[4] = (void *)
+	ipi_clear0_regs[4] = (void __iomem *)
 		(SMP_CORE_GROUP1_BASE + SMP_CORE0_OFFSET + CLEAR0);
-	ipi_clear0_regs[5] = (void *)
+	ipi_clear0_regs[5] = (void __iomem *)
 		(SMP_CORE_GROUP1_BASE + SMP_CORE1_OFFSET + CLEAR0);
-	ipi_clear0_regs[6] = (void *)
+	ipi_clear0_regs[6] = (void __iomem *)
 		(SMP_CORE_GROUP1_BASE + SMP_CORE2_OFFSET + CLEAR0);
-	ipi_clear0_regs[7] = (void *)
+	ipi_clear0_regs[7] = (void __iomem *)
 		(SMP_CORE_GROUP1_BASE + SMP_CORE3_OFFSET + CLEAR0);
-	ipi_clear0_regs[8] = (void *)
+	ipi_clear0_regs[8] = (void __iomem *)
 		(SMP_CORE_GROUP2_BASE + SMP_CORE0_OFFSET + CLEAR0);
-	ipi_clear0_regs[9] = (void *)
+	ipi_clear0_regs[9] = (void __iomem *)
 		(SMP_CORE_GROUP2_BASE + SMP_CORE1_OFFSET + CLEAR0);
-	ipi_clear0_regs[10] = (void *)
+	ipi_clear0_regs[10] = (void __iomem *)
 		(SMP_CORE_GROUP2_BASE + SMP_CORE2_OFFSET + CLEAR0);
-	ipi_clear0_regs[11] = (void *)
+	ipi_clear0_regs[11] = (void __iomem *)
 		(SMP_CORE_GROUP2_BASE + SMP_CORE3_OFFSET + CLEAR0);
-	ipi_clear0_regs[12] = (void *)
+	ipi_clear0_regs[12] = (void __iomem *)
 		(SMP_CORE_GROUP3_BASE + SMP_CORE0_OFFSET + CLEAR0);
-	ipi_clear0_regs[13] = (void *)
+	ipi_clear0_regs[13] = (void __iomem *)
 		(SMP_CORE_GROUP3_BASE + SMP_CORE1_OFFSET + CLEAR0);
-	ipi_clear0_regs[14] = (void *)
+	ipi_clear0_regs[14] = (void __iomem *)
 		(SMP_CORE_GROUP3_BASE + SMP_CORE2_OFFSET + CLEAR0);
-	ipi_clear0_regs[15] = (void *)
+	ipi_clear0_regs[15] = (void __iomem *)
 		(SMP_CORE_GROUP3_BASE + SMP_CORE3_OFFSET + CLEAR0);
 }
 
 static void ipi_status0_regs_init(void)
 {
-	ipi_status0_regs[0] = (void *)
+	ipi_status0_regs[0] = (void __iomem *)
 		(SMP_CORE_GROUP0_BASE + SMP_CORE0_OFFSET + STATUS0);
-	ipi_status0_regs[1] = (void *)
+	ipi_status0_regs[1] = (void __iomem *)
 		(SMP_CORE_GROUP0_BASE + SMP_CORE1_OFFSET + STATUS0);
-	ipi_status0_regs[2] = (void *)
+	ipi_status0_regs[2] = (void __iomem *)
 		(SMP_CORE_GROUP0_BASE + SMP_CORE2_OFFSET + STATUS0);
-	ipi_status0_regs[3] = (void *)
+	ipi_status0_regs[3] = (void __iomem *)
 		(SMP_CORE_GROUP0_BASE + SMP_CORE3_OFFSET + STATUS0);
-	ipi_status0_regs[4] = (void *)
+	ipi_status0_regs[4] = (void __iomem *)
 		(SMP_CORE_GROUP1_BASE + SMP_CORE0_OFFSET + STATUS0);
-	ipi_status0_regs[5] = (void *)
+	ipi_status0_regs[5] = (void __iomem *)
 		(SMP_CORE_GROUP1_BASE + SMP_CORE1_OFFSET + STATUS0);
-	ipi_status0_regs[6] = (void *)
+	ipi_status0_regs[6] = (void __iomem *)
 		(SMP_CORE_GROUP1_BASE + SMP_CORE2_OFFSET + STATUS0);
-	ipi_status0_regs[7] = (void *)
+	ipi_status0_regs[7] = (void __iomem *)
 		(SMP_CORE_GROUP1_BASE + SMP_CORE3_OFFSET + STATUS0);
-	ipi_status0_regs[8] = (void *)
+	ipi_status0_regs[8] = (void __iomem *)
 		(SMP_CORE_GROUP2_BASE + SMP_CORE0_OFFSET + STATUS0);
-	ipi_status0_regs[9] = (void *)
+	ipi_status0_regs[9] = (void __iomem *)
 		(SMP_CORE_GROUP2_BASE + SMP_CORE1_OFFSET + STATUS0);
-	ipi_status0_regs[10] = (void *)
+	ipi_status0_regs[10] = (void __iomem *)
 		(SMP_CORE_GROUP2_BASE + SMP_CORE2_OFFSET + STATUS0);
-	ipi_status0_regs[11] = (void *)
+	ipi_status0_regs[11] = (void __iomem *)
 		(SMP_CORE_GROUP2_BASE + SMP_CORE3_OFFSET + STATUS0);
-	ipi_status0_regs[12] = (void *)
+	ipi_status0_regs[12] = (void __iomem *)
 		(SMP_CORE_GROUP3_BASE + SMP_CORE0_OFFSET + STATUS0);
-	ipi_status0_regs[13] = (void *)
+	ipi_status0_regs[13] = (void __iomem *)
 		(SMP_CORE_GROUP3_BASE + SMP_CORE1_OFFSET + STATUS0);
-	ipi_status0_regs[14] = (void *)
+	ipi_status0_regs[14] = (void __iomem *)
 		(SMP_CORE_GROUP3_BASE + SMP_CORE2_OFFSET + STATUS0);
-	ipi_status0_regs[15] = (void *)
+	ipi_status0_regs[15] = (void __iomem *)
 		(SMP_CORE_GROUP3_BASE + SMP_CORE3_OFFSET + STATUS0);
 }
 
 static void ipi_en0_regs_init(void)
 {
-	ipi_en0_regs[0] = (void *)
+	ipi_en0_regs[0] = (void __iomem *)
 		(SMP_CORE_GROUP0_BASE + SMP_CORE0_OFFSET + EN0);
-	ipi_en0_regs[1] = (void *)
+	ipi_en0_regs[1] = (void __iomem *)
 		(SMP_CORE_GROUP0_BASE + SMP_CORE1_OFFSET + EN0);
-	ipi_en0_regs[2] = (void *)
+	ipi_en0_regs[2] = (void __iomem *)
 		(SMP_CORE_GROUP0_BASE + SMP_CORE2_OFFSET + EN0);
-	ipi_en0_regs[3] = (void *)
+	ipi_en0_regs[3] = (void __iomem *)
 		(SMP_CORE_GROUP0_BASE + SMP_CORE3_OFFSET + EN0);
-	ipi_en0_regs[4] = (void *)
+	ipi_en0_regs[4] = (void __iomem *)
 		(SMP_CORE_GROUP1_BASE + SMP_CORE0_OFFSET + EN0);
-	ipi_en0_regs[5] = (void *)
+	ipi_en0_regs[5] = (void __iomem *)
 		(SMP_CORE_GROUP1_BASE + SMP_CORE1_OFFSET + EN0);
-	ipi_en0_regs[6] = (void *)
+	ipi_en0_regs[6] = (void __iomem *)
 		(SMP_CORE_GROUP1_BASE + SMP_CORE2_OFFSET + EN0);
-	ipi_en0_regs[7] = (void *)
+	ipi_en0_regs[7] = (void __iomem *)
 		(SMP_CORE_GROUP1_BASE + SMP_CORE3_OFFSET + EN0);
-	ipi_en0_regs[8] = (void *)
+	ipi_en0_regs[8] = (void __iomem *)
 		(SMP_CORE_GROUP2_BASE + SMP_CORE0_OFFSET + EN0);
-	ipi_en0_regs[9] = (void *)
+	ipi_en0_regs[9] = (void __iomem *)
 		(SMP_CORE_GROUP2_BASE + SMP_CORE1_OFFSET + EN0);
-	ipi_en0_regs[10] = (void *)
+	ipi_en0_regs[10] = (void __iomem *)
 		(SMP_CORE_GROUP2_BASE + SMP_CORE2_OFFSET + EN0);
-	ipi_en0_regs[11] = (void *)
+	ipi_en0_regs[11] = (void __iomem *)
 		(SMP_CORE_GROUP2_BASE + SMP_CORE3_OFFSET + EN0);
-	ipi_en0_regs[12] = (void *)
+	ipi_en0_regs[12] = (void __iomem *)
 		(SMP_CORE_GROUP3_BASE + SMP_CORE0_OFFSET + EN0);
-	ipi_en0_regs[13] = (void *)
+	ipi_en0_regs[13] = (void __iomem *)
 		(SMP_CORE_GROUP3_BASE + SMP_CORE1_OFFSET + EN0);
-	ipi_en0_regs[14] = (void *)
+	ipi_en0_regs[14] = (void __iomem *)
 		(SMP_CORE_GROUP3_BASE + SMP_CORE2_OFFSET + EN0);
-	ipi_en0_regs[15] = (void *)
+	ipi_en0_regs[15] = (void __iomem *)
 		(SMP_CORE_GROUP3_BASE + SMP_CORE3_OFFSET + EN0);
 }
 
 static void ipi_mailbox_buf_init(void)
 {
-	ipi_mailbox_buf[0] = (void *)
+	ipi_mailbox_buf[0] = (void __iomem *)
 		(SMP_CORE_GROUP0_BASE + SMP_CORE0_OFFSET + BUF);
-	ipi_mailbox_buf[1] = (void *)
+	ipi_mailbox_buf[1] = (void __iomem *)
 		(SMP_CORE_GROUP0_BASE + SMP_CORE1_OFFSET + BUF);
-	ipi_mailbox_buf[2] = (void *)
+	ipi_mailbox_buf[2] = (void __iomem *)
 		(SMP_CORE_GROUP0_BASE + SMP_CORE2_OFFSET + BUF);
-	ipi_mailbox_buf[3] = (void *)
+	ipi_mailbox_buf[3] = (void __iomem *)
 		(SMP_CORE_GROUP0_BASE + SMP_CORE3_OFFSET + BUF);
-	ipi_mailbox_buf[4] = (void *)
+	ipi_mailbox_buf[4] = (void __iomem *)
 		(SMP_CORE_GROUP1_BASE + SMP_CORE0_OFFSET + BUF);
-	ipi_mailbox_buf[5] = (void *)
+	ipi_mailbox_buf[5] = (void __iomem *)
 		(SMP_CORE_GROUP1_BASE + SMP_CORE1_OFFSET + BUF);
-	ipi_mailbox_buf[6] = (void *)
+	ipi_mailbox_buf[6] = (void __iomem *)
 		(SMP_CORE_GROUP1_BASE + SMP_CORE2_OFFSET + BUF);
-	ipi_mailbox_buf[7] = (void *)
+	ipi_mailbox_buf[7] = (void __iomem *)
 		(SMP_CORE_GROUP1_BASE + SMP_CORE3_OFFSET + BUF);
-	ipi_mailbox_buf[8] = (void *)
+	ipi_mailbox_buf[8] = (void __iomem *)
 		(SMP_CORE_GROUP2_BASE + SMP_CORE0_OFFSET + BUF);
-	ipi_mailbox_buf[9] = (void *)
+	ipi_mailbox_buf[9] = (void __iomem *)
 		(SMP_CORE_GROUP2_BASE + SMP_CORE1_OFFSET + BUF);
-	ipi_mailbox_buf[10] = (void *)
+	ipi_mailbox_buf[10] = (void __iomem *)
 		(SMP_CORE_GROUP2_BASE + SMP_CORE2_OFFSET + BUF);
-	ipi_mailbox_buf[11] = (void *)
+	ipi_mailbox_buf[11] = (void __iomem *)
 		(SMP_CORE_GROUP2_BASE + SMP_CORE3_OFFSET + BUF);
-	ipi_mailbox_buf[12] = (void *)
+	ipi_mailbox_buf[12] = (void __iomem *)
 		(SMP_CORE_GROUP3_BASE + SMP_CORE0_OFFSET + BUF);
-	ipi_mailbox_buf[13] = (void *)
+	ipi_mailbox_buf[13] = (void __iomem *)
 		(SMP_CORE_GROUP3_BASE + SMP_CORE1_OFFSET + BUF);
-	ipi_mailbox_buf[14] = (void *)
+	ipi_mailbox_buf[14] = (void __iomem *)
 		(SMP_CORE_GROUP3_BASE + SMP_CORE2_OFFSET + BUF);
-	ipi_mailbox_buf[15] = (void *)
+	ipi_mailbox_buf[15] = (void __iomem *)
 		(SMP_CORE_GROUP3_BASE + SMP_CORE3_OFFSET + BUF);
 }
 
-- 
2.39.2

