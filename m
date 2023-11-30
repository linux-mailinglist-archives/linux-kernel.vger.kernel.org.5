Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0597FFC67
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 21:24:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376682AbjK3UYE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 15:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjK3UYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 15:24:03 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B8810FF;
        Thu, 30 Nov 2023 12:24:09 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40b40423df8so12114145e9.0;
        Thu, 30 Nov 2023 12:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701375848; x=1701980648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=S8gTz2MUVz+WKOP5tFTP9yWnrMxXAQWUx4ViPQ1DOAQ=;
        b=dalxBy4dgW7r+DlQjAuIyScIlqquspKB768CTPVtAM+Jr84yX0K3eVu4mICdEOIjF6
         TkoSKxoanrWFm+6EH/jBq9+PQBtzbeujJCrPpc57VtlvsY3rlW06c+TtNE+ott3EgP9/
         SM4WtWfiqqbzVniEcf0TOqWQfcLyjfgsyskVTBrlJbC5LXmBGefYPkDsuRk66sSWxOhw
         jirADGdQAoka6097NIkLcBBxFy553JSpV7kf99QYBusuuJUk6r08uvuOfbdrYoiYDjAj
         lNhPCjQYn7qbnrDqC5e6Jqaus31L+KytqLolRZtcRRR/LHwoo/NsMffflQ6NoVp+RMQj
         VNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701375848; x=1701980648;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S8gTz2MUVz+WKOP5tFTP9yWnrMxXAQWUx4ViPQ1DOAQ=;
        b=RUqlei/Xa/OHKemvC4qA+cVd0MsRjgxNq85/WIDHkgt/Cj7tfAKs1EXtxuD+o8GLOR
         u/Vpl467DmADZpo/hP6vZbJR/eWrZEGlPWNIZMB2D0wFA2n9+gwIGUhkac7ZuknWk/gN
         L1yqKV3lrer7I/nNml+UfgNvjGimS/MNeqq98KcsmKLsNpPRHzpJ1arv/3UCP2gFQ0yu
         v1hnvuvGUUt+PT8dg7k/eKrJ5hT4cGxa+LK1JbJxcJREG0AfB0Nt2pEp8SbIT1QUKyTm
         XsmuyGfPG/er4UG+JrhWAV/9EUe9WMaLDHmOl/0TgYy76+mWJhah8IKAD4upvsCzF+xG
         uk7Q==
X-Gm-Message-State: AOJu0YyFAwd9ACEGUOXAmaFNJjMULdWjXm2NIPBYYvmMK60oSMybRR0+
        Ou2do4LNJqQyNjIOM+8yvxk=
X-Google-Smtp-Source: AGHT+IFpkTGD8DYsKb7c2nqtRg2flhIF0Jm5Y6j0TlCxotdH/o/+OW79eNqE4GdOYLK7VnTMxjRR+g==
X-Received: by 2002:a05:600c:1c81:b0:40b:5e4a:4063 with SMTP id k1-20020a05600c1c8100b0040b5e4a4063mr26419wms.131.1701375847671;
        Thu, 30 Nov 2023 12:24:07 -0800 (PST)
Received: from Ansuel-xps. (93-34-89-13.ip49.fastwebnet.it. [93.34.89.13])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c351300b0040b347d90d0sm6630454wmq.12.2023.11.30.12.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:24:07 -0800 (PST)
Message-ID: <6568ef67.050a0220.398ae.be77@mx.google.com>
X-Google-Original-Message-ID: <ZWjvZW47TYQSmpoP@Ansuel-xps.>
Date:   Thu, 30 Nov 2023 21:24:05 +0100
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
 <6568e4aa.050a0220.120a5.9c83@mx.google.com>
 <568f8b22-a7d2-46c3-a539-30ecf6a85b18@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <568f8b22-a7d2-46c3-a539-30ecf6a85b18@lunn.ch>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 09:14:00PM +0100, Andrew Lunn wrote:
> On Thu, Nov 30, 2023 at 08:38:17PM +0100, Christian Marangi wrote:
> > On Thu, Nov 30, 2023 at 04:21:50PM +0100, Andrew Lunn wrote:
> > > > +struct at8031_data {
> > > > +	bool is_fiber;
> > > > +	bool is_1000basex;
> > > > +	struct regulator_dev *vddio_rdev;
> > > > +	struct regulator_dev *vddh_rdev;
> > > > +};
> > > > +
> > > >  struct at803x_priv {
> > > >  	int flags;
> > > >  	u16 clk_25m_reg;
> > > >  	u16 clk_25m_mask;
> > > >  	u8 smarteee_lpi_tw_1g;
> > > >  	u8 smarteee_lpi_tw_100m;
> > > > -	bool is_fiber;
> > > > -	bool is_1000basex;
> > > > -	struct regulator_dev *vddio_rdev;
> > > > -	struct regulator_dev *vddh_rdev;
> > > > +
> > > > +	/* Specific data for at8031 PHYs */
> > > > +	void *data;
> > > >  };
> > > 
> > > I don't really like this void *
> > > 
> > > Go through at803x_priv and find out what is common to them all, and
> > > keep that in one structure. Add per family private structures which
> > > include the common as a member.
> > 
> > As you notice later in the patches, only at803x have stuff in common
> > qca803xx and qca808x doesn't use the struct at all (aside from stats)
> 
> The dangers here are taking a phydev->priv and casting it. You think
> it is X, but is actually Y, and bad things happen.
> 
> The helpers you have in your common.c must never do this. You can have
> a at803x_priv only visible inside the at803x driver, and a
> qca808x_priv only visible inside the qca808x driver. Define a
> structure which is needed for the shared code in common.c, and pass it
> as a parameter to these helpers.

Tell me if the idea is crazy enough. Ideally common function should do
simple phy read/write and should not reference stuff using priv (as we
would have the problem you are pointing out)

But phy_read/write needs phydev...

Would be ok to have something like

struct qca_ethphy_common {
 struct phy_device *phydev;
}

And pass this struct to the helper? Is it enough to desist devs from
starting introducing function in common.c, checking the ID there and
starting doing stuff with funny specific phydev priv?

> 
> You have a reasonably good idea what your end goal is. The tricky part
> is getting there, in lots of easy to review, obviously correct steps.
>

-- 
	Ansuel
