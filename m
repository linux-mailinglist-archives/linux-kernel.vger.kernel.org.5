Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3835D77DCE0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 10:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243180AbjHPI7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 04:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243165AbjHPI6p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 04:58:45 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA4A1990
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 01:58:43 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-5257f2c0773so1053182a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 01:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google; t=1692176322; x=1692781122;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TBVLZWW4k19jCQWKycvded1nNFPSzR3otgm6sEXkniU=;
        b=BEaALTIoQNz5OxjB1gIK7MSHwVnhahh62pwc4x/pjkmrvl+LoihC9+JVf3SFWAbfEM
         e02ARV/+FwXYIjg1uAumB5xLeyLbAHl6IMm1RK+5GseZN6DJmYN0jYq4fRRq557G204A
         frzk4zCkqH+TpPmA2CFRK39ci2bsi3mDJsXAA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692176322; x=1692781122;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TBVLZWW4k19jCQWKycvded1nNFPSzR3otgm6sEXkniU=;
        b=XQUfm+rpurt2gYHaniPxkncpEiMF6+i+9Ogfl8u0lTUo21e4EbWOSV5CSNHvixzqbZ
         /LugNBfp5FsOYxkrtIcA7vmZWhnysDxMIu0XgP152DQSoDh5HPbszVrIVrrXeOn+kIqB
         1VDLH2UCciQajOAAcs1A3qK5Kod6V5sS+oZjfjvYuOz4VRPFH7HU3khpHamARdkHEqa6
         dYEzQmZhA2ZknUllXTwfi4kvlVIj/o71noMGSreRZf+LPBbD3mOhNUu0XrSQNJPNl5Zx
         cEeq1x86Ceok56y1B66YqAFz9cmeVwaOxj8FrIhbWXBjgl6bUJbKWmEgbxzo8PYdd+Ri
         KLXg==
X-Gm-Message-State: AOJu0Yw1ptUXNXumPxc/yDeFQOAAEXzhhmZIbV2D+4Ka+o5dwLvrxwha
        GyCxRBKu6jj0YYPKBJII2rDgSg==
X-Google-Smtp-Source: AGHT+IHf/PdnrorhK1FAvJtndFcxXmWbhU3HODQZY/m00yi43QKWPNuFDETogXUZlqJ4OgaFCqN++Q==
X-Received: by 2002:aa7:d1ce:0:b0:523:d1e0:7079 with SMTP id g14-20020aa7d1ce000000b00523d1e07079mr1050045edp.21.1692176322346;
        Wed, 16 Aug 2023 01:58:42 -0700 (PDT)
Received: from [172.16.11.116] ([81.216.59.226])
        by smtp.gmail.com with ESMTPSA id l10-20020aa7c3ca000000b005255ddb67c7sm4306722edr.40.2023.08.16.01.58.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Aug 2023 01:58:41 -0700 (PDT)
Message-ID: <cd4a78f5-a9fc-640a-8ebf-02969620abc4@rasmusvillemoes.dk>
Date:   Wed, 16 Aug 2023 10:58:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: cleanup: Make no_free_ptr() __must_check
Content-Language: en-US, da
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20230815105204.GA927051@hirez.programming.kicks-ass.net>
 <fcc8a158-f6e4-8963-782f-ba04b47350b8@rasmusvillemoes.dk>
 <20230815135339.GA966323@hirez.programming.kicks-ass.net>
 <a68424ff-b5e5-4dab-5705-5b63084c98eb@rasmusvillemoes.dk>
 <CAHk-=wiOXePAqytCk6JuiP6MeePL6ksDYptE54hmztiGLYihjA@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <CAHk-=wiOXePAqytCk6JuiP6MeePL6ksDYptE54hmztiGLYihjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/08/2023 10.00, Linus Torvalds wrote:
> On Wed, 16 Aug 2023 at 07:23, Rasmus Villemoes <linux@rasmusvillemoes.dk> wrote:
>>
>> Ah, ok, I thought the purpose was to ensure the p expression gets
>> evaluated. Well, we can still do without the temp var and weird comma or
>> statement expressions:
> 
> Well, the statement expression version with that types temporary
> pointer was much better than yours, which just randomly returns 'void
> *' and then lets the user assign it to any random pointer with no
> warning.
> 
> But I think you can add just a 'typeof(p)' cast to it and that should
> work out ok. 

Yes, that was an omission, and probably any version will need to have
that cast.

> But all of those macros seem to be fundamentally buggy because 'p'
> gets evaluated twice. It could have side effects, even when just
> having its address taken.

True. I don't know how I convinced myself that & behaved like sizeof(),
probably because I ran with my first "this seems to just be to ensure p
gets evaluated" interpretation. For my own education, '&(foo[bar])' is
by definition equivalent to 'foo + bar', and both foo and bar can be
mostly arbitrary expressions (subject to one being a pointer and the
other an integer). Similarly for &(*foo).

> At that point the whole "comma or statement expression" discussion is
> entirely immaterial.
> 
> So I think it needs to be something like
> 
>   #define __get_and_free_ptr(p) \
>       ({ __auto_type __ptr = &(p); \
>          __auto_type __val = *__ptr; \
>          *__ptr = NULL;  __val; })
> 
> to deal with the "assign NULL and return old value without double evaluation".
> 
> And then you can have a wrapper macro to do the __must_check part,
> something like
> 
>   static inline __must_check
>   const volatile void * __must_check_fn(const volatile void *val)
>   { return val; }
> 
>     #define no_free_ptr(p) \
>         ((typeof(p)) __must_check_fn(__get_and_free_ptr(p)))
> 
> the above is entirely untested. Of course.

I think it should work, the final cast both gives the right type and
removes any unwanted const or volatile qualifiers. It's the same thing
we ended up doing in overflow.h.

While I'm embarrassing myself in public: since p is really only supposed
to be a local auto variable with __cleanup attribute, one could throw in
some ## games to try to prevent no_free_ptr() from being used on other
kinds of lvalues, something like adding "extern int bla_ ## p ## _bla;"
inside __get_and_free_ptr().

Rasmus

