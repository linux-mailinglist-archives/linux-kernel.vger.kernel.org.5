Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2F67BBFCA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 21:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbjJFTnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 15:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjJFTnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 15:43:43 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA1B83
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 12:43:42 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id e9e14a558f8ab-34f69780037so2937125ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 12:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1696621422; x=1697226222; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N7YYLqQKEBxYGYHN/5uoJBXyuFdtBHM7nG76jzEtpXc=;
        b=J7uxfpAOJSzQp/vQtHYW0xVpSQ1sRSs4Y0yC+ZJPNsPZgGtSXLJMybPbIHzNH5npOL
         kYhJ/JEeWZGMxK/GpIutH2TFVLw3HbDmr3RkqNf8wifhfle6TaUoYWK7d5Ks3srUZO1e
         0YiF7BJQsGux8Do3OdOp7pIo4j1cxBlT3hYw0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696621422; x=1697226222;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N7YYLqQKEBxYGYHN/5uoJBXyuFdtBHM7nG76jzEtpXc=;
        b=nwgdz6w+X3CeaN1pvqIdlaIjQxx06ZmcebppvRRDitKqXvZLKD6CO2TMNheKaK5Jm2
         MHEqgldopQxAH6f9z6wRAW9MFQRuguhDGkzV1JHy92JhYcCl1ooXPDHFKHxVDnGTuit1
         epqLaT3Z6yHI75CLXfh27t3NZo+CbCySPA9624ZgHxZgJ2LUMyiEA6z/ZCNlBHTwO57+
         tmsmtFqX2o604UV24L3Um0xtE4MVFdU8lkhjCWHNEEp17lTED5A8X0GUSuIAXGSXsP9x
         iAUOu6PYnNrjhBDqh0YmEBGpMNW+z3HvhzXCcQha/GBirV5GL8uF/Ma60sGfqXRPEvxs
         6EcQ==
X-Gm-Message-State: AOJu0YwYXsrjLshhl8nd1PkdNhVrd+AFkzZfnEfjdJH1pZFigKaCw8b6
        ZHdfOilA77/fxHBXYkCcHHTW+Q==
X-Google-Smtp-Source: AGHT+IH8S+W4GcBgA8b7s2M/grRMn193p8+srz/4y0+Oit8CvMkRb+3GUpCbZJdp3ZEo6R8stxI0wQ==
X-Received: by 2002:a05:6602:368c:b0:792:7c78:55be with SMTP id bf12-20020a056602368c00b007927c7855bemr8827149iob.0.1696621422104;
        Fri, 06 Oct 2023 12:43:42 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id s12-20020a5eaa0c000000b0078754bed499sm749769ioe.37.2023.10.06.12.43.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 12:43:41 -0700 (PDT)
Message-ID: <d8437b59-552b-4ea5-9400-07535c200560@linuxfoundation.org>
Date:   Fri, 6 Oct 2023 13:43:40 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] usbip: Use platform_device_register_full()
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>, Hongren Zheng <i@zenithal.me>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20231006164312.3528524-1-andriy.shevchenko@linux.intel.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20231006164312.3528524-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/6/23 10:43, Andy Shevchenko wrote:
> The code to create the child platform device is essentially the same as
> what platform_device_register_full() does, so change over to use
> that same function to reduce duplication.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: (hopefully) fixed run-time NULL-dereference (LKP)
>   drivers/usb/usbip/vhci_hcd.c | 55 +++++++++++++-----------------------
>   1 file changed, 20 insertions(+), 35 deletions(-)
> 

Looks good to me.

Acked-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah

