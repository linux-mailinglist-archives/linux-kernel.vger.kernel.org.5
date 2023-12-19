Return-Path: <linux-kernel+bounces-5154-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B2B818744
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 13:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8296285063
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1014217741;
	Tue, 19 Dec 2023 12:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lDa1Qz4G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35516179B5
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 12:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3365d38dce2so3357153f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 04:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702988415; x=1703593215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0CXfSGXxmjhUY4+xy/DUIZgp4voh0kUDko4V3IRjf70=;
        b=lDa1Qz4GlGy10gcOQO8rQlXfIynGZuUUTyhxQMXyspV/I2j9UZBhG5Cp9QWf5DJxIG
         OFVMZsXj/7e4a04UOfeUo03JoISW47xpSmiuDZ+meelbglNSqxvHou9awSE/iENsxMAI
         JY0KHIM4vTwkm8JQ4Ds5mHK/MzpRvnTarcODVt4O3dL4CcrCEeK173SZZnGIcb+cAqBb
         /r9ysqi+wpmu/8em5T3Q6cCb2tEXLodON+x6g4u49gYfCIK5ViDHgVvjOmxORI2mCV6F
         A2VhuKkXoCQxXizi0Inmf7M7Os0Q2tCGzkr0j6M4iz6XNcftNc9I3ji3VX2s4SmYQSQW
         o+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702988415; x=1703593215;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0CXfSGXxmjhUY4+xy/DUIZgp4voh0kUDko4V3IRjf70=;
        b=GINAbevhBRTyoTwuENOkfdYyDDg8ExJhOv8AUVALll53Ayb5wGyeMUEob2jyEhOtiM
         QqEsBLuVlsQn//8h/zBw7d4zomM9Mj8trY9sB9oFHZnvewS6y2aL0G1C28Y/mH4vX84r
         Zq6jU6DV1Kz7tI6uI2mczO0tfQa+aQmu2mh1Uq0vWdAm/3md9dkU9R8Q/bMgo78jAhmB
         EdDS32vj9YFwnL98wZcs7E0h4CaENgRMcUJjnUTxCDg2CukCNZoqhetVSLtLUzOC3IXa
         QZznfGyteYvfllnEkmojt+8mz9SV6W4sEK56sClSUkR8CS8prqFESnVCcGStVEHs+w9Q
         ligA==
X-Gm-Message-State: AOJu0YwHOzXyZBE9cmmUDen8ftKRq/LOr5ZunaoOimK87VAdy+6bya/t
	2tdDzt5+r+HpEQfn3plq7+HZ5g==
X-Google-Smtp-Source: AGHT+IF+9/A5fw0ZxJcB6GgU+T18T+2PG7ccihhCEdn2ktqg+pNnxKHQQfJcErXNqnssntEdm+sJ2w==
X-Received: by 2002:a5d:69c9:0:b0:336:66eb:e7b4 with SMTP id s9-20020a5d69c9000000b0033666ebe7b4mr1461981wrw.7.1702988415170;
        Tue, 19 Dec 2023 04:20:15 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:e99:1baf:483a:7533? ([2a01:e0a:982:cbb0:e99:1baf:483a:7533])
        by smtp.gmail.com with ESMTPSA id f10-20020adff8ca000000b003365951cef9sm10876976wrq.55.2023.12.19.04.20.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 04:20:14 -0800 (PST)
Message-ID: <05473bb7-28ec-452e-9fc7-8f244c8b5de3@linaro.org>
Date: Tue, 19 Dec 2023 13:20:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/2] arm64: dts: qcom: sm8650-qrd: add USB-C Altmode
 Support
Content-Language: en-US, fr
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20231218-topic-sm8650-upstream-altmode-v1-0-7900660693cf@linaro.org>
 <20231218-topic-sm8650-upstream-altmode-v1-1-7900660693cf@linaro.org>
 <5b453356-f2bd-4703-8761-5311b5964f6c@linaro.org>
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
In-Reply-To: <5b453356-f2bd-4703-8761-5311b5964f6c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 19/12/2023 13:06, Konrad Dybcio wrote:
> On 18.12.2023 11:26, Neil Armstrong wrote:
>> Add the necessary nodes to support the USB-C Altmode path by
>> adding the following
>> - WCD939x USBSS Mux I2C device
>> - nb7vpq904m Redriver I2C device
>> - Port/Endpoint graph links bettween PMIC-Glink, Mux, Redriver and USB PHY nodes.
>>
>> WCD939x USBSS port 2 Path to Codec will be added later when Audio support
>> is added.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
> [...]
> 
>> +&i2c3 {
>> +       status = "ok";
> "okay"
> [...]
> 
>> +&i2c6 {
>> +	status = "ok";
> "okay"

Thanks, I should have passed DTBS_CHECK first...

> 
> 
> Konrad


