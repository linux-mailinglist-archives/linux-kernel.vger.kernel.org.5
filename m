Return-Path: <linux-kernel+bounces-17611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C93F882502C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 09:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37FB01F2372D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 08:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DAA522329;
	Fri,  5 Jan 2024 08:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="a3+DqxLe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E5621A03;
	Fri,  5 Jan 2024 08:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C6F981C0002;
	Fri,  5 Jan 2024 08:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1704444450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KiAV7MkFAS8XsXcT4nrUFXbjcZjnTFTonmUxeLLAN6Y=;
	b=a3+DqxLe45TsY1WKHwbjhC4ok2OHF5N8fmQep3fqsLV+byycHO/B6l6tdvaaXYLhqcq9lk
	jDqWC+umSxZCKJj5g0gZ0WAooaa3NvQct6RtlWoBG4rsrCI9qq/a/5/AmQZYpuA1pdFyg0
	BjFOX0kvX58F+zQY9BLjfYlX7UA6XQZ2BBaOLCJQryTBwtb61Sw0+tPC00BHCewtk/sXuN
	Plzqc2vj1V0xpLJpFjxVtqR2vm1kofTcLbcRkPy/gvOFsMCBukhPRta/y+SB/IqIp631xl
	jcvpFU/5kyj540blZ7eBLkocwgKMszNRNJru0GdWILqhpAXuRHS35HE0OZD14w==
Date: Fri, 5 Jan 2024 10:43:11 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com, Andrew Lunn
 <andrew@lunn.ch>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Herve Codina <herve.codina@bootlin.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Heiner Kallweit
 <hkallweit1@gmail.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>, Jesse Brandeburg
 <jesse.brandeburg@intel.com>, Jonathan Corbet <corbet@lwn.net>, Marek
 =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>, Piergiorgio Beruto
 <piergiorgio.beruto@gmail.com>, Oleksij Rempel <o.rempel@pengutronix.de>,
 =?UTF-8?B?Tmljb2zDsg==?= Veronese <nicveronese@gmail.com>, Simon Horman
 <horms@kernel.org>
Subject: Re: [PATCH net-next v5 07/13] net: ethtool: Introduce a command to
 list PHYs on an interface
Message-ID: <20240105104311.03a35622@device-28.home>
In-Reply-To: <20240104153401.08ff9809@kernel.org>
References: <20231221180047.1924733-1-maxime.chevallier@bootlin.com>
	<20231221180047.1924733-8-maxime.chevallier@bootlin.com>
	<20240104153401.08ff9809@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Jakub,

Thanks a lot for the review on that part,

On Thu, 4 Jan 2024 15:34:01 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Thu, 21 Dec 2023 19:00:40 +0100 Maxime Chevallier wrote:
> > As we have the ability to track the PHYs connected to a net_device
> > through the link_topology, we can expose this list to userspace. This
> > allows userspace to use these identifiers for phy-specific commands and
> > take the decision of which PHY to target by knowing the link topology.
> > 
> > Add PHY_GET and PHY_DUMP, which can be a filtered DUMP operation to list
> > devices on only one interface.
> > 
> > Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>  
> 
> > diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
> > index 3ca6c21e74af..97ff787a7dd8 100644
> > --- a/Documentation/networking/ethtool-netlink.rst
> > +++ b/Documentation/networking/ethtool-netlink.rst
> > @@ -2011,6 +2011,49 @@ The attributes are propagated to the driver through the following structure:
> >  .. kernel-doc:: include/linux/ethtool.h
> >      :identifiers: ethtool_mm_cfg
> >  
> > +PHY_GET
> > +=======
> > +
> > +Retrieve information about a given Ethernet PHY sitting on the link. As there
> > +can be more than one PHY, the DUMP operation can be used to list the PHYs
> > +present on a given interface, by passing an interface index or name in
> > +the dump request
> > +
> > +Request contents:
> > +
> > +  ====================================  ======  ==========================
> > +  ``ETHTOOL_A_PHY_HEADER``              nested  request header
> > +  ====================================  ======  ==========================
> > +
> > +Kernel response contents:
> > +
> > +  ===================================== ======  ==========================
> > +  ``ETHTOOL_A_PHY_HEADER``              nested  request header
> > +  ``ETHTOOL_A_PHY_INDEX``               u32     the phy's unique index, that can  
> 
> The fact that lines are longer than the ===== markings doesn't generate
> warnings in htmldoc?

I did test the doc, but maybe I missed the warning. Since I'll need to
respin anyway, I'll clean this up :)

> 
> > +                                                be used for phy-specific requests
> > +  ``ETHTOOL_A_PHY_DRVNAME``             string  the phy driver name
> > +  ``ETHTOOL_A_PHY_NAME``                string  the phy device name
> > +  ``ETHTOOL_A_PHY_UPSTREAM_TYPE``       u32     the type of device this phy is
> > +                                                connected to
> > +  ``ETHTOOL_A_PHY_UPSTREAM_PHY``        nested  if the phy is connected to another
> > +                                                phy, this nest contains info on
> > +                                                that connection
> > +  ``ETHTOOL_A_PHY_DOWNSTREAM_SFP_NAME`` string  if the phy controls an sfp bus,
> > +                                                the name of the sfp bus  
> 
> Is upstream / downstream clear to everyone / from the spec.
> I guess it's scoped to the netdev so upstream means "towards 
> the netdev MAC"?

Good point, it's indeed scoped to the netdev, upstream means "towards
the MAC" and downstream "towards the link-partner". The upstream
terminology is used a little bit in the SFP code, but anyway should we
keep that terminology, I'll document it better both here and in the
dedicated documentation.

> > +  ``ETHTOOL_A_PHY_ID``                  u32     the phy id if the phy is C22
> > +  ===================================== ======  ==========================
> > +
> > +When ``ETHTOOL_A_PHY_UPSTREAM_TYPE`` is PHY_UPSTREAM_PHY, the PHY's parent is
> > +another PHY. Information on the parent PHY will be set in the
> > +``ETHTOOL_A_PHY_UPSTREAM_PHY`` nest, which has the following structure :
> > +
> > +  =================================== ======  ==========================
> > +  ``ETHTOOL_A_PHY_UPSTREAM_INDEX``    u32     the PHY index of the upstream PHY
> > +  ``ETHTOOL_A_PHY_UPSTREAM_SFP_NAME`` string  if this PHY is connected to it's
> > +                                                parent PHY through an SFP bus, the
> > +                                                name of this sfp bus
> > +  =================================== ======  ==========================  
> 
> Why is this a nest?

It was an attempt to structure the info, but I think we can do without,
as it only contains 2 fields.

> >  Request translation
> >  ===================  
> 
> > +enum {
> > +	ETHTOOL_A_PHY_UNSPEC,
> > +	ETHTOOL_A_PHY_HEADER,			/* nest - _A_HEADER_* */
> > +	ETHTOOL_A_PHY_INDEX,			/* u32 */
> > +	ETHTOOL_A_PHY_DRVNAME,			/* string */
> > +	ETHTOOL_A_PHY_NAME,			/* string */
> > +	ETHTOOL_A_PHY_UPSTREAM_TYPE,		/* u8 */  
> 
> The Documentation say it's a u32 as it should be, AFAICT.
> But code and some comments use u8.

Ah my bad, Andrew did comment on that and I though I addressed the
inconsistency but there are some left apparently.

> > +	ETHTOOL_A_PHY_UPSTREAM,			/* nest - _A_PHY_UPSTREAM_* */
> > +	ETHTOOL_A_PHY_DOWNSTREAM_SFP_NAME,	/* string */
> > +	ETHTOOL_A_PHY_ID,			/* u32 */
> > +
> > +	/* add new constants above here */
> > +	__ETHTOOL_A_PHY_CNT,
> > +	ETHTOOL_A_PHY_MAX = (__ETHTOOL_A_PHY_CNT - 1)
> > +};  
> 
> > +++ b/net/ethtool/phy.c
> > @@ -0,0 +1,306 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright 2023 Bootlin
> > + *
> > + */  
> 
> Do you really need 4 lines for the copyright? :)

No I don't, I'll tidy this up :)

> 
> > +/* Caller holds rtnl */
> > +static ssize_t
> > +ethnl_phy_reply_size(const struct ethnl_req_info *req_base,
> > +		     struct netlink_ext_ack *extack)
> > +{
> > +	struct phy_link_topology *topo;
> > +	struct phy_device_node *pdn;
> > +	struct phy_device *phydev;
> > +	unsigned long index;
> > +	size_t size;
> > +
> > +	ASSERT_RTNL();
> > +
> > +	topo = &req_base->dev->link_topo;
> > +
> > +	size = nla_total_size(0);  
> 
> no comment on this one?

Ah sorry I'll add it

> > +
> > +	xa_for_each(&topo->phys, index, pdn) {  
> 
> Why count all the PHYs, you only output one on doit, right?

Uh ok good point, I'll fix it.

> > +		phydev = pdn->phy;
> > +
> > +		/* ETHTOOL_A_PHY_INDEX */
> > +		size += nla_total_size(sizeof(u32));
> > +
> > +		/* ETHTOOL_A_DRVNAME */
> > +		size += nla_total_size(strlen(phydev->drv->name) + 1);
> > +
> > +		/* ETHTOOL_A_NAME */
> > +		size += nla_total_size(strlen(dev_name(&phydev->mdio.dev)) + 1);
> > +
> > +		/* ETHTOOL_A_PHY_UPSTREAM_TYPE */
> > +		size += nla_total_size(sizeof(u8));
> > +
> > +		/* ETHTOOL_A_PHY_ID */
> > +		size += nla_total_size(sizeof(u32));
> > +
> > +		if (phy_on_sfp(phydev)) {
> > +			const char *upstream_sfp_name = sfp_get_name(pdn->parent_sfp_bus);
> > +
> > +			/* ETHTOOL_A_PHY_UPSTREAM_SFP_NAME */
> > +			if (upstream_sfp_name)
> > +				size += nla_total_size(strlen(upstream_sfp_name) + 1);
> > +
> > +			/* ETHTOOL_A_PHY_UPSTREAM_INDEX */
> > +			size += nla_total_size(sizeof(u32));
> > +		}
> > +
> > +		/* ETHTOOL_A_PHY_DOWNSTREAM_SFP_NAME */
> > +		if (phydev->sfp_bus) {
> > +			const char *sfp_name = sfp_get_name(phydev->sfp_bus);
> > +
> > +			if (sfp_name)
> > +				size += nla_total_size(strlen(sfp_name) + 1);
> > +		}
> > +	}
> > +
> > +	return size;
> > +}  
> 
> > +static int ethnl_phy_parse_request(struct ethnl_req_info *req_base,
> > +				   struct nlattr **tb)
> > +{
> > +	struct phy_link_topology *topo = &req_base->dev->link_topo;
> > +	struct phy_req_info *req_info = PHY_REQINFO(req_base);
> > +	struct phy_device_node *pdn;
> > +
> > +	if (!req_base->phydev)
> > +		return 0;  
> 
> The PHY INDEX should probably be a required attr, with 
> GENL_REQ_ATTR_CHECK()? Without phydev being specified
> what's the point?

We can still have a phydev without passing a PHY INDEX, this would
report information on the netdev->phydev device, that can be helpful
for users to know which PHY is targeted by commands such as "ethtool
--cable-test eth0" when no PHY index is passed

> > +	pdn = xa_load(&topo->phys, req_base->phydev->phyindex);
> > +	memcpy(&req_info->pdn, pdn, sizeof(*pdn));
> > +
> > +	return 0;
> > +}  
> 
> > +int ethnl_phy_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
> > +{
> > +	struct ethnl_phy_dump_ctx *ctx = (void *)cb->ctx;
> > +	struct net *net = sock_net(skb->sk);
> > +	unsigned long ifindex = 1;  
> 
> This doesn't look right, if dump gets full you gotta pick up
> when previous call left off.

I wasn't aware that this was the expected DUMP behaviour. So I should
keep track of the last dev and last phy_index dumped in the dump_ctx I
guess ? I'm not sure how I'm going to test this though, I only have
devices with at most 2 PHYs :(

> > +	struct net_device *dev;
> > +	int ret = 0;
> > +
> > +	rtnl_lock();
> > +
> > +	if (ctx->phy_req_info->base.dev) {
> > +		ret = ethnl_phy_dump_one_dev(skb, ctx->phy_req_info->base.dev, cb);
> > +		ethnl_parse_header_dev_put(&ctx->phy_req_info->base);
> > +		ctx->phy_req_info->base.dev = NULL;
> > +	} else {
> > +		for_each_netdev_dump(net, dev, ifindex) {
> > +			ret = ethnl_phy_dump_one_dev(skb, dev, cb);
> > +			if (ret)
> > +				break;
> > +		}
> > +	}
> > +	rtnl_unlock();
> > +
> > +	if (ret == -EMSGSIZE && skb->len)
> > +		return skb->len;
> > +	return ret;
> > +}
> > +  
> 

Thanks a lot for the review, the netlink part was definitely the hard
part for me.

Maxime

