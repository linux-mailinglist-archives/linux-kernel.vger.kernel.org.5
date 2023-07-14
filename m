Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E12753A12
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 13:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235530AbjGNLsP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 07:48:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235475AbjGNLsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 07:48:13 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F123F2D57
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 04:48:08 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id CBDA332002B6;
        Fri, 14 Jul 2023 07:48:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 14 Jul 2023 07:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=readahead.eu; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1689335287; x=1689421687; bh=yjrGorBcxd
        mN9zPQ+gXJSWbPe5NwWIXRuS95KLHLqkI=; b=TbxIyM7zY/2d2yDY6FWP9qaVli
        TimLZ7MKOf4FQf9BjTTGjz0BZTg4hOrDCSEhfLuk46D86APv4lgh54WHayPcTRQ6
        sc38HX064iRc8aTYfc598rWYdXLtABrHNFkI4osl1nsGpN1LRkKtZB4/LwtUrae/
        xPgkhqIw7KLz3Ki1OKM7+tWZyrPGXwRqsn/weN7YkxlvNa8hAAH/tEh3ovhNNMLR
        DY2x67OiP9MOAmLPWkJyEGTuDw/R2SfduqZvQeQGQ4x1x3fox6KPfiWkSsEEwFQ3
        PTRnPxedcvIv4Vyuo0q9LUjJVqZ3HyS3VMZeCyqY34P1+eS9dc5bkfDzxKUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1689335287; x=1689421687; bh=yjrGorBcxdmN9
        zPQ+gXJSWbPe5NwWIXRuS95KLHLqkI=; b=zfcVR6ORYr6RhrWqOg0W6ifmQ410H
        w4GdIymci+0oOU4P0bIaL5P9pn1Lz/DNLEwO3wxIu6o/PVm7x3MGpQM5ZeZ02o76
        OP9MLPe0ue0AEgzVKswL52Nb1pbYUqZvxRk92zyX/ebrgsNG9Va9YTTMljFqZBt4
        s7Qpfnvk7k0+siy2jqkQbJ7HVac95I2Oy7ZXGnYI/UGNUnQm1BJNbckD2SQAy2zI
        13sf5etAZIWeh+gjyYSbXWacCdgb7OIsfMkvig3VQGSMCbkMd+s4aGpnxmCDYIgD
        35PE8T3kCPV68wjoAg3Rj4KealiF+EIOnJhTOdxcbbZIVFnHDoUfKhjog==
X-ME-Sender: <xms:9zWxZCbw5XEW1SsqMxzfSHwXDX8PDay0ojGbEEzuKjBOWQSDWj6w1g>
    <xme:9zWxZFaAp7NMKD50eKN23-aB6cWOq7tnSpdbeFSWLHm93nztT7u4pWCQLtJnMHbRd
    3NPjCaGuyuw3iQVa8k>
X-ME-Received: <xmr:9zWxZM9AR9YoOWegYkvG15z3Qjh55WLT_ooO4xmenNYeLERWrkFW76hYwXvimjwtgiPRcoRbnu2CZezCZIVpIB7VZF9_ypZIztaT-e2AgFj15o-YQ4Ks>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeeigdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeffrghvihguucft
    hhgvihhnshgsvghrghcuoegurghvihgusehrvggruggrhhgvrggurdgvuheqnecuggftrf
    grthhtvghrnhepkeeivdeggeehleeltedujeejhedvfedvieeiiedvteevvdejhefgkeet
    gffggeevnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomh
    epuggrvhhiugesrhgvrggurghhvggrugdrvghu
X-ME-Proxy: <xmx:9zWxZEr-R8ZyTpl7J4YdgUwm7uZCD9xHVu4LWp0X4hf_1E5RxuGtwQ>
    <xmx:9zWxZNqFme-Tst0qLXsZcbg4Rlz55OId3LZYAj0q_YKgS8zVbVNfTw>
    <xmx:9zWxZCR2fuSh-DB7krh2lSOblEcRQ1Qo7oU76SO_69dXfow8Bu-KZg>
    <xmx:9zWxZOkGljUQHrq2qRiz8Rn1nqkk0wCw-HJ3ZkLFATjjZ2B55wdXzg>
Feedback-ID: id2994666:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Jul 2023 07:48:06 -0400 (EDT)
From:   David Rheinsberg <david@readahead.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jeff Xu <jeffxu@google.com>, Kees Cook <keescook@chromium.org>,
        Daniel Verkamp <dverkamp@chromium.org>,
        David Rheinsberg <david@readahead.eu>
Subject: [PATCH] memfd: support MFD_NOEXEC alongside MFD_EXEC
Date:   Fri, 14 Jul 2023 13:47:53 +0200
Message-ID: <20230714114753.170814-1-david@readahead.eu>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new flag for memfd_create() called MFD_NOEXEC, which has the
opposite effect as MFD_EXEC (i.e., it strips the executable bits from
the inode file mode).

The default mode for memfd_create() has historically been to use 0777 as
file modes. The new `MFD_EXEC` flag has now made this explicit, paving
the way to reduce the default to 0666 and thus dropping the executable
bits for security reasons. Additionally, the `MFD_NOEXEC_SEAL` flag has
been added which allows this without changing the default right now.

Unfortunately, `MFD_NOEXEC_SEAL` enforces `MFD_ALLOW_SEALING` and
`F_SEAL_EXEC`, with no alternatives available. This leads to multiple
issues:

 * Applications that do not want to allow sealing either have to use
   `MFD_EXEC` (which we don't want, unless they actually need the
   executable bits), or they must add `F_SEAL_SEAL` immediately on
   return of memfd_create(2) with `MFD_NOEXEC_SEAL`, since this
   implicitly enables sealing.

   Note that we explicitly added `MFD_ALLOW_SEALING` when creating
   memfd_create(2), because enabling seals on existing users of shmem
   without them knowing about it can easily introduce DoS scenarios. It
   is unclear why `MFD_NOEXEC_SEAL` was designed to enable seals, and
   this is especially dangerous with `MEMFD_NOEXEC_SCOPE_NOEXEC_SEAL`
   set via sysctl, since it will silently enable sealing on every memfd
   created.

 * Applications that do not want `MFD_EXEC`, but rely on
   `F_GET_SEALS` to *NOT* return `F_SEAL_EXEC` have no way of achieving
   this other than using `MFD_EXEC` and clearing the executable bits
   manually via fchmod(2). Using `MFD_NOEXEC_SEAL` will set
   `F_SEAL_EXEC` and thus break existing code that hard-codes the
   seal-set.

   This is already an issue when sending log-memfds to systemd-journald
   today, which verifies the seal-set of the received FD and fails if
   unknown seals are set. Hence, you have to use `MFD_EXEC` when
   creating memfds for this purpose, even though you really do not need
   the executable bits set.

 * Applications that want to enable the executable bit later on,
   currently have no way to create the memfd without it. They have to
   clear the bits immediately after creating it via fchmod(2), or just
   leave them set.

By adding MFD_NOEXEC, user-space is now able to clear the executable
bits on all memfds immediately, clearly stating their intention, without
requiring fixups after creating the memfd. In particular, it is highly
useful for existing use-cases that cannot allow new seals to appear on
memfds.

Signed-off-by: David Rheinsberg <david@readahead.eu>
---
 include/linux/pid_namespace.h |  4 ++--
 include/uapi/linux/memfd.h    |  1 +
 mm/memfd.c                    | 29 ++++++++++++++---------------
 3 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/linux/pid_namespace.h b/include/linux/pid_namespace.h
index c758809d5bcf..02f8acf94512 100644
--- a/include/linux/pid_namespace.h
+++ b/include/linux/pid_namespace.h
@@ -19,9 +19,9 @@ struct fs_pin;
 #if defined(CONFIG_SYSCTL) && defined(CONFIG_MEMFD_CREATE)
 /*
  * sysctl for vm.memfd_noexec
- * 0: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL
+ * 0: memfd_create() without MFD_EXEC nor MFD_NOEXEC
  *	acts like MFD_EXEC was set.
- * 1: memfd_create() without MFD_EXEC nor MFD_NOEXEC_SEAL
+ * 1: memfd_create() without MFD_EXEC nor MFD_NOEXEC
  *	acts like MFD_NOEXEC_SEAL was set.
  * 2: memfd_create() without MFD_NOEXEC_SEAL will be
  *	rejected.
diff --git a/include/uapi/linux/memfd.h b/include/uapi/linux/memfd.h
index 273a4e15dfcf..b9e13bd65817 100644
--- a/include/uapi/linux/memfd.h
+++ b/include/uapi/linux/memfd.h
@@ -12,6 +12,7 @@
 #define MFD_NOEXEC_SEAL		0x0008U
 /* executable */
 #define MFD_EXEC		0x0010U
+#define MFD_NOEXEC		0x0020U
 
 /*
  * Huge page size encoding when MFD_HUGETLB is specified, and a huge page
diff --git a/mm/memfd.c b/mm/memfd.c
index e763e76f1106..2afe49368fc5 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -266,7 +266,9 @@ long memfd_fcntl(struct file *file, unsigned int cmd, unsigned int arg)
 #define MFD_NAME_PREFIX_LEN (sizeof(MFD_NAME_PREFIX) - 1)
 #define MFD_NAME_MAX_LEN (NAME_MAX - MFD_NAME_PREFIX_LEN)
 
-#define MFD_ALL_FLAGS (MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | MFD_NOEXEC_SEAL | MFD_EXEC)
+#define MFD_ALL_FLAGS \
+	(MFD_CLOEXEC | MFD_ALLOW_SEALING | MFD_HUGETLB | \
+	 MFD_NOEXEC_SEAL | MFD_EXEC | MFD_NOEXEC)
 
 SYSCALL_DEFINE2(memfd_create,
 		const char __user *, uname,
@@ -289,11 +291,13 @@ SYSCALL_DEFINE2(memfd_create,
 			return -EINVAL;
 	}
 
-	/* Invalid if both EXEC and NOEXEC_SEAL are set.*/
-	if ((flags & MFD_EXEC) && (flags & MFD_NOEXEC_SEAL))
+	if (flags & MFD_NOEXEC_SEAL)
+		flags |= MFD_ALLOW_SEALING | MFD_NOEXEC;
+
+	if ((flags & MFD_EXEC) && (flags & MFD_NOEXEC))
 		return -EINVAL;
 
-	if (!(flags & (MFD_EXEC | MFD_NOEXEC_SEAL))) {
+	if (!(flags & (MFD_EXEC | MFD_NOEXEC))) {
 #ifdef CONFIG_SYSCTL
 		int sysctl = MEMFD_NOEXEC_SCOPE_EXEC;
 		struct pid_namespace *ns;
@@ -366,20 +370,15 @@ SYSCALL_DEFINE2(memfd_create,
 	file->f_mode |= FMODE_LSEEK | FMODE_PREAD | FMODE_PWRITE;
 	file->f_flags |= O_LARGEFILE;
 
-	if (flags & MFD_NOEXEC_SEAL) {
-		struct inode *inode = file_inode(file);
+	if (flags & MFD_NOEXEC)
+		file_inode(file)->i_mode &= ~0111;
 
-		inode->i_mode &= ~0111;
-		file_seals = memfd_file_seals_ptr(file);
-		if (file_seals) {
+	file_seals = memfd_file_seals_ptr(file);
+	if (file_seals) {
+		if (flags & MFD_ALLOW_SEALING)
 			*file_seals &= ~F_SEAL_SEAL;
+		if (flags & MFD_NOEXEC_SEAL)
 			*file_seals |= F_SEAL_EXEC;
-		}
-	} else if (flags & MFD_ALLOW_SEALING) {
-		/* MFD_EXEC and MFD_ALLOW_SEALING are set */
-		file_seals = memfd_file_seals_ptr(file);
-		if (file_seals)
-			*file_seals &= ~F_SEAL_SEAL;
 	}
 
 	fd_install(fd, file);
-- 
2.41.0

