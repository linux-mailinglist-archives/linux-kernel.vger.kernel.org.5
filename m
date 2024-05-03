Return-Path: <linux-kernel+bounces-168249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4769B8BB5AC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 23:26:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B57C41F24E5F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 21:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FD65914C;
	Fri,  3 May 2024 21:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GA8T0yTS"
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B291556457;
	Fri,  3 May 2024 21:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714771495; cv=none; b=sp8ErR6Q8jTOhMkyp5KBs0T3PJE3r4L8TupffB1Int0MTce9JRPyMoh3uGv/UbepoNbhyoll4IJHitYVTKzYRezVSltz7pCOLl1CPtLfLYbFIriqNKGrz24pxGuwrnyNZ8tmABhaboHqXy+lAIJKLCWVY6P2U52IX7t6+rq8k8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714771495; c=relaxed/simple;
	bh=LK3mL8JXOj0CEgZW6fEFEYPgmRm5K3A9R/yAs3xebvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SWVjBe4maDcj5qRiscBUKDFfgxA06kThE4cnRgo24g3UamVx/Pg5WwAomGE2qaw7nqe6tv2WUIho3vWywVyTPh/m6kiCXHHeDbcmubcBzqgPUfXfWqTz0VtDYqD6bFeskvjkg985evZvWGUdyMXzj/npqbWCQ1q0946AN5O/258=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GA8T0yTS; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-36c7ee71ebaso651535ab.2;
        Fri, 03 May 2024 14:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714771493; x=1715376293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=09tL1tpGLeljRIz0iUl6+EJExqbQDzFCA40DqLY+JpA=;
        b=GA8T0yTSVtxmhtsdaop/ys4ZIZaqkmw28W6ezP6WaAQHk8XquNKNHA2BpLEdVqFiyA
         YX4ympOKZAvp6RVuBAO/jm+hAykDw6/ASnzcLuPYlMH0366qeSB/Gf499hSO5O6NvosX
         hNes2zaakOVZIpDRgSeiMuA0tkIH3h8rsGYg9O9bNj8xcAsOKoe4W2zBQoKfn71n/PdA
         Nl6WLkxyOhUkj2cWEauTR06xdfLtbc/V2Sg4GVbVnrUrg3uErOyCgdNXxHo7Xq5z/qwx
         ooXSNLm7uS/mRbJ0aEvKOzHEF2dEatXlbuNFt4QqAyk5rEjXppJHDb1imrh4zsBe/PLH
         q/0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714771493; x=1715376293;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=09tL1tpGLeljRIz0iUl6+EJExqbQDzFCA40DqLY+JpA=;
        b=rH9iZdcfly4pDQrE2AeSKiSzPy4FmR4YirzJMk7R4arJPT5+LncWMbeDspPVB+dGVE
         teb/E3jqHFEgsFfsQz/TjDPy66getUmNN6+ZIZesgMqg37qiJBXJDv0mwzQIcPuYjbhV
         BtjhHSgkwtwKCUlawf+N6VGv0CWSYCcgxB89farRCdgH3Iae+S1YaSMZGwsS72RFKTfg
         9QPFOAKr9Yk5ixLw8rEQKzrQjwl5mhSdV6UaDXdnXb8512UfOmVoC76d8vaC6NADfuNX
         4sHTruTJMem79p2+bMVUQIXXrPAHm2OGg38yEASSq2HOrRaZ9jBLXUQUrNUPIUVTNUsT
         SnSA==
X-Forwarded-Encrypted: i=1; AJvYcCVjBt0JH1BHq9QNvAEoYMN+4FdCA3WCLlcaA7La0OmITRUhesXmP4SvsYrSxmCHfkGHKMSaqJEAfd1Gq+qVA5kD1pdVpbBr1lPh0ohHB+yDa0lcYPJpVxBWtuAoyfjvPFB7Pe/V+KNaCOOohporneSCoWW2dgkte27UxjUFsCtp85/nNq8=
X-Gm-Message-State: AOJu0YyVtfcQiGmv+AXK6aHvQN+NuyTB6aq5Npn9KxpD1xOT4nOkMVQn
	yD12UM1aBORTqz9caTSwf+48+Y/9aFhtpNiBUuSZ/R6zjQWlU7jX
X-Google-Smtp-Source: AGHT+IGRdJzMTUY42MWex2gSyT566Rqoi0b7dUAnOb0YdzSx5y3fOPtOuK8wPDh8u18jnrYCVNb6JA==
X-Received: by 2002:a05:6e02:13ad:b0:36b:2e91:efc0 with SMTP id h13-20020a056e0213ad00b0036b2e91efc0mr4651799ilo.23.1714771492640;
        Fri, 03 May 2024 14:24:52 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id bq18-20020a056a02045200b0061c16070b32sm1971108pgb.90.2024.05.03.14.24.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 14:24:51 -0700 (PDT)
Message-ID: <6ca4f556-28ea-4f51-a8dc-a10a94d726f0@gmail.com>
Date: Fri, 3 May 2024 14:24:49 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] mips: bmips: setup: make CBR address configurable
To: Christian Marangi <ansuelsmth@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Hauke Mehrtens <hauke@hauke-m.de>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <zajec5@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 =?UTF-8?Q?=C3=81lvaro_Fern=C3=A1ndez_Rojas?= <noltari@gmail.com>,
 linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Daniel_Gonz=C3=A1lez_Cabanelas?=
 <dgcbueu@gmail.com>
References: <20240503135455.966-1-ansuelsmth@gmail.com>
 <20240503135455.966-5-ansuelsmth@gmail.com>
 <bf20e911-26db-4291-95d4-c91cc1d7f000@broadcom.com>
 <66353c92.050a0220.fd42f.7cfb@mx.google.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <66353c92.050a0220.fd42f.7cfb@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/3/24 12:35, Christian Marangi wrote:
> On Fri, May 03, 2024 at 12:09:02PM -0700, Florian Fainelli wrote:
>> On 5/3/24 06:54, Christian Marangi wrote:
>>> Add support to provide CBR address from DT to handle broken
>>> SoC/Bootloader that doesn't correctly init it. This permits to use the
>>> RAC flush even in these condition.
>>>
>>> To provide a CBR address from DT, the property "mips-cbr-reg" needs to
>>> be set in the "cpus" node. On DT init, this property presence will be
>>> checked and will set the bmips_cbr_addr value accordingly. Also
>>> bmips_rac_flush_disable will be set to false as RAC flush can be
>>> correctly supported.
>>>
>>> The CBR address from DT will be applied only if the CBR address from the
>>> registers is 0, if the CBR address from the registers is not 0 and
>>> is not equal to the one set in DT (if provided) a WARN is printed.
>>>
>>> To ALWAYS overwrite the CBR address the additional property
>>> "mips-broken-cbr-reg" needs to be set.
>>>
>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>> ---
>>>    arch/mips/bmips/setup.c | 30 +++++++++++++++++++++++++++---
>>>    1 file changed, 27 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
>>> index 18561d426f89..bef84677248e 100644
>>> --- a/arch/mips/bmips/setup.c
>>> +++ b/arch/mips/bmips/setup.c
>>> @@ -34,7 +34,11 @@
>>>    #define REG_BCM6328_OTP		((void __iomem *)CKSEG1ADDR(0x1000062c))
>>>    #define BCM6328_TP1_DISABLED	BIT(9)
>>> -/* CBR addr doesn't change and we can cache it */
>>> +/*
>>> + * CBR addr doesn't change and we can cache it.
>>> + * For broken SoC/Bootloader CBR addr might also be provided via DT
>>> + * with "mips-cbr-reg" in the "cpus" node.
>>> + */
>>>    void __iomem *bmips_cbr_addr;
>>>    extern bool bmips_rac_flush_disable;
>>> @@ -212,8 +216,28 @@ void __init device_tree_init(void)
>>>    	/* Disable SMP boot unless both CPUs are listed in DT and !disabled */
>>>    	np = of_find_node_by_name(NULL, "cpus");
>>> -	if (np && of_get_available_child_count(np) <= 1)
>>> -		bmips_smp_enabled = 0;
>>> +	if (np) {
>>
>> Please reduce the indentation with early return/gotos. There might also be a
>> need to do some validation that the CBR is at least outside of the DRAM
>> window, that is we cannot blindly trust the DT to have gotten the CBR right
>> IMHO.
> 
> Do you have any hint on how to do the check if we are outside DRAM?
> 

I was going to suggest the use of memblock_start_of_DRAM() and 
memblock_end_of_DRAM() but before I sent that out your v2 already had it!
-- 
Florian


