Return-Path: <linux-kernel+bounces-157618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E64B68B13AA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:39:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55C3DB25B8A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD5078C99;
	Wed, 24 Apr 2024 19:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h/sXKpHW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEB45C614;
	Wed, 24 Apr 2024 19:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713987532; cv=none; b=oarMoAgwV23NgGvtvqgfOEfJO5LGrnBxKNVespPeVHfKqEBRHRAvONNlzm5khpnugxPnurG4eNL+pzmPv38kzlmSwxfbmbNkm20cCs9r2hP/CxRI0b6sFuMqQ67pMoE4DP0yy+E5797X6kFS9ts1xgOEbyMxTKAWazcUhanDw94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713987532; c=relaxed/simple;
	bh=l0ilri84SmnD9pNOTOslUkyhEiFOgPWIkUlWnz4KH2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEKQ2vooWw4BHcrmOgrJtUW05GWLJ1GM6u7NDL+fqk8YOS81hiBoPLJ2kVPYW4ClMS38ylrVdRekZ0h3Pdxm7QSlTDXWg6F5n7oFzi6cJZDmwjzHuIjqdiRnF76Brea7F0WAE3BiFduOB5RGUwVcu+ko2QD8GTztFQSrw54XOQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h/sXKpHW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835D0C113CD;
	Wed, 24 Apr 2024 19:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713987531;
	bh=l0ilri84SmnD9pNOTOslUkyhEiFOgPWIkUlWnz4KH2A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h/sXKpHWJlhlrcZk/Go6u/OG56s7UwL9BOt8s4r+0/LHTG6O46Bg8fAH5R1z4XkO5
	 vIYWXRuuRcWeIA9MHiei9FN9QdrjgrP9DOI0W6GssiEnLgkNWOWYG8wjPooaXgTSob
	 wgRzyJ9rTWKpSYX5AP3NTfsPqctXDgQVUaZME0RNxrj0oi8Mo+w6YFe+RuFSztioNK
	 mMPvSohYCtwx7+7kuTA7t5cYQBRGQz+fqumYQh/hqjcH/Dd6CByLZJ2OMWrQX3eTJO
	 xgbQehwHmby0fcpaupCAosIyM+F4Hmmu0hwGgPV/vPF74P1Aya8CquZzfqgmIFCRTs
	 jbgW3ZJE85OVA==
Date: Wed, 24 Apr 2024 14:38:49 -0500
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Peter Griffin <peter.griffin@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>, devicetree@vger.kernel.org,
	Will McVicker <willmcvicker@google.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Sylwester Nawrocki <s.nawrocki@samsung.com>,
	Chanwoo Choi <cw00.choi@samsung.com>, kernel-team@android.com,
	linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Conor Dooley <conor+dt@kernel.org>, linux-clk@vger.kernel.org,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/3] dt-bindings: clock: google,gs101-clock: add HSI0
 clock management unit
Message-ID: <171398751251.350681.17049753493384943747.robh@kernel.org>
References: <20240423-hsi0-gs101-v1-0-2c3ddb50c720@linaro.org>
 <20240423-hsi0-gs101-v1-1-2c3ddb50c720@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423-hsi0-gs101-v1-1-2c3ddb50c720@linaro.org>


On Tue, 23 Apr 2024 15:31:03 +0100, André Draszik wrote:
> Add dt-schema documentation and clock IDs for the high speed interface
> 0 HSI0 clock management unit. This is used (amongst others) for USB.
> 
> While the usual (sed) script has been used to derive the linux clock
> IDs from the data sheet, one manual tweak was applied to fix a typo
> which we don't want to carry:
>     HSI0_USPDPDBG_USER -> HSI0_USBDPDBG_USER (note USB vs USP).
> 
> Signed-off-by: André Draszik <andre.draszik@linaro.org>
> 
> ---
> Note for future reference: To ensure consistent naming throughout this
> driver, the IDs have been derived from the data sheet using the
> following, with the expectation for all future additions to this file
> to use the same:
>     sed \
>         -e 's|^PLL_LOCKTIME_PLL_\([^_]\+\)|CLK_FOUT_\1_PLL|' \
>         \
>         -e 's|^PLL_CON0_MUX_CLKCMU_\([^_]\+\)_|CLK_MOUT_\1_|' \
>         -e 's|^PLL_CON0_PLL_\(.*\)|CLK_MOUT_PLL_\1|' \
>         -e 's|^CLK_CON_MUX_MUX_CLK_\(.*\)|CLK_MOUT_\1|' \
>         -e '/^PLL_CON[1-4]_[^_]\+_/d' \
>         -e '/^[^_]\+_CMU_[^_]\+_CONTROLLER_OPTION/d' \
>         -e '/^CLKOUT_CON_BLK_[^_]\+_CMU_[^_]\+_CLKOUT0/d' \
>         \
>         -e 's|_IPCLKPORT||' \
>         -e 's|_RSTNSYNC||' \
>         -e 's|_G4X2_DWC_PCIE_CTL||' \
>         -e 's|_G4X1_DWC_PCIE_CTL||' \
>         -e 's|_PCIE_SUB_CTRL||' \
>         -e 's|_INST_0||g' \
>         -e 's|_LN05LPE||' \
>         -e 's|_TM_WRAPPER||' \
>         -e 's|_SF||' \
>         \
>         -e 's|^CLK_CON_DIV_DIV_CLK_\([^_]\+\)_|CLK_DOUT_\1_|' \
>         \
>         -e 's|^CLK_CON_BUF_CLKBUF_\([^_]\+\)_|CLK_GOUT_\1_|' \
>         -e 's|^CLK_CON_GAT_CLK_BLK_\([^_]\+\)_UID_|CLK_GOUT_\1_|' \
>         -e 's|^CLK_GOUT_[^_]\+_[^_]\+_CMU_\([^_]\+\)_PCLK$|CLK_GOUT_\1_PCLK|' \
>         -e 's|^CLK_CON_GAT_GOUT_BLK_\([^_]\+\)_UID_|CLK_GOUT_\1_|' \
>         -e 's|^CLK_CON_GAT_CLK_\([^_]\+\)_\(.*\)|CLK_GOUT_\1_CLK_\1_\2|' \
>         \
>         -e '/^\(DMYQCH\|PCH\|QCH\|QUEUE\)_/d'
> ---
>  .../bindings/clock/google,gs101-clock.yaml         | 29 +++++++++++-
>  include/dt-bindings/clock/google,gs101.h           | 54 ++++++++++++++++++++++
>  2 files changed, 81 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


