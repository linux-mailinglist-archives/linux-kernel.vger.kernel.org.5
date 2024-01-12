Return-Path: <linux-kernel+bounces-25055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E40FB82C6FD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8E8F1C21D63
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 22:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9687A17736;
	Fri, 12 Jan 2024 22:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/Hd5SsC"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7D4171DC;
	Fri, 12 Jan 2024 22:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-78313f4d149so648486485a.1;
        Fri, 12 Jan 2024 14:08:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705097292; x=1705702092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L+7rof0WGlCw1G9RYMZg6Un65fjMjn71sH8lI9OCckg=;
        b=Z/Hd5SsC8hJoSqn1bBPk3BCewsKnbrtX4TLiG+sbOXGpqSGzxC2Y9LQlYqtHzNpLUS
         7+THXT53qF2TPtHx7ufqfmtjhzdxBIbiCvtVt2ileWjG2dhyLiBw4SuH7UZCYIyRZ/hF
         hEKF/VwSUaJVOsZ17EK+2bcr3wRs7+M1R8pbyrS+skXlEwHVMS9DgMy5KjS3fmLp65xU
         Tmkbm5z+Lw5aiECBJ2y0MtunSNiTMGyDBSOBsI6AZO4ifH14AEo/kf/vswCwSdS0iesh
         wPowlj1sxSv5rQk9r7tOopw7PTebAVhc4tQ6UJiUc1YDCpDq02DcdMNTRHhIdOKYdOTt
         J8PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705097292; x=1705702092;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L+7rof0WGlCw1G9RYMZg6Un65fjMjn71sH8lI9OCckg=;
        b=rN75zFfViFNf6tpZclYAcoYToadpMsPpkxMPRQxLVLcDyCcWYi5ZoA/93b64a3munO
         jHp0t9AbY14RnJja5RgNiynEsOH/v5I2BipRcUgL5yFQRBRp9LNHNE0UI28UJu0mODj4
         neXMnswO3F73biQTeTTrN280XuNU/D/wz5MTh28HwDN0m+DPc/bnmnmZTurfy1gz673Y
         SOdUUWxmheOhIicRj23VfiSD8xT0HC7hz2G4dqjb8f6BXqTMeKV6rwEjP28ddv+4Giog
         3Zh9tNWjYJHiLs+a4Y41VxPWUYxrxgVnRSG3jFyu/sLcX0lAUP1entYyVrX0xLkm9f75
         BhLg==
X-Gm-Message-State: AOJu0YzmIJw8e5bkWZStMuUFZJ9YECK8R4eNGyeUNBO2kynzngp3KaTw
	Wll3fibGkm9ntwaGututirU=
X-Google-Smtp-Source: AGHT+IFMWkakS3L4QJvpofeuSpyOj3jN5og4vYpEA7zXTSj2qfQO35AsSgQitanirAcz/0rgJsgdDg==
X-Received: by 2002:a37:e20d:0:b0:783:35c0:d912 with SMTP id g13-20020a37e20d000000b0078335c0d912mr2433654qki.107.1705097292268;
        Fri, 12 Jan 2024 14:08:12 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id cn3-20020a05622a248300b00429c8ae9b94sm1417880qtb.85.2024.01.12.14.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 14:08:11 -0800 (PST)
Message-ID: <e1a9f5cf-d935-4754-9e8c-d34fcae000ed@gmail.com>
Date: Fri, 12 Jan 2024 14:08:08 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ethernet: ravb: fix dma mapping failure handling
Content-Language: en-US
To: Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
 Denis Kirjanov <dkirjanov@suse.de>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240112050639.405784-1-nikita.yoush@cogentembedded.com>
 <64deebbd-93d0-47dc-835e-f719655e076c@suse.de>
 <804a4586-1909-44ee-a40c-d9cb615f75ad@cogentembedded.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <804a4586-1909-44ee-a40c-d9cb615f75ad@cogentembedded.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/12/24 01:04, Nikita Yushchenko wrote:
> 
> 
> 12.01.2024 14:56, Denis Kirjanov wrote:
>>
>>
>> On 1/12/24 08:06, Nikita Yushchenko wrote:
>>> dma_mapping_error() depends on getting full 64-bit dma_addr_t and does
>>> not work correctly if 32-bit value is passed instead.
>>>
>>> Fix handling of dma_map_single() failures on Rx ring entries:
>>> - do not store return value of dma_map_signle() in 32-bit variable,
>>> - do not use dma_mapping_error() against 32-bit descriptor field when
>>>    checking if unmap is needed, check for zero size instead.
>>
>> Hmm, something is wrong here since you're mixing DMA api and forced 
>> 32bit values.
>> if dma uses 32bit addresses then dma_addr_t need only be 32 bits wide
> 
> dma_addr_t is arch-wide type and it is 64bit on arm64

Correct, does not mean all of the bits will be used, nor that there is 
not an offset, see below.

> 
> Still, some devices use 32-bit dma addresses.
> Proper setting of dma masks and/of configuring iommu ensures that in no 
> error case, dma address fits into 32 bits.

Yes, because dma_addr_t must be sized to the maximum supportable DMA 
address in any given system, hence it is 64-bit for a 64-bit 
architecture. If someone had a system with 32-bit DMA addressing 
limitation, they could technically introduce a Kconfig option to narrow 
dma_addr_t, not that this should ever be done. Anyway, I digress.

> Still, in error case dma_map_single() returns ~((dma_addr_t)0) which 
> uses fill dma_addr_t width and gets corrupted if assigned to 32-bit 
> value, then later call to dma_mapping_error() does not recognize it. The 
> patch fixes exactly this issue.

Your patch is actually fine, but you might have to write a lot more 
about it to tell the reviewers that it is fine.

At the very least you should explain that in case of DMA mapping failure 
by ravb_rx_ring_format_gbeth() and ravb_rx_ring_format_rcar(), the 
dsecriptor's ds_cc field is written to 0 to denote a mapping failure.

Note that we will still write a dma_addr_t cookie that corresponds to an 
error, but this may be OK, because the hardware looks for a ds_cc != 0 
to determine whether to DMA the packet into memory or not.

Because of the convention established in ravb_rx_ring_format_gbeth() and 
ravb_rx_ring_format_rcar(), checking for ds_cc == 0 to denote a mapping 
error in ravb_rx_ring_free_gbeth() and ravb_rx_ring_free_rcar() is an 
acceptable way of checking for a valid mapping.

What is however not valid, is that again, we use desc->dptr and pass 
that to dma_unmap_single() which would expect the non-truncated 
dma_addr_t. Again, probably works by design, chance, whatever, but is 
not supposed to be done that way.

It looks like the hardware is limited to 32-bit of DMA addressing, and 
assumes that the dma_addr_t cookie is 0-indexed, which may very well be 
the case, even with 64-bit SoCs thanks to an IOMMU.

It would feel a lot more comfortable if there was an actual check on the 
upper 32-bits of dma_addr_t being zero, and issue a big fat warning in 
case they are not.

Thanks!
-- 
Florian


