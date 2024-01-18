Return-Path: <linux-kernel+bounces-29622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 045B48310DD
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:28:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DFEAB24DE0
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE257481;
	Thu, 18 Jan 2024 01:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Jfv1rg4C"
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on2059.outbound.protection.outlook.com [40.107.105.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204643FFF;
	Thu, 18 Jan 2024 01:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.105.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705541244; cv=fail; b=We7WUdn79Ju7XFDvVNNAov8kBv2ymVW5k+V2tkI+zu2xeCtRbCiDsSW5k4F+ZzUGVKcMjhhvGtg7Y5dNbJGDWn6IfKST0g7wrLbFehJyX3YE8PElTTv5g2sYmI8lhQ8D+mdGNG8qGmgCzPgdoK1fB7mglhktjrdRSsTz2m4C6+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705541244; c=relaxed/simple;
	bh=k2ep/By8VyZLhkkqwwHYRGSTfm8EyH2AJsjJJEkjqIs=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 Content-Type:Content-Disposition:In-Reply-To:X-ClientProxiedBy:
	 MIME-Version:X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=Kx4mS0C3bomTwI4oNy1qZ0sS4s9rLP5zEAPySmmG2r63d6LWpxB9lhmbiC4QI3qKRuEmBfAZaxcfBeHmTukH13VaPynOPTynsym1Lw7X2finCwBSecCRYtiRrWbl7B+ch83JoqAOYhIcSiYlGyoYcbxTi1DLBZ2h3OcRdb0m0io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Jfv1rg4C; arc=fail smtp.client-ip=40.107.105.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TLrQxQ0DQuERYJlx85ioHl9ERTdO/X+zvK6F0YOMF94yKX1DLyWepUZIeR3mzyQAAdPKLV7IIowSIYkdqxXUQ9ssW8dg9xtHllvbXdxtOW/4EoByT6lz8f8eSOjjWK5Dcc8rmnYKgUDUok76xhgCtwxqot2LsGAjfDi9QZhVKRmU//EOBqQhwcRbYUUXPL3O8NFlOZf4i9XCn+bJ7vGfn5iWTCbL8v0KDjtyThvCCs71RP9Bg5Uvvp7T5ZXt05GLxlo9bdP6n0r5y3kLLSZhMeOB5X1FrWLR91dzbksy6bM0FKg7SlmM1wAaOw25TZJPhBnrFluQs5nVdpi5lNakHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dNr39vLLvGg6YzYeuxd9LdbAXOoMm27RlSRglmMh0VQ=;
 b=Tv9JMyrhss90C99+3nNnnrFSnJduvdCc4nKf8dITZlZF/N1bkCoyOv5o2vPb1BDdOi5dqe+XdknnoP1LxDgoilCiT6mhN9I5T/fM/NHDigT5ndAmylSt00mfPzimS6zNQqFgm26STG3z3XAp5ORadXHShz31oMFjmXygxavjGZgPuuDaZmCAuG3BbIQ1IrYOpVqPD6+V+Y1PD96dkk9BuJ8+zi2fAMFPkVL1B2O+4n7Jiib9P6q0848jVh6F9oRmBgVHhvZm5IBzGmKFf1raHsKCNpnI2UDT7sbrC7vkG1fh5DAvLbFwpW2IX5UKke3oa5wfhrxC07kVMFp4/i9mmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dNr39vLLvGg6YzYeuxd9LdbAXOoMm27RlSRglmMh0VQ=;
 b=Jfv1rg4CdkbgW9NlX/ml67KUG4DulK3jN6Cv30SLtP5GsJPHNVvJxiJFYy7O204xg57sfvGFXjnZAcuzqn5OMpgxJlIgEzjMYbp40VjyOVUMOg0i1ykCUxFus9tlHU3bo1eECULSCAujH4jxJHqkFFZjN0WNBg4Nt/mJLsRbAJo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com (2603:10a6:800:1ac::11)
 by AS8PR04MB8900.eurprd04.prod.outlook.com (2603:10a6:20b:42f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 01:27:18 +0000
Received: from VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34]) by VE1PR04MB7374.eurprd04.prod.outlook.com
 ([fe80::62cb:e6bf:a1ad:ba34%6]) with mapi id 15.20.7202.020; Thu, 18 Jan 2024
 01:27:18 +0000
Date: Thu, 18 Jan 2024 03:27:14 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Roger Quadros <rogerq@kernel.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com, r-gunasekaran@ti.com,
	linux-arm-kernel@lists.infradead.org, Roger Quadros <rogerq@ti.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>
Subject: Re: [PATCH net-next v4] net: ti: icssg_prueth: add TAPRIO offload
 support
Message-ID: <20240118012714.gzgmfwzb6tuuyofs@skbuf>
References: <20231006102028.3831341-1-danishanwar@ti.com>
 <20231011102536.r65xyzmh5kap2cf2@skbuf>
 <20231006102028.3831341-1-danishanwar@ti.com>
 <20231011102536.r65xyzmh5kap2cf2@skbuf>
 <cfb5edf6-90ac-4d2a-a138-981c276e24bb@ti.com>
 <cfb5edf6-90ac-4d2a-a138-981c276e24bb@ti.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cfb5edf6-90ac-4d2a-a138-981c276e24bb@ti.com>
 <cfb5edf6-90ac-4d2a-a138-981c276e24bb@ti.com>
X-ClientProxiedBy: FR0P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:15::14) To VE1PR04MB7374.eurprd04.prod.outlook.com
 (2603:10a6:800:1ac::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR04MB7374:EE_|AS8PR04MB8900:EE_
X-MS-Office365-Filtering-Correlation-Id: 4738f4fd-a85d-4673-26e8-08dc17c49c1a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1ooUODay2BqJbTdTAbWjT0W0STFaNZAZOr9zLTyBLCTXocRoPjrmk3NOZ+8VyXK5ZYfaPYB8dAxJS/4WtujXsapgnz9tDx3iapAZUmRd2E4lJbs/ufIxl6HtCmiFmvrm/a0+MG8OUTjF9EhD4xDa0GSGMDkXuSHNfKsdFPACzPyHr+DkK/VRNb0+Va/4uaUiTZxXblfc2/w+cxzTz6t1zlQNx+m4N7mtK19c6LSAYiDY0kGfm+45WFZr8U61Vdk7Vo/UVfiwjfvhSdOvIujuRyIYbhF16BS8FvzGgP4X0y1mwvTjHzV0pscR/+C3uKYBdKms0lNVpGQYpHRAWKFCAFbVKjxKLyndVdT/x3sMi8gI4apVD/O8SoD3K565v4zA4WJqLM0p+CWuIrDKfPlKbW0i3FTWliacLcJeEg8U5tRvXjY5Nm4GSEspqvFkSbap/u/VNQufXiKgkiolV1yxXIc97MoZceCYD4UncKu7P86K3VArNlfXZRIVDTZbmNWyAsKAEbr3D7IRdIn0kSCU0h/FXjuR4czvXX/6ekjfSS2xrNRQXTn+xzMcDKu8rOZo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR04MB7374.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(83380400001)(6486002)(38100700002)(478600001)(1076003)(26005)(6512007)(9686003)(6666004)(6506007)(33716001)(54906003)(4326008)(6916009)(66946007)(66556008)(66476007)(316002)(44832011)(8936002)(8676002)(5660300002)(2906002)(7416002)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7g8ejC8FkgSGrWtaYnzVIfyBBaiecWGmZboy7iYJTnRaTLXiNUgz7h+Bn1in?=
 =?us-ascii?Q?CTk8zB2V7aVc91u3JlMG8KZ6NCzW++Cs5Egcw0dhELWu2ZY4tdn5ZAHu0NNo?=
 =?us-ascii?Q?EFUg2iVMQTc0XAAVcfTphn+chA67SlMFkfauXdIIlSk7FD6FbhGz4JLYgG1I?=
 =?us-ascii?Q?z1QMYcXdq6uBZ6p9hJPrI+PZ5//byZmgi4RQTmA7ffGw5svvcCiaKe9SVrfZ?=
 =?us-ascii?Q?qp+fMorUzin6FpdWUYPduLWWT8B7+D2Sn+TgIFXZOk1h4e5joaeyLulhC5hs?=
 =?us-ascii?Q?HkAX1nxXqb6zNqnVRcH3OSQUgTg3fPdcv/U43YidEjf/w+Sqiu6iMXV6YQnS?=
 =?us-ascii?Q?HAtj/oIRyTi6DCH4mTLGw3sNnXauZau3GwoyLfWchtRn1Pyie80/muZeWVP0?=
 =?us-ascii?Q?8OG29mp/MV6NYEvtSy+BeoYy7WIdfdoLSB0ya+r/YWj2O0ZMA/X9rcxnfKXG?=
 =?us-ascii?Q?qnVqzkUV2QPlIBjRnMDNQ4HUQ8g5+EF9EtfhpoqCgL9KPVevxVh0geGmIVZh?=
 =?us-ascii?Q?tJ/e/WB7zJn6QRiumwF8wpcVzcP9Endmg1w9YmjpXU+w6X8BKCPH9EtSFHdt?=
 =?us-ascii?Q?JHH6FucXp+wT8Jmy4klIk//vz00HJ+d1w3liT6NtwNY2mJyNbYe1BJluzJhK?=
 =?us-ascii?Q?++nhpOlK6V2kil8CnxumDIHJUYlt56HPrfpP4Q3v0tF7c3C5SbSXS0opJ9Rj?=
 =?us-ascii?Q?4aDS6lcEklng/O+oG5yugkLY7zCqFkHPaxVcFmskjmF8Zw8cjkYRc9atTfZO?=
 =?us-ascii?Q?BGdJEFdAwHsunMdtAEpelDaKk7VmoFcYIeOD5Pvjuv+X6ri5ntAYqqauKcm6?=
 =?us-ascii?Q?h2mtrwN08PL64yNJPtDao8Rc4Z6GZs6l3XkxZ1LQWsPdxxwf0badL0LdmTs+?=
 =?us-ascii?Q?C7MYiTCIR6C4ZSVWuM/KoqS5LwAghfl3yE/Ls1PINBXMVSp7Ov0h9b9MMhwo?=
 =?us-ascii?Q?E92LVZavNoeK/dXhKcy5T6nybTBQeJbMjSIcYeCpOqsvyo6aXcQk8EDqEzD0?=
 =?us-ascii?Q?H7FPWit2rt5y/XtWNgmtFr7U9dFrvqA2bhH9lvIToK9HkXaqg0h3SILXDUup?=
 =?us-ascii?Q?a/RSRqzxkHqMELC3wZW0dSM2i0zrlZFv1/sBRNlXdS1iQ5P7r7fIqcveO9fY?=
 =?us-ascii?Q?LGPX+R4scjm20sAXrwybez9vfzOF7Omf7EAX7wQh5LcjxcwR0qxhm7x6i8sr?=
 =?us-ascii?Q?2GNxs1d0kZpe4UYjw6hKzjj4R4oijMG6fFD9qj5r1aUE51Nx9t4wVUQ5xHbU?=
 =?us-ascii?Q?N8Dpukx6azoH6MLgMkFOCWn2I9rrbLckUtWCL1v54pLbIHVzOC3qnw8NItHm?=
 =?us-ascii?Q?CIOROO4Ph3WtXBR/dbmomCyA170scgK5Vt+OXhZEd/T2nnc+soxpyYtCYyaI?=
 =?us-ascii?Q?ddvT/jB3yAfYB8jj9y1etioZblftvK88dd7KsvXtJzw+9iuSwjWA8kOxc3tb?=
 =?us-ascii?Q?diz9Znb2hLoDs0t4V9K60FEJWBtI6gceqvjpjZ6iZc0gYHOKpcClZJmaoexv?=
 =?us-ascii?Q?UCWySUbNh0WfRGi7igBhkIMvYK1ohaSDxbkVC5Mga8ttWshhyicG9pj6tGSL?=
 =?us-ascii?Q?R/MOh2z+lQmRZ9ow53xG000PgA5WddapauVIf6K0EFqDcngVPx+4VZS0eFTr?=
 =?us-ascii?Q?+w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4738f4fd-a85d-4673-26e8-08dc17c49c1a
X-MS-Exchange-CrossTenant-AuthSource: VE1PR04MB7374.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 01:27:18.2279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NyORTdSe2tvRqWgQowLjuZxCdBYLwAvP1w+EbGw8stH13g9YGf/1Jt6wrXnE15xcwZXieMNIURAjSvnDL8j33g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8900

On Mon, Jan 15, 2024 at 12:24:12PM +0530, MD Danish Anwar wrote:
> > I believe the intention is for this code to be run before any taprio
> > offload is added, correct? But it is possible for the user to add an
> 
> Yes, the intention here is to run this code before any taprio offload is
> added.

Then it is misplaced?

> > offloaded Qdisc even while the netdev has not yet been brought up.
> > Is that case handled correctly, or will it simply result in NULL pointer
> > dereferences (tas->config_list)?
> > 
> 
> In that case, it will eventually result in NULL pointer dereference as
> tas->config_list will be pointing to NULL. To handle this correctly we
> can add the below check in emac_taprio_replace().
> 
> if (!ndev_running(ndev)) {
> 	netdev_err(ndev, "Device is not running");
> 	return -EINVAL;
> }

What is the reason for which the device has to be running, other than
your placement of icssg_qos_tas_init()?

> >> +
> >> +	cycle_time = admin_list->cycle_time - 4; /* -4ns to compensate for IEP wraparound time */
> > 
> > Details? Doesn't this make the phase alignment of the schedule diverge
> > from what the user expects?
> 
> 4ns is needed to compensate for IEP wraparound time. IEP is the clock
> used by ICSSG driver. IEP tick is 4ns and we adjust this 4ns whenever
> calculating cycle_time. You may refer to [1] for details on IEP driver.

What is understood by "IEP wraparound time"? Its time wraps around what?
It wraps around exactly once every taprio cycle of each port and that's
why the cycle-time is compensated, or how does that work?

> > 
> >> +	base_time = admin_list->base_time;
> >> +	cur_time = prueth_iep_gettime(emac, &sts);
> >> +
> >> +	if (base_time > cur_time)
> >> +		change_cycle_count = DIV_ROUND_UP_ULL(base_time - cur_time, cycle_time);
> >> +	else
> >> +		change_cycle_count = 1;
> > 
> > I see that the base_time is only used to calculate the number of cycles
> > relative to cur_time. Taprio users want to specify a basetime value
> > which indicates the phase alignment of the schedule. This is important
> > when the device is synchronized over PTP with other switches in the
> > network. Can you explain how is the basetime taken into consideration in
> > your implementation?
> > 
> 
> In this implementation base_time is used only to obtain the
> change_cycle_count and to write it to TAS_CONFIG_CHANGE_CYCLE_COUNT. In
> this implementation base_time is not used for anything else.

So there is zero granularity in the base-time beyond the number of cycles?
That is very bad, because it means the hardware cannot be used in a
practical TSN network where schedules are offset in phase to each other.
It needs to be able to be told when the schedule begins, with precision.
Not just how many cycles from now (what does 'now' even mean?).

> > Better to say what's the hardware maximum, than to report back num_entries
> > as being not supported.
> > 
> 
> Sure, I'll change it to below,
> 
> if (taprio->num_entries > TAS_MAX_CMD_LISTS) {
> 	NL_SET_ERR_MSG_FMT_MOD(taprio->extack, "num_entries %ld is more than maximum supported entries %ld in taprio config\n",
> 				       taprio->num_entries, TAS_MAX_CMD_LISTS);
> 	return -EINVAL;
> }

Keep in mind that NETLINK_MAX_FMTMSG_LEN is only 80 characters. Also, \n
is not needed in netlink extack messages. And indentation also looks off.

> >> +
> >> +	emac_cp_taprio(taprio, est_new);
> >> +	emac->qos.tas.taprio_admin = est_new;
> >> +	ret = tas_update_oper_list(emac);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	ret =  tas_set_state(emac, TAS_STATE_ENABLE);
> >> +	if (ret)
> >> +		devm_kfree(&ndev->dev, est_new);
> >> +
> >> +	return ret;
> >> +}
> 
> Below is how the code will look like.
> 
> 	emac->qos.tas.taprio_admin = taprio_offload_get(taprio);

emac->qos.tas.taprio_admin can also hold an old offload, which is leaked
here when assigning the new one ("tc qdisc replace dev eth0 root taprio").

> 	ret = tas_update_oper_list(emac);
> 	if (ret)
> 		return ret;
> 
> 	ret = tas_set_state(emac, TAS_STATE_ENABLE);
> 	if (ret) {
> 		emac->qos.tas.taprio_admin = NULL;
> 		taprio_offload_free(taprio);
> 	}
> 
> 	return ret;
> 
> Please let me know if all of these changes looks ok, I'll resend the
> patch once you confirm. Thanks for reviewing.

Hard to say from this snippet. taprio_offload_free() will be needed from
emac_taprio_destroy() as well.

