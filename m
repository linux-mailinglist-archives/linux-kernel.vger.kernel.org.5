Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F38798728
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 14:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237217AbjIHMhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 08:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbjIHMg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 08:36:59 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 406821BD3
        for <linux-kernel@vger.kernel.org>; Fri,  8 Sep 2023 05:36:55 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31c5c06e8bbso1931705f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Sep 2023 05:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694176614; x=1694781414; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Be2k1ZgrDZKG3iK8uhCg66l2zxTQVwhjYtA2BDkGIDQ=;
        b=qQ8h0XpKkLGML5wEMy3uoMnOIA5XZa1VT+v+sBKfNA3xbl4ISQN0f5PHN+siWLNtds
         dbvd7Ku8OCIuJ+fy4ZTRjFdTOxg3AWrccVmFRVmmntDxAP4MINdIU8TPvwSxiFhxIzqL
         CdsAExFp34hHkN17RPidnVlN0A7/PbH6Z/4s098H/UznF05I2pm1zJKUjpd64dphQy6I
         ck5INxU0Zg9tztxvkvn/GsIR0SqBvMZ7yru3O+VXxa3Ws3keMRCNoudIXtYMfMW9sH0m
         Mhn/q9vI0EU4bL3OGAHbqOf4cl9Pan3n2fFljLJbzBj6g6zTGB0dLrH7+EgNZhvRhMdM
         TZUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694176614; x=1694781414;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Be2k1ZgrDZKG3iK8uhCg66l2zxTQVwhjYtA2BDkGIDQ=;
        b=fz2Ynk4tDmSBqDJnh2EWEbxjgUz2XILV/WLGN5dMnmlDMN2RRXEcvn8W9Vo5RtuKrN
         0+eQh+w4CSzoP4EW1aFrjCmQgjCrgKmYQDJBrFkuUs39Gh3gMr6VHjpoW3rT5Hv60UKU
         kE0Sq2ZSAe+wnSlE1GZvpbhir/x5SM6D7PBtMOXlmX082rXkcXprepzoXOQmxWENEYhF
         mSb0vTKaiCsblk+hrJhkn1FgYl9sHJmGr56mXrJNPRbxf3mWOaOyniMsY2w1xb+GcYk5
         vdhJCNR0h68kXN2F0rpw0R2BimnZXRwXP/PcTec3ehkRCCtn+uPKU6AvFxbJK72P3o07
         naOg==
X-Gm-Message-State: AOJu0YzvgTsUeu7yjnMv1ofAyiY5FbUsKlBpVeIzQM/QAAXDK64w863f
        owas7S5A0dFQnvt+D+LGXY7Xww==
X-Google-Smtp-Source: AGHT+IG9qMiw25Y/hia5vITBIkDc4lQt9y53sSYzYWNjS0uYR1XAAv0nZni37xL449zcerxOyCM/pA==
X-Received: by 2002:a5d:560d:0:b0:31d:cd33:b30e with SMTP id l13-20020a5d560d000000b0031dcd33b30emr2058224wrv.4.1694176613583;
        Fri, 08 Sep 2023 05:36:53 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:5f1a:ed04:d131:cda4? ([2a01:e0a:982:cbb0:5f1a:ed04:d131:cda4])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d6103000000b00316eb7770b8sm2023056wrt.5.2023.09.08.05.36.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Sep 2023 05:36:53 -0700 (PDT)
Message-ID: <12521b44-edba-49af-9011-b7850c39b35e@linaro.org>
Date:   Fri, 8 Sep 2023 14:36:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v1] arm64: dts: amlogic: meson-axg: Meson NAND node
Content-Language: en-US, fr
To:     Arseniy Krasnov <avkrasnov@salutedevices.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     oxffffaa@gmail.com, kernel@sberdevices.ru,
        Liang Yang <liang.yang@amlogic.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230828133647.3712644-1-avkrasnov@salutedevices.com>
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
In-Reply-To: <20230828133647.3712644-1-avkrasnov@salutedevices.com>
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

On 28/08/2023 15:36, Arseniy Krasnov wrote:
> Add description of the Meson NAND controller node.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
> ---
>   arch/arm64/boot/dts/amlogic/meson-axg.dtsi | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> index 768d0ed78dbe..a49aa62e3f9f 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-axg.dtsi
> @@ -1908,6 +1908,19 @@ sd_emmc_c: mmc@7000 {
>   				resets = <&reset RESET_SD_EMMC_C>;
>   			};
>   
> +			nfc: nand-controller@7800 {
> +				compatible = "amlogic,meson-axg-nfc";
> +				reg = <0x0 0x7800 0x0 0x100>,
> +				      <0x0 0x7000 0x0 0x800>;
> +				reg-names = "nfc", "emmc";
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				interrupts = <GIC_SPI 34 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&clkc CLKID_SD_EMMC_C>,
> +					 <&clkc CLKID_FCLK_DIV2>;
> +				clock-names = "core", "device";
> +			};
> +
>   			usb2_phy1: phy@9020 {
>   				compatible = "amlogic,meson-gxl-usb2-phy";
>   				#phy-cells = <0>;

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
