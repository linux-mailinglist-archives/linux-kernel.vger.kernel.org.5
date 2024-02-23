Return-Path: <linux-kernel+bounces-78506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9204861446
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45414B21260
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D6D21341;
	Fri, 23 Feb 2024 14:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kYYlDBUF"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A269E126F39
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699098; cv=none; b=STiCH7JBw8a9yNXbQOLey3D7cU3mYc5WIHfdY0lrTEv/1D7HD/I2MWRpt8wSa+yZZ/Loc4zDMmU5pR5mO9pZP6231XqMPZHSoaM71rWY3X8Gxe/JJeu3ESjI/tey5FgmUpvyVJZw5VF2ktXMEzgU8YHjrrUv3XdPp/Us6t/srF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699098; c=relaxed/simple;
	bh=bYPW0B0WRHp4T/K5Sfi4ZFL111WJj0i4hsvjHUkHuXQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=hKDJO2jhSsjH4cfHIJW5y+z4uJX4HpaRtppinWSWo0KjmOwNfMEtjxt3bK9pOuDHwvyzMYXtgwmcl93cWeTMYdJnKf3cQN+HMZ7JWzBqqyEBorenBx8YbFp2kqpmtWL85BOQD9KOcrnwMmZqIcyh/d7ypNH8TCfp743GPvutM18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kYYlDBUF; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4125e435b38so3078325e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 06:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708699095; x=1709303895; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OijQr4Cr1wWVumHbsjNdZzaJgYfpd0n4qUPdqEIlqC8=;
        b=kYYlDBUF4Ge3Pp9x3GP78SKxPEoh5HTLPyQWEn0PNwjZd8/RjsPKguqcHDjaiWkgeV
         q2alnWyJkIcHx/myfBa8fsA4Q+FLCVRBBP2gKmbMuVbPgSSgUe4O9bVNM023BKcgW75N
         a9Ibswisb4kTH7WmFeCICb4sOl7L1cV+l9Bo1xKeoCJ8Fqbk7oF2Zcl4wrkoEwrJhTOd
         j/9DszcFt8nzm+KoBQqJZ+UfrtCwlrDJCzglr7K3wAhPXKlu3rVzG3hW/+fFWOdS1jPL
         uTF5chTix+x58MkDVRV0EwIW45M3rsLVq5w441yO6XZ3nJ+jj/ajuc8E2uSlI/WsVZXd
         xPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708699095; x=1709303895;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OijQr4Cr1wWVumHbsjNdZzaJgYfpd0n4qUPdqEIlqC8=;
        b=BHtNi0jGYTWsW74qGHUPiLrp7j17SCGBumJ87eqcLCJ3Q9CJRg/c4lvRu82o6G35RU
         a4IvxfsufzrPcX3E2TWf8z9eHYlmR559m03VrVzJE/HOMPV93V+Db07yKJStOsxMmUt0
         aY/8DFVW1bYX8kYHygJqPG/rs81wyaqK/6jaKzeXPFdq63CqRUmaVhqXcW3rBu9C7bTR
         4b/0Fc+jGKCMXmgIvC1hvSiknvpTwV0isRUnJYOhOu4PLyKyvtzSEawK+srhGSSC16Em
         Tw8dD3y1wGOY28ecoUEUOaGzslOFzxSUR/IrxqX//yulBwMnkY3cROj52acubGUlGNVk
         IbxA==
X-Forwarded-Encrypted: i=1; AJvYcCVc8vYGVR0ocL/yFMqUR9/VHQnx3m17xxbZV82R4St8H5qEmemNfLrhetn8t0Ip2BQeEhTjXcqVsvKXoBmFyu+prIdVt9A+L55whID3
X-Gm-Message-State: AOJu0Ywe9kYQt1XPO9dpX4xC250u/Y6/cix5g3m844CBMa1RkHLrpuEY
	fBv/n3vuPlAr9AnOZoEJJrw5b+J4YItpPDgFkS1FtYKQ5Qc5O32kPaKqsxCafDY=
X-Google-Smtp-Source: AGHT+IHXnSkol2aJhEp+L08VZUe6Bf4+k2kUP/mYBPqvfHWEIG2AEabojynlyu84aR966Z4ypczRBQ==
X-Received: by 2002:a05:600c:3ca6:b0:412:78e1:5089 with SMTP id bg38-20020a05600c3ca600b0041278e15089mr18436wmb.13.1708699094868;
        Fri, 23 Feb 2024 06:38:14 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:58e3:6b80:c446:11f4? ([2a01:e0a:982:cbb0:58e3:6b80:c446:11f4])
        by smtp.gmail.com with ESMTPSA id c14-20020adfe74e000000b0033b87c2725csm2922134wrn.104.2024.02.23.06.38.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 06:38:14 -0800 (PST)
Message-ID: <77715ecd-ddb9-450c-98bf-4fcade0e81c0@linaro.org>
Date: Fri, 23 Feb 2024 15:38:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/6] soc: qcom: pmic_glink_altmode: fix drm bridge
 use-after-free
Content-Language: en-US, fr
To: Johan Hovold <johan@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Vinod Koul <vkoul@kernel.org>, Johan Hovold <johan+linaro@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Kuogee Hsieh <quic_khsieh@quicinc.com>, freedreno@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org
References: <20240217150228.5788-1-johan+linaro@kernel.org>
 <170868613914.4029284.5549880672870201262.b4-ty@linaro.org>
 <3c4246b6-431a-442e-8ace-3b0d0e67743f@linaro.org>
 <ZdiU2z8rzo542_Ih@hovoldconsulting.com>
 <d4049823-ad24-4426-887b-9c66cdd96318@linaro.org>
 <ZdiqAPPTn9SvsjL8@hovoldconsulting.com>
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
In-Reply-To: <ZdiqAPPTn9SvsjL8@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23/02/2024 15:21, Johan Hovold wrote:
> On Fri, Feb 23, 2024 at 02:52:28PM +0100, Neil Armstrong wrote:
>> On 23/02/2024 13:51, Johan Hovold wrote:
>>> On Fri, Feb 23, 2024 at 12:03:10PM +0100, Neil Armstrong wrote:
>>>> On 23/02/2024 12:02, Neil Armstrong wrote:
> 
>>>>> Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-fixes)
>>>>>
>>>>> [1/6] drm/bridge: aux-hpd: fix OF node leaks
>>>>>          https://cgit.freedesktop.org/drm/drm-misc/commit/?id=9ee485bdda68d6d3f5728cbe3150eb9013d7d22b
>>>>> [2/6] drm/bridge: aux-hpd: separate allocation and registration
>>>>>          (no commit info)
>>>>> [3/6] soc: qcom: pmic_glink_altmode: fix drm bridge use-after-free
>>>>>          (no commit info)
>>>>> [4/6] soc: qcom: pmic_glink: Fix boot when QRTR=m
>>>>>          (no commit info)
>>>>> [5/6] phy: qcom-qmp-combo: fix drm bridge registration
>>>>>          (no commit info)
>>>>> [6/6] phy: qcom-qmp-combo: fix type-c switch registration
>>>>>          (no commit info)
>>>>>
>>>>
>>>> To clarify, I only applied patch 1 to drm-misc-fixes
>>>
>>> Ok, but can you please not do that? :)
>>>
>>> These patches should go in through the same tree to avoid conflicts.
>>>
>>> I discussed this with Bjorn and Dmitry the other day and the conclusion
>>> was that it was easiest to take all of these through DRM.
>>
>> I only applied patch 1, which is a standalone fix and goes into a separate tree,
>> for the next patches it would be indeed simpler for them to go via drm-misc when
>> they are properly acked.
> 
> But it is *not* standalone as I tried to explain above.
> 
> So you have to drop it again as the later patches depend on it and
> cannot be merged (through a different tree) without it.

drm-misc branches cannot be rebased, it must be reverted, but it can still be applied
on drm-misc-next and I'll send a revert patch for drm-misc-fixes if needed, not a big deal.

> I thought you had all the acks you needed to take this through drm-misc,
> but we can wait a bit more if necessary (and there's no rush to get the
> first one in).

If you want it to be in v6.9, it's too late since the last drm-misc-next PR has been sent
yesterday (https://cgit.freedesktop.org/drm/drm-misc/tag/?h=drm-misc-next-2024-02-22)

Please ping Thomas or Maxime, perhaps it's not too late since the drm-misc-next tree
really closes on sunday.

Neil


> 
> Johan


