Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F96D7A46BF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240877AbjIRKPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240325AbjIRKPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:15:03 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05C7F1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 03:14:55 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:9622:9b2f:73fd:43ad])
        by laurent.telenet-ops.be with bizsmtp
        id nNEr2A00P4u9dj801NEreA; Mon, 18 Sep 2023 12:14:53 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qiBGw-003wYT-KP;
        Mon, 18 Sep 2023 12:14:51 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qiBHH-006GjQ-Ba;
        Mon, 18 Sep 2023 12:14:51 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Greg Ungerer <gerg@linux-m68k.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        linux-spdx@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 0/2] m68k/powerpc: Kill references to non-existent README.legal
Date:   Mon, 18 Sep 2023 12:14:42 +0200
Message-Id: <cover.1695031668.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi all,

Several source files contain license boilerplate that refers to the file
"README.legal", which never existed in upstream Linux.  This is a relic
from the early port of Linux to the m68k processor family, before it was
merged in v1.3.94.  Later, copies of this boilerplate ended up in the
PowerPC port.

The "README.legal" file (from e.g. [1]) read:

---8<-----------------------------------------------------------------
Legal information about the Linux/68k software package

All files contained in this archive are copyrighted by one or more
person.  They are not in the public domain.

Most of the files are copyrighted by Linus Torvalds, the original
writer of Linux for IBM PC clone systems.  Some parts are copyrighted
by other IBM PC linux developers.  Other parts are copyrighted by
Linux/68k developers.

This package is subject to the terms and conditions of the GNU General
Public License.  A copy of this license may be found in the file named
"COPYING" which should be in the same directory as this file.  If the
file has been omitted, you may obtain it by writing to the Free
Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
----------------------------------------------------------------->8---

Note that the "COPYING" file at that time corresponded to the version
from upstream Linux v0.99.11 until v2.1.104, and thus predated the
addition of the "only valid GPL version is v2" clause in v2.4.0-test8.

This patch series gets rid of the references to README.legal by
replacing the boilerplate with SPDX license identifiers.

Changes compared to v1[2]:
  - Add Acked-by,
  - s/existant/existent/.

Thanks for your comments!

[1] https://www.ibiblio.org/pub/historic-linux/ftp-archives/tsx-11.mit.edu/Oct-07-1996/680x0/v0.9/linux-0.9.tar.gz
[2] "[PATCH 0/2] m68k/powerpc: Kill references to non-existent README.legal
    https://lore.kernel.org/r/cover.1694095086.git.geert@linux-m68k.org

Geert Uytterhoeven (2):
  m68k: Replace GPL 2.0+ README.legal boilerplate with SPDX
  powerpc: Replace GPL 2.0+ README.legal boilerplate with SPDX

 arch/m68k/68000/entry.S             | 7 ++-----
 arch/m68k/bvme6000/config.c         | 5 +----
 arch/m68k/coldfire/entry.S          | 7 ++-----
 arch/m68k/ifpsp060/Makefile         | 6 ++----
 arch/m68k/kernel/entry.S            | 7 ++-----
 arch/m68k/kernel/head.S             | 8 ++------
 arch/m68k/mvme147/config.c          | 5 +----
 arch/m68k/mvme16x/config.c          | 5 +----
 arch/m68k/q40/config.c              | 5 +----
 arch/powerpc/kernel/ptrace/ptrace.c | 5 +----
 arch/powerpc/kernel/signal.c        | 5 +----
 arch/powerpc/kernel/signal.h        | 7 ++-----
 12 files changed, 18 insertions(+), 54 deletions(-)

-- 
2.34.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
