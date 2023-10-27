Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407217D94CA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 12:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345689AbjJ0KJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 06:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345670AbjJ0KJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 06:09:37 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5936AB0;
        Fri, 27 Oct 2023 03:09:35 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 65C4A40E01A3;
        Fri, 27 Oct 2023 10:09:33 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Y3oUyM1dWbPJ; Fri, 27 Oct 2023 10:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1698401371; bh=L8XedwDqBaH4e+x9C7cw85DjpNUpE28RmOdNZJ+MI24=;
        h=Date:From:To:Cc:Subject:From;
        b=YdJFbx3ZIowdFziEfnR1FYn/Ve+8gd4I+9I7Ahvmer9lg/l3Jn5Xhmfib6fmU1O5p
         yXvfbay/hHkpBglowNovNiyQxH1+nGAhhbaiVdJbzTlmo0nv3cj9hCpL8ZNZ08qye2
         K9KPvUsyibnZ6Zh61a4EJqeFUq5KbDFs/xk/GvZJBOyb8eFmEEgpRw7NRH0cmzmoZ+
         H+roLmtOBJu9daIh9U9rsX14euJ2MmGHwln57mu1TU+LFpXFY9qdbqtCJxEWjbpEWS
         /g9Sa3a48jMKUCm8Xr5RjWJHviCVcoeKvTbIPSMLhAQ5YiwLfpzGXn7l0ip25hxsdv
         1TFxBn3sDYbuz7vSlRh6TxCI9zGCxoX5QVEH0LEgUlqLiYHwi07zVOc6XuXGNXD0Jo
         Moqe3eTG+Ks6YzOWZuylxtWmqneZQboRy4jNLhtnImFXt+PmBffoe/gpWkStBwOa/3
         n6WhNaw8FZFrxX0FyA+hiUfnBHAMnnaNo+NGDfFu7MNnxK52ZwMeeugVLIRRLu3rBk
         bKxIH/l0wZA2PProMAGc2b9HjRZmXpPvUgkDs7FJGEswADPKgtApEsnTLVR9BX8/+f
         hZbZztoHPit+z+iJiNZ3EKsgJM5i3vGHoLEPG77zI42NJPeoTAsRJSIpQOPP5KIIBr
         mFBZwxMz4VCqEC1s2dXrkW4Y=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 1F9E440E018F;
        Fri, 27 Oct 2023 10:09:28 +0000 (UTC)
Date:   Fri, 27 Oct 2023 12:09:20 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-edac <linux-edac@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] EDAC updates for v6.7
Message-ID: <20231027100920.GAZTuMUJEP5LI7mZ+S@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull EDAC updates for 6.7. I know, the merge window hasn't opened
yet but lemme send you the stuff which is ready anyway and since you
prefer early pull requests...

Thx.

---

The following changes since commit 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa:

  Linux 6.6-rc4 (2023-10-01 14:15:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ras/ras.git tags/edac_updates_for_v6.7

for you to fetch changes up to 6f15b178cd6315c997981f76c6ebed7ad39144c5:

  EDAC/versal: Add a Xilinx Versal memory controller driver (2023-10-23 19:41:27 +0200)

----------------------------------------------------------------
- A new EDAC driver for Xilinx's Versal integrated memory controller

----------------------------------------------------------------
Shubhrajyoti Datta (2):
      dt-bindings: memory-controllers: Add support for Xilinx Versal EDAC for DDRMC
      EDAC/versal: Add a Xilinx Versal memory controller driver

 .../memory-controllers/xlnx,versal-ddrmc-edac.yaml |   57 ++
 MAINTAINERS                                        |    7 +
 drivers/edac/Kconfig                               |   12 +
 drivers/edac/Makefile                              |    1 +
 drivers/edac/versal_edac.c                         | 1069 ++++++++++++++++++++
 include/linux/firmware/xlnx-zynqmp.h               |   12 +
 6 files changed, 1158 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/xlnx,versal-ddrmc-edac.yaml
 create mode 100644 drivers/edac/versal_edac.c

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
