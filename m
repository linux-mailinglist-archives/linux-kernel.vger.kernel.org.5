Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119B17DBB71
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 15:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbjJ3OK5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 10:10:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjJ3OKt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 10:10:49 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A6FED3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:10:46 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6b87c1edfd5so3651951b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 07:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698675046; x=1699279846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Enm+nI8vfFGiUthTB80mGNT7rimsxWeKkqRRBI7bSko=;
        b=YieKu4RfyQwe76PrL6z+Jqvqubg38EVAv8a9mHxkH1M2imx4hquhO/MLus7LX26bIY
         vqa+MqnjxHuo7rnS+L05fBAmlEW3fIe/EXaSATEb9inkVmlGWNGZk/oeeH6lG2nBjW4o
         H1MO+CvuMNtOPA1jKGtYaCsMy/xhFf5yV6tGqkP6Dj9aFvwuTtvj+6dMjys5l5Gl6DVw
         Smmq3/6zE9MAKN5+QzLNCwZJ55nWZgBtWjSYUABM8Qr0tZg7kci4gCqRXBGk1chsdNbE
         KGvHlHQjNb3UJGjPJgacbkBTM6JQCa1Q32SaIw2UZe0kRd0gWVkmBjstJKzRd1t2BYgM
         zkSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698675046; x=1699279846;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Enm+nI8vfFGiUthTB80mGNT7rimsxWeKkqRRBI7bSko=;
        b=pQy/DNKE8/lklZy2/slu/1+juYlrXk5mOQlRNJGMsBnDDrRKi8XU8FvZ7uKbQpN4H2
         KJhHmayLL8Jd0WXuU0y1jfaCiOWh0Ev6lbQBmH+Zknx5eM0r2SjpeOvhkgSiujGiND5z
         ijSC5ylIRM28ntuXWTOiGjiz7Nwu5cbvInBv9iDXzhxjscfSCw0juxUui70pLC4fX9rf
         DQHZLVCe2fRuGxG8kx/AWxZJD7l6Y6UkznP6XqtbgzXK0dNGUjv8zB0dfl+5pXDM2iEV
         CARQJjN+Q9WHpJ2EeevsS5zchomYWvmNhuDK33OYhZSXlzxj8CJrdYD2xzrBisfQiCzb
         8Qow==
X-Gm-Message-State: AOJu0Yyjcq/1UnLtfBaZ7o27Sarr9AghcCrj3xkoJ3OAkTwDSBe2r+wP
        NncMGMpF601wNMmtW70ebHfGW8W0EHo=
X-Google-Smtp-Source: AGHT+IGQlArupjZC+r3H8N3aevLYQL83XIEvWWZyh9gykT9xdv3T+xUJV/U2Xt5Ux60qL9WQ7pTLPw==
X-Received: by 2002:a05:6a00:248d:b0:6bd:b7c5:f776 with SMTP id c13-20020a056a00248d00b006bdb7c5f776mr8536444pfv.8.1698675045592;
        Mon, 30 Oct 2023 07:10:45 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s24-20020a62e718000000b00694ebe2b0d4sm5925479pfh.191.2023.10.30.07.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 07:10:44 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <28f8b88b-4709-4254-a184-5fbbc1f7273f@roeck-us.net>
Date:   Mon, 30 Oct 2023 07:10:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] staging: octeon: remove typedef in enum
 cvmx_helper_interface_mode_t
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Oliver Crumrine <ozlinux@hotmail.com>, colin.i.king@gmail.com,
        sumitraartsy@gmail.com, u.kleine-koenig@pengutronix.de,
        geert@linux-m68k.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
References: <cover.1693236450.git.ozlinux@hotmail.com>
 <PH7PR11MB7643DEB4401AA83A0578087CBCE0A@PH7PR11MB7643.namprd11.prod.outlook.com>
 <32e9ad3c-191e-4dd1-b1cc-07f7b93c3f28@roeck-us.net>
 <2023103049-daybed-abstain-bad9@gregkh>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <2023103049-daybed-abstain-bad9@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/29/23 23:24, Greg KH wrote:
> On Sun, Oct 29, 2023 at 10:17:21AM -0700, Guenter Roeck wrote:
>> On Mon, Aug 28, 2023 at 11:39:07AM -0400, Oliver Crumrine wrote:
>>> Remove typedef in enum cvmx_helper_interface_mode_t, and rename all instances
>>> to cvmx_helper_interface_mode
>>>
>>> Signed-off-by: Oliver Crumrine <ozlinux@hotmail.com>
>>
>> In linux-next:
>>
>> Building mips:cavium_octeon_defconfig ... failed
>> --------------
>> Error log:
>> drivers/staging/octeon/ethernet.c: In function 'cvm_oct_common_get_stats':
>> drivers/staging/octeon/ethernet.c:204:37: error: storage size of 'rx_status' isn't known
>>    204 |         struct cvmx_pip_port_status rx_status;
>>        |                                     ^~~~~~~~~
>> drivers/staging/octeon/ethernet.c:205:37: error: storage size of 'tx_status' isn't known
>>    205 |         struct cvmx_pko_port_status tx_status;
>>        |                                     ^~~~~~~~~
>> drivers/staging/octeon/ethernet.c:205:37: warning: unused variable 'tx_status' [-Wunused-variable]
>> drivers/staging/octeon/ethernet.c:204:37: warning: unused variable 'rx_status' [-Wunused-variable]
>>    204 |         struct cvmx_pip_port_status rx_status;
>>        |                                     ^~~~~~~~~
>> drivers/staging/octeon/ethernet.c: In function 'cvm_oct_probe':
>> drivers/staging/octeon/ethernet.c:801:22: error: variable 'imode' has initializer but incomplete type
>>    801 |                 enum cvmx_helper_interface_mode imode =
>>        |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/staging/octeon/ethernet.c:801:49: error: storage size of 'imode' isn't known
>>    801 |                 enum cvmx_helper_interface_mode imode =
>>        |                                                 ^~~~~
>> drivers/staging/octeon/ethernet.c:801:49: warning: unused variable 'imode' [-Wunused-variable]
>>
>> Bisect points to this patch. Bisect log attached.
>>
>> As usual, my apologies for the noise if this has already been reported
>> and/or fixed.
> 
> It has not been reported, thanks for it, I'll go revert the offending
> commits.  And I need to figure out how to build this driver better, I
> get no build-failures from anyone for it when stuff like this happens,
> odd...
> 

This is kind of chronic. One really has to build mips:cavium_octeon_defconfig
to find Octeon related problems. The all{mod,yes}_defconfig builds don't build
that code.

Guenter

