Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F52577713B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 09:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbjHJHWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 03:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbjHJHWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 03:22:18 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AC312D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 00:22:16 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-31792ac0fefso548693f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 00:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691652135; x=1692256935;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LA29pBHV1Plxnsd8NqiQKipDkaYhRzIouuDaqGKhnGM=;
        b=rrBWnFHloXMv4UNOZW/QhGD2TAKRq+23t09I9dV4qooy4aTUpBtHCvXgZtTyM2UJzj
         dEXpa7kpjb4jbvnacTWnhd5eLfwfJthVCw88z8Q4MEbKWYyS/C+m6Vi+hrSg71+lfjd9
         pP1B21qkuq+4jtQaQG5gpQRGdP4WHsPKm4aLORwKpkQxjr/uQ0V/JMQjQlPgbwhFK2uS
         NSGWgFXKC6RDd5jR9HpwZhW4lDsCq1cQfaGMkEj6RBaIRMQwJtGnKAFQ3oOjOgnS92W+
         a1Vovdd+6JIfQEj1iP2XRb+YG7gOmKd+dt1g374N3O7DNXvQmHKhA5YwvUxWppUVHaZo
         GOUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691652135; x=1692256935;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LA29pBHV1Plxnsd8NqiQKipDkaYhRzIouuDaqGKhnGM=;
        b=l5rTxu/G2F3/qJnHp78CCKhMtEd3la4u1nTuq4+l1wDDzYEdhFEUH+x4RON/+MvL5D
         vKJLhZah1JNUqUzAo6mN3Xs9dLvI2JBMmkRrXhDjyC3lXyW2yjWiTZpoFbudAjhLQx4L
         RE/K/sZaqf2Grs4vyR7Z24f5e6F6YWPo/x6TWZy6xpOw7cCPA10Sk0wftiq7fjNTsZxl
         w8qj7P3OSTNVybfrcwbP1xfY3SftXzG7B/dOpMhbIEE+bwf+HBds+tbd2Ql/OVLkUtmy
         CsGP2UvGi56ll73ZngmRfPKBRt0uw3Ze19Q+bljDSgSDJVgf8W6Ma9cs4Bn4IBKSujzG
         cyUA==
X-Gm-Message-State: AOJu0YwVBA5r+fPjuGOsgwJLNp+CFlzZweSNA3EWFZRZwoZIUg+Xbz1p
        4+QU3eVvZ38IcoJ0N5cnegQE2A==
X-Google-Smtp-Source: AGHT+IFd/KI6g3Jhzci+c9hqE2/m4cUSLCnDUEV2fFbzVcanPSBk+dXkAxPC3mWqzHtojMoFsejfEA==
X-Received: by 2002:adf:e70d:0:b0:317:568d:d69a with SMTP id c13-20020adfe70d000000b00317568dd69amr1596273wrm.11.1691652135294;
        Thu, 10 Aug 2023 00:22:15 -0700 (PDT)
Received: from [192.168.2.107] ([79.115.63.126])
        by smtp.gmail.com with ESMTPSA id s7-20020adfecc7000000b0031912c0ffebsm403135wro.23.2023.08.10.00.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Aug 2023 00:22:14 -0700 (PDT)
Message-ID: <37782447-43c7-50f9-b9b4-5fbca94ce8c6@linaro.org>
Date:   Thu, 10 Aug 2023 08:22:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH v3 11/50] dt-bindings: crypto: add sam9x7 in Atmel TDES
Content-Language: en-US
To:     Varshini.Rajendran@microchip.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com,
        claudiu.beznea@microchip.com, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20230728102442.265820-1-varshini.rajendran@microchip.com>
 <09bd1388-02aa-32c7-319e-d7150a0f3e9c@linaro.org>
 <1ec901d0-44c2-1d28-5976-d93abfffee67@microchip.com>
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <1ec901d0-44c2-1d28-5976-d93abfffee67@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/10/23 06:38, Varshini.Rajendran@microchip.com wrote:
>> On 7/28/23 11:24, Varshini Rajendran wrote:
>>> Add DT bindings for atmel TDES.
>> NACK. The atmel crypto drivers check the version at runtime and
>> fill a capabilities structure based on the version identified.
>> There's a single compatible regardless of the version of the IP
>> used until now, why do you want to change it?
>>
> Hi Tudor,

Hi,

> 
> I am aware that there is no change in the crypto IP used. This patch is 
> to add a SoC specific compatible as expected by writing-bindings 
> guideline. Maybe a bit more explanation in the commit description might 
> do the trick.
> 

So you add a compatible that will never be used just to comply with
the writing bindings guideline?
