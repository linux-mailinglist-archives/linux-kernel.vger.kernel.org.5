Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22344793D8E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 15:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240452AbjIFNVr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 09:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjIFNVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 09:21:46 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5276010C7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 06:21:42 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99c1c66876aso541135366b.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 06:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694006501; x=1694611301; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5VeKi9/ArJTcrdf/DJQWIeh6fMdLX32bOeVBSbYiaos=;
        b=husH/zp9/SSyhOM63F1EVjV+XCBnoKoDjcI+iK8KyBqsBYL2luTCLW+5cUG22a4lLT
         1f2uKHnAMr/UW5DWO1W6P5tx/FZTU3Tw4ZGXWi1rLxPUQ+1LFNMH3kWXp/pwRwilcVG7
         UiGjknjH/leEhAiBdlXAL+/M18svHuCJp04lyARD10+jwzOG5Ju2jSc2euNM8xW51hE3
         VG71LjtNPHDfItDDd0OLPoecA6vnlWuvyFj6sAwwgGbVAbvnx59OjE5Ai3fpj0eAQxAc
         D3vmZpOJ1IBcBj9BaA5JP75394d87Sluoo5NDQLoBAGNld/AJDPX7nWyXi1FsJ0/9DQ9
         agZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694006501; x=1694611301;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5VeKi9/ArJTcrdf/DJQWIeh6fMdLX32bOeVBSbYiaos=;
        b=IBZtlwnk8Dtyesnm89rPqP4El0zeILFRMpvjUnGPVkzxm5Y/spBmGecNprl5JaOkhE
         8XomdA5UglYz8oMUVwpLnWN2r1oRyrb3/kfLdm9JeyXVgoKINX/3C52Ext8HgBMAs19p
         CJDhEU+TDWD/+x7tsJwAO6FKB6gBb1QLFD87DVY0BI+FP71dGTEcayIznt+r6THakmQz
         PXoX7MxEPZf/xkRf/Vvq8blL1j17TnfgsYJQGBmPgADEE40bsbE6pXnXEct0N7f29qJZ
         4kmeO6wKjANMcYA/XrqelZV7xXkm7dvCVLeyY7QWYdl8xlCJH8e+egBVZcecQrJAmjBK
         /Ang==
X-Gm-Message-State: AOJu0YxOcZUILNNrsbbDSZyljfruce8KaGdEnJJWT898P8Lv/XIuHwsW
        FKH8M7Zhsuap/qsO9rMoVP2uaQ==
X-Google-Smtp-Source: AGHT+IHV10jiJH/3WC9ALJHJW1lfi34oo5lqmZPk3BL0t6juF8X5rY+MxuF2VkP3ZNWfJRtva7WsmA==
X-Received: by 2002:a17:906:1d1:b0:9a1:fb4c:3b65 with SMTP id 17-20020a17090601d100b009a1fb4c3b65mr2496168ejj.14.1694006500792;
        Wed, 06 Sep 2023 06:21:40 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id gu18-20020a170906f29200b0098f99048053sm9165893ejb.148.2023.09.06.06.21.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 06:21:40 -0700 (PDT)
Message-ID: <6ae8f584-63ac-2d41-c689-c49eefa19764@linaro.org>
Date:   Wed, 6 Sep 2023 15:21:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v2] dt-bindings: rtc: mcp795: move to trivial-rtc
To:     Javier Carrasco <javier.carrasco.cruz@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Emil Bartczak <emilbart@gmail.com>,
        Josef Gajdusek <atx@atx.name>
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230906-topic-rtc_mcp795_yaml-v2-1-f9bef40c99b9@gmail.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230906-topic-rtc_mcp795_yaml-v2-1-f9bef40c99b9@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2023 14:48, Javier Carrasco wrote:
> The current mcp795 bindings in text format do not support validation and
> are missing the optional interrupt property that is currently supported.
> 
> Adding the missing property makes the bindings identical to the existing
> trivial-rtc bindings.
> 
> Add maxim,mcp795 to the trivial-rtc bindings and delete current .txt
> bindings
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> The current mcp795 bindings in text format do not support validation and
> are missing the optional interrupt property that is currently supported.
> 
> Adding the missing property makes the bindings identical to the existing
> trivial-rtc bindings.
> 
> Add maxim,mcp795 to the trivial-rtc bindings and delete current .txt
> bindings
> ---
> Changes in v2:
> - Move mcp795 to trivial-rtc
> - Link to v1: https://lore.kernel.org/r/20230906-topic-rtc_mcp795_yaml-v1-1-de75c377b5b0@gmail.com
> ---
>  Documentation/devicetree/bindings/rtc/maxim,mcp795.txt | 11 -----------
>  Documentation/devicetree/bindings/rtc/trivial-rtc.yaml |  2 ++
>  2 files changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/rtc/maxim,mcp795.txt b/Documentation/devicetree/bindings/rtc/maxim,mcp795.txt
> deleted file mode 100644
> index a59fdd8c236d..000000000000
> --- a/Documentation/devicetree/bindings/rtc/maxim,mcp795.txt
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -* Maxim MCP795		SPI Serial Real-Time Clock
> -
> -Required properties:
> -- compatible: Should contain "maxim,mcp795".
> -- reg: SPI address for chip
> -
> -Example:
> -	mcp795: rtc@0 {
> -		compatible = "maxim,mcp795";
> -		reg = <0>;
> -	};
> diff --git a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
> index 9af77f21bb7f..ae4792bbde92 100644
> --- a/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
> +++ b/Documentation/devicetree/bindings/rtc/trivial-rtc.yaml
> @@ -49,6 +49,8 @@ properties:
>        - isil,isl12022
>        # Real Time Clock Module with I2C-Bus
>        - microcrystal,rv3029
> +      # SPI-BUS INTERFACE REAL TIME CLOCK MODULE
> +      - maxim,mcp795

Does not look ordered by compatible.

Best regards,
Krzysztof

