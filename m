Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29A8767240
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbjG1QoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbjG1Qnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:43:32 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA1CD19BA
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:43:23 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-977e0fbd742so316571166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690562602; x=1691167402;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6NGaB+Pl1EDrqiUyMnXrdffVFXV680hTeyR0STD0Bjk=;
        b=hlpUPgc3EoCdmqg67UGLVu7Q5NJSDLmomhbjKq8lPe1YfSODHlzy4k+t0eY3ojMhMp
         /tnkJClxgnu5T65lndJhC5WgvMTdSZpmarsVdqdg00SsGm8v6wrs2VX68JkwFeipaIAl
         tQyK05+bGsEKy1aivmk+4hHs0lbn1GERr3SmiwJ9svYwxC844OULo5SU6W4GDqsW5Vj9
         1wK4sgXKuu6PfioLFEMj/vkhVE4BG8vePIjyEJRRY79H7qaptOGLN6wXp/6Puw6UVp1P
         mGHNjWIC/jVrrZO7gfP3R9uftKz8QrozIfbzaBqjuKEXXeva11eQljYwhzoaI8tbR2uR
         Cp0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690562602; x=1691167402;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6NGaB+Pl1EDrqiUyMnXrdffVFXV680hTeyR0STD0Bjk=;
        b=E7e8sofGK6CwMGKUoLoZum4lzJ0nQQA6c3HVEAtANnorz+h5fBFpRBsvg57x7Iz9Rt
         WDuWg6NFYyjasTnJ0JpVM2HlS2ORn+K/UVKoK6H4Z4wkjhmPKC/R2HHQUmDb4+2BkJ7U
         xXyNSVFWgmBnL4CR8+7XSIHbOP1yKxmWrJrBDtpEBy3ekZveBLmkXU54txBqHGFMTefp
         nfgLLzxx+5glCumBG+0erJtF3K487SLJBrD6c/Nnps4ob22c6j2kEViuDIPPnkEwbT3O
         KaAwT3cmFRgQMpno9R8ycj2ctXObnx2TNBAjYq0L+aBFJ6UP66bC4f89o+URlzw030fo
         Owkg==
X-Gm-Message-State: ABy/qLZhUgTT9zEqGiPuMfcd0I1tfqXmGfXFvg1htZjRMVCrSw9AQmuD
        0TlNhLMALUa+jXjer9xB6yxdDQ==
X-Google-Smtp-Source: APBJJlEUnec0/HBInXzgL9HSAyAgX9jBaoQ4JqrlwiBFMaOQn8xKs9H4eOj+zc9H7oDlR3Vxa1Gcww==
X-Received: by 2002:a17:906:530e:b0:99b:8c6f:f3af with SMTP id h14-20020a170906530e00b0099b8c6ff3afmr2399890ejo.12.1690562602387;
        Fri, 28 Jul 2023 09:43:22 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id v23-20020a1709067d9700b00992eabc0ad8sm2245414ejo.42.2023.07.28.09.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 09:43:22 -0700 (PDT)
Message-ID: <f5305742-dc43-7e35-f380-0bf7be37c442@linaro.org>
Date:   Fri, 28 Jul 2023 18:43:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 15/50] dt-bindings: atmel-gpbr: add
 microchip,sam9x7-gpbr
Content-Language: en-US
To:     Varshini Rajendran <varshini.rajendran@microchip.com>,
        lee@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230728102529.266030-1-varshini.rajendran@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230728102529.266030-1-varshini.rajendran@microchip.com>
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

On 28/07/2023 12:25, Varshini Rajendran wrote:
> Add microchip,sam9x7-gpbr to DT bindings documentation.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

