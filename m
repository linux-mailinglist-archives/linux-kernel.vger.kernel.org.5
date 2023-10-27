Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2127D973A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345804AbjJ0MG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345739AbjJ0MG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:06:27 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BDE10A;
        Fri, 27 Oct 2023 05:06:24 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-507a55302e0so2532035e87.0;
        Fri, 27 Oct 2023 05:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698408383; x=1699013183; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TfjG1MPQZh4uBcGLC6VVWkeSnIlrjqD/R5zPMvQS/b8=;
        b=O56UF0X8TYqnQJelqPKWY59qOu61pgg/Kx7+SYxOXvXm8UXwsx79XgU4eOtX0xO2tA
         HL3PIPEUntGNnVAu8hTXEPC3YD0k/7oe5AHRHUf4wsq1U+6lIrjtMvESiXLMvGAqCM3v
         7h8y7GrGgCWvCk1Do+PM0BihuvcYEHdmbSpPOsk7Kz3Gel7453Zz+HOApb2skg69oA/F
         peh+DgsxRkBbjjdlKiBAp3KkvvfBlx5dHsX8Qd/HApv3pAvUdhMzmXtbJfQhXYLhcbU6
         wk4kSHqB0ngZDPPnGaVl2hx5Ifj3YFcaUlfFnZtBr38Tuy8Dav/eBVtWtUK0bXueI/jx
         1x7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698408383; x=1699013183;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfjG1MPQZh4uBcGLC6VVWkeSnIlrjqD/R5zPMvQS/b8=;
        b=DqWIPp1NVHGD2O6WIngSBaEO0p34WiQP0FUez2VY5fZdy0Q0TKguzI8B8LOIU3JVZE
         HH6D4Zor445EfibzPXrxHtCHL5KCik2PJsoDQnQjr4lyoD35FwG7mQnDbnCrqL7JIWMR
         1gKvtSQHwnCzFQ8nMoLdZeybsTCKy5cznoyitCZJ9Ul+kA0nuKzxWR05utpi6Ijz+aZ8
         nBY/6UUzklY5Oaxd2Qxl459ODKfF3O5JOFDYoBjsETSTgUrLqzA4pLuiAI9fJkVQ68fL
         ZvdY6QWt4Z42d8L5q+d3pfJoI+B1T11iYURTF7piHAeWEShaeLayU8q8NG3nJbnNDxV/
         9Xog==
X-Gm-Message-State: AOJu0YzoEzTabHjmSDyI4emtO84xtIcruKRCSC81EjSFC7y8LpzVMUE+
        Y8HknQEQnKIzABdir+7lR3Q=
X-Google-Smtp-Source: AGHT+IHyWq5FZXbZhUJYDhNLA34rjW0Vm277H6hpVKcKitouI/Y6BQNwAxgovevweMQ9SGL5EPzdbQ==
X-Received: by 2002:a05:6512:239c:b0:507:a8ed:ee0b with SMTP id c28-20020a056512239c00b00507a8edee0bmr2171773lfv.65.1698408382010;
        Fri, 27 Oct 2023 05:06:22 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 18-20020ac24852000000b004ff8e79bc75sm256430lfy.285.2023.10.27.05.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 05:06:21 -0700 (PDT)
Date:   Fri, 27 Oct 2023 15:06:19 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Raju Lakkaraju <Raju.Lakkaraju@microchip.com>,
        netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, andrew@lunn.ch,
        Jose.Abreu@synopsys.com, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next V3] net: pcs: xpcs: Add 2500BASE-X case in get
 state for XPCS drivers
Message-ID: <6j7szthl34z5q2ea4qnno7e2fnde3djxifx7chhhaihqty23q6@7j42bte7b3dv>
References: <20231027044306.291250-1-Raju.Lakkaraju@microchip.com>
 <ghpmbmfjps24x7xvojk4gbkl55wjcuufd4v6mz6ws5htv35g2b@ugqsbet7t73p>
 <ZTuk/OF01M24nBeG@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTuk/OF01M24nBeG@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russell

On Fri, Oct 27, 2023 at 12:54:36PM +0100, Russell King (Oracle) wrote:
> On Fri, Oct 27, 2023 at 02:04:15PM +0300, Serge Semin wrote:
> > Cc += Russell
> > 
> > * It's a good practice to add all the reviewers to Cc in the new patch
> > * revisions.
> > 
> > On Fri, Oct 27, 2023 at 10:13:06AM +0530, Raju Lakkaraju wrote:
> > > Add DW_2500BASEX case in xpcs_get_state( ) to update speed, duplex and pause
> > > 
> > > Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> > 
> > With a nitpick below clarified, feel free to add:
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > 
> > > ---
> > >  drivers/net/pcs/pcs-xpcs.c | 29 +++++++++++++++++++++++++++++
> > >  drivers/net/pcs/pcs-xpcs.h |  2 ++
> > >  2 files changed, 31 insertions(+)
> > > 
> > > diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> > > index 4dbc21f604f2..31f0beba638a 100644
> > > --- a/drivers/net/pcs/pcs-xpcs.c
> > > +++ b/drivers/net/pcs/pcs-xpcs.c
> > > @@ -1090,6 +1090,28 @@ static int xpcs_get_state_c37_1000basex(struct dw_xpcs *xpcs,
> > >  	return 0;
> > >  }
> > >  
> > > +static int xpcs_get_state_2500basex(struct dw_xpcs *xpcs,
> > > +				    struct phylink_link_state *state)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_STS);
> > > +	if (ret < 0) {
> > > +		state->link = 0;
> > > +		return ret;
> > > +	}
> > > +
> > > +	state->link = !!(ret & DW_VR_MII_MMD_STS_LINK_STS);
> > > +	if (!state->link)
> > > +		return 0;
> > > +
> > > +	state->speed = SPEED_2500;
> > 
> > > +	state->pause |= MLO_PAUSE_TX | MLO_PAUSE_RX;
> > 
> > Why is it '|=' instead of just '='? Is it possible to have the 'pause'
> > field having some additional flags set which would be required to
> > preserve?
> 
> The code is correct. There are other flags on state->pause other than
> these, and phylink initialises state->pause prior to calling the
> function. The only flags that should be modified here are these two
> bits that the code is setting.
> 
> Phylink will initialise it to MLO_PAUSE_NONE if expecting autoneg, or
> the configured values if autoneg on the link is disabled.

Thanks for clarification. Then no more comments from my side in this
patch regard.

Regarding the XPCS driver in general. Based on what you said the rest
of the XPCS state getters are wrong in fully re-writing the 'pause'
field. Right?

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
