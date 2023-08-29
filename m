Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBC278BE7C
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:32:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbjH2Gbp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjH2Gbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:31:32 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DE4107
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 23:31:28 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-99c353a395cso513887666b.2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 23:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693290687; x=1693895487;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EbTpS2DfO4MuL752ysd/X26Nj6VhGdHkbTx7pRzKQP4=;
        b=Brtqq9vrvIv6TCQ41miOCtcM2e4xNbsKWLFVR+KMqllSzTv/n2o8omRM6UebQFjTlG
         PWN9eIH8idZiVoFP1DWuje/qjwPwAQRyc1BygoRTflWC6TjPsahO0pasmPgQmQy0bwho
         vrMqnL/lpU+RL7tQ8/NomBCjPXlWvTEmfWOknocgV+Xo0NIVZHJlt4KYCFkgLqYcF3Qh
         rXWT122+hBo2gu1EINYd8rDyhUPFTZCE5YXbhAHrlNRawnNlvIS3cCMZwtk9uFyRaN37
         JOI5v2Q0XgP33llNEKooRraq6RZw6HF8lzNzpuaTw67/wq868+GffJ2AuO/J2ymGavun
         Ax9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693290687; x=1693895487;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EbTpS2DfO4MuL752ysd/X26Nj6VhGdHkbTx7pRzKQP4=;
        b=XVajxrRNYwp6KitZv53O+0TqY0OuUvHo9Lz0cYdWJnZRxVzrRS4OFB9XGdVGatCl8V
         cN3vAEnAiCew9FlaGdq9z9MwgI9eYoBam7hNX0dFHXhxZ5+nctcT0yMc0KRXfgCNh7fH
         iC9Ipve83HP+Ri7WczmfnBRIwWEGEuWrcUYgn/MU0/apo7t3L62L4kcWlVbXPBQ14Y1g
         y4yJYgAV/Nak8PC4dsZ40J/JV50QfQmeCrlfzokuZck0J+rie1fTqOQVlrALUNCY8I8E
         Fw4stCBJCaN22cDWXIlS0ZzcPCwrU6/A8XDJfCvsHIPVdYHc367/NuLH53qBtDP0KYxo
         vhvg==
X-Gm-Message-State: AOJu0YxZLaL3DCG8GmeO1GoIIiTG0qPgG5K8zqGA1vqgSyjxNY/s6l3+
        BxwkAe8RljRD1hp2Zx0rqEhjMQ==
X-Google-Smtp-Source: AGHT+IHBIqEartLFtfu65129YrZ7at2izi8lIOD0bLViZXVYyy9xn5D+IclskmbAaHFG/r/VTASyCw==
X-Received: by 2002:a17:906:5349:b0:9a1:e011:1a62 with SMTP id j9-20020a170906534900b009a1e0111a62mr12417073ejo.38.1693290687299;
        Mon, 28 Aug 2023 23:31:27 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id uz16-20020a170907119000b0099b6becb107sm5598021ejb.95.2023.08.28.23.31.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 23:31:26 -0700 (PDT)
Message-ID: <3eec4ac6-83a4-1f79-9b3e-569b21765d87@linaro.org>
Date:   Tue, 29 Aug 2023 08:31:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v4 13/32] dt-bindings: usb: dwc3: Add
 snps,num-hc-interrupters definition
Content-Language: en-US
To:     Wesley Cheng <quic_wcheng@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        catalin.marinas@arm.com, will@kernel.org, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, bgoswami@quicinc.com,
        Thinh.Nguyen@synopsys.com
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org, alsa-devel@alsa-project.org,
        quic_jackp@quicinc.com, pierre-louis.bossart@linux.intel.com,
        oneukum@suse.com, albertccwang@google.com, o-takashi@sakamocchi.jp
References: <20230725023416.11205-1-quic_wcheng@quicinc.com>
 <20230725023416.11205-14-quic_wcheng@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230725023416.11205-14-quic_wcheng@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2023 04:33, Wesley Cheng wrote:
> Add a new definition for specifying how many XHCI secondary interrupters
> can be allocated.  XHCI in general can potentially support up to 1024
> interrupters, which some uses may want to limit depending on how many
> users utilize the interrupters.
> 
> Signed-off-by: Wesley Cheng <quic_wcheng@quicinc.com>
> ---
>  .../devicetree/bindings/usb/snps,dwc3.yaml          | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> index 50edc4da780e..cc6012e922e0 100644
> --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> @@ -376,6 +376,19 @@ properties:
>      items:
>        enum: [1, 4, 8, 16, 32, 64, 128, 256]
>  
> +  snps,num-hc-interrupters:
> +    description:
> +      Defines the maximum number of XHCI host controller interrupters that can
> +      be supported.  The XHCI host controller has support to allocate multiple
> +      event rings, which can be assigned to different clients/users.  The DWC3
> +      controller has a maximum of 8 interrupters.  If this is not defined then
> +      the value will be defaulted to 1.  This parameter is used only when
> +      operating in host mode.
> +    $ref: /schemas/types.yaml#/definitions/uint8

You did not respond to Rob's comments before sending this patch. :(

Best regards,
Krzysztof

