Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A157E7EB1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345025AbjKJRrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:47:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345970AbjKJRpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:45:54 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C7283C0;
        Thu,  9 Nov 2023 23:17:00 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-507ad511315so2454899e87.0;
        Thu, 09 Nov 2023 23:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699600618; x=1700205418; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=mVEpUZbvCQonAX75QOM4vRdLiNUUO1u99eUpFRy2i9o=;
        b=TLnW/wb0/WgNb+oG75xd7/r2AANzqmnZZtUpc8oX995j7pT0at9eBowjRVharUgZdW
         KLoHpOpDHEYI6xu3YwGZ5ZEhVslwlidthERKjiLtnwFqc8y0oZni71pgXeKJDTZQIPRA
         dbPhYPWouw5StBaGr/mBK14T6alYqNgLL2xgdjXqhh6mm0VFpBaV3YQ2zHy6CY+jkCM1
         kRRNro502kDQDjF3jmtz1kxUB5Q4oB955A5lK60OIn8o7eEsqDc9CdflC331h+KWIlES
         qGVO668VuY0p+Qime8YJ7AcwahnWlhyG/YFKGPK58mIV1sXSfY3T3nXJt8pxcx82gCJl
         ClTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699600618; x=1700205418;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mVEpUZbvCQonAX75QOM4vRdLiNUUO1u99eUpFRy2i9o=;
        b=i2Wx0P8fRlZUCpCrqrlHsEK1kiWdtpFfu3PXaEfJzn73yp4fnpoQzoDCrgXcOb9d3Y
         xn8WflGn61w4mi1XdeP1BBQCBsfVExX+N5DOqOzaBkLa0oVhCSjW86lG/XoPhWL5zReD
         jAyO7Nwbi2ertfcEeC5a4zisx8tbrun+0o+yiuzEbKMI04oi+nXvz8WUSUpfvXbt6flZ
         Jj+rzbv8aQOBiSB5I8PkrJRfUEByEs7vWGtrvqlpJge36s+Dn3YPcEvmYiCU7Ct4YFwk
         AO0xkl5Y1aUwqzMbxJCggJot/2E8XQIP79HaNdMrHBQGrLQCdraoG7AQHEt4koYmgxdE
         Akkg==
X-Gm-Message-State: AOJu0Yw677GdhVfmQ/SCShafFqeTjSnuRRsav8Kzn+jPhyB0AybuGSTL
        BtV/uEPAl4T+fpPnGkW4d+3LhODijL++VLrlwA0YmNlWi03rfj//8k0=
X-Google-Smtp-Source: AGHT+IFdJJ8lop74ujHOJzAE8i65dSlkG+M1fJJKF155V7Z+RsrDw+yJ6JY9Y7+t6lXdheg5NFV//2bJYFjT2bZTZXo=
X-Received: by 2002:ac2:4183:0:b0:509:4767:57f9 with SMTP id
 z3-20020ac24183000000b00509476757f9mr2991028lfh.55.1699600618093; Thu, 09 Nov
 2023 23:16:58 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 10 Nov 2023 01:16:47 -0600
Message-ID: <CAH2r5mtQPWefhxpwgYUyVkyaSWL0nRurOc3qAV9XxbUN5dni-w@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
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
766e9cf3bd64c45fcace3acc6f8b3df815448ea3:

  Merge tag '6.7-rc-smb3-client-fixes-part1' of
git://git.samba.org/sfrench/cifs-2.6 (2023-11-04 09:13:50 -1000)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/6.7-rc-smb3-server-part2

for you to fetch changes up to 5a5409d90bd05f87fe5623a749ccfbf3f7c7d400:

  ksmbd: handle malformed smb1 message (2023-11-07 18:54:25 -0600)

----------------------------------------------------------------
Three ksmbd server fixes (two also for stable):
- slab out of bounds fix in ACL handling
- fix malformed request oops
- minor doc fix
----------------------------------------------------------------
Namjae Jeon (3):
      ksmbd: fix slab out of bounds write in smb_inherit_dacl()
      ksmbd: fix kernel-doc comment of ksmbd_vfs_kern_path_locked()
      ksmbd: handle malformed smb1 message

 fs/smb/server/smb_common.c | 11 +++++++++++
 fs/smb/server/smbacl.c     | 29 ++++++++++++++++++++++++++---
 fs/smb/server/vfs.c        |  7 ++++---
 3 files changed, 41 insertions(+), 6 deletions(-)


-- 
Thanks,

Steve
