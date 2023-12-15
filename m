Return-Path: <linux-kernel+bounces-1679-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACC54815207
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6289D28201D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8939048CC5;
	Fri, 15 Dec 2023 21:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MoWzIPNn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2081.outbound.protection.outlook.com [40.107.7.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52404358B0;
	Fri, 15 Dec 2023 21:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hmrxNDOL9ik2SY4x9SlWtGwwjZjhNqOSqz8uX3VKeTDg/av/vBXuU/RlvGL1zzbhM+fUqQLs/YjM1d9XrPT9kwX2/eULYr+w4wFojmOIJjZ6ET6Lt+4vsfbnTbjjx8FcycbrkERLUKPpEaNVLbxtue70E3Vsanq5LM28A8e+xatrTZOytK4nabnZ4WpB7Tfm5BgFy4k7BUTdAI8dVTj59RvR7jvZ9kEhB6hTYyNNrC4qcVMMe27rgdezpL7Bb5X1CHVd+vbsoCcAwTlr0EtcvZpAARxGv/dz6T5Kg02uTTP7JoePEWdMdmpKLQv1KOu8L4394mFsBEpS0V+kdoluRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f06pJ8dPs7Tni5hIzB5LrTXTg8HTsmftsVMug+ylt0w=;
 b=FjfVdVca3vsjY3fMa9CTK9rhhRRhpYtlWDNw/9gIkTU7OltYqDpBGxg1eO4b+LtHYsqCbmpw0Cix2s2N1uE+ippY6XUBgtU+LbcjRcFa9Ft1yl9K31k+yYV5FMJbFFZij3vWsRTPr1WDVK0/hkh5SPN+ehyCQR7hhIp3tQSGZL/+zpzahhZmyakz2BySS01tMcldSvugD84uXUxotcGvpusNTYivtzMl2nPo797ruYllQ817IIt1jCB7NNCBzXejPOwTxcB92k4rmSqnBo09Llt4ah+GeAlLXkqON0eXSeglue/K/j6gTQMR/3hiM4TK9eCD/wnyZ6V55Z2i7ZCfRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f06pJ8dPs7Tni5hIzB5LrTXTg8HTsmftsVMug+ylt0w=;
 b=MoWzIPNnhVz4+3Dykoi1MS+24Rhlg8pF/FVwJkTN7K6JA+ADxT+9GIG9MZkZP5iqIApPsnjjjITiykq8lClWxRzjGb/4CJTUUNsmlVZZKSqd5vesmjrt57Yqo1WuiOX49FL27ZaezabQ4hFhQjCpz5lQ7aHLgNLzdHGT0yQsJng=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com (2603:10a6:208:16d::21)
 by DU2PR04MB8823.eurprd04.prod.outlook.com (2603:10a6:10:2e2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 21:45:27 +0000
Received: from AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4]) by AM0PR04MB6452.eurprd04.prod.outlook.com
 ([fe80::dd33:f07:7cfd:afa4%7]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 21:45:27 +0000
Date: Fri, 15 Dec 2023 23:45:23 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
	Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-arm-kernel@lists.infradead.org,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Herve Codina <herve.codina@bootlin.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	=?utf-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	=?utf-8?Q?Nicol=C3=B2?= Veronese <nicveronese@gmail.com>
Subject: Re: [PATCH net-next v4 01/13] net: phy: Introduce ethernet link
 topology representation
Message-ID: <20231215214523.ntk5kec32mb5vqjs@skbuf>
References: <20231215171237.1152563-1-maxime.chevallier@bootlin.com>
 <20231215171237.1152563-1-maxime.chevallier@bootlin.com>
 <20231215171237.1152563-2-maxime.chevallier@bootlin.com>
 <20231215171237.1152563-2-maxime.chevallier@bootlin.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215171237.1152563-2-maxime.chevallier@bootlin.com>
 <20231215171237.1152563-2-maxime.chevallier@bootlin.com>
X-ClientProxiedBy: VI1PR0102CA0078.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::19) To AM0PR04MB6452.eurprd04.prod.outlook.com
 (2603:10a6:208:16d::21)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR04MB6452:EE_|DU2PR04MB8823:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bfc1dfc-ec51-499e-a7f8-08dbfdb72689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zhgkncRdcLUlLSDLXlRjanNV0H0htOKWFMBgSA49wz61BuQxNivlY2RFNrx1T4RLhVVFQCDi151Q5DCEpVAhrBFdqoaZP+P2sgig5trSDbgPvl1zS4GAb2NRRK0ZhsOwOimBcU0lritLjtyxsWJMfcv9u0ojjRpghmo8lgE0kNtkjaqCL0Gqf3HDXJ0/fAgVO9qAu8vjC3pqyQYEugWxr2bPl0ApPCcJFtOqfi3kZdL115HE+/7pPvlBwwMCqgHkLXMgTbQdvFDvGVumHDOyMeYG5dO4mAaPBTVO6nygvkdenR6pgL3b8KTwQsA9q5qD/e1aF9ZLcGKT0yDsQxQbgG4D/Q5uwJeNg1QPJpTz87fhaitZjvXjSGempZudysL91VsREXiWyrE+rmgJK0G90fZYPW1omA/eiB/3R2LSXqePpL59L+sojR4MJ1iYVhjEMMcbNztj+N96Pdqg+EufVobxLNpDitZnHE81TRyadkSd2vFKXTZKb/zKGq+4OEv3ibmSBO1QhgGRjJeA79hyrqzezwb/fY4OR1fzm3w2+l6HHS+5FgcToPhWXkvtZQhJA0AyDkgLpx41CTTxbhAj7obpNdFBxPaw76hpmMKGZdwdTmqG2MWXSBQ2lqSgM0O9
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR04MB6452.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(230173577357003)(230273577357003)(451199024)(1800799012)(186009)(64100799003)(26005)(6506007)(1076003)(86362001)(38100700002)(83380400001)(4326008)(5660300002)(44832011)(7416002)(6512007)(9686003)(6666004)(6916009)(316002)(66946007)(8676002)(6486002)(8936002)(54906003)(66556008)(66476007)(2906002)(41300700001)(33716001)(478600001)(45080400002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6Xs1Xq13eGdp3xcpNSB3Yyk55AEXo95fDwrue4g6hBWrbQT2TkvZlO/Jn5fV?=
 =?us-ascii?Q?n912z9dQy2HfuGobofhixCRptQ8vkUARg/6b3AUKYSic1YuBW87GEb6MMUip?=
 =?us-ascii?Q?9VWBkllUzzXq7UxewCFA61+OEIo4936k3PyU9yLLGJuJMiBB8Spe6UXVDL4P?=
 =?us-ascii?Q?IniUQMfWYxoKElVs8xh087iTsqG1BnVJqfMdRurC4oSllEe45NSf7ga8Yk5e?=
 =?us-ascii?Q?PEBvdT89KgX/rwxCICeTI25k51Q/jQlCVk0JBk/Op6lREQNVD2zJzsDzxlrX?=
 =?us-ascii?Q?FrKwOA1oOZ07LMywYT/E9Ey9cW/wX1anYbxyqGs+fEfxQhaaWtVPbOqkPJ5O?=
 =?us-ascii?Q?moyzqoFLQnBo4QjRkeTkqMS0oQbcuLnNrE08wVPmLItAMJYGi5Z+BUw6sgll?=
 =?us-ascii?Q?fqnTbgYlXMmQHKy5/HwbdGTpD57RPXmemr8YwWdWl/v8IA7Q7lseiNNKkbGR?=
 =?us-ascii?Q?9EElTcQ8CyJvsNjpUMtfx9aNjwe806E/X5m8ZJ5AoCFtsR2FAriJJ43rIdY0?=
 =?us-ascii?Q?d/DOeemFz1Ic5EhLThnI+oZg6lP9oh9Hnm9ohqJGJ9PxAtO6p4ZpIwiitD2Z?=
 =?us-ascii?Q?+kOTkz+axkYGgg98QkqKRY7PRBpB6MJjP8S2ZqQrIaQXxmpPTeZbKTYRskCm?=
 =?us-ascii?Q?fp/RlhlMkC+eUV19v4U45OMmm1oBLYqgBc65rlLE/6l/Blom6qtrPQa/XKoj?=
 =?us-ascii?Q?kwytYKWU1lVaP9U+ZRjkyFHJeazf2cH7zsyOUfFTBX55jRicxCukKg0b+RHP?=
 =?us-ascii?Q?u3cogWNx2rJOFLRrAOcx9mzA4X57M4Nk/tgtjKVEckNLgiY/H+uUEtvZPKvi?=
 =?us-ascii?Q?+Ow9jX2w7DxR3qMarU57YSRZcoKQTX187ar4jPM7RQGxGJuqfMJNYsZOhRoI?=
 =?us-ascii?Q?nkxQIOgibID9FrjfUN/gx9p8oa6LXw1qXTyCAeZAvQRFXWwEJNbcOofz3Mgc?=
 =?us-ascii?Q?KIw6Ngq9pkE9r6AGq8y9aRhj8KpaTBQvK6jlXdV5mLnbZlDxKNCK83yQqzDl?=
 =?us-ascii?Q?H0r6uy4Jkspm56JkN5q4mXtGeC65WLxQYrCKuZcYQiKM+8+ro+wmJHxc9iIE?=
 =?us-ascii?Q?83sk1hFk14lPH1jfYDpwzrlpT4GW1rTb94R2WUqznMLpd7fpjVjygLlaKNp3?=
 =?us-ascii?Q?/XLS+sEXEeYfvbw0XprUvp3jmw/mof9T5xscvLt54gA/5abGEszLKT+fTSDb?=
 =?us-ascii?Q?gDbX4gLqxMK1yCb+Pc4SZ7tElgnZTr+DlqPlYJ7vOm/mQ4Ex4Zrzk3tEV9rZ?=
 =?us-ascii?Q?rJLMsK7nEXgOPZZcgtGJs9kvwmBIiCcqkzoi8zNb3d4ll6aZqGvktfWc/+Zs?=
 =?us-ascii?Q?YDXvO5jFlkLlBw7eoHIh4+CJcpDUTmG+kDtrA3tqWhPga0+6VaTspFBsitBN?=
 =?us-ascii?Q?EyOkUivqHOUYSTSiCLTxLmrfes3JaPNKR9mcqqL/Ra5IcEMIHlE/ro8sl+86?=
 =?us-ascii?Q?f0Ti+8Qine3sVel2TmLhHuzKmgfQ03VlfWWd/aZZ/FJN8zV5UPyt6n0waeFE?=
 =?us-ascii?Q?zxttb4sPjoCSUK9Yn8hmw2ZNmWpwXaqWYaSMUL1qXhgHN6Qs4cBL4FmSGm6u?=
 =?us-ascii?Q?/BNQcu8VSnx0NqISM3t0PzNs7F3cbPvTO3XRwaF1euKUeDwKGuv0OgGXQUj/?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfc1dfc-ec51-499e-a7f8-08dbfdb72689
X-MS-Exchange-CrossTenant-AuthSource: AM0PR04MB6452.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 21:45:27.2991
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ccs/ewb2ZZ134BcVDPn4SvIC0V5ANB5exj9my/Ju2x7FK9riueFxqidMCIS+dewwdyjWWfOTFyZsIIm1nFB5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8823

On Fri, Dec 15, 2023 at 06:12:23PM +0100, Maxime Chevallier wrote:
> diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
> index d8e9335d415c..89daaccc9276 100644
> --- a/drivers/net/phy/phy_device.c
> +++ b/drivers/net/phy/phy_device.c
> @@ -1491,6 +1500,11 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
>  
>  		if (phydev->sfp_bus_attached)
>  			dev->sfp_bus = phydev->sfp_bus;
> +
> +		err = phy_link_topo_add_phy(&dev->link_topo, phydev,
> +					    PHY_UPSTREAM_MAC, dev);
> +		if (err)
> +			goto error;
>  	}
>  
>  	/* Some Ethernet drivers try to connect to a PHY device before
> @@ -1816,6 +1830,7 @@ void phy_detach(struct phy_device *phydev)
>  	if (dev) {
>  		phydev->attached_dev->phydev = NULL;
>  		phydev->attached_dev = NULL;
> +		phy_link_topo_del_phy(&dev->link_topo, phydev);
>  	}
>  	phydev->phylink = NULL;
>  
> diff --git a/drivers/net/phy/phy_link_topology.c b/drivers/net/phy/phy_link_topology.c
> new file mode 100644
> index 000000000000..22f6372d002c
> --- /dev/null
> +++ b/drivers/net/phy/phy_link_topology.c
> +int phy_link_topo_add_phy(struct phy_link_topology *topo,
> +			  struct phy_device *phy,
> +			  enum phy_upstream upt, void *upstream)
> +{
> +	struct phy_device_node *pdn;
> +	int ret;
> +
> +	/* Protects phy and upstream */
> +	ASSERT_RTNL();

Something to think for the PHY library maintainers. This is probably
the first time when the rtnl_lock() requirement is asserted at
phy_attach_direct() time.

I haven't done too much with the patch set yet, so I don't understand
exactly from the comment what this is protecting. But I get the
following assertion failure with DSA:

[    4.157160] ------------[ cut here ]------------
[    4.161805] RTNL: assertion failed at drivers/net/phy/phy_link_topology.c (35)
[    4.169124] WARNING: CPU: 0 PID: 26 at drivers/net/phy/phy_link_topology.c:35 phy_link_topo_add_phy+0x128/0x130
[    4.179263] Modules linked in:
[    4.209232] pc : phy_link_topo_add_phy+0x128/0x130
[    4.214040] lr : phy_link_topo_add_phy+0x128/0x130
[    4.293822] Call trace:
[    4.296271]  phy_link_topo_add_phy+0x128/0x130
[    4.300730]  phy_attach_direct+0xbc/0x3c4
[    4.304752]  phylink_fwnode_phy_connect+0xa8/0xf8
[    4.309473]  phylink_of_phy_connect+0x1c/0x28
[    4.313844]  dsa_user_create+0x318/0x5ac
[    4.317778]  dsa_port_setup+0x100/0x144
[    4.321626]  dsa_register_switch+0xe90/0x11f8
[    4.325997]  sja1105_probe+0x2bc/0x2e4
[    4.329759]  spi_probe+0xa4/0xc4
[    4.332995]  really_probe+0x16c/0x3fc
[    4.336669]  __driver_probe_device+0xa4/0x168
[    4.341041]  driver_probe_device+0x3c/0x220
[    4.345238]  __device_attach_driver+0x128/0x1cc
[    4.349784]  bus_for_each_drv+0xf4/0x14c
[    4.353719]  __device_attach+0xfc/0x1bc
[    4.357567]  device_initial_probe+0x14/0x20
[    4.361764]  bus_probe_device+0x94/0x100
[    4.385371] ---[ end trace 0000000000000000 ]---

Someone please correct me if I'm wrong, but at least up until now, calling
this unlocked has been quite harmless, because we call dsa_user_phy_setup()
before register_netdevice(), and thus, the net_device is pretty much
inaccessible to the world when we attach it to the PHY.

And, while having the phydev->attached_dev pointer populated technically
makes the net_device now accessible from the PHY, this is a moot point,
because no user space command targets the PHY directly. They all target
the netdev, and through that, netdev->phydev. The netdev is still
unregistered, so it's ok to not have rtnl_lock().

It is rather going to be something that concerns those drivers which call
phy_attach_direct() after registering, for example from ndo_open().

Interestingly, phylink_disconnect_phy() has an ASSERT_RTNL() in it
even though the phylink_attach_phy() derivatives do not. I'm unable
to ascertain whether a previous unregister_netdevice() call makes this
requirement redundant or not.

> +
> +	pdn = kzalloc(sizeof(*pdn), GFP_KERNEL);
> +	if (!pdn)
> +		return -ENOMEM;
> +
> +	pdn->phy = phy;
> +	switch (upt) {
> +	case PHY_UPSTREAM_MAC:
> +		pdn->upstream.netdev = (struct net_device *)upstream;
> +		if (phy_on_sfp(phy))
> +			pdn->parent_sfp_bus = pdn->upstream.netdev->sfp_bus;
> +		break;
> +	case PHY_UPSTREAM_PHY:
> +		pdn->upstream.phydev = (struct phy_device *)upstream;
> +		if (phy_on_sfp(phy))
> +			pdn->parent_sfp_bus = pdn->upstream.phydev->sfp_bus;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto err;
> +	}
> +	pdn->upstream_type = upt;
> +
> +	ret = xa_alloc_cyclic(&topo->phys, &phy->phyindex, pdn, xa_limit_32b,
> +			      &topo->next_phy_index, GFP_KERNEL);
> +	if (ret)
> +		goto err;
> +
> +	return 0;
> +
> +err:
> +	kfree(pdn);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(phy_link_topo_add_phy);

