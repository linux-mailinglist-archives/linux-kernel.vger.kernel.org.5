Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB1979A353
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 08:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbjIKGJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 02:09:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbjIKGJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 02:09:18 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8EAF7
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 23:09:14 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-402d0eda361so47118835e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Sep 2023 23:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694412553; x=1695017353; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zWcdRs7/4PDNa35mC9WiHzYrOk8ak/seb1it3OwsXbs=;
        b=LZ8kMsArYlIUajJpjwTV/inX900P9eNJuRYaop3j2HHVccpspwbVYsRT/TYABotozy
         uHf/OxTMS+HJ4JyN55HzetD8RozpBiw0j/AkAJ3jA08sC6ecgU3TWfeiJKzKS0HTmkTx
         wp/VuSzzzOzpsp5+7Wo259+mrn0K8SxjwPov036vSHq/xICfqNcFVN6tR3kZPJCP4+YY
         yUzdZPsaaxV6XGGoymIbekg+0No5w+iD/14ultcu287ce2PFNBnajKnrMX6hZSFTlozW
         yhuCIJdFIr7CSLYVVmm7s/mTc9UUxIYa2H7/wrzSSBfG0g1yvzf4XrcLbLjPEjhkhjsm
         ol4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694412553; x=1695017353;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zWcdRs7/4PDNa35mC9WiHzYrOk8ak/seb1it3OwsXbs=;
        b=I9qNwbqFbZsUwo568RPy6F6P0ll5srdH1phHK4lvHAPlKY+7JeeK875fS1fvtKuqzE
         /O1H+T2M8ADNVAxLx/jBCU54AYsHoyfVZ3W3S8jQfPHRYnjOG1Pc1oJoNoORHh0up80U
         eJIdG2XJG38EkV+kHfHyPleJ15AAzA8e+NG6AvL6Lhiir1VGGZ+9nt2GAHKwLZiYA+/H
         W9vLak8V3RvRRMT84KO2WC+x1+PUEc4nn6PMOS2wjvl8+dt+iBQt447Z5zIAwYZRpKTE
         iwxvSXKG4DLj4X7vtST9KC3uBZeJPkbLuNrBwBmh8b6cJbRR1nWcDokmoQWqftZbrcSu
         XwIg==
X-Gm-Message-State: AOJu0YzBH9tTYeogLriHilrTdD1GGu/pCFIAZOxb54Ce/2V5VGsLa/2B
        FC6xDWfbpoc02x//gWfx6YFeYQ==
X-Google-Smtp-Source: AGHT+IG4W706F67nRSS4jrADVmi+lVT+lP0BNJIguoVA2dZItMhEsHe6WItR7qXF+U7xSCxn069nAw==
X-Received: by 2002:a5d:4c50:0:b0:31a:ed75:75d6 with SMTP id n16-20020a5d4c50000000b0031aed7575d6mr6938145wrt.15.1694412552884;
        Sun, 10 Sep 2023 23:09:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.214.188])
        by smtp.gmail.com with ESMTPSA id d16-20020adff2d0000000b0031981c500aasm8950963wrp.25.2023.09.10.23.09.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Sep 2023 23:09:12 -0700 (PDT)
Message-ID: <ef81697f-473e-898e-ec13-4dd255e2e3d7@linaro.org>
Date:   Mon, 11 Sep 2023 08:09:10 +0200
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <12bdd17a-98f4-5551-4253-229dc36f0c77@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/09/2023 14:07, Macpaul Lin wrote:
> 
> 
> On 9/10/23 17:09, Krzysztof Kozlowski wrote:
>>> +      - description: MediaTek Genio 350 Boards (Genio 350 EVK)
>>
>> That's a bit confusing. So all of the boards here will be Genio 350 EVK?
>> I don't get what is the point of this description.
>>
>>
>>> +        items:
>>>            - enum:
>>>                - mediatek,mt8365-evk
>>>            - const: mediatek,mt8365
> 
> Thes boards with compatible 'mediatek,mt8365-evk' is indeed used by

Boards?

> Genio 350-EVK, which Baylibre helped to do upstream tasks. The only 
> production version of hardware will be available on the market. The 
> derived version of customer's hardware is not available yet.
> 
> The separate patch for renaming mt8365-evk.dts file should be send next 
> week for aligning the naming rules.

So the description is not correct.

Anyway, this patch does not make much sense to me considering nothing
like this was merged. You just sent v5 doing the same!

Best regards,
Krzysztof

