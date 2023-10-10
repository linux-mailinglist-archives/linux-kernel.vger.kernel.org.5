Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2684A7C0307
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 19:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234074AbjJJRxQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 13:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233999AbjJJRxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 13:53:15 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79879A7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:53:13 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-406619b53caso55359195e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 10:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696960392; x=1697565192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:reply-to:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HSrhS+Y5NUbiKTwTH1nhAVKAr59WAJLwtFf78qIT2sM=;
        b=UwtTN9jmuLy6PPgQmomxJXiv0Z9cIYxKahHvW60N8kXi3N048mPOrhdmWvPj2xCJTu
         ALqzx73/7w1blocD3M49+u0omYxtfz0HxZI8H0Y7diUJ7ijuyJeoLu1dvI2iayhpoue3
         s9T3H1t45XRBDPUZC6uHBlZBx+RiSMMgyBW6GwbKP9ngoHHkyQZsjVvTmrrRD8tF3bMA
         e7oPzdiiTU45PXDTF3euYPHCdZQF6vl10d51xEjQm8eleh1tdSJtu0C1ZqRCXaazbewP
         nwBMAt1str7Qcu9zb1HbOjzLeZsqh3UegGwy6WBCmcodlAZNIJnhA5tt1t+iLy2uJiQH
         d0+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696960392; x=1697565192;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:reply-to:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HSrhS+Y5NUbiKTwTH1nhAVKAr59WAJLwtFf78qIT2sM=;
        b=Ao1tJsE7r46+n6nu+5njf60TeI7Aod7Kj+jKPlZUqxyqNq6OH1BySnNKdiD0Ler0iI
         81dGb3CAdGHVRaqnDVszb2HiB7jeXws4F/+CEmdX5rkJA+TAeaOcwyF9tFLoWA6Q3VHa
         QJD/Uo15k562vPIQJU/s0X2LqnE6Jr7BxRSwll85ILwbFl6x4c1vci9ljAztEt/PxiR3
         dLgc+pZJ9Xcu5MoH4+WfoFLqRXCXCvtOsjiKUZlyEwAAn9yXaZP+sJnknWC7mlpkkRj3
         MYzP7zh2FXTikcfIVhTH6HJaUVC6ADPzenxq+Lbv41nf7KHTNYbWMqoOu026MP281Xd8
         rIDw==
X-Gm-Message-State: AOJu0Yy8b/e1y17ZET/sXgIYlkc27dBreGrv/YXK4IOLQ49tSw3QUaDF
        fJpeIGzrUap6tNcA5Z9Ayojn9g==
X-Google-Smtp-Source: AGHT+IHzVMxGmaidcZD69WfVQvYZd9PD5NW75Sycsq+x2li8H1LirkVsUZqgDcmzrQFjcBXeDNIpHw==
X-Received: by 2002:a5d:45c2:0:b0:317:5bb2:aeca with SMTP id b2-20020a5d45c2000000b003175bb2aecamr16129536wrs.16.1696960391790;
        Tue, 10 Oct 2023 10:53:11 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:dc16:42a:1d87:57c1? ([2a01:e0a:982:cbb0:dc16:42a:1d87:57c1])
        by smtp.gmail.com with ESMTPSA id i10-20020adff30a000000b0031f8a59dbeasm13222309wro.62.2023.10.10.10.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 10:53:11 -0700 (PDT)
Message-ID: <8ccbeb04-9671-4414-810e-70d4c3690e0c@linaro.org>
Date:   Tue, 10 Oct 2023 19:53:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 1/3] dt-bindings: mfd: qcom,tcsr: Add compatible for
 sm8{2|3|5}50
Content-Language: en-US, fr
To:     Mukesh Ojha <quic_mojha@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1696954157-16327-1-git-send-email-quic_mojha@quicinc.com>
From:   Neil Armstrong <neil.armstrong@linaro.org>
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
In-Reply-To: <1696954157-16327-1-git-send-email-quic_mojha@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2023 18:09, Mukesh Ojha wrote:
> Document the compatible for sm8{2|3|5}50 SoCs.
> 
> Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
> ---
>   Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> index 33c3d023a106..f328ddd6c566 100644
> --- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> +++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
> @@ -29,7 +29,10 @@ properties:
>             - qcom,sdx65-tcsr
>             - qcom,sm4450-tcsr
>             - qcom,sm8150-tcsr
> +          - qcom,sm8250-tcsr
> +          - qcom,sm8350-tcsr
>             - qcom,sm8450-tcsr
> +          - qcom,sm8550-tcsr

This is already documented in:
Documentation/devicetree/bindings/clock/qcom,sm8550-tcsr.yaml

>             - qcom,tcsr-apq8064
>             - qcom,tcsr-apq8084
>             - qcom,tcsr-ipq5332

