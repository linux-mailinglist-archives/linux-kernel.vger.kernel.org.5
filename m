Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BDAB75B41F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 18:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjGTQZq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 12:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjGTQZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 12:25:45 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344D811D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 09:25:44 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6687446eaccso838398b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 09:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689870343; x=1690475143;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Yn/575ym0TaFIQctLLsNsaeMsWfyk2kbdLWYzyjH6KI=;
        b=ZBMD60DwZKp0yM7rv7p8FTx7me9yNb9SQwbIXEmXU3sGA/D+PVGtjSbEWBruvzbHRn
         q+CP98Q/B5TDY+FRtIWrNYFmtIecxk8cAcm8e6/vp9BLCJR1/hPtbc/paUu3xI5q12qo
         hbwcWaDA1VL1dlha5h5FzAkqOF/RRsSSQIrKjg2n3DyCnWQ2MTos2xe+2jchzwqbXyUY
         Kkycvuchv27ncULlsqfjeaR+lCgWEzOvKDGaSJ2tr5VJqqzy/a3B8iuGPLG1c97ImdOA
         BJ6pF+56sd7NCgxdrkaB5Gzj4nhDxEWCcw14Qdjf0sBtYKXosEiogzVYa2lHVf49Ho2M
         kBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689870343; x=1690475143;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Yn/575ym0TaFIQctLLsNsaeMsWfyk2kbdLWYzyjH6KI=;
        b=ZC5DNrEuBpagn8Sg8OGU7nypgs12ZrrxOimrrkkqaoM+3dwdcNn343bHHSulJ1Cgwn
         FKVk+sakP6te762XTqMZiVubYQI+MdWxNCwAw8dfSQSjU3rPGALBVd9v1m4xOh/lEGQ7
         H5QlgbIeALjCKoQlpQ7Bcp0PqFuoP8PZ5mmqda43rXURAGCvjR7AfovqGoeto8qFjcD4
         WfCKZpT7us3ZLM6WotgSw35TWkeA25bQq062J3H3gf+CFBJeL4Oaa658X0hEdk87uebO
         kaPJ5ToI8Q+mlZfjXsbALGV8ci2efwK5GEfEIm9az3DBesLA0+YpX/DyU8DMuC8rujrd
         vX7g==
X-Gm-Message-State: ABy/qLYHYgvWrody32qWgHyYQg3CMGKmMz7wZ0jpFGGtw+lKiAqPr04I
        ZU5WGaYhjEMpWI+/6YFT7nI=
X-Google-Smtp-Source: APBJJlHJorx5b/unJvujA+QA02FIrynR0JYh+lJuI0EGB88KSaabBYPW5EzsOj+7J/Hdgkq0QTg22w==
X-Received: by 2002:a05:6a20:2452:b0:137:2204:4ea6 with SMTP id t18-20020a056a20245200b0013722044ea6mr7065598pzc.27.1689870343553;
        Thu, 20 Jul 2023 09:25:43 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id w22-20020a63af16000000b00548d361c137sm1412731pge.61.2023.07.20.09.25.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Jul 2023 09:25:43 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e3799cbf-daf2-c805-4c70-09679c4b6cf5@roeck-us.net>
Date:   Thu, 20 Jul 2023 09:25:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Dan Carpenter <dan.carpenter@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
References: <ee59d128-413c-48ad-a3aa-d9d350c80042@roeck-us.net>
 <336fc14e-f734-49ea-97ce-802f03fa4422@kadam.mountain>
 <198c4edf-045c-8d85-1d5c-018378eeb490@roeck-us.net>
 <055f2564-551d-4b5f-a6e3-d54ae104d5c9@sirena.org.uk>
 <d29552c2-f20c-cf68-76ae-e03a2cc7e0ba@roeck-us.net>
 <12e6144c-0d24-4556-beef-d754273992e4@sirena.org.uk>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: Traceback with CONFIG_REGMAP_KUNIT=y+CONFIG_DEBUG_ATOMIC_SLEEP=y
In-Reply-To: <12e6144c-0d24-4556-beef-d754273992e4@sirena.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/20/23 08:07, Mark Brown wrote:
> On Thu, Jul 20, 2023 at 08:03:13AM -0700, Guenter Roeck wrote:
>> On 7/20/23 07:31, Mark Brown wrote:
> 
>>> They're both independently fine, but I wouldn't expect anything that's
>>> running in atomic context to be actually using dynamic allocations.
> 
>> Which one do you prefer ? As I mentioned in my second patch, there are
>> two drivers which use fast_io together with REGCACHE_RBTREE and thus
>> are likely affected by this problem. Dan's solution would cover that,
>> while my current RFC patch would likely cause those drivers to fail.
>> Plus, of course, they could get stuck if they actually end up trying to
>> sleep while allocating memory.
> 
> Like I say I don't think it's an either/or - we can do both
> independently, they both make sense standalone and don't conflict with
> each other.

I guess I am missing something. I have not tried it, but wouldn't my patches
be unnecessary if Dan's patch is applied ?

Thanks,
Guenter

