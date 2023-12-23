Return-Path: <linux-kernel+bounces-10273-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2962A81D1FA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 04:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E5C01C20D71
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 03:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F66615BD;
	Sat, 23 Dec 2023 03:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZPo7BmVh"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01511110;
	Sat, 23 Dec 2023 03:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROLJF4h96x88DBqmE7H20nUyJNCNhvXlpfVkt8JvmiorzyO/EuhfmAeQImh1zqjB8GaFqHlB4oAw6tfuVZQD/lIJwv5LHrIpQGzCga793ElaS69p11x4iafMzZ/gdf8lcqDnMP0LAxiEd/fAkbj03G/WvBaXF4HKKlaiCLciQ8KUDzRxpemGBro4DIS6uNdZrvgXTHLngVh/C6nGeWeg6Bsj1ecqP5Yz18tBct91lJIbHOIHQ43JhTp3vdMJPDlhkzRUigV4u4l5hWaWaxJ4nEagZyLB9aVD0Zp0gLdTTj7h8H6+vY5P4qAxHBlhKoHTeTqemEzJEzJQC9gbbKO7dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lo12c6bE14RVJRoLB4ADFB1d34QuJTs0A3/fnofIw4E=;
 b=S2kQYxpLX9kwOGSxvSm4pHBfTIvvgDKdX+LOUB33oWJvyTIqEM4lXfrPHZjeoPcK41Jp6iP5gW4vAwQQmCDhuoRI4V1Cx/LEI/lPPOenxfssqdZ3ICmuYK5lDucUqNApnBjm5Kl6xyOSK/Sx73kre7uvmbrqEO+RdT3+16s9i27A5QJNs07s2LyXkqrlg8744qF+psIqwvYqhUmtasGyxK/VX3p9mWhZshzRhsT55K0fMt/P9BXMipptLtgXDZmtwxhgof6PXLb51DkKiXWYy8oVFbLHsO13yuppaCvmB81PUMvomr2Hh5isXL76FWeOO/1ZNWLbFKUxklKSJLfuXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lo12c6bE14RVJRoLB4ADFB1d34QuJTs0A3/fnofIw4E=;
 b=ZPo7BmVh5hPchCKrmBv0bMkPiE5PaNM3Bcn1HigjrNDP6rtvX7aVvIjv/ckPlbgJD6Wd6/3/sRAIQLWkoDi6pT0SE7gIkLC37OXsirbFVVai71Hgrnr1F2TlX704KuUfqZvhvkmedc3noudykOy1nFb4NBdJvRrpEdAUwRQ2l88=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by AM9PR04MB8164.eurprd04.prod.outlook.com (2603:10a6:20b:3ea::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.22; Sat, 23 Dec
 2023 03:42:22 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%7]) with mapi id 15.20.7113.019; Sat, 23 Dec 2023
 03:42:21 +0000
Date: Fri, 22 Dec 2023 22:42:14 -0500
From: Frank Li <Frank.li@nxp.com>
To: yuan linyu <cugyly@163.com>
Cc: peter.chen@kernel.org, a-govindraju@ti.com, gregkh@linuxfoundation.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, pawell@cadence.com, rogerq@kernel.org
Subject: Re: [PATCH 4/4] Revert "usb: gadget: f_uvc: change endpoint
 allocation in uvc_function_bind()"
Message-ID: <ZYZXFmjlUzNnxiiM@lizhi-Precision-Tower-5810>
References: <20231221165426.1590866-1-Frank.Li@nxp.com>
 <20231221165426.1590866-5-Frank.Li@nxp.com>
 <3c51ffb5-8198-459f-b4db-b9136a407c08@163.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c51ffb5-8198-459f-b4db-b9136a407c08@163.com>
X-ClientProxiedBy: SA0PR11CA0104.namprd11.prod.outlook.com
 (2603:10b6:806:d1::19) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|AM9PR04MB8164:EE_
X-MS-Office365-Filtering-Correlation-Id: 71bb4cf2-0190-48e1-aa73-08dc03692b38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xbf4QbgJlZHyE32Cm4bHeG1HqD/yGzknM+XOUi9n+1O8i2bunn+is1aiEQfi18oyEd/CHgPLf80wmx9Gu40PfoIe1jhMw/MQXQuS8pKPAEKLeP0Ic4YazIMdyoChtVCNXUbwU8OezdZ8AoI4B0P07ii05O5icl2f8o+doNZDd9WuUOm220dtEJ/6f93/hMdP+uIwHqxgSSF7zXe6+2W8GlF2NXm77ZxQkW/KPHdHeXeLcx4ac4VMh72NVmHjpB81Lz04l0ezPS9vY88oKaYEH9w2yBZ1qZtgOFnNA4VYuWUwEIGj/03fxYFJkpglopuXLo70KJQA+3PuIPnVpMmo7JqYZ8N84Qfbdw9MlfrKbPJfwFLxR/nmVDUENNwXiaK18NK9eVO1k8f0hH9BPZ9ViRguAdUlQQhZ5SJq6cyC4uVgOaFfShwRorDKkEZAq/jDtwl3hDhSVwDW84dBZl4tXjHt8kEu9Egv3rzX8EAN59et6pgWrAhq6IrilObj43/ZaNl3L5zGh7Bq4d/Tb7B1Y+TCWg7ZCbESMS7MLqOk8HrWG+zkpGbkrVkmi75INQ0dBahJ1KgYL6vF/Qx9K0BYtIPz2K0Mmhj21rRBwThfwnLh1Xk1ZLADlNVfF9RV/ONi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(396003)(136003)(376002)(366004)(346002)(39860400002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(4326008)(83380400001)(33716001)(66899024)(316002)(6486002)(478600001)(6916009)(66556008)(66476007)(66946007)(26005)(6666004)(53546011)(6506007)(6512007)(9686003)(52116002)(8936002)(8676002)(41300700001)(2906002)(38350700005)(86362001)(5660300002)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v01Hu8uUuh4MGAww9FxmQmUv2wM1uacms1fBQOET5pDcowt5xm7oLGmndT/r?=
 =?us-ascii?Q?XY00IYbRG9KfOGzLhgslxmhTaDMVjqsws6Ul1GUuQVO6zsgLHdzQm1A+aRrZ?=
 =?us-ascii?Q?X5ec7ZLd4jAKD5vG8BuNewVpxGHPrQndqbM+GQFqoGK0ruSaExCKa5PgI1Qh?=
 =?us-ascii?Q?wUvz+BDM3aKJJQeIZaPcgbfe/lYW08VdLhRlxekFa8zfVh2kgAwo1/1j+apB?=
 =?us-ascii?Q?zG3PZNpsSmDcP/EcVSA3CZcDeoG9YHUDP59m5T/QmSlgH47KDKRCieGXkFSv?=
 =?us-ascii?Q?CvzSxHk71DtXVA74QnQ7zdpMK16subw4aMfZz2438H+Xfd3M+QvxfjC0efFw?=
 =?us-ascii?Q?sVu6zoAiqgP1P1dNk/huqZN1ZlkEVZe+/ahLio9ZOjcVVd0wmcubYUi9yDBm?=
 =?us-ascii?Q?PW9k+ohn3N6sQFL+aPQD7Irou1h8KIGBnRSHwB4pwi60H9zIgoNHAb4VPlvr?=
 =?us-ascii?Q?ViQDEBYU+rt65KlhOJTWOj11NEc91BoHDDxwy6kYGU8iu2IHeLBoYD8Jn1lr?=
 =?us-ascii?Q?wd97jpvyC8xlKqs67rcnQ1jFR7Zl+kKSbEzTsCFPfXJSicvcQQedLwjJlLi4?=
 =?us-ascii?Q?bt7jYr1V5/y2nhJIsy70DWGWmLMj9XbOcuW3UJXPxQHPADhoGWWILp00jrWv?=
 =?us-ascii?Q?foqViwUEcMHNxzVIb5DczJVFN3kQurNwBdO9amfZNQEPXgK266R5bkza66BD?=
 =?us-ascii?Q?BZcmKCveGJBbicSp2v5jtT7sTzPvAvaWsKxI7zq/zJTmT6l+qbe39hw8tcME?=
 =?us-ascii?Q?zDQ4c4018ct/CSo7ovtbUUyK0f9FCvyKer3vPc13LkU9tucpRCkFfe4KUQ4B?=
 =?us-ascii?Q?3sDIWH0kEXJD07zo96FRELtT3t4iitaq4j+8AvU2wWeFSOiNr/Rj34BTCIzi?=
 =?us-ascii?Q?TronDdeqWn06CFvKl5f+tykoIzS43Spj9dNoAUWwvPWCoaPlfen3Y+HDJS5t?=
 =?us-ascii?Q?Y7t96OSCTrS42PzPwkbptOQ1vTuXH/Yn/IpytCFtNvRkgyAkx9Yq2EpK3r9h?=
 =?us-ascii?Q?lhAKHbB7JIfTjTmeS7+Ss1kNnPJzz/mCCvf2m5g6ahQrMee3i9jt0NIvqbUz?=
 =?us-ascii?Q?X0p5zv0WVJqLZlufqZokhwuIj/PZQUOwjK37eRarT7B4YFGY7E/sTp0+9hLF?=
 =?us-ascii?Q?23F7zPrV3vEJXpD6fC8ikT1fw+rESTe5MQVbjFKu249nBry3q+LuYt5OeasV?=
 =?us-ascii?Q?DN4A35zE5zL6264xm9gMxGGrnP4s6qCCLX5K5xAcYK3lMyxg2xmLN8llUHGa?=
 =?us-ascii?Q?6xgLU4hYK2RJcvWER6pGRyQph4A14Tdt2H96RM9ibooTBnIq50i+E6VPZzXH?=
 =?us-ascii?Q?vMEtfkTM9Lq6ptv2j+ceJuCYcbPq8LG7j1tlu1aD41lvDIofpyANuvQxGsSB?=
 =?us-ascii?Q?PZaJBg9sSCH7RIygoA8MUsvkYjW8QlOgl2F99Y7q6PLmHivldIwobg8zbYVn?=
 =?us-ascii?Q?g5EB4Mu6fthxBhJqpwkdg4X5995wvYaC9gveSGDG6r54UOjBmPIFUczXyuXe?=
 =?us-ascii?Q?bHGZqiQxJrWYN+9SsS68WTvdaOIyMtpENMF0EklHBZ2CemDzJ2zQ+gVGHnsS?=
 =?us-ascii?Q?aLshzjmmXBpeeweHfsA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71bb4cf2-0190-48e1-aa73-08dc03692b38
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2023 03:42:21.3431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FUI2Oo3XxEhoDH7nYBnHZdvgMvwvlH+ZGGW5I7/rRVezuWGC8kdt+NO7UbEfCN8m9bU1sj4PGUW7W2fj126dmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8164

On Fri, Dec 22, 2023 at 08:26:13PM +0800, yuan linyu wrote:
> 
> On 2023/12/22 00:54, Frank Li wrote:
> > This reverts commit 3c5b006f3ee800b4bd9ed37b3a8f271b8560126e.
> >
> > gadget_is_{super|dual}speed() API check UDC controller capitblity. It
> > should pass down highest speed endpoint descriptor to UDC controller. So
> > UDC controller driver can reserve enough resource at check_config(),
> > especially mult and maxburst. So UDC driver (such as cdns3) can know need
> > at least (mult + 1) * (maxburst + 1) * wMaxPacketSize internal memory for
> > this uvc functions.
> >
> > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > ---
> >  drivers/usb/gadget/function/f_uvc.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
> > index faa398109431f..cc4e08c8169b4 100644
> > --- a/drivers/usb/gadget/function/f_uvc.c
> > +++ b/drivers/usb/gadget/function/f_uvc.c
> > @@ -719,13 +719,21 @@ uvc_function_bind(struct usb_configuration *c, struct usb_function *f)
> >  	}
> >  	uvc->enable_interrupt_ep = opts->enable_interrupt_ep;
> >  
> > -	ep = usb_ep_autoconfig(cdev->gadget, &uvc_fs_streaming_ep);
> 
> how about all none-0 endpoint used for all uvc ?

Unit of CDNS UDC is package size, how many package size associated to EP.
Interrupt EP only change package size according to speed.

May have issue with other controller. 

Idealy, usb function should pass down all speeds setting by a API, the
composite driver check UDC again for difference connect speeds.

But it is quite big change. 

> 
> please add some comment if currently this is only way to fix your issue.

I can add commens. 

> 
> need it for stable ?

Suppose yes.

> 
> > +	if (gadget_is_superspeed(c->cdev->gadget))
> > +		ep = usb_ep_autoconfig_ss(cdev->gadget, &uvc_ss_streaming_ep,
> > +					  &uvc_ss_streaming_comp);
> > +	else if (gadget_is_dualspeed(cdev->gadget))
> > +		ep = usb_ep_autoconfig(cdev->gadget, &uvc_hs_streaming_ep);
> > +	else
> > +		ep = usb_ep_autoconfig(cdev->gadget, &uvc_fs_streaming_ep);
> > +
> >  	if (!ep) {
> >  		uvcg_info(f, "Unable to allocate streaming EP\n");
> >  		goto error;
> >  	}
> >  	uvc->video.ep = ep;
> >  
> > +	uvc_fs_streaming_ep.bEndpointAddress = uvc->video.ep->address;
> >  	uvc_hs_streaming_ep.bEndpointAddress = uvc->video.ep->address;
> >  	uvc_ss_streaming_ep.bEndpointAddress = uvc->video.ep->address;
> >  
> 

