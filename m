Return-Path: <linux-kernel+bounces-974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36D3E8148C2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:12:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1487F1C2297B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A38A62D052;
	Fri, 15 Dec 2023 13:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KbScISHv"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A46208BD
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40c2308faedso7505425e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 05:12:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702645920; x=1703250720; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=elp6Thk4qtd/V/VmcwBF9x0WrXlslVQD7aBSrD8E/B4=;
        b=KbScISHvc+tse6Okt/As7nk3zVqjFSolWCv3574MD9hkN9Yc44JxD17WZEdGJ2+HjM
         0lrCGNQs/HDKJt9hDhpkkptNXYjxxtcKhbwPkKwn96Tpxefq1r4uixtVD3SfHCM/2GSl
         i8MsquDdCUZbWtEz3LbCMlbVNUMLxi1FqaIPyZARXQzSolVvQ3uQYQFbeWjYap7agJjn
         F9vjfMLVTWoerkOLB44nOJQlaoa+5i9rtuaEH5LaUF/nhMeopjy3yMJ2YkVKk2kJUibF
         wmlQGDj8VpKTu1tiOJdtXEJ2i0NxJ7tV4y5y8a8/7MiSnWfm03JprlPyOvkJacjd6Mko
         uC/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702645920; x=1703250720;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=elp6Thk4qtd/V/VmcwBF9x0WrXlslVQD7aBSrD8E/B4=;
        b=Rk+rrDtYxwwIenn9YmHQr4n8ylcbJBYN3ataeIAS+4Mueb40dxjeZ2ZWq2OL047r77
         BDErfZ4kfGo3Ih7BcenS0kYlTQKAza4tr9L4VZh+aA4OjmtBXQ7Eib0w1wPoSJwokJxk
         +9PcIwtPP2S+JDwq2ZixBAfZZ+tyaSqPG7eZlNBGGhP+vnrCiQmmhhCcqqgbn/pVI2lP
         XXnL9lfUQnk95nlKm34kli2QJNTZqQaWxX99K+rjm/aNnx1w9wXpFkFbC+sfHM/EDQ+V
         orOecf0zDhzowhJ9oe06s83XLZs9yCTxusfE/X4ufbjknMWKmJxdoVD6YvVfjwHAVk7d
         VUpQ==
X-Gm-Message-State: AOJu0YwBdDHfS/Gf685Yk983k8sF/f8GeipnCrU+YqIRL82E56AMcvh2
	UPSHvSfS8iSbxhxmZ0HlulvQCQ==
X-Google-Smtp-Source: AGHT+IGMLOefGAWydo1H4s1lMv7uUuyJss4sJUB5Q94jIew2eAFblDKp0NXWewGQfoB3FGjV3sHXtA==
X-Received: by 2002:a05:600c:164a:b0:40b:5e59:c566 with SMTP id o10-20020a05600c164a00b0040b5e59c566mr6001053wmn.144.1702645919664;
        Fri, 15 Dec 2023 05:11:59 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:bfe9:1376:5584:1682? ([2a01:e0a:982:cbb0:bfe9:1376:5584:1682])
        by smtp.gmail.com with ESMTPSA id be9-20020a05600c1e8900b0040596352951sm31552567wmb.5.2023.12.15.05.11.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 05:11:59 -0800 (PST)
Message-ID: <eb805e37-20a5-4462-8285-8942f8bfc74c@linaro.org>
Date: Fri, 15 Dec 2023 14:11:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 5/5] ASoC: codecs: Add WCD939x Codec driver
Content-Language: en-US, fr
To: Mark Brown <broonie@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231207-topic-sm8650-upstream-wcd939x-codec-v3-0-6df9585ec7c8@linaro.org>
 <20231207-topic-sm8650-upstream-wcd939x-codec-v3-5-6df9585ec7c8@linaro.org>
 <4dae5296-9984-4c3b-803a-f6024edd0dd9@sirena.org.uk>
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
In-Reply-To: <4dae5296-9984-4c3b-803a-f6024edd0dd9@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/12/2023 20:20, Mark Brown wrote:
> On Thu, Dec 07, 2023 at 11:28:08AM +0100, Neil Armstrong wrote:
> 
>> +static int wcd939x_rx_hph_mode_put(struct snd_kcontrol *kcontrol,
>> +				   struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
>> +	struct wcd939x_priv *wcd939x = snd_soc_component_get_drvdata(component);
>> +	u32 mode_val;
>> +
>> +	mode_val = ucontrol->value.enumerated.item[0];
>> +
>> +	if (wcd939x->variant == WCD9390) {
>> +		if (mode_val == CLS_H_HIFI || mode_val == CLS_AB_HIFI) {
>> +			dev_dbg(component->dev, "%s: Invalid HPH Mode\n", __func__);
>> +			return -EINVAL;
>> +		}
>> +	}
>> +	if (mode_val == CLS_H_NORMAL) {
>> +		dev_dbg(component->dev, "%s: Unsupported HPH Mode\n", __func__);
>> +		return -EINVAL;
>> +	}
>> +
>> +	wcd939x->hph_mode = mode_val;
> 
> This seems strange - the code will accept any value other than a small
> number of specifically enumerated ones?  I would have expected us to
> check a defined list of modes and reject anything that isn't in that
> list.  This also means that the get() function can return out of bounds
> values which is buggy.  Please use the mixer-test selftest on a card
> with this driver running, it should identify at least that issue.
> 
>> +
>> +	return 1;
>> +}
> 
> This will also unconditionally report that the value of the mux changed,
> the function should return 0 if the value written is the control value
> hasn't changed.

Ack, I'll fix this, I wasn't happy anyway with the design

Neil

