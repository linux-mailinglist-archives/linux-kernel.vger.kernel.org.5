Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E21EF7EF507
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 16:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjKQPUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 10:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231409AbjKQPUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 10:20:10 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B16D56;
        Fri, 17 Nov 2023 07:20:07 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cc394f4cdfso18695985ad.0;
        Fri, 17 Nov 2023 07:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700234407; x=1700839207; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=vJdjG8ryDNu2PLSB4enAYGhPWeJOFr7R1lfzxRENyp4=;
        b=PzeXN5hV4nG6ZTE5QAadRvrFfpmY4xE4PvxvwKfFW1EAJWFJivKJ62n77jMxYCAg83
         C3CXsXxkgU71IDMaAlefCjhz0R/RYfNY62WCB0IrvZgTrZQPtP4YD7c/SKVnhS1ySThe
         8i9NO1Kmb88IFkmzCzEvMBXjJTDeOW0FiBS2qmUDwCn42FFN6OdNw32Mvk0/NaRUgc51
         gveNYR/kYkAzDf/ptbcv1CwRdOCEaFKnVGq7Y+3bdd3D5GtiXbuO9+OINPp1qAKn8chw
         /nJjFvB7hWiaS19ieUWi+umVxfGtkCZKh5AIbA3pxFMVceu6C+vRc3pqkXR0g/c+nWAJ
         6OGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700234407; x=1700839207;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vJdjG8ryDNu2PLSB4enAYGhPWeJOFr7R1lfzxRENyp4=;
        b=kC9rrVmsgW+jAiCOaIX9n2Gio3djsaoNzFzzUsbmU8S8DPlq1/ea7cUqBY6b+tPhTW
         /BjajMmAA7kDlyNbZfZE+9sUZgae9HqUNpqEutN4JOBbYm/qrfPM35z8oFvqGZol7T/q
         PMhEzjROu8aagBXmODihi/xisDRiLqbHuj1Fb7AoZrXOWJ8F9eNptg+RPChipL96aof2
         JTf+SA8scRQDlKY5kP/mUBA8fdSTo9m2l/G9EsuGXMinJmI9IXpuLG2dlzDUG/IdQxpq
         tcclmGxFWNnIe7Nd7o4h4RmK0UxA/9M+HaYYCEXyd64tUhDHFLw6J0uF+uC5ViFPO8Cy
         KzBw==
X-Gm-Message-State: AOJu0Yx1SdMreYYVgatS5Oq5wIRg/uX06T1wh+0T8zyrK40vlzmYM/8D
        9/tW54DYZ5b//Zz0KG7JchJujNmf3/c=
X-Google-Smtp-Source: AGHT+IEQ594LDn+/PVyVwHlSugIysHcAQsisAUVTS42nvfHcczbWqMQ9doA/mToQyXG6xHUifJypLA==
X-Received: by 2002:a17:902:f64d:b0:1cc:6dfa:ca55 with SMTP id m13-20020a170902f64d00b001cc6dfaca55mr16083635plg.25.1700234406801;
        Fri, 17 Nov 2023 07:20:06 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x6-20020a170902ea8600b001cc20dd8825sm1472524plb.213.2023.11.17.07.20.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Nov 2023 07:20:06 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <46303fc1-1b5f-4559-b76b-49b175523e67@roeck-us.net>
Date:   Fri, 17 Nov 2023 07:20:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: hwmon: Add mps mp5990 driver bindings
Content-Language: en-US
To:     PeterYin <peteryin.openbmc@gmail.com>
Cc:     patrick@stwcx.xyz, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joel Stanley <joel@jms.id.au>,
        Chanh Nguyen <chanh@os.amperecomputing.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
References: <20231113155008.2147090-1-peteryin.openbmc@gmail.com>
 <20231113155008.2147090-2-peteryin.openbmc@gmail.com>
 <a3445201-58f2-42c6-bef7-ca6968fd80d6@roeck-us.net>
 <69657f96-4849-4134-911d-4785d5d6b8d8@gmail.com>
 <140086a7-c89d-48b7-9574-7db28dcc056e@roeck-us.net>
 <7080c9f3-2a57-4855-be1b-9a206f6ef8e1@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <7080c9f3-2a57-4855-be1b-9a206f6ef8e1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/16/23 20:52, PeterYin wrote:
> 
> 
> Guenter Roeck 於 11/17/23 12:16 寫道:
>> On Fri, Nov 17, 2023 at 11:18:47AM +0800, PeterYin wrote:
>>>
>>>
>>> Guenter Roeck 於 11/16/23 06:27 寫道:
>>>> On Mon, Nov 13, 2023 at 11:50:07PM +0800, Peter Yin wrote:
>>>>> Add a device tree bindings for mp5990 device.
>>>>>
>>>>> Signed-off-by: Peter Yin <peteryin.openbmc@gmail.com>
>>>>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>>>>
>>>> What branch is this patch based on ? git fails to apply it.
>>>>
>>>> Guenter
>>> I think I don't pull the last version. I can rebase it and push the new
>>> version. Thanks for your feedback.
>>
>> Question is: Last version of what ? Best would be if it was based
>> on mainline.
>>
>> Thanks,
>> Guenter
> 
> It is base on Linux 6.5.4, OpenBMC Kernel tree
> https://github.com/openbmc/linux/commit/2ba0babe7865cd5f4fac3d76ad15d9b6131bd283
> 
> I can regenerate it on mainline.
> 

No need; git was able to apply it after I aded the openbmc tree as remote.
It would be great if you can base future patches on Linux mainline.

Thanks,
Guenter



