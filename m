Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE5577C62F8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 04:42:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345779AbjJLCmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 22:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234008AbjJLCmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 22:42:36 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C05FB7
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 19:42:35 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-690bc3f82a7so433708b3a.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 19:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1697078554; x=1697683354; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7Q0G7SAJYo4UkLsXiQBpIDaDgLDqF1LJ1c6VmD0yOVM=;
        b=llTHM6dYgFRz0uD+zmp5iv/aMgdmNzjEIW3KmrBNFkwvXoKKWBXB9cZG7GlHGCSpfS
         GlTSTJIICVEoRiG9P3+Id3a49fmOZJNbYRCOiGS5v5Ebtd1+WliuBuvpMA4kKCl0kKxn
         XprLpsj5wwBWSSt4YAV9//u43QyBHO+5eRXc6vZrgmjHQa4EBbq32bDGS5xrUeCNNhhR
         AsDGGblPn26y1+GYPmkn3C1fiZrJ6Wdk+dzuwCSw7Z9UvJQUhqUUTXMAIqWZxzuw5Q3d
         bHh7cKjqyT8KU3dn+JcVaEogtjHmlgpn6Iuu6atz84InyfP4wXdu1ME1mTebVZHOm3/M
         P2LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697078554; x=1697683354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7Q0G7SAJYo4UkLsXiQBpIDaDgLDqF1LJ1c6VmD0yOVM=;
        b=qkYlgNjwGRMm5r9vv23Any6vrCgxqha8ZbVLUva9BiiLQx8PqpJuR7Q8OhM08xpkAx
         T6P2W5TQ759uHe12AC/vOSgVGA5zKHT5kPXOORihCL8rmIMHjkrL8Oz5edxoTldTovnP
         cqQi+nn2Et7SLdsbnfOB45/BhXMZ45M68JGFjQR7QeiQQ1IcIQMwPCHoEurKZK9gffnK
         XV6tgThyNwh1Z7UMB95jR0dgxR+BQZmOd+4Y4LVEmlaF0UeAAH6XM0zOPx2TBOfzN6UV
         dvuC9OM79awAvwWNkMqi+1rHOzN78WtbhHa91e4myTESjro/6Hgp5teFp0GZEOEa/7Y1
         z6pw==
X-Gm-Message-State: AOJu0YwBexq0ATcE9h5vnvNEcakS5d/Z9qBPaMhUvxQ+gc9nyNvDLnEh
        HaXwyc8UhVhjNtfbHB9PQnY8cw==
X-Google-Smtp-Source: AGHT+IFFy3uxF7uFKfjkdWUeHCfhK/bx2P4yWiMaOXUfCJPbmqiLdy7t31a1cbnl7KgaPpe8K2vH6Q==
X-Received: by 2002:a05:6300:8089:b0:174:373b:4381 with SMTP id ap9-20020a056300808900b00174373b4381mr2417195pzc.49.1697078554508;
        Wed, 11 Oct 2023 19:42:34 -0700 (PDT)
Received: from ubuntu-yizhou.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id a8-20020a1709027d8800b001b89a6164desm618060plm.118.2023.10.11.19.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 19:42:34 -0700 (PDT)
From:   Tang Yizhou <yizhou.tang@shopee.com>
X-Google-Original-From: Tang Yizhou
To:     houtao1@huawei.com, jack@suse.cz, bvanassche@acm.org,
        kch@nvidia.com
Cc:     axboe@kernel.dk, tj@kernel.org, corbet@lwn.net,
        linux-block@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, yingfu.zhou@shopee.com,
        yizhou.tang@shopee.com, chunguang.xu@shopee.com
Subject: [PATCH v2] doc: blk-ioprio: Bring the doc in line with the implementation
Date:   Thu, 12 Oct 2023 10:42:28 +0800
Message-Id: <20231012024228.2161283-1-yizhou.tang@shopee.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tang Yizhou <yizhou.tang@shopee.com>

Our system administrator have noted that the names 'rt-to-be' and
'all-to-idle' in the I/O priority policies table appeared without
explanations, leading to confusion. Let's bring these names in line
with the naming in the 'attribute' section.

Additionally,
1. Correct the interface name to 'io.prio.class'.
2. Add a table entry of 'promote-to-rt' for consistency.
3. Fix a typo of 'priority'.

Suggested-by: Yingfu Zhou <yingfu.zhou@shopee.com>
Reviewed-by: Hou Tao <houtao1@huawei.com>
Signed-off-by: Tang Yizhou <yizhou.tang@shopee.com>
---
v2:
Accept Bart's suggestion and rename the title of the patch.
Pick up Tao's Reviewed-by tag.

 Documentation/admin-guide/cgroup-v2.rst | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/cgroup-v2.rst b/Documentation/admin-guide/cgroup-v2.rst
index 4ef890191196..10461c73c9a3 100644
--- a/Documentation/admin-guide/cgroup-v2.rst
+++ b/Documentation/admin-guide/cgroup-v2.rst
@@ -2023,7 +2023,7 @@ IO Priority
 ~~~~~~~~~~~
 
 A single attribute controls the behavior of the I/O priority cgroup policy,
-namely the blkio.prio.class attribute. The following values are accepted for
+namely the io.prio.class attribute. The following values are accepted for
 that attribute:
 
   no-change
@@ -2052,9 +2052,11 @@ The following numerical values are associated with the I/O priority policies:
 +----------------+---+
 | no-change      | 0 |
 +----------------+---+
-| rt-to-be       | 2 |
+| promote-to-rt  | 1 |
 +----------------+---+
-| all-to-idle    | 3 |
+| restrict-to-be | 2 |
++----------------+---+
+| idle           | 3 |
 +----------------+---+
 
 The numerical value that corresponds to each I/O priority class is as follows:
@@ -2074,7 +2076,7 @@ The algorithm to set the I/O priority class for a request is as follows:
 - If I/O priority class policy is promote-to-rt, change the request I/O
   priority class to IOPRIO_CLASS_RT and change the request I/O priority
   level to 4.
-- If I/O priorityt class is not promote-to-rt, translate the I/O priority
+- If I/O priority class policy is not promote-to-rt, translate the I/O priority
   class policy into a number, then change the request I/O priority class
   into the maximum of the I/O priority class policy number and the numerical
   I/O priority class.
-- 
2.25.1

