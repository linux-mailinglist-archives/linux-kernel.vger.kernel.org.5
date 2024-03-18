Return-Path: <linux-kernel+bounces-105998-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E2F87E749
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 11:25:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE7F11F22CAB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA47737702;
	Mon, 18 Mar 2024 10:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="xtuQVgaF"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B3D2E657;
	Mon, 18 Mar 2024 10:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710757443; cv=none; b=G8rOkjD2NFqBf24hDldFO3hREz0flu2Y3aRdEivfbJffmuxIUJhKvW3Ww4m9VSM6tZJLWf4fYWgbbdvAkc7S2COZJQFdUwFs6dB3+qQGcRV4qgjrSdUOa6bVzu5rCshzTc4zv0It6rUSQwOItOwk1gRZD5TWWDk1j/k/ygRiK98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710757443; c=relaxed/simple;
	bh=epH7fThYZdzezDriuik2qS8wOnir6pPihC9rc071D6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YeOG8hKwWGqzLR1cDBXdNd2uriBW4MkGpxFIQ+Oga52duuF5QsHMJa8GU1FsTrb8MzFpkS1CMUDSlR0fzCOLFbZ0p/NYIqfXBIJbkfMvo4SeK0ynmUmhC9JZkPwdkWVqyLDhx9927AHiLlmeJE+RQQ2adaCvDc2ruC5O0LpfNlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=xtuQVgaF; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710757439;
	bh=epH7fThYZdzezDriuik2qS8wOnir6pPihC9rc071D6A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=xtuQVgaFTToXo9a3kjdvcWIZa34cagLpTEoKZWxxwWK+7bXuQoyhLMuAGm/CDeOx5
	 kVqGD5Phr5/nOk0FXEzwYUYk/20/G0CNiuvbYGXwlYwr0l9QaO0LPGCjfEOzlNKPOp
	 8gnWGf0EjDK1sJNOj0BwjMwG/Q1ZXo32WTsEdOoKT2AwBoS0BUJ0KC0d0ifiNe9ARg
	 k5XQMBBx+zTJPm/f3ssNrSw6WkO2HKGR5bCpCoPer4YI0V9TewW0Gw5HoC9ECW1Fjs
	 mgnev1bb3pZtsXpsmmGTERF5LWaTQQGhD36j2SAmjab9bLoYl9F+MqiPgR8cvZlNqV
	 mqZA4OYA1tgPQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 22128378203E;
	Mon, 18 Mar 2024 10:23:59 +0000 (UTC)
Message-ID: <88f9c771-f42e-4345-8811-ed123a0f1fe7@collabora.com>
Date: Mon, 18 Mar 2024 11:23:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/4] arm64: dts: mediatek: mt7622: fix IR nodename
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
 <20240317221050.18595-3-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240317221050.18595-3-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 17/03/24 23:10, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Fix following validation error:
> arch/arm64/boot/dts/mediatek/mt7622-rfb1.dtb: cir@10009000: $nodename:0: 'cir@10009000' does not match '^ir(-receiver)?(@[a-f0-9]+)?$'
>          from schema $id: http://devicetree.org/schemas/media/mediatek,mt7622-cir.yaml#
> 
> Fixes: ae457b7679c4 ("arm64: dts: mt7622: add SoC and peripheral related device nodes")
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



