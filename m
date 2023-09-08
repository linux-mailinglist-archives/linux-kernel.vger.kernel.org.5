Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6BC798705
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 14:30:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237217AbjIHMal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 08:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbjIHMak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 08:30:40 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14211BEE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 05:30:36 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31427ddd3fbso1821621f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 05:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694176235; x=1694781035; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PM2w2IzcLgzoOPeUzfKRLbjxESAa2w9XyRzVdDC8nNA=;
        b=DPMdLKwOxJ4W+SGlkdJIWEfaxIKK2Esw9VqiW/faIlehU4HC1R4q7+OWHaMqBvbSE8
         1jBeZoZ4f5EEMum7u8/q5xEPTAE/a7W9v0utaOZHyVIh4bfW063VNandEEMXAMdEo3Ll
         ch4akW3IWwpMCJnL79z4kFtTg6pf3OQCuMTniYuBlVhVcDam8VvICueaMYHwm2Sd0Rx4
         ATjx7va19AvUiMCB4ynRw5RQ2G0dGoyYH+DCQwDDN4hksUOZuRtJ5TSYcSthApqgCQru
         ZVuDDkY9LWaPDiVddJTaWs3YbAZUbvHx6fTiNB8gNNriaApHxhPnIZaTXn7nWzXSv6Rt
         BZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694176235; x=1694781035;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PM2w2IzcLgzoOPeUzfKRLbjxESAa2w9XyRzVdDC8nNA=;
        b=uWHMXV+KVA9S3UHdlUELfSviFjFwqmI+/gh+5RfweUOoPhcWZ6inda5Yd3iF627PyH
         Aa1or9MHFpgg6pQGDvbs0SxbXn03epddqUHTksib4oLxA7lWiDgI5VrWr559/V6N0Q30
         NhCseGuhB2Awo2AjZw7WckpebKF7BiuSp7zyGeNaG78n3CeJS6jwnT6W3bXTDYtLNTuz
         Valkqf1TAVnfP2zM08jBNNCaR93EcKY0lvGgfgHJsBu7lG9TVNLXBTFQqmhy5qHBxuOr
         imxUVkTr+3IkY4DPHkFM8t9vdzsdgxDa3eBBWSSS4rpNvOitJGStRDdzZ0BlnkglH7Xg
         90pg==
X-Gm-Message-State: AOJu0YzSyWRiXv/tRYJTKSgSJbfyR2YMHeaXZb5toi9ZXGoywwInpMCH
        QznYzZsZucqyCgaGtBXj+amoCA==
X-Google-Smtp-Source: AGHT+IGfiprw2HlOSI7C7qrMQSp2u5C9t9PCNm2p6AHs9JBK00uKP0Ve+a8f9jOa1yEkdzsQTDLAIQ==
X-Received: by 2002:adf:f8d2:0:b0:31c:81ef:f90a with SMTP id f18-20020adff8d2000000b0031c81eff90amr1715968wrq.47.1694176235144;
        Fri, 08 Sep 2023 05:30:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5f1a:ed04:d131:cda4? ([2a01:e0a:982:cbb0:5f1a:ed04:d131:cda4])
        by smtp.gmail.com with ESMTPSA id z7-20020adfe547000000b0031c71693449sm2031144wrm.1.2023.09.08.05.30.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 05:30:34 -0700 (PDT)
Message-ID: <00436bd2-5f3c-4fd6-9db8-799c541c6a33@linaro.org>
Date:   Fri, 8 Sep 2023 14:30:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 0/3] arm64: dts: amlogic: add more basic audio support
Content-Language: en-US, fr
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230815092751.1791195-1-christianshewitt@gmail.com>
 <1jh6p0vdyj.fsf@starbuckisacylon.baylibre.com>
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
In-Reply-To: <1jh6p0vdyj.fsf@starbuckisacylon.baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15/08/2023 11:37, Jerome Brunet wrote:
> 
> On Tue 15 Aug 2023 at 09:27, Christian Hewitt <christianshewitt@gmail.com> wrote:
> 
>> This mini-series adds basic audio support to the P200/P201 (GXBB) and U200 (G12A)
>> reference boards. Few people likely have the original reference boards which have
>> extra audio capabilities, but the device-trees are widely [ab]used by users with
>> Android set-top boxes whose hardware is copy/pasted from the reference designs to
>> get working installs. Adding basic audio support does no harm to the real boards
>> and helps the secondary cause.
> 
> Still, this is something you have not tested on the u200 reference
> design. I believe this was already discussed in the past.
> 
> The u200 is far more complex when it comes to audio and certainly would
> not work on this no-name android device. These device are heavily
> "inspired" by the reference, but trimmed down in many aspect including
> audio capabilities - NOT copied.

I understand you point, but those changes only adds "internal" audio & basic spdif
capabilities so it won't affect the on-board audio electronics in any way.

> 
> People abusing the u200 or p200 DT does make the patchset valid

This is a reality, but still I think this patchset is valid and I'll
pick those since they are used for years out-of-tree and probably works
very fine in the reference design boards.

Neil

> 
>>
>> Christian Hewitt (3):
>>    arm64: dts: meson: add audio playback to p200
>>    arm64: dts: meson: add audio playback to p201
>>    arm64: dts: meson: add audio playback to u200
>>
>>   .../boot/dts/amlogic/meson-g12a-u200.dts      | 129 ++++++++++++++++++
>>   .../boot/dts/amlogic/meson-gxbb-p200.dts      |  60 ++++++++
>>   .../boot/dts/amlogic/meson-gxbb-p201.dts      |  39 ++++++
>>   3 files changed, 228 insertions(+)
> 

