Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9C407941AE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240396AbjIFQr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236925AbjIFQr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:47:59 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 837A91738;
        Wed,  6 Sep 2023 09:47:55 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-565e395e7a6so69818a12.0;
        Wed, 06 Sep 2023 09:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694018875; x=1694623675; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YVuYrvdAZmiakwnUrTCNPT76uwDHc4nkNKfw/tN0vVQ=;
        b=INvoQ3TCO89d3d8+DLamiuspLRMZ7VMMzh7S+N1tdhN1PYmCtoGXH5D2CTt4x2xEK7
         0vaoAwbOJBOp8O4Hg9DjWo68HOthHnn+Lg+4MJD5UcgohH8N1L7tjFrNa5BfGizPHDIW
         CE68oTQPOpfRuOSHtB4kcSYqvHbyV53GXwYgJUY7faJQSbmQvno3oiPzuDJzWpnCbz5p
         eQ40bWXyzx0BAr2jaIJ4iwe6TI0BWJ+JoMOVo/eypXO7JIJEbSnfv2N823v3DBYdr2Pw
         2xxYy/UcyH0tuKT7hvZ04ZK9jXsocQ16J8paYxZV83Y0vblYJbYUbDyalAb+SldNF5Tv
         a3hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694018875; x=1694623675;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YVuYrvdAZmiakwnUrTCNPT76uwDHc4nkNKfw/tN0vVQ=;
        b=LuE7c+C7G9/lHymzdmyi/LoaFddWyqm1IdOYp7I4IDJKA0Jn3kknSLWw1wEP2QeS3N
         AapMszeyncBo4NCX02WLH7S/hkCwqKc+WRG4BtUP3De47xC3Ky7GAFHaS59OfV3Zy22L
         dyjAE97ovk7RXEx+UJMgZ39WZPA+qLxJBiHwoZduE04+zZx+tMMhbSvthEY5ZPB4hS/Q
         VISXKd2vWYPjZoqL+BefVA42I3PLlv1aAR4CHNcHHL9j4DItnYJChivGeBB7oqxuJqiF
         Zqf4G5X0bagntC2cVeJW+tijt3iAdelAllQfS9J6hUCd8cZqkzQ76M9kgo/m9cVxBlgA
         tpLg==
X-Gm-Message-State: AOJu0Yw4Rn00bq8hxrz1FGwZXuEC3yv2+j0FU1TwQdtL5ZnCypBXF67W
        u+dpZ2eJYT3KIfA64W2HN0I=
X-Google-Smtp-Source: AGHT+IGwiyMi44H17BEmu2LD+jihfhYG50dvi+Awsyh+gYS13Uz0l7Gp0RELkeYJpELupfsdcC2ZUw==
X-Received: by 2002:a05:6a21:a105:b0:14d:29f6:18c3 with SMTP id aq5-20020a056a21a10500b0014d29f618c3mr12270887pzc.20.1694018874768;
        Wed, 06 Sep 2023 09:47:54 -0700 (PDT)
Received: from [172.16.116.58] ([103.15.228.93])
        by smtp.gmail.com with ESMTPSA id h3-20020a63b003000000b0056c466b09a4sm11455647pgf.59.2023.09.06.09.47.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 09:47:54 -0700 (PDT)
Message-ID: <8c4717f1-36f3-96dc-2335-ec323e3f46df@gmail.com>
Date:   Wed, 6 Sep 2023 22:17:49 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v4 1/3] dt-bindings: Add beaglecc1352
Content-Language: en-US
To:     Krzysztof Kozlowski <krzk@kernel.org>, greybus-dev@lists.linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org,
        Vaishnav M A <vaishnav@beagleboard.org>,
        Jason Kridner <jkridner@beagleboard.org>,
        Nishanth Menon <nm@ti.com>
References: <20230902182845.1840620-1-ayushdevel1325@gmail.com>
 <20230902182845.1840620-2-ayushdevel1325@gmail.com>
 <937ea540-09e1-65f2-7165-662bbee2542b@kernel.org>
From:   Ayush Singh <ayushdevel1325@gmail.com>
In-Reply-To: <937ea540-09e1-65f2-7165-662bbee2542b@kernel.org>
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

On 9/4/23 12:44, Krzysztof Kozlowski wrote:
> On 02/09/2023 20:28, Ayush Singh wrote:
>> Add DT bindings for BeagleCC1352 co-processor UART.
> This does not look like UART controller.
>
>
>> Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
>> ---
>>   .../bindings/serial/beaglecc1352.yaml         | 25 +++++++++++++++++++
> It's not a serial driver. Don't put it in unrelated directory.
>
>> @@ -0,0 +1,25 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/serial/beaglecc1352.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: BeaglePlay CC1352 serial UART
> How is this serial UART? Of what? The SoC? Do not describe interface but
> the device.
>
>> +
>> +maintainers:
>> +  - Ayush Singh <ayushdevel1325@gmail.com>
>> +
>> +properties:
>> +  compatible:
>> +    const: beagle,cc1352
> No resources? This does not seem useful... Put it then only in trivial
> devices if your hardware - hardware, not driver - does not have any
> pins, interrupts or other resources.
>
>> +
>> +required:
>> +  - compatible
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    beaglecc1352 {
> Node names should be generic. See also an explanation and list of
> examples (not exhaustive) in DT specification:
> https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation
>
> Best regards,
> Krzysztof

I would like to get some help on how to tackle this particular device 
since I cannot seem to find anything similar to this setup. First let me 
go over the setup.

The BeaglePlay board has 2 processors. AM625 processor which is the main 
processor. This runs the main Linux system. This processor does not have 
direct access to SubG.

It also contains a CC1352P7 MCU with it's own flash program memory, ROM 
and SRAM. This processor has SubG antenna. It runs it's own OS (Zephyr 
by default).

The only way for CC1352P7 and AM625 to communicate is by using that 
particular UART which is just a standard 8250 UART. The setup pretty 
much looks like 2 boards connected over UART except the UART will always 
be static.

I guess it would make most sense to write a CC1352P7 binding in this 
case? However, I am not sure how accurate that is since anything from 
the Linux side will be interacting with the Zephyr application, and not 
the processor. So in all actuality, the processor itself does not matter 
at all.


Ayush Singh

