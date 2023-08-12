Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49AD779EDA
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 12:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236335AbjHLKRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 06:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjHLKRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 06:17:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3723E2133;
        Sat, 12 Aug 2023 03:17:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9B95627D0;
        Sat, 12 Aug 2023 10:17:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F6AC433C8;
        Sat, 12 Aug 2023 10:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691835429;
        bh=6KGjl4ZuzTY+sVa6wHpgVBZci7895Ma+lGQhtvuLk2A=;
        h=Date:From:To:Cc:Subject:From;
        b=gJFCxdQUXl9Fl2xmyO92CPc0evmsYbUhpsqdOGtqPFcJiCXbtOoFYR2jhETYKYmvN
         d3/OlsdAFDfdBWzFw+gLyHQNwQYmcPGC95fVhDdrzCoYQ275Nth+3f7fuocRSWAwFZ
         sPRzTItMbZs0j96v0dEzi1j5C4/MBVWXf/d7d7Lo=
Date:   Sat, 12 Aug 2023 12:17:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB / Thunderbolt driver fixes for 6.5-rc6
Message-ID: <ZNdcIir55QE1o2mO@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4:

  Linux 6.5-rc4 (2023-07-30 13:23:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.5-rc6

for you to fetch changes up to f48585c468f51ac038c2cfaafcd4437bc3746bce:

  Merge tag 'thunderbolt-for-v6.5-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-linus (2023-08-08 10:04:47 +0200)

----------------------------------------------------------------
USB/Thunderbolt driver fixes for 6.5-rc6

Here are some small USB and Thunderbolt driver fixes for reported
problems.  Included in here are:
  - thunderbolt driver memory leak fix
  - thunderbolt display flicker fix
  - usb dwc3 driver fix
  - usb gadget uvc disconnect crash fix
  - usb typec Kconfig build dependency fix
  - usb typec small fixes
  - usb-con-gpio bugfix
  - usb-storage old driver bugfix

All of these have been in linux-next for a while with no reported
issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Alan Stern (2):
      USB: Gadget: core: Help prevent panic during UVC unconfigure
      usb-storage: alauda: Fix uninit-value in alauda_check_media()

Badhri Jagan Sridharan (1):
      usb: typec: tcpm: Fix response to vsafe0V event

Christophe JAILLET (1):
      usb: typec: nb7vpq904m: Add an error handling path in nb7vpq904m_probe()

Elson Roy Serrao (1):
      usb: dwc3: Properly handle processing of pending events

Greg Kroah-Hartman (1):
      Merge tag 'thunderbolt-for-v6.5-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-linus

Heikki Krogerus (1):
      usb: typec: mux: intel: Add dependency on USB_COMMON

Mika Westerberg (1):
      thunderbolt: Fix memory leak in tb_handle_dp_bandwidth_request()

Prashanth K (1):
      usb: common: usb-conn-gpio: Prevent bailing out if initial role is none

RD Babiera (1):
      usb: typec: altmodes/displayport: Signal hpd when configuring pin assignment

Sanjay R Mehta (1):
      thunderbolt: Fix Thunderbolt 3 display flickering issue on 2nd hot plug onwards

 drivers/thunderbolt/tb.c                 |  2 ++
 drivers/thunderbolt/tmu.c                |  4 +++-
 drivers/usb/common/usb-conn-gpio.c       |  6 +++++-
 drivers/usb/dwc3/gadget.c                |  9 ++++++++-
 drivers/usb/gadget/udc/core.c            |  9 +++++++++
 drivers/usb/storage/alauda.c             | 12 +++++++++---
 drivers/usb/typec/altmodes/displayport.c | 18 +++++++++++++++++-
 drivers/usb/typec/mux/Kconfig            |  1 +
 drivers/usb/typec/mux/nb7vpq904m.c       | 25 ++++++++++++++++++-------
 drivers/usb/typec/tcpm/tcpm.c            |  7 +++++++
 10 files changed, 79 insertions(+), 14 deletions(-)
