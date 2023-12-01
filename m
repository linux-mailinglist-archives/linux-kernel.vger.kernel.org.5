Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83ED1801122
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378362AbjLAQeN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbjLAQeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:34:10 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2C4DD
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 08:34:17 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6cdfb721824so962967b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 08:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701448457; x=1702053257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=lIVPxXfyRSGDKVbd0O07+WBOozTI2XHgEyp2ySPuwu0=;
        b=TeN2rruDTPvIvr3vbAEwnuJ28JUV62svktbLw6kE07o2gwqOjVl6+jlfmv3D/M3vAg
         fLt1kfpgw2rc2dgFtBpEKZVwua06nTX6V4PtA629vsJ7VXqN6JuvvhHk3xnsvPfQXric
         VoBre/mCPTk7/Xvjp7RwCOVSgxjmaS24L0YFtg5nq5YupK4vCrtZKP8S56Mo9vYNjoSY
         eGNb4ufAB2HqWiQ70b69BMUHYZLFlfLqS6bFyvSB1ep15CfJ+wtJ6iSTZAnS0PQRNzv4
         bvF8Q6Xy0FSJ54DumRe+DvmDdPmUfVOCDlHS7qNPTelV8ph3y2dZjrzfQN2+sG8jSzrk
         KXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701448457; x=1702053257;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lIVPxXfyRSGDKVbd0O07+WBOozTI2XHgEyp2ySPuwu0=;
        b=sgqA27H7sRtBri+c9F2aw0hvDcUcCflEINCi3j6IWet6G4wuIgCWQtM1DHhfGgvt/3
         61W8CMjPBkzD+pXMHCe/pt1FnFrQM/xHS2eUNuxpVl1c5yGlsmUsQ8UtJ4H79KcPvXEh
         eXG6E7QPM+wYKqQnqVNnfsm/fcWOM+N6UuRkB+8Q8mDcjIoe8KDLBMZMjhYAMXp+DzwD
         DLVXcBcU2wlRDw15X8G/uyIGu1oI5x1Yr7N4BYzVUAfPz5ZHZHvyhqaevUPvAbTIeR9P
         vSDa011yKZ6oeT3FztZyXT8tjl21MvtIeQqyj4UPJ4NJNChjW1eh1lVWQhtP4OgRBDN6
         TJZA==
X-Gm-Message-State: AOJu0YwOiLMnXg9ipEY3ur3lOl+Fdljw7/+GkKYmqCPKFY45xtycgTZT
        7NUYPCf0u3PebHiIafAge5c=
X-Google-Smtp-Source: AGHT+IHXAoLSPo4+YCchKWHhboy6S4g5iIam80Qx8hZ40IZ3dTv+Lezn0sJjsf6II9TEkazXy6KBlA==
X-Received: by 2002:a05:6a20:e12a:b0:187:e646:4faf with SMTP id kr42-20020a056a20e12a00b00187e6464fafmr26437722pzb.14.1701448456881;
        Fri, 01 Dec 2023 08:34:16 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id cd24-20020a056a02079800b005b944b20f34sm2933455pgb.85.2023.12.01.08.34.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 08:34:15 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8fff7625-69b7-4c32-a3bb-d3ca24f149bf@roeck-us.net>
Date:   Fri, 1 Dec 2023 08:34:14 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] checkpatch: Add dev_err_probe() to the list of Log
 Functions
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
References: <20231201151446.1593472-1-andriy.shevchenko@linux.intel.com>
 <3c709cc1-0da8-4d23-9f75-8c18d4d18779@roeck-us.net>
 <ZWoHLkcPk2084gQH@smile.fi.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ZWoHLkcPk2084gQH@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 12/1/23 08:17, Andy Shevchenko wrote:
> On Fri, Dec 01, 2023 at 08:01:28AM -0800, Guenter Roeck wrote:
>> On 12/1/23 07:14, Andy Shevchenko wrote:
>>> dev_err_probe() is missing in the list of Log Functions and hence
>>> checkpatch issues a warning in the cases when any other function
>>> in use won't trigger it. Add dev_err_probe() to the list to behave
>>> consistently.
> 
> ...
> 
>> Not sure if I agree. The difference here is that dev_err_probe()
>> has two additional parameters ahead of the string. I would very much prefer
>> to have those two additional parameters on a separate line if the string is
>> too long to fit in 100 columns with those two parameters on the same line.
>> In other words, I very much prefer
>>
>> 	dev_err_probe(dev, -ESOMETHING,
>> 		      "very long string");
>> over
>> 	dev_err_probe(dev, -ESOMETHING, "very long string");
>>
>> and I don't really think that the latter has any benefits.
>>
>> Also note that other dev_xxx() log functions are not included in the above test
>> and would still generate warnings. Accepting
>>
>> 	dev_err_probe(dev, -ESOMETHING, "very long string");
>> but not
>> 	dev_err(dev, "very long string");
> 
> They are included, see the line previous to the added one.
> (Regexp covers something like x_y_()* and x_*() families with the explicitly
>   listed * suffixes.)
> 
> That's why _this_ change makes it consistent.
> 

Hmm ok. Still don't like it.

Guenter

