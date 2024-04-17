Return-Path: <linux-kernel+bounces-148542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB798A8431
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45381F2263E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAB913F441;
	Wed, 17 Apr 2024 13:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBgP00qI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC4513DDC1;
	Wed, 17 Apr 2024 13:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713359985; cv=none; b=LHhsrtQMGEAjebqEtcxwqAPNx7/nd3MPCMhtgHkj9NVGfijp9rMPKwTHfoWhEFpcM+zX8j1ozGBQ8iYgjzndn7yYhWhEUkvr1/J2bvQ0/wqAFsHfueSetqIK5DZfjbpF5KgcqVdsDcfSGPe9Tc6w4/D1fNkIzavrPNdFnMMCPk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713359985; c=relaxed/simple;
	bh=ifTod5t0Y3zdQxoTHX+qb4Ly20Qs+/JrsNxAdRyT8cI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=itIjnsptW1+Ho1xV3TBebEvsV0igzpiX1bPyRzYQqjkd+o9XUS628ZuKSLe+uEjhQ3VbDNLLuXeBcxLzEm/Ay6a9ok0Ayxc790pJGBcKxX3GCz7NQg7G+KqWf/mJURTRh6mItnWgfOqlDrsfcyIWf9e6TIkanKqrgcbWq4YfHY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBgP00qI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00AEC3277B;
	Wed, 17 Apr 2024 13:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713359985;
	bh=ifTod5t0Y3zdQxoTHX+qb4Ly20Qs+/JrsNxAdRyT8cI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oBgP00qIAs+tK0HzWCwC435B8SLinKSR/VeDfmQ+Nd839ZXRXCHfkvSridLxWvQHb
	 Z7q1+6k6ZT9vzHM0JarNfRXJCAgdlYeRWG6AZ21MGt9cAIjo0rHUX6vj+Pmx5IMmM4
	 XT03P8SEezA4lg0DGgTfXqDqYfLXbrF1ivmeIwVZ90EIzcST4gJE55NlvBwozbDxqi
	 wx9g9ByITh9mYRBHnmxLKHlDhTCmGW1plOe8d52O26ZXN1Zsfk7VnEVrQJewiHrJmS
	 UQ946Q0c+jJWu5q5VZywZ8M7fqYvnsLsi1NPtJ/hFYDF2cLiDKcbAl2CXRgIU/H3Zw
	 S6Z6SaFxzxLyQ==
Message-ID: <3b469d35-ee27-42d4-8768-fc2ce9235196@kernel.org>
Date: Wed, 17 Apr 2024 15:19:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/5] virt: vmgenid: rearrange code to make review
 easier
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, Babis Chalios <bchalios@amazon.es>
Cc: Alexander Graf <graf@amazon.de>, tytso@mit.edu, olivia@selenic.com,
 herbert@gondor.apana.org.au, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-crypto@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, sudanl@amazon.com,
 xmarcalx@amazon.co.uk, dwmw@amazon.co.uk
References: <20240417081212.99657-1-bchalios@amazon.es>
 <20240417081212.99657-2-bchalios@amazon.es>
 <10d41e7e-87b1-4036-a740-da36270a4325@amazon.de>
 <2838b126-ad87-4642-9223-e24f3fdb2c63@amazon.es> <Zh_Dpi630-LXJkJm@zx2c4.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <Zh_Dpi630-LXJkJm@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/04/2024 14:42, Jason A. Donenfeld wrote:
> On Wed, Apr 17, 2024 at 11:05:27AM +0200, Babis Chalios wrote:
>>
>>
>> On 17/4/24 10:35, Alexander Graf wrote:
>>>
>>> On 17.04.24 10:12, Babis Chalios wrote:
>>>> From: Sudan Landge <sudanl@amazon.com>
>>>>
>>>> Rearrage the functions of vmgenid to make the next commit,
>>>> which re-implements vmgenid as a platform driver, easier to review.
>>>>
>>>> Signed-off-by: Sudan Landge <sudanl@amazon.com>
>>>
>>>
>>> You can't sign off on behalf of someone else. The SoB here needs to be 
>>> yours. If you are taking over this code from Sudan, I'd suggest to 
>>> take over full ownership of it and put your own name as author and SoB 
>>> in all patches.
>>>
>>
>> I thought about it and it seemed weird to me that I take over SoB and 
>> authorship since I only touched one line in one of
>> the patches, but I will be taking over the patches, so I can do that if 
>> that's the way we things are done.
>>
>> Does it make sense to at least add "Co-authored-by Sudan Landge 
>> <sudanl@amazon.com>" here?
> 
> Wait, what? No. If you didn't write these patches, you're not the
> author. Sudan is the author. However, if they passed through you, it's
> fine to add your S-o-b. You can even mention the trivial change you made
> between Sudan's S-o-b and your own.
> 

It is not "fine" but it is a must. Regardless if you changed something
or not, you *must* provide your SoB since you generated the patch.
Babis, please read carefully submitting patches. Especially the DCO
part, but entire document is important.


Best regards,
Krzysztof


