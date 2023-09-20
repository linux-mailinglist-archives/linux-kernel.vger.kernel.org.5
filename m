Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5A97A88AC
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235449AbjITPmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234622AbjITPma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:42:30 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3440CA9;
        Wed, 20 Sep 2023 08:42:25 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1c4586b12feso30745095ad.2;
        Wed, 20 Sep 2023 08:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695224544; x=1695829344; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/FopUyV3sWTM0BYSDm8MXgHOopR6PnUhg8HFvmChPo4=;
        b=dsDeyx/zRjXeFICEFax+ycZJmINaBsKPK/9IG1+zFQir1zbqksO5fGQcGHIYZLpy4I
         Q27/OBqVe4V/CNSwI4/xFY4xH5BEwurLY0eWlNFV/3AzT+rpUC8QiaSVitYCSCLZzXcs
         +1I+8g5hDd+T7nDHTsw/bb+UvhE6Pu+a0TpLoernIbw5DfV7ZHKIbxMLYOr0o2cnDbgN
         f012PRPTytQlO3fBk6pYKYtWEADyOszt+RQBC8D/0Kh/d1CUlkRYPdDo21ig/eHr/nqG
         K5wd6fTsiqKOD9surAW6dTU8hnnFy+tEZ/6L/J4v3KsaC4Yze+P3cmdwtVLcvltvMdIu
         7Nkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695224544; x=1695829344;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/FopUyV3sWTM0BYSDm8MXgHOopR6PnUhg8HFvmChPo4=;
        b=cH9Rmzqq3QIBG3U20BW1UljDjFQErcJIOoawQuXwub9Y0UXo/3OFUN+IC9TgI6D4gk
         YQJUBot1DAv4DIwK/Bo9hzf8hv/Bi/IOS4FxBgJyJSL+R0wbBsIVaxync/Kjjia4lnSR
         s3U9hc/2GlA2PHytAEViMl75LRvHl790v/IvEWWZmflOj+OaliESi28+0fvfGz2AysPC
         chn5Ib688PhjRceXAzLSD3HQglQV2ekBY8QaCOYdCv4jlI1owBOq4oOX4KzIxZ1VkMHW
         jqpz2UvDbYzY6lo97pxc09l3gRxULPaB+cMRKlq3Fnvo4O64X8Yin3PL5LvlFD8niKFy
         vccw==
X-Gm-Message-State: AOJu0YzflufVl0Fm2awjrPfCPuvgna917TRrWKUPdNS9RvhUjnf5vQC/
        cTSLT49a59VQAtwzjiSk8EPJqFf7B1s=
X-Google-Smtp-Source: AGHT+IEg7YKWpX/lvcgUKqgEZpPhN5zjZAhlL+5B313ksWVb7l6TWMOYw1KftwM2OOl0540JUnhR3g==
X-Received: by 2002:a17:902:9f8e:b0:1c5:b1a6:8111 with SMTP id g14-20020a1709029f8e00b001c5b1a68111mr2306749plq.31.1695224544654;
        Wed, 20 Sep 2023 08:42:24 -0700 (PDT)
Received: from [192.168.31.134] ([117.243.89.101])
        by smtp.gmail.com with ESMTPSA id ik26-20020a170902ab1a00b001b89b7e208fsm12228396plb.88.2023.09.20.08.42.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 08:42:24 -0700 (PDT)
Message-ID: <74322740-8db4-f165-7c01-47ed98f07e51@gmail.com>
Date:   Wed, 20 Sep 2023 21:12:16 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] ASoC: dt-bindings: tfa9879: Convert to dtschema
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230919090739.2448-1-bragathemanick0908@gmail.com>
 <9d612171-8ae4-de65-31b0-fbb5f1f8331e@linaro.org>
From:   Bragatheswaran Manickavel <bragathemanick0908@gmail.com>
In-Reply-To: <9d612171-8ae4-de65-31b0-fbb5f1f8331e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 20/09/23 16:58, Krzysztof Kozlowski wrote:
> On 19/09/2023 11:07, Bragatheswaran Manickavel wrote:
>> Convert the tfa9879 audio CODEC bindings to DT schema
>>
>> +required:
>> +  - compatible
>> +  - reg
>> +  - '#sound-dai-cells'
>> +
>> +additionalProperties: false
> Instead:
> unevaluatedProperties: false
>
>> +
>> +examples:
>> +  - |
>> +    i2c1 {
>> +       #address-cells = <1>;
>> +       #size-cells = <0>;
>> +       amp: amp@6c {
> amplifier@6c
>
>> +          compatible: "nxp,tfa9879";
>> +          reg: <0x6c>;
>> +          "#sound-dai-cells": <0>;
>> +          pinctrl-names: "default";
>> +          pinctrl-0: <&pinctrl_i2c1>;
> That's not a DT syntax.
>
> Best regards,
> Krzysztof
>
Let me correct all this errors/warnings and send a new patch.

Thanks,
Bragathe
