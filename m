Return-Path: <linux-kernel+bounces-80739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A8B866BE5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 09:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8B5283A07
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 08:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DF21C6A6;
	Mon, 26 Feb 2024 08:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xen0n.name header.i=@xen0n.name header.b="v5/yDgLn"
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6316D1C292;
	Mon, 26 Feb 2024 08:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.28.160.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708935348; cv=none; b=bVxP8VmN2ayOz20cJRKATgJME9Lg3/GyEj2Jqiqp/g1wsZXaclMuLDSv7OM6ZVsEkuA+hpxiWvVfDv293CeVCaPZ86Wd8yYhAAIBq3gFEcuHp1DHdvdEOXbAfv94Ru6Pt/oBH6X1lMxGxtFUT0wdsyj+9XWPinyZfEtLmfPAirg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708935348; c=relaxed/simple;
	bh=gOnZYDgEPaUyxmyyfWi9fPSzeqDFwFnfKgtLfSpD0mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TQE8cGj1YMbMoPjRFOzVqFPzIBYz8ogI2ANIpWgEMGNM0IXp4zf1+UJnKED5WhzjkcBF+jrOtNl/6StGd0idIyC8nI0TxMds+fdZks6eZ4aa4HPQrFJsE1VUvLEWwa0lGxiAPHNoq9SXlMqBqiBg3vGXLM3X/5Aa3vzjEMnG2dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen0n.name; spf=pass smtp.mailfrom=xen0n.name; dkim=pass (1024-bit key) header.d=xen0n.name header.i=@xen0n.name header.b=v5/yDgLn; arc=none smtp.client-ip=115.28.160.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xen0n.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xen0n.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
	t=1708935343; bh=gOnZYDgEPaUyxmyyfWi9fPSzeqDFwFnfKgtLfSpD0mg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=v5/yDgLnrAHr7z3v+SEOCCq/Lkm8yMusJ7UjwWPqzRvsFklNr6hu3irxieAkc0hmA
	 OhAR2Gcwnki740xd5qLyXPGA0kcZu2z0TqVXwq6JRseFZH0phG7eZvZcIXgAsqqC0K
	 7lFn2Wj2Vk7goqpcYu5B+YdUQwx9Z/yePRboBIKo=
Received: from [28.0.0.1] (unknown [101.230.251.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by mailbox.box.xen0n.name (Postfix) with ESMTPSA id 9EE916006F;
	Mon, 26 Feb 2024 16:15:43 +0800 (CST)
Message-ID: <48afa638-9145-40ee-9868-fa82a1fce271@xen0n.name>
Date: Mon, 26 Feb 2024 16:15:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] loongarch/crypto: Clean up useless assignment operations
Content-Language: en-US
To: WangYuli <wangyuli@uniontech.com>, herbert@gondor.apana.org.au,
 davem@davemloft.net, chenhuacai@kernel.org
Cc: linux-crypto@vger.kernel.org, loongarch@lists.linux.dev,
 linux-kernel@vger.kernel.org, Guan Wentao <guanwentao@uniontech.com>
References: <20240226080328.334021-1-wangyuli@uniontech.com>
From: WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <20240226080328.334021-1-wangyuli@uniontech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/26/24 16:03, WangYuli wrote:
> Both crc32 and crc32c hw accelerated funcs will calculate the
> remaining len. Those codes are derived from
> arch/mips/crypto/crc32-mips.c and "len -= sizeof(u32)" is not
> necessary for 64-bit CPUs.
> 
> Removing it can make context code style more unified and improve
> code readability.
> 
> Suggested-by: Guan Wentao <guanwentao@uniontech.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---
>   arch/loongarch/crypto/crc32-loongarch.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/arch/loongarch/crypto/crc32-loongarch.c b/arch/loongarch/crypto/crc32-loongarch.c
> index a49e507af38c..3eebea3a7b47 100644
> --- a/arch/loongarch/crypto/crc32-loongarch.c
> +++ b/arch/loongarch/crypto/crc32-loongarch.c
> @@ -44,7 +44,6 @@ static u32 crc32_loongarch_hw(u32 crc_, const u8 *p, unsigned int len)
>   
>   		CRC32(crc, value, w);
>   		p += sizeof(u32);
> -		len -= sizeof(u32);
>   	}
>   
>   	if (len & sizeof(u16)) {
> @@ -80,7 +79,6 @@ static u32 crc32c_loongarch_hw(u32 crc_, const u8 *p, unsigned int len)
>   
>   		CRC32C(crc, value, w);
>   		p += sizeof(u32);
> -		len -= sizeof(u32);
>   	}
>   
>   	if (len & sizeof(u16)) {

Sure, but IIRC Loongson still has hopes in having 32-bit-only models 
support upstream? The possibility cannot be ruled out because from 
public information (e.g. the 2023-11-28 news event), Loongson is known 
to be actively licensing their reduced 32-bit-only IP cores to third 
parties.

Ultimately whether we want to imply 64-bit operation with the crc32 
module is up to Loongson to decide, and I think Huacai may have 
something to add, but IMO at least we could gate the statement with 
#ifdef's so we don't outright lose 32-bit compatibility with this code.

-- 
WANG "xen0n" Xuerui

Linux/LoongArch mailing list: https://lore.kernel.org/loongarch/


