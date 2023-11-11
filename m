Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 084227E86FD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 01:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345006AbjKKAoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 19:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344933AbjKKAoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 19:44:00 -0500
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E0A3C3D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 16:43:57 -0800 (PST)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6c334d2fd40so2769385b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 16:43:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699663437; x=1700268237;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=39TGkBSttqT5gX88OYPWAq3lJ31a7Beblx9sw9fQezk=;
        b=rHyuVr7PiiI+F21H6NIAin3K7nm5fb3OTEBxqDJvjrXzP6/Ycp7fCFeSVlBnl8+iho
         jOMHWJOeFN/suo2m0uxaFhlMZC7sLSbsFg8lrzp7xKuRRLFazR7DGYsymWGOJ5P3reO0
         Rqyvk/FVwR8a6Mv5x3mixMFTnTGBJIUmXMKpbLdvrx8yLeAQ1TyUIKwSPhPh7KiDHRn9
         sJD1OsprRLzCRiyTSKG1LZj0edDSpRVP+WNALr5oAVXizDcoXnCT7hOVE7+2o+bEcvVQ
         lHIi6KYkCnzoXeEtZhVXw+jDMGZChPGV+siVi8XrwnGFuq8J6wv4VTDKSoR8f0K9mHZH
         JzAA==
X-Gm-Message-State: AOJu0YwdnlA/WjpwZHVoqu7bAH9vR3T9ZqYV+6CpzFJ77grqIYBRqUos
        vDUlQRL1aaJEOsNTohMeERUDotyCTUaasp6MpAWbmyFfSEKYNZU=
X-Google-Smtp-Source: AGHT+IEml5QikEDeny0CjXB1QgNedzWRjyCbgaAKnMlTPzgtjYDtPaOeaba/7uWUC38XCNtmJ19sWgZlnnu2PTVc4cPXv9yKLM1m
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:8a81:b0:6c3:1b4d:309e with SMTP id
 id1-20020a056a008a8100b006c31b4d309emr142294pfb.0.1699663436472; Fri, 10 Nov
 2023 16:43:56 -0800 (PST)
Date:   Fri, 10 Nov 2023 16:43:56 -0800
In-Reply-To: <0000000000001959d30609bb5d94@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005e693e0609d5bb12@google.com>
Subject: Re: [syzbot] [PATCH] test 305230142ae0
From:   syzbot <syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com>
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 401ea09ae4b8..d2b6e4d18c89 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -4931,7 +4931,8 @@ int btrfs_get_free_objectid(struct btrfs_root *root, u64 *objectid)
 		goto out;
 	}
 
-	*objectid = root->free_objectid++;
+	while (find_qgroup_rb(root->fs_info, root->free_objectid++);
+	*objectid = root->free_objectid;
 	ret = 0;
 out:
 	mutex_unlock(&root->objectid_mutex);

