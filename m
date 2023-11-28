Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2148C7FB568
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbjK1JQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:16:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231316AbjK1JQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:16:33 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FCA1A5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:16:38 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40b3e7f2fd9so24266165e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:16:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701162997; x=1701767797; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I1ixJzL+G4ExhL3zGwuOlyXJPv0jAqiyItVDxcyAzs0=;
        b=WLxcWSgxbzy92Jo/uqZjfBRL1qrpntlbZxN6dffnl6+jy2iplssGVN/wuAxL/iHMCK
         v/v9uPKfAZ1AK3iUklAcTX0wSCSPdauzY7suSCFnfVtrjLT7eiaXi7WiYJH1a2ZAEUEJ
         ng7GLb6E24Q+yKZrzOL6RlMglp1sqBtt5HIP1GQt0f4lxIekCfydUDc0gpmPu4Qxv4bo
         ms4iKp93+yKW40nY9xiV22IPsmrx66l242z894k3tuDfD34lYIh9k7RSwL1NwlU6How2
         sCrF+gkDktJOMj59bx88ESL/S/cN2mEvhaqcyYCrXPMbKUX/qq0tTZvgAFyW2L7HUJj2
         mQZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701162997; x=1701767797;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I1ixJzL+G4ExhL3zGwuOlyXJPv0jAqiyItVDxcyAzs0=;
        b=Pl4pqhQyOKybAr3tHQ1jqdEw/d4fipDvJqdr4v7Tf7lF7dpRMkiPQH5YkXg/xhsjBV
         2JrkGGbqR0FWywDDe0zsFx9xzfDvZKJVsn55B/mUK3MsxH6bLsarvNa2EsVYAkHZ5vpc
         D1OY+NWvBIcMDkt4CJfHzJdkUMUpOskmIIjDTikSlhfEb4VzxlXd24y+bgcdWj5nN2/Y
         zgnJbLVdGS+8KAHvjgNoEYYJs7MALlh8H5d+9J4FyB6jRjtq0A+xLot2xl1WFJnWzzZN
         wFJjA21MYGTwre3WqG4ZJNH0JVtJPazn8q+MhpF5yTx2Tf+5670C3qJ+ZmnqYhuLMOhj
         JyYQ==
X-Gm-Message-State: AOJu0YwensWcCPvJ0UeTh3CV7KFapSy0zE+yXLmIPgQ6f2M9U+H8cU6M
        SYzCndLApqVhHPpy7jwhAXI1lw==
X-Google-Smtp-Source: AGHT+IG6ukaNt2ZgVZQMXe58TmnXHGQqqHO07e+EHx+fN6PCfUc66ZTyBG1sDU5facr7QJDgD0fR8Q==
X-Received: by 2002:a05:600c:4fcc:b0:40b:338b:5f38 with SMTP id o12-20020a05600c4fcc00b0040b338b5f38mr10094963wmq.8.1701162996775;
        Tue, 28 Nov 2023 01:16:36 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:eada:f40e:7ab3:2afe? ([2a01:e0a:982:cbb0:eada:f40e:7ab3:2afe])
        by smtp.gmail.com with ESMTPSA id az21-20020a05600c601500b0040b47c53610sm5045039wmb.14.2023.11.28.01.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Nov 2023 01:16:36 -0800 (PST)
Message-ID: <095f6e9d-dbee-4cfe-91dc-5443608c386d@linaro.org>
Date:   Tue, 28 Nov 2023 10:16:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 4/5] ASoC: codecs: Add WCD939x Soundwire slave driver
Content-Language: en-US, fr
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231123-topic-sm8650-upstream-wcd939x-codec-v1-0-21d4ad9276de@linaro.org>
 <20231123-topic-sm8650-upstream-wcd939x-codec-v1-4-21d4ad9276de@linaro.org>
 <a7725504-89fd-4f62-b8d0-6ec863bd059a@linaro.org>
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
In-Reply-To: <a7725504-89fd-4f62-b8d0-6ec863bd059a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2023 12:55, Konrad Dybcio wrote:
> On 23.11.2023 15:49, Neil Armstrong wrote:
>> Add Soundwire Slave driver for the WCD9390/WCD9395 Audio Codec.
>>
>> The WCD9390/WCD9395 Soundwire Slaves will be used by the
>> main WCD9390/WCD9395 Audio Codec driver to access registers
>> and configure Soundwire RX and TX ports.
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
> [...]
> 
> 
>> +static struct wcd939x_sdw_ch_info wcd939x_sdw_tx_ch_info[] = {
>> +	WCD_SDW_CH(WCD939X_ADC1, WCD939X_ADC_1_4_PORT, BIT(0)),
>> +	WCD_SDW_CH(WCD939X_ADC2, WCD939X_ADC_1_4_PORT, BIT(1)),
>> +	WCD_SDW_CH(WCD939X_ADC3, WCD939X_ADC_1_4_PORT, BIT(2)),
>> +	WCD_SDW_CH(WCD939X_ADC4, WCD939X_ADC_1_4_PORT, BIT(3)),
>> +	// TOFIX support ADC3/4 & DMIC0/1 on port 2
> Well, fix it or drop it :D
> 
>> +	//WCD_SDW_CH(WCD939X_ADC3, WCD939X_ADC_DMIC_1_2_PORT, BIT(0)),
>> +	//WCD_SDW_CH(WCD939X_ADC4, WCD939X_ADC_DMIC_1_2_PORT, BIT(1)),
>> +	//WCD_SDW_CH(WCD939X_DMIC0, WCD939X_ADC_DMIC_1_2_PORT, BIT(2)),
>> +	//WCD_SDW_CH(WCD939X_DMIC1, WCD939X_ADC_DMIC_1_2_PORT, BIT(3)),
>> +	WCD_SDW_CH(WCD939X_DMIC0, WCD939X_DMIC_0_3_MBHC_PORT, BIT(0)),
>> +	WCD_SDW_CH(WCD939X_DMIC1, WCD939X_DMIC_0_3_MBHC_PORT, BIT(1)),
>> +	WCD_SDW_CH(WCD939X_MBHC, WCD939X_DMIC_0_3_MBHC_PORT, BIT(2)),
>> +	WCD_SDW_CH(WCD939X_DMIC2, WCD939X_DMIC_0_3_MBHC_PORT, BIT(2)),
>> +	WCD_SDW_CH(WCD939X_DMIC3, WCD939X_DMIC_0_3_MBHC_PORT, BIT(3)),
>> +	WCD_SDW_CH(WCD939X_DMIC4, WCD939X_DMIC_3_7_PORT, BIT(0)),
>> +	WCD_SDW_CH(WCD939X_DMIC5, WCD939X_DMIC_3_7_PORT, BIT(1)),
>> +	WCD_SDW_CH(WCD939X_DMIC6, WCD939X_DMIC_3_7_PORT, BIT(2)),
>> +	WCD_SDW_CH(WCD939X_DMIC7, WCD939X_DMIC_3_7_PORT, BIT(3)),
>> +};
> [...]
> 
>> +
>> +int wcd939x_swr_get_current_bank(struct sdw_slave *sdev)
>> +{
>> +	int bank;
>> +
>> +	bank = sdw_read(sdev, SDW_SCP_CTRL);
>> +
>> +	return ((bank & 0x40) ? 1 : 0);
> bool conversion?
> 
> Also, 0x40 == BIT(6), can you look up what it means and #define it?
Ack

> 
> [...]
> 
>> +
>> +static int wcd9390_bus_config(struct sdw_slave *slave,
>> +			      struct sdw_bus_params *params)
>> +{
>> +	sdw_write(slave, SWRS_SCP_HOST_CLK_DIV2_CTL_BANK(params->next_bank),
>> +		  0x01);
> similar, BIT(0)
Ack

> [...]
> 
>> +	{ WCD939X_EAR_STATUS_REG_2, 0x08 },
>> +	{ WCD939X_FLYBACK_NEW_CTRL_2, 0x00 }, //??
>> +	{ WCD939X_FLYBACK_NEW_CTRL_3, 0x00 }, //??
>> +	{ WCD939X_FLYBACK_NEW_CTRL_4, 0x44 }, //??
> drop //s

Ack

> [...]
> 
>> +static bool wcd939x_volatile_register(struct device *dev, unsigned int reg)
>> +{
>> +	if (reg <= WCD939X_BASE)
>> +		return false;
> Maybe move this check to readonly_register
>> +
>> +	if (wcd939x_readonly_register(dev, reg))
>> +		return true;
> and call readonly for .volatile_reg as well?
> [...]

Hmm, let me check

> 
>> +	/**
>> +	 * Port map index starts with 0, however the data port for this codec
>> +	 * are from index 1
>> +	 */
> This is not kerneldoc

Ack

> 
>> +	if (of_property_read_bool(dev->of_node, "qcom,tx-port-mapping")) {
>> +		wcd->is_tx = true;
>> +		ret = of_property_read_u32_array(dev->of_node,
>> +						 "qcom,tx-port-mapping",
>> +						 &pdev->m_port_map[1],
>> +						 WCD939X_MAX_TX_SWR_PORTS);
>> +	} else {
>> +		ret = of_property_read_u32_array(dev->of_node,
>> +						 "qcom,rx-port-mapping",
>> +						 &pdev->m_port_map[1],
>> +						 WCD939X_MAX_RX_SWR_PORTS);
>> +	}
> This is used in wcd9380 and will be used in wcd9370 when that happens some
> day, maybe it'd be worth to commonize it as qcom_{rx/tx}_portmap_get?
> [...]

OK but where ?

> 
>> +static const struct sdw_device_id wcd9390_slave_id[] = {
>> +	SDW_SLAVE_ENTRY(0x0217, 0x10e, 0),
> 0x10e - WCD9380 or 9385 slave? an inline comment at the end of the line
> would be cool!

Ack

> 
> Konrad

