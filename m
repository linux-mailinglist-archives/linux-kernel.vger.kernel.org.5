Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1763376EB9F
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235570AbjHCOCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236578AbjHCOBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:01:23 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3DC3A9F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:00:47 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id EC7C1413D5
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 14:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691071238;
        bh=3z9qgb9ifPvjMsignbqopXQPiRZw936kb1zQwGNpHt4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=KpxGdts9ohXv2liGir1FzV+8kXas8YpOpHIKcrcTvISOoqQt5lQJajchAfNsiHCNt
         1OVhNIQ1LL0Z7F2vyQdAPdE8l3IhgTyoblROFT4B9sa6c+SjTdaP2ljFK+pCtrPWji
         QOTf2ETUpz0VMHVH2tg9QD9p/RafZqUab6XalD5UqaJMjJcfk7tCJ52kNqZlt9DUfS
         TTMFJKLeWknzudLmijWDacvyQLbgdJ9kpH+ZW95vZ54utovhzdipCkzE1M4277rs7S
         q/gi1KkoPDKcbhVF9A2VJ6rytwUZWxP3OmvIWUmiovu1hlCJPD8W7CcWPt6Y540Ln8
         ZcUcEoh2cAlFw==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-521a38098faso678596a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 07:00:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691071238; x=1691676038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3z9qgb9ifPvjMsignbqopXQPiRZw936kb1zQwGNpHt4=;
        b=Laj3Nu1WOExFvJYZKsh2gh56p996m0hAGaeTTn41DrWsBlAug1VLe9SqFOmXLxmMQd
         N3FXgTmknY1vnAuJ5+Z11bWuY98lQyNqDuizpWAuog96ajTcTxti0NAKhytm5eb6bB/7
         f3iVDEXDraf3Yxs/SeJfxapWxhoB8G64HozVTI+PhFNRQ0aMKu1Jj7UjjNZ7bhtpWYTE
         ipZx39uWZtd82FWuIAowPPrtWvpHgMl7Rray3O1FbH2F0VqocZgsKIsyemtIrtv1Boe7
         UWe+91EJB+yapECynK/gvGTtU/nNStMo2WWFklrJPy7p5u/SKEqh37PSyMogn+wMAvWT
         efEQ==
X-Gm-Message-State: ABy/qLaEFK5ZxrMIYRipc19oW3h4btZv1koAXIZnhoz7kKrIymxQh10i
        l3Q4deY5edykNBCON0W9KIKMfdA5htfyG/D1qYOJWekVc5VNJxkagwCP1St2+l+JZ8Axho+7WAi
        i5I9LqS1ROAbk7DRmgDDOsTRhcp7JQbpGM8CKfer6Og==
X-Received: by 2002:aa7:d7c9:0:b0:522:2b76:1985 with SMTP id e9-20020aa7d7c9000000b005222b761985mr7132495eds.2.1691071238722;
        Thu, 03 Aug 2023 07:00:38 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE0pp6lmcBwuEsjLXRAH6NybsqxtfW1AOq9hV5+FXgfxFhIOUTjX8q9MHOhwq4qu7jI+RVc6Q==
X-Received: by 2002:aa7:d7c9:0:b0:522:2b76:1985 with SMTP id e9-20020aa7d7c9000000b005222b761985mr7132484eds.2.1691071238558;
        Thu, 03 Aug 2023 07:00:38 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id bc21-20020a056402205500b0052229882fb0sm10114822edb.71.2023.08.03.07.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 07:00:38 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 11/12] ceph/file: allow idmapped atomic_open inode op
Date:   Thu,  3 Aug 2023 15:59:54 +0200
Message-Id: <20230803135955.230449-12-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803135955.230449-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230803135955.230449-1-aleksandr.mikhalitsyn@canonical.com>
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

From: Christian Brauner <brauner@kernel.org>

Enable ceph_atomic_open() to handle idmapped mounts. This is just a
matter of passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
[ adapted to 5fadbd9929 ("ceph: rely on vfs for setgid stripping") ]
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v4:
	- call mnt_idmap_get
---
 fs/ceph/file.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 7470daafe595..f73d8b760682 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -668,7 +668,9 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
 	in.truncate_seq = cpu_to_le32(1);
 	in.truncate_size = cpu_to_le64(-1ULL);
 	in.xattr_version = cpu_to_le64(1);
-	in.uid = cpu_to_le32(from_kuid(&init_user_ns, current_fsuid()));
+	in.uid = cpu_to_le32(from_kuid(&init_user_ns,
+				       mapped_fsuid(req->r_mnt_idmap,
+						    &init_user_ns)));
 	if (dir->i_mode & S_ISGID) {
 		in.gid = cpu_to_le32(from_kgid(&init_user_ns, dir->i_gid));
 
@@ -676,7 +678,9 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
 		if (S_ISDIR(mode))
 			mode |= S_ISGID;
 	} else {
-		in.gid = cpu_to_le32(from_kgid(&init_user_ns, current_fsgid()));
+		in.gid = cpu_to_le32(from_kgid(&init_user_ns,
+				     mapped_fsgid(req->r_mnt_idmap,
+						  &init_user_ns)));
 	}
 	in.mode = cpu_to_le32((u32)mode);
 
@@ -743,6 +747,7 @@ static int ceph_finish_async_create(struct inode *dir, struct inode *inode,
 int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 		     struct file *file, unsigned flags, umode_t mode)
 {
+	struct mnt_idmap *idmap = file_mnt_idmap(file);
 	struct ceph_fs_client *fsc = ceph_sb_to_fs_client(dir->i_sb);
 	struct ceph_client *cl = fsc->client;
 	struct ceph_mds_client *mdsc = fsc->mdsc;
@@ -802,6 +807,7 @@ int ceph_atomic_open(struct inode *dir, struct dentry *dentry,
 		mask |= CEPH_CAP_XATTR_SHARED;
 	req->r_args.open.mask = cpu_to_le32(mask);
 	req->r_parent = dir;
+	req->r_mnt_idmap = mnt_idmap_get(idmap);
 	ihold(dir);
 	if (IS_ENCRYPTED(dir)) {
 		set_bit(CEPH_MDS_R_FSCRYPT_FILE, &req->r_req_flags);
-- 
2.34.1

