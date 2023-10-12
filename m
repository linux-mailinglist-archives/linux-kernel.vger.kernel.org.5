Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27CEC7C6415
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 06:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376778AbjJLE2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 00:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjJLE2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 00:28:49 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9750A9;
        Wed, 11 Oct 2023 21:28:47 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9adb9fa7200so105936466b.0;
        Wed, 11 Oct 2023 21:28:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697084926; x=1697689726; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=03gb1vqwxiL5Z9iTAYGZjwocB8IZIyrRtKYufIydfpI=;
        b=eSzy9pEeCtczHt8MheF9/D1PSkGqCfEgEqypJr5aadI6cek8c+7VpSMoVPKiAQuHy5
         PAhpCXszVwZ+UsHlJ0xA5RuwWulKWZNgO95BujL8Yn7xPxmNj7awlSVwMHWUnOQUgPa6
         Xb4oxyLKIfO95bhcelahek6I/ErTVlcQmyEO/hN0+3KLACryOhFIMMMZy/p8tnDICenH
         9Kp6K3fMzEfS7J2IvdGGbl5XbIDC37J8PXPBnncUxffCrIBjFflxEqp/GA5aq1dazlIz
         tNJDQ1SKUm9KryB1XZ+zQZwSzdC3aNeAXXvBFzqutUVZRGt7nOOWIUqEJ56pwgjE8Yyi
         dLKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697084926; x=1697689726;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=03gb1vqwxiL5Z9iTAYGZjwocB8IZIyrRtKYufIydfpI=;
        b=LYIzZ4kn6QxwpAtcLYSpelwipyN3bl/QC/KlFI4wNkMmeM6m7yw2XzjbVjSMG4duNa
         jNRTXGIRwFxKf9imTzo1H4Xp2EWC6ZfFLe1ORnuCNS+Pyn7cstnQSRRsxtwCvzoNxxj1
         0QRV2mBRQ2CfMBxgWEKdv98V5yQSH9wqlMnT2sSByTmZdVYXVhzSbrcNo2cmPga+h4pX
         IDEj7RH65WhaOgTn/DcePNQge6EFKGxLP6N2F04nXD8ymf5kayjNNAeWjTllKbCO30vx
         XKuQ5+XLTJPNqYWIVMBauLySsU5/5xTwdDuXVAD2PSLe1cefdAzESK/kPRjPLzU5TJKK
         0lHg==
X-Gm-Message-State: AOJu0YxRL/e3bEfjDVcQ60RXwWUbWLfLtzTorvpvQihtphC64enBGNxt
        F/AK95VfspRRuGnr6A0USeI=
X-Google-Smtp-Source: AGHT+IFN8xfpMw+qbnj0j0PylQSY2EAm6Y0INtbrN5Zb12/I0fMHJoIBEW+UEmFCc3C8tmIolx6bUw==
X-Received: by 2002:a17:907:808:b0:9b2:cee1:1f82 with SMTP id wv8-20020a170907080800b009b2cee11f82mr16725318ejb.7.1697084925838;
        Wed, 11 Oct 2023 21:28:45 -0700 (PDT)
Received: from felia.fritz.box ([2a02:810d:7e40:14b0:78dc:282:cf18:8032])
        by smtp.gmail.com with ESMTPSA id k16-20020a1709062a5000b0099315454e76sm10491490eje.211.2023.10.11.21.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 21:28:45 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>, Jean Delvare <jdelvare@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] eeprom: remove doc and MAINTAINERS section after driver was removed
Date:   Thu, 12 Oct 2023 06:28:34 +0200
Message-Id: <20231012042834.6663-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 0113a99b8a75 ("eeprom: Remove deprecated legacy eeprom driver")
already removes the eeprom driver's code.

Remove also the eeprom driver's documentation and MAINTAINERS section.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Greg, please pick this patch into your -next char and misc tree on top
of the commit above.

 Documentation/misc-devices/eeprom.rst | 107 --------------------------
 Documentation/misc-devices/index.rst  |   1 -
 MAINTAINERS                           |   6 --
 3 files changed, 114 deletions(-)
 delete mode 100644 Documentation/misc-devices/eeprom.rst

diff --git a/Documentation/misc-devices/eeprom.rst b/Documentation/misc-devices/eeprom.rst
deleted file mode 100644
index 008249675ccc..000000000000
--- a/Documentation/misc-devices/eeprom.rst
+++ /dev/null
@@ -1,107 +0,0 @@
-====================
-Kernel driver eeprom
-====================
-
-Supported chips:
-
-  * Any EEPROM chip in the designated address range
-
-    Prefix: 'eeprom'
-
-    Addresses scanned: I2C 0x50 - 0x57
-
-    Datasheets: Publicly available from:
-
-                Atmel (www.atmel.com),
-                Catalyst (www.catsemi.com),
-                Fairchild (www.fairchildsemi.com),
-                Microchip (www.microchip.com),
-                Philips (www.semiconductor.philips.com),
-                Rohm (www.rohm.com),
-                ST (www.st.com),
-                Xicor (www.xicor.com),
-                and others.
-
-        ========= ============= ============================================
-        Chip      Size (bits)   Address
-        ========= ============= ============================================
-        24C01     1K            0x50 (shadows at 0x51 - 0x57)
-        24C01A    1K            0x50 - 0x57 (Typical device on DIMMs)
-        24C02     2K            0x50 - 0x57
-        24C04     4K            0x50, 0x52, 0x54, 0x56
-                                (additional data at 0x51, 0x53, 0x55, 0x57)
-        24C08     8K            0x50, 0x54 (additional data at 0x51, 0x52,
-                                0x53, 0x55, 0x56, 0x57)
-        24C16     16K           0x50 (additional data at 0x51 - 0x57)
-        Sony      2K            0x57
-
-        Atmel     34C02B  2K    0x50 - 0x57, SW write protect at 0x30-37
-        Catalyst  34FC02  2K    0x50 - 0x57, SW write protect at 0x30-37
-        Catalyst  34RC02  2K    0x50 - 0x57, SW write protect at 0x30-37
-        Fairchild 34W02   2K    0x50 - 0x57, SW write protect at 0x30-37
-        Microchip 24AA52  2K    0x50 - 0x57, SW write protect at 0x30-37
-        ST        M34C02  2K    0x50 - 0x57, SW write protect at 0x30-37
-        ========= ============= ============================================
-
-
-Authors:
-        - Frodo Looijaard <frodol@dds.nl>,
-        - Philip Edelbrock <phil@netroedge.com>,
-        - Jean Delvare <jdelvare@suse.de>,
-        - Greg Kroah-Hartman <greg@kroah.com>,
-        - IBM Corp.
-
-Description
------------
-
-This is a simple EEPROM module meant to enable reading the first 256 bytes
-of an EEPROM (on a SDRAM DIMM for example). However, it will access serial
-EEPROMs on any I2C adapter. The supported devices are generically called
-24Cxx, and are listed above; however the numbering for these
-industry-standard devices may vary by manufacturer.
-
-This module was a programming exercise to get used to the new project
-organization laid out by Frodo, but it should be at least completely
-effective for decoding the contents of EEPROMs on DIMMs.
-
-DIMMS will typically contain a 24C01A or 24C02, or the 34C02 variants.
-The other devices will not be found on a DIMM because they respond to more
-than one address.
-
-DDC Monitors may contain any device. Often a 24C01, which responds to all 8
-addresses, is found.
-
-Recent Sony Vaio laptops have an EEPROM at 0x57. We couldn't get the
-specification, so it is guess work and far from being complete.
-
-The Microchip 24AA52/24LCS52, ST M34C02, and others support an additional
-software write protect register at 0x30 - 0x37 (0x20 less than the memory
-location). The chip responds to "write quick" detection at this address but
-does not respond to byte reads. If this register is present, the lower 128
-bytes of the memory array are not write protected. Any byte data write to
-this address will write protect the memory array permanently, and the
-device will no longer respond at the 0x30-37 address. The eeprom driver
-does not support this register.
-
-Lacking functionality
----------------------
-
-* Full support for larger devices (24C04, 24C08, 24C16). These are not
-  typically found on a PC. These devices will appear as separate devices at
-  multiple addresses.
-
-* Support for really large devices (24C32, 24C64, 24C128, 24C256, 24C512).
-  These devices require two-byte address fields and are not supported.
-
-* Enable Writing. Again, no technical reason why not, but making it easy
-  to change the contents of the EEPROMs (on DIMMs anyway) also makes it easy
-  to disable the DIMMs (potentially preventing the computer from booting)
-  until the values are restored somehow.
-
-Use
----
-
-After inserting the module (and any other required SMBus/i2c modules), you
-should have some EEPROM directories in ``/sys/bus/i2c/devices/*`` of names such
-as "0-0050". Inside each of these is a series of files, the eeprom file
-contains the binary data from EEPROM.
diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devices/index.rst
index ecc40fbbcfb8..7de16797987a 100644
--- a/Documentation/misc-devices/index.rst
+++ b/Documentation/misc-devices/index.rst
@@ -17,7 +17,6 @@ fit into other categories.
    ad525x_dpot
    apds990x
    bh1770glc
-   eeprom
    c2port
    dw-xdata-pcie
    ibmvmc
diff --git a/MAINTAINERS b/MAINTAINERS
index ecdf3ab6f371..706769e04570 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12007,12 +12007,6 @@ F:	drivers/leds/
 F:	include/dt-bindings/leds/
 F:	include/linux/leds.h
 
-LEGACY EEPROM DRIVER
-M:	Jean Delvare <jdelvare@suse.com>
-S:	Maintained
-F:	Documentation/misc-devices/eeprom.rst
-F:	drivers/misc/eeprom/eeprom.c
-
 LEGO MINDSTORMS EV3
 R:	David Lechner <david@lechnology.com>
 S:	Maintained
-- 
2.17.1

