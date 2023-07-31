Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044A5768FAB
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjGaIJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjGaIJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:09:10 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E3B46BC;
        Mon, 31 Jul 2023 01:05:26 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31768ce2e81so4527388f8f.1;
        Mon, 31 Jul 2023 01:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690790725; x=1691395525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Bu+ldcCKjLm0By1TmlLv7z+ZXLa3JOlu2tgT86KevJE=;
        b=GNRv0eAbDzmjHpi1DlXwJ95tIbez1DBL+ofA2gR6RVZ5xprg6Mfq7zHrRWcMUPtPWw
         QFC7eVF4PFB+qXsDqYuTIcpsV+c+ctoZWudaH4cw4pd62G6/r79+vKt8qqBbJZ0kukm0
         y1Dk9AKzcuVG+8RPXkJrld9yf7lFKGxeZvMOmbFDjzcORbA9nnkBEs6uwTsOsnQZ7DUl
         zSq8dGpMuUz1yJ8JbfQ2B3akY/ZaK7x+FR1SE1K91tETsK06xp55WUEEB1paGcZhQ7GG
         zRyw9pEv+XRATXMBiwA5PDDNQQqfOnAmZizKb0Qveibac7Bnc0kG1uJjNJ+AlvGiNZbR
         y6Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690790725; x=1691395525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bu+ldcCKjLm0By1TmlLv7z+ZXLa3JOlu2tgT86KevJE=;
        b=It5GOOTf5bZe4eMzgClVMiupaYIgCvvdaGi5F0iuN6cBQYlkL01jsG5igzYvOfCawg
         eLGXc8vSPPccdm9aA5S5JMhT8y86dvI3WyNvRtdHYCH5pP7283/SNKyJhnTsn4NaOv8V
         WM9NOwqgOZrQRJGWbqyLvV+WbPpImSN3hC3Vn3UPFcYGqDBNGIykmcnembLE7/D/Mfjv
         to241phZe/BflINJjygZTtfL8fth05yyM7YLSgBz+g09/yRpOHI0bFQ5dAVdZ9O1ngr/
         fp62/LabNBclM8WxPOB/i7su+BvPEYc8qZ4JkOAjmT+CFDaiVl1npAd+zka2lWxOAlki
         T5wg==
X-Gm-Message-State: ABy/qLYz8kJOwIdABuykLKewCIJmizWqkqcnts2rtwtzPd6sv2poJxVv
        BxjQ4PuZE19FvCEdUCDjHYKUjBwOq172FQ==
X-Google-Smtp-Source: APBJJlGvO37k0LxsUADsH0Ij1wCI+iXVLeoWAn+9wFPQRUPbRc/orjVcetM+lI4iciHT8ds2TY8urQ==
X-Received: by 2002:a5d:4207:0:b0:317:71ee:912a with SMTP id n7-20020a5d4207000000b0031771ee912amr7041697wrq.18.1690790724776;
        Mon, 31 Jul 2023 01:05:24 -0700 (PDT)
Received: from tp440p.steeds.sam ([2602:fbf6:10:a::2])
        by smtp.gmail.com with ESMTPSA id e40-20020a5d5968000000b0031431fb40fasm12171461wri.89.2023.07.31.01.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 01:05:24 -0700 (PDT)
Date:   Mon, 31 Jul 2023 10:05:11 +0200
From:   Sicelo <absicsz@gmail.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH] bus: omap_l3_smx: identify timeout source before
 rebooting
Message-ID: <ZMdrN7IqJsASyifi@tp440p.steeds.sam>
References: <20230730202240.898519-1-absicsz@gmail.com>
 <20230731052904.GB5194@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731052904.GB5194@atomide.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 31, 2023 at 08:29:04AM +0300, Tony Lindgren wrote:
> * Sicelo A. Mhlongo <absicsz@gmail.com> [230730 20:23]:
> > Identify and print the error source before rebooting the board due to an l3
> > application timeout error, by delaying the BUG_ON. This is helpful when
> > debugging, e.g. via serial.
> 
> Makes sense to try to show some information, but please see the question
> below.
> 
> > diff --git a/drivers/bus/omap_l3_smx.c b/drivers/bus/omap_l3_smx.c
> > index bb1606f5ce2d..70f4903d5468 100644
> > --- a/drivers/bus/omap_l3_smx.c
> > +++ b/drivers/bus/omap_l3_smx.c
> > @@ -170,11 +170,9 @@ static irqreturn_t omap3_l3_app_irq(int irq, void *_l3)
> >  		status = omap3_l3_readll(l3->rt, L3_SI_FLAG_STATUS_0);
> >  		/*
> >  		 * if we have a timeout error, there's nothing we can
> > -		 * do besides rebooting the board. So let's BUG on any
> > -		 * of such errors and handle the others. timeout error
> > -		 * is severe and not expected to occur.
> > +		 * do besides rebooting the board after identifying the
> > +		 * error source.
> >  		 */
> > -		BUG_ON(status & L3_STATUS_0_TIMEOUT_MASK);
> >  	} else {
> >  		status = omap3_l3_readll(l3->rt, L3_SI_FLAG_STATUS_1);
> >  		/* No timeout error for debug sources */
> > @@ -190,6 +188,12 @@ static irqreturn_t omap3_l3_app_irq(int irq, void *_l3)
> >  		ret |= omap3_l3_block_irq(l3, error, error_addr);
> >  	}
> >  
> > +	/*
> > +	 * BUG on application timeout errors since they are severe and not
> > +	 * expected to occur.
> > +	 */
> > +	BUG_ON(status & L3_STATUS_0_TIMEOUT_MASK);
> 
> Aren't you now checking the bit for both L3_SI_FLAG_STATUS_0 and
> L3_SI_FLAG_STATUS_1 register values? I think it should be only for register
> L3_SI_FLAG_STATUS_0 value?
> 

Ah, you are right. It should be:

    `BUG_ON(!int_type && status & L3_STATUS_0_TIMEOUT_MASK);`

I'll send in a v2.

Thanks
Sicelo
