Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3EC7DA32F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 00:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346658AbjJ0WLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 18:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346649AbjJ0WLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 18:11:25 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791F01B9;
        Fri, 27 Oct 2023 15:11:22 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 7889B3200930;
        Fri, 27 Oct 2023 18:11:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 27 Oct 2023 18:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1698444680; x=
        1698531080; bh=z1/hT0gfhZcXEOcRfnRggstjECOl2aSsJ7lZKpBlqTw=; b=i
        e76scIspHwkejyfMlnNEsixiVulfjcVKOLLUtgoLrR11xkpC01KVmQhVHs2TefaD
        os2qKf+GPYO7zQEtb2JpXtEqsAvCecYBKwyw71y/mB4Z1YkU5+ItMtj4gt+oU1kF
        VvywaEgcocRVyucR8+JkP7vOsX9xYXX9qkF1X+7J/wGCPKbmwVhls7iRmBOpmlVW
        CubsWCdA35vNnHZhUyINIEzT9PPioX8vtRspLjG6TtzZe/+2oiwj1XHFj9oM2+7D
        nnWIX8fAxCtmUK5QjlIBrZlf5XuvVdZ1/nZqEw5UYqW/v6HSlK2e0xhUxnUZTriQ
        0YLCDxpkIWVzoe+kozbIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698444680; x=
        1698531080; bh=z1/hT0gfhZcXEOcRfnRggstjECOl2aSsJ7lZKpBlqTw=; b=m
        UpktjBn4KhValcLCW3JZDXm2MAbITWg2wnxsAVP4ABdz6qTmcSs661UOCnGARar4
        rNjg8ncG9spH9kheEDBsZgHrpkgp62yis2D11+/JX39HJRLghnhBi8R7ghQN16Po
        0uKuS5Oz6BYMLNkjBBa+G2xnHcW3kkEul8obcaS/fYtGJ13yfpJJGh1xUvZB/k3A
        h6UTk3lOQkeADwj+8YYh3SKb6Ahqq1sETozW8iubI0kTCHAmTiNvM6rF5z1/HJlH
        WBTVAn/SvFxRfNACEfITQmCUtJAyEbW5Mbz/JwNJg9HB77vvU9pldwePiaeOo+JV
        2n6JYAvVoMKTIGOjNVJqw==
X-ME-Sender: <xms:iDU8Za9r0FvfwfrW814-X1R0dvYuILuyEQkWQ4J77SINiFMWBnJVag>
    <xme:iDU8Zasvx6dn7dEM7gfDi0TuaFnqYN-mn2e9WiMHl6vndXmuFf_p72YXlEMZYs7sA
    punOhE90Ala_ouuoB8>
X-ME-Received: <xmr:iDU8ZQBGp5evnTe5u6lAlSsXSB434zU--8HB_4iOgqLmFGE_pqyyTCAZaFxx-49t8M46GdFgDho>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrleehgddtjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomheplfhirgiguhhnucgjrghnghcuoehjihgrgihunhdrhigrnhhg
    sehflhihghhorghtrdgtohhmqeenucggtffrrghtthgvrhhnpeefledufeehgedvuedvvd
    egkefgvddttedtleeiiefhgeetudegkefhvdfhjeeftdenucevlhhushhtvghrufhiiigv
    pedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehjihgrgihunhdrhigrnhhgsehflhihgh
    horghtrdgtohhm
X-ME-Proxy: <xmx:iDU8ZSc6AKh1flxcIsyrZ0xArh6u3G7rPLUJfw5AcObQxXjHJke07w>
    <xmx:iDU8ZfOQj2ZoI4KZ64l8XNMXkknRG_KVG5FaQCoJHV-vnoqSKhKxEA>
    <xmx:iDU8ZcmlRYLqnT_anfFDnOrASd3QFazKeI0E4G_s60RTfEE3VletMA>
    <xmx:iDU8ZUrV5hfeUQVZQKKp10KeHNGp_u1JSmiIT50QlRRarHbEOUVItQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Oct 2023 18:11:19 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        gregory.clement@bootlin.com, vladimir.kondratiev@intel.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 04/10] MIPS: Fix set_uncached_handler for ebase in XKPHYS
Date:   Fri, 27 Oct 2023 23:11:00 +0100
Message-Id: <20231027221106.405666-5-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027221106.405666-1-jiaxun.yang@flygoat.com>
References: <20231027221106.405666-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ebase may be in XKPHYS if memblock unable to allocate memory
within KSEG0 physical range.

To map ebase into uncached space we just convert it back to
physical address and then use platform's TO_UNCAC helper
to create mapping.

Co-developed-by: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Co-developed-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/kernel/traps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 60c513c51684..230728d76d11 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -2346,7 +2346,7 @@ static const char panic_null_cerr[] =
 void set_uncached_handler(unsigned long offset, void *addr,
 	unsigned long size)
 {
-	unsigned long uncached_ebase = CKSEG1ADDR(ebase);
+	unsigned long uncached_ebase = TO_UNCAC(__pa(ebase));
 
 	if (!addr)
 		panic(panic_null_cerr);
-- 
2.34.1

