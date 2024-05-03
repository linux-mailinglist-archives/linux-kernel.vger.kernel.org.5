Return-Path: <linux-kernel+bounces-167607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1975E8BABE1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:53:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE6241F229E9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:53:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5B90152DF4;
	Fri,  3 May 2024 11:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qo4z/cb1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B18CA62;
	Fri,  3 May 2024 11:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714737190; cv=none; b=kzXR8sRVosLYDbPZP1qyn8KRIzQjw8lHctDENmTQcB2OkkfIt8luUvK3a8TmvVCScGPXWMBTa6BvWAV+lCH0/fyeRej7ScYnU0hBpJjL3mBBTndjaua3vNeP0FVBPxMF8/Gb8h93qm+a6RjrNPGYY0o1F7bcsxBFvpnHcjXHokI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714737190; c=relaxed/simple;
	bh=oIovYuO/wwA3btzTdboGgNcBMqORvy93ZrXEDE9gLHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ozmUP7S0bitTQU1SN7slADnPobNy1Ox5zovJH/jlNYfmwpqWIjDSWaOz8CN/4+EiOzLWkjMAV5QZmqY027f2gUiCKRotLxXHG0vok4m1HwLIcODjgkVA941KGTjIuzM+5cyc9yRkz3zCTSNklKpH5+1KGlDtYp6G0ocKc9QxXdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qo4z/cb1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE35AC116B1;
	Fri,  3 May 2024 11:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714737189;
	bh=oIovYuO/wwA3btzTdboGgNcBMqORvy93ZrXEDE9gLHE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Qo4z/cb1lBqPWjlJbPLD9UCWaSUw+LkRcCfSFgtNCa7Nm5W7gqxC6hpvnHmbzRx12
	 qQKfkKM+AbafUkfxhz+qeYgQclTLeSm4to1eC4+KwSbHIR1Iw+GMg1aRK7/l6851XO
	 C3YQIpqUsFXZIq4UCK9NSdK1RJIF50QT69ChGe+XpxuMWw+OTYJi7OnZPezh/AST8h
	 yoYVNK2ZpyQiriowSgL3neRAC4CsiknyVfebk7q1CEPCsFLVt6tSmmcoeGvbakErgo
	 81Xz52g6gwf4V12wKhJ31oJ3XB6SzRhf7PqlevdgthOMdH5ib/63Y6cimZhxaxV35c
	 Pbx227mOPeUqw==
Message-ID: <52335ded-43e7-4694-80bf-6ceee7d918d8@kernel.org>
Date: Fri, 3 May 2024 14:53:03 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] interconnect: mediatek: Add MediaTek MT8183/8195
 EMI Interconnect driver
Content-Language: en-US
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, lgirdwood@gmail.com, broonie@kernel.org,
 keescook@chromium.org, gustavoars@kernel.org, henryc.chen@mediatek.com,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel@collabora.com,
 wenst@chromium.org, amergnat@baylibre.com
References: <20240424095416.1105639-1-angelogioacchino.delregno@collabora.com>
 <20240424095416.1105639-8-angelogioacchino.delregno@collabora.com>
From: Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20240424095416.1105639-8-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Angelo,

On 24.04.24 12:54, AngeloGioacchino Del Regno wrote:
> Add an interconnect driver for the External Memory Interface (EMI),
> voting for bus bandwidth over the Dynamic Voltage and Frequency Scaling
> Resource Collector (DVFSRC).
> 
>               ICC provider         ICC Nodes
>                                ----          ----
>               ---------       |CPU |   |--- |VPU |
>      -----   |         |-----  ----    |     ----
>     |DRAM |--|DRAM     |       ----    |     ----
>     |     |--|scheduler|----- |GPU |   |--- |DISP|
>     |     |--|(EMI)    |       ----    |     ----
>     |     |--|         |       -----   |     ----
>      -----   |         |----- |MMSYS|--|--- |VDEC|
>               ---------        -----   |     ----
>                 /|\                    |     ----
>                  |change DRAM freq     |--- |VENC|
>               ----------               |     ----
>              |  DVFSR   |              |
>              |          |              |     ----
>               ----------               |--- |IMG |
>                                        |     ----
>                                        |     ----
>                                        |--- |CAM |
>                                              ----
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Thank you for working on this! It looks good to me.
Do we have a plan how to merge all this?

Thanks,
Georgi

> ---
>   drivers/interconnect/Kconfig            |   1 +
>   drivers/interconnect/Makefile           |   1 +
>   drivers/interconnect/mediatek/Kconfig   |  29 ++
>   drivers/interconnect/mediatek/Makefile  |   5 +
>   drivers/interconnect/mediatek/icc-emi.c | 153 +++++++++++
>   drivers/interconnect/mediatek/icc-emi.h |  40 +++
>   drivers/interconnect/mediatek/mt8183.c  | 143 ++++++++++
>   drivers/interconnect/mediatek/mt8195.c  | 339 ++++++++++++++++++++++++
>   8 files changed, 711 insertions(+)
>   create mode 100644 drivers/interconnect/mediatek/Kconfig
>   create mode 100644 drivers/interconnect/mediatek/Makefile
>   create mode 100644 drivers/interconnect/mediatek/icc-emi.c
>   create mode 100644 drivers/interconnect/mediatek/icc-emi.h
>   create mode 100644 drivers/interconnect/mediatek/mt8183.c
>   create mode 100644 drivers/interconnect/mediatek/mt8195.c


