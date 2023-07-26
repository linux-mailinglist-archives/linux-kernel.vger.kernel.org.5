Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD02D763C37
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 18:19:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233076AbjGZQTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 12:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232514AbjGZQTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 12:19:11 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A9A22695
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:19:10 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b933bbd3eeso104006151fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 09:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690388348; x=1690993148;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PGbt6PYMLskM53TKZ26axcDYb2hySneGd/kuw1Q4t1A=;
        b=UtB3H6SEk6GoB09wbuHbHtkORwM/QWz6Ekw7lHFHgn3BcqUwHuINBbQqjPZnHNmoal
         f9OlabJofeA1zUvqogtGqsP1gIrU1R8uMhyk73Ac8Rrpbu3rA7y/2AeVXiZ/HySh7gwv
         uIHa2iX/us1vpuKABwhdHwEJl6x8gMfTKZEn6uMiRQHifJwIKbQZ9kYW4PZ/+acD2fuc
         Y2bZ6mqNTF87KZz15t546jqKGUCMQ3hleLHnjq9KvO1lga1+av87a90kqxDmqHTInENX
         M9ahCMKGt9rRtdfcSDAyuZKmqfr41ADKwKwPFg54e7QFLjPbW36/KdDI/Q0UQ95dVqX+
         8c2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690388348; x=1690993148;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PGbt6PYMLskM53TKZ26axcDYb2hySneGd/kuw1Q4t1A=;
        b=DhdPfXpkb4B8w4yTk1ooIMH4zjvacpHbnALxXfljICjTqjozsztcpFNSjcgi2n+MG5
         8gQdWDf+FhshTu8+OR3QyNJD2OFR4CUNY/NGfnlU7WezGmwgUbHH5ka+JLEX2JXzhORf
         +kWjQnGRgeZLv5IJ8dDaKn8F3PWYspVkFasuKH7Wc7CyLKmEFCB6hUXrstl9IS5Vmx27
         4ZpXC5gi7M60kMfMe8NT7PTv4QA8c7qN1jVatSIuNBUQVR1ySN6AXu2jeLF8Qe/pOYR6
         met9u1iGo49JuWyds8xvtxdzrKweRKsy1nyfhE4V0id/pLYBnCzunwoTgG7ZD6t0XGVd
         Vdqg==
X-Gm-Message-State: ABy/qLbKCeENE2NjHRFkfBw2DLuhE2nnSjHsoqK2Ab707URAsDO4CXKy
        D6NRQFmCr/Oj7xfMyfyxKjDZzQ==
X-Google-Smtp-Source: APBJJlE8hezboS//YmJrQJ4MM5zR/CYSBtT9FDJp1n9lOL3RLkHUeMdgVh8XVldJU45npuBdDbjWSQ==
X-Received: by 2002:a2e:91c2:0:b0:2b7:67f:24bb with SMTP id u2-20020a2e91c2000000b002b7067f24bbmr1884459ljg.50.1690388348338;
        Wed, 26 Jul 2023 09:19:08 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id j15-20020a170906254f00b00992d122af63sm9809417ejb.89.2023.07.26.09.19.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 09:19:07 -0700 (PDT)
Message-ID: <76bddaa4-bff2-ffd9-ea33-92e622b290a5@linaro.org>
Date:   Wed, 26 Jul 2023 18:19:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] dt-bindings: hwmon: add renesas,isl28022
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     =?UTF-8?Q?Carsten_Spie=c3=9f?= <mail@carsten-spiess.de>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20230726152235.249569-1-mail@carsten-spiess.de>
 <20230726152235.249569-3-mail@carsten-spiess.de>
 <82628237-e087-269e-9673-cf3873fe4b35@linaro.org>
In-Reply-To: <82628237-e087-269e-9673-cf3873fe4b35@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2023 18:14, Krzysztof Kozlowski wrote:
> 
>> +  shunt-resistor-micro-ohms:
>> +    description:
>> +      Shunt resistor value in micro-Ohm
>> +      defaults to <0> when not set
>> +      monitoring of current and power not supported when <0>
>> +
>> +  shunt-gain:
> 
> 1. Missing vendor prefix (does not look like generic property)
> 2. -microvolt
> 
>> +    description:
>> +      Shunt gain to scale maximal shunt voltage to
>> +      40mV, 80mV, 160mV, 320mV
>> +      defaults to <8> (320mV) when not set
> 
> And then enum is for 40, 80, 160 and 320.

Also use "default: X" to choose default, instead of free-form text.

Best regards,
Krzysztof

