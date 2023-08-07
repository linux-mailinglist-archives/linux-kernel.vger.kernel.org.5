Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125517725C4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:30:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233742AbjHGNax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:30:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbjHGNaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:30:39 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC8222D58
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:29:37 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 507D13F17B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:28:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691414921;
        bh=4z/daiO88HhZeOEnY3F9QYhLlQO1p3UrY3NiyEq1U7U=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=kLWym1tpcF36phHFDefL9y77tzGIPb2o+gsRAA6ZblR3Vl5dh1tvntKF1GwfXgw9H
         ve5jTFhIg8zYF7qzMGZs0tfSe3lfZIt4HxLv/cZ8Vw2P1KIRgz5u51YUXrmWuzhu1h
         tnrmMBuCA4hEZAWO+un3Cv69xjl/XqhX/irAvo5BemvCjzCnReZ0VvHJ53rhWsh+dK
         0j4WTG4xsi3HNXJKhWpg3AMaia56TGe8csPjUEYoxqK/7YS083SUghGIg3LUOqkYsO
         uUcYPKiTC761JloRpw9ZVFwUdjXwJpt8Nrno+sAHOmv2M586WEvDjjYDjaieEDtWYF
         hJRD4mtqj+8jg==
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-52310058f1eso5758838a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 06:28:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691414921; x=1692019721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4z/daiO88HhZeOEnY3F9QYhLlQO1p3UrY3NiyEq1U7U=;
        b=itvqTdL/bHopc8GzREF8nV7ox6AmYeGLv0ix+CAfcl4C5p743jyWGcTg1YyIiSEclm
         jJ4hWOlPXZzArbckl7zJu6u55SpaZ2XuA3PEz47kLBY71xbutb/O41vcZghYYzsFftQr
         jaUmN0VoGjf/R5L1Zq7uNhnIFBUr/gG4jGbQRSQVMNbotLM1xHe6OV54XfdGWtcERdAF
         vVEwy3pKVnjMFj9YZGhMvQ6R4f1ZMmAAa3eaAOT51RTEZ74slXPLSqCy6kQTy8bIo1YE
         SoCbneox1sJLgFfhze/iQh/oE8VikXgQ11SsGsu2/VGbSYiwlKbgWLAIFafz10xgg0iw
         /5Cg==
X-Gm-Message-State: AOJu0YzNmZ/5O1IgsRSRYvUNSCFdLHVlyUYrW46TZDLnS9J9bkPB3rAv
        4To7nkew1LBImQvyVdKFCQrPUR+rUCIgarXQVqkAMVpYzzlDLh5wrbqQCtjcpSwSBiUgf44XlVi
        6e0zriS+uoOPD0CFsCgjp/xe6SKZs7qbumlPKPkH1Sg==
X-Received: by 2002:a17:906:8a44:b0:99b:cdfd:fb44 with SMTP id gx4-20020a1709068a4400b0099bcdfdfb44mr7381518ejc.9.1691414920939;
        Mon, 07 Aug 2023 06:28:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwy+L+nCPnNmq6S3V19tL64bywfoR6mM7JJPFsVDhKATekruSoiqA62F3J2sZzqV/zbNE/KQ==
X-Received: by 2002:a17:906:8a44:b0:99b:cdfd:fb44 with SMTP id gx4-20020a1709068a4400b0099bcdfdfb44mr7381510ejc.9.1691414920783;
        Mon, 07 Aug 2023 06:28:40 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id lg12-20020a170906f88c00b00992ca779f42sm5175257ejb.97.2023.08.07.06.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 06:28:40 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 12/12] ceph: allow idmapped mounts
Date:   Mon,  7 Aug 2023 15:26:26 +0200
Message-Id: <20230807132626.182101-13-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230807132626.182101-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230807132626.182101-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <brauner@kernel.org>

Now that we converted cephfs internally to account for idmapped mounts
allow the creation of idmapped mounts on by setting the FS_ALLOW_IDMAP
flag.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 18bfdfd48cef..ad6d40309ebe 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1581,7 +1581,7 @@ static struct file_system_type ceph_fs_type = {
 	.name		= "ceph",
 	.init_fs_context = ceph_init_fs_context,
 	.kill_sb	= ceph_kill_sb,
-	.fs_flags	= FS_RENAME_DOES_D_MOVE,
+	.fs_flags	= FS_RENAME_DOES_D_MOVE | FS_ALLOW_IDMAP,
 };
 MODULE_ALIAS_FS("ceph");
 
-- 
2.34.1

