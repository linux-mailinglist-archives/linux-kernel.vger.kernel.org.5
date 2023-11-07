Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C093A7E3ADF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 12:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjKGLPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 06:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbjKGLPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 06:15:49 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9424FED;
        Tue,  7 Nov 2023 03:15:46 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 0E9BC5C023F;
        Tue,  7 Nov 2023 06:15:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 07 Nov 2023 06:15:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1699355746; x=1699442146; bh=40sUdJj73bfBxLsZPe0Q+r0SogTHEc7qeg3
        Eq8ciTbw=; b=0iQPVbQ8mrxnoOxPg+RCSLetUnI4nXjDZjur8d0W9AebnFQ87UF
        PLK0QUPhQh5Iod39xjUAn2R4SZ9Ubnevttvd2Nce3yDiSx/RG+elzQvIFoClPM42
        TsdG5PmrRq65FpvmUK8VKzsOhY15L6fV2UFZL68CQUQKCH3yKk5mA90NLrVh3It1
        d4JAKsbtuNir779mYDDIWQ/ZbV4sa2q0XrzvSgd5G3zAnHWvQYNAdfKMWtVB+DqT
        qxWbb/bQVGFteOHoFnws9kuQo6WYYq5e8YfKPk2yyoZY+k3Jz4+UxodupIzBKFkF
        evyDa15XrpJWtSn+74Bsj37+LETS7seejKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1699355746; x=1699442146; bh=40sUdJj73bfBxLsZPe0Q+r0SogTHEc7qeg3
        Eq8ciTbw=; b=q9RxcSs/VxR/qMsDV4mTzHR9oq0hKPhQN4AMhf3kZY8qN6mjORu
        CWiWPm9Y5Dah7Wx81eI1OJwLNxYLz+2H1bafkIH0Gh/dlR1hsptTxKKOxwlMANKV
        9P4HPl7+pm7tBq/5soXrl0jDKN3mWfFNHdsqZw9Yc5ozmto/YdL0G6fMREAMFPob
        whRnqvSfW9kkU4EINxhxWNDqNS7iSXNUM2s0+UWTuOj/kx+AyWnBsznFNoNyVwok
        TBOCxV6q3vYu63JqdAzs5NlBVcIy9HkD1q9rUi33Ch+xWGqaZwQeDz7ugM1+Z/k7
        7SPaMA45wgs0I0YHgMCEYh+d7teFLdUQazg==
X-ME-Sender: <xms:YRxKZcz61pHK_Zg5votfntEXGK8vLg_VvZIkLw3jjOLpbaX6NsdKVw>
    <xme:YRxKZQQt4qFbAhAJ9bEVihuF0_KsDdY9vSCdH3RS6b3WEvKAJysAR_MOLTVvXUV8v
    r5gs8L9RZj_qy8WYvM>
X-ME-Received: <xmr:YRxKZeUazxDjPQ0u9C92z3WhNwJ5Eg4-8BaiPRjHf7IWry7cU5IsZMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudduiedgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpeflihgr
    gihunhcujggrnhhguceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqne
    cuggftrfgrthhtvghrnhepvdekiefhfeevkeeuveetfeelffekgedugefhtdduudeghfeu
    veegffegudekjeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:YRxKZaidV-CDWoRWpj2KxDLJIyioHgZbajomr66Q8BQ-ZaepW5GshQ>
    <xmx:YRxKZeDUFoCqetVplBewiDS_jt6xbw0Y5RqMjBoSdp4yjjcVxMp8GA>
    <xmx:YRxKZbJ_YAzeirm-9MrDhnljXANTV76LnFJ9k8kzSLjJHZuLZHUmTA>
    <xmx:YhxKZV4eNVdziG9SHkEUO3dypszjYd5XEgLeWnKUEc4cOG9N012W0g>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 Nov 2023 06:15:44 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Date:   Tue, 07 Nov 2023 11:15:18 +0000
Subject: [PATCH fixes v2 1/3] MIPS: Loongson64: Reserve vgabios memory on
 boot
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231107-loongson64_fixes-v2-1-5c49ceed7950@flygoat.com>
References: <20231107-loongson64_fixes-v2-0-5c49ceed7950@flygoat.com>
In-Reply-To: <20231107-loongson64_fixes-v2-0-5c49ceed7950@flygoat.com>
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
v2:
	- Fix typo in commit message (Sergey)
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

