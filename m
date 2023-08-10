Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1856F776CED
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 02:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjHJACH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 20:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjHJACF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 20:02:05 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F324610C7;
        Wed,  9 Aug 2023 17:02:04 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-790b080f2a0so11310939f.3;
        Wed, 09 Aug 2023 17:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691625724; x=1692230524;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EF+Snm3LPKa5i9E9cWjF1nNNGnPQLRfTgbDA8zjNdbk=;
        b=Dd2n+fPolV391XO1325lLVXo0jdfI7gv3uMWYURFJtlWewtozwPdQBkSm/C25dS/P1
         a4AqnZyUE0A1bMnxH3gvoBXE4GB8jll2kjjHAZgCaPKxP1H7gXgY3TOkUmYGGNRhluAB
         IqA0ZUw9H4ekvcn93mWMqUkmxlH8Qi+TnfQwX6jHjUPw9u+A8ZyEd5D9G4GPMoZhg81m
         CqpY58l9caM6X32skyWeJNGznqxxbsPFUWIicmWRaOWUwincBwwVxW7PXX6LwgFrXa/d
         NHFRsS+iQ7ofI9ILv884GFIqZkK833Pr4VtCFjTnWGrvuMoz8C6cOGaVB32MU29Osr44
         ejYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691625724; x=1692230524;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EF+Snm3LPKa5i9E9cWjF1nNNGnPQLRfTgbDA8zjNdbk=;
        b=iU1zV4I6N3LeNNfhVRmNTNF37ZvT1/RCVGGKg1ZMdwz0Y4jhrRz5Y3RtISoCpnS5xb
         z5bTQzQPDG1PikeebAdsFEegykwG105HptzS21gmmnas7u2zJ5mNZdh2t6kBprwNvJTP
         gIAWwHMdR+XZUEGQ/9FRBxwgL+hJKbtTp+Id7XqY6v2rbj1zi7j1uDCrXoxC/H97eOYN
         Nav0+yJqRJ1zmsUjSxj+uhWl8osOH9jJd9f5RFL5FYb0TTcipI6LTh4zx194iFD/A1Rx
         Q2z04mAtIOLOaJFpmZcbsq8THL6YAIqHdjpKdZy2XVpxj6eUFX2z0YRxBCZPaEck0GkV
         IspQ==
X-Gm-Message-State: AOJu0YwfaVqdg2xkGYvN/jK6YGz7pJbCdcBPZNWaqQcSy9opYAh95WsL
        PMuVRZP2cxfQpfxj0EwBffM=
X-Google-Smtp-Source: AGHT+IEiVZBmnS9iXDo9uJAhz0/UT8J3BjEuH/7nsPv6jgX5u/ukXenen6oQgOhCZN4wuTxgnhlcyQ==
X-Received: by 2002:a5e:8a48:0:b0:791:7e14:4347 with SMTP id o8-20020a5e8a48000000b007917e144347mr825847iom.13.1691625724236;
        Wed, 09 Aug 2023 17:02:04 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g3-20020a0566380c4300b004311d1cdef1sm45441jal.169.2023.08.09.17.02.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 17:02:03 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <5958e9a8-ce46-e738-ddfb-722d38ab2b18@roeck-us.net>
Date:   Wed, 9 Aug 2023 17:02:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <yujie.liu@intel.com>,
        kunit-dev@googlegroups.com
References: <20230721-clk-fix-kunit-lockdep-v1-0-32cdba4c8fc1@kernel.org>
 <088cc246369820d5a426bc8823c85c8e.sboyd@kernel.org>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 0/2] clk: kunit: Fix the lockdep warnings
In-Reply-To: <088cc246369820d5a426bc8823c85c8e.sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/23 16:21, Stephen Boyd wrote:
> +kunit-dev
> 
> Quoting Maxime Ripard (2023-07-21 00:09:31)
>> Hi,
>>
>> Here's a small series to address the lockdep warning we have when
>> running the clk kunit tests with lockdep enabled.
>>
>> For the record, it can be tested with:
>>
>> $ ./tools/testing/kunit/kunit.py run \
>>      --kunitconfig=drivers/clk \
>>      --cross_compile aarch64-linux-gnu- --arch arm64 \
>>      --kconfig_add CONFIG_DEBUG_KERNEL=y \
>>      --kconfig_add CONFIG_PROVE_LOCKING=y
>>
>> Let me know what you think,
> 
> Thanks for doing this. I want to roll these helpers into the clk_kunit.c
> file that I had created for some other clk tests[1]. That's mostly
> because clk.c is already super long and adding kunit code there makes
> that problem worse. I'll try to take that patch out of the rest of the
> series and then add this series on top and resend.
> 
> I don't know what to do about the case where CONFIG_KUNIT=m though. We
> have to export clk_prepare_lock/unlock()? I really don't want to do that
> even if kunit is enabled (see EXPORT_SYMBOL_IF_KUNIT). Maybe if there
> was a GPL version of that, so proprietary modules can't get at kernel
> internals on kunit enabled kernels.
> 

EXPORT_SYMBOL_IF_KUNIT defines a module namespace. You could go a step
further and define a CLK_KUNIT module namespace or similar. That would
of course still permit abuse, but it would have to be _very_ intentional.
There is an EXPORT_SYMBOL_NS_GPL(), so you could further restrict it
to GPL only.

Guenter

