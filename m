Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECDC757DFF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 15:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbjGRNo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 09:44:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjGRNoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 09:44:25 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C39D1;
        Tue, 18 Jul 2023 06:44:23 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 099DA5C01B9;
        Tue, 18 Jul 2023 09:44:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 18 Jul 2023 09:44:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1689687863; x=1689774263; bh=CMyNnD4dXf
        z3wxwhrNtzwsCnZ57GYhNzAQwsalAFITM=; b=EpzGv4WEUOsi9muzilKvQbi9/L
        V4ZRhoWZb+ZcvWRrLbqPGpokMlWUUfjIGfeWd/3kecoEqzMIUul21Gq6tragDzEe
        U+VTc+bSFY7OqAHGsDf64FSKzfd8gC6rl2BT7xpKJ81Tz9+S09caMR7CamsGpLC1
        fyHzfmuGl6Rk3PxFXmqY8UzRIN6mIi2BdoBhPoR1EY2OLrj9guRcMAEaIEFKx1U1
        hn7EVtYavrTeuCHXHIV31WKPaDDg7lF2dfZ+RJC8bAfV/FCxLnn/yAWx+o3zxVz9
        NnLIBgmXRWwPoy3Oh/8WWzDYB9HRo1KFS2GmbpH95JbvHExItZpib3rKvwIg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689687863; x=1689774263; bh=CMyNnD4dXfz3w
        xwhrNtzwsCnZ57GYhNzAQwsalAFITM=; b=2Yc/DSzxMHaeDQZ5X9lMzN/ga01df
        vCZd4bz/qNAqb50PrLMoJPv941YBH0csylhHB3HGXmx/gmKFcPdmNIe8tCwRnFyg
        rxy9p8Ap55GS3zTH3pmDQGWMATU9RDuRws1b4bk6Q9O2i7aqLs8+KKzwi5uNWTb5
        u1OJ/wPCia9O3LsowiLKrzC69/XJXVX3jq2sQBmSNIiO/iL30BwjUZl0G5eS+gaX
        73oFKU3ljQRVFPRtv6mFlcQ4gqoRQNcLpcE3gT2/oNBZPtzLhQB1qsBS1xbn7NjS
        hJ0gh5o6G4w+mHLv5TuK5gvSzfEXP01v0aCmyqlMI/VfrovmjBlqkur0g==
X-ME-Sender: <xms:Npe2ZKewi2uTK5MLdh1HmjQ6x3ibgn9o8x2FG_cOVkdvFOFdvLWKkg>
    <xme:Npe2ZENdGj9xUs_pcgF3lQvUQfDAb-KE2Y2FVJ_rm7EjkE4CpajcFZBv-mtc9-zP8
    etdGMzytiiMCUE-pt4>
X-ME-Received: <xmr:Npe2ZLg_KJmhwd4YKfAIUiAjLH2D8yj_6jKOocgd8aIi65pEyL3DioXTDUf19qeVRH4QniGtRnQbgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgeeggdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgggfestdekredtre
    dttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhgsehf
    lhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpedvueetkeeluedugfeuteehtd
    dutdfhtdelffeghfeiheefieegvddtueevteeiudenucffohhmrghinhepkhgvrhhnvghl
    rdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:Npe2ZH_d5fG1t-Kl6IHIzwho_oyO0Np_cLJSvtcCFTQNzRTrTp9KgA>
    <xmx:Npe2ZGstNxOylaN7fCFkzSkGOO0aqCsm-KkGjMphoi5_JUtlUAAINg>
    <xmx:Npe2ZOEU1-pDje5Ss-6nK1UXMz6o6ktwh2NSotiLkypsteYSUtkSsA>
    <xmx:N5e2ZKLV3oQbqDs0LDUwhx3VI_vkB5xfxtQHfeALe-NO5C-kta0lIw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Jul 2023 09:44:20 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, chenhuacai@kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] MIPS: Loongson64: Fix more __iomem attributes
Date:   Tue, 18 Jul 2023 21:44:11 +0800
Message-Id: <20230718134411.2871477-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
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
 arch/mips/loongson64/smp.c | 168 ++++++++++++++++++-------------------
 1 file changed, 84 insertions(+), 84 deletions(-)

diff --git a/arch/mips/loongson64/smp.c b/arch/mips/loongson64/smp.c
index cdecd7af11a6..b700ca887c35 100644
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
 
@@ -782,7 +782,7 @@ void play_dead(void)
 
 	if (prid_imp == PRID_IMP_LOONGSON_64G) {
 		play_dead_at_ckseg1 =
-			(void *)CKSEG1ADDR((unsigned long)loongson3_type3_play_dead);
+			(void __iomem *)CKSEG1ADDR((unsigned long)loongson3_type3_play_dead);
 		goto out;
 	}
 
@@ -790,19 +790,19 @@ void play_dead(void)
 	case PRID_REV_LOONGSON3A_R1:
 	default:
 		play_dead_at_ckseg1 =
-			(void *)CKSEG1ADDR((unsigned long)loongson3_type1_play_dead);
+			(void __iomem *)CKSEG1ADDR((unsigned long)loongson3_type1_play_dead);
 		break;
 	case PRID_REV_LOONGSON3B_R1:
 	case PRID_REV_LOONGSON3B_R2:
 		play_dead_at_ckseg1 =
-			(void *)CKSEG1ADDR((unsigned long)loongson3_type2_play_dead);
+			(void __iomem *)CKSEG1ADDR((unsigned long)loongson3_type2_play_dead);
 		break;
 	case PRID_REV_LOONGSON3A_R2_0:
 	case PRID_REV_LOONGSON3A_R2_1:
 	case PRID_REV_LOONGSON3A_R3_0:
 	case PRID_REV_LOONGSON3A_R3_1:
 		play_dead_at_ckseg1 =
-			(void *)CKSEG1ADDR((unsigned long)loongson3_type3_play_dead);
+			(void __iomem *)CKSEG1ADDR((unsigned long)loongson3_type3_play_dead);
 		break;
 	}
 
-- 
2.39.2

