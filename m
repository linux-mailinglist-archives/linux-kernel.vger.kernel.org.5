Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E97C17D9A63
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346000AbjJ0Nss convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 27 Oct 2023 09:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345998AbjJ0Nso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:48:44 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9241192;
        Fri, 27 Oct 2023 06:48:41 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5845b7ee438so205127eaf.1;
        Fri, 27 Oct 2023 06:48:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698414521; x=1699019321;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bF44YxUtW4lmqUctT+CDGMhohfbJWK5fZeTVXTsAqg8=;
        b=NHXpv1ApT795ILosStPS5Y5s4qFdKZhqygrnEdejJHzmHFGNN+iaCAVAZsDy7WtKOo
         dAOmzNdZyOPLbnj5cTlIutLgztmfOz+SYz48Nn+cSGHSUPva9oXn2nvuGBeqxbtIowtG
         HDuaEBmqTcUwdjGJ11sqL8zMKFF/S3v+Ua/gAbBazfFzRJ/nOUD5ve2E85uCBbbMm/Cp
         /Ygp13WAfBxZYAE6HIKcolVmna6OMeCTDDFFQ7yNDOl5G3wdHXjUwXIi9R4pzI+IiBm6
         EQ4HmFn6pUophVmw2LGD1lJG/Kif/n1Kdut5bmoQvK8Xy9ZSfkwnB/Scw3Spp+7fRugz
         BSag==
X-Gm-Message-State: AOJu0YxRvYXqi8XEtsrUC3UU9YEgeEN+qFdvfTBHnXRvaWLAbhn+jpSH
        NwH353iuHurvVtDqTPbMBp4X3VUQHnZODsT2dONhFEVc4lU=
X-Google-Smtp-Source: AGHT+IF4fLW6P8CFCvsusMLRHo8Ae9AsJPno52dLE+/KaJ/K2/P4JI0GzaJ2lovIhiWhOztkpRhfi0GJ+kgcBGgjq10=
X-Received: by 2002:a4a:d8d1:0:b0:586:abc4:2c18 with SMTP id
 c17-20020a4ad8d1000000b00586abc42c18mr2837774oov.0.1698414520749; Fri, 27 Oct
 2023 06:48:40 -0700 (PDT)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 27 Oct 2023 15:48:29 +0200
Message-ID: <CAJZ5v0gxSDM_0DTzyKHtNXyf06hGJK4fU-ByRqoUh89M=OM-Yg@mail.gmail.com>
Subject: [GIT PULL] Thermal control updates for v6.7-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.7-rc1

with top-most commit 607218deac6e29c52f4ce521ed467a0d75090a0d

 Merge tag 'thermal-v6.7-rc1' of
ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux

on top of commit 6465e260f48790807eef06b583b38ca9789b6072

 Linux 6.6-rc3

to receive thermal control updates for 6.7-rc1.

These further rework the ACPI thermal driver, after the changes made to
it in the previous cycle, to make it easier to grasp, get rid of
redundant pieces of internal data structures and eliminate its reliance
on a specific ordering of trip point objects in the thermal core, make
thermal core adjustments needed for the ACPI thermal driver rework,
modify the thermal governor interface so as to use trip pointers for
representing trip points in it, switch over multiple thermal drivers to
using void platform driver remove callbacks, add support for 2 hardware
features to the Intel int340x thermal driver, add support for new
hardware on ARM platforms, update documentation, fix problems, clean up
code and update the MAINTAINERS record for thermal control.

Specifics:

 - Untangle the initialization and updates of passive and active trip
   points in the ACPI thermal driver (Rafael Wysocki).

 - Reduce code duplication related to the initialization and updates
   of trip points in the ACPI thermal driver (Rafael Wysocki).

 - Use trip pointers for cooling device binding in the ACPI thermal
   driver (Rafael Wysocki).

 - Simplify critical and hot trips representation in the ACPI thermal
   driver (Rafael Wysocki).

 - Use trip pointers in thermal governors and in the related part of
   the thermal core (Rafael Wysocki).

 - Drop the trips_disabled bitmask that has become redundant from the
   thermal core (Rafael Wysocki).

 - Avoid updating trip points when the thermal zone temperature falls
   into a trip point's hysteresis range (ícolas F. R. A. Prado).

 - Add power floor notifications support to the int340x thermal control
   driver (Srinivas Pandruvada).

 - Rework updating trip points in the int340x thermal driver so that it
   does not access thermal zone internals directly (Rafael Wysocki).

 - Use param_get_byte() instead of param_get_int() as the max_idle module
   parameter .get() callback in the Intel powerclamp thermal driver to
   avoid possible out-of-bounds access (David Arcari).

 - Add workload hints support to the int340x thermal driver (Srinivas
   Pandruvada).

 - Add support for Mediatek LVTS MT8192 along with suspend/resume
   routines (Balsam Chihi).

 - Fix probe for THERMAL_V2 in the Mediatek LVTS driver (Markus
   Schneider-Pargmann).

 - Remove duplicate error message from the max76620 driver when
   thermal_of_zone_register() fails (Thierry Reding).

 - Add i.MX7D compatible bindings to fix a warning from dtbs_check for
   the imx6ul platform (Alexander Stein).

 - Add sa8775p compatible to the QCom tsens driver (Priyansh Jain).

 - Fix error check in lvts_debugfs_init() to be against PTR_ERR() in the
   LVTS Mediatek driver (Minjie Du).

 - Remove unused variable in thermal/tools (Kuan-Wei Chiu).

 - Document the imx8dl thermal sensor (Fabio Estevam).

 - Add variable names in callback prototypes to prevent warning from
   checkpatch.pl in the imx8mm driver (Bragatheswaran Manickavel).

 - Add missing unevaluatedProperties on child node schemas for tegra124
   (Rob Herring)

 - Add mt7988 support to the Mediatek LVTS driver (Frank Wunderlich).

Thanks!


---------------

Alexander Stein (3):
      dt-bindings: imx-thermal: Add #thermal-sensor-cells property
      dt-bindings: net: microchip: Allow nvmem-cell usage
      dt-bindings: timer: add imx7d compatible

Balsam CHIHI (4):
      dt-bindings: thermal: mediatek: Add LVTS thermal controller
definition for mt8192
      thermal/drivers/mediatek/lvts_thermal: Add suspend and resume
      thermal/drivers/mediatek/lvts_thermal: Add mt8192 support
      thermal/drivers/mediatek/lvts_thermal: Update calibration data
documentation

Bragatheswaran Manickavel (1):
      thermal/drivers/imx8mm_thermal: Fix function pointer declaration
by adding identifier name

Dan Carpenter (2):
      ACPI: thermal: Fix a small leak in acpi_thermal_add()
      thermal: core: prevent potential string overflow

David Arcari (1):
      thermal: intel: powerclamp: fix mismatch in get function for max_idle

Dmitry Baryshkov (1):
      thermal/qcom/tsens: Drop ops_v0_1

Fabio Estevam (1):
      dt-bindings: thermal: fsl,scu-thermal: Document imx8dl

Frank Wunderlich (4):
      dt-bindings: thermal: mediatek: Add mt7988 lvts compatible
      dt-bindings: thermal: mediatek: Add LVTS thermal sensors for mt7988
      thermal/drivers/mediatek/lvts_thermal: Make coeff configurable
      thermal/drivers/mediatek/lvts_thermal: Add mt7988 support

Jonathan Bergh (1):
      ACPI: thermal: Fix up function header formatting in two places

Kuan-Wei Chiu (1):
      tools/thermal: Remove unused 'mds' and 'nrhandler' variables

Lukasz Luba (1):
      thermal: Add myself as thermal reviewer in MAINTAINERS

Markus Schneider-Pargmann (1):
      thermal/drivers/mediatek: Fix probe for THERMAL_V2

Minjie Du (1):
      thermal/drivers/mediatek/lvts_thermal: Fix error check in
lvts_debugfs_init()

Nícolas F. R. A. Prado (1):
      thermal: core: Don't update trip points inside the hysteresis range

Priyansh Jain (1):
      dt-bindings: thermal: tsens: Add sa8775p compatible

Rafael J. Wysocki (38):
      thermal: core: Drop trips_disabled bitmask
      ACPI: thermal: Simplify initialization of critical and hot trips
      ACPI: thermal: Fold acpi_thermal_get_info() into its caller
      ACPI: thermal: Determine the number of trip points earlier
      ACPI: thermal: Create and populate trip points table earlier
      ACPI: thermal: Simplify critical and hot trips representation
      ACPI: thermal: Untangle initialization and updates of the passive trip
      ACPI: thermal: Untangle initialization and updates of active trips
      ACPI: thermal: Drop redundant trip point flags
      ACPI: thermal: Drop valid flag from struct acpi_thermal_trip
      thermal: trip: Drop redundant trips check from for_each_thermal_trip()
      ACPI: thermal: Add device list to struct acpi_thermal_trip
      ACPI: thermal: Collapse trip devices update functions
      ACPI: thermal: Collapse trip devices update function wrappers
      ACPI: thermal: Merge trip initialization functions
      thermal: core: Store trip pointer in struct thermal_instance
      thermal: core: Allow trip pointers to be used for cooling device binding
      ACPI: thermal: Mark uninitialized active trips as invalid
      ACPI: thermal: Do not use trip indices for cooling device binding
      ACPI: thermal: Drop critical_valid and hot_valid trip flags
      ACPI: thermal: Rename structure fields holding temperature in deci-Kelvin
      ACPI: thermal: Drop list of device ACPI handles from struct acpi_thermal
      thermal: core: Add function to walk trips under zone lock
      ACPI: thermal: Move get_active_temp()
      ACPI: thermal: Combine passive and active trip update functions
      thermal: int340x: Use thermal_zone_for_each_trip()
      ACPI: thermal: Use thermal_zone_for_each_trip() for updating trips
      thermal: core: Drop thermal_zone_device_exec()
      thermal: trip: Remove lockdep assertion from for_each_thermal_trip()
      thermal: Remove Amit Kucheria from MAINTAINERS
      thermal: trip: Drop lockdep assertion from thermal_zone_trip_id()
      thermal: trip: Simplify computing trip indices
      thermal: trip: Define for_each_trip() macro
      thermal: gov_fair_share: Rearrange get_trip_level()
      thermal: gov_power_allocator: Use trip pointers instead of trip indices
      thermal: gov_step_wise: Fold update_passive_instance() into its caller
      thermal: core: Pass trip pointer to governor throttle callback
      thermal: ACPI: Include the right header file

Rob Herring (1):
      dt-bindings: thermal: nvidia,tegra124-soctherm: Add missing
unevaluatedProperties on child node schemas

Srinivas Pandruvada (16):
      thermal: int340x: processor_thermal: Move mailbox code to common module
      thermal: int340x: processor_thermal: Add interrupt configuration function
      thermal: int340x: processor_thermal: Use non MSI interrupts by default
      thermal: int340x: Remove PROC_THERMAL_FEATURE_WLT_REQ for Meteor Lake
      thermal: int340x: processor_thermal: Add workload type hint interface
      thermal: int340x: Handle workload hint interrupts
      selftests/thermel/intel: Add test to read workload hint
      thermal: int340x: Add ArrowLake-S PCI ID
      thermal: int340x: processor_thermal: Ack all PCI interrupts
      thermal: int340x: processor_thermal: Move interrupt status MMIO
offset to common header
      thermal: int340x: processor_thermal: Common function to clear
SOC interrupt
      thermal: int340x: processor_thermal: Set feature mask before
proc_thermal_add
      thermal: int340x: processor_thermal: Support power floor notifications
      thermal: int340x: processor_thermal: Handle power floor interrupts
      thermal: int340x: processor_thermal: Enable power floor support
      selftests/thermel/intel: Add test to read power floor status

Thierry Reding (1):
      thermal/drivers/max77620: Remove duplicate error message

Uwe Kleine-König (31):
      thermal: armada: Convert to platform remove callback returning void
      thermal: bcm2835: Convert to platform remove callback returning void
      thermal: ns: Convert to platform remove callback returning void
      thermal: da9062: Convert to platform remove callback returning void
      thermal: dove: Convert to platform remove callback returning void
      thermal: hisi: Convert to platform remove callback returning void
      thermal: imx8mm: Convert to platform remove callback returning void
      thermal: imx: Convert to platform remove callback returning void
      thermal: int3400: Convert to platform remove callback returning void
      thermal: int3401: Convert to platform remove callback returning void
      thermal: int3402: Convert to platform remove callback returning void
      thermal: int3403: Convert to platform remove callback returning void
      thermal: int3406: Convert to platform remove callback returning void
      thermal: k3_bandgap: Convert to platform remove callback returning void
      thermal: k3_j72xx_bandgap: Convert to platform remove callback
returning void
      thermal: kirkwood: Convert to platform remove callback returning void
      thermal: lvts: Convert to platform remove callback returning void
      thermal: tsens: Convert to platform remove callback returning void
      thermal: rcar_gen3: Convert to platform remove callback returning void
      thermal: rcar: Convert to platform remove callback returning void
      thermal: rockchip: Convert to platform remove callback returning void
      thermal: rzg2l: Convert to platform remove callback returning void
      thermal: exynos_tmu: Convert to platform remove callback returning void
      thermal: spear: Convert to platform remove callback returning void
      thermal: sprd: Convert to platform remove callback returning void
      thermal: stm: Convert to platform remove callback returning void
      thermal: soctherm: Convert to platform remove callback returning void
      thermal: tegra-bpmp: Convert to platform remove callback returning void
      thermal: ti-bandgap: Convert to platform remove callback returning void
      thermal: uniphier: Convert to platform remove callback returning void
      thermal: amlogic: Convert to platform remove callback returning void

---------------

 .../devicetree/bindings/net/microchip,lan95xx.yaml |   2 +
 .../bindings/thermal/fsl,scu-thermal.yaml          |   4 +-
 .../devicetree/bindings/thermal/imx-thermal.yaml   |   7 +
 .../bindings/thermal/mediatek,lvts-thermal.yaml    |   1 +
 .../bindings/thermal/nvidia,tegra124-soctherm.yaml |   5 +
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   1 +
 .../devicetree/bindings/thermal/thermal-zones.yaml |   2 +-
 .../devicetree/bindings/timer/fsl,imxgpt.yaml      |   4 +-
 Documentation/driver-api/thermal/intel_dptf.rst    |  64 ++
 MAINTAINERS                                        |   2 +-
 drivers/acpi/thermal.c                             | 841 ++++++++++-----------
 drivers/thermal/amlogic_thermal.c                  |   8 +-
 drivers/thermal/armada_thermal.c                   |   6 +-
 drivers/thermal/broadcom/bcm2835_thermal.c         |   6 +-
 drivers/thermal/broadcom/ns-thermal.c              |   6 +-
 drivers/thermal/da9062-thermal.c                   |   5 +-
 drivers/thermal/dove_thermal.c                     |   6 +-
 drivers/thermal/gov_bang_bang.c                    |  27 +-
 drivers/thermal/gov_fair_share.c                   |  35 +-
 drivers/thermal/gov_power_allocator.c              | 122 ++-
 drivers/thermal/gov_step_wise.c                    |  50 +-
 drivers/thermal/gov_user_space.c                   |   8 +-
 drivers/thermal/hisi_thermal.c                     |   6 +-
 drivers/thermal/imx8mm_thermal.c                   |   8 +-
 drivers/thermal/imx_thermal.c                      |   6 +-
 drivers/thermal/intel/int340x_thermal/Makefile     |   3 +
 .../intel/int340x_thermal/int3400_thermal.c        |   5 +-
 .../intel/int340x_thermal/int3401_thermal.c        |   6 +-
 .../intel/int340x_thermal/int3402_thermal.c        |   6 +-
 .../intel/int340x_thermal/int3403_thermal.c        |   6 +-
 .../intel/int340x_thermal/int3406_thermal.c        |   5 +-
 .../intel/int340x_thermal/int340x_thermal_zone.c   |  78 +-
 .../int340x_thermal/processor_thermal_device.c     |  85 ++-
 .../int340x_thermal/processor_thermal_device.h     |  33 +-
 .../int340x_thermal/processor_thermal_device_pci.c | 121 ++-
 .../processor_thermal_device_pci_legacy.c          |   3 +-
 .../intel/int340x_thermal/processor_thermal_mbox.c | 179 ++---
 .../processor_thermal_power_floor.c                | 126 +++
 .../int340x_thermal/processor_thermal_wt_hint.c    | 255 +++++++
 .../int340x_thermal/processor_thermal_wt_req.c     | 136 ++++
 drivers/thermal/intel/intel_powerclamp.c           |   2 +-
 drivers/thermal/k3_bandgap.c                       |   6 +-
 drivers/thermal/k3_j72xx_bandgap.c                 |   6 +-
 drivers/thermal/kirkwood_thermal.c                 |   6 +-
 drivers/thermal/max77620_thermal.c                 |   8 +-
 drivers/thermal/mediatek/auxadc_thermal.c          |   2 +-
 drivers/thermal/mediatek/lvts_thermal.c            | 256 ++++++-
 drivers/thermal/qcom/tsens-v0_1.c                  |   6 -
 drivers/thermal/qcom/tsens.c                       |   6 +-
 drivers/thermal/rcar_gen3_thermal.c                |   6 +-
 drivers/thermal/rcar_thermal.c                     |   6 +-
 drivers/thermal/rockchip_thermal.c                 |   6 +-
 drivers/thermal/rzg2l_thermal.c                    |   6 +-
 drivers/thermal/samsung/exynos_tmu.c               |   6 +-
 drivers/thermal/spear_thermal.c                    |   6 +-
 drivers/thermal/sprd_thermal.c                     |   5 +-
 drivers/thermal/st/stm_thermal.c                   |   6 +-
 drivers/thermal/tegra/soctherm.c                   |   6 +-
 drivers/thermal/tegra/tegra-bpmp-thermal.c         |   6 +-
 drivers/thermal/thermal_acpi.c                     |   3 +-
 drivers/thermal/thermal_core.c                     | 137 ++--
 drivers/thermal/thermal_core.h                     |   9 +-
 drivers/thermal/thermal_helpers.c                  |   8 +-
 drivers/thermal/thermal_sysfs.c                    |   3 +-
 drivers/thermal/thermal_trip.c                     |  55 +-
 drivers/thermal/ti-soc-thermal/ti-bandgap.c        |   6 +-
 drivers/thermal/uniphier_thermal.c                 |   6 +-
 .../dt-bindings/thermal/mediatek,lvts-thermal.h    |  28 +
 include/linux/thermal.h                            |  20 +-
 tools/testing/selftests/Makefile                   |   2 +
 .../selftests/thermal/intel/power_floor/Makefile   |  12 +
 .../thermal/intel/power_floor/power_floor_test.c   | 108 +++
 .../selftests/thermal/intel/workload_hint/Makefile |  12 +
 .../intel/workload_hint/workload_hint_test.c       | 157 ++++
 tools/thermal/lib/mainloop.c                       |  16 -
 75 files changed, 2170 insertions(+), 1048 deletions(-)
