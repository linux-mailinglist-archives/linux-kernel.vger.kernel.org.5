Return-Path: <linux-kernel+bounces-144923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB2288A4CA6
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:40:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2276E1C20F13
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C535C8EE;
	Mon, 15 Apr 2024 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Elta5SQ9"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8DD5B691;
	Mon, 15 Apr 2024 10:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713177633; cv=none; b=gXMlrdCo9Ys7Rn+hSpRLkHX/PRZVMDixAwpq2PKYg07AhorWDSltUpa4W9qIDM8W6R1Q1t/R3l0z22RKo4Hgsx37wk7jZsLfNuqM2jJkFp/cHIcxRDkuiXQxhBA9vI9M2qEdXRz51rCFeVn5E2ogA/JmFhKthCSoZVtXaElsnsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713177633; c=relaxed/simple;
	bh=fUNRMT40GKK0rii+qbnXmgY0J3JBenBg6zUwQ2WVDew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iyFAO+Gr//+g7aRu8kJY2qmIBG1hpIdCi4lZisN+ddbXgeEFYHB0hXspm6JvupB83WL96O0xy6XpZYMskuu+PwxgpbbL1csCBB3NUJHwXgYAElMgzBXZxhAkHGa7P1INPS/RXGcXa7MdoSc9xI2yp8q0HeUNY3xLhI2gFo4ng+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Elta5SQ9; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713177629;
	bh=fUNRMT40GKK0rii+qbnXmgY0J3JBenBg6zUwQ2WVDew=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Elta5SQ9I7l6Drg1gQy04pS7uxEpU8tL++tVeNeIzJ423BEjoJ/qyrahkWD3Z4oHQ
	 PCjS5GfMzIJP98Yte6jda5895UX0Doe8aCmk2qj0dB0mCNDI0+OxOScsWIJ2qSGEjE
	 RW8UHVcjFiBORzwYQodXOh5CZwSxiwqNCxRYzzU1ROe4uVwdeI6V4IesgbTBb8+kSt
	 EScT6pQLVSxqzU2TqbIvMjNVdFrwfNJP2+jera9owBcOdUvWklJrJxSBQgF8/fysCW
	 kIzqMHB4ih/ZWiAuo3amqnE7zR9gZxImedkD7bIIeP61hzNeiLH3MHSoMea9XMqnpo
	 WQZnOW8PsEGyg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 0BD19378000E;
	Mon, 15 Apr 2024 10:40:25 +0000 (UTC)
Message-ID: <2c16d81c-f955-4fa3-b291-3ca403dca45b@collabora.com>
Date: Mon, 15 Apr 2024 12:40:25 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm/arm64: dts: Drop "arm,armv8-pmuv3" compatible usage
To: Rob Herring <robh@kernel.org>, soc@kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Dinh Nguyen <dinguyen@kernel.org>,
 Tsahee Zidenberg <tsahee@annapurnalabs.com>,
 Antoine Tenart <atenart@kernel.org>,
 Khuong Dinh <khuong@os.amperecomputing.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>, Robert Richter <rric@kernel.org>,
 Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, "Paul J. Murphy"
 <paul.j.murphy@intel.com>,
 Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>, Heiko Stuebner <heiko@sntech.de>,
 Orson Zhai <orsonzhai@gmail.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Chunyan Zhang <zhang.lyra@gmail.com>,
 Jisheng Zhang <jszhang@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>,
 linux-fsd@tesla.com, Michal Simek <michal.simek@amd.com>
Cc: devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 imx@lists.linux.dev, linux-mediatek@lists.infradead.org,
 linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-realtek-soc@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org
References: <20240412222857.3873079-1-robh@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240412222857.3873079-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 13/04/24 00:28, Rob Herring ha scritto:
> The "arm,armv8-pmuv3" compatible is intended only for s/w models. Primarily,
> it doesn't provide any detail on uarch specific events.
> 
> There's still remaining cases for CPUs without any corresponding PMU
> definition and for big.LITTLE systems which only have a single PMU node
> (there should be one per core type).
> 
> Signed-off-by: Rob Herring <robh@kernel.org>

For MediaTek:

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



