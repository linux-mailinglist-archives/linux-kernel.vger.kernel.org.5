Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2D67B64CF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231366AbjJCI6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239487AbjJCIyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:54:16 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3BEFAD
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 01:54:12 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53829312d12so5538977a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 01:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696323251; x=1696928051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7IaObsVHs1NdJLfuEJziyoY/pLZb/GsRr8NAO3bXzbs=;
        b=JTvngf7z7HTar82sAGKIAchjgPw3tqeWxtHNOb6EycUD8soqZ15X9FBLa/pkenzahX
         qezK+Q4msJwFL0tenp1g30CtjoE989xNF6YJOAzBSR5Tm/9Sk8pZp52ecMDi8YCIBz06
         3CvFR2zfYvYUWdIR3ZtbOn2z0JXrObQfQTl/93ClsRhlb5xvSFl55jMxuNuE2dpW/6vL
         77q/GEWZScU29ujt+CFUToiCcbMBbo0o464Bm7xYogG/3QYiQLRJ0n63vN92Pz89G/28
         PiF2yr/khBSvNVrxdGOm5whAC4DEtdD0p8tuiOrHWD0sa4Nw4phHRXCjT2cHnF8SkDZK
         tO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696323251; x=1696928051;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7IaObsVHs1NdJLfuEJziyoY/pLZb/GsRr8NAO3bXzbs=;
        b=IBnKANwuPRCPwOTPR1CRtHHHFSUaRTpOXkdLvKIf/01VS2ZSB6NDTvfJeejexxuTif
         d19+MiL0a2+MjkI9l2C8q8+B6F9Uhf9K5IYYbuVBBu/yczeC7Kuic3FerBpAsUM0BX7J
         VHIUOAE1AWuqhAEI2LJnREhpkO6VHKPmsEV8//TJjj5MRGhEEgpNzqS924l4kYm1Oi32
         VBWYs5kPLwO5tqc4P+OIWA3izqtLWtdgYvFfkqz3NXwI9BYuMhCwA9/vsMxnu2x8cm3D
         4DO1cfs2/6yN4bk+RZ2pVBZ2AmuVN3mR1nDPxKkXe49hU1AlxVQt8LdTc0mSwfFgqXuR
         ofaQ==
X-Gm-Message-State: AOJu0YzjRnY1acV9CQB+bNtUuh2EgPQ0LOBXQgsaeg138LxoGT/WNeIX
        25jh0GtNa0zcIipP869+cvU5TQ==
X-Google-Smtp-Source: AGHT+IGD8eTXESVGFfQG73BZE1EspyM8U+kqBDYHOC7jfG6Cq16C51n36/lZQ3Muvqh+Mofu1SiRtQ==
X-Received: by 2002:a05:6402:297:b0:534:6e34:c1ec with SMTP id l23-20020a056402029700b005346e34c1ecmr1739661edv.6.1696323251286;
        Tue, 03 Oct 2023 01:54:11 -0700 (PDT)
Received: from [192.168.1.197] (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id f17-20020a50ee91000000b00537f5e85ea0sm512235edr.13.2023.10.03.01.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Oct 2023 01:54:10 -0700 (PDT)
Message-ID: <714073cb-6079-474f-90eb-f782e3edd53b@linaro.org>
Date:   Tue, 3 Oct 2023 10:54:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: misc: adi,axi-tdd: Add device-tree
 binding for TDD engine
Content-Language: en-US
To:     "Balas, Eliza" <Eliza.Balas@analog.com>,
        Conor Dooley <conor@kernel.org>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Derek Kiernan <derek.kiernan@amd.com>,
        Dragan Cvetic <dragan.cvetic@amd.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20230928092804.22612-1-eliza.balas@analog.com>
 <20230928092804.22612-2-eliza.balas@analog.com>
 <20231002163244.GA1886905-robh@kernel.org>
 <BN7PR03MB454508AF350D2DC96FE1743A97C5A@BN7PR03MB4545.namprd03.prod.outlook.com>
 <20231002-aggregate-scanner-3ca2ae69cf0c@spud>
 <BN7PR03MB4545090CC2F859333E9C3AB297C5A@BN7PR03MB4545.namprd03.prod.outlook.com>
 <20231002-carnivore-clapped-33140a07ff67@spud>
 <BN7PR03MB4545715CBC44232EEA81FF7697C5A@BN7PR03MB4545.namprd03.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <BN7PR03MB4545715CBC44232EEA81FF7697C5A@BN7PR03MB4545.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/10/2023 22:23, Balas, Eliza wrote:
>>>> If you have version registers in these IPs, what benefit does version
>>>> numbers in the compatible string bring?
>>>> Rather than using the version numbers to validate what the DT gave you,
>>>> which not the kernel's job IMO, why not just use the information from
>>>> the register to determine the version?
>>>>
>>>> Cheers,
>>>> Conor.
>>>
>>> As the description of this patch says, we want to resolve the naming confusion around the existing repurposed TDD core
>> (https://wiki.analog.com/resources/eval/user-guides/ad-pzsdr2400tdd-eb/reference_hdl#tdd_controller)
>>> built for AD9361 and this TDD Engine IP core (https://wiki.analog.com/resources/fpga/docs/axi_tdd) which is a similar core, with
>> more output channels and some extra features. The version numbers in the compatible string are used to differentiate between the
>> two IPs.
>>
>> Firstly, please fix your mail client to wrap text at a sane width :)
>> Secondly, where is the binding for that TDD ad9361 specific core that
>> calling this generic one "adi,axi-tdd" would conflict with?
>> Grepping the bindings directory of the kernel tree for "adi.*tdd" returns
>> nothing. If there is an ad9361 specific tdd, I would expect it to have a
>> compatible like "adi,ad9361-tdd".
> 
> We didn't upstream the ad9361 tdd driver, but we are using it
> in our internal kernel. If this is an issue, I will change the 
> compatible string to "adi,axi-tdd".
> 

Unfortunately, we do not care much about your internal kernel and
whatever you have there should rarely be an argument in upstream
discussions.

Best regards,
Krzysztof

