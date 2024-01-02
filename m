Return-Path: <linux-kernel+bounces-14357-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB95C821C0F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B8691F22B40
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 12:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A68F9CC;
	Tue,  2 Jan 2024 12:51:47 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D570EF9C3;
	Tue,  2 Jan 2024 12:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-593f182f263so2143166eaf.0;
        Tue, 02 Jan 2024 04:51:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704199905; x=1704804705;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWJpsSWjAqvITEmiBbPlA7D2pwFtpr6ooxh4CXH4Kz0=;
        b=tznP7T7VPmbrUuI5dtZ5+eHzqsXCeqo4rn41G4Yh7+g54ra4WRARLZZqgGBwZ5p17x
         i9P3rzqYXV1BWX5P6dexwe3ZmFhhk+rDQqAXuXEgKvdaoozKW1ub8S+UmJTW/lVcU7CB
         78OYEWaGfwz6bJuH4qeq/f+mfuhdYsKI0lA2KwWQmmOKq9iW/xNURdNH4t6K2rEPAp1D
         d4TdXQaDTed8vUH5vfj0Zxix+LwcHeauehzHHQ0XBSHYWCORR+tTxKnsdCanbDMaKs4x
         e2xL8ET5NswydAaL4ibi8HnR3atKKQ+L9lATJkVDjnQPOscExoVmbB4Azx+ZwX07K5q2
         sJzA==
X-Gm-Message-State: AOJu0YxkjLnd4QWNyGj0H5jlTxMVveBTNMGxGSUVE5a/nycJ7U5pZVeJ
	WwssnVsnssNvyfqgveXl0Ro9Q67hI2nxtmemmhU=
X-Google-Smtp-Source: AGHT+IHDBkPRU3mIu++qRAviLkA1G9ucIWm/FarTZFV8d7+KkDNR01/7Qq4GsvhtAKiAsdHVwmDKcrB/OTPSpgWRFWY=
X-Received: by 2002:a4a:c719:0:b0:594:c433:66e6 with SMTP id
 n25-20020a4ac719000000b00594c43366e6mr13646877ooq.0.1704199904988; Tue, 02
 Jan 2024 04:51:44 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7163da4d-3f73-490c-a387-04d82e8bee1b@free.fr>
In-Reply-To: <7163da4d-3f73-490c-a387-04d82e8bee1b@free.fr>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 2 Jan 2024 13:51:29 +0100
Message-ID: <CAJZ5v0iX=E-4T87_mUjToj+oRDqkek_iu_L05z0zzrR66xZSmg@mail.gmail.com>
Subject: Re: [GIT PULL] thermal material for v6.8-rc1
To: Daniel Lezcano <daniel.lezcano@free.fr>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux PM mailing list <linux-pm@vger.kernel.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Binbin Zhou <zhoubb.aaron@gmail.com>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Fabio Estevam <festevam@denx.de>, Johan Hovold <johan+linaro@kernel.org>, 
	Florian Eckert <fe@dev.tdt.de>, Mateusz Majewski <m.majewski2@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Tue, Jan 2, 2024 at 10:25=E2=80=AFAM Daniel Lezcano <daniel.lezcano@free=
.fr> wrote:
>
>
> Hi Rafael,
>
> happy new year 2024!
>
> Please consider pulling these thermal changes.
>
> Thanks
>
>    -- Daniel
>
> The following changes since commit 5f70413a85056db04050604a76b52e3f39a37f=
21:
>
>    thermal: cpuidle_cooling: fix kernel-doc warning and a spello
> (2023-12-21 12:05:48 +0100)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v6.8-rc1
>
> for you to fetch changes up to 5314b1543787e6cd5d248186fcfd5c5fc4ca2146:
>
>    thermal/drivers/exynos: Use set_trips ops (2024-01-02 09:33:19 +0100)
>
> ----------------------------------------------------------------
> - Converted Mediatek Thermal to the json-schema (Rafa=C5=82 Mi=C5=82ecki)
>
> - Fixed DT bindings issue on Loongson (Binbin Zhou)
>
> - Fixed returning NULL instead of -ENODEV on Loogsoo (Binbin Zhou)
>
> - Added the DT binding for the tsens on SM8650 platform (Neil Armstrong)
>
> - Added a reboot on critical option feature (Fabio Estevam)
>
> - Made usage of DEFINE_SIMPLE_DEV_PM_OPS on AmLogic (Uwe Kleine-K=C3=B6ni=
g)
>
> - Added the D1/T113s THS controller support on Sun8i (Maxim Kiselev)
>
> - Fixed example in the DT binding for QCom SPMI (Johan Hovold)
>
> - Fixed compilation warning for the tmon utility (Florian Eckert)
>
> - Added interrupt based configuration on Exynos along with a set of
>    related cleanups (Mateusz Majewski)
>
> ----------------------------------------------------------------
> Binbin Zhou (2):
>        dt-bindings: thermal: loongson,ls2k-thermal: Fix binding check iss=
ues
>        drivers/thermal/loongson2_thermal: Fix incorrect PTR_ERR() judgmen=
t
>
> Fabio Estevam (4):
>        dt-bindings: thermal-zones: Document critical-action
>        thermal/core: Prepare for introduction of thermal reboot
>        reboot: Introduce thermal_zone_device_critical_reboot()
>        thermal/thermal_of: Allow rebooting after critical temp
>
> Florian Eckert (1):
>        tools/thermal/tmon: Fix compilation warning for wrong format
>
> Johan Hovold (2):
>        dt-bindings: thermal: qcom-spmi-adc-tm5/hc: Fix example node names
>        dt-bindings: thermal: qcom-spmi-adc-tm5/hc: Clean up examples
>
> Mateusz Majewski (9):
>        thermal/drivers/exynos: Remove an unnecessary field description
>        thermal/drivers/exynos: Drop id field
>        thermal/drivers/exynos: Wwitch from workqueue-driven interrupt
> handling to threaded interrupts
>        thermal/drivers/exynos: Handle devm_regulator_get_optional return
> value correctly
>        thermal/drivers/exynos: Simplify regulator (de)initialization
>        thermal/drivers/exynos: Stop using the threshold mechanism on
> Exynos 4210
>        thermal/drivers/exynos: Split initialization of TMU and the
> thermal zone
>        thermal/drivers/exynos: Use BIT wherever possible
>        thermal/drivers/exynos: Use set_trips ops
>
> Maxim Kiselev (2):
>        dt-bindings: thermal: sun8i: Add binding for D1/T113s THS controll=
er
>        thermal/drivers/sun8i: Add D1/T113s THS controller support
>
> Neil Armstrong (1):
>        dt-bindings: thermal: qcom-tsens: document the SM8650 Temperature
> Sensor
>
> Rafa=C5=82 Mi=C5=82ecki (1):
>        dt-bindings: thermal: convert Mediatek Thermal to the json-schema
>
> Uwe Kleine-K=C3=B6nig (2):
>        thermal: amlogic: Make amlogic_thermal_disable() return void
>        thermal: amlogic: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
>
>   .../bindings/thermal/allwinner,sun8i-a83t-ths.yaml |   7 +-
>   .../bindings/thermal/loongson,ls2k-thermal.yaml    |  10 +-
>   .../bindings/thermal/mediatek,thermal.yaml         |  99 ++++
>   .../bindings/thermal/mediatek-thermal.txt          |  52 --
>   .../bindings/thermal/qcom-spmi-adc-tm-hc.yaml      |   8 +-
>   .../bindings/thermal/qcom-spmi-adc-tm5.yaml        |  16 +-
>   .../devicetree/bindings/thermal/qcom-tsens.yaml    |   1 +
>   .../devicetree/bindings/thermal/thermal-zones.yaml |  16 +
>   drivers/thermal/amlogic_thermal.c                  |  19 +-
>   drivers/thermal/loongson2_thermal.c                |   2 +-
>   drivers/thermal/samsung/exynos_tmu.c               | 529
> +++++++++++----------
>   drivers/thermal/sun8i_thermal.c                    |  13 +
>   drivers/thermal/thermal_core.c                     |  21 +-
>   drivers/thermal/thermal_core.h                     |   1 +
>   drivers/thermal/thermal_of.c                       |   6 +
>   include/linux/reboot.h                             |  12 +-
>   kernel/reboot.c                                    |  34 +-
>   tools/thermal/tmon/tui.c                           |   2 +-
>   18 files changed, 491 insertions(+), 357 deletions(-)
>   create mode 100644
> Documentation/devicetree/bindings/thermal/mediatek,thermal.yaml
>   delete mode 100644
> Documentation/devicetree/bindings/thermal/mediatek-thermal.txt

Pulled and added to the thermal branch in linux-pm.git.

Thanks!

