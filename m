Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC767A7493
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 09:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233971AbjITHpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 03:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbjITHop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 03:44:45 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAFC1E8;
        Wed, 20 Sep 2023 00:44:38 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-400a087b0bfso68845785e9.2;
        Wed, 20 Sep 2023 00:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695195877; x=1695800677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XzT+Xiw8JySJKyD7hHrg/jFpbzpL9ozxt4Lqd8Kjts4=;
        b=bA3jdgYNN8fGAyxxIZrFC+df4Ag5Sr/1FxNbfFI3uDzU6DdyR/Jk2aFVWECaP7+f2Z
         7iMoRrG2xe10GRY3OoU8+m9jFnU5Yj3iUaJsunTJmsMF2mIEQybQBbxnfomKOgrOZ9LL
         c9dbc7fU6yC93Bjcpikgf6lIu416z+KPrxLWAjPd2xMCopd8FNnqS4dljakybQT2qlS6
         3UdG2gZ7MpCd36zg9o4NBOAK3uoVDHb5kDTrjjZ430Hl+KQUatUI462JmhZnoRaI4zsm
         Sv74pe7Wy3ocyfkUSWS8cayXfmna/N7Xp47zbSOj+n+5erfy8MDC9WnM/jIZNmrawxdU
         fnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695195877; x=1695800677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XzT+Xiw8JySJKyD7hHrg/jFpbzpL9ozxt4Lqd8Kjts4=;
        b=dTtAs54f2DXqdZB1OPFHNV9HPzAfsA6J6MTsOAzpNvCgW5MzsK0H7x+3R1hO9OnQ7o
         ZTkk/GJwzDSdfJ9YtkryTS0H8k1ObSaTeR+mbOFe7xO+9VQCmIRmPYxDgI0dO0aOVyXW
         hHoIXK+c5euNP96MjAo8G6mmJzKR4NT4YUp+sZFbHQ27OAdUqB5vaMb0tp0vMX3Tu0ev
         5Dc1mLJ9msgI4BjZ07asgEvDNq/UiaP/cn4VhEwEW2mNP/ry78/jqp1Bz4HjBs6vmR48
         MiwgRhWk7afCzjjBmK/8RMTRvZiHmAZQscUY8CA0NqY/B7qyKMgJM5Z13gICd0vAT6F2
         J4Mg==
X-Gm-Message-State: AOJu0YwESKQvDZULTVJ78e36dSQl5+lHSnTCk1rKTGMhiD+cPLVMfM6r
        hcvyUaBojimXdexpfXzCrXs=
X-Google-Smtp-Source: AGHT+IGGJqNN92cz5c7adAH7+BYpcEYHIa0hDUrWov+ACoikEcq6k5usOPuqM5OZepDWyc7c5KEP/w==
X-Received: by 2002:a1c:ed08:0:b0:405:1bbd:aa9c with SMTP id l8-20020a1ced08000000b004051bbdaa9cmr1709320wmh.34.1695195876972;
        Wed, 20 Sep 2023 00:44:36 -0700 (PDT)
Received: from gmail.com (1F2EF265.nat.pool.telekom.hu. [31.46.242.101])
        by smtp.gmail.com with ESMTPSA id f7-20020adff987000000b0031c8a43712asm17606651wrr.69.2023.09.20.00.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 00:44:36 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Wed, 20 Sep 2023 09:44:33 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Matteo Rizzo <matteorizzo@google.com>
Cc:     "Lameter, Christopher" <cl@os.amperecomputing.com>,
        Dave Hansen <dave.hansen@intel.com>, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net, luto@kernel.org,
        peterz@infradead.org, jannh@google.com, evn@google.com,
        poprdi@google.com, jordyzomer@google.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 00/14] Prevent cross-cache attacks in the SLUB
 allocator
Message-ID: <ZQqi4RqpEM7PRGkF@gmail.com>
References: <20230915105933.495735-1-matteorizzo@google.com>
 <7a4f5128-28fd-3c5f-34c2-1c34f4448174@intel.com>
 <1d7573c0-ebbc-6ed2-f152-1045eb0542f9@os.amperecomputing.com>
 <CAHKB1w+rVyww0UrHhzeGfPA7FM482Z-7ApzXvekVqLHvTDAV3Q@mail.gmail.com>
 <ZQiLX0W2Tcr+wdJT@gmail.com>
 <CAHKB1wKneke-dyvMY0JtW-xwW8m=GaUdafoAqdCE0B9csY7_bw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHKB1wKneke-dyvMY0JtW-xwW8m=GaUdafoAqdCE0B9csY7_bw@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Matteo Rizzo <matteorizzo@google.com> wrote:

> On Mon, 18 Sept 2023 at 19:39, Ingo Molnar <mingo@kernel.org> wrote:
> >
> > What's the split of the increase in overhead due to SLAB_VIRTUAL=y, between
> > user-space execution and kernel-space execution?
> >
> 
> Same benchmark as before (compiling a kernel on a system running the patched
> kernel):
> 
> Intel Skylake:
> 
>       LABEL    | COUNT |   MIN    |   MAX    |   MEAN   |  MEDIAN  | STDDEV
> ---------------+-------+----------+----------+----------+----------+--------
> wall clock     |       |          |          |          |          |
> SLAB_VIRTUAL=n | 150   | 49.700   | 51.320   | 50.449   | 50.430   | 0.29959
> SLAB_VIRTUAL=y | 150   | 50.020   | 51.660   | 50.880   | 50.880   | 0.30495
>                |       | +0.64%   | +0.66%   | +0.85%   | +0.89%   | +1.79%
> system time    |       |          |          |          |          |
> SLAB_VIRTUAL=n | 150   | 358.560  | 362.900  | 360.922  | 360.985  | 0.91761
> SLAB_VIRTUAL=y | 150   | 362.970  | 367.970  | 366.062  | 366.115  | 1.015
>                |       | +1.23%   | +1.40%   | +1.42%   | +1.42%   | +10.60%
> user time      |       |          |          |          |          |
> SLAB_VIRTUAL=n | 150   | 3110.000 | 3124.520 | 3118.143 | 3118.120 | 2.466
> SLAB_VIRTUAL=y | 150   | 3115.070 | 3127.070 | 3120.762 | 3120.925 | 2.654
>                |       | +0.16%   | +0.08%   | +0.08%   | +0.09%   | +7.63%

These Skylake figures are a bit counter-intuitive: how does an increase of 
only +0.08% user-time - which dominates 89.5% of execution, combined with a 
+1.42% increase in system time that consumes only 10.5% of CPU capacity, 
result in a +0.85% increase in wall-clock time?

There might be hidden factors at work in the DMA space, as Linus suggested?

Or perhaps wall-clock time is dominated by the single-threaded final link 
time of the kernel, which phase might be disproportionately hurt by these 
changes?

(Stddev seems low enough for this not to be a measurement artifact.)

The AMD Milan figures are more intuitive:

> AMD Milan:
> 
>       LABEL    | COUNT |   MIN    |   MAX    |   MEAN   |  MEDIAN  | STDDEV
> ---------------+-------+----------+----------+----------+----------+--------
> wall clock     |       |          |          |          |          |
> SLAB_VIRTUAL=n | 150   | 25.480   | 26.550   | 26.065   | 26.055   | 0.23495
> SLAB_VIRTUAL=y | 150   | 25.820   | 27.080   | 26.531   | 26.540   | 0.25974
>                |       | +1.33%   | +2.00%   | +1.79%   | +1.86%   | +10.55%
> system time    |       |          |          |          |          |
> SLAB_VIRTUAL=n | 150   | 478.530  | 540.420  | 520.803  | 521.485  | 9.166
> SLAB_VIRTUAL=y | 150   | 530.520  | 572.460  | 552.825  | 552.985  | 7.161
>                |       | +10.86%  | +5.93%   | +6.15%   | +6.04%   | -21.88%
> user time      |       |          |          |          |          |
> SLAB_VIRTUAL=n | 150   | 2373.540 | 2403.800 | 2386.343 | 2385.840 | 5.325
> SLAB_VIRTUAL=y | 150   | 2388.690 | 2426.290 | 2408.325 | 2408.895 | 6.667
>                |       | +0.64%   | +0.94%   | +0.92%   | +0.97%   | +25.20%
>
> 
> I'm not exactly sure why user time increases by almost 1% on Milan, it 
> could be TLB contention.

The other worrying aspect is the increase of +6.15% of system time ... 
which is roughly in line with what we'd expect from a +1.79% increase in 
wall-clock time.

Thanks,

	Ingo
