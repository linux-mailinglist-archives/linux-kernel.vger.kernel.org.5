Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988F0763DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 19:42:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjGZRmF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 13:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjGZRmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:42:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56292685
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 10:42:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 690E561C0A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 17:42:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DC8C433C7;
        Wed, 26 Jul 2023 17:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690393321;
        bh=RjbahgfYdYfP9M0jz3QU7VVuCNTGt2mp4JwSqCgXXRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ouY6VDnGf9dajj2sdjAkhLvZjqW5N1Y3zgUaCyGcY/YxkW42toVnmaoC52mvBfLVW
         2Pd/oCvJPFpOn8co/x0eFGsgLtnP50fcs5pfH71IqkW0LtCm/zzmgEYdBTa/qcjYIM
         JXxjZyVocmTsUGTNzTH1SaceWtAElLPJvk/m+yZ1+hfzj/fXXI5HAy/yHJ4a3nR+ky
         1dNzuZ+/0dPDtdBTLz5Rzmz9TTCX18TMqbb8H14swnC9Ls0UnH5Qg30hW/omftwvGj
         LW5GQBxIwgPx/Elabnok1W/h5NzV2k0JzWDC4v8C8q14jaJCZ490JxVIJ9ZpAsgTl2
         iE1Y2xKZI5ILg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] riscv: vdso.lds.S: drop __alt_start and __alt_end symbols
Date:   Thu, 27 Jul 2023 01:30:22 +0800
Message-Id: <20230726173024.3684-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230726173024.3684-1-jszhang@kernel.org>
References: <20230726173024.3684-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These two symbols are not used, remove them.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/kernel/vdso/vdso.lds.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/riscv/kernel/vdso/vdso.lds.S b/arch/riscv/kernel/vdso/vdso.lds.S
index 82ce64900f3d..d43fd7c7dd11 100644
--- a/arch/riscv/kernel/vdso/vdso.lds.S
+++ b/arch/riscv/kernel/vdso/vdso.lds.S
@@ -42,9 +42,7 @@ SECTIONS
 
 	. = ALIGN(4);
 	.alternative : {
-		__alt_start = .;
 		*(.alternative)
-		__alt_end = .;
 	}
 
 	.data		: {
-- 
2.40.1

