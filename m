Return-Path: <linux-kernel+bounces-17770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D286482525A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 11:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6491F23E91
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 10:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C9125572;
	Fri,  5 Jan 2024 10:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4j7dmrj9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372DF250E7
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 10:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5534180f0e9so6650a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jan 2024 02:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704451713; x=1705056513; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oA+DfvkF/6fqh1TmhIwoR/ZJIBR+b0c6R1YFEKfiMo=;
        b=4j7dmrj9JPHMWgyvxsbkaV1dTFSw0iO6QZL6hP/hgVOvqPaveF3PANId4ep2dad4cY
         M4fISu7c58BFe9gmDJ61UrrYAxKCUk5wSLSXBTUu+ITw1Zy05QZCG/k3S7SytxPwm8yY
         /+jQqE2ibWQHUlHk1hKX8fQoYP2xgEvq/UCJRBkk6chEInMMARwBy3bgfflIhoi9FMMG
         gfQEvaxE241W1aHWmLuwVB91AEeSP138I5TnqJtHzg3n4i6Fqg3+0TlEDPhXBvy2cum+
         XL+X/NFGLcPcidwuGkw5SLENpm69NOZ4AXR5U/1QBRWmZUlB1Ikh0rrfyeomF5cow+sG
         CEMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704451713; x=1705056513;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2oA+DfvkF/6fqh1TmhIwoR/ZJIBR+b0c6R1YFEKfiMo=;
        b=QQME3mEG1kRrtsMFae9ci0sS5/2kwrtvJYbnLtDv3NaRmYvLeafRzqAHZHXke6l6yH
         I8LjfNx6YFN/R3AOVpoAZUmQnv8fe8EOU/mCk8Epi+DXc8EhrlgATuGhHwgD7mvJZouM
         hvPjXk6fFdTvO/zJ1IfbwbvIBHmdUrdBGM49XiWexh/XMCoYuE+vqGDWVLn9AGJgtBjg
         dTFM0CZJq8KHjmvPCT9PKRJy3OvcmQ73dRp+KyTQmzO5/4AUI34xQ8xHN0LMRksovCJH
         B89qVlggeH5GNIIMYQiovH0KampbLx7v+HvBKmbjIQXLwQUsyFcb6vEC8UJWzL1JCbFJ
         smpw==
X-Gm-Message-State: AOJu0YxRhkMEDULgwsoUWNC2ghGBk5kowDZQ6YRFGlsmwmldZGtp3Vjq
	A9UARtidSf7T/XZr5xzA6vll8gxjxIA3HXBBTxPQbIAXeF2w
X-Google-Smtp-Source: AGHT+IFv0vnQPWdLPrQsYnDtRDca919RUkeRsM5oeQs2Ots7c0R+6Lp39rU3ebTS/BDKx4md8p4+GBkyTzo7A8Jpejw=
X-Received: by 2002:a50:c05b:0:b0:554:98aa:f75c with SMTP id
 u27-20020a50c05b000000b0055498aaf75cmr101190edd.5.1704451713227; Fri, 05 Jan
 2024 02:48:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240105091556.15516-1-petr@tesarici.cz> <CANn89iLuYZBersxq4aH-9Fg_ojD0fh=0xtdLbRdbMrup=nvrkA@mail.gmail.com>
 <20240105113402.0f5f1232@meshulam.tesarici.cz>
In-Reply-To: <20240105113402.0f5f1232@meshulam.tesarici.cz>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 5 Jan 2024 11:48:19 +0100
Message-ID: <CANn89iLEvW9ZS=+WPETPC=mKRyu9AKmueGCWZZOrz9oX3Xef=g@mail.gmail.com>
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
	"open list:ARM/Allwinner sunXi SoC support" <linux-sunxi@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 5, 2024 at 11:34=E2=80=AFAM Petr Tesa=C5=99=C3=ADk <petr@tesari=
ci.cz> wrote:
>
> On Fri, 5 Jan 2024 10:58:42 +0100
> Eric Dumazet <edumazet@google.com> wrote:
>
> > On Fri, Jan 5, 2024 at 10:16=E2=80=AFAM Petr Tesarik <petr@tesarici.cz>=
 wrote:
> > >
> > > Add a spinlock to fix race conditions while updating Tx/Rx statistics=
.
> > >
> > > As explained by a comment in <linux/u64_stats_sync.h>, write side of =
struct
> > > u64_stats_sync must ensure mutual exclusion, or one seqcount update c=
ould
> > > be lost on 32-bit platforms, thus blocking readers forever.
> > >
> > > Such lockups have been actually observed on 32-bit Arm after stmmac_x=
mit()
> > > on one core raced with stmmac_napi_poll_tx() on another core.
> > >
> > > Signed-off-by: Petr Tesarik <petr@tesarici.cz>
> >
> > This is going to add more costs to 64bit platforms ?
>
> Yes, it adds a (hopefully not too contended) spinlock and in most
> places an interrupt disable/enable pair.
>
> FWIW the race condition is also present on 64-bit platforms, resulting
> in inaccurate statistic counters. I can understand if you consider it a
> mild annoyance, not worth fixing.
>
> > It seems to me that the same syncp can be used from two different
> > threads : hard irq and napi poller...
>
> Yes, that's exactly the scenario that locks up my system.
>
> > At this point, I do not see why you keep linux/u64_stats_sync.h if you
> > decide to go for a spinlock...
>
> The spinlock does not havce to be taken on the reader side, so the
> seqcounter still adds some value.
>
> > Alternative would use atomic64_t fields for the ones where there is no
> > mutual exclusion.
> >
> > RX : napi poll is definitely safe (protected by an atomic bit)
> > TX : each TX queue is also safe (protected by an atomic exclusion for
> > non LLTX drivers)
> >
> > This leaves the fields updated from hardware interrupt context ?
>
> I'm afraid I don't have enough network-stack-foo to follow here.
>
> My issue on 32 bit is that stmmac_xmit() may be called directly from
> process context while another core runs the TX napi on the same channel
> (in interrupt context). I didn't observe any race on the RX path, but I
> believe it's possible with NAPI busy polling.
>
> In any case, I don't see the connection with LLTX. Maybe you want to
> say that the TX queue is safe for stmmac (because it is a non-LLTX
> driver), but might not be safe for LLTX drivers?

LLTX drivers (mostly virtual drivers like tunnels...) can have multiple cpu=
s
running ndo_start_xmit() concurrently. So any use of a 'shared syncp'
would be a bug.
These drivers usually use per-cpu stats, to avoid races and false
sharing anyway.

I think you should split the structures into two separate groups, each
guarded with its own syncp.

No extra spinlocks, no extra costs on 64bit arches...

If TX completion can run in parallel with ndo_start_xmit(), then
clearly we have to split stmmac_txq_stats in two halves:

Also please note the conversion from u64 to u64_stats_t

Very partial patch, only to show the split and new structure :

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h
b/drivers/net/ethernet/stmicro/stmmac/common.h
index e3f650e88f82f927f0dcf95748fbd10c14c30cbe..702bceea5dc8c875a80f5e3a92b=
7bb058f373eda
100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -60,16 +60,22 @@
 /* #define FRAME_FILTER_DEBUG */

 struct stmmac_txq_stats {
-       u64 tx_bytes;
-       u64 tx_packets;
-       u64 tx_pkt_n;
-       u64 tx_normal_irq_n;
-       u64 napi_poll;
-       u64 tx_clean;
-       u64 tx_set_ic_bit;
-       u64 tx_tso_frames;
-       u64 tx_tso_nfrags;
-       struct u64_stats_sync syncp;
+/* First part, updated from ndo_start_xmit(), protected by tx queue lock *=
/
+       struct u64_stats_sync syncp_tx;
+       u64_stats_t tx_bytes;
+       u64_stats_t tx_packets;
+       u64_stats_t tx_pkt_n;
+       u64_stats_t tx_tso_frames;
+       u64_stats_t tx_tso_nfrags;
+
+/* Second part, updated from TX completion (protected by NAPI poll logic) =
*/
+       struct u64_stats_sync syncp_tx_completion;
+       u64_stats_t napi_poll;
+       u64_stats_t tx_clean;
+       u64_stats_t tx_set_ic_bit;
+
+/* Following feld is updated from hard irq context... */
+       atomic64_t tx_normal_irq_n;
 } ____cacheline_aligned_in_smp;

 struct stmmac_rxq_stats {

