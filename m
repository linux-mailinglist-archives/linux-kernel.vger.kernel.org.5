Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE0A7FEC3D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 10:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbjK3Jxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 04:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjK3Jxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 04:53:34 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE79D10C9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:53:39 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-40b4e35ecf1so6016655e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 01:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701338018; x=1701942818; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f0oSj0qrgtoV8MWs2hWZ/nAjZRQvwME7M2ma5I8IkEo=;
        b=mCZsc2oGXkPHyLUyPFV935QQY85SSxjj2/8HQnjf1Ma9C+cN6+VYtBBHEdJGgBn5XF
         HQDi3kuju7DGYyumhr2t7L8rQ49dnt7DBmj9Hrb5SDQdiCb0iZ33mf+05Perb0JE+W+F
         VJt3x1+z50Yuf9/jINK2OJe+as8L0J/qzKaSTx/w67Lo4lnC6GFwijh3ZRSxwwVJ27p2
         IvV+heacn+62QTe3NSpbG7kl0MgWMu5h8qWA02KgGLlS9p909iIvgfPRi4+33aXfaYMS
         bgvgdWusq5nkMGS4u145Knfblc5mjjHnv4Ytf/WfFjsN/7qEoEfyo23DZlxOs45VgRyD
         z/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701338018; x=1701942818;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=f0oSj0qrgtoV8MWs2hWZ/nAjZRQvwME7M2ma5I8IkEo=;
        b=RF4iMruxu3JBp4LlzEk3gcUMdYXkTG90Xxn1yQKEVgNurv61eC0m7uzK4lqGITAOYF
         UVOew4BMFL/JJze1C8gHSSyKP8dKR9KoQOcoL/fgip/M3L8AzWbKVtbYmz+po/FmJLLh
         cALc6OausZLE6hfbb2Ukdvhl2Qs929XIJG0gORpTeHP7W/iCSmc7Q1sXFDSvPH4+pEjA
         hTYwVlRN9121BF/cx1X7DJpHMT4adSZsbukOvOhYpx8n97frFBXRYiRaUVMgNiMKPcjH
         300vC4qc/djnBDSxovRG15e1yAEelLUq+L4oVrPmLUm8PVaDTU/uNGZNS5LvTd4AEpn0
         d2FA==
X-Gm-Message-State: AOJu0YwQMd+9T1TAlDyBj5dPqq9Tk3XrjG5BMAWR40cO8/fCB/15gt8C
        R4vDFZHaYCBspeRsP7WS7uU2xw==
X-Google-Smtp-Source: AGHT+IEHObDb9K2qTDOvGmoxgm+7e0PK9/gGK3ZXS5FzCE3oaEN8Qow73cBBU2nd8zagdCxH6q04Ng==
X-Received: by 2002:a05:600c:1d05:b0:40b:3faa:c964 with SMTP id l5-20020a05600c1d0500b0040b3faac964mr11627500wms.27.1701338018300;
        Thu, 30 Nov 2023 01:53:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:41c9:3acd:a6e2:5242? ([2a01:e0a:982:cbb0:41c9:3acd:a6e2:5242])
        by smtp.gmail.com with ESMTPSA id p36-20020a05600c1da400b0040b478da760sm1358964wms.48.2023.11.30.01.53.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 01:53:37 -0800 (PST)
Message-ID: <ebfdd058-dfca-4fd7-be62-cc89e15a8318@linaro.org>
Date:   Thu, 30 Nov 2023 10:53:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/6] arm64: dts: qcom: sm8450: Add GPU nodes
Content-Language: en-US, fr
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20231127-topic-a7xx_dt-v1-0-a228b8122ebf@linaro.org>
 <20231127-topic-a7xx_dt-v1-2-a228b8122ebf@linaro.org>
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
In-Reply-To: <20231127-topic-a7xx_dt-v1-2-a228b8122ebf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/11/2023 17:20, Konrad Dybcio wrote:
> Add the required nodes to support the A730 GPU.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8450.dtsi | 202 +++++++++++++++++++++++++++++++++++
>   1 file changed, 202 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
> index bde9c1093384..e9664672c160 100644
> --- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi

<snip>


Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
