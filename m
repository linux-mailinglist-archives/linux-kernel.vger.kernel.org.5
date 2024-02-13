Return-Path: <linux-kernel+bounces-63733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 533B88533CB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:57:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7870E1C28782
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB3C5EE6C;
	Tue, 13 Feb 2024 14:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J2XWJFDJ"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9035E3D8
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836161; cv=none; b=t2tiZSV3k/CedzR914hGZVUbY3pAFl5dGP/qxKxruyaoGCdw7N0VdbKPo7fkekYMwBiMgoe12h39vfClSGrzaYGWej13xtzxJoxUmh6d6rpSVybyh1Ob6bMaWys3Kz+NAWzdIM5zrCxTBXNUAxoYmrHhC4kRSVnjbFQ8OqnNzoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836161; c=relaxed/simple;
	bh=J21Pamh92j676AcnRBM3nQWy16qRSwaFtW4FAdvBVCY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZAj24U6opOMvNp/a8DYljNE2IFWdK8ui5LFVtOzJCXI7rxYz7YPkhEtCIpe8UyWjy72Cqlk+zoveyiA7Gzx72bMF6EI+Kc/fhrFija9IIRcBtvBC53O2rdkRTP0Zu2hnLEfeWA2zDCYEQxc79gX1NuN0MpvXpPTZvaP1vvwpunk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=J2XWJFDJ; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d0f7585d89so27931391fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707836157; x=1708440957; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tyULzsF+PCPr3bLPUsuXAABJpQii+iHiCCazp+x9FKM=;
        b=J2XWJFDJdEO+Qr1GXdXuxZ1TymAK0tsqArUMtrs6E1BhqNK0wEvKys2qOu+/cIjibB
         JpjaV6XR+0NUuobqtNwOY8GtokbXq+JTofdcMnIewvQbu8iMjfE5YfYgXdpt4XfsdaJg
         3ZXE9WlRHp9uvUhGOjcgqZcvl2znyv0ckSvncraMzE/FKwJw7l4jI18lCYzD2YDBWkUw
         SJkS6BcdRK8JfZ108v91Yy6ucqbZ0f+ocI8wQIkjcrJhe2TuLD6xmnLSN1x51Xmnxry+
         lcITfie9vAOsjrO8QqaIAdm1Vmfg2ILtcNd7WdSzDyITOiVzKUgFSi1b/dwCMwTLVnfT
         RyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707836157; x=1708440957;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tyULzsF+PCPr3bLPUsuXAABJpQii+iHiCCazp+x9FKM=;
        b=SuRDCQma0Nqd93frqissKTCbnU6nOWfhzkRovsuoCen82S6lXSukTjgdfsZNHr88C5
         TFaXhTlmtdXb7sy5Bxzz9cQYbT/jgfV16kpn2XfGKAvsHH8g7Iby8rJVYCNJSyM7rhKr
         Qu+47L6bTjByajh64A9hh6EV+HgCxH62jJB5Y4arGn2n9XVBp9vLIJbRMCKUv7MdoNve
         Yag6YEA9eLn5lybrMhDN7vlh9K2ijAwWozJiWqIkdfuZ9H3MQzzu8h/6LjjzLoj0l9uq
         EQ0oMDkZY4aHYwKwaQ2ds2YmfI1sFrjxeEbvs4WNINpRiBDsr+nPN9Gbys2RgF1pXDhm
         N0qw==
X-Forwarded-Encrypted: i=1; AJvYcCWWp3ydSd5wmABlnLpkA30Oj4QSrDHbK+K468MrRqIEWuLdXjQbUbVXWcDVCa9LjXJ0e/3rFjAVjKcyqfQXID3pPksNJD68OlEDZTbT
X-Gm-Message-State: AOJu0Yy+FY0paBEyvI4WyKG+kRx+ClovV6zH5m9XR6KjPM0wqCtEGvTp
	G65MBhDypdbBGvpolwm4hdLu+d+sDZbETXadExAiqylRH96pLqDdAF6LFfYvaTk=
X-Google-Smtp-Source: AGHT+IEJCO0191MmfYiLczJH0jtOt3i1sjwtrPWFnSTEsob40TAFOJo5Gn/yIPKs5y82EJc87GKl9A==
X-Received: by 2002:a2e:9a83:0:b0:2d0:a4f7:11aa with SMTP id p3-20020a2e9a83000000b002d0a4f711aamr6763639lji.41.1707836157531;
        Tue, 13 Feb 2024 06:55:57 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVEytTq+rKwG7mGlC1anzHlgZi4NtoC9XUXwYJwkoJQSu1uW46zONAmiTLzr6Alaz4/yLqDf7lksuvBfJHvkiVaInwni84l7hXR/yOIf9mFW1w1GDkNipdGdUKf7fm3MP8xW6wY5TpPMl4wTomivGfj85UG/0BlaUmjKGeJswRosgiX25NaFLE7k9NWemX8IRDKDhI1sHKuQpQkGsRH0XjpmrIO74O4NcTErM7uO3WzT/5HOXT1qJkIbTcvlPD36wVVbumLhcPtGn5Rx75xrf/p/zC21aK3uL62np9r8eXQHsdKz7KIdWrxiq5b/hPgoypek15+NbIs8mkRM/G9ebS1Z8ZOMZmGof1tHEr9ZRhT/WIxN5fN1fl4dsfcbGrYfjO9VeiHpQ++Oy82hv/WOAXUqjPGLNNNtzm+urcsJMMJKn6NQOqQHxq+IegvOrVMz+qXzfra8g==
Received: from ?IPV6:2a01:e0a:982:cbb0:6dfb:5e62:c51f:304b? ([2a01:e0a:982:cbb0:6dfb:5e62:c51f:304b])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600c46ce00b0040fdf2832desm12195850wmo.12.2024.02.13.06.55.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Feb 2024 06:55:57 -0800 (PST)
Message-ID: <3fcb9f16-61f8-4544-a319-20496d5eb106@linaro.org>
Date: Tue, 13 Feb 2024 15:55:56 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH RFC v2] spmi: pmic-arb: Add support for multiple buses
Content-Language: en-US, fr
To: Abel Vesa <abel.vesa@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Srini Kandagatla <srinivas.kandagatla@linaro.org>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20240213-spmi-multi-master-support-v2-1-b3b102326906@linaro.org>
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
In-Reply-To: <20240213-spmi-multi-master-support-v2-1-b3b102326906@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/02/2024 15:41, Abel Vesa wrote:
> The v7 HW supports currently 2 buses. So register each bus as a separate
> spmi controller and adapt all ops to use the bus instead of the
> arbitrator. Legacy mode is still supported as long as there is no child
> node that represents a bus, instead all nodes are expected to be actual
> slave devices.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
> Changes in v2:
> - Reworked it so that it registers a spmi controller for each bus
>    rather than relying on the generic framework to pass on the bus
>    (master) id.

Thanks, I think this is better.

> - Link to v1: https://lore.kernel.org/r/20240207-spmi-multi-master-support-v1-0-ce57f301c7fd@linaro.org
> ---
>   drivers/spmi/spmi-pmic-arb.c | 950 ++++++++++++++++++++++++++-----------------
>   1 file changed, 585 insertions(+), 365 deletions(-)
> 
> diff --git a/drivers/spmi/spmi-pmic-arb.c b/drivers/spmi/spmi-pmic-arb.c
> index 9ed1180fe31f..eced35b712b4 100644
> --- a/drivers/spmi/spmi-pmic-arb.c
> +++ b/drivers/spmi/spmi-pmic-arb.c

<snip>


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
> +	/* Optional property for v7: */
> +	of_property_read_u32(node, "qcom,bus-id", &bus_index);

Not sure what bindings you plan to use, but this should be the reg property.

> +	if (bus_index != pmic_arb->buses_available) {
> +		dev_err(dev, "wrong bus-id value");
> +		return -EINVAL;
> +	}
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
> +	ret = pmic_arb->ver_ops->init_apid(bus, index);
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
> +	for_each_available_child_of_node(node, child)
> +		if (of_node_name_eq(child, "bus")) {

It seems you use "bus" subnodes, it seems you should also submit a new
bindings scheme for v7 controllers with subnodes

> +			ret = spmi_pmic_arb_bus_init(pdev, child, pmic_arb);
> +			if (ret)
> +				return ret;
> +		}
> +
> +	if (!pmic_arb->buses_available)
> +		ret = spmi_pmic_arb_bus_init(pdev, node, pmic_arb);
> +
> +	return ret;
> +}
> +
> +static void spmi_pmic_arb_deregister_buses(struct spmi_pmic_arb *pmic_arb)
> +{
> +	int i;
> +
> +	for (i = 0; i < pmic_arb->buses_available; i++) {
> +		struct spmi_pmic_arb_bus *bus = &pmic_arb->buses[i];
> +
> +		irq_set_chained_handler_and_data(bus->irq,
> +						 NULL, NULL);
> +		irq_domain_remove(bus->domain);
> +	}
> +}
> +

<snip>

Overall the patch is __huge__, could you split it ? Like move the bus handling
then add the multi-bus support in separate patches ?

But first please add new bindings first so we know what you expect from DT.

Thanks,
Neil

> 
> ---
> base-commit: 445a555e0623387fa9b94e68e61681717e70200a
> change-id: 20240207-spmi-multi-master-support-832a704b779b
> 
> Best regards,


