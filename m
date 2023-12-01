Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B582800DB5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 15:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379195AbjLAOvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 09:51:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379244AbjLAOvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 09:51:31 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D7310FF;
        Fri,  1 Dec 2023 06:51:35 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6d858670630so358385a34.0;
        Fri, 01 Dec 2023 06:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701442295; x=1702047095; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=4kUZpJzd/INNeC9v2YwFr4GrBhIQhybHPbFBJIXAAiI=;
        b=Upskj1ji8jjpVAUr3Ai1C1ni/usv7FqFgsvox0T/fN4ODW2wQqAtOufKbVIAph9HPg
         bv+czHZLmgTvY61QlluA2dWUVO4U6yMZH2kdIkte2uM/jx06c4xQii/wDtd676xVztEt
         jz+A+Y6Uv8F/dnCdoIpzgNaK5vtn68bVRPOU/0iPtyZjc50gvnw7p/O6AYynd0oCftE4
         sZf7rCnwA8W4yBphtK+8jhrl1UwvbsdqBL8vWH+x2GKe1schjnpWI53iCKySoYXkcFYC
         viZuq3lI8WdthL9H8UY9w0EQ2juhnl2JNIwcZxpMxgTqvi3Ls6fO5uuannPSpux6XOrd
         FpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701442295; x=1702047095;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4kUZpJzd/INNeC9v2YwFr4GrBhIQhybHPbFBJIXAAiI=;
        b=p9Esf27Ktd7xOZ558ouMzdfBowoXU1CjcoQWbolUeL7dxWFmgUzDKXEZNCwMLmEn/F
         KlSL7+CVCf683u8mzA4C+QoWPmBTKtb+bs0FXgJzIHYTSFtTV59cyShFM3FWqcqx4S65
         dEC6ZhtUzDFDZmjTSloqG/x5Y6qIET5niWz0+ckf6XSJbaXZg2TMtoyd9IOtgGdJdrg0
         OyD2CDcyIXFtUgXHyGhXUhHrzVcG86qBLPLOzVx1lz8WHCs8S4Qs/UamRqYkkyjyJ5q9
         k/LvvA9ocJRC+WS/01bAMTlExgSS82hMY4Cv27SzQkOkr1ZMH7LK+DE4nl+nHIoxhely
         shdQ==
X-Gm-Message-State: AOJu0YxKzrBa2gfAym9gRHkSk/8V1tgduMvD3H5m/9FmW5nPYDfASiJj
        5KxtwT+AykRFtAxcHL+KEZQ=
X-Google-Smtp-Source: AGHT+IGRY69rAOX0/EsZF/pTja8wL645iNsno8qT2By6dUqBg2egW/esF4nu9KFTdRBeE4vq5nVynQ==
X-Received: by 2002:a05:6830:65c8:b0:6d8:5518:ab3e with SMTP id co8-20020a05683065c800b006d85518ab3emr4302550otb.36.1701442295020;
        Fri, 01 Dec 2023 06:51:35 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x5-20020a9d6285000000b006d811e1d91dsm511822otk.72.2023.12.01.06.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Dec 2023 06:51:34 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a77968c8-fd40-4221-96be-740aecdb5e84@roeck-us.net>
Date:   Fri, 1 Dec 2023 06:51:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] hwmon: tmp513: Simplify with dev_err_probe()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Tremblay <etremblay@distech-controls.com>,
        Jean Delvare <jdelvare@suse.com>
References: <20231128180654.395692-1-andriy.shevchenko@linux.intel.com>
 <20231128180654.395692-3-andriy.shevchenko@linux.intel.com>
 <1ef66c53-d9ba-4fca-8462-b670f029f5de@roeck-us.net>
 <ZWnlRAOG7EP3RyPR@smile.fi.intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <ZWnlRAOG7EP3RyPR@smile.fi.intel.com>
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

On 12/1/23 05:53, Andy Shevchenko wrote:
> On Thu, Nov 30, 2023 at 08:10:12PM -0800, Guenter Roeck wrote:
>> On Tue, Nov 28, 2023 at 08:06:03PM +0200, Andy Shevchenko wrote:
>>> Common pattern of handling deferred probe can be simplified with
>>> dev_err_probe().  Less code and also it prints the error value.
> 
> ...
> 
>>> +	if (IS_ERR(data->regmap))
>>> +		return dev_err_probe(dev, PTR_ERR(data->regmap), "failed to allocate register map\n");
>>
>> That line length was getting too long. Please consider running checkpatch
>> on your patches.
> 
> I got your point, but checkpatch has no limit for the string literals, see
> 
> f4c014c0dede ("checkpatch: allow printk strings to exceed 80 characters to maintain their searchability")
> ca56dc098caf ("checkpatch: check for quoted strings broken across lines")
> 
> So, what the exact parameters should I supply to it?
> 

None. Please just run checkpatch.

$ scripts/checkpatch.pl index.html
WARNING: line length of 102 exceeds 100 columns
#126: FILE: drivers/hwmon/tmp513.c:729:
+		return dev_err_probe(dev, PTR_ERR(data->regmap), "failed to allocate register map\n");

Guenter

