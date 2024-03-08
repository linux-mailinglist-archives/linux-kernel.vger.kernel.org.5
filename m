Return-Path: <linux-kernel+bounces-97254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 679FA87679A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95E8F1C2187C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AF625753;
	Fri,  8 Mar 2024 15:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="F+Gnu+cM"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA4A8366;
	Fri,  8 Mar 2024 15:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709912901; cv=none; b=lI9dG9mZeHhaxLSUG++5TF3qfbig+xqX0E7h2O/ori8ykMOHZGk8B6xlylZVQA8+PgHziuIabzmkL/mGM7VOEiA2i4oT/Q8irBV8ohRtbQwyKflqGeB2/G3Xky/0XisU8XxIr30sDw3Bib4G9BGHiilCrUaVbfFf+CnyMkrV5ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709912901; c=relaxed/simple;
	bh=Lj9Gw52rMuV7qbx8B3Gh4b2+vyWGBnyU2idByZwFVo0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H+NxWvkDrW+YEBc6VN4nVpaV42vKgAm6yA82nsjJ+QwAtRRM+8CnSKS52cjrzt2x072XAMvTrEumFoOzHLDq4QMYEEdIhySWMKyBIycS+UEg9BYQMUqnWrCanLhp66vM1ENXgR0AqRCtA1YJUsnEJ+GcHQBZC0AhaURJjYeUFmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=F+Gnu+cM; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1709912898;
	bh=Lj9Gw52rMuV7qbx8B3Gh4b2+vyWGBnyU2idByZwFVo0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=F+Gnu+cM9h3UhwP7wu4oZyyr6g5c3sBKIzYYbwpakb+5Aizohm1Z4f96DjgI3QPT7
	 VWDQh5uOMh1QPvcfzEe7+BB9Wq7taQ04QvzrK6uKbbsaujiPIvLBrVR91sFM7Kvhs8
	 du8sziDvfdP/W/TQT9pQBNEgrbqH+GjpfN4/X6iwxOounxoWuftYBEWt8CW0CczmYH
	 jg3T2VFLrI2lcZu6aUZnfFTpWIEvUyGevi7zpZpLyOCDPQuT+0OhteG2vh1uok6kkM
	 jT+s1kJqoiK/f0ZfjtTLpIuf2YVh4eepaZ/uKeH3YYAr4BRal9qWxxU4qb7ZFO7t6X
	 sDkr/8d8iSo7w==
Received: from [100.74.67.65] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: jmassot)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 65D5D3780B5F;
	Fri,  8 Mar 2024 15:48:17 +0000 (UTC)
Message-ID: <7d0197b9-9008-4260-86e9-4b7f7017b3b6@collabora.com>
Date: Fri, 8 Mar 2024 16:48:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] dt-bindings: media: add Maxim MAX96714 GMSL2
 Deserializer
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: linux-media@vger.kernel.org, kernel@collabora.com,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 mchehab@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, sakari.ailus@iki.fi
References: <20240305152608.287527-1-julien.massot@collabora.com>
 <20240305152608.287527-3-julien.massot@collabora.com>
 <20240307-retract-aloof-9ff1fde79a82@spud>
 <8f6972a1-e174-4c0e-808e-afece9b529bf@collabora.com>
 <20240308-footnote-landmass-e1efcaf72a6d@spud>
From: Julien Massot <julien.massot@collabora.com>
In-Reply-To: <20240308-footnote-landmass-e1efcaf72a6d@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/8/24 16:07, Conor Dooley wrote:
> On Fri, Mar 08, 2024 at 03:08:12PM +0100, Julien Massot wrote:
>> On 3/7/24 20:21, Conor Dooley wrote:
>>> On Tue, Mar 05, 2024 at 04:26:06PM +0100, Julien Massot wrote:
>>>> Add DT bindings for Maxim MAX96714 GMSL2 Deserializer.
>>>>
>>>> Signed-off-by: Julien Massot <julien.massot@collabora.com>
>>>> ---
>>>> Change since v3:
>>>>    - Renamed file to maxim,max96714.yaml dropped the 'f' suffix
>>>
>>> Why? The filename should match the compatible, which /does/ have an f.
>> All the work has been done on MAX96714F variant of this Maxim GMSL2
>> deserializer.
>> The driver and the binding remain suitable for all variants of this chipset,
>> since they share the same
>> register mapping, similar features etc..
>>
>> MAX96714 exists in different variant: MAX96714 / MAX96714F / MAX96714K that
>> will be easy
>> to add support for this binding and driver later.
> 
> Either document the non-f version if it really is that similar, using
> all of the same properties, or name the file after the version you've
> actually documented. I don't see why this particular case should be
> given an exception to how bindings are named.
> 
> What is the actual difference between the f and non f versions? Is it
> visible to software?

Yes there are a few differences visible to the software, for example the 
GMSL
link rate since MAX96714 support 6 and 3 Gbps, while MAX96714F only 
supports 3Gbps.
the registers map is the same, but a few values are not possible with 
the 'f' version.

I will add a compatible for the non 'f' version, and will do the same 
for the max96717 binding.

-- 
Julien Massot
Senior Software Engineer
Collabora Ltd.
Platinum Building, St John's Innovation Park, Cambridge CB4 0DS, UK
Registered in England & Wales, no. 5513718

