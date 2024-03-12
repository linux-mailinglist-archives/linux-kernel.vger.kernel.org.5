Return-Path: <linux-kernel+bounces-100401-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE0B8796F3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 025D71F25FC6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDE17BB13;
	Tue, 12 Mar 2024 14:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="W0mq3kG8"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99395F4FA;
	Tue, 12 Mar 2024 14:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710255301; cv=none; b=W8M3pQLzwpz4Ff0+Dx9nZDeeK8eOxhXN2l026JoeMCNPHim/XrJGN2+2trzr5SblMAh+rTgoj7RD6QngjybZQ9DdYEH6u9DG3W07hEKrV9S/3oZE7KwX0O8tehAIf5c9qhQDZ9u4s//DGCn9WGuj2K2vP0kVE5hRkbdG+U+DdxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710255301; c=relaxed/simple;
	bh=PRWIirwilphIw4zcMNTt1c46izhHLa0/pjMpYw4ic/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dB5yCEJa9L3lKcDUuu2njYRhmbgbt1FDlNuRlFvbPlggVVE1VaD2UtUyQ6GX8JfhpGU4U7mW/bW1YFfRZCIM89VAzx014IMBtaU9RCAGq4XrI7P+VSquua9KS8ejnLOMF5Qa6xGHxcREfpWPKmH5vJSTaqnkBw5TMvLMmQ+Mtd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=W0mq3kG8; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710255297;
	bh=PRWIirwilphIw4zcMNTt1c46izhHLa0/pjMpYw4ic/o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W0mq3kG86LmhXg334vp1B8RhZDdbMeVpYdLAytnolcZyjPNfr2kXn9W5lEeixOCCK
	 0KmgcInRX8B+FH1LhTbg2EK9zAnwoD7fQt1o7szRtSJduS5tr418smUTWytNHSsx9c
	 A/8oELBaufMoRsGYc1EXP6BDAttBKUC6Y2dAy3f5JtztfuvHKt2VXujhe3zz2iynMN
	 y7SYzLBUDaM7HX7tmyEVt7ss7JCHiJFfChIBbyUG6hZTcEi7DWN1evdnztmYn2wV0j
	 EHH1e+uQBe13DRKMp537t6nk1gMuORiF+BfV/eAqHJxgQL/PllwTWlOh+cBvFWED4M
	 EPNrpYnulqzZw==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 197EA37811D4;
	Tue, 12 Mar 2024 14:54:56 +0000 (UTC)
Message-ID: <4572ff92-ca26-4e61-a756-b9456896faef@collabora.com>
Date: Tue, 12 Mar 2024 15:54:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/18] ASoC: codecs: mt6357: add MT6357 codec
Content-Language: en-US
To: Alexandre Mergnat <amergnat@baylibre.com>
Cc: Flora Fu <flora.fu@mediatek.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Mark Brown <broonie@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>, Will Deacon <will@kernel.org>,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 Nicolas Belin <nbelin@baylibre.com>
References: <20240226-audio-i350-v1-0-4fa1cea1667f@baylibre.com>
 <20240226-audio-i350-v1-12-4fa1cea1667f@baylibre.com>
 <1641a853-88cb-43a8-bb95-653f5329a682@collabora.com>
 <253b4b6c-d8ba-40a3-adbb-4455af57d780@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
In-Reply-To: <253b4b6c-d8ba-40a3-adbb-4455af57d780@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 12/03/24 15:50, Alexandre Mergnat ha scritto:
> 
> 
> On 26/02/2024 16:25, AngeloGioacchino Del Regno wrote:
>>> +    if (enable) {
>>> +        /* set gpio mosi mode */
>>> +        regmap_write(priv->regmap, MT6357_GPIO_MODE2_CLR, GPIO_MODE2_CLEAR_ALL);
>>> +        regmap_write(priv->regmap, MT6357_GPIO_MODE2_SET, 
>>> GPIO8_MODE_SET_AUD_CLK_MOSI |
>>> +                                  GPIO9_MODE_SET_AUD_DAT_MOSI0 |
>>> +                                  GPIO10_MODE_SET_AUD_DAT_MOSI1 |
>>> +                                  GPIO11_MODE_SET_AUD_SYNC_MOSI);
>>
>> Are you sure that you need to write to MODE2_SET *and* to MODE2?!
> 
> This is downstream code and these registers aren't in my documentation.
> I've removed the MODE2_SET write and test the audio: it's still working.
> 
> So I will keep the spurious write removed for v2. :)
> 

Usually, MediaTek registers are laid out like "REG" being R/legacy-W and
"REG_SET/CLR" for setting and clearing bits in "REG" internally, and that
might account for internal latencies and such.

Can you please try to remove the MODE2 write instead of the MODE2_SET one
and check if that works?

You're already using the SETCLR way when manipulating registers in here,
so I would confidently expect that to work.

Cheers,
Angelo

