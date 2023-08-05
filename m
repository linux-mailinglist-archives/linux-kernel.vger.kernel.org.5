Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F69771258
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 23:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjHEV1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 17:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjHEV1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 17:27:06 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B3E1732
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 14:27:04 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-986d8332f50so436489366b.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 14:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691270823; x=1691875623;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XYmKs/r5+qnBMKYTGb7/a+oBzyM+kHkQR7E0ZDX+neg=;
        b=ZO7VFtQLcJPq6O1VLsyXvJWfaeuDWHC/jwCjimzq4K8i2DB7xCw2Sr6bdZuz4zEYlQ
         Q59Vf94RQmc2h3ID9ccx3GdYbS4lBhcjKhdI3K2ddc3QqlH+f8hCv3odg959IJECy3/G
         FC1dvQCUqsj5X/b7s+br6adlkaR2PLH78Gk/i6mqagqwjzV/qGsGy5i33Ga21TM/k6Ql
         qsULcPmtq9yaNkxog+Vg0StUPUkQI7/7kpwdAmglzYHcvN2SftJmiR9wVxTnoD/q+tZ0
         X/u+Mv+9puCH8Kfih8zag8mMvJ/Fdx1NZolS6dxq5sADO+vo+ftVOPLOt2pu6S7KmG7+
         Wnzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691270823; x=1691875623;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XYmKs/r5+qnBMKYTGb7/a+oBzyM+kHkQR7E0ZDX+neg=;
        b=WSWQDY8HMrN8D0MNOzhxTiRM25dKI+ejFCDy+fRiHjUpwv8wSf0leT8FP5cwIUqt2I
         oXGspiZdJ8qKmAISHN8PIR+AkS9eqOABsAJI6wWmqzOMYXdT33vQ3MASO8GWD191xwDJ
         8JNvVURwBUds428jGZGetKK+8iDSM73bEnkmn30AZmBAajNxGgkA0uf2vgpPgJU2mXHY
         SLHCCyeApQ9i0jxemFMvEvkrovduccgOwl3mOPAAJjH0PynsAHUumTrQADEY8vRyKzq7
         827m1DFn3gGKNEdKQqzkUjUqqmbgg8ImlVxBulUF9Q6ci5VonExAIXgGaQPJZRl82w0R
         mc/Q==
X-Gm-Message-State: AOJu0YyXHDG0zWpTexmSSSaXN6oM6OZas/nUg9YCFidaFy9GJjnWCa1+
        U3h9JTc24O6Vlhrvv4j0QEeLuA==
X-Google-Smtp-Source: AGHT+IFodzuEVQ0Ex6VutG7AL4gs35Vooe9mqXvY70JdGuyVJHlW6VwfaEn6OBQT7825oJDqb1cjrg==
X-Received: by 2002:a17:906:8a49:b0:977:befe:d888 with SMTP id gx9-20020a1709068a4900b00977befed888mr3834438ejc.13.1691270823115;
        Sat, 05 Aug 2023 14:27:03 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.245])
        by smtp.gmail.com with ESMTPSA id c24-20020a170906529800b0099ccee57ac2sm10945ejm.194.2023.08.05.14.27.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 14:27:02 -0700 (PDT)
Message-ID: <822f63ef-d9e6-84f2-1a98-8a916ffaeb58@linaro.org>
Date:   Sat, 5 Aug 2023 23:27:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 1/2] regulator: dt-bindings: rtq2208: Add Richtek
 RTQ2208 SubPMIC
Content-Language: en-US
To:     ChiYuan Huang <cy_huang@richtek.com>,
        Alina Yu <alina_yu@richtek.com>
Cc:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <1690355592-10920-1-git-send-email-alina_yu@richtek.com>
 <1690355592-10920-2-git-send-email-alina_yu@richtek.com>
 <20230803063656.GA19124@linuxcarl2.richtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230803063656.GA19124@linuxcarl2.richtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2023 08:36, ChiYuan Huang wrote:
> On Wed, Jul 26, 2023 at 03:13:11PM +0800, Alina Yu wrote:
>> Add bindings for Richtek RTQ2208 IC controlled SubPMIC
>>
>> Signed-off-by: Alina Yu <alina_yu@richtek.com>


>> +    
>> +  richtek,mtp-sel-high:
>> +    type: boolean
>> +    description:
>> +      vout register selection based on this boolean value.
>> +      false - Using DVS0 register setting to adjust vout
>> +      true - Using DVS1 register setting to adjust vout
>> +
>> +  regulators:
>> +    type: object
> Just curious.
> It seems this PMIC only support buck/ldo ouput.
> Since Krzysztof already reviewed it, not sure whether to group it into one node is common or not.
> AFAIK, if there's no more function included, to put all on the top level may be better.
>> +

Indeed we tend to avoid empty nodes just as a corresponding part to
Linux device.

Here, I don't know Rob's and Conor's opinion, but for cases of having
more than 2 regulators, having "regulators" node makes sense to me -
nicely organizes that piece of DT which can grow quite big. I can also
live without the "regulators" node.

Best regards,
Krzysztof

