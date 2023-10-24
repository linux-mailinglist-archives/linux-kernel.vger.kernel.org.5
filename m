Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0197D5205
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 15:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234388AbjJXNkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 09:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234451AbjJXNkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 09:40:45 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED7395;
        Tue, 24 Oct 2023 06:40:41 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 694441BF210;
        Tue, 24 Oct 2023 13:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698154840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XAvwTUEXIaI0z46pwJVVezsvG++BVtQgJpn7cNB1ctk=;
        b=fVfgHpnxlEj7KXhnlLkjkqIn4X+DlaVL28wNNDKsdKIyO3C3tvJQuTHYhg5CqnbLkuLnAJ
        MhjWilxmzP1cRei4l0+6prxLMziuTntq9RysPTZe30dYV50oRayMr13kCzvEzclbcaYryh
        ERnuCbdc2IHW4tbscWoIBlJ60sEyXnkg7y7EnGhxy0YUq0M5CPlkzk/nzoDiX74mJVuTCz
        IZWE0bfR+0kPEB5Wen0qms4C9EAH4tE8o6XR0LueVCj8q8PRwjegXINaoQdEeC8sZWBfZR
        WCKn4VSEZkKwpznLprcK4dM+i1TMkLP2POCtIyJUI0Q5OwBHZkyug+uSq8+HhQ==
Date:   Tue, 24 Oct 2023 15:40:37 +0200
From:   =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Radu Pirea <radu-nicolae.pirea@oss.nxp.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Jonathan Corbet <corbet@lwn.net>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        UNGLinuxDriver@microchip.com, Simon Horman <horms@kernel.org>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH net-next v6 07/16] net_tstamp: Add TIMESTAMPING SOFTWARE
 and HARDWARE mask
Message-ID: <20231024154037.2f61fe5b@kmaincent-XPS-13-7390>
In-Reply-To: <CAF=yD-+O6QxuYJzijMes7J_DHHd7yYCz8sBLFERM1U6pYN0Gkg@mail.gmail.com>
References: <20231019-feature_ptp_netnext-v6-0-71affc27b0e5@bootlin.com>
        <20231019-feature_ptp_netnext-v6-7-71affc27b0e5@bootlin.com>
        <CAF=yD-+O6QxuYJzijMes7J_DHHd7yYCz8sBLFERM1U6pYN0Gkg@mail.gmail.com>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2023 10:48:04 -0400
Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> On Thu, Oct 19, 2023 at 10:29=E2=80=AFAM Kory Maincent
> <kory.maincent@bootlin.com> wrote:
> >
> > Timestamping software or hardware flags are often used as a group,
> > therefore adding these masks will easier future use. =20
>=20
> This assumes that device support for timestamping is often symmetric:
> a device supports both rx and tx, or neither.
>
> All devices support software receive timestamping, as that timestamp
> is taken in the core network stack. But to support transmit timestamps
> drivers have to call sbk_tstamp_tx in their ndo_start_xmit.

Yes, and in that software only case they often call ethtool_op_get_ts_info =
to
fill the timestamp info.

There is several drivers that support hardware and software timestamp, these
mask could be useful for these. In case of asymmetric support we can still =
use
the SOF_TIMESTAMPING_RX/TX_SOFTWARE flags.

I forgot to specify, in the commit message but this patch is mainly to ease
the next patch of this series to deal with software/hardware time stamping.
Maybe you prefer to have this squash into next patch as had suggested Flori=
an
in last version.

K=C3=B6ry
