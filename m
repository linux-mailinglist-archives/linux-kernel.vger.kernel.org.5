Return-Path: <linux-kernel+bounces-74486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA47385D50F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:03:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6D152895B5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2EFF4C626;
	Wed, 21 Feb 2024 09:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="jaCxejWQ"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70623D569;
	Wed, 21 Feb 2024 09:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708509454; cv=none; b=Gc1OLiSbNeUYtsv4j/5VxoXBv5znA7lvqYbywIkSjcIlUQ3aXsnUccYQKnkWayq/OftI1d+2J5gS/0qJ5c4GhqilU9rd/gmElQWzc2Ra0XE1d1jHparoBnFgFhAF8nSgoN1vvATbm9DZhu2FW/mj3smgp13O9O0xQMXQxFhLYaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708509454; c=relaxed/simple;
	bh=CBRwI7HgCvtHtSggfcJjCRi/PajFPLcmhsfXJ/u7MmQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lfYhEObXxQKWuOiwK/xerPLXFxZY8HNAqE8VqCNCN9OxEx+82C94t/atBAbuRSdpoY/utuxOS57bPjYBsCGSA8JDyOeyNRwBOVYTS9BJg6RwmHf4I9zf8pVRrK40dqCDzVk99nSuCk8Wjs1PENBGqPs6NmFlC40VIH1+8kLS58I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=jaCxejWQ; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708509450;
	bh=CBRwI7HgCvtHtSggfcJjCRi/PajFPLcmhsfXJ/u7MmQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jaCxejWQxJfIe0hBE5Ipck3zFqSAN2f5oVJ5kE3mOF62mPU7gXwn/RTGIEcEXOjWo
	 3xQ7qtwotsYswBNxtIEQz9/7cULc+M4P9EKJwekfhJorFym4k0rWsCan01Z6biCSFT
	 fFcfZwZ9M5RFxdxJmZPrqkmGzKNJu1wKj/qF9nWWjpbJCcr+GsaxmaSs6lySkQrbNe
	 9RAJVu6PU2p5ONwG7qCgpWJFXLQvwIrf0ewX6Soki30P3Ef2fMKMUI4CUJQxehi1pL
	 oi4pGyhmH6fTvrjFl+w1CNObPh5uWVRTurW5OmBAHE26wwd//zfT38D3QDI2IDTj0Q
	 nfVfA1Ex8YDuw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 6E4CE37820C8;
	Wed, 21 Feb 2024 09:57:29 +0000 (UTC)
Message-ID: <8d80be8a-6ed4-48e3-b792-454e11b518c5@collabora.com>
Date: Wed, 21 Feb 2024 10:57:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] dt-bindings: arm64: dts: mediatek: Add Cudy WR3000 V1
 router
Content-Language: en-US
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Chen-Yu Tsai <wenst@chromium.org>, Hsin-Yi Wang <hsinyi@chromium.org>,
 =?UTF-8?Q?N=C3=ADcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 Heiko Stuebner <heiko.stuebner@cherry.de>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>,
 Linus Walleij <linus.walleij@linaro.org>, Sean Wang
 <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>
References: <20240221073524.20947-1-zajec5@gmail.com>
 <20240221073524.20947-3-zajec5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20240221073524.20947-3-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 21/02/24 08:35, Rafał Miłecki ha scritto:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> Cudy WR3000 V1 is an MT7981B (AKA Filogic 820) based wireless router.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



