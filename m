Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4967562A6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 14:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbjGQMXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 08:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjGQMXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 08:23:30 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0A7E4C;
        Mon, 17 Jul 2023 05:23:29 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f122ff663eso6921478e87.2;
        Mon, 17 Jul 2023 05:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689596608; x=1692188608;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sVqNfRjsiIYCh2syrD6lJFA4rvlIOlkMNpbFEJwYjlI=;
        b=eHGphcCtv+cNXSjHxh2VftOQjs4R+87gmt4SpBBGKPkQEjSgKBWJLIowfPrrdwcHpY
         4YAI6NMcxnSeSVSe08DbRb45zNoSa/W7XG4Jbmh6hNsHj1Vo3tEyURD3uLbi8nlNYLBC
         6MsRGhzv2PPn9U0HWn6K0mhj5Y1oDvuVOoW2usu+IkBk3Lgf/+MGXfEzdvbXur/Pa4ee
         zQ3ygYJyr3WooPaxS9oaPwTxQEkm1UVB8fb2mf35qSH6FAkoUc2Qi6jq8TB1orFgnTXD
         NnMR6eAkeuRcYcs26A9DP4CtjCP92ymIxVsNWzEu2h6nV/bKlWatprqiLhVC9kJLeYqu
         AZuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689596608; x=1692188608;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sVqNfRjsiIYCh2syrD6lJFA4rvlIOlkMNpbFEJwYjlI=;
        b=D/oSxYkgVMTt+7MbXqntizuyypi/2NxNl5yPyvNY0LDCYG9U1g00L1UzsBmwbQmGbm
         AG1uzHrgKw3wj4J6lLEf1KQQhdoaE7p4gf5Lef09aUawSrx5A7giy6eMUVLoD/xaeeD9
         d/dJSZ6snL/DU6jV1QlfTCC23RhMEVrjMSj+iIMgXDXeEKdPs7Z2pcyEaX2kaMRbiv1u
         Xfd+fPQUNDipCwGIm7syVTL0vgHz2GIQAAiq7+kgy0sv8HDkZCxm9kH9NdQP4K5tTvaz
         FueM/05xfqpEzDkC3tItFRFpqhNp90QSFQlBWYU/bQzPQ3y5MtP09/N79RVobkkUZnna
         d6oA==
X-Gm-Message-State: ABy/qLbMcvKnfLjWJgpjArjsl5Agg/eWkSIE04/yVgNRqPBH/WGrKTR0
        jHhTb70EyV0bt1u79QvcRTk=
X-Google-Smtp-Source: APBJJlFXDDTv9a4VrKTlnTEXqqxmTD1PhHVIngzaKnIHpLM28z8emGQQr3cnFOm/h5F9Hm1Jovf4sg==
X-Received: by 2002:a05:6512:31d2:b0:4fd:b1f6:b6cb with SMTP id j18-20020a05651231d200b004fdb1f6b6cbmr4055607lfe.26.1689596607439;
        Mon, 17 Jul 2023 05:23:27 -0700 (PDT)
Received: from [192.168.4.4] (host-95-237-109-246.retail.telecomitalia.it. [95.237.109.246])
        by smtp.gmail.com with ESMTPSA id m18-20020aa7d352000000b0051a4fcf7187sm9906971edr.62.2023.07.17.05.23.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 05:23:27 -0700 (PDT)
Message-ID: <72df284b-66dd-2deb-13c2-cc0c9f4105cb@gmail.com>
Date:   Mon, 17 Jul 2023 14:23:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Andrea Collamati <andrea.collamati@gmail.com>
Subject: =?UTF-8?Q?Re=3a_=5bPATCH_v2_0/2=5d_add_mcp4728_I2C_DAC_driver?=
 =?UTF-8?B?4oCL?=
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        Angelo Dureghello <angelo.dureghello@timesys.com>,
        Fabio Estevam <festevam@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <0414e2e4-a17d-3435-e9e7-35b110233a6d@gmail.com>
 <46bccbca-1343-aed4-4dfe-eb5182b8f6a1@linaro.org>
Content-Language: en-US
In-Reply-To: <46bccbca-1343-aed4-4dfe-eb5182b8f6a1@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/23 09:17, Krzysztof Kozlowski wrote:
>>> Shouldn't this binding be just merged with existing mcp4725? Are you
>>> sure it's not similar device, IOW, are you sure you do not have vref supply?
>>>
>> Unfortunately they are not that similar. MCP4728 has two vref choices:
>>
>> - Use Vdd (power supply) as Vref
>>
>> - User Internal 2.048 V Vref source.
> Exactly the same as existing mcp4726, so what is the problem?

MCP4726 has 2 separate pins, VDD and VREF that can be both used as external Vref depending on configuration.

MCP4728 has only one external vref pin, VDD pin. The other vref source is internal and fixed to 2.048V.

Furthermore MCP4728  has four independent channels. For each channels it's possible to choose whether

using VDD (External VRef) or 2.048V (Internal Vref).

Best regards

            Andrea


