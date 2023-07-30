Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610E87686EB
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 19:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjG3RzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 13:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjG3Ry7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 13:54:59 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D277AB3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 10:54:52 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-98dfb3f9af6so616564966b.2
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jul 2023 10:54:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690739691; x=1691344491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mbjS6TBC9NtU6oekBePBL31Nw/0x/d6yu4TOb6mnKIY=;
        b=P6jbYQ5csvD+4BbInxE1FPGjPTs2AnewX7WnsbjMJJTq1EGfetuG3xSy0ZMuXtqCJ3
         o9AoI1/Lw/WQKNpVpn6emK3roLzIW+M7xKJ5eBsnY93SBI0uUd2XF2jERi7d5g9NdzzF
         KbHkXXv8jBA5YtV/6F2dpt6+44XF/NjeovU8WmQqfZ1LnjvBORzorbZoI4SvePFazmMV
         WbG9QJ5j4f6RIz0GG0k285iwJDjNxAKLEolpuk9RD+r0d6Y7U6wmLc5PBPizOp+SkLCc
         CjuOvYnzSY5xhj1flC3DiycTNUatTKTkPYl34xm6+SmW8rO4K/jdz09gOQIZMdKX/NLd
         eSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690739691; x=1691344491;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mbjS6TBC9NtU6oekBePBL31Nw/0x/d6yu4TOb6mnKIY=;
        b=VkmXP5vfjquWmsd8nIyExOzzTgWJrrwAZVZWgxDjbwmoPztJwy7UAmi7akFoWjHkbm
         T37laJKm1JuxU/ogEpkvNqbpAgj6m8uS4dfVYopWigIBW+rGgzalh5tj2WJ5dFi+IWUU
         WLSKoqCXBj9iOFrVLrPBgN85mhZ0pI5K9MEwvxc9Bj+2sHUYpWBda69NQQfQdBFBHuzH
         xNK+m6ctr7tCdgWAlQE1Pxc4Cl7XLcXeOkJOQXaBLC7fvaqIqPYH/DFRijOUUG9YjRJE
         0pmi+oKDfkX9pKVZdSRljdhJoh19l93VPab9T9SMUfbTcXMAODjAI2lCcoj6c1EkA6vw
         TYUw==
X-Gm-Message-State: ABy/qLa3K5rY1+FoSbB4NzaTN2QjApr6eHlj19KlruJB7MLg/wNDZYev
        kJgXV636fsH3VFb7PsrhlNUyFw==
X-Google-Smtp-Source: APBJJlGKotrJF4ynR3yW3bafZKtRVjvSfy65pHmi1rA3GyhmcmsJZikumlPXSdF9eBN8iCEA/B9qfA==
X-Received: by 2002:a17:907:7711:b0:99b:d1cb:5add with SMTP id kw17-20020a170907771100b0099bd1cb5addmr5645098ejc.35.1690739691213;
        Sun, 30 Jul 2023 10:54:51 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.183])
        by smtp.gmail.com with ESMTPSA id t7-20020a1709063e4700b0098d15d170a0sm4875349eji.202.2023.07.30.10.54.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Jul 2023 10:54:50 -0700 (PDT)
Message-ID: <acd8e4ea-0d8f-3dc2-16ef-4c1deee281d8@linaro.org>
Date:   Sun, 30 Jul 2023 19:54:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH RESEND v2] dt-bindings: sound: gtm601: convert to YAML
Content-Language: en-US
To:     David Heidelberg <david@ixit.cz>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, - <kernel@puri.sm>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230730115150.38887-1-david@ixit.cz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230730115150.38887-1-david@ixit.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2023 13:51, David Heidelberg wrote:
> Convert GTM601 binding to the YAML format.
> 
> Signed-off-by: David Heidelberg <david@ixit.cz>
> 

No need for blank line between tags.

> Cc: kernel@puri.sm
> ---
> v2:
>  - add #sound-dai-cells
>  - put kernel@puri.sm into maintainers
> 
>  .../devicetree/bindings/sound/gtm601.txt      | 19 ----------
>  .../devicetree/bindings/sound/gtm601.yaml     | 36 +++++++++++++++++++

Filename like compatible, please, so option,gtm601.yaml

>  2 files changed, 36 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/gtm601.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/gtm601.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/gtm601.txt b/Documentation/devicetree/bindings/sound/gtm601.txt
> deleted file mode 100644
> index efa32a486c4a..000000000000
> --- a/Documentation/devicetree/bindings/sound/gtm601.txt
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -GTM601 UMTS modem audio interface CODEC
> -
> -This device has no configuration interface. The sample rate and channels are
> -based on the compatible string
> -	"option,gtm601" = 8kHz mono
> -	"broadmobi,bm818" = 48KHz stereo
> -
> -Required properties:
> -
> -  - compatible : one of
> -	"option,gtm601"
> -	"broadmobi,bm818"
> -
> -
> -Example:
> -
> -codec: gtm601_codec {
> -	compatible = "option,gtm601";
> -};
> diff --git a/Documentation/devicetree/bindings/sound/gtm601.yaml b/Documentation/devicetree/bindings/sound/gtm601.yaml
> new file mode 100644
> index 000000000000..e81a6aa75522
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/gtm601.yaml
> @@ -0,0 +1,36 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/gtm601.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GTM601 UMTS modem audio interface CODEC
> +
> +maintainers:
> +  - kernel@puri.sm
> +
> +description: >
> +  This device has no configuration interface. The sample rate and channels are
> +  based on the compatible string
> +

Missing $ref to dai-common.yaml

> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - const: broadmobi,bm818
> +          - const: option,gtm601
> +      - items:

No "items" needed here, just use enum.

> +          - enum:
> +              - broadmobi,bm818  # 48 kHz stereo
> +              - option,gtm601  # 8 kHz mono

This does not make much sense. bm818 is either compatible with gtm601 or
is not. Cannot be both.

> +
> +  '#sound-dai-cells':
> +    const: 0
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    gtm601_codec {

No underscores, generic names, so "codec" or "audio-codec".

> +        compatible = "option,gtm601";

Add dai cells also to the example to make it complete.

> +    };

Best regards,
Krzysztof

