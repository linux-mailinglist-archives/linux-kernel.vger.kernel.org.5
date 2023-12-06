Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035318069FC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377082AbjLFIKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:10:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbjLFIKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:10:38 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B94E8D73
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 00:10:33 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40bda47c489so48060905e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 00:10:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701850232; x=1702455032; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=F+gV9P+LLtbcV288f8bcnkug+5SdmrVHFSfaWr3WP8M=;
        b=zkJLkAI5tJzixB+SER/ohWSLc9yn+D0STy4lXbPvfX3eBwf2gNvw9PqtBHuZuMID/t
         ykwv0S165SjuocrOIs6c6KW94zONSsBZbehCa8tCNSt5TZ5cb+bEj5H/zzocqi1y6p6b
         EMM+/ZFgBLFLpBG8hPXkqHASbr2IwGfijXp9PUJllzvS6hBioroLWRoXEQIkIFJmdZaT
         OtAwu/rB6zqlxGg45h7t10rkuxagYZ3XLIaSQ0AeKJ0QtCUlb7JlFFFCzHZwdcqQX0d4
         WBGmGP3RT+ksS+Mv4UbwKCZuM1J6UtCHkOLcoxlee9ZkG/mIzmtNfB2kMBIoSgAqrVRO
         5WDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701850232; x=1702455032;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=F+gV9P+LLtbcV288f8bcnkug+5SdmrVHFSfaWr3WP8M=;
        b=DaNrkiF2aoIwiGunTB0gQXTagzeLdROMlbztYNomV3dW+dUW5LRvDOA25ooe4q2VKW
         Yx2GUNZb3L1KWfgw/m24SfbpZgfc48SLC7fSwe0u17P3aN2fhFjGNFBjhx3ljLhnUzew
         na9WNQLTzKiin1M0j2x2HkoVCeKNNTh73xQqu3N+UIqUkz3z9P3vVq2TepC08EIjLAU5
         iRwCTx7CBcStEXSQj7SPUPLukreENB4G3w4qNVSzOkch5EY0n4su+CpnEfiQ8PuHhPiJ
         7IIe93FjfXFL36sAx77jabcfUVrq2lXQBZy4+TZgi6afS+f9rNDH9tzui81uqoMKm1BX
         cTCA==
X-Gm-Message-State: AOJu0YxgEupuRPwDjxQ0uwLxI4xxNNwc5oxzTpYmqbZCh4z3yuS8QxWt
        nUu/6EsdfzKP8hGXOY8YE8tjgw==
X-Google-Smtp-Source: AGHT+IF3+jzIgYagYuozgaSQvR5QgLTRcig4lGIsn6hG2LwuH0IBqpbb5tT5ziahhcs3FJWNjZfgbA==
X-Received: by 2002:a7b:cb91:0:b0:40b:5e59:c591 with SMTP id m17-20020a7bcb91000000b0040b5e59c591mr305772wmi.187.1701850231928;
        Wed, 06 Dec 2023 00:10:31 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:f855:6075:9365:8b70? ([2a01:e0a:982:cbb0:f855:6075:9365:8b70])
        by smtp.gmail.com with ESMTPSA id v21-20020a05600c471500b0040836519dd9sm21114204wmo.25.2023.12.06.00.10.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 00:10:31 -0800 (PST)
Message-ID: <99ec05e1-8bcd-48a5-84b6-760ac7c93317@linaro.org>
Date:   Wed, 6 Dec 2023 09:10:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 5/5] ASoC: codecs: Add WCD939x Codec driver
Content-Language: en-US, fr
To:     Dan Carpenter <dan.carpenter@linaro.org>,
        oe-kbuild@lists.linux.dev,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     lkp@intel.com, oe-kbuild-all@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1a09512c-aaff-4fb6-914e-db755ce6e667@suswa.mountain>
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
In-Reply-To: <1a09512c-aaff-4fb6-914e-db755ce6e667@suswa.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 06/12/2023 06:39, Dan Carpenter wrote:
> Hi Neil,
> 
> kernel test robot noticed the following build warnings:

Thanks for the report, I'll fix all this
Neil

> 
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Neil-Armstrong/ASoC-dt-bindings-document-WCD939x-Audio-Codec/20231202-000916
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> patch link:    https://lore.kernel.org/r/20231201-topic-sm8650-upstream-wcd939x-codec-v2-5-94ed814b25aa%40linaro.org
> patch subject: [PATCH v2 5/5] ASoC: codecs: Add WCD939x Codec driver
> config: powerpc64-randconfig-r081-20231204 (https://download.01.org/0day-ci/archive/20231206/202312060127.FLhplIP3-lkp@intel.com/config)
> compiler: powerpc64-linux-gcc (GCC) 13.2.0
> reproduce: (https://download.01.org/0day-ci/archive/20231206/202312060127.FLhplIP3-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes: https://lore.kernel.org/r/202312060127.FLhplIP3-lkp@intel.com/
> 
> New smatch warnings:
> sound/soc/codecs/wcd939x.c:3168 wcd939x_typec_mux_set() error: 'wcd939x' dereferencing possible ERR_PTR()
> sound/soc/codecs/wcd939x.c:3221 wcd939x_swap_gnd_mic() warn: signedness bug returning '(-22)'
> 
> Old smatch warnings:
> sound/soc/codecs/wcd939x.c:3170 wcd939x_typec_mux_set() error: 'wcd939x' dereferencing possible ERR_PTR()
> sound/soc/codecs/wcd939x.c:3173 wcd939x_typec_mux_set() error: 'wcd939x' dereferencing possible ERR_PTR()
> sound/soc/codecs/wcd939x.c:3174 wcd939x_typec_mux_set() error: 'wcd939x' dereferencing possible ERR_PTR()
> sound/soc/codecs/wcd939x.c:3176 wcd939x_typec_mux_set() error: 'wcd939x' dereferencing possible ERR_PTR()
> sound/soc/codecs/wcd939x.c:3177 wcd939x_typec_mux_set() error: 'wcd939x' dereferencing possible ERR_PTR()
> sound/soc/codecs/wcd939x.c:3179 wcd939x_typec_mux_set() error: 'wcd939x' dereferencing possible ERR_PTR()
> 
> vim +/wcd939x +3168 sound/soc/codecs/wcd939x.c
> 
> 6c302e2f95b1d1 Neil Armstrong 2023-12-01  3164  static int wcd939x_typec_mux_set(struct typec_mux_dev *mux,
> 6c302e2f95b1d1 Neil Armstrong 2023-12-01  3165  				 struct typec_mux_state *state)
> 6c302e2f95b1d1 Neil Armstrong 2023-12-01  3166  {
> 6c302e2f95b1d1 Neil Armstrong 2023-12-01  3167  	struct wcd939x_priv *wcd939x = typec_mux_get_drvdata(mux);
> 6c302e2f95b1d1 Neil Armstrong 2023-12-01 @3168  	unsigned int previous_mode = wcd939x->typec_mode;
> 
> The Kconfig should probably depend on CONFIG_TYPEC to avoid a crash here.
> 
> 6c302e2f95b1d1 Neil Armstrong 2023-12-01  3169
> 6c302e2f95b1d1 Neil Armstrong 2023-12-01  3170  	if (!wcd939x->wcd_mbhc)
> 6c302e2f95b1d1 Neil Armstrong 2023-12-01  3171  		return -EINVAL;
> 6c302e2f95b1d1 Neil Armstrong 2023-12-01  3172
> 6c302e2f95b1d1 Neil Armstrong 2023-12-01  3173  	if (wcd939x->typec_mode != state->mode) {
> 6c302e2f95b1d1 Neil Armstrong 2023-12-01  3174  		wcd939x->typec_mode = state->mode;
> 6c302e2f95b1d1 Neil Armstrong 2023-12-01  3175
> 6c302e2f95b1d1 Neil Armstrong 2023-12-01  3176  		if (wcd939x->typec_mode == TYPEC_MODE_AUDIO)
> 6c302e2f95b1d1 Neil Armstrong 2023-12-01  3177  			return wcd_mbhc_typec_report_plug(wcd939x->wcd_mbhc);
> 6c302e2f95b1d1 Neil Armstrong 2023-12-01  3178  		else if (previous_mode == TYPEC_MODE_AUDIO)
> 6c302e2f95b1d1 Neil Armstrong 2023-12-01  3179  			return wcd_mbhc_typec_report_unplug(wcd939x->wcd_mbhc);
> 6c302e2f95b1d1 Neil Armstrong 2023-12-01  3180  	}
> 6c302e2f95b1d1 Neil Armstrong 2023-12-01  3181
> 6c302e2f95b1d1 Neil Armstrong 2023-12-01  3182  	return 0;
> 6c302e2f95b1d1 Neil Armstrong 2023-12-01  3183  }
> 
> [ snip ]
> 
> 6c302e2f95b1d1 Neil Armstrong 2023-12-01  3216  static bool wcd939x_swap_gnd_mic(struct snd_soc_component *component, bool active)
> 6c302e2f95b1d1 Neil Armstrong 2023-12-01  3217  {
> 6c302e2f95b1d1 Neil Armstrong 2023-12-01  3218  	struct wcd939x_priv *wcd939x = snd_soc_component_get_drvdata(component);
> 6c302e2f95b1d1 Neil Armstrong 2023-12-01  3219
> 6c302e2f95b1d1 Neil Armstrong 2023-12-01  3220  	if (!wcd939x->typec_analog_mux || !wcd939x->typec_switch)
> 6c302e2f95b1d1 Neil Armstrong 2023-12-01 @3221  		return -EINVAL;
> 
> This is type bool.  return false?
> 
> 6c302e2f95b1d1 Neil Armstrong 2023-12-01  3222
> 6c302e2f95b1d1 Neil Armstrong 2023-12-01  3223  	/* Report inversion via Type Switch of USBSS */
> 6c302e2f95b1d1 Neil Armstrong 2023-12-01  3224  	return typec_switch_set(wcd939x->typec_switch,
> 6c302e2f95b1d1 Neil Armstrong 2023-12-01  3225  				wcd939x->typec_orientation == TYPEC_ORIENTATION_REVERSE ?
> 6c302e2f95b1d1 Neil Armstrong 2023-12-01  3226  					TYPEC_ORIENTATION_NORMAL : TYPEC_ORIENTATION_REVERSE);
> 6c302e2f95b1d1 Neil Armstrong 2023-12-01  3227  }
> 

