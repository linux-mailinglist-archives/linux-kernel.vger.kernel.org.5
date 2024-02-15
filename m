Return-Path: <linux-kernel+bounces-67395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B22C856ADB
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF54B1C239D4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44C3E136995;
	Thu, 15 Feb 2024 17:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnOLa6v4"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E000E1339B2;
	Thu, 15 Feb 2024 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708017748; cv=none; b=YzzKEVOgwgM+WknTJofBDFw7e3ojycsRNtJuLnBrvN1LqNQASAjQivbZK/5JH2uvPmTqO1cxwlh75sPDfc6o78Z3wXQ3mGd6yny9I0swyfp7iQ/3ArWSbszPP6bEmZxsADR7ghP4KK7MWYQb6TUgnMwWJFpKiwK9VsOHyuG89tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708017748; c=relaxed/simple;
	bh=ukZFXVc6S0qbrAoAMv3KS8PeJLZfGw+D1iK0TtOTnvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cEv6RE00KCXXS5npiw2yl75YTZ+UGvZD+iUJzPAuph3oBLciYUa1HNpnrb4isfFiywEs23eVr8jhCkPgFtcz8W7N8+Bsj6q+pUP195KUj/9qXm/u8aS5IqwIBG1iJak7MQQkGQ+dYQvswhzC9U5jW/eqtJ7rIZ20qJdCLekuuT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CnOLa6v4; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5118d65cf9cso1414822e87.0;
        Thu, 15 Feb 2024 09:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708017744; x=1708622544; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b0LYqUpovxsGdXAUHh/jkK3Btsg/T77vW+o0kwFE/Rk=;
        b=CnOLa6v4T6SZaksWJ4xnW+ehFI643wIEeUTN9uLbm+96x1G6/a/Ryxwk5RXfc69/nn
         38DtsEd4OLWY2BVYuaTZtkpKCSTK3zvwMExc18MbWkTOAhU9M8mOZ4/TQC/lTxb7wnWb
         bqkGlXpTxrIsGpOFwGe12bWX3AL46i9w58Ys3+BYMLoUsCjGplP0sAtDe2RCSi05q3h/
         G7nmKLOyMZvpmJfKCHcTbrvhObaaN53UncQIrGpPzYUx6urhU+f/HsAwcnrr3TNc0zwI
         Vmf1K5G9s47Gh3Q3pC84I34GG/jE1iKatrtStJRaABjQXml/1Ks5TUdVPZgWv6FamTsN
         knkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708017744; x=1708622544;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0LYqUpovxsGdXAUHh/jkK3Btsg/T77vW+o0kwFE/Rk=;
        b=ErEdeeZWZPakDXYOWX30CXPVMLqWII9VttcuZDFtIjz9dR9asCfOko3FafDA9s6Yj0
         hsI3iWW8GRNSFd0sKyTjymDFiYr4v6l4rxxLC0v+w5yzrxwe6OhqJw8ymp3JuDd7m/M3
         YxIUBDfCc3CPg9EWCkIWCwUI0J35wegDZ0NRZkPk67BJ8EbqxQt+lV5nZmZJrT4+REXM
         0+ZntW5ldoqZZN8f83pA1g+Kx+Pg01JbH/cIvkf9hXB+DhriuaTMqElzCIXAswoJg2aG
         0p0/8/yHlgp9P0eLVnX/fFvBLeXLAD1WS6lP4xdChD5ZjSN0UQcBXjLITlVn8hJ1TdSZ
         DuBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUqh8yiKDnhDy3AJESmaoRwfDZ3rJ/u77mtWygakl3dya9AKLDKRaemuFNnPefe9yoJNJIWfOEFy3o7Byc0VSdI7BhuGbK/nW8HzOx
X-Gm-Message-State: AOJu0YxbYdptlVOg8gXiYK4QSW7XSJLDiHPCl+jsEk0sUN9i/spEaSTP
	lwOE5zEMER4ZyvxML9vadQ+drdBDL65GzS06wwz9r9KH2KtkYW8c44nv9l29ztY=
X-Google-Smtp-Source: AGHT+IE9GK6sTUdM5L/IxpbkblDGSOPjUaKtcngj+grrLCRCk4saTdVCqVotXaWg7GGnR7TjO3Ib+Q==
X-Received: by 2002:ac2:4890:0:b0:511:55fb:2405 with SMTP id x16-20020ac24890000000b0051155fb2405mr1836126lfc.50.1708017743342;
        Thu, 15 Feb 2024 09:22:23 -0800 (PST)
Received: from skbuf ([188.25.173.195])
        by smtp.gmail.com with ESMTPSA id es10-20020a056402380a00b0056163b46393sm727889edb.64.2024.02.15.09.22.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 09:22:22 -0800 (PST)
Date: Thu, 15 Feb 2024 19:22:20 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Pawel Dembicki <paweldembicki@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	UNGLinuxDriver@microchip.com, Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 07/15] net: dsa: vsc73xx: Add vlan filtering
Message-ID: <20240215172220.p7w2yyrveu7yd4w2@skbuf>
References: <20240213220331.239031-1-paweldembicki@gmail.com>
 <20240213220331.239031-1-paweldembicki@gmail.com>
 <20240213220331.239031-8-paweldembicki@gmail.com>
 <20240213220331.239031-8-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213220331.239031-8-paweldembicki@gmail.com>
 <20240213220331.239031-8-paweldembicki@gmail.com>

On Tue, Feb 13, 2024 at 11:03:20PM +0100, Pawel Dembicki wrote:
> This patch implements VLAN filtering for the vsc73xx driver.
> 
> After starting VLAN filtering, the switch is reconfigured from QinQ to
> a simple VLAN aware mode. This is required because VSC73XX chips do not
> support inner VLAN tag filtering.
> 
> Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
> ---

This looks good, please keep working on it. I have a lot of comments
below, but they are all minor and don't involve structural rework.

> v4:
>   - reworked most of conditional register configs
>   - simplified port_vlan function
>   - move vlan table clearing from port_setup to setup
>   - pvid configuration simplified (now kernel take care about no of
>     pvids per port)
>   - port vlans are stored in list now
>   - introduce implementation of all untagged vlans state
>   - many minor changes
> v3:
>   - reworked all vlan commits
>   - added storage variables for pvid and untagged vlans
>   - move length extender settings to port setup
>   - remove vlan table cleaning in wrong places
> v2:
>   - no changes done
> 
>  drivers/net/dsa/vitesse-vsc73xx-core.c | 523 ++++++++++++++++++++++++-
>  drivers/net/dsa/vitesse-vsc73xx.h      |  25 ++
>  2 files changed, 546 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
> index 1dca3c476fac..6c7bd1c200b4 100644
> --- a/drivers/net/dsa/vitesse-vsc73xx-core.c
> +++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
> @@ -21,9 +21,11 @@
>  #include <linux/of_mdio.h>
>  #include <linux/bitops.h>
>  #include <linux/if_bridge.h>
> +#include <linux/if_vlan.h>
>  #include <linux/etherdevice.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/gpio/driver.h>
> +#include <linux/dsa/8021q.h>
>  #include <linux/random.h>
>  #include <net/dsa.h>
>  
> @@ -61,6 +63,8 @@
>  #define VSC73XX_CAT_DROP	0x6e
>  #define VSC73XX_CAT_PR_MISC_L2	0x6f
>  #define VSC73XX_CAT_PR_USR_PRIO	0x75
> +#define VSC73XX_CAT_VLAN_MISC	0x79
> +#define VSC73XX_CAT_PORT_VLAN	0x7a
>  #define VSC73XX_Q_MISC_CONF	0xdf
>  
>  /* MAC_CFG register bits */
> @@ -121,6 +125,17 @@
>  #define VSC73XX_ADVPORTM_IO_LOOPBACK	BIT(1)
>  #define VSC73XX_ADVPORTM_HOST_LOOPBACK	BIT(0)
>  
> +/*  TXUPDCFG transmit modify setup bits */
> +#define VSC73XX_TXUPDCFG_DSCP_REWR_MODE	GENMASK(20, 19)
> +#define VSC73XX_TXUPDCFG_DSCP_REWR_ENA	BIT(18)
> +#define VSC73XX_TXUPDCFG_TX_INT_TO_USRPRIO_ENA	BIT(17)
> +#define VSC73XX_TXUPDCFG_TX_UNTAGGED_VID	GENMASK(15, 4)
> +#define VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA	BIT(3)
> +#define VSC73XX_TXUPDCFG_TX_UPDATE_CRC_CPU_ENA	BIT(1)
> +#define VSC73XX_TXUPDCFG_TX_INSERT_TAG	BIT(0)
> +
> +#define VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_SHIFT 4

nitpick: align a tab, not a space.

> +
>  /* CAT_DROP categorizer frame dropping register bits */
>  #define VSC73XX_CAT_DROP_DROP_MC_SMAC_ENA	BIT(6)
>  #define VSC73XX_CAT_DROP_FWD_CTRL_ENA		BIT(4)
> @@ -134,6 +149,15 @@
>  #define VSC73XX_Q_MISC_CONF_EARLY_TX_512	(1 << 1)
>  #define VSC73XX_Q_MISC_CONF_MAC_PAUSE_MODE	BIT(0)
>  
> +/* CAT_VLAN_MISC categorizer VLAN miscellaneous bits*/

nitpick: space before */

> +#define VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA BIT(8)
> +#define VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA BIT(7)
> +
> +/* CAT_PORT_VLAN categorizer port VLAN*/

nitpick: space before */

> +#define VSC73XX_CAT_PORT_VLAN_VLAN_CFI BIT(15)
> +#define VSC73XX_CAT_PORT_VLAN_VLAN_USR_PRIO GENMASK(14, 12)
> +#define VSC73XX_CAT_PORT_VLAN_VLAN_VID GENMASK(11, 0)
> +
>  /* Frame analyzer block 2 registers */
>  #define VSC73XX_STORMLIMIT	0x02
>  #define VSC73XX_ADVLEARN	0x03
> @@ -188,7 +212,8 @@
>  #define VSC73XX_VLANACCESS_VLAN_MIRROR		BIT(29)
>  #define VSC73XX_VLANACCESS_VLAN_SRC_CHECK	BIT(28)
>  #define VSC73XX_VLANACCESS_VLAN_PORT_MASK	GENMASK(9, 2)
> -#define VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK	GENMASK(2, 0)
> +#define VSC73XX_VLANACCESS_VLAN_PORT_MASK_SHIFT	2
> +#define VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK	GENMASK(1, 0)
>  #define VSC73XX_VLANACCESS_VLAN_TBL_CMD_IDLE	0
>  #define VSC73XX_VLANACCESS_VLAN_TBL_CMD_READ_ENTRY	1
>  #define VSC73XX_VLANACCESS_VLAN_TBL_CMD_WRITE_ENTRY	2
> @@ -343,6 +368,12 @@ static const struct vsc73xx_counter vsc73xx_tx_counters[] = {
>  	{ 29, "TxQoSClass3" }, /* non-standard counter */
>  };
>  
> +enum vsc73xx_port_vlan_conf {
> +	VSC73XX_VLAN_FILTER,
> +	VSC73XX_VLAN_FILTER_UNTAG_ALL,
> +	VSC73XX_VLAN_IGNORE,
> +};
> +
>  int vsc73xx_is_addr_valid(u8 block, u8 subblock)
>  {
>  	switch (block) {
> @@ -560,6 +591,82 @@ static enum dsa_tag_protocol vsc73xx_get_tag_protocol(struct dsa_switch *ds,
>  	return DSA_TAG_PROTO_NONE;
>  }
>  
> +static int vsc73xx_wait_for_vlan_table_cmd(struct vsc73xx *vsc)
> +{
> +	int ret, err;
> +	u32 val;
> +
> +	ret = read_poll_timeout(vsc73xx_read, err,
> +				err < 0 || ((val & VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK) ==
> +					    VSC73XX_VLANACCESS_VLAN_TBL_CMD_IDLE),
> +				1000, 10000, false, vsc, VSC73XX_BLOCK_ANALYZER,

#define VSC73XX_VLAN_TBL_SLEEP_US
#define VSC73XX_VLAN_TBL_TIMEOUT_US

> +				0, VSC73XX_VLANACCESS, &val);
> +	if (ret)
> +		return ret;
> +	return err;
> +}
> +
> +static int
> +vsc73xx_read_vlan_table_entry(struct vsc73xx *vsc, u16 vid, u8 *portmap)
> +{
> +	u32 val;
> +	int ret;
> +
> +	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANTIDX, vid);
> +	ret = vsc73xx_wait_for_vlan_table_cmd(vsc);
> +	if (ret)
> +		return ret;

Some blank lines before and after the sequences:

	ret = do_x();
	if (ret)
		return ret;

would improve the readability.

> +	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANACCESS,
> +			    VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK,
> +			    VSC73XX_VLANACCESS_VLAN_TBL_CMD_READ_ENTRY);
> +	ret = vsc73xx_wait_for_vlan_table_cmd(vsc);
> +	if (ret)
> +		return ret;
> +	vsc73xx_read(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANACCESS, &val);
> +	*portmap = (val & VSC73XX_VLANACCESS_VLAN_PORT_MASK) >>
> +		   VSC73XX_VLANACCESS_VLAN_PORT_MASK_SHIFT;
> +	return 0;
> +}
> +
> +static int
> +vsc73xx_write_vlan_table_entry(struct vsc73xx *vsc, u16 vid, u8 portmap)
> +{
> +	int ret;
> +
> +	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANTIDX, vid);
> +	ret = vsc73xx_wait_for_vlan_table_cmd(vsc);
> +	if (ret)
> +		return ret;
> +
> +	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANACCESS,
> +			    VSC73XX_VLANACCESS_VLAN_TBL_CMD_MASK |
> +			    VSC73XX_VLANACCESS_VLAN_SRC_CHECK |
> +			    VSC73XX_VLANACCESS_VLAN_PORT_MASK,
> +			    VSC73XX_VLANACCESS_VLAN_TBL_CMD_WRITE_ENTRY |
> +			    VSC73XX_VLANACCESS_VLAN_SRC_CHECK |
> +			    (portmap << VSC73XX_VLANACCESS_VLAN_PORT_MASK_SHIFT));
> +
> +	return vsc73xx_wait_for_vlan_table_cmd(vsc);
> +}
> +
> +static int
> +vsc73xx_update_vlan_table(struct vsc73xx *vsc, int port, u16 vid, bool set)
> +{
> +	u8 portmap;
> +	int ret;
> +
> +	ret = vsc73xx_read_vlan_table_entry(vsc, vid, &portmap);
> +	if (ret)
> +		return ret;
> +
> +	if (set)
> +		portmap |= BIT(port);
> +	else
> +		portmap &= ~BIT(port);
> +
> +	return  vsc73xx_write_vlan_table_entry(vsc, vid, portmap);

nitpick: remove extra space.

> +}
> +
>  static int vsc73xx_setup(struct dsa_switch *ds)
>  {
>  	struct vsc73xx *vsc = ds->priv;
> @@ -594,7 +701,7 @@ static int vsc73xx_setup(struct dsa_switch *ds)
>  		      VSC73XX_MACACCESS,
>  		      VSC73XX_MACACCESS_CMD_CLEAR_TABLE);
>  
> -	/* Clear VLAN table */
> +	/* Set VLAN table to default values*/
>  	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0,
>  		      VSC73XX_VLANACCESS,
>  		      VSC73XX_VLANACCESS_VLAN_TBL_CMD_CLEAR_TABLE);
> @@ -623,6 +730,9 @@ static int vsc73xx_setup(struct dsa_switch *ds)
>  	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GMIIDELAY,
>  		      VSC73XX_GMIIDELAY_GMII0_GTXDELAY_2_0_NS |
>  		      VSC73XX_GMIIDELAY_GMII0_RXDELAY_2_0_NS);
> +	/* Ingess VLAN reception mask (table 145) */
> +	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_VLANMASK,
> +		      0x5f);
>  	/* IP multicast flood mask (table 144) */
>  	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_IFLODMSK,
>  		      0xff);
> @@ -635,6 +745,12 @@ static int vsc73xx_setup(struct dsa_switch *ds)
>  
>  	udelay(4);
>  
> +	/* Clear VLAN table*/

nitpick: space before */

> +	for (i = 0; i < VLAN_N_VID; i++)
> +		vsc73xx_write_vlan_table_entry(vsc, i, 0);
> +
> +	INIT_LIST_HEAD(&vsc->vlans);
> +
>  	return 0;
>  }
>  
> @@ -1024,6 +1140,405 @@ static void vsc73xx_phylink_get_caps(struct dsa_switch *dsa, int port,
>  	config->mac_capabilities = MAC_SYM_PAUSE | MAC_10 | MAC_100 | MAC_1000;
>  }
>  
> +static void
> +vsc73xx_set_vlan_conf(struct vsc73xx *vsc, int port,
> +		      enum vsc73xx_port_vlan_conf port_vlan_conf)
> +{
> +	u32 val = (port_vlan_conf == VSC73XX_VLAN_IGNORE) ?
> +		  VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA : 0;
> +
> +	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_VLAN_MISC,
> +			    VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA, val);
> +
> +	val = (port_vlan_conf == VSC73XX_VLAN_IGNORE) ?
> +	      VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA : 0;
> +	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_VLAN_MISC,
> +			    VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA, val);

Could you perform the VSC73XX_CAT_VLAN_MISC modification as part of a
single call? Something like this:

	u32 val = 0;

	if (port_vlan_conf == VSC73XX_VLAN_IGNORE) {
		val = VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA |
		      VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA;
	}

	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_VLAN_MISC,
			    VSC73XX_CAT_VLAN_MISC_VLAN_TCI_IGNORE_ENA |
			    VSC73XX_CAT_VLAN_MISC_VLAN_KEEP_TAG_ENA, val);

> +
> +	val = (port_vlan_conf == VSC73XX_VLAN_FILTER) ?
> +	      VSC73XX_TXUPDCFG_TX_INSERT_TAG : 0;
> +	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCFG,
> +			    VSC73XX_TXUPDCFG_TX_INSERT_TAG, val);
> +}
> +
> +static int
> +vsc73xx_vlan_change_untagged(struct vsc73xx *vsc, int port, u16 vid, bool set,
> +			     bool operate_on_storage)

This also returns 0, so it can be made void. Although vsc73xx_update_bits()
can fail on register access too, but... yeah. We don't have a great story
for that. Your choice on whether to propagate the unlikely error, or just
print it somewhere. Just don't let it fail completely silently.

> +{
> +	u32 val;
> +
> +	if (operate_on_storage) {
> +		vsc->untagged_storage[port] = set ? vid : VLAN_N_VID;
> +		return 0;
> +	}
> +
> +	val = set ? VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA : 0;
> +	vid = set ? vid : 0;
> +
> +	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCFG,
> +			    VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA, val);
> +	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCFG,
> +			    VSC73XX_TXUPDCFG_TX_UNTAGGED_VID,
> +			    (vid << VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_SHIFT) &
> +			     VSC73XX_TXUPDCFG_TX_UNTAGGED_VID);

Same here, try to merge, otherwise you get 4 I/O operations on a slow
bus instead of 2.

> +	return 0;
> +}
> +
> +static int
> +vsc73xx_vlan_change_pvid(struct vsc73xx *vsc, int port, u16 vid, bool set, bool operate_on_storage)

nitpick: 80 character line limit

> +{
> +	u32 val;
> +
> +	if (operate_on_storage) {
> +		vsc->pvid_storage[port] = set ? vid : VLAN_N_VID;
> +		return 0;
> +	}
> +
> +	val = set ? 0 : VSC73XX_CAT_DROP_UNTAGGED_ENA;
> +	vid = set ? vid : 0;
> +
> +	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_DROP,
> +			    VSC73XX_CAT_DROP_UNTAGGED_ENA, val);
> +
> +	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_PORT_VLAN,
> +			    VSC73XX_CAT_PORT_VLAN_VLAN_VID,
> +			    vid & VSC73XX_CAT_PORT_VLAN_VLAN_VID);
> +	return 0;
> +}
> +
> +static bool
> +vsc73xx_port_get_pvid(struct vsc73xx *vsc, int port, u16 *vid, bool operate_on_storage)

nitpick: 80 character line limit

All comments apply elsewhere too, I might have missed some, so please
take a second look.

> +{
> +	u32 val;
> +
> +	if (operate_on_storage) {
> +		if (vsc->pvid_storage[port] < VLAN_N_VID) {
> +			*vid = vsc->pvid_storage[port];
> +			return true;
> +		}
> +		return false;
> +	}
> +
> +	vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_DROP, &val);
> +	if (val & VSC73XX_CAT_DROP_UNTAGGED_ENA)
> +		return false;
> +
> +	vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_PORT_VLAN, &val);
> +	*vid = val & VSC73XX_CAT_PORT_VLAN_VLAN_VID;
> +
> +	return true;
> +}
> +
> +static bool vsc73xx_tag_8021q_active(struct dsa_port *dp)
> +{
> +	return !dsa_port_is_vlan_filtering(dp);
> +}
> +
> +static bool
> +vsc73xx_port_get_untagged(struct vsc73xx *vsc, int port, u16 *vid, bool operate_on_storage)

nitpick: 80 character line limit

> +{
> +	u32 val;
> +
> +	if (operate_on_storage) {
> +		if (vsc->untagged_storage[port] < VLAN_N_VID) {
> +			*vid = vsc->untagged_storage[port];
> +			return true;
> +		}
> +		return false;
> +	}
> +
> +	vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCFG, &val);
> +	if (!(val & VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA))
> +		return false;
> +
> +	*vid = (val & VSC73XX_TXUPDCFG_TX_UNTAGGED_VID) >>
> +		VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_SHIFT;
> +
> +	return true;
> +}
> +
> +static struct vsc73xx_bridge_vlan *vsc73xx_bridge_vlan_find(struct vsc73xx *vsc, u16 vid)

nitpick: 80 character line limit

> +{
> +	struct vsc73xx_bridge_vlan *vlan;
> +
> +	list_for_each_entry(vlan, &vsc->vlans, list)
> +		if (vlan->vid == vid)
> +			return vlan;
> +
> +	return NULL;
> +}
> +
> +static u16 vsc73xx_bridge_vlan_num_tagged(struct vsc73xx *vsc, int port, u16 ignored_vid)

nitpick: 80 character line limit

Also, any reason why this has to return a fixed-size u16? You could use
the size_t type for object counts.

> +{
> +	struct vsc73xx_bridge_vlan *vlan;
> +	u16 num_tagged = 0;
> +
> +	list_for_each_entry(vlan, &vsc->vlans, list)
> +		if ((vlan->portmask & BIT(port)) &&
> +		    !(vlan->untagged & BIT(port)) &&
> +		    vlan->vid != ignored_vid)
> +			num_tagged++;
> +
> +	return num_tagged;
> +}
> +
> +static u16 vsc73xx_bridge_vlan_num_untagged(struct vsc73xx *vsc, int port, u16 ignored_vid)

nitpick: 80 character line limit

> +{
> +	struct vsc73xx_bridge_vlan *vlan;
> +	u16 num_untagged = 0;
> +
> +	list_for_each_entry(vlan, &vsc->vlans, list)
> +		if ((vlan->portmask & BIT(port)) &&
> +		    (vlan->untagged & BIT(port)) &&
> +		    vlan->vid != ignored_vid)
> +			num_untagged++;
> +
> +	return num_untagged;
> +}
> +
> +static u16 vsc73xx_find_first_vlan_untagged(struct vsc73xx *vsc, int port)
> +{
> +	struct vsc73xx_bridge_vlan *vlan;
> +
> +	list_for_each_entry(vlan, &vsc->vlans, list)
> +		if ((vlan->portmask & BIT(port)) &&
> +		    (vlan->untagged & BIT(port)))
> +			return vlan->vid;
> +
> +	return VLAN_N_VID;
> +}
> +
> +static int
> +vsc73xx_port_vlan_filtering(struct dsa_switch *ds, int port,
> +			    bool vlan_filtering, struct netlink_ext_ack *extack)
> +{
> +	enum vsc73xx_port_vlan_conf port_vlan_conf = VSC73XX_VLAN_IGNORE;
> +	struct vsc73xx *vsc = ds->priv;
> +	bool store_untagged  = false;

nitpick: remove one extra space

> +	bool store_pvid = false;
> +	u16 vlan_no, vlan_untagged;

nitpick: order variable declaration lines in the order of decreasing
line length.

Also, "vid" is a more conventional name than "vlan_no".

> +
> +	/* The swap processed bellow is required because vsc73xx is using tag8021q.

s/bellow/below/
s/tag8021q/tag_8021q/

> +	 * When vlan_filtering is disabled, tag8021q use pvid/untagged vlans for

s/tag8021q use/tag_8021q uses/

> +	 * port recognition. The values configured for vlans < 3072 are stored
> +	 * in storage table. When vlan_filtering is enabled, we need to restore
> +	 * pvid/untagged from storage and keep values used for tag8021q.
> +	 */
> +

nitpick: remove blank line

> +	if (vlan_filtering) {
> +		/* Use VLAN_N_VID to count all vlans */
> +		u16 num_untagged = vsc73xx_bridge_vlan_num_untagged(vsc, port, VLAN_N_VID);
> +
> +		port_vlan_conf = (num_untagged > 1) ?
> +				 VSC73XX_VLAN_FILTER_UNTAG_ALL : VSC73XX_VLAN_FILTER;
> +
> +		vlan_untagged = vsc73xx_find_first_vlan_untagged(vsc, port);
> +		if (vlan_no < VLAN_N_VID) {
> +			store_untagged  = vsc73xx_port_get_untagged(vsc, port, &vlan_no, false);
> +			vsc73xx_vlan_change_untagged(vsc, port, vlan_untagged,
> +						     vlan_untagged < VLAN_N_VID, false);
> +			vsc->untagged_storage[port] = store_untagged ? vlan_no : VLAN_N_VID;
> +		}
> +	} else {
> +		vsc73xx_vlan_change_untagged(vsc, port, vsc->untagged_storage[port],
> +					     vsc->untagged_storage[port] < VLAN_N_VID, false);
> +	}
> +
> +	vsc73xx_set_vlan_conf(vsc, port, port_vlan_conf);
> +
> +	store_pvid = vsc73xx_port_get_pvid(vsc, port, &vlan_no, false);
> +	vsc73xx_vlan_change_pvid(vsc, port, vsc->pvid_storage[port],
> +				 vsc->pvid_storage[port] < VLAN_N_VID, false);
> +	vsc->pvid_storage[port] = store_pvid ? vlan_no : VLAN_N_VID;
> +
> +	return 0;
> +}
> +
> +static int vsc73xx_port_vlan_add(struct dsa_switch *ds, int port,
> +				 const struct switchdev_obj_port_vlan *vlan,
> +				 struct netlink_ext_ack *extack)
> +{
> +	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
> +	bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
> +	struct vsc73xx_bridge_vlan *vsc73xx_vlan;
> +	u16 vlan_no, num_tagged, num_untagged;
> +	struct vsc73xx *vsc = ds->priv;
> +	int ret;
> +
> +	/* Be sure to deny alterations to the configuration done by tag_8021q.
> +	 */
> +	if (vid_is_dsa_8021q(vlan->vid)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Range 3072-4095 reserved for dsa_8021q operation");
> +		return -EBUSY;
> +	}
> +
> +	num_tagged = vsc73xx_bridge_vlan_num_tagged(vsc, port, vlan->vid);
> +	num_untagged = vsc73xx_bridge_vlan_num_untagged(vsc, port, vlan->vid);

Could you add a comment explaining why you need to exclude vlan->vid
from the search? I guess it's because the VLAN can be re-added with a
different set of flags, so it's easiest to ignore its old flags from the
VLAN database software copy.

> +
> +	/* VSC73XX allow only three untagged states: none, one or all */
> +	if ((untagged && num_tagged > 0 && num_untagged > 0) ||
> +	    (!untagged && num_untagged > 1)) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Port can have only none, one or all untagged vlan!\n");

No need for \n in extack message. Also, no need for exclamation mark.

> +		return -EBUSY;
> +	}
> +
> +	vsc73xx_vlan = vsc73xx_bridge_vlan_find(vsc, vlan->vid);
> +
> +	if (!vsc73xx_vlan) {
> +		vsc73xx_vlan = kzalloc(sizeof(*vsc73xx_vlan), GFP_KERNEL);
> +		if (!vsc73xx_vlan)
> +			return -ENOMEM;
> +
> +		vsc73xx_vlan->vid = vlan->vid;
> +		vsc73xx_vlan->portmask = BIT(port);
> +		vsc73xx_vlan->untagged |= untagged ? BIT(port) : 0;

kzalloc zero-initializes the memory, so |= can be simplified to just =.

> +
> +		INIT_LIST_HEAD(&vsc73xx_vlan->list);
> +		list_add_tail(&vsc73xx_vlan->list, &vsc->vlans);
> +	} else {
> +		vsc73xx_vlan->portmask |= BIT(port);
> +
> +		if (untagged)
> +			vsc73xx_vlan->untagged |= BIT(port);
> +		else
> +			vsc73xx_vlan->untagged &= ~BIT(port);
> +	}
> +
> +	/* CPU port must be always tagged because port separation are based on 8021q.*/

nitpick: space before */

s/are based/is based/
s/8021q/tag_8021q/

> +	if (port != CPU_PORT) {
> +		bool operate_on_storage = vsc73xx_tag_8021q_active(dsa_to_port(ds, port));

It would look better if you had a local variable declaration at the
beginning:

	struct dsa_port *dp = dsa_to_port(ds, port);

	if (port != CPU_PORT) {
		bool operate_on_storage = vsc73xx_tag_8021q_active(dp);

> +
> +		if (!operate_on_storage) {
> +			enum vsc73xx_port_vlan_conf port_vlan_conf = VSC73XX_VLAN_FILTER;
> +
> +			if (num_tagged == 0 && untagged)
> +				port_vlan_conf = VSC73XX_VLAN_FILTER_UNTAG_ALL;
> +			vsc73xx_set_vlan_conf(vsc, port, port_vlan_conf);
> +
> +			if (port_vlan_conf == VSC73XX_VLAN_FILTER) {
> +				if (untagged) {
> +					ret = vsc73xx_vlan_change_untagged(vsc, port, vlan->vid,
> +									   true,
> +									   operate_on_storage);
> +					if (ret)
> +						return ret;

This leaks vsc73xx_vlan.

> +				} else if (num_untagged == 1) {
> +					vlan_no = vsc73xx_find_first_vlan_untagged(vsc, port);
> +					ret = vsc73xx_vlan_change_untagged(vsc, port, vlan_no, true,
> +									   operate_on_storage);
> +					if (ret)
> +						return ret;

Same here.

> +				}
> +			}
> +		}
> +
> +		if (pvid) {
> +			ret = vsc73xx_vlan_change_pvid(vsc, port, vlan->vid, true,
> +						       operate_on_storage);
> +			if (ret)
> +				return ret;

Same here.

> +		} else {
> +			if (vsc73xx_port_get_pvid(vsc, port, &vlan_no, false) &&
> +			    vlan_no == vlan->vid)
> +				vsc73xx_vlan_change_pvid(vsc, port, 0, false, false);
> +			else if (vsc->pvid_storage[port] == vlan->vid)
> +				vsc73xx_vlan_change_pvid(vsc, port, 0, false, true);

Nitpick:

	if () {
	} else {
		if ()
		else if
	}

can be expressed with one indentation level less as:

	if () {
	} else if () {
	} else if () {
	}

> +		}
> +	}
> +
> +	return vsc73xx_update_vlan_table(vsc, port, vlan->vid, true);

If this returns an error, it also leaks vsc73xx_vlan.

> +}
> +
> +static int vsc73xx_port_vlan_del(struct dsa_switch *ds, int port,
> +				 const struct switchdev_obj_port_vlan *vlan)
> +{
> +	struct vsc73xx_bridge_vlan *vsc73xx_vlan;
> +	u16 vlan_no, num_tagged, num_untagged;
> +	struct vsc73xx *vsc = ds->priv;
> +	bool operate_on_storage;
> +	int ret;
> +
> +	num_tagged = vsc73xx_bridge_vlan_num_tagged(vsc, port, vlan->vid);
> +	num_untagged = vsc73xx_bridge_vlan_num_untagged(vsc, port, vlan->vid);
> +
> +	ret = vsc73xx_update_vlan_table(vsc, port, vlan->vid, false);
> +	if (ret)
> +		return ret;
> +
> +	operate_on_storage = vsc73xx_tag_8021q_active(dsa_to_port(ds, port));
> +
> +	if (!operate_on_storage) {
> +		enum vsc73xx_port_vlan_conf port_vlan_conf = VSC73XX_VLAN_FILTER;
> +
> +		if (num_tagged == 0)
> +			port_vlan_conf = VSC73XX_VLAN_FILTER_UNTAG_ALL;
> +		vsc73xx_set_vlan_conf(vsc, port, port_vlan_conf);
> +
> +		if (num_untagged <= 1) {
> +			vlan_no = vsc73xx_find_first_vlan_untagged(vsc, port);
> +			vsc73xx_vlan_change_untagged(vsc, port, vlan_no, num_untagged, false);
> +		}
> +	} else if (vsc->untagged_storage[port] == vlan->vid) {
> +		vsc73xx_vlan_change_untagged(vsc, port, 0, false, true);
> +	}
> +
> +	if (vsc73xx_port_get_pvid(vsc, port, &vlan_no, false) && vlan_no == vlan->vid)
> +		vsc73xx_vlan_change_pvid(vsc, port, 0, false, false);
> +	else if (vsc->pvid_storage[port] == vlan->vid)
> +		vsc73xx_vlan_change_pvid(vsc, port, 0, false, true);
> +
> +	vsc73xx_vlan = vsc73xx_bridge_vlan_find(vsc, vlan->vid);
> +
> +	if (vsc73xx_vlan) {
> +		vsc73xx_vlan->portmask &= ~BIT(port);
> +
> +		if (vsc73xx_vlan->portmask)
> +			return 0;
> +
> +		list_del(&vsc73xx_vlan->list);
> +		kfree(vsc73xx_vlan);
> +	}
> +
> +	return 0;
> +}
> +
> +static int vsc73xx_port_setup(struct dsa_switch *ds, int port)
> +{
> +	struct vsc73xx *vsc = ds->priv;
> +
> +	/* Those bits are responsible for MTU only. Kernel take care about MTU,
> +	 * let's enable +8 bytes frame length unconditionally.
> +	 */
> +	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MAC_CFG,
> +			    VSC73XX_MAC_CFG_VLAN_AWR | VSC73XX_MAC_CFG_VLAN_DBLAWR,
> +			    VSC73XX_MAC_CFG_VLAN_AWR | VSC73XX_MAC_CFG_VLAN_DBLAWR);
> +
> +	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_DROP,
> +			    VSC73XX_CAT_DROP_TAGGED_ENA, 0);
> +	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_DROP,
> +			    VSC73XX_CAT_DROP_UNTAGGED_ENA,
> +			    VSC73XX_CAT_DROP_UNTAGGED_ENA);

Merge operations.

> +	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCFG,
> +			    VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA, 0);
> +	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCFG,
> +			    VSC73XX_TXUPDCFG_TX_UNTAGGED_VID, 0);

Merge operations.

> +	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_PORT_VLAN,
> +			    VSC73XX_CAT_PORT_VLAN_VLAN_VID, 0);
> +
> +	if (port == CPU_PORT)
> +		vsc73xx_set_vlan_conf(vsc, port, VSC73XX_VLAN_FILTER);
> +	else
> +		vsc73xx_set_vlan_conf(vsc, port, VSC73XX_VLAN_IGNORE);
> +
> +	/* Set storage values out of range */

please make the comment more useful by adding an explanation why. Like
"Initially, there is no backup VLAN configuration to keep track of, so
configure the storage values out of range".

> +	vsc->pvid_storage[port] = VLAN_N_VID;
> +	vsc->untagged_storage[port] = VLAN_N_VID;
> +
> +	return 0;
> +}
> +
>  static void vsc73xx_refresh_fwd_map(struct dsa_switch *ds, int port, bool configure)
>  {
>  	struct dsa_port *dp = dsa_to_port(ds, port);
> @@ -1107,11 +1622,15 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
>  	.get_strings = vsc73xx_get_strings,
>  	.get_ethtool_stats = vsc73xx_get_ethtool_stats,
>  	.get_sset_count = vsc73xx_get_sset_count,
> +	.port_setup = vsc73xx_port_setup,
>  	.port_enable = vsc73xx_port_enable,
>  	.port_disable = vsc73xx_port_disable,
>  	.port_change_mtu = vsc73xx_change_mtu,
>  	.port_max_mtu = vsc73xx_get_max_mtu,
>  	.port_stp_state_set = vsc73xx_port_stp_state_set,
> +	.port_vlan_filtering = vsc73xx_port_vlan_filtering,
> +	.port_vlan_add = vsc73xx_port_vlan_add,
> +	.port_vlan_del = vsc73xx_port_vlan_del,
>  	.phylink_get_caps = vsc73xx_phylink_get_caps,
>  };
>  
> diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitesse-vsc73xx.h
> index 99c5c24ffde0..01eb2dd48f03 100644
> --- a/drivers/net/dsa/vitesse-vsc73xx.h
> +++ b/drivers/net/dsa/vitesse-vsc73xx.h
> @@ -24,6 +24,14 @@
>   * @addr: MAC address used in flow control frames
>   * @ops: Structure with hardware-dependent operations
>   * @priv: Pointer to the configuration interface structure
> + * @pvid_storage: Storage table with PVID configured for other state of vlan_filtering.
> + *	It have two roles: Keep PVID when PVID is configured but vlan filtering is off

"It has two alternating roles: it stores the PVID when configured by the
bridge but VLAN filtering is off, and it stores the PVID necessary for
tag_8021q operation when bridge VLAN filtering is enabled".

> + *	and keep PVID necessary for tag8021q operations when vlan filtering is enabled.
> + * @untagged_storage: Storage table with eggress untagged VLAN configured for

s/eggress/egress/

> + *	other state of vlan_filtering.Keep VID necessary for tag8021q operations when
> + *	vlan filtering is enabled.
> + * @vlans: List of configured vlans. Contain port mask and untagged status of every

Contains

> + *	vlan configured in port vlan operation. It doesn't cover tag8021q vlans.
>   */
>  struct vsc73xx {
>  	struct device			*dev;
> @@ -34,6 +42,9 @@ struct vsc73xx {
>  	u8				addr[ETH_ALEN];
>  	const struct vsc73xx_ops	*ops;
>  	void				*priv;
> +	u16				pvid_storage[VSC73XX_MAX_NUM_PORTS];
> +	u16				untagged_storage[VSC73XX_MAX_NUM_PORTS];
> +	struct list_head		vlans;
>  };
>  
>  /**
> @@ -48,6 +59,20 @@ struct vsc73xx_ops {
>  		     u32 val);
>  };
>  
> +/**
> + * struct vsc73xx_bridge_vlan - VSC73xx driver structure which keeps vlan database copy

More succinct: "Copy of VLAN database entry"

> + * @vid: VLAN number
> + * @portmask: each bit represends one port

s/represends/represents/

> + * @untagged: each bit represends one port configured with @vid untagged

s/represends/represents/

> + * @list: list structure
> + */
> +struct vsc73xx_bridge_vlan {
> +	u16 vid;
> +	u8 portmask;
> +	u8 untagged;
> +	struct list_head list;
> +};
> +
>  int vsc73xx_is_addr_valid(u8 block, u8 subblock);
>  int vsc73xx_probe(struct vsc73xx *vsc);
>  void vsc73xx_remove(struct vsc73xx *vsc);
> -- 
> 2.34.1
> 


