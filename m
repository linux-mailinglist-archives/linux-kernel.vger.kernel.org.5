Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCED27F9B3C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230120AbjK0IC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:02:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjK0IC5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:02:57 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B5710F
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:03:03 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c59a4dd14cso43070871fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:03:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701072181; x=1701676981; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wcPPFmhl3jLXPrx+GR4n91er0md/NE3IurXgub64qsI=;
        b=pfZ4uhHCcYqkMIC35LXnNsmFKj966hFSU8TKgzdDC4zu7WVPXIhwD6yGDJ21O+DEPz
         Bhn/7yDraNmRJ5+8hNg1HRTxdu73D6NgED/bn0dxNqxEfmA98mBpNVqgaEf2Gewsucek
         WIJ/OOORSys6yyp/b7XZMnlSslRQNL8eFTtQyvGRkDhhGECBDXM+LPj0xFmCk+BRbYXB
         O01Y9svelNI6EX5lLGqcd0jvm1iYwW4H806S1IsHGWhP5DrBp/fvWNg+w3KlnZub304i
         DNahoOpOaE/lcmtQTpZjCKkv14XmOEnN4ESxMVmg52YkaOtaJ/V/69TPlh8/pwn5vSFp
         +P2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701072181; x=1701676981;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wcPPFmhl3jLXPrx+GR4n91er0md/NE3IurXgub64qsI=;
        b=smq4B92g8tznDezJL02yl+Ssm2QEqRVGv06gK+L+x2vFOdd10AwvmJslnwteWUm+/m
         rhAgni0U9MnxDM2aYyg4B0cRgYAeh2Q3ItXWF26gGxvE4t2ldbWI1ayEtdDe8gB1fmRP
         CaDbyzZ05/T/J9fqE+JP+WYu6TmNYzgjLD5Zq3KpVoEcoSj0N+BrhWbUgt3eTOz51qhG
         78D3YKnfoNcjtrjt/XJKS23LdRWEf49QS9PelbUEZeTkkwgLDx05xXp811/IYCzD5H9F
         q71+di0RfzUmKDBOaQUcE2NfoTysH/krB/hUtUQC+ehqUvNe/QjtJ7N3yIdbDM8tPPKL
         c23g==
X-Gm-Message-State: AOJu0YxNKOR6UKoLDTbAqp5LXSwUO5HbFUI85+2En6j0ymnM/JTEeIXe
        /pIOjQMg4ysMYAGglUZxEyeFpw==
X-Google-Smtp-Source: AGHT+IF+USKIUWRcJDJ+jO+C+fC+kGlWnuPFwuHOKDZ85Dt7rLgLUw3KjaqCg+qy1KSghN13oED0cw==
X-Received: by 2002:a05:651c:3d1:b0:2c9:a274:a511 with SMTP id f17-20020a05651c03d100b002c9a274a511mr1554431ljp.43.1701072181565;
        Mon, 27 Nov 2023 00:03:01 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:5a15:ac68:b4a4:85ff? ([2a01:e0a:982:cbb0:5a15:ac68:b4a4:85ff])
        by smtp.gmail.com with ESMTPSA id o36-20020a05600c512400b0040596352951sm13703473wms.5.2023.11.27.00.02.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 00:03:01 -0800 (PST)
Message-ID: <7166d20c-5092-4d7c-af0a-140854fa8e07@linaro.org>
Date:   Mon, 27 Nov 2023 09:02:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1 0/2] firmware: meson_sm: cleanup error paths inside
 probe()
Content-Language: en-US, fr
To:     Evgeny Bachinin <EABachinin@salutedevices.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        Miles Chen <miles.chen@mediatek.com>,
        Alexey Romanov <avromanov@salutedevices.com>
Cc:     kernel@sberdevices.ru, evgen89bachinin@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20231108125604.162383-1-EABachinin@salutedevices.com>
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
In-Reply-To: <20231108125604.162383-1-EABachinin@salutedevices.com>
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

On 08/11/2023 13:56, Evgeny Bachinin wrote:
> At first, patches series refactors sysfs node creation to avoid extra code
> paths. After that, the resource leak in probe error path is fixed.
> 
> Evgeny Bachinin (2):
>    firmware: meson_sm: refactor serial sysfs entry via dev_groups attrs
>    firmware: meson-sm: unmap out_base shmem in error path
> 
>   drivers/firmware/meson/meson_sm.c | 19 ++++++++-----------
>   1 file changed, 8 insertions(+), 11 deletions(-)
> 

Acked-by: Neil Armstrong <neil.armstrong@linaro.org>
