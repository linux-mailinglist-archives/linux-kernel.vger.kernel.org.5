Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 735B27C592B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbjJKQcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 12:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbjJKQcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:32:31 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8E8A4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 09:32:30 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5859d13f73dso4065715a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 09:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697041950; x=1697646750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6TTvG9RsDz513s2F23HaEBE2HWxh0jvH/4VBJj8ZPLk=;
        b=aZBv53Hh9FvsdHpC7JgvzITjHIwsn3Yu7m7NWIp5GWVdd6dLCbXEAVeOtr+27Agqj9
         NNOSN3v/kx3g5X1SVkayi4X+AOqkvt7eCr5cqXeGAFcw/qEHjxwZYbG0gcOWHaITMIWJ
         2JwFi+1CEdnt28tyIcSMXvjzpHhEO9BwkuGQB4qa/4dw4V7PPo/OALKgJ5ZTr55ek/wx
         k3lMWWiZNyOtCKlYoREDy6wSjVooegtRBnclW/kJQkokYdsYKRnmrN8wcG7FTU8XzRKf
         P/sttiMV28jEByYXAOTwfJJKKgf84+LrxcQ7k7LHmzj2xIrpGW45DONEjrLSOJKGyr79
         G39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697041950; x=1697646750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6TTvG9RsDz513s2F23HaEBE2HWxh0jvH/4VBJj8ZPLk=;
        b=JmpZ8sWhof99y2gt9NTZKedRi3/086bvhNmfqpUOIIY7WHX37e/B3yPN2txmvUye/1
         6sJ8FgZJGp7KW05dAgvqcWqdCiP/xvTf2RW8UE4YWIzD/D3EEGc6tFjSDPzlRqD0J90U
         o0r75l1LCTqrfupKVVA2lOdH3tpWEz6/y/sluDqriSbXFzEGuM9eKhYsdSCjwrDdJ5Na
         tKIrR1EFzJL5yzv3EWBUfG3SLxzTuw+2nV0sPQnLHCZquMaAUo+TBHt7jDLZBXoUAk8P
         T51n40sKr/1HMAQQwCuq6V2mHJoXXbVLV2SKq6D8QPycR572ElHQ31ETnWYSmNXfPfPi
         zlhg==
X-Gm-Message-State: AOJu0Yw5iKRjw24o/Hsqgwjz99ow/3N99ZRehVT0r4qYaDyslX4ksNKV
        p/LYfP0dB1qLUPLwO5gWf7g=
X-Google-Smtp-Source: AGHT+IE6gWwlpkkkq0U3s9MJSP7t8t3BKkfZpXp1GtQIDHyRgnCdCpGHP8sMs+lo9xh+IAW6Ajldhw==
X-Received: by 2002:a17:90b:3143:b0:268:b682:23da with SMTP id ip3-20020a17090b314300b00268b68223damr18583581pjb.34.1697041949845;
        Wed, 11 Oct 2023 09:32:29 -0700 (PDT)
Received: from vm.. (ip141.ip-148-113-3.net. [148.113.3.141])
        by smtp.gmail.com with ESMTPSA id z9-20020a17090acb0900b00274262bcf8dsm117869pjt.41.2023.10.11.09.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 09:32:29 -0700 (PDT)
From:   Yuanheng Zhang <yuanhengzhang1214@gmail.com>
To:     mark@fasheh.com
Cc:     jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
        Yuanheng Zhang <yuanhengzhang1214@gmail.com>
Subject: [PATCH] ocfs2: fix a typo in a comment
Date:   Thu, 12 Oct 2023 00:32:16 +0800
Message-Id: <20231011163216.29446-1-yuanhengzhang1214@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix spelling typo in comment.

Signed-off-by: Yuanheng Zhang <yuanhengzhang1214@gmail.com>
---
 fs/ocfs2/buffer_head_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/buffer_head_io.c b/fs/ocfs2/buffer_head_io.c
index 196638a22b48..6cb919f60011 100644
--- a/fs/ocfs2/buffer_head_io.c
+++ b/fs/ocfs2/buffer_head_io.c
@@ -158,7 +158,7 @@ int ocfs2_read_blocks_sync(struct ocfs2_super *osb, u64 block,
 			if (new_bh && bh) {
 				/* If middle bh fails, let previous bh
 				 * finish its read and then put it to
-				 * aovoid bh leak
+				 * avoid bh leak
 				 */
 				if (!buffer_jbd(bh))
 					wait_on_buffer(bh);
-- 
2.34.1

