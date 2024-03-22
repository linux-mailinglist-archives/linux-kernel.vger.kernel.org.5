Return-Path: <linux-kernel+bounces-111362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8A9886B3E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58269B2105F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 11:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056413EA9C;
	Fri, 22 Mar 2024 11:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="COxmyx41"
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8634224F2;
	Fri, 22 Mar 2024 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711106629; cv=none; b=jzIXys5P0HZNhMrC8hSGvk/ojBXEQ7ByXfJtJomDt28a0GT85xovpdtCcCEpxbBTyYlZg51rRGJ1kafPYKSS3yH3tXXGkNxEL0NuEBMYvEORHgj8kS7IT7TFMc2M/XhhUK8ZvVhWRxFB6ym3n18Ld/cXAJpoBWzptAD7SPZYRyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711106629; c=relaxed/simple;
	bh=AGTRp5yUrXAlVm9NQRF9auXu7qqb/qOhx9KGNmoCvsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PvEUSQS5DTsOvl/RI3PH7tr+m+E9LgSDHdSQ+Ats5EZrJq55fYg2ibPyky+G1ClS4pJvRVgee/BQhtRKGoH17Ip450AAcLTV3SuZvLMh6KYJZO+RJN6+QHCDpJM+lW8w+E5i0yOO7f3HURCV931g+gjS6W7/E6do2RO/eE3MVbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=COxmyx41; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 273A287FFF;
	Fri, 22 Mar 2024 12:23:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1711106625;
	bh=9v12RPulVDx9brrXxQ/UMVoj/6uBcJtZ7FSS8MAE+fo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=COxmyx41VErA/cSPgUVHdBWPoUEPMaCIzPEd4qDFyy5Bnf/W25fH79Of17eCOMBUT
	 i+6OaTdbVcqT8TR2PelBtTDhEEQ+yDeyV2BAMR1rxBiyH8TUV+pjlX3cL/JPxrjUYh
	 amBSg+hAk+HdJZpyvr5h29xfQNQ+/7fjz+j26THGUVtAySa5mjiB5VlXu7GxyqcsrY
	 O2LOPGWkfha7lXqKY9QHf025tYKsiGNa6vz+IyBBDqr/N9mv9yjZGSd740KyOOf83f
	 o20D5CZxmMhmPZJfF2POcrtMS2+06rZ86dJypv8s+5IaBSqqqNwsya1KDE6iS3Bh4U
	 1Gc73XiEaHHKA==
Message-ID: <21741b02-2454-40d8-87e3-9243e44f9738@denx.de>
Date: Fri, 22 Mar 2024 12:23:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5.10 00/73] 5.10.213-rc1 review
To: Pavel Machek <pavel@denx.de>
Cc: Sasha Levin <sashal@kernel.org>, broonie@kernel.org, tzimmermann@suse.de,
 omosnace@redhat.com, paul@paul-moore.com, yi.zhang@huawei.com, jack@suse.cz,
 tytso@mit.edu, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org
References: <20240313164640.616049-1-sashal@kernel.org>
 <ZfrngHBf1hbHohFa@duo.ucw.cz> <21fce6d1-fadb-4175-9539-73d4cbdad452@denx.de>
 <Zf1T1Q9q+0TA9ppm@duo.ucw.cz>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <Zf1T1Q9q+0TA9ppm@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 3/22/24 10:48 AM, Pavel Machek wrote:
> Hi!
> 
>>>> Marek Vasut (1):
>>>>     regmap: Add bulk read/write callbacks into regmap_config
>>>
>>> This one quite intrusive for the stable. Plus, at least "regmap: Add
>>> missing map->bus check" is marked as fixing this one.
>>
>> If there is no very good reason to include that regmap patch in stable
>> backports, I would skip it, it is a feature patch. Does any backport depend
>> on it ?
> 
> Well, yes and no.
> 
> Series of max310x patches depends on it:
> 
> !!a just a preparation; buggy, whole series for fixing this |ef8537927 285e76 o: 5.10| serial: max
> 310x: use regmap methods for SPI batch operations
> 
> ...
> 
> !! whole series to fix corruption, which did not exist in 5.10 in the first place |57871c388 3f42b1 o: 5.10| serial: max310x: fix IO data corruption in batched
> operations
> 
> But according to the 3f42b1, the bug did not exist in 5.10 in the
> first place, so we got buggy 285e76 backported, and then fixes up-to
> 3f42b1 applied to fix it up.

Then probably both max30x patches should be dropped/reverted and the 
regmap bulk callbacks also dropped ?

