Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDAB7A8955
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 18:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234533AbjITQTn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 12:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234462AbjITQTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 12:19:40 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A243C6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 09:19:34 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id ca18e2360f4ac-79277cfc73bso1653539f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 09:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695226773; x=1695831573; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=v+L5vtyxoXiX1VhFCoLSv7yA2ox0MxhbIEpoe+LwMQQ=;
        b=hz9MKw4HmbTkfae4sSjlPpIlHdj0troN6abDowscrUkozwftdup4/2pKOaqjHQhSEz
         USJPxILibllnxe7wzqTGuB2iJTjYjYYq+iTlT/QDEA4p4jOU5JJobZ/d0bREWZTnjEBA
         3Qp0YRKqop+xKdYkMoXVAnaCjt8nB83GPxT7PYd22YiIokPzdm3jpub+2tqnswrnIDXx
         K5E8yk0X4TFIMrmG1ov+bkrEN+bwcQGl4nl2mCLM3ertwd5WIRkkeXmI8OELMdL6Losg
         +6uHl9v20+eytf9Yo26Dvoh2gahF+u04rHhR+Rbuue+bVl4JAq1T9HqL5BEnrlZSwlEq
         syKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695226773; x=1695831573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=v+L5vtyxoXiX1VhFCoLSv7yA2ox0MxhbIEpoe+LwMQQ=;
        b=MyHXnHRFMmwlsDMZOHZQS/+6lH/dgTPpedsC3N06m2if+Ot6iFprsdr9k7axQzmRJT
         Z9Q32Ug/uwK/cLj7RgDvjjof4Ms+FUatmbeoc3mK/jf1JnbZCQVlxfPlgWmIq+S/0v8Y
         arKrCuxGwTcPlFK50FpnnB3Ym4eIMl/18LSTXyZYclqlPoggKStlbLkMXdLpa94F0MkQ
         VSuXIYc1KRwwjJTU2hntTexrw8Zf4IJwoS9FYkPPhL+OWvu2j3r4eeIXuF0Xj6keFPpl
         CAIrobhWKPGQlshAXKCLjrarH9srHyroBkmyTTS7LIFYAKcCVz+aW83W+AvWTTZXSPJo
         sjIw==
X-Gm-Message-State: AOJu0YwxYU0WGNvdWTDR7otROs3oby+011iWx0dCTSczObbfTdaz+J85
        3plkronjybHYA7uwoAQkVG3vELecVM6YubrrWO/7Hg==
X-Google-Smtp-Source: AGHT+IGxVvwgctKBUx4FuVSpVqy6qqqDOMG+nsGr5KKXHLwtYJR9pOZZf4c8DDAS/7IGlbZgDWvDCcx6Vz1mQTTcqc0=
X-Received: by 2002:a05:6602:2251:b0:795:16b8:8607 with SMTP id
 o17-20020a056602225100b0079516b88607mr3290989ioo.0.1695226773601; Wed, 20 Sep
 2023 09:19:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230720173956.3674987-1-glider@google.com> <20230720173956.3674987-6-glider@google.com>
 <ZN+13iQ4oOgpKhNO@arm.com> <CAG_fn=Wr86MxbhxajObGw+Zoa_Y8zhGb8RVwhZdQmKxj4mxdTA@mail.gmail.com>
In-Reply-To: <CAG_fn=Wr86MxbhxajObGw+Zoa_Y8zhGb8RVwhZdQmKxj4mxdTA@mail.gmail.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Wed, 20 Sep 2023 18:18:52 +0200
Message-ID: <CAG_fn=VDCU0ZJRSvP9xbB8jq+KA+vQQ8QaYhgS0U3XyqcH+ZsA@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] arm64: mte: add compression support to mteswap.c
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     will@kernel.org, pcc@google.com, andreyknvl@gmail.com,
        andriy.shevchenko@linux.intel.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 3:26=E2=80=AFPM Alexander Potapenko <glider@google.=
com> wrote:
>
> On Fri, Aug 18, 2023 at 8:18=E2=80=AFPM Catalin Marinas <catalin.marinas@=
arm.com> wrote:
> >
> > On Thu, Jul 20, 2023 at 07:39:56PM +0200, Alexander Potapenko wrote:
> > > Soon after booting Android, tag compression saves ~2.5x memory previo=
usly
> > > spent by mteswap.c on tag allocations. With the growing uptime, the
> > > savings reach 20x and even more.
> >
> > This sounds like a marketing claim ;). The way I read your statement is
> > that the memory used for tag storage is 2.5x less with your patches and
> > that's great. It means a 2.5x compression on average. How does the
> > compression get so much better to 20x with more uptime?
>
> I am currently looking at this, and I think this happens because some
> userspace apps assign zero tags to userspace pages, and those tags are
> effectively zero-cost, because they can be compressed into 8 bytes of
> the Xarray pointer.
> As the uptime grows, the share of such pages also grows.
> I agree though that this is a marginal use case, and the average
> compression rate is more representative.
>
> > The number of
> > tag storage allocations should be proportional to the pages swapped out
> > (not equal as not all would be mapped as PROT_MTE).
>
> We think a reasonable upper bound for PROT_MTE pages is 40%, but
> currently it is probably more like 20%.
>
>
> > So you can indeed
> > have a lot more pages swapped out than available in RAM and the tag
> > storage can take space but not sure which numbers you divided to get
> > 20x.
>
> Right now (in kernel 6.5) the amount of memory spent to store the tags
> can be calculated as 128 * (number of mte_allocate_tag_storage() calls
> - number of mte_free_tag_storage() calls).
> In my patchset I calculate the total amount of memory
> allocated/deallocated from the mte-tags-N caches and compare that with
> 128 * (total number of live objects in those caches).
> E.g. the stats after booting up the device (~120s uptime) look as follows=
:
>
> 8 bytes: 14007 allocations, 256 deallocations
> 16 bytes: 1583 allocations, 179 deallocations
> 32 bytes: 1634 allocations, 205 deallocations
> 64 bytes: 1538 allocations, 142 deallocations
> 128 bytes: 10881 allocations, 1340 deallocations
> uncompressed tag storage size: 3522688
> compressed tag storage size: 1488792
>
> (note 8-byte allocations contribute to uncompressed storage, but not
> to compressed storage).
>
> After running various apps, I made the device use almost 19Mb swap space:

Sorry, this is by no means 19Mb

> 8 bytes: 71352 allocations, 8093 deallocations
> 16 bytes: 5102 allocations, 2598 deallocations
> 32 bytes: 8206 allocations, 4536 deallocations
> 64 bytes: 9489 allocations, 5377 deallocations
> 128 bytes: 43258 allocations, 23364 deallocations
> uncompressed tag storage size: 11960192
> compressed tag storage size: 2967104
