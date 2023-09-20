Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F17BD7A87CB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 17:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbjITPD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 11:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235293AbjITPDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 11:03:55 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F44A1;
        Wed, 20 Sep 2023 08:03:49 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-404fbfac998so45836175e9.3;
        Wed, 20 Sep 2023 08:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695222228; x=1695827028; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=I98A8Eic46rO8tiZ9osV0szBa2CeIR57yFuC8bpVBNk=;
        b=B9cXE7h0HA61eaxC66MeNhC5raf7n2ob8jHEnTzN3ccRpfgTdVFDzUQJXFPscgpY1P
         zGo14SfCu4wpV9QMyMDlM808OILZhTezeJsedb3f/0eg25btUAk3frHCbCr2xWmHhVZE
         NS0wHkX0jtOvm4ZCmFvPjhB2mEIFn9W0DcAvjjd6ZWUO+Gz8xrzbdA5X0DMdlAttrLuQ
         ej6/fgeGIPYASpt1E3Pi35507CvnjrMvA9w7Fmdd20T6wXSWYTJWQWaRYbVviQO+zldo
         3mWC0arIPatUb4s9njxjj54FEV3+cQMB8QMYutjHGeyMvIajP/GHqfa1GHIlTdDLalV0
         2Tzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695222228; x=1695827028;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I98A8Eic46rO8tiZ9osV0szBa2CeIR57yFuC8bpVBNk=;
        b=ICstIjJKer9W8MqcIc7tx3Cv7OmMZ29q6Wd39HACsI/BC8shth+D0lSnfPeRTxB0gd
         zx/gVXPgyg4ZCzBefTbRyNtbV2p4iRe5To9Jbf3qvCTZMbEXE9yAtDOiHVm+g0yPvStV
         /mCLuudaQGU1R4ONZZO6LK4XfYDTCj3p9ejysenA121lAxc2ITlqWtyzHrrt4fZSdp0h
         f9onSOKYavzFrkBJ6ENwexlHMdkC3qAg69VdZM2ETCQbZf5gNmWr+uevymglP0HvzAx5
         ZyIkcZ9sEuN9bTczorr7e12Lrl2DrBo3D34O2pOcPh/HRmfdNp/bUOq8Pp2wKEvrLakl
         uojw==
X-Gm-Message-State: AOJu0YxLI7cC4YxRzP7oR7MI05ExkbPcfnWJt40v2iwSRHLc75xXj9cF
        Qbb/29FFMO/VQzGRFYNIrEI=
X-Google-Smtp-Source: AGHT+IHYQMMTNsPPlYocx1D3a+VMp/3BOUl2c4yeh6KKjbzkbCD1WgPOy7peE1KUNvIFAykI4kp0vg==
X-Received: by 2002:a7b:cd0e:0:b0:402:f500:fcee with SMTP id f14-20020a7bcd0e000000b00402f500fceemr2718867wmj.0.1695222226928;
        Wed, 20 Sep 2023 08:03:46 -0700 (PDT)
Received: from primary ([212.34.23.120])
        by smtp.gmail.com with ESMTPSA id y15-20020a1c4b0f000000b003fe2a40d287sm2226705wma.1.2023.09.20.08.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 08:03:46 -0700 (PDT)
Date:   Wed, 20 Sep 2023 10:50:17 -0400
From:   Abdel Alkuor <alkuor@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, bryan.odonoghue@linaro.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        abdelalkuor@geotab.com
Subject: Re: [PATCH v5 08/15] USB: typec: Add interrupt support for TPS25750
Message-ID: <ZQsGqfKGDVoBXgj2@primary>
References: <20230917152639.21443-1-alkuor@gmail.com>
 <20230917152639.21443-9-alkuor@gmail.com>
 <ZQhGsA4PyiaUy7+7@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQhGsA4PyiaUy7+7@kuha.fi.intel.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 03:46:40PM +0300, Heikki Krogerus wrote:
> Hi,
> 
> On Sun, Sep 17, 2023 at 11:26:32AM -0400, Abdel Alkuor wrote:
> > From: Abdel Alkuor <abdelalkuor@geotab.com>
> > 
> > Update tps6598x interrupt handler to accommodate tps25750 interrupt
> 
> You have the "why" explained here, but please also explain what you
> are doing - in this case it's not completely clear.
>
Makes sense. I will add an explanation in v6.
> > Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
> > ---
> >  drivers/usb/typec/tipd/core.c | 49 +++++++++++++++++++++++++----------
> >  1 file changed, 35 insertions(+), 14 deletions(-)
> > 
> > diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> > index bd5436fd88fd..17b3bc480f97 100644
> > --- a/drivers/usb/typec/tipd/core.c
> > +++ b/drivers/usb/typec/tipd/core.c
> > @@ -120,6 +120,7 @@ struct tps6598x {
> >  	enum power_supply_usb_type usb_type;
> >  
> >  	int wakeup;
> > +	u32 status; /* status reg */
> >  	u16 pwr_status;
> >  	struct delayed_work	wq_poll;
> >  	irq_handler_t irq_handler;
> > @@ -539,50 +540,71 @@ static irqreturn_t cd321x_interrupt(int irq, void *data)
> >  	return IRQ_NONE;
> >  }
> >  
> > +static bool tps6598x_has_role_changed(struct tps6598x *tps, u32 status)
> > +{
> > +	status ^= tps->status;
> > +
> > +	return status & (TPS_STATUS_PORTROLE | TPS_STATUS_DATAROLE);
> > +}
> > +
> >  static irqreturn_t tps6598x_interrupt(int irq, void *data)
> >  {
> >  	struct tps6598x *tps = data;
> > -	u64 event1 = 0;
> > -	u64 event2 = 0;
> > +	u64 event[2] = { };
> >  	u32 status;
> >  	int ret;
> >  
> >  	mutex_lock(&tps->lock);
> >  
> > -	ret = tps6598x_read64(tps, TPS_REG_INT_EVENT1, &event1);
> > -	ret |= tps6598x_read64(tps, TPS_REG_INT_EVENT2, &event2);
> > +	if (tps->is_tps25750) {
> > +		ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT1, event, 11);
> > +	} else {
> > +		ret = tps6598x_read64(tps, TPS_REG_INT_EVENT1, &event[0]);
> > +		ret |= tps6598x_read64(tps, TPS_REG_INT_EVENT2, &event[1]);
> > +	}
> > +
> >  	if (ret) {
> >  		dev_err(tps->dev, "%s: failed to read events\n", __func__);
> >  		goto err_unlock;
> >  	}
> > -	trace_tps6598x_irq(event1, event2);
> > +	trace_tps6598x_irq(event[0], event[1]);
> >  
> > -	if (!(event1 | event2))
> > +	if (!(event[0] | event[1]))
> >  		goto err_unlock;
> >  
> >  	if (!tps6598x_read_status(tps, &status))
> >  		goto err_clear_ints;
> >  
> > -	if ((event1 | event2) & TPS_REG_INT_POWER_STATUS_UPDATE)
> > +	if ((event[0] | event[1]) & TPS_REG_INT_POWER_STATUS_UPDATE)
> >  		if (!tps6598x_read_power_status(tps))
> >  			goto err_clear_ints;
> >  
> > -	if ((event1 | event2) & TPS_REG_INT_DATA_STATUS_UPDATE)
> > +	if ((event[0] | event[1]) & TPS_REG_INT_DATA_STATUS_UPDATE)
> >  		if (!tps6598x_read_data_status(tps))
> >  			goto err_clear_ints;
> >  
> > -	/* Handle plug insert or removal */
> > -	if ((event1 | event2) & TPS_REG_INT_PLUG_EVENT)
> > +	/*
> > +	 * data/port roles could be updated independently after
> > +	 * a plug event. Therefore, we need to check
> > +	 * for pr/dr status change to set TypeC dr/pr accordingly.
> > +	 */
> > +	if ((event[0] | event[1]) & TPS_REG_INT_PLUG_EVENT ||
> > +		tps6598x_has_role_changed(tps, status))
> 
> Alignment.
Will be fixed in v6.
> 
> >  		tps6598x_handle_plug_event(tps, status);
> >  
> > +	tps->status = status;
> >  err_clear_ints:
> > -	tps6598x_write64(tps, TPS_REG_INT_CLEAR1, event1);
> > -	tps6598x_write64(tps, TPS_REG_INT_CLEAR2, event2);
> > +	if (tps->is_tps25750) {
> > +		tps6598x_block_write(tps, TPS_REG_INT_CLEAR1, event, 11);
> > +	} else {
> > +		tps6598x_write64(tps, TPS_REG_INT_CLEAR1, event[0]);
> > +		tps6598x_write64(tps, TPS_REG_INT_CLEAR2, event[1]);
> > +	}
> >  
> >  err_unlock:
> >  	mutex_unlock(&tps->lock);
> >  
> > -	if (event1 | event2)
> > +	if (event[0] | event[1])
> >  		return IRQ_HANDLED;
> >  	return IRQ_NONE;
> >  }
> > @@ -1003,7 +1025,6 @@ static int tps6598x_probe(struct i2c_client *client)
> >  
> >  		irq_handler = cd321x_interrupt;
> >  	} else {
> > -
> 
> You need to fix patch 4 instead - that's where you add that empty
> line.
Will be fixed in v6.
> 
> >  		tps->is_tps25750 = of_device_is_compatible(np, "ti,tps25750");
> >  		/* Enable power status, data status and plug event interrupts */
> >  		mask1 = TPS_REG_INT_POWER_STATUS_UPDATE |
> > -- 
> > 2.34.1
> 
> -- 
> heikki

Thanks,
Abdel
