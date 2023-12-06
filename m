Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65C528068BB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376915AbjLFHiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjLFHiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:38:21 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF791BDB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 23:37:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2524FC433D9;
        Wed,  6 Dec 2023 07:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701848270;
        bh=1ogJNRCRUSjNVsxhxIxRKhd/3MM0E+QpvFM4Un0/0KI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YYRRTJ2Ex+COXZInEvSuWRBkCj4G2MDfBBEm10lA/6YWME/zUfsKGjeiIcbMF7H7S
         VLRXViRHFcM99MJo4maY01ypfdfSRY6mo6b3CKNQ4x2lmjDZYoRVbLGkXL0rz/jBuj
         FwqHudifLvhhqB2Zk2yQ1EOEnoezkMg31Z8DvnYSAlfUzN1ulFLoXtSbVyp6m7wb8M
         DMJmKjDVFHeRJ7KCAeMMskuXzDs/OKe0aKoT5RFN2aQq14xId7E8M/zJGKEyFkpv51
         KIUWiCmI3f2ODm5M2WtjKWEpU4mPQF0ZVCV24Q4raYZuGK4Oo5eScD7UV6qeaesYk8
         QbF1R2OmgsiQA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org
Subject: [PATCH 14/27] tty: m68k: nfcon: convert to u8 and size_t
Date:   Wed,  6 Dec 2023 08:36:59 +0100
Message-ID: <20231206073712.17776-15-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206073712.17776-1-jirislaby@kernel.org>
References: <20231206073712.17776-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch character types to u8 and sizes to size_t. To conform to
characters/sizes in the rest of the tty layer.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org
---
 arch/m68k/emu/nfcon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/emu/nfcon.c b/arch/m68k/emu/nfcon.c
index 3a74d493eb3e..17b2987c2bf5 100644
--- a/arch/m68k/emu/nfcon.c
+++ b/arch/m68k/emu/nfcon.c
@@ -23,9 +23,9 @@ static int stderr_id;
 static struct tty_port nfcon_tty_port;
 static struct tty_driver *nfcon_tty_driver;
 
-static void nfputs(const char *str, unsigned int count)
+static void nfputs(const u8 *str, size_t count)
 {
-	char buf[68];
+	u8 buf[68];
 	unsigned long phys = virt_to_phys(buf);
 
 	buf[64] = 0;
-- 
2.43.0

