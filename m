Return-Path: <linux-kernel+bounces-67-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A15EE813B84
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9DAD1C21AF7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 20:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6ACB6A328;
	Thu, 14 Dec 2023 20:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NL5yMhgj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761126A33F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 20:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7b6fe5d67d4so321399039f.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 12:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702585772; x=1703190572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zBgjjgr8D/SHxPTnKZMl5g8ELyqfBBSI/orkqxON0Q=;
        b=NL5yMhgjgjRNGqiZUmqdFhvYoREXQXddQplRe8954yEJSX2pHppKYq0zrS91Do/r+4
         GWjaW8Fx1z0gVXBKPugyPJTjsWxQMmpeQY8CcZNu5jluwsKLoFxy4E2at6K8CR9Niobw
         uw9N3L8phqtFVmOxEAEXJmYiJVFUOcckkMqRG8iV1M5YLWvCAr6R1NTkfx+1/23bQ2K1
         eKi1xHB/f7KGppQ8RVakw7h4z9Ve64r/hnkrBB1FZZz0OtzMORijSgvdJsz3CaIa63Cg
         D6YEXyObSxf4Q0S1sGq2tkpDH+txo3XdmckopEohMOGu67DYS+6/PZgesH2bcMjmYGqB
         hxXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702585772; x=1703190572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zBgjjgr8D/SHxPTnKZMl5g8ELyqfBBSI/orkqxON0Q=;
        b=vP7nvIeElv6ajbVqnYBwzYS4YwKcYjxmbCStG90q7P1OU1Bcb8FidUdZ3GtBIB419W
         paLW4qkClcF9EETqZCFETw3semYd+IVQb/C4dSqd4h+ecgaPKRpLWL66kEiOPhYP8oat
         sxjybaGaZ0aCv8jgjBp+AAJ8TjYTbFhZSNlA8QF4Bvr4Qtcz66ydlOyM94uliKgUhZb/
         GD1pabsNHy8Zo4ZXx7m0bd1nBgW3oT1jRmOnafKtKXygFuGtbToT4AKehnL0nV7Bahbl
         qFKhQK1kMbqiBeoirzwCFD+2T6iSERC1aDKxhWf2JFFoBSM8p5XmhTE08tmZsn1oo4uk
         Lt2Q==
X-Gm-Message-State: AOJu0YyxcAbxkeZp9zyfF2mp3oDIyEHzucQp+hjmORB9cgXbydw7vOJd
	e3MAAc7fQKsb2aMzvM+nd67WjUujosMray4Wo2c=
X-Google-Smtp-Source: AGHT+IEqbkpIDFaiZ9sABqn7gCj16ftZYkx6C73e7dJ1T8eQXZYsMrospP9F8WaeqyBNAwKXm8Iu811KDPv6ovjH/7A=
X-Received: by 2002:a6b:7117:0:b0:7b4:28f8:3ba1 with SMTP id
 q23-20020a6b7117000000b007b428f83ba1mr10071425iog.36.1702585772146; Thu, 14
 Dec 2023 12:29:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231213-zswap-dstmem-v1-0-896763369d04@bytedance.com>
 <20231213-zswap-dstmem-v1-2-896763369d04@bytedance.com> <CAJD7tkZJRgf+502QU_ECVPey0w-5vw_e6HSL+Ay7unetq5gL0A@mail.gmail.com>
 <CAKEwX=P4=YbvoRCa5+BB+==f4YL_5-6AaUNUCdH3v2faTx-PYQ@mail.gmail.com>
 <cb558f85-4f9b-4eb9-b60c-9b609075920d@bytedance.com> <CAJD7tkY_fe9SeTxOSVmYHNgi2tKvZ+EoM15KifJihF_Zn_LqDg@mail.gmail.com>
 <7a8c77b0-c78c-427d-9545-2b328c7dc727@bytedance.com> <CAJD7tkba0O=Qfc-yuq6BNfYbrebmBy2NzywGmogdQmRwoS06dw@mail.gmail.com>
In-Reply-To: <CAJD7tkba0O=Qfc-yuq6BNfYbrebmBy2NzywGmogdQmRwoS06dw@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 14 Dec 2023 12:29:21 -0800
Message-ID: <CAKEwX=NyV_V2f9nGy7814m7ax5T_-J70HjQKdqCrf1vG-Tn_Vw@mail.gmail.com>
Subject: Re: [PATCH 2/5] mm/zswap: change dstmem size to one page
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Chengming Zhou <zhouchengming@bytedance.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chriscli@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Seth Jennings <sjenning@redhat.com>, Dan Streetman <ddstreet@ieee.org>, 
	Vitaly Wool <vitaly.wool@konsulko.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 10:30=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> On Thu, Dec 14, 2023 at 5:57=E2=80=AFAM Chengming Zhou
> <zhouchengming@bytedance.com> wrote:
> >
> > On 2023/12/14 21:37, Yosry Ahmed wrote:
> > > On Thu, Dec 14, 2023 at 5:33=E2=80=AFAM Chengming Zhou
> > > <zhouchengming@bytedance.com> wrote:
> > >>
> > >> On 2023/12/14 08:18, Nhat Pham wrote:
> > >>> On Wed, Dec 13, 2023 at 3:34=E2=80=AFPM Yosry Ahmed <yosryahmed@goo=
gle.com> wrote:
> > >>>>
> > >>>> On Tue, Dec 12, 2023 at 8:18=E2=80=AFPM Chengming Zhou
> > >>>> <zhouchengming@bytedance.com> wrote:
> > >>>>>
> > >>>>> Change the dstmem size from 2 * PAGE_SIZE to only one page since
> > >>>>> we only need at most one page when compress, and the "dlen" is al=
so
> > >>>>> PAGE_SIZE in acomp_request_set_params(). If the output size > PAG=
E_SIZE
> > >>>>> we don't wanna store the output in zswap anyway.
> > >>>>>
> > >>>>> So change it to one page, and delete the stale comment.
> > >>>>
> > >>>> I couldn't find the history of why we needed 2 * PAGE_SIZE, it wou=
ld
> > >>>> be nice if someone has the context, perhaps one of the maintainers=
.
> > >>>
> > >>> It'd be very nice indeed.
> > >>>
> > >>>>
> > >>>> One potential reason is that we used to store a zswap header
> > >>>> containing the swap entry in the compressed page for writeback
> > >>>> purposes, but we don't do that anymore. Maybe we wanted to be able=
 to
> > >>>> handle the case where an incompressible page would exceed PAGE_SIZ=
E
> > >>>> because of that?
> > >>>
> > >>> It could be hmm. I didn't study the old zswap architecture too much=
,
> > >>> but it has been 2 * PAGE_SIZE since the time zswap was first merged
> > >>> last I checked.
> > >>> I'm not 100% comfortable ACK-ing the undoing of something that look=
s
> > >>> so intentional, but FTR, AFAICT, this looks correct to me.
> > >>
> > >> Right, there is no any history about the reason why we needed 2 page=
s.
> > >> But obviously only one page is needed from the current code and no a=
ny
> > >> problem found in the kernel build stress testing.
> > >
> > > Could you try manually stressing the compression with data that
> > > doesn't compress at all (i.e. dlen =3D=3D PAGE_SIZE)? I want to make =
sure
> > > that this case is specifically handled. I think using data from
> > > /dev/random will do that but please double check that dlen =3D=3D
> > > PAGE_SIZE.

FWIW, zsmalloc supports the storing of pages that are PAGE_SIZE in
length, so a use case is probably there (although it could be for
ZRAM). We tested it during the storing-uncompressed-pages patch.
Architecturally, it seems that zswap just lets the backend allocator
handle the rejection of compressed objects that are too large, and the
compressor to reject pages that are too poorly compressed.

> >
> > I just did the same kernel build testing, indeed there are a few cases
> > that output dlen =3D=3D PAGE_SIZE.
> >
> > bpftrace -e 'k:zpool_malloc {@[(uint32)arg1=3D=3D4096]=3Dcount()}'
> >
> > @[1]: 2
> > @[0]: 12011430
>
> That's very useful information, thanks for testing that. Please
> include this in the commit log. Please also include the fact that we
> used to store a zswap header with the compressed page but don't do
> that anymore, which *may* be the reason why this was needed back then.
>
> I still want someone who knows the history to Ack this, but FWIW it
> looks correct to me, so low-key:
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>

Anyway:
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

