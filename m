Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCDD7E9F17
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 15:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbjKMOqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 09:46:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjKMOqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 09:46:51 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4781706
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:46:47 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32fbf271346so2745268f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 06:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699886806; x=1700491606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eH/cbv+HTmjd9T6Og+nrY0oFWB621hXpBo6QeBm/lDg=;
        b=ZpD9H2366KcA0db6Mu4/g0+zwNYDKLjKHr939p5a3t6OPxGoqU5xpCupux0V4GaZG1
         umko9mVdDObX/FlgIBHZpTGRzSDSSupiQk7Htje2gkF7n4puU1l/0qGECVueI1OVACYw
         bV4aoVXqswCaW51kd/ZKpkiPfsiKgQnNE461y20xdgnJJx6MUJ6MSC6xmGKCidEIL0W/
         rg2JJl8S+NOQ1dnBfyH5h3+TuhEzYmpPM+iSshHJLQin61qwt9TiovfCXkt6KSu/e9T8
         qDhPTAhA3xPmsGrClcDH4QO2LTX4voO6iKMpVn5n1vDULvkBk4+PIYOXQGMnjvYBx+XC
         dCDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699886806; x=1700491606;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eH/cbv+HTmjd9T6Og+nrY0oFWB621hXpBo6QeBm/lDg=;
        b=CbLlQmxw9y77I/nclEe5NIRK4YznOaNzOk3xjT35WbTSWYKB9eI5+djSoxRPq0l9TP
         4OxKqFi0LQ1YR88yXAfvF4JoykLvqZckaSwcpXtT/gKza5xli+AmO4q9ddupSsIJqfAo
         GS0gso6Hb82cN/ymN7GLfIvCdXV7BpsbcSDzsMVHS4XOkpouzkxkRWvEUmGGSAWggfc7
         eo1ViVQrkdFNl2TxXFYuLD2Zt06kKQxIA+Zdd3WE8uB0L9HgNF6ZcMyWgsDscuN0vB82
         FZ5b/QtYUA8kMesmEd0uNYHsmoeiqLVxeNNj9ZpVgW2tDbUCgwFLws0021jaltyqkrDk
         K/TA==
X-Gm-Message-State: AOJu0Yx9HPiptAqkEupuhUmjUtriis/3Y4oV6vppfnnIYXBLxZC+4Ai4
        ICMQxxSOOAWgqJrG7Xqm4/Wdyg==
X-Google-Smtp-Source: AGHT+IFElif9cHOC9qe+E7tgITXO3oLS7DlfLfXUb9l/5s3/U7DnGOzL81WwyZYiUMApLuYHuAwrUw==
X-Received: by 2002:a05:6000:178d:b0:32d:a466:48d8 with SMTP id e13-20020a056000178d00b0032da46648d8mr6597253wrg.69.1699886805912;
        Mon, 13 Nov 2023 06:46:45 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:1bb7:80e:7bf2:f66c? ([2a01:e0a:982:cbb0:1bb7:80e:7bf2:f66c])
        by smtp.gmail.com with ESMTPSA id o16-20020adfe810000000b0032326908972sm5587673wrm.17.2023.11.13.06.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Nov 2023 06:46:45 -0800 (PST)
Message-ID: <418b98b5-738b-491d-b5a2-692fd26dbf98@linaro.org>
Date:   Mon, 13 Nov 2023 15:46:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v3 0/3] pinctrl: qcom: Introduce Pinctrl/GPIO for SM8650
Content-Language: en-US, fr
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20231106-topic-sm8650-upstream-tlmm-v3-0-0e179c368933@linaro.org>
 <CACRpkdYB7AQZ7HeNmE5d716sWz5_MHiVtAet6P5XOC1etDKNcw@mail.gmail.com>
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
In-Reply-To: <CACRpkdYB7AQZ7HeNmE5d716sWz5_MHiVtAet6P5XOC1etDKNcw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On 13/11/2023 15:06, Linus Walleij wrote:
> On Mon, Nov 6, 2023 at 9:32 AM Neil Armstrong <neil.armstrong@linaro.org> wrote:
> 
>> The SM8650 Top Level Mode Multiplexer supports 211 GPIOs,
>> and the usual UFS Reset, SDC Clk/Cmd/Data special pins.
>>
>> An handful of pins can have their IRQ generated by the PDC
>> module, and for this support for the new wakeup_present &
>> wakeup_enable_bit is required to allow the "wakeup" event
>> to be passed to PDC and generate an interrupt or a wakeup
>> system event.
>>
>> As SM8550, it also supports the i2c_pull_bit bit to enable the
>> on-SoC load resistor for I2C busses.
>>
>> Dependencies: None
>>
>> For convenience, a regularly refreshed linux-next based git tree containing
>> all the SM8650 related work is available at:
>> https://git.codelinaro.org/neil.armstrong/linux/-/tree/topic/sm8650/upstream/integ
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Patches applied, unless Bjorn has some last minutes regrets,
> they are in.
> 
> Had to rebase the last patch manually because of Krzysztof's
> LPASS driver, check the result pls.

Will check, thanks.

Neil

> 
> Yours,
> Linus Walleij

