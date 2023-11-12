Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8849A7E91B9
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 17:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbjKLQ5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 11:57:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbjKLQ5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 11:57:01 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578E61FF6;
        Sun, 12 Nov 2023 08:56:58 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc4f777ab9so26106235ad.0;
        Sun, 12 Nov 2023 08:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699808218; x=1700413018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NtmZPk3yPHOhQirsjhCxzhyVo85FJQsbyJr7+IvOrbY=;
        b=MOvrnwU4H5gOobh/+/PylpS2NU2oJS4EO6Md9XpljFLbz8v7fF8FNPHfDAeN11iJG6
         rsoUDWgc/sasBAVPMglf2I4oYG64O4iXE81anOp/J+T9VZIXvmPpkGbpVy5MF8Gj21ZJ
         Q5KT9uVW4tM3l3CqNkNoGiaNZaQPWAs9eAuDhoaMu4ffLXhEUe8U1naiojFAn7T3KW/s
         PhR/Rl5GKbWGZze2gZmFd2KjNfnox0l5e/R+3VTR20HmI+V4mt8gvMCSaKY7/a0A+cj6
         hnxoOxEmBXprbpPFW5X4qm+8SUwRZuZ6KW3QAUGlStrCQLbmqr39AQlmmmDYdNv5i251
         BCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699808218; x=1700413018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NtmZPk3yPHOhQirsjhCxzhyVo85FJQsbyJr7+IvOrbY=;
        b=VzZYuOn1cN85LU6FlYm3TF6SIe7g/zWieZSEO4QHjRxuxT1eIZ7N4TTdN8fqjGuSwT
         jYC0TrrHsIh9MNTvjOc2J4pMWEkNi0mnaYpJGvGpcWkxGkJe6OWjSUcXGd8vOau0l1B9
         j8enClMpaU13QQlQbAg9py4Gu/OdGtHhEuvLMkAWHmQOuqbG3O8DBMOz3197Vt0JMEHT
         6AV4ehYEJJM/pxj+qEmaVJNfQd/8dnFoF9+Ky+6n4IHIe9Ob2nkGgX7Pij3DWinVG5bh
         xvQ21NrC+kA31TK6y0GQEcm07oYDAUPwdjDPXZcCHr9GODdry19Ztiqns0x1jkYVDmco
         5lAw==
X-Gm-Message-State: AOJu0YwvzMibjAyJJ+ox/M6QJirAGhpJeCnB9jTq/wYJTaH5L+zYqXxE
        Ia1/esxdheomckNytJmcF5U=
X-Google-Smtp-Source: AGHT+IFTQvftkfKAgU00tb4uq7qPPczJYuK9ri454obLeUhDiRjVheDQOl/le0bKspE6DyXpOVdfZA==
X-Received: by 2002:a17:903:249:b0:1cc:51b8:8100 with SMTP id j9-20020a170903024900b001cc51b88100mr3399728plh.7.1699808217710;
        Sun, 12 Nov 2023 08:56:57 -0800 (PST)
Received: from brag-vm.. ([117.243.91.115])
        by smtp.gmail.com with ESMTPSA id u12-20020a170902e5cc00b001c5eb2c4d8csm2749301plf.160.2023.11.12.08.56.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 08:56:57 -0800 (PST)
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
To:     clm@fb.com, josef@toxicpanda.com, dsterba@suse.com
Cc:     Bragatheswaran Manickavel <bragathemanick0908@gmail.com>,
        linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+d66de4cbf532749df35f@syzkaller.appspotmail.com
Subject: [PATCH] btrfs: ref-verify: fix memory leaks
Date:   Sun, 12 Nov 2023 22:26:48 +0530
Message-Id: <20231112165648.10537-1-bragathemanick0908@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In btrfs_ref_tree_mod(), when !parent 're' was allocated
through kmalloc(). In the following code, if an error occurs,
the execution will be redirected to 'out' or 'out_unlock' and
the function will be exited. However, on some of the paths,
're' are not deallocated and may lead to memory leaks.

For example : lookup_block_entry() for 'be' returns null, the
out label will be invoked. During that flow ref and ra was
freed but not re, which can potentially lead to memleak

Reported-and-tested-by: syzbot+d66de4cbf532749df35f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d66de4cbf532749df35f
Signed-off-by: Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
---
 fs/btrfs/ref-verify.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/btrfs/ref-verify.c b/fs/btrfs/ref-verify.c
index 95d28497de7c..50b59b3dc474 100644
--- a/fs/btrfs/ref-verify.c
+++ b/fs/btrfs/ref-verify.c
@@ -791,6 +791,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 			dump_ref_action(fs_info, ra);
 			kfree(ref);
 			kfree(ra);
+			kfree(re);
 			goto out_unlock;
 		} else if (be->num_refs == 0) {
 			btrfs_err(fs_info,
@@ -800,6 +801,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 			dump_ref_action(fs_info, ra);
 			kfree(ref);
 			kfree(ra);
+			kfree(re);
 			goto out_unlock;
 		}
 
@@ -822,6 +824,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 				dump_ref_action(fs_info, ra);
 				kfree(ref);
 				kfree(ra);
+				kfree(re);
 				goto out_unlock;
 			}
 			exist->num_refs--;
@@ -838,6 +841,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 			dump_ref_action(fs_info, ra);
 			kfree(ref);
 			kfree(ra);
+			kfree(re);
 			goto out_unlock;
 		}
 		kfree(ref);
@@ -849,6 +853,7 @@ int btrfs_ref_tree_mod(struct btrfs_fs_info *fs_info,
 			dump_ref_action(fs_info, ra);
 			kfree(ref);
 			kfree(ra);
+			kfree(re);
 			goto out_unlock;
 		}
 	}
-- 
2.34.1

