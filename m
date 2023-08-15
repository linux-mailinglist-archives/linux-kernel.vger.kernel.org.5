Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA23F77D3CC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 22:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240160AbjHOUAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 16:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240089AbjHOT7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 15:59:42 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6A983;
        Tue, 15 Aug 2023 12:59:40 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b9db1de50cso87702511fa.3;
        Tue, 15 Aug 2023 12:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692129579; x=1692734379;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WDEeQ3eCIpybg5uj/Oi3ysP7TFHjBsBg7ziPx4BTTs4=;
        b=iF0O5NPLl12GBWr6ulYkKxtXRAfw0CR5RaHzY3ChsLWDMn2eOjer+7LVC9ekDqNCyk
         t830Eh1mQTtCy22nWxcS+GyDFiUGZ82Sq8pwQFB0c9sQbJMWDinn2gerTaEt1lJ2sXNm
         DpGa2p+oY03rCtaZsaXGYdh8jatFNyeGbYH9EohauMXyoSxSBCnJHnOB3E5+fP2XC6z8
         iXMCH1d/vSRkW1FItZ/4DjjQ9QfHhq2u/zV+3deGvRY1mcwsq/o8AuQZqP3zm2V0b+sw
         Agahk8HGiZ2EJB4R34bcBoUDhHy4At/xoogWPfjUum4JYsond5NrOI3uAzpHctSSHryl
         AdQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692129579; x=1692734379;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WDEeQ3eCIpybg5uj/Oi3ysP7TFHjBsBg7ziPx4BTTs4=;
        b=G6KkMQKdaRNw1C24XknaFrGKOQrkYLclo0WA3HBa/fDXrzjbGQnFoWyb6/tO9Pb1zr
         d9n7kIIhLmigpM7JV/4I8kEAkMwzWkBZ6QwFUsaS6XFnFcl3TWkSMfkFOvF4dfMCso4P
         kDDgBgRicsDYI638sZBgqe8axODlnC2wUUyD9I5F7rxGWRuYROYYjkG1ydkYTsI5hBQQ
         yaVXfSHRwa7fihC815b2ehggHjk3jVJnihtQ9C72ZrrPo4Al1Ogx5/9qEOB3Ekdl/blQ
         89b1f6p453xXtT4l9ueLY2/tjj/i4D+w5y1j37lOy+ry38rjJZJuqcf/4Xgs7wDNXEq0
         X2yg==
X-Gm-Message-State: AOJu0YxuI7bjUraI+VnhBYsDjTn5mLUfqDFMnM//p6FxOSRR+d2OcXre
        lbrVl8mTVAtmsXvZqDZlBvLOfAk8OFR8XYnJtEif1Jbauqj21w==
X-Google-Smtp-Source: AGHT+IFw+oFbGPiiCcLVQSBjQ2DXiP4pctBQ++B+FVrG2nLkX5vIXlNO2sH0peC3UxM0C+mCrvXyuh5KfSs43zibb+Y=
X-Received: by 2002:a2e:730c:0:b0:2b9:eeaa:1074 with SMTP id
 o12-20020a2e730c000000b002b9eeaa1074mr9261552ljc.35.1692129578416; Tue, 15
 Aug 2023 12:59:38 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 15 Aug 2023 14:59:27 -0500
Message-ID: <CAH2r5mt9bY7hGagfTPS_uK9KnbTQVsWaO9JciJ6XekLb36Zusg@mail.gmail.com>
Subject: [GIT PULL] SMB3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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
f6a691685962637e53371788fe2a72b171aedc68:

  Merge tag '6.5-rc4-smb3-client-fix' of
git://git.samba.org/sfrench/cifs-2.6 (2023-08-05 13:44:06 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.5-rc6-smb3-client-fixes

for you to fetch changes up to 7b38f6ddc97bf572c3422d3175e8678dd95502fa:

  smb3: display network namespace in debug information (2023-08-14
08:41:29 -0500)

----------------------------------------------------------------
Three smb client fixes, all for stable
- fix for oops in unmount race with lease break of deferred close
- debugging improvement for reconnect
- fix for fscache deadlock (folio_wait_bit_common hang)
----------------------------------------------------------------
Russell Harmon via samba-technical (1):
      cifs: Release folio lock on fscache read hit.

Steve French (2):
      cifs: fix potential oops in cifs_oplock_break
      smb3: display network namespace in debug information

 fs/smb/client/cifs_debug.c | 10 ++++++++++
 fs/smb/client/file.c       | 25 +++++++++++++++++--------
 2 files changed, 27 insertions(+), 8 deletions(-)


--
Thanks,

Steve
