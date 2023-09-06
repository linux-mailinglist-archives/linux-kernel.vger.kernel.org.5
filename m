Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644C8794036
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242504AbjIFPVW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjIFPVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:21:20 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991EF1724;
        Wed,  6 Sep 2023 08:21:16 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-56c2e882416so2337961a12.3;
        Wed, 06 Sep 2023 08:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694013676; x=1694618476; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2L9GRjR364WCUyawO5k8E+dewUfnR/NDRPvmW9pij2I=;
        b=k8zNmkz1ihqkhAlFvTmvsWhnp/2xZIASXOSmX4e/X77kVyFQ2WsdpDBKMnR2+atfOK
         nJzGkzGaePfrm9NwdeozZYd1V5bKlrqsAOTZ7hI3xLC6iBON5YzMnhdq0UucM4pmP1iu
         ObGHO3HmQPi3pbX8ogsT2ZQEfiLpLx+mzIDYBuKLocExzSMODA4j3muKyLrzw+Sj3Hbk
         TDd7/DjK6ktpG2vdBbtCuAp3M1A+P8sFcYfgedBOC79kxh7KGl8B2X3tvBXdCOsoel2/
         1NydowfLEhc3x0s9rq1dMD1eV7HD7FLuE9CErD5LDXJozN3ptCL84K76HPM4GVyJYQWJ
         v42g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694013676; x=1694618476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2L9GRjR364WCUyawO5k8E+dewUfnR/NDRPvmW9pij2I=;
        b=A0ygYchK0dz0rb8WreA15JBvzH3eF9xoBj7uBOmh9DSLFPC+40DT2ZYh/hI5/9ZYfr
         f1jq+Jb/HXKf2ttiylj0DpLytYwmUitT8OEBD1NYBf3yIR72zRG+flUMaOGSk6cDcehg
         OqFaZB5mdsOsjcLdAXsKh6Fknie65NfQlCqNJ9VH55MiYGV+38lHPBZa7T8YZKpiOUD2
         sDAyluOR/oRADXNcZTd06jfUWpruJM2W798oYUcQdqXub5TGFXoaR12ojNhDmff1URzX
         LU1iK5s9FqKVR8c0Z8CrsD1Yl/WjFtKU8iyAy+hcUUtefg1Q8kpoTcKvQQdm71trP0MT
         m/IA==
X-Gm-Message-State: AOJu0Yw0o+SiCE1Y80LNIUzEVNpMH2NrG77r9mSVB4fwlyMtaMw1TAEh
        GDfqxPrXjBJMZZB0+0Is7DQ=
X-Google-Smtp-Source: AGHT+IES8cBWsR7Fv4U3nDHZ/CT3HL0Z9k44+4M1+YtWuZNEqRPl+IwhNFWfAZGvAWSEyWnyQgKZpQ==
X-Received: by 2002:a05:6a20:9691:b0:140:c838:2b2e with SMTP id hp17-20020a056a20969100b00140c8382b2emr12678175pzc.22.1694013675947;
        Wed, 06 Sep 2023 08:21:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g18-20020aa78192000000b0068718aadda7sm10945777pfi.108.2023.09.06.08.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 08:21:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 6 Sep 2023 08:21:13 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Eric Tremblay <etremblay@distech-controls.com>,
        Jean Delvare <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH v4 1/2] hwmon: tmp513: Add max_channels variable to
 struct tmp51x_data
Message-ID: <329b6717-6bba-42c4-94a7-7466d3d0f411@roeck-us.net>
References: <20230905184252.222742-1-biju.das.jz@bp.renesas.com>
 <20230905184252.222742-2-biju.das.jz@bp.renesas.com>
 <ZPiPVZKXeDfLsU64@smile.fi.intel.com>
 <OS0PR01MB592218CADC2F90290B0B727D86EFA@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <ZPiT606wpCDsNVPC@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPiT606wpCDsNVPC@smile.fi.intel.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 05:59:55PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 06, 2023 at 02:46:37PM +0000, Biju Das wrote:
> > > On Tue, Sep 05, 2023 at 07:42:51PM +0100, Biju Das wrote:
> 
> ...
> 
> > > > +#define TMP51X_TEMP_CONFIG_CONV_RATE	FIELD_PREP(GENMASK(9, 7), 0x7)
> > > > +#define TMP51X_TEMP_CONFIG_RC		BIT(10)
> > > > +#define TMP51X_TEMP_CHANNEL_MASK(n)	FIELD_PREP(GENMASK(14, 11), \
> > > > +						   GENMASK((n) - 1, 0))
> > > 
> > > Why do you need FIELD_PREP() for the pure constants here? Why can you
> > > simply define the constants in the proper place?
> > 
> > I think one can clearly understand the bit definitions and value from FIELD_PREP.
> 
> I think it is clear over engineering. In the first one the constant can't be
> more than the field, in the second the defensive programming that is discouraged
> in the kernel.
> 
> #define TMP51X_TEMP_CHANNEL_MASK(n)	(GENMASK((n) - 1, 0) << 11)
> 
> would suffice and much easier to understand.
> 

I agree.

> ...
> 
> > > > +#define TMP51X_TEMP_CONFIG_DEFAULT(n)	(TMP51X_TEMP_CONFIG_CONT | \
> > > > +			TMP51X_TEMP_CHANNEL_MASK(n) | \
> > > > +			TMP51X_TEMP_CONFIG_CONV_RATE | TMP51X_TEMP_CONFIG_RC)
> > > 
> > > This is better to read in a form of
> > > 
> > > #define TMP51X_TEMP_CONFIG_DEFAULT(n)					\
> > > 	(TMP51X_TEMP_CHANNEL_MASK(n) | TMP51X_TEMP_CONFIG_CONT |	\
> > > 	 TMP51X_TEMP_CONFIG_CONV_RATE | TMP51X_TEMP_CONFIG_RC)
> > > 
> > 
> > I just used the indentation suggested by Guenter.
> 
> But wouldn't my proposal be sightly better to read?

I'd have to look up what specifically I had asked for, but it wasn't meant
to exclude better formatting. I agree that the formatting you suggested
is better.

Guenter
