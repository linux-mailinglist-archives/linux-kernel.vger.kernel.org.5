Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A17579BDBF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356174AbjIKWDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235981AbjIKJr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:47:58 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEB6E4A
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:47:54 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bce552508fso69005411fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 02:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694425672; x=1695030472; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hVBnqnB5rrJmJ9oxMSlJ3T1LMxyr5CXqSBdgSMAQNIg=;
        b=CYqus95YhPz6osXQpZzG5i/JV/gsLnwpNIVHDtPq3IG7IOUmKKPP38enRIDzOe961R
         UOV25kkQUFQOrXreIpB/X4Qbpn0QU+iDZlHaK4hvyVKilVOHjBWHRNROwdX78GIK1oDl
         xLT5bK38lYiv8ieuuvk4rpF4p6ta1dsIvr+6p4c23w+6FIoqi4+Nkd4chflpl5/0MvNv
         5SuWxvw45a3Co7qF0gGpZ8GLFt+SHGFuKApb5SLXq4cSfNYjxX+OQxxFLeMmtbKLs/MT
         y51lXjsgD9yINdmtA1N8BawhP6pmBCq4NoFRFkI0F3PddBvAdiSR0kCvQy5nfCuu3oc/
         +OWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694425672; x=1695030472;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hVBnqnB5rrJmJ9oxMSlJ3T1LMxyr5CXqSBdgSMAQNIg=;
        b=NnhlOCBRhOEsvi6xp9qB3dTR412T2irl+4sgLZl0EYDhnyjFi68U9N/KDXHlS8/elj
         OTKO6nTQIPnoGdSkT69/D7V6BdhijDZ9xaQOU7pOd7i74vyVXTPyHX4WqE5fDaVqh9PG
         mKXrI2cpFbz+W6yYZMre1mHH7+bp7MjmMhd/9E6Ua2VWKdheH+YOmCAIGKNLo3pFyZcu
         E7lVNhpvAhKfuwW7PLxxzeR5Xv2hmLFK9+4hOiJQWoOS1t+zgDFfctoVzFswTWws7d5q
         zIzdyB6TJj7bGcN5aDkFz/L09lRrZS+9ihvQzcSQe8Br4peJRmZblANCqPl8MfDVZ10m
         gShA==
X-Gm-Message-State: AOJu0YzSllDTYhSs45yl/IJp2dUnh/cYhWh0EzDyoZ/WqlgxZePoGalf
        I047tsQNjbUXCrHlc6itzJBGrA==
X-Google-Smtp-Source: AGHT+IEF/j2AH2R/KwZSRqW3RHIwq6yDyTn8L4VmbId/KdBMxnXkl4+T7K05xdZMKM/6e9WVD7bpIw==
X-Received: by 2002:a2e:7a09:0:b0:2b9:e93e:65e6 with SMTP id v9-20020a2e7a09000000b002b9e93e65e6mr7692189ljc.35.1694425672534;
        Mon, 11 Sep 2023 02:47:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id a22-20020a1709064a5600b00992ca779f42sm5088901ejv.97.2023.09.11.02.47.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Sep 2023 02:47:51 -0700 (PDT)
Message-ID: <6b1f1e97-f747-eab4-86ec-39be487e6956@linaro.org>
Date:   Mon, 11 Sep 2023 11:47:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] dt-bindings: arm64: dts: mediatek: add description for
 mt8365-evk board
Content-Language: en-US
To:     Macpaul Lin <macpaul.lin@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     Bear Wang <bear.wang@mediatek.com>,
        Pablo Sun <pablo.sun@mediatek.com>,
        Macpaul Lin <macpaul@gmail.com>
References: <20230910062852.15415-1-macpaul.lin@mediatek.com>
 <f8864242-daa1-e72f-4759-aac3fa1bbcf2@linaro.org>
 <12bdd17a-98f4-5551-4253-229dc36f0c77@mediatek.com>
 <ef81697f-473e-898e-ec13-4dd255e2e3d7@linaro.org>
 <82a0ab25-a3cc-3e87-e379-9b15b3fbbf76@mediatek.com>
 <649e89c3-343a-c00c-ae89-329833b38981@linaro.org>
 <e697a23e-e677-c97b-269a-a7a11d338d95@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e697a23e-e677-c97b-269a-a7a11d338d95@mediatek.com>
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

On 11/09/2023 10:16, Macpaul Lin wrote:
> 
> 
> On 9/11/23 15:06, Krzysztof Kozlowski wrote:
>> 	
>>
>> External email : Please do not click links or open attachments until you 
>> have verified the sender or the content.
>>
>> On 11/09/2023 08:34, Macpaul Lin wrote:
>>> On 9/11/23 14:09, Krzysztof Kozlowski wrote:
>>>>
>>>>
>>>> External email : Please do not click links or open attachments until you 
>>>> have verified the sender or the content.
>>>>
>>>> On 10/09/2023 14:07, Macpaul Lin wrote:
>>>>>
>>>>>
>>>>> On 9/10/23 17:09, Krzysztof Kozlowski wrote:
>>>>>>> +      - description: MediaTek Genio 350 Boards (Genio 350 EVK)
>>>>>>
>>>>>> That's a bit confusing. So all of the boards here will be Genio 350 EVK?
>>>>>> I don't get what is the point of this description.
>>>>>>
>>>>>>
>>>>>>> +        items:
>>>>>>>            - enum:
>>>>>>>                - mediatek,mt8365-evk
>>>>>>>            - const: mediatek,mt8365
>>>>>
>>>>> Thes boards with compatible 'mediatek,mt8365-evk' is indeed used by
>>>>
>>>> Boards?
>>>
>>> I'm not sure if there will be more hardware version released to market.
>>> Current the p1v3 is the final version of mt8365-evk.
>>
>> Then your code (enum) does not match description. The code is saying:
>> this is for multiple boards based on mt8365.
>>
>> Your description is saying: this is only for 350 boards.
>>
>> Now your email is saying: there is only one 350 board.
>>
>> Three different versions. Sorry, I am confused.
>>
> 
> Okay, this description has been modified to support single board.
> Since there is only one type of the hardware is available on the market.

Then why the code uses enum?



Best regards,
Krzysztof

