Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2436803EDB
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjLDT5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjLDT5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:57:10 -0500
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22AEC1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:57:15 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1faea6773c9so2724815fac.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 11:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1701719835; x=1702324635; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SBTfgpI7c2ac59dT9wiC8J/GPNEeE/8u5o5TG4ssEQ4=;
        b=fhmp8ounvakzsyada1KC6PTtZwKjGMLx0HfFFzpB3k0J5DYAn4tTZYmuYo27TMfu6P
         AC+sDKWTPHkSW6suXieYbQ7yM+1o3gCKpZUz4BmO9/wCrfNqLsvXb8js0hNdvDbqXH/R
         P0guMe/VWq0OM37JM9rEyzwow4STHG/d9cl/FM5hypwUcRUeEbI91AEjmjc776eN2knv
         vtlm5F3d0TtPTWQEqRlgVwAN8/Lw9WOJY07FTy65c6nRRhaZBu5zNtkbK7ZsjlTSZ545
         qpWXIzjGPmNpuoOoV6DOQatQX8yO8HOervIKBBuGNrqPUFin0z6xGwdi/hLLA7BsVCJ8
         t0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701719835; x=1702324635;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SBTfgpI7c2ac59dT9wiC8J/GPNEeE/8u5o5TG4ssEQ4=;
        b=Pn8SygQ6jcAmFBbmm8UROjBdONEH6akCvNKuL+pA7CgZagbdGeKtWfFI368OXFKqSV
         VJ6wcF2szWZUURD01NVCmLLjvLYUFESSA73efIxlBh7MSP2Y3eBZ9KgjT9lFe/rwxOjs
         jikeX11AQEZv3ApRhOARE8/Z/Td5TWoi8WCOJCSlUIrfx98YctCnBP1irZ26ZEuNgKhM
         NzmMaqyjJjAiobgZttYknxFoGXiqZBgZ+iXJUQimO6G1h11/qETmibpsaNYrG7Ax72pe
         8DNIu9GTnNTLcRzP9aazA3hMYB4jQ5uEj0YUeslyxTYdUmKnmzn+RqZ8kZSk8yMn1O5M
         WNNg==
X-Gm-Message-State: AOJu0YxdUn+S+hFIm7ul1iaTbj6wSRGSfuSXLLg4ZOkKEZ5hwW2e36CQ
        g+FDQLXEaboC7YX5W9Czh2Rl3PvgGxc94w/LAm9T2dTjH56Yh7nt
X-Google-Smtp-Source: AGHT+IFOFahrQNa632EgBewrVs7SXeztT1nvDz+j8RxzpLp1TJG0AtGPq1vH8DB7jC4CehQb0sIPVHJSoNVZMFvqVIQ=
X-Received: by 2002:a05:6870:568c:b0:1fb:75b:2fd6 with SMTP id
 p12-20020a056870568c00b001fb075b2fd6mr5131473oao.109.1701719835169; Mon, 04
 Dec 2023 11:57:15 -0800 (PST)
MIME-Version: 1.0
References: <cover.1701168726.git.cmo@melexis.com> <c9db99819adb0cdd602394b27f97a3b8fe081148.1701168726.git.cmo@melexis.com>
 <20231204142224.51f2ccdf@jic23-huawei> <CAKv63usxdfOviH=M6iUiNTtBFZVOseWUGz63Q-oJniBDFvTpSQ@mail.gmail.com>
 <20231204170623.0c0cd598@jic23-huawei>
In-Reply-To: <20231204170623.0c0cd598@jic23-huawei>
From:   Crt Mori <cmo@melexis.com>
Date:   Mon, 4 Dec 2023 20:56:39 +0100
Message-ID: <CAKv63uuBjkqffEzVsJcsMKK3wYoShJ0gNU_X+=KrU1zicTVdEw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: temperature: mlx90635 MLX90635 IR Temperature sensor
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Andrew Hepp <andrew.hepp@ahepp.dev>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2023 at 18:06, Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Mon, 4 Dec 2023 16:34:30 +0100
> Crt Mori <cmo@melexis.com> wrote:
>
> > On Mon, 4 Dec 2023 at 15:22, Jonathan Cameron <jic23@kernel.org> wrote:
> > >
...
> > While in Sleep Step mode, the EEPROM is powered down, but the cache
> > buffers those values. Still when you try to write or read a volatile
> > register (which should not be prevented by cache enabled as per my
> > opinion, but code says differently) in that mode, it returns -EBUSY
> > (as we discovered by code), so this kind of manipulation is needed to
> > enable write and read operations from volatile registers.
>
> So the cache trick is just meant for the eeprom?  Can you use two regmaps.
> (I've seen similar done for devices with different ways of reading which
> this 'kind of' corresponds to).
> One to cover the eeprom and the other the registers that always work.
> That should let you separately control if they are in caching state or
> not.
> Or just read the eeprom into a manually created cache on boot?
>

It did not seem correct to create a manual cache, since regcache does
this job. I tried two separated regmaps, but when I tried to
initialize them I got into kernel panic/crash, so I could not get it
working on same device. Do you have any device in mind I could
template this against?

...
> > "invalid" data (shouldn't differ much, but I wanted to prevent that as
> > it might be 0).
>
> ok.  Just give a little bit more of that detail.  I'd not understood
> intent is to ensure one trigger -> one measurement.

OK.
> >
...
> >
> > Burst is from 90632 terminology (and our chip register map), but maybe
> > more general would be "trigger_measurement"?
>
> ok. But why only if in SLEEP_STEP?
>

Because in continuous mode (other mode used here) the measurement
table is constantly updated, so trigger is not useful and would only
slow down the reading. And I did not want to block the data retrieval
when person wants to read the data fast.

> >
> > > > +static int mlx90635_get_refresh_rate(struct mlx90635_data *data,
> > > > +                                  unsigned int *refresh_rate)
> > > > +{
> > > > +     unsigned int reg;
> > > > +     int ret;
> > > > +
> > > > +     if (data->powerstatus == MLX90635_PWR_STATUS_SLEEP_STEP)
> > > > +             regcache_cache_only(data->regmap, false);
> > >
> > > Definitely needs a comment on why this is needed in this case.
> > >
> >
> > Here and below (where we turn it back to true?), but then I assume in
> > all other instances as well? Maybe a more general comment in the
> > sleep_step mode function?
>
> If we keep this, then yes I think we need comments on these - even if
> it's as simple as 'not accessing an eeprom register so we want to
> talk to the device'.

OK, then this is an option if I cannot make two regmaps work.

> >
> > > > +
...
> > changed we should end up in correct state. I can wrap a mutex around
> > though.
>
> Assuming regcache_cache_only() isn't refcounted, you could end up with a
> second copy of this racing through and accessing the data after the
> first one turned the cache back on so the -EBUSY your mentioned.
>

True. I will use mutex then for this action.
