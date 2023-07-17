Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF67755907
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 03:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjGQBWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 21:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjGQBWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 21:22:36 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6D8198;
        Sun, 16 Jul 2023 18:22:35 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-55be1ce1669so2461493a12.1;
        Sun, 16 Jul 2023 18:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689556954; x=1692148954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/xsec41khvstwojfKKnVijK7VZDVczRFwtjYPna4+YI=;
        b=m8bLTGJauMxUKVyDpIlaNkk99Hkb+YrGDvRf063B3eaNisyPDM8bt6nLngAqrdQW/a
         H6rH90DitEebLR89aw3P0xUCS48+ZsoDiVbhp6qGW6m3rKskw3hPXlZrt9wXeKYDQuDE
         BWLuQBMxMRANjydYyzmV0JZhatFgmidRIqZ98uZkaKVxXGqUTGFZh/VNQxzmkEj5pkxp
         qU9wvNtbGaDeiMLQMkyUpbRqjfj+gAJ9VT4sRERXhbqG5hzGrj/ASHtamDQDRS0P+ZVO
         93d33GWxNzrdl34anhtasl2t0lwjTYRFW/VYtdWqwIeoPsMEqLyHbZbcbLJzmuUCz6iG
         mAxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689556954; x=1692148954;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/xsec41khvstwojfKKnVijK7VZDVczRFwtjYPna4+YI=;
        b=HXqpI9lFKGGKjgqx/fhAbLZASlSzZ6iEAkftCGxfEsXK6NgSbMgJO6zqXoboVUruX5
         ly2f/Z+EuaurNpb5kl2RM5/2+7z1N4VfBqbBly1sMUzMHYlc+M7lDeNhCBWlxSi4+OVI
         S/2nQDVoHU8VATFWMUOYv23nTnEdZwOMeY7Mt6sMFikZjOyQo1N+WrNHwOqfvbW1ZN0Y
         qZksMT0tm91AeLJhvPtfdbWDNub48j3ZhpDWd1TbxFNdPlKMYgoW3UKATZqjhQQm6GPD
         QAiyqoh3HyqJ3MKcUola7nJYbZjxCF4DkxbyV5rz+nLGybGyqTg//GAFQK8/GRxFlIXu
         tEdA==
X-Gm-Message-State: ABy/qLbPDJ/6Y/CG5ARg5xOc21AFHhzO4dwxqE5u7L8Tkwl7saA2y7HQ
        VEXD53ZJEtw8/jV8Snn2Dmlb8PytMttPnSwOJWs=
X-Google-Smtp-Source: APBJJlFBLBkMzZlok4fsVOd1z8wIHlUwkUujopGLFLaW/brvPbCpRt3b/nI8OIcQ4vuAxSexPbDmnZo7X3+ViZnYZf4=
X-Received: by 2002:a17:90a:fa16:b0:263:1af0:5541 with SMTP id
 cm22-20020a17090afa1600b002631af05541mr9985566pjb.32.1689556954509; Sun, 16
 Jul 2023 18:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230713121907.3249291-1-vladimir.oltean@nxp.com>
In-Reply-To: <20230713121907.3249291-1-vladimir.oltean@nxp.com>
From:   Max Georgiev <glipus@gmail.com>
Date:   Sun, 16 Jul 2023 19:22:23 -0600
Message-ID: <CAP5jrPFbt7vc77wVi5buYM88gDQ-OCHzm3Hg=EzRxJiha7Ur5A@mail.gmail.com>
Subject: Re: [PATCH v7 net-next 00/10] Introduce ndo_hwtstamp_get() and ndo_hwtstamp_set()
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        Wei Fang <wei.fang@nxp.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        UNGLinuxDriver@microchip.com,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        Simon Horman <simon.horman@corigine.com>,
        Casper Andersson <casper.casan@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 6:19=E2=80=AFAM Vladimir Oltean <vladimir.oltean@nx=
p.com> wrote:
>
> Based on previous RFCs from Maxim Georgiev:
> https://lore.kernel.org/netdev/20230502043150.17097-1-glipus@gmail.com/
>
> this series attempts to introduce new API for the hardware timestamping
> control path (SIOCGHWTSTAMP and SIOCSHWTSTAMP handling).
>
> I don't have any board with phylib hardware timestamping, so I would
> appreciate testing (especially on lan966x, the most intricate
> conversion). I was, however, able to test netdev level timestamping,
> because I also have some more unsubmitted conversions in progress:
>
> https://github.com/vladimiroltean/linux/commits/ndo-hwtstamp-v7
>
> I hope that the concerns expressed in the comments of previous series
> were addressed, and that K=C3=B6ry Maincent's series:
> https://lore.kernel.org/netdev/20230406173308.401924-1-kory.maincent@boot=
lin.com/
> can make progress in parallel with the conversion of the rest of drivers.
>
> Maxim Georgiev (5):
>   net: add NDOs for configuring hardware timestamping
>   net: add hwtstamping helpers for stackable net devices
>   net: vlan: convert to ndo_hwtstamp_get() / ndo_hwtstamp_set()
>   net: macvlan: convert to ndo_hwtstamp_get() / ndo_hwtstamp_set()
>   net: bonding: convert to ndo_hwtstamp_get() / ndo_hwtstamp_set()
>
> Vladimir Oltean (5):
>   net: fec: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
>   net: fec: delete fec_ptp_disable_hwts()
>   net: sparx5: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
>   net: lan966x: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
>   net: remove phy_has_hwtstamp() -> phy_mii_ioctl() decision from
>     converted drivers
>
>  drivers/net/bonding/bond_main.c               | 105 ++++++----
>  drivers/net/ethernet/freescale/fec.h          |   6 +-
>  drivers/net/ethernet/freescale/fec_main.c     |  41 ++--
>  drivers/net/ethernet/freescale/fec_ptp.c      |  43 ++--
>  .../ethernet/microchip/lan966x/lan966x_main.c |  61 ++++--
>  .../ethernet/microchip/lan966x/lan966x_main.h |  12 +-
>  .../ethernet/microchip/lan966x/lan966x_ptp.c  |  34 ++--
>  .../ethernet/microchip/sparx5/sparx5_main.h   |   9 +-
>  .../ethernet/microchip/sparx5/sparx5_netdev.c |  35 +++-
>  .../ethernet/microchip/sparx5/sparx5_ptp.c    |  24 ++-
>  drivers/net/macvlan.c                         |  34 ++--
>  include/linux/net_tstamp.h                    |  28 +++
>  include/linux/netdevice.h                     |  25 +++
>  net/8021q/vlan_dev.c                          |  27 ++-
>  net/core/dev_ioctl.c                          | 183 +++++++++++++++++-
>  15 files changed, 480 insertions(+), 187 deletions(-)
>
> --
> 2.34.1
>

Vladimir, thank you for taking over and improving this patch stack!

I see you dropped the netdevsim patch:
https://www.spinics.net/lists/netdev/msg901378.html
Do you believe it's not useful any more since the rest of the
patches in the stack were tested through other means?
