Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771CB7EBE8F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 09:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343514AbjKOI07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 03:26:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbjKOI05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 03:26:57 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBC5DF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 00:26:52 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-7bb2e625165so2530179241.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 00:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700036811; x=1700641611; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9jKwR1gpSfQdTlAXjlEEGIRRbRHY5oxkajkqLsICLD8=;
        b=xu1FklQ6VC7Rl05WPc5H4Q3Sx481SVkm/3SChGOkBEcmkLrH/z3AWEXo9DtoG02XBT
         eb8cBjoM6oCxhvquvDNDREYxQo3XRsaCGNi0uc7VE80JiJHYfrJJbQJ5luA8m1FmHB17
         lsLJxiMFT3Gmo6kXKfMT7CXYg+eOIdo1ax/6yXayCzCtz3W2ZvdfWLNoDbmcAibS1vBc
         aXMAgJE7Z/ZojKqiMBcMaAemL+tAKhn4P3DIPAqOArOyg+1Prec/prV02kJ5XhW3jOyp
         6pQt0LsbuQPby/Jo0fxj/C7UMzAS8VE8NHEtYCoREKAiUJ5eScwe/GvruDkhO45sNMYn
         af1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700036811; x=1700641611;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9jKwR1gpSfQdTlAXjlEEGIRRbRHY5oxkajkqLsICLD8=;
        b=evjVCoxGrqhE0/0rYbJ8JoEz/dwkA+FtVFQXKi0mGbVGX9FCAXpkR5luUDywNylBGq
         tIaQBLdvi/tYMhThg6jhB5IBQW3MArm6wMvnLd+Ie/SKgBYaJDWwbPJ6PtTBFYxGNcC5
         yRWURv/6EwVt76YCCC3AQmi52wR3t0Pbk7C8wxLLv26XkrZqjYUC4Laf5QLP2EmMYYQl
         W/ZYlqc7/n/yAC3djdBGG69rzJmnkt2FGG7FMz3QmzKUIN2xGwRyk763WcUrPjS6iIzV
         l8GL0chq82nY/4z6qnnOEqXfuRx4ixBAc9MiJoqfUgGE6Jciqg07+QdnFZ4JouZSVNG6
         m8MQ==
X-Gm-Message-State: AOJu0YxSHz7jgGMRk2oPq2puVx/J8NSDMvIipAXywuDSOzmb054trrQf
        Zo3WC4b4YxdnnZdsTYSc6qeuXliE+b9vVADxsduhwQ==
X-Google-Smtp-Source: AGHT+IHlHN6/fqb4BlyS3USPLglPg5gitxI7ccvqFg2CGaZ8in/L5HEzf93cke8DdsjG2TTgZwi3B2QD+Axz28INOHU=
X-Received: by 2002:a67:ab0d:0:b0:45d:920b:f111 with SMTP id
 u13-20020a67ab0d000000b0045d920bf111mr12202204vse.5.1700036811448; Wed, 15
 Nov 2023 00:26:51 -0800 (PST)
MIME-Version: 1.0
References: <20231109155101.186028-1-paul.heidekrueger@tum.de>
 <CA+fCnZcMY_z6nOVBR73cgB6P9Kd3VHn8Xwi8m9W4dV-Y4UR-Yw@mail.gmail.com>
 <CANpmjNNQP5A0Yzv-pSCZyJ3cqEXGRc3x7uzFOxdsVREkHmRjWQ@mail.gmail.com>
 <20231114151128.929a688ad48cd06781beb6e5@linux-foundation.org> <918c3ff64f352427731104c5275786c815b860d9.camel@perches.com>
In-Reply-To: <918c3ff64f352427731104c5275786c815b860d9.camel@perches.com>
From:   Marco Elver <elver@google.com>
Date:   Wed, 15 Nov 2023 09:26:15 +0100
Message-ID: <CANpmjNP+UsZS_vcuWaCPSqHpg54ZJZXe6k1p4zC+Bkd9vnoc4w@mail.gmail.com>
Subject: Re: [PATCH] kasan: default to inline instrumentation
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        =?UTF-8?Q?Paul_Heidekr=C3=BCger?= <paul.heidekrueger@tum.de>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Nov 2023 at 06:38, Joe Perches <joe@perches.com> wrote:
>
> On Tue, 2023-11-14 at 15:11 -0800, Andrew Morton wrote:
> > On Tue, 14 Nov 2023 12:00:49 +0100 Marco Elver <elver@google.com> wrote:
> >
> > > +Cc Andrew (get_maintainers.pl doesn't add Andrew automatically for
> > > KASAN sources in lib/)
> >
> > Did I do this right?

If the signal to noise ratio is acceptable, something like that could
be helpful. New contributors like Paul in this case may have an easier
time, if none of the reviewers spot the missing Cc.

However, folks familiar with subsystems that also have bits in lib/
(or elsewhere) know to Cc you. It worked in this case.

Thanks,
-- Marco

> > From: Andrew Morton <akpm@linux-foundation.org>
> > Subject: MAINTAINERS: add Andrew Morton for lib/*
> > Date: Tue Nov 14 03:02:04 PM PST 2023
> >
> > Add myself as the fallthough maintainer for material under lib/
> >
> > Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> > ---
> >
> >  MAINTAINERS |    7 +++++++
> >  1 file changed, 7 insertions(+)
> >
> > --- a/MAINTAINERS~a
> > +++ a/MAINTAINERS
> > @@ -12209,6 +12209,13 @@ F:   include/linux/nd.h
> >  F:   include/uapi/linux/ndctl.h
> >  F:   tools/testing/nvdimm/
> >
> > +LIBRARY CODE
> > +M:   Andrew Morton <akpm@linux-foundation.org>
> > +L:   linux-kernel@vger.kernel.org
> > +S:   Supported
>
> Dunno.
>
> There are a lot of already specifically maintained or
> supported files in lib/
>
> Maybe be a reviewer?
>
