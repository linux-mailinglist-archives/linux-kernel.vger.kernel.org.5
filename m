Return-Path: <linux-kernel+bounces-19290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B77A826AEB
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:41:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2584C2827FF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B9813AC9;
	Mon,  8 Jan 2024 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="XInpMI66"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD5011C89;
	Mon,  8 Jan 2024 09:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4084iuFE020014;
	Mon, 8 Jan 2024 01:40:10 -0800
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3vga958qsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jan 2024 01:40:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxfUj+IKWCoEICj9/4ruZtTREQS0i4L2usjIkjG+A6JRM7zurG2/YXr9EBgt1BeilsFO0pLFy9LRgM4s8+yyES6fn51OWvuOVi9pqYRlaVlNgcJtCOvIUWcGARIGiX7Z2ve11nyAtTBS4J4W4KbChj7AuChIbD4FB0NbmMni6mnQDYPB1rQnlKqN0yUXDmVi5Cw02Yc0uNvDZpfRVA7xo5Yyv5uOseLVose8tztfaEXLFDb8t68jUG5gXHB0+A86ugS4UULQ0a4X4tqlQm9bDWRQjMd1Oeol7kHcIOviaPYAXnuTQEwqI20gPjzrtzclQ7ZOyGOnYuUTSzkdkJO6TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VNNtFK21VSQyHfRlubg87HI8hfQLXWkD+Pm6LX7AwEQ=;
 b=SvDX2Cn1h4ofTGRwfn/0xJkLZqbDEaughIJVEykCBeS57+432MNcn0PgLchwHxmOQOCv7oEctSlpPSo0kp03bPNhweXkX8PR7McAkQL4mBPDa/2qChdIfPpP6WtIoMOoOgQlcDhUoxdRSvCPVAHlZ/eW1rZlqVhV0z3eE9P9NqUadcILpMmXtO77y6kMAu2tI+gkCYH6b/llbNGe9IdUERc2F/bRw/rcFM2TIdy46iS61ilqyaiD23Hofr3Hi1fhwcjUkrUlPBsH263Ek6dysnKpRenrfcgV6l2LcU6OFOzNL45f4/3ybJHZ+Dz+2N1/nuqhkinMg2b5CjPQWGN7Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNNtFK21VSQyHfRlubg87HI8hfQLXWkD+Pm6LX7AwEQ=;
 b=XInpMI66dRjP9JVWX2l/PT1yLK/jlH5y3aP9oQ85T3VQoQk0WOERfGSkrMBd0CjDsYyZVv1en2K8FJ07mXaBrQGguXvzlrhXjGbOW6wPKfjC+uQuTWi7Rd8Sgt2cX0UyXldVsTZ0XDLBbrO4iQVvFNt1fp6ag1VMKC2E08mrJR8=
Received: from PH0PR18MB4734.namprd18.prod.outlook.com (2603:10b6:510:cd::24)
 by SN7PR18MB3807.namprd18.prod.outlook.com (2603:10b6:806:f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.14; Mon, 8 Jan
 2024 09:40:07 +0000
Received: from PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::ca1e:e4b2:a920:25a9]) by PH0PR18MB4734.namprd18.prod.outlook.com
 ([fe80::ca1e:e4b2:a920:25a9%3]) with mapi id 15.20.7181.015; Mon, 8 Jan 2024
 09:40:07 +0000
From: Shinas Rasheed <srasheed@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haseeb Gani
	<hgani@marvell.com>, Vimlesh Kumar <vimleshk@marvell.com>,
        Sathesh B Edara
	<sedara@marvell.com>,
        "egallen@redhat.com" <egallen@redhat.com>,
        "mschmidt@redhat.com" <mschmidt@redhat.com>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "horms@kernel.org" <horms@kernel.org>,
        "wizhao@redhat.com" <wizhao@redhat.com>,
        "kheib@redhat.com"
	<kheib@redhat.com>,
        "konguyen@redhat.com" <konguyen@redhat.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Satananda Burla
	<sburla@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>
Subject: RE: [EXT] Re: [PATCH net-next v3 7/8] octeon_ep_vf: add ethtool
 support
Thread-Topic: [EXT] Re: [PATCH net-next v3 7/8] octeon_ep_vf: add ethtool
 support
Thread-Index: AQHaQBdBShrkdjKYx0aaWpM69n+DqLDMId6AgAOLKyA=
Date: Mon, 8 Jan 2024 09:40:07 +0000
Message-ID: 
 <PH0PR18MB4734F1FC933FC4E4BAB06934C76B2@PH0PR18MB4734.namprd18.prod.outlook.com>
References: <20240105203823.2953604-1-srasheed@marvell.com>
	<20240105203823.2953604-8-srasheed@marvell.com>
 <20240105193251.028e8eb5@kernel.org>
In-Reply-To: <20240105193251.028e8eb5@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR18MB4734:EE_|SN7PR18MB3807:EE_
x-ms-office365-filtering-correlation-id: fed9a327-b21b-4516-b0d4-08dc102dcc89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 8FysZBPEuH14O8IFiBm7HW8/6wmM3wC2NHITj6z5e74VS4r4KbYMgCR8SQ5QcWAjL9r6B9JEmObH8abI25GFCuGq7vQJxVLOlznT1omx+bI+8+91/4AzVJkGqCjBN5gUE3VUeIEfZa77+fmwC6PSUEskmVePa8L551lY1KBmhNFwZh1I6c6cxlY6UlyDnfHyD+KtEr4MPFX+k58soNKF207vvP5mUbrMzTd7yNkRdsSITJfDPeeqojXFrTfk3I9KVz5WqwJcbhRXEPmjABMdCbYU53Rl2K37di5AkaIYAzrEn+3AaMMZ0h3h7xYL9ucP4r+03s4Ux6LsUz/ykkSGJHIIxQorECwZ0IvqfCGKN+KKmkokpdXXu6ZxSMXozsHqwt9G7DN0RHxxkva8+ov8lhAmCIxeB3c/T7rjT5pSryxMCu69rapjGSlRZ11t8eliO1O/Xwn0Xdq5w2wPR2A5RyLSdtk2eK3mB0VPc9Ctr44alXCRepeZy3lQfzcBcmCKEfAwio9xCflwu9dzEHD0639HoRyF07D7aDjhXKHwCC+INZv2k6eQlMsEcs0hBt4nkxV4HV94S20kCQUBajM6ct74VcQ1EoGHQxawxIPGvzIcnNrzmO74MtNebzPwUGNULPGSVFGVE1gIHHKetko8jvdjVlSuzlGEgM7EPiHWtmI=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR18MB4734.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(366004)(396003)(376002)(39860400002)(230922051799003)(230273577357003)(230173577357003)(64100799003)(451199024)(186009)(1800799012)(55016003)(53546011)(26005)(9686003)(6506007)(71200400001)(478600001)(7696005)(122000001)(38100700002)(86362001)(33656002)(2906002)(5660300002)(7416002)(41300700001)(83380400001)(38070700009)(66946007)(6916009)(8676002)(66556008)(66476007)(66446008)(64756008)(316002)(76116006)(54906003)(4326008)(52536014)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?f5h0Qn/iYK2HKt2XqTy/QxzOWvV4f4hQy8sbVuCPKY6XA5qWEG8DQR0zuXVW?=
 =?us-ascii?Q?rysgl8jLSVHGfzrzgVmxHYUOfBYsJKSsXNXC42+DzbLd8N6hYsraCJM6mnai?=
 =?us-ascii?Q?Xq12PTns4BxxaqnAesSzP1BR4ZbCSY9Zre0l3waBX3uCP7Upx/DvSLIyPjug?=
 =?us-ascii?Q?CIKFzvE+/yVMkVvUnK0+YMa82nViCqDvs8Q/yuUKoISh4S11bBogPrZaOonj?=
 =?us-ascii?Q?sAV4wcGR5VqC+V8Tpcq3Eukjl25HhAqllAR0cmnKtdIaTIBZsVd2nyutnlPY?=
 =?us-ascii?Q?vjeuV3PxXbDaPNp5D1AF3vZfE9aSvNBLcFPRTZa73YxiA/07DMnK3OqHB66U?=
 =?us-ascii?Q?shZswSfMOHnIEe/xZn51ch+G7wIE2G12BUEMT3glIiNicJVgZTYbs/5L+6yu?=
 =?us-ascii?Q?0ep5Q7kZ+qnJ2FZGLsFmbVa1DO0nr02fBeYpLWhgVod+igzpVpN+uG8jeGkD?=
 =?us-ascii?Q?kWer6y0IJ0tCcw2K4J+9pQRMXH+xQyVGqHEXTyQHTANbWVDMHtw4KL4SD3Tv?=
 =?us-ascii?Q?EaxY9TzVQIrJDO9In9144xTGKYJBtzMCpuPEArkbcytdWx7pr+XEAJmf6ouI?=
 =?us-ascii?Q?eP+N+4hqi9IeDIA1kmhLMUskEN5Y8TeQ/NrixfZJmJ7S75v9JM7IJ2z7bjK3?=
 =?us-ascii?Q?NVa7G2nsv2BJ/vuGj/NlcgayJlPnpwh8gf8Zt98OaA4K50cySB7piS+TJ/rz?=
 =?us-ascii?Q?i5d8sPfp+ERC3DWvmufmAi5MFaAfSXTwRfvnXP1YLy1059QXPAZV7Q9lJtTl?=
 =?us-ascii?Q?SCj5+a0xIS+uDW0ZKyPyFKzUXwWXWjkhtQeRusvrM3Qr2bBezrATUBVg22HP?=
 =?us-ascii?Q?bFXMGXWr9bUwDUfK9W2NbaEsAZhBzKrWbdKBw/KSrL+lCXrjjO7Db8bJKizH?=
 =?us-ascii?Q?IG/UmKEpdEVg7qDUhe40RhzkxWNczltMN+RmoJkMLwpLVaz9VUoPiECBghSh?=
 =?us-ascii?Q?WhRED8yXJOgY6uBh1iVDqFfWPvdMBu4nLRiuACKc9/BVMfqxnBULDAhdVROA?=
 =?us-ascii?Q?CQkuQj8Of8I6XWJK2HXWTV4aU6SqaA/1qpTE7kaFc4c21J0DCudh2JnWTZP3?=
 =?us-ascii?Q?jhzcjFGhfFTMITr58Gi2rryso4lkW36zcmR9kDdCY5cdUyplPyVJ1fSX8ECq?=
 =?us-ascii?Q?HxYWmgJJAt5o5VIlMcUyXBv9lYfeGfw3Y7j6TERNgZXw6Do2gVwoW2eeTr/B?=
 =?us-ascii?Q?hTEliyxy0eqK2eZA53+Wh1onx3io1AdK1xgIvGa6drwYWKUyXMvBr9wRQ88R?=
 =?us-ascii?Q?bDi/GUquZQpsl0oKQGr1PjY7TuA2I5bihJLLSim+qY/OB3zwNiomvU//ubLo?=
 =?us-ascii?Q?jgCms0fTq/1cu/rOH9Ywq58wbU5v+MNLQO2cYzwud7x4Kt1t4plahpU1uNNn?=
 =?us-ascii?Q?PUqDvTq8ddmuzf+zLjkyPFpSZf/P+FkGdW6u1i2PZSYvsJfcQM4WMpPdee0k?=
 =?us-ascii?Q?qgur9iKUUKAUWjZbp28au4N+LXzZ2ikv4Fz7MZLbJ77BvqTDuzS5xzipvekq?=
 =?us-ascii?Q?me2xbFYFa/gbeYWvQSMe5PkMsdoeBq/7khjpuW9PbHzLirZ7Wh4Yeq2aVzcC?=
 =?us-ascii?Q?k5ZJgbqLx9gkkHLFgkC+9ga6Vpis4tkdFrwSypjm?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH0PR18MB4734.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fed9a327-b21b-4516-b0d4-08dc102dcc89
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 09:40:07.0771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xmyXgYGcFvlJ8pLzynAAdHOo/rFfSU+tfYtmKzFqMUFkKtsdltJIiLdnwy6NQT6nDbqWw/xbvr2T9tZvAmy1BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB3807
X-Proofpoint-GUID: 2yFOyl6HhOrWc0xuETXCPcb1Q3AH3gOf
X-Proofpoint-ORIG-GUID: 2yFOyl6HhOrWc0xuETXCPcb1Q3AH3gOf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

Thanks for your review. Will submit V4 soon

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Saturday, January 6, 2024 9:03 AM
> To: Shinas Rasheed <srasheed@marvell.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Haseeb Gani
> <hgani@marvell.com>; Vimlesh Kumar <vimleshk@marvell.com>; Sathesh B
> Edara <sedara@marvell.com>; egallen@redhat.com; mschmidt@redhat.com;
> pabeni@redhat.com; horms@kernel.org; wizhao@redhat.com;
> kheib@redhat.com; konguyen@redhat.com; Veerasenareddy Burru
> <vburru@marvell.com>; Satananda Burla <sburla@marvell.com>; David S.
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>
> Subject: [EXT] Re: [PATCH net-next v3 7/8] octeon_ep_vf: add ethtool supp=
ort
>=20
> External Email
>=20
> ----------------------------------------------------------------------
> On Fri, 5 Jan 2024 12:38:22 -0800 Shinas Rasheed wrote:
> > +	"rx_dropped",
> > +	"tx_dropped",
>=20
> Please take a close look at rtnl_link_stats64.
> Anything that fits should really go to standard interface stats.
> This will benefit the piles of monitoring SW which gather standard
> stats.
>=20
> > +	"rx_dropped_pkts_fifo_full",
>=20
> This one is probably rx_missed_errors

