Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795487E3ADD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbjKGLPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjKGLPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:15:48 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0EDEA;
        Tue,  7 Nov 2023 03:15:45 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 944465C0162;
        Tue,  7 Nov 2023 06:15:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 07 Nov 2023 06:15:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:message-id:mime-version:reply-to
        :sender:subject:subject:to:to; s=fm1; t=1699355744; x=
        1699442144; bh=QLGn+pJ6jA1OBsO+n6clp14ghLq+Aqned+goXZG8HJw=; b=B
        J2ivxoayFi0lVMufasb7MEhgFhQk8uG+cDL1xLMNF0p71SJXUtD6PiL5u8aWKO+I
        ms9vLiyf7OiWaiu4UcNT7b4vB/tr7wNNiO0S+U5qculPLjTEeGbbpQ/r+psNfu/H
        pHKCzb8gZSA0umleoRuLWCs3xj/OXN/o0EPBi/8cOFjMNoIkj6zrArGOS9pwXW4S
        6I0AlZpph/RSheLdZEhTaTGcl5oSO9LTfugu2xokICD4EsU8Lnwi8BbTCVcJtUpb
        WKUXNw29eizskiX/6EPetdCyGcweZnxrtnoNy8raybeKog17bsbJJ8zlqt64qNnX
        CTgScMRjrFTtCdADjnRKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; t=1699355744; x=1699442144; bh=Q
        LGn+pJ6jA1OBsO+n6clp14ghLq+Aqned+goXZG8HJw=; b=FPqpaumdoThd/Hs6U
        cgNytyy0SYkVRUMHRxq1kgcyj7RxLB543N89s7nvOhZptD+bzZd4sJvcMiTr6sj/
        //wA97Jr0OjNCn7CI0crVJHb8l4L0NnumKhqAJwmg63D4V1Ogr5wjI+9qfuuHnNn
        kraB/56eB27xdoSXdpuj9YyDfH4R/xbf6msi6TrCki4hix8b3bHeYUc8VNLn+eQg
        bQjszUHOyB1K0IlYvP7l2VePdsCHiv8WTH9p1mRZg0oYT0+K5AMoBHMBakk63Kdl
        PkrTqUEiEu7qNSvC2efCAFtPybg4PYRLX/3FfrE4O1cWg3TR40L+k/6C9Ra+KVMN
        GS2Vg==
X-ME-Sender: <xms:XxxKZWhOgt9trhqpH4f0PTcD4GPgNK4eIIr3RrAoLDgqEO4IzOfVlQ>
    <xme:XxxKZXDuwvwjyZT2ay3DOA38HZiRhiRZacfDjbBCHu7Co_hf3_gahxXFULqrEcgaK
    7LCcfNbM0iDKn2C2Co>
X-ME-Received: <xmr:XxxKZeF92KfCNWkuf7ZMoPuiiNbiS62-pDnLjEMneSTuiKnBN0nduzU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduiedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffufffkgggtgffvvefosehtjeertdertdejnecuhfhrohhmpeflihgrgihu
    nhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecugg
    ftrfgrthhtvghrnhepgfevffejteegjeeflefgkeetleekhfeugfegvdeuueejkeejteek
    kedvfffffedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehf
    lhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:XxxKZfQqlWaYxhX-AumhfYOgsux6wFakKEQyH9OSxggBKYFkFUrOtg>
    <xmx:XxxKZTxGTh9Li0weax68f-e2pNV3c5wlJLsq3pqjVk5UKdqv3K9T1w>
    <xmx:XxxKZd5rpO9TsVCM6zBnCHY6hrz6TCiuXYx5qmD3cs1yNcJ4jJbeaA>
    <xmx:YBxKZerpapQl9wq0-wUbkqLwVEs4UghzVu0e6o5NFovHxMOuJYNOCA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Nov 2023 06:15:42 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH fixes v2 0/3] MIPS: Loongson64: Fix some long-term issues
Date:   Tue, 07 Nov 2023 11:15:17 +0000
Message-Id: <20231107-loongson64_fixes-v2-0-5c49ceed7950@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEUcSmUC/3WNwQqDMBBEf0X23JRs1NL21P8oUhLdaMBmJZFQk
 fx7gz33NjOPmdkhUnAU4V7tECi56NgXo04V9JP2Iwk3FA9KqhpRopiZ/RjZX5qXdR+KQmpr0LS
 yHpCg1JZAByitJ/xUV+LJxZXDdhwlPOD/zYRCCqVVe1W6MVbfHnbeRtbruec3dDnnLwPE9BC5A
 AAA
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Huacai Chen <chenhuacai@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sergey Shtylyov <s.shtylyov@omp.ru>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series fixes some long-term issues in kernel that preventing
some machine from work properly.

Hopefully that will rescue some system in wild :-)

Thanks

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
Changes in v2:
- Typo and style fixes
- Link to v1: https://lore.kernel.org/r/20231101-loongson64_fixes-v1-0-2a2582a4bfa9@flygoat.com

---
Jiaxun Yang (3):
      MIPS: Loongson64: Reserve vgabios memory on boot
      MIPS: Loongson64: Enable DMA noncoherent support
      MIPS: Loongson64: Handle more memory types passed from firmware

 arch/mips/Kconfig                                  |  2 +
 arch/mips/include/asm/mach-loongson64/boot_param.h |  9 ++++-
 arch/mips/loongson64/env.c                         | 10 ++++-
 arch/mips/loongson64/init.c                        | 47 ++++++++++++++--------
 4 files changed, 49 insertions(+), 19 deletions(-)
---
base-commit: 9c2d379d63450ae464eeab45462e0cb573cd97d0
change-id: 20231101-loongson64_fixes-0afb1b503d1e

Best regards,
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>

