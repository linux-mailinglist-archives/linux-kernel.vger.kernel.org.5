Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0F77DE350
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:36:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233643AbjKAPRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbjKAPRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:17:19 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A751125;
        Wed,  1 Nov 2023 08:16:46 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 0FBB65C0282;
        Wed,  1 Nov 2023 11:16:46 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 01 Nov 2023 11:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1698851806; x=1698938206; bh=rfJ8NsCUvbCjddA6Gq2JRigs1j0SZ4J6oSh
        nKu8GER4=; b=VvkLJUB5wsNp4XJ1T/zesbCIIT7H4cwSpZB/KyQBKVwRGP4uDz/
        0pwUzkliwMAd06C3IWgl5ybLGCI4V7pUUoE5vZOUkbo2sAWjsuNl/iaw5Aqu3V7L
        Vu95r2911bwaCKJix33axtmfuXwWLbl28NDRFT90Er3kuloGBgrAPVD2fTaFoqcW
        mzFS7/TvNCH9PbcoqakGnVuu4qQj1w6Z+jMShTDpfwMunSP+ToTxS2TzPUkW4ly8
        sZ6VEfEO0C8leGUsY1FGj1aOBUZkcNlcmAPRp8PJQpKRwGCyFJATWgzqf6oqnwML
        Ki3hkBUnCcis3inEQDxbALpc1vwQe3MbTqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1698851806; x=1698938206; bh=rfJ8NsCUvbCjddA6Gq2JRigs1j0SZ4J6oSh
        nKu8GER4=; b=cbTM0SnOeM9q1h/gSBazmSH+cMBcKmsWGsirLvXuVuWD7PQguTR
        IqPsrYL8v615lBNIEZ+Mj1v6J+gs5v/b8HTDa+DHfjL1g6WwXYPnNGC/GwiHcvW4
        1ody6RBWX79ch4YfdzSmauffviFUNoqTe/ONRWxFKCaT0pkWhVmc7CwHkwo9AvE9
        K3LB+PE7p5c1LEK/ECPCXDSto9dSC2HH6Vs/1N9WrsQIglI8uEfVTEozJZ9jptdc
        NO7y6k0vE3pmcZI3JYUDdzKLoXVe3he7k2FvCF2DuN0se6HZcCZwI9Fd5hcl/GgW
        DUiLVD5GyUkd3biSsZhM+Bxy/35rQEqzIcg==
X-ME-Sender: <xms:3WtCZfFGR2nvZBKy1b9-cou6Wkr3STw2d4drxPyHU5PKNy0LomdlPQ>
    <xme:3WtCZcXWN4n7s2RgQs3CaGhjNngt-MEfYvbo56-dQkMLJi5BYCLsPEgKm0xk-YYBu
    r0gvBADXiU_7azT5yo>
X-ME-Received: <xmr:3WtCZRLIt2IJpzNLdxJGNYtW0n1g_eYAckr1rO4ZiK08shONnOcMXRQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedruddtgedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
    veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:3WtCZdHHe3eeQfa736XS5TsQDEr7XPE1YeMhIJ3RnAVv0nERr0MmEQ>
    <xmx:3WtCZVWeKcTJVak3AYFr0szwJZnGIvBoDq4kEBFG0PR-_hQFgoojdQ>
    <xmx:3WtCZYNkOxfw5oIbO-H38RvE4iPxChZDpr73aJuSFbk5DTMcvmiVGA>
    <xmx:3mtCZbxarsPw3-xXXnZ66FFBTbVkEYb80lEWt1diQQP0CADjAs1uxw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Nov 2023 11:16:44 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Date:   Wed, 01 Nov 2023 11:39:07 +0000
Subject: [PATCH fixes 1/3] MIPS: Loongson64: Reserve vgabios memory on boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231101-loongson64_fixes-v1-1-2a2582a4bfa9@flygoat.com>
References: <20231101-loongson64_fixes-v1-0-2a2582a4bfa9@flygoat.com>
In-Reply-To: <20231101-loongson64_fixes-v1-0-2a2582a4bfa9@flygoat.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Huacai Chen <chenhuacai@kernel.org>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vgabios is passed from firmware to kernel on Loongson64 systems.
Sane firmware will keep this pointer in reserved memory space
passed from the firmware but insane firmware keeps it in low
memory before kernel entry that is not reserved.

Previously kernel won't try to allocate memory from low memory
before kernel entry on boot, but after converting to memblock
it will do that.

Fix by resversing those memory on early boot.

Cc: stable@vger.kernel.org
Fixes: a94e4f24ec83 ("MIPS: init: Drop boot_mem_map")
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/loongson64/init.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/mips/loongson64/init.c b/arch/mips/loongson64/init.c
index ee8de1735b7c..d62262f93069 100644
--- a/arch/mips/loongson64/init.c
+++ b/arch/mips/loongson64/init.c
@@ -88,6 +88,11 @@ void __init szmem(unsigned int node)
 			break;
 		}
 	}
+
+	/* Reserve vgabios if it comes from firmware */
+	if (loongson_sysconf.vgabios_addr)
+		memblock_reserve(virt_to_phys((void *)loongson_sysconf.vgabios_addr),
+				SZ_256K);
 }
 
 #ifndef CONFIG_NUMA

-- 
2.34.1

