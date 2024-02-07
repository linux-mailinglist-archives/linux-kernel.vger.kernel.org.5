Return-Path: <linux-kernel+bounces-56199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42CF484C740
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 10:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E6161C25441
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 09:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DB46210EC;
	Wed,  7 Feb 2024 09:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MXC0Hfcc"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC24820DC4
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 09:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707297853; cv=none; b=N4tdHQxeQOOBUK5oWMOWOOVswL+JnXNqt5FiDBBl9Lo1TqHN9UXgvvT+ucuMhP5gErzcSAdmkOfRsvUFpZsL4tUrJeQ+10xulcR2seXsrLRFRJogl1o5o+k5Tdf2tFdzUrtZto4LcZYSJR2pT1Z26joMNAXCY5ecFnsznvwIJvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707297853; c=relaxed/simple;
	bh=/a0vIa4et3RkPen+x9ntdcMgu3Luz7mg6TfMPDyIYuw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=f0NJ7qKPEZyf1y+dS0m1zXLMsy58O12ptr76nv5JxA9Njojr0aKARJqrAwjn0P9Ohl18EZkH4wlJ1sBxGXvudEIqXyVkOc6UmVpcveOBdP5BRMYbBQwd38AVTxxV8mFPMq9it/mwLBbZV6yxL80A3FLZGlbT8JPvELugmx53xEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MXC0Hfcc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40fe59b22dbso2884165e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 01:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707297850; x=1707902650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zo6yUyG1s8prj2OzCo9YS/8+1Ln1HdjhhiH9cZ+GZgQ=;
        b=MXC0HfccI8tfuc9ZrqJtorPHmHxLJMlF5g+EeXVmDOxWr4JJTIvpO9UdXovQ9/U3IT
         bcuF4ZgEe2Ima5/OL39dmxgmQzH0sy+cBYQ0rlXg0VDDOXK5yOFMGE91eaHpGEkWAn4m
         pIVr+IX5yZS6BMAi5G1/t0hr6r839BsuwzyuBJ5L10rLei6+tE2IgOTM/K3CuiKDF63L
         aJYE5Rb8f46SXZQ5Z0RPNHkN8iWx9BoQhBLO8GAZECdAslcO8PzDVziema+ZTZDyAaDC
         mmSTxWDL2mp/nSFuWli+6sHHYcwNUyoc22RencbnMuQrHP6C+1IO6Ews53xkazSgJse/
         P0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707297850; x=1707902650;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zo6yUyG1s8prj2OzCo9YS/8+1Ln1HdjhhiH9cZ+GZgQ=;
        b=ToLC2co8ma/4A4puwdch14CsCzI8lWI0avfBwRysgzeGJEPJHN+lsWWULZTxIQqqKr
         W2QMC/LXT0/FMZx9IENfWwBHhLX+wAvjucX6bLosDgUUA+HLrsZB0KNfbOvIQow9d2/7
         lhIj9r6WE4JKJY3cEKAMfrkRzUoqJgcApL4JJaj98phNemenvTm3M5ZiwlDB8JOhrMpN
         kWlJz566D5TyhZpTFF/shjxPRfAdTsCJTXZ7CmZQ+hrbXdaBC9k2CcfcBQ0evXNVOK4X
         lqokTxjCmUcxxhMTy3gXORhOgmbf2QyEEvY3AMD9UTNW95ySEjWl8hWtBZKvOxVN2Hi2
         QUiw==
X-Gm-Message-State: AOJu0YwV+E8bjfrwalPc7OlRF86QSV+hjqRYsfMkhT+I/7KqjtZhRIOW
	kzA6tfQi56GDTTdw+w388Cisz2HkYGCUzW/LyNWkd/sRfJOcK0wjct8vPQjKdSk=
X-Google-Smtp-Source: AGHT+IGe2pU6iQCDttbsluezhdBi1CzVp4sdFRKfgyxD3wTU1d1ys8zg92ip5IfJ0ueVYpI82aZ7UA==
X-Received: by 2002:a05:600c:5612:b0:40f:d3b3:b6d2 with SMTP id jr18-20020a05600c561200b0040fd3b3b6d2mr4062915wmb.14.1707297849851;
        Wed, 07 Feb 2024 01:24:09 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUxnV2TfuOXYpdtmQNNXwULpzmPJaVG7nA+/wdIgXxMKxV6M0NDIkyY2VylHXYREpKV6p2s+3U796DI90OTR1eSDbg1RZlAhhaukJjAIGf/tPY5C/v3bkdKPdQDqVfFoipvjSk5lXXjkG4uPQWKou5G+iQj/RIjS9Gs2RbxFTZOQVm+PzwWY8buU9mhK24ZfutSizj3kxNISTemK/BLKxB3dTzJHzzauV1rb1LcgunHxcy9d7PHshfe4RTzbdRxxTaNmwudjEOhhHGmkYiNWlDiUiW/7tls8X2huGfEMaokIi9w0YYwl8a8/ReUVKIaHrvyYUizvE7iLAB/lp6GysAfBaFEt7bPGw3W6mFdbdvlL0D5EKoT/tAEdjp2vRSH/YCtKt+fhmEORcDL/+wRrEwNWpafACfflItlJKzx/iaMEhx0GnHrGit9o9Y+rJ0AvsaeprKxlpECmQt18CBprxvupQwH6pUe9rd+Ni3GhBUsHX3G+hChUrpxQQ3wY3YIcpj8EZ1HmnQy16JruDdqIoAyKEUtFg7ku1YdliEG3as4RvF6kPvq6CuT6ivvJPVjUzzUoVTWAkzeqGCs2NtQKpQC0g9USxXyoL5QLqr5Jd+RXZErf0kKcaqo08NNYmlYKCNxHHTt46koxp+rUtuh7MgBVO43XRodN8WCaWra7+BUB+dzj88prZ0Mg8L8qhMW1GV4a9YjrSFJTrTvy6i1y7lNsbmh4U7mpKwUpuXQdfuZ
Received: from ?IPV6:2a01:e0a:982:cbb0:5ae7:7fdb:32ad:f6d7? ([2a01:e0a:982:cbb0:5ae7:7fdb:32ad:f6d7])
        by smtp.gmail.com with ESMTPSA id f8-20020a05600c154800b0040fb03f803esm1434724wmg.24.2024.02.07.01.24.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Feb 2024 01:24:09 -0800 (PST)
Message-ID: <7b71ab7f-7ea5-4144-a7c5-d0b66ab13476@linaro.org>
Date: Wed, 7 Feb 2024 10:24:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/bridge: imx8mp-hdmi-pvi: Fix build warnings
Content-Language: en-US, fr
To: Fabio Estevam <festevam@gmail.com>, Adam Ford <aford173@gmail.com>
Cc: dri-devel@lists.freedesktop.org, nathan@kernel.org,
 kernel test robot <lkp@intel.com>, Liu Ying <victor.liu@nxp.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Lucas Stach <l.stach@pengutronix.de>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240207002305.618499-1-aford173@gmail.com>
 <CAOMZO5A1yiXiLOtR=H_4vJYAMGwjpqrErCzvSkmLoB_f6_rN_w@mail.gmail.com>
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
In-Reply-To: <CAOMZO5A1yiXiLOtR=H_4vJYAMGwjpqrErCzvSkmLoB_f6_rN_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/02/2024 10:22, Fabio Estevam wrote:
> Hi Adam,
> 
> On Tue, Feb 6, 2024 at 9:23 PM Adam Ford <aford173@gmail.com> wrote:
>>
>> Two separate build warnings were reported.  One from an
>> uninitialized variable, and the other from returning 0
>> instead of NULL from a pointer.
>>
>> Fixes: 059c53e877ca ("drm/bridge: imx: add driver for HDMI TX Parallel Video Interface")
>> Reported-by: nathan@kernel.org
> 
> The Reported-by line format can be improved:
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> 
> Thanks

Fixed while applying,

Thanks,
Neil

