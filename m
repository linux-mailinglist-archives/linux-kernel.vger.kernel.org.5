Return-Path: <linux-kernel+bounces-156482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA718B0320
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 09:24:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18285B261B4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96D21586FE;
	Wed, 24 Apr 2024 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KjiLHxaW"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F221586FB
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 07:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713943405; cv=none; b=c+RbucnQMDzHCkLAPgLTbkrTkjFMqLmIK48frODZNXNsT5NWwfZsRx7pUCgtYp1CmmcxTXtYDaz+S5c/i7nIEZj38JvIt8lwQUok/a/tQG50dCIu6OefC4mkm9qgupgbAdyvNZGe5hV+01LjmWKD6XrpxfZRefp7WPfExpKjGx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713943405; c=relaxed/simple;
	bh=xxbCaBc95Z+Z+7XM5Kj5BsqZk7VsT9hZrQe/N57hIpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RYkGFC78mHGZ4ujqvxcCZ4SXN+RS5f8Dxs99l8HjG+zPxgRu65HKjhfLFLS51LstfL+NbdbLax78LxIEgXJCbB+IZV9EagLnG9f5P1e/X89R4lricG24lsf846BA9eriz2aqDb3/4dYbvIu53q8NFbgsw1vMeehG7wRX46Gxyl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KjiLHxaW; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-51bab51e963so1797857e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 00:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713943401; x=1714548201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eH5hTGqBaVmQ4QxFz7/DMtOsuiwt9fPf1HS+xP5aISM=;
        b=KjiLHxaWhVHm1alFdMVuRPmZNe5PdZaC6VgQHGvVTAWo2zTCGA7BS8uxMUEjPpKwbl
         Gp5+qRXl1Z2Ji/LLHjPxZ3D9qswvvL3stQA0IL0ub07fYzhqUv2Vsdu8AfMbjFYUZWcA
         SRRYNI8UdnD0YOuHI8zeWI9PjGdrR1q66FAbmcoPhIa5LvHt0+tQNM1YjMCxjfOFuZQy
         OY1yZu3Rp+9DfZIVox4wWXCxTBugXEvnlKGuCagaOgGnDg5O6QbWHhTvPH9ER4aTx+Bm
         uR2EW1lkumXaaUak/fQO/wdohkC9q9SrM1xXfXURAjkXntArPjQu7zK/xqmoOyl/950D
         5MKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713943401; x=1714548201;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eH5hTGqBaVmQ4QxFz7/DMtOsuiwt9fPf1HS+xP5aISM=;
        b=mJ9A09Mg5wb8jxD+3K4LFly21Pw26ZUb7C/oFjNCtdZ5m4Et6fmU1+VqXYnKekKjut
         3lStTx8zJNr93cVbDtLQweQZT+RxNvD7HXC01loAVlurRE6UrfE38DkIQ5jpXOQtcV6F
         JDhMNbz29dCrauY+uwid0mvCL8GZExZEvGCi/04i8iK2Qa1uWPb57q+ZL0QY5tGLXaZ/
         SR1u+ZN1djIK4S2u0Zx6uiYXqcgx8niTSu+5axLy3jWt2Ow6M7inN4//lTVjGbsZm9Ed
         2TF4OWOv8+PkfmUq4+SSFJxAKxYhP/Z/ICnIbiwTKwWmj2OuOrR4pcVwlH/s4SHbn82C
         27fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYNkmztu4Zquyn9S6U9HkeE9y8bYpvS6x7yR96m9ibtnRKU9EJlE9Vmy2FR35XSk2BNFTh3qA/loaTQJ23aNz/0Vvs1CK8XWjokb70
X-Gm-Message-State: AOJu0YzV/isU+WUYzAcnVWh+5jsADBDIBpt/un/amd385tI8ZoOxqT0h
	hBMUilumR2JAlXu7VxzQizZnp7glJTgZiodnRuC3M3o0mcAFyctxx4qhWDAayuo=
X-Google-Smtp-Source: AGHT+IGqo+H29o4iRcT5EnnqV/XVSKwzVeBUziqEaVmTYL+5Iogt2R+hnXOSJF4St9+K8Rt6G40iyg==
X-Received: by 2002:a05:6512:b88:b0:51b:5f9c:ac1b with SMTP id b8-20020a0565120b8800b0051b5f9cac1bmr1691883lfv.37.1713943401541;
        Wed, 24 Apr 2024 00:23:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id q23-20020a50c357000000b0056e672573e5sm7846910edb.88.2024.04.24.00.23.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 00:23:21 -0700 (PDT)
Message-ID: <7adfe10b-cfb6-4242-9520-dd9819bf7f43@linaro.org>
Date: Wed, 24 Apr 2024 09:23:19 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] arm64: dts: hisilicon: hip05: move non-MMIO node out
 of soc
To: Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
References: <20240402193148.62323-1-krzk@kernel.org>
 <171394159880.43787.12383182687947213751.b4-ty@linaro.org>
 <6628B1E9.1050300@hisilicon.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <6628B1E9.1050300@hisilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/04/2024 09:16, Wei Xu wrote:
> Hi Krzysztof,
> 
> On 2024/4/24 14:54, Krzysztof Kozlowski wrote:
>>
>> On Tue, 02 Apr 2024 21:31:40 +0200, Krzysztof Kozlowski wrote:
>>> Non-MMIO devices, which are BTW not really part of the SoC, should not
>>> be within simple-bus, as reported by dtc W=1 warning:
>>>
>>>   hip05.dtsi:301.30-305.5: Warning (simple_bus_reg): /soc/refclk200mhz: missing or empty reg/ranges property
>>>
>>>
>>
>> Almost a month passed, no replies from maintainers about picking it up. Dunno,
>> looks abandoned, so let me grab this. If anyone else wants to pick it up, let
>> me know.
>>
> 
> Sorry for the late reply!
> I am applying these patches which are in the following git repo.
>   https://github.com/hisilicon/linux-hisi/tree/next/dt64
> 
> And it is fine to me to go through your git tree.
> Thanks!

So you picked them up? Why you did not notify anyone? b4 does it almost
automatically. How anyone can know what is happening with the patches?

I will drop them from my tree.

Best regards,
Krzysztof


