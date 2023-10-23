Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34227D3FF9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 21:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232081AbjJWTOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 15:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231472AbjJWTOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 15:14:12 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34F694;
        Mon, 23 Oct 2023 12:14:10 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 187B15C039B;
        Mon, 23 Oct 2023 15:14:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 23 Oct 2023 15:14:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1698088450; x=
        1698174850; bh=z1/hT0gfhZcXEOcRfnRggstjECOl2aSsJ7lZKpBlqTw=; b=f
        9QS4lLRzjmlQ4M2TtMEPPxiHPJ+vzcEt7SZhYcO6LBu2QH9uiiySUVTl+WMKIWYb
        AZt9KnvxiyhG4gV72ECJkwQiMqWyOkz92FqFat09Trjcr9TyQVH7j65QZ/uTWmTY
        FP5bqK1LauBBqFBH6pJyzUxURLh0JxnRwqS0Xg8lo0yXu76/lT+Yj12EhqmG0MA2
        kbRje4Ecf2dSe9Y7Uyiz+6oVVh+DAY5GJ73YUkkJvc1MHUc3wmeuVeT0p5SOmPGL
        QI0zXLGXlK58o+sPQsQmweBQIFb54KJimPmTGZZOKoh6Th6VSkVJG1D/JJ0LFrr2
        4SC7QKLEeQSwBnLwX8EaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1698088450; x=
        1698174850; bh=z1/hT0gfhZcXEOcRfnRggstjECOl2aSsJ7lZKpBlqTw=; b=d
        2RjKvnMMLLaoeUmXvajRFssG4MtP2LOedZgw75iBxoy5AFicoySNzIypJfs7CtMv
        UT3fubUxU3XzXhEcpbUY27WGjl4ZGz0fWVLad/nPZC1tzJiob2678hM8Ee2MnFhh
        OG/wq+XAwWQW6faxB8NGViTT0xxla4q8YWFbwFg3lKnMmzUBEO8X3BmIfPJf1zDa
        a4bIkyNaMA/dWM5dJ/YiUXGmiwn9tfo8/JJnwYL2mQyxgHEJB8Dq5yYfgbaBPgqg
        ai9E513EMYpR+VgvhctAAR13ugzQnNgBQ5J5BteMPm52ypP1cZ30hd2mMp1/3m35
        sw1xxukf4EYQxoWP2z3rw==
X-ME-Sender: <xms:AcY2ZTwXL1Rznd3ngdWlYMGvihGGJbjhJ5VUDM4v8yfA49I5_q3J3g>
    <xme:AcY2ZbToMuKGg3ibnkxG0mnawq3sY1nkG05iOHrDlsKygFvojj_cvNjSiVtspi5lr
    6ktyvoY2NVHVjjDsYE>
X-ME-Received: <xmr:AcY2ZdUkD6KZUSzDcetPtHPnnZQWVzRGIIgz9G6ETOhLKIyhQIAsVv3FYMigjKtM4KvkPP4bmsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrkeeigddufedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:AcY2Zdh4yYqWMbhT0XgSo7pYfMygOBw1n_wL4pgmpU9frQLS8gOmJw>
    <xmx:AcY2ZVBIvg26kv12DQ9Vfw52WIlT29ao4TrZ9BuE5SD2D4onLnWEnw>
    <xmx:AcY2ZWJGo1nYQs4nMScUmxpCpVXm1EyNAgC8mG48vSMl6Q1EIGJBlg>
    <xmx:AsY2ZQ-MbdHv70zHfUSwDtVpMtc4qWaotStUGwLymXad3npi4so3pg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Oct 2023 15:14:08 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        gregory.clement@bootlin.com, vladimir.kondratiev@intel.com,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 3/5] MIPS: Fix set_uncached_handler for ebase in XKPHYS
Date:   Mon, 23 Oct 2023 20:13:58 +0100
Message-Id: <20231023191400.170052-4-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231023191400.170052-1-jiaxun.yang@flygoat.com>
References: <20231023191400.170052-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

