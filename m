Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C99A781A5A
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 17:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233480AbjHSP2t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 11:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbjHSP2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 11:28:48 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 317259ECB;
        Sat, 19 Aug 2023 08:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1692458922; x=1693063722; i=deller@gmx.de;
 bh=GRhMdDZNp3zW4FxJHaNo2GmRxhT3B7zEJwqADRAFfVg=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=rlw8ytj9Da5zSHn9v0Kjb7C75K+seKOzWcUfgPYNvIndiOMA4/jLZaR8I33IPlcDIdI7F1g
 uNlqnfR3i2AD+6FZP37iqYPIO6hKHAhkYhJ4kXXLvXD9WnMqXsreOawiSCdgxUhFTS+RSpYB0
 yWLB9yvL0mTA6bxP793Myt7r8VM3CyjyIX/uaTyqVlOPpynQk+ECCRq96SBQ+LP6+c/pwTzZ+
 8LQPKEL4De+fY56pLqTaFzIq4I6rOHPrRqLf6s2Mm8d6sbnaAVrtJF0OhUgkwG6liWqq5lcpX
 HTe51pZ6TKRZBIX1lZvJAlBO9PFEyPvSvUqvcRzClEbZNDJy5Uaw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ls3530 ([94.134.154.181]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N33Il-1pbB0p0cgf-013KU5; Sat, 19
 Aug 2023 17:28:42 +0200
Date:   Sat, 19 Aug 2023 17:28:40 +0200
From:   Helge Deller <deller@gmx.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: [GIT PULL] fbdev fixes and cleanups for v6.5-rc7
Message-ID: <ZODfqGYs/M1xvIJ8@ls3530>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pKs7SJVGe9ugwZ/dOlqAYRFGkUafB0lJnYYxWvxV9XIFDAsQh3z
 Y0xHT3nbUU7Rbdmy/V5CwraQcBpVso83EyWzbsAcIPLUUNJZ6ZdyItw+y7Z1aIiSDNQEb6c
 wsIJubMOv5BkrUa6F+jUIEf7sohU18ARXoxFihfUJ1azSO1R+xB8NUKCtlr2KBjrYYXC4QS
 /iYlTwGKGte5YrjKVqnbg==
UI-OutboundReport: notjunk:1;M01:P0:yrYXlY6oIb0=;4AnfTikvFab7mqgB0esy7e/Txpe
 fq7Vrut2cUueAcSpTpRg0QKAXmAuzCPjPtfaHTyB65Tfc1yNhVA1xuG+YRoNgeL8SIKX0Dipo
 SFNapE83XQYCh6xzdCqCJCvJ8Kz4l0pN/1Y6h7xxgdLwnK0xaNeXW2hkkRLWH2t9Tk8s/Uqml
 mtryBan86tBsMxGE66IwR3F3ZDFqkg4AAZuWGVNOCy+mz4q9Nkz7Jx3ti4/B1NWq0MISmXR6J
 sleb73R5TPdz/8CT4mblJ2ZB3egZnqVKE8LUUHD5jAv8Vdih+5QZoUsXYa7hAANBqjk514cmB
 6m9hVzo7BzTtDHYVGESWzEajGxFrrcXjRdiA5b0tYvT0M5/TeI+CY+JR63uVhXshix6e4ETgl
 sUQ7Rh+6o0yOGuBFz18INP6pz4p2BCHVsMsvyngNSt5jY5CXiW/GLm0/AHlLYVgmvLsNWv0ea
 hk7LDULvb22PjMbtQRBU2NNdB12kULWYUzUZQ561apdhjVk2a3Dtk1lA6W6SnQ0T8WGaHAYGS
 4BY90qSoxCc0p4sj9HbN3PeAOFIDuP64iUYPSceE02c7OFpW8T+0OdbJtyPAqfa7HVp5aTVKY
 wMl7ttudIxgrMjzQJL3t3xK7eRacnnRDBwh0e7No9yoULG1bQF0Zo57IjK1ATGK1YrELZHju5
 2L7yaj9aCtu/wwGjPRWFGkJjY/+Ym0TA3DQbuhyTltoaF8BiPdNwewIYzwFrwlNrWAoSgt8Qv
 lqTIn5QLYPjxuic3Abq2kuB1LCqyF4k/gGpyu6fwdsveijYz+SBDOBor6NyjRYzyJ7RoQhzV9
 4hlkGjawSK0ls5UFdojKdutKgG10I+ypbOlqrQT72p/CcXM30mhtadDZe170kj7BwyNlTGhpE
 tLdjDl8jhvxpx4DTsGG/lptJwe84TXSsbSKxQD0tlkr62H8Pxk70dLX0mN32ShOzbhC/a++WU
 +MUtkFGJbInmyMed0idvvuD3SgY=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull some small fbdev fixes & cleanups for kernel 6.5-rc7.

Various code cleanups in amifb, atmel_lcdfb, ssd1307fb, kyro and goldfishf=
b.

Thanks!
Helge

=2D-------------

The following changes since commit 5d0c230f1de8c7515b6567d9afba1f196fb4e2f=
4:

  Linux 6.5-rc4 (2023-07-30 13:23:47 -0700)

are available in the Git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/deller/linux-fbdev.git ta=
gs/fbdev-for-6.5-rc7

for you to fetch changes up to 0650d5098f8b6b232cd5ea0e15437fc38f7d63ba:

  fbdev: goldfishfb: Do not check 0 for platform_get_irq() (2023-08-15 23:=
39:33 +0200)

=2D---------------------------------------------------------------
fbdev fixes and cleanups for 6.5-rc7:

- various code cleanups in amifb, atmel_lcdfb, ssd1307fb, kyro and goldfis=
hfb

=2D---------------------------------------------------------------
Atul Raut (1):
      fbdev: amifb: Replace zero-length arrays with DECLARE_FLEX_ARRAY() h=
elper

Ruan Jinjie (1):
      fbdev: atmel_lcdfb: Remove redundant of_match_ptr()

Uwe Kleine-K=F6nig (1):
      fbdev: ssd1307fb: Print the PWM's label instead of its number

Yuanjun Gong (1):
      fbdev: mmp: fix value check in mmphw_probe()

Yue Haibing (1):
      fbdev: kyro: Remove unused declarations

Zhu Wang (1):
      fbdev: goldfishfb: Do not check 0 for platform_get_irq()

 drivers/video/fbdev/amifb.c           |  2 +-
 drivers/video/fbdev/atmel_lcdfb.c     |  2 +-
 drivers/video/fbdev/goldfishfb.c      |  4 ++--
 drivers/video/fbdev/mmp/hw/mmp_ctrl.c |  4 +++-
 drivers/video/fbdev/ssd1307fb.c       |  4 ++--
 include/video/kyro.h                  | 12 ------------
 6 files changed, 9 insertions(+), 19 deletions(-)
