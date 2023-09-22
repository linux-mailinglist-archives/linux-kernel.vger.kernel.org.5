Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C237AB391
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 16:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbjIVO0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 10:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjIVO0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 10:26:21 -0400
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F129100;
        Fri, 22 Sep 2023 07:26:13 -0700 (PDT)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-7ab8265b797so210754241.2;
        Fri, 22 Sep 2023 07:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695392772; x=1695997572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ZY2KpqDfk+3SZ0Uy/4udXrPF+MUiwa/igff1W+lrSE=;
        b=HThspFnYSF3Z9SV8aVwdCR/qe6hYbw2jB5d/3UbsiOkmUHFxqFotcOkCW4qCJ48oGL
         uW9YE0qQTcZm0oSbeyfNsdQlMLjxBYYlfSUFXidFjgKiL9wHLSp21vZJTLNT1NOkep01
         9kErAU2zte/CPkrPo6K1Q25tK7B1c+MlA+gmyv7VlLKrvAe+CtYQHYd5akfvamIJ5VUS
         zYEvTjNZu+fmaDt9C27xeMn/dqnna43j73XCxKexOK+DKWMYTSFoXBcpxAIXMy2j5R3N
         eXHt3GgT0sKJ8Fmg2hmL3uXgRIcnvLI8yk2fOTKFmFvtyy6xSRLvt5NhcW1B8PSPRWCT
         zrsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695392772; x=1695997572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ZY2KpqDfk+3SZ0Uy/4udXrPF+MUiwa/igff1W+lrSE=;
        b=RbT872m+2oX7LiScUDJb6xyst6ae2gzwzzim3AUAjUOK6GAFJ4yb5gX171WKEUD1aY
         eYUmBKd/0tTrWXXYm/uxh1q5zI9yHKMt6OuLyz3m1ZAoe0+6Z55//KjKZ1cKD4flxP5k
         1y/c2bzYRbkE1KnDC1KIHyK7SDu6uYCKaU2bFVe/11MqYgYQA44JrElrS1/8GCV9hV5o
         3GfcUIEoVyp1yellwunTG4VkrWTi32Cx8nYnBWzYFYGOXJLZiDopmQCdmGJks0+VODNe
         JaryS+JuMKaDH/6+XiFwJnw7X1RyKGv1yGMSsk6Z4ycNxHxU8ZLy3Qdwqb0d7jtJUqAW
         GXSg==
X-Gm-Message-State: AOJu0YwQseM+kYx2BCj4/h67vBVfWchV4+99fQmNivfRAzK0rUsuNZde
        WQJkXDqUyUX9nh4x69bHUCAqU2v3NAImXomHcrM=
X-Google-Smtp-Source: AGHT+IFU5sXF3z0ZC1IZzYuVXgwCkA6BtfDMlQpImfuwUClQ353Sg4b7ZAp/HY0yFEnAjjkFfSathrSaY5zzQ2KUbI4=
X-Received: by 2002:a05:6102:256:b0:450:f5cb:c3ce with SMTP id
 a22-20020a056102025600b00450f5cbc3cemr7925875vsq.17.1695392771378; Fri, 22
 Sep 2023 07:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20230912122201.3752918-1-paweldembicki@gmail.com>
 <20230912122201.3752918-6-paweldembicki@gmail.com> <20230912161709.g34slexfaop6xp7w@skbuf>
In-Reply-To: <20230912161709.g34slexfaop6xp7w@skbuf>
From:   =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date:   Fri, 22 Sep 2023 16:26:00 +0200
Message-ID: <CAJN1Kkwzwt++6GtrAnCbKzYto-uQECYZz5=N7bePqK9wsK2_+g@mail.gmail.com>
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

Hi Vladimir,

wt., 12 wrz 2023 o 18:17 Vladimir Oltean <olteanv@gmail.com> napisa=C5=82(a=
):
>
> On Tue, Sep 12, 2023 at 02:21:59PM +0200, Pawel Dembicki wrote:
> > This patch implements VLAN filtering for the vsc73xx driver.
> >
> > After starting VLAN filtering, the switch is reconfigured from QinQ to
> > a simple VLAN aware mode. This is required because VSC73XX chips do not
> > support inner VLAN tag filtering.
> >
> > Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> > ---
> > v3:
> >   - reworked all vlan commits
> >   - added storage variables for pvid and untagged vlans
> >   - move length extender settings to port setup
> >   - remove vlan table cleaning in wrong places
> >   - note: dev_warn was keept because function 'vsc73xx_vlan_set_untagge=
d'
> >     and 'vsc73xx_vlan_set_pvid' are used later in tag implementation
> > v2:
> >   - no changes done
> >
> >  drivers/net/dsa/vitesse-vsc73xx-core.c | 425 ++++++++++++++++++++++++-
> >  drivers/net/dsa/vitesse-vsc73xx.h      |   2 +
> >  2 files changed, 425 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/v=
itesse-vsc73xx-core.c
> > index 541fbc195df1..d9a6eac1fcce 100644
> > --- a/drivers/net/dsa/vitesse-vsc73xx-core.c
> > +++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
> > @@ -21,14 +21,18 @@
> >  #include <linux/of_mdio.h>
> >  #include <linux/bitops.h>
> >  #include <linux/if_bridge.h>
> > +#include <linux/if_vlan.h>
> >  #include <linux/etherdevice.h>
> >  #include <linux/gpio/consumer.h>
> >  #include <linux/gpio/driver.h>
> > +#include <linux/dsa/8021q.h>
> >  #include <linux/random.h>
> >  #include <net/dsa.h>
> >
> >  #include "vitesse-vsc73xx.h"
> >
> > +#define VSC73XX_IS_CONFIGURED        0x1
> > +
> >  #define VSC73XX_BLOCK_MAC    0x1 /* Subblocks 0-4, 6 (CPU port) */
> >  #define VSC73XX_BLOCK_ANALYZER       0x2 /* Only subblock 0 */
> >  #define VSC73XX_BLOCK_MII    0x3 /* Subblocks 0 and 1 */
> > @@ -61,6 +65,8 @@
> >  #define VSC73XX_CAT_DROP     0x6e
> >  #define VSC73XX_CAT_PR_MISC_L2       0x6f
> >  #define VSC73XX_CAT_PR_USR_PRIO      0x75
> > +#define VSC73XX_CAT_VLAN_MISC        0x79
> > +#define VSC73XX_CAT_PORT_VLAN        0x7a
> >  #define VSC73XX_Q_MISC_CONF  0xdf
> >
> >  /* MAC_CFG register bits */
> > @@ -121,6 +127,17 @@
> >  #define VSC73XX_ADVPORTM_IO_LOOPBACK BIT(1)
> >  #define VSC73XX_ADVPORTM_HOST_LOOPBACK       BIT(0)
> >
> > +/*  TXUPDCFG transmit modify setup bits */
> > +#define VSC73XX_TXUPDCFG_DSCP_REWR_MODE      GENMASK(20, 19)
> > +#define VSC73XX_TXUPDCFG_DSCP_REWR_ENA       BIT(18)
> > +#define VSC73XX_TXUPDCFG_TX_INT_TO_USRPRIO_ENA       BIT(17)
> > +#define VSC73XX_TXUPDCFG_TX_UNTAGGED_VID     GENMASK(15, 4)
> > +#define VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA BIT(3)
> > +#define VSC73XX_TXUPDCFG_TX_UPDATE_CRC_CPU_ENA       BIT(1)
> > +#define VSC73XX_TXUPDCFG_TX_INSERT_TAG       BIT(0)
> > +
> > +#define VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_SHIFT 4
> > +
> >  /* CAT_DROP categorizer frame dropping register bits */
> >  #define VSC73XX_CAT_DROP_DROP_MC_SMAC_ENA    BIT(6)
> >  #define VSC73XX_CAT_DROP_FWD_CTRL_ENA                BIT(4)
> > @@ -134,6 +151,15 @@
> >  #define VSC73XX_Q_MISC_CONF_EARLY_TX_512     (1 << 1)
> >  #define VSC73XX_Q_MISC_CONF_MAC_PAUSE_MODE   BIT(0)
> >
> > +/* CAT_VLAN_MISC categorizer VLAN miscellaneous bits*/
> > +#define VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA BIT(8)
> > +#define VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA BIT(7)
> > +
> > +/* CAT_PORT_VLAN categorizer port VLAN*/
> > +#define VSC73XX_CAT_PORT_VLAN_VLAN_CFI BIT(15)
> > +#define VSC73XX_CAT_PORT_VLAN_VLAN_USR_PRIO GENMASK(14, 12)
> > +#define VSC73XX_CAT_PORT_VLAN_VLAN_VID GENMASK(11, 0)
> > +
> >  /* Frame analyzer block 2 registers */
> >  #define VSC73XX_STORMLIMIT   0x02
> >  #define VSC73XX_ADVLEARN     0x03
> > @@ -188,7 +214,8 @@
> >  #define VSC73XX_VLANACCESS_VLAN_MIRROR               BIT(29)
> >  #define VSC73XX_VLANACCESS_VLAN_SRC_CHECK    BIT(28)
> >  #define VSC73XX_VLANACCESS_VLAN_PORT_MASK    GENMASK(9, 2)
> > -#define VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK GENMASK(2, 0)
> > +#define VSC73XX_VLANACCESS_VLAN_PORT_MASK_SHIFT      2
> > +#define VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK GENMASK(1, 0)
> >  #define VSC73XX_VLANACCESS_VLAN_TBL_CMD_IDLE 0
> >  #define VSC73XX_VLANACCESS_VLAN_TBL_CMD_READ_ENTRY   1
> >  #define VSC73XX_VLANACCESS_VLAN_TBL_CMD_WRITE_ENTRY  2
> > @@ -343,6 +370,11 @@ static const struct vsc73xx_counter vsc73xx_tx_cou=
nters[] =3D {
> >       { 29, "TxQoSClass3" }, /* non-standard counter */
> >  };
> >
> > +enum vsc73xx_port_vlan_conf {
> > +     VSC73XX_VLAN_FILTER,
> > +     VSC73XX_VLAN_IGNORE,
> > +};
> > +
> >  int vsc73xx_is_addr_valid(u8 block, u8 subblock)
> >  {
> >       switch (block) {
> > @@ -563,7 +595,7 @@ static enum dsa_tag_protocol vsc73xx_get_tag_protoc=
ol(struct dsa_switch *ds,
> >  static int vsc73xx_setup(struct dsa_switch *ds)
> >  {
> >       struct vsc73xx *vsc =3D ds->priv;
> > -     int i;
> > +     int i, ret;
>
> ../drivers/net/dsa/vitesse-vsc73xx-core.c:598:9: warning: unused variable=
 'ret' [-Wunused-variable]
>         int i, ret;
>                ^
>
> >
> >       dev_info(vsc->dev, "set up the switch\n");
> >
> > @@ -623,6 +655,9 @@ static int vsc73xx_setup(struct dsa_switch *ds)
> >       vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GMIIDELAY,
> >                     VSC73XX_GMIIDELAY_GMII0_GTXDELAY_2_0_NS |
> >                     VSC73XX_GMIIDELAY_GMII0_RXDELAY_2_0_NS);
> > +     /* Ingess VLAN reception mask (table 145) */
> > +     vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANMASK,
> > +                   0x5f);
> >       /* IP multicast flood mask (table 144) */
> >       vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_IFLODMSK,
> >                     0xff);
> > @@ -1031,8 +1066,387 @@ static int vsc73xx_get_max_mtu(struct dsa_switc=
h *ds, int port)
> >       return 9600 - ETH_HLEN - ETH_FCS_LEN;
> >  }
> >
> > +static int vsc73xx_wait_for_vlan_table_cmd(struct vsc73xx *vsc)
> > +{
> > +     int ret, err;
> > +     u32 val;
> > +
> > +     ret =3D read_poll_timeout(vsc73xx_read, err,
> > +                             err < 0 || ((val & VSC73XX_VLANACCESS_VLA=
N_TBL_CMD_MASK) =3D=3D
> > +                                         VSC73XX_VLANACCESS_VLAN_TBL_C=
MD_IDLE),
> > +                             1000, 10000, false, vsc, VSC73XX_BLOCK_AN=
ALYZER,
> > +                             0, VSC73XX_VLANACCESS, &val);
> > +     if (ret)
> > +             return ret;
> > +     return err;
> > +}
> > +
> > +static int
> > +vsc73xx_read_vlan_table_entry(struct vsc73xx *vsc, u16 vid, u8 *portma=
p)
> > +{
> > +     u32 val;
> > +     int ret;
> > +
> > +     vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANTIDX, v=
id);
> > +     ret =3D vsc73xx_wait_for_vlan_table_cmd(vsc);
> > +     if (ret)
> > +             return ret;
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANA=
CCESS,
> > +                         VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK,
> > +                         VSC73XX_VLANACCESS_VLAN_TBL_CMD_READ_ENTRY);
> > +     ret =3D vsc73xx_wait_for_vlan_table_cmd(vsc);
> > +     if (ret)
> > +             return ret;
> > +     vsc73xx_read(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANACCESS, =
&val);
> > +     *portmap =3D (val & VSC73XX_VLANACCESS_VLAN_PORT_MASK) >>
> > +                VSC73XX_VLANACCESS_VLAN_PORT_MASK_SHIFT;
> > +     return 0;
> > +}
> > +
> > +static int
> > +vsc73xx_write_vlan_table_entry(struct vsc73xx *vsc, u16 vid, u8 portma=
p)
> > +{
> > +     int ret;
> > +
> > +     vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANTIDX, v=
id);
> > +     ret =3D vsc73xx_wait_for_vlan_table_cmd(vsc);
> > +     if (ret)
> > +             return ret;
> > +
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANA=
CCESS,
> > +                         VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK |
> > +                         VSC73XX_VLANACCESS_VLAN_SRC_CHECK |
> > +                         VSC73XX_VLANACCESS_VLAN_PORT_MASK,
> > +                         VSC73XX_VLANACCESS_VLAN_TBL_CMD_WRITE_ENTRY |
> > +                         VSC73XX_VLANACCESS_VLAN_SRC_CHECK |
> > +                         (portmap <<
> > +                          VSC73XX_VLANACCESS_VLAN_PORT_MASK_SHIFT));
> > +
> > +     return vsc73xx_wait_for_vlan_table_cmd(vsc);
> > +}
> > +
> > +static int
> > +vsc73xx_update_vlan_table(struct vsc73xx *vsc, int port, u16 vid, bool=
 set)
> > +{
> > +     u8 portmap;
> > +     int ret;
> > +
> > +     ret =3D vsc73xx_read_vlan_table_entry(vsc, vid, &portmap);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (set)
> > +             portmap |=3D BIT(port) | BIT(CPU_PORT);
> > +     else
> > +             portmap &=3D ~BIT(port);
> > +
> > +     if (portmap =3D=3D BIT(CPU_PORT))
> > +             portmap =3D 0;
>
> Why did you need to do this? To my knowledge, the DSA framework code
> will decide when to remove VLANs from the CPU port.
>

I will fix it.

> > +
> > +     return  vsc73xx_write_vlan_table_entry(vsc, vid, portmap);
> > +}
> > +
> > +static void
> > +vsc73xx_set_vlan_conf(struct vsc73xx *vsc, int port,
> > +                   enum vsc73xx_port_vlan_conf port_vlan_conf)
> > +{
> > +     if (port_vlan_conf =3D=3D VSC73XX_VLAN_IGNORE) {
> > +             vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> > +                                 VSC73XX_CAT_VLAN_MISC,
> > +                                 VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE=
_ENA,
> > +                                 VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE=
_ENA);
>
> IMO this, and all the other places that write the same registers from 2
> branches, would look less clutered like this:
>
>         u32 val;
>
>         val =3D (port_vlan_conf =3D=3D VSC73XX_VLAN_IGNORE) ?
>               VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA : 0;
>
>         vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_VLA=
N_MISC,
>                             VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA, val)=
;
>
>         val =3D ...
>
> Otherwise, the larger the branches become, the harder it gets to see
> what's common and what's different.
>
> > +             vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> > +                                 VSC73XX_CAT_VLAN_MISC,
> > +                                 VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_E=
NA,
> > +                                 VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_E=
NA);
> > +             vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> > +                                 VSC73XX_TXUPDCFG,
> > +                                 VSC73XX_TXUPDCFG_TX_INSERT_TAG, 0);
> > +     } else {
> > +             vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> > +                                 VSC73XX_CAT_VLAN_MISC,
> > +                                 VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE=
_ENA,
> > +                                 0);
> > +             vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> > +                                 VSC73XX_CAT_VLAN_MISC,
> > +                                 VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_E=
NA, 0);
> > +             vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
> > +                                 VSC73XX_TXUPDCFG,
> > +                                 VSC73XX_TXUPDCFG_TX_INSERT_TAG,
> > +                                 VSC73XX_TXUPDCFG_TX_INSERT_TAG);
> > +     }
> > +}
> > +
> > +static int
> > +vsc73xx_vlan_change_untagged(struct vsc73xx *vsc, int port, u16 vid, b=
ool set)
> > +{
> > +     u32 val =3D set ? VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA : 0;
> > +
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCF=
G,
> > +                         VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA, val);
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCF=
G,
> > +                         VSC73XX_TXUPDCFG_TX_UNTAGGED_VID,
> > +                         (vid << VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_SHIF=
T) &
> > +                          VSC73XX_TXUPDCFG_TX_UNTAGGED_VID);
> > +     return 0;
> > +}
> > +
> > +static int
> > +vsc73xx_vlan_change_pvid(struct vsc73xx *vsc, int port, u16 vid, bool =
set)
>
> Would it simplify callers to add a "bool operate_on_storage" argument her=
e,
> and absorb that logic? The callers could look like this, notice how there=
 is
> less code duplication between the "if" and "else" branches.
>

I will rework it.

> static int vsc73xx_vlan_set_pvid(struct dsa_switch *ds, int port, u16 vid=
,
>                                  bool tag_8021q_vlan)
> {
>         struct dsa_port *dp =3D dsa_to_port(ds, port);
>         struct vsc73xx *vsc =3D ds->priv;
>         bool operate_on_storage;
>         u16 existing_pvid;
>         bool had_pvid;
>
>         operate_on_storage =3D vsc73xx_tag_8021q_active(dp) ^ tag_8021q_v=
lan;
>
>         had_pvid =3D vsc73xx_port_get_pvid(vsc, port, &existing_pvid,
>                                          &operate_on_storage);
>         if (had_pvid && existing_pvid !=3D vid) {
>                 dev_warn(vsc->dev,
>                          "Port %d can have only one pvid! Now is: %d.\n",
>                          port, existing_pvid);
>                 return -EOPNOTSUPP;
>         }
>
>         return vsc73xx_vlan_change_pvid(vsc, port, vid, true, operate_on_=
storage);
> }
>
> > +{
> > +     u32 val =3D set ? 0 : VSC73XX_CAT_DROP_UNTAGGED_ENA;
> > +
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_DRO=
P,
> > +                         VSC73XX_CAT_DROP_UNTAGGED_ENA, val);
> > +
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_POR=
T_VLAN,
> > +                         VSC73XX_CAT_PORT_VLAN_VLAN_VID,
> > +                         vid & VSC73XX_CAT_PORT_VLAN_VLAN_VID);
> > +     return 0;
> > +}
> > +
> > +static int vsc73xx_vlan_port_is_pvid(struct vsc73xx *vsc, int port, u1=
6 *vid)
>
> I believe it would look better if this would return bool, and if it had
> a shorter name (vsc73xx_port_get_pvid).
>
> > +{
> > +     u32 val;
> > +
> > +     vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_DROP, &val=
);
> > +     if (val & VSC73XX_CAT_DROP_UNTAGGED_ENA)
> > +             return 0;
> > +
> > +     vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_PORT_VLAN,=
 &val);
> > +     *vid =3D val & VSC73XX_CAT_PORT_VLAN_VLAN_VID;
> > +
> > +     return VSC73XX_IS_CONFIGURED;
> > +}
> > +
> > +static int vsc73xx_vlan_port_is_untagged(struct vsc73xx *vsc, int port=
, u16 *vid)
> > +{
> > +     u32 val;
> > +
> > +     vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCFG, &val=
);
> > +     if (!(val & VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA))
> > +             return 0;
> > +
> > +     vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCFG,
> > +                  &val);
>
> Don't need to read the same register twice.
>
> > +     *vid =3D (val & VSC73XX_TXUPDCFG_TX_UNTAGGED_VID) >>
> > +             VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_SHIFT;
> > +
> > +     return VSC73XX_IS_CONFIGURED;
> > +}
> > +
> > +static int vsc73xx_vlan_set_untagged(struct dsa_switch *ds, int port, =
u16 vid,
> > +                                  bool port_vlan)
> > +{
> > +     struct vsc73xx *vsc =3D ds->priv;
> > +     u16 vlan_no =3D 0;
> > +
> > +     if (dsa_port_is_vlan_filtering(dsa_to_port(ds, port)) ^ port_vlan=
) {
>
> I think it would be valuable for readability to create a helper function =
named:
>
> static bool vsc73xx_tag_8021q_active(struct dsa_port *dp)
> {
>         return !dsa_port_is_vlan_filtering(dp);
> }
>
> and then, to rename "port_vlan" to "!tag_8021q_vlan". It would make it
> clearer as to what the checks are about.
>
>         if (vsc73xx_tag_8021q_active(dp) ^ tag_8021q_vlan) {
>                 // update cached storage
>         } else {
>                 // update hardware
>         }
>
> > +             if (vsc->untagged_storage[port] < VLAN_N_VID &&
> > +                 !vid_is_dsa_8021q(vsc->untagged_storage[port]) &&
> > +                 !vid_is_dsa_8021q(vid) &&
>
> The problem here which led to these vid_is_dsa_8021q() checks is that
> dsa_switch_tag_8021q_vlan_add() sets all flags on user ports to
> BRIDGE_VLAN_INFO_UNTAGGED | BRIDGE_VLAN_INFO_PVID, and you can't offload
> those, correct?

In my case, the major problem with tag8021q vlans is
"dsa_tag_8021q_bridge_join" function:
"dsa_port_tag_8021q_vlan_add" is called before "dsa_port_tag_8021q_vlan_del=
".
I must disable pvid/untagged checking, because it will always fail. I
let kernel do the job,
it keeps only one untagged/pvid per port after "dsa_tag_8021q_bridge_join".

> But when the port is VSC73XX_VLAN_IGNORE mode (and
> tag_8021q is active), VSC73XX_TXUPDCFG_TX_INSERT_TAG is 0, and thus,
> *all* VLANs are egress-untagged VLANs, correct?
>
> If that is the case, why do you call vsc73xx_vlan_set_untagged() in the
> first place, for tag_8021q VLANs, if you don't rely on the port's native
> VLAN for egress untagging?
>
> > +                 vsc->untagged_storage[port] !=3D vid) {
> > +                     dev_warn(vsc->dev,
> > +                              "Port %d can have only one untagged vid!=
 Now is: %d.\n",
> > +                              port, vsc->untagged_storage[port]);
> > +                     return -EOPNOTSUPP;
> > +             }
> > +             vsc->untagged_storage[port] =3D vid;
> > +     } else {
> > +             if (vsc73xx_vlan_port_is_untagged(vsc, port, &vlan_no) =
=3D=3D VSC73XX_IS_CONFIGURED &&
> > +                 !vid_is_dsa_8021q(vlan_no) && !vid_is_dsa_8021q(vid) =
&& vlan_no !=3D vid) {
> > +                     dev_warn(vsc->dev,
> > +                              "Port %d can have only one untagged vid!=
 Now is: %d.\n",
> > +                              port, vlan_no);
> > +                     return -EOPNOTSUPP;
> > +             }
> > +             return vsc73xx_vlan_change_untagged(vsc, port, vid, 1);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int vsc73xx_vlan_set_pvid(struct dsa_switch *ds, int port, u16 =
vid,
> > +                              bool port_vlan)
> > +{
> > +     struct dsa_port *dsa_port =3D dsa_to_port(ds, port);
> > +     struct vsc73xx *vsc =3D ds->priv;
> > +     u16 vlan_no;
> > +
> > +     if (!dsa_port)
> > +             return -EINVAL;
>
> Why is this check here?
>

Unnecessary defensive programming.

> > +
> > +     if (dsa_port_is_vlan_filtering(dsa_port) ^ port_vlan) {
> > +             if (vsc->pvid_storage[port] < VLAN_N_VID &&
> > +                 !vid_is_dsa_8021q(vsc->pvid_storage[port]) &&
> > +                 !vid_is_dsa_8021q(vid) && vsc->pvid_storage[port] !=
=3D vid) {
>
> What are the vid_is_dsa_8021q() checks for?

The same reason as the "untagged" case.

>
> > +                     dev_warn(vsc->dev,
> > +                              "Port %d can have only one pvid! Now is:=
 %d.\n",
> > +                              port, vsc->pvid_storage[port]);
> > +                     return -EOPNOTSUPP;
> > +             }
> > +             vsc->pvid_storage[port] =3D vid;
> > +     } else {
> > +             if (vsc73xx_vlan_port_is_pvid(vsc, port, &vlan_no) =3D=3D=
 VSC73XX_IS_CONFIGURED &&
> > +                 !vid_is_dsa_8021q(vlan_no) && !vid_is_dsa_8021q(vid) =
&&
> > +                 vlan_no !=3D vid) {
> > +                     dev_warn(vsc->dev,
> > +                              "Port %d can have only one pvid! Now is:=
 %d.\n",
> > +                              port, vlan_no);
> > +                     return -EOPNOTSUPP;
> > +             }
> > +             return vsc73xx_vlan_change_pvid(vsc, port, vid, 1);
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> > +static int
> > +vsc73xx_port_vlan_filtering(struct dsa_switch *ds, int port,
> > +                         bool vlan_filtering, struct netlink_ext_ack *=
extack)
>
> A comment would be good which states that the flipping between the
> hardware and the storage values relies on the fact that vsc73xx_port_vlan=
_filtering()
> only gets called on actual changes to vlan_filtering, and thus, to
> vsc73xx_tag_8021q_active(). So, we know for sure that what is in storage
> needs to go to hardware, and what is in hardware needs to go to storage.
>
> It's an interesting implementation for sure.
>

Thank you.

> > +{
> > +     struct vsc73xx *vsc =3D ds->priv;
> > +     bool store_untagged  =3D false;
> > +     bool store_pvid  =3D false;
>
> nit: replace the 2 spaces before the "=3D" with a single one.
>
> > +     u16 vlan_no;
> > +
> > +     if (vlan_filtering)
> > +             vsc73xx_set_vlan_conf(vsc, port, VSC73XX_VLAN_FILTER);
> > +     else
> > +             vsc73xx_set_vlan_conf(vsc, port, VSC73XX_VLAN_IGNORE);
> > +
> > +     if (vsc73xx_vlan_port_is_pvid(vsc, port, &vlan_no) =3D=3D VSC73XX=
_IS_CONFIGURED)
> > +             store_pvid =3D true;
> > +
> > +     if (vsc->pvid_storage[port] < VLAN_N_VID)
> > +             vsc73xx_vlan_change_pvid(vsc, port, vsc->pvid_storage[por=
t], true);
> > +     else
> > +             vsc73xx_vlan_change_pvid(vsc, port, 0, false);
> > +
> > +     vsc->pvid_storage[port] =3D store_pvid ? vlan_no : VLAN_N_VID;
> > +
> > +     if (vsc73xx_vlan_port_is_untagged(vsc, port, &vlan_no) =3D=3D VSC=
73XX_IS_CONFIGURED)
> > +             store_untagged  =3D true;
> > +
> > +     if (vsc->untagged_storage[port] < VLAN_N_VID)
> > +             vsc73xx_vlan_change_untagged(vsc, port, vsc->untagged_sto=
rage[port], true);
> > +     else
> > +             vsc73xx_vlan_change_untagged(vsc, port, 0, false);
> > +
> > +     vsc->untagged_storage[port] =3D store_untagged ? vlan_no : VLAN_N=
_VID;
> > +
> > +     return 0;
> > +}
> > +
> > +static int vsc73xx_port_vlan_add(struct dsa_switch *ds, int port,
> > +                              const struct switchdev_obj_port_vlan *vl=
an,
> > +                              struct netlink_ext_ack *extack)
> > +{
> > +     bool untagged =3D vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
> > +     bool pvid =3D vlan->flags & BRIDGE_VLAN_INFO_PVID;
> > +     struct vsc73xx *vsc =3D ds->priv;
> > +     u16 vlan_no;
> > +     int ret;
> > +
> > +     /* Be sure to deny alterations to the configuration done by tag_8=
021q.
> > +      */
> > +     if (vid_is_dsa_8021q(vlan->vid)) {
> > +             NL_SET_ERR_MSG_MOD(extack,
> > +                                "Range 3072-4095 reserved for dsa_8021=
q operation");
> > +             return -EBUSY;
> > +     }
> > +
> > +     if (port !=3D CPU_PORT) {
> > +             if (untagged) {
> > +                     ret =3D vsc73xx_vlan_set_untagged(ds, port, vlan-=
>vid, true);
> > +                     if (ret)
> > +                             return ret;
> > +             } else {
> > +                     if (vsc73xx_vlan_port_is_untagged(vsc, port, &vla=
n_no)
> > +                         =3D=3D VSC73XX_IS_CONFIGURED &&
> > +                         vlan_no =3D=3D vlan->vid)
> > +                             vsc73xx_vlan_change_untagged(vsc, port, 0=
, false);
> > +                     else if (vsc->untagged_storage[port] =3D=3D vlan-=
>vid)
> > +                             vsc->untagged_storage[port] =3D VLAN_N_VI=
D;
> > +             }
> > +             if (pvid) {
> > +                     ret =3D vsc73xx_vlan_set_pvid(ds, port, vlan->vid=
, true);
> > +                     if (ret)
> > +                             return ret;
> > +             } else {
> > +                     if (vsc73xx_vlan_port_is_pvid(vsc, port, &vlan_no=
)
> > +                         =3D=3D VSC73XX_IS_CONFIGURED &&
> > +                         vlan_no =3D=3D vlan->vid)
> > +                             vsc73xx_vlan_change_pvid(vsc, port, 0, fa=
lse);
> > +                     else if (vsc->pvid_storage[port] =3D=3D vlan->vid=
)
> > +                             vsc->pvid_storage[port] =3D VLAN_N_VID;
> > +             }
> > +     }
> > +
> > +     return vsc73xx_update_vlan_table(vsc, port, vlan->vid, 1);
>
> last argument is bool, so pass true or false (here and everywhere else)
>
> > +}
> > +
> > +static int vsc73xx_port_vlan_del(struct dsa_switch *ds, int port,
> > +                              const struct switchdev_obj_port_vlan *vl=
an)
> > +{
> > +     struct vsc73xx *vsc =3D ds->priv;
> > +     u16 vlan_no;
> > +     int ret;
> > +
> > +     ret =3D vsc73xx_update_vlan_table(vsc, port, vlan->vid, 0);
> > +     if (ret)
> > +             return ret;
> > +
> > +     if (vsc73xx_vlan_port_is_untagged(vsc, port, &vlan_no) =3D=3D VSC=
73XX_IS_CONFIGURED &&
> > +         vlan_no =3D=3D vlan->vid)
> > +             vsc73xx_vlan_change_untagged(vsc, port, 0, false);
> > +     else if (vsc->untagged_storage[port] =3D=3D vlan->vid)
> > +             vsc->untagged_storage[port] =3D VLAN_N_VID;
> > +
> > +     if (vsc73xx_vlan_port_is_pvid(vsc, port, &vlan_no) =3D=3D VSC73XX=
_IS_CONFIGURED &&
> > +         vlan_no =3D=3D vlan->vid)
> > +             vsc73xx_vlan_change_pvid(vsc, port, 0, false);
> > +     else if (vsc->pvid_storage[port] =3D=3D vlan->vid)
> > +             vsc->pvid_storage[port] =3D VLAN_N_VID;
> > +
> > +     return 0;
> > +}
> > +
> >  static int vsc73xx_port_setup(struct dsa_switch *ds, int port)
> >  {
> > +     struct vsc73xx *vsc =3D ds->priv;
> > +     int ret, i;
> > +
> > +     /* Those bits are responsible for MTU only. Kernel take care abou=
t MTU,
> > +      * let's enable +8 bytes frame length unconditionally.
> > +      */
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MAC_CFG=
,
> > +                         VSC73XX_MAC_CFG_VLAN_AWR | VSC73XX_MAC_CFG_VL=
AN_DBLAWR,
> > +                         VSC73XX_MAC_CFG_VLAN_AWR | VSC73XX_MAC_CFG_VL=
AN_DBLAWR);
> > +
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_DRO=
P,
> > +                         VSC73XX_CAT_DROP_TAGGED_ENA, 0);
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_DRO=
P,
> > +                         VSC73XX_CAT_DROP_UNTAGGED_ENA,
> > +                         VSC73XX_CAT_DROP_UNTAGGED_ENA);
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCF=
G,
> > +                         VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA, 0);
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCF=
G,
> > +                         VSC73XX_TXUPDCFG_TX_UNTAGGED_VID, 0);
> > +     vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_POR=
T_VLAN,
> > +                         VSC73XX_CAT_PORT_VLAN_VLAN_VID, 0);
> > +
> > +     if (port =3D=3D CPU_PORT)
> > +             vsc73xx_set_vlan_conf(vsc, port, VSC73XX_VLAN_FILTER);
> > +     else
> > +             vsc73xx_set_vlan_conf(vsc, port, VSC73XX_VLAN_IGNORE);
> > +
> > +     for (i =3D 0; i <=3D VLAN_N_VID; i++) {
>
> VLAN_N_VID is 4096, so i <=3D VLAN_N_VID must be a mistake?
>

Yeep.

> > +             ret =3D vsc73xx_update_vlan_table(vsc, port, i, 0);
> > +             if (ret)
> > +                     return ret;
> > +     }
>
> Also, could you write an expedited version of this, which is not called
> from ds->ops->port_setup() but from ds->ops->setup()? It is wasteful to
> traverse the VLAN table for each port, when we know from the get go that
> we need to clear all ports.
>

I'll rework it in setup.

> > +
> >       /* Configure forward map to CPU <-> port only */
> >       if (port =3D=3D CPU_PORT)
> >               vsc->forward_map[CPU_PORT] =3D VSC73XX_SRCMASKS_PORTS_MAS=
K &
> > @@ -1041,6 +1455,10 @@ static int vsc73xx_port_setup(struct dsa_switch =
*ds, int port)
> >               vsc->forward_map[port] =3D VSC73XX_SRCMASKS_PORTS_MASK &
> >                                        BIT(CPU_PORT);
> >
> > +     /* Set storage values out of range*/
>
> Nit: Space after "*/" (there are a few other places left which have
> this style issue)
>
> > +     vsc->pvid_storage[port] =3D VLAN_N_VID;
> > +     vsc->untagged_storage[port] =3D VLAN_N_VID;
> > +
> >       return 0;
> >  }
> >
> > @@ -1098,6 +1516,9 @@ static const struct dsa_switch_ops vsc73xx_ds_ops=
 =3D {
> >       .port_change_mtu =3D vsc73xx_change_mtu,
> >       .port_max_mtu =3D vsc73xx_get_max_mtu,
> >       .port_stp_state_set =3D vsc73xx_port_stp_state_set,
> > +     .port_vlan_filtering =3D vsc73xx_port_vlan_filtering,
> > +     .port_vlan_add =3D vsc73xx_port_vlan_add,
> > +     .port_vlan_del =3D vsc73xx_port_vlan_del,
> >  };
> >
> >  static int vsc73xx_gpio_get(struct gpio_chip *chip, unsigned int offse=
t)
> > diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitess=
e-vsc73xx.h
> > index 224e284a5573..b7614dd7d0eb 100644
> > --- a/drivers/net/dsa/vitesse-vsc73xx.h
> > +++ b/drivers/net/dsa/vitesse-vsc73xx.h
> > @@ -30,6 +30,8 @@ struct vsc73xx {
> >       const struct vsc73xx_ops        *ops;
> >       void                            *priv;
> >       u8                              forward_map[VSC73XX_MAX_NUM_PORTS=
];
> > +     u16                             pvid_storage[VSC73XX_MAX_NUM_PORT=
S];
> > +     u16                             untagged_storage[VSC73XX_MAX_NUM_=
PORTS];
> >  };
> >
> >  struct vsc73xx_ops {
> > --
> > 2.34.1
> >
>
