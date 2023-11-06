Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFA97E2CD7
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjKFTac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbjKFTab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:30:31 -0500
X-Greylist: delayed 528 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Nov 2023 11:30:28 PST
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E381704
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:30:28 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
Received: from shine.dominikbrodowski.net (shine.brodo.linta [10.2.0.112])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 434C220160B;
        Mon,  6 Nov 2023 19:21:38 +0000 (UTC)
Received: by shine.dominikbrodowski.net (Postfix, from userid 1000)
        id C8D56A0086; Mon,  6 Nov 2023 20:13:29 +0100 (CET)
Date:   Mon, 6 Nov 2023 20:13:29 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] PCMCIA odd cleanups and fixes for v6.7-rc1
Message-ID: <ZUk62d3X1ETRrcuQ@shine.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

a few PCMCIA changes since commit 2dde18cd1d8fac735875f2e4987f11817cc0bc2c:

  Linux 6.5 (2023-08-27 14:49:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brodo/linux tags/pcmcia-6.7-rc1

for you to fetch changes up to 4f733de8b78a209501041a4b0a44c83ece0e8933:

  pcmcia: tcic: remove unneeded "&" in call to setup_timer() (2023-09-03 10:45:53 +0200)

----------------------------------------------------------------
PCMCIA odd cleanups and fixes for v6.7-rc1

Yang Yingliang has fixed a number of resource leaks and Dongliang Mu
contributed a spelling fix for the PCMCIA core. Also included is a tiny
clenaup to the tcic PCMCIA socket driver provided by lizhe.
----------------------------------------------------------------

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>


Dongliang Mu (1):
      pcmcia: typo fix

Yang Yingliang (3):
      pcmcia: cs: fix possible hung task and memory leak pccardd()
      pcmcia: ds: fix refcount leak in pcmcia_device_add()
      pcmcia: ds: fix possible name leak in error path in pcmcia_device_add()

lizhe (1):
      pcmcia: tcic: remove unneeded "&" in call to setup_timer()

 drivers/pcmcia/cs.c              |  1 +
 drivers/pcmcia/ds.c              | 14 +++++++++-----
 drivers/pcmcia/pcmcia_resource.c |  2 +-
 drivers/pcmcia/tcic.c            |  2 +-
 4 files changed, 12 insertions(+), 7 deletions(-)


Thanks,
	Dominik
