Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1585175F4DE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 13:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231407AbjGXLVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 07:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjGXLVs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 07:21:48 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59ACBE56;
        Mon, 24 Jul 2023 04:21:45 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fd0f000f1cso26057645e9.1;
        Mon, 24 Jul 2023 04:21:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690197703; x=1690802503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFhFWl3vFXI5sPJ8FjP5qyAt2hWCbzGdgcfHzMXY7QM=;
        b=XSeQ/loMiS/JX1qZ4jbdZ53R3soRSnaXmc8nlgDRZ+PNsTA++w39sG5vMl/xSsAic5
         Bye26XiWAeiro/xUINpaMvvwabcjrDT45tNUwVf0yKfFOUWGcgIPw/6wTry15Tc6AFSQ
         JLlaSYj/4wM0oWyZFWEaZ8E/BtB+XjCkUnu91+Esnm6knDrmdhXoyzbUM5TUGpKd/5gt
         kP2VLUnHctEEzfxCGUivrjIFyLImw3EZ9U8M9wTh4ZDFpGyTdybibvPsn2u1RpYulosK
         taDGeM2M+Fyx4gd1R0p4XmSkwlzrFjwDOaw0nFG2xCGDFWI9hWDPzGXepI4K72KJx144
         Ctmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690197703; x=1690802503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TFhFWl3vFXI5sPJ8FjP5qyAt2hWCbzGdgcfHzMXY7QM=;
        b=PdT7SrT7XHfBILxxN0gwfzkUVyRYXsM0MbElGUea8d48/tDc5cDHXusHGMgLTJ2zrp
         +6feTlKl8LcxgA1tpAHNVr/tdC/YbNP/1YmvAoXoq97Uq84rXoTrPTZWhy9Ykgyj8I6s
         UYOrQDi7fGPgusZX8w7RHzDHAMqcJecvVJV/xsolAbyF6Nb+4LougpcLb5A+WrhMyMIu
         mxpUgJuaDD+obKskzXNDq/E+Oh5t1AetVf1efy6cCLlMiupd6O+efiV7/pHd8cp7kTg7
         0WrjU0OSqxLfe2jSmC0TI0p7X0eAoPjC06CkiHzl6YtsLyEcqkKyVkmmNt5Owpx+dOKJ
         74tA==
X-Gm-Message-State: ABy/qLYbxiQiD5TUgHFPLmYWVCRbXEYIu641gncJnUxkZUJpJ6ktR6CC
        iasvQ23ObfyPLD5klef67qsdNCc3fwdS1Q==
X-Google-Smtp-Source: APBJJlGgSiV3HlEbJ70IaPI4jigHZPogdp1chytFPFwub6+Z681rVxLwfJ+8C3bskxVT1+lbFSRzDg==
X-Received: by 2002:a1c:6a0e:0:b0:3fb:acbe:da5d with SMTP id f14-20020a1c6a0e000000b003fbacbeda5dmr8130689wmc.4.1690197703191;
        Mon, 24 Jul 2023 04:21:43 -0700 (PDT)
Received: from suse.localnet (host-87-20-104-222.retail.telecomitalia.it. [87.20.104.222])
        by smtp.gmail.com with ESMTPSA id l8-20020a7bc448000000b003fb40ec9475sm10059915wmi.11.2023.07.24.04.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 04:21:42 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mike Rapoport <rppt@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [RFC PATCH v2] Documentation/page_tables: Add info about MMU/TLB and Page
 Faults
Date:   Mon, 24 Jul 2023 13:21:40 +0200
Message-ID: <23157760.6Emhk5qWAg@suse>
In-Reply-To: <20230724105505.000060c7@Huawei.com>
References: <20230723120721.7139-1-fmdefrancesco@gmail.com>
 <20230724105505.000060c7@Huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On luned=EC 24 luglio 2023 11:55:05 CEST Jonathan Cameron wrote:
> On Sun, 23 Jul 2023 14:07:09 +0200
>=20
> "Fabio M. De Francesco" <fmdefrancesco@gmail.com> wrote:
> > Extend page_tables.rst by adding a section about the role of MMU and TLB
> > in translating between virtual addresses and physical page frames.
> > Furthermore explain the concept behind Page Faults and how the Linux
> > kernel handles TLB misses. Finally briefly explain how and why to disab=
le
> > the page faults handler.
> >=20
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Bagas Sanjaya <bagasdotme@gmail.com>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>=20
> Hi Fabio,
>=20

Hi Jonathan,

> Some superficial comments...

Maybe that they are "superficial", BTW they are indeed very welcome :-)

> > ---
> >=20
> > v1->v2: Add further information about lower level functions in the page
> > fault handler and add information about how and why to disable / enable
> > the page fault handler (provided a link to a Ira's patch that make use
> > of pagefault_disable() to prevent deadlocks).
> >=20
> > This is an RFC PATCH because of two reasons:
> >=20
> > 1) I've heard that there is consensus about the need to revise and
> > extend the MM documentation, but I'm not sure about whether or not
> > developers need these kind of introductory information.
> >=20
> > 2) While preparing this little patch I decided to take a quicj look at
>=20
> Spell check your intro text.

Sure, I'll s/quicj/quick/

> > the code and found out it currently is not how I thought I remembered
> > it. I'm especially speaking about the x86 case. I'm not sure that I've
> > been able to properly understand what I described as a difference in
> > workflow compared to most of the other architecture.
> >=20
> > Therefore, for the two reasons explained above, I'd like to hear from
> > people actively involved in MM. If this is not what you want, feel free
> > to throw it away. Otherwise I'd be happy to write more on this and other
> > MM topics. I'm looking forward for comments on this small work.
> >=20
> >  Documentation/mm/page_tables.rst | 87 ++++++++++++++++++++++++++++++++
> >  1 file changed, 87 insertions(+)
> >=20
> > diff --git a/Documentation/mm/page_tables.rst
> > b/Documentation/mm/page_tables.rst index 7840c1891751..2be56f50c88f 100=
644
> > --- a/Documentation/mm/page_tables.rst
> > +++ b/Documentation/mm/page_tables.rst
> > @@ -152,3 +152,90 @@ Page table handling code that wishes to be
> > architecture-neutral, such as the>=20
> >  virtual memory manager, will need to be written so that it traverses a=
ll=20
of
> >  the currently five levels. This style should also be preferred for
> >  architecture-specific code, so as to be robust to future changes.
> >=20
> > +
> > +
> > +MMU, TLB, and Page Faults
> > +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> > +
> > +The Memory Management Unit (MMU) is a hardware component that handles
> > virtual to +physical address translations. It uses a relatively small=20
cache
> > in hardware
> It may use a relatively...
> (I doubt Linux supports anything that doesn't have a TLB but they aren't
> required by some architectures - just a performance optimization that you
> 'can' add to an implementation.)

Oh, I didn't know that Linux supports non-MMU architectures. However I susp=
ect=20
that the vast majority have MMU and TLB. Is it correct?=20

I'll change the statement to "it may use, and in the vast majority of=20
supported architecture it indeed uses [...]". How about this? Is it not yet=
=20
what you meant?

> > +called the Translation Lookaside Buffer (TLB) to speed up these
> > translations. +When a process wants to access a memory location, the CPU
> > provides a virtual +address to the MMU, which then uses the TLB to quic=
kly
> > find the corresponding +physical address.
> > +
> > +However, sometimes the MMU can't find a valid translation in the TLB.=
=20
This
> > +could be because the process is trying to access a range of memory that
> > it's not +allowed to, or because the memory hasn't been loaded into RAM
> > yet.
>=20
> It might not find it because this is first attempt to do the translation =
and
> the MMU hasn't filled the TLB entry yet, or a capacity eviction has=20
happened.

I thought that "[...] hasn't been loaded into RAM yet" would have covered a=
ll=20
cases comprising lazy allocation, copy-n-write, and swapped out pages. I=20
talked about the first two later in the text, but I forgot to speak about=20
swapped out page frames to persistent storage so I'll add it in the next=20
version.

However, I am thinking that is not the TLB misses that may cause an excepti=
on=20
to fault in memory, but it is the MMU itself if not able to fill the TLB wi=
th=20
the content of allocated page tables. If you confirm so, I'll need to rewri=
te=20
the first introductory paragraphs. Can you please confirm?=20

> Basically failure to find it in the TLB doesn't mean we get a page fault
> (unless you are on an ancient architecture where TLB entries are software
> filled which is definitely not the case for most modern ones).

Let me summarize so that you can confirm or deny whether or not I=20
understood...

1) TLB misses don't cause page faults unless MMU is not able to find the=20
entries in the hierarchy of page tables. If it finds the entries is=20
transparently refills the TLB buffer with the found translations.

2) Page faults happens only if MMU, after walking the hierarchy, cannot yet=
=20
find any suitable translation.

> >  When this
> >=20
> > +happens, the MMU triggers a page fault, which is a type of interrupt t=
hat
>=20
> Hmm. Whilst similar to an interrupt I'd argue that it's not one..

3) I shouldn't define it as an "interrupt" because it technically is not. H=
ow=20
about "exception" or "software exception"?
=20
> > +signals the CPU to pause the current process and run a special functio=
n=20
to
> > +handle the fault.
>=20
> ...
>=20
> Jonathan

I don't read any other comments on the second part of the RFC. Does it mean=
=20
that the second part is OK from your POV?

It would be of great help if you could set aside some more minutes and clea=
r=20
the doubts I just expressed and answer the questions I asked :-)

Thanks for the comments,

=46abio



