Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764C57FFB74
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:38:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376483AbjK3TiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376422AbjK3TiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:38:14 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21A593;
        Thu, 30 Nov 2023 11:38:20 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3331752d2b9so954541f8f.3;
        Thu, 30 Nov 2023 11:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701373099; x=1701977899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AEfJqIl3X2gXSOJ2gIPsjyHWEUMck6FZOj8vIfnbhnA=;
        b=iPw778g4WqUj5Li67O8gmG63dCzzpS9KNVYO7T57Wp/fBOnvhko2JE6Ong93QEH58W
         L6ymF+C4QPqqP3ksYVPbyycng4erR64qVivHj/8QgbV9mU+513mFueSXIdWcSmtzMu3+
         5+sd1Wh5F+5O5nFuxMpaQcJxbC7enEtWe1VoIISfLkn4N3BX0b2AnWJBYE4tWbkbbzal
         r/4NW/OwVUH9hxYG+aE+PnxcX8E5xeNFFygHCmf6IPRVMINapsWrAgSVoWAPsI3vsUUP
         SI/q2OdxNoBs6bkkkl9UMtAYk7vKqECC8O1s69cxLNEALh8vHV1st78VAzeovhgNCHnY
         2Stw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701373099; x=1701977899;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEfJqIl3X2gXSOJ2gIPsjyHWEUMck6FZOj8vIfnbhnA=;
        b=Bhl7U5Gje/DCywiADL0qXVAUH9cIxzZJVOoOxJx9vfMkE5bjg38lsSjrv1LLLsWqPC
         7A8LX16SxI4tkbWALFk4XHrzDwFrsX4z/ayOU049eTL9nPKRL/xcgEGDOX9t8qxhdwg4
         5E1jEtZIraXVs+MRlf4XoJM9MTslkJ+TuI9kGuJtujmKfnZuDEeYoorVKJBpXBuclOXi
         CPjRwdou81iHjwbnN4JfiNJzmdKeL/Ga8tFRA5cHxG0xc3ENBxGdJ9hluA8kkdj7N4zj
         mgQc8xk3vHV4cPCgBURJf7/V3rMV0pb9OSjB+gWZ4dxfEmyJVjJxeBrhYem2UZZYgxVn
         fKmg==
X-Gm-Message-State: AOJu0Yzq9bL4LhV4kMKAqesAQiQqzdD64gi7G3AWiq3ArSQtqJFlfM0U
        vh54ofaj8ORq4CryMhieRIs=
X-Google-Smtp-Source: AGHT+IHETBlUH8OmbXwCkdKprfxeaHj4ZH7B3muQxe0+pLAfyy9N7pPT0vBpxpbYA7fBh3pRkTHiew==
X-Received: by 2002:a5d:6acf:0:b0:333:2fd2:8144 with SMTP id u15-20020a5d6acf000000b003332fd28144mr27399wrw.97.1701373098878;
        Thu, 30 Nov 2023 11:38:18 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id a12-20020a056000188c00b0032ddf2804ccsm2334838wri.83.2023.11.30.11.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 11:38:18 -0800 (PST)
Message-ID: <6568e4aa.050a0220.120a5.9c83@mx.google.com>
X-Google-Original-Message-ID: <ZWjkqRDk_g-4SpW_@Ansuel-xps.>
Date:   Thu, 30 Nov 2023 20:38:17 +0100
From:   Christian Marangi <ansuelsmth@gmail.com>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [net-next PATCH 06/14] net: phy: at803x: move at8031 specific
 data out of generic at803x_priv
References: <20231129021219.20914-1-ansuelsmth@gmail.com>
 <20231129021219.20914-7-ansuelsmth@gmail.com>
 <47df2f0d-3410-43c2-96d3-87af47cfdcce@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47df2f0d-3410-43c2-96d3-87af47cfdcce@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 04:21:50PM +0100, Andrew Lunn wrote:
> > +struct at8031_data {
> > +	bool is_fiber;
> > +	bool is_1000basex;
> > +	struct regulator_dev *vddio_rdev;
> > +	struct regulator_dev *vddh_rdev;
> > +};
> > +
> >  struct at803x_priv {
> >  	int flags;
> >  	u16 clk_25m_reg;
> >  	u16 clk_25m_mask;
> >  	u8 smarteee_lpi_tw_1g;
> >  	u8 smarteee_lpi_tw_100m;
> > -	bool is_fiber;
> > -	bool is_1000basex;
> > -	struct regulator_dev *vddio_rdev;
> > -	struct regulator_dev *vddh_rdev;
> > +
> > +	/* Specific data for at8031 PHYs */
> > +	void *data;
> >  };
> 
> I don't really like this void *
> 
> Go through at803x_priv and find out what is common to them all, and
> keep that in one structure. Add per family private structures which
> include the common as a member.

As you notice later in the patches, only at803x have stuff in common
qca803xx and qca808x doesn't use the struct at all (aside from stats)

And in the at803x PHY family only at8031 have fiber 1000basex and
regulators.

> 
> By having real types everywhere you get the compiler doing checks for
> you.

Main problem is that adding something like
'struct at8031_data* at8031_data' looks also bad.

Maybe I can rework the 2 bool to flags (they are used only by at803x)
and keep the 2 regulator pointer?

> 
> As Russell pointed out, this patch series is going to be too big. So
> break it up. We can move fast on patches which are simple and
> obviously correct.
> 
-- 
	Ansuel
