Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A66B7DC3B9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 01:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbjJaA4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 20:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjJaA4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 20:56:38 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7ABB9C;
        Mon, 30 Oct 2023 17:56:35 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-5079f6efd64so7137015e87.2;
        Mon, 30 Oct 2023 17:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698713794; x=1699318594; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0TwmeoKlgpoZDhppTQ2PaW5Q6vbRQDwHsZCqGM48uso=;
        b=Ua1nDrbv859/UjxMWo9nXpDAA/1+/t9Yx8HFvPHUvP4cz+b9q6Ak35fHVEU34P95+8
         jVmAGq/o2WePhjTwixRwl78kqTEjlClWzNBhgbbhsU4e44hIg5BGT2CMB8epuN7vsBxv
         iphEqUVaPgai4Rc5B6wR+gGYezU2ACmf38/klCuiYjKSxEhbnOqVKxGizy/8p3Q738/c
         7woODWr5BzFUcN9gMFHsMOsPU2nabVLSDUgxYx+MJoqm8YP69uFfTskbPoCazpb61fWP
         cl0xJc44XhikgXJN3AGVEuPNJ1gMm8iiYJ1cXGN+yBNxO/ZGajhkAbv+eWdrSX7n76MY
         ZaAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698713794; x=1699318594;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TwmeoKlgpoZDhppTQ2PaW5Q6vbRQDwHsZCqGM48uso=;
        b=nOTC3NRt1yYRP1Idnwj7Lb9a/udWiYM4ffgjzapS2HNoCcwJ31qp8hdqvMc0Wkeme/
         olPZtX+Lr3nqU/Q3P5PbaQi132hbPXtz447u+vzruNg2VwOoqQoBp6m4Cwb6f+WzHq96
         Tjyh+rrQRxCi9pDUxDtLHyr8F/RCYWCSYm8yjXSNLnODXLu4P4KzPJtAR18y3oybBL4t
         nSOj5+mMXDx8d1+05z20hLf315QeasVYwOsulK996KrO1i3YRiCSbKAonUt58lAZFyYC
         K5CaKNVgpN28HaKV90sEP49ENCX5eXSFnBJQ5oc+h3V9/cgEIV3RjDdAlSN7aGmLrSlW
         +0Tg==
X-Gm-Message-State: AOJu0YxTG4ugdandFFSO5nfza9hpX5mcSlKANyS5jgntD9j0FW7VvmiX
        mMje7TbiY3en2XDsHWr/huE7QO76Qlg=
X-Google-Smtp-Source: AGHT+IEMoIvLPNMWvMpJuau3xvpGX3VFFk8Y8I+d2J8br/XPW9eXki51Km3lshIAAFFetnZhY7gD4Q==
X-Received: by 2002:ac2:4306:0:b0:503:2deb:bbc1 with SMTP id l6-20020ac24306000000b005032debbbc1mr6865405lfh.22.1698713793502;
        Mon, 30 Oct 2023 17:56:33 -0700 (PDT)
Received: from mobilestation ([89.113.151.243])
        by smtp.gmail.com with ESMTPSA id z9-20020a19f709000000b00507a0098424sm21381lfe.109.2023.10.30.17.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 17:56:33 -0700 (PDT)
Date:   Tue, 31 Oct 2023 03:56:29 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Raju Lakkaraju <Raju.Lakkaraju@microchip.com>,
        netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
        linux-kernel@vger.kernel.org, andrew@lunn.ch,
        Jose.Abreu@synopsys.com, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net-next V3] net: pcs: xpcs: Add 2500BASE-X case in get
 state for XPCS drivers
Message-ID: <i6i5q64zfji3ohwsi3ikybpjulcbfce7zjgh3y44zj5gv4rqmp@jvzptfeotz2m>
References: <20231027044306.291250-1-Raju.Lakkaraju@microchip.com>
 <ghpmbmfjps24x7xvojk4gbkl55wjcuufd4v6mz6ws5htv35g2b@ugqsbet7t73p>
 <ZTuk/OF01M24nBeG@shell.armlinux.org.uk>
 <6j7szthl34z5q2ea4qnno7e2fnde3djxifx7chhhaihqty23q6@7j42bte7b3dv>
 <ZTuvwnGZKEueGDwa@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTuvwnGZKEueGDwa@shell.armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 01:40:34PM +0100, Russell King (Oracle) wrote:
> On Fri, Oct 27, 2023 at 03:06:19PM +0300, Serge Semin wrote:
> > Hi Russell
> > 
> > On Fri, Oct 27, 2023 at 12:54:36PM +0100, Russell King (Oracle) wrote:
> > > On Fri, Oct 27, 2023 at 02:04:15PM +0300, Serge Semin wrote:
> > > > Cc += Russell
> > > > 
> > > > * It's a good practice to add all the reviewers to Cc in the new patch
> > > > * revisions.
> > > > 
> > > > On Fri, Oct 27, 2023 at 10:13:06AM +0530, Raju Lakkaraju wrote:
> > > > > Add DW_2500BASEX case in xpcs_get_state( ) to update speed, duplex and pause
> > > > > 
> > > > > Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> > > > 
> > > > With a nitpick below clarified, feel free to add:
> > > > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> > > > 
> > > > > ---
> > > > >  drivers/net/pcs/pcs-xpcs.c | 29 +++++++++++++++++++++++++++++
> > > > >  drivers/net/pcs/pcs-xpcs.h |  2 ++
> > > > >  2 files changed, 31 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
> > > > > index 4dbc21f604f2..31f0beba638a 100644
> > > > > --- a/drivers/net/pcs/pcs-xpcs.c
> > > > > +++ b/drivers/net/pcs/pcs-xpcs.c
> > > > > @@ -1090,6 +1090,28 @@ static int xpcs_get_state_c37_1000basex(struct dw_xpcs *xpcs,
> > > > >  	return 0;
> > > > >  }
> > > > >  
> > > > > +static int xpcs_get_state_2500basex(struct dw_xpcs *xpcs,
> > > > > +				    struct phylink_link_state *state)
> > > > > +{
> > > > > +	int ret;
> > > > > +
> > > > > +	ret = xpcs_read(xpcs, MDIO_MMD_VEND2, DW_VR_MII_MMD_STS);
> > > > > +	if (ret < 0) {
> > > > > +		state->link = 0;
> > > > > +		return ret;
> > > > > +	}
> > > > > +
> > > > > +	state->link = !!(ret & DW_VR_MII_MMD_STS_LINK_STS);
> > > > > +	if (!state->link)
> > > > > +		return 0;
> > > > > +
> > > > > +	state->speed = SPEED_2500;
> > > > 
> > > > > +	state->pause |= MLO_PAUSE_TX | MLO_PAUSE_RX;
> > > > 
> > > > Why is it '|=' instead of just '='? Is it possible to have the 'pause'
> > > > field having some additional flags set which would be required to
> > > > preserve?
> > > 
> > > The code is correct. There are other flags on state->pause other than
> > > these, and phylink initialises state->pause prior to calling the
> > > function. The only flags that should be modified here are these two
> > > bits that the code is setting.
> > > 
> > > Phylink will initialise it to MLO_PAUSE_NONE if expecting autoneg, or
> > > the configured values if autoneg on the link is disabled.
> > 
> > Thanks for clarification. Then no more comments from my side in this
> > patch regard.
> > 
> > Regarding the XPCS driver in general. Based on what you said the rest
> > of the XPCS state getters are wrong in fully re-writing the 'pause'
> > field. Right?
> 
> Yes.
> 
> xpcs_resolve_pma:
>         state->pause = MLO_PAUSE_TX | MLO_PAUSE_RX;
> 
> xpcs_get_state_c37_sgmii:
>         state->pause = 0;
> 
> are both incorrect. The former should be |=, the latter is totally
> unnecessary.
> 
> Documentation:
>  * pcs_get_state() - Read the current inband link state from the hardware
>  * @pcs: a pointer to a &struct phylink_pcs.
>  * @state: a pointer to a &struct phylink_link_state.
>  *
>  * Read the current inband link state from the MAC PCS, reporting the
>  * current speed in @state->speed, duplex mode in @state->duplex, pause
>                                                                   ^^^^^
>  * mode in @state->pause using the %MLO_PAUSE_RX and %MLO_PAUSE_TX bits,
>    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> I guess I need to make that more explicit that pcs_get_state() methods
> are only expected to _set_ these two bits as appropriate, leaving all
> other bits as-is.

Thanks for the detailed response. I'll send fixup patches for the
denoted problems as soon as I get some free time for it. Hopefully
within a month if nobody does it sooner.

-Serge(y)

> 
> -- 
> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
