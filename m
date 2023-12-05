Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A216804C02
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344663AbjLEINI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231725AbjLEIND (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:13:03 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8050AD41
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 00:13:05 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c0f3a7717so12124535e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 00:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701763984; x=1702368784; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XWumVZikOXzxQEuwBpEYj+ThnaICBaLkShH0sLOBNUg=;
        b=zdTj1v9GUOsa3bdCFKDkTP1Bu2H8zxguN63LD/8GyC8SFulYQZkvIwf/k2MYju5Rko
         eu66uILyuTKEYaSYh5cUzq4FCwG7zrlJ5xSAV5MJoR3lKv3A4fgizyoMv/lQSKkie+Zw
         USiLJftKy+S9y7n9y+PxiUFssASuQHBZ2XyQ0tIPqiHO/5oPd/aOzPlbGgZ+Z/w7lXoj
         qNHv3cpAcjZmSXxVncwe3oIssV2GJ3wVU30EqSa3edOag/xkvdj2ZKm7SG9HJK6uyIS5
         ns9tDj9iQYbbzLlhtCahR7VE4ZGIkFOFRFbmGedWv1J/nHwesw6RxgBR4yjzkIfAF7ch
         PFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701763984; x=1702368784;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :references:cc:to:content-language:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XWumVZikOXzxQEuwBpEYj+ThnaICBaLkShH0sLOBNUg=;
        b=KvIrS4rDGaTAWfb+Efr60R75vsUzx46P3XAv5b4EP94rP99SlGXlQU1mktibPoE0t3
         qIW9UeXLGCcVJG+5Vr1S49oUmqQ+w4ZYQATjykyJy0YKLai9Fi2RS5apl9lETdEfglMI
         /HBVIlh6R9yXEmxxVw/KOpn5j0LrmR0pOe2CQNREXL1L+01r5JRBCeF4TDZoiyFbOyxB
         1lEBv6X9Fakeh1sh6qz7XUTdZc4sFYc67MtcRQUhtAtD6DNqxfi6zjWAxF+ADxKvLHZY
         VNfYzhwakdjPQoP5pqYqfGZNASZxWMgqAKQOqh5xPX1I5nnXKp7T7iFNbWLGal7SA3uv
         /04A==
X-Gm-Message-State: AOJu0Yz4nDPe/oKHGUKKBUI/YxefIZxZap6enFTRB31dTnb5ITDgeHZz
        vbfgM6lEBD69YAMYHSvZUBwp7A==
X-Google-Smtp-Source: AGHT+IGWc9xTOPWlQOOr6X538/CWDGQxdCUUBsGV9G+7FbahJqBYmrp6U/0fIBx/1DtDiRbMKhAXbw==
X-Received: by 2002:a05:600c:230b:b0:40b:5f03:b41a with SMTP id 11-20020a05600c230b00b0040b5f03b41amr1826465wmo.316.1701763983722;
        Tue, 05 Dec 2023 00:13:03 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:4518:5e57:ff13:b4bb? ([2a01:e0a:982:cbb0:4518:5e57:ff13:b4bb])
        by smtp.gmail.com with ESMTPSA id v9-20020a05600c470900b004063cd8105csm21461190wmo.22.2023.12.05.00.13.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Dec 2023 00:13:03 -0800 (PST)
Message-ID: <51bd4c09-8e84-448b-b3ce-67b8343f4c33@linaro.org>
Date:   Tue, 5 Dec 2023 09:13:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 3/3] drm/panel: ilitek-ili9881c: Add Ampire AM8001280G LCD
 panel
Content-Language: en-US, fr
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        Jessica Zhang <quic_jesszhan@quicinc.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Marco Felsch <m.felsch@pengutronix.de>,
        kernel@pengutronix.de
References: <20231123-drm-panel-ili9881c-am8001280g-v1-0-fdf4d624c211@pengutronix.de>
 <20231123-drm-panel-ili9881c-am8001280g-v1-3-fdf4d624c211@pengutronix.de>
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
In-Reply-To: <20231123-drm-panel-ili9881c-am8001280g-v1-3-fdf4d624c211@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2023 18:08, Philipp Zabel wrote:
> Add support for Ampire AM8001280G LCD panels.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>   drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 223 ++++++++++++++++++++++++++
>   1 file changed, 223 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> index 0c911ed9141b..2ffe5f68a890 100644
> --- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> +++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
> @@ -830,6 +830,203 @@ static const struct ili9881c_instr w552946ab_init[] = {
>   	ILI9881C_SWITCH_PAGE_INSTR(0),
>   };
>   
> +static const struct ili9881c_instr am8001280g_init[] = {
> +	ILI9881C_SWITCH_PAGE_INSTR(3),
> +	ILI9881C_COMMAND_INSTR(0x01, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x02, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x03, 0x73),
> +	ILI9881C_COMMAND_INSTR(0x04, 0xD3),
> +	ILI9881C_COMMAND_INSTR(0x05, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x06, 0x0A),
> +	ILI9881C_COMMAND_INSTR(0x07, 0x0E),
> +	ILI9881C_COMMAND_INSTR(0x08, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x09, 0x01),
> +	ILI9881C_COMMAND_INSTR(0x0a, 0x01),
> +	ILI9881C_COMMAND_INSTR(0x0b, 0x01),
> +	ILI9881C_COMMAND_INSTR(0x0c, 0x01),
> +	ILI9881C_COMMAND_INSTR(0x0d, 0x01),
> +	ILI9881C_COMMAND_INSTR(0x0e, 0x01),
> +	ILI9881C_COMMAND_INSTR(0x0f, 0x01),
> +	ILI9881C_COMMAND_INSTR(0x10, 0x01),
> +	ILI9881C_COMMAND_INSTR(0x11, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x12, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x13, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x14, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x15, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x16, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x17, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x18, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x19, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x1a, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x1b, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x1c, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x1d, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x1e, 0x40),
> +	ILI9881C_COMMAND_INSTR(0x1f, 0x80),
> +	ILI9881C_COMMAND_INSTR(0x20, 0x06),
> +	ILI9881C_COMMAND_INSTR(0x21, 0x01),
> +	ILI9881C_COMMAND_INSTR(0x22, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x23, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x24, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x25, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x26, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x27, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x28, 0x33),
> +	ILI9881C_COMMAND_INSTR(0x29, 0x03),
> +	ILI9881C_COMMAND_INSTR(0x2a, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x2b, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x2c, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x2d, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x2e, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x2f, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x30, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x31, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x32, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x33, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x34, 0x03),
> +	ILI9881C_COMMAND_INSTR(0x35, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x36, 0x03),
> +	ILI9881C_COMMAND_INSTR(0x37, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x38, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x39, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x3a, 0x40),
> +	ILI9881C_COMMAND_INSTR(0x3b, 0x40),
> +	ILI9881C_COMMAND_INSTR(0x3c, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x3d, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x3e, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x3f, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x40, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x41, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x42, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x43, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x44, 0x00),
> +
> +	ILI9881C_COMMAND_INSTR(0x50, 0x01),
> +	ILI9881C_COMMAND_INSTR(0x51, 0x23),
> +	ILI9881C_COMMAND_INSTR(0x52, 0x45),
> +	ILI9881C_COMMAND_INSTR(0x53, 0x67),
> +	ILI9881C_COMMAND_INSTR(0x54, 0x89),
> +	ILI9881C_COMMAND_INSTR(0x55, 0xab),
> +	ILI9881C_COMMAND_INSTR(0x56, 0x01),
> +	ILI9881C_COMMAND_INSTR(0x57, 0x23),
> +	ILI9881C_COMMAND_INSTR(0x58, 0x45),
> +	ILI9881C_COMMAND_INSTR(0x59, 0x67),
> +	ILI9881C_COMMAND_INSTR(0x5a, 0x89),
> +	ILI9881C_COMMAND_INSTR(0x5b, 0xab),
> +	ILI9881C_COMMAND_INSTR(0x5c, 0xcd),
> +	ILI9881C_COMMAND_INSTR(0x5d, 0xef),
> +
> +	ILI9881C_COMMAND_INSTR(0x5e, 0x11),
> +	ILI9881C_COMMAND_INSTR(0x5f, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x60, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x61, 0x01),
> +	ILI9881C_COMMAND_INSTR(0x62, 0x0D),
> +	ILI9881C_COMMAND_INSTR(0x63, 0x0C),
> +	ILI9881C_COMMAND_INSTR(0x64, 0x0F),
> +	ILI9881C_COMMAND_INSTR(0x65, 0x0E),
> +	ILI9881C_COMMAND_INSTR(0x66, 0x06),
> +	ILI9881C_COMMAND_INSTR(0x67, 0x07),
> +	ILI9881C_COMMAND_INSTR(0x68, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x69, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x6a, 0x08),
> +	ILI9881C_COMMAND_INSTR(0x6b, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x6c, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x6d, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x6e, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x6f, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x70, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x71, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x72, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x73, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x74, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x75, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x76, 0x00),
> +	ILI9881C_COMMAND_INSTR(0x77, 0x01),
> +	ILI9881C_COMMAND_INSTR(0x78, 0x0D),
> +	ILI9881C_COMMAND_INSTR(0x79, 0x0C),
> +	ILI9881C_COMMAND_INSTR(0x7a, 0x0F),
> +	ILI9881C_COMMAND_INSTR(0x7b, 0x0E),
> +	ILI9881C_COMMAND_INSTR(0x7c, 0x06),
> +	ILI9881C_COMMAND_INSTR(0x7d, 0x07),
> +	ILI9881C_COMMAND_INSTR(0x7e, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x7f, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x80, 0x08),
> +	ILI9881C_COMMAND_INSTR(0x81, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x82, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x83, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x84, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x85, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x86, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x87, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x88, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x89, 0x02),
> +	ILI9881C_COMMAND_INSTR(0x8A, 0x02),
> +
> +	ILI9881C_SWITCH_PAGE_INSTR(4),
> +	ILI9881C_COMMAND_INSTR(0x6c, 0x15),
> +	ILI9881C_COMMAND_INSTR(0x6e, 0x30),
> +	ILI9881C_COMMAND_INSTR(0x6f, 0x33),
> +	ILI9881C_COMMAND_INSTR(0x8d, 0x15),
> +	ILI9881C_COMMAND_INSTR(0x3a, 0xa4),
> +	ILI9881C_COMMAND_INSTR(0x87, 0xba),
> +	ILI9881C_COMMAND_INSTR(0x26, 0x76),
> +	ILI9881C_COMMAND_INSTR(0xb2, 0xd1),
> +
> +	ILI9881C_SWITCH_PAGE_INSTR(1),
> +	ILI9881C_COMMAND_INSTR(0x22, 0x0A),
> +	ILI9881C_COMMAND_INSTR(0x31, 0x0B),
> +	ILI9881C_COMMAND_INSTR(0x50, 0xa5),
> +	ILI9881C_COMMAND_INSTR(0x51, 0xa0),
> +	ILI9881C_COMMAND_INSTR(0x53, 0x70),
> +	ILI9881C_COMMAND_INSTR(0x55, 0x7A),
> +	ILI9881C_COMMAND_INSTR(0x60, 0x14),
> +
> +	ILI9881C_COMMAND_INSTR(0xA0, 0x00),
> +	ILI9881C_COMMAND_INSTR(0xA1, 0x53),
> +	ILI9881C_COMMAND_INSTR(0xA2, 0x50),
> +	ILI9881C_COMMAND_INSTR(0xA3, 0x20),
> +	ILI9881C_COMMAND_INSTR(0xA4, 0x27),
> +	ILI9881C_COMMAND_INSTR(0xA5, 0x33),
> +	ILI9881C_COMMAND_INSTR(0xA6, 0x25),
> +	ILI9881C_COMMAND_INSTR(0xA7, 0x25),
> +	ILI9881C_COMMAND_INSTR(0xA8, 0xD4),
> +	ILI9881C_COMMAND_INSTR(0xA9, 0x1A),
> +	ILI9881C_COMMAND_INSTR(0xAA, 0x2B),
> +	ILI9881C_COMMAND_INSTR(0xAB, 0xB5),
> +	ILI9881C_COMMAND_INSTR(0xAC, 0x19),
> +	ILI9881C_COMMAND_INSTR(0xAD, 0x18),
> +	ILI9881C_COMMAND_INSTR(0xAE, 0x53),
> +	ILI9881C_COMMAND_INSTR(0xAF, 0x1A),
> +	ILI9881C_COMMAND_INSTR(0xB0, 0x25),
> +	ILI9881C_COMMAND_INSTR(0xB1, 0x62),
> +	ILI9881C_COMMAND_INSTR(0xB2, 0x6A),
> +	ILI9881C_COMMAND_INSTR(0xB3, 0x31),
> +
> +	ILI9881C_COMMAND_INSTR(0xC0, 0x00),
> +	ILI9881C_COMMAND_INSTR(0xC1, 0x53),
> +	ILI9881C_COMMAND_INSTR(0xC2, 0x50),
> +	ILI9881C_COMMAND_INSTR(0xC3, 0x20),
> +	ILI9881C_COMMAND_INSTR(0xC4, 0x27),
> +	ILI9881C_COMMAND_INSTR(0xC5, 0x33),
> +	ILI9881C_COMMAND_INSTR(0xC6, 0x25),
> +	ILI9881C_COMMAND_INSTR(0xC7, 0x25),
> +	ILI9881C_COMMAND_INSTR(0xC8, 0xD4),
> +	ILI9881C_COMMAND_INSTR(0xC9, 0x1A),
> +	ILI9881C_COMMAND_INSTR(0xCA, 0x2B),
> +	ILI9881C_COMMAND_INSTR(0xCB, 0xB5),
> +	ILI9881C_COMMAND_INSTR(0xCC, 0x19),
> +	ILI9881C_COMMAND_INSTR(0xCD, 0x18),
> +	ILI9881C_COMMAND_INSTR(0xCE, 0x53),
> +	ILI9881C_COMMAND_INSTR(0xCF, 0x1A),
> +	ILI9881C_COMMAND_INSTR(0xD0, 0x25),
> +	ILI9881C_COMMAND_INSTR(0xD1, 0x62),
> +	ILI9881C_COMMAND_INSTR(0xD2, 0x6A),
> +	ILI9881C_COMMAND_INSTR(0xD3, 0x31),
> +	ILI9881C_SWITCH_PAGE_INSTR(0),
> +	ILI9881C_COMMAND_INSTR(MIPI_DCS_WRITE_CONTROL_DISPLAY, 0x2c),
> +	ILI9881C_COMMAND_INSTR(MIPI_DCS_WRITE_POWER_SAVE, 0x00),
> +};
> +
>   static inline struct ili9881c *panel_to_ili9881c(struct drm_panel *panel)
>   {
>   	return container_of(panel, struct ili9881c, panel);
> @@ -1014,6 +1211,23 @@ static const struct drm_display_mode w552946aba_default_mode = {
>   	.height_mm	= 121,
>   };
>   
> +static const struct drm_display_mode am8001280g_default_mode = {
> +	.clock		= 67911,
> +
> +	.hdisplay	= 800,
> +	.hsync_start	= 800 + 20,
> +	.hsync_end	= 800 + 20 + 32,
> +	.htotal		= 800 + 20 + 32 + 20,
> +
> +	.vdisplay	= 1280,
> +	.vsync_start	= 1280 + 6,
> +	.vsync_end	= 1280 + 6 + 8,
> +	.vtotal		= 1280 + 6 + 8 + 4,
> +
> +	.width_mm	= 94,
> +	.height_mm	= 151,
> +};
> +
>   static int ili9881c_get_modes(struct drm_panel *panel,
>   			      struct drm_connector *connector)
>   {
> @@ -1147,11 +1361,20 @@ static const struct ili9881c_desc w552946aba_desc = {
>   		      MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_NO_EOT_PACKET,
>   };
>   
> +static const struct ili9881c_desc am8001280g_desc = {
> +	.init = am8001280g_init,
> +	.init_length = ARRAY_SIZE(am8001280g_init),
> +	.mode = &am8001280g_default_mode,
> +	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
> +		      MIPI_DSI_CLOCK_NON_CONTINUOUS | MIPI_DSI_MODE_LPM,
> +};
> +
>   static const struct of_device_id ili9881c_of_match[] = {
>   	{ .compatible = "bananapi,lhr050h41", .data = &lhr050h41_desc },
>   	{ .compatible = "feixin,k101-im2byl02", .data = &k101_im2byl02_desc },
>   	{ .compatible = "tdo,tl050hdv35", .data = &tl050hdv35_desc },
>   	{ .compatible = "wanchanglong,w552946aba", .data = &w552946aba_desc },
> +	{ .compatible = "ampire,am8001280g", .data = &am8001280g_desc },
>   	{ }
>   };
>   MODULE_DEVICE_TABLE(of, ili9881c_of_match);
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
