Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DF67F2B69
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 12:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjKULFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 06:05:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjKULE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 06:04:58 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C89A2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 03:04:53 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40b2b3da41eso2321935e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 03:04:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700564692; x=1701169492; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kIK/f1U9gj42KtTbzVAHFRC1UQ6zgDgmA86Cyhg1HRw=;
        b=kQlDTd/Z1AJlM/l+B45q6ErNGd/rYZQOTQ5dOlGkkZugjP8cBLgiaJrqB4q57eU2KC
         SJOGj0HmVdbiJk+cg3twUUKrRSKFLgdeVveLTy4dBPLPUuDeydC4Nsqn2MdMoi9SdAoT
         4DHnCRuKL346viW2l4WM0Vs5ac1MVZMsdGBeWD5T6i5uSGdXmcRMj1z00vOj+BfiPPhh
         JAXDFHteJETn+tK3RmoVdCy0U+rqJo/q4qIGXrlVNubdYtlA3s0NIzXLT8LyAzutdFhj
         6pcpnVwl1HaZYLsyzg2g77Rmei7CTgGfYaBsGbzXsM3H8Y9N/aqbdyVM/B0xoNMJR1hD
         ZouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700564692; x=1701169492;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kIK/f1U9gj42KtTbzVAHFRC1UQ6zgDgmA86Cyhg1HRw=;
        b=h8Rfk5KXCWBzaZxtLIChVEXdEIMeNts45EScdbDGY/xb/HEPEIXNHyvkYOedGCPbM8
         68bCP1jnekdN0HzHIvNAZZ8eWfWSshVDZsKrAff6gS5vDMN0jblVUdpG5zK8lQUsRqtO
         rd6fL6B6ckMksQihiRQG/64bLr8kVpGRsnQf3dleexxchKHjmzoVSh8rjL4686bZqbJc
         jCK+qj6d/QsOkWO9B9Dr8POAZ4ytqsCvq61iHtbbFinqU5HIJJEyRQUKtSqdam6jg1az
         JhCvKzX30tD13hMfrTK7w25oHUZzg61Wgl00Fs5abaig742g6acdMkN5n87XvF8GniVy
         DBgQ==
X-Gm-Message-State: AOJu0YzRtzzLSqzB2uSMB7RGqYU6xbyzyJAMvTpUH2khhaRIXlA9ESaV
        KcVvOmyxSA2nMl5JDc9KMJ98eQ==
X-Google-Smtp-Source: AGHT+IHIYLaPdDRrbJE5uQgQlOj1dJoooND6JHpZCP3BrMLOAYeMAn/fpW4er0klLi7y3R6yE9dZMg==
X-Received: by 2002:adf:f4cc:0:b0:332:cb97:2cb6 with SMTP id h12-20020adff4cc000000b00332cb972cb6mr2183534wrp.21.1700564691910;
        Tue, 21 Nov 2023 03:04:51 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:2a39:bc19:20b6:16a? ([2a01:e0a:982:cbb0:2a39:bc19:20b6:16a])
        by smtp.gmail.com with ESMTPSA id e1-20020adff341000000b0032f79e55eb8sm14010312wrp.16.2023.11.21.03.04.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Nov 2023 03:04:51 -0800 (PST)
Message-ID: <a69e5dd0-8efe-4415-9747-0554f8370fcf@linaro.org>
Date:   Tue, 21 Nov 2023 12:04:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] pmdomain: amlogic: meson-ee-pwrc: add support for
 G12A ISP power domain
Content-Language: en-US, fr
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Scally <dan.scally@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20231114-topic-amlogic-upstream-isp-pmdomain-v1-0-f01e6fca67a0@linaro.org>
 <20231114-topic-amlogic-upstream-isp-pmdomain-v1-2-f01e6fca67a0@linaro.org>
 <CAFBinCDe3yoEBd6SzozNZtC=zGaUHt4VeO_uhV1s5XBaWp0w1Q@mail.gmail.com>
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
In-Reply-To: <CAFBinCDe3yoEBd6SzozNZtC=zGaUHt4VeO_uhV1s5XBaWp0w1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/11/2023 21:15, Martin Blumenstingl wrote:
> Hi Neil,
> 
> On Tue, Nov 14, 2023 at 11:19 AM Neil Armstrong
> <neil.armstrong@linaro.org> wrote:
> [...]
>> +static struct meson_ee_pwrc_mem_domain g12a_pwrc_mem_isp[] = {
>> +       { G12A_HHI_ISP_MEM_PD_REG0, GENMASK(31, 0) },
>> +       { G12A_HHI_ISP_MEM_PD_REG0, GENMASK(31, 0) },
> I expected this second line to use G12A_HHI_ISP_MEM_PD_REG1 (note the
> number at the end: 0 vs 1)
> Is this correct?

Indeed you're right, let me fix it in a v2,

Thanks,
Neil

> 
> 
> Best regards,
> Martin

