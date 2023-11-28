Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7A667FB41A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344098AbjK1Ia2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:30:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbjK1Ia0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:30:26 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5094F5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:30:32 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40b472f98a3so13263395e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701160231; x=1701765031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UI9+225njmRZsv7a13t5KhvN35Dxdfq3Mcv8/7dVTvQ=;
        b=AAQaX2+HTszVVCHTSM4KOiSUIILpn+1cHo/3+OCJNbZ1+n2obwACmY5My/7FaSnOQ9
         QvOT7cQJC9WW1XqSoGmi04oOEbRBmn85S1yJ4rkwt9b1CwpQtOmzSDUe8Ms/IbhKSf83
         6ZfbXV49F6b8jq2+0bsjw7694PfVZFm+DTwMfO/8YjxI1YlUBVTeYBdODGKYVKNqNw/w
         g7aZ5cyd4Me7wqjMgSlJtBSpzzsM6sUNjs1R1iWNVhfSHfruUKCSiHYdXwcRY6VPWcMF
         +utnJvSUpKV2EDtRi9vYtVjcyBTzq8DNEZ+tZm87UiF7kTXQZ6WHG4pmoj3BaorX0CqW
         eDyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701160231; x=1701765031;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UI9+225njmRZsv7a13t5KhvN35Dxdfq3Mcv8/7dVTvQ=;
        b=I+vxdDa2MEwSsP8GsuPe/jbKmistoGMh7+mjZVwJLI3UQJLkB+e4TjWM9zzT6YaSJf
         zKPhuR8QS8PY4VbkpAErEZyUggEnn7R5gbxtVfD+6+skPy98k4EY0CY9s6+1gBhGgDOm
         yrBaCp8zgkA2HcYIQWGx+XJKfwFxlJusU4zVE2QImlCYBavXJ4okV8ybBMIrqNm2uR3o
         dutFYbxw3i6uOfbKttW3OFWYFuDDmOV3CyTSJYmtsznnzFmanswaDJrnaT2SqDXETd/Y
         0pHccrmvZR6w6zXyO07lSvtUWz6M1l82LoBhMT24I29/v6kZtW2+CaC58BFc/JLqMxiR
         mzEQ==
X-Gm-Message-State: AOJu0YznhRdKc3pYkerntypLS3FKbZ5+vT8ASaO2wSP4Z93WqUURMSLh
        xMJOGykEeB32xjhZGVCtR2ta4w==
X-Google-Smtp-Source: AGHT+IFG4ZA6yx2M3SuXLBx5tg9XX22OhbiKLyWiaklFEpGLpkLApKcdMmQ84H3CIiYxHxq1JqlWpw==
X-Received: by 2002:a05:600c:314c:b0:405:95ae:4a94 with SMTP id h12-20020a05600c314c00b0040595ae4a94mr9142353wmo.5.1701160231062;
        Tue, 28 Nov 2023 00:30:31 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:eada:f40e:7ab3:2afe? ([2a01:e0a:982:cbb0:eada:f40e:7ab3:2afe])
        by smtp.gmail.com with ESMTPSA id n16-20020a05600c4f9000b0040b38292253sm15217322wmq.30.2023.11.28.00.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 00:30:30 -0800 (PST)
Message-ID: <80be087e-0341-487f-b6d9-8772d7c6128a@linaro.org>
Date:   Tue, 28 Nov 2023 09:30:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/3] Revert panel fixes and original buggy patch
Content-Language: en-US, fr
To:     Linus Walleij <linus.walleij@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Liu Ying <victor.liu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20231128-revert-panel-fix-v1-0-69bb05048dae@linaro.org>
 <20231127232542.GB25590@pendragon.ideasonboard.com>
 <CACRpkdYWjHbgWQc46hGM3bg+5nf4NiveEZJmHrnx0X-=XsUDLA@mail.gmail.com>
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
In-Reply-To: <CACRpkdYWjHbgWQc46hGM3bg+5nf4NiveEZJmHrnx0X-=XsUDLA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 28/11/2023 00:36, Linus Walleij wrote:
> On Tue, Nov 28, 2023 at 12:25 AM Laurent Pinchart
> <laurent.pinchart@ideasonboard.com> wrote:
>> On Tue, Nov 28, 2023 at 12:10:18AM +0100, Linus Walleij wrote:
>>> This series reverts the attempts to fix the bug that went
>>> into v6.7-rc1 in commit 199cf07ebd2b
>>> "drm/bridge: panel: Add a device link between drm device and panel device"
>>> and then it reverts that patch as well.
>>>
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>> ---
>>> Linus Walleij (3):
>>>        Revert "driver core: Export device_is_dependent() to modules"
>>>        Revert "drm/bridge: panel: Check device dependency before managing device link"
>>>        Revert "drm/bridge: panel: Add a device link between drm device and panel device"
>>
>> To preserve bisectability, you should revert in the opposite order.
> 
> You mean apply patch 2, then 1, then 3 so the kernel builds after each
> revert?
> 
> Yeah that's a good idea, I don't know if I should apply these though, better
> someone else do it since I screwed up too much.
> 
> Another option is to just squash the reverts into one, that bisects too :/

You can apply them now, or tell me if you want me to apply them.

Neil

> 
> Yours,
> Linus Walleij

