Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04F2C766BFB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:44:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbjG1Loi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234807AbjG1Log (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:44:36 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDFA3AB6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:44:35 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-3174aac120aso2037731f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690544673; x=1691149473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DtqrNXvAqbGnaFK11beQhojgaNwjRzpnOxCudKS4U2A=;
        b=gbuLTQF6hBW6TizMdQO6/NLNVTDxN+mlQ2Vxjli3wD7IhNmQctyZmLCVOPMAMhxznv
         zvkKnFhsWBXLNhiFHarqWWXSMetgX/+8oJuTzCDCSdjBtBvC77qk/VHq7RjmquOQqk1I
         1FqBEI0m22dfXpsLkTb827+PBD/i/t28Azgu9tev/4s4cFzFpLwk9+8N5bkAaoKPJidK
         Ei8pobXVwGaFPt4sn8fnybGqzhI/dCYSAPAHBUxg3Zr6n/LYEPnFFegACQBSjzPe27OW
         efzS5/T0IjsdpqTk5iHnmxkC7QmwILb0qUa3qAxUsZCfNCroj9+O9HiJVi8ecpHZX1ce
         XzdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690544673; x=1691149473;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DtqrNXvAqbGnaFK11beQhojgaNwjRzpnOxCudKS4U2A=;
        b=PTLHTCAKbC1lJRpl6KvcPFt9IK3Uli/CpSMDxN/fJTZXFDJYrLf+Cjy4r+rfWqXlK3
         22J6jfwx/ATzzvXDUbwCtnxQ+u/3uSpvtKWi3no0Zl4jzgXvjYgR5XCAXhLwry/B3K1N
         +oW2qsOHPxhJg3cuD6RA6D5JaZBKpsiPC4nDYpHbIP1Iz7s1Ti/sra6ddpS7BkAd7FMF
         /BjjsK0x+KkUdJ5IX5ze+Op4n3p26ZcwOWYOt9QxND297I2M3BugNBXTlIjeV4WeVVws
         68pO0XsNkMBiRFPLNIcYJ5WDhumkKiVBXgeDv3/PQBQMqXjjLi0q53sLFnJcrrmWAu/U
         FPxQ==
X-Gm-Message-State: ABy/qLYV4GwLQQHN8btM2hc7jJmGvODbpb+5AZC+R7vAOXO3d1sAc7jV
        qOVJEI55fROPvbYwEpplw5jkmg==
X-Google-Smtp-Source: APBJJlHYs+xENUPYc1+K2ZgnFIU2Jzx2/+CtsWQ5tAoIjmJR8Eme6SfLjAQZhrp6VLYuMGplZGJwMg==
X-Received: by 2002:adf:f291:0:b0:317:636b:fcb1 with SMTP id k17-20020adff291000000b00317636bfcb1mr1364548wro.27.1690544673618;
        Fri, 28 Jul 2023 04:44:33 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id e5-20020a5d5005000000b00311d8c2561bsm4562595wrt.60.2023.07.28.04.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 04:44:33 -0700 (PDT)
Message-ID: <11947259-1e05-40dd-c20f-422bb649214a@linaro.org>
Date:   Fri, 28 Jul 2023 13:44:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 03/50] dt-bindings: net: cdns,macb: add sam9x7 ethernet
 interface
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, claudiu.beznea@microchip.com,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh@kernel.org>
References: <20230728102328.265410-1-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728102328.265410-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/2023 12:23, Varshini Rajendran wrote:
> Add documentation for sam9x7 ethernet interface.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/net/cdns,macb.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> index bf8894a0257e..c9840a284322 100644
> --- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
> +++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
> @@ -59,6 +59,12 @@ properties:
>            - cdns,gem                  # Generic
>            - cdns,macb                 # Generic
>  
> +      - items:
> +          - enum:
> +              - microchip,sam9x7-gem  # Microchip SAM9X7 gigabit ethernet interface
> +          - enum:
> +              - microchip,sama7g5-gem # Microchip SAMA7G5 gigabit ethernet interface

That's entirely different patch than before. Not correct also - drop the
second enum, because it cannot be enum.

Please provide changelogs explaining what happened in the patch. Sending
such huge patchset with changelog only in cover letter with very vague
description of changes is not helping.

Best regards,
Krzysztof

