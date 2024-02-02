Return-Path: <linux-kernel+bounces-49954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7979D8471F9
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB5271C2564E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC4B946B98;
	Fri,  2 Feb 2024 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HnccJTCB"
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B2A145353;
	Fri,  2 Feb 2024 14:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706884347; cv=none; b=R/4UimlynTb8NcbNDMpHO01XL2SoCHSvmn+ImIdfZcBi0HQ1UNm6Y1WhHlkLPpSqZTJj2X+x5WhxePdJxIbKpUf8j+EVKrmsfgYZ+7n6yj9g7iuH4xrU9J2tH4TT09oRMzkIKFFJSGchvGTtnwOR5RR8T9dsh3mTZC2qok8a1tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706884347; c=relaxed/simple;
	bh=aEyCAg5r7C7mGUU+wZa9a1AvTO9rjirBlH3sTiTaSn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSLJMqal7eiBp7oGOi67Hc8KRqjKz2lAPq8zm72QrtaEhLDpwu6x0EqjIFCSCGVdiGyS6PZxZ5k3KA/5KTjSxf5/z8m+qrBBErPKTX2wruoiSz+WOtTZ+1H5Ngjv0K64N5zyLjNxiauepXxJJ24IWGA/m3HKQRopLKejiXiFVTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HnccJTCB; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a370e63835cso80193966b.1;
        Fri, 02 Feb 2024 06:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706884336; x=1707489136; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/XFbEk8TjvWrH3OpqkG5Nm22jl0ZreNTnoVcouMOMeQ=;
        b=HnccJTCB7ozWvQ5q6XwXEouFC7hW0b4/Z+sn+yUKfRLQn7xEw7+pSi0j1yYNuoLJqS
         29MH9M7/oQuAkpqiGC6sOUXwRqQqsbQqAFQlwe7MywJifLHMPbzJ0tWS939mEyahPfL3
         8Arab3AqdCosz6zAVURtJcpmeHWwHFjRkWIGCsN0NqHoOOTmamCwd+lhALz7fFVBESrr
         i55jU8G3hpY8B0Wp0/zI/EBMFnn72j+bcIHCe5ILjpvKWZmgjsD7K89ceAbitBnkj59L
         Bsn0VG7mKi+fvrnkTXBmQQCZ+Ngn1DW9j81lpj34HsMQoKAPd8RDI/WDzMaWK7vtkkJu
         TaYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706884336; x=1707489136;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/XFbEk8TjvWrH3OpqkG5Nm22jl0ZreNTnoVcouMOMeQ=;
        b=p4TbcBeNC3cf396wvGwjlLmzsStwu9SBF0uaIRJ7f2WuGN+IAmeYpCa8P0hOdpjwZj
         zE8ncuGKk9tvCa1F8aCo+iCkDvFPVii+qikl446hsjbKgCF7AmLVIgewvFJYbFRDuw9e
         GWIMlQrfVyU+xwQcZeew1HH4tejCcP7wjv/fLg1lcNvcR8Ll9iy1vTHRgdQP3UQwcqto
         YPEtuLANDX2o5MRwKzDGIrbEPCspAEGmzN9wJZOwaKTMFKRdy2DHN0fRsK5uAGBwV+aT
         9C8KBlZlms2nT9cpb9pWQqtJUWbj5fnKuzSTq21LjQ9hlD4r4v3n181WpUM15BjY94AE
         1XyA==
X-Gm-Message-State: AOJu0YyRirBhYZ6iqzWDZJdT59fTpWPFp3y5JTIfTOX94/sD0McCmAYC
	xsvgWHAVbFyIpXzcEygLI+81X1EF30Cr4d6REveC6NBXVtIwSy2Z
X-Google-Smtp-Source: AGHT+IE90c2PgiDGC1ohmOdD4Hq2fvODX53JZMl4Yes8Q1Pqg4ZO4D2dFkGCGV2u7q867spZtxNT3g==
X-Received: by 2002:a17:906:f107:b0:a2d:52dc:1841 with SMTP id gv7-20020a170906f10700b00a2d52dc1841mr3956312ejb.18.1706884336128;
        Fri, 02 Feb 2024 06:32:16 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWWMwX2rUnBTEWm4GD5TeeQVOz9SsTzA3cCLLc9C4Pw51Lvv+APyc1HN+F4OhADXF+Iu0ZiCuTS9CEFm9jgaUFP9dND+OKJuzMnSNVP6493qWkROD7l6plHBwQdKQGq4n51HQspY2yO78/hZ0qHzitYMAR7xL8kW1TDLV+HUDmGIxHHsnBTo7jwBM46cnp/IfRDvH0T8QYOloUcclYGBoP6KSJCkZ2hdMWLYhcqrNw7FBdwU6CMoQEf1uFC/c29idq1QXZOT7ku8aflHNYzx+IWcePRdL4yiQxdytGbJ/JZgZKjM4NWvS7pF84nbGVP16bx0eIPcb3AKHP/GYrAVFKBevkp7uxZpJT+M5GF+x1ihlxl0RWp3fqIQGH/U3UTzOYD5Rk7WvuPrUAWwL51nAp9LSCOLQ==
Received: from [10.76.84.182] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id c3-20020a170906340300b00a35a659cab5sm944245ejb.179.2024.02.02.06.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 06:32:15 -0800 (PST)
Message-ID: <8c7839a9-b1f1-4e58-b35e-afdc8503c90f@gmail.com>
Date: Fri, 2 Feb 2024 16:32:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/4] iio: adc: ad7192: Add AD7194 support
Content-Language: en-US
To: Jonathan Cameron <jic23@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Alisa-Dariana Roman <alisa.roman@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Alexandru Tachici <alexandru.tachici@analog.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <20231114200533.137995-1-alisa.roman@analog.com>
 <20231114200533.137995-5-alisa.roman@analog.com>
 <20231126163426.66e51114@jic23-huawei>
From: Alisa-Dariana Roman <alisadariana@gmail.com>
In-Reply-To: <20231126163426.66e51114@jic23-huawei>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 26.11.2023 18:34, Jonathan Cameron wrote:
> On Tue, 14 Nov 2023 22:05:33 +0200
> Alisa-Dariana Roman <alisadariana@gmail.com> wrote:
> 
>> Unlike the other AD719Xs, AD7194 has configurable differential
>> channels. The default configuration for these channels can be changed
>> from the devicetree.
>>
>> The default configuration is hardcoded in order to have a stable number
>> of channels.
>>
>> Also modify config AD7192 description for better scaling.
>>
>> Signed-off-by: Alisa-Dariana Roman <alisa.roman@analog.com>
> 
> Not directly related to this patch (which looks fine to me)
> but any idea why 3db_frequency_available is not using read_avail?
> 
> Seems sensible to convert it over given all the other cases are using that
> and it will allow dropping at least some of the attributes infrastructure
> for some devices.

Thank you very much for the feedback!

I actually tried then to use read_avail for the 3db frequencies, but it 
required a greater rework. If I remember correctly, the four possible 
frequency choices need to be stored in the ad7192_state for it to work. 
Should I add a patch with these changes?

Kind regards,
Alisa-Dariana Roman


