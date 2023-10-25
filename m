Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26977D6F70
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 16:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344745AbjJYODy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 10:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbjJYODt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 10:03:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1900518D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698242534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oOOGhallOPxnWGST34MdPR6LpOdkhm6q6XmykKHjQ0c=;
        b=gT2LfIBMmQ8sCCKPzUxLcI7wq6s2aIyE98U06NzNmSIBPseLsePeYNdg0v+gQLgIfTPJrB
        /1l4qyt0AHF8g42FLc/sqvnLyp8/2gdWLk02P+24+3DCkyTCA+TMMuuWnwhrc6PHOpY4Iw
        YPsKfm28BeQ4F8Gu4THGbG0qUtFTkh8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-qAzJUC4LNAWxidPLCC6QjQ-1; Wed, 25 Oct 2023 10:02:12 -0400
X-MC-Unique: qAzJUC4LNAWxidPLCC6QjQ-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-9c797b497e8so308368766b.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 07:02:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698242531; x=1698847331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oOOGhallOPxnWGST34MdPR6LpOdkhm6q6XmykKHjQ0c=;
        b=ZNez/9vhFGXzwwJW9k/jEvi+XSTkBzRNjrteYh9npLR6rG4zPKjDo8mcRQb8Xfk7FX
         Cmtu70W/Jm+A1Z6BMBs9QTOGYEs39rkM8P9FSV/i9KwCUPq8B0PcATAQztPTSSfdKnNH
         ZGL2K7PdLlhrnlIkZEXh9prUQh+r+icS+Qpphmyni+sNQzUfgxnfX6lNlV6gJITf9luw
         1DSGbpLmrbjzHTwibQh6EP6NsaXqNGdNP0w/Pb3yuCMewfvvuW2hrBpNxM2ZA4FW0CqR
         dKwzw89dWUes+FC83uQbD/bQA+HP2WX6GdrJzedC+GPnpFyNFpweZsYo0/BjrCSsosFl
         wcWg==
X-Gm-Message-State: AOJu0Yy6WFiUYkicLwXPi87hDmi/oXBkGAeywyKaMHDI4kBnFnFzoycW
        nwgEW1iyraXcsWH0vzr5cslU6gwV0EdBP9gc4/K/KXvhKOqL3Hmy8EQOkuQAd9FDgAYpgNe4BHS
        O9U3hYgn/ECZ+8FuhcLLcQKhx
X-Received: by 2002:a17:907:7214:b0:9c5:64f2:eaba with SMTP id dr20-20020a170907721400b009c564f2eabamr12173163ejc.53.1698242531652;
        Wed, 25 Oct 2023 07:02:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGjFyLKoZkQVe5WJ8FMZvmHP9TlGwCthXsPC2ClyGzG4V59SQ3WuYohHWjLbekPtDQTXUhMwQ==
X-Received: by 2002:a17:907:7214:b0:9c5:64f2:eaba with SMTP id dr20-20020a170907721400b009c564f2eabamr12173147ejc.53.1698242531456;
        Wed, 25 Oct 2023 07:02:11 -0700 (PDT)
Received: from maszat.piliscsaba.szeredi.hu (92-249-235-200.pool.digikabel.hu. [92.249.235.200])
        by smtp.gmail.com with ESMTPSA id vl9-20020a170907b60900b00989828a42e8sm9857073ejc.154.2023.10.25.07.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 07:02:10 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 3/6] namespace: extract show_path() helper
Date:   Wed, 25 Oct 2023 16:02:01 +0200
Message-ID: <20231025140205.3586473-4-mszeredi@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231025140205.3586473-1-mszeredi@redhat.com>
References: <20231025140205.3586473-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To be used by the statmount(2) syscall as well.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/internal.h       |  2 ++
 fs/namespace.c      |  9 +++++++++
 fs/proc_namespace.c | 10 +++-------
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index d64ae03998cc..0c4f4cf2ff5a 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -83,6 +83,8 @@ int path_mount(const char *dev_name, struct path *path,
 		const char *type_page, unsigned long flags, void *data_page);
 int path_umount(struct path *path, int flags);
 
+int show_path(struct seq_file *m, struct dentry *root);
+
 /*
  * fs_struct.c
  */
diff --git a/fs/namespace.c b/fs/namespace.c
index 0eab47ffc76c..7a33ea391a02 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4672,6 +4672,15 @@ SYSCALL_DEFINE5(mount_setattr, int, dfd, const char __user *, path,
 	return err;
 }
 
+int show_path(struct seq_file *m, struct dentry *root)
+{
+	if (root->d_sb->s_op->show_path)
+		return root->d_sb->s_op->show_path(m, root);
+
+	seq_dentry(m, root, " \t\n\\");
+	return 0;
+}
+
 static void __init init_mount_tree(void)
 {
 	struct vfsmount *mnt;
diff --git a/fs/proc_namespace.c b/fs/proc_namespace.c
index 73d2274d5f59..0a808951b7d3 100644
--- a/fs/proc_namespace.c
+++ b/fs/proc_namespace.c
@@ -142,13 +142,9 @@ static int show_mountinfo(struct seq_file *m, struct vfsmount *mnt)
 
 	seq_printf(m, "%i %i %u:%u ", r->mnt_id, r->mnt_parent->mnt_id,
 		   MAJOR(sb->s_dev), MINOR(sb->s_dev));
-	if (sb->s_op->show_path) {
-		err = sb->s_op->show_path(m, mnt->mnt_root);
-		if (err)
-			goto out;
-	} else {
-		seq_dentry(m, mnt->mnt_root, " \t\n\\");
-	}
+	err = show_path(m, mnt->mnt_root);
+	if (err)
+		goto out;
 	seq_putc(m, ' ');
 
 	/* mountpoints outside of chroot jail will give SEQ_SKIP on this */
-- 
2.41.0

