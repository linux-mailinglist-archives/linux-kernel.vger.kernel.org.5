Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C74478F056
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 17:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237542AbjHaPaY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 11:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjHaPaV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 11:30:21 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB48E4C;
        Thu, 31 Aug 2023 08:30:18 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so17578721fa.2;
        Thu, 31 Aug 2023 08:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693495817; x=1694100617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d5/t/HKn5nFvDJ6p71UlBWH51trAjRS5q+GK7CmmUHg=;
        b=EQuWKBn9RH3hj5eYgh6yYzw1EpYaUcXxQ6Ts890kMEHGzJTvgteuaTHIiVTiBU1pj4
         IvtVccj+tfURB+bTYotPw/m9sI8iLAP1rIPs86PoEQfOVwnz7fD8AEbvRk23Z80ajsvE
         Wd79+28r+ymQjoZD5WqjuWa+uWiUAYqtDOBL+Op/PT8qMqqB/ZsYD5nHGJWiLGhScwcm
         Yl19koN1903LnGNzkKHLYXNHjfBuc5skYH91amP3hJEa0uKG59s0VlEOIeVXCYlbws+c
         wMOauOplam0uN56TJNK8O2T8P3mUrPnpNYddhrrEPYGWf+3hzv6Q/ohR/cBpyXZ6Qco9
         wKwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693495817; x=1694100617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d5/t/HKn5nFvDJ6p71UlBWH51trAjRS5q+GK7CmmUHg=;
        b=Q3V+Jt+1xH38036SS6lfNAWdWzdYNqLBETPwERSC4nA5+2l0fcdsEjv3dkKIhTUUWE
         2YXcTzueIR7j51mE309pUhvV6h0JAPAZpmotDyq/vdlPP7ujagqZ7wI7H+yEzOT1H3uW
         sU+SJj+4dEZAWSsGiT/44lJof+L00WW4oEI5clga2ZIAWN0ATjk2eMI0zJAITfhp35jX
         6mK219lRo7cGXkozwiF0aAb0MIW5Gs40uEF+h/LrmPb4j6hcVHiJeaWrRvK2pIFnflQk
         x5/s9BxaPWNerEwGmGupN1bosvPCte2n17cu1y7cK3JLB4OK7Tckxe1kb3AdBmWQEaCM
         hyaw==
X-Gm-Message-State: AOJu0Yy9savNAZrA2tC2eGUv8O7AWVlMdMi9gufhrVMUrezNIizgznPF
        FV7wsoeosBgpCdTSdfjPNgClGOyg4NApJEvEHy4=
X-Google-Smtp-Source: AGHT+IFyyPhOC5V1BnZwlW+JcwwzIhZ0+DJeu/EMhcz2JBOv+XWrjeHI1t+NqUSXZZhK2x7t72WDhAhZYCYJmZyREJw=
X-Received: by 2002:a2e:9889:0:b0:2b6:a08d:e142 with SMTP id
 b9-20020a2e9889000000b002b6a08de142mr4188601ljj.7.1693495816811; Thu, 31 Aug
 2023 08:30:16 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 31 Aug 2023 10:30:05 -0500
Message-ID: <CAH2r5mvMSeqLQkNqwrxr5Q1FpJrQ85VUkp7_c4WP0BugQfpHPg@mail.gmail.com>
Subject: [GIT PULL] ksmb server fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
2dde18cd1d8fac735875f2e4987f11817cc0bc2c:

  Linux 6.5 (2023-08-27 14:49:51 -0700)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/6.6-rc-ksmbd-fixes-part1

for you to fetch changes up to 0e2378eaa2b3a663726cf740d4aaa8a801e2cb31:

  ksmbd: add missing calling smb2_set_err_rsp() on error (2023-08-29
12:30:20 -0500)

----------------------------------------------------------------
Ten ksmbd server fixes
- Fix two potential overflows in decoding create and in session setup reque=
sts
- Three cleanup fixes
- Two compounding fixes, including one for MacOS compounded read requests
- Session setup error handling fix
- Fix mode bit bug when applying force_directory_mode and force_create_mode
- RDMA (smbdirect) write fix
----------------------------------------------------------------
Atte Heikkil=C3=A4 (1):
      ksmbd: fix `force create mode' and `force directory mode'

Namjae Jeon (7):
      ksmbd: add support for read compound
      ksmbd: fix wrong interim response on compound
      ksmbd: reduce descriptor size if remaining bytes is less than request=
 size
      ksmbd: fix wrong DataOffset validation of create context
      ksmbd: fix slub overflow in ksmbd_decode_ntlmssp_auth_blob()
      ksmbd: replace one-element array with flex-array member in
struct smb2_ea_info
      ksmbd: add missing calling smb2_set_err_rsp() on error

Yang Li (1):
      ksmbd: Fix one kernel-doc comment

Yang Yingliang (1):
      ksmbd: switch to use kmemdup_nul() helper

 fs/smb/server/asn1.c              |   4 +-
 fs/smb/server/auth.c              |  14 +-
 fs/smb/server/connection.c        |  55 ++--
 fs/smb/server/connection.h        |   2 +-
 fs/smb/server/ksmbd_work.c        |  93 ++++++-
 fs/smb/server/ksmbd_work.h        |  34 ++-
 fs/smb/server/mgmt/share_config.h |  29 +--
 fs/smb/server/oplock.c            |  31 +--
 fs/smb/server/server.c            |   8 +-
 fs/smb/server/smb2pdu.c           | 527 +++++++++++++++++-----------------=
----
 fs/smb/server/smb2pdu.h           |   2 +-
 fs/smb/server/smb_common.c        |  13 +-
 fs/smb/server/transport_rdma.c    |  29 ++-
 fs/smb/server/vfs.c               |   4 +-
 fs/smb/server/vfs.h               |   4 +-
 15 files changed, 432 insertions(+), 417 deletions(-)


--=20
Thanks,

Steve
