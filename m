Return-Path: <linux-kernel+bounces-28838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE07F830394
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97CD82821EE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3DD1DFC2;
	Wed, 17 Jan 2024 10:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="elOe0XkA"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821F11DDDE;
	Wed, 17 Jan 2024 10:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705487349; cv=none; b=V0NocLj50d54JkYNxV6pzVwAsE1EY/fUSmdwdQD7eF4OF66VoTxGXp3SDktfZdcsrWFk1Ks947pv/UBygo9DDz4eMeU9oiEoZgiMVhViTE/SFcYb41y6ZF2AViICv7cKKvYLyVzH/h+WN/pHTFhrzc8n8vVZZNirh3R3UTC01bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705487349; c=relaxed/simple;
	bh=uzs6hr67x0wcN5kmfNYEWgn7qqBTKldWpYNeoxCt1GU=;
	h=DKIM-Signature:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding; b=LC/D1DfP3GjAPhw9/4b6BPcDYVaHhSC5ZMBNG5YQKo3ACwbu3iX/wM/WWu/E7tAB5eQ60XhanPDzwBaeW+LV7iZuilKe95Gn08mv8Xn7qasunKsvqEuXGrEJ5uHSOJevsz0nOw+wEJLenUPkUK+ZfdB+VzirkCnnmOWQ3dYj0Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=elOe0XkA; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705487346;
	bh=uzs6hr67x0wcN5kmfNYEWgn7qqBTKldWpYNeoxCt1GU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=elOe0XkAQYBaF2j+quVIDduCoSqMpPA4uttYtiJ8+edcOGA+F7BC3gngIGSXXrdBb
	 iiEys6qytH/YYkK53Nty5Eg4uKsbqYwazpa2A0AMl2DPtOFLHbO9uCQbHtxIyjvgbT
	 MIhixDNe1cQbm3cyTx1pCAbadStenTUAtl7gYl7e0s8URZTa+dnmfNOG7qHk0yo1NK
	 oaIS2Z/V+8NCk1gixwj+yZvNF8SAQmdVgKKfUe1HOAjsox6dl9STPj4ktzL7ou8unL
	 vPZqnAeyniR3OYZLLhzAnrDqGVLlmUMa4x+NEFhZqCOXGN6JQSogvsvbxqZsjGcHdZ
	 k1iLtC4R3ZXDQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 93BB8378148C;
	Wed, 17 Jan 2024 10:29:04 +0000 (UTC)
Message-ID: <cf895498-ef54-4667-a205-cc3150be9a22@collabora.com>
Date: Wed, 17 Jan 2024 11:29:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/7] Allow coreboot modules to autoload and enable
 cbmem in the arm64 defconfig
Content-Language: en-US
To: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Tzung-Bi Shih <tzungbi@kernel.org>
Cc: kernel@collabora.com, chrome-platform@lists.linux.dev,
 Abhijit Gangurde <abhijit.gangurde@amd.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson <quic_bjorande@quicinc.com>,
 Brian Norris <briannorris@chromium.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Julius Werner <jwerner@chromium.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
 Nicolas Schier <nicolas@fjasle.eu>, Nipun Gupta <nipun.gupta@amd.com>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 U mang Jain <umang.jain@ideasonboard.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240112131857.900734-1-nfraprado@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240112131857.900734-1-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 12/01/24 14:18, Nícolas F. R. A. Prado ha scritto:
> 
> This series adds the missing pieces to the coreboot bus and the module
> alias generation to allow coreboot modules to be automatically loaded
> when matching devices are detected.
> 
> The configs for cbmem coreboot entries are then enabled in the arm64
> defconfig, as modules, to allow reading logs from coreboot on arm64
> Chromebooks, which is useful for debugging the boot process.
> 

For the entire series:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> Changes in v2:
> - Added commits for vpd, memconsole and framebuffer drivers to add them
>    to the module device table
> 
> Nícolas F. R. A. Prado (7):
>    firmware: coreboot: Generate modalias uevent for devices
>    firmware: coreboot: Generate aliases for coreboot modules
>    firmware: google: cbmem: Add to module device table
>    firmware: google: vpd: Add to module device table
>    firmware: google: memconsole: Add to module device table
>    firmware: google: framebuffer: Add to module device table
>    arm64: defconfig: Enable support for cbmem entries in the coreboot
>      table
> 
>   arch/arm64/configs/defconfig                   |  3 +++
>   drivers/firmware/google/cbmem.c                |  7 +++++++
>   drivers/firmware/google/coreboot_table.c       |  9 +++++++++
>   drivers/firmware/google/framebuffer-coreboot.c |  7 +++++++
>   drivers/firmware/google/memconsole-coreboot.c  |  7 +++++++
>   drivers/firmware/google/vpd.c                  |  7 +++++++
>   include/linux/mod_devicetable.h                |  8 ++++++++
>   scripts/mod/devicetable-offsets.c              |  3 +++
>   scripts/mod/file2alias.c                       | 10 ++++++++++
>   9 files changed, 61 insertions(+)
> 


