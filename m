Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF04D78DD8F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245064AbjH3Svu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243186AbjH3KQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:16:39 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496671B0;
        Wed, 30 Aug 2023 03:16:36 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so81213881fa.2;
        Wed, 30 Aug 2023 03:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693390594; x=1693995394; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O74fUAq4yON/ngfo+TFWziDGXzfaVIbefUrfdMhAods=;
        b=IkUQad53ce9QYTEHAoOJVlXCsXve4Vrp3HI/zxmHZtxEORXJIG73oFA1T0w+08xZCH
         2bPPgM2KYmQ6+Z6ju8hlybFYuFsMViZGtTyDO+akVu8zi8vjd2OjqdLQzi0AOsG2gOMC
         mGDrePr2eKb2c/HL0naSLdg4CvCsp4fyomDS5nr4SjE1ILgLGjTbrPOAcBWE+5ZTNm/b
         eyoXXiZKUpD2a/lHhrSLv6TCTT2C54pszaw96SzmnpR41SCsDu5Be039lNxEhOa3eRzi
         tx6Uz+XS2NwpP7YqB+mbFGLSqU6Lkw618Rkiwuyw9BkTsvsvuKxMF4MParnKJJLoIK5X
         7RxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693390594; x=1693995394;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O74fUAq4yON/ngfo+TFWziDGXzfaVIbefUrfdMhAods=;
        b=bSFgUlxJ1Q5EIVPd3tcVw2lR880vTTC23E47ugqHW2eMqqJBz+q1dJTRcOmr1kjvIB
         1pe8scZnwrwuOtqCxCvk/5XPnn59NW99E3VyZT4nyL2NcMawTBQbE9X9gMCVcnzOncM+
         gOKiNNKvimN5uacrLJcRmEBqa51H4hFHdoOHTSlo4Q+AmQwDKmvMCOxZTAurKMJdRiVy
         hUDgzuY2G7aZeSgdvrYhh4GgUG/Rx5HOQFT0Ynktrmi+sWTES/19MpvGfPhfwaldlL/q
         CXJ8jtJ3Sy0zKGWSBGZe4ip4BKi2LoZ5jtN3SmhhGtyi5NQolyMYQ1Me3huIxTpz2CqE
         OXWw==
X-Gm-Message-State: AOJu0YxC5CrmC6N/g4Excb7dXJfM+eO7q8zI7MeEPivvMdvnq1cEZxBU
        2vjRvinNlFKZmQFHHdEKLdc=
X-Google-Smtp-Source: AGHT+IGWfBMCbIv10VrnrGwDZQgPmh28LVKHc0tsyuqphHygEgmcQbth01u8VFLvImcuGxc8+h8C7A==
X-Received: by 2002:a2e:9159:0:b0:2bc:ffcc:6cc0 with SMTP id q25-20020a2e9159000000b002bcffcc6cc0mr1610470ljg.17.1693390594126;
        Wed, 30 Aug 2023 03:16:34 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id d6-20020a2eb046000000b002b724063010sm2561269ljl.47.2023.08.30.03.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 03:16:33 -0700 (PDT)
Date:   Wed, 30 Aug 2023 13:16:31 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 6/7] net: stmmac: Fix comment about default
 addend calculation
Message-ID: <b5jay65dndlpzdu7qjxa5ty5vudz62h3xosiu7mjdjvzieoylq@sk7h7erb25bd>
References: <20230824-stmmac-subsecond-inc-cleanup-v1-0-e0b9f7c18b37@redhat.com>
 <20230824-stmmac-subsecond-inc-cleanup-v1-6-e0b9f7c18b37@redhat.com>
 <krvdz4filnpzhdy7tjkaisa2uzeh2sjzc2krno2rns24ldka37@abay33wdcck4>
 <matyki35liqllsiokgn4xrfxabk4wzelif56vtlkvauhkpssor@ohy5a25yk6ja>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mrfk6k2ikf6hihjo"
Content-Disposition: inline
In-Reply-To: <matyki35liqllsiokgn4xrfxabk4wzelif56vtlkvauhkpssor@ohy5a25yk6ja>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mrfk6k2ikf6hihjo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 29, 2023 at 10:01:20AM -0500, Andrew Halaney wrote:
> On Sun, Aug 27, 2023 at 03:02:07AM +0300, Serge Semin wrote:
> > Hi Andrew
> > 
> > On Thu, Aug 24, 2023 at 01:32:57PM -0500, Andrew Halaney wrote:
> > > The comment neglects that freq_div_ratio is the ratio between
> > > the subsecond increment frequency and the clk_ptp_rate frequency.
> > > 
> > > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> > > ---
> > >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > index dfead0df6163..64185753865f 100644
> > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > @@ -853,10 +853,12 @@ int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags)
> > >  	/* Store sub second increment for later use */
> > >  	priv->sub_second_inc = sub_second_inc;
> > >  
> > 
> > > -	/* calculate default addend value:
> > > -	 * formula is :
> > > -	 * addend = (2^32)/freq_div_ratio;
> > > -	 * where, freq_div_ratio = 1e9ns/sub_second_inc
> > > +	/* Calculate default addend so the accumulator overflows (2^32) in
> > > +	 * sub_second_inc (ns). The addend is added to the accumulator
> > > +	 * every clk_ptp cycle.
> > > +	 *
> > > +	 * addend = (2^32) / freq_div_ratio
> > > +	 * where, freq_div_ratio = (1e9ns / sub_second_inc) / clk_ptp_rate
> > >  	 */
> > >  	temp = div_u64(NSEC_PER_SEC, sub_second_inc);
> > >  	temp = temp << 32;
> > 
> > I am not well familiar with the way PTP works but at my naked eyes the
> > calculation implemented here looks a bit different than what is
> > described in the comment.
> > 
> > Basically config_sub_second_increment(clk_ptp_rate, sub_second_inc)
> > returns clk_ptp_rate period in nanoseconds or twice that period, or have it
> > scaled up on 0.465. So we have one of the next formulae:
> > X1 = NSEC_PER_SEC / clk_ptp_rate
> > X2 = 2 * NSEC_PER_SEC / clk_ptp_rate
> > X3 = X1 / 0.465
> > X4 = X2 / 0.465
> 

> X5 = PTP_SSIR_SSINC_MAX (0xFF) is a case as well to consider

I noticed that option too, but then I thought it must have been not
that much probable to be considered as a real case seeing it's a
boundary case. The clamping happens if
if (X1 > 255 || X2 > 255 || X3 > 255 || X4 > 255)
	X5 = 255
so in the worst case PTP-rate period in nanoseconds multiplied by 4.3
must be greater than 255 which is equivalent to X1 >= 60. It means
PTP clock rate must be greater than 16.6MHz to avoid the clamping. In
the best case - 3.9MHz. I doubted that these limits are crossed in
reality. But in anyways you are right saying that it still needs to be
taken into account in case if the implemented algo would be a subject
for optimizations.

> > 
> > Then stmmac_init_tstamp_counter() handles the retrieved period in the
> > next manner:
> > temp = div_u64(NSEC_PER_SEC, sub_second_inc);     // Convert back to frequency
> > temp = temp << 32;                                // multiply by 2^32
> > addend = div_u64(temp, priv->plat->clk_ptp_rate); // Divide by clk_ptp_rate
> > 
> > The code above is equivalent:
> > 
> > addend = ((NSEC_PER_SEC / X) * 2^32 ) / clk_ptp_rate = 
> >          (2^32 * NSEC_PER_SEC / X) / clk_ptp_rate = 
> >          2^32 / (clk_ptp_rate / (NSEC_PER_SEC / X))
> > 
> > AFAICS this doesn't match to what is in the comment (X = sub_second_inc).
> > freq_div_ratio gets to be inverted. Does it?
> 

> You're right, my comment needs to be inverted to match all of the above
> (which is a great recap, thank you!).

Good. Then an hour spent for decyphering of that stuff wasn't a waste
of time after all.)

> 
> > 
> > Substituting X to the formulae above we'll have just four possible results:
> > addend1 = 2^32
> > addend2 = 2^32 / 2
> > addend3 = 0.465 * 2^32
> > addend4 = 0.465 * 2^32 / 2
>
> addend5 = 2^32 / (clk_ptp_rate / (NSEC_PER_SEC / 0xFF))
> 
> I think that would be the PTP_SSIR_SSINC_MAX case (X5) I inserted above
> 
> > 
> > So basically clk_ptp_rate is irrelevant (neglecting all the
> > integer divisions rounding). Is that what implied by the implemented
> > algo?
> > 
> > Am I missing something? (it's quite possible since it's long past
> > midnight already.)
> 
> I believe you've captured everything, minus the one conditional I added.
> 
> I think because of that conditional we can't just nicely code up some
> contants here independent of sub_second_inc. Now I can blame the morning
> and not enough coffee, do you see anything wrong with that thought

I am not that much aware of the PTP internals but it just seems weird
to have clk_ptp_rate not affecting anything except the boundary case.
Do you have a DW *MAC HW databook with the PTP-engine chapter
describing the way the System Time Register Module works?

> process? I'm all ears for suggestions for cleaning this up, especially
> since others like Richard have indicated that it could use some love,

* I would have said more definitive - some _hard_ love.)

> but right now I'm hung up thinking the best I can do is fix the bad
> comment in this patch.

Just at the first very swift glance:
1. See attached patch.
2. Exporting stmmac_init_tstamp_counter() isn't necessary. It doesn't
seem like being utilized anywhere except in the stmmac_main.c module.
3. stmmac_hwtimestamp-based abstraction seems redundant since: just a
single PTP implementation is provided; DW GMAC, DW XGMAC and DW QoS
Eth PTP implementations don't seem like very much different (XGMAC and
QoS Eth seems to have some additional features but the basics looks
the same). Moreover developing a HW-abstraction without having all the
IP-core databooks at hands and having at least two different engines
description seems like a needless over-complication of the code. I
have doubts it was possible to create a comprehensive enough
sub-module to be suitable for the real and any other not yet known PTP
engine.)
4. For the same reason as 2. splitting up the PTP support into two
files seems redundant. stmmac_hwtstamp.c content can be moved to
stmmac_ptp.c .
5. ...

3 and 5 imply bulky and delicate work which I would have attempted
only after much deeper PTP engine studying in all the DW *MAC IP-cores
(I might have missed something) and only having a real PTP-charged
device at hands.

-Serge(y)

> 
> Thanks for the review!
> - Andrew
> 
> 

--mrfk6k2ikf6hihjo
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-stmmac-Stop-overriding-the-PTP-clock-info-static.patch"

From 5ecf0d4f859c42103e69c400dc62b905f423bbe9 Mon Sep 17 00:00:00 2001
From: Serge Semin <fancer.lancer@gmail.com>
Date: Fri, 6 Aug 2021 02:13:36 +0300
Subject: [PATCH] net: stmmac: Stop overriding the PTP clock info static
 instance

It had been defined as constant before commit 9a8a02c9d46d ("net: stmmac:
Add Flexible PPS support"). But then it was converted to be just static,
which fields may get to be modified on each stmmac_ptp_register()
invocation. Since that method is called from the driver probe method, a
concurrent DW *MAC NIC initialization causes the race condition for the
updated stmmac_ptp_clock_ops fields. That also may lead to setting an
inappropriate max_adj value, which was specific for one device, was
written to the stmmac_ptp_clock_ops, but then copied to the private
ptp_clock_info instance unmodified.

So to speak let's leave the stmmac_ptp_clock_ops content untouched and
just copy it to the device-specific instance of the ptp_clock_info
structure, which fields could be then accordingly modified. After that we
can get the const qualifier back to the stmmac_ptp_clock_ops instance
definition.

While at it remove pointless zero-initialization of the
stmmac_ptp_clock_ops fields. It's redundant since the structure is static.

Fixes: 9a8a02c9d46d ("net: stmmac: Add Flexible PPS support")
Fixes: 190f73ab4c43 ("net: stmmac: setup higher frequency clk support for EHL & TGL")
Fixes: f4da56529da6 ("net: stmmac: Add support for external trigger timestamping")
Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_ptp.c  | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
index b4388ca8d211..19a28b1cc272 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.c
@@ -254,15 +254,10 @@ static int stmmac_getcrosststamp(struct ptp_clock_info *ptp,
 }
 
 /* structure describing a PTP hardware clock */
-static struct ptp_clock_info stmmac_ptp_clock_ops = {
+static const struct ptp_clock_info stmmac_ptp_clock_ops = {
 	.owner = THIS_MODULE,
 	.name = "stmmac ptp",
 	.max_adj = 62500000,
-	.n_alarm = 0,
-	.n_ext_ts = 0, /* will be overwritten in stmmac_ptp_register */
-	.n_per_out = 0, /* will be overwritten in stmmac_ptp_register */
-	.n_pins = 0,
-	.pps = 0,
 	.adjfine = stmmac_adjust_freq,
 	.adjtime = stmmac_adjust_time,
 	.gettime64 = stmmac_get_time,
@@ -287,21 +282,21 @@ void stmmac_ptp_register(struct stmmac_priv *priv)
 		priv->pps[i].available = true;
 	}
 
-	if (priv->plat->ptp_max_adj)
-		stmmac_ptp_clock_ops.max_adj = priv->plat->ptp_max_adj;
-
 	/* Calculate the clock domain crossing (CDC) error if necessary */
 	priv->plat->cdc_error_adj = 0;
 	if (priv->plat->has_gmac4 && priv->plat->clk_ptp_rate)
 		priv->plat->cdc_error_adj = (2 * NSEC_PER_SEC) / priv->plat->clk_ptp_rate;
 
-	stmmac_ptp_clock_ops.n_per_out = priv->dma_cap.pps_out_num;
-	stmmac_ptp_clock_ops.n_ext_ts = priv->dma_cap.aux_snapshot_n;
-
 	rwlock_init(&priv->ptp_lock);
 	mutex_init(&priv->aux_ts_lock);
 	priv->ptp_clock_ops = stmmac_ptp_clock_ops;
 
+	if (priv->plat->ptp_max_adj)
+		priv->ptp_clock_ops.max_adj = priv->plat->ptp_max_adj;
+
+	priv->ptp_clock_ops.n_per_out = priv->dma_cap.pps_out_num;
+	priv->ptp_clock_ops.n_ext_ts = priv->dma_cap.aux_snapshot_n;
+
 	priv->ptp_clock = ptp_clock_register(&priv->ptp_clock_ops,
 					     priv->device);
 	if (IS_ERR(priv->ptp_clock)) {
-- 
2.41.0


--mrfk6k2ikf6hihjo--
