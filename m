Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C19D75939D
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 13:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjGSLAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 07:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjGSLAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 07:00:52 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303CE186
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 04:00:49 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R5Xsz2KFVzBRDrW
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 19:00:39 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689764439; x=1692356440; bh=QBL7hyJ4zfeX5L8G+qvS4vfiCIR
        +etA4h9MhqkiPafw=; b=cHkDZWKpj4O7hOcJUNXKDhgiHxpez9VN9wxV6UKtruD
        PrFQ785WBUxBQhGZH3rAb+CskrK5p6aeqNWPCw36fVU/BqpfxELq99i+4/FL3rXe
        6LiDLI5/ji7x3udFOa18r3UAcUNaQNVGM13hTCjikxOCLHGGCahhcxsDv1ba6cIH
        GWkHihL2Xk4aGYJ+wqLXm4Tmr7918rM7kEyjqRFyxA4RSCCnI/A9mJRQHOongOaN
        3wWZoXAnok5HD/jt1uNHr5tzwrsmlCd6LtJ22WZula0r/2/93sO0mSjF/clQ+5aL
        1A2d9avX+8JHYE3/8m/UeGqpe4MJ4S3xw3CTheUMPkg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KZZ5if7iaNbK for <linux-kernel@vger.kernel.org>;
        Wed, 19 Jul 2023 19:00:39 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R5Xsz06wgzBR5CB;
        Wed, 19 Jul 2023 19:00:38 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 19 Jul 2023 19:00:38 +0800
From:   huzhi001@208suo.com
To:     trond.myklebust@hammerspace.com, anna@kernel.org
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] filemap: Fix errors in file.c
In-Reply-To: <tencent_405AD96A973A6206087B37AD8032389BA807@qq.com>
References: <tencent_405AD96A973A6206087B37AD8032389BA807@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <0918d0a7d468ab484d075593c35470ad@208suo.com>
X-Sender: huzhi001@208suo.com
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

The following checkpatch errors are removed:
ERROR: "foo * bar" should be "foo *bar"
"foo * bar" should be "foo *bar"

Signed-off-by: ZhiHu <huzhi001@208suo.com>
---
  fs/nfs/file.c | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index 79b1b3fcd3fc..3f9768810427 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -200,7 +200,7 @@ nfs_file_splice_read(struct file *in, loff_t *ppos, 
struct pipe_inode_info *pipe
  EXPORT_SYMBOL_GPL(nfs_file_splice_read);

  int
-nfs_file_mmap(struct file * file, struct vm_area_struct * vma)
+nfs_file_mmap(struct file *file, struct vm_area_struct *vma)
  {
      struct inode *inode = file_inode(file);
      int    status;
