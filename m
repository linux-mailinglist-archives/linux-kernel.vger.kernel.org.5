Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 949BB7E0D84
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Nov 2023 04:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjKDDjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 23:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjKDDjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 23:39:31 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 374BFBF
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 20:39:28 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id 8C2BFC009; Sat,  4 Nov 2023 04:39:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1699069165; bh=bqVJARalMpuZfvwuVrtAyfyj2tFBWs+NtWZpQL9dz3E=;
        h=Date:From:To:Cc:Subject:From;
        b=uCDAV8L7JRxlQ6QZMMDq1yxnOPmLLcBsdVOtSzJG2HBE+9defjMQ/ixYCOMfALSOM
         mKlp6/5gF7HblOhePDlCZPzm6D9yptHxzh5zmdiyg6XBKAa78dP08XUIFYK88QFW3o
         qrv1jWcINzD7aFX6LfxHUgl1dUbFQEtWNGq1lKnmYLCYsuWHodQoMo2hvvmoTophyh
         eWojZxuuxTRmcJNnmZUFvRbylc5vq3CrTd6KmJMNFLDEtoGvWXS0NuA5HjkT0q20Zj
         /SIekEW+B0nvTmtENIsrwIVHp2wa9fXEAUcsITpp6WkvpAg2t1T3ED1R/n6QfhOYTF
         JLgi/sTmiFOqQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
Received: from gaia (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 62FA8C009;
        Sat,  4 Nov 2023 04:39:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1699069164; bh=bqVJARalMpuZfvwuVrtAyfyj2tFBWs+NtWZpQL9dz3E=;
        h=Date:From:To:Cc:Subject:From;
        b=ziDvt2egvZRt8SrbNo0+N3AIYbLRfHkcqzpLNcVIicwn3aQ0eNuWeVfJLGLGNoHL8
         0r0QjvcaG7RTnTTvIqA2Goui6npuzI9JohPmgylxkepZR+9XdlxRKNcTBTQCUlO003
         hN1YfCl/V1vXJN2PycVNUW3nDMyUIHz5Kfp6QVfIxFvSIkqptrLaY34mB2yuvx4U2q
         CMSkk1ejpOwB4Ry/RWE69OOb5QQ3jKq/h4/R5Wtq35b5XYSLVun9VFmWDSGM+FquQg
         rdSHbZz6HUjZx6O3+HA1ckhasq88aJwMQQNoyIR4PIwfPsrijggcAeW284HAQBu0z4
         Z7gVHfVm9fZMw==
Received: from localhost (gaia [local])
        by gaia (OpenSMTPD) with ESMTPA id 7c6e001d;
        Sat, 4 Nov 2023 03:39:20 +0000 (UTC)
Date:   Sat, 4 Nov 2023 12:39:05 +0900
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christian Schoenebeck <linux_oss@crudebyte.com>,
        Eric Van Hensbergen <ericvh@kernel.org>,
        v9fs@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [GIT PULL] 9p fixes for 6.7-rc1
Message-ID: <ZUW82S8bGg2BAeNU@codewreck.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1:

  Linux 6.6-rc7 (2023-10-22 12:11:21 -1000)

are available in the Git repository at:

  https://github.com/martinetd/linux tags/9p-for-6.7-rc1

for you to fetch changes up to ce07087964208eee2ca2f9ee4a98f8b5d9027fe6:

  9p/net: fix possible memory leak in p9_check_errors() (2023-10-27 12:44:13 +0900)

----------------------------------------------------------------
Bunch of small fixes:

- three W=1 warning fixes: the NULL -> "" replacement isn't trivial
but is serialized identically by the protocol layer and has been tested
- one syzbot/KCSAN datarace annotation where we don't care about users
messing with the fd they passed to mount -t 9p
- removing a declaration without implementation
- yet another race fix for trans_fd around connection close:
the 'err' field is also used in potentially racy calls and this
isn't complete, but it's better than what we have.
- and finally a theorical memory leak fix on serialization failure

----------------------------------------------------------------
Dominique Martinet (3):
      9p: v9fs_listxattr: fix %s null argument warning
      9p/net: xen: fix false positive printf format overflow warning
      9p/fs: add MODULE_DESCIPTION
(^ I've just noticed DESCIPTION -> DESCRIPTION typo, but I guess it's
understandable enough and I'd rather not rebase the branch just before
sending the pull request (that last memory leak patch came in late
enough) -- please say if you'd rather I fix it up and I'll resend this)

Hangyu Hua (1):
      9p/net: fix possible memory leak in p9_check_errors()

Marco Elver (1):
      9p/trans_fd: Annotate data-racy writes to file::f_flags

Sishuai Gong (1):
      9p/trans_fd: avoid sending req to a cancelled conn

Yue Haibing (1):
      fs/9p: Remove unused function declaration v9fs_inode2stat()

 fs/9p/v9fs.c       |  1 +
 fs/9p/v9fs_vfs.h   |  1 -
 fs/9p/xattr.c      |  5 +++--
 net/9p/client.c    |  8 +++++---
 net/9p/trans_fd.c  | 21 ++++++++++++++++-----
 net/9p/trans_xen.c | 15 +++++++--------
 6 files changed, 32 insertions(+), 19 deletions(-)

-- 
Dominique Martinet | Asmadeus
