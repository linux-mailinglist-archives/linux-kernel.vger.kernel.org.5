Return-Path: <linux-kernel+bounces-63187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFDF0852C0E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:12:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68A6C285E90
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A41AD21A04;
	Tue, 13 Feb 2024 09:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="qzzapQ4j"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A80A224C6;
	Tue, 13 Feb 2024 09:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707815569; cv=none; b=a9deZZSA+QE59CcjshqfDdw62ft+GB/0yhzZALtcKMFTe0ualOmSptbZbxzP5AAJfwJ7OeGegosUXcZOwc7qMeDIMhTdfl62W9kG47jVrf6PQvzmpMQh0/W49Mzjs3+s6ktVRxu8wUXVrXHbwon/z/OYKjSOLwFSXu4BjFwD+Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707815569; c=relaxed/simple;
	bh=IF9JkPNFvE+ZhS23bc558VWeMouFPJSwGah7iUkeyQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oYF86wJcsJwzDA4ppSBG00F4SI494G5a9becgG90TJ9ND8UbSlvTS96FotXoA6nFG4Ps0pwxnd7l0y6kMJ84pJCvnC3RlTt2lBii5A6UdogDmeok1CmCXoc0vIkWUh9OV0TRJlLm0T0shkHQ5E57i0HN6jF6fM0+AWfzSTDADC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=qzzapQ4j; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707815567;
	bh=IF9JkPNFvE+ZhS23bc558VWeMouFPJSwGah7iUkeyQI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qzzapQ4jZZQHyDb2s7cv9CxYUZwuwm+L8YsGJwME6JSybXHz2O23UMHZ7HC58e+BS
	 kkaSuQqHyIMfTemMh17Fa/6NuchfPjcL9QQ6dcBBcwXHVtrbnEgpm3F7hWstTfkwDH
	 arxSPTUBIH9zNp2hnSRbd/1tpPQDsefrCJLrGQ0gcZpUiuIADznBLMf1OpFLstdxVG
	 74UUTMmhBe9AOSI8E6YStWrbVrYu3o+buco/+ZkddvCcvLTFWDmKE+U4zaEbIzbC5V
	 Sqk4yaUAF46iwuuV0prWHaFiheA0NpTAJJH2uWkhqYK09Xq6mJpvdvX5QtUTVMGane
	 4BerPvF1EKTxA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 3941D3781FEF;
	Tue, 13 Feb 2024 09:12:46 +0000 (UTC)
Message-ID: <3df28f8e-4efa-4fa6-b529-daba04969ede@collabora.com>
Date: Tue, 13 Feb 2024 10:12:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt7986: prefix BPI-R3 cooling maps
 with "map-"
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>,
 Frank Wunderlich <frank-w@public-files.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>
References: <20240213061459.17917-1-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240213061459.17917-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 13/02/24 07:14, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This fixes:
> arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtb: thermal-zones: cpu-thermal:cooling-maps: 'cpu-active-high', 'cpu-active-low', 'cpu-active-med' do not match any of the regexes: '^map[-a-zA-Z0-9]*$', 'pinctrl-[0-9]+'
>          from schema $id: http://devicetree.org/schemas/thermal/thermal-zones.yaml#
> 
> Fixes: c26f779a2295 ("arm64: dts: mt7986: add pwm-fan and cooling-maps to BPI-R3 dts")
> Cc: Daniel Golle <daniel@makrotopia.org>
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



