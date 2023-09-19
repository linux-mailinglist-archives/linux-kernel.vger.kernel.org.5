Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13FC87A6336
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 14:39:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbjISMjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 08:39:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbjISMja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:39:30 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1982EE3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:39:25 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-523100882f2so7214913a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 05:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695127163; x=1695731963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7KPj36MbfSKWyVnSEtl1DKIjrmkge+O7pPsjetRL4rw=;
        b=yklkOb3yQypfqNXQ6B4IOQfbm9dTo8Y/VI0nXBuR89AUQH7ci5ByeTS7ANdr0qGnY/
         LCwSDp606FfITjP0FPH3QZsNwxj1EGiazm63P2q1UGpmaTgaDgRDGDRqsgPXed6nAiCq
         Yr3ufnHTYGBx9SZY15uOUGwfWuop6EHVACV7nLKIZz9cjKEK3fVUkTU/ZmWJjp1W670r
         3m8INioZLX/SvWtyHDFX7X7J+iR625e5VONubaaob3N7scETjwl5rJcTCBGn7wK7a0Oh
         Or+NUiOt31ZUvsLkxqHOyeyE4JO8U06aVi2Sf02rd5bci783k+qNgWjXrD4Pgz/5c2ax
         1eDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695127163; x=1695731963;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7KPj36MbfSKWyVnSEtl1DKIjrmkge+O7pPsjetRL4rw=;
        b=eFqUtYAS9GLlAGguOruGjhWMxVljXnT3bYWnTHMelVvBb3LWBwE/kH7aO1NihhKFal
         zt30xNNBazl66+mlvVFRVsvmmJhaESmvt5YISO/GzxyB9sN7t9zQH6jbTVqscAL1lYKa
         alcW9fTRxYQxYcK9cnYZL8A9V7VHJ8oTjggVdNsdE5KXg5ukkFNtPb7J9fB1MP6vralF
         2FGHcirViPGy2DRsDzLGj3JPJZGRgYNx7s6feXeuchCejxSz+wKRarcRcQWpBj83Kqj7
         2yju6X2vCUalf9EthEHq9bJek7IktlObBFnrXsXu+55L2Q9HUx80ql8giyNJMiSRLfo2
         o7Qw==
X-Gm-Message-State: AOJu0YxgUbO2LnhyOOeEnU7IhHT2NfHDhaVq4VWbk7KGiYXTSIy8LJRp
        xe3AvGNTIZckkZxpyvaLQB3L6g==
X-Google-Smtp-Source: AGHT+IFTtdB3ZYAylEmFZOXVN2m6qAW8iQgQcPlnCno8Y8GycSpjLb7BHWT8HDL8LVmBpL+UOJHcKQ==
X-Received: by 2002:aa7:d4d7:0:b0:530:4967:df1a with SMTP id t23-20020aa7d4d7000000b005304967df1amr8442803edr.17.1695127163528;
        Tue, 19 Sep 2023 05:39:23 -0700 (PDT)
Received: from [172.20.24.238] (static-212-193-78-212.thenetworkfactory.nl. [212.78.193.212])
        by smtp.gmail.com with ESMTPSA id r16-20020aa7c150000000b0052fe12a864esm7296339edp.57.2023.09.19.05.39.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 05:39:23 -0700 (PDT)
Message-ID: <e0d42d13-b307-9915-97c8-948261b39ce1@linaro.org>
Date:   Tue, 19 Sep 2023 14:39:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 1/2] dt-binding: usb: ci-hdrc-usb2: document Nuvoton
 NPCM supprt
Content-Language: en-US
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     peter.chen@kernel.org, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        xu.yang_2@nxp.com, peng.fan@nxp.com, avifishman70@gmail.com,
        tali.perry1@gmail.com, joel@jms.id.au, venture@google.com,
        yuenn@google.com, benjaminfair@google.com, j.neuschaefer@gmx.net,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230918165958.2659-1-tmaimon77@gmail.com>
 <20230918165958.2659-2-tmaimon77@gmail.com>
 <b7a337f2-a810-d14c-e7cd-15e33a9ecb5d@linaro.org>
 <CAP6Zq1gSJYsNUuD-bexFW_1VpAUuF_WZkicNzZms6hVdo9LnMQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAP6Zq1gSJYsNUuD-bexFW_1VpAUuF_WZkicNzZms6hVdo9LnMQ@mail.gmail.com>
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

On 19/09/2023 07:14, Tomer Maimon wrote:
>>>            - nvidia,tegra20-ehci
>>>            - nvidia,tegra20-udc
>>>            - nvidia,tegra30-ehci
>>> @@ -325,6 +326,20 @@ properties:
>>>      type: boolean
>>>      deprecated: true
>>>
>>> +  nuvoton,sysgcr:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle-array
>>> +    items:
>>> +      - items:
>>> +          - description: phandle to syscon that configures usb phy mux.
>>> +          - description: offset of usb phy mux selection.
>>> +          - description: mask usb phy mux selection.
>>> +          - description: value usb phy mux selection.
>>> +    description:
>>> +      A phandle to syscon with three arguments that configure usb phy mux.
>>> +      The argument one is the offset of usb phy mux selection, the argument two
>>> +      is the mask usb phy mux selection, the argument three is the mask usb phy
>>> +      mux selection.
>>
>> Sorry, you miss phy driver. Don't use syscon instead of proper hardware
>> devices.
> Sorry the role of nuvoton,sysgcr property is to handle a mux between
> the different devices and not the handle the phy itself, handle the
> mux done in the GCR.
> Should we move the nuvoton,sysgcr description to another place in the
> ci-hdrc-usb2.yaml
> or
> Should we use a different driver to handle the mux and call it from
> the ci-hdrc-npcm driver, If yes which driver should we use?

What is an "usb phy mux"?

Best regards,
Krzysztof

