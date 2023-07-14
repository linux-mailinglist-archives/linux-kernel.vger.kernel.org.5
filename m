Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61159753159
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 07:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234567AbjGNFhb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 01:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233638AbjGNFh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 01:37:29 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B5C2738
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 22:37:26 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R2KxH5cp1zBR9sN
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 13:37:23 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689313043; x=1691905044; bh=8BNA5nZF9onPgOovnxahcOKlTIQ
        u2zsyuHGyYIxstW8=; b=PRbyWFPip4xtVRJBxFYm4+QckfVQSA38NjNC01+WYzQ
        FtKDrVu2Nf8BsZCABcoJ1AuqNdxf/Xcsdy8qZDRe7oaFR9p7pzTpSi0KbK1rgpOW
        PK6eYTbGD5zdvnkCs5474PUWMcAwSuaq7CHBcUwuYCj1z8cWVS9T3MQSU4PKIPYN
        enJfNAljYodSDLsmZgSLk3UwMwSFQuBaJXYL52ju7qMNkW5cbvQAUqwhKXStTuGi
        HtkZ0pXPcIZnENwnOVVg7pJb9ckIS2aFTbq+6cTNLyKsj6mzGjK+DcSLBLXNrBFh
        XkzL0SAvWz6WkXYu7M1uDdA4pHbqZgFAHIMVjkrMhdQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 1llbn-__IcmC for <linux-kernel@vger.kernel.org>;
        Fri, 14 Jul 2023 13:37:23 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R2KxH3Lr1zBR5C9;
        Fri, 14 Jul 2023 13:37:23 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 14 Jul 2023 13:37:23 +0800
From:   chenqingyun001@208suo.com
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: extable:"(foo*)" should be "(foo *)"
In-Reply-To: <tencent_1DFBBBDD0C944F003E04996E11065CA32906@qq.com>
References: <tencent_1DFBBBDD0C944F003E04996E11065CA32906@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <74dd71ee7fa975cec2927d291936207b@208suo.com>
X-Sender: chenqingyun001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The variable name of the needle type is preceded
by parentheses without a space between the
parentheses and the asterisk. This will make
the code look unclear, and may conflict with
some tools or compilers.

Signed-off-by: Qingyun Chen <chenqingyun001@208suo.com>
---
  arch/arm64/mm/extable.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
index 228d681a8715..c89a52870ca9 100644
--- a/arch/arm64/mm/extable.c
+++ b/arch/arm64/mm/extable.c
@@ -42,7 +42,7 @@ ex_handler_load_unaligned_zeropad(const struct 
exception_table_entry *ex,
      offset = addr & 0x7UL;
      addr &= ~0x7UL;

-    data = *(unsigned long*)addr;
+    data = *(unsigned long *)addr;

  #ifndef __AARCH64EB__
      data >>= 8 * offset;
