Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C1B7A5152
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 19:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjIRR4a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 13:56:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjIRR43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:56:29 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684ABDB;
        Mon, 18 Sep 2023 10:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=n8pjl.ca;
        s=protonmail2; t=1695059779; x=1695318979;
        bh=KDmGL0149HMvYz0D68P8rK9iJncYI66ZFd51OEaftAc=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=XDyAGqfxs1IhZyrSbs3kXmWVIDtAAGsbXg/jRzsX7fuS5Oxw4QNBzYWsvFGPZ+ksw
         S5Zcze4DfsU+j4F71vMZOBVGe3BZKYabMh1wfnbZ2ABquD3iq/MryJ0VB04GGHqRW3
         gnQBHdLwQI3E7N3+pV5UgFQGhEjTazGFHroCb4KlhwP9A18gG508T7Pqs5jbffIgxO
         cUkXsv81IXGY6O6u6TWRNYFNwN9rAhwcn1b7zAnxuUbHTSaeD2idJu0SKxFygNCYtF
         S9e7CJc5qlz+kEo5lV3WyEyT1tOTgZkgAyKcyZB3b18aHv/xFJwzM9+FJT8sFeXCTe
         SfZ1idLrRGTVw==
Date:   Mon, 18 Sep 2023 17:56:09 +0000
To:     reiserfs-devel@vger.kernel.org
From:   Peter Lafreniere <peter@n8pjl.ca>
Cc:     Peter Lafreniere <peter@n8pjl.ca>, jack@suse.cz,
        linux-kernel@vger.kernel.org, richard@nod.at,
        anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
        linuxppc-dev@lists.ozlabs.org, linux-um@lists.infradead.org,
        linux-sh@vger.kernel.org, tsbogend@alpha.franken.de,
        linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        geert@linux-m68k.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk, linux-alpha@vger.kernel.org,
        richard.henderson@linaro.org, ink@jurassic.park.msu.ru
Subject: [PATCH 0/7] arch/*: config: Remove ReiserFS from defconfig
Message-ID: <20230918175529.19011-1-peter@n8pjl.ca>
Feedback-ID: 53133685:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ReiserFS has been considered deprecated for 19 months since commit
eb103a51640e ("reiserfs: Deprecate reiserfs"). However, there are
several architectures that still build it into their defconfig kernels.

As ReiserFS will be removed in 2025, delete all ReiserFS-related options
from defconfig files before the filesystem's removal.

The series is intended to be approved/rejected on an arch-by-arch basis.
No patch is dependant upon another in the series.

See discussion originating in,
Link: https://lore.kernel.org/linux-um/20230918125744.4342-1-peter@n8pjl.ca=
/

Peter Lafreniere (7):
  arch: um: remove ReiserFS from defconfig
  arch: powerpc: remove ReiserFS from defconfig
  arch: sh: remove ReiserFS from defconfig
  arch: mips: remove ReiserFS from defconfig
  arch: m68k: remove ReiserFS from defconfig
  arch: arm: remove ReiserFS from defconfig
  arch: alpha: remove ReiserFS from defconfig

 arch/alpha/configs/defconfig                | 1 -
 arch/arm/configs/pxa_defconfig              | 4 ----
 arch/m68k/configs/amiga_defconfig           | 1 -
 arch/m68k/configs/apollo_defconfig          | 1 -
 arch/m68k/configs/atari_defconfig           | 1 -
 arch/m68k/configs/bvme6000_defconfig        | 1 -
 arch/m68k/configs/hp300_defconfig           | 1 -
 arch/m68k/configs/mac_defconfig             | 1 -
 arch/m68k/configs/multi_defconfig           | 1 -
 arch/m68k/configs/mvme147_defconfig         | 1 -
 arch/m68k/configs/mvme16x_defconfig         | 1 -
 arch/m68k/configs/q40_defconfig             | 1 -
 arch/m68k/configs/sun3_defconfig            | 1 -
 arch/m68k/configs/sun3x_defconfig           | 1 -
 arch/mips/configs/fuloong2e_defconfig       | 1 -
 arch/mips/configs/jazz_defconfig            | 4 ----
 arch/mips/configs/lemote2f_defconfig        | 3 ---
 arch/mips/configs/malta_defconfig           | 5 -----
 arch/mips/configs/malta_kvm_defconfig       | 5 -----
 arch/mips/configs/maltaup_xpa_defconfig     | 5 -----
 arch/mips/configs/rm200_defconfig           | 4 ----
 arch/powerpc/configs/44x/sam440ep_defconfig | 1 -
 arch/powerpc/configs/g5_defconfig           | 4 ----
 arch/powerpc/configs/ppc64e_defconfig       | 4 ----
 arch/powerpc/configs/ppc6xx_defconfig       | 5 -----
 arch/sh/configs/landisk_defconfig           | 1 -
 arch/sh/configs/titan_defconfig             | 1 -
 arch/um/configs/i386_defconfig              | 1 -
 arch/um/configs/x86_64_defconfig            | 1 -
 29 files changed, 62 deletions(-)

--=20
2.42.0


