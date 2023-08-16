Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E775677D785
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 03:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240986AbjHPBO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 21:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240988AbjHPBOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 21:14:38 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C3922121
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 18:14:37 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d6b66b41232so2557379276.0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 18:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692148476; x=1692753276;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=H9VD/R3G+MRr4pzWPFKTK91k5G484Ke6ASD3dpiheZk=;
        b=7SGqYnHcvzgKqDQAOT64GfSHs8LSnxqu4EdXwePI/U0odcpJhxnbXwnY/Pij2PVe0P
         svipqTfLgv56/AMAz9ICoYJqkC7QIUZfasne9wgDdmsHSC8OH8H41yUTx6DP92cYmaCn
         /zbPoMlul7yqVynoW0xkkpH446u7aYYw63jIgEyplEzhLp9Jl+0Ecd67xiKNkOf01yXr
         zE3/gNBZU1SN+oAOWRZNI50/pOurCPTZXcG6/OkNdloQjgmr4ZnHDq76m6SEzSgAgQdh
         Odn8JWDs2AVnkgibZNfGmtlHIQnkCL3uwBB9JPzPT2V2fy9qhJvwun31Ej+hL1HwjHJi
         tASQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692148476; x=1692753276;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H9VD/R3G+MRr4pzWPFKTK91k5G484Ke6ASD3dpiheZk=;
        b=hSRgwjNhgcaxOKliFha60/rtEFF/D2tGibvf8DUIVtEu1DObGMn+aU1KupTs/nEH8A
         g+qfgZQ96Gtjw5ghdqtTwkqWCfh6DXAvkNBDNBUC/ws4TQKJkWvTYts73Q5vTE6qVttW
         qJvkhecggkLNSqZ8Jq3E4gvMtSQL8xrSwfrRv+iuRyY6Ir3fh6t4YK4qcN6Zhmtdgcus
         FwhGY8S3NJNI1uXIgGDGJHvFS1G96Mo0hslqoORfcN75rl/WJFdpxmg1xrdfKxilDggb
         2Xzf14lLfA6bWENFqDNmVgZqL7DnTUwRHbkInvSRQJUuvDVCqIM8SbnLDNAMGC8TCGgM
         P3BQ==
X-Gm-Message-State: AOJu0Ywhyg59Tr5Y+QTJy8lGgaW8f4wWb0tb52+T1L2C7g5j+Ww/BIXm
        owX5wWuXlj2pzLLCkBoKNuafLgy/Y3A=
X-Google-Smtp-Source: AGHT+IHRLlIGGNwPaRpxAIIhl1cJ1s0NCl5PXS5Bil58d1WAv6OI7FtfbwHuY4ImazllyImjOZPmj1JFiGc=
X-Received: from drosen.mtv.corp.google.com ([2620:15c:211:201:19fa:33cd:f272:37ec])
 (user=drosen job=sendgmr) by 2002:a05:6902:a08:b0:d42:5cb6:31ff with SMTP id
 cb8-20020a0569020a0800b00d425cb631ffmr6364ybb.8.1692148476757; Tue, 15 Aug
 2023 18:14:36 -0700 (PDT)
Date:   Tue, 15 Aug 2023 18:14:31 -0700
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230816011432.1966838-1-drosen@google.com>
Subject: [PATCH 0/1] Add 16K Support for f2fs
From:   Daniel Rosenberg <drosen@google.com>
To:     linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        Daniel Rosenberg <drosen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

F2fs filesystems currently have two large restrictions around block size.
The block size must equal the page size, and the block size must be 4096.

The following patch, along with the associated f2fs-tools patch set, relax the
latter restriction, allowing you to use 16K block size f2fs on a 16K page size
system. It does not allow mounting 4K block size f2fs on a 16k page system.

Doing that would require a lot more work, requiring a refactor of all block
sized struct similar to the userspace patches, as well as handling the block
reading/writing at sub page boundaries. As far as I know, buffer_heads are
still the main way this is handled in other filesystems. Is there a different
option there? I know there's a general desire to move away from buffer_heads,
but I don't know of any replacements covering that use case. And it would feel
a bit silly to not be able to read older filesystems from a 16k system...

Daniel Rosenberg (1):
  ANDROID: f2fs: Support Block Size == Page Size

 fs/f2fs/data.c          |  2 +-
 fs/f2fs/node.c          |  2 +-
 fs/f2fs/super.c         |  4 +--
 include/linux/f2fs_fs.h | 69 ++++++++++++++++++++++++-----------------
 4 files changed, 45 insertions(+), 32 deletions(-)


base-commit: 0cc81b1ad51287847e494e055e5d3426f95e7921
-- 
2.41.0.694.ge786442a9b-goog

