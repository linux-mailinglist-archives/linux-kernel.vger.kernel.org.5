Return-Path: <linux-kernel+bounces-46442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3983843FBF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F111C242DC
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966B879DD1;
	Wed, 31 Jan 2024 12:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="HD31pEQC";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="cLFbyaTm"
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838C878676;
	Wed, 31 Jan 2024 12:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706705581; cv=fail; b=M2DB2PqybS0r1tfdfPbSGzPOPk1M+WH2YBnh/3t9SdAqt3L+ArVCcU+ARlIbvcJ3/BNFYW1TSk/T5uz+uTybMj8ljU3Yd87dUU319iU034yNl/r4TyNN2lmT4hWtUhlp6QwpSiuuWEQX3h0DhtZ76DjrOjG9MTFqzBiIBeWX6nI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706705581; c=relaxed/simple;
	bh=q4u2H8/+m2E5RAb3CqqmoFNBkb3dRXic91bZRWef1rU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ng8/AqJmzVJ2VpSx15wqKE46Liy9eqKQyOFxB9vHpXxuJmz4ueKV/tav8XbovU/7m9JDc1vzB4syGbydtmo8t/fuxSKT1lHGv0gw2UA1fxZgpa4qhzwQcDfWvvWX3MS7+JGddDGYIyk9UCwqCNHsEG/tkfaaP5fgMPRfe7r11UM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=HD31pEQC; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=cLFbyaTm; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1706705577; x=1738241577;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=q4u2H8/+m2E5RAb3CqqmoFNBkb3dRXic91bZRWef1rU=;
  b=HD31pEQCB8nmdss15aLOHwRbksxOMkKwtc+q+5qmmt+1rBi9vNrzO5j2
   s2F+PfIWimZlrGxEYUHfbEvF2ZdG9ByCngn1fE3+rDbYu/2CRL6llN0if
   1xPKZzrxcevYMAMTlZFjNCcnDlICzkUEljM4bgF7s/UMLNLIC7ZU+2tNH
   JArvDKCnOnFdVG83gZMzJVFq5Xyd8uV36bOJDld1CNrucATdajNeUodRf
   TFc+vPyQyBcRFrMnVW0EzvBw5F+Vc4wZkvoVqvfJ0w2dtpPUrmRGHKAqT
   sDi32hN4Ho8UGjGuCtY5H9Hi9QBl5bR+4lqur89zjSexsIM3ooWBMNN1i
   g==;
X-CSE-ConnectionGUID: BEVnGFRGRgewSL+IwKG8TQ==
X-CSE-MsgGUID: q/cIvMHeQAuWM4nYJoumdQ==
X-IronPort-AV: E=Sophos;i="6.05,231,1701100800"; 
   d="scan'208";a="8228663"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jan 2024 20:52:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIvyScyuE6oZTu0HgjZnFBsJoWTOVFUEVZlxYnCB3ueAGKa07dYdmFkKHhMEiKDu0Jx+XykmTdCxVjr6hmR94vWf1ZwlKD31UPvnZOQbHo/lF1WJPLSYZXWEB32Hz8fpS8pdyfA2s4OKaPWAZRa9h13D75teos4C6V/CuO7FFRoXKJ1v0L+IBv+boB984BmPckchRS1Yp+9rzgZWsx1V6LNyMziPzQ5RrdZ2AHtN/kXFAEG/nrXw8ldM2JfNubTb8sL+hNxmP98VPfzhREcrhxN4Ev7c4krDdD75ad1+rCzFJtFrghsMOwMySJd6XcOlNAJx1meH1EGyFBgirvEE+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tKkcNb6lgon2TGOwy5wV0j58qIE/wi3aQ+sqbF2lZfM=;
 b=fr3d1mpoysJrEh2Q7tUa4VIe0aqcXnh6PSHaEm6ZdlSRHyw9VhhpqBTFnbyK5XGm2y0huEh2306ShSw6gMa8nYN5svDxynb5Kn6HXz45HG4YCU7jJYhW4l2a7WgzhL6HCLivXOEobegVuXX3l36o3lg0VCASU/tPaxovTtmF5Zg70ckInyvOPqaTNzvhgRvNTD+r+FxuWRl9n2ZpImK5Wgwn2g1Vic29WI7Mw1+PDrSi41aVGmWBp3TU8Ug/DLjj1ntfy/T3jrD+gLgxhCK2lKeX6iHvE7FIX912Ah9aRhgr5G0RSeJUcdH29asQCRayAwQwgIKmoaY3P3sdbVvwdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tKkcNb6lgon2TGOwy5wV0j58qIE/wi3aQ+sqbF2lZfM=;
 b=cLFbyaTmmMTDlDp9QsxRMhVb4oQ02nAg/VRp/0LAeLskaWdxIgLK4DFG6oC/AqGgA0aaBs5zgcX1tClgv5bluwfpa+jhm3KpTxvLIE+0/luMkV5lfmcwD+AfAyT7xC6YNNL/QJl0L/ilrawDMTmGK6s8ucoZtih1LjYejtRmqe8=
Received: from MWHPR04MB1040.namprd04.prod.outlook.com (2603:10b6:301:3d::18)
 by DM6PR04MB6907.namprd04.prod.outlook.com (2603:10b6:5:24a::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.37; Wed, 31 Jan
 2024 12:52:53 +0000
Received: from MWHPR04MB1040.namprd04.prod.outlook.com
 ([fe80::5c41:d0da:15a9:41ef]) by MWHPR04MB1040.namprd04.prod.outlook.com
 ([fe80::5c41:d0da:15a9:41ef%6]) with mapi id 15.20.7228.028; Wed, 31 Jan 2024
 12:52:53 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: zhaoyang.huang <zhaoyang.huang@unisoc.com>
CC: Damien Le Moal <dlemoal@kernel.org>, "Martin K . Petersen"
	<martin.petersen@oracle.com>, Hannes Reinecke <hare@suse.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Zhaoyang Huang
	<huangzhaoyang@gmail.com>, "steve.kang@unisoc.com" <steve.kang@unisoc.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, Bart Van Assche
	<bvanassche@acm.org>
Subject: Re: [PATCH 1/1] block: print warning when invalid domain set to
 ioprio
Thread-Topic: [PATCH 1/1] block: print warning when invalid domain set to
 ioprio
Thread-Index: AQHaVD8dNUpei/ydt0+12iLyo24sy7Dz4E6A
Date: Wed, 31 Jan 2024 12:52:53 +0000
Message-ID: <ZbpCo+90OsXJwFWV@x1-carbon>
References: <20240131121401.3898735-1-zhaoyang.huang@unisoc.com>
In-Reply-To: <20240131121401.3898735-1-zhaoyang.huang@unisoc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR04MB1040:EE_|DM6PR04MB6907:EE_
x-ms-office365-filtering-correlation-id: 353e9de3-a605-4ce6-0021-08dc225b89fc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 obMG3NICZu6zPfnDjdJ7Xg8+ajmEpFseYPaQGMr6WJVaZ+x/m5o1xPRaNN7Vqgj6ZXCDGFhF0i/LlNmFjuxHSTKYflOLW04XcdAayEgSxnhowVGDnqFMJrnn67RNqTSVBRJiMTBLf50amkSPTSwEGfsGzeuFb9kZbySTHRPzYO58a2UMmOHJHY2Fk1Jdqt/wIJpBlj6QgVFlGoI6THCqLI5l2V1dzJeKt63rBUDrUJIlYDDytvDilikAvcXZAn+B9vbHzoe1iIBNsEF2H75sFzppiWqQO50jfum9T6A9Vxpt3soguu0Dv8UydLFd+hRlxZbdFGnz4MyxDgrh/F8iRFTKscsDXMsQaES+ZJc4VlJfTzuNxP0xrddOUnGvEyWCpIbKqaww8SseFtPWf6YkwmAlMLRHhph/4r+kzopAcBm7uaC1+qcD/eDX9fUjFofCXoVme46Ep6XWPGGomJj5ox6bIMBL0mdIZM/JofThv+X2lOwGTIbXDkQ4ggw0Wuwo1Y4FLhicDQjPs7Pl3WKgMtk+WVG2oeanvWOgllF3UffmQ2jlfr+dJMxsl4NKBJ/Cn8NKtVKsdy+hDZqD2zfN7mORYAaDz/AR6+z2HXk/Ah2vFbOgnf4knH3rrfmV1/54drK9h4Weq17kaHxDnm85Pw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR04MB1040.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(83380400001)(478600001)(71200400001)(9686003)(6512007)(33716001)(41300700001)(6506007)(6486002)(8676002)(8936002)(4326008)(122000001)(316002)(64756008)(66946007)(66556008)(66446008)(66476007)(6916009)(82960400001)(54906003)(2906002)(5660300002)(38100700002)(38070700009)(76116006)(91956017)(86362001)(67856001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AKSU8tkkx02ZZXN/Ih4yc3z8garz1qCzFY9nAVpUBmiwRt0T6tNBuxjjUoHI?=
 =?us-ascii?Q?M2ESUaqoxONDJrU6ZzpREiF0QsWPq7MHYQP+nrkKo9DnyDU5c6gxBt9F6GKk?=
 =?us-ascii?Q?LhacG2CYl8A1C7FXQuPKZfqg1BvC/C4sm+LnoTdXO6RmuUezi9zqcESQezrx?=
 =?us-ascii?Q?EWWFX+++zKYG4XF1JCUXjLbz0swQf6MarB5M/JzNyVCdtgdKZPtl6ur7UTrh?=
 =?us-ascii?Q?g80TBEJWUX8jFLa4H4BdXObKEZbOnedlKBT22ZYekwR80w7GSYOiSd3H9nGM?=
 =?us-ascii?Q?U44B3Zuq4W3yP7YqrYvKu5DzG+1LZxsklfM+FKzgqOk1WxzTAz/iFvMQg4YF?=
 =?us-ascii?Q?1sgeK2hNb9KSsP/5Gi6rYoDur8w4+/znDmdzNvXabF9WC8youd33V1JbCZvP?=
 =?us-ascii?Q?Z83P4CQ8i1Tg7W7a03IlaWiG7XB9Ni5PfVPrgV020BLRBfIYf42LwotMm1mC?=
 =?us-ascii?Q?RZ1II2+jpFUyxFUC258ooLlXeZQ3qy0//PSClIfi9NELB8qnbKqWQVKjWrQ1?=
 =?us-ascii?Q?VG5JHLQJW19omj/TdyWaZs7P7x+97taqO8dYl38YYxWQJloTWUsVeFlDiDJ3?=
 =?us-ascii?Q?3YgeleklMV/YEav1cHRK4J+OVY/7gE/Yh1TSkw0dmkdFmB5wj5Qrk9gbJDWn?=
 =?us-ascii?Q?vQ3p/qbfASCefWvd7k2QlJaysUdS3by2ecqVtw34k7RZZufGJzowwYbsgXiQ?=
 =?us-ascii?Q?qMcnIfxVC/USaqEMvMa+emVo8gHTozbiGHUEbnuNIjQ1Rj8VsEwORdKdjUwW?=
 =?us-ascii?Q?+QGguVqwqfIlu1/l0tAppe9P/ei1WgPI+pSto34s7krvZkwMLW4/XQeCqtiX?=
 =?us-ascii?Q?HJ3nL+WDGVureAJeWyv5LtP0NIZ5KXD+ikb7bWcbMrOqolEmkDNo3YlMntWL?=
 =?us-ascii?Q?va3C9Y/8IAyQ7FDcU9Xp6KPEq2FgzFu1kgJeUznA63MwsoFSntU9MN2wyFWz?=
 =?us-ascii?Q?EP284uRIXJGSeYL54KR/gT3QilH9fxYCuwcqTEQdFH0+APh25dW9iG6gcAsI?=
 =?us-ascii?Q?A5HarI8uf0pEVedX5TI1+7lY8541dahsXA4CAj1puUNIlkXv9jKWSc5cFdTJ?=
 =?us-ascii?Q?IR78LT6v+tS/EzVGSEuCuV3O0Wh/RIVojx5cZdPH8kbHrigt062BZhZrmmsk?=
 =?us-ascii?Q?KdPhkqeB0NInrlqmDnJ6KzjbZyiYd8OGfdzxbgY9cZaJy8Vol921v2t6FPY8?=
 =?us-ascii?Q?urJp6AKYEqeaGlJ/YRQ9f7khaYj0fc0Ihp/819IxJmkKZ18cCWeTDXr8dd3b?=
 =?us-ascii?Q?L9ACmBw54iDT+hPCuUadachlHcVWfitiBXmhjF966cxsfeLsanMe5GAZWMIk?=
 =?us-ascii?Q?baDRrobPOTq8wmLoM0wWaRivoQQWgmpvIXKns67ZUiFa7CE30GQWFgtsPqie?=
 =?us-ascii?Q?+um98FkSlPV3e45y6l8kKi++/95B9ZDWGMT6OkMLu+u+HA1uszxaK7t3uvfN?=
 =?us-ascii?Q?IH49iXXEnanfYZbsL8ed544Wkrou7pK5y8IJs0Lbu7yX+rsDiP2vgYtLiSj1?=
 =?us-ascii?Q?ByoQv83waqouBEZSqRB2Bq2ZXQkb8se9rsNJcznHhBz3rzG8BuMxFU4CVaHw?=
 =?us-ascii?Q?Qb/hXOQvUz7daHQNzSTK0U2y6w0folnTxTLi9DAFx9VTdOeaUqf3uMpVnxO/?=
 =?us-ascii?Q?Jw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7F51F5A0D4B0A842B0AD780706E0570E@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0jUkGk7jWjMyh+ebwFx3sZ7lWWMbIlrLKanv+E+6zRcSFpTCwc/f2pe/dEs6obHPEZYaWvUJKs9f/3Hv+QtTdp9Xe4r41DuCqhm0CLsUOFh5Q5lewwAmgeO4ygBtXTuGWBxKpB58popu5h/YcIP1yBvGP7vJdPvVthM6Js0KToIaZnlUDs311hub0XP4su6QLEJT1n/DVaK3FV0FmjwYvzZfJ2i+pwWmtAHGTB1qLX/k1eJUOEEZrPqog8QTN4Vn11apRzC9OjGGIg6FkWTwxC6H8+Z9dmmLfPeAQSD86ZuBnhZlzp5h/Vj4HKcuW1obHwq8hqSbehUUiBYlSYqo3TOYNTM82xSXILxmJonC9MpCPmOaqAo7CAS4+euMGSc2CnhgQ5oC2zkIh51riWkKkgWwg8eBT5g0lKEmM4pY+hLo1etEkW8+cAlUukWezxakNplfjfpUk4coBtwmC2YZPCyGqvoye1hXC1TLlhWLM8n3FR2UboqJ66M7iQ3ZNcu8Eq3ltEMSB8/dGhteDvIgtc7HEuIK+Shn7YNy25oBrVaxzu/7vJpmX82c/Jh2soldIUKRVVtWtysmhfvxKPeSniWRS8qSjz3O5MpqvS5lWD/OMdNVkr/SXAenfFzlX+WB
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR04MB1040.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 353e9de3-a605-4ce6-0021-08dc225b89fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 12:52:53.1652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n/d4C+UFtsXwH90ctTsjpiMq4GRUBRj5JSV0TxrgjAwNf63qHXzH8yLtBPlo/s752d27NugpozQOA7wLV9r2ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6907

On Wed, Jan 31, 2024 at 08:14:01PM +0800, zhaoyang.huang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>=20
> Since few caller check IOPRIO_PRIO_VALUE's return value and bio_set_prio
> is a open macro to set bio->ioprio directly.It is confused for the develo=
per
> who run across kernel panic[1] but can find nothing in previous kernel lo=
g.
> Add a pr_err here to dump the information.
>=20
> [1]
> Here is the kernel panic I run across which caused by a out of bounds che=
ck
> introduced by CONFIG_FOTIFY_SOURCE.
>=20
> [exception_serialno]:
> [exception_kernel_version]:
> [exception_reboot_reason]: kernel_crash
> [exception_panic_reason]: UBSAN: array index out of bounds: Fatal excepti=
on
> [exception_time]: 1970-01-01_08-00-23
> [exception_file_info]: not-bugon
> [exception_task_id]: 409
> [exception_task_family]: [f2fs_ckpt-254:4, 409][kthreadd, 2]
> [exception_pc_symbol]: [<ffffffc080736974>] dd_request_merge+0x100/0x110
> [exception_stack_info]: [<ffffffc07a27e274>] get_exception_stack_info+0x1=
24/0x2d8 [sysdump]gc
> [<ffffffc07a27e670>] prepare_exception_info+0x158/0x1d4 [sysdump]gc
> [<ffffffc07a280128>] sysdump_panic_event+0x5d8/0x748 [sysdump]gc
> [<ffffffc08016a508>] notifier_call_chain+0x98/0x17cgc
> [<ffffffc08016a9b4>] atomic_notifier_call_chain+0x44/0x68gc
> [<ffffffc0810f0eb4>] panic+0x194/0x37cgc
> [<ffffffc0800a638c>] die+0x300/0x310gc
> [<ffffffc0800a77e8>] ubsan_handler+0x34/0x4cgc
> [<ffffffc0800960a8>] brk_handler+0x9c/0x11cgc
> [<ffffffc0800bf998>] do_debug_exception+0xb0/0x140gc
> [<ffffffc0810f8bf0>] el1_dbg+0x58/0x74gc
> [<ffffffc0810f89f4>] el1h_64_sync_handler+0x3c/0x90gc
> [<ffffffc080091298>] el1h_64_sync+0x68/0x6cgc
> [<ffffffc080736974>] dd_request_merge+0x100/0x110gc   //out of bound
> here caused by the value of class transferred from ioprio
> [<ffffffc080707f28>] elv_merge+0x248/0x270gc
> [<ffffffc0807146e8>] blk_mq_sched_try_merge+0x4c/0x20cgc
> [<ffffffc080736824>] dd_bio_merge+0x64/0xb4gc
> [<ffffffc080723e3c>] blk_mq_sched_bio_merge+0x68/0x144gc
> [<ffffffc08071b944>] blk_mq_submit_bio+0x2e8/0x6c0gc
> [<ffffffc08070dd3c>] __submit_bio+0xbc/0x1b0gc
> [<ffffffc08070c440>] submit_bio_noacct_nocheck+0xe4/0x2f0gc
> [<ffffffc08070c8e4>] submit_bio_noacct+0x298/0x3d8gc
> [<ffffffc08070caf8>] submit_bio+0xd4/0xf0gc
> [<ffffffc080642644>] f2fs_submit_write_bio+0xcc/0x49cgc
> [<ffffffc0806442d4>] __submit_merged_bio+0x48/0x13cgc
> [<ffffffc080641de4>] __submit_merged_write_cond+0x18c/0x1f8gc
> [<ffffffc080641c4c>] f2fs_submit_merged_write+0x2c/0x38
> [<ffffffc080655724>] f2fs_sync_node_pages+0x6e0/0x740gc
> [<ffffffc08063946c>] f2fs_write_checkpoint+0x4c0/0x97cgc
> [<ffffffc08063b37c>] __checkpoint_and_complete_reqs+0x88/0x248gc
> [<ffffffc08063ad70>] issue_checkpoint_thread+0x94/0xf4gc
> [<ffffffc080167c20>] kthread+0x110/0x1b8gc
>=20
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  include/uapi/linux/ioprio.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/uapi/linux/ioprio.h b/include/uapi/linux/ioprio.h
> index bee2bdb0eedb..73c420a0df72 100644
> --- a/include/uapi/linux/ioprio.h
> +++ b/include/uapi/linux/ioprio.h
> @@ -112,8 +112,11 @@ static __always_inline __u16 ioprio_value(int priocl=
ass, int priolevel,
>  {
>  	if (IOPRIO_BAD_VALUE(prioclass, IOPRIO_NR_CLASSES) ||
>  	    IOPRIO_BAD_VALUE(priolevel, IOPRIO_NR_LEVELS) ||
> -	    IOPRIO_BAD_VALUE(priohint, IOPRIO_NR_HINTS))
> +	    IOPRIO_BAD_VALUE(priohint, IOPRIO_NR_HINTS)) {
> +		pr_err("%s: get a invalid domain in class %d, level %d, hint %d\n",
> +			__func__, prioclass, priolevel, priohint);
>  		return IOPRIO_CLASS_INVALID << IOPRIO_CLASS_SHIFT;
> +	}
> =20
>  	return (prioclass << IOPRIO_CLASS_SHIFT) |
>  		(priohint << IOPRIO_HINT_SHIFT) | priolevel;
> --=20
> 2.25.1
>=20

Adding linux-block to CC.

pr_err() is a kernel function for printing.
ioprio_value() is a function in a uapi header, so this function will be
used by user space programs.

There is a reason:
$ git grep pr_err include/uapi/

Gives no results.



I think you should fix mq-deadline instead.
It looks like the problem comes from:
ioprio_value() will set class to IOPRIO_CLASS_INVALID (value 7),
if the user specified an class/level/hint that was invalid.

ioprio_class_to_prio[] array in mq-deadline.c does currently not have an
entry in to translate IOPRIO_CLASS_INVALID (7) to a valid DD_*_PRIO value.

Although, why does this I/O even reach the scheduler, shouldn't this I/O
get rejected even earlier?

Both io_uring and libaio will call ioprio_check_cap(), which should fail
the I/O before it reaches the I/O scheduler, but in your case, you are
submitting the I/O from the filesystem.

Should we perhaps add a call to ioprio_check_cap() or similar in some
path used to submit I/O by filesystems?


Kind regards,
Niklas=

