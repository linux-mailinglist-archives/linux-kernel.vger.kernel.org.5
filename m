Return-Path: <linux-kernel+bounces-99171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DC887846D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:02:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4344F1F21249
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3344AEC0;
	Mon, 11 Mar 2024 16:01:27 +0000 (UTC)
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499D8481C7;
	Mon, 11 Mar 2024 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710172886; cv=none; b=dar8FgKPKHvvxdTusA+DClLOkUbgr53S1ERZy4QKwCMmkedB9itSq3z+znVZbvn9l9b44fpCHvlS0XJyHHMnX5jFZDvCFVz8VC7imruDPSsRvINapbmcRWJrhTIdbEvDaF/K65ckJp++/iNg/0OLJhrDVfmm+/R6uSyB/EYMJTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710172886; c=relaxed/simple;
	bh=spDxJWO92dYpglndypBxFdVLYfWnGC2H1RBYNFmayJo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=RcX988LwBx4ajR4VD73fu9zzq4w+2jiJnnsEBwEkW3KfBMKZGjfztk/PeQaw8yyZwV+g22RGWMZXTVQMU0y0xJk07af8RX/ZPK3p63FEVo2LyLpnNPoKFmFfCZsN7OH3k0Ejp4xIZeqf+usFH/gtZWqp8s9lAZ5cLXmVk2shzjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-220ce420472so1454776fac.1;
        Mon, 11 Mar 2024 09:01:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710172884; x=1710777684;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WRJDUbmCO2USSChQ6z+l2fPpbRAxlnCr5YaUGmQ1gYg=;
        b=W7Ftv9lwR6FOCjDOV8Q0t4NmitonRUxU+XznV7O4GnNujG1a0SkwXrCKpFVD67XzS6
         eV4GjbrAL9wJ33Kx6eysypAAS6GBTKYNiTcg9f1qB8fdSxwiYUvzKzilMMvY7Fseqa9m
         9vYjoYt++Cs0li1jGyIpcBgcdl36eyIV743MrYQlnxu8OMQwcAncQA8auvMhdTQ1GVBg
         0MWi/W5qSEY4tL/kt8E2DUiJv/fMA8e2DNLeUlYOwUqU6MsuwEkyzhGxgYxwbb1WnXyo
         7C6A9h+YzDT9L2UL4oWJYvNXpdAu+177N+vHS1iWhDRoqwSMad//4LAH6j49+2Zv1iVE
         sYVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTJYMMGcWNMNzoMX8Ztjq0xOxLGeOKP9UOn8UIQB7qi6tSyC4QvqE1sL3thkz/x1vC38sk/a8POcxHTDAk2rPxl8UqRbJJgL8wSa4Gyu1YuGFDSZftRQdrAddih7vUBqLIA0qWRj6UMg==
X-Gm-Message-State: AOJu0Yw2jKvld29PYZPbOLlgWa+yGzOy70zKGQnJ6QIL6AH5XAKLzlAr
	GSoh4Q/tLKlV+ZmTJIzebKz0YN/+Glv0sUUnFHmP4QXSsAAqDObRokNF7GLwzuO8vfl2iGiO3M3
	7NIci5rs6I4qZv+I1/EJ08NM3NP4=
X-Google-Smtp-Source: AGHT+IFNohavfWXuSkU+2HXKlvZAwheN54+g4aqnyDfXAlGylKTxjFn7Bb4h8M1nCkwqlNICMbZYVPhBDPgos4qb4L8=
X-Received: by 2002:a05:6870:168f:b0:221:bdc9:6a1d with SMTP id
 j15-20020a056870168f00b00221bdc96a1dmr6762240oae.2.1710172884346; Mon, 11 Mar
 2024 09:01:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 11 Mar 2024 17:01:13 +0100
Message-ID: <CAJZ5v0i-nMb_TiYUxEQvzuUER_6fAs8Or96EU1isyrAywMPm1w@mail.gmail.com>
Subject: [GIT PULL] Thermal control updates for v6.9-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, 
	ACPI Devel Maling List <linux-acpi@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 thermal-6.9-rc1

with top-most commit dcb497ec993265dfc5fffa60b486c1ad353e9ad5

 Merge branches 'thermal-core' and 'thermal-intel'

on top of commit 841c35169323cd833294798e58b9bf63fa4fa1de

 Linux 6.8-rc4

to receive thermal control updates for 6.9-rc1.

These mostly change the thermal core in a few ways allowing thermal
drivers to be simplified, in particular in their removal and failing
probe handling parts that are notoriously prone to errors, and propagate
the changes to several drivers.

Apart from that, support for a new platform is added (Intel Lunar
Lake-M), some bugs are fixed and some code is cleaned up, as usual.

Specifics:

 - Store zone trips table and zone operations directly in struct
   thermal_zone_device (Rafael Wysocki).

 - Fix up flex array initialization during thermal zone device
   registration (Nathan Chancellor).

 - Rework writable trip points handling in the thermal core and
   several drivers (Rafael Wysocki).

 - Thermal core code cleanups (Dan Carpenter, Flavio Suligoi).

 - Use thermal zone accessor functions in the int340x Intel thermal
   driver (Rafael Wysocki).

 - Add Lunar Lake-M PCI ID to the int340x Intel thermal driver (Srinivas
   Pandruvada).

 - Minor fixes for thermal governors (Rafael Wysocki, Di Shen).

 - Trip point handling fixes for the iwlwifi wireless driver (Rafael
   Wysocki).

 - Code cleanups (Rafael Wysocki, AngeloGioacchino Del Regno).

Thanks!


---------------

AngeloGioacchino Del Regno (1):
      thermal: core: Change governor name to const char pointer

Dan Carpenter (1):
      thermal: core: remove unnecessary check in trip_point_hyst_store()

Di Shen (1):
      thermal: gov_power_allocator: Avoid overwriting PID coefficients
from setup time

Flavio Suligoi (1):
      thermal: core: Remove excess empty line from a comment

Nathan Chancellor (1):
      thermal: core: Move initial num_trips assignment before memcpy()

Rafael J. Wysocki (22):
      thermal: gov_fair_share: Fix dependency on trip points ordering
      thermal: gov_bang_bang: Fix possible cooling device state ping-pong
      iwlwifi: mvm: Drop unused fw_trips_index[] from iwl_mvm_thermal_device
      iwlwifi: mvm: Populate trip table before registering thermal zone
      iwlwifi: mvm: Use for_each_thermal_trip() for walking trip points
      thermal: sysfs: Fix up white space in trip_point_temp_store()
      thermal: core: Store zone trips table in struct thermal_zone_device
      thermal: ACPI: Discard trips table after zone registration
      thermal: intel: Discard trip tables after zone registration
      thermal: core: Store zone ops in struct thermal_zone_device
      thermal: ACPI: Constify acpi_thermal_zone_ops
      thermal: intel: Adjust ops handling during thermal zone registration
      thermal: Get rid of CONFIG_THERMAL_WRITABLE_TRIPS
      thermal: core: Add flags to struct thermal_trip
      thermal: core: Drop the .set_trip_hyst() thermal zone operation
      thermal: intel: Set THERMAL_TRIP_FLAG_RW_TEMP directly
      mlxsw: core_thermal: Set THERMAL_TRIP_FLAG_RW_TEMP directly
      wifi: iwlwifi: mvm: Set THERMAL_TRIP_FLAG_RW_TEMP directly
      thermal: imx: Set THERMAL_TRIP_FLAG_RW_TEMP directly
      thermal: of: Set THERMAL_TRIP_FLAG_RW_TEMP directly
      thermal: core: Eliminate writable trip points masks
      thermal: intel: int340x_thermal: Use thermal zone accessor functions

Srinivas Pandruvada (1):
      thermal: int340x: processor_thermal: Add Lunar Lake-M PCI ID

Zhang Rui (1):
      thermal/intel: Fix intel_tcc_get_temp() to support negative CPU
temperature

---------------

 arch/arm/configs/imx_v6_v7_defconfig               |  1 -
 drivers/acpi/thermal.c                             | 61 +++++++----------
 drivers/net/ethernet/chelsio/cxgb4/cxgb4_thermal.c |  2 +-
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c | 12 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h       |  2 -
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c        | 73 ++++++++++----------
 drivers/platform/x86/acerhdf.c                     |  2 +-
 drivers/thermal/Kconfig                            | 11 ----
 drivers/thermal/da9062-thermal.c                   |  2 +-
 drivers/thermal/gov_bang_bang.c                    |  2 +-
 drivers/thermal/gov_fair_share.c                   | 16 +++--
 drivers/thermal/gov_power_allocator.c              |  2 +
 drivers/thermal/imx_thermal.c                      |  6 +-
 drivers/thermal/intel/Kconfig                      |  2 -
 .../intel/int340x_thermal/int340x_thermal_zone.c   | 43 ++++--------
 .../intel/int340x_thermal/int340x_thermal_zone.h   |  2 -
 .../int340x_thermal/processor_thermal_device.c     |  8 +--
 .../int340x_thermal/processor_thermal_device.h     |  1 +
 .../int340x_thermal/processor_thermal_device_pci.c | 13 ++--
 drivers/thermal/intel/intel_pch_thermal.c          | 28 ++++----
 drivers/thermal/intel/intel_quark_dts_thermal.c    | 34 ++++------
 drivers/thermal/intel/intel_soc_dts_iosf.c         | 77 +++++++++-------------
 drivers/thermal/intel/intel_soc_dts_iosf.h         |  2 -
 drivers/thermal/intel/intel_tcc.c                  | 12 ++--
 drivers/thermal/intel/x86_pkg_temp_thermal.c       | 47 +++++--------
 drivers/thermal/rcar_thermal.c                     |  2 +-
 drivers/thermal/st/st_thermal.c                    |  2 +-
 drivers/thermal/thermal_core.c                     | 76 +++++++++------------
 drivers/thermal/thermal_core.h                     |  2 +-
 drivers/thermal/thermal_helpers.c                  | 10 +--
 drivers/thermal/thermal_hwmon.c                    |  4 +-
 drivers/thermal/thermal_of.c                       | 37 ++++-------
 drivers/thermal/thermal_sysfs.c                    | 38 +++++------
 drivers/thermal/thermal_trip.c                     |  6 +-
 include/linux/intel_tcc.h                          |  2 +-
 include/linux/thermal.h                            | 37 ++++++-----
 36 files changed, 282 insertions(+), 395 deletions(-)

