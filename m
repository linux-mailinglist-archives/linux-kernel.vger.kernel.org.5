Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 477A87CBC49
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234539AbjJQHdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbjJQHda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:33:30 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8756C83
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VdT5aVa9/7XZ19+lqwEAJM4k0MdpmtN5n6Vjg5pryhY=;
  b=klU1bxGnGJeCYlQOOkm2t/dYgOjJHhyL0acn7eHujkCKG0Qs9dnNGqcY
   S8jSb2wfFjn/BZuLZ4DRglwQVV6Evn4RB9nNRX1sg05foLD8njK0zwsaz
   hMSZ9AO1iF+aYlsqQLBq2OxxMrhqYLkAXD2PYOC6X9dpA6VuMGGPT+UZD
   Q=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="6.03,231,1694728800"; 
   d="scan'208";a="131596095"
Received: from clt-128-93-180-172.vpn.inria.fr ([128.93.180.172])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 09:33:25 +0200
Date:   Tue, 17 Oct 2023 09:33:24 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Gilbert Adikankwu <gilbertadikankwu@gmail.com>
cc:     Julia Lawall <julia.lawall@inria.fr>, outreachy@lists.linux.dev,
        forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] staging: vt6655: Rename variable bUpdateBBVGA
In-Reply-To: <ZS44MmlkQUtnuhz+@gilbert-PC>
Message-ID: <4124e456-bad6-af50-8237-85efbba31076@inria.fr>
References: <cover.1697495597.git.gilbertadikankwu@gmail.com> <9bd935c464671db2654c654964812cc48f4603d3.1697495598.git.gilbertadikankwu@gmail.com> <a060ab8-238d-dffa-ce4b-9b814667786c@inria.fr> <ZS44MmlkQUtnuhz+@gilbert-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Oct 2023, Gilbert Adikankwu wrote:

> On Tue, Oct 17, 2023 at 06:48:00AM +0200, Julia Lawall wrote:
> >
> >
> > On Mon, 16 Oct 2023, Gilbert Adikankwu wrote:
> >
> > > Remove bool Type encoding "b" from variable name and replace camelcase
> > > with snakecase.
> > >
> > > Mute checkpatch.pl error:
> > >
> > > CHECK: Avoid CamelCase: <bUpdateBBVGA>
> > >
> > > Signed-off-by: Gilbert Adikankwu <gilbertadikankwu@gmail.com>
> > > ---
> > >  drivers/staging/vt6655/baseband.c    | 2 +-
> > >  drivers/staging/vt6655/channel.c     | 2 +-
> > >  drivers/staging/vt6655/device.h      | 2 +-
> > >  drivers/staging/vt6655/device_main.c | 6 +++---
> > >  4 files changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
> > > index 7d47b266b87e..f7824396c5ff 100644
> > > --- a/drivers/staging/vt6655/baseband.c
> > > +++ b/drivers/staging/vt6655/baseband.c
> > > @@ -2087,7 +2087,7 @@ bool bb_vt3253_init(struct vnt_private *priv)
> > >  		/* {{ RobertYu: 20050104 */
> > >  	} else {
> > >  		/* No VGA Table now */
> > > -		priv->bUpdateBBVGA = false;
> > > +		priv->update_bbvga = false;
> > >  		priv->bbvga[0] = 0x1C;
> >
> > I wonder about the name bbvga in the line above.  Does the initial b mean
> > byte or is it a lowercase version of BBVGA?
> >
> > julia
>
> Hello,
>
> bbvga is lowercase version of BBGVA. It was added with this commit 11b896e65f4bff7e412b3abca366ea0bdadc8834

OK thanks for the confirmation.

julia

>
> Thanks
> Gilbert
> >
> > >  	}
> > >
> > > diff --git a/drivers/staging/vt6655/channel.c b/drivers/staging/vt6655/channel.c
> > > index 6ac7d470c041..c11bc2dbc356 100644
> > > --- a/drivers/staging/vt6655/channel.c
> > > +++ b/drivers/staging/vt6655/channel.c
> > > @@ -86,7 +86,7 @@ bool set_channel(struct vnt_private *priv, struct ieee80211_channel *ch)
> > >  		return ret;
> > >
> > >  	/* Set VGA to max sensitivity */
> > > -	if (priv->bUpdateBBVGA &&
> > > +	if (priv->update_bbvga &&
> > >  	    priv->bbvga_current != priv->bbvga[0]) {
> > >  		priv->bbvga_current = priv->bbvga[0];
> > >
> > > diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
> > > index 68bfadacfa7c..b166d296b82d 100644
> > > --- a/drivers/staging/vt6655/device.h
> > > +++ b/drivers/staging/vt6655/device.h
> > > @@ -246,7 +246,7 @@ struct vnt_private {
> > >  	unsigned char byAutoFBCtrl;
> > >
> > >  	/* For Update BaseBand VGA Gain Offset */
> > > -	bool bUpdateBBVGA;
> > > +	bool update_bbvga;
> > >  	unsigned int	uBBVGADiffCount;
> > >  	unsigned char bbvga_new;
> > >  	unsigned char bbvga_current;
> > > diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
> > > index b08fcf7e6edc..b654fc24d725 100644
> > > --- a/drivers/staging/vt6655/device_main.c
> > > +++ b/drivers/staging/vt6655/device_main.c
> > > @@ -179,7 +179,7 @@ device_set_options(struct vnt_private *priv)
> > >  	priv->byBBType = priv->opts.bbp_type;
> > >  	priv->byPacketType = priv->byBBType;
> > >  	priv->byAutoFBCtrl = AUTO_FB_0;
> > > -	priv->bUpdateBBVGA = true;
> > > +	priv->update_bbvga = true;
> > >  	priv->preamble_type = 0;
> > >
> > >  	pr_debug(" byShortRetryLimit= %d\n", (int)priv->byShortRetryLimit);
> > > @@ -423,7 +423,7 @@ static void device_init_registers(struct vnt_private *priv)
> > >  	/* initialize BBP registers */
> > >  	bb_vt3253_init(priv);
> > >
> > > -	if (priv->bUpdateBBVGA) {
> > > +	if (priv->update_bbvga) {
> > >  		priv->bbvga_current = priv->bbvga[0];
> > >  		priv->bbvga_new = priv->bbvga_current;
> > >  		bb_set_vga_gain_offset(priv, priv->bbvga[0]);
> > > @@ -1040,7 +1040,7 @@ static void vnt_check_bb_vga(struct vnt_private *priv)
> > >  	long dbm;
> > >  	int i;
> > >
> > > -	if (!priv->bUpdateBBVGA)
> > > +	if (!priv->update_bbvga)
> > >  		return;
> > >
> > >  	if (priv->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
> > > --
> > > 2.34.1
> > >
> > >
> > >
>
>
