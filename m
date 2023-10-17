Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45E347CBC3F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 09:31:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbjJQHbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 03:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjJQHbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 03:31:07 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8343B83
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:31:05 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5a7c93507d5so63999947b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 17 Oct 2023 00:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697527864; x=1698132664; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eDTzbP2xWSfZcdzhTVPjMCIeC76MnVa5/4v6LhJNkX4=;
        b=ioHkR5CtLBPaPMYnjALCEK9VXGca4SfuuMp4aHSMvafjRrH8QMIddqR/h04HZxnN4S
         /mtacssGjxiMIdEQYyOvTUgPeFTutjj/TZxdaPYJySsFWuuSLSnXFkHTf4zShhk2lNfv
         xQRnvqcmOznfvHMb/lKKqxOCDDOGmLzKcHo3JY3lQBaLcwaXr5cTAYp7Kl9G8Im/M+Zk
         BfRurHBgzDe6vyCBro1XesBuB80MON0WmuVkhT0phFVegbWV+X6KL56FA8hVCT2VSe+6
         LBnncJT3qnuTC72Vnl+97f8R3D1mV6FOIdz5bj6giGuWhv3lMlcYg56J372x585CNz38
         LNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697527864; x=1698132664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eDTzbP2xWSfZcdzhTVPjMCIeC76MnVa5/4v6LhJNkX4=;
        b=mU7jT+WmGUkPoCS+FqzSp3t8XInH00QvhRUwiHbA1SIYzzpWe3YRkmLIBzgRK8yC1o
         3IJER3a6KkX9Sn7uMIvl7S1esKxEdiLiqP/dRI+sL8laWXjq7aNKqSZ5lGn3NTRtG2+i
         bZbW5mFxMZiM0bPRC6DAprNNc++bJvjeS1Id0YN1QP0LvGZQZdwzlZsi/HN/049VTiDN
         x9uK40DXe2AKVP9IpdF6NOEggMjzKt71jLuOqdO3ZB3aiiDt+/WNGHBtgjyaUMc6TGU4
         xCQpviXTtKphJuzUXZxAIGsKh74a6dpUhCFhNhOZyhiwzxrytZcp2ecqXxyBrlspIXZi
         pEwQ==
X-Gm-Message-State: AOJu0YyQgXQEh9tmxPPUx4daMJ/o62ztKakmt3WFGE79R6E0OGHIyZ2w
        ilOuGtztbmT4FMs2Hpv/AzA=
X-Google-Smtp-Source: AGHT+IG25/o4TcNYMhrs5//KXEuFr8Lm92dWuvRLd4ntUpRXh4/VQczrlbTuVj51JMX8VrPiFLzv+Q==
X-Received: by 2002:a0d:dd8a:0:b0:589:c065:b419 with SMTP id g132-20020a0ddd8a000000b00589c065b419mr1608797ywe.34.1697527864621;
        Tue, 17 Oct 2023 00:31:04 -0700 (PDT)
Received: from gilbert-PC ([105.112.189.86])
        by smtp.gmail.com with ESMTPSA id h3-20020a816c03000000b005a7c969137csm406496ywc.19.2023.10.17.00.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 00:31:04 -0700 (PDT)
Date:   Tue, 17 Oct 2023 08:30:58 +0100
From:   Gilbert Adikankwu <gilbertadikankwu@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     outreachy@lists.linux.dev, forest@alittletooquiet.net,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] staging: vt6655: Rename variable bUpdateBBVGA
Message-ID: <ZS44MmlkQUtnuhz+@gilbert-PC>
References: <cover.1697495597.git.gilbertadikankwu@gmail.com>
 <9bd935c464671db2654c654964812cc48f4603d3.1697495598.git.gilbertadikankwu@gmail.com>
 <a060ab8-238d-dffa-ce4b-9b814667786c@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a060ab8-238d-dffa-ce4b-9b814667786c@inria.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 06:48:00AM +0200, Julia Lawall wrote:
> 
> 
> On Mon, 16 Oct 2023, Gilbert Adikankwu wrote:
> 
> > Remove bool Type encoding "b" from variable name and replace camelcase
> > with snakecase.
> >
> > Mute checkpatch.pl error:
> >
> > CHECK: Avoid CamelCase: <bUpdateBBVGA>
> >
> > Signed-off-by: Gilbert Adikankwu <gilbertadikankwu@gmail.com>
> > ---
> >  drivers/staging/vt6655/baseband.c    | 2 +-
> >  drivers/staging/vt6655/channel.c     | 2 +-
> >  drivers/staging/vt6655/device.h      | 2 +-
> >  drivers/staging/vt6655/device_main.c | 6 +++---
> >  4 files changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/staging/vt6655/baseband.c b/drivers/staging/vt6655/baseband.c
> > index 7d47b266b87e..f7824396c5ff 100644
> > --- a/drivers/staging/vt6655/baseband.c
> > +++ b/drivers/staging/vt6655/baseband.c
> > @@ -2087,7 +2087,7 @@ bool bb_vt3253_init(struct vnt_private *priv)
> >  		/* {{ RobertYu: 20050104 */
> >  	} else {
> >  		/* No VGA Table now */
> > -		priv->bUpdateBBVGA = false;
> > +		priv->update_bbvga = false;
> >  		priv->bbvga[0] = 0x1C;
> 
> I wonder about the name bbvga in the line above.  Does the initial b mean
> byte or is it a lowercase version of BBVGA?
> 
> julia

Hello,

bbvga is lowercase version of BBGVA. It was added with this commit 11b896e65f4bff7e412b3abca366ea0bdadc8834

Thanks
Gilbert
> 
> >  	}
> >
> > diff --git a/drivers/staging/vt6655/channel.c b/drivers/staging/vt6655/channel.c
> > index 6ac7d470c041..c11bc2dbc356 100644
> > --- a/drivers/staging/vt6655/channel.c
> > +++ b/drivers/staging/vt6655/channel.c
> > @@ -86,7 +86,7 @@ bool set_channel(struct vnt_private *priv, struct ieee80211_channel *ch)
> >  		return ret;
> >
> >  	/* Set VGA to max sensitivity */
> > -	if (priv->bUpdateBBVGA &&
> > +	if (priv->update_bbvga &&
> >  	    priv->bbvga_current != priv->bbvga[0]) {
> >  		priv->bbvga_current = priv->bbvga[0];
> >
> > diff --git a/drivers/staging/vt6655/device.h b/drivers/staging/vt6655/device.h
> > index 68bfadacfa7c..b166d296b82d 100644
> > --- a/drivers/staging/vt6655/device.h
> > +++ b/drivers/staging/vt6655/device.h
> > @@ -246,7 +246,7 @@ struct vnt_private {
> >  	unsigned char byAutoFBCtrl;
> >
> >  	/* For Update BaseBand VGA Gain Offset */
> > -	bool bUpdateBBVGA;
> > +	bool update_bbvga;
> >  	unsigned int	uBBVGADiffCount;
> >  	unsigned char bbvga_new;
> >  	unsigned char bbvga_current;
> > diff --git a/drivers/staging/vt6655/device_main.c b/drivers/staging/vt6655/device_main.c
> > index b08fcf7e6edc..b654fc24d725 100644
> > --- a/drivers/staging/vt6655/device_main.c
> > +++ b/drivers/staging/vt6655/device_main.c
> > @@ -179,7 +179,7 @@ device_set_options(struct vnt_private *priv)
> >  	priv->byBBType = priv->opts.bbp_type;
> >  	priv->byPacketType = priv->byBBType;
> >  	priv->byAutoFBCtrl = AUTO_FB_0;
> > -	priv->bUpdateBBVGA = true;
> > +	priv->update_bbvga = true;
> >  	priv->preamble_type = 0;
> >
> >  	pr_debug(" byShortRetryLimit= %d\n", (int)priv->byShortRetryLimit);
> > @@ -423,7 +423,7 @@ static void device_init_registers(struct vnt_private *priv)
> >  	/* initialize BBP registers */
> >  	bb_vt3253_init(priv);
> >
> > -	if (priv->bUpdateBBVGA) {
> > +	if (priv->update_bbvga) {
> >  		priv->bbvga_current = priv->bbvga[0];
> >  		priv->bbvga_new = priv->bbvga_current;
> >  		bb_set_vga_gain_offset(priv, priv->bbvga[0]);
> > @@ -1040,7 +1040,7 @@ static void vnt_check_bb_vga(struct vnt_private *priv)
> >  	long dbm;
> >  	int i;
> >
> > -	if (!priv->bUpdateBBVGA)
> > +	if (!priv->update_bbvga)
> >  		return;
> >
> >  	if (priv->hw->conf.flags & IEEE80211_CONF_OFFCHANNEL)
> > --
> > 2.34.1
> >
> >
> >
