Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 386297A4EE4
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:29:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbjIRQ3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjIRQ2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:28:51 -0400
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F22196;
        Mon, 18 Sep 2023 09:25:27 -0700 (PDT)
Received: by mail-oo1-xc34.google.com with SMTP id 006d021491bc7-571194584e2so2910757eaf.3;
        Mon, 18 Sep 2023 09:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695054326; x=1695659126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MZi9KVW/VHOjmcBD8yLAq6vDAF0JfWa5rIwSZAGCZA8=;
        b=lLmCDo+MYbo+VFpiqIycJHyAejVaWhXIg6N1TvF8v3Yf12mJz8oXadb67zt0KTdssH
         6ekZL0JTG+0IXmFWwxaTKbQcf0+FhvLb11D0ifuCFqTchxLxKk42KirD6vwZpOIC2gdF
         SRf2Rwr1phyXvC20wTmGmLNPePPrzh0VDoSLI2m+Oi4thkgwjj0bZ1SJjs3ALLmADa+v
         Qo4vvIKHavhZkMuR7nDEu05d9X0NeFrA6u1JFeT7pXOmt0M+4xXAXJ2kTKK/fg5HwVME
         Q/qAd5tEkE41y4y9NPvdYvMgx8f/+EFVDoBz8K7sE3xo+87+gVXlg0wWp1KPM43fiv0R
         5WTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695054326; x=1695659126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZi9KVW/VHOjmcBD8yLAq6vDAF0JfWa5rIwSZAGCZA8=;
        b=Qw4z764wGiZimn23MEw/C3OddEjQZGl2uSpHgrLOxuX2QLjgW++TIZlFoKfdxUyXGI
         s+XariNkgUYuzooc8o+6tYPqUuIoB57G5SOHEzl7CWGfe+8I3SXJvwWDPvr19Zz2BcRc
         tRXDcOv2NfPpeP6gFS9UNzyz+Tn8iMfEf9/zffr6IB63yYapxnNNie5MxEoAFWqlBvVZ
         av4ufbMPKt3Pu+Dlx0JbuHQrisowBxwDt9pwgzNuw7ebIVgD9A60dbtYxCQkRKb3/pcW
         3fWhPzxxdlS1wTH00YIjr2J7G8w8dmBfireO1e1zImAhBx5RSqFUEz+cCoGsNQRagloG
         tgMw==
X-Gm-Message-State: AOJu0Yx0W6HCLRUKz3aWy+UMhBC9B5zJ7oBv1hzjyoqXF30NVgiqfAJu
        0/g58SlHSXdjKcT1S0gc4ew=
X-Google-Smtp-Source: AGHT+IHkTQ/j6v86h1uYYMolH9IaMasCsbfxKFGtmjZPTUAosXsBAzolCO4DtPHATAtDQTdFN1whSQ==
X-Received: by 2002:a05:6870:468e:b0:1b3:715c:463e with SMTP id a14-20020a056870468e00b001b3715c463emr11909272oap.0.1695054326515;
        Mon, 18 Sep 2023 09:25:26 -0700 (PDT)
Received: from shaak (modemcable063.135-226-192.mc.videotron.ca. [192.226.135.63])
        by smtp.gmail.com with ESMTPSA id h9-20020a0cb4c9000000b00656373f9c30sm2708297qvf.75.2023.09.18.09.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 09:25:25 -0700 (PDT)
Date:   Mon, 18 Sep 2023 12:25:23 -0400
From:   Liam Beguin <liambeguin@gmail.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: add ltc2309 support
Message-ID: <20230918162523.GA735412@shaak>
References: <20230828-ltc2309-v3-0-338b3a8fab8b@gmail.com>
 <20230828-ltc2309-v3-2-338b3a8fab8b@gmail.com>
 <20230903124341.360c95fe@jic23-huawei>
 <20230910150333.472437be@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230910150333.472437be@jic23-huawei>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On Sun, Sep 10, 2023 at 03:03:33PM +0100, Jonathan Cameron wrote:
> On Sun, 3 Sep 2023 12:43:41 +0100
> Jonathan Cameron <jic23@kernel.org> wrote:
> 
> > On Mon, 28 Aug 2023 22:41:35 -0400
> > Liam Beguin <liambeguin@gmail.com> wrote:
> > 
> > > The LTC2309 is an 8-Channel, 12-Bit SAR ADC with an I2C Interface.
> > > 
> > > This implements support for all single-ended and differential channels,
> > > in unipolar mode only.
> > > 
> > > Signed-off-by: Liam Beguin <liambeguin@gmail.com>  
> > Hi Liam,
> > 
> > A few really small editorial bits in here.  I'll fix them whilst applying.
> > Series applied to the togreg branch of iio.git
> > 
> > Note I will be rebasing the tree on rc1 once available and in the meantime
> > this will only be pushed out as testing.
> 
> A couple more static analysis reports came in (unreachable return in one pace
> and a missing static.  I've fixed up in my tree.

My apologies for the delay, I was away for a few days.

Thanks for making those changes, I'll go over the comments and the
reports, and if there's anything left, I'll send an update.

> Thanks,
> 
> Jonathan

Thanks again for your time,

Liam

> 
> > 
> > Thanks,
> > 
> > Jonathan
> > 
> > 
> > 
> > > +/**
> > > + * struct ltc2309 - internal device data structure
> > > + * @dev:	Device reference
> > > + * @client:	I2C reference
> > > + * @vref:	External reference source
> > > + * @lock:	Lock to serialize data access
> > > + * @vref_mv	Internal voltage reference  
> > 
> > Missing : which is what the bot picked up on.
> > 
> > > + */
> > > +struct ltc2309 {
> > > +	struct device		*dev;
> > > +	struct i2c_client	*client;
> > > +	struct regulator	*vref;
> > > +	struct mutex		lock; /* serialize data access */
> > > +	int			vref_mv;
> > > +};  
> > 
> > > +
> > > +void ltc2309_regulator_disable(void *regulator)
> > > +{
> > > +	struct regulator *r = (struct regulator *)regulator;  
> > 
> > Never any need to explicitly cast from a void * to any other pointer type.
> > (C spec says it is always fine to do this :)
> > 
> > Given type is obvious from use, can just do
> > 	regulator_disable(regulator);
> > and lose the local variable.
> > 
> > > +
> > > +	regulator_disable(r);
> > > +}  
> > 
> > ..
> > > +
> > > +static const struct of_device_id ltc2309_of_match[] = {
> > > +	{ .compatible = "lltc,ltc2309" },
> > > +	{ }
> > > +};
> > > +MODULE_DEVICE_TABLE(of, ltc2309_of_match);
> > > +
> > > +static const struct i2c_device_id ltc2309_id[] = {
> > > +	{ "ltc2309" },
> > > +	{}  
> > 
> > Trivial but space between { and } for consistency.
> > 
> > 
> 
