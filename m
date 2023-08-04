Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD92176FCA3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjHDIwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjHDIuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:50:24 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4933C4ED9
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:49:53 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D6F073F148
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691138991;
        bh=3z9qgb9ifPvjMsignbqopXQPiRZw936kb1zQwGNpHt4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=OV7Xk6DYmrC9Bf1PfSJ4bhX+xzNohrVjBEnPx6DGl++fVi2DA4kX01J21rPhi8tnT
         dmmF9krrAGvvYsxjH4WxtthhYci7J7fbg4bW6VtmPeFL/DGZe7Ir4s1+pIt7e39vNv
         BGNzDqTGOCMpRCg/R0uIlC4jaijuJ/wSIMDYeeb0Klli9w0ufYAABWRzs9xX9lMVQo
         IQni/E9ysiynKJT6a1nuozBVITP+kO2MGgCTP9RltVG2/ruvZ0UwAxd9BYoqyx1AfE
         W7hEU+au3ac6T5VI0pTdwhP9bcVW8DsTJ+pBALN+8yru3Sfm+h+DORYIla3EIq3FlJ
         zV6qxwS1sy+mg==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-993c2d9e496so119701166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:49:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691138989; x=1691743789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3z9qgb9ifPvjMsignbqopXQPiRZw936kb1zQwGNpHt4=;
        b=HEF5Z1/1XIlr6ogSx+gxCzkw0eWZI5AE04NM+77KDeymQKJR1a2jynfcmxkzRmzqGA
         NLLLT/zRPSV4WLSRdfI0/xNzlaWHEs/BGSdBgVZ0/JdsdMmGKH6mYQn9JhrlCGabQpR/
         Cvi4GZgS0PBZ10yuGqcTkvVuiMIlw/APBB0kJKUAf/HtktxjK2dti9irJfbWbsdwoP1p
         uSzX7FLAqHHGcuAaYV2vhJkRA5asSTidmas93twkQbXKaB3XKPZD+7FXxejtioegpRi5
         PRm0bHRNprGCBY9b0XabNPI/lTOh5cNEOxnANKnwY7T647w/qSTMlQZ5o7+QWb/bib9I
         lcGw==
X-Gm-Message-State: AOJu0YzXh1UOn6kVOEqZQkB8/NlYwYXf7UeJyrsumt+kG7aecJKidO4v
        dgllCMfFTdpxkvGWMDTM26ybzOpR/ju4QQbRMZ8Y/FwGr2cIdVrhtUKUmsFeViVfiPyix6hMA1y
        UJM2qN1Z9OmPRGvfUnq08hafspyze4zCvUYvLfsULLg==
X-Received: by 2002:a17:906:76c8:b0:99c:524d:5052 with SMTP id q8-20020a17090676c800b0099c524d5052mr947635ejn.0.1691138989329;
        Fri, 04 Aug 2023 01:49:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTym5TfzlHG1lZSavhyqmoZ0wMSQV6UssfY2G4oAk1V8i7SJ+uZP+Mld/WvvtmdYlgx9LngQ==
X-Received: by 2002:a17:906:76c8:b0:99c:524d:5052 with SMTP id q8-20020a17090676c800b0099c524d5052mr947623ejn.0.1691138989153;
        Fri, 04 Aug 2023 01:49:49 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id k25-20020a17090646d900b00992e94bcfabsm979279ejs.167.2023.08.04.01.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:49:48 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 11/12] ceph/file: allow idmapped atomic_open inode op
Date:   Fri,  4 Aug 2023 10:48:57 +0200
Message-Id: <20230804084858.126104-12-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804084858.126104-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230804084858.126104-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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

