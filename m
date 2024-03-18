Return-Path: <linux-kernel+bounces-105999-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 257AE87E74B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD3592834BF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:25:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3353138389;
	Mon, 18 Mar 2024 10:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="RnV6nsUU"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 243AE37711;
	Mon, 18 Mar 2024 10:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710757445; cv=none; b=IGWn3kGqlaP6o2u2rn9fNSrkpqPdtaa5/SA1eUl9vbv0kbB2KILo+0ahApx8m6tqZm7amZ4twkJJ/7DdZ4tFhQfxk8ali9mOaX5bl6sOmVjr6Zzu2qUFtQCa1vomddynFMpAf99an41roI1avhVZbI/lEvCXEqgIkx99tF+KlVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710757445; c=relaxed/simple;
	bh=hNpLFt8GxecUESbc49ly/PcpGkpFphO8cqf5mABNGZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RrCVQsH8WbVgPCUoPJ4e2ggSmqY+WSHIKH9Vn64PWGXZTOi5bXGSs1Y6wQorjcf5tpcmHUWxAS4n4+T12ynhP2Q1s28dpCU/hDp1Qw3eDLYrMMEkm79ZNPmMsj3IhCWQIZyJkAbGQNXAP3MRGxXBF1fQV1M9Igd42wcq5HvER8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=RnV6nsUU; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710757442;
	bh=hNpLFt8GxecUESbc49ly/PcpGkpFphO8cqf5mABNGZs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RnV6nsUUsgKCxPjetCnisWhXn2lFSsvUwOwxOrlEwSfdm63DKXmi5na1L2dZKwjRq
	 MlpIIFOoPhskrLCPSn0dYXqlU9j53luKhKUfcw9OMrflAiAwbjHMoIT7o1QH066wCz
	 77VWLDsPDMqJwZ3uoIpwhQ0j9kUGFEL7DXp/k5U8QcjFGKCwIE6KYPQ41HooT96Ypy
	 ymdTq8PmFp/qhh6XJNxv6tppHgEWmAdK6Q/GT29Bb+d8SHFMkf6Q+17VgEbTzygD1T
	 DtS6hSYa10XHHrFfLJUykgswjHc8569GFs96dXHqUJg06tQI8bHa9YKuuUvkvHGZRO
	 39sokNIQvI6wA==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id BDCCD378205B;
	Mon, 18 Mar 2024 10:24:01 +0000 (UTC)
Message-ID: <847e1c25-d28c-4616-88fb-b1d3d8f60f7b@collabora.com>
Date: Mon, 18 Mar 2024 11:24:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/4] arm64: dts: mediatek: mt7622: fix clock
 controllers
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Sean Wang <sean.wang@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
 "David S . Miller" <davem@davemloft.net>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>
References: <20240317221050.18595-1-zajec5@gmail.com>
 <20240317221050.18595-2-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240317221050.18595-2-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 17/03/24 23:10, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> 1. Drop unneeded "syscon"s (bindings were updated recently)
> 2. Use "clock-controller" in nodenames
> 3. Add missing "#clock-cells"
> 
> Fixes: d7167881e03e ("arm64: dts: mt7622: add clock controller device nodes")
> Fixes: e9b65ecb7c30 ("arm64: dts: mediatek: mt7622: introduce nodes for Wireless Ethernet Dispatch")
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



