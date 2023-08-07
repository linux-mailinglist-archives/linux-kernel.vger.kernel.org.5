Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C357725B4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 15:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234227AbjHGN3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 09:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234193AbjHGN3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 09:29:14 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AFDE2106
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 06:28:52 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 795C844278
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 13:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691414897;
        bh=dbq6NgAMN4t7wxNwyddA+VrJjiC20GkONqywDZDeteI=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=cDMh1TFltob3E+cLFQxoYH8TQL5S6/9dVb0IAS+fnD5D34lIXUVa1uiSDz5+TJyys
         H//9qpZq6y5ar8+V9zixY5D+lCzYhcch0fn/j9c+8Es7QX7ZQxBhde2fVgXATrPE8p
         /pCe8I5YGLxYYeL1LZHsZYHvTON+DSg/b8Pw2FV+zTILaRGs/IBQek8cwNl8VzPkVw
         MpxIYeZh0bhdNsXiKDgXvn4UFDunU6eX33mwJuw2F4Dm1VDQKrkJYZlNWjkLn5aJok
         tsUcDDidw9p7NrPTgEXb6k9k5ntcUgFOmfB1w8eB3b2NPAGr1y916SHnHV891uOXzK
         Aglr6SMDxQ0Hw==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94a355cf318so362489866b.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Aug 2023 06:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691414897; x=1692019697;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dbq6NgAMN4t7wxNwyddA+VrJjiC20GkONqywDZDeteI=;
        b=UDNR51bU7Ajnwpx/tcpdrBGCkyk+wNEcPmvy6NLeLm8TmgJDI87Qkjkst9t7SL7n00
         GH/8HUFLTq2aR58JnnxeevGzrK5mXZoyd0mvvLw3Nr56j5RLodPekQjwrNBbig2ai02V
         XSC89BRePHL3Exz0GP+/1yJH2+4wfieSZSFixbTuxp+S7f5XG0QmEC/DCYohYmnBkuAK
         T446SiKpbKpOvd6I0g53QArTlQ69fQshChlJwMXk9+K7XV0fDq6IUreN6ZDa8UUl/UrP
         68DwEzY0acbe2/nS5STz/gcgtkTsZqWBJORRPmarszOW5MMidEQaaFJq13aGD+H2drVi
         px8w==
X-Gm-Message-State: AOJu0YzvqCn4ZserR1DGdxdyvRf0H7gYWj95URLAO+geYFJ0woLA+ECy
        tQ+1gYOvvMnVXGyeDkjFs2cr8dNww6yM3qMrO+lsSwXISCglpdlDBTBqf80I5VfyxDiwKpCr1G2
        ywCJRDx2fdXoqss6KzstWLNw6inaXR6GI7a3E5bBs0Q==
X-Received: by 2002:a17:906:5dd9:b0:99c:d069:d1e with SMTP id p25-20020a1709065dd900b0099cd0690d1emr3469993ejv.46.1691414897151;
        Mon, 07 Aug 2023 06:28:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkQ8KMlwVzyxsmXgNgAf7VeSk8c2NyZW9xrTMgDHQCTpHcK/uSnnQ4DPTGpDy3R5g22kXPCQ==
X-Received: by 2002:a17:906:5dd9:b0:99c:d069:d1e with SMTP id p25-20020a1709065dd900b0099cd0690d1emr3469974ejv.46.1691414896935;
        Mon, 07 Aug 2023 06:28:16 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id lg12-20020a170906f88c00b00992ca779f42sm5175257ejb.97.2023.08.07.06.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 06:28:16 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v10 06/12] ceph: allow idmapped getattr inode op
Date:   Mon,  7 Aug 2023 15:26:20 +0200
Message-Id: <20230807132626.182101-7-aleksandr.mikhalitsyn@canonical.com>
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

Enable ceph_getattr() to handle idmapped mounts. This is just a matter
of passing down the mount's idmapping.

Cc: Xiubo Li <xiubli@redhat.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/ceph/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 3ff4f57f223f..136b68ccdbef 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -3034,7 +3034,7 @@ int ceph_getattr(struct mnt_idmap *idmap, const struct path *path,
 			return err;
 	}
 
-	generic_fillattr(&nop_mnt_idmap, inode, stat);
+	generic_fillattr(idmap, inode, stat);
 	stat->ino = ceph_present_inode(inode);
 
 	/*
-- 
2.34.1

