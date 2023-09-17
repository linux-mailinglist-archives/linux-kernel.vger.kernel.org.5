Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB627A3395
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 03:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbjIQB4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 21:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjIQB4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 21:56:07 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9964DCCF;
        Sat, 16 Sep 2023 18:55:59 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-502b1bbe5c3so5623208e87.1;
        Sat, 16 Sep 2023 18:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694915758; x=1695520558; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8EwLc90Wd21xas0fgvqq6H73IyXGR//SFw2PkS94YO0=;
        b=jXokpf6Rqlabrx7T1WmoTMT2uxjIlUQHGUTHvQU3B88pmDGYDKGYkAsyCifpiqm+27
         lUO0T95Ax13kjS3fL7UNlq7f0B88LHVsUn8roascOkryLisRCz3cuUisXy0AgDMV+Ks2
         /OD/B5+VbzDq8BHA0zSnXnM1EaoTYbFl/U9W96Zzo9ZlOtUU3FYcH0T9aN0sPSKTkaI3
         rb9vSRi+POq/hkyAXeUeF9xv2y0yNb3iRcbQMLuFwYyHvmWYrWT6LNYnX/Ce6cnaZO/S
         mFcKt3Fg0yRl81hWuBNeObnI8hdgtDT4vxDNl7iYtNsnfcChJ4g81rWo50dgKMX1qSgc
         PkWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694915758; x=1695520558;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8EwLc90Wd21xas0fgvqq6H73IyXGR//SFw2PkS94YO0=;
        b=XDzeSad6hdDFtG0afmU3Z/kQ9gtt6kXfVIBrQEQjcfgTXkz2pTuqL5K8mzGgDlt4NM
         ToNes3iWuywhm3mhFc1O3oLlWVJFAFUmncMQYgyA9eG1uGLFK/OXQTUVsa2Ijaemksvb
         8p/1Bc6KkNjOpDCb7tIFG0p9n+GP1AsS77AvcqR9Na0zXUS4cxQ9szNaHwaU7w1437Iv
         u/vWb3M7ND5X39MBjnX+E/RT1uyFL4Qx899jzPLkYdEOB5wkMMqkAhh5EIhSP5HhD28c
         MUhLaUiW/dwUHWG63nu9fb/Yi0tCO7qW/Wapfcx+Nr70rdszqHAxJB0wI5BroI4jJtwB
         q4Hg==
X-Gm-Message-State: AOJu0Yz0gdYD1400VNUZOmxD5SPHqTgSKO5QNuF0v3cx4miHGK3m0h0u
        eBGU9GtbaBgvwNmvXW1XQDp33umnozYCI5VSGtoaao9YXu0=
X-Google-Smtp-Source: AGHT+IFHysjG5kp2ypup+To6AxRxwpxcICS7nQCYr09T84dKCpzrtBNgR2j9sn4gkMZwl7IpzjqmkdhK/uGKG5LvB60=
X-Received: by 2002:a05:6512:1090:b0:502:f7a4:c31f with SMTP id
 j16-20020a056512109000b00502f7a4c31fmr5931423lfg.45.1694915757434; Sat, 16
 Sep 2023 18:55:57 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 16 Sep 2023 20:55:46 -0500
Message-ID: <CAH2r5mtanACUTG3pjXuroE6RUw1WHOw1N4k1bbTmNHrydUK_sg@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/6.6-rc1-ksmbd

for you to fetch changes up to 59d8d24f4610333560cf2e8fe3f44cafe30322eb:

  ksmbd: fix passing freed memory 'aux_payload_buf' (2023-09-13 10:21:05 -0500)

----------------------------------------------------------------
Two small ksmbd server fixes
- quiet smatch warning, clarifying aux_payload_buf freed
 (set explicitly to NULL)
- avoid duplicate call to mark_inode_dirty (when setting ACLs)
----------------------------------------------------------------
Namjae Jeon (2):
      ksmbd: remove unneeded mark_inode_dirty in set_info_sec()
      ksmbd: fix passing freed memory 'aux_payload_buf'

 fs/smb/server/smb2pdu.c | 2 +-
 fs/smb/server/smbacl.c  | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

-- 
Thanks,

Steve
