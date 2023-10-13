Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 567147C85F5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbjJMMj4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:39:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbjJMMjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:39:54 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B21A9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:39:52 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-406619b53caso21735905e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 05:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697200791; x=1697805591; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NiucGJ23kleVfOPFdzHx+PITXQzpKfuepfl0A0K/y/8=;
        b=XF7kmUSZVYEIrKrAoXapyvZkbXSY5mylll84s6NvUvmyoId2ugeUYe5EERlcFPoTb8
         KebzYhw/2bRmDgz9NsJIWR+VpB50vUSJkYwIFbNoV4dsvuUNXjNp7QrKFU6qgTxg/kit
         LBi5akfFmxauz4lHoHXDJ6ikH5Eu5pfUkfRXHy52Dur4rUT6xJRbnju5r5CckLRq/TOK
         2y70qm7RwDTNu/LWqHBMJvRxe1TaLIjhBDgK/mqJ5rnYw6DtuRqRSW9EspKxRU0PjWwk
         P5cINRn6Am+x9p00IDiTzuiozlYFy2sipgJoxFb9zW0W2ZZuE6w0uhIgIE/11X9jdNEt
         sOyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697200791; x=1697805591;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NiucGJ23kleVfOPFdzHx+PITXQzpKfuepfl0A0K/y/8=;
        b=dlbJwYRqhTY7F4qQiYr08Fv1YGkU6vJtDP0mDe/gVtioRMnQmrGgADwbW7O5pvePHo
         KNg/1ETVpAPyDUqQUGnQElRed9PB7aBoIFdc79hCNMau9oEUKlsR1+hh/U09IcTkPdZy
         yoq0+bXs7161n2PZCZw+DbbxadN6YacIMUQWHeeionEdgErUrgQdSfiREeisyKuvM/4c
         jZtea71Wf56xgcITgQm65vrxprKEjiTlnhJX67z26egrR27TPegYuYeiU4xkv5I5CCxT
         eT2vw0cPh1a4nFSON+bEoe1xcWRaXThMr3f37wDktRgOnkZpGKBHk9wYkQ8EylU5vZLO
         lORw==
X-Gm-Message-State: AOJu0Yx2i8ZOd1aMMAL9DFZAv8KALUjjLDQ2eH59m9uCqR5or3kjIuk4
        cqjD4+ZzgKpukHTRz3S7MOhLRA==
X-Google-Smtp-Source: AGHT+IGxB2bW44bO6m+dViA6Wkvp3pCcF/tOqel7uDj6gisWa2jn4vi/SsHLZePR9fqtB7EcCSDqzQ==
X-Received: by 2002:a5d:548f:0:b0:31d:d48f:12a3 with SMTP id h15-20020a5d548f000000b0031dd48f12a3mr20805925wrv.43.1697200790694;
        Fri, 13 Oct 2023 05:39:50 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:535e:33c9:c7dd:4940? ([2a01:e0a:982:cbb0:535e:33c9:c7dd:4940])
        by smtp.gmail.com with ESMTPSA id l21-20020a05600c1d1500b00402f713c56esm25696wms.2.2023.10.13.05.39.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Oct 2023 05:39:50 -0700 (PDT)
Message-ID: <0afed2a2-8dce-4922-98bb-a7121c9f02bd@linaro.org>
Date:   Fri, 13 Oct 2023 14:39:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/3] usb: typec: fsa4480: Add support to swap SBU
 orientation
Content-Language: en-US, fr
To:     Luca Weiss <luca.weiss@fairphone.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
References: <20231013-fsa4480-swap-v1-0-b877f62046cc@fairphone.com>
 <20231013-fsa4480-swap-v1-2-b877f62046cc@fairphone.com>
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
In-Reply-To: <20231013-fsa4480-swap-v1-2-b877f62046cc@fairphone.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/10/2023 13:38, Luca Weiss wrote:
> On some hardware designs the AUX+/- lanes are connected reversed to
> SBU1/2 compared to the expected design by FSA4480.
> 
> Made more complicated, the otherwise compatible Orient-Chip OCP96011
> expects the lanes to be connected reversed compared to FSA4480.
> 
> * FSA4480 block diagram shows AUX+ connected to SBU2 and AUX- to SBU1.
> * OCP96011 block diagram shows AUX+ connected to SBU1 and AUX- to SBU2.
> 
> So if OCP96011 is used as drop-in for FSA4480 then the orientation
> handling in the driver needs to be reversed to match the expectation of
> the OCP96011 hardware.
> 
> Support parsing the data-lanes parameter in the endpoint node to swap
> this in the driver.
> 
> The parse_data_lanes_mapping function is mostly taken from nb7vpq904m.c.

I see the inspiration :-)

> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>   drivers/usb/typec/mux/fsa4480.c | 81 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 81 insertions(+)
> 
> diff --git a/drivers/usb/typec/mux/fsa4480.c b/drivers/usb/typec/mux/fsa4480.c
> index e0ee1f621abb..6ee467c96fb6 100644
> --- a/drivers/usb/typec/mux/fsa4480.c
> +++ b/drivers/usb/typec/mux/fsa4480.c
> @@ -9,6 +9,7 @@
>   #include <linux/kernel.h>
>   #include <linux/module.h>
>   #include <linux/mutex.h>
> +#include <linux/of_graph.h>
>   #include <linux/regmap.h>
>   #include <linux/usb/typec_dp.h>
>   #include <linux/usb/typec_mux.h>
> @@ -60,6 +61,7 @@ struct fsa4480 {
>   	unsigned int svid;
>   
>   	u8 cur_enable;
> +	bool swap_sbu_lanes;
>   };
>   
>   static const struct regmap_config fsa4480_regmap_config = {
> @@ -76,6 +78,9 @@ static int fsa4480_set(struct fsa4480 *fsa)
>   	u8 enable = FSA4480_ENABLE_DEVICE;
>   	u8 sel = 0;
>   
> +	if (fsa->swap_sbu_lanes)
> +		reverse = !reverse;
> +
>   	/* USB Mode */
>   	if (fsa->mode < TYPEC_STATE_MODAL ||
>   	    (!fsa->svid && (fsa->mode == TYPEC_MODE_USB2 ||
> @@ -179,12 +184,84 @@ static int fsa4480_mux_set(struct typec_mux_dev *mux, struct typec_mux_state *st
>   	return ret;
>   }
>   
> +enum {
> +	NORMAL_LANE_MAPPING,
> +	INVERT_LANE_MAPPING,
> +};
> +
> +#define DATA_LANES_COUNT	2
> +
> +static const int supported_data_lane_mapping[][DATA_LANES_COUNT] = {
> +	[NORMAL_LANE_MAPPING] = { 0, 1 },
> +	[INVERT_LANE_MAPPING] = { 1, 0 },
> +};
> +
> +static int fsa4480_parse_data_lanes_mapping(struct fsa4480 *fsa)
> +{
> +	struct device_node *ep;
> +	u32 data_lanes[DATA_LANES_COUNT];
> +	int ret, i, j;
> +
> +	ep = of_graph_get_next_endpoint(fsa->client->dev.of_node, NULL);
> +	if (!ep)
> +		return 0;
> +
> +	ret = of_property_count_u32_elems(ep, "data-lanes");
> +	if (ret == -EINVAL)
> +		/* Property isn't here, consider default mapping */
> +		goto out_done;
> +	if (ret < 0)
> +		goto out_error;
> +
> +	if (ret != DATA_LANES_COUNT) {
> +		dev_err(&fsa->client->dev, "expected 2 data lanes\n");
> +		ret = -EINVAL;
> +		goto out_error;
> +	}
> +
> +	ret = of_property_read_u32_array(ep, "data-lanes", data_lanes, DATA_LANES_COUNT);
> +	if (ret)
> +		goto out_error;
> +
> +	for (i = 0; i < ARRAY_SIZE(supported_data_lane_mapping); i++) {
> +		for (j = 0; j < DATA_LANES_COUNT; j++) {
> +			if (data_lanes[j] != supported_data_lane_mapping[i][j])
> +				break;
> +		}
> +
> +		if (j == DATA_LANES_COUNT)
> +			break;
> +	}
> +
> +	switch (i) {
> +	case NORMAL_LANE_MAPPING:
> +		break;
> +	case INVERT_LANE_MAPPING:
> +		fsa->swap_sbu_lanes = true;
> +		dev_info(&fsa->client->dev, "using inverted data lanes mapping\n");
> +		break;
> +	default:
> +		dev_err(&fsa->client->dev, "invalid data lanes mapping\n");
> +		ret = -EINVAL;
> +		goto out_error;
> +	}
> +
> +out_done:
> +	ret = 0;
> +
> +out_error:
> +	of_node_put(ep);
> +
> +	return ret;
> +}

It's probbaly slighly over engineered for 2 lanes, and at some point
this could go into an helper somewhere because we will need it for all
SBU muxes and redrivers/retimers.

> +
>   static int fsa4480_probe(struct i2c_client *client)
>   {
>   	struct device *dev = &client->dev;
>   	struct typec_switch_desc sw_desc = { };
>   	struct typec_mux_desc mux_desc = { };
>   	struct fsa4480 *fsa;
> +	int ret;
>   
>   	fsa = devm_kzalloc(dev, sizeof(*fsa), GFP_KERNEL);
>   	if (!fsa)
> @@ -193,6 +270,10 @@ static int fsa4480_probe(struct i2c_client *client)
>   	fsa->client = client;
>   	mutex_init(&fsa->lock);
>   
> +	ret = fsa4480_parse_data_lanes_mapping(fsa);
> +	if (ret)
> +		return ret;
> +
>   	fsa->regmap = devm_regmap_init_i2c(client, &fsa4480_regmap_config);
>   	if (IS_ERR(fsa->regmap))
>   		return dev_err_probe(dev, PTR_ERR(fsa->regmap), "failed to initialize regmap\n");
> 

But since I did the same in nb7vpq904m, and the SBU can be inverted, LGTM

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>

Neil
