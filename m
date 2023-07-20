Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E7575B2DB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 17:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbjGTPfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 11:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232663AbjGTPfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 11:35:01 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DAA7271C
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 08:34:57 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R6Gvw5RVRzBRDsw
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 23:34:52 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689867292; x=1692459293; bh=7SRXP5aYC5VI5N72WCnMWkFIrQ6
        QJUDaQRwdLx6Vavo=; b=aZUkoxiqGI5Qcy7iC208+/iBwtp9x6T/73TvPz2QnFP
        yIptaH6G9g9jrBm0WSIP9n65VxJzZGdjW0HWYemJ6okg5uV9TL28RISqgGEiUWqu
        l4DW00VD1ca4Qn89o4qgnTs6fGpSTAlqapx1mb++FFoU29f8WmKtw7wPZVg1GTdV
        bs7CCjzTgut54VnjFaIj7I9D74jnH63lC2+hlCF9IWs39LSqj8HSV9V1Cae6BhVD
        I9EXwPFZg9rsiF+Mix0+VqEZ/l88p5h/QcfcDrgOG+YMhio/Gnq4V92kwNnHibiP
        5KgA4qFIjsySvW6FzvUJpPqVuJLfvr/hVxiYPhzFKhw==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 0oJLnVvvbO6D for <linux-kernel@vger.kernel.org>;
        Thu, 20 Jul 2023 23:34:52 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R6Gvw3YG8zBHXgs;
        Thu, 20 Jul 2023 23:34:52 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 20 Jul 2023 23:34:52 +0800
From:   pangzizhen001@208suo.com
To:     terrelln@fb.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] zstd/decompress: Fix typos in comments
In-Reply-To: <20230720153251.41120-1-wangjianli@cdjrlc.com>
References: <20230720153251.41120-1-wangjianli@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <5704cc1d71fe90348a9e845c80fae7fe@208suo.com>
X-Sender: pangzizhen001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Delete duplicate word "the"

Signed-off-by: Zizhen Pang <pangzizhen001@208suo.com>
---
  lib/zstd/decompress/zstd_decompress_block.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/zstd/decompress/zstd_decompress_block.c 
b/lib/zstd/decompress/zstd_decompress_block.c
index c1913b8e7c89..cd2e9acecd84 100644
--- a/lib/zstd/decompress/zstd_decompress_block.c
+++ b/lib/zstd/decompress/zstd_decompress_block.c
@@ -510,7 +510,7 @@ void ZSTD_buildFSETable_body(ZSTD_seqSymbol* dt,
              }
          }
          /* Now we spread those positions across the table.
-         * The benefit of doing it in two stages is that we avoid the 
the
+         * The benefit of doing it in two stages is that we avoid the
           * variable size inner loop, which caused lots of branch 
misses.
           * Now we can run through all the positions without any branch 
misses.
           * We unroll the loop twice, since that is what emperically 
worked best.
