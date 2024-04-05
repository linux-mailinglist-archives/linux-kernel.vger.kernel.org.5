Return-Path: <linux-kernel+bounces-132591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDE08996F2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 09:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0619B245C9
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 07:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE683140363;
	Fri,  5 Apr 2024 07:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="SM5Mzf1l"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7480213FD95;
	Fri,  5 Apr 2024 07:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712303443; cv=none; b=knuwAKX+9v0bSz73DYAbLOuC1H2ddvgdOVeAERZCv+vsCjqJk2d/MM70h30C8x9zGxG2xfuqRpZd7utgTFe1uqMY2NPtTGbHyY/2C9cXsBMyQYlWo+EAO8Otp6gpibRyL4u6GG1z6awxrV6xl5B+JgrKF7SxcG8rMsDSWJ7sbKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712303443; c=relaxed/simple;
	bh=H7kK29oj+wvc5c9f238ZbY+t3yjQC9CUKnWWHNbYtnI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SDCNm6FCDLM+eqJSDilDpzBEuRKMNmR4JZqH+SkBANbNwf3OqhLOXtovmqMJZe4gLnNxJXtx22Igdv7JV9eSet0aYmPph2b5uGh4c2GTWk8Ty0qqAArKzluKQ1ByLLuJezfa9JXR8b4lFGpzTh0XjjTHkXxQGvXHrnpdzhvdvW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=SM5Mzf1l; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1712303434;
	bh=H7kK29oj+wvc5c9f238ZbY+t3yjQC9CUKnWWHNbYtnI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SM5Mzf1lrfWXDFKW6B+MwigdEtMBo2c89S6Q6JJFnaDf+wEvggbX1uRrPnCRxPhON
	 4FHVSZ5msVYQMRy7mT9ax2PEza1WAbaWYuxbqeoIy36U0J11keRYrWlMaTU8D4cl2I
	 TNkMakzETyU0fAhHDeVvDiVTSeB1W3srvrt7dSoTbXeuzJpCt+fYwP2nIFF3YT64ma
	 0k9I4KA2vf/59YKtMprWHm1f3nZA0vM/oC94okIgPlt7STUByXmLGJowhgq7c+4Ke5
	 RpHkXeL/I/VIrqmlqqQaqIDJ/pZT/zG+6RUnKrVfYKWiiDR2K3YlGJviEpx8z8h9Fq
	 3vrGhgXyscjAg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4E4D7378212D;
	Fri,  5 Apr 2024 07:50:33 +0000 (UTC)
Message-ID: <fd030e38-aa3b-4bf7-8018-455ed83f5cc4@collabora.com>
Date: Fri, 5 Apr 2024 09:50:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: mediatek: mt2712: fix validation errors
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20240301074741.8362-1-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240301074741.8362-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 01/03/24 08:47, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> 1. Fixup infracfg clock controller binding
>     It also acts as reset controller so #reset-cells is required.
> 2. Use -pins suffix for pinctrl
> 
> This fixes:
> arch/arm64/boot/dts/mediatek/mt2712-evb.dtb: syscon@10001000: '#reset-cells' is a required property
>          from schema $id: http://devicetree.org/schemas/arm/mediatek/mediatek,infracfg.yaml#
> arch/arm64/boot/dts/mediatek/mt2712-evb.dtb: pinctrl@1000b000: 'eth_default', 'eth_sleep', 'usb0_iddig', 'usb1_iddig' do not match any of the regexes: 'pinctrl-[0-9]+', 'pins$'
>          from schema $id: http://devicetree.org/schemas/pinctrl/mediatek,mt65xx-pinctrl.yaml#
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


