Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262C17E8E14
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 04:19:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjKLDNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 22:13:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKLDNt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 22:13:49 -0500
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C1D130FA
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 19:13:47 -0800 (PST)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-58b2e2af00fso2954728a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 19:13:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699758826; x=1700363626;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M/4BoQGiwS+30aUkcnREquWCCC34rCQnqmivdxGcVkc=;
        b=GKDdns9R0eeRvwJvRxfvWOHGtmnNElS9HXEunEFvnE6wSxpoo9P5j80YA3GJDplIZU
         X7eqF7UpVV3WcWLikXIxCjbGOKRQkJ8oZ6abQGf4/gDDVkN2sQFgM5c38BYPQ4SS7LDm
         jTrT/Pk3RFwQ8UdjXR0TYwuc6rekDPq/xclyR7SdSljoN79LkI9v8IjuakooeUgRnzBL
         QOBNEkreFZQvSh051GsLv56OjSSkQJKJ72l5KrhLfu8RcDVqKmZDG4b/0+zos0LGN7Z4
         0Ql/CB/owjVYeRIBk96xFNJSxn6kq7iu6E9P/Us1mkrEqkyoeieZG/vMfbGUw0s1wHyq
         8F7Q==
X-Gm-Message-State: AOJu0YwDP+fWwButAUasAGyTRtNKafTY+qhwLEuj58gFvU3cZ0sLhGEh
        uW7qDpETVDQJYOfELc/FnsMW/04xcD/CIH94LIat/EMlJfn+QhQ=
X-Google-Smtp-Source: AGHT+IGS0oqKEWv/tZRXyVGJ+p3YYx6isq2c49cmVQtkSAiMEY+mPfw6n7hq/wNSMT1HmHIVf1HcWNSwl3foG17hC35W3PoEMkJw
MIME-Version: 1.0
X-Received: by 2002:a63:e313:0:b0:5bd:d69b:6f8 with SMTP id
 f19-20020a63e313000000b005bdd69b06f8mr892671pgh.4.1699758826562; Sat, 11 Nov
 2023 19:13:46 -0800 (PST)
Date:   Sat, 11 Nov 2023 19:13:46 -0800
In-Reply-To: <0000000000001959d30609bb5d94@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000fadc00609ebf197@google.com>
Subject: Re: [syzbot] [PATCH] test 305230142ae0
From:   syzbot <syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: [PATCH] test 305230142ae0
Author: eadavis@qq.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 305230142ae0

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index edb84cc03237..6cd89248e530 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -204,6 +204,7 @@ static struct btrfs_qgroup *add_qgroup_rb(struct btrfs_fs_info *fs_info,
 	struct rb_node **p = &fs_info->qgroup_tree.rb_node;
 	struct rb_node *parent = NULL;
 	struct btrfs_qgroup *qgroup;
+	u64 objid;
 
 	/* Caller must have pre-allocated @prealloc. */
 	ASSERT(prealloc);
@@ -232,6 +233,7 @@ static struct btrfs_qgroup *add_qgroup_rb(struct btrfs_fs_info *fs_info,
 
 	rb_link_node(&qgroup->node, parent, p);
 	rb_insert_color(&qgroup->node, &fs_info->qgroup_tree);
+	while (!btrfs_get_free_objectid(fs_info->tree_root, &objid) && objid <= qgroupid);
 
 	return qgroup;
 }
-- 
2.25.1

