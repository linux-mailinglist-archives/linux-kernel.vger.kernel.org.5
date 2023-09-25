Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC3FB7AE07D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 22:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbjIYUzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 16:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbjIYUzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 16:55:49 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85255C0;
        Mon, 25 Sep 2023 13:55:41 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id 71dfb90a1353d-49032a0ff13so2667256e0c.0;
        Mon, 25 Sep 2023 13:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695675340; x=1696280140; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dIA+qziFaiYcJMDJC+/kx6eXDbvvT/HPXUlpCtHOxiU=;
        b=Ji37eCiw1aGJbbqBRggFFY9ZDbH8T0ei9Rb0kNHSBEYZDHrQlNznrcWJci3ZFWkH6L
         257mNo61mtK22xJwgPBEZYwXIgQvo1ClduzwXfh9zgHIKCTUJHTz+rDZUWj9WAewIPhK
         RwQTzkqCMxCfrE5D76oPZ8daim6QVay37L8DL6d3Uq1rrCoslOERa1W59cFTn5jSiIVH
         1zgPg0yk9ST8LUN/nLg5IeU1ENsdNkMUmnweg3ei5i1t9zNKXvMyz7RzhtgsKX8h7X56
         frt7gjMbu/pOT5Cux/OJltxlkI1aqR/r6ulL6E0OgHkAgliv56UNtF5unU517pdudiT3
         X/tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695675340; x=1696280140;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dIA+qziFaiYcJMDJC+/kx6eXDbvvT/HPXUlpCtHOxiU=;
        b=Po6RAfbfsxYSj7dc/vivkqLfAUwLeQ112b1oRvUsdyI7wMArpR97GJLOF1/2UxhOeV
         U4tGJngJIKnHx4vSsHPXv+Rqn6z3yLXXv9u1N/BzS0YPcN/VcC1BBiUIB/vmnhHfII6K
         1RX/Dl84mC3n7yRhiWoWO01KZqaBE71qsi2TdnX2OMV2x7xLNRsB8L38wrgtYZ1SO7KN
         UEQ3JQYzyGcP7XpuqAK8uBnH1lxM7gzaYE3ZpNL4ff9H7K4BK3vVybyenpG5yjIJkxCW
         vAwH6ZWot04OBj2UQawBSRWVp7Xprgo75A7sCDnKuPGBJP7hVZbxTYtfBNb13xvXUXFg
         E/aw==
X-Gm-Message-State: AOJu0Yw0zP9AZ4fGpllbRRzBy3No3eAZHXd9EJT0ED6VZ93b2iR3rIOq
        FzR5kxgPLt75OWkq5COJaZds2xTJ0xg5Q/2+c1A=
X-Google-Smtp-Source: AGHT+IE8OXQ5qBWmBH2Wg+f0Rn0UrvAUxFonYCEfiWSdmlJpE5mh59jI9o8qMwt1vMu66AnDRdbHAFQ8ahoC5NLTvPg=
X-Received: by 2002:a1f:c6c1:0:b0:48d:1e9:2707 with SMTP id
 w184-20020a1fc6c1000000b0048d01e92707mr4461061vkf.7.1695675340584; Mon, 25
 Sep 2023 13:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230912122201.3752918-1-paweldembicki@gmail.com>
 <20230912122201.3752918-7-paweldembicki@gmail.com> <20230912213937.wqwiex32ojlojnue@skbuf>
In-Reply-To: <20230912213937.wqwiex32ojlojnue@skbuf>
From:   =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date:   Mon, 25 Sep 2023 22:55:29 +0200
Message-ID: <CAJN1KkyV_B4Dhd65WmeetE8ynf+w=_L3XqE55=4+QWNLNRaDsQ@mail.gmail.com>
Subject: Re: [PATCH net-next v3 6/8] net: dsa: vsc73xx: introduce tag 8021q
 for vsc73xx
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

wt., 12 wrz 2023 o 23:39 Vladimir Oltean <olteanv@gmail.com> napisa=C5=82(a=
):
>
> Hi Pawel,

Hi Vladimir,

>
> On Tue, Sep 12, 2023 at 02:22:00PM +0200, Pawel Dembicki wrote:
> > This commit introduces a new tagger based on 802.1q tagging.
> > It's designed for the vsc73xx driver. The VSC73xx family doesn't have
> > any tag support for the RGMII port, but it could be based on VLANs.
> >
> > Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> > ---
> > diff --git a/net/dsa/tag_vsc73xx_8021q.c b/net/dsa/tag_vsc73xx_8021q.c
> > new file mode 100644
> > index 000000000000..9093a71e6eb0
> > --- /dev/null
> > +++ b/net/dsa/tag_vsc73xx_8021q.c
> > @@ -0,0 +1,91 @@
> > +// SPDX-License-Identifier: GPL-2.0 OR MIT
> > +/* Copyright (C) 2022 Pawel Dembicki <paweldembicki@gmail.com>
>
> 2022-2023 by now, maybe?
>
> > + * Based on tag_sja1105.c:
> > + * Copyright (c) 2019, Vladimir Oltean <olteanv@gmail.com>
> > + */
> > +#include <linux/dsa/8021q.h>
> > +
> > +#include "tag.h"
> > +#include "tag_8021q.h"
> > +
> > +#define VSC73XX_8021Q_NAME "vsc73xx-8021q"
> > +
> > +static struct sk_buff *vsc73xx_xmit(struct sk_buff *skb, struct net_de=
vice *netdev)
> > +{
> > +     struct dsa_port *dp =3D dsa_slave_to_port(netdev);
> > +     u16 queue_mapping =3D skb_get_queue_mapping(skb);
> > +     u16 tx_vid =3D dsa_tag_8021q_standalone_vid(dp);
> > +     u8 pcp;
> > +
> > +     if (skb->offload_fwd_mark) {
> > +             unsigned int bridge_num =3D dsa_port_bridge_num_get(dp);
> > +             struct net_device *br =3D dsa_port_bridge_dev_get(dp);
> > +
> > +             if (br_vlan_enabled(br))
> > +                     return skb;
> > +
> > +             tx_vid =3D dsa_tag_8021q_bridge_vid(bridge_num);
> > +     }
> > +
> > +     pcp =3D netdev_txq_to_tc(netdev, queue_mapping);
> > +
> > +     return dsa_8021q_xmit(skb, netdev, ETH_P_8021Q,
> > +                           ((pcp << VLAN_PRIO_SHIFT) | tx_vid));
> > +}
> > +
> > +static void vsc73xx_vlan_rcv(struct sk_buff *skb, int *source_port,
> > +                          int *switch_id, int *vbid, u16 *vid)
> > +{
> > +     if (vid_is_dsa_8021q(skb_vlan_tag_get(skb) & VLAN_VID_MASK))
> > +             return dsa_8021q_rcv(skb, source_port, switch_id, vbid);
> > +
> > +     /* Try our best with imprecise RX */
> > +     *vid =3D skb_vlan_tag_get(skb) & VLAN_VID_MASK;
> > +}
> > +
> > +static struct sk_buff *vsc73xx_rcv(struct sk_buff *skb, struct net_dev=
ice *netdev)
> > +{
> > +     int src_port =3D -1, switch_id =3D -1, vbid =3D -1;
> > +     u16 vid;
> > +
> > +     if (skb_vlan_tag_present(skb)) {
> > +             /* Normal traffic path. */
> > +             vsc73xx_vlan_rcv(skb, &src_port, &switch_id, &vbid, &vid)=
;
> > +     } else {
> > +             netdev_warn(netdev, "Couldn't decode source port\n");
> > +             return NULL;
> > +     }
> > +
> > +     if (vbid >=3D 1)
> > +             skb->dev =3D dsa_tag_8021q_find_port_by_vbid(netdev, vbid=
);
> > +     else if (src_port =3D=3D -1 || switch_id =3D=3D -1)
> > +             skb->dev =3D dsa_find_designated_bridge_port_by_vid(netde=
v, vid);
> > +     else
> > +             skb->dev =3D dsa_master_find_slave(netdev, switch_id, src=
_port);
>
> Hmm, this isn't looking too good.
>
> I think the fact that you had to add my copyright on what should be such
> a simple thing as a VLAN-based tagger is a bad sign :)
>
> It's time to consolidate some more stuff that currently lives in
> tag_sja1105 and move it into tag_8021q so that you can reuse it more
> easily.
>
> I've prepared some (only compile-tested) patches on this branch here:
> https://github.com/vladimiroltean/linux/commits/pawel-dembicki-vsc73xx-v3
>
> I need to double-check that they don't introduce regressions,

I tested it on my device and I couldn't find any regressions. vlan
filtering and tagging work as expected.

> and we
> should discuss the merging strategy. Probably you're going to submit
> them together with your patch set.

I prepared the v4 patch series. Please look if that format is ok with you.
https://github.com/CHKDSK88/linux/commits/vsc73xx-vlan-net-next

>
> With that, you can drop my part of the copyright :) The remainder should
> look like straightforward use of API which can be written in only a
> limited number of ways.

Now it is much simpler.

>
> > +     if (!skb->dev) {
> > +             netdev_warn(netdev, "Couldn't decode source port\n");
> > +             return NULL;
> > +     }
> > +
> > +     dsa_default_offload_fwd_mark(skb);
> > +
> > +     if (dsa_port_is_vlan_filtering(dsa_slave_to_port(skb->dev)) &&
> > +         eth_hdr(skb)->h_proto =3D=3D htons(ETH_P_8021Q))
> > +             __vlan_hwaccel_clear_tag(skb);
>
> Why do you need to do this? We send VLAN-tagged packets to the
> VLAN-aware bridge intentionally, so that it knows what VLAN they come
> from (in the dsa_find_designated_bridge_port_by_vid() case). So don't
> strip it if it's not causing a problem.
>

I dropped it in v4. I needed it when I started with this patch series,
because bridge in vlan filtering causes double tagged frames (one from
hardware and one from bridge). But after recent changes it is useless
and it could be dropped because vlan works as expected without it.

> > +
> > +     return skb;
> > +}
