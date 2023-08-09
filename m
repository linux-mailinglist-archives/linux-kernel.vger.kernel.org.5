Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32515776CAE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 01:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbjHIXLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 19:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjHIXLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 19:11:21 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25201D1;
        Wed,  9 Aug 2023 16:11:21 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2b9ba3d6157so4957111fa.3;
        Wed, 09 Aug 2023 16:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691622679; x=1692227479;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qvaA2dr27xwLbhrsEkqVsKRPGUbqoqs8Cc6VxoCBRhY=;
        b=npDadkHPMFJnWf4isIAZ8VLDu9cORyOZFLOjD1RcXHMUv+RiU7JlXgasZ9g0FexOq7
         KOpG/4Shf/Mbmd5yGc+wvnqW3H9Jy1yp679xMRLx3lMHkTDyke+lAnhY+KdHGtnGevOb
         pWZnnfoNdBXJi1pKpecm/7f0Hx8own+r/YnQ+abqDzHOtCk09LyXAd1qXZWM2/5ElOfi
         gYIv/zMY9lXETu+MMb5JeUfoTyEVbq7iiXK2QVCiHWOs1fZk5ihG3PVDOftDkDuADH72
         zrf2LgebLtTe09zgvQOytRQnqgy2nxWdcw8hHHZC9rpLEEUXHrZ2siOU1Ty3kyWRSBK8
         CW9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691622679; x=1692227479;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qvaA2dr27xwLbhrsEkqVsKRPGUbqoqs8Cc6VxoCBRhY=;
        b=BDrZjWEml7aMcsOJOBePS610BMBDAJHwCGZQZ0sIDL+B2En0sdsjFWr3AIRJmthKUm
         TwbWbswJJwLkzo60KpxsPdqyxmQGVxNyxfcLpbf1Y+E5smQsd6a8doqy0UIbV8elDndB
         3JU6qghzHpy0PlnwKkKqqa+SwBGO3Aps/Qf527VTBvsNjKOJdpqW8KQ0cAijPv91+ibz
         8/FmAs1kJDhQSsXDaix5SitPVFSAMjqFe5zhGawI+wlzXI18z5SdBcBzmV/XSEbttzo5
         vhTUKiDaEUM5DSyofwAZX2ISi/cODDXO5bR6VAFmk16r+DRFy7H7GYf5mM1ahXGb9apW
         rhnA==
X-Gm-Message-State: AOJu0Yywx2KRPpM2GA7wztNSRofoz15sgjm2otHjwnjCWpXvFbhXmk8i
        tddoN5IB05+7HqotP+ULhB+eIezRFg0l03h5HUh40Egl+iUjJfFC
X-Google-Smtp-Source: AGHT+IH7zFRhQ8K0QTnS4GWmvelHzEanqe4bpcjccWQbl6SkEDRUz8XbLevSBqgLPNnO2Cvs9RpgvpsZ1HiKdRQemVM=
X-Received: by 2002:a2e:9b51:0:b0:2b9:dd96:5340 with SMTP id
 o17-20020a2e9b51000000b002b9dd965340mr418676ljj.50.1691622679027; Wed, 09 Aug
 2023 16:11:19 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 9 Aug 2023 18:11:07 -0500
Message-ID: <CAH2r5mv+Sy5mrZThrQUf1na-mg-B9DiLd5fkYs9sPo97GWirCA@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
5d0c230f1de8c7515b6567d9afba1f196fb4e2f4:

  Linux 6.5-rc4 (2023-07-30 13:23:47 -0700)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/6.5-rc5-ksmbd-server

for you to fetch changes up to 79ed288cef201f1f212dfb934bcaac75572fb8f6:

  ksmbd: fix wrong next length validation of ea buffer in
smb2_set_ea() (2023-08-05 20:57:00 -0500)

----------------------------------------------------------------
Two ksmbd server fixes, both also for stable
- improve buffer validation when multiple EAs returned
- missing check for command payload size
----------------------------------------------------------------
Long Li (1):
      ksmbd: validate command request size

Namjae Jeon (1):
      ksmbd: fix wrong next length validation of ea buffer in smb2_set_ea()

 fs/smb/server/smb2misc.c | 10 +++++-----
 fs/smb/server/smb2pdu.c  |  9 ++++++++-
 2 files changed, 13 insertions(+), 6 deletions(-)

-- 
Thanks,

Steve
