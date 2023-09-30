Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22CCB7B4034
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 14:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbjI3MEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 08:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbjI3MEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 08:04:36 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584A6BD;
        Sat, 30 Sep 2023 05:04:34 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40566f89f6eso123059855e9.3;
        Sat, 30 Sep 2023 05:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696075473; x=1696680273; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=y1aX76wnxIZc/qepBCMoxahwj6U8pp0kTrNtby/mtII=;
        b=Md758fL4lVmKA3gnBhlipNIkSRppQJA5bZE6k+JlALVZqG3PnC+bPptzz4RpFr/B8d
         kz9YSWx0tPvZYSZoG5oyo9dpPf90XfrjXUHzKIA878pZPtMif2K7h8+PsslJ7NhjhGQu
         j7NGZ4ZdWS4ietKamH5G1S/0JUpzD5ySHkeN6E8Far/vAwjoSxn9QPit/Kk3fs9i45up
         6weOGg3gtIDeJh3dc9aqtx1dqj9BQHPDIlZe1B0JwZo05L4GtZjx4r902RTajOY7j8pU
         mox74cwFsxcAzS/4uDLPXPnJww8SIxLnjAh3MIbJdcFRnMi0ehdnTj4aXQKzTHL+9vjj
         d/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696075473; x=1696680273;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:subject:cc:to:from:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y1aX76wnxIZc/qepBCMoxahwj6U8pp0kTrNtby/mtII=;
        b=fbEfPR2MXRWvirzTYDYF1QF3I1rQUeFe6KHtOAc117rya97GccFc794/SpELcas6m7
         qNLL5i7XCBdoWcj2epyKH/Rt/EqriKZZIWlYiWAWWiCxgE6K9U4nipy//iraMLQGD0MK
         6tAXC8v163IPnSDOMADECpEtlQArsqlg42wxD2jZStKeY5aIaL6fFrUrQA6THABC41Ro
         z9qECSjgnNt/+UKNkotPyavQCj0nFwEidEIJpcWJ39bdDM6tvciBiiO04ow812ujXv2M
         z7WC/7q9RPJo8BBoPGuEEhKyMd1ab7eRAEIgM5ZijpB4kZVdD1EOhFL4cSW1JbHZSVrn
         Zm7g==
X-Gm-Message-State: AOJu0Yzy4VD2TNNUqiaVohk4356pmAunP27iVNr09O1JyYh5oKS/TbXS
        OOHFhlZLU+j6qNZcliOGbmw7cuCHJDM=
X-Google-Smtp-Source: AGHT+IF/09054jO/NN87gwAvDg9HEwLTvzP+yEzINsQIqa4JrVOm5cj6VxTTRZevsBs3NYcn6qIy1w==
X-Received: by 2002:a05:600c:2317:b0:402:f5c4:2e5a with SMTP id 23-20020a05600c231700b00402f5c42e5amr6281596wmo.37.1696075472327;
        Sat, 30 Sep 2023 05:04:32 -0700 (PDT)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id c19-20020a05600c0ad300b00405c33a9a12sm2415923wmr.0.2023.09.30.05.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 Sep 2023 05:04:31 -0700 (PDT)
Message-ID: <65180ecf.050a0220.10a98.7a51@mx.google.com>
X-Google-Original-Message-ID: <ZRgOzeSsTmTOhCdo@Ansuel-xps.>
Date:   Sat, 30 Sep 2023 14:04:29 +0200
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Vincent Whitchurch <Vincent.Whitchurch@axis.com>
Cc:     "linux-stm32@st-md-mailman.stormreply.com" 
        <linux-stm32@st-md-mailman.stormreply.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "liuhangbin@gmail.com" <liuhangbin@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "jiri@resnulli.us" <jiri@resnulli.us>,
        "joabreu@synopsys.com" <joabreu@synopsys.com>,
        "rajur@chelsio.com" <rajur@chelsio.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "kvalo@kernel.org" <kvalo@kernel.org>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "pkshih@realtek.com" <pkshih@realtek.com>
Subject: Re: [net-next PATCH 2/3] net: stmmac: improve TX timer arm logic
References: <20230922111247.497-1-ansuelsmth@gmail.com>
 <20230922111247.497-2-ansuelsmth@gmail.com>
 <0a62a2b6bff4fd01065e0de6a8703c96e344f1dc.camel@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0a62a2b6bff4fd01065e0de6a8703c96e344f1dc.camel@axis.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 12:38:48PM +0000, Vincent Whitchurch wrote:
> On Fri, 2023-09-22 at 13:12 +0200, Christian Marangi wrote:
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > index 9201ed778ebc..14bf6fae6662 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> > @@ -2994,13 +2994,25 @@ static void stmmac_tx_timer_arm(struct stmmac_priv *priv, u32 queue)
> >  {
> >  	struct stmmac_tx_queue *tx_q = &priv->dma_conf.tx_queue[queue];
> >  	u32 tx_coal_timer = priv->tx_coal_timer[queue];
> > +	struct stmmac_channel *ch;
> > +	struct napi_struct *napi;
> >  
> > 
> >  	if (!tx_coal_timer)
> >  		return;
> >  
> > 
> > -	hrtimer_start(&tx_q->txtimer,
> > -		      STMMAC_COAL_TIMER(tx_coal_timer),
> > -		      HRTIMER_MODE_REL);
> > +	ch = &priv->channel[tx_q->queue_index];
> > +	napi = tx_q->xsk_pool ? &ch->rxtx_napi : &ch->tx_napi;
> > +
> > +	/* Arm timer only if napi is not already scheduled.
> > +	 * Try to cancel any timer if napi is scheduled, timer will be armed
> > +	 * again in the next scheduled napi.
> > +	 */
> > +	if (unlikely(!napi_is_scheduled(napi)))
> > +		hrtimer_start(&tx_q->txtimer,
> > +			      STMMAC_COAL_TIMER(tx_coal_timer),
> > +			      HRTIMER_MODE_REL);
> > +	else
> > +		hrtimer_try_to_cancel(&tx_q->txtimer);
> 
> When this function is called from within the napi poll function
> (stmmac_tx_clean()), NAPI_STATE_SCHED will always be set and so after
> this patch the "We still have pending packets, let's call for a new
> scheduling" logic will never start the timer.  Was that really
> intentional?
>

No and understanding the code flow of napi and tx-coal is hard... (also
problem with tx coal arise only with real world scenario and now with
synthetic tests like iperf.

I will shortly send a v2 of this that will just move the logic of arming
the TX timer outside napi call after DMA interrupt is enabled again.
Currently testing the new version on openwrt with ipq806x hoping
everything is good.

(same perf increase observed but no queue timeout)

-- 
	Ansuel
