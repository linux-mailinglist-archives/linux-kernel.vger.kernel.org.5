Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D2C7C99C4
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Oct 2023 17:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjJOP1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 11:27:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjJOP1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 11:27:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF46DC5
        for <linux-kernel@vger.kernel.org>; Sun, 15 Oct 2023 08:27:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 058ABC433C8;
        Sun, 15 Oct 2023 15:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697383623;
        bh=QaSiZzIOTqhI2MaA+czQkWR9G885SWEjNZj9qefFAxE=;
        h=Date:From:To:Cc:Subject:From;
        b=XrOLXe1a9mNgw3KwaMWnPM56nk5HdRRqK6HZOKfTa444h3givBTgVDUq/zEJOwcLf
         27pAQ4YCLdZnxjf/Kn+ww+FP7CaorK/K0EtOpG4JTcFYWUqyt9KWbieW3Jn0N1PgXz
         MsOC/kWzFLI4SddzOmirYmREk3UZ6FSJTL6B9f04=
Date:   Sun, 15 Oct 2023 17:26:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [GIT PULL] USB/Thunderbolt fixes for 6.6-rc6
Message-ID: <ZSwEwMBjyYyiT9Tz@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 8a749fd1a8720d4619c91c8b6e7528c0a355c0aa:

  Linux 6.6-rc4 (2023-10-01 14:15:13 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git tags/usb-6.6-rc6

for you to fetch changes up to c9ca8de2eb15f9da24113e652980c61f95a47530:

  usb: typec: ucsi: Use GET_CAPABILITY attributes data to set power supply scope (2023-10-11 11:39:25 +0200)

----------------------------------------------------------------
USB/Thunderbolt fixes for 6.6-rc6

Here are some USB and Thunderbolt driver fixes for 6.6-rc6 to resolve a
number of small reported issues.  Included in here are:
  - thunderbolt driver fixes
  - xhci driver fixes
  - cdns3 driver fixes
  - musb driver fixes
  - a number of typec driver fixes
  - a few other small driver fixes

All of these have been in linux-next with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      Merge tag 'thunderbolt-for-v6.6-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/westeri/thunderbolt into usb-linus

Heikki Krogerus (1):
      usb: typec: ucsi: Fix missing link removal

Hui Liu (1):
      usb: typec: qcom: Update the logic of regulator enable and disable

Javier Carrasco (1):
      usb: misc: onboard_hub: add support for Microchip USB2412 USB 2.0 hub

Krishna Kurapati (1):
      usb: gadget: ncm: Handle decoding of multiple NTB's in unwrap call

Lukas Wunner (2):
      xhci: Clear EHB bit only at end of interrupt handler
      xhci: Preserve RsvdP bits in ERSTBA register correctly

Mario Limonciello (1):
      usb: typec: ucsi: Use GET_CAPABILITY attributes data to set power supply scope

Mathias Nyman (1):
      xhci: track port suspend state correctly in unsuccessful resume cases

Mika Westerberg (4):
      thunderbolt: Workaround an IOMMU fault on certain systems with Intel Maple Ridge
      thunderbolt: Check that lane 1 is in CL0 before enabling lane bonding
      thunderbolt: Correct TMU mode initialization from hardware
      thunderbolt: Restart XDomain discovery handshake after failure

Pawel Laszczak (1):
      usb: cdnsp: Fixes issue with dequeuing not queued requests

Piyush Mehta (1):
      usb: gadget: udc-xilinx: replace memcpy with memcpy_toio

Prashanth K (1):
      usb: typec: ucsi: Clear EVENT_PENDING bit if ucsi_send_command fails

RD Babiera (1):
      usb: typec: altmodes/displayport: Signal hpd low when exiting mode

Ricardo Cañuelo (1):
      usb: hub: Guard against accesses to uninitialized BOS descriptors

Thinh Nguyen (1):
      usb: dwc3: Soft reset phy on probe for host

Wesley Cheng (1):
      usb: xhci: xhci-ring: Use sysdev for mapping bounce buffer

Xiaolei Wang (1):
      usb: cdns3: Modify the return value of cdns_set_active () to void when CONFIG_PM_SLEEP is disabled

Xingxing Luo (2):
      usb: musb: Modify the "HWVers" register address
      usb: musb: Get the musb_qh poniter after musb_giveback

 drivers/thunderbolt/icm.c                          | 40 +++++++--------
 drivers/thunderbolt/switch.c                       |  7 +++
 drivers/thunderbolt/tmu.c                          |  2 +-
 drivers/thunderbolt/xdomain.c                      | 58 +++++++++++++++-------
 drivers/usb/cdns3/cdnsp-gadget.c                   |  3 ++
 drivers/usb/cdns3/core.h                           |  3 +-
 drivers/usb/core/hub.c                             | 25 ++++++++--
 drivers/usb/core/hub.h                             |  2 +-
 drivers/usb/dwc3/core.c                            | 39 ++++++++++++++-
 drivers/usb/gadget/function/f_ncm.c                | 26 +++++++---
 drivers/usb/gadget/udc/udc-xilinx.c                | 20 +++++---
 drivers/usb/host/xhci-hub.c                        | 19 +++----
 drivers/usb/host/xhci-mem.c                        |  4 +-
 drivers/usb/host/xhci-ring.c                       | 16 +++---
 drivers/usb/host/xhci.h                            |  2 +-
 drivers/usb/misc/onboard_usb_hub.c                 |  1 +
 drivers/usb/misc/onboard_usb_hub.h                 |  1 +
 drivers/usb/musb/musb_debugfs.c                    |  2 +-
 drivers/usb/musb/musb_host.c                       |  9 +++-
 drivers/usb/typec/altmodes/displayport.c           |  5 ++
 .../usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c    | 12 ++---
 drivers/usb/typec/ucsi/psy.c                       |  9 ++++
 drivers/usb/typec/ucsi/ucsi.c                      |  2 +
 23 files changed, 220 insertions(+), 87 deletions(-)
