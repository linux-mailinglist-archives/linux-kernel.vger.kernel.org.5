Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD82C7DE357
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 16:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232555AbjKAPFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 11:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232519AbjKAPE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 11:04:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDBA5DC;
        Wed,  1 Nov 2023 08:04:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BD3FC433CA;
        Wed,  1 Nov 2023 15:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698851095;
        bh=wPhcCh2R5mo1LuWpZ6AE/5k4PZ89Ug41tO+Ww2sWSJY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RLJfP929G898YCZnm8fG0Z8UEYoSCW5ezQCzlUFOsxV4VOgx0C7slWecL3/MlxVqa
         SO64HtipVGBgdtqlfCQzHmxvTZlJZVjsbP/pVy6on0YT6I+hR50kgjnENgg32JEft3
         EyQp93H4paPi7/HFZZJvJkwovU6LXOlDR26keTd9cCXTp4xgpJ0/+3GkvlRVXeogWR
         AtayS6mMN2cLcd3xCVPBNuLOhV7NVCj3TqqVysDMK2v6eF9fGSgU85BrNDOwZZnlaW
         M5SRDbd/jv2W8sPs0lxt1FH4p6EjkGKgYiYWxcuK9bxyr2zv+wfeRT++/9RDZK2baW
         QpC9MhPte6TbA==
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Greg Ungerer <gerg@kernel.org>,
        Jack Brennen <jbrennen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [PATCH 2/7] modpost: add const qualifier to syminfo table
Date:   Thu,  2 Nov 2023 00:03:59 +0900
Message-Id: <20231101150404.754108-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231101150404.754108-1-masahiroy@kernel.org>
References: <20231101150404.754108-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

symsearch_find_nearest() does not modify the table.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/symsearch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/mod/symsearch.c b/scripts/mod/symsearch.c
index aa4ed51f9960..00f0f9c354db 100644
--- a/scripts/mod/symsearch.c
+++ b/scripts/mod/symsearch.c
@@ -156,7 +156,7 @@ Elf_Sym *symsearch_find_nearest(struct elf_info *elf, Elf_Addr addr,
 {
 	unsigned int hi = elf->symsearch->table_size;
 	unsigned int lo = 0;
-	struct syminfo *table = elf->symsearch->table;
+	const struct syminfo *table = elf->symsearch->table;
 	struct syminfo target;
 
 	target.addr = addr;
-- 
2.40.1

