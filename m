Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9D3758F62
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 09:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjGSHoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 03:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjGSHnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 03:43:42 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A134626B5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:43:06 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 4fb4d7f45d1cf-51cff235226so1114575a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 00:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689752585; x=1692344585;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XrOde/q1m7wsJc0cQzdjZKMM/F9GgJQT4hPTs2X/dFI=;
        b=TjKvmcvcJjCizME7RnMlElhcT0DWN/+oqGOEIcvZP2LhXmClmdX6F+KzJNF8mjE+Ry
         ObHDxs30XpAz9rbN3h25BCYv++zu9nZIbf/JbYFFl4+3r+gGGDhNcNX/88gak9LDn79L
         lP+GM6aTgjQJq3VaZd+HX9gxyxDL5jnAMN+8tfzkg1Mk1KXIcK55DeBON1wWzKOhcL+o
         6xXm9RFqXAnUC/GOCvJlkFOdZC8juLkGE462W+c6bCn0uQwL+iUVhH8kQWYvJsW3xnj3
         4Qlk8IR9YSCb6x7KG5ygmvIJESNwDVF9UiOdEUKQBjWFsLtFDmGrRmr6bBY3i3Hgxgsq
         DXew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689752585; x=1692344585;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XrOde/q1m7wsJc0cQzdjZKMM/F9GgJQT4hPTs2X/dFI=;
        b=ldcBmtThyWCWlgOzGQ5aZ3BBTMg7+m8cP/VMZO3SzBCznV0ddQfhj80VsyAreR4Rg4
         k4BJmxPGlDn0ozorq5paVGFbRjPctTn6jZsK7FdEroaTeTcYRD+ukTS9rjK03hmxJLi/
         BzY1ozPzVfjpdo374SwK4imFeOIauPlEASkDi/lVYcaP5IbFT2B6AqjBumYFP4dSlTgj
         TmSwtFz+PdlWDjrKhXoDCk4FABI7KRsdalxlwaxnmHei+Bz42VbYg8ebmjqEfwz+q3mU
         Tf85TLHvzRxHvfK7Q3ij4FpHoaQ4e3p26KPN6O3vvWLJfZ99dfQnl+4gF9A4JaEDKv7b
         s/Jg==
X-Gm-Message-State: ABy/qLZWQMM6kSfKsZ4Sh5/D+Poz6Ggx0v2Mz/h0k9O0vBgetS5DDIww
        kFC0JjlBIV7rNnkfddPQxtiCRA==
X-Google-Smtp-Source: APBJJlG2x/jItQNIYIviF7th6RDrpRediAXSLO6Gr9qWlNnt+XbEb7yJd7YO91cheoL1oUO2nwPY8w==
X-Received: by 2002:a05:6402:50d0:b0:51e:4218:b91b with SMTP id h16-20020a05640250d000b0051e4218b91bmr1522766edb.1.1689752585190;
        Wed, 19 Jul 2023 00:43:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id k23-20020aa7c397000000b0051d9dbf5edfsm2324720edq.55.2023.07.19.00.43.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 00:43:04 -0700 (PDT)
Message-ID: <860fffab-3c48-027d-aa2e-b15fc8f7a760@linaro.org>
Date:   Wed, 19 Jul 2023 09:43:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 1/2] regulator: dt-bindings: rtq2208: Add Richtek
 RTQ2208 SubPMIC
Content-Language: en-US
To:     alina_yu@richtek.com, lgirdwood@gmail.com, broonie@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1689740741-29244-1-git-send-email-alina_yu@richtek.com>
 <1689740741-29244-2-git-send-email-alina_yu@richtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1689740741-29244-2-git-send-email-alina_yu@richtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 06:25, alina_yu@richtek.com wrote:
> From: alinayu <alina_yu@richtek.com>
> 
> Add bindings for Richtek RTQ2208 IC controlled SubPMIC
> 
> Signed-off-by: Alina Yu <alina_yu@richtek.com>
> ---
> v3
> - Fix some typos
> - Modify the descriptions for "richtek,mtp-sel"
> - Modify the node name to lowercase and remove underscore
> - Remove '|' from description
> - Remove "regulator-compatible" from property
> - Remove "regulator-state-mem" from pattern
> - Modify node name to generic one
> ---
>  .../regulator/richtek,rtq2208-regulator.yaml       | 206 +++++++++++++++++++++
>  1 file changed, 206 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/regulator/richtek,rtq2208-regulator.yaml
> 
> diff --git a/Documentation/devicetree/bindings/regulator/richtek,rtq2208-regulator.yaml b/Documentation/devicetree/bindings/regulator/richtek,rtq2208-regulator.yaml
> new file mode 100644
> index 0000000..2fc92e5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/regulator/richtek,rtq2208-regulator.yaml

No improvements here.

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

Best regards,
Krzysztof

