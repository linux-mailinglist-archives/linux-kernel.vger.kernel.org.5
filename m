Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 887ED7FA5C6
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234461AbjK0QK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:10:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbjK0QKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:10:40 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914A61A7;
        Mon, 27 Nov 2023 08:10:45 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-332e40315bdso2764854f8f.1;
        Mon, 27 Nov 2023 08:10:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701101444; x=1701706244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g+lF3QgCwvWnbjfqhJEMa7OoaEHoxVxVETL2faHDack=;
        b=SMqhFRWtRXFUUW0aQqRS7CFlvhBuTwPPO4sEscfBdfaUdWRHI8r4Y7RxtfW30D8RuW
         9Q4V+Or0/TWhBrTHN4KOO2lF3Y7DbYDzZAR4KX2axqgl4B3FxZKEWr8DJIereGJhFi+I
         Gn8ou6H1IVjTzN/6LO+B8AOmIwK5YQM7f6nDgiHSforpXyLkdekwFjPLrFk2J08Qrjxt
         LAUAvCjpeuTCNF2YSadPA/kU+u8j5ok3nEwgYo8nxY5zoIERblxVUsWt16Y8lJfrbOJK
         t98qhQmJ9y1jED3BgYBqunUx5pv2cOMlcmZE4pi1+b6dVLmtcg++UFelhETpAjrbXdf0
         norw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701101444; x=1701706244;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g+lF3QgCwvWnbjfqhJEMa7OoaEHoxVxVETL2faHDack=;
        b=LuRcgnfPc+l+D5hf8h/X9EhRyEND4VMSYExi2lkk1UDcAeYgu0jUVhynU8t8CHKEId
         28IOtb8EAL3eI/gj/y2pI9kEixU2OGzvky0P0g9C8XoUlxSY/nYZihLXZsvGUPofriAp
         Z8uWiavRwJ06k+utN9GlnjGtD38LnB4+ZybI3/Ur6XuqbmcKG+WVIQrrPsTvOFQ1SRwk
         UkYJ55mhPdaCrM5UtFo2tBM/ZFFOclw9TxF3ckfbjK4pDIghqeCwGgW2hgS/CDoQtHUn
         t3h7veZoFkNcktYP4jGzVO7X0uWKMVqPLH5E1pG4RiBm8C9ctzDdoyGGoKBmBO6hbUiE
         yawQ==
X-Gm-Message-State: AOJu0Yx6RC54bHD7dovwTn2tPc6phgrHE/7MyT8k34MEDM0RcLfi7Xfu
        rUf5WvCIRyaGRvyWTBDUmGU=
X-Google-Smtp-Source: AGHT+IFGREU7mhh8Zy+vus2qLVxZ7UEZYtWvBcxMMrydr3j/3AjBv6ioEJwShSAq6Sb8x3TtsHo1YA==
X-Received: by 2002:a5d:6a91:0:b0:333:2f2:33c7 with SMTP id s17-20020a5d6a91000000b0033302f233c7mr2471080wru.41.1701101443549;
        Mon, 27 Nov 2023 08:10:43 -0800 (PST)
Received: from [172.25.98.130] ([5.2.194.157])
        by smtp.gmail.com with ESMTPSA id s16-20020a5d69d0000000b00332cddd7468sm12386974wrw.40.2023.11.27.08.10.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 08:10:42 -0800 (PST)
Message-ID: <0002141e-4605-414d-9baf-84bc794ee66b@gmail.com>
Date:   Mon, 27 Nov 2023 18:10:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] dt-bindings: adc: add AD7173
To:     Conor Dooley <conor@kernel.org>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, andy@kernel.org,
        linux-gpio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        =?UTF-8?Q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Haibo Chen <haibo.chen@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231123152331.5751-1-user@HYB-hhAwRlzzMZb>
 <20231123-ninth-joylessly-89e8531cf756@spud>
Content-Language: en-US
From:   Ceclan Dumitru <mitrutzceclan@gmail.com>
In-Reply-To: <20231123-ninth-joylessly-89e8531cf756@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/23/23 20:02, Conor Dooley wrote:
> On Thu, Nov 23, 2023 at 05:23:21PM +0200, mitrutzceclan wrote:
>> +allOf:
>> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
>> +
>> +  - if:
>> +      properties:
>> +        compatible:
>> +          not:
>> +            contains:
>> +              const: adi,ad7173-8
>> +    then:
>> +      properties:
>> +        refin2-supply: false
>> +      patternProperties:
>> +        "^channel@[0-9a-f]$":
>> +          properties:
>> +            adi,reference-select:
>> +              enum:
>> +                - refin
>> +                - refout-avss
>> +                - avdd
> 
> I assume you tested that this restriction works as intended?
> 

Yes, for both reference and reference-select
