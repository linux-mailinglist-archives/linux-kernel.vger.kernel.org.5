Return-Path: <linux-kernel+bounces-103850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A17F187C5B6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 00:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B00C1C214D1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 23:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACC7FC15;
	Thu, 14 Mar 2024 23:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ka0FeXO5"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBC210949;
	Thu, 14 Mar 2024 23:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710457344; cv=none; b=fBagls9wpeJjL1jJaU203A4me+B8aQIqjovI0pZL1zgrycijAaWL9HiKNlmkNYt44ITVnsiaidEZ6XBK+tYh3W8DlaCQ4dXJChLia0NSq5ArcCXImQy0hCx6wwIY4o0l5APQZB68ylKLeu3fvk1VxN8oe96qw8643aN+Dfj5cn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710457344; c=relaxed/simple;
	bh=0rp7RDhW81aCgk764t/PVDgO8Xn3E3e57qBdErzb8do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JHw6Ptu21862uFRWGzPnqB3ck20aaExI2wmO4II/TA/Gv+rFq4qqMZkwUkOVQ38Vrt4gYkY4Kmz4FBLFR/HaPkK3eCVhQDjIFLGcRVoGhEcASK94/O07iDbeoeqR54PK1NRa9YLyCrkIt0BRbpn8MVhs/rY7LWi9rr4xoJxYBTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ka0FeXO5; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-690d7a8f904so21489986d6.1;
        Thu, 14 Mar 2024 16:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710457341; x=1711062141; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2vTaB+3nXPkQbpP8KjsP8gIf1ZGCsjZmDvyUllaXpP8=;
        b=Ka0FeXO59/aXt8jCIFhLH/EhF/wlvaa2YDx4or1seceG2GIEhushygOXsb7+bJuYsl
         ARntR+xk6V/nJZqg7egLQwT1oH/ZZvyRb1eM5IA+ZR6AGK8cRZVVAaY0e/iC47mayg/2
         rcmVhQ1KJmkqafcN+eW9JkACex1+QTXHqVhWY7ifv3zlzvDd1rry7LdyFdZ/RYuiLAec
         6On2YEjkuJDwhZjjQTmjAhMSl3ETmkjWUYobysaZd6b1hc1M40LGCZSmurU4TONb6yd+
         Jf6TC4npP3Kf7mAykx1SeQyQX0DKTW735mqcMUmj5gyRUq0NtvdZ9qCXKd864hX//BRC
         lJcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710457341; x=1711062141;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2vTaB+3nXPkQbpP8KjsP8gIf1ZGCsjZmDvyUllaXpP8=;
        b=MqYFgfkmk2+z3UxJKQVKWgsbSSuJqrRsK8f9neMsr9GrMGAmTmIU0Xu4ul48Qt3n8C
         quhiZLh18FjnuGrQumjQWHS6ihpkbJDlYUa2KB4yg8WBqICvC2/JhU0/P+RW5WsXAOT7
         pJ+famazCSoT/2bJ9VO0B2wsK79GBS7c7yxTEtrlNdY1f0IbybeJsdJ4JNbP+6oinNNy
         +GC0yLlMtgoNnT6eoq/sNCahC6DRJfU5drWzEUb98hufy4ZQKutBA++CzA9qR0aE17Cz
         GW58057gylFDVg5HZyL0KSjhrs6e+REq4jNKTNzH1aRiFupvVgpNzPbUWDB07XFfEZeC
         BdSg==
X-Forwarded-Encrypted: i=1; AJvYcCXUH6kMzKJEes0ncEk7oAqokg3GOqqkAjwZXUj6EjhT+IW34623503EP6RRzyRZuoPSNE51aERjvAe8JBWlKMM4cix7zuFMkM87Mf0LdxoA3L+7QVMVhFioHoKB/D7A4JZ7mLIQ7Hmldw==
X-Gm-Message-State: AOJu0YxpMfY2KDmNLH8Ot83e5o5oKDnLHROzjaGODd8+t69OIzlukfkP
	Jf2zeuzG6ZOXmiBfJ4XQnGYF/AO05J81qlFTr+P2Rt/Q0k43voXg
X-Google-Smtp-Source: AGHT+IH6Ayv2Q+7NsVrU8mVfqofnEIVHBT8AiarIiX0b2aAL3TdeYXbbOC0jmCpuURTOnqc4RT3LLA==
X-Received: by 2002:ad4:4b28:0:b0:690:e164:31e0 with SMTP id s8-20020ad44b28000000b00690e16431e0mr5281385qvw.25.1710457341368;
        Thu, 14 Mar 2024 16:02:21 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id jm14-20020ad45ece000000b00690c5cc0ff6sm1074393qvb.124.2024.03.14.16.02.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 16:02:19 -0700 (PDT)
Message-ID: <d3c66783-b71f-431f-9028-45897f12f2a0@gmail.com>
Date: Thu, 14 Mar 2024 16:02:15 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/13] mtd: rawnand: brcmnand: driver and doc updates
Content-Language: en-US
To: Miquel Raynal <miquel.raynal@bootlin.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>
Cc: William Zhang <william.zhang@broadcom.com>,
 Linux MTD List <linux-mtd@lists.infradead.org>,
 Linux ARM List <linux-arm-kernel@lists.infradead.org>,
 Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
 kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
 anand.gore@broadcom.com, dregan@mail.com, kamal.dasu@broadcom.com,
 tomer.yacoby@broadcom.com, dan.beygelman@broadcom.com,
 Andre Przywara <andre.przywara@arm.com>, Rob Herring <robh+dt@kernel.org>,
 Kamal Dasu <kdasu.kdev@gmail.com>, Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
 David Regan <dregan@broadcom.com>, devicetree@vger.kernel.org,
 Alexandre TORGUE <alexandre.torgue@st.com>,
 Vignesh Raghavendra <vigneshr@ti.com>,
 Brian Norris <computersforpeace@gmail.com>, Shawn Guo <shawnguo@kernel.org>,
 linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>
References: <20240223034758.13753-1-william.zhang@broadcom.com>
 <90ecf4d2-0eee-48e6-8222-7d3b5fd52b2f@broadcom.com>
 <20240229101101.5208195c@xps-13> <20240314230402.5fc7bbf3@xps-13>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20240314230402.5fc7bbf3@xps-13>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/14/24 15:04, Miquel Raynal wrote:
> Hi Florian,
> 
> miquel.raynal@bootlin.com wrote on Thu, 29 Feb 2024 10:11:01 +0100:
> 
>> Hi Florian,
>>
>> florian.fainelli@broadcom.com wrote on Mon, 26 Feb 2024 09:36:02 -0800:
>>
>>> On 2/22/24 19:47, William Zhang wrote:
>>>> This patch series is an update from the previous version [1] after
>>>> exex_op support and fixes (patch 1 to 4 from the previous version.)
>>>>
>>>> It updates all the BCMBCA SoC to support the nand controller and add
>>>> functions to handle BCMBCA specific needs on ECC and Write Protection
>>>> usage. The device tree document is also updated accordingly with the new
>>>> properties needed by the driver.
>>>>
>>>> In addition there is a bug fix for exec_op helper functions, log level
>>>> adjustment on uncorrectable ECC error and some coding style fixes.
>>>>
>>>> [1] https://lore.kernel.org/lkml/20230606231252.94838-1-william.zhang@broadcom.com/
>>>
>>> Miquel, thanks for having applied the patches, we should have discussed ahead of time whether you should take the SoC/board-level DTS changes through your tree or mine, but it's fine either way and should not lead to conflicts in Linus' tree.
>>
>> I'm sorry for not thinking about this ahead of time, I was also not
>> Cced on the other patches, I noticed it (told Willliam) and just forgot
>> about this when I applied the series.
>>
>> It is currently living in -next so if there is any problem I can still
>> act.
>>
>> However for this kind of change I usually apply the bindings and .c
>> changes independently from the DT patches. I believe there is no
>> problem having one or the other being merged first, or do I overlook
>> something?
> 
> What the heck /o\ I just understand now my mistake, I am very truly
> sorry for that...
> 
> You were telling me I should sync with you before taking DT changes,
> and I was so convinced I _did_not_ take the DT, when I looked at the
> branch I did not understand your point. But I am totally sorry I
> actually did take the DTs by mistake and I truly did not notice it.
> Confirmation bias I suppose. My very sincere apologies.
> 
> As mentioned previously, I was not CC'ed on the DT patches, but I
> believe the linux-mtd list was, so the patches didn't appear in my
> inbox, and once I was happy with the binding/driver changes I applied
> it all without noticing the DT changes had sneaked in.
> 
> I'm finally preparing the PR for Linus and I see it now...
> 
> I believe the SoC tree is closed now so it's up to you what I should do
> with them. Let me know if you want me to keep them in my tree and
> forward them to Linus or if I should drop them and you'll take them for
> the next cycle. Also, if I keep them, shall I add some tag of yours on
> these 3 patches? For the record I did not review them.

Yes please add my:

Acked-by: Florian Fainelli <florian.fainelli@broadcom.com>

tag, and it's fine I don't expect that we will get conflicts for those 
files.

> 
> Thanks and again, I'm confused. I never apply DT patches like that,
> your initial remark was more than legitimate.

Not a problem!
-- 
Florian


