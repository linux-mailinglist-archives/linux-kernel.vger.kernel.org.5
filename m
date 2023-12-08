Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 898E080AFDC
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 23:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjLHW05 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 17:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbjLHW0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 17:26:55 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0F71710;
        Fri,  8 Dec 2023 14:27:01 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-50bfd7be487so2948165e87.0;
        Fri, 08 Dec 2023 14:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702074420; x=1702679220; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TZod9n+20CdIqGbbIh44fnE2S5YQ4gpQxwyERB4BCS8=;
        b=XgI+bU/PuEGIk24WDbeoDRD5N/ZMvfA1rZqb7pH2/zyH6NIoR6EXHv4uGhYKMmP0OK
         4euCiABg0jkG9A6aePHvwNMc223OlV12hU1NLORlyTltCZX83ojFKU/gRp7PjMwx/ujJ
         6lOfDf3ALyYVGPTAqI1MW20V288ZgBv0bqZ6ejPVtwDIoB5Baoj4sQTeJKr2zW+n1bRb
         ak6h172u0798kEEYi9kqMHHkXyoapa29qqoOIUbT/+OLv10Gv/j21ei6UHZIHl9GSLSB
         2rDUi1PmkzWmptIHJLsbBU/NptV6z94SMkcBke6XNv/gE40rtViYkay3pmuY/5BkkVd3
         vtSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702074420; x=1702679220;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TZod9n+20CdIqGbbIh44fnE2S5YQ4gpQxwyERB4BCS8=;
        b=WXRjDiCq7Mmwwh9BnjBmPfRgLeIlUlcB0jZ042L2LD6VCadJtf9RKHdD72uP3cuD/0
         +77LDABEughiegAFBG7P9KxSu5g4crhSdX1WugFl1HcbVg9PRDPzgk0pv4jfG1xEW77g
         NZzBT6zuOv+Kvtqo0waH8DWKNVTTXFjNKZ5Hgg8Ttr+fzF9MXPZkrQPsAFtBxwz7xis4
         opCbu6sVOUaQM/q/F5qL8A7zBP+TYjp99Yj41/aLyV1Krh0znYFzOor1KHe/QqcwE48K
         zTpW+LbpszF+OKrK7L9CrNemYHSJKWRsoF91BKGtVSaVdhfFoGyPQZdSEcXYA7H+BkEm
         TpBA==
X-Gm-Message-State: AOJu0YxzttUUAeIGO4Amllzy8Y6WJSwb5Ndv6mH6PxFtIAwpS/zqswjn
        zSNJx3vaNzmmSst32H96qE3NGsVM8+yRr7dGCnSJRKpUrGf7Kg==
X-Google-Smtp-Source: AGHT+IHCgjf6q6ES62d3fEbLVg1h70EEekTOpdH3s1Elg7U6zlEnK7HN6v2iPyMpFhzwFkOlndUae9cBXKMJeLzzELI=
X-Received: by 2002:ac2:4dbc:0:b0:50b:f154:1802 with SMTP id
 h28-20020ac24dbc000000b0050bf1541802mr294137lfe.64.1702074419607; Fri, 08 Dec
 2023 14:26:59 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 8 Dec 2023 16:26:48 -0600
Message-ID: <CAH2r5mtBLhwXUy3KtDxuqAnUJnxav=GFsR+V6ejp1XHpYaDmrQ@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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
33cc938e65a98f1d29d0a18403dbbee050dcad9a:

  Linux 6.7-rc4 (2023-12-03 18:52:56 +0900)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.7-rc4-smb3-client-fixes

for you to fetch changes up to 04909192ada3285070f8ced0af7f07735478b364:

  cifs: reconnect worker should take reference on server struct
unconditionally (2023-12-06 11:04:23 -0600)

----------------------------------------------------------------
Six smb3 client fixes:
- Fixes for copy_file_range and clone (cache invalidation and file
size), also addresses an xfstest failure
- Fix to return proper error if REMAP_FILE_DEDUP set (also fixes
xfstest generic/304)
- Fix potential null pointer reference with DFS
-  Multichannel fix addressing (reverting an earlier patch) some of
the problems with enabling/disabling channels dynamically

Still working on a followon multichannel fix to address another issue
found in reconnect testing that will send next week.
----------------------------------------------------------------
David Howells (3):
      cifs: Fix flushing, invalidation and file size with copy_file_range()
      cifs: Fix flushing, invalidation and file size with FICLONE
      cifs: Fix non-availability of dedup breaking generic/304

Paulo Alcantara (1):
      smb: client: fix potential NULL deref in parse_dfs_referrals()

Shyam Prasad N (2):
      Revert "cifs: reconnect work should have reference on server struct"
      cifs: reconnect worker should take reference on server struct
unconditionally

 fs/smb/client/cifsfs.c  | 174 ++++++++++++++++++++++++++++++++++++++++++----
 fs/smb/client/connect.c |  35 +++-------
 fs/smb/client/smb2ops.c |   2 +
 fs/smb/client/smb2pdu.c |  34 +++++----
 4 files changed, 187 insertions(+), 58 deletions(-)


-- 
Thanks,

Steve
