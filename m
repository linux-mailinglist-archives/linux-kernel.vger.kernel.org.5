Return-Path: <linux-kernel+bounces-148144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D14AC8A7E49
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:31:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EA83283CD7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35ED0126F3D;
	Wed, 17 Apr 2024 08:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PEot3oHS"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325F2139F;
	Wed, 17 Apr 2024 08:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713342660; cv=none; b=StrP4qdmr0mUoEtNkwnD1E816MuWGJTk7tMZXWafnT1Nf1sERuLydg0NelEIGgUczhpGDjgSdJCDrnLok7FTCbi8qXsKXlkA/xJpzis4O7eku5vKEv7TpKxsMm6GaPnXsRcdwgGSa+muI3BYPDp0fjzDX7j8tUstPmUcCQMjICE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713342660; c=relaxed/simple;
	bh=hAKoZHGRwe5oOR+gYjYRmI7U+/iTL7eq3fs9/Xu1aqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c6xoi2AvzPNASF4LTK8ofusFUUS8iA1E7KxsHfrol2HAgnBDwVZHeLRUV8WMaoXx6sdZQ6DpCE1Y3sd/pNNxACJJ+EMB1ScR2R7YindPWqzZ7eg60s6qu5x26TlzRZcD/eQwc024dPkjZctpuC/D1cMtVlj9xEl0XlhPlpFQUH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PEot3oHS; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1713342657;
	bh=hAKoZHGRwe5oOR+gYjYRmI7U+/iTL7eq3fs9/Xu1aqU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PEot3oHSw4wT5loY0dZpFv8eiXYny753dDhAVZKZBGyksPkHRuacYII0BK9ALD0dD
	 DebbtnNXmKla5szZK45nxT4sWD+rEyD4i59/JWeB6LEm+tMmwFCDN8U+WBdE5u2ucG
	 mQ5JTOJc2nZ3tbCbv3AZiLwhUvnXVy5YGB8PDm8dkiPy/CdsiWReM+8GjXTcMMw+Dq
	 oETXqmldu52IL/9sXB0/+QjrP3ZevN8A75ItxzP47rmkYzKdxuaTDyKlom+s0jpeI/
	 FuzSDf9TYqz+dVDbKulHemdsjmr9wnMrrGxqDA55pPMnlEO2vEWYEvbLpHp+qemspe
	 pfNE+h722qR9A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 713E537820F9;
	Wed, 17 Apr 2024 08:30:56 +0000 (UTC)
Message-ID: <f8cd2b23-f5e0-4692-a149-3ec98adb94b8@collabora.com>
Date: Wed, 17 Apr 2024 10:30:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 5/6] regulator: mtk-dvfsrc-regulator: Refactor and add
 MT8192/MT8195 vregs
To: Mark Brown <broonie@kernel.org>
Cc: djakov@kernel.org, robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com, lgirdwood@gmail.com,
 keescook@chromium.org, gustavoars@kernel.org, henryc.chen@mediatek.com,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel@collabora.com,
 wenst@chromium.org, amergnat@baylibre.com
References: <20240416153805.431118-1-angelogioacchino.delregno@collabora.com>
 <20240416153805.431118-6-angelogioacchino.delregno@collabora.com>
 <Zh8dWdE8V8-GhNlF@finisterre.sirena.org.uk>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <Zh8dWdE8V8-GhNlF@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/04/24 02:52, Mark Brown ha scritto:
> On Tue, Apr 16, 2024 at 05:38:04PM +0200, AngeloGioacchino Del Regno wrote:
>> This driver never worked, and never got even compiled, because it was
>> missing the DVFSRC driver entirely, including headers it relies on!
>>
>> Perform a full (or nearly full) refactoring of the MediaTek DVFSRC
>> controlled Regulators driver: this retains support for the MT6873,
>> MT8183 and MT8192 SoCs, and adds MT8195.
>>
>> As part of the refactoring, this driver is now probed using its own
>> devicetree compatible, as this is a child of the main DVFSRC driver
>> and gets probed as a subnode of that.
> 
> Given what you're doing this would probably be easier to review as
> two commits, one removing the existing driver and another adding the new
> code.

Yeah, definitely.... I'll do that for v2.

Cheers,
Angelo

