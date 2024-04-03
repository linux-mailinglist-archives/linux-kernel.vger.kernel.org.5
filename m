Return-Path: <linux-kernel+bounces-128947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD94896227
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:42:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2FAA1C24AA6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 01:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861EF18E20;
	Wed,  3 Apr 2024 01:41:23 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2112.outbound.protection.partner.outlook.cn [139.219.17.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BB9182A0;
	Wed,  3 Apr 2024 01:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712108483; cv=fail; b=DKunl/jDWV1E8SbwJJZqjbH7YTJe9ktdsLyUWsD0yoWBrvm8EI2YyE0OFai35i+hPEO7bVIrBeOn+4aUWbWpqKXf6SLk87Q+YFMraD4KjFPLeERZkaDnNQRD9hdrTXDHd/gV+9Bq3kDcWMdWBZLLoEEv6va/bvC4xCmPozhcF9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712108483; c=relaxed/simple;
	bh=xuzmXwl0jyxkepXtnCK/TjDpBcw+aXeoMOShNR6Fwcw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VIM2Zzg2FwXwfs6zZhDaZO4BluvZe5zc6qtSUxFltKTDaS3tKvBaHnjFZhtDJMu6sllgRcDVQl35FyLgFKIhCLlKP5lj70/YiKbmqu0bHvmQP5O0wFKx/5jVOLX8BRUONuShzd9CzpaFaVy9UMMLzJTWqaA/zYZ8KZiAuq5loTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jnmf0bHlFz34Yg17jE9+A5YG79w7irCI+xRR5UhThhWJQKmC9QzwbZTvn92fSRgWNVrkRgTlK2cfGmea7kHgGZlgj82MJehhRWQCq0WG1zxHsl2VNqTYJRKOrK3sH8HMUQAdWXQRjj+4c2qKTLHOzMSBAsM5UMBKlB9+wOFrK4UQFRTFLg75DgaPjg/3zXob85OTNXRn3ZlsBiCzzkTgKfS0TUzmgtAzpElK098ed7AF6W8jJWj7mT8xAHBe6p3ZV/EC8P0aLY5KVjx6H5gcFJ8zRLTwagF8MJvMOjnaFG9f1dAFKGBvdBW9OSiEfqG/7yBGQ3E2bX5QaSDq15PcnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7vnNo9bd/zTfR1nAwLAprCJ80qWZ48/Sm1QXUJGRfis=;
 b=X7fs8XYdvKvmXVjqV42uAIfWpIuYw0ZPgDcyG41lKtYraPX0rcC2AGmgOtYRLaQUrxyVma/cmzyBX7RBoWnMC45Lv3YzW9mRH8KLmcXwgovvNyR9ObtOYlN95XddzUMNVo1UM6uyfDeVPW0k8kI935uaLbbQqnNbNCz/UdvGNGQClMgnlbm2HfBxcNBr9IAwT8Y32rzaM8fKh4YZlT68s91Y8+XXKlFJNF/q7ggeJ9SpFM6Vlk025rEDbWkcslYLMmX8x1NU9f/uGoN+7b2TUkbIrFQxslaIrvT3h+2H7FKpgQXfVA9RRI5R5yDAOPUXmSmV8Jp81L5+0/vnVcHzFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0847.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:24::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.43; Wed, 3 Apr
 2024 01:41:09 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::a137:b8e5:8a0e:ca9f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::a137:b8e5:8a0e:ca9f%4])
 with mapi id 15.20.7409.042; Wed, 3 Apr 2024 01:41:09 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] net: stmmac: mmc_core: Add GMAC mmc tx/rx missing
 statistics
Thread-Topic: [PATCH v1 2/2] net: stmmac: mmc_core: Add GMAC mmc tx/rx missing
 statistics
Thread-Index: AQHag96avQqP5Wam70CUDUnMD23smbFVw26AgAAE1KA=
Date: Wed, 3 Apr 2024 01:41:09 +0000
Message-ID:
 <SHXPR01MB086358DEAFDD853ED4103D57E63DA@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20240401024456.41433-1-minda.chen@starfivetech.com>
	<20240401024456.41433-2-minda.chen@starfivetech.com>
 <20240402182351.031f5b59@kernel.org>
In-Reply-To: <20240402182351.031f5b59@kernel.org>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0847:EE_
x-ms-office365-filtering-correlation-id: 24d8e265-8c25-4e1d-203e-08dc537f2335
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 nbuOHKwgIVS4dIddUiZYgBscc9Wllzu09i+TN+76Tf/X9HpBrxhCdfDZPAKvFldVuXmKrKATwoC8oLFZkxz/2m5hLkef7vaxmol9ZREN53oZ2OUq67PUjjQEReZEB5PXWXHpfetZMRpF50TQXbfHCbzhaa31fGAdpowRx18LjB0QkV4Mp4SUmbn6rLTzZJ0+49dXLluo0mR7o2Ql6oZtI7lV9+mmjdiHGbZDnAuG0ptiP3jMoC1K2UDKLgYy4whak4g34SfJvkBfFz58Zd8xz9F8vQJUJYWJz/ZtalR6iZaD+sVd+BExvR8gbVdgBc6/lZQzUnZ7lUryfGDiNpT6hr/1iNIeT167JLOZeS0i8QedIooDaoMJsO1YMc9WzXx6qYPu4BJw55zjFIaTZdTLflTOmJV6aKCgZ4SysPoXkDM48nBpiMcLGqGcKx/m2wWLBrWRysq7HZ7rEt2pP8lJjgzUCQzSM53DNZsnRv6Zk9wj/yZZ5fDICQ29Kzu+jpDYuqAKtBdBS4CbG68CjjD+rOE6cmvAZ6zWCoR8lFVOSTCix1904kB0bXqWz+3QcHidFk3w5SXS6R8OUXmf+LmJX6mMCpYLxskl8yxl77op8lmOfZ9rVTVpV1px2k3gGpYG
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(41320700004)(366007)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gg4UoGmpQbAzyybkDbyXxRcmbi9wBRTRNu35KUSeLfvwtzjdlLBQB3K/U+Nq?=
 =?us-ascii?Q?8Kf+sJ4RfKPK0qN9OCTiQ7eYxbJTMT/k11Bilf6U9b0JzcgAHMHapawyFuSv?=
 =?us-ascii?Q?eD5puz7GoOa3ItaW+yOT2inSsfeRuVCnIGUOSk6NLarVSI79/D4TnLWuV6sz?=
 =?us-ascii?Q?QWYc/ihuZpNxdwIDd7dnigQukIBjLUZ7zQuvalT016KDCZxI3SuY0YjdDVZZ?=
 =?us-ascii?Q?4Nwj5mmNvofncD+14U0BXJhEg5/DwQ06+Y4WAiW2A5YUfFiqf1u4FLD36ltp?=
 =?us-ascii?Q?rr/Cz7IaRcZgttgd0y6QFqZL/bpXeVG3mGYwcirtKnjA3usUqkEU8/zbPq98?=
 =?us-ascii?Q?W/iZfhY4rqqr6pcVr2pJyQV2HBHDPiDRql2fjUt03IdgLM36lyMNM0oALTUN?=
 =?us-ascii?Q?kIuX1i8vODPxfY+A/Zczpns0CEHu4JHitZ91NdRzjt+5hF33c6CUgcovjlnD?=
 =?us-ascii?Q?q4kSR6J9qpPqITSodVg7tPjAwNSgeukisRTJWL+yzZ76HrjYjghAeQGmFwaF?=
 =?us-ascii?Q?nJKYx3MjGP7Cp7FLNMFW1/FIyKM+ElBXqbI9SJSeKm3PwFtzxQEZYSFX5+cG?=
 =?us-ascii?Q?PiCE/B9RwdxZRB7Dc4VvB6pJLsrpEhYAV+tnC6KAN1Bk/zjBx7jRour+Qi7s?=
 =?us-ascii?Q?E5AK4YXCY2TJiSpjEY1L5DehWWu7Al7nCyBaEc1iCg9IbcRuh4Z+dQuEE7BN?=
 =?us-ascii?Q?HpFQNcCUMr+jlJt5spAJokEc1lFsAZ5hKO3Z8ysmtkF5OEI0lbKtbwmkzNDx?=
 =?us-ascii?Q?f1T+K1D/ToFaEI1QX69iSrL49BWvC2DmE2rcj+rJ0xvygDE6QoF5AyGBYLNo?=
 =?us-ascii?Q?4j59ddhLM5tICTUDI6XolR0JLdFh2YuCNVk3dYJ+qmGR+/wkW7W9brm4/vdb?=
 =?us-ascii?Q?Bjt/+K9d9Y9+aUz6vemR7oQvc66ijdaavt4k8dmK5mFc7E2vXVooHc/jvb33?=
 =?us-ascii?Q?9Uvmq5uIUMwzdmWWnyv71FUgNYkgi4O+Yjm+5xe6rCexhOpZCi88sJPWvCJO?=
 =?us-ascii?Q?G03XtsWH8iuHOUTtcF4E+8KbBs2kT/tp+zaCh6ivyfk+D7cBKHQlQiILkEAe?=
 =?us-ascii?Q?09uwRBQAItKBbLRL/IVFFEZTTV/XmO1KRL7E9jOG8aXn/Opvc2COzBJTomkd?=
 =?us-ascii?Q?QHVQIxWaYo5obk5gzlQN9DLHkJtiaYLeDyrD3l+m5JzW1I9BUUFj0qI4Qb7T?=
 =?us-ascii?Q?QAqYij3ZQlBYYmqsV53myaJa12RUMYaBRfn2ugF6fB3kdSEXH6EE6hX79E42?=
 =?us-ascii?Q?nbqi3PsR2lWzuNAZFl/3Kdux1WntHEcbxa5KDHvx0GTU/yIKPLVixg34NMkG?=
 =?us-ascii?Q?YSOoQg96q5m/rjM5J5Du5zB1vRQxqcO/BpozIAma5h2wrleNdi/cv1Wyv7lO?=
 =?us-ascii?Q?85G+UdS5DHsHs3BL9BOVOaqQ/dbTgmkS/lnb4oPgtzDrf6lSB9/LZvGTrBkf?=
 =?us-ascii?Q?BvevyTSx5zzdfwnW7bFuKoUOuEN6B3Raf8qM2QaaeoNTVVUi9omcJRHlH6RM?=
 =?us-ascii?Q?c4TMtHyyiukj2jFdSxMpq5rUEGjYolza3GrBP2l1cX3ZHl5AJqlN3rk3O8+G?=
 =?us-ascii?Q?F123x2Ke9ZlIva8Nf0Agl82THGXfw5CDO1OaONgW?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d8e265-8c25-4e1d-203e-08dc537f2335
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 01:41:09.5990
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vCO3hJOhLkbOkZIzPloOI3v3h63zvhPy1CMrIXTddTiBfmsjxXhowZNlDSHBWF0steGtm9RwQAkXZkoCF6NNUL/hDs/tz6iE2k1QkDmXMkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0847


>=20
> On Mon,  1 Apr 2024 10:44:56 +0800 Minda Chen wrote:
> > +	unsigned int mmc_rx_control_g;
>=20
> What's control_g?
> If it's number of received control frames it should be reported as
> MACControlFramesReceived from ethtool_ops::get_eth_ctrl_stats.

This is explanations
Rx Control Packets Good
This field indicates the number of good control packets received.

It looks it is number of received control. But I don't know register offset
in designware XGMAC IP.I can't implement ethtool_ops::get_eth_ctrl_stats.
I will delete this first

