Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2647757494
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjGRGpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbjGRGpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:45:42 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4306B134;
        Mon, 17 Jul 2023 23:45:41 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-579efc32377so48925517b3.1;
        Mon, 17 Jul 2023 23:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689662740; x=1692254740;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RYEnSjRbogv2a232Wt5RDLOlCRVr+Svj4aNxG7iOabY=;
        b=IwDTdBvUotAJ6wdv/OTm3JQdIY4yNNG35zChngIg4ZCkWq3ozLCPEKIqlFaTDkZbr1
         edULVY3jQJBOdNogAVNd42ziCBu2FBs7guV7ybZCBRmNAZnCJNWGyj9wLn8iGpjb6jGd
         jSoskA24vJCXlOcQaLKeEnfFcRJA4kOEJOU9phJ76DbVHq05wPszB6XpT7Bsc8HfB7yf
         LMl3bFu8B2PrqGL/AX1Fcm9Se39pv4pGqcGqAeEYzMeXtz2dbf6Ac/TF0BouVw7qF/YA
         T8h6XcZLy5OYYoj4Xwd3xTxtnxFFdwzS7f4TPFl+ibSxfkM68iFl+O9/SdsfBLG8a+F/
         Womg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689662740; x=1692254740;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RYEnSjRbogv2a232Wt5RDLOlCRVr+Svj4aNxG7iOabY=;
        b=CubGpVfD6tsD7ZpNna7GX1O1cXH4TAZbr+8y6KazAAUWBnHOSZb8EBy2pAjJCON298
         /d28PX0zLyUiPuZLq2rbT8+3M+I6DINCgKe/+m8/QjoZNMV4PEOm155kj/2chM92cpEb
         R33kgGY2girWdPJlNgOQ5owalAK2f1nt65g46XlMVfql8dnSQCGFSnBwrticN+sxCQcf
         2HPjdMdivZr8KHVarEVZRLd+M/s3X4sZ/VGYZoHwPGj7xT2BCyizyRMPEQfPntyURpr5
         XLA1K0bpcrNR39eY4EjhXwjHBAQjTIu/G4TVvTZwPun4Joj6+qntlUAbuvl3cVytMdEV
         zGug==
X-Gm-Message-State: ABy/qLYjBs3dkbDrncfNm+296r7LM70HbapWQf9ST6gq9tqMxavEwKD7
        bKpBnwwaa/JJNELjHrLDHms=
X-Google-Smtp-Source: APBJJlEVFHpC4q1Ty43rQaP0AAaXKieldjAQFSqMe0k3ca6qKhRfDgD7Hdc09UiTORQI8lPRk4A5gg==
X-Received: by 2002:a81:8343:0:b0:573:9e0a:b8bf with SMTP id t64-20020a818343000000b005739e0ab8bfmr12214681ywf.9.1689662740452;
        Mon, 17 Jul 2023 23:45:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u187-20020a8184c4000000b00577357201e2sm306905ywf.14.2023.07.17.23.45.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 23:45:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <28de46d5-bf6a-da0c-ad24-5404ad416b3a@roeck-us.net>
Date:   Mon, 17 Jul 2023 23:45:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        =?UTF-8?B?6JSh5om/6YGU?= <billyking19920205@gmail.com>
Cc:     "jdelvare@suse.com" <jdelvare@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patrick@stwcx.xyz" <patrick@stwcx.xyz>,
        Billy Tsai <billy_tsai@aspeedtech.com>
References: <CAGUgbhCqOJaEPjS96o2au21uW4NhqFScm4Ayd8PzOQvqxQ94SQ@mail.gmail.com>
 <0b9dd5cf-f4ca-2e6b-624d-0b451bbc2f30@linaro.org>
 <0ba3767c-d481-6e2c-2d32-b79af0e1efd8@roeck-us.net>
 <CAGUgbhC34-pUp4ECULc0ScaN7hUF1L-z69h+ji-TiVrv4gKd3Q@mail.gmail.com>
 <7b198d57-ddec-3074-314a-3e5e5b8f48f9@roeck-us.net>
 <CAGUgbhDbFedVe-pc+muD_NtDpjHpGqMDdrS3A73C-QbxeHn4oQ@mail.gmail.com>
 <cf91edc9-1093-495b-48eb-6b05198c2541@linaro.org>
 <7a69bda1-5f4c-5b1f-8eb6-6fd58917a9b1@roeck-us.net>
 <CAGUgbhCTDPGt_vpbfaEreX+iuLJ3WUBqt4kppxyaFZQus9Zf0Q@mail.gmail.com>
 <b22b2ccc-6760-0db6-067b-109c3864d2e8@linaro.org>
 <CAGUgbhDmXnyxYCL9h9C0P4ByDSTstWnGqW=uFoDVVHeK3BerHA@mail.gmail.com>
 <3756dffd-1407-d656-485a-9cf1eefd9ae1@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [v6 2/4] dt-bindings: hwmon: Add ASPEED TACH Control
 documentation
In-Reply-To: <3756dffd-1407-d656-485a-9cf1eefd9ae1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/23 23:04, Krzysztof Kozlowski wrote:

[ ... ]

>> The first method involves passing the memory region from an MFD
>> driver, which was the
> 
> I have no clue how can you pass memory region
> (Documentation/devicetree/bindings/reserved-memory/) from MFD and why
> does it make sense here.
> 

It is quite common for mfd drivers to pass regmap information to
child drivers. Child drivers typically call dev_get_regmap() with
the parent device as parameter. Granted, that is typically used
for spi or i2c devices, but I don't see why it would not work
here as well.

Then there s syscon, but I don't know if that works with overlapping
memory regions.

Guenter

