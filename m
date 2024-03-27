Return-Path: <linux-kernel+bounces-120501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F21DA88D86F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADF1C29D9EF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 08:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A5D82C842;
	Wed, 27 Mar 2024 08:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q3Pv/gQs"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F0232577D
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 08:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711526990; cv=none; b=IzkUocKnEkvP+FGAMkB5yflppdKrG0vZ8UY9uvUkWj6A4hhVtA7/HolHtH5Xr7Pomrqj+qa/PEyOkro4qtZI/PJRqpeO7ISgAPRtMjRhvMmz5OI5UpuScvlqZIIZ+VnogO7TV5UTJCc1qFdG0I3Pk9UZZCoWbCkr/UZ1IVeidq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711526990; c=relaxed/simple;
	bh=GPu0olZFo/3Df8UKJk+W9AS/4Etn7baYS1zdkvAVtIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KwOrjG5p03692AhO2+rOcu+1DqWska/ossVukrAnEEEOq8Jpqm3zP265mgq/eI0Y8MdIk4PlVuvREXLPuBBRmUIqdJMpaerUabxfhAmpusulsSUEvh+vcCaIl316Ac5qLBNo6xWcdgPXLDjnLRr7KaCPC0TwISm3VqcB3Bxi2DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q3Pv/gQs; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41494aaa1c5so2050085e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 01:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711526987; x=1712131787; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=laN7yfiUrlW9A39+FpFCocbYRuO1xnHUno2fLpcSh5I=;
        b=Q3Pv/gQsam2BY1ZZCrfrZ6Hlc9c1ZugUlFx8C2V5B26fyhQxDdIn48rWTzIhBsxkn/
         6dlUizWBny8f/AE7DfduNSyquz8n2WUH2y59u9ULjekIZqux4+J1/ilV27JsjyxUyPQN
         K8aEdiEciNBSFe88a5gE+bpwnwp2ev8d4bYtUPvEStwXedCBt8DqHFGdY/l96kWcc/4r
         8iydzL9PQX+wqmvwr+E6d8ty2GoMUCYzenYzCIfONLBga7QlZvl5BWvyzDK70QR/4Zx8
         4R4B2t6fJMDASk5Qk3QUFWOZY1ycksmlwfD2HSfVJ0IGoLiMDUMts7cw42+7M6xIBSJ7
         uyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711526987; x=1712131787;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=laN7yfiUrlW9A39+FpFCocbYRuO1xnHUno2fLpcSh5I=;
        b=lnwOH05lLhtHDwuKdD+zKGcWpnN7JmsCoOlx03xMUGcUvDEzx/YCOuvxpggZTBWRbI
         zFb/vDD83oIUxQQFyAuJRa2ndQKQW6y1bMMYdRhNCXJJgHAkRX8X4c2QeCZlapdINjmh
         o9wMpY07sRiQqgjPOmjaVr+Au7eH+vxWZiePHC9UZQsWVxYn6sPNhB2MBGNA0YS+Sz9M
         4RO3HW2PfBVtEsLgH3eYUR3gpI7y5hHJlVT8ICddOtea0qbl2YiSu1uJVh7InCk4FJ1/
         wsZsL6mZr25LA2lskZi8SzWDIRhD6GRzSCGsvyYcGNdOIvKZqLhlo0ZqLVdlCjZlXs6j
         Ediw==
X-Forwarded-Encrypted: i=1; AJvYcCWeQUTRyonUaIDJtgruPGex89i0Cx7jsOkO3NSiE8q22H4ZNgMhenKUCw/XhS5gkpvV93dqXrgVRuUk28lUuaFg5466ywXD/T4R9ROV
X-Gm-Message-State: AOJu0YzXwPMwbb44ZxE3aRFC6XTG2cMODYbiGpBkpmTqtRpYFpuoSP3R
	L9FJqI5MGQV/4Z1s5ZXFbjJQ6L2sHYRoKeeyzfq3gHSQ09QF8jz6oZ+wUuMe/Vc=
X-Google-Smtp-Source: AGHT+IGEz+1d1jkgyoddachI7gTTbD9dQEkwNHSRq3xwokZx4P8MvimuzJLiHrnBk29XtEAHxjXt3Q==
X-Received: by 2002:a05:600c:1c15:b0:414:21e:86e8 with SMTP id j21-20020a05600c1c1500b00414021e86e8mr410489wms.27.1711526986918;
        Wed, 27 Mar 2024 01:09:46 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.252])
        by smtp.gmail.com with ESMTPSA id q18-20020a05600c46d200b0041409db0349sm1334313wmo.48.2024.03.27.01.09.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 01:09:46 -0700 (PDT)
Message-ID: <2b441832-9b3b-452f-8c63-444f29cbdd12@linaro.org>
Date: Wed, 27 Mar 2024 08:09:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] clk: samsung: introduce nMUX for MUX clks that can
 reparented
Content-Language: en-US
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 peter.griffin@linaro.org, krzysztof.kozlowski@linaro.org
Cc: alim.akhtar@samsung.com, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
 willmcvicker@google.com, kernel-team@android.com, s.nawrocki@samsung.com,
 cw00.choi@samsung.com, mturquette@baylibre.com, sboyd@kernel.org,
 semen.protsenko@linaro.org, linux-clk@vger.kernel.org,
 jaewon02.kim@samsung.com
References: <20240326172813.801470-1-tudor.ambarus@linaro.org>
 <20240326172813.801470-2-tudor.ambarus@linaro.org>
 <c20452059e62d3b8c45efb8070223f10f0bd06ed.camel@linaro.org>
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <c20452059e62d3b8c45efb8070223f10f0bd06ed.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/26/24 17:43, André Draszik wrote:
> Hi Tudor,
> 

Hi, Andre'!

> On Tue, 2024-03-26 at 17:28 +0000, Tudor Ambarus wrote:
>> All samsung MUX clocks that are defined with MUX() set the
>> CLK_SET_RATE_NO_REPARENT flag in __MUX(), which prevents MUXes to be
>> reparented during clk_set_rate().
>>
>> Introduce nMUX() for MUX clocks that can be reparented.
> 
> What does n in nMUX stand for?

I thought about using the common terminology, "n-to-1 multiplexer",
where n is the number of select lines. I'm open to other suggestions if
there are any. I should have specified the naming scheme in the commit
message, will do in the next version.
> 
>> [...]
>>  
>> +/* Used by MUX clocks where reparenting is allowed. */
>> +#define __nMUX(_id, cname, pnames, o, s, w, f, mf)		\
>> +	{							\
>> +		.id		= _id,				\
>> +		.name		= cname,			\
>> +		.parent_names	= pnames,			\
>> +		.num_parents	= ARRAY_SIZE(pnames),		\
>> +		.flags		= f,				\
>> +		.offset		= o,				\
>> +		.shift		= s,				\
>> +		.width		= w,				\
>> +		.mux_flags	= mf,				\
>> +	}
> 
> You've duplicated __MUX() and removed the CLK_SET_RATE_NO_REPARENT
> from flags - I think it would make sense to instead drop the flag
> from the existing __MUX(), and adjust the only two existing users
> of the macro, i.e. to add it in MUX() and MUX_F().
> 

Yes, I find the suggestion good. Will do in v3.

Thanks,
ta

