Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDF580A6FB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574336AbjLHPMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:12:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574321AbjLHPMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:12:15 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA1E1BC8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:10:59 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0175F3F4C0
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 15:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1702048256;
        bh=ahAq0bs9SRy7utEnw9I8X1oqpnFPhDexGIr3W8i6/sw=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=Ti4KS7vRnia70hFmmpifOOxX37fpa4kMxFGbSQHupGwLe4IPmtc/OQbQKmh+2zTQd
         E7Oxw1Pxh+/HqcQ65ZBJxqIyTqWaTqp0Lp8pFjHaTSQL05XtjJPSOjQaNEZv7d0Yue
         8ETldMgyFHwgXDG4f8HkDNbA8mgNepgVDusnNhm4rNfTRbqGbVdl1Syg5pmY7UtHJM
         vHzyUkjU43tBXFD+Xb2XW/cQNK6ooePReqmam/0lPU8L3YRbEkadvrK8aYsQOba5hB
         RzFYVM7yFpyUHYvrHDTzj65eHGMsQX4yrmRQAUtMEBykp9EKgRT1vTB4AFyNum1Nu9
         ck9MBCJFP0lug==
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a1f6b30185bso42860266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 07:10:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702048255; x=1702653055;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ahAq0bs9SRy7utEnw9I8X1oqpnFPhDexGIr3W8i6/sw=;
        b=a85AHUW6fsBnRZWujkU++quXtl+hn09oDrfQPx0Ity+kohDVnnBS6VcSjvD4T42xQO
         Er01/rOrSFFOgo2eFW4xvEVpO9dhXwfYCHQ1df7TzYwbYYkkzcQkkSSKralKCLI0f654
         u6CVJANPlH4SSt19WsaKBaIjLwQ4ebI5PVvahgapc6vbav3ZblxfZ6lC5S7ygBG59wgT
         jBjmNsUEeq2qF7TT/u6CfYUJEW+hUFGeiIeEDMBBpzZ1sDPERKoEbv5QuAWl287kDExj
         3bUljwTIxsX3YtgXvOTFUX5NfSas79pOPvIJ76KTPpppSmGboJ08HAG1KkBJbaGEQUtd
         rFkQ==
X-Gm-Message-State: AOJu0YwAZ33Ft2bFYlybe0AlJOYKdS14gvVFcLJ5kI6NCPfOE8Vs7QgO
        liuyiSPspNKHFiZaiTasOrPuJCUUnFe5tBsbmDO/uobudvA8Qz1wPaFSYpvwpeZCWrLfN1YNvVD
        eQ5SClEFmYv9/oeIxEn6KOTYiXL552Bi3GdDXZvyGRw==
X-Received: by 2002:a17:907:7882:b0:a19:d40a:d225 with SMTP id ku2-20020a170907788200b00a19d40ad225mr30588ejc.241.1702048255607;
        Fri, 08 Dec 2023 07:10:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyDTKMZuA0UGfAukUeYUoKzCBZlXeHl6o7b0W3kpy7uvNruLx3UuUJq41J0yRgruhRHcmDAg==
X-Received: by 2002:a17:907:7882:b0:a19:d40a:d225 with SMTP id ku2-20020a170907788200b00a19d40ad225mr30582ejc.241.1702048255312;
        Fri, 08 Dec 2023 07:10:55 -0800 (PST)
Received: from amikhalitsyn.. ([2a02:8109:8624:a300:c1aa:a6b2:15a4:a9b9])
        by smtp.gmail.com with ESMTPSA id vi12-20020a170907d40c00b00a1a8d03347csm1120847ejc.13.2023.12.08.07.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 07:10:54 -0800 (PST)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     brauner@kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Jan Kara <jack@suse.cz>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs: super: use GFP_KERNEL instead of GFP_USER for super block allocation
Date:   Fri,  8 Dec 2023 16:10:22 +0100
Message-Id: <20231208151022.156273-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
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

There is no reason to use a GFP_USER flag for struct super_block allocation
in the alloc_super(). Instead, let's use GFP_KERNEL for that.

From the memory management perspective, the only difference between
GFP_USER and GFP_KERNEL is that GFP_USER allocations are tied to a cpuset,
while GFP_KERNEL ones are not.

There is no real issue and this is not a candidate to go to the stable,
but let's fix it for a consistency sake.

Cc: Jan Kara <jack@suse.cz>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 fs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/super.c b/fs/super.c
index 076392396e72..6fe482371633 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -323,7 +323,7 @@ static void destroy_unused_super(struct super_block *s)
 static struct super_block *alloc_super(struct file_system_type *type, int flags,
 				       struct user_namespace *user_ns)
 {
-	struct super_block *s = kzalloc(sizeof(struct super_block),  GFP_USER);
+	struct super_block *s = kzalloc(sizeof(struct super_block), GFP_KERNEL);
 	static const struct super_operations default_op;
 	int i;
 
-- 
2.34.1

