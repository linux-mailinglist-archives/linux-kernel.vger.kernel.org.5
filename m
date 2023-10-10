Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542797BF920
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 13:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjJJLDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 07:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjJJLDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 07:03:30 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA1194
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:03:25 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9b2cee40de8so1196737766b.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 04:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1696935803; x=1697540603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c/i7ipb8PJg3s3t17cpJlp3LtfS+T2lfExRkpf/9NCg=;
        b=QBBPfyiLiCjxvEs1M5/xgiG1UtkKWvNZJnd2LZnLweo57pfET6lsqAP9WPp0f61E9e
         LXjQsWhQ8QfvL1JL8PBWpz0o5vMC75reVsUGocVL3aEQd8XIPWw+yDulmCR3JFl2In6w
         lWmX4mD+WnR7gUjnT6xZZTGAHEPL9/ZIRPfP0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696935803; x=1697540603;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c/i7ipb8PJg3s3t17cpJlp3LtfS+T2lfExRkpf/9NCg=;
        b=m7LbhOZeiQ8WZYvm5gF8brY9Hv1sWjY3G5uSbOovmuIMhoBAuXa5e7/C9O72wZfKxn
         dDZMvJMLVjoU21hJnXc9Jt/nbXLx/GDsAE4F4CvTEso9hqEEx8y1xac05KGPFoa8zRKy
         NM/m6VDyPw2EBgbdE79vkX9hdVOAN05AIMOS9irQz5qY4n4+0PjJuVAZHa2aqlpfsGt4
         fHizTQFu9gWS7b8bBO1WDRsYEPJsgJXkkRNYtULzyKuHfND3odmQ+vJDBr5niacYDs/n
         prLgFYRsE1e/XSV+IC7Xm485wD6b3rSNYzV1bsjt6ijFOiudoJ/LFV3Mp45gj5aTt8zO
         qzFQ==
X-Gm-Message-State: AOJu0YzNTZr9+mIYOPVyZp19hvCUn3RPCY28WC918EJFCgI+TKz2ToLy
        SEZeu4ZoSa3nh4yswq22rrkNgw==
X-Google-Smtp-Source: AGHT+IF9+d4mN7xoZYchdJjQ3IiIZ2nhmPkSZJPHHofNCryjQ+9y5+Zl/K8WNr7qcFmRwY7+ISXPWQ==
X-Received: by 2002:a17:906:3109:b0:9b6:3be9:a8f with SMTP id 9-20020a170906310900b009b63be90a8fmr14031157ejx.20.1696935803530;
        Tue, 10 Oct 2023 04:03:23 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id lf1-20020a170907174100b00992b2c55c67sm8279098ejc.156.2023.10.10.04.03.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Oct 2023 04:03:23 -0700 (PDT)
Message-ID: <76db1532-1575-614e-5820-5b0fa49863c9@rasmusvillemoes.dk>
Date:   Tue, 10 Oct 2023 13:03:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 1/5] lib/bitmap: add bitmap_{read,write}()
Content-Language: en-US, da
To:     Alexander Potapenko <glider@google.com>,
        Yury Norov <yury.norov@gmail.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, andriy.shevchenko@linux.intel.com,
        aleksander.lobakin@intel.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
References: <20231006134529.2816540-1-glider@google.com>
 <20231006134529.2816540-2-glider@google.com> <ZSCLuCu9yMyDdHni@yury-ThinkPad>
 <CAG_fn=XHiVyRO-JiOSFREgJjXWjU9Zc1CCMPYV2Xx4LA8P8tkA@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <CAG_fn=XHiVyRO-JiOSFREgJjXWjU9Zc1CCMPYV2Xx4LA8P8tkA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2023 11.17, Alexander Potapenko wrote:

>> 'behaves similarly' sounds like an understatement. I think, it behaves
>> much faster because it can assign up to 64 bits at once, not mentioning
>> the pressure on cache lines traffic.
> 
> My intent was to describe the visible behavior, of course the
> generated code is better, and the number of memory accesses lower.
> 
> How about the following description:
> 
>  * The result of bitmap_write() is similar to @nbits calls of assign_bit(), i.e.
>  * bits beyond @nbits are ignored:
>  *
>  *   for (bit = 0; bit < nbits; bit++)
>  *           assign_bit(start + bit, bitmap, val & BIT(bit));
> 
> ?

C programmers should know the meaning of the term "as-if". Perhaps use
that. Smth like "bitmap_write() behaves as-if implemented as @nbits
calls of __assign_bit()".

Rasmus

