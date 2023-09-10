Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6AF7799C3F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 03:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343515AbjIJBgi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 21:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236268AbjIJBgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 21:36:37 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EA11BF;
        Sat,  9 Sep 2023 18:36:32 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-500cfb168c6so5328714e87.2;
        Sat, 09 Sep 2023 18:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694309791; x=1694914591; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XWUyT4PbfqJHBky36kl15hBjq+u3Zrn12t7h3PXaL5c=;
        b=BZ3ib/rBxHN4kHLss+GwifeMlfVOnmSLkTCyknWlAjJE121IEHRV7bOkvUsWvaB2jj
         yoxb1Fa45w3CLxB960mshNEyI8gqAAuImr23FH6Zm5+dWzhYaEj9PouJR+8uxDphz+mQ
         78AW/nqKzboVoEuU2vVQczN+lx2XTDPtvHUnP0r8hivTPHzRzNTHrxj2gvNL4/FHe4Ed
         XsWFo5j1IWMXBKHqFS4PRmF4OIFpLaWaLjcRKzxfb29mDeuC97k1iIBJlsDG/fo9aGw6
         +je6dS2RUg9QKb+COqFkzjpYsKNrD9GIREIsBIdPo/I//YH9AVUngFYwbHeBwymDBkeH
         IpAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694309791; x=1694914591;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XWUyT4PbfqJHBky36kl15hBjq+u3Zrn12t7h3PXaL5c=;
        b=jKdEMN1pT6JWhZjuKrhsIIiGYApuwf6dhB+8pFrNL5YSnCGk3qeIC38FRN/kM4DtZr
         pBpK3z96xs/G4wRh5gTvajExKdsERtIkLX+yYveuKV5qkkCMbfQ6KAfJEFmDkPTW3Ih/
         rc9ewJUg1sSryyAJwStHxSRZG1B+hbS4WpzCpvDkcywR9dwvlHBVPsPqTIJLB/6rjUxE
         E4+EMLyaWrNYT8zFsxjY1/q6L+bCoh9iHdyLGI4kI4hPRlNO1SSzXe2eQAqK+u3y4ksA
         GFdnmidla4LkFGTnK78rKnYq6PV8ypjun2fjrkL5as10fp44EJ4lr0d2KnEj2t93ltcH
         jhoQ==
X-Gm-Message-State: AOJu0YzWJs864B1ww3rmdX/lLb5aXkwfOq4RabPMGptkpUP0o+S3/6pX
        slemta99qgNkfRVfqjLjkL5SOEeqtaiPdBX2U/S5Nprd8s4=
X-Google-Smtp-Source: AGHT+IHNAKU7PqecW7KUirex5eE5n9nownBgwoqkxfsmC//qAvp80Ro1D03ki4O+l9D/wVdQG6JUV8BC4coq4SUGn/s=
X-Received: by 2002:a05:6512:2256:b0:500:9d6c:913e with SMTP id
 i22-20020a056512225600b005009d6c913emr5298552lfu.52.1694309790830; Sat, 09
 Sep 2023 18:36:30 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 9 Sep 2023 20:36:18 -0500
Message-ID: <CAH2r5msQ5+okQ3Sk9HzwW6r7YoWDEBDtSfDio0XOhTpVDjibFw@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
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
b97d64c722598ffed42ece814a2cb791336c6679:

  Merge tag '6.6-rc-smb3-client-fixes-part1' of
git://git.samba.org/sfrench/cifs-2.6 (2023-08-30 21:01:40 -0700)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/6.6-rc-smb3-client-fixes-part2

for you to fetch changes up to 5d153cd128251aaedc8e9657f0a949ec94952055:

  spnego: add missing OID to oid registry (2023-09-09 08:18:16 -0500)

----------------------------------------------------------------
- six smb3 client fixes including ones to allow controlling smb3
directory caching timeout and limits, and one debugging improvement
- one fix for nls Kconfig (don't need to expose NLS_UCS2_UTILS option)
- one minor spnego registry update

----------------------------------------------------------------
Dr. David Alan Gilbert (1):
      nls: Hide new NLS_UCS2_UTILS

Katya Orlova (1):
      smb: propagate error code of extract_sharename()

Steve French (6):
      smb3: allow controlling length of time directory entries are
cached with dir leases
      smb3: add trace point for queryfs (statfs)
      smb3: allow controlling maximum number of cached directories
      cifs: update internal module version number for cifs.ko
      smb3: fix minor typo in SMB2_GLOBAL_CAP_LARGE_MTU
      spnego: add missing OID to oid registry

 fs/nls/Kconfig               |  7 +------
 fs/smb/client/cached_dir.c   | 11 ++++++-----
 fs/smb/client/cached_dir.h   |  2 +-
 fs/smb/client/cifsfs.c       | 12 ++++++++++++
 fs/smb/client/cifsfs.h       |  4 ++--
 fs/smb/client/cifsglob.h     |  2 ++
 fs/smb/client/connect.c      |  1 +
 fs/smb/client/fs_context.c   | 11 ++++++++++-
 fs/smb/client/fs_context.h   |  4 +++-
 fs/smb/client/fscache.c      |  2 +-
 fs/smb/client/smb2ops.c      |  1 +
 fs/smb/client/trace.h        |  2 +-
 fs/smb/common/smb2pdu.h      |  2 +-
 include/linux/oid_registry.h |  1 +
 14 files changed, 43 insertions(+), 19 deletions(-)


--
Thanks,

Steve
