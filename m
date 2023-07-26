Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D09577638A3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232399AbjGZOMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjGZOLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:11:50 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAEC3C04
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:11:18 -0700 (PDT)
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 35E38413CA
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 14:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1690380646;
        bh=2wRsV5VoJJC+a/Nnh0k6h5YuKsT02FRfB/wC7z4rT6w=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=Kjjcj98Vp7IomFtovs4tRoVg3h59bs03gNLQSbAPRC5b1OqeHqF9U4ChtBdj0STcb
         wcWj9ZpdVfu67EQEtjO3OoK/kywcyiuQa8Of07myiY1bBLo2TeN05y/IYBoY9bbjHU
         DP2nlco9Ri9RPiPa+2bOKXQKgyLlkvL5sMSX1pLBSZ9EXSOBS6adobhY0jMFLBm0rF
         LPGaRgPRm6ztX1dvsh9F8c9HD6JIqPEVtDeJ6LcPDz6Fax9F6IeJXq1hhnEGXJ9lJ2
         XpcsmISNZDTMCHujYN3caKNkQzqrfAtWQtashYeJ8Ybt1kkylQWg8wX5ZoKH9Xe0K9
         WDcuj5dnBV58g==
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2b9bb2d0b1bso4086471fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 07:10:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690380643; x=1690985443;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wRsV5VoJJC+a/Nnh0k6h5YuKsT02FRfB/wC7z4rT6w=;
        b=EhvoxOq328O0bqYOhRHXwDvhSCq5/W+9GLs80RKJKwN7zSZ7fYrKClXQidcoC/JdIN
         bQ0zZmRjtJ8bYRi/qUkNRH9a8b0eTLvF9+VdYE8nsWakgfAhSzy8sWz9Nh0X2T3PJjZQ
         scmt7E5oHBUiP11ujPlSIiqF0ZF3hPO93WVTqoTK8hZO6aiwW+Losryjbq+VW4hGhe2J
         F1P0sB3BcmJbjdeMJEkKTXe9UULJ3y/vVQYFiE+BjvmTExYqF5TuSp7fyFVmWfUl+vBS
         tlJXMEERcSZOUn1ueW83ZGE1Ta79JuvrB/yu6Vu72euCU8C4zv3n/o2QBDG/Xrr+wiQa
         t/eA==
X-Gm-Message-State: ABy/qLacU3xTtCBG6ozc5mOeR7tNeTkyl3fIm3b9aUEq0t7JgQVCngZU
        OKzNLRSbtMPOGybX37DJ1BiupmRU3ltc/DFMXq0cbdyjxpm9/OXryu1Bd7BZs12L3VU4HsyMwZ4
        UJM2+ygy3onJKD9m/wpOqpG+JsVFkTX7B6H21TO4CuA==
X-Received: by 2002:a2e:984b:0:b0:2b6:decf:5cbd with SMTP id e11-20020a2e984b000000b002b6decf5cbdmr1578254ljj.36.1690380643777;
        Wed, 26 Jul 2023 07:10:43 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFzfOvSVHgN1R2U97B5NMYqDDnWYxKIdEobLA7c0AI/5Ct5RedFqzwWPJru7Kk1HPoq0AB4Rg==
X-Received: by 2002:a2e:984b:0:b0:2b6:decf:5cbd with SMTP id e11-20020a2e984b000000b002b6decf5cbdmr1578241ljj.36.1690380643620;
        Wed, 26 Jul 2023 07:10:43 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id k14-20020a7bc30e000000b003fc02219081sm2099714wmj.33.2023.07.26.07.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jul 2023 07:10:43 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 04/11] ceph: pass an idmapping to mknod/symlink/mkdir
Date:   Wed, 26 Jul 2023 16:10:19 +0200
Message-Id: <20230726141026.307690-5-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726141026.307690-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230726141026.307690-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Enable mknod/symlink/mkdir iops to handle idmapped mounts.
This is just a matter of passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v4:
	- call mnt_idmap_get
v7:
	- don't pass idmapping for ceph_rename (no need)
---
 fs/ceph/dir.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index b752ed3ccdf0..397656ae7787 100644
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
@@ -1146,6 +1148,7 @@ static int ceph_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	req->r_parent = dir;
 	ihold(dir);
 	set_bit(CEPH_MDS_R_PARENT_LOCKED, &req->r_req_flags);
+	req->r_mnt_idmap = mnt_idmap_get(idmap);
 	req->r_args.mkdir.mode = cpu_to_le32(mode);
 	req->r_dentry_drop = CEPH_CAP_FILE_SHARED | CEPH_CAP_AUTH_EXCL |
 			     CEPH_CAP_XATTR_EXCL;
-- 
2.34.1

