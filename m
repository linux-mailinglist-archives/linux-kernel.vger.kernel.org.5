Return-Path: <linux-kernel+bounces-29338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11838830D03
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 19:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDE8A1C24288
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 18:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6742421B;
	Wed, 17 Jan 2024 18:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIHkq7fx"
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BFE241F8;
	Wed, 17 Jan 2024 18:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705517654; cv=none; b=Lf+ICAMBLsEGdEKhInoTD5/Uxstep/9F3D62AtV+dlo10GmhbehB9ffyY2ob0UpDhavpVZ/xwm/R9EeDX23nnYvO4QoMN/g9y8RMf/M8qKwociuU5mhaDHd83GPTYJNHfs3qBXaCr1TZWB78dlblAU299PUmLhcBKTMmqxKZVRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705517654; c=relaxed/simple;
	bh=MWuKH8ZTh5p7NA2617kjoMyVaghyl+CNjJMgHjO/csQ=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Date:
	 From:To:Cc:Message-ID:In-Reply-To:References:Subject:Mime-Version:
	 Content-Type:Content-Transfer-Encoding; b=RNTnkEVNqKXVfmcx5fY2XvfSJZhWbpX11bINeqdWhhowxIvtCkio+IFY0BHj6yazxVefwLZpUd/iz9fgejllWnzJa41U0Y4oFmBwrCZmS21LECadwxQ5xRviZq7fVjz44cqLuNFdh/j6POnAH/a22tWd/J+6F7DiYfTJuqsepsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIHkq7fx; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bbbc6e51d0so7334839b6e.3;
        Wed, 17 Jan 2024 10:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705517652; x=1706122452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6E9wW+O2HUtc5WuKzUUUjwTqu2FBhW5+kdjVHG2sIoU=;
        b=HIHkq7fxwChvaj/qYtAQD+p5NYy5pvJYaTEzwmEEJXvsOVurUNaTEwpzCb9suTUm6B
         GouGrplt07NimUkmfVOjH9ZvwKrOLto8oBwduRJgQqsOJJHA3mApVakwsXSjYWiSGgqb
         zytaHif59wXQZhTWbjF3vgysUEpQfB/XLrYQVzyB2I4GIQXhnxw/fzINJQlN/wLcjX5c
         yGxxS5U0/lFh963qKpCODM9d+HT93goszAD5YzMqhWqegk7YfK5XjfncsTswkscDGjft
         v/BqsW9T30OvJ8qHMe5yhbvxn3zNOq8099UYWDVAg5BWKVUBwLshi88SCwSWPOQrYtQf
         oVyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705517652; x=1706122452;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6E9wW+O2HUtc5WuKzUUUjwTqu2FBhW5+kdjVHG2sIoU=;
        b=pRS04hajPigmVwJmxB1aW3Z1Pq/y6A0Scni2/bdrIqziQupLFl0tnZfKtlvdZ+z+sG
         ZasfyqCNxLIRWrCs8zBbtnHB5Jy+O9wzsyHPQpZ5W/rWo0lyIaLiRdpTezDHCIq0sBTm
         W17IvQTdvtd9D+aI0NoK5dHsZeTRyxWSOUebNBUQZAG8VCHuYf15QEaeYkdOgG8o/Hth
         K5OjKGvD2FT/z0R021usN99zZnd7dli6Gpga6XDOJFfTIRFjehTmG3clt6aIHT/k5VnE
         YE3dPbheAN16x/uXbJfITj6RYKkurbzw9/j04jehO2fYbCunyYjvxXCrCw3IhHq12LEv
         Z0PA==
X-Gm-Message-State: AOJu0YwMNDzB9t2+YMpLh9y0Rl96GymiJFYCOR8iLPLUSYDzg4VdyQkN
	lnQ6F/X+kgd+8lmg8gzhe04=
X-Google-Smtp-Source: AGHT+IFmjYUFYB1qt8ZEKt/ytrzG0VRboRsPWNL/uTGfWYNVsgtDVlim9IAMkZ8yyl0k6fOdS5OvXw==
X-Received: by 2002:a05:6808:2012:b0:3bd:935f:4c23 with SMTP id q18-20020a056808201200b003bd935f4c23mr1580367oiw.90.1705517651857;
        Wed, 17 Jan 2024 10:54:11 -0800 (PST)
Received: from localhost (131.65.194.35.bc.googleusercontent.com. [35.194.65.131])
        by smtp.gmail.com with ESMTPSA id x22-20020a05620a0ed600b007831c7989a4sm4747095qkm.22.2024.01.17.10.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jan 2024 10:54:11 -0800 (PST)
Date: Wed, 17 Jan 2024 13:54:11 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Mina Almasry <almasrymina@google.com>, 
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Yunsheng Lin <linyunsheng@huawei.com>, 
 linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 =?UTF-8?B?Q2hyaXN0aWFuIEvDtm5pZw==?= <christian.koenig@amd.com>, 
 Shakeel Butt <shakeelb@google.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Message-ID: <65a8225348b92_11eb12942c@willemb.c.googlers.com.notmuch>
In-Reply-To: <CAHS8izO1-+MczzFw_R80uv=aK5A9bUNcKroY=H9Euk+ZPnnGPw@mail.gmail.com>
References: <20240109011455.1061529-1-almasrymina@google.com>
 <20240109011455.1061529-3-almasrymina@google.com>
 <5219f2cd-6854-0134-560d-8ae3f363b53f@huawei.com>
 <CAHS8izOtr+jfqQ6xCB3CoN-K_V1-4hPsB4-k5+1z-M3Qy2BbwA@mail.gmail.com>
 <0711845b-c435-251f-0bbc-20b243721c06@huawei.com>
 <CAHS8izOxvMVGXKpLBvVgyyS5_94WGG8Aca=O_zGMX+db-3gBXg@mail.gmail.com>
 <66bc7b8f-51b6-0d9e-db5b-47e7ee5e9029@huawei.com>
 <CAHS8izOnhtQGeQ-EFmYjZyZ0eW2LqO0Rrm73eAB2su=UA34yTw@mail.gmail.com>
 <20240116000129.GX734935@nvidia.com>
 <9c1a6725-c4c3-2bb1-344f-5e71f8ce7e63@huawei.com>
 <20240116121611.GY734935@nvidia.com>
 <CAHS8izPa6ostY7qZUAmm4g8N3rfWoVBK6r5z0_MycxfsEVH4jw@mail.gmail.com>
 <CAHS8izO1-+MczzFw_R80uv=aK5A9bUNcKroY=H9Euk+ZPnnGPw@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v5 2/2] net: add netmem to skb_frag_t
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Mina Almasry wrote:
> On Wed, Jan 17, 2024 at 10:00=E2=80=AFAM Mina Almasry <almasrymina@goog=
le.com> wrote:
> >
> > On Tue, Jan 16, 2024 at 4:16=E2=80=AFAM Jason Gunthorpe <jgg@nvidia.c=
om> wrote:
> > >
> > > On Tue, Jan 16, 2024 at 07:04:13PM +0800, Yunsheng Lin wrote:
> > > > On 2024/1/16 8:01, Jason Gunthorpe wrote:
> > > > > On Mon, Jan 15, 2024 at 03:23:33PM -0800, Mina Almasry wrote:
> > > > >>>> You did not answer my question that I asked here, and ignori=
ng this
> > > > >>>> question is preventing us from making any forward progress o=
n this
> > > > >>>> discussion. What do you expect or want skb_frag_page() to do=
 when
> > > > >>>> there is no page in the frag?
> > > > >>>
> > > > >>> I would expect it to do nothing.
> > > > >>
> > > > >> I don't understand. skb_frag_page() with an empty implementati=
on just
> > > > >> results in a compiler error as the function needs to return a =
page
> > > > >> pointer. Do you actually expect skb_frag_page() to uncondition=
ally
> > > > >> cast frag->netmem to a page pointer? That was explained as
> > > > >> unacceptable over and over again by Jason and Christian as it =
risks
> > > > >> casting devmem to page; completely unacceptable and will get n=
acked.
> > > > >> Do you have a suggestion of what skb_frag_page() should do tha=
t will
> > > > >> not get nacked by mm?
> > > > >
> > > > > WARN_ON and return NULL seems reasonable?
> > > >
> >
> > That's more or less what I'm thinking.
> >
> > > > While I am agreed that it may be a nightmare to debug the case of=
 passing
> > > > a false page into the mm system, but I am not sure what's the poi=
nt of
> > > > returning NULL to caller if the caller is not expecting or handli=
ng
> > > > the
> > >
> > > You have to return something and NULL will largely reliably crash t=
he
> > > thread. The WARN_ON explains in detail why your thread just crashed=
.
> > >
> >
> > Agreed.
> >
> > > > NULL returning[for example, most of mm API called by the networki=
ng does not
> > > > seems to handling NULL as input page], isn't the NULL returning w=
ill make
> > > > the kernel panic anyway? Doesn't it make more sense to just add a=
 BUG_ON()
> > > > depending on some configuration like CONFIG_DEBUG_NET or CONFIG_D=
EVMEM?
> > > > As returning NULL seems to be causing a confusion for the caller =
of
> > > > skb_frag_page() as whether to or how to handle the NULL returning=
 case.
> > >
> > > Possibly, though Linus doesn't like BUG_ON on principle..
> > >
> > > I think the bigger challenge is convincing people that this devmem
> > > stuff doesn't just open a bunch of holes in the kernel where usersp=
ace
> > > can crash it.
> > >
> >
> > It does not, and as of right now there are no pending concerns from
> > any netdev maintainers regarding mishandled devmem checks at least.
> > This is because the devmem series comes with a full audit of
> > skb_frag_page() callers [1] and all areas in the net stack attempting=

> > to access the skb [2].
> >
> > [1] https://patchwork.kernel.org/project/netdevbpf/patch/202312180240=
24.3516870-10-almasrymina@google.com/
> > [2] https://patchwork.kernel.org/project/netdevbpf/patch/202312180240=
24.3516870-11-almasrymina@google.com/
> >
> > > The fact you all are debating what to do with skb_frag_page() sugge=
sts
> > > to me there isn't confidence...
> > >
> >
> > The debate raging on is related to the performance of skb_frag_page()=
,
> > not correctness (and even then, I don't think it's related to
> > perf...). Yunsheng would like us to optimize skb_frag_page() using an=

> > unconditional cast from netmem to page. This in Yunsheng's mind is a
> > performance optimization as we don't need to add an if statement
> > checking if the netmem is a page. I'm resistant to implement that
> > change so far because:
> >
> > (a) unconditionally casting from netmem to page negates the compiler
> > type safety that you and Christian are laying out as a requirement fo=
r
> > the devmem stuff.
> > (b) With likely/unlikely or static branches the check to make sure
> > netmem is page is a no-op for existing use cases anyway, so AFAIU,
> > there is no perf gain from optimizing it out anyway.
> >
> =

> Another thought, if anyone else is concerned about the devmem checks
> performance,  potentially we could introduce CONFIG_NET_DEVMEM which
> when disabled prevents the user from using devmem at all (disables the
> netlink API).
> =

> When that is disabled, skb_frag_page(), netmem_to_page() & friends can
> assume netmem is always a page and do a straight cast between netmem &
> page. When it's enabled, it will check that netmem =3D=3D page before
> doing a cast, and return NULL if it is not a page.
> =

> I think this is technically viable and I think preserves the compiler
> type safety requirements set by mm folks. From my POV though, bloating
> the kernel with a a new CONFIG just to optimize out no-op checks seems
> unnecessary, but if there is agreement that the checks are a concern,
> adding CONFIG_NET_DEVMEM should address it while being acceptable to
> mm maintainers.

I agree. A concern with CONFIGs is that what matters in practice is
which default the distros compile with. In this case, adding hurdles
to using the feature likely for no real reason.

Static branches are used throughout the kernel in performance
sensitive paths, exactly because they allow optional paths effectively
for free. I'm quite surprised that this issue is being raised so
strongly here, as they are hardly new or controversial.

But perhaps best is to show with data. Is there a representative page
pool benchmark that exercises the most sensitive case (XDP_DROP?) that
we can run with and without a static branch to demonstrate that any
diff is within the noise?

> > But none of this is related to correctness. Code calling
> > skb_frag_page() will fail or crash if it's not handled correctly
> > regardless of the implementation details of skb_frag_page(). In the
> > devmem series we add support to handle it correctly via [1] & [2].
> >
> > --
> > Thanks,
> > Mina
> =

> =

> =

> -- =

> Thanks,
> Mina



