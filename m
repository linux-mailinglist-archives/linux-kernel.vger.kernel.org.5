Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA0D754F26
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 17:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjGPPAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 11:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjGPPAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 11:00:19 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308B2E4A;
        Sun, 16 Jul 2023 08:00:18 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b702319893so53156981fa.3;
        Sun, 16 Jul 2023 08:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689519616; x=1692111616;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jD4sl620oHCFNPW2ivfKXJBTArv08seFBzkkGNHo2qY=;
        b=RJ6HyMTl0mmLuKESQACae3ajrUSFBawEFI0w1q/QgjpaKFsrH6MoGXhbhRWkkRnsyS
         lIpl95+19Stz8nOZekJWkmGdcbQUeXyrYLm2xYHaKkzTOLSZUwLj8I5qFCp9dZHVZSO1
         j3relKunI4uM3utNhCdG1tJeomf25ZDX26hgXZuNoiDNkUHoA4cooEyOKA+VDkcgtzfp
         Syh7ukeLRmI53fMnv2d8doFjcMcwuasR22TIWxBZ8dLGO3BWnVDqVILyhYM7BR6el4Ea
         RUOvpa+llChOb5ydZhBS/TsUl4XxsGtM+lNHJmU71S/Jh7JHq5mP6CtrC0aoFGVv/ejg
         Cgww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689519616; x=1692111616;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jD4sl620oHCFNPW2ivfKXJBTArv08seFBzkkGNHo2qY=;
        b=DC1binskGu4KDzOCIAO7qERNPyPcz1mq1ZlJtkA9kqx862hvrMFxZZtehP4zXNAgrU
         PyZe0XHERhdlgVOR+eMiVs7vtUgNQmIJgJXYXEIKC4lH5EkSXlcWnGwOfAisAA8QHNBu
         YyKULdylNdnZm7oD9KCG+2e39uiCuLcnC1wPehRlv6RNv+6GqTbfZXL2I3/L+9MJGmIv
         6vrWFbhtbC5nwr5dyZ/sE9SClAx4FvvnEEV42HMRZfNk3gm6mcN6CA3731Lv4zbWwnsM
         7PoLr57d9vqd04/rM/vk1ykVYGj+qNu6jBSGSbwwceWUWppFIxaw7L+LtydyFSmYyW6e
         8dqA==
X-Gm-Message-State: ABy/qLYb7rOtge+jDd85ERvX1ZiIRBcDZT3uIoj6RET8bRCESVrePk+0
        S17kBHOHPYK3v+ZuUTvVUGQOIij7+tVhsGa/oxMgUsfNYlA=
X-Google-Smtp-Source: APBJJlHNn+DGwc/3aB63+QcXY/w7F88xSfNYIU8A7/CJiqveahU5GxwunajYq5j2myL5WfZ65mGmdPj/rO6W77RJn4Y=
X-Received: by 2002:a2e:868b:0:b0:2b6:a186:52ac with SMTP id
 l11-20020a2e868b000000b002b6a18652acmr6562087lji.47.1689519615882; Sun, 16
 Jul 2023 08:00:15 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 16 Jul 2023 09:59:59 -0500
Message-ID: <CAH2r5mu_m5J8Nxop9Of133-g3KgGydrX0-TMrFJt08zOVcYg=g@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.5-rc1-smb3-fixes

for you to fetch changes up to 69cba9d3c1284e0838ae408830a02c4a063104bc:

  cifs: fix mid leak during reconnection after timeout threshold
(2023-07-14 11:25:08 -0500)

----------------------------------------------------------------
Five SMB3 client fixes
- Two reconnect fixes: important fix to address inFlight count to leak
(which can leak credits), and fix for better handling a deleted share
- DFS fix
- SMB1 cleanup fix
- deferred close fix
----------------------------------------------------------------
Bharath SM (1):
      cifs: if deferred close is disabled then close files immediately

Gustavo A. R. Silva (1):
      smb: client: Fix -Wstringop-overflow issues

Paulo Alcantara (1):
      smb: client: fix missed ses refcounting

Shyam Prasad N (2):
      cifs: is_network_name_deleted should return a bool
      cifs: fix mid leak during reconnection after timeout threshold

 fs/smb/client/cifsglob.h      |  2 +-
 fs/smb/client/cifssmb.c       |  2 +-
 fs/smb/client/connect.c       | 30 +++++++++++++++++++++++-------
 fs/smb/client/dfs.c           | 26 ++++++++++----------------
 fs/smb/client/file.c          |  4 ++--
 fs/smb/client/smb2ops.c       |  8 +++++---
 fs/smb/client/smb2transport.c |  2 +-
 7 files changed, 43 insertions(+), 31 deletions(-)


-- 
Thanks,

Steve
