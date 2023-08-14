Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DD477B36C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbjHNIJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbjHNIJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:09:35 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 105599D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:09:12 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-99c353a395cso539784466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692000546; x=1692605346;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wW73jLCz6WieQvaVVhpG3EtKgyhVpALhxWqDlxdk10k=;
        b=jqCYy3Rwepnr0q4EP509gEzHyPJaOU/Jg5deC7nJrTakv9BmAOMi/nSMf1jwON5F/V
         IuF3yQ35p/ASKUUe9dTzFP78WGE9wcjV4RkNjLEG2C0jmIUCxe15CT8MLNwXgOCj7db2
         oIPDlCHg34KytoFGePzBAvIFJdh0LTn2po2qclayipFFWWA6MUtMaCN0AzJaSYHVu4IB
         CDUKRdbqKaCyg5EAkNxeGrNrD+loCHS9/zmuRqFKESDu14oEkGmWNGxKyy+Vt00RbYd0
         /4K4r+MgkFX/qO79UBebhXCpR9DIDoGi5u5bS2UkGncs6kCzDu1HOLDimuYAjc5cQ0I4
         h3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692000546; x=1692605346;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wW73jLCz6WieQvaVVhpG3EtKgyhVpALhxWqDlxdk10k=;
        b=BD2m+H0AhwTZ4gv6EQ4Z82pLzKPcF9URjxdx6Xzlt8ngIuS+KuLuq0i6nbV8GWDHKV
         3ag6yvkK2PRIl9tkba5xi91zNMw48qozX38hOVKnoZu6SeoiVhzQMy0HuF7e6VxJxW43
         wPaL8KC2FqemM+tsXJBimH8I4UXRMl+4O8tnvA2DHQuBifekdVXMtZa9SFhY+6GGgEkW
         iN/lJwD3TiXLU1lvdTQFQ8hf8rFXAitcUTKH/EV8UlgWVNPrsxyrAIzzTEsZmmh2sh2b
         +0U/B8LAnd//nssggDQ6mwBXdT/wr2TK3MbxqribFjBXJ8QnBgExNeMSdP3L5ypbHtgT
         H7YA==
X-Gm-Message-State: AOJu0YwvphJ1UVrHwLdFDwasQjfpN0hVAqX88oaTuna50ZuZXFlQjoYx
        ej9P+w/taS2iG1WQhGQjsGgorg==
X-Google-Smtp-Source: AGHT+IEgRyR4gQ082IQCVGw8VR3WnXzvZ2IaUK1a4+yaS7LZUkquL49geYE7k2QthCwZcD4rCoZPjQ==
X-Received: by 2002:a17:906:3044:b0:993:ec0b:1a24 with SMTP id d4-20020a170906304400b00993ec0b1a24mr7139171ejd.7.1692000546430;
        Mon, 14 Aug 2023 01:09:06 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id ov14-20020a170906fc0e00b0099290e2c163sm5390760ejb.204.2023.08.14.01.09.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 01:09:06 -0700 (PDT)
Message-ID: <cbc5c82a-dfda-2d46-44a9-6338f2eb505c@linaro.org>
Date:   Mon, 14 Aug 2023 10:09:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/2] arm64: dts: allwinner: h616: Add SID controller
 node
Content-Language: en-US
To:     Martin Botka <martin.botka@somainline.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <mripard@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        Andre Przywara <andre.przywara@arm.com>,
        Alan Ma <tech@biqu3d.com>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
References: <20230814-sid-h616-v2-0-0267749b4471@somainline.org>
 <20230814-sid-h616-v2-2-0267749b4471@somainline.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230814-sid-h616-v2-2-0267749b4471@somainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/08/2023 08:38, Martin Botka wrote:
> Add node for the H616 SID controller
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> index 74aed0d232a9..d549d277d972 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
> @@ -133,6 +133,13 @@ ccu: clock@3001000 {
>  			#reset-cells = <1>;
>  		};
>  
> +		sid: efuse@3006000 {
> +			compatible = "allwinner,sun50i-h616-sid", "allwinner,sun50i-a64-sid";

Are you sure? Limited diff context from your patch #1 suggests something
else.

Best regards,
Krzysztof

