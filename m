Return-Path: <linux-kernel+bounces-24444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9525282BCA2
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:04:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4262867BA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AB055786;
	Fri, 12 Jan 2024 09:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="J+QCA1+J"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD715675B
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 09:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2ccae380df2so67533721fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 01:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1705050261; x=1705655061; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FMOEBUTyrxAFteCOdbuePmYjjamQBShc/8fenoo2NDg=;
        b=J+QCA1+J4EIlik86ZsMQxwOCMJINQ3x7UWwiv2oNz9Mys+I0qE3JEPdzZ56W9Nhgle
         ejOZeqq5gR1SDyBJimpQKODwoTWvvU/WBzXY0LY0qkOnSJSrkbHpx3/KgKxQszlEADwB
         2364fw0E0ESQ27LrFnFR2wSoYE5LnlYAy2Mmh4kJpElCuFXbs87DmvRgXFPLRplNfJbZ
         V10AtQ/+hALNf3RNC+/JpDr9Z5jaDuaIXMurEQLXCD7H7jJHKMD5dFXXYY82XXLSjdil
         DNMMI81eTqvJ6vcVpBJBv89CaebJTyVnPbPZddCsTnXhRMpkLtPkn6jkao24UV/5VeVq
         W59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705050261; x=1705655061;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FMOEBUTyrxAFteCOdbuePmYjjamQBShc/8fenoo2NDg=;
        b=dd64aJUWq3y2JRrir/CzkNvbkVHa62Mb4yjBb651LY+OCdmbUPX4PWDOdETrNzhiOP
         huJSL1nDlzdTy0yW8AHomdwhqlu4cARbgAp+KBr9y0ykRE0yDSIapRvArMC1BOwJHr/A
         MMFEQuxvtfLO8nxxQKwyBsLTX6Zcpkrv9WE3ajk9eeupegWRklYO16k+yhNHLZ69JFBR
         5R3GpBS6851qYS4zGl0IsDXfQrmj+05vt3Id8jJNeebevs04RoA06tuqgV0v3encOkvB
         1Nuz4xbvh7QLWjn6jZb1OaWvjwQgyttTq66URaZi68aeR7mLhYPMKcGSQt06+JmtMM3n
         EP1g==
X-Gm-Message-State: AOJu0Yxl78haOLcnPafGExVMzqzNZl2eboOMd9kNJU7ubuCcBF9aj3ui
	7KbEJpxqN67mTcmNfCMGDF3I/MyUNm8tcQ==
X-Google-Smtp-Source: AGHT+IHdDV0zW9ct7lpVWRmoAkfRX62ksO05UlwuC1BnHaNkmnr0sx8vh+sbrHII1V73V2ewYYk8gA==
X-Received: by 2002:a2e:6e03:0:b0:2cd:8ce7:71e1 with SMTP id j3-20020a2e6e03000000b002cd8ce771e1mr483215ljc.4.1705050260789;
        Fri, 12 Jan 2024 01:04:20 -0800 (PST)
Received: from [192.168.0.104] ([91.231.66.25])
        by smtp.gmail.com with ESMTPSA id n26-20020a2e86da000000b002ccdb0a00bcsm403541ljj.54.2024.01.12.01.04.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 01:04:20 -0800 (PST)
Message-ID: <804a4586-1909-44ee-a40c-d9cb615f75ad@cogentembedded.com>
Date: Fri, 12 Jan 2024 15:04:17 +0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ethernet: ravb: fix dma mapping failure handling
Content-Language: en-US, ru-RU
To: Denis Kirjanov <dkirjanov@suse.de>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Sergey Shtylyov <s.shtylyov@omp.ru>,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Wolfram Sang <wsa+renesas@sang-engineering.com>,
 =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
 netdev@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240112050639.405784-1-nikita.yoush@cogentembedded.com>
 <64deebbd-93d0-47dc-835e-f719655e076c@suse.de>
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
In-Reply-To: <64deebbd-93d0-47dc-835e-f719655e076c@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



12.01.2024 14:56, Denis Kirjanov wrote:
> 
> 
> On 1/12/24 08:06, Nikita Yushchenko wrote:
>> dma_mapping_error() depends on getting full 64-bit dma_addr_t and does
>> not work correctly if 32-bit value is passed instead.
>>
>> Fix handling of dma_map_single() failures on Rx ring entries:
>> - do not store return value of dma_map_signle() in 32-bit variable,
>> - do not use dma_mapping_error() against 32-bit descriptor field when
>>    checking if unmap is needed, check for zero size instead.
> 
> Hmm, something is wrong here since you're mixing DMA api and forced 32bit values.
> if dma uses 32bit addresses then dma_addr_t need only be 32 bits wide

dma_addr_t is arch-wide type and it is 64bit on arm64

Still, some devices use 32-bit dma addresses.
Proper setting of dma masks and/of configuring iommu ensures that in no error case, dma address fits 
into 32 bits.
Still, in error case dma_map_single() returns ~((dma_addr_t)0) which uses fill dma_addr_t width and gets 
corrupted if assigned to 32-bit value, then later call to dma_mapping_error() does not recognize it. The 
patch fixes exactly this issue.


