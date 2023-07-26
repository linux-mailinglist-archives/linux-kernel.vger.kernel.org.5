Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDDE0763DE9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 19:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjGZRsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 13:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232191AbjGZRr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 13:47:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98580E7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 10:47:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35F3261C11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 17:47:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97419C433C8;
        Wed, 26 Jul 2023 17:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690393674;
        bh=kjkGVTyWfRPTlqoBKs6nR/LSEfoi7kSB3Nvb0e/M5Ko=;
        h=From:To:Cc:Subject:Date:From;
        b=K0SrQ5ulVOTTLDVP6oHJEQXxHIkFbBaUETdeBHszGFfK0+NjtSd7ofnFIEXqp4xub
         lIFsWox25y3QDPgmukdLm09UgY2wrtRkBvyDb7C538+aSHVJiMtXU//0P7XWQ0j8GJ
         rVkzk7eNVcoE6kBs4Kbv3T1HRyIsz2zY/RjFnbp8MeZ+9yBZSWA6wwlzNoKN0DcpcT
         xh4pQzrZEkHeGFhzOWeDTM8Gyt1cBStlnyi0gE9+rmXPLFRI/fDlNgQvZdPm8g+lwk
         5lpP+Q9LuB4lm9c6Ul5WqG7TW0g9pHw2lGWbJZpqzSdD46JIoEKxC3s8uCoFbOKeVj
         YdeJ86If7kgPA==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: vdso: remove two .altinstructions related symbols
Date:   Thu, 27 Jul 2023 01:36:19 +0800
Message-Id: <20230726173619.3732-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two symbols __alt_instructions and __alt_instructions_end are not
used, remove them.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/arm64/kernel/vdso/vdso.lds.S | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
index 6028f1fe2d1c..45354f2ddf70 100644
--- a/arch/arm64/kernel/vdso/vdso.lds.S
+++ b/arch/arm64/kernel/vdso/vdso.lds.S
@@ -50,9 +50,7 @@ SECTIONS
 
 	. = ALIGN(4);
 	.altinstructions : {
-		__alt_instructions = .;
 		*(.altinstructions)
-		__alt_instructions_end = .;
 	}
 
 	.dynamic	: { *(.dynamic) }		:text	:dynamic
-- 
2.40.1

