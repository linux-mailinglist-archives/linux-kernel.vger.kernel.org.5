Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491BB767FC8
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 15:55:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231368AbjG2NzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 09:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjG2NzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 09:55:22 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0996510FA;
        Sat, 29 Jul 2023 06:55:22 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-686e0213c0bso2184538b3a.1;
        Sat, 29 Jul 2023 06:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690638921; x=1691243721;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+juVBEUn1R8j59wDMxRrsd2Mf8MjX0ZcSc/qKrqr3Q4=;
        b=ZYW1ZtbzEPbaat/rHLCVCFSyZiwm01HIFhAILCJVkW5Gq+z2REcyPZ63lXEAJJaYZI
         cgLSQwxPC1slxhfU97nQkijVsnrAGs8PwLnFKXJUNs3JztctVCmIrh6I/v0nJKQF3aNJ
         DNsOla9nKlCmnXybAi+kKlLuTVbs64+yEdyRij97OHrQCVgOL7UK7RdjerO77GgdnsVp
         G6OMeCzmefMBSntrkK5TQtGtX5YZO3CBDSDxMyRTIvCJmaPjEh1rzhmgDLpF3YtrxBSg
         cnmuy/e0kFc2uloZH86tsRRU3soecNFT+j+hvTjoLBY0cp5+lroSnqAuajtroaQlh+Ww
         kFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690638921; x=1691243721;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+juVBEUn1R8j59wDMxRrsd2Mf8MjX0ZcSc/qKrqr3Q4=;
        b=hxg9UM7ztwyux71VE5iIYKiYqPcMESKxu23H1ry9Szx3MeuTVGW2EZfy5SF6poWML3
         mvt/J1FOUHBxhprrTOiNfb0M+BNtOgd/ftnT1134xs4ZkKemH3dzOZ6WhHHGb+scvakR
         amTyr8lAaWnWpRPJqRW/lgAuyfNOnCKmTHB6yW+MQicUFQkvzWTEX4X2uzMVaehI9N9g
         7vo2gWbdAmyj8sd4N/dy0ytLQOYd+4gTJ5/XFpiNXG9jPLrv5dbdLKrvACI5SIBT26SL
         u4JNapOl38NH24sI5BhLmnsUtYcS4W7F1DzJH5Hk/mks5APzrTPYKOcPneElsJ0nZybb
         zsEQ==
X-Gm-Message-State: ABy/qLbCcFv15wp9HnHuhDP+BUe4wGoNhjL6cvlj58UoQd12i4pnzWzm
        fDj2FdWcBzV88nSyZPb0snT/R+Re61Y=
X-Google-Smtp-Source: APBJJlFcvdzkDB5pl/cxryze9pycHNQA25P+x+k3L8JTGbJ6+LrZwV8tKK7Y1xQ8RZ930fG7EtaT3Q==
X-Received: by 2002:aa7:88c3:0:b0:687:20d6:faea with SMTP id k3-20020aa788c3000000b0068720d6faeamr1522930pff.15.1690638921301;
        Sat, 29 Jul 2023 06:55:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ey14-20020a056a0038ce00b00686bdff1d6fsm4508300pfb.77.2023.07.29.06.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jul 2023 06:55:20 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <94d2e491-4986-5344-c169-c1732c80bdf1@roeck-us.net>
Date:   Sat, 29 Jul 2023 06:55:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Aleksa Savic <savicaleksa83@gmail.com>, linux-hwmon@vger.kernel.org
Cc:     Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
        linux-kernel@vger.kernel.org
References: <20230729133112.462023-1-savicaleksa83@gmail.com>
 <d7ea15aa-5348-3fd0-b399-ec03af438c85@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2] hwmon: (aquacomputer_d5next) Add selective 200ms delay
 after sending ctrl report
In-Reply-To: <d7ea15aa-5348-3fd0-b399-ec03af438c85@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/29/23 06:42, Aleksa Savic wrote:
> On 2023-07-29 15:31:12 GMT+02:00, Aleksa Savic wrote:
>> Add a 200ms delay after sending a ctrl report to Quadro,
>> Octo, D5 Next and Aquaero to give them enough time to
>> process the request and save the data to memory. Otherwise,
>> under heavier userspace loads where multiple sysfs entries
>> are usually set in quick succession, a new ctrl report could
>> be requested from the device while it's still processing the
>> previous one and fail with -EPIPE.
>>
>> Reported by a user on Github [1] and tested by both of us.
>>
>> [1] https://github.com/aleksamagicka/aquacomputer_d5next-hwmon/issues/82
>>
>> Signed-off-by: Aleksa Savic <savicaleksa83@gmail.com>
>> ---
>> Changes in v2:
>> - Added missing <linux/delay.h> include
>> ---
> Sorry for the noise, I didn't include the Cc: stable@vger.kernel.org
> line from v1 in v2. Do I need to resend?
> 

Normally it would be me adding that. Instead, it would make much more
sense to add a Fixes: tag, because otherwise I'll have to spend time
figuring that out. Also, you are not supposed to actually send the patch
to the stable@ mailing list because it hasn't been accepted into the
upstream kernel. It is only necessary to actually send a patch to the
stable@ mailing list if it is a backport.

Either case I'd suggest to consider addressing my feedback before sending
yet another version.

Guenter

