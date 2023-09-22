Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510767AA6CA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 03:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbjIVBxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 21:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjIVBxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 21:53:23 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99871E8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 18:53:16 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-3226cc3e324so804938f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 18:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695347595; x=1695952395; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWG5Cr/URo6om9dDoGNWRX1ofAGukQSqmfRjr+ASakU=;
        b=AS7UIEvhpsdajLM3K/oaSkm1jj5kphfE90BaDbDboUZ0+WHWawU//XyOXFa8El3vyJ
         KZKReYZ0uQkNHM3/grdz69glniKk+sWNQUs2HqZdl+igPy2Y7J2ZbvY+NHnajYbC0Y4r
         06EsstYShRjjh/DbyzYbHAH7seACAJ/Xx0miSpXuhS2LkYHg/rTKdD+GHJzt9iavelpA
         4Pyd5uLOdOIPTGaGgTkJk0w4ql4NJI8fSx9tjX6aSI52QLUP0cgB//Qb0a9HEvXom+fu
         86x9Wae8HBoz7T1YUKvXWeGbd9YxDM+xoyKHbKf4qIJ84uaL4lfYCgbcDRjiWLQ3M/0L
         ER5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695347595; x=1695952395;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:references:cc:to:subject:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pWG5Cr/URo6om9dDoGNWRX1ofAGukQSqmfRjr+ASakU=;
        b=tNFeLmU59CMA9a8rWfqwCCb6dit5eqsNmzCjfHNgz7ZDu/qwBiWhMqqd/b80DRQcp+
         R1Vp+VaqxINc9R5ynb8mr8ncK3hywX3h4Zlr690pveICK1y4R/4Sk/IB13hp3ogoSghG
         O6kOj4w4UOawzpDZJWkPPKbRkQ+995PZoO6vVk+4U2Q02uz7AuOZUCK736OUPdS8GsH5
         A45QEr/a0fj4ly0gCtaFgxNDMmck2YynRRyXXs3OGf07xzt10CgniGA83djKybjTuAO3
         bbY0PKM3p5sCYh3fJw08mLoeCdYHMhaXrJIyw9GvgruGVyl7lhQTcA9wWkbAfZlFrWQ8
         5iOw==
X-Gm-Message-State: AOJu0YzxeezmREudC4TvSa+iwF+uqmsZ/nDf0KmvBe5rdomEsGkmGg/R
        kXQbtUyA8NnQ7f6nX1R7yEvIM4DDaz/zXg==
X-Google-Smtp-Source: AGHT+IE6VMM8fZvXMtEZpy6J/0+KRj8mxtNRIEQeFpdKCP0/7G8jsnYnQdVu1PEcgGwtSo38u5Ph1g==
X-Received: by 2002:a5d:5184:0:b0:320:6f4:a200 with SMTP id k4-20020a5d5184000000b0032006f4a200mr6018539wrv.10.1695347594742;
        Thu, 21 Sep 2023 18:53:14 -0700 (PDT)
Received: from [192.168.1.6] (dynamic-093-132-179-053.93.132.pool.telefonica.de. [93.132.179.53])
        by smtp.googlemail.com with ESMTPSA id r8-20020a5d4e48000000b00315af025098sm3071139wrt.46.2023.09.21.18.53.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 18:53:14 -0700 (PDT)
Subject: Re: arch/m68k/include/asm/raw_io.h:91:13: warning: array subscript 0
 is outside array bounds of 'volatile u16[0]' {aka 'volatile short unsigned
 int[]'}
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh@kernel.org>
Cc:     kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>
References: <202309192013.vI4DKHmw-lkp@intel.com>
 <CAL_JsqJ0BoR7Dan3=oyWPa6HU3YV=eOFTO5fx7u5zz2i=eB-jQ@mail.gmail.com>
 <a57afd40-71a2-aa68-84cb-44d2a88a1e2b@roeck-us.net>
 <CAL_JsqJYPJVTxH=d5nYK78+ZWhZAfh4VhEyBLqzyg4MzMhrX0g@mail.gmail.com>
 <194e2d22-9eff-ec6c-9bc9-13b62bda870a@roeck-us.net>
 <CAL_JsqKcD4AttSVUEi5zuF8S1E4xNdqdZVKiHmk0r79SRW5Cqw@mail.gmail.com>
 <ad1f36ab-29a6-98b6-8782-3980323760e1@roeck-us.net>
 <CAMuHMdXsiSfp3DGnLXfuENVLOdG91a+GXj3+g9p8Yp6aGTuqDQ@mail.gmail.com>
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <fe7e6c19-916e-a30b-6f59-df03812fa431@gmail.com>
Date:   Fri, 22 Sep 2023 13:53:13 +1200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXsiSfp3DGnLXfuENVLOdG91a+GXj3+g9p8Yp6aGTuqDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

Am 21.09.23 um 19:08 schrieb Geert Uytterhoeven:
> Hi Günter, Rob,
>
> CC Michael
>
> On Wed, Sep 20, 2023 at 11:09 PM Guenter Roeck <linux@roeck-us.net> wrote:
>> On 9/20/23 09:20, Rob Herring wrote:
>> [....]
>>
>>>> Sure, but I still argue that this isn't worth it for drivers like this one.
>>>> Are you going to submit a fix ? Because otherwise I'll submit a patch
>>>> to drop COMPILE_TEST from MACHZ_WDT.
> I think dropping COMPILE_TEST from MACHZ_WDT is the right thing to do
> anyway.  Unlike most other drivers, this is not a driver that can be
> compiled in, and doesn't do anything if the hardware is not present.
> In fact it is a very dangerous driver: its probe function "reads" the
> ZF version register, but that involves doing an unconditional write,
> which might crash any non-X86 system.
>
> IMHO a driver must not be enabled for compile-testing if its presence
> can harm the system.
>
>>> I honestly don't know what the fix is. There's a compiler flag to
>>> allow 0 address, but that seems like a big hammer. From what I read on
>>> the fix for gcc-12, we shouldn't be getting this, but I haven't
>>> confirmed. I was hoping for comment from Geert as the issue doesn't
>>> appear to be the driver, but the arch code.
> Well, Atari ROM port ISA accesses are really weird, due to the really
> weird way the bus is wired to the address/data lines...

Putting it mildly ...

> The issue is that gcc considers accessing these addresses as "not
> done"...
That an new GCC problem?
>>> Furthermore, I just built the same HEAD and config as reported and
>>> don't see this error. I'm using kernel.org nolibc gcc 13.2.0 which
>>> should be the same version.
>> Exactly my point. So now we are stuck with a report like this on a
>> driver which probably has 0 users and we don't know how to fix it,
>> all to get the benefit of being able to compile it for an architecture
>> and platform which will never use it.
>>
>> I seem to recall similar errors with m68k and COMPILE_TEST last time
>> I tried to enable it on watchdog drivers, so I am not sure if this is
>> entirely new.
> Probably not.
>
> Michael: original build failure report in
> https://lore.kernel.org/r/202309192013.vI4DKHmw-lkp@intel.com/

From what I can see, DATA_W appears to be zero - maybe the driver needs
to set 'sane' values for IO ports if compile tested on non-ISA
architectures?

In the alternative, we might have to prevent setting ATARI_ROM_ISA if
COMPILE_TEST is set.

Cheers,

    Michael


>
> Gr{oetje,eeting}s,
>
>                         Geert
>
