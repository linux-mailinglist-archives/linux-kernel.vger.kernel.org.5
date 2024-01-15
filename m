Return-Path: <linux-kernel+bounces-26528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C3482E33F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C037283C01
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 23:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DE81B7F1;
	Mon, 15 Jan 2024 23:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rVH0t3FP"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D301B7E0
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 23:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2c179aa5c4so583786966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 15:23:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705361027; x=1705965827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vhhNn99yEjnnGmh3w/oDNlY6XSr3WhLhiU/eGcp7Qc=;
        b=rVH0t3FPUnWpoTFbLcVTI7EPqekFftih/sujAnGWSr/R4J/sLv4Uy8WQKMaGgsdpcZ
         FL/pWymcDk930UyNQqtim5MmCLoSzMuvXReVC6XfTcdgnCXB1KKAPmr293gN7+rAV5nd
         3J9s8h5mvHvcTdpnpjumdgiBjpvHQCxku7MQm8mCwy40i0ui0TvDsBwNJ1OcDZZXTv+G
         XwS2+NIyeKuOmp5nVKxPfT6TiGr+8JX1vyViy9R9Uzj0hatkiqYCMUXp0KhLS+WyZh4p
         /uDtaGQx3HGiojDzafmdwQzBcJqWcX/n+rDPNY3pg3tngideBOlZWG8ouKQHz1PXP0R8
         dbHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705361027; x=1705965827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6vhhNn99yEjnnGmh3w/oDNlY6XSr3WhLhiU/eGcp7Qc=;
        b=AH8PHsFtKYy/xtBSYqimBvKpCkxKVdvd8c+bx4uI3K57PuPpTBqTnx0p8N6SImSWa2
         /vMvKYNQsmeOo1omvTPx30YRa5hP0DyC4LAsGExAJEnNmJ5suFViNB8cw4r4JcIuM7Kb
         g0XVt3W3yh9wHVcaKqLYl86QKetYCjap2og+tw5JylWbXM+cidaekI1yERny32nbMcwn
         Uyz1P1vAHJUOsPMkp9vgGgIVvfjdRBkQx15A14175Am3B+qjKVqmTafIaJn+f6un/9ZV
         xDtUmcUYpFcT2ZUkMpRa2pMeyySWE4SwyqfVMKjP8xjnFGLf5TwkPCBxMJj9Yyh5Vg9G
         VFCw==
X-Gm-Message-State: AOJu0YyGlGeJm0d0Vn6c2Un4/dDV12cMm981gA9vXXZo47+Dljrj22IJ
	V58GEA7F+SuRn/zoKghTyquDkU8gyutavJjwYmhA99ucfAMO
X-Google-Smtp-Source: AGHT+IE+Fh8w6hVYEoUvJ3R27PkyItxPpZ3Ve0n/VkluLPVovp4xzA9IeY/NWgpc+Ew3XE6l0U5ySztFmchr61vNb8w=
X-Received: by 2002:a17:907:3a0f:b0:a2b:1fc1:b3b5 with SMTP id
 fb15-20020a1709073a0f00b00a2b1fc1b3b5mr2417096ejc.99.1705361027227; Mon, 15
 Jan 2024 15:23:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109011455.1061529-1-almasrymina@google.com>
 <20240109011455.1061529-3-almasrymina@google.com> <5219f2cd-6854-0134-560d-8ae3f363b53f@huawei.com>
 <CAHS8izOtr+jfqQ6xCB3CoN-K_V1-4hPsB4-k5+1z-M3Qy2BbwA@mail.gmail.com>
 <0711845b-c435-251f-0bbc-20b243721c06@huawei.com> <CAHS8izOxvMVGXKpLBvVgyyS5_94WGG8Aca=O_zGMX+db-3gBXg@mail.gmail.com>
 <66bc7b8f-51b6-0d9e-db5b-47e7ee5e9029@huawei.com>
In-Reply-To: <66bc7b8f-51b6-0d9e-db5b-47e7ee5e9029@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 15 Jan 2024 15:23:33 -0800
Message-ID: <CAHS8izOnhtQGeQ-EFmYjZyZ0eW2LqO0Rrm73eAB2su=UA34yTw@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v5 2/2] net: add netmem to skb_frag_t
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 1:37=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/1/12 23:35, Mina Almasry wrote:
> > On Fri, Jan 12, 2024 at 3:51=E2=80=AFAM Yunsheng Lin <linyunsheng@huawe=
i.com> wrote:
> >>
> >> On 2024/1/12 8:34, Mina Almasry wrote:
> >>> On Thu, Jan 11, 2024 at 4:45=E2=80=AFAM Yunsheng Lin <linyunsheng@hua=
wei.com> wrote:
> >>>>
> >>>> On 2024/1/9 9:14, Mina Almasry wrote:
> >>>>
> >>>> ...
> >>>>
> >>>>>
> >>>>> +             if (WARN_ON_ONCE(!skb_frag_page(&skb_shinfo(skb)->fra=
gs[0]))) {
> >>>>
> >>>> I am really hate to bring it up again.
> >>>> If you are not willing to introduce a new helper,
> >>>
> >>> I'm actually more than happy to add a new helper like:
> >>>
> >>> static inline netmem_ref skb_frag_netmem();
> >>>
> >>> For future callers to obtain frag->netmem to use the netmem_ref direc=
tly.
> >>>
> >>> What I'm hung up on is really your follow up request:
> >>>
> >>> "Is it possible to introduce something like skb_frag_netmem() for
> >>> netmem? so that we can keep most existing users of skb_frag_page()
> >>> unchanged and avoid adding additional checking overhead for existing
> >>> users."
> >>>
> >>> With this patchseries, skb_frag_t no longer has a page pointer inside
> >>> of it, it only has a netmem_ref. The netmem_ref is currently always a
> >>> page, but in the future may not be a page. Can you clarify how we kee=
p
> >>> skb_frag_page() unchanged and without checks? What do you expect
> >>> skb_frag_page() and its callers to do? We can not assume netmem_ref i=
s
> >>> always a struct page. I'm happy to implement a change but I need to
> >>> understand it a bit better.
> >
> >
> > You did not answer my question that I asked here, and ignoring this
> > question is preventing us from making any forward progress on this
> > discussion. What do you expect or want skb_frag_page() to do when
> > there is no page in the frag?
>
> I would expect it to do nothing.

I don't understand. skb_frag_page() with an empty implementation just
results in a compiler error as the function needs to return a page
pointer. Do you actually expect skb_frag_page() to unconditionally
cast frag->netmem to a page pointer? That was explained as
unacceptable over and over again by Jason and Christian as it risks
casting devmem to page; completely unacceptable and will get nacked.
Do you have a suggestion of what skb_frag_page() should do that will
not get nacked by mm?

> IMHO, the caller is expected to only call skb_frag_page() for the frag
> with normal page, for example, doing some 'readable' checking before
> callingskb_frag_page(), or not doing any checking at all if it is called
> in some existing driver not support devmem.
>

You did not specify what you actually want skb_frag_page() to do, but
IMO leaving it up to the programmer to guess/decide if it's safe to
use with no checking in the function is very error prone and hacky, as
the programmer is obviously liable to assume the wrong thing.

All skb_frag_page() callers (which are mainly core networking
actually) would need to do a check anyway to ensure the compiler type
safety, set as a hard requirement by mm & dmabuf maintainers, and at
that point having the check in the function makes sense.

> >
> >>
> >> There are still many existing places still not expecting or handling
> >> skb_frag_page() returning NULL, mostly those are in the drivers not
> >> supporting devmem,
> >
> > As of this series skb_frag_page() cannot return NULL.
> >
> > In the devmem series, all core networking stack places where
> > skb_frag_page() may return NULL are audited.
> >
> > skb_frag_page() returning NULL in a driver that doesn't support devmem
> > is not possible. The driver is the one that creates the devmem frags
>
> Is it possible a netdev supporting devmen and a netdev not supporting
> devmen are put into the same bridge, and a rx skb from netdev supporting
> devmen is forwarded to netdev not supporting devmem?
>
> br_forward() or ip_forward() may be the place that might do this kind
> of forwarding?
>

I'd need to check, but even at that point it sounds to me like this
forwarding code would need to check handle devmem or disabled for
devmem, not a global audit of drivers.

> > in the first place. When the driver author adds devmem support, they
> > should also add support for skb_frag_page() returning NULL.
> >
> >> what's the point of adding the extral overhead for
> >> those driver?
> >>
> >
> > There is no overhead with static branches. The checks are no-op unless
> > the user enables devmem, at which point the devmem connections see no
>
> no-op is still some cpu instruction that will be replaced by some jumping
> instruction when devmem is enabled, right?
>

No, there is no overhead with static branches. There seems to be a
misunderstanding of how they work causing this massive overestimation
of the 'overhead' of the checks. Branches in code are free or almost
free when they are correctly predicted by the compiler:

if (unlikely(check()))
   do_work();
continue();

Is free or almost free when check() is false, as the compiler assumes
check() is false and starts executing continue() immediately. There is
a minor perf hit when the branch is mispredicted as the CPU needs to
start executing do_work() after the check() result is available.
Static branches enable us to at runtime decide which branch the
compiler predicts. We could put devmem processing to always be in the
unlikely path without static branches, but that's not necessary.
Optimizing devmem processing with static branches when devmem is
enabled seems the right choice here. That's my understanding at least.

> Maybe Alexander had better words for those kinds of overhead:
> "The overhead may not seem like much, but when you are having to deal
> with it per page and you are processing pages at millions per second it
> can quickly start to add up."
>
>

This IMO would be relevant if we're adding (significant, or
measureable) overhead to page processing, but with static branches or
putting devmem in the unlikely path we are not.

> > overhead and non-devmem connections will see minimal overhead that I
> > suspect will not reproduce any perf issue. If the user is not fine
> > with that they can simply not enable devmem and continue to not
> > experience any overhead.
> >
> >> The networking stack should forbid skb with devmem frag being forwarde=
d
> >> to drivers not supporting devmem yet. I am sure if this is done proper=
ly
> >> in your patchset yet? if not, I think you might to audit every existin=
g
> >> drivers handling skb_frag_page() returning NULL correctly.
> >>
> >
> > There is no audit required. The devmem frags are generated by the
> > driver and forwarded to the TCP stack, not the other way around.
> >
> >>
> >>>
>


--=20
Thanks,
Mina

