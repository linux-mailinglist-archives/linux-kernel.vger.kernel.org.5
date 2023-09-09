Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B04799ABF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 22:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245013AbjIIURr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 16:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245132AbjIIURp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 16:17:45 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A94CED
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 13:17:39 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 2D9BD3200805;
        Sat,  9 Sep 2023 16:17:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 09 Sep 2023 16:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1694290657; x=
        1694377057; bh=rUsqFVJjBVyLyCtvleKeuxMZhdTqpYL3EtsdFwHrfmk=; b=E
        N8Sx3QN/zwyT1uB2+ogFARNEBx5avj520tUSxakXtHkIRaKHXquCPWKjhWIzDZgG
        srtx3VyL9+CDt3cqFSDUG6MQF2i/sOudw4fvnTOxSxeyya6GP/oPZW2IYxCwRut2
        40mmFiiqU6NNduAoRnoXLlYRKOSSRHcwtZ6GXPO3ZkS6e9fZ27yZrvOyB0euLz9y
        kj88QUz7fOXwIZUbxic69m6Kh2dLZ/WpeigR/X4t3feBkqX7h24Rk/4bXQEfm40M
        fQdX4a9Nz3LeVejqFaHuJXTUPRCg2thjwWhWK1mK2V6IgHXJdCUprlREPHV1mf+b
        tDiB8MPwA70ma9zm4JwUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1694290657; x=
        1694377057; bh=rUsqFVJjBVyLyCtvleKeuxMZhdTqpYL3EtsdFwHrfmk=; b=l
        R+Q/fYfNiHJVIzgyH8iPibJTTy6BLgjJwAJX9wbPM0FZjI/tTm4mQMH5s2MYqzG7
        CoypenZlZDIJwwfOBTr01Buows1SWTkPrwjGvr26szHSjHxGbO+6QUhMwxCDrjqy
        X013ycgQWlbyxULqmNrU3Xfy+mJZL3U876cdL6urH/vRtDyoMEk99b46BbaZTwPE
        FPfJ+CPX3k0+3F9zmkQop8AxbAbmC2TrHdCRcFf3vELyKw6fJ4BqmE60GJNZdLXQ
        slewUndvm4x5TzH5Y1HEHVR6aif3RLAIEw78+QsrAXYpDFfgIf7KUkBJT8Srh0vt
        LdKCPxnON/hgTnyTp6hFQ==
X-ME-Sender: <xms:4dL8ZP9-5oTidZloLy-nR4A4FbUUVGt-C7Bk6E37WxyKXgTk2PJW-g>
    <xme:4dL8ZLtIRylnb_DLOCyHGJRtEVI_MwLggr1EH8q_NWYe7mgHOn_NNCTPiwgZR46nf
    I4oD6zJTmMiIbRTog>
X-ME-Received: <xmr:4dL8ZNBRdsxg3h_Z2SdA8FnR7qYUb0DtLHc-6Uo2qgP792mDniMJ9-aMgr5_b_o2xaS1Okk7eqLaBwHkqmV18wwEYkZXxlBr7oU1BozGtUF4cebUMD0iKGnavlKwwDLOtcgwVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehledgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:4dL8ZLchhWySKUuDasjyZRBwirkTM0Hv-5KK324bJPnioTfpilz32A>
    <xmx:4dL8ZEOJ8dOb5MX812UdY66grGmMnTiq_0FdOjruBInopqeysKKZQQ>
    <xmx:4dL8ZNk_1GNUP3mm6M8l-i85_rfeI8IhxNymwDZf0md-BVV5Yd1Ktw>
    <xmx:4dL8ZBoYoYJ7FQKWFAUwYWhZX7FXYpsZwK4IwxxST5Z9rMObLBc-Fw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Sep 2023 16:17:37 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 4/7] riscv: mm: Make asid_bits a local variable
Date:   Sat,  9 Sep 2023 15:16:32 -0500
Message-ID: <20230909201727.10909-5-samuel@sholland.org>
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

This variable is only used inside asids_init().

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 arch/riscv/mm/context.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index b5170ac1b742..43a8bc2d5af4 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -20,7 +20,6 @@
 
 DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
 
-static unsigned long asid_bits;
 static unsigned long num_asids;
 
 static atomic_long_t current_version;
@@ -226,7 +225,7 @@ static inline void set_mm(struct mm_struct *prev,
 
 static int __init asids_init(void)
 {
-	unsigned long old;
+	unsigned long asid_bits, old;
 
 	/* Figure-out number of ASID bits in HW */
 	old = csr_read(CSR_SATP);
-- 
2.41.0

