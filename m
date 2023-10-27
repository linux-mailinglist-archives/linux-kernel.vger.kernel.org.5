Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEA57D9A70
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346018AbjJ0Nuw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 27 Oct 2023 09:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345458AbjJ0Nuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:50:50 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221D51AA;
        Fri, 27 Oct 2023 06:50:48 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3b413cc2789so179508b6e.0;
        Fri, 27 Oct 2023 06:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698414647; x=1699019447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TvrgDwXytJvWMSoY+ak1p0VcO5aXnj47/Szk+RjmP7o=;
        b=pVuHcrekVn0rZTDjsZZhqETbQIvDGMitRjF2qmQX22j3ve7JjShZ8TRS4dUSck+bj6
         EM7h8LeZT8fD8A6s0pOHdR2dgIPupkHa+qs+IBP085IPY3s+q+wz9RUjHvm9T2co8eAr
         pOFbxE/tpVqRLVb/o9evmMInxw3OxjRmi2Gawv3BHbXjSEL+T7bpTyMQ3sE8j31SF/UD
         6VFw6394+2VqpApbDDuD/Scq38n+YEX5hy9AJSH2GY39xkgRZqNm0Pb2iHMrKYnvgmM/
         zCDDWgUKdnWdJff8kA6EIrWEIxunQcGiBrS62kSiDVSTHdfErX+YH6xBV3MKwoWLr1rz
         Al7Q==
X-Gm-Message-State: AOJu0Yyp94mS1DqBNGoLqSzuVJbpYe4YDLuoINmQIpDYrWJ1GEm7TusK
        KsMcbvG/eD98gl3ku0aj6alhPqJTu7BrX515uC9gqOOhZoo=
X-Google-Smtp-Source: AGHT+IFLCR1B+THaBavDJmUmrXxnItgpUYlcoSWZ1G4er9GHnljbJ0zsXR4KbfbiPfJiaqsTdg5L7ol8qHDWDR9ZNuU=
X-Received: by 2002:a05:6808:1a02:b0:3ae:100d:5320 with SMTP id
 bk2-20020a0568081a0200b003ae100d5320mr2998703oib.2.1698414647271; Fri, 27 Oct
 2023 06:50:47 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 27 Oct 2023 15:50:36 +0200
Message-ID: <CAJZ5v0jT7CKsUtTY3FN=GKBZkCm5naHVEH43vS+jonTrvy4gCg@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v6.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.7-rc1

with top-most commit f4cb34a75e4a4aee09ff832ea2147cf8322a6a7f

 Merge branches 'acpi-ac', 'acpi-pad' and 'pnp'

on top of commit 611da07b89fdd53f140d7b33013f255bf0ed8f34

 Merge tag 'acpi-6.6-rc8' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive ACPI and PNP updates for 6.7-rc1.

These fix issues, add new quirks, rearrange the IRQ override quirk
definitions, add new helpers and switch over code to using them,
rework a couple of interfaces to be more flexible, eliminate
strncpy() usage from PNP, extend the ACPI PCC mailbox driver and
clean up code.

This is based on ACPI thermal driver changes that are present in the
thermal control updates for 6.7-rc1 pull request (they are depended
on by the ACPI utilities updates).  However, the ACPI thermal driver
changes are not included in the list of specific ACPI changes below.

Specifics:

 - Add symbol definitions related to CDAT to the ACPICA code (Dave
   Jiang).

 - Use the acpi_device_is_present() helper in more places and rename
   acpi_scan_device_not_present() to be about enumeration (James Morse).

 - Add __printf format attribute to acpi_os_vprintf() (Su Hui).

 - Clean up departures from kernel coding style in the low-level
   interface for ACPICA (Jonathan Bergh).

 - Replace strncpy() with strscpy() in acpi_osi_setup() (Justin Stitt).

 - Fail FPDT parsing on zero length records and add proper handling for
   fpdt_process_subtable() to acpi_init_fpdt() (Vasily Khoruzhick).

 - Rework acpi_handle_list handling so as to manage it dynamically,
   including size computation (Rafael Wysocki).

 - Clean up ACPI utilities code so as to make it follow the kernel
   coding style (Jonathan Bergh).

 - Consolidate IRQ trigger-type override DMI tables and drop .ident
   values from dmi_system_id tables used for ACPI resources management
   quirks (Hans de Goede).

 - Add ACPI IRQ override for TongFang GMxXGxx (Werner Sembach).

 - Allow _DSD buffer data only for byte accessors and document the _DSD
   data buffer GUID (Andy Shevchenko).

 - Drop BayTrail and Lynxpoint pinctrl device IDs from the ACPI LPSS
   driver, because it does not need them (Raag Jadav).

 - Add acpi_backlight=vendor quirk for Toshiba Portégé R100 (Ondrej
   Zary).

 - Add "vendor" backlight quirks for 3 Lenovo x86 Android tablets (Hans
   de Goede).

 - Move Xiaomi Mi Pad 2 backlight quirk to its own section (Hans de
   Goede).

 - Annotate struct prm_module_info with __counted_by (Kees Cook).

 - Fix AER info corruption in aer_recover_queue() when error status data
   has multiple sections (Shiju Jose).

 - Make APEI use ERST maximum execution time for slow devices (Jeshua
   Smith).

 - Add support for platform notification handling to the PCC mailbox
   driver and modify it to support shared interrupts for multiple
   subspaces (Huisong Li).

 - Define common macros to use when referring to various bitfields in the
   PCC generic communications channel command and status fields and use
   them in some drivers (Sudeep Holla).

 - Add EC GPE detection quirk for HP 250 G7 Notebook PC (Jonathan
   Denose).

 - Fix and clean up create_pnp_modalias() and create_of_modalias()
   (Christophe JAILLET).

 - Modify 2 pieces of code to use acpi_evaluate_dsm_typed() (Andy
   Shevchenko).

 - Define acpi_dev_uid_match() for matching _UID and use it in several
   places (Raag Jadav).

 - Use acpi_device_uid() for fetching _UID in 2 places (Raag Jadav).

 - Add context argument to acpi_dev_install_notify_handler() (Rafael
   Wysocki).

 - Clarify ACPI bus concepts in the ACPI device enumeration
   documentation (Rafael Wysocki).

 - Switch over the ACPI AC and ACPI PAD drivers to using the platform
   driver interface which, is more logically consistent than binding a
   driver directly to an ACPI device object, and clean them up (Michal
   Wilczynski).

 - Replace strncpy() in the PNP code with either memcpy() or strscpy()
   as appropriate (Justin Stitt).

 - Clean up coding style in pnp.h (GuoHua Cheng).

Thanks!


---------------

Andy Shevchenko (4):
      ACPI: PCI: Switch to use acpi_evaluate_dsm_typed()
      ACPI: x86: s2idle: Switch to use acpi_evaluate_dsm_typed()
      ACPI: property: Allow _DSD buffer data only for byte accessors
      ACPI: property: Document the _DSD data buffer GUID

Christophe JAILLET (2):
      ACPI: sysfs: Fix create_pnp_modalias() and create_of_modalias()
      ACPI: sysfs: Clean up create_pnp_modalias() and create_of_modalias()

Dan Carpenter (1):
      ACPI: thermal: Fix a small leak in acpi_thermal_add()

Dave Jiang (1):
      ACPICA: Add defines for CDAT SSLBIS

GuoHua Cheng (1):
      PNP: Clean up coding style in pnp.h

Hans de Goede (4):
      ACPI: video: Move Xiaomi Mi Pad 2 quirk to its own section
      ACPI: video: Add "vendor" quirks for 3 Lenovo x86 Android tablets
      ACPI: resource: Consolidate IRQ trigger-type override DMI tables
      ACPI: resource: Drop .ident values from dmi_system_id tables

Huisong Li (2):
      mailbox: pcc: Add support for platform notification handling
      mailbox: pcc: Support shared interrupt for multiple subspaces

James Morse (2):
      ACPI: scan: Use the acpi_device_is_present() helper in more places
      ACPI: scan: Rename acpi_scan_device_not_present() to be about enumeration

Jeshua Smith (1):
      ACPI: APEI: Use ERST timeout for slow devices

Jonathan Bergh (5):
      ACPI: OSL: Fix up white space in parameter lists
      ACPI: OSL: Remove redundant parentheses in return statements
      ACPI: OSL: Add empty lines after local variable declarations
      ACPI: utils: Fix up white space in a few places
      ACPI: utils: Remove redundant braces around individual statement

Jonathan Denose (1):
      ACPI: EC: Add quirk for HP 250 G7 Notebook PC

Justin Stitt (3):
      ACPI: OSI: refactor deprecated strncpy()
      PNP: ACPI: replace deprecated strncpy() with strscpy()
      PNP: replace deprecated strncpy() with memcpy()

Kees Cook (1):
      ACPI: PRM: Annotate struct prm_module_info with __counted_by

Michal Wilczynski (7):
      ACPI: AC: Remove redundant checks
      ACPI: AC: Use string_choices API instead of ternary operator
      ACPI: AC: Replace acpi_driver with platform_driver
      ACPI: AC: Rename ACPI device from device to adev
      ACPI: acpi_pad: Replace acpi_driver with platform_driver
      ACPI: acpi_pad: Use dev groups for sysfs
      ACPI: acpi_pad: Rename ACPI device from device to adev

Ondrej Zary (1):
      ACPI: video: Add acpi_backlight=vendor quirk for Toshiba Portégé R100

Raag Jadav (8):
      ACPI: LPSS: drop BayTrail and Lynxpoint pinctrl HIDs
      ACPI: sysfs: use acpi_device_uid() for fetching _UID
      perf: qcom: use acpi_device_uid() for fetching _UID
      ACPI: utils: Introduce acpi_dev_uid_match() for matching _UID
      pinctrl: intel: use acpi_dev_uid_match() for matching _UID
      ACPI: utils: use acpi_dev_uid_match() for matching _UID
      ACPI: x86: use acpi_dev_uid_match() for matching _UID
      perf: arm_cspmu: use acpi_dev_hid_uid_match() for matching _HID and _UID

Rafael J. Wysocki (16):
      ACPI: thermal: Simplify initialization of critical and hot trips
      ACPI: thermal: Fold acpi_thermal_get_info() into its caller
      ACPI: thermal: Determine the number of trip points earlier
      ACPI: thermal: Create and populate trip points table earlier
      ACPI: thermal: Simplify critical and hot trips representation
      ACPI: thermal: Untangle initialization and updates of the passive trip
      ACPI: thermal: Untangle initialization and updates of active trips
      ACPI: thermal: Drop redundant trip point flags
      ACPI: thermal: Drop valid flag from struct acpi_thermal_trip
      ACPI: thermal: Add device list to struct acpi_thermal_trip
      ACPI: thermal: Collapse trip devices update functions
      ACPI: thermal: Collapse trip devices update function wrappers
      ACPI: thermal: Merge trip initialization functions
      ACPI: utils: Dynamically determine acpi_handle_list size
      ACPI: docs: enumeration: Clarify ACPI bus concepts
      ACPI: bus: Add context argument to acpi_dev_install_notify_handler()

Shiju Jose (1):
      ACPI: APEI: Fix AER info corruption when error status data has
multiple sections

Su Hui (1):
      ACPI: OSL: add __printf format attribute to acpi_os_vprintf()

Sudeep Holla (4):
      ACPI: PCC: Add PCC shared memory region command and status bitfields
      i2c: xgene-slimpro: Migrate to use generic PCC shmem related macros
      hwmon: (xgene) Migrate to use generic PCC shmem related macros
      soc: kunpeng_hccs: Migrate to use generic PCC shmem related macros

Vasily Khoruzhick (1):
      ACPI: FPDT: properly handle invalid FPDT subtables

Werner Sembach (1):
      ACPI: resource: Do IRQ override on TongFang GMxXGxx

---------------

 Documentation/firmware-guide/acpi/enumeration.rst |  43 ++
 drivers/acpi/ac.c                                 |  98 ++-
 drivers/acpi/acpi_fpdt.c                          |  45 +-
 drivers/acpi/acpi_lpss.c                          |  21 +-
 drivers/acpi/acpi_pad.c                           |  82 +--
 drivers/acpi/acpi_video.c                         |   2 +-
 drivers/acpi/apei/erst.c                          |  41 +-
 drivers/acpi/apei/ghes.c                          |  23 +-
 drivers/acpi/battery.c                            |   2 +-
 drivers/acpi/bus.c                                |   4 +-
 drivers/acpi/device_sysfs.c                       |  24 +-
 drivers/acpi/ec.c                                 |  10 +
 drivers/acpi/hed.c                                |   2 +-
 drivers/acpi/nfit/core.c                          |   2 +-
 drivers/acpi/osi.c                                |   2 +-
 drivers/acpi/osl.c                                |  28 +-
 drivers/acpi/pci_root.c                           |   6 +-
 drivers/acpi/prmt.c                               |   2 +-
 drivers/acpi/property.c                           |  20 +-
 drivers/acpi/resource.c                           |  94 +--
 drivers/acpi/scan.c                               |  13 +-
 drivers/acpi/thermal.c                            | 712 +++++++++++-----------
 drivers/acpi/utils.c                              | 102 +++-
 drivers/acpi/video_detect.c                       |  84 ++-
 drivers/acpi/x86/s2idle.c                         |   5 +-
 drivers/acpi/x86/utils.c                          |   3 +-
 drivers/hwmon/xgene-hwmon.c                       |  16 +-
 drivers/i2c/busses/i2c-xgene-slimpro.c            |  16 +-
 drivers/mailbox/pcc.c                             |  91 ++-
 drivers/pci/pcie/aer.c                            |  10 +
 drivers/perf/arm_cspmu/arm_cspmu.c                |   8 +-
 drivers/perf/qcom_l3_pmu.c                        |   4 +-
 drivers/pinctrl/intel/pinctrl-intel.c             |   2 +-
 drivers/platform/surface/surface_acpi_notify.c    |  10 +-
 drivers/pnp/pnpacpi/core.c                        |   7 +-
 drivers/pnp/pnpbios/rsparser.c                    |   4 +-
 drivers/soc/hisilicon/kunpeng_hccs.c              |   8 +-
 include/acpi/acpi_bus.h                           |  12 +-
 include/acpi/actbl1.h                             |   3 +
 include/acpi/ghes.h                               |   4 +
 include/acpi/pcc.h                                |  13 +
 include/linux/acpi.h                              |   5 +
 include/linux/pnp.h                               |   8 +-
 43 files changed, 1024 insertions(+), 667 deletions(-)
