Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2446799B23
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Sep 2023 22:29:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236862AbjIIU3q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 9 Sep 2023 16:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjIIU3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 16:29:43 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AA519E;
        Sat,  9 Sep 2023 13:29:38 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qf4a0-003NNt-FK; Sat, 09 Sep 2023 22:29:20 +0200
Received: from dynamic-089-014-158-203.89.14.pool.telefonica.de ([89.14.158.203] helo=[192.168.1.11])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qf4a0-0025rN-5I; Sat, 09 Sep 2023 22:29:20 +0200
Message-ID: <86e6baa7dc92b42440c1e07332c876530306eaa3.camel@physik.fu-berlin.de>
Subject: [GIT PULL] sh updates for v6.6
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Duoming Zhou <duoming@zju.edu.cn>,
        Petr Tesarik <petr.tesarik.ext@huawei.com>,
        Rich Felker <dalias@libc.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Sat, 09 Sep 2023 22:29:11 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 89.14.158.203
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

I am very late this merge window since I was rather busy the past month but
as there are only two small fixes in this pull request, I hope you are still
willing to pull the sh changes for v6.6.

The first patch by Duoming Zhou fixes a use-after-free bug in the push-switch
driver while the second one by Petr Tesarik addresses an issue where the call
to dma_declare_coherent_memory() incorrectly passes the buffer end address
instead of the buffer size as the size parameter.

I expect the pull request for v6.7 much larger since we're currently working
on converting arch/sh to using device trees for which the patches have now
been posted on the linux-sh mailing list.
 
The following changes since commit fdf0eaf11452d72945af31804e2a1048ee1b574c:

  Linux 6.5-rc2 (2023-07-16 15:10:37 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/glaubitz/sh-linux.git tags/sh-for-v6.6-tag1

for you to fetch changes up to 246f80a0b17f8f582b2c0996db02998239057c65:

  sh: push-switch: Reorder cleanup operations to avoid use-after-free bug (2023-09-09 21:54:20 +0200)

Thanks for pulling!

Adrian

----------------------------------------------------------------
sh updates for v6.6

- sh: push-switch: Reorder cleanup operations to avoid use-after-free bug
- sh: boards: Fix CEU buffer size passed to dma_declare_coherent_memory()

----------------------------------------------------------------
Duoming Zhou (1):
      sh: push-switch: Reorder cleanup operations to avoid use-after-free bug

Petr Tesarik (1):
      sh: boards: Fix CEU buffer size passed to dma_declare_coherent_memory()

 arch/sh/boards/mach-ap325rxa/setup.c | 2 +-
 arch/sh/boards/mach-ecovec24/setup.c | 6 ++----
 arch/sh/boards/mach-kfr2r09/setup.c  | 2 +-
 arch/sh/boards/mach-migor/setup.c    | 2 +-
 arch/sh/boards/mach-se/7724/setup.c  | 6 ++----
 arch/sh/drivers/push-switch.c        | 2 +-
 6 files changed, 8 insertions(+), 12 deletions(-)

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
