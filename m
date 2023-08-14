Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1421B77C05D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 21:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231946AbjHNTHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 15:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjHNTG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 15:06:29 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C346310F2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:06:28 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-522bd411679so6185193a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692039987; x=1692644787;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T5HtRk7v9N5XEliCZizIOYoda+POCp5Lvz3Wvapa2NQ=;
        b=rDeKbTEZJKLZ9FP1roXmnxVr4jyE26Xz426JSxZdrzFWLD5ynNP3xL8sNjLcZU/yaL
         56uzL+AXlE3EnhrMYYJZN356xVRsL+DBftaWVa5MdwnNPtTB/06e8PaKrxHHpwMVfRfM
         Dsp69t/qPIE2on4qrEYQZfSRtWSPiRVAM5a887sF+w+hBCVqnycbtdnYngB+lHxLLy46
         QaSiAGaZeqwj0iZ2S/TTfBYlt+kgL/KVZOr09/XGuys4tU09IOhFHylGoMYHVXxrB+IS
         6IUxT0Z2anepZ/wN3DbVMWHvkX/h95uHAqig2E2Nmj97puU6DWSdv2Q7TercqwaTXKrk
         e26w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692039987; x=1692644787;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T5HtRk7v9N5XEliCZizIOYoda+POCp5Lvz3Wvapa2NQ=;
        b=ZCjRgU2OD8dqmOhqd+5bQZxcmqYYAnDC0gnmjHLfFu4fnuHl/HbBiSO//ocGrvdOZE
         4gIVABzUfQqZS8QPpIzihwFmat96arRkOmAOoKxV+ft2dgqf2YI+lq2XQjyDnVrTit7r
         dqJ7K1ovJegGMG4gcRB3JJ3XcCaLxOZSnsgkBz8yHOpCjg/+KxxxNVLWotRQcs6EFatY
         dTE6ok+f8n9pRSe/6QA1spBbZdGpSji6lEU0fiJTHh0+y5J1UGM563jb5imwuA0K/ba8
         luqkcL0Vco/6qShJYXayOdVzJfGTO/mMtFptNHw6WEzQHiFDq4W5vRmGUCADC+n9KnIZ
         wDZg==
X-Gm-Message-State: AOJu0YygaNi2SCDve24FXmNnI9IB+0f6kp02tb+IlDgSaIj5n1DJQ+Uf
        bIAJ7/+V16q7xWDlgWpO5l+l3Q==
X-Google-Smtp-Source: AGHT+IFHiepWq3vTDb+HRBkxRdAsLmYtndO/QQpUJgvVSY+3A1b+srlVoCwN0ixgeEioddUXasf1pA==
X-Received: by 2002:a05:6402:792:b0:51d:fa7c:c330 with SMTP id d18-20020a056402079200b0051dfa7cc330mr8460833edy.26.1692039987311;
        Mon, 14 Aug 2023 12:06:27 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id t8-20020a056402020800b005236b47116asm5862939edv.70.2023.08.14.12.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 12:06:26 -0700 (PDT)
Message-ID: <fae2d136-28e3-d3a1-c789-8552e8f59a15@linaro.org>
Date:   Mon, 14 Aug 2023 21:06:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/5] dt-bindings: mfd: syscon: Add compatibles for
 Loongson-1 syscon
To:     Keguang Zhang <keguang.zhang@gmail.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>
References: <20230812151135.1028780-1-keguang.zhang@gmail.com>
 <20230812151135.1028780-3-keguang.zhang@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230812151135.1028780-3-keguang.zhang@gmail.com>
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

On 12/08/2023 17:11, Keguang Zhang wrote:
> Add Loongson LS1B and LS1C compatibles for system controller.
> 
> Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> ---
>  Documentation/devicetree/bindings/mfd/syscon.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
> index 8103154bbb52..c77d7b155a4c 100644
> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
> @@ -49,6 +49,8 @@ properties:
>                - hisilicon,peri-subctrl
>                - hpe,gxp-sysreg
>                - intel,lgm-syscon
> +              - loongson,ls1b-syscon
> +              - loongson,ls1c-syscon

It seems each SoC has multiple syscons so using the same compatible is
wrong. Different devices should have different compatibles.

Best regards,
Krzysztof

