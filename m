Return-Path: <linux-kernel+bounces-17921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 085F4825522
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 15:27:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D2D32856A7
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 14:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 355412E413;
	Fri,  5 Jan 2024 14:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q2nhLLux"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99032E3FF
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 14:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-55679552710so9071a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 06:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704464795; x=1705069595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ertu959bjOalPicwP5y7fvQYTT2yinxYlnafGaXe6yI=;
        b=q2nhLLuxt0uoBE6Y88rtbx4WCd6KTYJUbSeWWgaoOcjitu56VpXxoTvHj43mvmacgT
         hxtf6i0osMeAfytCp1DfMaNxSyPRdGx8PLMkkeDbcTRM0bwDKU82Gg2lB3jXtCEUoK0M
         bVzNnWZa9Dl1fnclB5gDYkkwO7D+CUKYuXSEsQmWTGVNiR7b78926Cz6GdJDGktd0kn/
         nn19Y8D8wma7j0icN67EbTCree9ADjSLkKfqTOfXoqCRuWBZagXpj0XIRQnz4bw21+N+
         JdESGQWL6uMMr/JwbhTsG4OpY/vlvPFWnAoGeS6PnL6cHh22l/IoP0c3+TLd6kkV7EIQ
         0m2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704464795; x=1705069595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ertu959bjOalPicwP5y7fvQYTT2yinxYlnafGaXe6yI=;
        b=SZz+y6rjlh/5O9gPM0BQc4j/c0Lg48FsIhL/iOWMrz6upv/ACMMVN+OZTHaCZ53fo6
         rnp/QWP6JgHaxyJgHIVpBbvQlu9onPKdvTtv4uBvnMjfyn+m8mdmSEaTvVSG9xOC2+Nt
         40o9zeh7Twr7/ZFjZv554ffOx7NpOTNVIYsXMhcuUhhD4ldPWN7W1rmN9ZICroD5MpAl
         1AvufwdotQF3M0bCabyLmCOJA0YkhtUd/xeCtY0hJSfP35GVULZIu9EAUe40oZ1w9717
         M6QU4DTNMPoq7Vn2l7XLygheLwfGLjqw3yb81EshBUFjvhyOPsCY3LFrHDdOkiv8WoxX
         GLQw==
X-Gm-Message-State: AOJu0YwuFWlgbnP1hddRQqINfHgb1o1rE3Zow+pZVM+wS+Tg9lUc5jqt
	ERn+26NWMk1oUv9y1kIKVprwqWQWL/qot4/cvk09YFoXo6MI
X-Google-Smtp-Source: AGHT+IESHnJsxpf00LEOnpGiHPsPvwsavyRYn3QDmEvFp5F3KnujN7kspizGLy7jLoyWuCnbw9NMtW/VQ3c3fBpFFEA=
X-Received: by 2002:a50:8743:0:b0:553:5578:2fc9 with SMTP id
 3-20020a508743000000b0055355782fc9mr129890edv.5.1704464794698; Fri, 05 Jan
 2024 06:26:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105091556.15516-1-petr@tesarici.cz> <CANn89iLuYZBersxq4aH-9Fg_ojD0fh=0xtdLbRdbMrup=nvrkA@mail.gmail.com>
 <20240105113402.0f5f1232@meshulam.tesarici.cz> <CANn89iLEvW9ZS=+WPETPC=mKRyu9AKmueGCWZZOrz9oX3Xef=g@mail.gmail.com>
 <20240105121447.11ae80d1@meshulam.tesarici.cz> <20240105142732.1903bc70@meshulam.tesarici.cz>
In-Reply-To: <20240105142732.1903bc70@meshulam.tesarici.cz>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 5 Jan 2024 15:26:20 +0100
Message-ID: <CANn89iLHLvGFX_JEYU-en0ZoCUpTvjXPBzFECxLFfa_Jhpcjmg@mail.gmail.com>
Subject: Re: [PATCH] net: stmmac: protect statistics updates with a spinlock
To: =?UTF-8?B?UGV0ciBUZXNhxZnDrWs=?= <petr@tesarici.cz>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, Chen-Yu Tsai <wens@csie.org>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, 
	"open list:STMMAC ETHERNET DRIVER" <netdev@vger.kernel.org>, 
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-stm32@st-md-mailman.stormreply.com>, 
	"moderated list:ARM/STM32 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>, Jiri Pirko <jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 2:27=E2=80=AFPM Petr Tesa=C5=99=C3=ADk <petr@tesaric=
i.cz> wrote:
>
> Hi Eric,
>
> yeah, it's me again...
>
> On Fri, 5 Jan 2024 12:14:47 +0100
> Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> wrote:
>
> > On Fri, 5 Jan 2024 11:48:19 +0100
> > Eric Dumazet <edumazet@google.com> wrote:
> >
> > > On Fri, Jan 5, 2024 at 11:34=E2=80=AFAM Petr Tesa=C5=99=C3=ADk <petr@=
tesarici.cz> wrote:
> > > >
> > > > On Fri, 5 Jan 2024 10:58:42 +0100
> > > > Eric Dumazet <edumazet@google.com> wrote:
> > > >
> > > > > On Fri, Jan 5, 2024 at 10:16=E2=80=AFAM Petr Tesarik <petr@tesari=
ci.cz> wrote:
> > > > > >
> > > > > > Add a spinlock to fix race conditions while updating Tx/Rx stat=
istics.
> > > > > >
> > > > > > As explained by a comment in <linux/u64_stats_sync.h>, write si=
de of struct
> > > > > > u64_stats_sync must ensure mutual exclusion, or one seqcount up=
date could
> > > > > > be lost on 32-bit platforms, thus blocking readers forever.
> > > > > >
> > > > > > Such lockups have been actually observed on 32-bit Arm after st=
mmac_xmit()
> > > > > > on one core raced with stmmac_napi_poll_tx() on another core.
> > > > > >
> > > > > > Signed-off-by: Petr Tesarik <petr@tesarici.cz>
> > > > >
> > > > > This is going to add more costs to 64bit platforms ?
> > > >
> > > > Yes, it adds a (hopefully not too contended) spinlock and in most
> > > > places an interrupt disable/enable pair.
> > > >
> > > > FWIW the race condition is also present on 64-bit platforms, result=
ing
> > > > in inaccurate statistic counters. I can understand if you consider =
it a
> > > > mild annoyance, not worth fixing.
> > > >
> > > > > It seems to me that the same syncp can be used from two different
> > > > > threads : hard irq and napi poller...
> > > >
> > > > Yes, that's exactly the scenario that locks up my system.
> > > >
> > > > > At this point, I do not see why you keep linux/u64_stats_sync.h i=
f you
> > > > > decide to go for a spinlock...
> > > >
> > > > The spinlock does not havce to be taken on the reader side, so the
> > > > seqcounter still adds some value.
> > > >
> > > > > Alternative would use atomic64_t fields for the ones where there =
is no
> > > > > mutual exclusion.
> > > > >
> > > > > RX : napi poll is definitely safe (protected by an atomic bit)
> > > > > TX : each TX queue is also safe (protected by an atomic exclusion=
 for
> > > > > non LLTX drivers)
> > > > >
> > > > > This leaves the fields updated from hardware interrupt context ?
> > > >
> > > > I'm afraid I don't have enough network-stack-foo to follow here.
> > > >
> > > > My issue on 32 bit is that stmmac_xmit() may be called directly fro=
m
> > > > process context while another core runs the TX napi on the same cha=
nnel
> > > > (in interrupt context). I didn't observe any race on the RX path, b=
ut I
> > > > believe it's possible with NAPI busy polling.
> > > >
> > > > In any case, I don't see the connection with LLTX. Maybe you want t=
o
> > > > say that the TX queue is safe for stmmac (because it is a non-LLTX
> > > > driver), but might not be safe for LLTX drivers?
> > >
> > > LLTX drivers (mostly virtual drivers like tunnels...) can have multip=
le cpus
> > > running ndo_start_xmit() concurrently. So any use of a 'shared syncp'
> > > would be a bug.
> > > These drivers usually use per-cpu stats, to avoid races and false
> > > sharing anyway.
> > >
> > > I think you should split the structures into two separate groups, eac=
h
> > > guarded with its own syncp.
> > >
> > > No extra spinlocks, no extra costs on 64bit arches...
> > >
> > > If TX completion can run in parallel with ndo_start_xmit(), then
> > > clearly we have to split stmmac_txq_stats in two halves:
> >
> > Oh, now I get it. Yes, that's much better, indeed.
> >
> > I mean, the counters have never been consistent (due to the race on the
> > writer side), and nobody is concerned. So, there is no value in taking
> > a consistent snapshot in stmmac_get_ethtool_stats().
> >
> > I'm going to rework and retest my patch. Thank you for pointing me in
> > the right direction!
> >
> > Petr T
> >
> > > Also please note the conversion from u64 to u64_stats_t
> >
> > Noted. IIUC this will in turn close the update race on 64-bit by using
> > an atomic type and on 32-bit by using a seqlock. Clever.
> >
> > Petr T
> >
> > > Very partial patch, only to show the split and new structure :
> > >
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h
> > > b/drivers/net/ethernet/stmicro/stmmac/common.h
> > > index e3f650e88f82f927f0dcf95748fbd10c14c30cbe..702bceea5dc8c875a80f5=
e3a92b7bb058f373eda
> > > 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/common.h
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/common.h
> > > @@ -60,16 +60,22 @@
> > >  /* #define FRAME_FILTER_DEBUG */
> > >
> > >  struct stmmac_txq_stats {
> > > -       u64 tx_bytes;
> > > -       u64 tx_packets;
> > > -       u64 tx_pkt_n;
> > > -       u64 tx_normal_irq_n;
> > > -       u64 napi_poll;
> > > -       u64 tx_clean;
> > > -       u64 tx_set_ic_bit;
> > > -       u64 tx_tso_frames;
> > > -       u64 tx_tso_nfrags;
> > > -       struct u64_stats_sync syncp;
> > > +/* First part, updated from ndo_start_xmit(), protected by tx queue =
lock */
> > > +       struct u64_stats_sync syncp_tx;
> > > +       u64_stats_t tx_bytes;
> > > +       u64_stats_t tx_packets;
> > > +       u64_stats_t tx_pkt_n;
> > > +       u64_stats_t tx_tso_frames;
> > > +       u64_stats_t tx_tso_nfrags;
> > > +
> > > +/* Second part, updated from TX completion (protected by NAPI poll l=
ogic) */
> > > +       struct u64_stats_sync syncp_tx_completion;
> > > +       u64_stats_t napi_poll;
> > > +       u64_stats_t tx_clean;
> > > +       u64_stats_t tx_set_ic_bit;
>
> Unfortunately, this field is also updated from ndo_start_xmit():
>
> 4572)     if (set_ic)
> 4573)             txq_stats->tx_set_ic_bit++;
>
> I feel it would be a shame to introduce a spinlock just for this one
> update. But I think the field could be converted to an atomic64_t.
>
> Which raises a question: Why aren't all stat counters simply atomic64_t? =
There
> is no guarantee that the reader side takes a consistent snapshot
> (except on 32-bit). So, why do we even bother with u64_stats_sync?

This infra was added to have no _lock_ overhead on 64bit arches.

If a counter must be updated from multiple cpus (regardless of 32/64
bit kernel), then use atomic64_t

>
> Is it merely because u64_stats_add() should be cheaper than
> atomic64_add()? Or is there anything else I'm missing? If yes, does it
> invalidate my proposal to convert tx_set_ic_bit to an atomic64_t?

atomic64_add() is expensive, especially in contexts where updates are
already guarded by a spinlock or something.

