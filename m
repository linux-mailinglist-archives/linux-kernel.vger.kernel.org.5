Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5D37E57CF
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 14:09:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344630AbjKHNJ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 08:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbjKHNJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 08:09:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAA0198D;
        Wed,  8 Nov 2023 05:09:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05ABFC433C8;
        Wed,  8 Nov 2023 13:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699448994;
        bh=z8N3D1mOIbdvSmQNPFl82JkSxxX0USW9mYG6Fe/7eXw=;
        h=From:To:Cc:Subject:Date:From;
        b=mvMGauBwaDo1LjaDr/ykBkemQGU1lI8LVEjsySkiVBBe5GcnYv+ZdQJdjNKZ0aitK
         bGCnjFxx5qErp3RcWpvIJ2nEkNylil95EOpcyVUA6wiIK39AHu1f0NdUImZz/it1wh
         twt44T9cNIusDdrJJQ6VtWxtMrseSeMO2swulMsM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.1
Date:   Wed,  8 Nov 2023 14:09:49 +0100
Message-ID: <2023110849-sandy-unlinked-4f41@gregkh>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm announcing the release of the 6.6.1 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Documentation/devicetree/bindings/serial/rs485.yaml |    4 
 Makefile                                            |    2 
 drivers/bluetooth/hci_bcm4377.c                     |    5 
 drivers/gpu/drm/amd/display/dc/dce/dce_dmcu.c       |    3 
 drivers/gpu/drm/amd/display/dc/dce/dmub_psr.c       |    3 
 drivers/misc/pci_endpoint_test.c                    |    4 
 drivers/pci/quirks.c                                |    8 
 drivers/power/supply/power_supply_core.c            |    8 
 drivers/tty/n_gsm.c                                 |    2 
 drivers/tty/serial/8250/8250_pci.c                  |  327 +++++++++++++++++++-
 drivers/tty/serial/serial_core.c                    |    2 
 drivers/usb/gadget/legacy/raw_gadget.c              |   26 -
 drivers/usb/storage/unusual_cypress.h               |    2 
 drivers/usb/typec/tcpm/tcpm.c                       |    5 
 fs/tracefs/event_inode.c                            |  288 ++++++++++-------
 include/linux/pci_ids.h                             |    1 
 include/linux/power_supply.h                        |    2 
 include/linux/trace_events.h                        |    4 
 kernel/trace/trace.c                                |   15 
 kernel/trace/trace.h                                |    3 
 kernel/trace/trace_events.c                         |   31 +
 kernel/trace/trace_events_filter.c                  |    3 
 sound/hda/intel-dsp-config.c                        |    6 
 sound/soc/sof/sof-pci-dev.c                         |    7 
 sound/usb/quirks.c                                  |    2 
 tools/perf/util/evlist.c                            |    5 
 26 files changed, 623 insertions(+), 145 deletions(-)

Andrey Konovalov (1):
      usb: raw-gadget: properly handle interrupted requests

Badhri Jagan Sridharan (1):
      usb: typec: tcpm: Add additional checks for contaminant

Cameron Williams (9):
      tty: 8250: Remove UC-257 and UC-431
      tty: 8250: Add support for additional Brainboxes UC cards
      tty: 8250: Add support for Brainboxes UP cards
      tty: 8250: Add support for Intashield IS-100
      tty: 8250: Fix port count of PX-257
      tty: 8250: Fix up PX-803/PX-857
      tty: 8250: Add support for additional Brainboxes PX cards
      tty: 8250: Add support for Intashield IX cards
      tty: 8250: Add Brainboxes Oxford Semiconductor-based quirks

Daniel Starke (1):
      tty: n_gsm: fix race condition in status line change on dead connections

Francesco Dolcini (1):
      dt-bindings: serial: rs485: Add rs485-rts-active-high

Greg Kroah-Hartman (1):
      Linux 6.6.1

Ian Rogers (1):
      perf evlist: Avoid frequency mode for the dummy event

Janne Grunau (1):
      Bluetooth: hci_bcm4377: Mark bcm4378/bcm4387 as BROKEN_LE_CODED

Jimmy Hu (1):
      usb: typec: tcpm: Fix NULL pointer dereference in tcpm_pd_svdm()

Kai-Heng Feng (1):
      power: supply: core: Use blocking_notifier_call_chain to avoid RCU complaint

LihaSika (1):
      usb: storage: set 1.50 as the lower bcdDevice for older "Super Top" compatibility

Mark Hasemeyer (2):
      ALSA: hda: intel-dsp-config: Fix JSL Chromebook quirk detection
      ASoC: SOF: sof-pci-dev: Fix community key quirk detection

Max McCarthy (1):
      ALSA: usb-audio: add quirk flag to enable native DSD for McIntosh devices

Nicholas Kazlauskas (1):
      drm/amd/display: Don't use fsleep for PSR exit waits

Siddharth Vadapalli (1):
      misc: pci_endpoint_test: Add deviceID for J721S2 PCIe EP device support

Steven Rostedt (Google) (5):
      tracing: Have trace_event_file have ref counters
      eventfs: Remove "is_freed" union with rcu head
      eventfs: Save ownership and mode
      eventfs: Delete eventfs_inode when the last dentry is freed
      eventfs: Use simple_recursive_removal() to clean up dentries

Tony Lindgren (1):
      serial: core: Fix runtime PM handling for pending tx

Vicki Pfau (1):
      PCI: Prevent xHCI driver from claiming AMD VanGogh USB3 DRD device

