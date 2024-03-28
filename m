Return-Path: <linux-kernel+bounces-122633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9085188FAAA
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E803B297B47
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 09:05:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9385A11C;
	Thu, 28 Mar 2024 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sOEF46s8"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3F754776
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711616746; cv=none; b=goF0ssG64tfp8m+cyiFO63LSTKCJcN2zDoKcNmSvsypBpPjl7H2cao5+rc2SqhpAxyupWh8dUrjv6fA6gTJwDTWqIMuWqn4kHCMVGfPWiOnCAbotRMwzU8Ob02LqEvz+S6Brvqjk07ghG1l/iico11BhiHyWDK+Xi3e3885oqn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711616746; c=relaxed/simple;
	bh=PUw+zXh3gCiVA5o1ShYJzNkqdbXqf6aXlUJLpzIQN/s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UJl0RC9sCTtxdn7/xEajBBg3UkK2dGK340+lDgHuXaNdJWzHt3xzhbTUndusbWKPtGzAS5qFwkWN4sCjPY3UUyIFm59DgKsnXdazvXTuZLWf4uvwutcowxHgePIQ55t1zCFvNY4oCeb4IReLmgwXfs41+C/S7JVUwtfkeHen4l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sOEF46s8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4154471fb59so2802875e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 02:05:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711616740; x=1712221540; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FnIVRjkYht1zdUSS+X2MOZYO5fyAI963dUUGQU8Vuu0=;
        b=sOEF46s8pC43S0rnGh8kyuBE5QCDTWj7bCruHhxzE5/6Q9rERBJQJlo2xg9k5jmHZg
         BxRv4xXjhoKBtUCGoJ3cEpUhBVGHrbyIzO23FlHc8zXIasCvKGd8u9YAPo1Wx9wKh/1G
         rhzEsTOC6Au4ivTwrctEVT+RtWGR2TaAB94TSyYyDVD0lZy5f9SBZUADctGoVxyljqoc
         GQlnvNJsmx0h7odwJtHfWSMj/Fw3B+mjAvFfnvMktz1HbHtrmEPeDGbuEy7B6BOldiyF
         YZOLugLYh7Dncjui0PvFzsVOJPuLYivLmOe1BiNjvmpbuE3RnG3N0Smi/tAmAVGhjMRg
         08rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711616740; x=1712221540;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FnIVRjkYht1zdUSS+X2MOZYO5fyAI963dUUGQU8Vuu0=;
        b=FhGSYIbIXU4yoGTX+VLSJYP2a9fQpq5T0wYzWxi7jDUQ9pSzyOKxmg7XzCSMJIzIAP
         6wA+RwHD5Q6f5I5HwwKverhXXDyUY+dkaRuTrgc7rvWwyzqH2GuQyy4X8saZp41OH28K
         RAxXOpFi2Guf1n1+1AIq/fkq06LXHyEE6j3kwDOZ3hrOPx3mJ1jKa8W1oijmnWK3kbx0
         lrhhST5dt4D5bKP6vRDEwu5lj+0MkKMDLq1ijHaWT+3dRI7ndwbmp+cReushXhah/iJM
         f6r49i492v3RnD2fepft3JCHwKuC8fj+tlDAOPn8V/pcDaTyAMdhLd6v4ovxovlGXWV4
         r7Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWIBS6lGZpNlJTJPuFViuCEk6B3OgvcKXeElA7RcS1/UUjikV+5LfGfP0b+ZDvhHMKc6IJr64Q27lr4KBU2O3a2FxRRRSrTOJ4apfl1
X-Gm-Message-State: AOJu0Yz0FSbvniVGAnJ7y14rnDFksxHbt44C6BTCC5jbJB4oWQiIlBeL
	BG9La0lMx+j6KzFXkEek/U+x+Qzljdfxwm4u9GEuKud78kccQrp7SHMWHiiRsZ0=
X-Google-Smtp-Source: AGHT+IEKyEj76TKqdZ2wjEqdrUNAEuhn1vc5WEichi+mr8H2ucU86XTmbcPLYOvoKdRAdMCv3TiWhA==
X-Received: by 2002:a05:600c:5103:b0:414:8941:e7e2 with SMTP id o3-20020a05600c510300b004148941e7e2mr1801046wms.0.1711616739725;
        Thu, 28 Mar 2024 02:05:39 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:6306:1c7a:72c2:892a? ([2a01:e0a:982:cbb0:6306:1c7a:72c2:892a])
        by smtp.gmail.com with ESMTPSA id m28-20020a05600c3b1c00b00414688af147sm4762301wms.20.2024.03.28.02.05.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 02:05:39 -0700 (PDT)
Message-ID: <60a42bb8-3911-4d56-894f-c756a6bfbe06@linaro.org>
Date: Thu, 28 Mar 2024 10:05:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RESEND v6 5/5] spmi: pmic-arb: Add multi bus support
To: Abel Vesa <abel.vesa@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
References: <20240326-spmi-multi-master-support-v6-0-1c87d8306c5b@linaro.org>
 <20240326-spmi-multi-master-support-v6-5-1c87d8306c5b@linaro.org>
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
In-Reply-To: <20240326-spmi-multi-master-support-v6-5-1c87d8306c5b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Abel,

On 26/03/2024 17:28, Abel Vesa wrote:
> Starting with HW version 7, there are actually two separate buses
> (with two separate sets of wires). So in order to support both
> buses, we need to register a separate spmi controller for each one.
> Add a separate compatible for v7 only, but allow the legacy platforms
> that have v7 to still work with the old one, for DT backwards
> compatibility.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>   drivers/spmi/spmi-pmic-arb.c | 726 +++++++++++++++++++++++++------------------
>   1 file changed, 429 insertions(+), 297 deletions(-)
> 
> diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
> index 188252bfb95f..ca0f42952445 100644
> --- a/drivers/spmi/spmi-pmic-arb.c
> +++ b/drivers/spmi/spmi-pmic-arb.c
> @@ -13,6 +13,8 @@
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_irq.h>
>   #include <linux/platform_device.h>
>   #include <linux/slab.h>
>   #include <linux/spmi.h>
> @@ -94,6 +96,8 @@ enum pmic_arb_channel {
>   	PMIC_ARB_CHANNEL_OBS,
>   };
>   
> +#define PMIC_ARB_MAX_BUSES		2
> +
>   /* Maximum number of support PMIC peripherals */
>   #define PMIC_ARB_MAX_PERIPHS		512
>   #define PMIC_ARB_MAX_PERIPHS_V7		1024
> @@ -125,58 +129,68 @@ struct apid_data {
>   	u8		irq_ee;
>   };
>   
> +struct spmi_pmic_arb;
> +
>   /**
> - * struct spmi_pmic_arb - SPMI PMIC Arbiter object
> + * struct spmi_pmic_arb_bus - SPMI PMIC Arbiter Bus object
>    *
> - * @rd_base:		on v1 "core", on v2 "observer" register base off DT.
> - * @wr_base:		on v1 "core", on v2 "chnls"    register base off DT.
>    * @intr:		address of the SPMI interrupt control registers.
>    * @cnfg:		address of the PMIC Arbiter configuration registers.
> - * @lock:		lock to synchronize accesses.
> - * @channel:		execution environment channel to use for accesses.
> - * @irq:		PMIC ARB interrupt.
> - * @ee:			the current Execution Environment
> - * @bus_instance:	on v7: 0 = primary SPMI bus, 1 = secondary SPMI bus
> - * @min_apid:		minimum APID (used for bounding IRQ search)
> - * @max_apid:		maximum APID
> + * @domain:		irq domain object for PMIC IRQ domain
>    * @base_apid:		on v7: minimum APID associated with the particular SPMI
>    *			bus instance
>    * @apid_count:		on v5 and v7: number of APIDs associated with the
>    *			particular SPMI bus instance
>    * @mapping_table:	in-memory copy of PPID -> APID mapping table.
> - * @domain:		irq domain object for PMIC IRQ domain
> - * @spmic:		SPMI controller object
> - * @ver_ops:		version dependent operations.
>    * @ppid_to_apid:	in-memory copy of PPID -> APID mapping table.
> - * @last_apid:		Highest value APID in use
>    * @apid_data:		Table of data for all APIDs
> + * @last_apid:		Highest value APID in use
> + * @irq:		PMIC ARB interrupt.

Those are moved for no reason, and it doesn't match anymore with the actual fields in spmi_pmic_arb_bus,
please fix.

> + */
> +struct spmi_pmic_arb_bus {
> +	struct spmi_pmic_arb	*pmic_arb;
> +	struct irq_domain	*domain;
> +	void __iomem		*intr;
> +	void __iomem		*cnfg;
> +	struct spmi_controller	*spmic;
> +	u16			base_apid;
> +	int			apid_count;
> +	u32			*mapping_table;
> +	DECLARE_BITMAP(mapping_table_valid, PMIC_ARB_MAX_PERIPHS);
> +	u16			*ppid_to_apid;
> +	u16			last_apid;
> +	struct apid_data	*apid_data;
> +	u16			min_apid;
> +	u16			max_apid;
> +	int			irq;
> +	u8			id;
> +};
> +
> +/**
> + * struct spmi_pmic_arb - SPMI PMIC Arbiter object
> + *
> + * @rd_base:		on v1 "core", on v2 "observer" register base off DT.
> + * @wr_base:		on v1 "core", on v2 "chnls"    register base off DT.
> + * @lock:		lock to synchronize accesses.
> + * @channel:		execution environment channel to use for accesses.
> + * @ee:			the current Execution Environment
> + * @min_apid:		minimum APID (used for bounding IRQ search)
> + * @max_apid:		maximum APID
> + * @ver_ops:		version dependent operations.
>    * @max_periphs:	Number of elements in apid_data[]
>    */
>   struct spmi_pmic_arb {
>   	void __iomem		*rd_base;
>   	void __iomem		*wr_base;
> -	void __iomem		*intr;
> -	void __iomem		*cnfg;
>   	void __iomem		*core;
>   	resource_size_t		core_size;
>   	raw_spinlock_t		lock;
>   	u8			channel;
> -	int			irq;
>   	u8			ee;
> -	u32			bus_instance;
> -	u16			min_apid;
> -	u16			max_apid;
> -	u16			base_apid;
> -	int			apid_count;
> -	u32			*mapping_table;
> -	DECLARE_BITMAP(mapping_table_valid, PMIC_ARB_MAX_PERIPHS);
> -	struct irq_domain	*domain;
> -	struct spmi_controller	*spmic;
>   	const struct pmic_arb_ver_ops *ver_ops;
> -	u16			*ppid_to_apid;
> -	u16			last_apid;
> -	struct apid_data	*apid_data;
>   	int			max_periphs;
> +	struct spmi_pmic_arb_bus buses[PMIC_ARB_MAX_BUSES];
> +	int			buses_available;
>   };

Same here, please refresh/resync the struct documentation

I get the following:
drivers/spmi/spmi-pmic-arb.c:167: warning: Function parameter or struct member 'pmic_arb' not described in 'spmi_pmic_arb_bus'
drivers/spmi/spmi-pmic-arb.c:167: warning: Function parameter or struct member 'spmic' not described in 'spmi_pmic_arb_bus'
drivers/spmi/spmi-pmic-arb.c:167: warning: Function parameter or struct member 'mapping_table_valid' not described in 'spmi_pmic_arb_bus'
drivers/spmi/spmi-pmic-arb.c:167: warning: Function parameter or struct member 'min_apid' not described in 'spmi_pmic_arb_bus'
drivers/spmi/spmi-pmic-arb.c:167: warning: Function parameter or struct member 'max_apid' not described in 'spmi_pmic_arb_bus'
drivers/spmi/spmi-pmic-arb.c:167: warning: Function parameter or struct member 'id' not described in 'spmi_pmic_arb_bus'
drivers/spmi/spmi-pmic-arb.c:194: warning: Function parameter or struct member 'core' not described in 'spmi_pmic_arb'
drivers/spmi/spmi-pmic-arb.c:194: warning: Function parameter or struct member 'core_size' not described in 'spmi_pmic_arb'
drivers/spmi/spmi-pmic-arb.c:194: warning: Function parameter or struct member 'buses' not described in 'spmi_pmic_arb'
drivers/spmi/spmi-pmic-arb.c:194: warning: Function parameter or struct member 'buses_available' not described in 'spmi_pmic_arb'
drivers/spmi/spmi-pmic-arb.c:194: warning: Excess struct member 'min_apid' description in 'spmi_pmic_arb'
drivers/spmi/spmi-pmic-arb.c:194: warning: Excess struct member 'max_apid' description in 'spmi_pmic_arb'
drivers/spmi/spmi-pmic-arb.c:236: warning: Function parameter or struct member 'get_core_resources' not described in 'pmic_arb_ver_ops'
drivers/spmi/spmi-pmic-arb.c:258: warning: Function parameter or struct member 'pmic_arb' not described in 'pmic_arb_read_data'
drivers/spmi/spmi-pmic-arb.c:272: warning: Function parameter or struct member 'pmic_arb' not described in 'pmic_arb_write_data'

>   
>   /**
> @@ -204,21 +218,21 @@ struct spmi_pmic_arb {
>   struct pmic_arb_ver_ops {
>   	const char *ver_str;
>   	int (*get_core_resources)(struct platform_device *pdev, void __iomem *core);
> -	int (*init_apid)(struct spmi_pmic_arb *pmic_arb, int index);
> -	int (*ppid_to_apid)(struct spmi_pmic_arb *pmic_arb, u16 ppid);
> +	int (*init_apid)(struct spmi_pmic_arb_bus *bus, int index);
> +	int (*ppid_to_apid)(struct spmi_pmic_arb_bus *bus, u16 ppid);
>   	/* spmi commands (read_cmd, write_cmd, cmd) functionality */
> -	int (*offset)(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
> -			enum pmic_arb_channel ch_type);
> +	int (*offset)(struct spmi_pmic_arb_bus *bus, u8 sid, u16 addr,
> +		      enum pmic_arb_channel ch_type);
>   	u32 (*fmt_cmd)(u8 opc, u8 sid, u16 addr, u8 bc);
>   	int (*non_data_cmd)(struct spmi_controller *ctrl, u8 opc, u8 sid);
>   	/* Interrupts controller functionality (offset of PIC registers) */
> -	void __iomem *(*owner_acc_status)(struct spmi_pmic_arb *pmic_arb, u8 m,
> +	void __iomem *(*owner_acc_status)(struct spmi_pmic_arb_bus *bus, u8 m,
>   					  u16 n);
> -	void __iomem *(*acc_enable)(struct spmi_pmic_arb *pmic_arb, u16 n);
> -	void __iomem *(*irq_status)(struct spmi_pmic_arb *pmic_arb, u16 n);
> -	void __iomem *(*irq_clear)(struct spmi_pmic_arb *pmic_arb, u16 n);
> +	void __iomem *(*acc_enable)(struct spmi_pmic_arb_bus *bus, u16 n);
> +	void __iomem *(*irq_status)(struct spmi_pmic_arb_bus *bus, u16 n);
> +	void __iomem *(*irq_clear)(struct spmi_pmic_arb_bus *bus, u16 n);
>   	u32 (*apid_map_offset)(u16 n);
> -	void __iomem *(*apid_owner)(struct spmi_pmic_arb *pmic_arb, u16 n);
> +	void __iomem *(*apid_owner)(struct spmi_pmic_arb_bus *bus, u16 n);
>   };
>   
>   static inline void pmic_arb_base_write(struct spmi_pmic_arb *pmic_arb,
> @@ -266,13 +280,14 @@ static int pmic_arb_wait_for_done(struct spmi_controller *ctrl,
>   				  void __iomem *base, u8 sid, u16 addr,
>   				  enum pmic_arb_channel ch_type)
>   {
> -	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
> +	struct spmi_pmic_arb_bus *bus = spmi_controller_get_drvdata(ctrl);
> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>   	u32 status = 0;
>   	u32 timeout = PMIC_ARB_TIMEOUT_US;
>   	u32 offset;
>   	int rc;
>   
> -	rc = pmic_arb->ver_ops->offset(pmic_arb, sid, addr, ch_type);
> +	rc = pmic_arb->ver_ops->offset(bus, sid, addr, ch_type);
>   	if (rc < 0)
>   		return rc;
>   
> @@ -284,21 +299,21 @@ static int pmic_arb_wait_for_done(struct spmi_controller *ctrl,
>   
>   		if (status & PMIC_ARB_STATUS_DONE) {
>   			if (status & PMIC_ARB_STATUS_DENIED) {
> -				dev_err(&ctrl->dev, "%s: %#x %#x: transaction denied (%#x)\n",
> -					__func__, sid, addr, status);
> +				dev_err(&ctrl->dev, "%s: %#x %#x %#x: transaction denied (%#x)\n",
> +					__func__, bus->id, sid, addr, status);

Won't "dev_err(&ctrl->dev" already print the bus id ?

>   				return -EPERM;
>   			}
>   
>   			if (status & PMIC_ARB_STATUS_FAILURE) {
> -				dev_err(&ctrl->dev, "%s: %#x %#x: transaction failed (%#x)\n",
> -					__func__, sid, addr, status);
> +				dev_err(&ctrl->dev, "%s: %#x %#x %#x: transaction failed (%#x) reg: 0x%x\n",
> +					__func__, bus->id, sid, addr, status, offset);
>   				WARN_ON(1);
>   				return -EIO;
>   			}
>   
>   			if (status & PMIC_ARB_STATUS_DROPPED) {
> -				dev_err(&ctrl->dev, "%s: %#x %#x: transaction dropped (%#x)\n",
> -					__func__, sid, addr, status);
> +				dev_err(&ctrl->dev, "%s: %#x %#x %#x: transaction dropped (%#x)\n",
> +					__func__, bus->id, sid, addr, status);
>   				return -EIO;
>   			}
>   
> @@ -307,8 +322,8 @@ static int pmic_arb_wait_for_done(struct spmi_controller *ctrl,
>   		udelay(1);
>   	}
>   
> -	dev_err(&ctrl->dev, "%s: %#x %#x: timeout, status %#x\n",
> -		__func__, sid, addr, status);
> +	dev_err(&ctrl->dev, "%s: %#x %#x %#x: timeout, status %#x\n",
> +		__func__, bus->id, sid, addr, status);
>   	return -ETIMEDOUT;
>   }
>   
> @@ -316,12 +331,13 @@ static int
>   pmic_arb_non_data_cmd_v1(struct spmi_controller *ctrl, u8 opc, u8 sid)
>   {
>   	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
> +	struct spmi_pmic_arb_bus *bus = &pmic_arb->buses[0];
>   	unsigned long flags;
>   	u32 cmd;
>   	int rc;
>   	u32 offset;
>   
> -	rc = pmic_arb->ver_ops->offset(pmic_arb, sid, 0, PMIC_ARB_CHANNEL_RW);
> +	rc = pmic_arb->ver_ops->offset(bus, sid, 0, PMIC_ARB_CHANNEL_RW);
>   	if (rc < 0)
>   		return rc;
>   
> @@ -357,20 +373,21 @@ static int pmic_arb_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid)
>   	return pmic_arb->ver_ops->non_data_cmd(ctrl, opc, sid);
>   }
>   
> -static int pmic_arb_fmt_read_cmd(struct spmi_pmic_arb *pmic_arb, u8 opc, u8 sid,
> +static int pmic_arb_fmt_read_cmd(struct spmi_pmic_arb_bus *bus, u8 opc, u8 sid,
>   				 u16 addr, size_t len, u32 *cmd, u32 *offset)
>   {
> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>   	u8 bc = len - 1;
>   	int rc;
>   
> -	rc = pmic_arb->ver_ops->offset(pmic_arb, sid, addr,
> +	rc = pmic_arb->ver_ops->offset(bus, sid, addr,
>   				       PMIC_ARB_CHANNEL_OBS);
>   	if (rc < 0)
>   		return rc;
>   
>   	*offset = rc;
>   	if (bc >= PMIC_ARB_MAX_TRANS_BYTES) {
> -		dev_err(&pmic_arb->spmic->dev, "pmic-arb supports 1..%d bytes per trans, but:%zu requested",
> +		dev_err(&bus->spmic->dev, "pmic-arb supports 1..%d bytes per trans, but:%zu requested",
>   			PMIC_ARB_MAX_TRANS_BYTES, len);
>   		return  -EINVAL;
>   	}
> @@ -394,7 +411,8 @@ static int pmic_arb_read_cmd_unlocked(struct spmi_controller *ctrl, u32 cmd,
>   				      u32 offset, u8 sid, u16 addr, u8 *buf,
>   				      size_t len)
>   {
> -	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
> +	struct spmi_pmic_arb_bus *bus = spmi_controller_get_drvdata(ctrl);
> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>   	u8 bc = len - 1;
>   	int rc;
>   
> @@ -416,12 +434,13 @@ static int pmic_arb_read_cmd_unlocked(struct spmi_controller *ctrl, u32 cmd,
>   static int pmic_arb_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
>   			     u16 addr, u8 *buf, size_t len)
>   {
> -	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
> +	struct spmi_pmic_arb_bus *bus = spmi_controller_get_drvdata(ctrl);
> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>   	unsigned long flags;
>   	u32 cmd, offset;
>   	int rc;
>   
> -	rc = pmic_arb_fmt_read_cmd(pmic_arb, opc, sid, addr, len, &cmd,
> +	rc = pmic_arb_fmt_read_cmd(bus, opc, sid, addr, len, &cmd,
>   				   &offset);
>   	if (rc)
>   		return rc;
> @@ -433,21 +452,22 @@ static int pmic_arb_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
>   	return rc;
>   }
>   
> -static int pmic_arb_fmt_write_cmd(struct spmi_pmic_arb *pmic_arb, u8 opc,
> +static int pmic_arb_fmt_write_cmd(struct spmi_pmic_arb_bus *bus, u8 opc,
>   				  u8 sid, u16 addr, size_t len, u32 *cmd,
>   				  u32 *offset)
>   {
> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>   	u8 bc = len - 1;
>   	int rc;
>   
> -	rc = pmic_arb->ver_ops->offset(pmic_arb, sid, addr,
> +	rc = pmic_arb->ver_ops->offset(bus, sid, addr,
>   					PMIC_ARB_CHANNEL_RW);
>   	if (rc < 0)
>   		return rc;
>   
>   	*offset = rc;
>   	if (bc >= PMIC_ARB_MAX_TRANS_BYTES) {
> -		dev_err(&pmic_arb->spmic->dev, "pmic-arb supports 1..%d bytes per trans, but:%zu requested",
> +		dev_err(&bus->spmic->dev, "pmic-arb supports 1..%d bytes per trans, but:%zu requested",
>   			PMIC_ARB_MAX_TRANS_BYTES, len);
>   		return  -EINVAL;
>   	}
> @@ -473,7 +493,8 @@ static int pmic_arb_write_cmd_unlocked(struct spmi_controller *ctrl, u32 cmd,
>   				      u32 offset, u8 sid, u16 addr,
>   				      const u8 *buf, size_t len)
>   {
> -	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
> +	struct spmi_pmic_arb_bus *bus = spmi_controller_get_drvdata(ctrl);
> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>   	u8 bc = len - 1;
>   
>   	/* Write data to FIFOs */
> @@ -492,12 +513,13 @@ static int pmic_arb_write_cmd_unlocked(struct spmi_controller *ctrl, u32 cmd,
>   static int pmic_arb_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
>   			      u16 addr, const u8 *buf, size_t len)
>   {
> -	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
> +	struct spmi_pmic_arb_bus *bus = spmi_controller_get_drvdata(ctrl);
> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>   	unsigned long flags;
>   	u32 cmd, offset;
>   	int rc;
>   
> -	rc = pmic_arb_fmt_write_cmd(pmic_arb, opc, sid, addr, len, &cmd,
> +	rc = pmic_arb_fmt_write_cmd(bus, opc, sid, addr, len, &cmd,
>   				    &offset);
>   	if (rc)
>   		return rc;
> @@ -513,18 +535,19 @@ static int pmic_arb_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
>   static int pmic_arb_masked_write(struct spmi_controller *ctrl, u8 sid, u16 addr,
>   				 const u8 *buf, const u8 *mask, size_t len)
>   {
> -	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
> +	struct spmi_pmic_arb_bus *bus = spmi_controller_get_drvdata(ctrl);
> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>   	u32 read_cmd, read_offset, write_cmd, write_offset;
>   	u8 temp[PMIC_ARB_MAX_TRANS_BYTES];
>   	unsigned long flags;
>   	int rc, i;
>   
> -	rc = pmic_arb_fmt_read_cmd(pmic_arb, SPMI_CMD_EXT_READL, sid, addr, len,
> +	rc = pmic_arb_fmt_read_cmd(bus, SPMI_CMD_EXT_READL, sid, addr, len,
>   				   &read_cmd, &read_offset);
>   	if (rc)
>   		return rc;
>   
> -	rc = pmic_arb_fmt_write_cmd(pmic_arb, SPMI_CMD_EXT_WRITEL, sid, addr,
> +	rc = pmic_arb_fmt_write_cmd(bus, SPMI_CMD_EXT_WRITEL, sid, addr,
>   				    len, &write_cmd, &write_offset);
>   	if (rc)
>   		return rc;
> @@ -567,25 +590,25 @@ struct spmi_pmic_arb_qpnpint_type {
>   static void qpnpint_spmi_write(struct irq_data *d, u8 reg, void *buf,
>   			       size_t len)
>   {
> -	struct spmi_pmic_arb *pmic_arb = irq_data_get_irq_chip_data(d);
> +	struct spmi_pmic_arb_bus *bus = irq_data_get_irq_chip_data(d);
>   	u8 sid = hwirq_to_sid(d->hwirq);
>   	u8 per = hwirq_to_per(d->hwirq);
>   
> -	if (pmic_arb_write_cmd(pmic_arb->spmic, SPMI_CMD_EXT_WRITEL, sid,
> +	if (pmic_arb_write_cmd(bus->spmic, SPMI_CMD_EXT_WRITEL, sid,
>   			       (per << 8) + reg, buf, len))
> -		dev_err_ratelimited(&pmic_arb->spmic->dev, "failed irqchip transaction on %x\n",
> +		dev_err_ratelimited(&bus->spmic->dev, "failed irqchip transaction on %x\n",
>   				    d->irq);
>   }
>   
>   static void qpnpint_spmi_read(struct irq_data *d, u8 reg, void *buf, size_t len)
>   {
> -	struct spmi_pmic_arb *pmic_arb = irq_data_get_irq_chip_data(d);
> +	struct spmi_pmic_arb_bus *bus = irq_data_get_irq_chip_data(d);
>   	u8 sid = hwirq_to_sid(d->hwirq);
>   	u8 per = hwirq_to_per(d->hwirq);
>   
> -	if (pmic_arb_read_cmd(pmic_arb->spmic, SPMI_CMD_EXT_READL, sid,
> +	if (pmic_arb_read_cmd(bus->spmic, SPMI_CMD_EXT_READL, sid,
>   			      (per << 8) + reg, buf, len))
> -		dev_err_ratelimited(&pmic_arb->spmic->dev, "failed irqchip transaction on %x\n",
> +		dev_err_ratelimited(&bus->spmic->dev, "failed irqchip transaction on %x\n",
>   				    d->irq);
>   }
>   
> @@ -593,47 +616,49 @@ static int qpnpint_spmi_masked_write(struct irq_data *d, u8 reg,
>   				     const void *buf, const void *mask,
>   				     size_t len)
>   {
> -	struct spmi_pmic_arb *pmic_arb = irq_data_get_irq_chip_data(d);
> +	struct spmi_pmic_arb_bus *bus = irq_data_get_irq_chip_data(d);
>   	u8 sid = hwirq_to_sid(d->hwirq);
>   	u8 per = hwirq_to_per(d->hwirq);
>   	int rc;
>   
> -	rc = pmic_arb_masked_write(pmic_arb->spmic, sid, (per << 8) + reg, buf,
> +	rc = pmic_arb_masked_write(bus->spmic, sid, (per << 8) + reg, buf,
>   				   mask, len);
>   	if (rc)
> -		dev_err_ratelimited(&pmic_arb->spmic->dev, "failed irqchip transaction on %x rc=%d\n",
> +		dev_err_ratelimited(&bus->spmic->dev, "failed irqchip transaction on %x rc=%d\n",
>   				    d->irq, rc);
>   	return rc;
>   }
>   
> -static void cleanup_irq(struct spmi_pmic_arb *pmic_arb, u16 apid, int id)
> +static void cleanup_irq(struct spmi_pmic_arb_bus *bus, u16 apid, int id)
>   {
> -	u16 ppid = pmic_arb->apid_data[apid].ppid;
> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
> +	u16 ppid = bus->apid_data[apid].ppid;
>   	u8 sid = ppid >> 8;
>   	u8 per = ppid & 0xFF;
>   	u8 irq_mask = BIT(id);
>   
> -	dev_err_ratelimited(&pmic_arb->spmic->dev, "%s apid=%d sid=0x%x per=0x%x irq=%d\n",
> -			__func__, apid, sid, per, id);
> -	writel_relaxed(irq_mask, pmic_arb->ver_ops->irq_clear(pmic_arb, apid));
> +	dev_err_ratelimited(&bus->spmic->dev, "%s apid=%d sid=0x%x per=0x%x irq=%d\n",
> +			    __func__, apid, sid, per, id);
> +	writel_relaxed(irq_mask, pmic_arb->ver_ops->irq_clear(bus, apid));
>   }
>   
> -static int periph_interrupt(struct spmi_pmic_arb *pmic_arb, u16 apid)
> +static int periph_interrupt(struct spmi_pmic_arb_bus *bus, u16 apid)
>   {
> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>   	unsigned int irq;
>   	u32 status, id;
>   	int handled = 0;
> -	u8 sid = (pmic_arb->apid_data[apid].ppid >> 8) & 0xF;
> -	u8 per = pmic_arb->apid_data[apid].ppid & 0xFF;
> +	u8 sid = (bus->apid_data[apid].ppid >> 8) & 0xF;
> +	u8 per = bus->apid_data[apid].ppid & 0xFF;
>   
> -	status = readl_relaxed(pmic_arb->ver_ops->irq_status(pmic_arb, apid));
> +	status = readl_relaxed(pmic_arb->ver_ops->irq_status(bus, apid));
>   	while (status) {
>   		id = ffs(status) - 1;
>   		status &= ~BIT(id);
> -		irq = irq_find_mapping(pmic_arb->domain,
> -					spec_to_hwirq(sid, per, id, apid));
> +		irq = irq_find_mapping(bus->domain,
> +				       spec_to_hwirq(sid, per, id, apid));
>   		if (irq == 0) {
> -			cleanup_irq(pmic_arb, apid, id);
> +			cleanup_irq(bus, apid, id);
>   			continue;
>   		}
>   		generic_handle_irq(irq);
> @@ -645,16 +670,17 @@ static int periph_interrupt(struct spmi_pmic_arb *pmic_arb, u16 apid)
>   
>   static void pmic_arb_chained_irq(struct irq_desc *desc)
>   {
> -	struct spmi_pmic_arb *pmic_arb = irq_desc_get_handler_data(desc);
> +	struct spmi_pmic_arb_bus *bus = irq_desc_get_handler_data(desc);
> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>   	const struct pmic_arb_ver_ops *ver_ops = pmic_arb->ver_ops;
>   	struct irq_chip *chip = irq_desc_get_chip(desc);
> -	int first = pmic_arb->min_apid;
> -	int last = pmic_arb->max_apid;
> +	int first = bus->min_apid;
> +	int last = bus->max_apid;
>   	/*
>   	 * acc_offset will be non-zero for the secondary SPMI bus instance on
>   	 * v7 controllers.
>   	 */
> -	int acc_offset = pmic_arb->base_apid >> 5;
> +	int acc_offset = bus->base_apid >> 5;
>   	u8 ee = pmic_arb->ee;
>   	u32 status, enable, handled = 0;
>   	int i, id, apid;
> @@ -665,7 +691,7 @@ static void pmic_arb_chained_irq(struct irq_desc *desc)
>   	chained_irq_enter(chip, desc);
>   
>   	for (i = first >> 5; i <= last >> 5; ++i) {
> -		status = readl_relaxed(ver_ops->owner_acc_status(pmic_arb, ee, i - acc_offset));
> +		status = readl_relaxed(ver_ops->owner_acc_status(bus, ee, i - acc_offset));
>   		if (status)
>   			acc_valid = true;
>   
> @@ -679,9 +705,9 @@ static void pmic_arb_chained_irq(struct irq_desc *desc)
>   				continue;
>   			}
>   			enable = readl_relaxed(
> -					ver_ops->acc_enable(pmic_arb, apid));
> +					ver_ops->acc_enable(bus, apid));
>   			if (enable & SPMI_PIC_ACC_ENABLE_BIT)
> -				if (periph_interrupt(pmic_arb, apid) != 0)
> +				if (periph_interrupt(bus, apid) != 0)
>   					handled++;
>   		}
>   	}
> @@ -690,19 +716,19 @@ static void pmic_arb_chained_irq(struct irq_desc *desc)
>   	if (!acc_valid) {
>   		for (i = first; i <= last; i++) {
>   			/* skip if APPS is not irq owner */
> -			if (pmic_arb->apid_data[i].irq_ee != pmic_arb->ee)
> +			if (bus->apid_data[i].irq_ee != pmic_arb->ee)
>   				continue;
>   
>   			irq_status = readl_relaxed(
> -					     ver_ops->irq_status(pmic_arb, i));
> +					     ver_ops->irq_status(bus, i));
>   			if (irq_status) {
>   				enable = readl_relaxed(
> -					     ver_ops->acc_enable(pmic_arb, i));
> +					     ver_ops->acc_enable(bus, i));
>   				if (enable & SPMI_PIC_ACC_ENABLE_BIT) {
> -					dev_dbg(&pmic_arb->spmic->dev,
> +					dev_dbg(&bus->spmic->dev,
>   						"Dispatching IRQ for apid=%d status=%x\n",
>   						i, irq_status);
> -					if (periph_interrupt(pmic_arb, i) != 0)
> +					if (periph_interrupt(bus, i) != 0)
>   						handled++;
>   				}
>   			}
> @@ -717,12 +743,13 @@ static void pmic_arb_chained_irq(struct irq_desc *desc)
>   
>   static void qpnpint_irq_ack(struct irq_data *d)
>   {
> -	struct spmi_pmic_arb *pmic_arb = irq_data_get_irq_chip_data(d);
> +	struct spmi_pmic_arb_bus *bus = irq_data_get_irq_chip_data(d);
> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>   	u8 irq = hwirq_to_irq(d->hwirq);
>   	u16 apid = hwirq_to_apid(d->hwirq);
>   	u8 data;
>   
> -	writel_relaxed(BIT(irq), pmic_arb->ver_ops->irq_clear(pmic_arb, apid));
> +	writel_relaxed(BIT(irq), pmic_arb->ver_ops->irq_clear(bus, apid));
>   
>   	data = BIT(irq);
>   	qpnpint_spmi_write(d, QPNPINT_REG_LATCHED_CLR, &data, 1);
> @@ -738,14 +765,15 @@ static void qpnpint_irq_mask(struct irq_data *d)
>   
>   static void qpnpint_irq_unmask(struct irq_data *d)
>   {
> -	struct spmi_pmic_arb *pmic_arb = irq_data_get_irq_chip_data(d);
> +	struct spmi_pmic_arb_bus *bus = irq_data_get_irq_chip_data(d);
> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>   	const struct pmic_arb_ver_ops *ver_ops = pmic_arb->ver_ops;
>   	u8 irq = hwirq_to_irq(d->hwirq);
>   	u16 apid = hwirq_to_apid(d->hwirq);
>   	u8 buf[2];
>   
>   	writel_relaxed(SPMI_PIC_ACC_ENABLE_BIT,
> -			ver_ops->acc_enable(pmic_arb, apid));
> +			ver_ops->acc_enable(bus, apid));
>   
>   	qpnpint_spmi_read(d, QPNPINT_REG_EN_SET, &buf[0], 1);
>   	if (!(buf[0] & BIT(irq))) {
> @@ -802,9 +830,9 @@ static int qpnpint_irq_set_type(struct irq_data *d, unsigned int flow_type)
>   
>   static int qpnpint_irq_set_wake(struct irq_data *d, unsigned int on)
>   {
> -	struct spmi_pmic_arb *pmic_arb = irq_data_get_irq_chip_data(d);
> +	struct spmi_pmic_arb_bus *bus = irq_data_get_irq_chip_data(d);
>   
> -	return irq_set_irq_wake(pmic_arb->irq, on);
> +	return irq_set_irq_wake(bus->irq, on);
>   }
>   
>   static int qpnpint_get_irqchip_state(struct irq_data *d,
> @@ -826,17 +854,18 @@ static int qpnpint_get_irqchip_state(struct irq_data *d,
>   static int qpnpint_irq_domain_activate(struct irq_domain *domain,
>   				       struct irq_data *d, bool reserve)
>   {
> -	struct spmi_pmic_arb *pmic_arb = irq_data_get_irq_chip_data(d);
> +	struct spmi_pmic_arb_bus *bus = irq_data_get_irq_chip_data(d);
> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>   	u16 periph = hwirq_to_per(d->hwirq);
>   	u16 apid = hwirq_to_apid(d->hwirq);
>   	u16 sid = hwirq_to_sid(d->hwirq);
>   	u16 irq = hwirq_to_irq(d->hwirq);
>   	u8 buf;
>   
> -	if (pmic_arb->apid_data[apid].irq_ee != pmic_arb->ee) {
> -		dev_err(&pmic_arb->spmic->dev, "failed to xlate sid = %#x, periph = %#x, irq = %u: ee=%u but owner=%u\n",
> +	if (bus->apid_data[apid].irq_ee != pmic_arb->ee) {
> +		dev_err(&bus->spmic->dev, "failed to xlate sid = %#x, periph = %#x, irq = %u: ee=%u but owner=%u\n",
>   			sid, periph, irq, pmic_arb->ee,
> -			pmic_arb->apid_data[apid].irq_ee);
> +			bus->apid_data[apid].irq_ee);
>   		return -ENODEV;
>   	}
>   
> @@ -863,15 +892,16 @@ static int qpnpint_irq_domain_translate(struct irq_domain *d,
>   					unsigned long *out_hwirq,
>   					unsigned int *out_type)
>   {
> -	struct spmi_pmic_arb *pmic_arb = d->host_data;
> +	struct spmi_pmic_arb_bus *bus = d->host_data;
> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>   	u32 *intspec = fwspec->param;
>   	u16 apid, ppid;
>   	int rc;
>   
> -	dev_dbg(&pmic_arb->spmic->dev, "intspec[0] 0x%1x intspec[1] 0x%02x intspec[2] 0x%02x\n",
> +	dev_dbg(&bus->spmic->dev, "intspec[0] 0x%1x intspec[1] 0x%02x intspec[2] 0x%02x\n",
>   		intspec[0], intspec[1], intspec[2]);
>   
> -	if (irq_domain_get_of_node(d) != pmic_arb->spmic->dev.of_node)
> +	if (irq_domain_get_of_node(d) != bus->spmic->dev.of_node)
>   		return -EINVAL;
>   	if (fwspec->param_count != 4)
>   		return -EINVAL;
> @@ -879,37 +909,38 @@ static int qpnpint_irq_domain_translate(struct irq_domain *d,
>   		return -EINVAL;
>   
>   	ppid = intspec[0] << 8 | intspec[1];
> -	rc = pmic_arb->ver_ops->ppid_to_apid(pmic_arb, ppid);
> +	rc = pmic_arb->ver_ops->ppid_to_apid(bus, ppid);
>   	if (rc < 0) {
> -		dev_err(&pmic_arb->spmic->dev, "failed to xlate sid = %#x, periph = %#x, irq = %u rc = %d\n",
> -		intspec[0], intspec[1], intspec[2], rc);
> +		dev_err(&bus->spmic->dev, "failed to xlate sid = %#x, periph = %#x, irq = %u rc = %d\n",
> +			intspec[0], intspec[1], intspec[2], rc);
>   		return rc;
>   	}
>   
>   	apid = rc;
>   	/* Keep track of {max,min}_apid for bounding search during interrupt */
> -	if (apid > pmic_arb->max_apid)
> -		pmic_arb->max_apid = apid;
> -	if (apid < pmic_arb->min_apid)
> -		pmic_arb->min_apid = apid;
> +	if (apid > bus->max_apid)
> +		bus->max_apid = apid;
> +	if (apid < bus->min_apid)
> +		bus->min_apid = apid;
>   
>   	*out_hwirq = spec_to_hwirq(intspec[0], intspec[1], intspec[2], apid);
>   	*out_type  = intspec[3] & IRQ_TYPE_SENSE_MASK;
>   
> -	dev_dbg(&pmic_arb->spmic->dev, "out_hwirq = %lu\n", *out_hwirq);
> +	dev_dbg(&bus->spmic->dev, "out_hwirq = %lu\n", *out_hwirq);
>   
>   	return 0;
>   }
>   
>   static struct lock_class_key qpnpint_irq_lock_class, qpnpint_irq_request_class;
>   
> -static void qpnpint_irq_domain_map(struct spmi_pmic_arb *pmic_arb,
> +static void qpnpint_irq_domain_map(struct spmi_pmic_arb_bus *bus,
>   				   struct irq_domain *domain, unsigned int virq,
>   				   irq_hw_number_t hwirq, unsigned int type)
>   {
> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>   	irq_flow_handler_t handler;
>   
> -	dev_dbg(&pmic_arb->spmic->dev, "virq = %u, hwirq = %lu, type = %u\n",
> +	dev_dbg(&bus->spmic->dev, "virq = %u, hwirq = %lu, type = %u\n",
>   		virq, hwirq, type);
>   
>   	if (type & IRQ_TYPE_EDGE_BOTH)
> @@ -928,7 +959,7 @@ static int qpnpint_irq_domain_alloc(struct irq_domain *domain,
>   				    unsigned int virq, unsigned int nr_irqs,
>   				    void *data)
>   {
> -	struct spmi_pmic_arb *pmic_arb = domain->host_data;
> +	struct spmi_pmic_arb_bus *bus = domain->host_data;
>   	struct irq_fwspec *fwspec = data;
>   	irq_hw_number_t hwirq;
>   	unsigned int type;
> @@ -939,20 +970,22 @@ static int qpnpint_irq_domain_alloc(struct irq_domain *domain,
>   		return ret;
>   
>   	for (i = 0; i < nr_irqs; i++)
> -		qpnpint_irq_domain_map(pmic_arb, domain, virq + i, hwirq + i,
> +		qpnpint_irq_domain_map(bus, domain, virq + i, hwirq + i,
>   				       type);
>   
>   	return 0;
>   }
>   
> -static int pmic_arb_init_apid_min_max(struct spmi_pmic_arb *pmic_arb)
> +static int pmic_arb_init_apid_min_max(struct spmi_pmic_arb_bus *bus)
>   {
> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
> +
>   	/*
>   	 * Initialize max_apid/min_apid to the opposite bounds, during
>   	 * the irq domain translation, we are sure to update these
>   	 */
> -	pmic_arb->max_apid = 0;
> -	pmic_arb->min_apid = pmic_arb->max_periphs - 1;
> +	bus->max_apid = 0;
> +	bus->min_apid = pmic_arb->max_periphs - 1;
>   
>   	return 0;
>   }
> @@ -970,43 +1003,44 @@ static int pmic_arb_get_core_resources_v1(struct platform_device *pdev,
>   	return 0;
>   }
>   
> -static int pmic_arb_init_apid_v1(struct spmi_pmic_arb *pmic_arb, int index)
> +static int pmic_arb_init_apid_v1(struct spmi_pmic_arb_bus *bus, int index)
>   {
> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>   	u32 *mapping_table;
>   
>   	if (index) {
> -		dev_err(&pmic_arb->spmic->dev, "Unsupported buses count %d detected\n",
> +		dev_err(&bus->spmic->dev, "Unsupported buses count %d detected\n",
>   			index);
>   		return -EINVAL;
>   	}
>   
> -	mapping_table = devm_kcalloc(&pmic_arb->spmic->dev, pmic_arb->max_periphs,
> +	mapping_table = devm_kcalloc(&bus->spmic->dev, pmic_arb->max_periphs,
>   				     sizeof(*mapping_table), GFP_KERNEL);
>   	if (!mapping_table)
>   		return -ENOMEM;
>   
> -	pmic_arb->mapping_table = mapping_table;
> +	bus->mapping_table = mapping_table;
>   
> -	return pmic_arb_init_apid_min_max(pmic_arb);
> +	return pmic_arb_init_apid_min_max(bus);
>   }
>   
> -static int pmic_arb_ppid_to_apid_v1(struct spmi_pmic_arb *pmic_arb, u16 ppid)
> +static int pmic_arb_ppid_to_apid_v1(struct spmi_pmic_arb_bus *bus, u16 ppid)
>   {
> -	u32 *mapping_table = pmic_arb->mapping_table;
> +	u32 *mapping_table = bus->mapping_table;
>   	int index = 0, i;
>   	u16 apid_valid;
>   	u16 apid;
>   	u32 data;
>   
> -	apid_valid = pmic_arb->ppid_to_apid[ppid];
> +	apid_valid = bus->ppid_to_apid[ppid];
>   	if (apid_valid & PMIC_ARB_APID_VALID) {
>   		apid = apid_valid & ~PMIC_ARB_APID_VALID;
>   		return apid;
>   	}
>   
>   	for (i = 0; i < SPMI_MAPPING_TABLE_TREE_DEPTH; ++i) {
> -		if (!test_and_set_bit(index, pmic_arb->mapping_table_valid))
> -			mapping_table[index] = readl_relaxed(pmic_arb->cnfg +
> +		if (!test_and_set_bit(index, bus->mapping_table_valid))
> +			mapping_table[index] = readl_relaxed(bus->cnfg +
>   						SPMI_MAPPING_TABLE_REG(index));
>   
>   		data = mapping_table[index];
> @@ -1016,9 +1050,9 @@ static int pmic_arb_ppid_to_apid_v1(struct spmi_pmic_arb *pmic_arb, u16 ppid)
>   				index = SPMI_MAPPING_BIT_IS_1_RESULT(data);
>   			} else {
>   				apid = SPMI_MAPPING_BIT_IS_1_RESULT(data);
> -				pmic_arb->ppid_to_apid[ppid]
> +				bus->ppid_to_apid[ppid]
>   					= apid | PMIC_ARB_APID_VALID;
> -				pmic_arb->apid_data[apid].ppid = ppid;
> +				bus->apid_data[apid].ppid = ppid;
>   				return apid;
>   			}
>   		} else {
> @@ -1026,9 +1060,9 @@ static int pmic_arb_ppid_to_apid_v1(struct spmi_pmic_arb *pmic_arb, u16 ppid)
>   				index = SPMI_MAPPING_BIT_IS_0_RESULT(data);
>   			} else {
>   				apid = SPMI_MAPPING_BIT_IS_0_RESULT(data);
> -				pmic_arb->ppid_to_apid[ppid]
> +				bus->ppid_to_apid[ppid]
>   					= apid | PMIC_ARB_APID_VALID;
> -				pmic_arb->apid_data[apid].ppid = ppid;
> +				bus->apid_data[apid].ppid = ppid;
>   				return apid;
>   			}
>   		}
> @@ -1038,24 +1072,26 @@ static int pmic_arb_ppid_to_apid_v1(struct spmi_pmic_arb *pmic_arb, u16 ppid)
>   }
>   
>   /* v1 offset per ee */
> -static int pmic_arb_offset_v1(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
> -			enum pmic_arb_channel ch_type)
> +static int pmic_arb_offset_v1(struct spmi_pmic_arb_bus *bus, u8 sid, u16 addr,
> +			      enum pmic_arb_channel ch_type)
>   {
> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>   	return 0x800 + 0x80 * pmic_arb->channel;
>   }
>   
> -static u16 pmic_arb_find_apid(struct spmi_pmic_arb *pmic_arb, u16 ppid)
> +static u16 pmic_arb_find_apid(struct spmi_pmic_arb_bus *bus, u16 ppid)
>   {
> -	struct apid_data *apidd = &pmic_arb->apid_data[pmic_arb->last_apid];
> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
> +	struct apid_data *apidd = &bus->apid_data[bus->last_apid];
>   	u32 regval, offset;
>   	u16 id, apid;
>   
> -	for (apid = pmic_arb->last_apid; ; apid++, apidd++) {
> +	for (apid = bus->last_apid; ; apid++, apidd++) {
>   		offset = pmic_arb->ver_ops->apid_map_offset(apid);
>   		if (offset >= pmic_arb->core_size)
>   			break;
>   
> -		regval = readl_relaxed(pmic_arb->ver_ops->apid_owner(pmic_arb,
> +		regval = readl_relaxed(pmic_arb->ver_ops->apid_owner(bus,
>   								     apid));
>   		apidd->irq_ee = SPMI_OWNERSHIP_PERIPH2OWNER(regval);
>   		apidd->write_ee = apidd->irq_ee;
> @@ -1065,14 +1101,14 @@ static u16 pmic_arb_find_apid(struct spmi_pmic_arb *pmic_arb, u16 ppid)
>   			continue;
>   
>   		id = (regval >> 8) & PMIC_ARB_PPID_MASK;
> -		pmic_arb->ppid_to_apid[id] = apid | PMIC_ARB_APID_VALID;
> +		bus->ppid_to_apid[id] = apid | PMIC_ARB_APID_VALID;
>   		apidd->ppid = id;
>   		if (id == ppid) {
>   			apid |= PMIC_ARB_APID_VALID;
>   			break;
>   		}
>   	}
> -	pmic_arb->last_apid = apid & ~PMIC_ARB_APID_VALID;
> +	bus->last_apid = apid & ~PMIC_ARB_APID_VALID;
>   
>   	return apid;
>   }
> @@ -1104,21 +1140,22 @@ static int pmic_arb_get_core_resources_v2(struct platform_device *pdev,
>   	return pmic_arb_get_obsrvr_chnls_v2(pdev);
>   }
>   
> -static int pmic_arb_ppid_to_apid_v2(struct spmi_pmic_arb *pmic_arb, u16 ppid)
> +static int pmic_arb_ppid_to_apid_v2(struct spmi_pmic_arb_bus *bus, u16 ppid)
>   {
>   	u16 apid_valid;
>   
> -	apid_valid = pmic_arb->ppid_to_apid[ppid];
> +	apid_valid = bus->ppid_to_apid[ppid];
>   	if (!(apid_valid & PMIC_ARB_APID_VALID))
> -		apid_valid = pmic_arb_find_apid(pmic_arb, ppid);
> +		apid_valid = pmic_arb_find_apid(bus, ppid);
>   	if (!(apid_valid & PMIC_ARB_APID_VALID))
>   		return -ENODEV;
>   
>   	return apid_valid & ~PMIC_ARB_APID_VALID;
>   }
>   
> -static int pmic_arb_read_apid_map_v5(struct spmi_pmic_arb *pmic_arb)
> +static int pmic_arb_read_apid_map_v5(struct spmi_pmic_arb_bus *bus)
>   {
> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>   	struct apid_data *apidd;
>   	struct apid_data *prev_apidd;
>   	u16 i, apid, ppid, apid_max;
> @@ -1140,9 +1177,9 @@ static int pmic_arb_read_apid_map_v5(struct spmi_pmic_arb *pmic_arb)
>   	 * where N = number of APIDs supported by the primary bus and
>   	 *       M = number of APIDs supported by the secondary bus
>   	 */
> -	apidd = &pmic_arb->apid_data[pmic_arb->base_apid];
> -	apid_max = pmic_arb->base_apid + pmic_arb->apid_count;
> -	for (i = pmic_arb->base_apid; i < apid_max; i++, apidd++) {
> +	apidd = &bus->apid_data[bus->base_apid];
> +	apid_max = bus->base_apid + bus->apid_count;
> +	for (i = bus->base_apid; i < apid_max; i++, apidd++) {
>   		offset = pmic_arb->ver_ops->apid_map_offset(i);
>   		if (offset >= pmic_arb->core_size)
>   			break;
> @@ -1153,19 +1190,18 @@ static int pmic_arb_read_apid_map_v5(struct spmi_pmic_arb *pmic_arb)
>   		ppid = (regval >> 8) & PMIC_ARB_PPID_MASK;
>   		is_irq_ee = PMIC_ARB_CHAN_IS_IRQ_OWNER(regval);
>   
> -		regval = readl_relaxed(pmic_arb->ver_ops->apid_owner(pmic_arb,
> -								     i));
> +		regval = readl_relaxed(pmic_arb->ver_ops->apid_owner(bus, i));
>   		apidd->write_ee = SPMI_OWNERSHIP_PERIPH2OWNER(regval);
>   
>   		apidd->irq_ee = is_irq_ee ? apidd->write_ee : INVALID_EE;
>   
> -		valid = pmic_arb->ppid_to_apid[ppid] & PMIC_ARB_APID_VALID;
> -		apid = pmic_arb->ppid_to_apid[ppid] & ~PMIC_ARB_APID_VALID;
> -		prev_apidd = &pmic_arb->apid_data[apid];
> +		valid = bus->ppid_to_apid[ppid] & PMIC_ARB_APID_VALID;
> +		apid = bus->ppid_to_apid[ppid] & ~PMIC_ARB_APID_VALID;
> +		prev_apidd = &bus->apid_data[apid];
>   
>   		if (!valid || apidd->write_ee == pmic_arb->ee) {
>   			/* First PPID mapping or one for this EE */
> -			pmic_arb->ppid_to_apid[ppid] = i | PMIC_ARB_APID_VALID;
> +			bus->ppid_to_apid[ppid] = i | PMIC_ARB_APID_VALID;
>   		} else if (valid && is_irq_ee &&
>   			   prev_apidd->write_ee == pmic_arb->ee) {
>   			/*
> @@ -1176,42 +1212,43 @@ static int pmic_arb_read_apid_map_v5(struct spmi_pmic_arb *pmic_arb)
>   		}
>   
>   		apidd->ppid = ppid;
> -		pmic_arb->last_apid = i;
> +		bus->last_apid = i;
>   	}
>   
>   	/* Dump the mapping table for debug purposes. */
> -	dev_dbg(&pmic_arb->spmic->dev, "PPID APID Write-EE IRQ-EE\n");
> +	dev_dbg(&bus->spmic->dev, "PPID APID Write-EE IRQ-EE\n");
>   	for (ppid = 0; ppid < PMIC_ARB_MAX_PPID; ppid++) {
> -		apid = pmic_arb->ppid_to_apid[ppid];
> +		apid = bus->ppid_to_apid[ppid];
>   		if (apid & PMIC_ARB_APID_VALID) {
>   			apid &= ~PMIC_ARB_APID_VALID;
> -			apidd = &pmic_arb->apid_data[apid];
> -			dev_dbg(&pmic_arb->spmic->dev, "%#03X %3u %2u %2u\n",
> -			      ppid, apid, apidd->write_ee, apidd->irq_ee);
> +			apidd = &bus->apid_data[apid];
> +			dev_dbg(&bus->spmic->dev, "%#03X %3u %2u %2u\n",
> +				ppid, apid, apidd->write_ee, apidd->irq_ee);
>   		}
>   	}
>   
>   	return 0;
>   }
>   
> -static int pmic_arb_ppid_to_apid_v5(struct spmi_pmic_arb *pmic_arb, u16 ppid)
> +static int pmic_arb_ppid_to_apid_v5(struct spmi_pmic_arb_bus *bus, u16 ppid)
>   {
> -	if (!(pmic_arb->ppid_to_apid[ppid] & PMIC_ARB_APID_VALID))
> +	if (!(bus->ppid_to_apid[ppid] & PMIC_ARB_APID_VALID))
>   		return -ENODEV;
>   
> -	return pmic_arb->ppid_to_apid[ppid] & ~PMIC_ARB_APID_VALID;
> +	return bus->ppid_to_apid[ppid] & ~PMIC_ARB_APID_VALID;
>   }
>   
>   /* v2 offset per ppid and per ee */
> -static int pmic_arb_offset_v2(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
> -			   enum pmic_arb_channel ch_type)
> +static int pmic_arb_offset_v2(struct spmi_pmic_arb_bus *bus, u8 sid, u16 addr,
> +			      enum pmic_arb_channel ch_type)
>   {
> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>   	u16 apid;
>   	u16 ppid;
>   	int rc;
>   
>   	ppid = sid << 8 | ((addr >> 8) & 0xFF);
> -	rc = pmic_arb_ppid_to_apid_v2(pmic_arb, ppid);
> +	rc = pmic_arb_ppid_to_apid_v2(bus, ppid);
>   	if (rc < 0)
>   		return rc;
>   
> @@ -1219,33 +1256,34 @@ static int pmic_arb_offset_v2(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
>   	return 0x1000 * pmic_arb->ee + 0x8000 * apid;
>   }
>   
> -static int pmic_arb_init_apid_v5(struct spmi_pmic_arb *pmic_arb, int index)
> +static int pmic_arb_init_apid_v5(struct spmi_pmic_arb_bus *bus, int index)
>   {
> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>   	int ret;
>   
>   	if (index) {
> -		dev_err(&pmic_arb->spmic->dev, "Unsupported buses count %d detected\n",
> +		dev_err(&bus->spmic->dev, "Unsupported buses count %d detected\n",
>   			index);
>   		return -EINVAL;
>   	}
>   
> -	pmic_arb->base_apid = 0;
> -	pmic_arb->apid_count = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES) &
> +	bus->base_apid = 0;
> +	bus->apid_count = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES) &
>   					   PMIC_ARB_FEATURES_PERIPH_MASK;
>   
> -	if (pmic_arb->base_apid + pmic_arb->apid_count > pmic_arb->max_periphs) {
> -		dev_err(&pmic_arb->spmic->dev, "Unsupported APID count %d detected\n",
> -			pmic_arb->base_apid + pmic_arb->apid_count);
> +	if (bus->base_apid + bus->apid_count > pmic_arb->max_periphs) {
> +		dev_err(&bus->spmic->dev, "Unsupported APID count %d detected\n",
> +			bus->base_apid + bus->apid_count);
>   		return -EINVAL;
>   	}
>   
> -	ret = pmic_arb_init_apid_min_max(pmic_arb);
> +	ret = pmic_arb_init_apid_min_max(bus);
>   	if (ret)
>   		return ret;
>   
> -	ret = pmic_arb_read_apid_map_v5(pmic_arb);
> +	ret = pmic_arb_read_apid_map_v5(bus);
>   	if (ret) {
> -		dev_err(&pmic_arb->spmic->dev, "could not read APID->PPID mapping table, rc= %d\n",
> +		dev_err(&bus->spmic->dev, "could not read APID->PPID mapping table, rc= %d\n",
>   			ret);
>   		return ret;
>   	}
> @@ -1257,15 +1295,16 @@ static int pmic_arb_init_apid_v5(struct spmi_pmic_arb *pmic_arb, int index)
>    * v5 offset per ee and per apid for observer channels and per apid for
>    * read/write channels.
>    */
> -static int pmic_arb_offset_v5(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
> -			   enum pmic_arb_channel ch_type)
> +static int pmic_arb_offset_v5(struct spmi_pmic_arb_bus *bus, u8 sid, u16 addr,
> +			      enum pmic_arb_channel ch_type)
>   {
> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>   	u16 apid;
>   	int rc;
>   	u32 offset = 0;
>   	u16 ppid = (sid << 8) | (addr >> 8);
>   
> -	rc = pmic_arb_ppid_to_apid_v5(pmic_arb, ppid);
> +	rc = pmic_arb_ppid_to_apid_v5(bus, ppid);
>   	if (rc < 0)
>   		return rc;
>   
> @@ -1275,8 +1314,8 @@ static int pmic_arb_offset_v5(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
>   		offset = 0x10000 * pmic_arb->ee + 0x80 * apid;
>   		break;
>   	case PMIC_ARB_CHANNEL_RW:
> -		if (pmic_arb->apid_data[apid].write_ee != pmic_arb->ee) {
> -			dev_err(&pmic_arb->spmic->dev, "disallowed SPMI write to sid=%u, addr=0x%04X\n",
> +		if (bus->apid_data[apid].write_ee != pmic_arb->ee) {
> +			dev_err(&bus->spmic->dev, "disallowed SPMI write to sid=%u, addr=0x%04X\n",
>   				sid, addr);
>   			return -EPERM;
>   		}
> @@ -1303,38 +1342,39 @@ static int pmic_arb_get_core_resources_v7(struct platform_device *pdev,
>    * Only v7 supports 2 buses. Each bus will get a different apid count, read
>    * from different registers.
>    */
> -static int pmic_arb_init_apid_v7(struct spmi_pmic_arb *pmic_arb, int index)
> +static int pmic_arb_init_apid_v7(struct spmi_pmic_arb_bus *bus, int index)
>   {
> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>   	int ret;
>   
>   	if (index == 0) {
> -		pmic_arb->base_apid = 0;
> -		pmic_arb->apid_count = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES) &
> +		bus->base_apid = 0;
> +		bus->apid_count = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES) &
>   						   PMIC_ARB_FEATURES_PERIPH_MASK;
>   	} else if (index == 1) {
> -		pmic_arb->base_apid = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES) &
> +		bus->base_apid = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES) &
>   						  PMIC_ARB_FEATURES_PERIPH_MASK;
> -		pmic_arb->apid_count = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES1) &
> +		bus->apid_count = readl_relaxed(pmic_arb->core + PMIC_ARB_FEATURES1) &
>   						   PMIC_ARB_FEATURES_PERIPH_MASK;
>   	} else {
> -		dev_err(&pmic_arb->spmic->dev, "Unsupported buses count %d detected\n",
> -			index);
> +		dev_err(&bus->spmic->dev, "Unsupported buses count %d detected\n",
> +			bus->id);
>   		return -EINVAL;
>   	}
>   
> -	if (pmic_arb->base_apid + pmic_arb->apid_count > pmic_arb->max_periphs) {
> -		dev_err(&pmic_arb->spmic->dev, "Unsupported APID count %d detected\n",
> -			pmic_arb->base_apid + pmic_arb->apid_count);
> +	if (bus->base_apid + bus->apid_count > pmic_arb->max_periphs) {
> +		dev_err(&bus->spmic->dev, "Unsupported APID count %d detected\n",
> +			bus->base_apid + bus->apid_count);
>   		return -EINVAL;
>   	}
>   
> -	ret = pmic_arb_init_apid_min_max(pmic_arb);
> +	ret = pmic_arb_init_apid_min_max(bus);
>   	if (ret)
>   		return ret;
>   
> -	ret = pmic_arb_read_apid_map_v5(pmic_arb);
> +	ret = pmic_arb_read_apid_map_v5(bus);
>   	if (ret) {
> -		dev_err(&pmic_arb->spmic->dev, "could not read APID->PPID mapping table, rc= %d\n",
> +		dev_err(&bus->spmic->dev, "could not read APID->PPID mapping table, rc= %d\n",
>   			ret);
>   		return ret;
>   	}
> @@ -1346,15 +1386,16 @@ static int pmic_arb_init_apid_v7(struct spmi_pmic_arb *pmic_arb, int index)
>    * v7 offset per ee and per apid for observer channels and per apid for
>    * read/write channels.
>    */
> -static int pmic_arb_offset_v7(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
> -			   enum pmic_arb_channel ch_type)
> +static int pmic_arb_offset_v7(struct spmi_pmic_arb_bus *bus, u8 sid, u16 addr,
> +			      enum pmic_arb_channel ch_type)
>   {
> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>   	u16 apid;
>   	int rc;
>   	u32 offset = 0;
>   	u16 ppid = (sid << 8) | (addr >> 8);
>   
> -	rc = pmic_arb->ver_ops->ppid_to_apid(pmic_arb, ppid);
> +	rc = pmic_arb->ver_ops->ppid_to_apid(bus, ppid);
>   	if (rc < 0)
>   		return rc;
>   
> @@ -1364,8 +1405,8 @@ static int pmic_arb_offset_v7(struct spmi_pmic_arb *pmic_arb, u8 sid, u16 addr,
>   		offset = 0x8000 * pmic_arb->ee + 0x20 * apid;
>   		break;
>   	case PMIC_ARB_CHANNEL_RW:
> -		if (pmic_arb->apid_data[apid].write_ee != pmic_arb->ee) {
> -			dev_err(&pmic_arb->spmic->dev, "disallowed SPMI write to sid=%u, addr=0x%04X\n",
> +		if (bus->apid_data[apid].write_ee != pmic_arb->ee) {
> +			dev_err(&bus->spmic->dev, "disallowed SPMI write to sid=%u, addr=0x%04X\n",
>   				sid, addr);
>   			return -EPERM;
>   		}
> @@ -1387,104 +1428,110 @@ static u32 pmic_arb_fmt_cmd_v2(u8 opc, u8 sid, u16 addr, u8 bc)
>   }
>   
>   static void __iomem *
> -pmic_arb_owner_acc_status_v1(struct spmi_pmic_arb *pmic_arb, u8 m, u16 n)
> +pmic_arb_owner_acc_status_v1(struct spmi_pmic_arb_bus *bus, u8 m, u16 n)
>   {
> -	return pmic_arb->intr + 0x20 * m + 0x4 * n;
> +	return bus->intr + 0x20 * m + 0x4 * n;
>   }
>   
>   static void __iomem *
> -pmic_arb_owner_acc_status_v2(struct spmi_pmic_arb *pmic_arb, u8 m, u16 n)
> +pmic_arb_owner_acc_status_v2(struct spmi_pmic_arb_bus *bus, u8 m, u16 n)
>   {
> -	return pmic_arb->intr + 0x100000 + 0x1000 * m + 0x4 * n;
> +	return bus->intr + 0x100000 + 0x1000 * m + 0x4 * n;
>   }
>   
>   static void __iomem *
> -pmic_arb_owner_acc_status_v3(struct spmi_pmic_arb *pmic_arb, u8 m, u16 n)
> +pmic_arb_owner_acc_status_v3(struct spmi_pmic_arb_bus *bus, u8 m, u16 n)
>   {
> -	return pmic_arb->intr + 0x200000 + 0x1000 * m + 0x4 * n;
> +	return bus->intr + 0x200000 + 0x1000 * m + 0x4 * n;
>   }
>   
>   static void __iomem *
> -pmic_arb_owner_acc_status_v5(struct spmi_pmic_arb *pmic_arb, u8 m, u16 n)
> +pmic_arb_owner_acc_status_v5(struct spmi_pmic_arb_bus *bus, u8 m, u16 n)
>   {
> -	return pmic_arb->intr + 0x10000 * m + 0x4 * n;
> +	return bus->intr + 0x10000 * m + 0x4 * n;
>   }
>   
>   static void __iomem *
> -pmic_arb_owner_acc_status_v7(struct spmi_pmic_arb *pmic_arb, u8 m, u16 n)
> +pmic_arb_owner_acc_status_v7(struct spmi_pmic_arb_bus *bus, u8 m, u16 n)
>   {
> -	return pmic_arb->intr + 0x1000 * m + 0x4 * n;
> +	return bus->intr + 0x1000 * m + 0x4 * n;
>   }
>   
>   static void __iomem *
> -pmic_arb_acc_enable_v1(struct spmi_pmic_arb *pmic_arb, u16 n)
> +pmic_arb_acc_enable_v1(struct spmi_pmic_arb_bus *bus, u16 n)
>   {
> -	return pmic_arb->intr + 0x200 + 0x4 * n;
> +	return bus->intr + 0x200 + 0x4 * n;
>   }
>   
>   static void __iomem *
> -pmic_arb_acc_enable_v2(struct spmi_pmic_arb *pmic_arb, u16 n)
> +pmic_arb_acc_enable_v2(struct spmi_pmic_arb_bus *bus, u16 n)
>   {
> -	return pmic_arb->intr + 0x1000 * n;
> +	return bus->intr + 0x1000 * n;
>   }
>   
>   static void __iomem *
> -pmic_arb_acc_enable_v5(struct spmi_pmic_arb *pmic_arb, u16 n)
> +pmic_arb_acc_enable_v5(struct spmi_pmic_arb_bus *bus, u16 n)
>   {
> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>   	return pmic_arb->wr_base + 0x100 + 0x10000 * n;
>   }
>   
>   static void __iomem *
> -pmic_arb_acc_enable_v7(struct spmi_pmic_arb *pmic_arb, u16 n)
> +pmic_arb_acc_enable_v7(struct spmi_pmic_arb_bus *bus, u16 n)
>   {
> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>   	return pmic_arb->wr_base + 0x100 + 0x1000 * n;
>   }
>   
>   static void __iomem *
> -pmic_arb_irq_status_v1(struct spmi_pmic_arb *pmic_arb, u16 n)
> +pmic_arb_irq_status_v1(struct spmi_pmic_arb_bus *bus, u16 n)
>   {
> -	return pmic_arb->intr + 0x600 + 0x4 * n;
> +	return bus->intr + 0x600 + 0x4 * n;
>   }
>   
>   static void __iomem *
> -pmic_arb_irq_status_v2(struct spmi_pmic_arb *pmic_arb, u16 n)
> +pmic_arb_irq_status_v2(struct spmi_pmic_arb_bus *bus, u16 n)
>   {
> -	return pmic_arb->intr + 0x4 + 0x1000 * n;
> +	return bus->intr + 0x4 + 0x1000 * n;
>   }
>   
>   static void __iomem *
> -pmic_arb_irq_status_v5(struct spmi_pmic_arb *pmic_arb, u16 n)
> +pmic_arb_irq_status_v5(struct spmi_pmic_arb_bus *bus, u16 n)
>   {
> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>   	return pmic_arb->wr_base + 0x104 + 0x10000 * n;
>   }
>   
>   static void __iomem *
> -pmic_arb_irq_status_v7(struct spmi_pmic_arb *pmic_arb, u16 n)
> +pmic_arb_irq_status_v7(struct spmi_pmic_arb_bus *bus, u16 n)
>   {
> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>   	return pmic_arb->wr_base + 0x104 + 0x1000 * n;
>   }
>   
>   static void __iomem *
> -pmic_arb_irq_clear_v1(struct spmi_pmic_arb *pmic_arb, u16 n)
> +pmic_arb_irq_clear_v1(struct spmi_pmic_arb_bus *bus, u16 n)
>   {
> -	return pmic_arb->intr + 0xA00 + 0x4 * n;
> +	return bus->intr + 0xA00 + 0x4 * n;
>   }
>   
>   static void __iomem *
> -pmic_arb_irq_clear_v2(struct spmi_pmic_arb *pmic_arb, u16 n)
> +pmic_arb_irq_clear_v2(struct spmi_pmic_arb_bus *bus, u16 n)
>   {
> -	return pmic_arb->intr + 0x8 + 0x1000 * n;
> +	return bus->intr + 0x8 + 0x1000 * n;
>   }
>   
>   static void __iomem *
> -pmic_arb_irq_clear_v5(struct spmi_pmic_arb *pmic_arb, u16 n)
> +pmic_arb_irq_clear_v5(struct spmi_pmic_arb_bus *bus, u16 n)
>   {
> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>   	return pmic_arb->wr_base + 0x108 + 0x10000 * n;
>   }
>   
>   static void __iomem *
> -pmic_arb_irq_clear_v7(struct spmi_pmic_arb *pmic_arb, u16 n)
> +pmic_arb_irq_clear_v7(struct spmi_pmic_arb_bus *bus, u16 n)
>   {
> +	struct spmi_pmic_arb *pmic_arb = bus->pmic_arb;
>   	return pmic_arb->wr_base + 0x108 + 0x1000 * n;
>   }
>   
> @@ -1504,9 +1551,9 @@ static u32 pmic_arb_apid_map_offset_v7(u16 n)
>   }
>   
>   static void __iomem *
> -pmic_arb_apid_owner_v2(struct spmi_pmic_arb *pmic_arb, u16 n)
> +pmic_arb_apid_owner_v2(struct spmi_pmic_arb_bus *bus, u16 n)
>   {
> -	return pmic_arb->cnfg + 0x700 + 0x4 * n;
> +	return bus->cnfg + 0x700 + 0x4 * n;
>   }
>   
>   /*
> @@ -1515,9 +1562,9 @@ pmic_arb_apid_owner_v2(struct spmi_pmic_arb *pmic_arb, u16 n)
>    * 0.
>    */
>   static void __iomem *
> -pmic_arb_apid_owner_v7(struct spmi_pmic_arb *pmic_arb, u16 n)
> +pmic_arb_apid_owner_v7(struct spmi_pmic_arb_bus *bus, u16 n)
>   {
> -	return pmic_arb->cnfg + 0x4 * (n - pmic_arb->base_apid);
> +	return  bus->cnfg + 0x4 * (n - bus->base_apid);
>   }
>   
>   static const struct pmic_arb_ver_ops pmic_arb_v1 = {
> @@ -1607,29 +1654,159 @@ static const struct irq_domain_ops pmic_arb_irq_domain_ops = {
>   	.translate = qpnpint_irq_domain_translate,
>   };
>   
> +static int spmi_pmic_arb_bus_init(struct platform_device *pdev,
> +				  struct device_node *node,
> +				  struct spmi_pmic_arb *pmic_arb)
> +{
> +	int bus_index = pmic_arb->buses_available;
> +	struct spmi_pmic_arb_bus *bus = &pmic_arb->buses[bus_index];
> +	struct device *dev = &pdev->dev;
> +	struct spmi_controller *ctrl;
> +	void __iomem *intr;
> +	void __iomem *cnfg;
> +	int index, ret;
> +	u32 irq;
> +
> +	ctrl = devm_spmi_controller_alloc(dev, sizeof(*ctrl));
> +	if (IS_ERR(ctrl))
> +		return PTR_ERR(ctrl);
> +
> +	ctrl->cmd = pmic_arb_cmd;
> +	ctrl->read_cmd = pmic_arb_read_cmd;
> +	ctrl->write_cmd = pmic_arb_write_cmd;
> +
> +	bus = spmi_controller_get_drvdata(ctrl);
> +	bus->spmic = ctrl;
> +
> +	bus->ppid_to_apid = devm_kcalloc(dev, PMIC_ARB_MAX_PPID,
> +					 sizeof(*bus->ppid_to_apid),
> +					 GFP_KERNEL);
> +	if (!bus->ppid_to_apid)
> +		return -ENOMEM;
> +
> +	bus->apid_data = devm_kcalloc(dev, pmic_arb->max_periphs,
> +				      sizeof(*bus->apid_data),
> +				      GFP_KERNEL);
> +	if (!bus->apid_data)
> +		return -ENOMEM;
> +
> +	index = of_property_match_string(node, "reg-names", "cnfg");
> +	if (index < 0) {
> +		dev_err(dev, "cnfg reg region missing");
> +		return -EINVAL;
> +	}
> +
> +	cnfg = devm_of_iomap(dev, node, index, NULL);
> +	if (IS_ERR(cnfg))
> +		return PTR_ERR(cnfg);
> +
> +	index = of_property_match_string(node, "reg-names", "intr");
> +	if (index < 0) {
> +		dev_err(dev, "intr reg region missing");
> +		return -EINVAL;
> +	}
> +
> +	intr = devm_of_iomap(dev, node, index, NULL);
> +	if (IS_ERR(intr))
> +		return PTR_ERR(intr);
> +
> +	irq = of_irq_get_byname(node, "periph_irq");
> +	if (irq < 0)
> +		return irq;
> +
> +	bus->pmic_arb = pmic_arb;
> +	bus->intr = intr;
> +	bus->cnfg = cnfg;
> +	bus->irq = irq;
> +	bus->id = bus_index;
> +
> +	ret = pmic_arb->ver_ops->init_apid(bus, bus_index);
> +	if (ret)
> +		return ret;
> +
> +	dev_dbg(&pdev->dev, "adding irq domain for bus %d\n", bus_index);
> +
> +	bus->domain = irq_domain_add_tree(dev->of_node,
> +					  &pmic_arb_irq_domain_ops, bus);
> +	if (!bus->domain) {
> +		dev_err(&pdev->dev, "unable to create irq_domain\n");
> +		return -ENOMEM;
> +	}
> +
> +	irq_set_chained_handler_and_data(bus->irq,
> +					 pmic_arb_chained_irq, bus);
> +
> +	bus->spmic->dev.of_node = node;
> +	dev_set_name(&bus->spmic->dev, "spmi-%d", bus_index);
> +
> +	ret = devm_spmi_controller_add(dev, bus->spmic);
> +	if (ret)
> +		return ret;
> +
> +	pmic_arb->buses_available++;
> +
> +	return 0;
> +}
> +
> +static int spmi_pmic_arb_register_buses(struct spmi_pmic_arb *pmic_arb,
> +					struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *node = dev->of_node;
> +	struct device_node *child;
> +	int ret;
> +
> +	/* legacy mode doesn't provide child node for the bus */
> +	if (of_device_is_compatible(node, "qcom,spmi-pmic-arb"))
> +		return spmi_pmic_arb_bus_init(pdev, node, pmic_arb);
> +
> +	for_each_available_child_of_node(node, child) {
> +		if (of_node_name_eq(child, "spmi")) {
> +			ret = spmi_pmic_arb_bus_init(pdev, child, pmic_arb);
> +			if (ret)
> +				return ret;
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static void spmi_pmic_arb_deregister_buses(struct spmi_pmic_arb *pmic_arb)
> +{
> +	int i;
> +
> +	for (i = 0; i < PMIC_ARB_MAX_BUSES; i++) {
> +		struct spmi_pmic_arb_bus *bus = &pmic_arb->buses[i];
> +
> +		irq_set_chained_handler_and_data(bus->irq,
> +						 NULL, NULL);
> +		irq_domain_remove(bus->domain);
> +	}
> +}
> +
>   static int spmi_pmic_arb_probe(struct platform_device *pdev)
>   {
>   	struct spmi_pmic_arb *pmic_arb;
> -	struct spmi_controller *ctrl;
> +	struct device *dev = &pdev->dev;
>   	struct resource *res;
>   	void __iomem *core;
>   	u32 channel, ee, hw_ver;
>   	int err;
>   
> -	ctrl = devm_spmi_controller_alloc(&pdev->dev, sizeof(*pmic_arb));
> -	if (IS_ERR(ctrl))
> -		return PTR_ERR(ctrl);
> -
> -	pmic_arb = spmi_controller_get_drvdata(ctrl);
> -	pmic_arb->spmic = ctrl;
> +	pmic_arb = devm_kzalloc(dev, sizeof(*pmic_arb), GFP_KERNEL);
> +	if (!pmic_arb)
> +		return -ENOMEM;
>   
>   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "core");
> -	core = devm_ioremap(&ctrl->dev, res->start, resource_size(res));
> +	core = devm_ioremap(dev, res->start, resource_size(res));
>   	if (IS_ERR(core))
>   		return PTR_ERR(core);
>   
>   	pmic_arb->core_size = resource_size(res);
>   
> +	platform_set_drvdata(pdev, pmic_arb);
> +	raw_spin_lock_init(&pmic_arb->lock);
> +
>   	hw_ver = readl_relaxed(core + PMIC_ARB_VERSION);
>   
>   	if (hw_ver < PMIC_ARB_VERSION_V2_MIN)
> @@ -1643,30 +1820,12 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
>   	else
>   		pmic_arb->ver_ops = &pmic_arb_v7;
>   
> -	dev_info(&ctrl->dev, "PMIC arbiter version %s (0x%x)\n",
> -		 pmic_arb->ver_ops->ver_str, hw_ver);
> -
>   	err = pmic_arb->ver_ops->get_core_resources(pdev, core);
>   	if (err)
>   		return err;
>   
> -	err = pmic_arb->ver_ops->init_apid(pmic_arb, 0);
> -	if (err)
> -		return err;
> -
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "intr");
> -	pmic_arb->intr = devm_ioremap_resource(&ctrl->dev, res);
> -	if (IS_ERR(pmic_arb->intr))
> -		return PTR_ERR(pmic_arb->intr);
> -
> -	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cnfg");
> -	pmic_arb->cnfg = devm_ioremap_resource(&ctrl->dev, res);
> -	if (IS_ERR(pmic_arb->cnfg))
> -		return PTR_ERR(pmic_arb->cnfg);
> -
> -	pmic_arb->irq = platform_get_irq_byname(pdev, "periph_irq");
> -	if (pmic_arb->irq < 0)
> -		return pmic_arb->irq;
> +	dev_info(dev, "PMIC arbiter version %s (0x%x)\n",
> +		 pmic_arb->ver_ops->ver_str, hw_ver);
>   
>   	err = of_property_read_u32(pdev->dev.of_node, "qcom,channel", &channel);
>   	if (err) {
> @@ -1695,46 +1854,19 @@ static int spmi_pmic_arb_probe(struct platform_device *pdev)
>   
>   	pmic_arb->ee = ee;
>   
> -	platform_set_drvdata(pdev, ctrl);
> -	raw_spin_lock_init(&pmic_arb->lock);
> -
> -	ctrl->cmd = pmic_arb_cmd;
> -	ctrl->read_cmd = pmic_arb_read_cmd;
> -	ctrl->write_cmd = pmic_arb_write_cmd;
> -
> -	dev_dbg(&pdev->dev, "adding irq domain\n");
> -	pmic_arb->domain = irq_domain_add_tree(pdev->dev.of_node,
> -					 &pmic_arb_irq_domain_ops, pmic_arb);
> -	if (!pmic_arb->domain) {
> -		dev_err(&pdev->dev, "unable to create irq_domain\n");
> -		return -ENOMEM;
> -	}
> -
> -	irq_set_chained_handler_and_data(pmic_arb->irq, pmic_arb_chained_irq,
> -					pmic_arb);
> -	err = spmi_controller_add(ctrl);
> -	if (err)
> -		goto err_domain_remove;
> -
> -	return 0;
> -
> -err_domain_remove:
> -	irq_set_chained_handler_and_data(pmic_arb->irq, NULL, NULL);
> -	irq_domain_remove(pmic_arb->domain);
> -	return err;
> +	return spmi_pmic_arb_register_buses(pmic_arb, pdev);
>   }
>   
>   static void spmi_pmic_arb_remove(struct platform_device *pdev)
>   {
> -	struct spmi_controller *ctrl = platform_get_drvdata(pdev);
> -	struct spmi_pmic_arb *pmic_arb = spmi_controller_get_drvdata(ctrl);
> -	spmi_controller_remove(ctrl);
> -	irq_set_chained_handler_and_data(pmic_arb->irq, NULL, NULL);
> -	irq_domain_remove(pmic_arb->domain);
> +	struct spmi_pmic_arb *pmic_arb = platform_get_drvdata(pdev);
> +
> +	spmi_pmic_arb_deregister_buses(pmic_arb);
>   }
>   
>   static const struct of_device_id spmi_pmic_arb_match_table[] = {
>   	{ .compatible = "qcom,spmi-pmic-arb", },
> +	{ .compatible = "qcom,x1e80100-spmi-pmic-arb", },
>   	{},
>   };
>   MODULE_DEVICE_TABLE(of, spmi_pmic_arb_match_table);
> 

The change is quite long and it's hard to disinguish the introduction of
spmi_pmic_arb_bus and the addition of 2 busses for v7.

Could you split in 2 by:
1) adding spmi_pmic_arb_bus but only registering a single bus
2) add the plumbing for 2 busses for v7

it would help review and bisecting.

Thanks,
Neil

