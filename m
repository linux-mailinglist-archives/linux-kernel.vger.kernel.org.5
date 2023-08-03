Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A163576EB8B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 16:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236505AbjHCOBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 10:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236560AbjHCOBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 10:01:21 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA2030D7
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 07:00:43 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D2F864247D
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 14:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691071224;
        bh=mZe9Srkw8mk9+UpxCgBj79JVdzJ8PXD8OnJawp13C+4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=EY6/g++g/fpUSThgktpyIUfWc81ZZ9AffggXY8V1VNU1g3iyPxYRADDrk52E8Qknb
         0dx0C8RMiexwhhDZEijOdR5IEuYsLO3jLyqDxL+ggW2tpszuENsUIIQD3Xtlx8nyzv
         DXKA9s1/TUSkx3YVj27d8vV8yx8y/6TDFoZItHBWNCdTMlKRmNo02FfLxZiWqKrIzc
         MZ4jmhfFzdPDIGaiLBDq6jtFlAt4TKRrxxMDTiW1jvMYr4zCbu3iNtkOySgGztIL8u
         WKC0BK1QYMNUM8Oe3vX+/8WdI+7uDTe5diWKXPFYHlPb9f5a3CEJ+gHWP/eXSB1i3f
         C5afrNffacBVw==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-521a38098faso678371a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 07:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691071223; x=1691676023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mZe9Srkw8mk9+UpxCgBj79JVdzJ8PXD8OnJawp13C+4=;
        b=UeE/jxFP5TYA4I3MGD7KLWS2OIHp5R3bHpNOhqvF3U1Ajyp2wW1oVjZv/w+/X7UKXK
         79A3CVa5MKTmqq1gmsXcl8R5a3+izdZIVTDGUAa0rqmij6zDlIUwpDSbeBn0zUxCvQ5e
         0xcfhpxXJ3JVf6tJ457IvGvRHwhKvSZzLAZPailsrh7TGLn/+fPsGywsMoBZBeS75KIZ
         a8/48cl7ghlu5mkW7OMI2Ri632dd6Vfe1X+2nvBYzu2ohxrC9bwjbhZJnIYyFZ12idob
         xgYek47OpS06jMq+5rIm2HiKh5r6GOycabi7iSqcnZ3p+kqeIFeUzG3xEAS2xQTtjLUv
         XX9Q==
X-Gm-Message-State: AOJu0YzapRHMe+KLUzWalw0kaO6YskohCeDvKskQg9LZlNtwftXgfZch
        dKGIds8uPUIKwWXFU920dQS2/Z5aStqJpFCgO9reF/bsrNpY+W+ll6T5PIRlmpulGgp9daOLoBt
        3ka0MrcLvfg0ZkbqgEXJdCUxsqU62LbPOKTwOia62cw==
X-Received: by 2002:aa7:dbda:0:b0:523:f29:a912 with SMTP id v26-20020aa7dbda000000b005230f29a912mr1338864edt.21.1691071223233;
        Thu, 03 Aug 2023 07:00:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHNXClq9w1vu3j+/MCpqQ1qf7yVb7U3H47Lv374blmqMtgY6wWk79A9/cAXoEkoeyvY03jUKw==
X-Received: by 2002:aa7:dbda:0:b0:523:f29:a912 with SMTP id v26-20020aa7dbda000000b005230f29a912mr1338852edt.21.1691071223066;
        Thu, 03 Aug 2023 07:00:23 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id bc21-20020a056402205500b0052229882fb0sm10114822edb.71.2023.08.03.07.00.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 07:00:22 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 05/12] ceph: pass an idmapping to mknod/symlink/mkdir
Date:   Thu,  3 Aug 2023 15:59:48 +0200
Message-Id: <20230803135955.230449-6-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230803135955.230449-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230803135955.230449-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
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

