Return-Path: <linux-kernel+bounces-75017-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0B985E1A1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09FE0B21C8B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A768063E;
	Wed, 21 Feb 2024 15:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r0+9htwG"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10314F8AB
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708530199; cv=none; b=J8t82KGLWN8cUToFTO9ghZpItsudlN/sZLTSv1LIZd5pZi73qZwj6jgmbUZ17tw+GnAx3NpAcDSx8lZxgpmxHGdXdF+agRkb6g9uxkfU1wLRqVuaT3R/FlDWtyiMotTmjhGl221JV2AIhfW2yClRmr5zmtUAalJud/W16DGx7fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708530199; c=relaxed/simple;
	bh=eTCwPInH3FUXyO/jeetzCnGXL2RbtJ3Kz+Mpn+kujGs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pIWAf4hVOnVIZn2hjYhTmqd5FYXWMoQqdExUDQEBup3UEl3n/a1MLzVeZULK9n7fMlOXitbRcdkv4a3tIGtURQFiSq4conYfKdaKJ+RRo3eTPJkLHaCEiiPTcJMs8IE9uzShRlWksMETB39NCxwUqmimeB2GQHvOhMIAWrVLqSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r0+9htwG; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5645960cd56so4991910a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:43:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708530196; x=1709134996; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HYPJBlpSkFCHdVgLslmiqUOZByirVW8qunK061Blp0U=;
        b=r0+9htwGHaD+rgcCiDDay67QqfIMddE0+lYajlqMKUuUn7ilqhUZRM5BE0vfi3SFl8
         l9mivjAkj/6ScFBMYp8al3e8pRqrfGj7mWTqzyTjTBkI1LzrUEkRY/CTXlmFZQ77dyUd
         Z4z4J3AikATSGTi+ET1KZchtOXnkNRQAThViZjydmk3PEWMAM1CGrhAeEChkGOy9Wb5E
         LBcGHl+LHw4LFzt2xG3TFjrPyMOh/md0cBvJN1am2KB6GH6Nrr83SRXKayiTz1/IwWPF
         NCA6nNmvqHFXhstn9IqyqIVmROeY7ix7JdqEscCYZjIO7bcXWKnv1g10AhJTDPhGV6nL
         ax2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708530196; x=1709134996;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HYPJBlpSkFCHdVgLslmiqUOZByirVW8qunK061Blp0U=;
        b=DNN01fYZqQIR/2T6sqjGraa5BkQokniVYt1CugtfFp7PjtuOWtqTqb7FaWwYaJR3KY
         NnvWmA72GIi6uW9z7Om9YYfGE8VSrNTaUgVYNoyephJnZQ0izBFBZIi73F4dwFfZtQrS
         6slawibcZWZndoxPgX9uPZDRWJjFzsRL9tvUOOGx24oyZmpTLB68a2rzSo54+d69+Iye
         WBS7JnyiZ1FGe+5fwwuth96xl9DVo88BceXLdIHD6VZ4UDvnRv+zFHJqNy/P4LULDtCP
         iIpPoD3CheYGH0qWYNKemf4m1EfA/I8O96Yo3XC5bK3Yxd7TOlSul6EAf0LXYe+tNWFH
         qzZg==
X-Forwarded-Encrypted: i=1; AJvYcCU6T/UvazW+AbqIdAGZfg5V9jzU4bwnH79WoHkYsGZL8xzc6i6B2KhvfFHrktoFHCpzGu9ErYkx2c0GqOHperT/ofSB9sGWEe96Sbra
X-Gm-Message-State: AOJu0YyxPtHs6+Zt8V8/PBUvrtc2Ar6XhgwU34Fjs/JG7vQuZZsyC5E0
	ORw3ibwaVuvBqSUXr6Ixh+1yw5QzXtQwiObl8vFS5eoYie8FweEMLnCDt1wh/k4=
X-Google-Smtp-Source: AGHT+IEOwSPfl5OGhGHb2pcaVwCbGIpWDZ4oXyQBlaoUkbrefM9619gNRMmJfGuQvWA24LA6eO0j5Q==
X-Received: by 2002:a17:906:5906:b0:a3e:d9ca:259f with SMTP id h6-20020a170906590600b00a3ed9ca259fmr5147972ejq.14.1708530195776;
        Wed, 21 Feb 2024 07:43:15 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id lj8-20020a170907188800b00a3e0c8f4afbsm4916042ejc.110.2024.02.21.07.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Feb 2024 07:43:15 -0800 (PST)
Message-ID: <e538ded0-bd3a-4ca4-b2bd-8d20d8c8c3fe@linaro.org>
Date: Wed, 21 Feb 2024 16:43:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] MAINTAINERS: Add maintainer for NXP S32G boards
Content-Language: en-US
To: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>,
 Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
 Chester Lin <chester62515@gmail.com>, krzysztof.kozlowski+dt@linaro.org,
 =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
 Matthias Brugger <mbrugger@suse.com>, robh+dt@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 soc@kernel.org, NXP S32 Linux Team <s32@nxp.com>,
 Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
References: <20240221120123.1118552-1-ghennadi.procopciuc@oss.nxp.com>
 <20240221120123.1118552-2-ghennadi.procopciuc@oss.nxp.com>
 <f4465547-1fb1-4578-9a69-7d399e7661b3@linaro.org>
 <403e32c2-910e-4745-9ebe-fbf377c3fde8@linaro.org>
 <ad856766-8903-46c0-93af-24e101ad51dc@oss.nxp.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ad856766-8903-46c0-93af-24e101ad51dc@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/02/2024 16:19, Ghennadi Procopciuc wrote:
> On 2/21/24 16:45, Krzysztof Kozlowski wrote:
>> On 21/02/2024 15:42, Krzysztof Kozlowski wrote:
>>> On 21/02/2024 13:01, Ghennadi Procopciuc wrote:
>>>> From: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
>>>>
>>>> Add myself as a maintainer of the NXP S32G DT files.
>>>
>>> No need for cover letters for single patches. OTOH, this commit msg is
>>> empty...
> Thank you, I can correct that.
> 
>>> Plus your patch looks corrupted (wrong encoding): F??rber
> 
> Indeed, it is due to 'Content-Type: text/plain; charset="us-ascii"'.
> I can fix this as part of v2.
> 
>>> BTW, did you contribute anything to the upstream Linux kernel? Do you
>>> know the process? Downstream does not really matter.
>>
>> I found the answer:
>>
>> From: Ghennadi Procopciuc <ghennadi.procopciuc@nxp.com>
>> Signed-off-by: Ghennadi Procopciuc <ghennadi.procopciuc@oss.nxp.com>
>>
>> Does not look like. Please get some upstream work experience first.
>>
>> https://lore.kernel.org/all/?q=f%3Aghennadi.procopciuc%40oss.nxp.com
> 
> Although I am new to upstream communities and may make mistakes, I am
> eager to learn and improve.
> 
> After leaving SuSe[0], the current maintainer of the NXP S32G DT files
> became inactive[1]. As a result, this area is not currently being
> maintained. This is the actual reason why I attempted to add myself as a
> maintainer of that area. Although I acknowledge that I may not have
> enough experience to become a maintainer, I am concerned that the NXP
> S32G DT patch submission may be blocked for everyone due to the current
> situation.

I would be just happy to see first actual contributions or any sort of
activity, like reviewing, before taking over something.

You do not need to become maintainer to provide reviews. By reviewing
patches you already reduce burden/work from the maintainers.

Best regards,
Krzysztof


