Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A4F762B42
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 08:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231673AbjGZGS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 02:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjGZGSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 02:18:01 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D5CA2D68;
        Tue, 25 Jul 2023 23:17:25 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b703caf344so92769461fa.1;
        Tue, 25 Jul 2023 23:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690352243; x=1690957043;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xkFICdvw0eO5WMVxHngflASegVtH5FxSGHtFBl09lsw=;
        b=iyAUvTwLkDGHeAN54ox5rSlVXeMcHmi2jY7gi/c+qIA/CEMV0zc79k60aYpUrdMWrC
         4oFizgZIymxspFCdfSoTp/F8V02yvh2fhvkNSzl101S6wAq8kC2r8AgQ279mv3MqJy8V
         04PVTDwNFGbnr04DRQtrdj+LcIo2ksy6G6Tyo+FslLB+L6inC+SY8LEOKyiLfwp9vZ4u
         scewCL/ui9dm4PkmsrnZ46rS+czcuoKfg5+WHiJCajg+SCIsRURIctMRBgW8Skkx602A
         NNsmXDYBOQZ/IbP22vdlua0smrOF5ZuzoLrLav/WcoLZYyk/3Y50sQ4ruMP2ZNdvoCtQ
         1yuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690352243; x=1690957043;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xkFICdvw0eO5WMVxHngflASegVtH5FxSGHtFBl09lsw=;
        b=TgNlWb6KDLc+JFZQB9IV3BORuhD/vU1h+rh0JarXK/gIfPo5R6RxO4vKJ54Fskhqte
         ZqvT7gj5UcbxM1Q18ZyL2KsU8Xk7osVGcrH/A3UdazARq+MA55GsLCsIFg8tybcbe+eU
         PVcxQmRke4xKMtL0Hgop8lggHHWCIrR0dbdJX1mG+kxuCG6BQdt+i9KJQyVf6PAUo3sM
         3xjp/T38hbqe20CNyZHu7TlnJdXhBoGvTPzTl/BYw6x7WvQFyEAquxxd1wMRdM6a3U5n
         t/YbDSjKU1O/L+eTS6ZKhnwiH9fAk0Qb5wgIlJbCYgYMcea6dpR6BNfzMJxGhWXfylWF
         Irog==
X-Gm-Message-State: ABy/qLbs78bv3MS/nQH3zd6DOgrwDakb+4skUwqNy5tSe6M5rZ48YktZ
        TxfimcGL1+6+fQQDqymZ848XXEklUnxUFXGE+A5iOml2Efs=
X-Google-Smtp-Source: APBJJlFkaodBapyVejMgOUBE+o9pxsTZgtVhwV7jU48M7GSCdrAy/DbqZNOwe1EqqPYOLyRoKdsByf/NlKNJfgWjtFQ=
X-Received: by 2002:a2e:8509:0:b0:2b5:7f93:b3b0 with SMTP id
 j9-20020a2e8509000000b002b57f93b3b0mr665295lji.17.1690352243219; Tue, 25 Jul
 2023 23:17:23 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 26 Jul 2023 01:17:12 -0500
Message-ID: <CAH2r5muSHRKyEq8tuivVSAvDW4ko37UVrKNAfNSveDy09mP=Hg@mail.gmail.com>
Subject: [GIT PULL] ksmbd server fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
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
06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  git://git.samba.org/ksmbd.git tags/6.5-rc3-ksmbd-server-fixes

for you to fetch changes up to 536bb492d39bb6c080c92f31e8a55fe9934f452b:

  ksmbd: fix out of bounds in init_smb2_rsp_hdr() (2023-07-23 10:25:11 -0500)

----------------------------------------------------------------
Six ksmbd server fixes including for stable, and four reported by ZDI
- fixes for two possible out of bounds access (in negotiate, and in decrypt msg)
- fix unsigned compared to zero warning
- fix path lookup crossing a mountpoint
- fix case when first compound request is a tree connect
- fix memory leak if reads are compounded

----------------------------------------------------------------
Namjae Jeon (5):
      ksmbd: check if a mount point is crossed during path lookup
      ksmbd: fix out of bounds in smb3_decrypt_req()
      ksmbd: validate session id and tree id in compound request
      ksmbd: no response from compound read
      ksmbd: fix out of bounds in init_smb2_rsp_hdr()

Wang Ming (1):
      ksmbd: Fix unsigned expression compared with zero

 fs/smb/server/ksmbd_netlink.h |  3 ++-
 fs/smb/server/server.c        |  7 ++++++-
 fs/smb/server/smb2pdu.c       | 47
+++++++++++++++++++++++++++------------------
 fs/smb/server/smb_common.c    | 19 +++++++++++--------
 fs/smb/server/smb_common.h    |  2 +-
 fs/smb/server/vfs.c           | 65
++++++++++++++++++++++++++++++++++++---------------------------
 fs/smb/server/vfs.h           |  4 ++--
 7 files changed, 88 insertions(+), 59 deletions(-)

-- 
Thanks,

Steve
