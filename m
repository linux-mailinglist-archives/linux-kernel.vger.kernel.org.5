Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D826B7725B5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:29:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234230AbjHGN3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234197AbjHGN3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:29:14 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52C81736
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:28:52 -0700 (PDT)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1A559417C1
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691414894;
        bh=dSSVvNS5h70J5u6vsFuPYT4MXnye3oVzKXsF0V62fVM=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=mihTwDzI2yPbW7y3IRKt5PtChNJmgnh8SQx9M1u4N2W9+ARsMRKe/MscifOzAZDk1
         o/aLU2edQinABhj9L7mS0m7WtX+bBtI2bBkyy4w9E/ptD8NPLXpPtnfMbm5BKB7zzg
         ikuks7GTvbZFJM/K5+TAogJfMKBvc/Z958riAmR4EjhathHbKk7X2eCn3MLr2aiva+
         9hUfjnZrCr/lui0qfV7IM2YNpX1eeqgDcf0PGJdL8UHie2jE48Oe1o3awz7dl2w8e2
         jdZRZt15x7Qbgskbt7g0aiIiW+s9iGtCd3lBq6Drf9w8lPtma5FNUXuRbCxpT0VWKE
         ZI5MgAxojMRUg==
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-99bc8f1290eso307789566b.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 06:28:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691414893; x=1692019693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSSVvNS5h70J5u6vsFuPYT4MXnye3oVzKXsF0V62fVM=;
        b=HhyasbdAm32koyPERt4UJKiC2afesxG1MNA4Yhq0xF8caXXRqTLaKcZtDz/aR4CWJD
         +XuLZntp6wGTF2TTjTAWPX6rthhBLOfSXPkGMA5hSw9dQNHwlA4KnKbleFdtaQL/olNe
         N6YJ9+Fzdc6jzoX35te6zVCe95z+Kd4vlYNtKXVZg/1WB7AtPfTJhBhtzDAia6Nw1ax/
         qUvfTYN6gGpZ4001ftjHmTu6mAZN5vrtEaewMVaZfc0qIpxE4FcIfbYZpFl4hPCiqadT
         D3ox7obWevmjWOlQDrSNCqrK+pMg4muuLS3M6PczFa0a4JZpkUdqqu7xgtCRYxXgQpgu
         DTLA==
X-Gm-Message-State: AOJu0YwEvvO91902clQlK4ZvldC92vzE9ZReQ2PfLpsSOif7T+eZgQjr
        MIKFl+7OR/DyDa5LYNJ1YKWHqqzec4htUvfZTCGx/lOiqi9ErnTiTm5eMTy/y10vo2PA/ahdcd7
        LJ8JvEbH04il0SeVlVWZywvqpUTsw6IlplX+NauUXHw==
X-Received: by 2002:a17:906:259:b0:99c:3b4:940f with SMTP id 25-20020a170906025900b0099c03b4940fmr8960490ejl.27.1691414893696;
        Mon, 07 Aug 2023 06:28:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGa0CjsHfJWZ04OQaM2nEIQHZnEMwjGZHzg3KFBLXF85/4ug5/dORHqOGj+uj7M8E5GiyJxWQ==
X-Received: by 2002:a17:906:259:b0:99c:3b4:940f with SMTP id 25-20020a170906025900b0099c03b4940fmr8960481ejl.27.1691414893493;
        Mon, 07 Aug 2023 06:28:13 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id lg12-20020a170906f88c00b00992ca779f42sm5175257ejb.97.2023.08.07.06.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 06:28:13 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 05/12] ceph: pass an idmapping to mknod/symlink/mkdir
Date:   Mon,  7 Aug 2023 15:26:19 +0200
Message-Id: <20230807132626.182101-6-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807132626.182101-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230807132626.182101-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <brauner@kernel.org>

Enable mknod/symlink/mkdir iops to handle idmapped mounts.
This is just a matter of passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v4:
	- call mnt_idmap_get
v7:
	- don't pass idmapping for ceph_rename (no need)
v10:
	- do not set req->r_mnt_idmap for MKSNAP operation
---
 fs/ceph/dir.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index b752ed3ccdf0..d6db6d861cd9 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -952,6 +952,7 @@ static int ceph_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	req->r_parent = dir;
 	ihold(dir);
 	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
+	req->r_mnt_idmap = mnt_idmap_get(idmap);
 	req->r_args.mknod.mode = cpu_to_le32(mode);
 	req->r_args.mknod.rdev = cpu_to_le32(rdev);
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_AUTH_EXCL |
@@ -1067,6 +1068,7 @@ static int ceph_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	}
 
 	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
+	req->r_mnt_idmap = mnt_idmap_get(idmap);
 	req->r_dentry = dget(dentry);
 	req->r_num_caps = 2;
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_AUTH_EXCL |
@@ -1146,6 +1148,8 @@ static int ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	req->r_parent = dir;
 	ihold(dir);
 	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
+	if (op == CEPH_MDS_OP_MKDIR)
+		req->r_mnt_idmap = mnt_idmap_get(idmap);
 	req->r_args.mkdir.mode = cpu_to_le32(mode);
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_AUTH_EXCL |
 			     CEPH_CAP_XATTR_EXCL;
-- 
2.34.1

