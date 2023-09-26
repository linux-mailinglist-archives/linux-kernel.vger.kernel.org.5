Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18EB7AE2FC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 02:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231617AbjIZAf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 20:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbjIZAf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 20:35:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42AB711D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 17:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=0J8nTsTynSvtRpFuXVxSLl94WdD3f0MuLFh/eUmRVV0=; b=DlB5Q353F68F2fmcQ8R+0Ju7fA
        pt6pqnxYC2NjEgW3x5HCNlTVlhKXSta//DowPWwqlt0y0x30Uu3hX7ovZpwXYwRQcn+EE+t3rs9ZB
        pobZ5lho8uQqIZS8OjodGVwCGSwzwuILddPlZ8hHbZZ3LmGa6J7/dXd+q1PR4PVI7ISEQt57twQOV
        NAf0BdaAKEo1dmPwuHfkDfQk5wvhzrx2xF6kIWr/N0siAfywwUA/NhOooGnUsxXMD/zJtbZcZyuRK
        c38lXaiq9f8XeE4kvbEbKc+QVLE7cSFMSxYMZC2ykywL7jAHT+bmRbgRlYKFpTdsavrMnOEHrhzZp
        xX1ymeXQ==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qkw3J-00FIWV-1I;
        Tue, 26 Sep 2023 00:35:49 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        soc@kernel.org, linux-arm-kernel@lists.infradead.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH] ARM: uniphier: fix cache kernel-doc warnings
Date:   Mon, 25 Sep 2023 17:35:48 -0700
Message-ID: <20230926003548.22066-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix kernel-doc warning(s) as reported by lkp:

arch/arm/mm/cache-uniphier.c:72: warning: cannot understand function prototype: 'struct uniphier_cache_data '
cache-uniphier.c:82: warning: Function parameter or member 'way_ctrl_base' not described in 'uniphier_cache_data'

Fixes: e7ecbc057bc5 ("ARM: uniphier: add outer cache support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: lore.kernel.org/r/202309260130.Uvwh8ceE-lkp@intel.com # fixes only one item
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: soc@kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/arm/mm/cache-uniphier.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff -- a/arch/arm/mm/cache-uniphier.c b/arch/arm/mm/cache-uniphier.c
--- a/arch/arm/mm/cache-uniphier.c
+++ b/arch/arm/mm/cache-uniphier.c
@@ -58,11 +58,13 @@
 		((op & UNIPHIER_SSCOQM_S_MASK) == UNIPHIER_SSCOQM_S_RANGE)
 
 /**
- * uniphier_cache_data - UniPhier outer cache specific data
+ * struct uniphier_cache_data - UniPhier outer cache specific data
  *
  * @ctrl_base: virtual base address of control registers
  * @rev_base: virtual base address of revision registers
  * @op_base: virtual base address of operation registers
+ * @way_ctrl_base: virtual address of the way control registers for this
+ *	SoC revision
  * @way_mask: each bit specifies if the way is present
  * @nsets: number of associativity sets
  * @line_size: line size in bytes
