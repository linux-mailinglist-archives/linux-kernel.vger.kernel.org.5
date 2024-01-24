Return-Path: <linux-kernel+bounces-36672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DF7D83A4D3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAF521F24211
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2014017BB6;
	Wed, 24 Jan 2024 08:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xDpt3RkH"
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99CF1AACA
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706086753; cv=none; b=Kk+kTpX0o2sSRQBAn1Dq86HGa4N6SUL8QNGx407mvRis9iyJspw5XxN1pMX1zSeo8774VKRF6I7tvuFWBp4EYSiphYh/HQmfn6Xe22lwLGm9WDzu2fZWmOMiu6N4leQ7f4e/2ZTojxRxMZs5CJB9JleD69jHNO3/+hjUHpK8X7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706086753; c=relaxed/simple;
	bh=qAKFbuVN5fhxqzG9URof1iwAmz4SehLizSvWZWQWppA=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FW304fyhE7G9QjgUPzuqpmLC9GP+IL6WPCXJwNZQgWocf3S0ki5m8pRarNaypSNDJK66TZnCMC/ElkW4mcSk8YeO85E4Kh6P+60/DhJJh7tyYdg90eezjvCrtc3RXgp8ubT6wachkf+ak37IM/VGTUJr8IRkiU66mupsnv/VsEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xDpt3RkH; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-337b8da1f49so4634266f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706086750; x=1706691550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4kQVWWTPzP8uJf2o+x+YqXbHc9lNHUWxACBkGysOMnA=;
        b=xDpt3RkHlpA0vWHG5qX7U3chgPV+8BR9EH6gzDYuXxz8Fxqi2Qv1GJaltdzyvJv8Yt
         glZhUMAUOmjm2zZE+7neT8i3+Ccq1ikyIReEo3KJTd83COJ2OQjcpQOe9DmrBk+f1KBZ
         ++5U0NKws7UVdkgf4CZHHH9vWefHzytiaxFEzjF7sgvuOSBzAlWziudJPK6QaQt0nyEY
         lsgy+J/NqQWBH77aXv/b3b64tAkmg6ji0wDajGtrYYBwOt5gjlldEwGMGsCKXyzu3Sjx
         NApYbAgBybXNAppMHRIEuKRiHImAsHf3hUwXBd7KTNv1RoJXqm8JIkfMSsZWRQ4vfqD/
         Q5Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706086750; x=1706691550;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=4kQVWWTPzP8uJf2o+x+YqXbHc9lNHUWxACBkGysOMnA=;
        b=qJ3hlmR43sE0Fi1923zKELNBNPIetXTuIw9Q0sCiwRK1UKX9t/m+oCKhH6iBpcoZbY
         A/M2Uq/2u9leSefjIZ4+HCj0hSk1bw0oqqL37qylmCyNABYxGLFNlw0X6ap2+q5RacGs
         5nuV0AtmCBZYY8Z1mc24ZaoLUkN1r7ejUCmMPxN9rWPkkQpzuiwDFo17Jh41zsDmHudy
         4o8/FTalYv/BK6jY6iltRABiEC5TS13K70DDqRVH8wKEU1eUgks3dM3OHrbTS+0bAKM2
         8AiVNcV6vZ8QKCD5Ra/B9Eq9jdwQdhxjfWiQf1VBuZ6lXjDgqv+ZGc3ODO7VTs2OuXo5
         3PKQ==
X-Gm-Message-State: AOJu0YzMXwrps8Nbr41ltOIBtepGPOJVJMkW4iUqhtCP6ubynAHh4t31
	xICYPqH36JkqA8jhUDtRMhKMOhTdyjYMgMUue9XRHxB51jr476pt/YrcvJKPuf4=
X-Google-Smtp-Source: AGHT+IFj6WIDffEuE3XmE5yjVnwJkBgFE4Gvta/9V0AqCFWBg506Z15Aq+zVk34bF4X0p6W299ET0g==
X-Received: by 2002:a5d:448a:0:b0:336:6fa9:518 with SMTP id j10-20020a5d448a000000b003366fa90518mr248261wrq.17.1706086750006;
        Wed, 24 Jan 2024 00:59:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:fd4f:fd82:e4fb:1654? ([2a01:e0a:982:cbb0:fd4f:fd82:e4fb:1654])
        by smtp.gmail.com with ESMTPSA id j28-20020adfb31c000000b003393457afc2sm7885382wrd.95.2024.01.24.00.59.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 00:59:09 -0800 (PST)
Message-ID: <1e3c70f1-0dd4-46c1-a092-c9c4712bfa4f@linaro.org>
Date: Wed, 24 Jan 2024 09:59:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] interconnect: qcom: sm8550: Enable sync_state
Content-Language: en-US, fr
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Georgi Djakov <djakov@kernel.org>,
 Abel Vesa <abel.vesa@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240123-topic-sm8550-upstream-icc-sync-state-v1-1-a66259e0e176@linaro.org>
 <e6c57522-3f4b-4ae9-9d90-82c162d167ab@linaro.org>
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
In-Reply-To: <e6c57522-3f4b-4ae9-9d90-82c162d167ab@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/01/2024 18:57, Konrad Dybcio wrote:
> 
> 
> On 1/23/24 09:49, Neil Armstrong wrote:
>> Enable sync_state on sm8550 so that the interconnect votes actually mean
>> anything and aren't just pinned to INT_MAX.
>>
>> Fixes: e6f0d6a30f73 ("interconnect: qcom: Add SM8550 interconnect provider driver")
>> Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
> 
> https://lore.kernel.org/linux-arm-msm/20231218-topic-8550_fixes-v1-2-ce1272d77540@linaro.org/
> 
> Konrad

Ack forgot about it, seems it has been forgotten in the serie

Neil

