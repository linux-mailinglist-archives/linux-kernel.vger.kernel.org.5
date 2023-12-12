Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F3580E2C1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 04:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345846AbjLLDUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 22:20:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjLLDUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 22:20:52 -0500
Received: from mxct.zte.com.cn (mxct.zte.com.cn [58.251.27.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D384CD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 19:20:57 -0800 (PST)
Received: from mxde.zte.com.cn (unknown [10.35.20.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxct.zte.com.cn (FangMail) with ESMTPS id 4Sq3m368f9zW8l
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:20:51 +0800 (CST)
Received: from mxhk.zte.com.cn (unknown [192.168.250.137])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mxde.zte.com.cn (FangMail) with ESMTPS id 4Sq3lx5jZnz5yGyX
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 11:20:45 +0800 (CST)
Received: from mse-fl1.zte.com.cn (unknown [10.5.228.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxhk.zte.com.cn (FangMail) with ESMTPS id 4Sq3lq4nkdz8XrRF;
        Tue, 12 Dec 2023 11:20:39 +0800 (CST)
Received: from xaxapp03.zte.com.cn ([10.88.97.17])
        by mse-fl1.zte.com.cn with SMTP id 3BC3KXj1052334;
        Tue, 12 Dec 2023 11:20:33 +0800 (+08)
        (envelope-from yang.guang5@zte.com.cn)
Received: from mapi (xaxapp03[null])
        by mapi (Zmail) with MAPI id mid31;
        Tue, 12 Dec 2023 11:20:34 +0800 (CST)
Date:   Tue, 12 Dec 2023 11:20:34 +0800 (CST)
X-Zmail-TransId: 2afb6577d182ffffffff9f1-650fe
X-Mailer: Zmail v1.0
Message-ID: <202312121120348064534@zte.com.cn>
Mime-Version: 1.0
From:   <yang.guang5@zte.com.cn>
To:     <linux@armlinux.org.uk>
Cc:     <jiang.xuexin@zte.com.cn>, <chen.haonan2@zte.com.cn>,
        <cgel.zte@gmail.com>, <rmk+kernel@armlinux.org.uk>,
        <willy@infradead.org>, <linus.walleij@linaro.org>,
        <rppt@kernel.org>, <jroedel@suse.de>, <arnd@arndb.de>,
        <gregkh@linuxfoundation.org>, <jgg@ziepe.ca>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: =?UTF-8?B?W1BBVENIIGxpbnV4LW5leHRdIEFSTS9kbWEtbWFwcGluZzogcmVwbGFjZSBremFsbG9jKCkgYW5kIHZ6YWxsb2MoKSB3aXRoIGt2emFsbG9jKCk=?=
Content-Type: text/plain;
        charset="UTF-8"
X-MAIL: mse-fl1.zte.com.cn 3BC3KXj1052334
X-Fangmail-Gw-Spam-Type: 0
X-Fangmail-Anti-Spam-Filtered: true
X-Fangmail-MID-QID: 6577D192.001/4Sq3m368f9zW8l
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>
using kvzalloc() simplifies the code by avoiding the 
use of different memory allocation functions for different 
situations, making the code more uniform and readable.

Signed-off-by: Chen Haonan <chen.haonan2@zte.com.cn>
---
 arch/arm/mm/dma-mapping.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
index 5409225b4abc..d688eac6dbc1 100644
--- a/arch/arm/mm/dma-mapping.c
+++ b/arch/arm/mm/dma-mapping.c
@@ -859,10 +859,7 @@ static struct page **__iommu_alloc_buffer(struct device *dev, size_t size,
 	int i = 0;
 	int order_idx = 0;

-	if (array_size <= PAGE_SIZE)
-		pages = kzalloc(array_size, GFP_KERNEL);
-	else
-		pages = vzalloc(array_size);
+	pages = kvzalloc(array_size, GFP_KERNEL);
 	if (!pages)
 		return NULL;

-- 
2.25.1
