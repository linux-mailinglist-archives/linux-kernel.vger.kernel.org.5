Return-Path: <linux-kernel+bounces-71015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C9E859F6C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 365B01F21947
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8153C22F17;
	Mon, 19 Feb 2024 09:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="PAH4lnRs"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E72922EF7;
	Mon, 19 Feb 2024 09:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334230; cv=none; b=ORGD14GIitiS0hoTfY2fHBCWQiNXl/E1P/bdJOeCr4i+3PWy0+U8lP8hYZepOsY/m+0lb/aUoZA8cI8z4iwQ0cYpv47S/5ORS8KBoqAAqDVyH1sOq82kEYuSLYvsUe+R81+Mt0mo2uZ2CUUvn2rfibMbOX8NzocI/52shOzi9Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334230; c=relaxed/simple;
	bh=ChNaRha/WMNDl/yhYHIi8rH1Wcspnu1Kp9xRdQK9PnE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RTwIaeg1ZuqRiYpEGAnWFt01ZmcVSloScjlfLbL35lAVkMw9vAAQzkATFuucUnf6nCLa0YAWEOiPM7kiphDd3dLz4qBrbgLwZvzZRIktp5KkGOc5EA0eZNWUWUhVV4jK8D01l8Oz65wrdF43FCi01vsB8/5zppoFX50orMlOko4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=PAH4lnRs; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1708334227;
	bh=ChNaRha/WMNDl/yhYHIi8rH1Wcspnu1Kp9xRdQK9PnE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PAH4lnRsy3dA4rL5zx3OMxfWsSZz36xjHm3UoX5n4YLT5Rb7S9OT1CO1/lVmZDbWS
	 H9Zys0ZlNoW8AKV69si846A+9hb+flVD60pEYD0DL92rCB7M1oUiAgj2nNl2xPp7yu
	 TgViIjHbMifRXMT6Qy0YMTjnRoG5QYGnjukFLOUUrjtjv+nKf5HtcwDu/ynoLWZAO2
	 epOX8xAZ11H9rddcZpkpa2abnfDinrLpANA1CojDcF/fzUfUh0DosP6ifbrwrYGvr/
	 /GgND1BAh8pnY4EHEw/rz9GJy0o25oOkwRASPzrjTLUH0IOYbBXiRNK5CbF7a/CD+T
	 CciKoshaVPPmQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id ACDFE37820C0;
	Mon, 19 Feb 2024 09:17:06 +0000 (UTC)
Message-ID: <2795a056-eac2-491b-bcb5-52bf4a331c07@collabora.com>
Date: Mon, 19 Feb 2024 10:17:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: {mt7622,mt7986}: add port@5 as CPU port
To: =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>
Cc: Frank Wunderlich <frank-w@public-files.de>, mithat.guner@xeront.com,
 erkin.bozoglu@xeront.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
References: <20230918074938.79796-1-arinc.unal@arinc9.com>
 <5d582382-9a31-4a95-bc81-01d99dde0a6e@arinc9.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <5d582382-9a31-4a95-bc81-01d99dde0a6e@arinc9.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 18/02/24 11:52, Arınç ÜNAL ha scritto:
> Matthias, please apply this patch.
> 
> Arınç

Please split this by SoC and resend as two patches.

If you can resend fast enough, I can apply the patches for 6.9.

Cheers,
Angelo

