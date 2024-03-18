Return-Path: <linux-kernel+bounces-105846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A395087E562
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 10:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DDBEBB21447
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EFE328DD8;
	Mon, 18 Mar 2024 09:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vXj2NRw9"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBFA25634
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 09:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710752674; cv=none; b=hDgqHiF+hagYMDjRQNUdl7ouR4l/QtLfZMjGpI+/KW9Est+PJoAqi1SvSVSyIh13hk0ZOKdLqCYob/q7UFOsP1opZTL8KXxpn/cgTZdsKJ+HVIOomnkKs1lHbvG5Tw2kHP59eO/stdn65aTVJ6UQ6T1Tkup85ciA+DwvKle7JpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710752674; c=relaxed/simple;
	bh=0s+Bo+G3KaxZiyGMieudAdG3u3JDO1GgJ+Hl/tmhrtE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=jM2wXrrJRSQsNS2zwM99LCGFINFRTYqGjjE5Vt53rOtjrRIr8RrD2+e4POSXLjQ4o6hcACPBC6pLN5WU1zvZckNmw2frVhf0VMdyJ5o84Ult3aLXrq+wPfWqdspVmn9K3PKuAPJK0qmlIjcx8f48ZnIlw+zDVzy3ffekag+Jy64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vXj2NRw9; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-513cfc93f4eso4586059e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 02:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710752670; x=1711357470; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Cx67NFg6k3z/hP6o29yTje1Tqs03MrVFCP2cg904mNo=;
        b=vXj2NRw9MNox67D+wkU8HsYWhHBLbkNl4QBADKGFkV2nbcVlijcQq6hv3aIb+6WqCr
         j9OXfay3OH7s0kw2ogMtWHerETPsAsEKrC+kyBsSWg2RnVCDRiBIbarA82S7+LPULhn6
         qW3H/zRbpg+kHxhlqzwO2QWb8k3GHaW7pgnjZHDhSxn1wIaWpECEtqY3ugt1rRUKHR3f
         YhzghcdZ5rnGwy6VQZB2vcf5l24KiwX3OOT5o2r4neGJUiKaI6w5Ow4LqFA7HFaufFrh
         VHa9u9DM4dprBP0NajmSEnXQh6ub+ypZtOGZNaeAxKSikCojhFEnMgFW2T1JuxHB27py
         W9WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710752670; x=1711357470;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Cx67NFg6k3z/hP6o29yTje1Tqs03MrVFCP2cg904mNo=;
        b=rliA0uY3IHjPlN+xw8oaYDEWfruX0wrKru/pS01UxHjwh09WuSd13IiNDHe2+NWCTi
         MQfXAKqVBrE4sEuVj/28WQivRxGNvtE7RxpKSE+r7fJcuHdWFXYdfXElPLeWUGfzLE4i
         CMpjAgS+jet3jWWvh4esVf9GDlAaPnqhdBExurOkYxIwqCyHZRb9FMOKSHa9bKdUbKYh
         Ym0hkGkrS0t4u5omocpU84jfpeyJHsiqrAi3EcLZOce33rUWbFy6I8W5CzKOyekHfgDv
         cOjMY0r1RzRLn3gGr7QKw9PkKaMnJ/3PfgnxrEwBviyEGqzNlw+8I9S0Y0D+I2kQqbIB
         hhTQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+oM0OZAVajtQn9g/R2rFYvYe/nZlniy4ia+zsBiuKkF98VGXCjgdNIOLhRXHH4OSJaDlU7fkV/BQNYxOLVc6tQOBR0Tt9tpbq3eou
X-Gm-Message-State: AOJu0Yzbd2QkX5saN5gJ+/fzO3zaoZ9OwuxyQ8RRrqWQEtWeIwSTTHhe
	07aaqnOpYkghlWftlMinsMvgPd0F2rCp+5i+ser1bxuLJly3UKuJUQYDuI0sKCc=
X-Google-Smtp-Source: AGHT+IFJNcbmM+h1fJhnFwTV+dPLBW03cF7R7EBAdJeE4g3j17IOtc7lNrB7A2u9VRzqdOMZ2U6RgQ==
X-Received: by 2002:a19:2d15:0:b0:513:2329:4308 with SMTP id k21-20020a192d15000000b0051323294308mr8336569lfj.14.1710752669525;
        Mon, 18 Mar 2024 02:04:29 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:ad2b:a316:59d9:3dbc? ([2a01:e0a:982:cbb0:ad2b:a316:59d9:3dbc])
        by smtp.gmail.com with ESMTPSA id r7-20020a05600c35c700b0041409fa57c4sm5752066wmq.34.2024.03.18.02.04.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 02:04:29 -0700 (PDT)
Message-ID: <59580953-196b-482a-bbbd-7f0ff8da75f5@linaro.org>
Date: Mon, 18 Mar 2024 10:04:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH] drm/bridge: Select DRM_KMS_HELPER for DRM_PANEL_BRIDGE
Content-Language: en-US, fr
To: Luca Weiss <luca.weiss@fairphone.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20240111-drm-panel-bridge-fixup-v1-1-e06292f6f500@fairphone.com>
 <b1da07f9-7e15-4d83-bef3-d0ce157654bc@linaro.org>
 <CYGUWBAM3D62.35CPP5HGEYJ3Y@fairphone.com>
 <CZHGFD9QYM82.371U2DPG1AEGQ@fairphone.com>
 <CAA8EJppZRABYGuoDc-6e6VMwtAo3LvEyDpsHdkHFckrR=q+0ig@mail.gmail.com>
 <CZO9HDL1N45S.1JIXM2QUFTQCS@fairphone.com>
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
In-Reply-To: <CZO9HDL1N45S.1JIXM2QUFTQCS@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08/03/2024 10:29, Luca Weiss wrote:
> On Sun Mar 3, 2024 at 9:37 PM CET, Dmitry Baryshkov wrote:
>> On Thu, 29 Feb 2024 at 11:27, Luca Weiss <luca.weiss@fairphone.com> wrote:
>>>
>>> On Wed Jan 17, 2024 at 9:59 AM CET, Luca Weiss wrote:
>>>> On Mon Jan 15, 2024 at 9:43 AM CET, Neil Armstrong wrote:
>>>>> Hi Luca,
>>>>>
>>>>> On 11/01/2024 13:38, Luca Weiss wrote:
>>>>>> Since the kconfig symbol of DRM_PANEL_BRIDGE is only adding
>>>>>> bridge/panel.o to drm_kms_helper object, we need to select
>>>>>> DRM_KMS_HELPER to make sure the file is actually getting built.
>>>>>>
>>>>>> Otherwise with certain defconfigs e.g. devm_drm_of_get_bridge will not
>>>>>> be properly available:
>>>>>>
>>>>>>     aarch64-linux-gnu-ld: drivers/phy/qualcomm/phy-qcom-qmp-combo.o: in function `qmp_combo_bridge_attach':
>>>>>>     drivers/phy/qualcomm/phy-qcom-qmp-combo.c:3204:(.text+0x8f4): undefined reference to `devm_drm_of_get_bridge'
>>>>>>
>>>>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>>>>> ---
>>>>>> I can see "depends on DRM_KMS_HELPER" was removed with commit
>>>>>> 3c3384050d68 ("drm: Don't make DRM_PANEL_BRIDGE dependent on DRM_KMS_HELPERS")
>>
>> Could you please make sure that the usecase described in the mentioned
>> commit message doesn't get broken by your change?
> 
> Hi Neil,
> 
> The problem fixed in that linked patch (3c3384050d68) is about fixing
> undefined reference errors with specific .config setups - similar to
> this patch.
> 
> Since we're only adding a 'select' and not removing anything I don't see
> how it could cause new errors like that, and it does fix the one I'm
> describing.
> 
> And also I checked again and I don't see any circular dependencies
> (something that was also mentioned in the linked patch), so apart from
> what I mentioned with that I'm not too familiar when 'select' should be
> used and when 'depend' should be used, it's good from my perspective.

Sure, LGTM:

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

> 
> Regards
> Luca
> 
>>
>>>>>>
>>>>>> I'm not too familiar with Kconfig but it feels more correct if
>>>>>> PHY_QCOM_QMP_COMBO selects DRM_PANEL_BRIDGE that that's enough; and it
>>>>>> doesn't also has to explicitly select DRM_KMS_HELPER because of how the
>>>>>> objects are built in the Makefile.
>>>>>>
>>>>>> Alternatively solution to this patch could be adjusting this line in
>>>>>> include/drm/drm_bridge.h:
>>>>>>
>>>>>>     -#if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL_BRIDGE)
>>>>>>     +#if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL_BRIDGE) && defined(CONFIG_DRM_KMS_HELPER)
>>>>>>      struct drm_bridge *devm_drm_of_get_bridge(struct device *dev, struct device_node *node,
>>>>>>                                               u32 port, u32 endpoint);
>>>>>>
>>>>>> .. and then selecting DRM_KMS_HELPER for PHY_QCOM_QMP_COMBO.
>>>>>>
>>>>>> But I think the solution in this patch is better. Let me know what you
>>>>>> think.
>>>>>
>>>>> I think this is no more the case after on linux-next:
>>>>> 35921910bbd0 phy: qcom: qmp-combo: switch to DRM_AUX_BRIDGE
>>>>>
>>>>> But could you still check ?
>>>>
>>>> On next-20240117 the error happens in the aux-bridge file instead then.
>>>>
>>>> aarch64-linux-gnu-ld: drivers/gpu/drm/bridge/aux-bridge.o: in function `drm_aux_bridge_probe':
>>>> drivers/gpu/drm/bridge/aux-bridge.c:115:(.text+0xe0): undefined reference to `devm_drm_of_get_bridge'
>>>>
>>>> I'm attaching the defconfig with which I can reproduce this but it's
>>>> really just DRM_KMS_HELPER=n and PHY_QCOM_QMP_COMBO=y I believe.
>>>
>>> Hi Neil,
>>>
>>> Ping on this patch
>>>
>>> Regards
>>> Luca
>>>
>>>>
>>>> Regards
>>>> Luca
>>>>
>>>>
>>>>>
>>>>> Neil
>>>>>
>>>>>> ---
>>>>>>    drivers/gpu/drm/bridge/Kconfig | 1 +
>>>>>>    1 file changed, 1 insertion(+)
>>>>>>
>>>>>> diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
>>>>>> index ac9ec5073619..ae782b427829 100644
>>>>>> --- a/drivers/gpu/drm/bridge/Kconfig
>>>>>> +++ b/drivers/gpu/drm/bridge/Kconfig
>>>>>> @@ -8,6 +8,7 @@ config DRM_BRIDGE
>>>>>>    config DRM_PANEL_BRIDGE
>>>>>>            def_bool y
>>>>>>            depends on DRM_BRIDGE
>>>>>> + select DRM_KMS_HELPER
>>>>>>            select DRM_PANEL
>>>>>>            help
>>>>>>              DRM bridge wrapper of DRM panels
>>>>>>
>>>>>> ---
>>>>>> base-commit: b9c3a1fa6fb324e691a03cf124b79f4842e65d76
>>>>>> change-id: 20240111-drm-panel-bridge-fixup-5c2977fb969f
>>>>>>
>>>>>> Best regards,
>>>
> 


