Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D1EA7A87AD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 16:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235220AbjITO4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 10:56:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234330AbjITO4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 10:56:11 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FBAC91;
        Wed, 20 Sep 2023 07:56:05 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-401d6f6b2e0so7042415e9.1;
        Wed, 20 Sep 2023 07:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695221764; x=1695826564; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0iRZLIffPTS9uyCDviQG+os8TsMY+2PYozlRu/n8AwA=;
        b=OAjv9An6RgfT2opUpeSA5bxEEgKp+21rlxMN6WyHaQb68yjgo38i1mwuSKGcQvBQMn
         9sE5VAXax69bi7uB2TVvsYdXWUsipx/uB9GnqKKnJcmg2jNN/g5PrVj5KIl5EttShA4V
         So3fScZMN3YWcBSFoyNTmFSdUekko4dkyWjsMf5GKenoySsojeCRAtuAVGJjJwI9UiUj
         L5YY7H0mtWyXXfF6llf6QQNlU3T/Hnt92UnlY28qPW5YikP+nkc5gOCEhFPiOjsIfOh/
         yBLL4gkxBFg1UHFIG9oGaw+AW4gnNHoi5i40Z63q1gC2w1/WmC4Ote24NFIsAThp5hTO
         /mwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695221764; x=1695826564;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0iRZLIffPTS9uyCDviQG+os8TsMY+2PYozlRu/n8AwA=;
        b=o225PuIRYlAV6E5XpUkfh6v9KVV3EHkh2lX+IxZUWVIDMXv3373+dSs+OiJNbpK+XJ
         zdwUbUAconwsfLwY238J4Wa2aQTxl3Y0scv+Hy05lcF2jILOnt8COCUuS0I50ZXv7SoA
         iR085bpUpKoUftycuQb+aNONMRtDr+GE42c1JUr7wjLvYR01qLtn6kgeX/CjgoqpTSPx
         jYlIFaRExXLxeC9V3DQAsDKAjwP0Fup+aUuEZZSyDLISj/JmayfVYDPRir2LspXmuY4y
         kcASQC9xT6rsUgvqouzqbO9BLpwln2Srcd5ZNPe+vlrlXk4PVLrlJA/kjQhD4/JdeiI3
         Hr9w==
X-Gm-Message-State: AOJu0YzUwZvZmUFleKUO9KYW4gRkrGl+19aApJtsD2OqJjBWCXWZgwYd
        HyTNLKdPPfs4Bl7oNl0hx+sNQZ2bT6cxTsAUJxE=
X-Google-Smtp-Source: AGHT+IFmB+Pn3ZVugG4xU1ri/Sc06ubzoCb3GX8QmUvw0H+8pSy7LFStQPUUm+s4/viPewMH+P9ZNw==
X-Received: by 2002:a5d:494e:0:b0:317:558c:c15e with SMTP id r14-20020a5d494e000000b00317558cc15emr4926665wrs.27.1695221763456;
        Wed, 20 Sep 2023 07:56:03 -0700 (PDT)
Received: from primary ([212.34.23.120])
        by smtp.gmail.com with ESMTPSA id x2-20020adff0c2000000b0031423a8f4f7sm3264835wro.56.2023.09.20.07.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 07:56:02 -0700 (PDT)
Date:   Wed, 20 Sep 2023 10:42:34 -0400
From:   Abdel Alkuor <alkuor@gmail.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, bryan.odonoghue@linaro.org,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        abdelalkuor@geotab.com
Subject: Re: [PATCH v5 03/15] USB: typec: Add patch mode to tps6598x
Message-ID: <ZQsE2r5ws7gWlByN@primary>
References: <20230917152639.21443-1-alkuor@gmail.com>
 <20230917152639.21443-4-alkuor@gmail.com>
 <ZQgvgJRLK+ysS30D@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQgvgJRLK+ysS30D@kuha.fi.intel.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 18, 2023 at 02:07:44PM +0300, Heikki Krogerus wrote:
> On Sun, Sep 17, 2023 at 11:26:27AM -0400, Abdel Alkuor wrote:
> > TPS25750 has a patch mode indicating the device requires
> > a configuration to get the device into operational mode
> > 
> > Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
> > ---
> >  drivers/usb/typec/tipd/core.c | 12 +++++++++---
> >  1 file changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> > index a8aee4e1aeba..6d2151325fbb 100644
> > --- a/drivers/usb/typec/tipd/core.c
> > +++ b/drivers/usb/typec/tipd/core.c
> > @@ -68,6 +68,7 @@ enum {
> >  	TPS_MODE_BOOT,
> >  	TPS_MODE_BIST,
> >  	TPS_MODE_DISC,
> > +	TPS_MODE_PTCH,
> >  };
> >  
> >  static const char *const modes[] = {
> > @@ -75,6 +76,7 @@ static const char *const modes[] = {
> >  	[TPS_MODE_BOOT]	= "BOOT",
> >  	[TPS_MODE_BIST]	= "BIST",
> >  	[TPS_MODE_DISC]	= "DISC",
> > +	[TPS_MODE_PTCH] = "PTCH",
> >  };
> >  
> >  /* Unrecognized commands will be replaced with "!CMD" */
> > @@ -576,7 +578,7 @@ static void tps6598x_poll_work(struct work_struct *work)
> >  			   &tps->wq_poll, msecs_to_jiffies(POLL_INTERVAL));
> >  }
> >  
> > -static int tps6598x_check_mode(struct tps6598x *tps)
> > +static int tps6598x_check_mode(struct tps6598x *tps, u8 *curr_mode)
> >  {
> >  	char mode[5] = { };
> >  	int ret;
> > @@ -585,8 +587,11 @@ static int tps6598x_check_mode(struct tps6598x *tps)
> >  	if (ret)
> >  		return ret;
> >  
> > -	switch (match_string(modes, ARRAY_SIZE(modes), mode)) {
> > +	*curr_mode = match_string(modes, ARRAY_SIZE(modes), mode);
> > +
> > +	switch (*curr_mode) {
> >  	case TPS_MODE_APP:
> > +	case TPS_MODE_PTCH:
> 
> This check is OK, but it seems that you are not using that curr_mode
> for anything yet, so don't change the paramaters of this function in
> this patch.
> 
> I would also just return the mode. Then this function would be used
> like this:
> 
>         ret = tps6598x_check_mode(...)
>         if (ret < 0)
>                 return ret;
> 
> Now mode = ret.
> 
> >  		return 0;
> >  	case TPS_MODE_BOOT:
> >  		dev_warn(tps->dev, "dead-battery condition\n");
> > @@ -715,6 +720,7 @@ static int tps6598x_probe(struct i2c_client *client)
> >  	u32 vid;
> >  	int ret;
> >  	u64 mask1;
> > +	u8 mode;
> >  
> >  	tps = devm_kzalloc(&client->dev, sizeof(*tps), GFP_KERNEL);
> >  	if (!tps)
> > @@ -759,7 +765,7 @@ static int tps6598x_probe(struct i2c_client *client)
> >  
> >  	tps->irq_handler = irq_handler;
> >  	/* Make sure the controller has application firmware running */
> > -	ret = tps6598x_check_mode(tps);
> > +	ret = tps6598x_check_mode(tps, &mode);
> 
> Actually, if you need to know the mode in here later, then I'm not
> sure tps6592x_check_mode() is useful after that. This is the only
> place it's called. Just read and check the mode in here directly at
> that point.

I will return the mode and check ret directly.
> 
> thanks,
> 
> -- 
> heikki

Thanks,
Abdel
