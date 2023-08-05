Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A141277119F
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 20:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjHESz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 14:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHESz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 14:55:58 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFF2A7;
        Sat,  5 Aug 2023 11:55:56 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9b9f0387dso49868341fa.0;
        Sat, 05 Aug 2023 11:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691261754; x=1691866554;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LIEL0tXVDTOWo0X4AX2HSPtn+A9sB8Rgxb5Azfh9x5I=;
        b=gdHG3RepOtrk0+kc/f0sEMLkeYEBonCsY7LkhiYj6LGEXrf1L20ct3D7WCCCJ4igP8
         5vBktCy7T85nglPOQG5XJh0bRkqoKewbL+F/q4RMHyU1UOPm3YPwo1aPoxS70k9LflEX
         HKsnECg3D9Mp3c7YGdgpX19MNfrSuQR3kK+tbkL/w+xmx6+p4mSATzqk/kL310DlUIGD
         RU0/abPM6cV7/1RZdBLsiom+AcMbsf5ziAEDBNRU5WAMdbcRLPnCiwENKBrF8Ts1kAqQ
         r/0CLNyk66pdacD+fZNRBGBPrhnwpJd/ayV4kpJiLRI7Jzc1OrdwGLthbyeHMNyOUedV
         89XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691261754; x=1691866554;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LIEL0tXVDTOWo0X4AX2HSPtn+A9sB8Rgxb5Azfh9x5I=;
        b=ONBXOQawVn9xDebqRZ/w0b6kNlN8mUglyxe+FlKJ2RrklHOuxuV3klFW44RLILhNrJ
         Qzsx/0+qOqg+EHftVkUB/wdwXTXh9I0IUP/QsHoyjeV3C9LNSkLJDlDWbAZvYgucC/cZ
         wCbd0WMbLUIRs9s5PyyEjaZifQ0P2FXdqremcZrM+UbLfUsWduw5Dgo2X76fIOiiSEXy
         tjBMe6CyKQAeHcJf+XzmJ2V2DBPyhKP9oxKyaByKxB3Gmitkm56NQLxZm5wPsaMYtqSV
         emUlkgveALvLpJwdQv58Qkn/NOp2mjrHuorWNogzk/GJ1coAiz210UTJIkiFySFWZzsV
         a6gw==
X-Gm-Message-State: AOJu0Yyw53/76nT8ljvtDZAzq+oxhW65NNkICYXHhfAy4gv9a+p8X14u
        qhKKMCGpIAhWtYZs0ZK+pGEmL0ZPek06byGrh0wFvTYNQIFfWA==
X-Google-Smtp-Source: AGHT+IEhmqretDu+8l+NeMCDqrX2H9NlmnFMpB7rt77QXIlcG1jVUMCBzN+on0MjV6jFsQWFGSAGfHw6We9sEnCpfc8=
X-Received: by 2002:a2e:b0d0:0:b0:2b9:b904:74d7 with SMTP id
 g16-20020a2eb0d0000000b002b9b90474d7mr4221463ljl.18.1691261754220; Sat, 05
 Aug 2023 11:55:54 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 5 Aug 2023 13:55:42 -0500
Message-ID: <CAH2r5mt0UH0Z-nRdEDsFMbE_gj1d8ezcoAhScZoToQckVvT_fw@mail.gmail.com>
Subject: [GIT PULL] SMB3 DFS Fix
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
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
5d0c230f1de8c7515b6567d9afba1f196fb4e2f4:

  Linux 6.5-rc4 (2023-07-30 13:23:47 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.5-rc4-smb3-client-fix

for you to fetch changes up to 11260c3d608b59231f4c228147a795ab21a10b33:

  smb: client: fix dfs link mount against w2k8 (2023-08-02 13:36:12 -0500)

----------------------------------------------------------------
small DFS fix
- Fix DFS interlink problem (different namespace)

----------------------------------------------------------------
Paulo Alcantara (1):
      smb: client: fix dfs link mount against w2k8

 fs/smb/client/dfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)


-- 
Thanks,

Steve
