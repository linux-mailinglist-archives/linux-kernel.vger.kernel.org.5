Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F3A7AC826
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 14:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjIXMyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 08:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjIXMyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 08:54:05 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC1BFC
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 05:53:58 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-3214d4ecd39so4028037f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Sep 2023 05:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695560037; x=1696164837; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V+zWR4OnErzUNTHI9CGno+JO0shm7NKnCH0fmpCCo4c=;
        b=enfe8olHQ3cTGk9667QX1SE2aUnLE40rcjxtTOms/JpXkoRn4wLQ0qdlWYqYLDH/2J
         nOMrN/U1DJ1inQh4vJH8iO8gDoOYUPFUF9a8JkoYsmTM9mhltYirZ8aNPR141Ozdfc+v
         KyKn6+c0oXLpvqO7jhPXd4knpe28gQxM6A9iM8jy1FKyvDyueMkKdngt1e6p2VrwMjX/
         0tjsMFYKAn7jSU6oC0ur990X+IrPrz9fx8Bxi7DOyDgGa2QlVCpO6ST/PXB1oIK1jjfw
         OvALK79mc7Fo4rOAWi6dpDRUR3f0xjCL3xtEOba49dTBxeGOJcJeGHWeHMlgjMc13Fak
         BT3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695560037; x=1696164837;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V+zWR4OnErzUNTHI9CGno+JO0shm7NKnCH0fmpCCo4c=;
        b=r9Y72jjfQz1jqwumzayROXmswKH7b9LhYlvCZ7UIfjGC69htyrl3eO+o+S3j4wI8u2
         Oyk7pLOv7LWC04cCtOxAY7+Rc71sSDwNwtteppyQ0CviOTFzHXJhRIpHC4UHtbHwOYK8
         wB1K4dBROdmyYyMP0Zg7cKmednTgrQb7SXKGxNmk/b5t4iU77onvhQlDPHdfsU5gbGEi
         Q5jnnazhwJI6bFero9+Z916qbGFM170xw9nWhvBoXZJ9TIAIAwBo3Ad7UuVqIjaNgulF
         W8RREFRVOnf9+i/SOZUH1MvvT6m/nF27M7aad/S/+KONR7uZzeN3rskOZLCu7ezu3WHm
         /snA==
X-Gm-Message-State: AOJu0Yx07kq15oqmk/7DZCayyOUvkcSOebqIJnq1PnqM1w1y4/GdByyf
        /BRX+ri6JA0cWtjm0HtlD4am0YOKaGj7XyW/QuM=
X-Google-Smtp-Source: AGHT+IE+y3uD5k3aI0TjwvT+iKkLTK6/bpET/tRb+igBUnXtTSJ7YkjJcnfCC4yooWKXBkNSieuy7Q==
X-Received: by 2002:a5d:4842:0:b0:314:152d:f8db with SMTP id n2-20020a5d4842000000b00314152df8dbmr3615045wrs.58.1695560037285;
        Sun, 24 Sep 2023 05:53:57 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.100])
        by smtp.gmail.com with ESMTPSA id f18-20020a5d58f2000000b00317b0155502sm9222827wrd.8.2023.09.24.05.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Sep 2023 05:53:56 -0700 (PDT)
Message-ID: <141ec8de-4008-9f96-e915-92056b409edc@linaro.org>
Date:   Sun, 24 Sep 2023 14:53:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 1/3] dt-bindings: Add beagleplaycc1352
Content-Language: en-US
To:     Ayush Singh <ayushdevel1325@gmail.com>,
        greybus-dev@lists.linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, vaishnav@beagleboard.org,
        jkridner@beagleboard.org, nm@ti.com,
        krzysztof.kozlowski+dt@linaro.org, vigneshr@ti.com,
        kristo@kernel.org, robh+dt@kernel.org, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230924113725.164948-1-ayushdevel1325@gmail.com>
 <20230924113725.164948-2-ayushdevel1325@gmail.com>
 <0fd912a9-4aaa-d4bd-4ceb-7319d9f46db8@linaro.org>
 <69f8f5aa-075c-0dc1-7a5f-bd6978c71f53@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <69f8f5aa-075c-0dc1-7a5f-bd6978c71f53@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2023 14:22, Ayush Singh wrote:
>> So this is "Texas Instruments Simplelink CC1352P7 wireless MCU"? Since
>> you do not have any fixed feature and run general-purpose OS, then this
>> should be rather compatible matching actual hardware (so ti,cc1352p7).
> Yes, it is "Texas Instruments Simplelink CC1352P7 wireless MCU". Since 
> the docs suggest that all functionality of the device should be 
> mentioned in the bindings rather than just what is being used, I suppose 
> all the other properties can be defined as optional? The bindings for 
> this device do exist in Zephyr, so I guess that can be re-purposed for 
> Linux kernel. However, I think in that case it should be moved into 
> `soc` instead of `net`?

Zephyr bindings might be entirely different, because they are for the
case of running Zephyr OS on this processor.

I still do not fully understand whether you describe here generic MCU
used for Greybus or some specific firmware with fixed features. Looks
like the first, thus my suggestion about compatible. The location could
be arm.

>>
>>> +
>>> +maintainers:
>>> +  - Ayush Singh <ayushdevel1325@gmail.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: beagle,play-cc1352
>>> +
>>> +required:
>>> +  - compatible
>> Still no resources? I asked about it last time and you did not answer
>> anything.
> Sorry, I missed that. By resources, I think you mean pins, peripherals, 
> etc right?

By resources I mean whatever is needed to power it up and operate, e.g.
clocks, supplies, reset lines.

Best regards,
Krzysztof

