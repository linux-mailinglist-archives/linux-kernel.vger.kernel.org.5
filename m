Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682FB790F8E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 03:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239622AbjIDBIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 21:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231252AbjIDBIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 21:08:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236DFBB;
        Sun,  3 Sep 2023 18:08:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC12560DEF;
        Mon,  4 Sep 2023 01:08:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4FEC433C8;
        Mon,  4 Sep 2023 01:08:09 +0000 (UTC)
Message-ID: <fe6c0932-ac00-8a81-4eae-8759547ddd1f@linux-m68k.org>
Date:   Mon, 4 Sep 2023 11:08:06 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Greg Ungerer <gerg@linux-m68k.org>
Subject: [git pull] m68knommu changes for v6.6
To:     torvalds@linux-foundation.org
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>, gerg@kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull the m68knommu git tree changes for v6.6.

Two changes, one a trivial white space clean up, the other removes the
unnecessary local pcibios_setup() code.

Regards
Greg




The following changes since commit 706a741595047797872e669b3101429ab8d378ef:

   Linux 6.5-rc7 (2023-08-20 15:02:52 +0200)

are available in the Git repository at:

   git://git.kernel.org/pub/scm/linux/kernel/git/gerg/m68knommu.git 
tags/m68knommu-for-v6.6

for you to fetch changes up to cf18ecd34f71dfd2815046d4c0d7b6439bb0cbde:

   m68k: coldfire: dma_timer: ERROR: "foo __init bar" should be "foo 
__init bar" (2023-08-21 08:45:36 +1000)

----------------------------------------------------------------
m68knommu: updates and fixes for v6.6

Fixes include:
. white space cleanup in dma code
. removal of unused pcibios_setup() code

----------------------------------------------------------------
Bjorn Helgaas (1):
       m68k/pci: Drop useless pcibios_setup()

hexingwei001@208suo.com (1):
       m68k: coldfire: dma_timer: ERROR: "foo __init bar" should be "foo 
__init bar"

  arch/m68k/coldfire/dma_timer.c | 2 +-
  arch/m68k/kernel/pcibios.c     | 6 ------
  2 files changed, 1 insertion(+), 7 deletions(-)
