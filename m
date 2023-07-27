Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04DB0764DE4
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 10:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232594AbjG0Inc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 04:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234526AbjG0Im5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:42:57 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CB6346EA
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:26:11 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5221f3affe4so831934a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690446360; x=1691051160;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=swASYsLeNFQfktebQb18z1d8WQd7Vaanta+bt2MXp7w=;
        b=kI9e5+lVG0emMWHDhAXj4/rhBAIjrJ4UPuIm4IrXTcUes2uh4/Gd468gxTcgn4mi5K
         2+btD6aKBnqC+IkT8RUQJeCt+2FXS+MlKOIoTZBLYBYBjk28ADPFF+OxO6zL6QpfBz8R
         AlPy3qxneccFU6NIzTC2yekUk+nKJ2eQR485MKucGRb4voxPkgpRooTrWF86X1WTLX47
         lE9qp8ZB0FSe5ayZYUoVD2uSlE/VhZ6GLp7v6EMUAhhzAkGBgankyouTiLa8Voo9lsOR
         /kiUxDGj2nwi4d60ylnFXoykXYSXL2wfu3ZcY4He8y1Y6ZvK7PArpA5Tj+5LLwjV3vQK
         nQsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690446360; x=1691051160;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=swASYsLeNFQfktebQb18z1d8WQd7Vaanta+bt2MXp7w=;
        b=aVnAHtoldoxrhrXqLFNWxZ9RIcJwA8huXgffSbfK0iPscPNaP/aJIS2HNpPfTQOhJH
         JdfZ3Nys1V/jEayObzr+AAFadVS1SJUOwTgM5J1CdVtvSXoQybWZqLGK0fYANAJ5rGTt
         tTx9jwiHUToCaM/rT5qqX/MG8ZwiAvu9ipypOCtzWzvQhi9dZNuEovrTFraeV0yh2HvD
         GBji9eddtiXsYhcV13ghVhfOBM92smgzX9RRwfnQfZWZQ309ZxPb4/LYayoBccFNlGut
         x8Pg38zcWDSxDYHJBloceiV8gSBicCylluyd8fA/n2nV2jX8V8TRWpI1ipLtIrFFPkYj
         gXvg==
X-Gm-Message-State: ABy/qLaOxoNSOHV0VZS+fmi4BF0Ic2La5w4QMtd5Ku3FkYyTKn3+Xt8c
        tbsyVD7uGBsQW1ksCEg2RsQM1Q==
X-Google-Smtp-Source: APBJJlEJ/GQVXhT5xKnIM4tesBNqLbRszRLhsFXvDtrblcChfvysJkoz1rfX7AE6+tqo0bA5KUEmFQ==
X-Received: by 2002:a17:906:76d0:b0:991:e458:d14 with SMTP id q16-20020a17090676d000b00991e4580d14mr1406247ejn.34.1690446360068;
        Thu, 27 Jul 2023 01:26:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id l19-20020a170906079300b0098e0a937a6asm484431ejc.69.2023.07.27.01.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 01:25:59 -0700 (PDT)
Message-ID: <d5e3aa31-1aaa-0f8a-12d2-20dc6ee94f1a@linaro.org>
Date:   Thu, 27 Jul 2023 10:25:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] dt-bindings: hwmon: add renesas,isl28022
To:     =?UTF-8?Q?Carsten_Spie=c3=9f?= <mail@carsten-spiess.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20230726152235.249569-1-mail@carsten-spiess.de>
 <20230726152235.249569-3-mail@carsten-spiess.de>
 <f8fdc8d7-6ac5-5e20-10ef-7417d79c1b91@roeck-us.net>
 <20230727093528.594ce3a7.mail@carsten-spiess.de>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230727093528.594ce3a7.mail@carsten-spiess.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2023 09:35, Carsten Spieß wrote:
> thanks all for your input.
> I conclude here in one answer:
> 
> On 7/26/23 18:14, Krzysztof Kozlowski wrote:
>> It does not look like you tested the bindings, at least after quick
>> look. Please run `make dt_binding_check` (see
> sorry i missed that, fixed for [Patch v2].
> 
> 
> On 7/26/23 18:14, Krzysztof Kozlowski wrote:
>>> +  shunt-gain:  
>> 1. Missing vendor prefix (does not look like generic property)
>> 2. -microvolt
>> And then enum is for 40, 80, 160 and 320.
> replaced with
>   renesas,shunt-range-milli-volts:

That's not correct unit in DT, so again please use -microvolt:
https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml

>     description: |
>       maximal shunt voltage range of 40mV, 80mV, 160mV or 320mV
>     $ref: /schemas/types.yaml#/definitions/uint32-array

And then drop this line.


Best regards,
Krzysztof

