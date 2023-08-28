Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C41278B125
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 14:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbjH1Mzk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 08:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbjH1MzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:55:23 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E505C3;
        Mon, 28 Aug 2023 05:55:19 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-57328758a72so864615eaf.1;
        Mon, 28 Aug 2023 05:55:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693227318; x=1693832118;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=m38t+6ENHSM7sxq7lBG7ajN0dx0/1nAUuWaIrnX+J0s=;
        b=H7IoMFL2SvlnyOgR80St5WGm6iHO/KI7bbo/842+A5Z2O+WFnKaHQ3OtLn5poRxArr
         JKAoyvfTCo05ULqKqll0tYM/vjfg2afiz7Oikr/+xOe44mNVechT2K3Sbwb9A96tuR9k
         FaTfEOQQK9v8UDjD8JZDSs9cg/vzJLOQDLuUTg5KJ/y0OussdQVQQXd9PAmwK1Ww18MG
         teKUJwhn+snX6T7e2i1+UovELqYST83SHZy5D1cPUOrH2b0zpXtCdRUiRTWZPbZksLvB
         I30+qATOaiHW83DFDlrw7Wl30uuGD79Nb7cqxUeuRXMWFkEqPqQVew+X4Vr0phYONodz
         VAXA==
X-Gm-Message-State: AOJu0YwpYiN3GuInM68wBkhpIlyjORzngozHhEa9rvO7BsLziExocXxP
        9C1Fgl1E80PojJved0ktRks5CYzTdBDiXggJJ0SZVdcYjKY=
X-Google-Smtp-Source: AGHT+IEbzDvsKN7NxRk6ArW8L89mABVQymOMbOmA8WutwQKDSp7CMy6s79khs/kh12Ky8UX2gDSuQb4MEy0pJQQfwkI=
X-Received: by 2002:a4a:d137:0:b0:571:1906:47f0 with SMTP id
 n23-20020a4ad137000000b00571190647f0mr13795453oor.1.1693227318607; Mon, 28
 Aug 2023 05:55:18 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 28 Aug 2023 14:55:04 +0200
Message-ID: <CAJZ5v0hsVwQ+F1NN5OfY7HG7tPcbcZi_X2SdgWXfF9ExW6r3hg@mail.gmail.com>
Subject: [GIT PULL] ACPI updates for v6.6-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 acpi-6.6-rc1

with top-most commit b483d3b8a54a544ab8854ca6dbb8d99c423b3ba4

 Merge branch 'pnp'

on top of commit 93f5de5f648d2b1ce3540a4ac71756d4a852dc23

 Merge tag 'acpi-6.5-rc8' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive ACPI updates for 6.6-rc1.

These include new ACPICA material, a rework of the ACPI thermal driver,
a switch-over of the ACPI processor driver to using _OSC instead of
(long deprecated) _PDC for CPU initialization, a rework of firmware
notifications handling in several drivers, fixes and cleanups for
suspend-to-idle handling on AMD systems, ACPI backlight driver
updates and more.

Specifics:

 - Update the ACPICA code in the kernel to upstream revision 20230628
   including the following changes:
   * Suppress a GCC 12 dangling-pointer warning (Philip Prindeville).
   * Reformat the ACPI_STATE_COMMON macro and its users (George Guo).
   * Replace the ternary operator with ACPI_MIN() (Jiangshan Yi).
   * Add support for _DSC as per ACPI 6.5 (Saket Dumbre).
   * Remove a duplicate macro from zephyr header (Najumon B.A).
   * Add data structures for GED and _EVT tracking (Jose Marinho).
   * Fix misspelled CDAT DSMAS define (Dave Jiang).
   * Simplify an error message in acpi_ds_result_push() (Christophe
     Jaillet).
   * Add a struct size macro related to SRAT (Dave Jiang).
   * Add AML_NO_OPERAND_RESOLVE flag to Timer (Abhishek Mainkar).
   * Add support for RISC-V external interrupt controllers in MADT (Sunil
     V L).
   * Add RHCT flags, CMO and MMU nodes (Sunil V L).
   * Change ACPICA version to 20230628 (Bob Moore).

 - Introduce new wrappers for ACPICA notify handler install/remove and
   convert multiple drivers to using their own Notify() handlers instead
   of the ACPI bus type .notify() slated for removal (Michal Wilczynski).

 - Add backlight=native DMI quirk for Apple iMac12,1 and iMac12,2 (Hans
   de Goede).

 - Put ACPI video and its child devices explicitly into D0 on boot to
   avoid platform firmware confusion (Kai-Heng Feng).

 - Add backlight=native DMI quirk for Lenovo Ideapad Z470 (Jiri Slaby).

 - Support obtaining physical CPU ID from MADT on LoongArch (Bibo Mao).

 - Convert ACPI CPU initialization to using _OSC instead of _PDC that
   has been deprecated since 2018 and dropped from the specification in
   ACPI 6.5 (Michal Wilczynski, Rafael Wysocki).

 - Drop non-functional nocrt parameter from ACPI thermal (Mario
   Limonciello).

 - Clean up the ACPI thermal driver, rework the handling of firmware
   notifications in it and make it provide a table of generic trip point
   structures to the core during initialization (Rafael Wysocki).

 - Defer enumeration of devices with _DEP pointing to IVSC (Wentong Wu).

 - Install SystemCMOS address space handler for ACPI000E (TAD) to meet
   platform firmware expectations on some platforms (Zhang Rui).

 - Fix finding the generic error data in the ACPi extlog driver for
   compatibility with old and new firmware interface versions (Xiaochun
   Lee).

 - Remove assorted unused declarations of functions (Yue Haibing).

 - Move AMBA bus scan handling into arm64 specific directory (Sudeep
   Holla).

 - Fix and clean up suspend-to-idle interface for AMD systems (Mario
   Limonciello, Andy Shevchenko).

 - Fix string truncation warning in pnpacpi_add_device() (Sunil V L).

Thanks!


---------------

Abhishek Mainkar (1):
      ACPICA: Add AML_NO_OPERAND_RESOLVE flag to Timer

Andy Shevchenko (1):
      ACPI: x86: s2idle: Add for_each_lpi_constraint() helper

Bibo Mao (1):
      ACPI: processor: LoongArch: Get physical ID from MADT

Bob Moore (1):
      ACPICA: Update version to 20230628

Christophe Jaillet (1):
      ACPICA: Slightly simplify an error message in acpi_ds_result_push()

Dave Jiang (2):
      ACPICA: Fix misspelled CDAT DSMAS define
      ACPICA: Add a define for size of struct
acpi_srat_generic_affinity device_handle

George Guo (1):
      ACPICA: Modify ACPI_STATE_COMMON

Hans de Goede (1):
      ACPI: video: Add backlight=native DMI quirk for Apple iMac12,1
and iMac12,2

Jiangshan Yi (1):
      ACPICA: exserial.c: replace ternary operator with ACPI_MIN()

Jiri Slaby (SUSE) (1):
      ACPI: video: Add backlight=native DMI quirk for Lenovo Ideapad Z470

Jose Marinho (2):
      ACPICA: Detect GED device and keep track of _EVT
      ACPICA: Add interrupt command to acpiexec

Kai-Heng Feng (1):
      ACPI: video: Put ACPI video and its child devices into D0 on boot

Mario Limonciello (7):
      ACPI: thermal: Drop nocrt parameter
      ACPI: Adjust #ifdef for *_lps0_dev use
      ACPI: x86: s2idle: Post-increment variables when getting constraints
      ACPI: x86: s2idle: Catch multiple ACPI_TYPE_PACKAGE objects
      ACPI: x86: s2idle: Fix a logic error parsing AMD constraints table
      ACPI: x86: s2idle: Add more debugging for AMD constraints parsing
      ACPI: x86: s2idle: Add a function to get LPS0 constraint for a device

Michal Wilczynski (18):
      ACPI: processor: Move MWAIT quirk out of acpi_processor.c
      ACPI: processor: Move processor_physically_present() to acpi_processor.c
      ACPI: processor: Refactor arch_acpi_set_pdc_bits()
      ACPI: processor: Rename ACPI_PDC symbols
      ACPI: processor: Clear C_C2C3_FFH and C_C1_FFH in
arch_acpi_set_proc_cap_bits()
      ACPI: processor: Set CAP_SMP_T_SWCOORD in arch_acpi_set_proc_cap_bits()
      ACPI: processor: Introduce acpi_processor_osc()
      ACPI: bus: Introduce wrappers for ACPICA notify handler install/remove
      ACPI: bus: Set driver_data to NULL every time .add() fails
      ACPI: AC: Install Notify() handler directly
      ACPI: video: Install Notify() handler directly
      ACPI: battery: Install Notify() handler directly
      ACPI: HED: Install Notify() handler directly
      ACPI: NFIT: Install Notify() handler directly
      ACPI: NFIT: Remove unnecessary .remove callback
      ACPI: thermal: Install Notify() handler directly
      ACPI: processor: Use _OSC to convey OSPM processor support information
      ACPI: processor: Remove acpi_hwp_native_thermal_lvt_osc()

Najumon B.A (1):
      ACPICA: fix for conflict macro definition on zephyr interface

Philip Prindeville (1):
      ACPICA: Fix GCC 12 dangling-pointer warning

Rafael J. Wysocki (15):
      ACPI: processor: Refine messages in acpi_early_processor_control_setup()
      ACPI: thermal: Drop enabled flag from struct acpi_thermal_active
      ACPI: thermal: Do not attach private data to ACPI handles
      ACPI: thermal: Drop redundant local variable from acpi_thermal_resume()
      thermal: core: Do not handle trip points with invalid temperature
      thermal: core: Introduce thermal_zone_device_exec()
      thermal: core: Add priv pointer to struct thermal_trip
      ACPI: thermal: Clean up acpi_thermal_register_thermal_zone()
      ACPI: thermal: Carry out trip point updates under zone lock
      ACPI: thermal: Introduce struct acpi_thermal_trip
      thermal: core: Rework and rename __for_each_thermal_trip()
      ACPI: thermal: Use trip point table to register thermal zones
      ACPI: thermal: Rework thermal_get_trend()
      ACPI: thermal: Drop unnecessary thermal zone callbacks
      ACPI: thermal: Eliminate code duplication from acpi_thermal_notify()

Saket Dumbre (1):
      ACPICA: Add support for _DSC as per ACPI 6.5

Sudeep Holla (1):
      ACPI: Move AMBA bus scan handling into arm64 specific directory

Sunil V L (3):
      ACPICA: MADT: Add RISC-V external interrupt controllers
      ACPICA: RHCT: Add flags, CMO and MMU nodes
      PNP: ACPI: Fix string truncation warning

Wentong Wu (1):
      ACPI: scan: Defer enumeration of devices with a _DEP pointing to
IVSC device

Xiaochun Lee (1):
      ACPI: extlog: Fix finding the generic error data for v3 structure

Yue Haibing (1):
      ACPI: Remove assorted unused declarations of functions

YueHaibing (1):
      ACPI: Remove unused extern declaration acpi_paddr_to_node()

Zhang Rui (1):
      ACPI: TAD: Install SystemCMOS address space handler for ACPI000E

---------------

 Documentation/admin-guide/kernel-parameters.txt |   4 -
 arch/ia64/include/asm/acpi.h                    |   6 +-
 arch/x86/include/asm/acpi.h                     |  24 +-
 arch/x86/xen/enlighten_pv.c                     |   8 +-
 drivers/acpi/Makefile                           |   1 -
 drivers/acpi/ac.c                               |  27 +-
 drivers/acpi/acpi_cmos_rtc.c                    |  25 +-
 drivers/acpi/acpi_extlog.c                      |   2 +-
 drivers/acpi/acpi_processor.c                   | 124 +++++--
 drivers/acpi/acpi_tad.c                         |  27 +-
 drivers/acpi/acpi_video.c                       |  26 +-
 drivers/acpi/acpica/acdebug.h                   |   2 +
 drivers/acpi/acpica/acglobal.h                  |   1 +
 drivers/acpi/acpica/aclocal.h                   |  38 +-
 drivers/acpi/acpica/acpredef.h                  |   3 +
 drivers/acpi/acpica/dbcmds.c                    |  58 +++
 drivers/acpi/acpica/dbinput.c                   |   8 +
 drivers/acpi/acpica/dswstate.c                  |   4 +-
 drivers/acpi/acpica/exserial.c                  |   3 +-
 drivers/acpi/acpica/psopcode.c                  |   2 +-
 drivers/acpi/acpica/utdebug.c                   |   5 +
 drivers/acpi/arm64/Makefile                     |   1 +
 drivers/acpi/{acpi_amba.c => arm64/amba.c}      |   2 +-
 drivers/acpi/arm64/init.c                       |   2 +
 drivers/acpi/arm64/init.h                       |   1 +
 drivers/acpi/battery.c                          |  24 +-
 drivers/acpi/bus.c                              |  33 +-
 drivers/acpi/hed.c                              |  15 +-
 drivers/acpi/internal.h                         |  16 +-
 drivers/acpi/nfit/core.c                        |  42 ++-
 drivers/acpi/processor_core.c                   |  29 ++
 drivers/acpi/processor_pdc.c                    |  97 +----
 drivers/acpi/scan.c                             |   4 +-
 drivers/acpi/thermal.c                          | 470 +++++++++++-------------
 drivers/acpi/video_detect.c                     |  27 ++
 drivers/acpi/x86/s2idle.c                       |  99 +++--
 drivers/acpi/x86/utils.c                        |  35 ++
 drivers/pnp/pnpacpi/core.c                      |   3 +
 drivers/thermal/thermal_core.c                  |  22 +-
 drivers/thermal/thermal_core.h                  |   4 -
 drivers/thermal/thermal_trip.c                  |  18 +-
 include/acpi/acnames.h                          |   1 +
 include/acpi/acpi_bus.h                         |  17 +-
 include/acpi/acpixf.h                           |   4 +-
 include/acpi/actbl1.h                           |   2 +-
 include/acpi/actbl2.h                           |  76 +++-
 include/acpi/actbl3.h                           |   4 +-
 include/acpi/pdc_intel.h                        |  36 --
 include/acpi/platform/aclinux.h                 |   1 +
 include/acpi/platform/aczephyr.h                |   3 -
 include/acpi/proc_cap_intel.h                   |  40 ++
 include/linux/acpi.h                            |  12 +-
 include/linux/thermal.h                         |   9 +
 53 files changed, 967 insertions(+), 580 deletions(-)
