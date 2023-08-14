Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B8077B3B8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233694AbjHNIQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbjHNIQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:16:34 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4748AE4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:16:33 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-99c353a395cso540637766b.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692000992; x=1692605792;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4t56tuRVfyB2+mdu458cVXMKjiaGhseXmQMyq/iUziM=;
        b=mtWMV+/h+8x0WnM8tMrxxxq9MpaP6L8/wiBOJiYUO93kLb9qCBAWaasX9ZRzcS8B+k
         nxFflBfQyfiW6PlGczZXAtux/t+bh6yxC1s/5xdmqRp7K1d30LK2S7V+1/j+FBBQ1mIP
         wDg3dcYFBTmqMFdOLe4i8/qF+ZBLqrwB6uJ47bbUSmruKcIM8vdHIB71jRWqszt5PCul
         nsH4W5lkHVRbzviyNpp8jpoYRoBxSfEh2q4tagZF3HGtHYnfysxB6WN75WExXfCSdxG9
         0VMhnDRQ2Akz2wSklkJTKjhW0BeTMbsAC4+7LauTrAkasB16ixxcJ8vYVr9CpDWNHK7J
         6kKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692000992; x=1692605792;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4t56tuRVfyB2+mdu458cVXMKjiaGhseXmQMyq/iUziM=;
        b=GJoWuSvMTRtXv9zQ2oGFCcANTilyjj7HJOvW/Xa5tHaYtyk7/ixQm5Ku5rOMaQBPKG
         /vC3E0z44uoV1Rbwbah7SjGZCmgMaGjo7+4IE1RWGcRKRY1X7uUkx6wHEqtFaryE3kCk
         fGGwLWKp2vfL+ZTf1u7K450Og6izT/WfRJ9nvZ3NZrk3Eam3o5QVe9UTpVvg1DB0/uIc
         UtYSRcQA5GEb8rf9DW93EFnCP7oDqTT7YqVu14iN67p5AVGD0oLnQ38lk9TCg9somHfL
         H9uYXp/gDhUqg7ngtDrOo5qKkWBCi2ocayTlmS26xsMHgoGd1hnyxXXVwtj3nRfXS10i
         79Zg==
X-Gm-Message-State: AOJu0Yz9B7IwZELzbRutd/uMZnFH7QC38Y/jUI1ywESYrMbozPY2aq7z
        wDxYGxMDRG8YfD5aIDLObFPkHw==
X-Google-Smtp-Source: AGHT+IFn+H2H4jU8i7W8+7puC5WmWrCi3NGpKZsQ7vGNm8EX0LJufiSISjSM1Qzl3zXCZIMZe4SdYg==
X-Received: by 2002:a17:906:cc52:b0:98d:e605:2bce with SMTP id mm18-20020a170906cc5200b0098de6052bcemr6479021ejb.46.1692000991868;
        Mon, 14 Aug 2023 01:16:31 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id h10-20020a170906854a00b00984822540c9sm5384180ejy.96.2023.08.14.01.16.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 01:16:31 -0700 (PDT)
Message-ID: <36dbb926-0694-f84b-44dc-9608537024b5@linaro.org>
Date:   Mon, 14 Aug 2023 10:16:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 6/6] dt-bindings: perf: Add Marvell Odyssey DDR PMU
Content-Language: en-US
To:     Gowthami Thiagarajan <gthiagarajan@marvell.com>, will@kernel.org,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org
Cc:     sgoutham@marvell.com, bbhushan2@marvell.com, lcherian@marvell.com
References: <20230812142518.778259-1-gthiagarajan@marvell.com>
 <20230812142518.778259-7-gthiagarajan@marvell.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230812142518.778259-7-gthiagarajan@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/2023 16:25, Gowthami Thiagarajan wrote:
> Add binding documentation for Marvell Odyssey DDR PMU.
> 
> Signed-off-by: Gowthami Thiagarajan <gthiagarajan@marvell.com>
> ---
> 
> v1->v2
> - No change
> 
>  .../devicetree/bindings/perf/marvell-cn10k-ddr.yaml      | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml b/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml
> index a18dd0a8c43a..a435cbf4aea0 100644
> --- a/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml
> +++ b/Documentation/devicetree/bindings/perf/marvell-cn10k-ddr.yaml
> @@ -11,10 +11,15 @@ maintainers:
>  
>  properties:
>    compatible:
> -    items:
> +    oneOf:
>        - enum:
>            - marvell,cn10k-ddr-pmu
> -
> +          - marvell,odyssey-ddr-pmu
> +      - items:
> +          - enum:
> +              - marvell,cn10k-ddr-pmu
> +              - marvell,odyssey-ddr-pmu
> +          - const: marvell,cn10k-ddr-pmu

This is absolutely bogus and does not make sense.

marvell,cn10k-ddr-pmu is not compatible with marvell,cn10k-ddr-pmu

Questions about actual name of SoC remain...

>    reg:
>      maxItems: 1
>  

Best regards,
Krzysztof

