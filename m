Return-Path: <linux-kernel+bounces-93591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C91487321C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 10:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FE8C1C21CBC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 09:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D055FBAB;
	Wed,  6 Mar 2024 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="kpBLh5rE"
Received: from bee.tesarici.cz (unknown [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785B75DF14;
	Wed,  6 Mar 2024 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709715721; cv=none; b=itT+UTVTg+Kwdabs2azBuXpCc8EbbawPnR+9iO3N5jv054S8Ch0wNb2a9w2GWvcmKqicNUSL3H2gxwSzBaWMIqebjDmE6AuIpbSSNoh4qUkuggtX0zB9I17jZqcgCmOWxkVp3tonC2yO3GubfqBj66mLyKwtDM0oBbec8q7w7Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709715721; c=relaxed/simple;
	bh=7XL+rmg/KDDdM8d5X26+ryR+7KjkuSIR7iF+X0R/4d8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ey35N6c97eY08NJRU3xokS74JDeYFo6Hvuf0siU/2t+zooFRD5XZp+2TEUqWHgsOo3ZN5Yue1/oNEjyWpYvVhVOPa0TXdViC3swF5+8K29qixbsh/1jyQX/iJ1rWAIOm6pk4OQZrd5yr1c8zr6RxShgwsnGUzvbcPgp0NPXgakA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=kpBLh5rE; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 7B6871CA38F;
	Wed,  6 Mar 2024 10:01:54 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1709715714; bh=YzH+vqMnEg2qYPMQb47PYCat1WD2FNYibWcd0rUjZiY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kpBLh5rESQNyznO+SYYM00jpTxdGjER/C8xQnqISGk8f0f0ZNTfT/wigUZmhMQnJ2
	 lOxnSFnQV276r/0/82WhJDGm7FuNZXWk5cYXxuI64wbdf+opcec/OfNzeagtaH+93y
	 0FdlRPPUnUdTVWLxO/mwJTyeVqpAdwnVcJ9yxLw6Xqq8i8nINb7oboUnf9g98TZKxe
	 +BcSmKTaeZSSPzDJNNM1g9gethLgL5aYOun3EKdUvVp2yW/MKxpBCjDWzvrHMqWzgl
	 psC2i4iZCrhSlkzrcCwazXxAQmLnORH7LaXGXDF2FuzX8aK9xPcG2eUxN8H3NAWoOL
	 ZwMpmdC/IZiFw==
Date: Wed, 6 Mar 2024 10:01:53 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, Eric
 Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, Jisheng
 Zhang <jszhang@kernel.org>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 "open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>, "moderated
 list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, open list
 <linux-kernel@vger.kernel.org>, "open list:ARM/Allwinner sunXi SoC support"
 <linux-sunxi@lists.linux.dev>, Marc Haber <mh+netdev@zugschlus.de>, Andrew
 Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 stable@vger.kernel.org, alexis.lothore@bootlin.com, Guenter Roeck
 <linux@roeck-us.net>
Subject: Re: [PATCH net v3] net: stmmac: protect updates of 64-bit
 statistics counters
Message-ID: <20240306100153.32d305f7@meshulam.tesarici.cz>
In-Reply-To: <e3181555-c08d-463f-a9a9-b08c69875c84@leemhuis.info>
References: <20240203190927.19669-1-petr@tesarici.cz>
	<ea1567d9-ce66-45e6-8168-ac40a47d1821@roeck-us.net>
	<Zct5qJcZw0YKx54r@xhacker>
	<CANn89i+4tVWezqr=BYZ5AF=9EgV2EPqhdHun=u=ga32CEJ4BXQ@mail.gmail.com>
	<20d94512-c4f2-49f7-ac97-846dc24a6730@roeck-us.net>
	<CANn89iL1piwsbsBx4Z=kySUfmPa9LbZn-SNthgA+W6NEnojgSQ@mail.gmail.com>
	<a3749d3f-ced1-4c48-adaf-348c8dee7610@leemhuis.info>
	<20240228120308.48d6a9c2@meshulam.tesarici.cz>
	<e3181555-c08d-463f-a9a9-b08c69875c84@leemhuis.info>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 6 Mar 2024 09:23:53 +0100
"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>=
 wrote:

> On 28.02.24 12:03, Petr Tesa=C5=99=C3=ADk wrote:
> > On Wed, 28 Feb 2024 07:19:56 +0100
> > "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.i=
nfo> wrote:
> >  =20
> >> Net maintainers, chiming in here, as it seems handling this regression
> >> stalled. =20
> > Indeed, I was too busy with sandbox mode... =20
>=20
> Hmm, no reply in the past week to Petr's request for help from someone
> with more knowledge about the field. :-/
>=20
> So I guess this means that this won't be fixed for 6.8? Unfortunate, but
> well, that's how it it sometimes.

For the record, I _can_ reproduce lockdep splats on my device, but they
don't make any sense to me. They seem to confirm Jisheng Zhang's
conclusion that lockdep conflates two locks which should have different
lock-classes.

So far I have noticed only one issue: the per-cpu syncp's are not
initialized. I'll recompile and see if that's what confuses lockdep.

Petr T

> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>=20
> #regzbot poke
>=20
> >> On 13.02.24 16:52, Eric Dumazet wrote: =20
> >>> On Tue, Feb 13, 2024 at 4:26=E2=80=AFPM Guenter Roeck <linux@roeck-us=
net> wrote:   =20
> >>>> On Tue, Feb 13, 2024 at 03:51:35PM +0100, Eric Dumazet wrote:   =20
> >>>>> On Tue, Feb 13, 2024 at 3:29=E2=80=AFPM Jisheng Zhang <jszhang@kern=
el.org> wrote:   =20
> >>>>>> On Sun, Feb 11, 2024 at 08:30:21PM -0800, Guenter Roeck wrote:   =
=20
> >>>>>>> On Sat, Feb 03, 2024 at 08:09:27PM +0100, Petr Tesarik wrote:   =
=20
> >>>>>>>> As explained by a comment in <linux/u64_stats_sync.h>, write sid=
e of struct
> >>>>>>>> u64_stats_sync must ensure mutual exclusion, or one seqcount upd=
ate could
> >>>>>>>> be lost on 32-bit platforms, thus blocking readers forever. Such=
 lockups
> >>>>>>>> have been observed in real world after stmmac_xmit() on one CPU =
raced with
> >>>>>>>> stmmac_napi_poll_tx() on another CPU.
> >>>>>>>>
> >>>>>>>> To fix the issue without introducing a new lock, split the stati=
cs into
> >>>>>>>> three parts:
> >>>>>>>>
> >>>>>>>> 1. fields updated only under the tx queue lock,
> >>>>>>>> 2. fields updated only during NAPI poll,
> >>>>>>>> 3. fields updated only from interrupt context,
> >>>>>>>>
> >>>>>>>> Updates to fields in the first two groups are already serialized=
 through
> >>>>>>>> other locks. It is sufficient to split the existing struct u64_s=
tats_sync
> >>>>>>>> so that each group has its own.
> >>>>>>>>
> >>>>>>>> Note that tx_set_ic_bit is updated from both contexts. Split thi=
s counter
> >>>>>>>> so that each context gets its own, and calculate their sum to ge=
t the total
> >>>>>>>> value in stmmac_get_ethtool_stats().
> >>>>>>>>
> >>>>>>>> For the third group, multiple interrupts may be processed by dif=
ferent CPUs
> >>>>>>>> at the same time, but interrupts on the same CPU will not nest. =
Move fields
> >>>>>>>> from this group to a newly created per-cpu struct stmmac_pcpu_st=
ats.
> >>>>>>>>
> >>>>>>>> Fixes: 133466c3bbe1 ("net: stmmac: use per-queue 64 bit statisti=
cs where necessary")
> >>>>>>>> Link: https://lore.kernel.org/netdev/Za173PhviYg-1qIn@torres.zug=
schlus.de/t/
> >>>>>>>> Cc: stable@vger.kernel.org
> >>>>>>>> Signed-off-by: Petr Tesarik <petr@tesarici.cz>   =20
> >>>>>>>
> >>>>>>> This patch results in a lockdep splat. Backtrace and bisect resul=
ts attached.
> >>>>>>>
> >>>>>>> ---
> >>>>>>> [   33.736728] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>>>>>> [   33.736805] WARNING: inconsistent lock state
> >>>>>>> [   33.736953] 6.8.0-rc4 #1 Tainted: G                 N
> >>>>>>> [   33.737080] --------------------------------
> >>>>>>> [   33.737155] inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usag=
e.
> >>>>>>> [   33.737309] kworker/0:2/39 [HC1[1]:SC0[2]:HE0:SE0] takes:
> >>>>>>> [   33.737459] ef792074 (&syncp->seq#2){?...}-{0:0}, at: sun8i_dw=
mac_dma_interrupt+0x9c/0x28c
> >>>>>>> [   33.738206] {HARDIRQ-ON-W} state was registered at:
> >>>>>>> [   33.738318]   lock_acquire+0x11c/0x368
> >>>>>>> [   33.738431]   __u64_stats_update_begin+0x104/0x1ac
> >>>>>>> [   33.738525]   stmmac_xmit+0x4d0/0xc58   =20
> >>>>>>
> >>>>>> interesting lockdep splat...
> >>>>>> stmmac_xmit() operates on txq_stats->q_syncp, while the
> >>>>>> sun8i_dwmac_dma_interrupt() operates on pcpu's priv->xstats.pcpu_s=
tats
> >>>>>> they are different syncp. so how does lockdep splat happen.   =20
> >>>>>
> >>>>> Right, I do not see anything obvious yet.   =20
> >>>>
> >>>> Wild guess: I think it maybe saying that due to
> >>>>
> >>>>         inconsistent {HARDIRQ-ON-W} -> {IN-HARDIRQ-W} usage.
> >>>>
> >>>> the critical code may somehow be interrupted and, while handling the
> >>>> interrupt, try to acquire the same lock again.   =20
> >>>
> >>> This should not happen, the 'syncp' are different. They have different
> >>> lockdep classes.
> >>>
> >>> One is exclusively used from hard irq context.
> >>>
> >>> The second one only used from BH context.   =20
> >>
> >> Alexis Lothor=C3=A9 hit this now as well, see yesterday report in this
> >> thread; apart from that nothing seem to have happened for two weeks no=
w.
> >> The change recently made it to some stable/longterm kernels, too. Makes
> >> me wonder:
> >>
> >> What's the plan forward here? Is this considered to be a false positiv=
e? =20
> >=20
> > Although my system has run stable for a couple of months, I am hesitant
> > to call it a false positive.
> >  =20
> >> Or a real problem? =20
> >=20
> > That's what I think. But I would have to learn a lot about the network
> > stack to understand what exactly happens here.
> >=20
> > It may go faster if somebody else on the Cc can give me a hint where to
> > start looking based on the lockdep warning.
> >=20
> > Petr T
> >=20
> >  =20


