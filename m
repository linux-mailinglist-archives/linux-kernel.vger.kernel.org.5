Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C61E7C979E
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 04:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233380AbjJOCQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 22:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjJOCQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 22:16:10 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E08D6;
        Sat, 14 Oct 2023 19:16:07 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50573e85ee0so4094547e87.3;
        Sat, 14 Oct 2023 19:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697336165; x=1697940965; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CqVE6uodm+iyb6Wqc7ayNNI6THJDNZR8gRKY9AL1+Rg=;
        b=nRoBLHMBEGnq0B9XK8X3Ct2P7PLfznhN+qZw/Mus7LXBe+k9TsmOpljuJb7AMFW8tg
         /eIjoXObjy5RLEeS4yaNNEIwjwGf+7RChi1Ar3jOv+cDPV6Z1hlggR5KT9uEJFhv7Rz4
         BzrF8Igzg1Ts1rRQRYDuDhoa55E5pKArUOQWg1w+JDSylYjFe/oMwRlgOlL61EPzQHEg
         7C5Nhsjk+Ec+4IiCDHNSj4F1Lr97z4L4MZWB2mGuw88Olu3WisCDf/SrZXEcaDjeDF1g
         CKC84Tk4d79Q41XqbLixThSP7KArICy4nkpPS1KbIuyWuaRdFJEdTDBL+O6835jjGQdP
         pmrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697336165; x=1697940965;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CqVE6uodm+iyb6Wqc7ayNNI6THJDNZR8gRKY9AL1+Rg=;
        b=dG/2y7PO05NhD4gtWSm1b2SbyqirOpGvd7Z8Y2pcx81MhaXLI9KKh97OLj4dX7jkvo
         tv4gD6jpasrI4SsN2YtjQkTCf0XNtzMnhqnGtln7dkTi+DCIJteIfBNK/O0LX0+KSRXo
         zWKfjlYAtBOnQXsMD4bWEXYla94RfiW1zgckIrrr6S9l5YJFH92ai4tmeClP4r3Z5sjN
         0y9h+3oC7oR2tgsJkLEvZXHD3uix0m7rV+PM24LMWNuVnp8fjjyZKDW6wClH6IolQe/J
         f098ElQeWKOuRTWRNq38k3XPWYUy471UcQRD88hRNkxmCCEyomnQcO8k+sciJpsxOHcE
         Py8g==
X-Gm-Message-State: AOJu0Ywel3kGZ+PZUQMc5CUaIBQSAgk+P9N/46eHjSZ5XOgE6TPslz0Y
        6/eWQPgxOJJggJ8YHr9qPo4V5H1JE9hnOyacmqPMaCgkMu8=
X-Google-Smtp-Source: AGHT+IHKx5dK8HN6Ub70InFkq5cz+jMHeSY+Ijdez+ueCMPXXZfFXC5hAdiXfX89AKweVDJBSeS7Z8aiNl1+l+W6dKU=
X-Received: by 2002:a05:6512:3f10:b0:500:be57:ce53 with SMTP id
 y16-20020a0565123f1000b00500be57ce53mr31645337lfa.42.1697336164883; Sat, 14
 Oct 2023 19:16:04 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 14 Oct 2023 21:15:53 -0500
Message-ID: <CAH2r5ms0UzM_VjC6rUjyYX5X1dR2Jxp3t9_fSoqw_0h2zqk4qg@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
94f6f0550c625fab1f373bb86a6669b45e9748b3:

  Linux 6.6-rc5 (2023-10-08 13:49:43 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.6-rc5-smb3-client-fixes

for you to fetch changes up to 81ba10959970d15c388bf29866b01b62f387e6a3:

  smb: client: prevent new fids from being removed by laundromat
(2023-10-12 09:41:32 -0500)

----------------------------------------------------------------
Two SMB3 client fixes
- Fix caching race with open_cached_dir and laundromat cleanup of
cached dirs (addresses a problem spotted with xfstest run with
directory leases enabled)
- reduce excessive resource usage of laundromat threads

----------------------------------------------------------------
Paulo Alcantara (2):
      smb: client: make laundromat a delayed worker
      smb: client: prevent new fids from being removed by laundromat

 fs/smb/client/cached_dir.c | 141 ++++++++++++++++++++++-----------------------
 fs/smb/client/cached_dir.h |   2 +-
 2 files changed, 69 insertions(+), 74 deletions(-)


--
Thanks,

Steve
