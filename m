Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A1376812F
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 21:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjG2TIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 15:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjG2TIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 15:08:07 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4019A1A8;
        Sat, 29 Jul 2023 12:08:06 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9a828c920so50283381fa.1;
        Sat, 29 Jul 2023 12:08:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690657684; x=1691262484;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GAE2z1sqOQ4U7Z2OAsMeFxw8EZ6FViB9HKo0vEztFf0=;
        b=CSWr4cdu86ei1TwsLLrFcabgBGbN4Hk/7zcuuBFeRHYfNbmxmCwJ7KkH9fKthmFGXm
         7YrlLNPSXXc7iBFK7eV4AEpbvjhQVmh6CXcx/AOPzwThXcdED4PXZSMjvvG0jSGXKzlw
         KkfAxzwnoOa7T5DM+ebPGJuFpA+WtOT7i4/fYAPaZqc5hIl4r74QJrShOkJSaDJGHojv
         su1HF2qcIQBLiFwnheOPCwp9y068sA8TWXS735g92MgJlJJjmp7vjd1U/y3aWZ7yTZRX
         BmFZggQuThCRLhYBE/3GSGMX1vKs7mxdhjixHf27wMQGto4g/5qGxpeD717bd5bxu9JW
         M5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690657684; x=1691262484;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GAE2z1sqOQ4U7Z2OAsMeFxw8EZ6FViB9HKo0vEztFf0=;
        b=KrQyms/QrVNyF44XHcnaRA4/aPjbDnSpHd+w+2RnSj4WLciMGOA77uvZ30vvn/tLR5
         H67RVoYTEoJIrzC1sxIIwJ1EFNIDAUjD5N443UfJY9hGb16oKk0l3fQoUY3LGo8+3sjp
         hBbH/18C+EBQ/PExr8Q1YyaNmN0fSRRBG1cNYkm9DIkr9ktcS49WyLdEIMNqu7wOmMNx
         D9koQgGoxCK3jRJD3LLLPwJiL3OhostP9tDbFl4FfAvQzvpPlri9LLF8ziVuXlvwxoir
         D5LqZRqk/l+sX8JtI4QFxrhtJTSxHjQDG0r3y7sctdC+Tv5RiBwRjQ14KwsXawOHRIa3
         SWOg==
X-Gm-Message-State: ABy/qLasTBbgrW4H6b5+jqHyc5gTdBYhnmjR7N/PX+MhLY9Gd93Y3sHA
        2LWyVaswNF+wHZ5o0iwggvw5VK6OlEpPzqLTRpPPYGJf
X-Google-Smtp-Source: APBJJlFIbpcEFeveHd1+UwMlJ0qrILLlbHDucVbw5obWOPf2eRga6waSxoqO0wWfSEGKsL0JjegeoWcUxVjP6L8Q9xg=
X-Received: by 2002:a2e:8e81:0:b0:2b6:a3a0:5f7 with SMTP id
 z1-20020a2e8e81000000b002b6a3a005f7mr4244396ljk.9.1690657684252; Sat, 29 Jul
 2023 12:08:04 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 29 Jul 2023 14:07:53 -0500
Message-ID: <CAH2r5mvzyVsou=Avw8GjxwV5CRgEMY_4XO+JEaZLk+GF-QjyzA@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
6eaae198076080886b9e7d57f4ae06fa782f90ef:

  Linux 6.5-rc3 (2023-07-23 15:24:10 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.5-rc3-smb3-client-fixes

for you to fetch changes up to a171eb5cac427fa8d084eaf5e47fbe4c0f1e279f:

  cifs: add missing return value check for cifs_sb_tlink (2023-07-26
15:41:27 -0500)

----------------------------------------------------------------
Four small SMB3 client fixes
- two reconnect fixes (to address the case where non-default iocharset
gets incorrectly overridden at reconnect with the default charset)
- fix for NTLMSSP_AUTH request setting a flag incorrectly)
- Add missing check for invalid tlink (tree connection) in ioctl

----------------------------------------------------------------
Shyam Prasad N (1):
      cifs: add missing return value check for cifs_sb_tlink

Steve French (1):
      smb3: do not set NTLMSSP_VERSION flag for negotiate not auth request

Winston Wen (2):
      fs/nls: make load_nls() take a const parameter
      cifs: fix charset issue in reconnection

 fs/nls/nls_base.c        | 4 ++--
 fs/smb/client/cifsglob.h | 1 +
 fs/smb/client/cifssmb.c  | 3 +--
 fs/smb/client/connect.c  | 5 +++++
 fs/smb/client/ioctl.c    | 5 +++++
 fs/smb/client/misc.c     | 1 +
 fs/smb/client/sess.c     | 4 +++-
 fs/smb/client/smb2pdu.c  | 3 +--
 include/linux/nls.h      | 2 +-
 9 files changed, 20 insertions(+), 8 deletions(-)


--
Thanks,

Steve
