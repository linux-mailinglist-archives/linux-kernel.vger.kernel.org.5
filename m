Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4571A7C97B2
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 04:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233409AbjJOCrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 22:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjJOCrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 22:47:03 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D8ED9;
        Sat, 14 Oct 2023 19:47:00 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507a55302e0so885464e87.0;
        Sat, 14 Oct 2023 19:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697338019; x=1697942819; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ay7zsasRnZ/tBmxbe/iCuIZqVf1cOHfG/pAJIzyurgI=;
        b=B3AHYMvl3y2E/qqlLbbyN5AReS7itDxaHDMVH6evLHqrDxnnfMUubFtji2FgDV1xEI
         e9sQgdjUT+BMy9tQP7exijbb63SX6+6ySOMMMUm7+kD9zvABFtpscAQWi2Y5N2a77l6S
         nmMyOzu128qSpIlehJsLjfKkTW2fWAGB+x7pafy5rvnaVUjUNHugwu4Af0pJeR7VhW3L
         8dtlpZbvejBfGwCzCYjQ6oyjNmJdUhtsTZ+c7tfSIsUTvowWxINJao3Kpf4tTGzsXzDT
         X4tNBD8ZOkMJqL9gKTZY/IqTYARS0UNGoX+6kUVKQrtaO3inrnwEn7lZ0IJv+5X4hLX+
         gaqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697338019; x=1697942819;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ay7zsasRnZ/tBmxbe/iCuIZqVf1cOHfG/pAJIzyurgI=;
        b=qFmnjKvuFODb9rrni9myTA3KeoJDAHjz9gps5kaekB8RkfCTEks0qdT4TS5ivemork
         rPiB39wUS4T7Q/DWsh3awdNOSx1DxDCXm1228P9x5bFcYOAvONQJamA9z/pOwluODoD0
         aDv+q/SeqSZY5AcZaG5gTLEu7f9+6ROMDLGol73K9khZjYkIoQsmGSLrErllfSXL8MId
         T6eSRnKRVyw1l4kIQY/P/KtZ7E/6f1Lz5cfm5CQOQGH19Z1CnY6PzTEheW5/PuCQ+BHI
         aUhVYKHElPaL8MAOlq1Af9efVWyPtyonuQZjdEKHA902kOhUjSMOhCaP6MIIk/bnqz9z
         KQuQ==
X-Gm-Message-State: AOJu0Yw/84/lL1EJcD4R6WNWsUlxW/dlT7ZWyD30yW9XZFDbXcsU1Qag
        v0GXZFyBBIAuhDYy7PAnRMc3PC1lqjzlrydHyY+znBWraRdXTA==
X-Google-Smtp-Source: AGHT+IEmIABzDflRNUFixP2iO1KWgKs4v49S9NBmO9g7VZS1D6ZsUK9/D6xiOjCqJI8BESN5lFVnYo3jo1NXmZQgrM8=
X-Received: by 2002:ac2:4d92:0:b0:507:96e5:2ff4 with SMTP id
 g18-20020ac24d92000000b0050796e52ff4mr5043581lfe.52.1697338018898; Sat, 14
 Oct 2023 19:46:58 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 14 Oct 2023 21:46:47 -0500
Message-ID: <CAH2r5mtOMhHDNhjf0Lhd2nGLE4asiDex7q61fDj9qh1J6H+eag@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
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

  git://git.samba.org/ksmbd.git 6.6-rc5-ksmbd-server-fixes

for you to fetch changes up to 1903e6d0578118e9aab1ee23f4a9de55737d1d05:

  ksmbd: fix potential double free on smb2_read_pipe() error path
(2023-10-12 22:44:11 -0500)

----------------------------------------------------------------
Four SMB3 server fixes
- Fix for possible double free in RPC read
- Add additional check to clarify smb2_open path and quiet Coverity
- Fix incorrect error rsp in a compounding path
- Fix to properly fail open of file with pending delete on close
----------------------------------------------------------------
Namjae Jeon (4):
      ksmbd: not allow to open file if delelete on close bit is set
      ksmbd: fix wrong error response status by using set_smb2_rsp_status()
      ksmbd: fix Null pointer dereferences in ksmbd_update_fstate()
      ksmbd: fix potential double free on smb2_read_pipe() error path

 fs/smb/server/smb2pdu.c   | 11 ++++++-----
 fs/smb/server/vfs_cache.c |  7 +++++--
 2 files changed, 11 insertions(+), 7 deletions(-)

-- 
Thanks,

Steve
