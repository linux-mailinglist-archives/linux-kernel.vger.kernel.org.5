Return-Path: <linux-kernel+bounces-24787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A752A82C28E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D22D41C21EBD
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 589C26E2C5;
	Fri, 12 Jan 2024 15:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tmgKjx9V"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D7FD6E2D1
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 15:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3376d424a79so4487407f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 07:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705072107; x=1705676907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YlH+RSdYRoNdfUEygz2Iz90RJfaOQT2YtQneGSIE04U=;
        b=tmgKjx9VR4KDZvHWU5+EAOE929PjGRjMgga00/c7QiD2HXr3xigTagwNMKpOPVOL2V
         55R+EEMd4p6VCPZBr8vmawjuUCpaHbJ0jnqm0Ci81ws9YyZ+ok+a+qeXUwQWhJ3ExliJ
         ZhaZcr2eQC7IHR8uarJCQuR6Fpx7TtlQcMp6Qb/veBJ9qTYrqhTDfxbpGLPatR5n8Xgx
         6uehEq9AwnwFRRC52/hHDgwK+1Tq2Szwo43Swp3y6s57CKRWoCnxRzYeJZFLXTCYN24N
         lL/703MWFZ4Byoohpbov5PBqswFaiEj5BYw9udefibtele1dWgzlg41jRv0BC8DEGQNv
         wRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705072107; x=1705676907;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YlH+RSdYRoNdfUEygz2Iz90RJfaOQT2YtQneGSIE04U=;
        b=xT5sqYy4OkdIQWMh3GrvCBN6ZyNVe/SBFFj5U3wnD4LPWgBbOfhvYlT6vrF4RNHr4f
         uBt0qtjPbJXYaUmxcjHypfQRZtGJO7kyskwJPIRqhc43b2Th+cxJZ65dokCEE7vv0e++
         Lpxe7fZDr3E2ZjchixSNtLLCd5JuEfL8RQsUHGuaEB7H73cPtVVn0X1Fsiawoen/4g9V
         MfHMGK2lI/ymH2aDjKRizfA17ewnlAsOrdq2yXTbbSbXLYiVOU/i+xJahYLY6lJ/M2lj
         9lZEDabrjCt5YXhtOLM+RW+tePW3SpyNHAflE1OCgL66zYsfTNEKYW204S7IMAuGMjZs
         EKNg==
X-Gm-Message-State: AOJu0YyHsq4AB2Rfltz43H2hqz6FlFAodx+zd/6jBCaQ6inVoDUuZyCj
	MnDl6B8V5zSASoPPJvU64S8w7USAtm1Vzw==
X-Google-Smtp-Source: AGHT+IHcab6t7oU8df+Vv5MKkJQwgZOMfKP62VXTh5xVxPG6f8EpxAJLVT+q/6kp36EYqcr/SZ226Q==
X-Received: by 2002:a5d:64ef:0:b0:337:97ec:d73c with SMTP id g15-20020a5d64ef000000b0033797ecd73cmr496429wri.22.1705072107391;
        Fri, 12 Jan 2024 07:08:27 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:59d5:231:f1ee:77f? ([2a01:e0a:982:cbb0:59d5:231:f1ee:77f])
        by smtp.gmail.com with ESMTPSA id j21-20020a5d6e55000000b0033672cfca96sm4123938wrz.89.2024.01.12.07.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jan 2024 07:08:26 -0800 (PST)
Message-ID: <98ed4ee9-f381-43a0-a5cc-523ad108b374@linaro.org>
Date: Fri, 12 Jan 2024 16:08:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v14 2/4] Input: add core support for Goodix Berlin
 Touchscreen IC
Content-Language: en-US, fr
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
In-Reply-To: <ZZ-W0UPHOdpU-8el@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dmitry,

On 11/01/2024 08:20, Dmitry Torokhov wrote:
> Hi Neil,
> 
> On Thu, Dec 21, 2023 at 04:21:20PM +0100, Neil Armstrong wrote:
>> Add initial support for the new Goodix "Berlin" touchscreen ICs.
> 
> Thank you very much for explaining how reading of additional contacts
> and checksum works, it makes sense now.
> 
> I was a bit unhappy about number of times we copy/move the data over;
> could you please try the patch below to see if the device still works
> with it?

Sure, I'll test it and report you.

> 
> I also shortened some #defines and defines some additional structures.
> Also as far as I can see not everything needs to be packed as the data
> is naturally aligned on the word boundaries.

Great, thank!

Neil

> 
> Thanks!
> 


