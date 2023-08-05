Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDEBE770DFE
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 08:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjHEGCo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 02:02:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHEGCl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 02:02:41 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79ADA4ECF;
        Fri,  4 Aug 2023 23:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1691215342; x=1691820142; i=deller@gmx.de;
 bh=ADlQgcxxX/BU3meLqwOkBqG5Uzdi6RZo+u1FT7knl6U=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=gk8Qi0QCkgdVjVTfM9U69Mzo9Uc+ymgLzElHDOFC7or7i10m41zGdyxIplAzP0W6qq/uAmV
 ay/PnK2Y/QDsC1UBaBnfOi6cp4z5iW+vASMxX2lRpkx6x8RApay+1zKKkaRCh91M3PfT+pzfR
 Mv3mRlx8w38jXfmRdhZBPf+1EAvweed9Bu21dBnBZT9bFsw7/NuOiDvH7Bu1A8r3+5/3JhTxI
 k7nJoBHNbrf5wS7UO1vQCRjtUggODVKel1JUU1R8lNTEMWmh7IYv1QJ9HZDRtShFhseb/Ar+b
 uVPCLjIQl/STuipsWEEEgznFXrriYvRQ9C1kC8h0REhYaf3cOAEw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.145.133]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N17YY-1piHw40rGs-012Wlg; Sat, 05
 Aug 2023 08:02:22 +0200
Date:   Sat, 5 Aug 2023 08:02:20 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
Subject: [GIT PULL] parisc architecture fixes for v6.5-rc5
Message-ID: <ZM3l7IiQKzkkN29S@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:qIacwImC/KQv3KrLeNeSEvxudHKIcxlDO+upSSkLn10lL/cBUwz
 JmamHh5xKjn7nJkzGWwk9sY9RwTy5N7EUeeRN/InzeRmSj0gJHx3R2iXrK72V09FtGHYuQo
 Ds9TeKcMQidaum8rsScAFx7Wd3U+bGq6VusvHuao+fYPkNtTc+LanjEBSv1KLdiL/xGTc1V
 UTgsxIUjyy/K4ADcG8LRg==
UI-OutboundReport: notjunk:1;M01:P0:0zul3E6pVyk=;RGxKYTrpT8sI7a4TkJHoC4/vThk
 lkagKIg1lbZRbZZ2/8QfdsxwRpEIDJkgU8Sz/U193avHz4F9K/oSn6rAgPN0+n16DbpElKhcV
 FQFmLWVbTtPZr+k8+8bcFyy992c/jNsFsq2Pfbo7nNyT+XwPm1w5sNv5c53tEYu80wNiD6put
 nIlbuAPUsioJsY+vBqvUzRKXcjxuluFfu6Yr0Ju/2cXPYh1Nf8KcX9rg7xNzgdiAI+9t8hFjq
 ECGvCYKOqeG8zKGFmVvjtEawFY2Wr1kuKuucvFBcR1pkjuxy99KF1H6RNb3aYg1hx9ShlRfG5
 8e3L4V89rxib8GuYvXpFhBDw9OA11iZiysAMtu5o8z9iEm6j3tirVk27ZH3wnyyy0jhPDm+Rb
 SiFvT51YtmT/EdfGVdaRee4kDJoxngda5xAbauIjeBQT6895EXohxfy1x/J50BuYnQ4nLYzHI
 IvQNs9mNYfMOu2AWWoH4rQ1ut59upkGCOPfWI3Q3bV4U47kfkF0v4pZ9HExG8yrpQPWOOLY9d
 iXXfZFknYZRGNZC0Z7QW+M27twngbdf7sdyRhXplcZs3Vx1r1lOPuV+3fOtkTubRvlr2OlxYf
 SyjG7I2HuQTwz3tcpRD6eKY9ZiS3OF6GJ7+v1X77vxuICvsS8xh+bie5MZpGJT3MCpb9gVaBw
 WwQUd5XYK8SCtWlnjQYvvs9vlyVv7ZXUiERlLk5Xxz1g3Y7ghpyQG+wmX/ENeJp3W7IRT2LZq
 /oYymWOoXkYSCJZZOEzXWITtA80tx3DBAGynQZ0hnvpE8Gr1svF+ydwZ3LoqBmXEfAWvXAyG4
 DnzAd7tAg4xDstnwmLK276TfQm+WkqJ/uwuFzO2CvIaepQRfdLqDyoLCmTb6R7UvXjQOgStLW
 FyR16qJoSh2oBoqebI5+k5p6wUSzOulhyCwVfeY2dp8/RRAa/8yRc2RDqFY/f9OL2f3W+AKPW
 mPp6/wjENrznJWkIgK4TDr3MbXY=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull a few fixes for the parisc architecture for kernel 6.5-rc5.

- Preallocate fixmap page tables early, which prevents crashes in static
  keycode patching since the page allocator isn't initialized yet.  This
  fixes boot problems which occured since kernel 6.4 [Mike Rapoport]

- DMA code removal from parport_gsc driver [Arnd Bergmann]

- coding style fixes and dead comment removal

Thanks!
Helge

----

The following changes since commit 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4:

  Linux 6.5-rc4 (2023-07-30 13:23:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/deller/parisc-linux.git tags/parisc-for-6.5-rc5

for you to fetch changes up to 99b2f159b6e76b84357eae6dc2a206871aa630d5:

  parisc: unaligned: Add required spaces after ',' (2023-08-03 14:40:37 +0200)

----------------------------------------------------------------
parisc architecture fixes for kernel v6.5-rc5:

- early fixmap preallocation to fix boot failures on kernel >= 6.4
- remove DMA leftover code in parport_gsc
- drop old comments and code style fixes

----------------------------------------------------------------
Arnd Bergmann (1):
      parport: gsc: remove DMA leftover code

Mike Rapoport (IBM) (1):
      parisc/mm: preallocate fixmap page tables at init

Petr Tesarik (1):
      parisc: pci-dma: remove unused and dead EISA code and comment

hanyu001@208suo.com (1):
      parisc: unaligned: Add required spaces after ','

 arch/parisc/kernel/pci-dma.c   |  8 --------
 arch/parisc/kernel/unaligned.c | 18 +++++++++---------
 arch/parisc/mm/fixmap.c        |  3 ---
 arch/parisc/mm/init.c          | 34 ++++++++++++++++++++++++++++++++++
 drivers/parport/parport_gsc.c  | 28 ++++------------------------
 drivers/parport/parport_gsc.h  |  7 -------
 6 files changed, 47 insertions(+), 51 deletions(-)
