Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1032D7C98E3
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 14:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbjJOMBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 08:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbjJOMBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 08:01:40 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1F6A3;
        Sun, 15 Oct 2023 05:01:38 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-503056c8195so4647213e87.1;
        Sun, 15 Oct 2023 05:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697371297; x=1697976097; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4OuWWe6QQQ7t0Q2G9sE2ZPxCechLHmlPfkSrhfWa6Hw=;
        b=TgAZQaCgN6C+VRVM7SUfR2f6FSAvs7ZKGF8sZ2pTfCbOSMiQhsCXm15v1zLgMtVIQi
         yszAqUf1X6aXdZstnkG3EmQ2/hT15Ud+aKv4nbllSuUAVinLeqp7K5hOPk/z0z/2XfMS
         T7oMpdQ7KJ2TIdfX9lws1wHebEX4a38T18daKNVoRzjHkLUwq+Huvn1YsLGI+OC1KgCn
         aNJQqmy2GTgc6i9IoFQjGWiN2c0DlIDgsPFNjdnI1V7ktFBG7JIoqsoqfPsvvKQdBefl
         Vxv52BG8WFcZZrH6+X8THQc0kREYVUq9m5Xtvv2CexvZEmjG9/ADJCJC2/ZGJ+FS/01E
         MAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697371297; x=1697976097;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4OuWWe6QQQ7t0Q2G9sE2ZPxCechLHmlPfkSrhfWa6Hw=;
        b=QFnV5wmhe/DYIxwAqlqRFBPBjQGCvkMUt8RzQuilkksLk9XrmmrSwl5/YfECLALHjU
         FfO8Bxgemv1VFI5SsVSpnPuhI6C0gV6+2uGkidCD26H7BkQnNsoFIISvLGLlD8N8P9HY
         HKdnkWoko06RDhIfxq7p9AvmGpBD56lN+9i5bFWq9bSHmjHRzou9WQmdL6QIbzlpEAl4
         mh9Zwvj9floxZNzzDYytcKmuUa3Oj5IYE71A1Gxtm2l4cgQKzTIAVEuTz+TYNcoGqLyl
         erdWETRwyIgMH766HDkhdUfbp14UBKISphlpsuxJovO1y+j2FHXOJDo6PKYcWjotvEQs
         M6uw==
X-Gm-Message-State: AOJu0YzOq3/Cc86TXT0+jYIL9lSjz2CCMJEtZRf/vHyx8gBePegaz7CA
        34uQGI0ul7466jJC7yfOdGo=
X-Google-Smtp-Source: AGHT+IGhrE9ChjUoxmFts7+WdcHBP2dzl4UkKzYgopix7KiHwbmZmJ3OLyDI24d2TGBpWYtTVaevPA==
X-Received: by 2002:ac2:560c:0:b0:507:9745:8629 with SMTP id v12-20020ac2560c000000b0050797458629mr5702913lfd.55.1697371296520;
        Sun, 15 Oct 2023 05:01:36 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id j11-20020a056512344b00b004f13cd61ebbsm1106601lfr.175.2023.10.15.05.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 05:01:27 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Christian Brauner <brauner@kernel.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-unionfs@vger.kernel.org
Subject: [GIT PULL] overlayfs fixes for 6.6-rc6
Date:   Sun, 15 Oct 2023 15:01:17 +0300
Message-Id: <20231015120117.2131546-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull overlayfs fixes for 6.6-rc6.

An earlier version of the fixes branch:

 001cef5143c3 ("ovl: fix regression in showing lowerdir mount option")

has been sitting in linux-next for a few days.

Since then, I have made two small changes that Miklos requested.
Alas, the linux-next tree was not updated since next-20231013.

This branch has gone through the usual overlayfs test routines and it
merges cleanly with master branch of the moment.

Thanks,
Amir.

----------------------------------------------------------------
The following changes since commit 94f6f0550c625fab1f373bb86a6669b45e9748b3:

  Linux 6.6-rc5 (2023-10-08 13:49:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs.git ovl-fixes-6.6-rc6

for you to fetch changes up to beae836e9c61ee039e367a94b14f7fea08f0ad4c:

  ovl: temporarily disable appending lowedirs (2023-10-14 22:42:45 +0300)

----------------------------------------------------------------
overlayfs fixes for 6.6-rc6:

- Various fixes for regressions due to conversion to new mount api in v6.5

- Disable a new mount option syntax (append lowerdir) that was added in v6.5
  because we plan to add a different lowerdir append syntax in v6.7

----------------------------------------------------------------
Amir Goldstein (4):
      fs: factor out vfs_parse_monolithic_sep() helper
      ovl: fix regression in parsing of mount options with escaped comma
      ovl: fix regression in showing lowerdir mount option
      ovl: temporarily disable appending lowedirs

 Documentation/filesystems/overlayfs.rst |  12 ++++
 fs/fs_context.c                         |  34 +++++++--
 fs/overlayfs/params.c                   | 119 +++++++++++++++-----------------
 include/linux/fs_context.h              |   2 +
 4 files changed, 98 insertions(+), 69 deletions(-)
