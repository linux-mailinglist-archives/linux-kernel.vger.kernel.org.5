Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773AE7F9175
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 06:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbjKZF0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 00:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKZF0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 00:26:07 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FF9CE;
        Sat, 25 Nov 2023 21:26:13 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50aab20e828so4624063e87.2;
        Sat, 25 Nov 2023 21:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700976371; x=1701581171; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XU0TRDEiogUmhBiqOshigQkhmH3QUgJ6MV2/oP6qstA=;
        b=BaNlCZf1HJ07guQQoLZqDnlKotQRK1cPHd+/uown4trzK2b5meI+vKOlauB6e4xIwg
         jEgCAlCV1RutpMSDAchpcScDICLkt/k+TF1VzNBMlcG/yOr1vL/SCLnXw73gxgNn5tDx
         dOR+K2drocEOLmbAGzbljIEmb8ofaZk8W55Sge1Ylq+AI9NTTfPMwkBzcrzumzjxdxEw
         g5iy7xLvsk4GJcS4ceQ6A0kpNRuW1Zb4FH4mEv6CB3gpDwfQ8DUauYG/wdA16r6kwFdP
         eQYLSmS3WmhPcoW1UIn9cHVR6bYPAILYpdcDz276/oLWUrkRF6FAnZm5evXMJ08lfVhF
         AtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700976371; x=1701581171;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XU0TRDEiogUmhBiqOshigQkhmH3QUgJ6MV2/oP6qstA=;
        b=LN5n22V6T1139h2aZPbPeIIYGfM3OoSvSFguP3sFrLmvDa6v7isBmwnryCRqnuCOEM
         1iak2fmtcEtl1Ai0JH48Orrg4hNquk4WGxXwmLvQ7MnLzFNmirD6DnmJngElPkb/4uaI
         FHQpgtAd6ZEYqE8Oh6QM0W9PDV9mmXeRkzp3OspnKhuIXL6H4T5FyWO2EIbCtBTY8mYM
         RY3HAuBccXwqr0ZOTYxKN5El6ZByR8do/70AXoNEGk87M1B/dxnhCefbgdurPxS6vw3p
         jvTREtTR3fw7yenTaRicNQ9fgNgBBZbiWtvM1m909cY/xporIukcRJDwW+cj2fAkQXpR
         oKeA==
X-Gm-Message-State: AOJu0YzUjivQY8GSi9SPYg/GGxAamqHZ45BGhEF1+B67ACC7r8EmiJX3
        URw8Fd0Xb0NNh7K5u2mRozrEf3NBrnJvGqj/6O1CTNJVzLh5sg==
X-Google-Smtp-Source: AGHT+IHqNi35gn66DTSyR2qorB2aTwWKQwlGJdVj8SMW4yb9GNS3EYaBsph4pvkHIK4HfTxIBzhDeif5wuzEiaCUdgY=
X-Received: by 2002:a05:6512:280d:b0:507:ba75:b016 with SMTP id
 cf13-20020a056512280d00b00507ba75b016mr6927777lfb.3.1700976370939; Sat, 25
 Nov 2023 21:26:10 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 25 Nov 2023 23:25:59 -0600
Message-ID: <CAH2r5mtFbhGETfqO=qE185xWY+82Yv2AF3BoOH5TLa8_TnY35A@mail.gmail.com>
Subject: [GIT PULL] smb3/cifs client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
98b1cc82c4affc16f5598d4fa14b1858671b2263:

  Linux 6.7-rc2 (2023-11-19 15:02:14 -0800)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.7-rc2-smb3-client-fixes

for you to fetch changes up to b0348e459c836abdb0f4b967e006d15c77cf1c87:

  smb: client: introduce cifs_sfu_make_node() (2023-11-23 11:46:05 -0600)

----------------------------------------------------------------
Five cifs/smb3 fixes
- use after free fix in releasing multichannel interfaces
- fixes for special file types (report char, block, FIFOs properly
when created e.g. by NFS to Windows)
- fixes for reporting various special file types and symlinks properly
when using SMB1

----------------------------------------------------------------
Paulo Alcantara (4):
      smb: client: implement ->query_reparse_point() for SMB1
      smb: client: introduce ->parse_reparse_point()
      smb: client: set correct file type from NFS reparse points
      smb: client: introduce cifs_sfu_make_node()

Ritvik Budhiraja (1):
      cifs: fix use after free for iface while disabling secondary channels

 fs/smb/client/cifsglob.h  |  14 ++++-
 fs/smb/client/cifspdu.h   |   4 +-
 fs/smb/client/cifsproto.h |  14 ++++-
 fs/smb/client/cifssmb.c   | 193
+++++++++++++++++++++++----------------------------------
 fs/smb/client/inode.c     |  74 +++++++++++++++++-----
 fs/smb/client/readdir.c   |   6 +-
 fs/smb/client/sess.c      |   2 +-
 fs/smb/client/smb1ops.c   | 153 ++++++++++-----------------------------------
 fs/smb/client/smb2inode.c |   2 +-
 fs/smb/client/smb2ops.c   | 227
+++++++++++++++++++++++++++++++++----------------------------------
 10 files changed, 314 insertions(+), 375 deletions(-)


-- 
Thanks,

Steve
