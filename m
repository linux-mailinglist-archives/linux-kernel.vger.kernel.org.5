Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A808A7A5C4F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 10:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbjISISi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 04:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbjISISe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:18:34 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826BA11A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:18:28 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-403004a96eeso57186665e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 01:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695111507; x=1695716307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pFKz0KWwiS0pVzc4P5uzGjv0X8MPFPaaJ3s5AKyJ+TY=;
        b=CChUMqViAk9ijFZ+Sl2Vatz6hWua9FTgOycsJhTcyibs1c8Xzz9MAN/OELcBC+GXoF
         guqchm8GrRqi8LUrDqAJkih6qWGxjk+wl0rkZ1r1AIvl3OiAoKnadWPznvyU8Mr4L71Z
         3Q/JkMEQ+aDUQOEQ3R+yGShFrD3lVB/jselhDoUXT3KuxTT9ky4MaUsPwoVmbinoP1du
         WO0ubhXrw6JXwsp56VPF+KwnAksjEfj12It4P1ZtASfVd2Xh4NZT5DV3hdwcyAtatEVT
         1xbCrKZNHQMsS5NHfv8hb/izwN6gCl500JK1pqe66ywE0Ym/2dopUaA644KCZEKDlK/d
         jH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695111507; x=1695716307;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pFKz0KWwiS0pVzc4P5uzGjv0X8MPFPaaJ3s5AKyJ+TY=;
        b=b6nZvFYFf8wYyAgqPJbhN97s5BPCUrpH+TEpWsdbgN0QWL8E1pQobDP6yZ/wqtRuNm
         /LrWdn1c34It6xHVvejH02yTYOwlWCfadTs/YG2OwIdis5PYOGHy1tjYA58D1rvnVfxH
         sQS4ASXOxoTTcLB6Tldmj/WdeCV1/aTi5R+ufnSEmDeBI02Y96tS1T8iJ+5GM0Q3Q8J2
         D1xjEusOjk4qhoc3lRqC8H3shS1CFlfpSTvIPEKCGy3Vc51m+Hr9vsHRIbaFN0syY2IM
         /GptVVHAZjDJqvTREab8tZZXfZ9e3v1BTHIHHNQIOP9s6UEy9WrusV9z6QvOju3MVe8C
         FCvg==
X-Gm-Message-State: AOJu0Yxbe2eTcufCumQQO5w5WJDuD8HD6w6aje62faM/IBo5h/ajQ3R2
        XA2Np4k/56EIaLGCdAY1hXVGgw==
X-Google-Smtp-Source: AGHT+IFIA72JLXYLX9P45Y7TvbzUP8wCfKgwoFLVj3U0ZuxAO8wVqrE454TPVH/lN3031fnF4Cnvpw==
X-Received: by 2002:a5d:404c:0:b0:319:7abf:d8e2 with SMTP id w12-20020a5d404c000000b003197abfd8e2mr10936570wrp.24.1695111506898;
        Tue, 19 Sep 2023 01:18:26 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f209c00529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f20:9c00:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d560a000000b003142e438e8csm14687115wrv.26.2023.09.19.01.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 01:18:26 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     Max Kellermann <max.kellermann@ionos.com>,
        "J . Bruce Fields" <bfields@redhat.com>, stable@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fs/ext4/acl: apply umask if ACL support is disabled
Date:   Tue, 19 Sep 2023 10:18:23 +0200
Message-Id: <20230919081824.1096619-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function ext4_init_acl() calls posix_acl_create() which is
responsible for applying the umask.  But without
CONFIG_EXT4_FS_POSIX_ACL, ext4_init_acl() is an empty inline function,
and nobody applies the umask.

This fixes a bug which causes the umask to be ignored with O_TMPFILE
on ext4:

 https://github.com/MusicPlayerDaemon/MPD/issues/558
 https://bugs.gentoo.org/show_bug.cgi?id=686142#c3
 https://bugzilla.kernel.org/show_bug.cgi?id=203625

Reviewed-by: J. Bruce Fields <bfields@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/ext4/acl.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ext4/acl.h b/fs/ext4/acl.h
index 0c5a79c3b5d4..ef4c19e5f570 100644
--- a/fs/ext4/acl.h
+++ b/fs/ext4/acl.h
@@ -68,6 +68,11 @@ extern int ext4_init_acl(handle_t *, struct inode *, struct inode *);
 static inline int
 ext4_init_acl(handle_t *handle, struct inode *inode, struct inode *dir)
 {
+	/* usually, the umask is applied by posix_acl_create(), but if
+	   ext4 ACL support is disabled at compile time, we need to do
+	   it here, because posix_acl_create() will never be called */
+	inode->i_mode &= ~current_umask();
+
 	return 0;
 }
 #endif  /* CONFIG_EXT4_FS_POSIX_ACL */
-- 
2.39.2

