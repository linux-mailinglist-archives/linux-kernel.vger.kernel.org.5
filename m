Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4653778EFA5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 16:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244232AbjHaOh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 10:37:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbjHaOh1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 10:37:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096921B2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 07:37:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 871FB617B4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 14:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDBB3C433C7;
        Thu, 31 Aug 2023 14:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693492644;
        bh=t9a6eU9zuY8T4ILSrNaY944MFMHVPUISoSSOmSSA+R0=;
        h=Date:From:To:Cc:Subject:From;
        b=MkJOyqTA0b21Dzl9UqzyDlLX5HiaRIOZWQQo9M/DY1OnfBnoO6uPVmhVo0EvsJxXT
         3mJTYV2ShSP1lLQf7tcD+OHYoy16H/+msYlD9nrd97KD5etDrlu+rwrjcRCmjx5TNq
         +u+++xPqJHu5Oicpo5x7yWfm0zb+dyAiTthhawGUeKVeQyGhijbWfJi7ehS0IxHFNT
         sR99ranR2wBC/GFmUy3Q42/72xz5iEuKwGsoR2ZOqbY4UjH/dC6SBgp28DiszoUS3Q
         bvPiRUqYgTCB9ctzOg30xhg8n/mhrFNsVrmsl4gOYXx8N0M5phqmqeIeC5aANWE4sf
         249H2ol6wkXXA==
Date:   Thu, 31 Aug 2023 16:37:20 +0200
From:   Benjamin Tissoires <bentiss@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID for 6.6
Message-ID: <rbbohtzjjqpbh7w6nmkqqoi2ca5jfl62sxtjyv5go5dock32yr@vslcd4yadpdg>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2023083101

to receive HID subsystem updates for 6.6.

=====
- devm fixes that were now sending use after free in linux-next
  (Rahul Rameshbabu)
- Some extensive HID docs (Marco Morandini)
- Constification of struct class (Ivan Orlov and Greg Kroah-Hartman)
- Google Stadia Force Feedback support (Fabio Baltieri)
- Various fixes and new device ID support
=====

Thanks.

----------------------------------------------------------------
Aaron Armstrong Skomra (3):
      HID: wacom: remove the battery when the EKR is off
      HID: wacom: remove unnecessary 'connected' variable from EKR
      HID: wacom: struct name cleanup

Andy Shevchenko (12):
      lib/string_choices: Add str_write_read() helper
      HID: cp2112: Use str_write_read() and str_read_write()
      HID: cp2112: Make irq_chip immutable
      HID: cp2112: Switch to for_each_set_bit() to simplify the code
      HID: cp2112: Don't call ->to_irq() explicitly
      HID: cp2112: Remove dead code
      HID: cp2112: Define maximum GPIO constant and use it
      HID: cp2112: Define all GPIO mask and use it
      HID: cp2112: Use BIT() in GPIO setter and getter
      HID: cp2112: Use sysfs_emit() to instead of scnprintf()
      HID: cp2112: Convert to DEVICE_ATTR_RW()
      HID: cp2112: Use octal permissions

Bastien Nocera (2):
      HID: logitech-hidpp: Rename HID++ "internal" error constant
      HID: steelseries: Add support for Arctis 1 XBox

Benjamin Tissoires (14):
      HID: logitech-hidpp: rework one more time the retries attempts

Christophe JAILLET (1):
      HID: Reorder fields in 'struct hid_input'

Cong Yang (2):
      dt-bindings: input: i2c-hid: Introduce Ilitek ili9882t
      HID: i2c-hid: elan: Add ili9882t timing

Daniel Thompson (1):
      HID: sensor-hub: Allow multi-function sensor devices

David Rheinsberg (1):
      MAINTAINERS: update my email address

Fabio Baltieri (1):
      HID: hid-google-stadiaff: add support for Stadia force feedback

Greg Kroah-Hartman (1):
      HID: hidraw: make hidraw_class structure const

Illia Ostapyshyn (1):
      HID: input: Support devices sending Eraser without Invert

Ivan Orlov (1):
      HID: roccat: make all 'class' structures const

Jiri Kosina (1):
      HID: steelseries: arctis_1_battery_request[] should be static

Marco Morandini (1):
      HID: Add introduction about HID for non-kernel programmers

Mavroudis Chatzilazaridis (2):
      HID: logitech-hidpp: Add support for the Pro X Superlight
      HID: logitech-dj: Add support for a new lightspeed receiver iteration

Maxim Mikityanskiy (1):
      HID: logitech-hidpp: Add support for Logitech MX Anywhere 3 mouse

Nikita Zhandarovich (1):
      HID: logitech-dj: Fix error handling in logi_dj_recv_switch_to_dj_mode()

Nils Tonnaett (1):
      HID: apple: Add "Hailuck" to the list of non-apple keyboards

Nimish Gåtam (1):
      HID: input: Fix Apple Magic Trackpad 1 Bluetooth disconnect

Osama Muhammad (1):
      HID: hid-wiimote-debug.c: Drop error checking for debugfs_create_file

Rahul Rameshbabu (6):
      HID: nvidia-shield: Remove led_classdev_unregister in thunderstrike_create
      HID: nvidia-shield: Add battery support for Thunderstrike
      HID: nvidia-shield: Update Thunderstrike LED instance name to use id
      HID: uclogic: Correct devm device reference for hidinput input_dev name
      HID: multitouch: Correct devm device reference for hidinput input_dev name
      HID: nvidia-shield: Reference hid_device devm allocation of input_dev name

 .mailmap                                                     |   3 +
 Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml |  67 +++++++++++
 Documentation/hid/hidintro.rst                               | 524 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 Documentation/hid/hidreport-parsing.rst                      |  49 ++++++++
 Documentation/hid/index.rst                                  |   1 +
 MAINTAINERS                                                  |   4 +-
 drivers/hid/Kconfig                                          |  13 ++-
 drivers/hid/Makefile                                         |   1 +
 drivers/hid/hid-apple.c                                      |   3 +-
 drivers/hid/hid-cp2112.c                                     | 169 ++++++++++------------------
 drivers/hid/hid-google-stadiaff.c                            | 158 ++++++++++++++++++++++++++
 drivers/hid/hid-ids.h                                        |   2 +
 drivers/hid/hid-input.c                                      |  21 +++-
 drivers/hid/hid-logitech-dj.c                                |  16 ++-
 drivers/hid/hid-logitech-hidpp.c                             | 121 +++++++++++++-------
 drivers/hid/hid-multitouch.c                                 |  13 +--
 drivers/hid/hid-nvidia-shield.c                              | 428 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 drivers/hid/hid-roccat-arvo.c                                |  20 ++--
 drivers/hid/hid-roccat-isku.c                                |  21 ++--
 drivers/hid/hid-roccat-kone.c                                |  24 ++--
 drivers/hid/hid-roccat-koneplus.c                            |  22 ++--
 drivers/hid/hid-roccat-konepure.c                            |  22 ++--
 drivers/hid/hid-roccat-kovaplus.c                            |  22 ++--
 drivers/hid/hid-roccat-pyra.c                                |  22 ++--
 drivers/hid/hid-roccat-ryos.c                                |  20 ++--
 drivers/hid/hid-roccat-savu.c                                |  20 ++--
 drivers/hid/hid-roccat.c                                     |   2 +-
 drivers/hid/hid-sensor-hub.c                                 |   2 +-
 drivers/hid/hid-steelseries.c                                | 311 +++++++++++++++++++++++++++++++++++++++++++++++---
 drivers/hid/hid-uclogic-core.c                               |  13 +--
 drivers/hid/hid-wiimote-debug.c                              |  10 --
 drivers/hid/hidraw.c                                         |  18 +--
 drivers/hid/i2c-hid/i2c-hid-of-elan.c                        |  50 +++++++--
 drivers/hid/wacom.h                                          |   1 +
 drivers/hid/wacom_sys.c                                      |  44 +++++---
 drivers/hid/wacom_wac.c                                      |   7 +-
 drivers/hid/wacom_wac.h                                      |   4 +-
 include/linux/hid-roccat.h                                   |   2 +-
 include/linux/hid.h                                          |  26 ++++-
 include/linux/string_choices.h                               |   1 +
 40 files changed, 1916 insertions(+), 361 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/ilitek,ili9882t.yaml
 create mode 100644 Documentation/hid/hidintro.rst
 create mode 100644 Documentation/hid/hidreport-parsing.rst
 create mode 100644 drivers/hid/hid-google-stadiaff.c

