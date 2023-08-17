Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6D1877F988
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345190AbjHQOpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352164AbjHQOpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:45:08 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416D2C7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:45:05 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:d85a:258d:2c59:b44])
        by baptiste.telenet-ops.be with bizsmtp
        id aeky2A00Q4QHFyo01eky42; Thu, 17 Aug 2023 16:44:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWeF1-000u8c-5u;
        Thu, 17 Aug 2023 16:44:58 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWeF8-007SBJ-LE;
        Thu, 17 Aug 2023 16:44:58 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 0/6] m68k: math-emu: Miscellaneous esthetical improvements
Date:   Thu, 17 Aug 2023 16:44:47 +0200
Message-Id: <cover.1692283195.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

This patch series contains miscellaneous esthetical improvements for the
Linux/m68k floating point emulator.  They have no functional impact.
The main objective is to get rid of the compiler warnings when building
with W=1.

I plan to queue this in the m68k tree rather sooner than later.

Thanks for your comments!

Geert Uytterhoeven (6):
  m68k: math-emu: Fix incorrect file reference in fp_log.c
  m68k: math-emu: Sanitize include guards
  m68k: math-emu: Make multi_arith.h self-contained
  m68k: math-emu: Replace external declarations by header inclusion
  m68k: math-emu: Reformat function and variable headers
  m68k: math-emu: Add missing prototypes

 arch/m68k/math-emu/fp_arith.c    | 49 ++++++++++-------------------
 arch/m68k/math-emu/fp_arith.h    | 49 +++++++++++------------------
 arch/m68k/math-emu/fp_log.c      | 46 ++++++++++-----------------
 arch/m68k/math-emu/fp_log.h      | 44 ++++++++++++++++++++++++++
 arch/m68k/math-emu/fp_trig.c     | 54 +++++++++++---------------------
 arch/m68k/math-emu/fp_trig.h     | 25 +++++++++++++--
 arch/m68k/math-emu/multi_arith.h |  8 +++--
 7 files changed, 142 insertions(+), 133 deletions(-)
 create mode 100644 arch/m68k/math-emu/fp_log.h

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
