Return-Path: <linux-kernel+bounces-993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 322868148F0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 14:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 56D981C23B87
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBCA2DB67;
	Fri, 15 Dec 2023 13:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zwzWNCVa"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329112DB6B
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33642ab735dso488685f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 05:19:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702646391; x=1703251191; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dwNp0sgW48z+F5oUMsIxJsVhA8NF2XoB7VYgvdpehl4=;
        b=zwzWNCVavhyRxdlVEWCEREcpgDXCZ4uiTSJgYtrR15rkNHq3nLiKzM3DmTwUE1AHGQ
         UJZSR4gy+5HC5QuRqS95DmsgRfAeTPrgH+UdZadnG8lvpDG75jtMRDsXM/f7+o8vcsDv
         eJsMz1c+g/Tv2LhyIFeyrfaHg2XgyO/rLuwu/g0vsZhDroE4+6svAa6DzJirGWgzJ1lK
         bVf/dKDWupBBKzV4ipzIclYjjdiKevx1i4oojJfdTLs1XgMPBo3wyYAFPEqMhp/hmr6H
         16llaT1Zpdq4aJez3hsfcDTaos1prziikGLH+6nUriY4bFXHc1UXkA3NMY+D1Vud8oVa
         EVGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702646391; x=1703251191;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dwNp0sgW48z+F5oUMsIxJsVhA8NF2XoB7VYgvdpehl4=;
        b=rRg87KnWTnHaIuW+WsUEYO+QhKzEddvICzGC4ROwtAIjGK3GogBzLIPQjNmnIugp9o
         YTZC+th/jTFZSyblEyzMJxG4hNpvm5A8HQyk9Eg5fhtOlSqdrgWx5lzB6FharqznjwXH
         KMV0aV4OPVb2iNSFohgk5iJYPZhocV3S4WZ8hcMnaz0y/df4r5w1tbKHAoaz8R77IDjW
         YnvbYg01HX4RciTX15MRcWMOpUp4fPB7oMimVLZWpptOxL/xgD5r/e8pFZvd+sVESW81
         kGQ3diZkKkQbGSVCzlMdmMsnXXdCsd66du4Xu8F6pPWOijW6f3C1kZCPe0VxdGKZN9nB
         UvzQ==
X-Gm-Message-State: AOJu0YzFDpFD2HgfQrGTvQOKWxeclL5deQFcOKm7DzECBkuG/RWpZbgm
	fVDCJCXd2pWcpI3QiUoamqvhbazoBKkTTpkokHaW1qut
X-Google-Smtp-Source: AGHT+IEDD6bxhoN6uIYdEQ2w4hHbUIflkHy6qPGABXfxSyBAawfdYuz9kwdPIXVJPxY5ZT4EWLZU9g==
X-Received: by 2002:adf:e4c9:0:b0:336:42ce:f83e with SMTP id v9-20020adfe4c9000000b0033642cef83emr968835wrm.59.1702646391432;
        Fri, 15 Dec 2023 05:19:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:bfe9:1376:5584:1682? ([2a01:e0a:982:cbb0:bfe9:1376:5584:1682])
        by smtp.gmail.com with ESMTPSA id j8-20020adfb308000000b003365964ba85sm430767wrd.28.2023.12.15.05.19.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Dec 2023 05:19:50 -0800 (PST)
Message-ID: <d41d4cc3-81eb-431c-b158-673b7ef92727@linaro.org>
Date: Fri, 15 Dec 2023 14:19:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 4/5] ASoC: codecs: Add WCD939x Soundwire devices driver
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
 <20231207-topic-sm8650-upstream-wcd939x-codec-v3-4-6df9585ec7c8@linaro.org>
 <e8b5099c-ceb2-4605-94bc-efd09ad55cb7@sirena.org.uk>
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
In-Reply-To: <e8b5099c-ceb2-4605-94bc-efd09ad55cb7@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/12/2023 19:31, Mark Brown wrote:
> On Thu, Dec 07, 2023 at 11:28:07AM +0100, Neil Armstrong wrote:
>> Add Soundwire Slave driver for the WCD9390/WCD9395 Audio Codec.
>>
>> The WCD9390/WCD9395 Soundwire devices will be used by the
>> main WCD9390/WCD9395 Audio Codec driver to access registers
>> and configure Soundwire RX and TX ports.
> 
>> +static const struct reg_default wcd939x_defaults[] = {
> 
>> +	{ WCD939X_DIGITAL_MODE_STATUS_0, 0x00 },
>> +	{ WCD939X_DIGITAL_MODE_STATUS_1, 0x00 },
> 
> There's a bunch of registers like this which look like they should be
> volatile and are actually volatile which makes supplying defaults rather
> strange - in general volatile registers shouldn't have defaults.

Indeed I'll clean those up

> 
>> +	{ WCD939X_DIGITAL_EFUSE_REG_0, 0x00 },
>> +	{ WCD939X_DIGITAL_EFUSE_REG_1, 0xff },
>> +	{ WCD939X_DIGITAL_EFUSE_REG_2, 0xff },
> 
> With the fuse registers even though I'd expect them to be cachable the
> whole point is usually that these are programmable per device and
> therefore I'd not expect defaults, I'd expect them to be cached on first
> use.

Ack

> 
>> +static bool wcd939x_readonly_register(struct device *dev, unsigned int reg)
>> +{
> 
>> +	case WCD939X_DIGITAL_CHIP_ID0:
>> +	case WCD939X_DIGITAL_CHIP_ID1:
>> +	case WCD939X_DIGITAL_CHIP_ID2:
>> +	case WCD939X_DIGITAL_CHIP_ID3:
> 
>> +	case WCD939X_DIGITAL_EFUSE_REG_0:
>> +	case WCD939X_DIGITAL_EFUSE_REG_1:
>> +	case WCD939X_DIGITAL_EFUSE_REG_2:
> 
>> +	/* Consider all readonly registers as volatile */
>> +	.volatile_reg = wcd939x_readonly_register,
> 
> There's a bunch of the readonly registers that I'd expect to be cachable
> at runtime - I *hope* the chip ID doesn't change at runtime!  OTOH it
> likely doesn't matter so perhaps it's fine but the comment could use
> some improvement.


I'll improve this

> 
>> +static int wcd939x_sdw_component_bind(struct device *dev, struct device *master,
>> +				      void *data)
>> +{
>> +	/* Bind is required by component framework */
>> +	return 0;
>> +}
>> +
>> +static void wcd939x_sdw_component_unbind(struct device *dev,
>> +					 struct device *master, void *data)
>> +{
>> +	/* Unbind is required by component framework */
>> +}
>> +
>> +static const struct component_ops wcd939x_sdw_component_ops = {
>> +	.bind = wcd939x_sdw_component_bind,
>> +	.unbind = wcd939x_sdw_component_unbind,
>> +};
> 
> So what exactly is the component framework *doing* here then?  It really
> would be better to get this fixed in the component framework if this is
> a sensible usage.

So the component framework is here to synchronize probes of the main codec
and soundwire devices, because the main codec needs the soundwire devices
to access registers.
I assume this design was chosen to limit probe defer infinite loops waiting
for the soundwire devices to probe

I'll propose a change on the component framework, without any insurance it
would be accepted.

> 
>> +static int __maybe_unused wcd939x_sdw_runtime_resume(struct device *dev)
>> +{
>> +	struct wcd939x_sdw_priv *wcd = dev_get_drvdata(dev);
>> +
>> +	if (wcd->regmap) {
>> +		regcache_cache_only(wcd->regmap, false);
>> +		regcache_sync(wcd->regmap);
>> +	}
>> +
>> +	pm_runtime_mark_last_busy(dev);
> 
> The pm_runtime_mark_last_busy() in the resume function is a bit of a
> weird pattern - usually this is something that the user updates and more
> normally when releasing a runtime PM reference.

I took this from wcd938x_sd, I'll check the rationale of it in the resume function.

Thanks,
Neil

