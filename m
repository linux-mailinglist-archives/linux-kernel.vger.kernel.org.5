Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D65617632D9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 11:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232465AbjGZJvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 05:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233408AbjGZJvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 05:51:20 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933392D5B;
        Wed, 26 Jul 2023 02:51:00 -0700 (PDT)
Received: from dggpemm500016.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R9pzK5lMFz1GDFC;
        Wed, 26 Jul 2023 17:50:05 +0800 (CST)
Received: from huawei.com (10.67.174.205) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 17:50:58 +0800
From:   Chen Jiahao <chenjiahao16@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <kexec@lists.infradead.org>, <linux-doc@vger.kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <conor.dooley@microchip.com>, <guoren@kernel.org>,
        <heiko@sntech.de>, <bjorn@rivosinc.com>, <alex@ghiti.fr>,
        <akpm@linux-foundation.org>, <atishp@rivosinc.com>,
        <bhe@redhat.com>, <thunder.leizhen@huawei.com>, <horms@kernel.org>
CC:     <chenjiahao16@huawei.com>
Subject: [PATCH -next v9 2/2] docs: kdump: Update the crashkernel description for riscv
Date:   Wed, 26 Jul 2023 17:50:00 +0000
Message-ID: <20230726175000.2536220-3-chenjiahao16@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726175000.2536220-1-chenjiahao16@huawei.com>
References: <20230726175000.2536220-1-chenjiahao16@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.205]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now "crashkernel=" parameter on riscv has been updated to support
crashkernel=X,[high,low]. Through which we can reserve memory region
above/within 32bit addressible DMA zone.

Here update the parameter description accordingly.

Signed-off-by: Chen Jiahao <chenjiahao16@huawei.com>
Reviewed-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a1457995fd41..bd519749968f 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -862,7 +862,7 @@
 			memory region [offset, offset + size] for that kernel
 			image. If '@offset' is omitted, then a suitable offset
 			is selected automatically.
-			[KNL, X86-64, ARM64] Select a region under 4G first, and
+			[KNL, X86-64, ARM64, RISCV] Select a region under 4G first, and
 			fall back to reserve region above 4G when '@offset'
 			hasn't been specified.
 			See Documentation/admin-guide/kdump/kdump.rst for further details.
@@ -875,14 +875,14 @@
 			Documentation/admin-guide/kdump/kdump.rst for an example.
 
 	crashkernel=size[KMG],high
-			[KNL, X86-64, ARM64] range could be above 4G. Allow kernel
-			to allocate physical memory region from top, so could
-			be above 4G if system have more than 4G ram installed.
-			Otherwise memory region will be allocated below 4G, if
-			available.
+			[KNL, X86-64, ARM64, RISCV] range could be above 4G.
+			Allow kernel to allocate physical memory region from top,
+			so could be above 4G if system have more than 4G ram
+			installed. Otherwise memory region will be allocated
+			below 4G, if available.
 			It will be ignored if crashkernel=X is specified.
 	crashkernel=size[KMG],low
-			[KNL, X86-64, ARM64] range under 4G. When crashkernel=X,high
+			[KNL, X86-64, ARM64, RISCV] range under 4G. When crashkernel=X,high
 			is passed, kernel could allocate physical memory region
 			above 4G, that cause second kernel crash on system
 			that require some amount of low memory, e.g. swiotlb
@@ -893,6 +893,7 @@
 			size is	platform dependent.
 			  --> x86: max(swiotlb_size_or_default() + 8MiB, 256MiB)
 			  --> arm64: 128MiB
+			  --> riscv: 128MiB
 			This one lets the user specify own low range under 4G
 			for second kernel instead.
 			0: to disable low allocation.
-- 
2.34.1

