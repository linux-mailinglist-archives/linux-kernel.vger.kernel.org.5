Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FAE77BAB92
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 22:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjJEUlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 16:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjJEUlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 16:41:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65947CE
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 13:41:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F11ABC433C7;
        Thu,  5 Oct 2023 20:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696538474;
        bh=MnS+p9PEGXTOLqMVCq4ByQXZqnFJrFlGZLFJnYm1/Y4=;
        h=Date:From:To:cc:Subject:From;
        b=mlai1npoHTUZBCK+NQzwLvLbXOVk6TBGK0GwkxerFmioHKX+fhWwBWhPu0P15MPAr
         76n3GhFB4NF6NkYfAc8Vct1cT/8n+IgyH3jKWaidRKltYSYQT1UDVv83AtVR2Yucvd
         Gh48zLU79ISbn/JJcAd+uwUJ3BpMejM8SU7hF/AROemOoCLCnzArfca931Xv7fgrAZ
         bsSrHomM6Legz3VJKhHKNqpN7nTpqlk2L47Jzng46/gL1Ygw2AHn0gcGWI68DMXWhI
         RoMA3vHqSRMBciCH/IhWSrvnBLQVmO8LpsV5Rudtgm+fKrUuZkB2+QKc158PK84wPz
         vbnS47GuaHitw==
Date:   Thu, 5 Oct 2023 22:41:10 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.2310052240320.3534@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023100502

to get HID subsystem fixes for 6.6.

=====
- power management fix for intel-ish-hid (Srinivas Pandruvada)
- power management fix for hid-nintendo (Martino Fontana)
- error handling fixes for nvidia-shield (Christophe JAILLET)
- memory leak fix for hid-sony (Christophe JAILLET)
- fix for slab out-of-bound write in hid-holtek (Ma Ke)
- other assorted smaller fixes and device ID / quirk entry additions
=====

Thanks.

----------------------------------------------------------------
Christophe JAILLET (3):
      HID: sony: Fix a potential memory leak in sony_probe()
      HID: nvidia-shield: Fix a missing led_classdev_unregister() in the probe error handling path
      HID: nvidia-shield: Fix some missing function calls() in the probe error handling path

Dan Carpenter (1):
      HID: steelseries: Fix signedness bug in steelseries_headset_arctis_1_fetch_battery()

Fabian Vogt (1):
      HID: Add quirk to ignore the touchscreen battery on HP ENVY 15-eu0556ng

Hans de Goede (1):
      HID: logitech-hidpp: Add Bluetooth ID for the Logitech M720 Triathlon mouse

Jiri Kosina (1):
      HID: sony: remove duplicate NULL check before calling usb_free_urb()

Ma Ke (1):
      HID: holtek: fix slab-out-of-bounds Write in holtek_kbd_input_event

Martino Fontana (1):
      HID: nintendo: reinitialize USB Pro Controller after resuming from suspend

Rahul Rameshbabu (2):
      HID: nvidia-shield: Select POWER_SUPPLY Kconfig option
      HID: multitouch: Add required quirk for Synaptics 0xcd7e device

Randy Dunlap (1):
      HID: nvidia-shield: add LEDS_CLASS dependency

Srinivas Pandruvada (1):
      HID: intel-ish-hid: ipc: Disable and reenable ACPI GPE bit

 drivers/hid/Kconfig                     |   2 +
 drivers/hid/hid-holtek-kbd.c            |   4 +
 drivers/hid/hid-ids.h                   |   1 +
 drivers/hid/hid-input.c                 |   2 +
 drivers/hid/hid-logitech-hidpp.c        |   2 +
 drivers/hid/hid-multitouch.c            |   4 +
 drivers/hid/hid-nintendo.c              | 175 +++++++++++++++++++-------------
 drivers/hid/hid-nvidia-shield.c         |   9 +-
 drivers/hid/hid-sony.c                  |   2 +
 drivers/hid/hid-steelseries.c           |   2 +-
 drivers/hid/intel-ish-hid/ipc/pci-ish.c |   8 ++
 11 files changed, 135 insertions(+), 76 deletions(-)

-- 
Jiri Kosina
SUSE Labs
