Return-Path: <linux-kernel+bounces-152777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 908F98AC41B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F17E5281009
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 06:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6739405EB;
	Mon, 22 Apr 2024 06:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kYEG9A3N"
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87900DDA3;
	Mon, 22 Apr 2024 06:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713767001; cv=none; b=nXsYGGU/1uDcnJpso+HFnR3Xnz3sipmpIla9fV7epCT/CQO+D73z4z9HO74LbPnNE/gfSl25cCWUIL6ciV/15paYcBfJoFNE7a/AEgpPOIG1yHOuH4tJGkzpdo0x9gU7UMaODbpw0iy3IGTcRsJXPHchUWuEhule2/CgwOoAmPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713767001; c=relaxed/simple;
	bh=0yqWmG4lFvTjrQyRBilrn39JPzAakJCXrEK1lFFWrvU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=JQxFvURmtc+1vNZ8qSoxKi9RGNwoYUfYxQLVtzo9QsEgTuCtNSKoBh0uwrHlovpudu51PFUHdfcZvBEMYrJ8N+8okzAylY7ljNXOBUG44OhrHF3O8B+JWYXg6HJdnpu95Kz9HihldfsnSKM+EwbJUk0Jj+VMXfsVF7lfPL71TMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kYEG9A3N; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 13E8240008;
	Mon, 22 Apr 2024 06:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1713766990;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qTFhysNt/3zWhuk9APN+XkSCHeCT2braUpoM8bTINGY=;
	b=kYEG9A3N5oVABsryFafN7bFTT6Dtj6GkdtikX8DKyrAXSNEdsxaHLrFdOz2EmKkIHZCfmA
	Q0CFA0/o4uaJSlA9qBfop3gCCHF1bhPjIA60S0J5F+QbiZWtyU8+xxWjR3M6EKWELtzyON
	bW0pz8Q8lZfpIw6g5omvxiA56R8JoSKj162nZMwLLvolDA1UI3N02sYDHjH7//uPu+FLJU
	LaCo0lzVZnj1/3HvDbGy82nhJvaPTnY3vYH6dD9cMoh7V1Zc+u1wOmA55gGVV20HbFh+Hi
	E3DHdNuTHRZCYIcJL4nICNYV+MoK78TEz+B9ztz6O3bgIwxXvTWPl7gPIT+j9g==
Message-ID: <505a8cea-5b0e-4ecf-b566-e68b37b2d4ed@bootlin.com>
Date: Mon, 22 Apr 2024 08:23:04 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: michael.opdenacker@bootlin.com, linux-riscv@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: riscv: add Milk-V Duo S board
 compatibles
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Chao Wei <chao.wei@sophgo.com>
References: <20240421055710.143617-1-michael.opdenacker@bootlin.com>
 <20240421055710.143617-2-michael.opdenacker@bootlin.com>
 <c30cc11a-209a-4919-a382-7588daff0d71@linaro.org>
 <b1f59075-f2b0-4f2c-aea3-bc596ac45f1c@bootlin.com>
 <71f2e031-41b0-4a47-9bdd-e8fb6334da5d@linaro.org>
Content-Language: en-US
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <71f2e031-41b0-4a47-9bdd-e8fb6334da5d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: michael.opdenacker@bootlin.com


On 4/22/24 at 06:24, Krzysztof Kozlowski wrote:
> On 21/04/2024 20:55, Michael Opdenacker wrote:
>> Hi Krzysztof
>>
>> On 4/21/24 at 16:12, Krzysztof Kozlowski wrote:
>>> On 21/04/2024 07:57, michael.opdenacker@bootlin.com wrote:
>>>> From: Michael Opdenacker <michael.opdenacker@bootlin.com>
>>>>
>>>> Document the compatible strings for the Milk-V Duo S board[1] which uses
>>>> the SOPHGO SG2000 SoC, compatible with the CV1812H SoC[2].
>>>>
>>>> Link: https://milkv.io/duo-s [1]
>>>> Link: https://en.sophgo.com/product/introduce/cv181xH.html [2]
>>>>
>>>> Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
>>>> ---
>>> Where is the changelog? It's v6!
>> Oops, it was in my cover letter
>> (https://lore.kernel.org/linux-riscv/20240421055710.143617-1-michael.opdenacker@bootlin.com/T/#t),
>> which you didn't get because of get-maintainer.pl. As the recipients are
>> patch dependent, am I supposed to describe the changes in all patches
>> and not only in the cover letter?
> If you do not send the changelog to everyone, then yes, please describe
> respective changes in each patch.

Ok, will do, thanks!

>
> It's your choice, but if you decide not to send cover letter to some
> folks, then *it does not exist* for such folks.

Well, actually, I shouldn't have let get-maintainer.pl decide for me. Is 
there a way to send the cover-letter to the union of people who will 
receive the individual patches?
Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


