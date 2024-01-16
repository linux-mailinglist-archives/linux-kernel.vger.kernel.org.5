Return-Path: <linux-kernel+bounces-27136-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A76D182EB00
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 09:42:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAD211C20E80
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 08:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C844712B70;
	Tue, 16 Jan 2024 08:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="YuvdH5mI"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E9A125D9;
	Tue, 16 Jan 2024 08:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1705394511;
	bh=3vm3djyuGxuOvKgs02bBxiarOCcIXQxbzAdbmeHHzfU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YuvdH5mINDH88ByNQQgmMqqavq2kD/OTj+hnIn/vhJ2hoY9kFAlVDpdHGyVAbufb9
	 TnN9ttDET06VwYH0F9MqEjRPM9xmRfBHjqRzfqbqBV17v+1Jx7OHqpNFoQNb1HdtyM
	 2WHGFrCycsT0IZSSXnsMMyWDm7q5pKG/eWBsPbL+ep2oAXCGDzPnidedHdidqABXCQ
	 p9BT/BRxDb7wzO7Z7ufOv4dmHvlUzQr5GavsubjYqejEjLbny2HOhKwlav6FdAIQ6j
	 VB9YHzoXZd9f7prbI0V/PeT0DywXtjLyPzJNarA58CtLhQ94TGUjwTXJnFvAF5n/fZ
	 jmYK1MXmbl/2g==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9B6183782009;
	Tue, 16 Jan 2024 08:41:50 +0000 (UTC)
Message-ID: <feb39d03-bc78-474e-b99c-d835a37dd36b@collabora.com>
Date: Tue, 16 Jan 2024 09:41:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/15] arm64: dts: mediatek: radxa-nio-12l: Enable System
 Companion Processor
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-mediatek@lists.infradead.org
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com, wenst@chromium.org,
 hsinyi@chromium.org, nfraprado@collabora.com, macpaul.lin@mediatek.com,
 sean.wang@mediatek.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kernel@collabora.com
References: <20240112094632.66310-1-angelogioacchino.delregno@collabora.com>
 <20240112094632.66310-10-angelogioacchino.delregno@collabora.com>
 <106b925b-93d7-4661-a561-424f426dd92a@linaro.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <106b925b-93d7-4661-a561-424f426dd92a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 16/01/24 09:18, Krzysztof Kozlowski ha scritto:
> On 12/01/2024 10:46, AngeloGioacchino Del Regno wrote:
>> The SCP is used by the SoC for various tasks, including initializing
>> hardware video encoding/decoding hardware and managing other remote
>> processors. Enable this node and assign its own DMA pool to it.
>>
> 
> Please provide reason why this cannot be included in initial submission
> and must be split into separate patch. I really do not understand except
> some patch count stats.
> 

This was done to describe both the reasons why each node was enabled at
which point and the actual workflow for the bringup with each commit.

I don't care about the stats.

I will squash some of those patches for v2, anyway.

Regards,
Angelo


