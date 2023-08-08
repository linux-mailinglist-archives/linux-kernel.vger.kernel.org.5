Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C91774BF9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbjHHVBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234589AbjHHVBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:01:30 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FC961B6;
        Tue,  8 Aug 2023 14:00:54 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id E6946734;
        Tue,  8 Aug 2023 21:00:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net E6946734
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1691528453; bh=4qu8DsXzJEWOLf19QHJhbRU0BX8VweH67rlHSUdngy4=;
        h=From:To:Cc:Subject:Date:From;
        b=qWQRZcnXARK7vKJq0hckl7/qctvnNRDtj5Vuo2plijP/oO1fJar9sxFJpsgzYrNw8
         ZKhQ9eylUYp4O+x9io7rUec8LV7rjswGY/xsXUz4dVe7z+RSfBFAv+J4pePoqY6f7c
         61lmIyWKdlZPjH3YGEvJsUSgXxefmvgETPnxxgoCvJV6fLWJCSG9XfbieY96yzTD/A
         MK33IDRb7nLKy8ZPq0XAIgrGRnQuYrEFixtQ+jtK7K0guOO7AfGNyAs1DgB0Q3xxNj
         uy80GQWtQiFUT57HVARx4S+63h+omQPhNwFzoMLOZrJbsh4P/MhK2TMZnV7kC+GdIB
         5mlh3x6EVmtZQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH] docs: vfs: clean up after the iterate() removal
Date:   Tue, 08 Aug 2023 15:00:52 -0600
Message-ID: <874jl945bv.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3e3271549670 ("vfs: get rid of old '->iterate' directory operation")
removed the iterate() file_operations member, but neglected to clean up the
associated documentation.  Get rid of the leftovers.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
If nobody objects (or beats me to it) I'll drop this into docs-next
shortly.

 Documentation/filesystems/locking.rst | 1 -
 Documentation/filesystems/vfs.rst     | 7 +------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index 0ca479dbb1cd..aeed0a5a80eb 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -509,7 +509,6 @@ prototypes::
 	ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
 	ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
 	int (*iopoll) (struct kiocb *kiocb, bool spin);
-	int (*iterate) (struct file *, struct dir_context *);
 	int (*iterate_shared) (struct file *, struct dir_context *);
 	__poll_t (*poll) (struct file *, struct poll_table_struct *);
 	long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index cb2a97e49872..a751f6d01eb2 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -1074,7 +1074,6 @@ This describes how the VFS can manipulate an open file.  As of kernel
 		ssize_t (*read_iter) (struct kiocb *, struct iov_iter *);
 		ssize_t (*write_iter) (struct kiocb *, struct iov_iter *);
 		int (*iopoll)(struct kiocb *kiocb, bool spin);
-		int (*iterate) (struct file *, struct dir_context *);
 		int (*iterate_shared) (struct file *, struct dir_context *);
 		__poll_t (*poll) (struct file *, struct poll_table_struct *);
 		long (*unlocked_ioctl) (struct file *, unsigned int, unsigned long);
@@ -1126,12 +1125,8 @@ otherwise noted.
 ``iopoll``
 	called when aio wants to poll for completions on HIPRI iocbs
 
-``iterate``
-	called when the VFS needs to read the directory contents
-
 ``iterate_shared``
-	called when the VFS needs to read the directory contents when
-	filesystem supports concurrent dir iterators
+	called when the VFS needs to read the directory contents
 
 ``poll``
 	called by the VFS when a process wants to check if there is
-- 
2.41.0

