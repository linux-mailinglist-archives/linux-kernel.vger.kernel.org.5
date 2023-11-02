Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6E07DEACE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 03:46:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233007AbjKBCqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 22:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbjKBCqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 22:46:22 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970F283;
        Wed,  1 Nov 2023 19:46:16 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5079f3f3d7aso507894e87.1;
        Wed, 01 Nov 2023 19:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698893175; x=1699497975; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IQ5dYrRG7/rq9Ng5gsXj2Nv4rJ8MwiyXRaJl+IZPwvs=;
        b=VXroKxYcDKD7M3aX8bVPpojTDNnLE0XBdUN5fJ747j/bLNDGsic23lhGR8x3axeGUr
         WNGznUhUOiWs57VJRI2J7UmHTW6l5CnoQD7m1oHSkN53lGCf2E7mKmmPZ2jZZEI7ha9r
         fKGzlhbkcLlR4lseovuJai95ZqZ4VwPKL4OG3ONJDVTTPENUFRAYUVSGyTn+HJAAmR9+
         X3C3rRyM2a5EfpdHHXDAe8n4g5aneaqWQKZnnaRdcXRqmgJcVwwmtY++L7O0Sfe/qH9Y
         eD9tEoIq7VZ75mqUH9NDbWEd9Jg6WFL8CxgCjstDz3hN9GubLkJimzqWBnnK4fcbX/kq
         rT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698893175; x=1699497975;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IQ5dYrRG7/rq9Ng5gsXj2Nv4rJ8MwiyXRaJl+IZPwvs=;
        b=TmN0jc1d6229nW/Cnt1U/+O1XzTCIBMPEfDPogt51foPQKNRU6q06okzZAwsl4VDkz
         Xjb2FWL8DoIwUs27HilLA5aOMbddTQQm6wg32K+BCea2xpZCx7OgAy6YOv93RCc22T9p
         1/TXJMMJL+igv0Yi+v5ATdOPZwk2ySLvgeh126Q5swlHcn7R72pmcKcgxQ47+9wfHZdL
         ryR8Sss7RuGhmgEnPr2rF7IoLuFT/D45cl1M2XdlhovP3Y60va+IAzX7pc7rPfyTMX3y
         ejBBf1CMU95S4Yyf7DZXuDS9h3gD3Ctd/wYAJsbmgqPVuf6JYZ5hNp7Ssq5lDpTfkCHm
         OSVg==
X-Gm-Message-State: AOJu0Yy/4yrUE8y3/Z3CsvU8ihA2Cy7V3y8FhppKDHlwaZR4Je8Dbztb
        AkX80+zxBVRFKiNneEtE0YA4wmqMcMNMaAM/2WI=
X-Google-Smtp-Source: AGHT+IFx51rAWG2jZcULXoGk9fvZ08uUiypbGYzr1bmenajR80kkhxoBdA4NQF0LQMEJrXLPYWTmDf64aqiXevt4RS0=
X-Received: by 2002:ac2:4db2:0:b0:509:441d:9bea with SMTP id
 h18-20020ac24db2000000b00509441d9beamr1393598lfe.20.1698893174574; Wed, 01
 Nov 2023 19:46:14 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 1 Nov 2023 21:46:03 -0500
Message-ID: <CAH2r5muPW=PY1mDGqR-Mpfv95RbR7w6XpumoXpu7cdRv1HS0-A@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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
05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1:

  Linux 6.6-rc7 (2023-10-22 12:11:21 -1000)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/6.7-rc-ksmbd-server-fixes

for you to fetch changes up to 67797da8a4b82446d42c52b6ee1419a3100d78ff:

  ksmbd: no need to wait for binded connection termination at logoff
(2023-10-30 21:58:12 -0500)

----------------------------------------------------------------
Seven ksmbd server fixes
- logoff improvement for multichannel bound connections
- unicode fix for surrogate pairs
- RDMA (smbdirect) fix for IB devices
- fix locking deadlock in kern_path_create during rename
- iov memory allocation fix
- Two minor cleanup patches (doc cleanup, and unused variable)

----------------------------------------------------------------
Cheng-Han Wu (1):
      ksmbd: Remove unused field in ksmbd_user struct

Kangjing Huang (1):
      ksmbd: fix missing RDMA-capable flag for IPoIB device in
ksmbd_rdma_capable_netdev()

Marios Makassikis (1):
      ksmbd: fix recursive locking in vfs helpers

Namjae Jeon (4):
      ksmbd: reorganize ksmbd_iov_pin_rsp()
      ksmbd: fix kernel-doc comment of ksmbd_vfs_setxattr()
      ksmbd: add support for surrogate pair conversion
      ksmbd: no need to wait for binded connection termination at logoff

 fs/smb/server/connection.c       |  16 ----
 fs/smb/server/ksmbd_work.c       |  43 ++++-----
 fs/smb/server/mgmt/user_config.h |   1 -
 fs/smb/server/transport_rdma.c   |  40 ++++++---
 fs/smb/server/unicode.c          | 187 +++++++++++++++++++++++++++++----------
 fs/smb/server/vfs.c              |  25 +-----
 6 files changed, 194 insertions(+), 118 deletions(-)


-- 
Thanks,

Steve
