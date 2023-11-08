Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97827E588E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 15:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbjKHOUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 09:20:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbjKHOUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 09:20:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD018171B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 06:20:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BD8DC433C8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 14:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699453239;
        bh=44I87NxHimpYa4+A22pdvojzN0g88SEJqsaIONesthE=;
        h=From:Date:Subject:To:Cc:From;
        b=LkD8nd5CVXkrlSnPwVV8gV1flDM7jtU+cEPeuG0R/I9cmafn+EOWzAcjGOK8nQI6d
         ECab/RNDaSRZ5yGRXGqpi4aSLLupCsz+H0FoOkcDxnbU6HrBC+TgNl31Vo48AsDsLj
         H5XZbCzwIizfstMDvU54P2zJObkzMF64tbPU6oa8YF1+FzoQQga/+9D8c9S2Tfxzsu
         9sXJkrflEDNVBozf+UC+aMcuHL3pwQwBqxufJZuAtuiM1bbsYpn1hPXYiEEJjxvjYN
         mPnJcj6t8JT1Zhk4b2xIS1Zo02pdGicIjoxGgm/+IFjOwjs0ATaxXndcgFQhjWYlQu
         tGO4PUGIM2sMA==
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6ce2d4567caso3908148a34.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 06:20:39 -0800 (PST)
X-Gm-Message-State: AOJu0YwpFrOI5Xugkhc0JnfWEA/zTv3QhzeHAu8zY5OOjXlruFIo3iuC
        lQ8VZmGwy+rzYKbHmxNODNN7mF+hiFgS0/3IUbk=
X-Google-Smtp-Source: AGHT+IHu3N0N3UWQd+1bXKRwyhqCNmYSrVhDDziZ/mIxs9/zCq5bH3xktdXs2HXw5YMBJlsxUzBjdGQXCk/kREZhSB4=
X-Received: by 2002:a9d:6942:0:b0:6bc:cd0d:427e with SMTP id
 p2-20020a9d6942000000b006bccd0d427emr1834767oto.38.1699453238694; Wed, 08 Nov
 2023 06:20:38 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ac9:67d1:0:b0:506:a3fc:1021 with HTTP; Wed, 8 Nov 2023
 06:20:37 -0800 (PST)
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Wed, 8 Nov 2023 23:20:37 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-rB+hXUVbCgnRebSsRMH8AK0XzOGJRLqAPX9GFa_9_Kg@mail.gmail.com>
Message-ID: <CAKYAXd-rB+hXUVbCgnRebSsRMH8AK0XzOGJRLqAPX9GFa_9_Kg@mail.gmail.com>
Subject: [GIT PULL] exfat fixes for 6.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

This is exfat fixes pull request for v6.7-rc1. I add description of
this pull request on below. Please pull exfat with following fixes.

Thanks!

The following changes since commit 8f6f76a6a29f36d2f3e4510d0bde5046672f6924:

  Merge tag 'mm-nonmm-stable-2023-11-02-14-08' of
git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm (2023-11-02
20:53:31 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
tags/exfat-for-6.7-rc1-part2

for you to fetch changes up to 1373ca10ec04afba9199de1fab01fde91338a78b:

  exfat: fix ctime is not updated (2023-11-03 22:24:11 +0900)

----------------------------------------------------------------
Description for this pull request:
  - Fix an issue that exfat timestamps are not updated caused by
    new timestamp accessor function patch.

----------------------------------------------------------------
Yuezhang Mo (2):
      exfat: fix setting uninitialized time to ctime/atime
      exfat: fix ctime is not updated

 fs/exfat/file.c  | 1 +
 fs/exfat/inode.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)
