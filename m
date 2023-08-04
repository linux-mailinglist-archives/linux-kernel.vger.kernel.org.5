Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D43376FCA8
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 10:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjHDIwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 04:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbjHDIue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 04:50:34 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B3749E1
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 01:49:53 -0700 (PDT)
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 333A2417C0
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 08:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1691138992;
        bh=4z/daiO88HhZeOEnY3F9QYhLlQO1p3UrY3NiyEq1U7U=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=FGpgOd5ti5ENfTSJa5Lym7mJNoSpd89kabM9ALr54NEi9dQU66oPukd1ANS5PgYF/
         x/F6myWr3xpm43u0Du/xcYSO7MTXTv5zm9Nn/7qlZDTMfJD6JkgEXRoTDnGkFQvc7x
         iQPwIf9nB3b3VQWzSjw1Tw8AvZ+QkVSkEpSGXJuYdbG4UAYJCA2DUia7Zp+069zPfZ
         o744w4MFIsf4UHmS+8utL/zKgLwwFSE3PH9f3Pvzfz7wiQGXEHAqtnGx0JzaDTLgDm
         wAQ9pyiqtlzFmFzypDK1AGqedG5bJAGxZwa5kaRfo/MhsC99McaBeqT2ZIr0gJntCX
         qK6ZofXsqda+Q==
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94a34d3e5ebso124427566b.3
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 01:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691138991; x=1691743791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4z/daiO88HhZeOEnY3F9QYhLlQO1p3UrY3NiyEq1U7U=;
        b=X0R/sP6z589H/J6I/ZdXWRbfWFdhlv7LNa7bX51CnmGmsOL6UeP4xHavpgTES27+Yx
         NnTnv7pDuI+o16u32CwqIfyb/OQEwsUZTiIxNYJm1uP+1/JSQJ16+tPdlcnbZ5UJJ9f2
         laTrpiGbO0qTnwEajno9Msg0VnjjWmQTNEjHpcwObvsDlBAHwAx4hOiJc6Vv5cCuG2gX
         uvfP4hbm8VMM7yx0kYSgO/9WE+zGW00io+sv0JHEw68YjCc25nCmUj3H07pN65kmscYn
         P3Uc+100CBgzW/n6Tf9qZHrnlR3iPt/sSjecpzx+ARzql1bm84zZfhi7bREXY9pZiBix
         rmzA==
X-Gm-Message-State: AOJu0Yw+j/3VWgir5jQwMss3hJVLbKteddshVvsccfdGgnGrXBedJIr0
        7oID22Q9ZrLZuiFpE8Tlsn/wphGmW6vUeIWAaeRWe8hXCnLDo60DT4OL7tJuKSbR0Fy4OmZp3js
        iGUk1IbSMzUDAEz3Au2TuxWApwqct/Ym/ggVKReBnJUm1zs7kJg==
X-Received: by 2002:a17:906:2cb:b0:99c:ae35:ac0 with SMTP id 11-20020a17090602cb00b0099cae350ac0mr32342ejk.61.1691138991753;
        Fri, 04 Aug 2023 01:49:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdh2YBW+3zSthygL5eMI53A2dql4TVwWtXDEJAl+omt1I6HfFzDgF/roaG3QRdDVBhhechfA==
X-Received: by 2002:a17:906:2cb:b0:99c:ae35:ac0 with SMTP id 11-20020a17090602cb00b0099cae350ac0mr32336ejk.61.1691138991574;
        Fri, 04 Aug 2023 01:49:51 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-066-182-192.088.066.pools.vodafone-ip.de. [88.66.182.192])
        by smtp.gmail.com with ESMTPSA id k25-20020a17090646d900b00992e94bcfabsm979279ejs.167.2023.08.04.01.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 01:49:51 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     xiubli@redhat.com
Cc:     brauner@kernel.org, stgraber@ubuntu.com,
        linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
        Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 12/12] ceph: allow idmapped mounts
Date:   Fri,  4 Aug 2023 10:48:58 +0200
Message-Id: <20230804084858.126104-13-aleksandr.mikhalitsyn@canonical.com>
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

