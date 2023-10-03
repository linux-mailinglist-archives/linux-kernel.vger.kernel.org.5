Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9E67B732A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241151AbjJCVPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241171AbjJCVPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:15:10 -0400
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D6B3D8;
        Tue,  3 Oct 2023 14:15:07 -0700 (PDT)
Received: by mail-vs1-xe2e.google.com with SMTP id ada2fe7eead31-4526b9078b2so654437137.0;
        Tue, 03 Oct 2023 14:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696367706; x=1696972506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t66igBKn3unZXjiFNkV7Rwej4hjUxsXRg77hR2hMt8g=;
        b=F6FtSrhkKbEAbrbgaRYiWexw4Z5Ka9Ao+WBZD8jAoFRwYyGD/9fn5V17nhCQlRU8rz
         nKA1DerouRjKH4RSr5ORaCoQ8WKMvX0k1Iyrx0iWX4qc16XlKpYmGJobtnWYtnN/oP51
         cZi1m1ncpBcyOwjaS9F/aArLEFcBz15VnpsY/io8u/agSBeQzrnMthmpzwXH21emXSRp
         ltEU+r+BuSwoyzcV4gPeVcf5MRxNGQEWL34DqUEc4/UJ1bzgrHhZMYz50y0SqnpSZLpX
         nszRVMM8UOpoBxRgzy7nuUdRScIxUvrr4+yF4mT+xkpUfl4Xnfgd594w4waXqMmP9jyM
         mJ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696367706; x=1696972506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t66igBKn3unZXjiFNkV7Rwej4hjUxsXRg77hR2hMt8g=;
        b=W5HPZAAqyhbRfve3H1/9Sy3hfJWMgV4A6dSZh9ynLCoZjJtmg52B9DrmtfnvO/O+lA
         z9BJXceJEt2qrn0BhsRDfVWhQ1V52H0KEprosBp/Hfy1XhCYA89xgreP/9sHWdJIc2Kv
         GHp4HvscVcTBorb1NfJhXi0hE2Dkz7aCaKFMC/Re70Gj/dSHi7cxAn6SgIG4XFUlVT+Y
         ep3hkeQ01fnKglgn98gYkTUjz8OGOI3UADVgWKmXd7J16EfMireemIINW065mif2DzUb
         /70Rsso6CMe1AKf72NcVyHdIe9l89amPhkyHfk3Et3b0wmqTBb16lOOGtPDUWmRMb42n
         FvKw==
X-Gm-Message-State: AOJu0YzoeVPcrAHu3Dv7RbXj0yHde57Rm8ZIj4J8xRg0xWhRE0lRRrcd
        5AnQJd62Mp/OgnvNDePKmMvCjH/ULWmXqv6iLMk=
X-Google-Smtp-Source: AGHT+IHU1HA7EBCu1bSOZFLvFKaE67h5BM/9flJCDRh81glmHisci7ZazVDwTxJi01fD5rgoNDUEUSZoQ2xLrv/Qz3Y=
X-Received: by 2002:a05:6102:7c2:b0:44e:96aa:e445 with SMTP id
 y2-20020a05610207c200b0044e96aae445mr525026vsg.29.1696367706115; Tue, 03 Oct
 2023 14:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230912122201.3752918-1-paweldembicki@gmail.com>
 <20230912122201.3752918-6-paweldembicki@gmail.com> <20230912161709.g34slexfaop6xp7w@skbuf>
 <CAJN1Kkwzwt++6GtrAnCbKzYto-uQECYZz5=N7bePqK9wsK2_+g@mail.gmail.com> <20230926235848.3uftpkj7m24qsord@skbuf>
In-Reply-To: <20230926235848.3uftpkj7m24qsord@skbuf>
From:   =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date:   Tue, 3 Oct 2023 23:14:55 +0200
Message-ID: <CAJN1KkxcPzQ3-KCPdh1N6CGg7Foj=JbP3b2Kg=vqxpKOZumn8w@mail.gmail.com>
Subject: Re: [PATCH net-next v3 5/8] net: dsa: vsc73xx: Add vlan filtering
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     netdev@vger.kernel.org, Dan Carpenter <dan.carpenter@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 27 wrz 2023 o 01:58 Vladimir Oltean <olteanv@gmail.com> napisa=C5=
=82(a):
>
> On Fri, Sep 22, 2023 at 04:26:00PM +0200, Pawe=C5=82 Dembicki wrote:
> > > > +             if (vsc->untagged_storage[port] < VLAN_N_VID &&
> > > > +                 !vid_is_dsa_8021q(vsc->untagged_storage[port]) &&
> > > > +                 !vid_is_dsa_8021q(vid) &&
> > >
> > > The problem here which led to these vid_is_dsa_8021q() checks is that
> > > dsa_switch_tag_8021q_vlan_add() sets all flags on user ports to
> > > BRIDGE_VLAN_INFO_UNTAGGED | BRIDGE_VLAN_INFO_PVID, and you can't offl=
oad
> > > those, correct?
> >
> > In my case, the major problem with tag8021q vlans is
> > "dsa_tag_8021q_bridge_join" function:
> > "dsa_port_tag_8021q_vlan_add" is called before "dsa_port_tag_8021q_vlan=
_del".
> > I must disable pvid/untagged checking, because it will always fail. I
> > let kernel do the job,
> > it keeps only one untagged/pvid per port after "dsa_tag_8021q_bridge_jo=
in".
>
> I'm not sure that you described the problem in a way that I can understan=
d, here.
>
> After dsa_tag_8021q_bridge_join():
> -> dsa_port_tag_8021q_vlan_add(dp, bridge_vid)
> -> dsa_port_tag_8021q_vlan_del(dp, standalone_vid)
>
> it's *expected* that there should be only one untagged/pvid per port: the=
 bridge_vid.
>
> For context, consider the fact that you can run the following commands:
>
> bridge vlan add dev eth0 vid 10 pvid
> bridge vlan add dev eth0 vid 11 pvid
>
> and after the second command, vid 10 stops being a pvid.
>
> So I think that the "Port %d can have only one pvid! Now is: %d.\n" behav=
ior
> is not correct. You need to implement the pvid overwriting behavior, sinc=
e
> there's always only 1 pvid.
>

Yes, overwriting pvid is the only proper way. Kernel mechanism will
take care about the number of pvids. I will fixit in v4.

> So that leaves the "untagged" flag as being problematic, correct? Could
> you comment...
>
> >
> > > But when the port is VSC73XX_VLAN_IGNORE mode (and
> > > tag_8021q is active), VSC73XX_TXUPDCFG_TX_INSERT_TAG is 0, and thus,
> > > *all* VLANs are egress-untagged VLANs, correct?
> > >
> > > If that is the case, why do you call vsc73xx_vlan_set_untagged() in t=
he
> > > first place, for tag_8021q VLANs, if you don't rely on the port's nat=
ive
> > > VLAN for egress untagging?
>
> ... on this? Here I'm pointing out that "all VLANs have the egress-untagg=
ed flag"
> is a configuration that can actually be supported by vsc73xx. You just
> need to ensure that VSC73XX_TXUPDCFG_TX_INSERT_TAG is 0. And tag_8021q
> basically requests exactly that configuration on user ports (both the
> bridge_vid and the standalone_vid are egress-untagged). So your check is
> too restrictive, you are denying a configuration that would work.
> The problem only appears when you mix egress-tagged with egress-untagged
> VLANs on a port. Only then there can be at most 1 egress-untagged VID,
> because you need to enable VSC73XX_TXUPDCFG_TX_INSERT_TAG for the
> egress-tagged VIDs to work.

Should I make a local copy of the quantity of egress untagged and
tagged vlans per port to resolve this issue, shouldn't I?
And then I check how many vlans are egress tagged or untagged for a
properly restricted solution?

I see another problem. Even if I return an error value, the untagged
will be marked in 'bridge vlan' listing. I'm not sure how it should
work in this case.

>
> > > A comment would be good which states that the flipping between the
> > > hardware and the storage values relies on the fact that vsc73xx_port_=
vlan_filtering()
> > > only gets called on actual changes to vlan_filtering, and thus, to
> > > vsc73xx_tag_8021q_active(). So, we know for sure that what is in stor=
age
> > > needs to go to hardware, and what is in hardware needs to go to stora=
ge.
> > >
> > > It's an interesting implementation for sure.
> > >
> >
> > Thank you.
>
> I'm not sure if that was a compliment :)

Touch=C3=A9. :)

>At least in this form, it's
> certainly non-trivial to determine by looking at the code if it is
> correct or not, and it uses different patterns than the other VLAN
> implementations in DSA drivers. Generally, boring and obvious is
> preferable. But after I took the time to understand, it seems plausible
> that the approach might work.
>
> Let's see how the same idea looks, cleaned up a bit but not redesigned,
> in v4.

I try to at least clean pvid and untagged issues before v4.
