Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F9D7899E6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 02:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjH0ACV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 20:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjH0ACQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 20:02:16 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B36018C;
        Sat, 26 Aug 2023 17:02:13 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b72161c6e9so36135741fa.0;
        Sat, 26 Aug 2023 17:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693094532; x=1693699332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BziPzk/8G2vrhw0dTzUPnWi0alpCUqJuRBn4AMK0kR4=;
        b=nK37IzwmvriZafI4FIa2ZgTvT3CKTqlP6hYXNdsqJI4wFHhOp6arHRMlM0phDZtN94
         kXSLn/EkKzn7IrePD1qEsG2LRXkNBN3HLY0Z9U0dnEfqvQUdt55MPdusO9Q3Sgj2qXd5
         uAraNFigMPGSqaJXFFLDEiwFEv7wkj5kvfCB2OkGIxdpUUGSQ1LxtF3QOtSJBsi82pnY
         8YIf/IBrOb8egt8CbOQl0xXKeUVFMOxl6aV5i71EFsmbS6NybYBy7j45y3D/ZBzmNp8y
         EHUUBSG/Deft/TK+zQ4UlRPSz61QQr81IbrXMlGg8xjzgyVfcdWqz9zBFUrBRu3UG8fK
         pPYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693094532; x=1693699332;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BziPzk/8G2vrhw0dTzUPnWi0alpCUqJuRBn4AMK0kR4=;
        b=CaRpinu82AZawY0gDf8uzKfXswuLJe9qqaUx/LcbuFdDpbbKjPprlZdWHJ8v4aCHnC
         u6yoPr27Gdqndm3gr8sxdeiYyi4PmQT4gORd+CEBKHtLV06SCeW3B+tNn1AWiuEm0Rr5
         NhQjgvJo+3ALmrkIQa3SLiRyfiCycd9uPbroMLKhsaZnveUq1ZyCvOIRlp0vMx3s8NMT
         OXJcUdh4XYvFi4+ewTlRaROkFJYjxR421e1VSAN+UStJoMKMw4nvWP7hjVDNIdI0Gfgu
         WE5RNEyXNNiX0f1BnZZKnIVRveKK9JZf8xDDv9rk0irzqF+Rot9v9axreWDsjoyu2xeI
         QxXw==
X-Gm-Message-State: AOJu0YwtoggdlqcckzDzZxu74RBw4IoVLm0vfOzd2PhUzpoBi+ApT3S3
        pyy6ERA27Nn1g+WF6ecXCdwtPhoN21gBYw==
X-Google-Smtp-Source: AGHT+IE2r5rN7h92pC+cHwPeAN0O1FLIbwZJPfB5AgA6RIX/BYsntyBApHOHFklOdIwCOoyhkmXXuA==
X-Received: by 2002:a2e:b537:0:b0:2bc:d993:5a58 with SMTP id z23-20020a2eb537000000b002bcd9935a58mr4747127ljm.17.1693094531471;
        Sat, 26 Aug 2023 17:02:11 -0700 (PDT)
Received: from mobilestation ([95.79.200.178])
        by smtp.gmail.com with ESMTPSA id b26-20020a2e989a000000b002bb99bd0865sm1002035ljj.38.2023.08.26.17.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Aug 2023 17:02:10 -0700 (PDT)
Date:   Sun, 27 Aug 2023 03:02:07 +0300
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
Message-ID: <krvdz4filnpzhdy7tjkaisa2uzeh2sjzc2krno2rns24ldka37@abay33wdcck4>
References: <20230824-stmmac-subsecond-inc-cleanup-v1-0-e0b9f7c18b37@redhat.com>
 <20230824-stmmac-subsecond-inc-cleanup-v1-6-e0b9f7c18b37@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824-stmmac-subsecond-inc-cleanup-v1-6-e0b9f7c18b37@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

On Thu, Aug 24, 2023 at 01:32:57PM -0500, Andrew Halaney wrote:
> The comment neglects that freq_div_ratio is the ratio between
> the subsecond increment frequency and the clk_ptp_rate frequency.
> 
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
>  drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index dfead0df6163..64185753865f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -853,10 +853,12 @@ int stmmac_init_tstamp_counter(struct stmmac_priv *priv, u32 systime_flags)
>  	/* Store sub second increment for later use */
>  	priv->sub_second_inc = sub_second_inc;
>  

> -	/* calculate default addend value:
> -	 * formula is :
> -	 * addend = (2^32)/freq_div_ratio;
> -	 * where, freq_div_ratio = 1e9ns/sub_second_inc
> +	/* Calculate default addend so the accumulator overflows (2^32) in
> +	 * sub_second_inc (ns). The addend is added to the accumulator
> +	 * every clk_ptp cycle.
> +	 *
> +	 * addend = (2^32) / freq_div_ratio
> +	 * where, freq_div_ratio = (1e9ns / sub_second_inc) / clk_ptp_rate
>  	 */
>  	temp = div_u64(NSEC_PER_SEC, sub_second_inc);
>  	temp = temp << 32;

I am not well familiar with the way PTP works but at my naked eyes the
calculation implemented here looks a bit different than what is
described in the comment.

Basically config_sub_second_increment(clk_ptp_rate, sub_second_inc)
returns clk_ptp_rate period in nanoseconds or twice that period, or have it
scaled up on 0.465. So we have one of the next formulae:
X1 = NSEC_PER_SEC / clk_ptp_rate
X2 = 2 * NSEC_PER_SEC / clk_ptp_rate
X3 = X1 / 0.465
X4 = X2 / 0.465

Then stmmac_init_tstamp_counter() handles the retrieved period in the
next manner:
temp = div_u64(NSEC_PER_SEC, sub_second_inc);     // Convert back to frequency
temp = temp << 32;                                // multiply by 2^32
addend = div_u64(temp, priv->plat->clk_ptp_rate); // Divide by clk_ptp_rate

The code above is equivalent:

addend = ((NSEC_PER_SEC / X) * 2^32 ) / clk_ptp_rate = 
         (2^32 * NSEC_PER_SEC / X) / clk_ptp_rate = 
         2^32 / (clk_ptp_rate / (NSEC_PER_SEC / X))

AFAICS this doesn't match to what is in the comment (X = sub_second_inc).
freq_div_ratio gets to be inverted. Does it?

Substituting X to the formulae above we'll have just four possible results:
addend1 = 2^32
addend2 = 2^32 / 2
addend3 = 0.465 * 2^32
addend4 = 0.465 * 2^32 / 2

So basically clk_ptp_rate is irrelevant (neglecting all the
integer divisions rounding). Is that what implied by the implemented
algo?

Am I missing something? (it's quite possible since it's long past
midnight already.)

-Serge(y)

> 
> -- 
> 2.41.0
> 
> 
