Return-Path: <linux-kernel+bounces-166350-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBE88B9972
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42D95B220BC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 439635E091;
	Thu,  2 May 2024 10:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WfG92Vhl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA7357871;
	Thu,  2 May 2024 10:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714647073; cv=none; b=JFe3fpUXHdqF8onxfC7Uuxadx1Ea1mKnlwz4aIBsU1jf2kP6poI2X2YQ8D5EcufrOjRNnFGPNeorEzFUXscGBgceySS+LEJHBoSzpApbsBVDHKFsJ0xwLAQMvGSTCbfG99lo1beM4zXVx5uAF3DXr3lnCT5zeIj31qWSyCFkqtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714647073; c=relaxed/simple;
	bh=fR5HOrR6Ubn0xyMbMtSkOFo520Msg119zUjsxH5P3dk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gafMp3MqsTpRpYFA1AebbXC3COJZMcGliW2Up28hZqoXIly7AwmKfEDnvNfD++iy8MH6liaxAOELF+eViOoDYxzKiZ+GCtSrHk+4yGTDH9HeGCb1yORvXY6zFxI+UBTabgd2dxVo7/s/ddQn6DBd0+B5sOg3swZ6wdB8MfSKxxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WfG92Vhl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6257C4AF1D;
	Thu,  2 May 2024 10:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714647072;
	bh=fR5HOrR6Ubn0xyMbMtSkOFo520Msg119zUjsxH5P3dk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=WfG92VhljYufTAVzjiEUxiwqnY6DgXVPqbaCMi4aX6TnSc4e9lYf4rY951wj0EwKs
	 TzWxXE2gL6TPynfe+lgn49/utuFcuo8y/5KBq/TmVuak6N/wANYnnlKpJDFXwGGHuw
	 OusyTsr34eREJFxNJuBpS6JBEGgnI+4ZqBTXiSPwgNez7jfg1RTUNhv4VvQwBxVD51
	 nhuMHvln038ij22+EkrBhY9gyNj1bntgdGBdiShnWr5m6C8WsH4+L+3KKUSpMcmc8M
	 rudllHmf+AIb1Ddfdsmpow3HR2bEywqrNmG6Io6Z/X3INpBc4SvPNLBH90CJS96kBA
	 PXc0Q8fVLmeLQ==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5acf5723325so1950631eaf.0;
        Thu, 02 May 2024 03:51:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWwl46nrDyJHV35xPmw65o9lPX9knVmXZNa3p8kmwlzaedd9RUhRuq5q0rBYlC9BeC/3ywcxFyvofJ7Af7c238FUa3XRy/UDVL9WqC0zGvhigVFCc16PaVMh214fKtmYjir129Wl8M=
X-Gm-Message-State: AOJu0Ywr0LzaeuYM3Xi75gIqlMXDSfgSU0wuYFhSXTEzhdHYJkhi50Th
	lO3v3OqBpgrgxfTHbgR0VDMwpdxYDqDUXo9KUvrqQ81LFsoYzBetLsSenMvzaRppI0LaVskUs0m
	0ckXP0q5IFRheaHZsRJUr6o9LB78=
X-Google-Smtp-Source: AGHT+IGFXvaP04bY4o4omIjRMy+hQgJIqekDcRnbPWRO0R4oPEni7cBtvTk42duDAiYiQCJu3r387iiHQaH64qQBpuY=
X-Received: by 2002:a05:6820:2b06:b0:5ac:6fc1:c2cb with SMTP id
 dt6-20020a0568202b0600b005ac6fc1c2cbmr5097901oob.0.1714647072034; Thu, 02 May
 2024 03:51:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <89a02410-87c8-47c6-aa50-04dad5b4e585@linaro.org>
In-Reply-To: <89a02410-87c8-47c6-aa50-04dad5b4e585@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 2 May 2024 12:50:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jVkD2muM_rZ_1nfOukHKaB4LoFheV79YX7v2p+koV4Vg@mail.gmail.com>
Message-ID: <CAJZ5v0jVkD2muM_rZ_1nfOukHKaB4LoFheV79YX7v2p+koV4Vg@mail.gmail.com>
Subject: Re: [GIT PULL] thermal drivers for v6.10-rc1
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux PM mailing list <linux-pm@vger.kernel.org>, Lukasz Luba <Lukasz.Luba@arm.com>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Raphael Gallais-Pou <rgallaispou@gmail.com>, Priyansh Jain <quic_priyjain@quicinc.com>, 
	Dmitry Rokosov <ddrokosov@salutedevices.com>, 
	=?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund+renesas@ragnatech.se>, 
	Hsin-Te Yuan <yuanhsinte@chromium.org>, Aleksandr Mishin <amishin@t-argos.ru>, 
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Nicolas Pitre <nicolas.pitre@linaro.org>, 
	Binbin Zhou <zhoubinbin@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

On Thu, May 2, 2024 at 11:51=E2=80=AFAM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> Hi Rafael,
>
> please consider this pull request for v6.10-rc1
>
> The following changes since commit 5c897a9a1237155822183b8979005d06c14a99=
6a:
>
>    Merge back earlier thermal control material for v6.10. (2024-04-19
> 15:17:21 +0200)
>
> are available in the Git repository at:
>
>
> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/thermal/linux.git
> tags/thermal-v6.10-rc1
>
> for you to fetch changes up to 734b5def91b594d3aa1147d60c45eded139ce2eb:
>
>    thermal/drivers/loongson2: Add Loongson-2K2000 support (2024-04-23
> 12:40:30 +0200)
>
> ----------------------------------------------------------------
> - Add QCM2290 compatible DT bindings for Lmh and fix a null pointer
>    dereference in the lmh driver in case the SCM is not present (Konrad
>    Dybcio)
>
> - Use the strreplace() function instead of doing it manually in the
>    Armada driver (Rasmus Villemoes)
>
> - Convert st,stih407-thermal to DT schema and fix up missing
>    properties (Raphael Gallais-Pou)
>
> - Add suspend/resume by restoring the context of the tsens sensor
>    (Priyansh Jain)
>
> - Support A1 SoC family Thermal Sensor controller and add the DT
>    bindings (Dmitry Rokosov)
>
> - Improve the temperature approximation calculation and consolidate
>    the Tj constant into a shared area of the structure instead of
>    duplicating it on the Rcar Gen3 (Niklas S=C3=B6derlund)
>
> - Fix the Mediatek LVTS sensor coefficient for the MT8192 in order to
> support
>    it correctly (Hsin-Te Yuan)
>
> - Fix a null pointer dereference on the tsens driver when the function
>    compute_intercept_slope() is called with a null parameter (Aleksandr
>    Mishin)
>
> - Remove some unused fields in struct qpnp_tm_chip and k3_bandgap
>    (Christophe Jaillet)
>
> - Fixup calibration efuse data decoding, consolidate the code by
>    checking boundaries and refactor some part of the LVTS Mediatek
>    driver. After setting the scene, add MT8186 and MT8188 along with
>    the DT bindings (Nicolas Pitre)
>
> - Add Loongson-2K2000 support after some minor code adjustements and
>    providing the DT bindings definition (Binbin Zhou)
>
> ----------------------------------------------------------------
> Aleksandr Mishin (1):
>        thermal/drivers/tsens: Fix null pointer dereference
>
> Binbin Zhou (4):
>        thermal/drivers/loongson2: Trivial code style adjustment
>        dt-bindings: thermal: loongson,ls2k-thermal: Add Loongson-2K0500
> compatible
>        dt-bindings: thermal: loongson,ls2k-thermal: Fix incorrect
> compatible definition
>        thermal/drivers/loongson2: Add Loongson-2K2000 support
>
> Christophe JAILLET (2):
>        thermal/drivers/qcom: Remove some unused fields in struct
> qpnp_tm_chip
>        thermal/drivers/k3_bandgap: Remove some unused fields in struct
> k3_bandgap
>
> Dmitry Rokosov (2):
>        dt-bindings: thermal: amlogic: add support for A1 thermal sensor
>        thermal/drivers/amlogic: Support A1 SoC family Thermal Sensor
> controller
>
> Hsin-Te Yuan (1):
>        thermal/drivers/mediatek/lvts_thermal: Add coeff for mt8192
>
> Konrad Dybcio (2):
>        dt-bindings: thermal: lmh: Add QCM2290 compatible
>        thermal/drivers/qcom/lmh: Check for SCM availability at probe
>
> Nicolas Pitre (11):
>        thermal/drivers/mediatek/lvts_thermal: Retrieve all calibration by=
tes
>        thermal/drivers/mediatek/lvts_thermal: Move comment
>        thermal/drivers/mediatek/lvts_thermal: Remove .hw_tshut_temp
>        thermal/drivers/mediatek/lvts_thermal: Use offsets for every
> calibration byte
>        thermal/drivers/mediatek/lvts_thermal: Guard against efuse data
> buffer overflow
>        dt-bindings: thermal: mediatek: Add LVTS thermal controller
> definition for MT8186
>        thermal/drivers/mediatek/lvts_thermal: Add MT8186 support
>        thermal/drivers/mediatek/lvts_thermal: Provision for gt variable
> location
>        thermal/drivers/mediatek/lvts_thermal: Allow early empty sensor sl=
ots
>        dt-bindings: thermal: mediatek: Add LVTS thermal controller
> definition for MT8188
>        thermal/drivers/mediatek/lvts_thermal: Add MT8188 support
>
> Niklas S=C3=B6derlund (2):
>        thermal/drivers/rcar_gen3: Move Tj_T storage to shared private dat=
a
>        thermal/drivers/rcar_gen3: Update temperature approximation
> calculation
>
> Priyansh Jain (1):
>        thermal/drivers/tsens: Add suspend to RAM support for tsens
>
> Raphael Gallais-Pou (1):
>        dt-bindings: thermal: convert st,stih407-thermal to DT schema
>
> Rasmus Villemoes (1):
>        thermal/drivers/armada: Simplify name sanitization
>
>   .../bindings/thermal/amlogic,thermal.yaml          |  12 +-
>   .../bindings/thermal/loongson,ls2k-thermal.yaml    |  24 +-
>   .../bindings/thermal/mediatek,lvts-thermal.yaml    |   6 +
>   .../devicetree/bindings/thermal/qcom-lmh.yaml      |  12 +-
>   .../bindings/thermal/st,stih407-thermal.yaml       |  58 +++
>   .../devicetree/bindings/thermal/st-thermal.txt     |  32 --
>   drivers/thermal/amlogic_thermal.c                  |  10 +
>   drivers/thermal/armada_thermal.c                   |   9 +-
>   drivers/thermal/k3_bandgap.c                       |   1 -
>   drivers/thermal/loongson2_thermal.c                | 117 ++++--
>   drivers/thermal/mediatek/lvts_thermal.c            | 438
> +++++++++++++++------
>   drivers/thermal/qcom/lmh.c                         |   3 +
>   drivers/thermal/qcom/qcom-spmi-temp-alarm.c        |   1 -
>   drivers/thermal/qcom/tsens-v2.c                    |   1 +
>   drivers/thermal/qcom/tsens.c                       |  33 +-
>   drivers/thermal/qcom/tsens.h                       |   5 +
>   drivers/thermal/rcar_gen3_thermal.c                | 165 ++++----
>   .../dt-bindings/thermal/mediatek,lvts-thermal.h    |  26 ++
>   18 files changed, 667 insertions(+), 286 deletions(-)
>   create mode 100644
> Documentation/devicetree/bindings/thermal/st,stih407-thermal.yaml
>   delete mode 100644
> Documentation/devicetree/bindings/thermal/st-thermal.txt
>
> --

Pulled and added to the thermal branch in linux-pm.git.

Thank you!

