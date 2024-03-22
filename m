Return-Path: <linux-kernel+bounces-111876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B836488720A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 18:43:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBCBB1C22C16
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05F15FDD3;
	Fri, 22 Mar 2024 17:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="or+twNsX"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0035FB86;
	Fri, 22 Mar 2024 17:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711129418; cv=fail; b=GDokVvkPz1AVvdZFmLnXUCCoatQXERruw2N/WR6wsh7RJsA/6i4+e5Xyn7Fofe2SeMubeE+KdPbCr4luFB9KFtUV1zpwQa7hkCD+t8D641i0rOeqywRbqJL4eFO9RipIvS2IqJbq/P54j6cVMtcEgfMWtJU/8rXa3wLVqCoZ9PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711129418; c=relaxed/simple;
	bh=bObKwJ3CLPnEjJWlEcSgXEThOUQtqdSdOfXIXQBBtLQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r/Ti3Bs2gWcA17H3jwc01NbpRdjbkdMNzmRqzRmGLZcSNDQwJrswpNOAV2FqH6zQD66vonyG99l3EvGF+pPtAapIgctcQ49+YReamSjso/5mGD2u83I66BG8pFU7nVBFCM6Ut8J/YKAD/rLkNePuhys7TxfPYoMqhlZbvzoxsWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=or+twNsX; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42ME6Mt7019977;
	Fri, 22 Mar 2024 10:43:15 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3x0ybuavu4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Mar 2024 10:43:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=njgqBCO434ScqJiv4NgeRsbczla4o96gFU5ReLcw8/kDqjR9old8anzP1sWZZfh51+Bna5LRnlbP3lqynvkfCkGP3iRh1B817rLEcPgMIur8oycpoBhwPy4mFzBSa2qCWQGL9cPlUCjl56JyT4M8qJoMCMdeCmZJmLuHLVODqnMuHZ38pa4NdrXjcnca3efJBSnVpIZmQMIB12jkCItOtV+Z5xhrb1SU6Dzdyf87KL9un1LCRdwvdwZ7Ynfc7l5k9X4C4LmaNEVi+g2WtH5q8fOpBSoAG9gydWcF4usIlKCPx9fuelFOwtQk8uC4JPtxAJxP8rkU/VTveFIXDdkPYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TlI1ztqwpjXnS5kLB8Q3ZWCOTlZAl/QUAS5Y8DVr5VM=;
 b=Jcj1hU87zFkWVX07xYmSLG8Jna12g4FoT7VX1CHQgDB7mRnKAGXmNRWG3BtDeVNoDrB6vMa4/b2FM4kjSGtKX7uqAiK4TYGKv1c/fnQYO4X0lE/xkfDrgNAsRbnaOqXwyh4VOi98ajhkZwz0IGJMI+To58MFYMke3OIglQUdEueBf2QqWCEg3ZflFr8aDliwel2z2r3FsXWCWlaeKuNF0c2vkg5sa5jULpQyQi2E7H6vva/BtBgtsWl0Py2yE9V03GLbUh214ecgmACoYEUpvjZEtvCz8Gm/XtUGNP+8nc1UyOd7XYqYb6hG44bKAbjgBmcSCNSTLuc/ROZw7xV6jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TlI1ztqwpjXnS5kLB8Q3ZWCOTlZAl/QUAS5Y8DVr5VM=;
 b=or+twNsXaaJnPuH7YDhqkbKlD5Ma0TciFijo43EskTFzYPILl1oe4+xMbRT1AO87fnrmlEyHPXPZAraozadellXYWjMkg6xAGH/RxKnjPrjPpeQKFvdUMfADXeGLLxSEdFswFZssmMhEWD/+shBHA3jt4B9ArSBGNtK+K2P+Gy0=
Received: from SA1PR18MB4709.namprd18.prod.outlook.com (2603:10b6:806:1d8::10)
 by SA1PR18MB5994.namprd18.prod.outlook.com (2603:10b6:806:3e3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.34; Fri, 22 Mar
 2024 17:43:12 +0000
Received: from SA1PR18MB4709.namprd18.prod.outlook.com
 ([fe80::ebe0:68b0:1b37:b100]) by SA1PR18MB4709.namprd18.prod.outlook.com
 ([fe80::ebe0:68b0:1b37:b100%5]) with mapi id 15.20.7386.031; Fri, 22 Mar 2024
 17:43:12 +0000
From: Sai Krishna Gajula <saikrishnag@marvell.com>
To: Oliver Neukum <oneukum@suse.com>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "syzbot+9665bf55b1c828bbcd8a@syzkaller.appspotmail.com"
	<syzbot+9665bf55b1c828bbcd8a@syzkaller.appspotmail.com>
Subject: RE:  [PATCH net-next] usbnet: fix cyclical race on disconnect with
 work queue
Thread-Topic: [PATCH net-next] usbnet: fix cyclical race on disconnect with
 work queue
Thread-Index: AQHafIBp1dqMXcvK9kC5zLoffE3WoA==
Date: Fri, 22 Mar 2024 17:43:12 +0000
Message-ID: 
 <SA1PR18MB470955BBB332D3A9F9A6F247A0312@SA1PR18MB4709.namprd18.prod.outlook.com>
References: <20240321124758.6302-1-oneukum@suse.com>
In-Reply-To: <20240321124758.6302-1-oneukum@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR18MB4709:EE_|SA1PR18MB5994:EE_
x-ms-office365-filtering-correlation-id: 881dd50b-085f-4afc-9124-08dc4a978be5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 svLRM3LA7Mxxhy8didAP9vqCHHSOh2g5FGy3oKpZF+oBlp7ag6D08VXbm7yNt7O1GvC6V1Fl9sWDErFYlTX+tMNzKmaeufteWbiNU6FhK2E2GCf94FIHW/wB8gEY46rMWvI8+GP1pYHnb41gwLOXPQqYCoZr4un2gLOIheTMBUR7SVSYOygcz+xY7RlOrcRT4wRxu+Ypjo6j4hMrqVPMJvRaqTV1Yjw+zcqfU4ln4sa59tCvBL3/531YPu5zIO9nBJGTXOZBN+VuwMNg226hr5ad7sA0jWipHiyBdN465JOo7Dbse72JMUloUu8pFbNBMdrxATndHF2KAe2l1Fco2f4fzGKfMQkM+4yvRjD7RUxFj8EpA88Ib7Hbg79eoghhvteFmF0WWlVw0EHfNOxf2RJJu7SzKuKhL/Sel4e1UJH0qr8wxW0WouC2Dyg+bypE+9Uy/BR7cRBdWdlQiiISQJ3qPug7+ejW7qXty2yuMKzSRYm85Bm3DmMFPnGxacixV6wB+mqKhQtgG4nDcJX2Y5ZGyhugJGORYKnjzd1YiqOljvvI0FiX7VcGtM4bfCy2m9KI12lq2lA9DLuVPgTN+MiOFIHXb2xUAJP0KA8JfeGxFltiXSF3GCsPnLCDhpjzH4S40dJZLcz8/5w4aj+Yn+bruz0fUGEQ/f0VOEoJrraWG6kflizkQJpAyZoYFt/QcS7n/MLbFQieZMztzKryut5RDg+IbvwQcOKl41BLnyM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR18MB4709.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?sKcKHbbTmwPGb2HZ1u6sPqsh34wFGNvzbGd2DuKeOico+NWMDyNJTRKMRq2w?=
 =?us-ascii?Q?QYZ5r9qeRlPHg0oypLfu8MO+3Ltsg/zSDEpeYRr0vGqGSN/ux82E9s2Gavrs?=
 =?us-ascii?Q?NywtjQ2fCH+w6XXnW1bxuCtVWqAB4yo4Oj/Mpdvzx0cJgfKVfFy+/qYMTdmT?=
 =?us-ascii?Q?lDgOX5WBC1UnUpiColVQjnDj+ga10r2poR5BSMVws0BdqRZf8tv+W1qreyLQ?=
 =?us-ascii?Q?uT4v7Ze9S9B5bpwCMqLggKvWgaS/bDDltrUe4aQyv/vgRt7iFTCAZ4pK1l+v?=
 =?us-ascii?Q?P+CEF0pJuSK1faZaTwsY2AQ03uCZ0lrzKKgnzUXBid7Le9EY5CSfmPQrOqdM?=
 =?us-ascii?Q?RqxoubHrl7Ww7IamzkQolr3xQKJfz5R2AtOR4rEYIw1bmWdTxUjAXNoL6C1D?=
 =?us-ascii?Q?iqye0oUVhhFnMBpwSBYbn98Y/25eoUvtSPyXGR+YMRorlZiGv7xzsz199Xuh?=
 =?us-ascii?Q?38gZtJimsfOx9JWYV45U4jBAD4+Y9A3Fosg1qYs8D7bSceU6ph+c1O9S4GVE?=
 =?us-ascii?Q?V5DMtjfnVyLuRTz583OUK0rpzGgtTc6t6pv8SM7+7+CfLz+gTC0brCfS0qJh?=
 =?us-ascii?Q?iMKWCI6UM391FwURzOKGElJXkFp4Y3d87x3todWtYHUL/OcCFvH7TwvJLKVT?=
 =?us-ascii?Q?eYfPst6V/HnxiHM3Kif7lgQu/P1I7/GgnofiXGCiUa9lS+7DIPNzgUPDtmAe?=
 =?us-ascii?Q?eLzEQU8tTzoVyfamu4EP/lkC3KxdsrvD0hOJccN4Ket7rQ8DWu3QV1h/G8QS?=
 =?us-ascii?Q?QUmp04UYALAm7+EoKBzotrMOL6Pw3iHQAlGg71A7JoCtEtOjJ/qHFwiJDrxW?=
 =?us-ascii?Q?HiEyiSyh/Ll5AuGaPd0uvxQVlmMfoQCSvVVNo5hi9XFzwLaSQy+RuJu7THpM?=
 =?us-ascii?Q?ziOYXjZ2yssZUuCtZnsgrK5qcWXqbx6SHHtVtTMXjr5zvoWcwYNOmFaMGoo9?=
 =?us-ascii?Q?CRDjJxKBkT+Ct1+epbH9i/q4zYMNZkcnGDCGieP0adxSpfbrzYBKiDCoK0Uv?=
 =?us-ascii?Q?x/CMB1wA0GE+7NL39qTZXDwwtFwJcIOeqZ68QeBbIc7z0WDMseFYOmozf8L0?=
 =?us-ascii?Q?7Fw/5KA5ESzshYMQYdbrhkAOkP9wPmkUpONuikIoN6Bvx3a7H9+uE4uO+TxO?=
 =?us-ascii?Q?t8efTMXgC5ijBGA8gXcr7VWNwydFiNNJbQnxeisiCbe+KcGkkeeDFzukmZNw?=
 =?us-ascii?Q?5r4kPYhgrQJtQwNPJU+Is0qOmBWInJcPD9JWrjBI2WXB014qJH/tico7EL7T?=
 =?us-ascii?Q?R52Y1z4SiR+IgUHx9DP7Z9l12L+f048miQnUUNIcOTgNmpTYTIVgk5TDISQt?=
 =?us-ascii?Q?tmvUpLuKtQqAQSz3wTnr9opb3y5ei39USl9He0jKcQQik/4X6NkEsgWhcBNy?=
 =?us-ascii?Q?UuBO/0VmpnTXiGoMrSySomIYuX+UeXcr5qPxpvoF8On35r4kXxgN5aWhcS+C?=
 =?us-ascii?Q?3UJuzskYRo8KLiWUjqzsAvoUBk7jjCMVUgRKHC8yf8vmg92zVuR6L3RTz67j?=
 =?us-ascii?Q?anjRJ7cQ1Xj0LIrkXcbubToqwyaCFb942DXW5TtjTF6jg7hu7q9SxxNGWQSM?=
 =?us-ascii?Q?0jr8vSqPjTsDAWVv17eza8YxTwtu6CMtD6ti4Qy/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR18MB4709.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 881dd50b-085f-4afc-9124-08dc4a978be5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 17:43:12.7229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zZ59++4ndPBVD+WiyuinZc0gH+cF9bsON3i0nykYCJscwXevvshbrwPmc0u9voeAjUClYjGM8lFr2ElkUNonHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB5994
X-Proofpoint-GUID: 5MOq8SKb9LkO3prPFPHgEf3QCA8V7NjH
X-Proofpoint-ORIG-GUID: 5MOq8SKb9LkO3prPFPHgEf3QCA8V7NjH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-22_10,2024-03-21_02,2023-05-22_02


> -----Original Message-----
> From: Oliver Neukum <oneukum@suse.com>
> Sent: Thursday, March 21, 2024 6:17 PM
> To: davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com; netdev@vger.kernel.org; linux-usb@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Cc: Oliver Neukum <oneukum@suse.com>;
> syzbot+9665bf55b1c828bbcd8a@syzkaller.appspotmail.com
> Subject: [PATCH net-next] usbnet: fix cyclical race on disconnect
> with work queue

This patch seems to be a fix, in that case the subject need to be with [PAT=
CH net]

>=20
> The work can submit URBs and the URBs can schedule the work.
> This cycle needs to be broken, when a device is to be stopped.
> Use a flag to do so.
>=20
> Fixes: f29fc259976e9 ("[PATCH] USB: usbnet (1/9) clean up framing")

Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")=
' - ie: 'Fixes: f29fc259976e ("[PATCH] USB: usbnet (1/9) clean up framing")=
'=20

> Reported-by: syzbot+9665bf55b1c828bbcd8a@syzkaller.appspotmail.com
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> ---
>  drivers/net/usb/usbnet.c   | 37 ++++++++++++++++++++++++++++---------
>  include/linux/usb/usbnet.h | 18 ++++++++++++++++++
>  2 files changed, 46 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/net/usb/usbnet.c b/drivers/net/usb/usbnet.c index
> e84efa661589..422d91635045 100644
> --- a/drivers/net/usb/usbnet.c
> +++ b/drivers/net/usb/usbnet.c
> @@ -467,10 +467,12 @@ static enum skb_state defer_bh(struct usbnet *dev,
> struct sk_buff *skb,  void usbnet_defer_kevent (struct usbnet *dev, int w=
ork)

space prohibited between function name and open parenthesis '('

> {
>  	set_bit (work, &dev->flags);
> -	if (!schedule_work (&dev->kevent))
> -		netdev_dbg(dev->net, "kevent %s may have been
> dropped\n", usbnet_event_names[work]);
> -	else
> -		netdev_dbg(dev->net, "kevent %s scheduled\n",
> usbnet_event_names[work]);
> +	if (!usbnet_going_away(dev)) {
> +		if (!schedule_work (&dev->kevent))
> +			netdev_dbg(dev->net, "kevent %s may have been
> dropped\n", usbnet_event_names[work]);
> +		else
> +			netdev_dbg(dev->net, "kevent %s scheduled\n",
> usbnet_event_names[work]);
> +	}
>  }
>  EXPORT_SYMBOL_GPL(usbnet_defer_kevent);
>=20
> @@ -538,7 +540,8 @@ static int rx_submit (struct usbnet *dev, struct urb
> *urb, gfp_t flags)

space prohibited between function name and open parenthesis '(', where ever=
 applicable.

>  			tasklet_schedule (&dev->bh);
>  			break;
>  		case 0:
> -			__usbnet_queue_skb(&dev->rxq, skb, rx_start);
> +			if (!usbnet_going_away(dev))
> +				__usbnet_queue_skb(&dev->rxq, skb,
> rx_start);
>  		}
>  	} else {
>  		netif_dbg(dev, ifdown, dev->net, "rx: stopped\n"); @@ -849,6
> +852,16 @@ int usbnet_stop (struct net_device *net)
>  	del_timer_sync (&dev->delay);
>  	tasklet_kill (&dev->bh);
>  	cancel_work_sync(&dev->kevent);
> +
> +	/*
> +	 * we have cyclic dependencies. Those calls are needed
> +	 * to break a cycle. We cannot fall into the gaps because
> +	 * we have a flag
> +	 */

Networking block comments don't use an empty /* line, use /* Comment...

> +	tasklet_kill (&dev->bh);
> +	del_timer_sync (&dev->delay);
> +	cancel_work_sync(&dev->kevent);
> +
>  	if (!pm)
>  		usb_autopm_put_interface(dev->intf);
>=20
> @@ -1174,7 +1187,8 @@ usbnet_deferred_kevent (struct work_struct *work)
>  					   status);
>  		} else {
>  			clear_bit (EVENT_RX_HALT, &dev->flags);
> -			tasklet_schedule (&dev->bh);
> +			if (!usbnet_going_away(dev))
> +				tasklet_schedule (&dev->bh);
>  		}
>  	}
>=20
> @@ -1196,10 +1210,13 @@ usbnet_deferred_kevent (struct work_struct
> *work)
>  			}
>  			if (rx_submit (dev, urb, GFP_KERNEL) =3D=3D -ENOLINK)
>  				resched =3D 0;
> -			usb_autopm_put_interface(dev->intf);
>  fail_lowmem:
> -			if (resched)
> +			usb_autopm_put_interface(dev->intf);
> +			if (resched) {
> +				set_bit (EVENT_RX_MEMORY, &dev->flags);
> +
>  				tasklet_schedule (&dev->bh);
> +			}
>  		}
>  	}
>=20
> @@ -1212,13 +1229,13 @@ usbnet_deferred_kevent (struct work_struct
> *work)
>  		if (status < 0)
>  			goto skip_reset;
>  		if(info->link_reset && (retval =3D info->link_reset(dev)) < 0) {
> -			usb_autopm_put_interface(dev->intf);
>  skip_reset:
>  			netdev_info(dev->net, "link reset failed (%d) usbnet
> usb-%s-%s, %s\n",
>  				    retval,
>  				    dev->udev->bus->bus_name,
>  				    dev->udev->devpath,
>  				    info->description);
> +			usb_autopm_put_interface(dev->intf);
>  		} else {
>  			usb_autopm_put_interface(dev->intf);
>  		}
> @@ -1562,6 +1579,7 @@ static void usbnet_bh (struct timer_list *t)
>  	} else if (netif_running (dev->net) &&
>  		   netif_device_present (dev->net) &&
>  		   netif_carrier_ok(dev->net) &&
> +		   !usbnet_going_away(dev) &&
>  		   !timer_pending(&dev->delay) &&
>  		   !test_bit(EVENT_RX_PAUSED, &dev->flags) &&
>  		   !test_bit(EVENT_RX_HALT, &dev->flags)) { @@ -1609,6
> +1627,7 @@ void usbnet_disconnect (struct usb_interface *intf)
>  	usb_set_intfdata(intf, NULL);
>  	if (!dev)
>  		return;
> +	usbnet_mark_going_away(dev);
>=20
>  	xdev =3D interface_to_usbdev (intf);
>=20
> diff --git a/include/linux/usb/usbnet.h b/include/linux/usb/usbnet.h inde=
x
> 9f08a584d707..d26599faab33 100644
> --- a/include/linux/usb/usbnet.h
> +++ b/include/linux/usb/usbnet.h
> @@ -76,8 +76,26 @@ struct usbnet {
>  #		define EVENT_LINK_CHANGE	11
>  #		define EVENT_SET_RX_MODE	12
>  #		define EVENT_NO_IP_ALIGN	13
> +/*
> + * this one is special, as it indicates that the device is going away
> + * there are cyclic dependencies between tasklet, timer and bh
> + * that must be broken
> + */

Networking block comments don't use an empty /* line, use /* Comment...

> +#		define EVENT_UNPLUG		31
>  };
>=20
> +static inline bool usbnet_going_away(struct usbnet *ubn) {
> +	smp_mb__before_atomic();
> +	return test_bit(EVENT_UNPLUG, &ubn->flags); }
> +
> +static inline void usbnet_mark_going_away(struct usbnet *ubn) {
> +	set_bit(EVENT_UNPLUG, &ubn->flags);
> +	smp_mb__after_atomic();
> +}
> +
>  static inline struct usb_driver *driver_of(struct usb_interface *intf)  =
{
>  	return to_usb_driver(intf->dev.driver);
> --
> 2.44.0
>=20


