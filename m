Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F9D7D77FD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 00:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjJYWb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 18:31:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjJYWbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 18:31:25 -0400
Received: from nautica.notk.org (ipv6.notk.org [IPv6:2001:41d0:1:7a93::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C22184
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 15:31:22 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 462F7C01C; Thu, 26 Oct 2023 00:31:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1698273081; bh=s0T4j+oFkJAnGVqQY6I6/eKO/edOXtDsKiM/6aI97S8=;
        h=From:To:Cc:Subject:Date:From;
        b=XxJ3AoCGAHfrjc+6Mnl5RGtPO76ic3hB6bpWyMM+t1YjD4dFBq2CWCy1dfNmIsqpJ
         uLCPR1yDlEdb5D1940/5He/SrrXPtcoXvIWdbA3tVqqavLRaqhny2XwHRKaRGtcG+a
         Kqq2lNt7PR4kP4wBXytJhdjA3TFst3LuHZiHo2WV6Yae4c8r2ZNuh3xJU9w5prKIq6
         HQ3ANEoooDb0MMGERP9mip3lLTCGmt24oWRwkYcSH8zK5c2X7vjlnSyu8xINHX/UeX
         Y/tzv/K7RmTqwJJmno+Z8nvsqElKvySTAAvAwRStNQkoIPPAXZNnpWYgJgXQAf8z+P
         yG0qFoTIo6GSw==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Received: from gaia (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 4CB2FC01C;
        Thu, 26 Oct 2023 00:31:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1698273079; bh=s0T4j+oFkJAnGVqQY6I6/eKO/edOXtDsKiM/6aI97S8=;
        h=From:To:Cc:Subject:Date:From;
        b=R+Mzl8WbtJ0nfZ/XHARYfwXiFd3Ys+O7yzFMZV1gZuR+LRKXyh6ODyPsv0Vcc616j
         h3bw9GX9cDN3PDXWQzx2GE2dWcHmJ0B/y69Z77n1rAkwyIrdYykhFwP1TMh9Ob9MxK
         xbaqKPVP0oZtU79IdCw3b7k4joVAEnmL7+V/TFDbCNgV0mYMQl660Y3DzQlJXhh69c
         90nLxLlmjmUu7NdQMeLtgnK94Yfq6u2Rd2u1Jo0HJ43yd4h0ctSyXfGJP9+bDa5COm
         wVl1HKQNrFvbUbM1GHh8knGqk/qUeKzdAhooraUPRd49KwOATIYcRRiWh0/TRqqhSk
         W5zDqQ5lwBnhQ==
Received: from gaia.codewreck.org (localhost.lan [::1])
        by gaia (OpenSMTPD) with ESMTP id cdd0c0cd;
        Wed, 25 Oct 2023 22:31:13 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     v9fs@lists.linux.dev
Cc:     ericvh@kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net,
        linux-kernel@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH] 9p/fs: add MODULE_DESCIPTION
Date:   Thu, 26 Oct 2023 07:31:07 +0900
Message-ID: <20231025223107.1274963-1-asmadeus@codewreck.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix modpost warning that MODULE_DESCRIPTION is missing in fs/9p/9p.o

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
Probably doesn't really matter after all this time, but noticed this
when double-checking there weren't any warnings left in W=1... Might as
well get rid of this:
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/9p/9p.o

 fs/9p/v9fs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index d525957594b6..61dbe52bb3a3 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -732,4 +732,5 @@ module_exit(exit_v9fs)
 MODULE_AUTHOR("Latchesar Ionkov <lucho@ionkov.net>");
 MODULE_AUTHOR("Eric Van Hensbergen <ericvh@gmail.com>");
 MODULE_AUTHOR("Ron Minnich <rminnich@lanl.gov>");
+MODULE_DESCRIPTION("9P Client File System");
 MODULE_LICENSE("GPL");
-- 
2.41.0

