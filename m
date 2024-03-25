Return-Path: <linux-kernel+bounces-116747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E895F88A343
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:55:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F7B51F3D1F8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDF0F84D27;
	Mon, 25 Mar 2024 10:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWDbW2pi"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33951802CD;
	Mon, 25 Mar 2024 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711358967; cv=none; b=J9vkPFupGrZVA0vMz8IZP5e4FQTo3B/etgTjR6foGzT6cHucRAS7iAOlBL+N6FkQXoA3imlCWmDXsxjJqmiO97j1qqwRBiThYmgNjG6OEaMIr8v929ALsCj08rw/UY8fgzK3lLcaLmNpSAcGL3puUhWKDPyb4YC25r/LGMb/WkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711358967; c=relaxed/simple;
	bh=L7eRB9UE0AFTLtUcx3jXW/Lcf4eB7MvnxSvfFx8sbKc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fjwStrHAjW/Nh6DuDYRL1t7IPkhOx2kwaG87EfCBOU1NJ3rU2lw9J+Nnc0/J0OofcyZFa6MaJDgGYdU3+aSAglJNiPXXjuUY1y/wEkuYRsFZ9lfvN+PYc1hqld5eppeUiAxTQreDwycFjr+XS1JqR/VX9Foqii08ABYNA570Eds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWDbW2pi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E6C0C43390;
	Mon, 25 Mar 2024 09:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711358967;
	bh=L7eRB9UE0AFTLtUcx3jXW/Lcf4eB7MvnxSvfFx8sbKc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TWDbW2piXNm8EWyiTv6cIJJ696JM3raBRT5+utcMQKVm8Z6M5g/RaMxR0BlnouZsE
	 cMBGuGUbbBBFr1MsYpQakLxXFl3Zn4rD5af0uYM0eA3njAy1JT4PcttX+13sDyfoDI
	 V31OdwOR1kM38GF/onFRpViFko6v1fHMMeAQ7GmHSZ5kwR6/ZbsgNCdt5W086XBpKc
	 lzd6ONim4fzMmtxarTRTs9onIAn/N+yKFCHIPhehj91C+tCUvAs49sOdFAIanOTFVF
	 DQxF3GHNfVIdMAAnyLmemYBo3DFtF8r95VMu7hmNJAjBo76g3feZiltOT1CLNNfZov
	 2Nuc2MWdjvMGg==
Message-ID: <1a7ec34d-b126-4193-9e0c-bbdfe4e7126f@kernel.org>
Date: Mon, 25 Mar 2024 18:29:24 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8] dt-bindings: ata: imx-pata: Convert to dtschema
Content-Language: en-US
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240320090733.96828-1-animeshagarwal28@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240320090733.96828-1-animeshagarwal28@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/20/24 18:07, Animesh Agarwal wrote:
> Convert the imx-pata bindings to DT schema.
> Add missing fsl,imx31-pata and fsl,imx51-pata compatibles during
> conversion, because they are already being used in existing DTS.
> 
> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>

Applied to for-6.10. Thanks !

-- 
Damien Le Moal
Western Digital Research


