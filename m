Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C63E755F23
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjGQJWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjGQJWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:22:47 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D186A10F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:22:43 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R4Gnr0y1QzBHXhg
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 17:22:40 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689585760; x=1692177761; bh=r52AuiwO6w9aLbUyDgtZmjP53bO
        eVyomaOlCYxlVI/Y=; b=mPfQmvJlN+mG8PuHh8PlBTIyzFOMTs1uwcjZa5gL/zG
        eWLr0I8DCraXLeEJ/K63JbcTVmoo38kXzYMlHu66368mOt3jWjeM9Qo2K1mGqEUZ
        y5iwcbBSXeVCXrod5E72UvqU/o1+nCzbAx4pwqET574WFYm7+fBIbtQ7aV8a4N/W
        jBkwv3UL8UPIfdWo4yYM4kWTHSbU2WwqDMbZRvURziNo30oHPva0L3X00GwN+C7Q
        qi9zZp2S6hH53WZ/FUa6mCEqups/tqpxVeKHpE0ZUKIGElwbwyoO13oKP9ui3yAM
        /yQGOKV/nLpX5m4+NTYGr1cuCAwarVM0FN39LAamb+Q==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8DOL3asa6b8x for <linux-kernel@vger.kernel.org>;
        Mon, 17 Jul 2023 17:22:40 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R4Gnq5Gv4zBHXhJ;
        Mon, 17 Jul 2023 17:22:39 +0800 (CST)
MIME-Version: 1.0
Date:   Mon, 17 Jul 2023 17:22:39 +0800
From:   hanyu001@208suo.com
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        maninder1.s@samsung.com, nathanl@linux.ibm.com,
        gustavoars@kernel.org
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: xmon: Remove space after '(' and before ')'
In-Reply-To: <tencent_C47ED53495F8E338441AB48CB53AE7AF0208@qq.com>
References: <tencent_C47ED53495F8E338441AB48CB53AE7AF0208@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <f9ba0bd1bc611c999fdd68b53b0d913d@208suo.com>
X-Sender: hanyu001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch fixes the following errors detected by checkpatch:

./arch/powerpc/xmon/xmon.c:2426: ERROR: space prohibited after that open 
parenthesis '('
./arch/powerpc/xmon/xmon.c:2426: ERROR: space prohibited before that 
close parenthesis ')'
./arch/powerpc/xmon/xmon.c:2426: ERROR: space required before the open 
parenthesis '('

Signed-off-by: ztt <1549089851@qq.com>
---
  arch/powerpc/xmon/xmon.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 013b63eb4cd9..c10d9ff02af1 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1057,7 +1057,7 @@ cmds(struct pt_regs *excp)
          flush_input();
          termch = 0;
          cmd = skipbl();
-        if(cmd == '\n' ) {
+        if (cmd == '\n') {
              if (last_cmd == NULL)
                  continue;
              take_input(last_cmd);
@@ -2423,7 +2423,7 @@ memex(void)
      }
      last_cmd = "m\n";
      while ((cmd = skipbl()) != '\n') {
-        switch( cmd ){
+        switch (cmd) {
          case 'b':    size = 1;    break;
          case 'w':    size = 2;    break;
          case 'l':    size = 4;    break;
