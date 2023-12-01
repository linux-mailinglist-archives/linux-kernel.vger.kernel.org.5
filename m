Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32967801849
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 00:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjLAX7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 18:59:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjLAX7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 18:59:12 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A8409A;
        Fri,  1 Dec 2023 15:59:18 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50bc39dcbcbso3787873e87.1;
        Fri, 01 Dec 2023 15:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701475157; x=1702079957; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ry6rEWWIPy9XfFGMdahZWvFS711IvLdFUKUk5teU+cs=;
        b=IN4R5nABiyR7DBsu3DGnCH/83CvtM7qnTHM98BoWDrHNUWOLyErDPt29gAPTHNncaM
         myMtYbgsp4FJCxMT+m6E+vTfZ9BajKoXvX5amGefQ6MTDT6rN4pOcpoRLqe3fGWW/BgF
         Lwijrb1E9KWEK5yj82HK1esljluQG8K7DMR9J77/sIolISjKlgdDoubLqVGYyqIG7yFz
         R17pDrJ28LC5KE1UW+P6EfYz8G2TPBKkp5+6+EnlFzM6GWVzAHfmZeuNGRhCi4x63y0b
         zq5DrqiCpF1iINjvMjCRy3hfManCVBqdpJWH6dvQ5zdMtnWZ1s3Tpo6PzOY/Tx4+lVx4
         NCfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701475157; x=1702079957;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ry6rEWWIPy9XfFGMdahZWvFS711IvLdFUKUk5teU+cs=;
        b=DHn6pOu4/30gnuEoPeB3kjqSexrQh+BYt0fhfNF2p3Vo7GnH9uWnSIk5RqRF7tIPYN
         lTW72ncrsORZ3mq0SNCAdEkWXJEqGigUGGGNZiPRSYU6u/ookmsYgcZnVVGdhAHmF/VC
         zrb12o3ri5Ttci4wTtepvGYWxh2w2xtH2X4TlMHu+9u6Jvgfj8YAHdM8fnM4wRpdWPi8
         JhfmHf3x6I11yCTK5XmF1rbzGJNBLYtYjC+BfiX2M02zKG8iH2+yGWQHSq/egLLPVdew
         Ry1gLbAA3QSkqJVw7uDwK48lNJopR7mRGeOfCE8izHMw/iYKe4gVA6RwQJNTMa4J8UH+
         ephg==
X-Gm-Message-State: AOJu0Yw6CI61rMJqi9J/vrpSUrRWJ6b6vh975cK+D7WGviK6aHHnF4Py
        gk1zJdwXBnPAUjVdY2uQWq5+8gW07JhLE3BXn2zNmos2B45Nqg==
X-Google-Smtp-Source: AGHT+IH50E9HdfKAyfxobkJqFbIei6OxD2pYN5qDl8PyNoRCUhSxa0yHbciJAIBVBsfpLRxZkKddfI7MRIxAuCzvgCo=
X-Received: by 2002:ac2:5584:0:b0:50b:d103:2e3a with SMTP id
 v4-20020ac25584000000b0050bd1032e3amr1203880lfg.10.1701475156107; Fri, 01 Dec
 2023 15:59:16 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 1 Dec 2023 17:59:05 -0600
Message-ID: <CAH2r5muZp5cizyqC94OT0KkwfKkUBAA0cR3J-0nMxprFpQYwfg@mail.gmail.com>
Subject: [GIT PULL] smb3 client fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull the following changes since commit
2cc14f52aeb78ce3f29677c2de1f06c0e91471ab:

  Linux 6.7-rc3 (2023-11-26 19:59:33 -0800)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/v6.7-rc3-smb3-client-fixes

for you to fetch changes up to 0015eb6e12384ff1c589928e84deac2ad1ceb236:

  smb: client, common: fix fortify warnings (2023-11-30 11:17:03 -0600)

----------------------------------------------------------------
Five cifs/smb3 client fixes, most for stable as well
- Two fallocate fixes
- Fix warnings from new gcc
- Two symlink fixes

----------------------------------------------------------------
David Howells (2):
      cifs: Fix FALLOC_FL_ZERO_RANGE by setting i_size if EOF moved
      cifs: Fix FALLOC_FL_INSERT_RANGE by setting i_size after EOF moved

Dmitry Antipov (1):
      smb: client, common: fix fortify warnings

Paulo Alcantara (2):
      smb: client: fix missing mode bits for SMB symlinks
      smb: client: report correct st_size for SMB and NFS symlinks

 fs/smb/client/cifspdu.h | 24 ++++++++++++++----------
 fs/smb/client/cifssmb.c |  6 ++++--
 fs/smb/client/inode.c   |  4 +++-
 fs/smb/client/smb2ops.c | 13 +++++++++++--
 fs/smb/client/smb2pdu.c |  8 +++-----
 fs/smb/client/smb2pdu.h | 16 +++++++++-------
 fs/smb/common/smb2pdu.h | 17 ++++++++++-------


-- 
Thanks,

Steve
