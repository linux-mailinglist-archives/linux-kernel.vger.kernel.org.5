Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66107F854F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 21:59:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346054AbjKXUsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 15:48:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjKXUsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 15:48:16 -0500
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F5F19A4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 12:48:22 -0800 (PST)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-423a0a25222so102951cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 12:48:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700858901; x=1701463701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tFQWMpDN2F24cc/J03f4NVx2U6EwlQXtQnJp1TM3/K8=;
        b=1LcHPJrkSE6LmyHMrgDoIEpZNHn/ywCyZYHVujYiNCy8y8v5qEqT6rE/drq/47cIwa
         4yfcCQKfCCfSy+UnOyeX3+nAPOvRqPInA7EJWxm6m1GpsIsdUo733GMKcvRBufgfZjDa
         Hyi6KwukEDyLeESd6CtwH8oGuWPzbUaN0jrkPf6UfaWubZpx4FX8kBmN7V/DRglmIwl0
         NPcgFok1JYzrSMZp8Y5sVp4ms/ZycId2UIRAU1OJR5b8YPrarK1ipy/ATnbNqLvc57Mi
         HVCyuEohN3wMNlt6WJxkBQL9fUlQP85/c6ET6wYrQ2F/fPRcVMOzhQ3/+7fuUsrG992f
         vKxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700858901; x=1701463701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tFQWMpDN2F24cc/J03f4NVx2U6EwlQXtQnJp1TM3/K8=;
        b=Mm/agt4l2Tm5LowflQIkRwUtEC9VGAuPNQCVevKDooTK+Ao/wh9KSy9LXpKa6qX354
         u4vj54NUF7pj8meu3aDAQYeSSaLpFZL7jZQW9UVpWKM8YwAPrjz1uX9FCxLv5M2/jRMm
         wvXJXRIMdlWsicgPY8IGFR4TfDn7vSolziMD5cSctk7Yvjg33BgsCvTeSA5vQdxwDdCN
         PN/4ni1uhhj8DHRcL+p1jj/fHKvTEYXWMiCgKDwcrto/zQQInC+g0bAFA914Rm826Bht
         /sUw7R1RG7kAmpS8crIoQvuEwvKTxI4gAXAR09mHT3/GQKmXubawA4Id6J0V4Liqed5T
         EPgw==
X-Gm-Message-State: AOJu0YzC64+2gKuBCKeR/Ol5vzNtxE48yMelNISs+auHslqE83uzOvTw
        fbdXa+TTxC+VElUYTswnAxqdZFGjsAElAbteFkyDHw==
X-Google-Smtp-Source: AGHT+IFlw/BprWhMGyCnxPL0swEeuxm4RjdXSiWCk+/jHDaoAAmc3zBMtDvNW474MpL5i9yKSS1/AA2MWkWolILaYOk=
X-Received: by 2002:ac8:5885:0:b0:421:c8d7:58f1 with SMTP id
 t5-20020ac85885000000b00421c8d758f1mr705562qta.4.1700858900765; Fri, 24 Nov
 2023 12:48:20 -0800 (PST)
MIME-Version: 1.0
References: <20231120220549.cvsz2ni3wj7mcukh@skbuf> <20231121183114.727fb6d7@kmaincent-XPS-13-7390>
 <20231121094354.635ee8cd@kernel.org> <20231122144453.5eb0382f@kmaincent-XPS-13-7390>
 <20231122140850.li2mvf6tpo3f2fhh@skbuf> <20231122085000.79f2d14c@kernel.org>
 <20231122165517.5cqqfor3zjqgyoow@skbuf> <20231122100142.338a2092@kernel.org>
 <20231123160056.070f3311@kmaincent-XPS-13-7390> <20231123093205.484356fc@kernel.org>
 <20231124154343.sr3ajyueoshke6tn@skbuf> <20231124183431.5d4cc189@kmaincent-XPS-13-7390>
In-Reply-To: <20231124183431.5d4cc189@kmaincent-XPS-13-7390>
From:   Willem de Bruijn <willemb@google.com>
Date:   Fri, 24 Nov 2023 15:47:43 -0500
Message-ID: <CA+FuTSfQgqQyBHSgx32Vdnxs4wgMSyB9yEpJTObS5t1iYFcWBA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 15/16] net: ethtool: ts: Let the active time
 stamping layer be selectable
To:     =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>
Cc:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 24, 2023 at 12:34=E2=80=AFPM K=C3=B6ry Maincent
<kory.maincent@bootlin.com> wrote:
>
> On Fri, 24 Nov 2023 17:43:43 +0200
> Vladimir Oltean <vladimir.oltean@nxp.com> wrote:
>
> > On Thu, Nov 23, 2023 at 09:32:05AM -0800, Jakub Kicinski wrote:
> > > On Thu, Nov 23, 2023 at 04:00:56PM +0100, K=C3=B6ry Maincent wrote:
> > > > So, do we have a consensus? Vlad, do you agree on putting all under
> > > > ethtool?
> > > >
> > > > ETHTOOL_GET_TS_INFO will be in charge of replacing the SIOCGHWSTAMP
> > > > implementation. Need to add ETHTOOL_A_TSINFO_PHC_INDEX
> > > > ETHTOOL_A_TSINFO_QUALIFIER to the request.
> > > >
> > > > ETHTOOL_GET_TS_INFO will list all the hwtstamp provider (aka "{phc_=
index,
> > > > qualifier}") through the dumpit callback. I will add a filter to be=
 able
> > > > to list only the hwtstamp provider of one netdev.
> > > >
> > > > ETHTOOL_SET_TS_INFO will be in charge of replacing the SIOCSHWSTAMP
> > > > implementation.
> > >
> > > If not we can do a vote/poll? Maybe others don't find the configurati=
on
> > > of timestamping as confusing as me.
> >
> > If you mean the ETHTOOL_MSG_TSINFO_GET netlink message (ETHTOOL_GET_TS_=
INFO
> > is an ioctl), you're saying that you want to move the entire contents o=
f
> > SIOCGHWSTAMP there, by making the kernel call ndo_hwtstamp_get() in
> > addition to the existing __ethtool_get_ts_info()?
>
> Yes.
>
> > Yeah, I don't know, I don't have a real objection, I guess it's fine.
> >
> > What will be a bit of an "?!" moment for users is when ethtool gains
> > support for the SIOCGHWSTAMP/SIOCSHWSTAMP netlink replacements, but not
> > for the original ioctls. So hwstamp_ctl will be able to change timestam=
ping
> > configuration, but ethtool wouldn't - all on the same system. Unless
> > ethtool gains an ioctl fallback for a ioctl that was never down its all=
ey.
>
> Yes indeed. Would it break things if both ioctls and netlink can get and =
set
> the hwtstamps configuration? It is only configuration. Both happen under
> rtnl_lock it should be alright.
>
> The question is which hwtstamp provider will the original ioctls be able =
to
> change? Maybe the default one (MAC with phy whitelist) and only this one.
>
> > But by all means, still hold a poll if you want to. I would vote for
> > ethtool netlink, not because it's great, just because I don't have a
> > better alternative to propose.
>
> If you agree on that choice, let's go. Jakub and your are the most proact=
ive
> reviewers in this patch series. Willem you are the timestamping maintaine=
r do
> you also agree on this?

I don't have a strong opinion. Ethtool netlink SGTM.

For new network configuration we are moving away from ioctl towards
netlink in general.

Ethtool itself made this move, where the old ioctl way of things
continues to work, but will no longer be extended.

Since one of the APIs we use already uses ethtool, converting the
other two there makes sense to me.

I'm not familiar enough with configuring CAN or wireless to know
whether it would pose a problem for these mentioned cases.

> If anyone have another proposition let them speak now, or forever remain
> silent! ;)
