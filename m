Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529D278D8D8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbjH3SbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243234AbjH3K00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:26:26 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61546C0;
        Wed, 30 Aug 2023 03:26:22 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2bcc846fed0so82118381fa.2;
        Wed, 30 Aug 2023 03:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693391180; x=1693995980; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QIXCLg0hwpHbeiH0A783o6Qt6FNWASfzco1qAUgQXkc=;
        b=C39Y1J5lMi2knaCAOxR8+OTpy4LnNslwbcSSqA9aHZgSlIFz06iFNUwOO4QhZ1LpUI
         lIFhk2jwPgxV5qSErkmKoY+xahY0uCuojsb4RgYt5XqG9ZAllcP60+m+DdZbopW7lJQR
         zZ2GPckkjIBa6bp1hjksz98y3UQJ3E8vgjlk4ceUIzYQbHZGBUyuNNHmR9vsGR4aygHh
         GeNJcTRx+6EfRLOou+jQQLFai/izXcat0cj6KrRwO2mZUiBQPlWTP0sgs+UTXm1K9876
         02m/UScniVYTZvhRAP5Q/chC2+roDWaQxtG1v+H+YALxc4+POoTStBTahTpt6L0FN49J
         tstg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693391180; x=1693995980;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QIXCLg0hwpHbeiH0A783o6Qt6FNWASfzco1qAUgQXkc=;
        b=VVXV6XLBNCVXQk+IaDDPLeIxAP/uv18abC0Qg4IfNc1SU7q/YhaTrCjHOnJ9JXrCYJ
         lQXtDPuA3nQJv3Ni2BedkPG63uqFnHfAWnDY8SN6exXrbpSrl6GuoUbh8WDnxkGbajaJ
         PGgfQjghdQ6hSMWTZm4Ota/EuzklmDdQ92p1YRNCcIn7eqAx8ugAZiBcl1RLxLWPP1yT
         8pGR52/9suOZWxZdCfsWDFtVEEKSfXkFIY5wAOj2GFZeEnaxbYl8FjjQHksFS87qHgMV
         6teXgiD4O8rLpczbz4jYY7Nf/paVexL92/IER8b3jI9139HfNHlKYjlCt6UNgFNeWLGf
         /A6w==
X-Gm-Message-State: AOJu0YxqNwrHc6+DObFyImZVApn5Kc/fowihghVg7+M8vwFPDVvuNEru
        T7dBD1veZ5HRjbLxjZXKnjc=
X-Google-Smtp-Source: AGHT+IFOMIX/EKJolcvqYh3uDcQSsEpOgptxSp5kdMQbbilG0BSCQCBqtmrYF/z3DBglm0wuXQLtcQ==
X-Received: by 2002:a2e:9990:0:b0:2bc:dab2:c7dc with SMTP id w16-20020a2e9990000000b002bcdab2c7dcmr1316591lji.47.1693391180347;
        Wed, 30 Aug 2023 03:26:20 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id z19-20020a2e9653000000b002ba0497cc99sm2522952ljh.70.2023.08.30.03.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 03:26:19 -0700 (PDT)
Date:   Wed, 30 Aug 2023 13:26:16 +0300
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
Message-ID: <bdliy63ifn7npbpqpk4twwzsxjulwe4druo5nwhaymbrdwv3cu@khb3zhn3npaf>
References: <20230824-stmmac-subsecond-inc-cleanup-v1-0-e0b9f7c18b37@redhat.com>
 <20230824-stmmac-subsecond-inc-cleanup-v1-6-e0b9f7c18b37@redhat.com>
 <krvdz4filnpzhdy7tjkaisa2uzeh2sjzc2krno2rns24ldka37@abay33wdcck4>
 <matyki35liqllsiokgn4xrfxabk4wzelif56vtlkvauhkpssor@ohy5a25yk6ja>
 <b5jay65dndlpzdu7qjxa5ty5vudz62h3xosiu7mjdjvzieoylq@sk7h7erb25bd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5jay65dndlpzdu7qjxa5ty5vudz62h3xosiu7mjdjvzieoylq@sk7h7erb25bd>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 30, 2023 at 01:16:31PM +0300, Serge Semin wrote:
> On Tue, Aug 29, 2023 at 10:01:20AM -0500, Andrew Halaney wrote:
> > On Sun, Aug 27, 2023 at 03:02:07AM +0300, Serge Semin wrote:
> > > Hi Andrew
> > > 
> > > On Thu, Aug 24, 2023 at 01:32:57PM -0500, Andrew Halaney wrote:
> > > > The comment neglects that freq_div_ratio is the ratio between
> > > > the subsecond increment frequency and the clk_ptp_rate frequency.
> > > > 
> > > > Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> > > > ---
> > > >  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 10 ++++++----
> > > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > index dfead0df6163..64185753865f 100644
> > > > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > > > @@ -853,10 +853,12 @@ int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags)
> > > >  	/* Store sub second increment for later use */
> > > >  	priv->sub_second_inc = sub_second_inc;
> > > >  
> > > 
> > > > -	/* calculate default addend value:
> > > > -	 * formula is :
> > > > -	 * addend = (2^32)/freq_div_ratio;
> > > > -	 * where, freq_div_ratio = 1e9ns/sub_second_inc
> > > > +	/* Calculate default addend so the accumulator overflows (2^32) in
> > > > +	 * sub_second_inc (ns). The addend is added to the accumulator
> > > > +	 * every clk_ptp cycle.
> > > > +	 *
> > > > +	 * addend = (2^32) / freq_div_ratio
> > > > +	 * where, freq_div_ratio = (1e9ns / sub_second_inc) / clk_ptp_rate
> > > >  	 */
> > > >  	temp = div_u64(NSEC_PER_SEC, sub_second_inc);
> > > >  	temp = temp << 32;
> > > 
> > > I am not well familiar with the way PTP works but at my naked eyes the
> > > calculation implemented here looks a bit different than what is
> > > described in the comment.
> > > 
> > > Basically config_sub_second_increment(clk_ptp_rate, sub_second_inc)
> > > returns clk_ptp_rate period in nanoseconds or twice that period, or have it
> > > scaled up on 0.465. So we have one of the next formulae:
> > > X1 = NSEC_PER_SEC / clk_ptp_rate
> > > X2 = 2 * NSEC_PER_SEC / clk_ptp_rate
> > > X3 = X1 / 0.465
> > > X4 = X2 / 0.465
> > 
> 
> > X5 = PTP_SSIR_SSINC_MAX (0xFF) is a case as well to consider
> 
> I noticed that option too, but then I thought it must have been not
> that much probable to be considered as a real case seeing it's a
> boundary case. The clamping happens if
> if (X1 > 255 || X2 > 255 || X3 > 255 || X4 > 255)
> 	X5 = 255
> so in the worst case PTP-rate period in nanoseconds multiplied by 4.3
> must be greater than 255 which is equivalent to X1 >= 60. It means
> PTP clock rate must be greater than 16.6MHz to avoid the clamping. In
> the best case - 3.9MHz. I doubted that these limits are crossed in
> reality. But in anyways you are right saying that it still needs to be
> taken into account in case if the implemented algo would be a subject
> for optimizations.
> 
> > > 
> > > Then stmmac_init_tstamp_counter() handles the retrieved period in the
> > > next manner:
> > > temp = div_u64(NSEC_PER_SEC, sub_second_inc);     // Convert back to frequency
> > > temp = temp << 32;                                // multiply by 2^32
> > > addend = div_u64(temp, priv->plat->clk_ptp_rate); // Divide by clk_ptp_rate
> > > 
> > > The code above is equivalent:
> > > 
> > > addend = ((NSEC_PER_SEC / X) * 2^32 ) / clk_ptp_rate = 
> > >          (2^32 * NSEC_PER_SEC / X) / clk_ptp_rate = 
> > >          2^32 / (clk_ptp_rate / (NSEC_PER_SEC / X))
> > > 
> > > AFAICS this doesn't match to what is in the comment (X = sub_second_inc).
> > > freq_div_ratio gets to be inverted. Does it?
> > 
> 
> > You're right, my comment needs to be inverted to match all of the above
> > (which is a great recap, thank you!).
> 
> Good. Then an hour spent for decyphering of that stuff wasn't a waste
> of time after all.)
> 
> > 
> > > 
> > > Substituting X to the formulae above we'll have just four possible results:
> > > addend1 = 2^32
> > > addend2 = 2^32 / 2
> > > addend3 = 0.465 * 2^32
> > > addend4 = 0.465 * 2^32 / 2
> >
> > addend5 = 2^32 / (clk_ptp_rate / (NSEC_PER_SEC / 0xFF))
> > 
> > I think that would be the PTP_SSIR_SSINC_MAX case (X5) I inserted above
> > 
> > > 
> > > So basically clk_ptp_rate is irrelevant (neglecting all the
> > > integer divisions rounding). Is that what implied by the implemented
> > > algo?
> > > 
> > > Am I missing something? (it's quite possible since it's long past
> > > midnight already.)
> > 
> > I believe you've captured everything, minus the one conditional I added.
> > 
> > I think because of that conditional we can't just nicely code up some
> > contants here independent of sub_second_inc. Now I can blame the morning
> > and not enough coffee, do you see anything wrong with that thought
> 
> I am not that much aware of the PTP internals but it just seems weird
> to have clk_ptp_rate not affecting anything except the boundary case.
> Do you have a DW *MAC HW databook with the PTP-engine chapter
> describing the way the System Time Register Module works?
> 

> > process? I'm all ears for suggestions for cleaning this up, especially
> > since others like Richard have indicated that it could use some love,
> 
> * I would have said more definitive - some _hard_ love.)
> 
> > but right now I'm hung up thinking the best I can do is fix the bad
> > comment in this patch.
> 
> Just at the first very swift glance:
> 1. See attached patch.
> 2. Exporting stmmac_init_tstamp_counter() isn't necessary. It doesn't
> seem like being utilized anywhere except in the stmmac_main.c module.
> 3. stmmac_hwtimestamp-based abstraction seems redundant since: just a
> single PTP implementation is provided; DW GMAC, DW XGMAC and DW QoS
> Eth PTP implementations don't seem like very much different (XGMAC and
> QoS Eth seems to have some additional features but the basics looks
> the same). Moreover developing a HW-abstraction without having all the
> IP-core databooks at hands and having at least two different engines
> description seems like a needless over-complication of the code. I
> have doubts it was possible to create a comprehensive enough
> sub-module to be suitable for the real and any other not yet known PTP
> engine.)
> 4. For the same reason as 2. splitting up the PTP support into two
> files seems redundant. stmmac_hwtstamp.c content can be moved to
> stmmac_ptp.c .
> 5. ...

Ah, if you were talking about the Sub-second Increment part and the
System Time Register module then alas I can't help with that much
since I have only a very shallow knowledge about PTP in general, not
to say about that particular module.

-Serge(y)

> 
> 3 and 5 imply bulky and delicate work which I would have attempted
> only after much deeper PTP engine studying in all the DW *MAC IP-cores
> (I might have missed something) and only having a real PTP-charged
> device at hands.
> 
> -Serge(y)
> 
> > 
> > Thanks for the review!
> > - Andrew
> > 
> > 


