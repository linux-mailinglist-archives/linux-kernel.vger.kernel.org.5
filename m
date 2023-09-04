Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D152479129A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348406AbjIDHxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjIDHxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:53:18 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C297ED
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:53:13 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-52a1ce529fdso1443864a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Sep 2023 00:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693813991; x=1694418791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hKg+j0ij0bj6tL0Ubk+HvKTshP5Zvzo1++prZoHQU4M=;
        b=Bv0Cy/Cv4Lz9Mv/lKx/1cWP7Cwa4jvYVvtyPanjJQMhAuHzEc+jPdPCGA7/zg/MoHb
         Fh03ltRwp2HqkAqR8FWnOjO+QikhymMNJB+gT2Dvj0zsaM7V1J8gQZEv5+HY3rtlD6ZL
         YpuSJ8K5RC0DYAo2z05SLwF+BsYT1seXXawb6Y42RjXvJxJzo5IYmOV3uLBzZXioxhrE
         5QGtUp25Wn3HtL6iN5vQFfwsU/itXmtJ3dYCGU/zipG31Sg/krqbz7vTUFXX5IYtn3S0
         L/8+FGyo3iWiXtEps6Dt4bHlvgjI4sRHEu2O3Sf5OLLlwVR4/nrlG0RiH/C5j4QJ3nwB
         xf5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693813991; x=1694418791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hKg+j0ij0bj6tL0Ubk+HvKTshP5Zvzo1++prZoHQU4M=;
        b=HdxDE5kPcQxzFBsnAKzaXWjEHmJka0eTzHkLf34+eO2HXgqftsBPAG0Ulw4um+bfHS
         LMAtzyThj/zOYuC/vvMpPWB9KO8ekq46fFLy4UeM+E+v8YurOei08CGw43OynkbjFMP9
         F8ZRvtAiSMqYawIPJVgQ1hePK/wgTC0nFbrjjgaXrcipUKRZAzEEH01z/yCLnUz66e6R
         lV4oT1wNeDulpm5d9f4RCkNj6dCP2BI7+gDdQ9kbFIS2sBXq5h6/Yy/ZSZoq7b+XBe/c
         OgGlTGX7PexwZTZA1nhOhqeRB5Lg5zFaRlBifKyyoFqsUAhKurnjjkFfg8z+qMCIXDVn
         fTmQ==
X-Gm-Message-State: AOJu0YwTt99UVZW0CaRGC8Bpk/fzxPaHuQUPUBShM61XNxKuDIrPFsC1
        Ep87fPejAt1J5uPB+B/VF/yn7A==
X-Google-Smtp-Source: AGHT+IG51yyXlEkoIHVtZBQ6BjDgQ9Ot4st5+o3nOo3wNnbxIkT/ovnRE6ZUUWjLC2qouRxMzCXnNQ==
X-Received: by 2002:aa7:d982:0:b0:525:5ed2:abed with SMTP id u2-20020aa7d982000000b005255ed2abedmr6686818eds.30.1693813991487;
        Mon, 04 Sep 2023 00:53:11 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id w25-20020aa7cb59000000b005222c6fb512sm5484731edt.1.2023.09.04.00.53.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Sep 2023 00:53:11 -0700 (PDT)
Message-ID: <4b88a31a-bbff-21b5-a53d-19a3e66e2f3e@linaro.org>
Date:   Mon, 4 Sep 2023 09:53:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v11 5/6] dt-bindings: media: wave5: add yaml devicetree
 bindings
Content-Language: en-US
To:     Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     linux-media@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        kernel@collabora.com, bob.beckett@collabora.com,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com,
        nas.chung@chipsnmedia.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221207121350.66217-1-sebastian.fricke@collabora.com>
 <20221207121350.66217-6-sebastian.fricke@collabora.com>
 <48d60bd0-4de1-4a5e-eca1-1f8a9303cce0@linaro.org>
 <20230904062502.qtajep4zyslnouxv@basti-XPS-13-9310>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230904062502.qtajep4zyslnouxv@basti-XPS-13-9310>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2023 08:25, Sebastian Fricke wrote:

>>> +  sram:
>>
>> Missing vendor prefix.
> 
> After some discussion with the the manufacturer of this CODEC chip, the SRAM
> is not fixed to the CODEC chip but instead part of the SoC, thus the
> vendor can vary. It sounds like the policy is to use the vendor prefix
> of the SoC, that was used for upstreaming. But that policy sounds a bit
> like a potential for future confusion to me, so I wanted to ask what you
> would like to see. The SoC we develop on is from TI and the CODEC chip is from
> C&M, so I could either call it: `ti,sram` or `cnm,sram`

I meant vendor prefix of this device. It does not matter what SoC is
that, however it turns out it is already a generic property, so no
vendor prefix is needed if you use the same property - phandle points to
a node which is a sram.yaml.


Best regards,
Krzysztof

