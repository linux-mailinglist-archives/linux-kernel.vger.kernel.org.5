Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA7D759C95
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 19:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbjGSRkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 13:40:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjGSRkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 13:40:06 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAEB618D;
        Wed, 19 Jul 2023 10:40:04 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1bb1baf55f5so44164355ad.0;
        Wed, 19 Jul 2023 10:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689788404; x=1692380404;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4zcvJfBQoZ3LsY68xNz61DEwSh2nWYBOthwrmgBDGLE=;
        b=Nqt/y7dZhDZukuh/FcMihVDpyhDYZU5/5m+eW2aiDDqEikKUWWq7xrtorFOtZvpDqH
         I4Og8fTe4ohDg9cipITyxcltnLH5k7BlCVwLE9aprWW1wstJWBA0u2YaYyzlZ6TTY4wd
         KC+BCEfBeTAO0gZDkTiivXZewky9yHuRnQmGgUKBe+8RkCu1QW6liRdHvwVyb/SJAOb2
         hzhH2ap0c7pxE5ja+K+tPm1PMfINZuZCZQJroMc64+k+HAARI1Pi3lj8jrioQZfqXFOB
         kkQJ448EYxfYb2JD8ELocrvWpavPmZPyzcAk2N9LoKlCvhxepZXDSuhgaDN53AZ9uypK
         YhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689788404; x=1692380404;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4zcvJfBQoZ3LsY68xNz61DEwSh2nWYBOthwrmgBDGLE=;
        b=hlFKe8uj7GkUhm9xn9r1Z6hzdFvFnv4FzFWuR8bsFd/yIAsgAV3chEXMgS936Mvxck
         +enLT/zncjnG/a7TJCQR83QkgXpanaXl26me9mQhDwoOuPn4sPOpDZYF/L8IiFROMHGk
         z/7SOpvY32pknU3JtKZVmZcIgMxSk2963cNLjqio4ZN1w0ucKRTIfejV1QXbouC8Po4j
         viGX0szYKeFEqJHn4+nIfVKuKlBzyUwUuSMtwu+D1soKfNR3PWtKqLSIN8XLNpj34vaw
         TW9DmGzFdCE+Px63LEZuFryeYsy7N2KYNDRoRDvaeterGVeVxEh0+Kwy8y45/2wa8hHF
         OPRg==
X-Gm-Message-State: ABy/qLaXvBzVyhe8qv0MmGmEoqkZVgfaVQFyYVjRSdLZM6Ky/CTMEygM
        wB2pT7iG68+QhAP9o6AiPk0=
X-Google-Smtp-Source: APBJJlFFiTE+0z9U4aWP809XsVIBymKGnyIWz7Qcdg5w7V0e+H49/b8WytaFUjY40hXdQRDStFVf1w==
X-Received: by 2002:a17:902:6a8c:b0:1b8:90bd:d157 with SMTP id n12-20020a1709026a8c00b001b890bdd157mr19228012plk.26.1689788382901;
        Wed, 19 Jul 2023 10:39:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x21-20020a170902ea9500b001b9c5e07bc3sm4247550plb.238.2023.07.19.10.39.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 10:39:41 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <3a912cab-001f-a70b-394d-71370fc482e5@roeck-us.net>
Date:   Wed, 19 Jul 2023 10:39:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Naresh Solanki <naresh.solanki@9elements.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230420111759.2687001-1-Naresh.Solanki@9elements.com>
 <76e57634-75dd-01e8-9c56-36ed7de17812@linaro.org>
 <c8d1b5db-318e-3401-0834-b89769831eca@9elements.com>
 <be129c4f-3ad7-c54b-936e-08b142608ebc@linaro.org>
 <88f9a008-2861-284c-76c4-7d416c107fbb@9elements.com>
 <bd45ea5d-e6e4-403a-e855-376e0f647f91@9elements.com>
 <20eb1d0e-0aa2-9d41-7ba5-2feb148748d0@linaro.org>
 <9d989c4c-7c9e-9e95-133f-03741d07198b@9elements.com>
 <80b60de0-dcb5-303f-8d13-f4b1cf7d8521@linaro.org>
 <45236017-22d2-f9f8-0069-77195e49221d@9elements.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 1/2] dt-bindings: hwmon: Add max6639
In-Reply-To: <45236017-22d2-f9f8-0069-77195e49221d@9elements.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/23 04:36, Naresh Solanki wrote:
> Hi Krzysztof,
> 
[ ... ]
>>
>> No, we cannot, because we asked you to fix things there. Your entire
>> explanation about compatible and driver is not related to the comment
>> you received: bindings should be complete. You argue that bindings do
>> not have to be complete, because of something with driver. This is not
>> related. Bindings are not for driver.
> 
> I understand that complete bindings are important, but as the driver is already merged and functional, my immediate goal is to enable its use on my machine. I will work on a separate patch to include the interrupts in both binding & driver.
> 

As a follow-up, since it came up in a separate context:

Bindings and driver are independent of each other. _Bindings_
are supposed to be complete. However, the existence of a property
in the bindings description does not have to be reflected in
the driver.

FWIW, you _could_ have added the device to the list of trivial
devices. The only really mandatory property is vdd, and every
chip has that. All other properties are really about configuration
and/or fan properties, and I don't even know how to describe fan
properties (such as pulses per revolution, pwm parameters,
fan speed limits, the relationship between pwm outputs
and fan inputs, the relationship between fan speed input
and pwm output, or fan spin-up requirements) in devicetree.

Guenter

