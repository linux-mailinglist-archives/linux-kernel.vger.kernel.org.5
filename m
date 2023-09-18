Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EB57A4DB7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjIRP5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbjIRP5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:57:45 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22A72FF;
        Mon, 18 Sep 2023 08:54:34 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-773a0f36b4bso275343385a.0;
        Mon, 18 Sep 2023 08:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695052236; x=1695657036; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=D1Fje60QNx1BvdDO0QihprgGJ7xlaD1JNybZmw5Nq/w=;
        b=hxGqmPGpADFPAT3rEgNcAaeoN3wgTDLB1Tgd5sI1v5MMo2A7vHRrfUzAgqZIfDwLWx
         96rfgWJEKJHIuCKgsAS/6xrjEUXaU8H2suCZBTuYY76ko9SDlVaf/u7Szt5V6PxBL1Ny
         +EZOqnpINUHitNlwUbwlft+z7niF3FEquJxi5medjkh6NLQCzoqzIi6EYNPm9WekSLWn
         FbFj9GTub83R+5c9Nxk+vwBW3GIB2FVTQWWYE8Gc2TfDSLcnEWYWW3fBfAE0Gj2nQMj9
         r/Nr9GX7Y+05vIDFI6/oly5qy2grOxB2uxpBRX4/uEfMChoBUqYN2pbN6mi/q56H+pal
         OEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695052236; x=1695657036;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D1Fje60QNx1BvdDO0QihprgGJ7xlaD1JNybZmw5Nq/w=;
        b=c6NjqNmUUB3A2Cpk7zTCZKOolyzlYj9FNe786w2236MZrgCqOBP9jQlbiDZGpXaGp7
         9nY504ys+HXxDXn5cytJ4iIgTtCU6ZHZHO8BFbMENlXvrrTbf7lf0lsz56PtBvYuIuzN
         fCWthtRZqDL/4U8x9l7GCnB1whAu2AD/jUe7y+fQ/QPE0nmMSBtbac+4+L7QIOOZXyf5
         6j6h/sADePvK9rV+dZxYoAhSKrCfVZS/wrlcZ4qMsH9r/RSdRcq3K4qE9L1pPKz6+gGP
         tt2NDbvX9EPacB496B+3r+x0IiMsXVLFaq2gf75laT5Wdt1Mg/C/4JDIWc10JsyrfuuA
         KY0w==
X-Gm-Message-State: AOJu0YwjnYBa1XlFQ6RcupRJFrRTj3ZMUCvZ7POZFPDUuvUQHLfxB043
        EoPS5LCvqIADBd8FInSQQbf0vH5WGOQ=
X-Google-Smtp-Source: AGHT+IFQdbSe5j8h3gcfqs7w0EAAODxRBkZUnrWEIijpJmeUgC/SN2QMLHB4QM8ogfl6uR8Vgjbgsw==
X-Received: by 2002:a17:902:82c3:b0:1c4:749e:e725 with SMTP id u3-20020a17090282c300b001c4749ee725mr3135869plz.0.1695046148422;
        Mon, 18 Sep 2023 07:09:08 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id jk15-20020a170903330f00b001b9fef7f454sm5910990plb.73.2023.09.18.07.09.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 07:09:06 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <34b6d4b8-b0a4-ea7a-923a-4e4ed365cb70@roeck-us.net>
Date:   Mon, 18 Sep 2023 07:08:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 1/5] hwmon: max31827: Make code cleaner
Content-Language: en-US
To:     "Matyas, Daniel" <Daniel.Matyas@analog.com>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
References: <20230914075948.208046-1-daniel.matyas@analog.com>
 <44e84cb8-b573-0e1a-91e5-cdee0441d0f9@roeck-us.net>
 <PH0PR03MB6771F345901A22603B60508289FBA@PH0PR03MB6771.namprd03.prod.outlook.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <PH0PR03MB6771F345901A22603B60508289FBA@PH0PR03MB6771.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/23 02:25, Matyas, Daniel wrote:
> 
> 
>> -----Original Message-----
>> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
>> Sent: Saturday, September 16, 2023 2:26 AM
>> To: Matyas, Daniel <Daniel.Matyas@analog.com>
>> Cc: Jean Delvare <jdelvare@suse.com>; Rob Herring
>> <robh+dt@kernel.org>; Krzysztof Kozlowski
>> <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
>> <conor+dt@kernel.org>; Jonathan Corbet <corbet@lwn.net>; linux-
>> hwmon@vger.kernel.org; devicetree@vger.kernel.org; linux-
>> kernel@vger.kernel.org; linux-doc@vger.kernel.org
>> Subject: Re: [PATCH v3 1/5] hwmon: max31827: Make code cleaner
>>
>> [External]
>>
>> On 9/14/23 00:59, Daniel Matyas wrote:
>>> Now the wait time for one-shot is 140ms, instead of the old 141
>>> (removed the 1ms error).
>>>
>>
>> It was explicitly documented that the wait time was 140 + 1 milli-seconds,
>> presumably to be sure that the conversion is really complete.
>>
>> Why was this an error ? It was _documented_ that way.
>>
>> Guenter
>>
> 
> Well... actually I developed the driver initially and I wrote the documentation, so I know. I decided to remove the error milli-second, because I realized, it isn't really needed. There is no reference about it in the documentation of the chip, and frankly, I didn’t actually encounter any error which would need the 1 milli-second.
> 
> This way, the wait time is more exact and the correspondence with the chip documentation becomes quite straightforward.
> 

This is all fine, but it is yet another example of more than one logical
change in a single patch, and it has nothing to do with the subject. It
is not a cleanup, but a functional change.

Please split _all_ logical changes into separate patches.

Guenter

