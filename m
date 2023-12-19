Return-Path: <linux-kernel+bounces-4939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A138381841F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 10:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B23A61C23A36
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023D912E44;
	Tue, 19 Dec 2023 09:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SP6XpKFB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032F8134AE
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 09:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3366ddd1eddso1610765f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 01:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702976815; x=1703581615; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RDqC8mlmI0zifdWF6zhA4HVQDLdCJIzhq2G0yUNbN+U=;
        b=SP6XpKFBf/Dam36RWOlQ4c3JCjLJxLbrpWDOz2NvMfZ+5zMn2NRB3y0c+4CRa5PAbc
         iWLqMKt7xvm8nMWjOz/9wRdX+epnyUPnrxIBCJTraQvUnoVGr5JcL0XBCNOxTRfMhhcc
         Lz5k/GwayVjcPV5q6z1Zy0zyVf540R36xTsGTCaXjsC7K3kc7FcTeXPM5XVMYh4iFcCV
         YR3Ag87mg1uzn1bWApKs5SCpJuYub98dku9Xt9Sgyv1IPZaDIKAs+Lf1safiIeNrlsHy
         X+IqRZhQy9Uu+ERj8JxeClDd2iiT7lgzsE21sSnJwob8OFiDQ5vCnquFp3KV1sWHxA2l
         lyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702976815; x=1703581615;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RDqC8mlmI0zifdWF6zhA4HVQDLdCJIzhq2G0yUNbN+U=;
        b=KXuf0943FBqFkIiX1xQFE7z0xghwvnNwgWldncUKJ28oysv9uFpzBbtYHkMmsuvx2V
         gbhabv7zjohErCl+NfvUu0eCfiHWrt9y1H09FzC1k8YYRGbfZJw+RvVtpuEgNm3aBywS
         p8sN6G90JDqG9i0uoW70KTnud0XmtGfSmullGJMN0Q2qvjJ32h1qdLE3Jnlv3hkQfmxC
         kSma0FQ2f8ODlFhEC/n08e40xK3ZQgJOqn08Xw9t6C2YFzkAFMGQQ42UxneiudJFS6bz
         zZqwVVnFO7bWIrQ9QablfjlnKtXs9wdGweQ7r6AndRpNbMmPIXw454IJGz3QZxnLqEef
         gXeQ==
X-Gm-Message-State: AOJu0YxN4deL/ILp4TYm9NuF77a12y+SvMY2WR8T+0iU6RfuB4Y6OjwU
	sxRnWEhQmEyDc7ksIV0o3zBtog==
X-Google-Smtp-Source: AGHT+IFN8G5/Lgsr+ycIlj6IKKA3b++uKO1oEZgohuUof2lngQpHf+MVMOCmZrneYpdXMAHqLDK7kA==
X-Received: by 2002:adf:e58b:0:b0:336:4c3d:91e6 with SMTP id l11-20020adfe58b000000b003364c3d91e6mr2194897wrm.271.1702976815185;
        Tue, 19 Dec 2023 01:06:55 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:e99:1baf:483a:7533? ([2a01:e0a:982:cbb0:e99:1baf:483a:7533])
        by smtp.gmail.com with ESMTPSA id l17-20020a5d4bd1000000b00336607f6630sm7841873wrt.47.2023.12.19.01.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 01:06:54 -0800 (PST)
Message-ID: <73b45f8b-f8a5-47cd-87f1-c522ae908769@linaro.org>
Date: Tue, 19 Dec 2023 10:06:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org, linux-input@vger.kernel.org
Subject: Re: [PATCH v13 0/4] Input: add initial support for Goodix Berlin
 touchscreen IC
Content-Language: en-US, fr
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Bastien Nocera <hadess@hadess.net>,
 Hans de Goede <hdegoede@redhat.com>, Henrik Rydberg <rydberg@bitmath.org>,
 Jeff LaBundy <jeff@labundy.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <20231213-topic-goodix-berlin-upstream-initial-v13-0-5d7a26a5eaa2@linaro.org>
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
In-Reply-To: <20231213-topic-goodix-berlin-upstream-initial-v13-0-5d7a26a5eaa2@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Dmitry,

On 13/12/2023 18:13, Neil Armstrong wrote:
> These touchscreen ICs support SPI, I2C and I3C interface, up to
> 10 finger touch, stylus and gestures events.
> 

<snip>

Gentle ping! Is there any chance this driver could land for v6.8-rc1 ?

Thanks!
Neil

<snip>


