Return-Path: <linux-kernel+bounces-162662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00CD78B5EAE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC16282DB8
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5732F84D1D;
	Mon, 29 Apr 2024 16:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="JQv7Png0"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4434A83CB9;
	Mon, 29 Apr 2024 16:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714407250; cv=fail; b=FY4MG0kq6cvlB/UlkZSBlU9CHd+CCkg6AKRsjsURw4Y5iFUOVb5qKxID0AuqELmQ5q32lQMu3WxYV6h/hVidxUHwqZeWNC7z8boWoQYsieyhN9rvV/x94jM5LxW0u+cv4VPnbKh/l2+rMc88JAzy//RxpjX2giX1wp9kOVtdJn0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714407250; c=relaxed/simple;
	bh=LdO1CkPz3K2pIUf0daOcvXD002H7F74aO/fP3SdMHjY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lZQXvtdLqYeDEUCaD6/X7jmW1C12JVWphSHO5yfEvgZAsdcuFz4MUdYo+RUpJ4VGZfKNZH6E+qaImG0bYDAAkzBQMQgso1NuohI/r2O/5f2wzPPadReBYoZvcN8XIhukXg7jsnbbpGSd9V5SsOJxao36+78YqbLk6P3T7j5/pRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=JQv7Png0; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43TGCubv005525;
	Mon, 29 Apr 2024 09:13:59 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xt43av4vs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 09:13:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E4hFc+RW2Cjre63NaVrVJSoMCZF8J85WysykPJDDCfWLunnm/YSlV3iRraNBgefP0usL8CwgEMS7C5Mm5MZ66A4MrwJaWPksFQif92c2DY1xY/6SROdjwBH13Ya/+crtSU0n5AlqBL29KqtdsJnzeWGr84da/wa81cONgxYKNRUN7P8dpXq0icVOl+M6VgMef0p/7sfLy9QVmUwrcpqz6m4+iPrT8pNP+7iLS+dz8Cp7AHmg5n4LaD3OQLcTequvbBbwssf7B9nvXQdz9Xn4CYoUTtWz9K6X3ra1/3Fty0CGDuJvWuzJ/qyAZJ/rN4j+EnYogbm0n7SLIsxcTXbJXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LdO1CkPz3K2pIUf0daOcvXD002H7F74aO/fP3SdMHjY=;
 b=e1+u+MOMYj45Kd4LewDqPr8Iu4qVWaBhoXgXUvxgW9zgwyVHEJLGlS7DKFUoAhzF5339b8blReOV7JEr303eTiGx5hI/88fRyFa7yYJWJ0nwf2qTxVn2l6DbikTG82f4tYFIMJqMb5BMfu0xpMJTLF5kRlix/TQx5ef3Unes2gdGX9g3XmAT+6DA0+0uej8HR+CPUu3HG8e8pySFzRo+HW+aS+xolNzkRKGWyXQawqP/je+TLV1LzCtQeX5FgKU1+S5z37srEh/xHeIIP4vltW/47CD+5ympYL4kWdaRfL7p069RJIcp5W9Iu2y5Ro5GaqXBDUGlR027A4Sc8qHgtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LdO1CkPz3K2pIUf0daOcvXD002H7F74aO/fP3SdMHjY=;
 b=JQv7Png0eLOF2y0EFvt99pKFA36LKPYYVtyz+HWS+EWU2Bbc+TyCZ1Mb+fX72S7oIv5iLunsNewXv9MBE1G00ROqIBXlShOe4jHX2Vo9oMx4oZZ53+sAqJjS7eYIb/QyhD5K9otMBvVdDqhRbPLX62hM1WjrlD91DAhq2ITuenM=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by CO6PR18MB3953.namprd18.prod.outlook.com (2603:10b6:5:341::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 16:13:56 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 16:13:56 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Jiri Pirko <jiri@resnulli.us>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Sunil Kovvuri Goutham
	<sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH v3 3/9] octeontx2-pf: Create
 representor netdev
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v3 3/9] octeontx2-pf: Create
 representor netdev
Thread-Index: AQHamVpOk4r/tpYYKkK9e3oUMm7yXbF/H2GAgABOIvA=
Date: Mon, 29 Apr 2024 16:13:56 +0000
Message-ID: 
 <CH0PR18MB4339BF5712F2E93835E1EA08CD1B2@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240428105312.9731-1-gakula@marvell.com>
 <20240428105312.9731-4-gakula@marvell.com> <Zi-Fg7oZBCtCvbBA@nanopsycho>
In-Reply-To: <Zi-Fg7oZBCtCvbBA@nanopsycho>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|CO6PR18MB3953:EE_
x-ms-office365-filtering-correlation-id: 739f9d31-8d82-411b-8ede-08dc68675ef9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?VZAvVCnExzqA9QQrCt1rT+Tfnk4KuJlFxORRPkzILxXAPCLP9HjmkGUSYTZc?=
 =?us-ascii?Q?U7L+oCeykrqO0bh9/RNY3KwDqGOyCmdILvos89LVySZ4eVaoa4xXQjrkWhgv?=
 =?us-ascii?Q?i887omRmmuGSeOfFniOlcg0xtke/GwuLBMgbZYMYbBxPfZdtWeq+mo/MV7tN?=
 =?us-ascii?Q?KnZtlq1nsXy3qH0lHKZli/C3MK8B8RXWfrDpXcVeekhEsRCton27biXSA+Ym?=
 =?us-ascii?Q?Kdqwur1OYBH3hftEjyk8q1Vjx+4NP8rUism9tI1uR/namzcyF6rPvCCATYbc?=
 =?us-ascii?Q?KgInb4eryZRVjPYigZYLoxwfdgzFS30RqDSIjCSMsntCbHl6YAMQDFrDcVQ1?=
 =?us-ascii?Q?dxk1nbW2uaeJbH+UD7ah9xdmgES/X8VrKOE5qIMiarGqCx9fiugAceXgEq4/?=
 =?us-ascii?Q?kiDEEMsE123qUtXPlRqJtQGLPAN+Guxs37CrcYgDt7RK3KIcEJVK/QFdDhLh?=
 =?us-ascii?Q?MLMx8QPfGChJ6ox95Kl70YsAlYCf4ZsM6h/iLnDfkN8cnZkchYcEThexLYUa?=
 =?us-ascii?Q?4kxYBaiZZ/2LZbvliGTbnEikIs9Vd4Mogx9jee52sN88ZmQD03e/Lca988XB?=
 =?us-ascii?Q?1jESe3voCw0oq6GfBnMfqvOE5aup6is3KIqqvbc/+IbWtfsScdH8uS0EEHe6?=
 =?us-ascii?Q?hyAGh2xmJT6KOdLk7He/0bHnBQFmZgRCQk/mtdNNLTljHGw2iOEvm98W8MRu?=
 =?us-ascii?Q?zxJtJMETr5ADHw/TqPgio/0mAysvBkqhFp9EpO9Kp8c6Rw2slYyQNAEV4ip/?=
 =?us-ascii?Q?jmyvfMchbhsFcaBDi5D25Z4J8kqxu1mJw5TIsr921FdbNGaT+rUp9T94Fzjs?=
 =?us-ascii?Q?yd6N6db2lCVVJI67mTODkemGczO4Wipzs1PPanqME62PWHtQPThzakj+C/Nf?=
 =?us-ascii?Q?S77gTLC5Uzl4GP8hkyTUK4K715r/tNjb9zaBn3yLzlf0L9s5aC1iNtX6JBAL?=
 =?us-ascii?Q?vjxcsMSNYcZpLlfBGdD6oogax2P/mOE2mHB+J2acogpIWk1D63Q51ZmfcYQq?=
 =?us-ascii?Q?tdqkR7F/CA9+iMnfZfmPatduE7EPBkQ5wfPcdKFux+To2Qb3vkDdJh2hBnE5?=
 =?us-ascii?Q?/dXUAFI/b+x+Px8hopRxNiB1wBqt1WEUsnYAGJ8MBrnmsMHXcVxBuFc4rSjh?=
 =?us-ascii?Q?Vrq53u20nZYRJSKWEbUDBD6vak9N3bECns8b1NvIRBScmF4B08N989ti4g2i?=
 =?us-ascii?Q?sYhDfPvWkYNtpwdQeu3LFLEo2aCoJuGwvH9C/yhINKeIFE4DqkRxU4gJb07Y?=
 =?us-ascii?Q?t0HKsvdGQr2Y6SVltq6HvNweHRGHeg8USozMUxDlIUKHmbx9F6rF6lFm2Twu?=
 =?us-ascii?Q?nCQ/nyxg6+P/JlGp1TR0RbJCoON+6V+CEpXXqt0/2MUmJg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?pZ5UtfZwod0Pvm4rK29yBgX0Hi6UHk9SjMIcazo2tVXIn3CEvqEipfB1ROXs?=
 =?us-ascii?Q?jwaw+OGjQPjJHKJttSmgA1+ALboB/HS26W8FNbW8VkTJJMMq/fDTByE7QBBH?=
 =?us-ascii?Q?PL8+En1vzCEOtcmK/FI8Wnm/CNzIpDpnqNPrNY71SGdZFA/2a6+E3J6QE1wI?=
 =?us-ascii?Q?jDy6XZARezG16q64ScYjObo9ijBzDzfDslTuEheUKqG9sGqFUKy2P/hq0KW8?=
 =?us-ascii?Q?jrA/tBdB1Wtiz+Ch0tr7Ujn7r3Ml3maMBxDBP7rzSUF7M18mqpGJA4NSnw8B?=
 =?us-ascii?Q?2Ndptfu2auDDqjeFLM9hbncXuOPxzIfBrub/01hWNWe+tyPYaQfcsTCiv4rx?=
 =?us-ascii?Q?u24OXcsUvTbCsagItU2ZkcRoKKTIoIRQ4hMFppdc1zXcqQncCL5afy67qyY7?=
 =?us-ascii?Q?ucg8IUs5K3og6qIeZqevkyPWYk8bcvkxrC7Fbdtd9AXGZvgosch+iN9wGSuw?=
 =?us-ascii?Q?tLVAxD1ghu5z70ZR8xW0Rq7z6Wl5YGoQCZRXF+NbMXUwHf2upwx3XW224grf?=
 =?us-ascii?Q?Uc0E12aCIoJ+okUXLtkQB4QW3BDI0IylJ7RUES7oivlRA3g+L0Wrlr9wWore?=
 =?us-ascii?Q?JU0hSPUiFyXwFcQI3UW5I5v9AqGe4eLZdo7C2OFOzmoKGmx4gYyHDjlX0oVJ?=
 =?us-ascii?Q?RaogPo8eDVuAlZliBJzVFsyAvHmPapNd95fd6QuQtAbo3/Zm5z0nfeH1umfo?=
 =?us-ascii?Q?+uleXLuHRMSHJOa6MwzMJvK1gjCoNvZ/dc0jDsjARMNHBQ8VddOXuBp5lZGO?=
 =?us-ascii?Q?GIe/Qub1he652uMxpEPogf6Q+0GnaWqt4uD1kDY8MoF+KxbHM1J7m/LUARee?=
 =?us-ascii?Q?sRBSO8MKdvvGOIJeJTo1KWfT/QAAvcfs5I/xNIZ/mRx7jMdSmNglw1rJJyL9?=
 =?us-ascii?Q?5euU3wbz20SHIjmy/M9nJvX01LRjsLLz5zXqHgrpFgzXWx/QVEWfyjosz6br?=
 =?us-ascii?Q?KpkRegMgEG8gdaMo7yF1oFMacKvYcYIctZnatdrWn+4s9YnXHCEoOBH9M9Wa?=
 =?us-ascii?Q?FTqGBBBmcsn0NB5Yv5bP7iZ5kDvy84SlVDfkOrhzv6KuKnDaUOhFECr1E3eQ?=
 =?us-ascii?Q?h3+eHkQTj7M4AmSVTHDLNakMTr2Ww7hftDR6bXTKt00cehceWWvYAZS/+261?=
 =?us-ascii?Q?AdebiX4VtNnojmUEGqxfL8EwD7OVFv6Lptdw5/AO8WwlsjsFfNP1d6kNjyYC?=
 =?us-ascii?Q?e/DC1yD+IdPwbYT23MfqURpPSlN9gjHk3WoARDCxqggTdH22cX3JnCTmuv9a?=
 =?us-ascii?Q?w7Ay0WILDChwFFvaqcCl1BHIvqBjaboliIV7C/+ABjp8yfUMg+tTcGZuDCSh?=
 =?us-ascii?Q?deU7dc0+2uy2CW86W4l2O3M66fhhCiMMUSNpshKH2nbddWHTMX9iIOzAqNvf?=
 =?us-ascii?Q?0zfsBS5qulMz/yB9N1B2ynTfKwPJSq+/KsY0HstDOyKEfxs448GeeRPinGmN?=
 =?us-ascii?Q?H2+EHTynNKyzAOS3Arou3w62x/n2eaqXbnTeC5fJZc8o++VjlJQnptRfSTSo?=
 =?us-ascii?Q?e59rFidp0Ik/5yclLS8AQ3z2J6fYAHWNZAYpi4/83SgZIHMCFoON2w5DI5en?=
 =?us-ascii?Q?jwFHzdZKcmU7Ep6jkF4W5nTW7ufZEfrA7ykvJ2bgZyzRBGbGw1tCxrlbYSUC?=
 =?us-ascii?Q?oeatlUP7pHB3o9k/MQm95tc=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CH0PR18MB4339.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 739f9d31-8d82-411b-8ede-08dc68675ef9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 16:13:56.4077
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yznellFFFqOLx9N02ksAtvJpsucNgTQ7PewwJ7opJYrSWQu4RGnijsfu0pByP78dcQ/mf1f36kkfNbWqV1Tmrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB3953
X-Proofpoint-ORIG-GUID: H3kvg5ziQIC1v08EIQ70wg4ENjbBROxy
X-Proofpoint-GUID: H3kvg5ziQIC1v08EIQ70wg4ENjbBROxy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_14,2024-04-29_01,2023-05-22_02



> -----Original Message-----
> From: Jiri Pirko <jiri@resnulli.us>
> Sent: Monday, April 29, 2024 5:03 PM
> To: Geethasowjanya Akula <gakula@marvell.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org=
;
> davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
> Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
> Subject: [EXTERNAL] Re: [net-next PATCH v3 3/9] octeontx2-pf: Create
> representor netdev
>=20
> Prioritize security for external emails: Confirm sender and content safet=
y
> before clicking links or opening attachments
>=20
> ----------------------------------------------------------------------
> Sun, Apr 28, 2024 at 12:53:06PM CEST, gakula@marvell.com wrote:
> >Adds initial devlink support to set/get the switchdev mode.
> >Representor netdevs are created for each rvu devices when the switch
> >mode is set to 'switchdev'. These netdevs are be used to control and
> >configure VFs.
> >
> >Signed-off-by: Geetha sowjanya <gakula@marvell.com>
>=20
>=20
> Are you still missing creating of devlink port as I requested? Why?
Sorry I missed your comment on earlier patchset.
Wrt adding devlink port support, our plan is to get the initial patchset re=
viewed and then add 'devlink port' support.
Will submit 'devlink port' support as a follow-up patch series.

