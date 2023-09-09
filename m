Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C496799ABA
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 22:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244245AbjIIURe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 16:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232992AbjIIURd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 16:17:33 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11B2819E
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 13:17:30 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 18E023200805;
        Sat,  9 Sep 2023 16:17:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sat, 09 Sep 2023 16:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1694290648; x=1694377048; bh=Hk6wknAc4l
        ZaedMTDgYmfaNUU/MhXW2aKVUzRRXMt28=; b=Un7Tv41Q3wdz3Wgm5HiIlxYwVs
        fN3illv7SBD32AjBR5kPcRLA0EU11tC+qB4tUulBOWf6XuMeJE0ztUW84a/JMkhF
        q173Gy0q1doHfPxubc7XGwsdlqYM9KsnODCuvcjAg1XMsHL47AU+EywUDw+K4rVu
        Jldiw3fnL0elu9DCclKPboPwVuM+Y9kkUGcUVLqJP+3nVOi/RumH4DNTdoOYiKxb
        WpfG/mRepO8ztaVWCUoG8WWTYOyof5rZQ38FLro5P2hSCzU/Nevm/Rbgr7F57kQk
        34EsberygQaG7NWy6Y8peTpUI66l0mAFMFa3cUGK2o5aYPi78CaaAuk+rW1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1694290648; x=1694377048; bh=Hk6wknAc4lZae
        dMTDgYmfaNUU/MhXW2aKVUzRRXMt28=; b=o8/vTDdesjQJE4xdC4uKNxUKB/bdx
        3g4BJc8uRX0CprZNCnhhKlY8I4wNh/2SGaFl2RwNgFQAQtF0iPp82NyIwP4YbclO
        rVuZfBt6KriLmiYkTbT3upJcQYL2qT/MyiWWknuu293+SWFNZRHY++OnZ5VYB1+G
        pg6nCofyBtxcOp58ON2CsFQyrqRFjTaZVc4UoS0nwFHhL9GDLkaFd3OOo8+qLYR0
        UU0RfMltu+h4UD8/fHBM+VP8Y14a5N8bIW+sg6ynZDW10DDQWWjgnkDV1Yu5qVtm
        3IiQEaCGUrfv6b8yr0RcefGR6rmix0EcQm+8Um51up9iRH/pOieQkb14A==
X-ME-Sender: <xms:2NL8ZDlswmi7zLKrN8eboJYF5zwdvDwDLkolqNpsu2eq9ZV0WiUGcQ>
    <xme:2NL8ZG1mhcIJwNw9vQRXxsLP1cU2FF2uEM7NEt7SCIHZ9FoB05IvbL9iWVamkDR8R
    v01aSYN1hJWdrV4uw>
X-ME-Received: <xmr:2NL8ZJrirpbtqbIpRmlnyb_ua4p7fQ36CeOv5JwaziUAvj5Hdl3ZZWrxHv3rUFvcrQZBaFq7dKd7C04x2UMQfGdCkXFm1TRbNsjorWELlAtuYY2Zr_kbQ0eg4tjOBcFJppyUbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudehledgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeekheffteehtdetfffgfeetteejvdefleeuvedufffguedtjedvheel
    vddvfffhveenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:2NL8ZLlD6P4BP98h7HGLqexLcqWO4yRv1tk2vy6c00aeVvVma4xKUw>
    <xmx:2NL8ZB3QjE6rgPcchM1XTdQdgT3HIrN24YiiR-JCeY5zYb4JycjRqg>
    <xmx:2NL8ZKtGkXb97huSsxoPLt3NWo4sQrTn8jvgcmXbKGKhYII9Iw-Ifg>
    <xmx:2NL8ZMTuSAloKitZByflDMPX7tELBBD58pJd1wh6vVHwZ4ZfwkRVnA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 Sep 2023 16:17:27 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>,
        linux-riscv@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 0/7] riscv: ASID-related and UP-related TLB flush enhancements
Date:   Sat,  9 Sep 2023 15:16:28 -0500
Message-ID: <20230909201727.10909-1-samuel@sholland.org>
X-Mailer: git-send-email 2.41.0
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

While reviewing Alexandre Ghiti's "riscv: tlb flush improvements"
series[1], I noticed that the TLB flushing functions mostly end up as
flush_tlb_all() when SMP is disabled. This series resolves that. Along
the way, I realized that we should be using single-ASID flushes wherever
possible, so I implemented that as well. This series is mostly
orthogonal to Alexandre's series, though it does remove the non-ASID
code path from tlbflush.c, which turns out to be required for
flush_tlb_kernel_range().

[1]: https://lore.kernel.org/linux-riscv/20230801085402.1168351-1-alexghiti@rivosinc.com/


Samuel Holland (7):
  riscv: Apply SiFive CIP-1200 workaround to single-ASID sfence.vma
  riscv: mm: Introduce cntx2asid/cntx2version helper macros
  riscv: mm: Use a fixed layout for the MM context ID
  riscv: mm: Make asid_bits a local variable
  riscv: mm: Preserve global TLB entries when switching contexts
  riscv: mm: Always flush a single MM context by ASID
  riscv: mm: Combine the SMP and non-SMP TLB flushing code

 arch/riscv/include/asm/errata_list.h | 12 +++-
 arch/riscv/include/asm/mmu.h         |  3 +
 arch/riscv/include/asm/mmu_context.h |  2 -
 arch/riscv/include/asm/tlbflush.h    | 41 ++++++-------
 arch/riscv/mm/Makefile               |  5 +-
 arch/riscv/mm/context.c              | 26 ++++----
 arch/riscv/mm/tlbflush.c             | 92 +++++++---------------------
 7 files changed, 67 insertions(+), 114 deletions(-)

-- 
2.41.0

