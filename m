Return-Path: <linux-kernel+bounces-42399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAD08400D5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:02:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 283D81F22FB4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7FC54BF7;
	Mon, 29 Jan 2024 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RZIiJg4E"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42DE54BF1
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706518961; cv=none; b=L9c7SbCGjJVonwsvrB0g5q2m7M6X7BVojqDpPLnUkuwdcpDBHkXhDyTMeX9t2ufjF1VIlvGaGBmhU55/RmJpLjL1KvBVTBsztrnC/fj5d3Rpdn26IsmyGgPeYS1XAlFMCCG4IYacnxrE7w10FZaSD3C5sdsDSWBXxotVefY/r+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706518961; c=relaxed/simple;
	bh=X1zJ7Cq8bAtVtLASw0Rg1H/ttk5L9TXWNZzu3ejEejU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=nBEdE7NGfgjj2MhMT/SSHKoNX9N17Nc739PzHgZssi+xfOUTKn5405/3Bs0jX7bwoq909DJ9G/hcAQJ/6clzCPDXQkZuhHXqNjr0AfOBjKye9GGBuFZXi573cfcSJ/RUWoL4xqHPiLqGU3VW5taM1ty9vgDdVl2uOnkD6CBvW10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RZIiJg4E; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40ef6442d60so6268415e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 01:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706518958; x=1707123758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cYevMNeoNktot3JAMstftSYPsRaaLyjRhS0LapjonnQ=;
        b=RZIiJg4E7W1RhsITe6CGmpFceCd6HNrVa0jzAvHDNlantalOf/uZBARo7iwIJkBDha
         O/+615UE0zPcm6EPF/PBBaWPR2Wv2+X5BNPYf3WvhWYR1TptR8ISHEVvN8IKTtm34khO
         0WjbB6LdDPcD02x1mtaUHXlU9+9/hB4thjDINgXz2YhUwnLv6iYS+AYJFkXhfal7OVjc
         Hr7s7ekHxita+EYAZp3xCymIHRNSnq6yabxwWew9eY7WjPRRYmdm5636vZqPZTUQGw5x
         k4Ap22vflXkDohyCV50CMXpInmkiRRcQyy4qbwxuYVJ52AOSa58o+LxgPZi2zh1DLGr2
         Ev9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706518958; x=1707123758;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:from:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cYevMNeoNktot3JAMstftSYPsRaaLyjRhS0LapjonnQ=;
        b=WNoBBhQcLFDj2nQus7DxXLjyW9On9SEQWL50c5fqQQ1fwqBoohod5IpiBu/QwarJ1E
         geLACRGXn+bbKEi6RPWyrqm9nu3V2BZJQpelob/bB1GjaPjr3p5rwJ3KesSuE/yiZI9T
         x/0lNdhwNs+pAQjSM+7m8ubMb4ogNIC85BKrRgx3wGNgt8Mr2L+kixoP2El70SqFj/hq
         KpGiWTIV4y+fCWzmKHpxtr3fQhdLvyssPhXKCiyCoyT9l9NOYPehGEKDDPscvfbbaeR3
         SyEIwdf1uk5rsd0ZezgcycjcxAOudN5t/lGB8qe/yYRaslr8T1u31E5TXfF0OWtDeyq1
         l0cg==
X-Gm-Message-State: AOJu0YxAtnuh2VquF9gtl0ViLJruFibLygZHjlYl9spHQYZKxz8paQfe
	L6+vC4VwlJDgXYa1y0P3zdalHC8VbSNqWLHzHZW5mwH5MmL6868KJYRPS6At6+4=
X-Google-Smtp-Source: AGHT+IF832ffChBB4wb9YZTobltYh0scrrCKKWNmDElh4bEYRMcp6FY5fnLKCP6CcaPHOLGzvxcAGA==
X-Received: by 2002:a05:600c:45c9:b0:40e:b6c6:89ee with SMTP id s9-20020a05600c45c900b0040eb6c689eemr4674772wmo.38.1706518958119;
        Mon, 29 Jan 2024 01:02:38 -0800 (PST)
Received: from [192.168.7.29] (212-114-21-58.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id r12-20020a05600c35cc00b0040eac0721edsm9554855wmq.3.2024.01.29.01.02.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jan 2024 01:02:37 -0800 (PST)
Message-ID: <cef1e9ec-1aae-400f-bb30-05d43c6211f4@linaro.org>
Date: Mon, 29 Jan 2024 10:02:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v14 2/4] Input: add core support for Goodix Berlin
 Touchscreen IC
From: Neil Armstrong <neil.armstrong@linaro.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bastien Nocera <hadess@hadess.net>,
 Hans de Goede <hdegoede@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>,
 Jeff LaBundy <jeff@labundy.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231221-topic-goodix-berlin-upstream-initial-v14-0-04459853b640@linaro.org>
 <20231221-topic-goodix-berlin-upstream-initial-v14-2-04459853b640@linaro.org>
 <ZZ-W0UPHOdpU-8el@google.com>
 <98ed4ee9-f381-43a0-a5cc-523ad108b374@linaro.org>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro Developer Services
In-Reply-To: <98ed4ee9-f381-43a0-a5cc-523ad108b374@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/01/2024 16:08, Neil Armstrong wrote:
> Hi Dmitry,
> 
> On 11/01/2024 08:20, Dmitry Torokhov wrote:
>> Hi Neil,
>>
>> On Thu, Dec 21, 2023 at 04:21:20PM +0100, Neil Armstrong wrote:
>>> Add initial support for the new Goodix "Berlin" touchscreen ICs.
>>
>> Thank you very much for explaining how reading of additional contacts
>> and checksum works, it makes sense now.
>>
>> I was a bit unhappy about number of times we copy/move the data over;
>> could you please try the patch below to see if the device still works
>> with it?
> 
> Sure, I'll test it and report you.

Ok it still works fine!

Sending v15 with those changes and rebased on latest linux-next.

Thanks,
Neil

> 
>>
>> I also shortened some #defines and defines some additional structures.
>> Also as far as I can see not everything needs to be packed as the data
>> is naturally aligned on the word boundaries.
> 
> Great, thank!
> 
> Neil
> 
>>
>> Thanks!
>>
> 


