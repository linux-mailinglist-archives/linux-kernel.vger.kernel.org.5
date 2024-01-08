Return-Path: <linux-kernel+bounces-19730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8467A82720B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:02:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EEC70B2254E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 15:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C3C4777C;
	Mon,  8 Jan 2024 15:01:53 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E0C47780;
	Mon,  8 Jan 2024 15:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6dbca8c6eeeso351800a34.1;
        Mon, 08 Jan 2024 07:01:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704726110; x=1705330910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XXoRiuBlSY4HT/TXlsTUnYQUiZhUA5LY91S49BqyVFg=;
        b=LHNjieGtQQmjIR/z+IzjKCbjOqeqWnNUyVRAuFuXDCM1+JnGyxwbQsANHte8CinLyI
         qJ7lYWb0UlBVOrbfidYPZ1EYpoDo/fM4ZxmYRoCUP6eLs7/cO6LBo96fxwxKcjepovaE
         pF35X5PMyaRYmL5WVMnr7FXI5oJY+IqLt3iYqVeNA3Ykqvzn+3FbyuudUD4rjryFk71F
         p9lLGhlPafFwRGCPuNFXOKIxkVXuIkYZ8EpmdXBV6Anfu12sLQwbR5P0U9ONjd2pgvAm
         ZpEh2dBAH+EW5ETXzX6pVka6exEmAWaFbpUlJQfKX/GzfoAf/7JnHzeh1eyPi/jnGd6g
         Osmw==
X-Gm-Message-State: AOJu0YzP6k0xDeR3lMQ5BlC0Tak/MzZr7Zxk2Mcr8jwUM6QfhVG8w/+R
	uvjIkZAU9Tm+tZIrfnawSIo1tAa/0rcJSD4In76UHRI2sfQ=
X-Google-Smtp-Source: AGHT+IFoyaMEBgIslin+npR1xJ0YMB6WFO5RQKeus7Wgeeb+JYFeE00pIib4tsyVsnQ8sU4K3p5GTUAu8rsO7HDFva0=
X-Received: by 2002:a4a:bb91:0:b0:596:2820:ced with SMTP id
 h17-20020a4abb91000000b0059628200cedmr5309151oop.1.1704726110235; Mon, 08 Jan
 2024 07:01:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 8 Jan 2024 16:01:39 +0100
Message-ID: <CAJZ5v0gNn9e8mA1L-NoCRz7ipDE7J+pe37fc9nX-fn-rqjxDuQ@mail.gmail.com>
Subject: [GIT PULL] Thermal control updates for v6.8-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.8-rc1

with top-most commit 17e8b76491b007698cf63bc10093bc8991e45001

 Merge branch 'thermal-intel'

on top of commit 98b1cc82c4affc16f5598d4fa14b1858671b2263

 Linux 6.7-rc2

to receive thermal control updates for 6.8-rc1.

These add support for the D1/T113s THS controller to the sun8i driver
and a DT-based mechanism for platforms to indicate a preference to
reboot (instead of shutting down) on crossing a critical trip point, fix
issues, make other improvements (in the IPA governor, the Intel HFI
driver, the exynos driver and the thermal netlink interface among other
places) and clean up code.

One long-standing issue addressed here is that trip point crossing
notifications sent to user space might be unreliable due to the
incorrect handling of trip point hysteresis in the thermal core:
multiple notifications might be sent for the same event or there
might be events without any notification at all.

Specifics:

 - Add dynamic thresholds for trip point crossing detection to prevent
   trip point crossing notifications from being sent at incorrect times
   or not at all in some cases (Rafael J. Wysocki).

 - Fix synchronization issues related to the resume of thermal zones
   during a system-wide resume and allow thermal zones to be resumed
   concurrently (Rafael J. Wysocki).

 - Modify the thermal zone unregistration to wait for the given zone to
   go away completely before returning to the caller and rework the
   sysfs interface for trip points on top of that (Rafael J. Wysocki).

 - Fix a possible NULL pointer dereference in thermal zone registration
   error path (Rafael J. Wysocki).

 - Clean up the IPA thermal governor and modify it (with the help of a
   new governor callback) to avoid allocating and freeing memory every
   time its throttling callback is invoked (Lukasz Luba).

 - Make the IPA thermal governor handle thermal instance weight changes
   via sysfs correctly (Lukasz Luba).

 - Update the thermal netlink code to avoid sending messages if there
   are no recipients (Stanislaw Gruszka).

 - Convert Mediatek Thermal to the json-schema (Rafa=C5=82 Mi=C5=82ecki).

 - Fix thermal DT bindings issue on Loongson (Binbin Zhou).

 - Fix returning NULL instead of -ENODEV during thermal probe on
   Loogsoon (Binbin Zhou).

 - Add thermal DT binding for tsens on the SM8650 platform (Neil
   Armstrong).

 - Add reboot on the critical trip point crossing option feature (Fabio
   Estevam).

 - Use DEFINE_SIMPLE_DEV_PM_OPS do define PM functions for thermal
   suspend/resume on AmLogic (Uwe Kleine-K=C3=B6nig)

 - Add D1/T113s THS controller support to the Sun8i thermal control
   driver (Maxim Kiselev)

 - Fix example in the thermal DT binding for QCom SPMI (Johan Hovold).

 - Fix compilation warning in the tmon utility (Florian Eckert).

 - Add support for interrupt-based thermal configuration on Exynos along
   with a set of related cleanups (Mateusz Majewski).

 - Make the Intel HFI thermal driver enable an HFI instance (eg. processor
   package) from its first online CPU and disable it when the last CPU in
   it goes offline (Ricardo Neri).

 - Fix a kernel-doc warning and a spello in the cpuidle_cooling thermal
   driver (Randy Dunlap).

 - Move the .get_temp() thermal zone callback presence check to the
   thermal zone registration code (Daniel Lezcano).

 - Use the for_each_trip() macro for trip points table walks in a few
   places in the thermal core (Rafael J. Wysocki).

 - Make all trip point updates (via sysfs as well as from the platform
   firmware) trigger trip change notifications (Rafael J. Wysocki).

 - Drop redundant code from the thermal core and make one function in
   it take a const pointer argument (Rafael J. Wysocki).

Thanks!


---------------

Binbin Zhou (2):
      dt-bindings: thermal: loongson,ls2k-thermal: Fix binding check issues
      drivers/thermal/loongson2_thermal: Fix incorrect PTR_ERR() judgment

Daniel Lezcano (1):
      thermal/core: Check get_temp ops is present when registering a tz

Fabio Estevam (4):
      dt-bindings: thermal-zones: Document critical-action
      thermal/core: Prepare for introduction of thermal reboot
      reboot: Introduce thermal_zone_device_critical_reboot()
      thermal/thermal_of: Allow rebooting after critical temp

Florian Eckert (1):
      tools/thermal/tmon: Fix compilation warning for wrong format

Johan Hovold (2):
      dt-bindings: thermal: qcom-spmi-adc-tm5/hc: Fix example node names
      dt-bindings: thermal: qcom-spmi-adc-tm5/hc: Clean up examples

Lukasz Luba (16):
      thermal: gov_power_allocator: Rename trip_max_desired_temperature
      thermal: gov_power_allocator: Set up trip points earlier
      thermal: gov_power_allocator: Check the cooling devices only for trip=
_max
      thermal: gov_power_allocator: Rearrange local variables
      thermal: gov_power_allocator: Use shorter paths to access data
when possible
      thermal: gov_power_allocator: Remove excessive local variables
      thermal: gov_power_allocator: Rearrange initialization of local varia=
bles
      thermal: core: Add governor callback for thermal zone change
      thermal: gov_power_allocator: Refactor check_power_actors()
      thermal: gov_power_allocator: Refactor checks in divvy_up_power()
      thermal: gov_power_allocator: Change trace functions
      thermal: gov_power_allocator: Move memory allocation out of throttle(=
)
      thermal: gov_power_allocator: Simplify checks for valid power actor
      thermal/sysfs: Update instance->weight under tz lock
      thermal/sysfs: Update governors when the 'weight' has changed
      thermal: gov_power_allocator: Support new update callback of weights

Mateusz Majewski (9):
      thermal/drivers/exynos: Remove an unnecessary field description
      thermal/drivers/exynos: Drop id field
      thermal/drivers/exynos: Wwitch from workqueue-driven interrupt
handling to threaded interrupts
      thermal/drivers/exynos: Handle devm_regulator_get_optional
return value correctly
      thermal/drivers/exynos: Simplify regulator (de)initialization
      thermal/drivers/exynos: Stop using the threshold mechanism on Exynos =
4210
      thermal/drivers/exynos: Split initialization of TMU and the thermal z=
one
      thermal/drivers/exynos: Use BIT wherever possible
      thermal/drivers/exynos: Use set_trips ops

Maxim Kiselev (2):
      dt-bindings: thermal: sun8i: Add binding for D1/T113s THS controller
      thermal/drivers/sun8i: Add D1/T113s THS controller support

Neil Armstrong (1):
      dt-bindings: thermal: qcom-tsens: document the SM8650 Temperature Sen=
sor

Rafael J. Wysocki (17):
      thermal: core: Add trip thresholds for trip crossing detection
      thermal: trip: Drop a redundant check from thermal_zone_set_trip()
      thermal: sysfs: Rework the handling of trip point updates
      thermal: sysfs: Rework the reading of trip point attributes
      thermal: core: Make thermal_zone_device_unregister() return
after freeing the zone
      thermal: Drop redundant and confusing device_is_registered() checks
      thermal: core: Rework thermal zone availability check
      thermal: trip: Drop redundant __thermal_zone_get_trip() header
      thermal: trip: Use for_each_trip() in __thermal_zone_set_trips()
      thermal: helpers: Use for_each_trip() in __thermal_zone_get_temp()
      thermal: netlink: Use for_each_trip() in thermal_genl_cmd_tz_get_trip=
()
      thermal: trip: Send trip change notifications on all trip updates
      thermal: core: Fix NULL pointer dereference in zone registration
error path
      thermal: core: Fix thermal zone suspend-resume synchronization
      thermal: core: Initialize poll_queue in thermal_zone_device_init()
      thermal: core: Resume thermal zones asynchronously
      thermal: trip: Constify thermal zone argument of thermal_zone_trip_id=
()

Rafa=C5=82 Mi=C5=82ecki (1):
      dt-bindings: thermal: convert Mediatek Thermal to the json-schema

Randy Dunlap (1):
      thermal: cpuidle_cooling: fix kernel-doc warning and a spello

Ricardo Neri (3):
      thermal: intel: hfi: Refactor enabling code into helper functions
      thermal: intel: hfi: Enable an HFI instance from its first online CPU
      thermal: intel: hfi: Disable an HFI instance when all its CPUs go off=
line

Stanislaw Gruszka (2):
      thermal: netlink: Add enum for mutlicast groups indexes
      thermal: netlink: Add thermal_group_has_listeners() helper

Uwe Kleine-K=C3=B6nig (2):
      thermal: amlogic: Make amlogic_thermal_disable() return void
      thermal: amlogic: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions

---------------

 .../bindings/thermal/allwinner,sun8i-a83t-ths.yaml |   7 +-
 .../bindings/thermal/loongson,ls2k-thermal.yaml    |  10 +-
 .../bindings/thermal/mediatek,thermal.yaml         |  99 ++++
 .../bindings/thermal/mediatek-thermal.txt          |  52 --
 .../bindings/thermal/qcom-spmi-adc-tm-hc.yaml      |   8 +-
 .../bindings/thermal/qcom-spmi-adc-tm5.yaml        |  16 +-
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   1 +
 .../devicetree/bindings/thermal/thermal-zones.yaml |  16 +
 drivers/acpi/thermal.c                             |   7 +-
 drivers/thermal/amlogic_thermal.c                  |  19 +-
 drivers/thermal/cpuidle_cooling.c                  |   4 +-
 drivers/thermal/gov_power_allocator.c              | 364 ++++++++------
 .../intel/int340x_thermal/int340x_thermal_zone.c   |   8 +-
 drivers/thermal/intel/intel_hfi.c                  |  91 +++-
 drivers/thermal/loongson2_thermal.c                |   2 +-
 drivers/thermal/samsung/exynos_tmu.c               | 529 +++++++++++------=
----
 drivers/thermal/sun8i_thermal.c                    |  13 +
 drivers/thermal/thermal_core.c                     | 193 ++++++--
 drivers/thermal/thermal_core.h                     |   9 +-
 drivers/thermal/thermal_helpers.c                  |  17 +-
 drivers/thermal/thermal_hwmon.c                    |   5 +-
 drivers/thermal/thermal_netlink.c                  |  44 +-
 drivers/thermal/thermal_of.c                       |   6 +
 drivers/thermal/thermal_sysfs.c                    | 121 ++---
 drivers/thermal/thermal_trace_ipa.h                |  50 +-
 drivers/thermal/thermal_trip.c                     |  80 ++--
 include/linux/reboot.h                             |  12 +-
 include/linux/thermal.h                            |  19 +-
 kernel/reboot.c                                    |  34 +-
 tools/thermal/tmon/tui.c                           |   2 +-
 30 files changed, 1074 insertions(+), 764 deletions(-)

