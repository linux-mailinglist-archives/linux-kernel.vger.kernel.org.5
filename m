Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AFAF7DF02B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 11:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347030AbjKBKcc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 06:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346735AbjKBKc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 06:32:26 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66BC138
        for <linux-kernel@vger.kernel.org>; Thu,  2 Nov 2023 03:32:18 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-32f7c80ab33so446803f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Nov 2023 03:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698921137; x=1699525937; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hL5GAkNYX5lf5Xnnqavo6wfZxNcky+vNwT6ydKIiCK0=;
        b=WEzbl58iLKcndODZjAdZophctyQu2r9oOt3DuwJGGxJUQCltuFXJ0iYytUTcgpfFte
         xYQy7bgKHO+eGYTa+tp7+LKQ+8fgug9kN/ploet0ZFkefynsVWVsPw2+tJcttGOyhXwj
         bhA0Rm99IJ/+4NzLDmd6b3gFSsff/ugQM5Ec8Ty8Lfi3Am74CLBXhj7MGcmJ+8f0eRKw
         xAx8qEyhmW5D6Hbnqj3FIJyFLJkt5666RLfYzRR302aOC2Lx2zsDKtse70iA+QFmMjWD
         rinDi9eXvXooe5wqfwg+yJc2ZaGLuMJhgEzICbToy4OdaArFFV5cVZXdgvgjQ0NWx3Hb
         oLHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698921137; x=1699525937;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hL5GAkNYX5lf5Xnnqavo6wfZxNcky+vNwT6ydKIiCK0=;
        b=EywB/SNB2q56xzHc+gNusZQRrtaQBzw98e/1CgOxJZqILK+tEcTtVG2DPmxh9BaEZS
         EU6AWWdlaXM0THXudg0QKpK36LDg7saTwkrYJapiaMia7ME9SaD3ISbl/4lEyUYU4Pob
         jdx3eBJEsPLylzxufeChk/YDU8F9200+YYrfriLHoYcwg/+Up4X1xHjMTcvZKzZpngH3
         sZuyK0yexYUyA7CB3kphr4O3bVqxJXzHfE+nHSHrpE6N5Exkxx3bvxL9PeCrkRX4WsO2
         uugpQzewwETJNTlmVodFnRa8Iq3SpbfxQrq07eKQ2hE9buBqCcraUjYbprbLnlWgU65w
         0JfQ==
X-Gm-Message-State: AOJu0Ywo0WOH9CsPvXLXMjL3JAX5Hhx8wHoDL85RdM7vj9G899le6wRA
        XUMpQOHQ9jx6B7CPKiOj19QC7A==
X-Google-Smtp-Source: AGHT+IFPxwdfmh35qsrDuZo1uOZ2JxX6Pr4ET8SmzWDoqC5BsYtR7YOjn4l0q9vCDunbUwW0/3h7uw==
X-Received: by 2002:a5d:46c7:0:b0:32f:b1f2:1f99 with SMTP id g7-20020a5d46c7000000b0032fb1f21f99mr18289wrs.9.1698921135424;
        Thu, 02 Nov 2023 03:32:15 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:4ac1:f109:811c:51be? ([2a01:e0a:982:cbb0:4ac1:f109:811c:51be])
        by smtp.gmail.com with ESMTPSA id bk28-20020a0560001d9c00b0032dab20e773sm2081738wrb.69.2023.11.02.03.32.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Nov 2023 03:32:14 -0700 (PDT)
Message-ID: <0126493b-6735-42a6-b346-dfabdf23bcaf@linaro.org>
Date:   Thu, 2 Nov 2023 11:32:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v10 2/4] Input: add core support for Goodix Berlin
 Touchscreen IC
Content-Language: en-US, fr
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bastien Nocera <hadess@hadess.net>,
        Hans de Goede <hdegoede@redhat.com>,
        Henrik Rydberg <rydberg@bitmath.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231023-topic-goodix-berlin-upstream-initial-v10-0-88eec2e51c0b@linaro.org>
 <20231023-topic-goodix-berlin-upstream-initial-v10-2-88eec2e51c0b@linaro.org>
 <ZTnzorJ4h1zva1AZ@nixie71>
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
In-Reply-To: <ZTnzorJ4h1zva1AZ@nixie71>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

On 26/10/2023 07:05, Jeff LaBundy wrote:
> Hi Neil,
> 
> On Mon, Oct 23, 2023 at 05:03:46PM +0200, Neil Armstrong wrote:
> 
> [...]
> 
>> +static int goodix_berlin_get_ic_info(struct goodix_berlin_core *cd)
>> +{
>> +	__le16 length_raw;
>> +	u8 *afe_data;
>> +	u16 length;
>> +	int error;
>> +
>> +	afe_data = kzalloc(GOODIX_BERLIN_IC_INFO_MAX_LEN, GFP_KERNEL);
>> +	if (!afe_data)
>> +		return -ENOMEM;
>> +
>> +	error = regmap_raw_read(cd->regmap, GOODIX_BERLIN_IC_INFO_ADDR,
>> +				&length_raw, sizeof(length_raw));
>> +	if (error) {
>> +		dev_info(cd->dev, "failed get ic info length, %d\n", error);
> 
> This should be dev_err().

Ack

> 
>> +		goto free_afe_data;
>> +	}
>> +
>> +	length = le16_to_cpu(length_raw);
>> +	if (length >= GOODIX_BERLIN_IC_INFO_MAX_LEN) {
>> +		dev_info(cd->dev, "invalid ic info length %d\n", length);
> 
> And here.

Ack

> 
>> +		error = -EINVAL;
>> +		goto free_afe_data;
>> +	}
>> +
>> +	error = regmap_raw_read(cd->regmap, GOODIX_BERLIN_IC_INFO_ADDR,
>> +				afe_data, length);
>> +	if (error) {
>> +		dev_info(cd->dev, "failed get ic info data, %d\n", error);
>> +		return error;
>> +		goto free_afe_data;
>> +	}
> 
> This return statement is left over from v9; the print should also be dev_err().

Ack

> 
>> +
>> +	/* check whether the data is valid (ex. bus default values) */
>> +	if (goodix_berlin_is_dummy_data(cd, afe_data, length)) {
>> +		dev_err(cd->dev, "fw info data invalid\n");
>> +		error = -EINVAL;
>> +		goto free_afe_data;
>> +	}
>> +
>> +	if (!goodix_berlin_checksum_valid(afe_data, length)) {
>> +		dev_info(cd->dev, "fw info checksum error\n");
> 
> And here.

Ack

> 
>> +		error = -EINVAL;
>> +		goto free_afe_data;
>> +	}
>> +
>> +	error = goodix_berlin_convert_ic_info(cd, afe_data, length);
>> +	if (error)
>> +		goto free_afe_data;
>> +
>> +	/* check some key info */
>> +	if (!cd->touch_data_addr) {
>> +		dev_err(cd->dev, "touch_data_addr is null\n");
>> +		error = -EINVAL;
>> +		goto free_afe_data;
>> +	}
>> +
>> +	return 0;
>> +
>> +free_afe_data:
>> +	kfree(afe_data);
>> +
>> +	return error;
>> +}
> 
> [...]
> 
>> +static int goodix_berlin_request_handle_reset(struct goodix_berlin_core *cd)
>> +{
>> +	gpiod_set_value(cd->reset_gpio, 1);
>> +	usleep_range(2000, 2100);
>> +	gpiod_set_value(cd->reset_gpio, 0);
> 
> I see that now, this function is only called if the reset GPIO is defined,
> but there used to be another msleep() here that has since been dropped. Is
> that intentional?

Indeed, it was dropped, I'll add it back thx for noticing !

> 
>> +
>> +	return 0;
>> +}
> 
> Kind regards,
> Jeff LaBundy

Thanks,
Neil

