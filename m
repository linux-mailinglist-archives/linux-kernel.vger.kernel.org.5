Return-Path: <linux-kernel+bounces-151486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ED28AAF7B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64222284336
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2F412A14B;
	Fri, 19 Apr 2024 13:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iabnmbkm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB579128366;
	Fri, 19 Apr 2024 13:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713533810; cv=none; b=rl/f8fFf9Inrc5j7NNqIRbPLojR2WitFmEm6yHlFt8Pk4/GI/T7OE/pw/1I4tWFYFUlpInD5gHSC7yowBHymVRl0MB+ZOHa9iGGAGH5rChHu1XE8r3tzGys5tDI7wJkagSABLyWcjAr5eHd9skMIi11E5GLElVqJMmKPoUVds5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713533810; c=relaxed/simple;
	bh=U4aqqscz4hwYVD7/WUzWa+gb7dWeA61ua2/mMi8nDpM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=h5zLn/Sk9Xfbmqj0Y94DY3K6b03H8BTqqIrvomxQAGj6dl1rZipqY4JzMDgnLeX6fSZz9JFIQp/ftNtjJYmSpztmMwWGZiX2ABhEq3zPFbF8z9KNzmx8XiJAGbnle9AtVok+qUM5pXrqcptnAK6C7O3rN0VhgRqK/vGgoKATQUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iabnmbkm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E26C072AA;
	Fri, 19 Apr 2024 13:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713533810;
	bh=U4aqqscz4hwYVD7/WUzWa+gb7dWeA61ua2/mMi8nDpM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=iabnmbkmijCMIS27u2Zn7TNmeWwaeYDvgG1yGndZuHY1abEloEb0oOda1CPtCT9Oh
	 IBGZRDtQHNQwU+2AMGQMdOEFb9fZgHRVFSwQSDGExUiWFVqLFiFhZRRAgVVnfdfnOO
	 Hky/RAE7e5V6wb9hl18rLAC9UYBdfdqwgZ2cWeibY0SjHwZh2Gdh+rkrplBSlbUBMG
	 ceAxvceynXchWT3oaooraaL4O2JwwBB8wEAxDOxMUkhdCX1Oz2QWCq2tQKzM1Ofn0R
	 HWVzfJae+r7qqFNy6tijzRY+rakDPIrL1k0+JBu9CE8uEMc0Phj0NG5wH6/eP+mZrl
	 VMVF/PmKcos9g==
Message-ID: <46a9196a-aca2-413b-8f82-794c19861a51@kernel.org>
Date: Fri, 19 Apr 2024 15:36:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] dt-bindings: rng: Add vmgenid support
To: "Landge, Sudan" <sudanl@amazon.co.uk>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, tytso@mit.edu, robh@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, sudanl@amazon.com, graf@amazon.com,
 dwmw@amazon.co.uk, krzysztof.kozlowski@linaro.org, bchalios@amazon.es,
 xmarcalx@amazon.co.uk
References: <20240418121249.42380-1-Jason@zx2c4.com>
 <20240418121249.42380-3-Jason@zx2c4.com>
 <bf9b59ed-a739-4a06-93db-facb0c89dab6@amazon.co.uk>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <bf9b59ed-a739-4a06-93db-facb0c89dab6@amazon.co.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/04/2024 15:31, Landge, Sudan wrote:
>> +...
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index aa3b947fb080..c84ac9258a48 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -18463,6 +18463,7 @@ M:      "Theodore Ts'o" <tytso@mit.edu>
>>   M:     Jason A. Donenfeld <Jason@zx2c4.com>
>>   S:     Maintained
>>   T:     git https://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git
>> +F:     Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml
>>   F:     drivers/char/random.c
>>   F:     drivers/virt/vmgenid.c
>>
>> --
>> 2.44.0
>>
> Since I am on leave, looping in Babis to review/verify the patches.

You can bounce emails to Babis. Or ask him to use lei/lore. No need to
Cc all of us with such forward. This is just unnecessary noise in our
mailboxes.

Especially if you want to get some reviews...

Best regards,
Krzysztof


