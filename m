Return-Path: <linux-kernel+bounces-127589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34D67894E07
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74A17B23CD1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD80A53380;
	Tue,  2 Apr 2024 08:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YP9GYB5F"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31711755A
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712048127; cv=none; b=ak9+4pHwGuRxenolQQEmZ7phmtrZlIxltMbrvC7NF7LkfiDNSV0gBKowdQxDXjaTlLFnjWc+zL/DzCZeGoffG9eDv7RjT6T6CLxzxNt2EGCxKq1p+kGH/I+gU/m4FmUvl13W5eUiCT5m35hfmwM9V45ZMqoHNwbgWXA/jw/5mmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712048127; c=relaxed/simple;
	bh=GoZzy3W9SDIrytQtUtf4X0vG831YuGGavZOiX3+ZiAs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=re5s+Vg0B4PVjknt9cgil9bNsAwIEL36oP/Aa9+xTXd/AwyX5ywvBYcPd50SUWWT8nf69DLMRHRx9id1oA2s/8FzwFcVE9ngNzM6URL7RnA+YhVhuTWmgv4Slufog5oLjFC5D+Il+Diah08DuiyLQFuDT87rdkmmHJw8dCPr/DU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YP9GYB5F; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e0b889901bso38651495ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 01:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712048125; x=1712652925; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f+R+mLMFOJFLXv5vS3Pr1o1ss6hqvr1UyFoTXxVcLIo=;
        b=YP9GYB5FOf5ndzhyckAkZhUOzoCMvQDBB3kq0a/inhBni8EH0KM1/RiQMSss0n1LPj
         Qz7UCb9mApZRnfg1U2GEk0KtAe5x4Kzz0fbLriUkzhxda5PBXjIWmqf3ZlsmdMl6SvGC
         ezGHaYysKojdiJyPsPUMIlVwAh4Yhn0+pGGfZm6RRC67Fe55+xRzw0hJVvCpVPxtTW4F
         qf136Fc98R9vdsnoQofsMAIParoA/OPePTtc/COArl4rBYu9pxO1r0gbXe0UaZKEvss0
         9JucN0z5pwnQw5gKljGFy77jqcCtRRYl0ON8ZJ5xcHQuyklCNvCavZlEwmjWxn0w95nM
         YLLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712048125; x=1712652925;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f+R+mLMFOJFLXv5vS3Pr1o1ss6hqvr1UyFoTXxVcLIo=;
        b=UIzyXDBQUjpv4gmroehaVMf/S/mMN7IPsyZOQBXDX9+v4WpMPVCgb8Dzll9yD/UVlN
         +VUo14KpJvjrW3SEaBeVyS2ngDnJyrLgEN5iJHiKBRwXI4SUzQzqxiIuxXoMHEG+Rd3R
         C6e7debnA+j+RsMiughu5HBWIGcC5Yn38EsgrR9qgFHmkBZMJZvqa3Tvjls8uF7mpYZg
         ddwggyDMj/Q2JlnP10SK8U6d3cN1XmbImy2dtmNY62dk2Pmtp1G6OcatYrzjqQNwT6k+
         nJhCdYX1nODq9IfQ7ldnISMTgu6X5gpVWO1obJpVmz0qHS+YnYSUBNOCDATIqbqYy7o2
         YCcA==
X-Forwarded-Encrypted: i=1; AJvYcCUIdDFLxLsM5FaSGN+OKKTv/97eWbpGTaWvOwpucEAUQik1grif+4PR6ACxepmvwTW5np1K8d0Vi6DWt4w23pRk2XWL+iZwONtJ7yfM
X-Gm-Message-State: AOJu0YyRyhFNIE0Ke0YRwPDJRBbU209zKB6SM/P0C9lygeH55oOH7Kqq
	H+DgWhfDQGlT+p1VYWcfs2H9gNy5mBH2u5TUzSdjh22RkKoda48Au0uePm2hcDo=
X-Google-Smtp-Source: AGHT+IEbX9JnkqeOZsehIjP9iAc7jCIKkTip7u8M1yw8RHp8s5JujMub1rSRlFfBgRWQo0jfm3NTOg==
X-Received: by 2002:a17:902:c94f:b0:1dd:a912:2db3 with SMTP id i15-20020a170902c94f00b001dda9122db3mr12261850pla.17.1712048125006;
        Tue, 02 Apr 2024 01:55:25 -0700 (PDT)
Received: from [192.168.7.190] (82-64-249-211.subs.proxad.net. [82.64.249.211])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902c10d00b001dbac604e4dsm10485159pli.146.2024.04.02.01.55.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 01:55:24 -0700 (PDT)
Message-ID: <d04dd893-7fd4-48a3-9b6b-19bd3b5a78f6@linaro.org>
Date: Tue, 2 Apr 2024 10:55:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v7 6/6] spmi: pmic-arb: Add multi bus support
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>, Matthias Brugger
 <matthias.bgg@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
References: <20240329-spmi-multi-master-support-v7-0-7b902824246c@linaro.org>
 <20240329-spmi-multi-master-support-v7-6-7b902824246c@linaro.org>
 <871bc3f2-d4c3-4c83-ad0c-04c65ed15598@linaro.org>
 <ZgvG08kfV2PvzLeb@linaro.org>
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
Organization: Linaro
In-Reply-To: <ZgvG08kfV2PvzLeb@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/04/2024 10:50, Abel Vesa wrote:
> On 24-04-02 10:25:52, Neil Armstrong wrote:
>> Hi Abel,
>>
>> On 29/03/2024 19:54, Abel Vesa wrote:
>>> Starting with HW version 7, there are actually two separate buses
>>> (with two separate sets of wires). So add support for the second bus.
>>> The first platform that needs this support for the second bus is the
>>> Qualcomm X1 Elite, so add the compatible for it as well.
>>>
>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>> ---
>>>    drivers/spmi/spmi-pmic-arb.c | 138 +++++++++++++++++++++++++++++++++++++------
>>>    1 file changed, 120 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
>>> index 19ff8665f3d9..56f2b3190d82 100644
>>> --- a/drivers/spmi/spmi-pmic-arb.c
>>> +++ b/drivers/spmi/spmi-pmic-arb.c
>>> @@ -13,6 +13,7 @@
>>>    #include <linux/kernel.h>
>>>    #include <linux/module.h>
>>>    #include <linux/of.h>
>>> +#include <linux/of_address.h>
>>>    #include <linux/of_irq.h>
>>>    #include <linux/platform_device.h>
>>>    #include <linux/slab.h>
>>> @@ -95,6 +96,8 @@ enum pmic_arb_channel {
>>>    	PMIC_ARB_CHANNEL_OBS,
>>>    };
>>> +#define PMIC_ARB_MAX_BUSES		2
>>> +
>>>    /* Maximum number of support PMIC peripherals */
>>>    #define PMIC_ARB_MAX_PERIPHS		512
>>>    #define PMIC_ARB_MAX_PERIPHS_V7		1024
>>> @@ -148,6 +151,7 @@ struct spmi_pmic_arb;
>>>     * @min_apid:		minimum APID (used for bounding IRQ search)
>>>     * @max_apid:		maximum APID
>>>     * @irq:		PMIC ARB interrupt.
>>> + * @id:			unique ID of the bus
>>>     */
>>>    struct spmi_pmic_arb_bus {
>>>    	struct spmi_pmic_arb	*pmic_arb;
>>> @@ -165,6 +169,7 @@ struct spmi_pmic_arb_bus {
>>>    	u16			min_apid;
>>>    	u16			max_apid;
>>>    	int			irq;
>>> +	u8			id;
>>>    };
>>>    /**
>>> @@ -179,7 +184,8 @@ struct spmi_pmic_arb_bus {
>>>     * @ee:			the current Execution Environment
>>>     * @ver_ops:		version dependent operations.
>>>     * @max_periphs:	Number of elements in apid_data[]
>>> - * @bus:		per arbiter bus instance
>>> + * @buses:		per arbiter buses instances
>>> + * @buses_available:	number of buses registered
>>>     */
>>>    struct spmi_pmic_arb {
>>>    	void __iomem		*rd_base;
>>> @@ -191,7 +197,8 @@ struct spmi_pmic_arb {
>>>    	u8			ee;
>>>    	const struct pmic_arb_ver_ops *ver_ops;
>>>    	int			max_periphs;
>>> -	struct spmi_pmic_arb_bus *bus;
>>> +	struct spmi_pmic_arb_bus *buses[PMIC_ARB_MAX_BUSES];
>>> +	int			buses_available;
>>>    };
>>>    /**
>>> @@ -219,7 +226,7 @@ struct spmi_pmic_arb {
>>>    struct pmic_arb_ver_ops {
>>>    	const char *ver_str;
>>>    	int (*get_core_resources)(struct platform_device *pdev, void __iomem *core);
>>> -	int (*init_apid)(struct spmi_pmic_arb_bus *bus);
>>> +	int (*init_apid)(struct spmi_pmic_arb_bus *bus, int index);
>>>    	int (*ppid_to_apid)(struct spmi_pmic_arb_bus *bus, u16 ppid);
>>>    	/* spmi commands (read_cmd, write_cmd, cmd) functionality */
>>>    	int (*offset)(struct spmi_pmic_arb_bus *bus, u8 sid, u16 addr,
>>> @@ -308,8 +315,8 @@ static int pmic_arb_wait_for_done(struct spmi_controller *ctrl,
>>>    			}
>>>    			if (status & PMIC_ARB_STATUS_FAILURE) {
>>> -				dev_err(&ctrl->dev, "%s: %#x %#x: transaction failed (%#x)\n",
>>> -					__func__, sid, addr, status);
>>> +				dev_err(&ctrl->dev, "%s: %#x %#x: transaction failed (%#x) reg: 0x%x\n",
>>> +					__func__, sid, addr, status, offset);
>>>    				WARN_ON(1);
>>>    				return -EIO;
>>>    			}
>>> @@ -325,8 +332,8 @@ static int pmic_arb_wait_for_done(struct spmi_controller *ctrl,
>>>    		udelay(1);
>>>    	}
>>> -	dev_err(&ctrl->dev, "%s: %#x %#x: timeout, status %#x\n",
>>> -		__func__, sid, addr, status);
>>> +	dev_err(&ctrl->dev, "%s: %#x %#x %#x: timeout, status %#x\n",
>>> +		__func__, bus->id, sid, addr, status);
>>>    	return -ETIMEDOUT;
>>>    }
>>> @@ -1005,11 +1012,17 @@ static int pmic_arb_get_core_resources_v1(struct platform_device *pdev,
>>>    	return 0;
>>>    }
>>> -static int pmic_arb_init_apid_v1(struct spmi_pmic_arb_bus *bus)
>>> +static int pmic_arb_init_apid_v1(struct spmi_pmic_arb_bus *bus, int index)
>>>    {
>>>    	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>>>    	u32 *mapping_table;
>>> +	if (index) {
>>> +		dev_err(&bus->spmic->dev, "Unsupported buses count %d detected\n",
>>> +			index);
>>> +		return -EINVAL;
>>> +	}
>>
>> Shouldn't be here
>>
> 
> You're right. Since the DT bindings for HW < v7 doesn't allow multi bus
> support, this check is not needed. Will drop.
> 
>>> +
>>>    	mapping_table = devm_kcalloc(&bus->spmic->dev, pmic_arb->max_periphs,
>>>    				     sizeof(*mapping_table), GFP_KERNEL);
>>>    	if (!mapping_table)
>>> @@ -1252,11 +1265,17 @@ static int pmic_arb_offset_v2(struct spmi_pmic_arb_bus *bus, u8 sid, u16 addr,
>>>    	return 0x1000 * pmic_arb->ee + 0x8000 * apid;
>>>    }
>>> -static int pmic_arb_init_apid_v5(struct spmi_pmic_arb_bus *bus)
>>> +static int pmic_arb_init_apid_v5(struct spmi_pmic_arb_bus *bus, int index)
>>>    {
>>>    	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>>>    	int ret;
>>> +	if (index) {
>>> +		dev_err(&bus->spmic->dev, "Unsupported buses count %d detected\n",
>>> +			index);
>>> +		return -EINVAL;
>>> +	}
>>
>> Shouldn't be here
>>
> 
> Ditto.
> 
>>> +
>>>    	bus->base_apid = 0;
>>>    	bus->apid_count = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES) &
>>>    					   PMIC_ARB_FEATURES_PERIPH_MASK;
>>> @@ -1328,6 +1347,50 @@ static int pmic_arb_get_core_resources_v7(struct platform_device *pdev,
>>>    	return pmic_arb_get_obsrvr_chnls_v2(pdev);
>>>    }
>>> +/*
>>> + * Only v7 supports 2 buses. Each bus will get a different apid count, read
>>> + * from different registers.
>>> + */
>>> +static int pmic_arb_init_apid_v7(struct spmi_pmic_arb_bus *bus, int index)
>>> +{
>>> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>>> +	int ret;
>>> +
>>> +	if (index == 0) {
>>> +		bus->base_apid = 0;
>>> +		bus->apid_count = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES) &
>>> +						   PMIC_ARB_FEATURES_PERIPH_MASK;
>>> +	} else if (index == 1) {
>>> +		bus->base_apid = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES) &
>>> +						  PMIC_ARB_FEATURES_PERIPH_MASK;
>>> +		bus->apid_count = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES1) &
>>> +						   PMIC_ARB_FEATURES_PERIPH_MASK;
>>> +	} else {
>>> +		dev_err(&bus->spmic->dev, "Unsupported buses count %d detected\n",
>>> +			bus->id);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	if (bus->base_apid + bus->apid_count > pmic_arb->max_periphs) {
>>> +		dev_err(&bus->spmic->dev, "Unsupported APID count %d detected\n",
>>> +			bus->base_apid + bus->apid_count);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	ret = pmic_arb_init_apid_min_max(bus);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	ret = pmic_arb_read_apid_map_v5(bus);
>>> +	if (ret) {
>>> +		dev_err(&bus->spmic->dev, "could not read APID->PPID mapping table, rc= %d\n",
>>> +			ret);
>>> +		return ret;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>
>> Shouldn't be here
>>
> 
> Since the apid base and count are different between buses and since v7
> supports 2 buses, we need a v7 specific init_apid. So this one is
> needed.


I know, all those were wrongly removed in patch 5, just let them in place.

Neil

> 
>>> +
>>>    /*
>>>     * v7 offset per ee and per apid for observer channels and per apid for
>>>     * read/write channels.
>>> @@ -1580,7 +1643,7 @@ static const struct pmic_arb_ver_ops pmic_arb_v5 = {
>>>    static const struct pmic_arb_ver_ops pmic_arb_v7 = {
>>>    	.ver_str		= "v7",
>>>    	.get_core_resources	= pmic_arb_get_core_resources_v7,
>>> -	.init_apid		= pmic_arb_init_apid_v5,
>>> +	.init_apid		= pmic_arb_init_apid_v7,
>>
>> Shouldn't be here
>>
> 
> See above.
> 
>>>    	.ppid_to_apid		= pmic_arb_ppid_to_apid_v5,
>>>    	.non_data_cmd		= pmic_arb_non_data_cmd_v2,
>>>    	.offset			= pmic_arb_offset_v7,
>>> @@ -1604,6 +1667,7 @@ static int spmi_pmic_arb_bus_init(struct platform_device *pdev,
>>>    				  struct device_node *node,
>>>    				  struct spmi_pmic_arb *pmic_arb)
>>>    {
>>> +	int bus_index = pmic_arb->buses_available;
>>>    	struct spmi_pmic_arb_bus *bus;
>>>    	struct device *dev = &pdev->dev;
>>>    	struct spmi_controller *ctrl;
>>> @@ -1622,7 +1686,7 @@ static int spmi_pmic_arb_bus_init(struct platform_device *pdev,
>>>    	bus = spmi_controller_get_drvdata(ctrl);
>>> -	pmic_arb->bus = bus;
>>> +	pmic_arb->buses[bus_index] = bus;
>>>    	bus->ppid_to_apid = devm_kcalloc(dev, PMIC_ARB_MAX_PPID,
>>>    					 sizeof(*bus->ppid_to_apid),
>>> @@ -1665,12 +1729,13 @@ static int spmi_pmic_arb_bus_init(struct platform_device *pdev,
>>>    	bus->cnfg = cnfg;
>>>    	bus->irq = irq;
>>>    	bus->spmic = ctrl;
>>> +	bus->id = bus_index;
>>> -	ret = pmic_arb->ver_ops->init_apid(bus);
>>> +	ret = pmic_arb->ver_ops->init_apid(bus, bus_index);
>>>    	if (ret)
>>>    		return ret;
>>> -	dev_dbg(&pdev->dev, "adding irq domain\n");
>>> +	dev_dbg(&pdev->dev, "adding irq domain for bus %d\n", bus_index);
>>>    	bus->domain = irq_domain_add_tree(dev->of_node,
>>>    					  &pmic_arb_irq_domain_ops, bus);
>>> @@ -1683,14 +1748,53 @@ static int spmi_pmic_arb_bus_init(struct platform_device *pdev,
>>>    					 pmic_arb_chained_irq, bus);
>>>    	ctrl->dev.of_node = node;
>>> +	dev_set_name(&ctrl->dev, "spmi-%d", bus_index);
>>>    	ret = devm_spmi_controller_add(dev, ctrl);
>>>    	if (ret)
>>>    		return ret;
>>> +	pmic_arb->buses_available++;
>>> +
>>>    	return 0;
>>>    }
>>> +static int spmi_pmic_arb_register_buses(struct spmi_pmic_arb *pmic_arb,
>>> +					struct platform_device *pdev)
>>> +{
>>> +	struct device *dev = &pdev->dev;
>>> +	struct device_node *node = dev->of_node;
>>> +	struct device_node *child;
>>> +	int ret;
>>> +
>>> +	/* legacy mode doesn't provide child node for the bus */
>>> +	if (of_device_is_compatible(node, "qcom,spmi-pmic-arb"))
>>> +		return spmi_pmic_arb_bus_init(pdev, node, pmic_arb);
>>> +
>>> +	for_each_available_child_of_node(node, child) {
>>> +		if (of_node_name_eq(child, "spmi")) {
>>> +			ret = spmi_pmic_arb_bus_init(pdev, child, pmic_arb);
>>> +			if (ret)
>>> +				return ret;
>>> +		}
>>> +	}
>>> +
>>> +	return ret;
>>> +}
>>> +
>>> +static void spmi_pmic_arb_deregister_buses(struct spmi_pmic_arb *pmic_arb)
>>> +{
>>> +	int i;
>>> +
>>> +	for (i = 0; i < PMIC_ARB_MAX_BUSES; i++) {
>>> +		struct spmi_pmic_arb_bus *bus = pmic_arb->buses[i];
>>> +
>>> +		irq_set_chained_handler_and_data(bus->irq,
>>> +						 NULL, NULL);
>>> +		irq_domain_remove(bus->domain);
>>> +	}
>>> +}
>>> +
>>>    static int spmi_pmic_arb_probe(struct platform_device *pdev)
>>>    {
>>>    	struct spmi_pmic_arb *pmic_arb;
>>> @@ -1761,21 +1865,19 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
>>>    	pmic_arb->ee = ee;
>>> -	return spmi_pmic_arb_bus_init(pdev, dev->of_node, pmic_arb);
>>> +	return spmi_pmic_arb_register_buses(pmic_arb, pdev);
>>>    }
>>>    static void spmi_pmic_arb_remove(struct platform_device *pdev)
>>>    {
>>>    	struct spmi_pmic_arb *pmic_arb = platform_get_drvdata(pdev);
>>> -	struct spmi_pmic_arb_bus *bus = pmic_arb->bus;
>>> -	irq_set_chained_handler_and_data(bus->irq,
>>> -					 NULL, NULL);
>>> -	irq_domain_remove(bus->domain);
>>> +	spmi_pmic_arb_deregister_buses(pmic_arb);
>>>    }
>>>    static const struct of_device_id spmi_pmic_arb_match_table[] = {
>>>    	{ .compatible = "qcom,spmi-pmic-arb", },
>>> +	{ .compatible = "qcom,x1e80100-spmi-pmic-arb", },
>>>    	{},
>>>    };
>>>    MODULE_DEVICE_TABLE(of, spmi_pmic_arb_match_table);
>>>
>>
>> With issues fixed, it looks fine.
>>
>> Thanks,
>> Neil


