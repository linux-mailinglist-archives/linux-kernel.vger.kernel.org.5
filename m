Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8AF7DEBD1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 05:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348459AbjKBEVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 00:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348429AbjKBEVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 00:21:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2997127;
        Wed,  1 Nov 2023 21:21:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81275C433C7;
        Thu,  2 Nov 2023 04:21:15 +0000 (UTC)
Message-ID: <49bc6b4b-e2c5-4f83-b160-6062205cb2c3@linux-m68k.org>
Date:   Thu, 2 Nov 2023 14:21:13 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Greg Ungerer <gerg@linux-m68k.org>
Subject: [git pull] m68knommu changes for v6.7
To:     torvalds@linux-foundation.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, gerg@kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the m68knommu git tree changes for v6.7.

A few changes, most of them related to fixing warnings when compiling
with "W=1". These follow up Geert's recent changes for M68K for this too.
These ones complete the fixes for the nommu and ColdFire specific code.

Also a couple of other fixes to improve ROM default addressing and
compiling for the Cleopatra boards.

Regards
Greg




The following changes since commit 05d3ef8bba77c1b5f98d941d8b2d4aeab8118ef1:

   Linux 6.6-rc7 (2023-10-22 12:11:21 -1000)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git tags/m68knommu-for-v6.7

for you to fetch changes up to 2508b608f4028c6fe0d63698f64a9bfc3eb6b780:

   m68k: 68000: fix warning in timer code (2023-10-23 08:22:22 +1000)

----------------------------------------------------------------
m68knommu: updates and fixes for v6.7

Fixes include.
. improve default Kconfig ROM section settings
. fix compilation for some Cleopatra boards
. fixes and cleanups for warnings compiling with "W=1"

----------------------------------------------------------------
Greg Ungerer (9):
       m68knommu: improve config ROM setting defaults
       m68knommu: fix compilation for ColdFire/Cleopatra boards
       m68k: coldfire: add and use "vectors.h"
       m68k: coldfire: ensure gpio prototypes visible
       m68k: coldfire: make mcf_maskimr() static
       m68k: coldfire: fix warnings in uboot argument processing
       m68k: coldfire: remove unused variable in MMU code
       m68k: 68000: fix warnings in 68000 interrupt handling
       m68k: 68000: fix warning in timer code

  arch/m68k/68000/ints.c          |  5 ++++-
  arch/m68k/68000/ints.h          |  7 +++++++
  arch/m68k/68000/timers.c        |  2 ++
  arch/m68k/Kconfig.machine       |  4 ++--
  arch/m68k/coldfire/intc.c       |  4 ++--
  arch/m68k/coldfire/vectors.c    |  2 ++
  arch/m68k/coldfire/vectors.h    |  3 +++
  arch/m68k/include/asm/mcfgpio.h |  8 ++++----
  arch/m68k/include/asm/nettel.h  |  5 ++---
  arch/m68k/kernel/uboot.c        | 13 ++++++++-----
  arch/m68k/mm/mcfmmu.c           |  3 +--
  11 files changed, 37 insertions(+), 19 deletions(-)
  create mode 100644 arch/m68k/68000/ints.h
  create mode 100644 arch/m68k/coldfire/vectors.h
