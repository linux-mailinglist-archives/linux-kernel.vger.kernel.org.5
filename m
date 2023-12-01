Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79077800278
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 05:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377295AbjLAEOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 23:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjLAEOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 23:14:44 -0500
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120C7171B;
        Thu, 30 Nov 2023 20:14:51 -0800 (PST)
Received: by mail-ot1-x335.google.com with SMTP id 46e09a7af769-6d816bb0a61so71137a34.1;
        Thu, 30 Nov 2023 20:14:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701404090; x=1702008890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Ou39VwI4qDSNHUhmf4l8yTbj4hV8r42H44EzZ/2omPE=;
        b=XEeeynt5INqFrlW5KxYU0YTOha8STwdeE0rGEXKDybao622U2LE054jBbIYSwRgl9F
         dQvjjXXAFuGcwQYlCjnKXkL6sR03bHkOtoeCAD+KrnyhOv/SAUFjhxar/CIUWOPJYk+J
         shqIi2oeeK6+LkHD8ADIxEVDcyTrxnT1EVOZWmP7XtG+TOhIIlkwPpYnC2F6K2924B5H
         wvyGFiWRQrWV9N6ph2KEoLQGgSwvM3E0sYw/1ocOSNRRZYtCHWo0qoILLLZP5aZ+1IyZ
         spUucidvSy7nzHfMt3UR/CUyk40CX0ryGvJcQ40JO4g/k5R8aLld6SRKzYCXvmrRVFx9
         qG/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701404090; x=1702008890;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ou39VwI4qDSNHUhmf4l8yTbj4hV8r42H44EzZ/2omPE=;
        b=X+5H2ac9IsGbvZhoFI+SYrzz2bdfqTVliCFD5Nkjrl36j/qKnD38I1upK8CaJJgFcX
         AK+8ecdTglm/SpSxmn4mpnjl2+X4F6IvWCQvIMtNbIWO1RX3F6bBNSX0HbZ8wNzMcFsm
         dqjtd8BOwXpG+S9OvIUGFC9g2OnhDTXfUex11IY/BbE5EvaBkqrd6f6mevHuhnA27NZ9
         jljw0PU8OAUXmfhgkpS7oAw8sepVevwnxinHbFFO/6iQE9SPsMGnECTPa0UtkGuU3qTy
         BTXak+eo/A9D2qpzEhNYTw9tZlS4Tn2quMgzSOz7bZAqqHR8Po/Dm4UcC+8knh/L4Ivc
         ZqhQ==
X-Gm-Message-State: AOJu0YztmEbdr/7JvNKSZ6R3qqQAJVwIqWjm7QNg63N8GGasqzVhbQ/B
        dh6HG9V5ajmMCobBUdbwjLdf13C6bto=
X-Google-Smtp-Source: AGHT+IGz170Y+gMyo5Rz47FRwDcYrTFpRyCNdsd5CgFuq1UGT7iPoXSHaP7jKIP5Wyxw/rZXPKl06A==
X-Received: by 2002:a9d:6f1a:0:b0:6d8:134b:23e2 with SMTP id n26-20020a9d6f1a000000b006d8134b23e2mr1953943otq.0.1701404090392;
        Thu, 30 Nov 2023 20:14:50 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e24-20020a0568301e5800b006cd09ba046fsm376560otj.61.2023.11.30.20.14.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 20:14:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <0646bcf5-fd41-41e5-b7b1-06b425973c86@roeck-us.net>
Date:   Thu, 30 Nov 2023 20:14:48 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] hwmon: (coretemp) Introduce enum for attr index
Content-Language: en-US
To:     Ashok Raj <ashok_raj@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     jdelvare@suse.com, fenghua.yu@intel.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ashok Raj <ashok.raj@intel.com>
References: <20231127131651.476795-1-rui.zhang@intel.com>
 <20231127131651.476795-2-rui.zhang@intel.com>
 <ZWkDQ5y3e4oPONni@araj-dh-work.jf.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ZWkDQ5y3e4oPONni@araj-dh-work.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30/23 13:51, Ashok Raj wrote:
> On Mon, Nov 27, 2023 at 09:16:49PM +0800, Zhang Rui wrote:
>> Introduce enum coretemp_attr_index to better describe the index of each
>> sensor attribute and the maximum number of basic/possible attributes.
>>
>> No functional change.
>>
>> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>> ---
>>   drivers/hwmon/coretemp.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
>> index ba82d1e79c13..6053ed3761c2 100644
>> --- a/drivers/hwmon/coretemp.c
>> +++ b/drivers/hwmon/coretemp.c
>> @@ -43,10 +43,18 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
>>   #define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp */
>>   #define NUM_REAL_CORES		128	/* Number of Real cores per cpu */
>>   #define CORETEMP_NAME_LENGTH	28	/* String Length of attrs */
>> -#define MAX_CORE_ATTRS		4	/* Maximum no of basic attrs */
>> -#define TOTAL_ATTRS		(MAX_CORE_ATTRS + 1)
>>   #define MAX_CORE_DATA		(NUM_REAL_CORES + BASE_SYSFS_ATTR_NO)
>>   
>> +enum coretemp_attr_index {
>> +	ATTR_LABEL,
>> +	ATTR_CRIT_ALARM,
>> +	ATTR_TEMP,
>> +	ATTR_TJMAX,
>> +	ATTR_TTARGET,
>> +	TOTAL_ATTRS,			/* Maximum no of possible attrs */
>> +	MAX_CORE_ATTRS = ATTR_TJMAX + 1	/* Maximum no of basic attrs */
> 
> This seems odd. TOTAL_ATTRS being the last entry seems fine, but defining a
> MAX_CORE_ATTR the way above sounds a bit hacky.
> 

Complaining is easy. What do you suggest that would be better ?

Guenter

>> +};
>> +
>>   #ifdef CONFIG_SMP
>>   #define for_each_sibling(i, cpu) \
>>   	for_each_cpu(i, topology_sibling_cpumask(cpu))
>> -- 
>> 2.34.1
>>
> 

