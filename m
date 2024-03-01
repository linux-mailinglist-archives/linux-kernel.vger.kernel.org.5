Return-Path: <linux-kernel+bounces-88289-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD1386DFB7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 11:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0618B24579
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 10:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F34D6CBE1;
	Fri,  1 Mar 2024 10:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cix4wL3c"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8916BFCD
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 10:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709290487; cv=none; b=GhucVYzysufRZwc6F/IGY7LDTB6zjP7d05h4Imx80wmYLjaiRVp7UWnrCc7JTekVIffV1lTDN5PXBMoh5mzomEuKnfsAdWf4tNozo5FkNUKLafGpd8UGN1T0LgjkRVzNZjueNeLrGD5D6t1N15fNB4YY/AskY52L63V/LTdawQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709290487; c=relaxed/simple;
	bh=tDFvi21dKzSYBfpUMY9QvZIm3b44eoXgp0W0nNOW5ZM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=HT2DUqo6QvMEx0CDOq9wOVwWeO7Ms6dtLXRpzQRns5GGqd8hDAlIU6/2In1HWrRnY3mijKg+lESxfl/ShwwiMZM5f8zGpHXQISvYf9ddo2/MQ+FVkr4eOEgSnuFdTo4Q0kvCdCk1M3aGMTdZAGZYLBOcbX+Qeap1kNDKZgdjNj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cix4wL3c; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412a14299a4so14434785e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Mar 2024 02:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709290483; x=1709895283; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h14Xm3TezU8c75lO7pwHUJZjglnS6YlgEv6//zfNa+w=;
        b=cix4wL3c72h6336IorHSs7pglOENbn/cftCEt5DDznioYTu63/tQ28uf3DJ3aaCsCj
         tMlQHCi8nkWAOudAHHgXXqH4pCToPtA7DmRKg+vwGvDd3lxRSbbx3YilWzb7x6f8LUk9
         izlw4JrHxsQgvwhqQYqGPzE9Pg/29ZLT3kMh+wFv6gpPA9IROY2uX5mqT7MP5zC4uv4t
         iOcr/0zjAgDh1u7Dz1uelRjMKZHvCuhXzCWffXNpHRn8TvvjG1egdiEmkmdQnpT/fInU
         +VIyj39bgLcUqmvsR8tJh9pI2+JMvuInoikpeW9/7WMuOgs71ZeGnAo8+EKyK8tmz9wF
         Ae1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709290483; x=1709895283;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h14Xm3TezU8c75lO7pwHUJZjglnS6YlgEv6//zfNa+w=;
        b=r86Xu2ND9LXB95PH52vGw+2aytRQ5rRdAu+AT2AfMiBcE34e6tVfD0n++pTE3q4eMi
         KAyllt52WFsufmI/Q88+JRJBRyMcpz/uCUK4ihkfqcdFSptqzKFb7apOKYAS3smtAtjE
         Bbt+P3k2NHFpji2fxvPjPL0Pirqzo3rDev8TeublFlyBoXDXY1+FBMcks2PoUPNcqmVB
         1AKTXQPcYCFme07MuQcs/l1jpydJEqdFOMWezFg7M0IpZA+9LMatFucDmKkgIdRMHczr
         EGZID6c1/R5JzRF3N/H9LMKxm43v6MjqqraiTKKYFJtcdmbDxkj22UgyyJn2kklwyhpL
         E43Q==
X-Forwarded-Encrypted: i=1; AJvYcCUsJjczY2ldrYnuqhdsjOBEyOK2Y4n8E7/a8A5TlmmiOiQt/WskzC+Ei4D/mZIKSCA4gdWhykur1Z5bbRWwgGEWz9YRqEehHdvzZBvN
X-Gm-Message-State: AOJu0YxWIveMuIucbLmiR8BNd00X9ZuKqTH2MqLKPscKTYQmXsHwPV/g
	Nh87CKMyHcUrkh5LcmGOyW2p1ION7sld82xpfUN4U58YggY6rQymhEGo008B73w=
X-Google-Smtp-Source: AGHT+IGhMHXpAqi5+IVL4bNRROXCyT6HHdikK0xk5w+TzFebmWT7U4TDkmi2gbFJ9VzxjGd/4p2dOA==
X-Received: by 2002:a05:6000:1041:b0:33e:1284:487d with SMTP id c1-20020a056000104100b0033e1284487dmr1056407wrx.31.1709290483298;
        Fri, 01 Mar 2024 02:54:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:8beb:89b5:61ff:3fd8? ([2a01:e0a:982:cbb0:8beb:89b5:61ff:3fd8])
        by smtp.gmail.com with ESMTPSA id v13-20020adfd04d000000b0033d202abf01sm4237067wrh.28.2024.03.01.02.54.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Mar 2024 02:54:42 -0800 (PST)
Message-ID: <33ce8317-0e8c-4fc1-a351-bf76115d89b3@linaro.org>
Date: Fri, 1 Mar 2024 11:54:41 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 9/9] drm/panel: truly-nt35597: Don't log an error when
 DSI host can't be found
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= <nfraprado@collabora.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 owen <qwt9588@gmail.com>, Jagan Teki <jagan@amarulasolutions.com>,
 Marek Vasut <marex@denx.de>, Adrien Grassein <adrien.grassein@gmail.com>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Sam Ravnborg <sam@ravnborg.org>, Bjorn Andersson <andersson@kernel.org>,
 Vinod Koul <vkoul@kernel.org>, Dmitry Baryshkov
 <dmitry.baryshkov@linaro.org>, Vinay Simha BN <simhavcs@gmail.com>,
 Christopher Vollo <chris@renewoutreach.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>,
 kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20240229-anx7625-defer-log-no-dsi-host-v2-0-00506941049a@collabora.com>
 <20240229-anx7625-defer-log-no-dsi-host-v2-9-00506941049a@collabora.com>
 <20240301063020.GL30889@pendragon.ideasonboard.com>
 <fc12dbc9-5c0b-4bff-8754-5b9a5f7b0e12@collabora.com>
 <20240301085624.GC30104@pendragon.ideasonboard.com>
 <ceee318c-1d57-4b3d-9754-1a9ee53fc4e2@collabora.com>
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
In-Reply-To: <ceee318c-1d57-4b3d-9754-1a9ee53fc4e2@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 01/03/2024 10:37, AngeloGioacchino Del Regno wrote:
> Il 01/03/24 09:56, Laurent Pinchart ha scritto:
>> On Fri, Mar 01, 2024 at 09:44:36AM +0100, AngeloGioacchino Del Regno wrote:
>>> Il 01/03/24 07:30, Laurent Pinchart ha scritto:
>>>> On Thu, Feb 29, 2024 at 07:12:15PM -0500, Nícolas F. R. A. Prado wrote:
>>>>> Given that failing to find a DSI host causes the driver to defer probe,
>>>>> make use of dev_err_probe() to log the reason. This makes the defer
>>>>> probe reason available and avoids alerting userspace about something
>>>>> that is not necessarily an error.
>>>>>
>>>>> Suggested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>>> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
>>>>> ---
>>>>>    drivers/gpu/drm/panel/panel-truly-nt35597.c | 6 ++----
>>>>>    1 file changed, 2 insertions(+), 4 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/panel/panel-truly-nt35597.c b/drivers/gpu/drm/panel/panel-truly-nt35597.c
>>>>> index b73448cf349d..d447db912a61 100644
>>>>> --- a/drivers/gpu/drm/panel/panel-truly-nt35597.c
>>>>> +++ b/drivers/gpu/drm/panel/panel-truly-nt35597.c
>>>>> @@ -550,10 +550,8 @@ static int truly_nt35597_probe(struct mipi_dsi_device *dsi)
>>>>>        dsi1_host = of_find_mipi_dsi_host_by_node(dsi1);
>>>>>        of_node_put(dsi1);
>>>>> -    if (!dsi1_host) {
>>>>> -        dev_err(dev, "failed to find dsi host\n");
>>>>> -        return -EPROBE_DEFER;
>>>>> -    }
>>>>> +    if (!dsi1_host)
>>>>> +        return dev_err_probe(dev, -EPROBE_DEFER, "failed to find dsi host\n");
>>>>
>>>>         return dev_err_probe(dev, -EPROBE_DEFER,
>>>>                      "failed to find dsi host\n");
>>>>
>>>> With this addressed,
>>>
>>> I disagree. That's 87 columns, and the 80-col rule is long gone.
>>
>> It's still a maintainer's preference. I soft-enforce it in drivers I
>> maintain. In this case I'll let Neil decide, as he's listed as the
>> maintainer for drivers/gpu/drm/panel/.
>>
> 
> Yes, that's right. Comes down to personal opinion.

There always was an exception for strings to go over the 80col, and I like it better as an one-liner.
So I'm in favor with the initial proposal.

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>


Neil

> 
> Cheers
> 
>>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>>
>>>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>>>
>>>>>        /* register the second DSI device */
>>>>>        dsi1_device = mipi_dsi_device_register_full(dsi1_host, &info);
>>
> 


