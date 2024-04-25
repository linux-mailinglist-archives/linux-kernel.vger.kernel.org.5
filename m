Return-Path: <linux-kernel+bounces-158041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 143B48B1A8B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 378771C2110D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31A5D3D0AD;
	Thu, 25 Apr 2024 06:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="s91snpBy"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C053728680;
	Thu, 25 Apr 2024 06:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714024921; cv=fail; b=WkjKfxuM3R5Zy6j5+aSZWo/+HfKELnORZXv4hNR9YmmAm9f3pERMXZuCUWVrP7At7Gei8skACn48nBCpnfrTFFNkurY8vqkOIcssXVkOHk6cFCZ8gKdZdlJGE/bFOzJ2zF4pqNOje3/hxsZMItpRNb4T7/voFGqecg3VkZ4D/8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714024921; c=relaxed/simple;
	bh=ces2iRqIcqel34Z1/HFCW6Ogj+M4ikh/292QOjSyptI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cPqnA5vJySAAfGK5KNQwvLvD6unLNcVyYF4/fY7mqbJnpyiBNhYjthL4iok+u9KBv+rW5aRVITiZCHCaVQEdnc808rgLbr4O8N/3WKlDHjlGXKePgpR1l4KJcu8hJDICJRfigLUcu+odOit5tfj8yND+mPxubrlENf8MPn7Qogk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=s91snpBy; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P1hkhv031580;
	Wed, 24 Apr 2024 23:01:49 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2169.outbound.protection.outlook.com [104.47.73.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xq284bfpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 23:01:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Nq4tY6n2PflXazgtJnEWGlE0zQsNha7BCzdq5lL7uIwG/ywR/CWwMlxNuQ7iB0G0Wm2XMv6tKMTifuQarYX8UQMW9XoPqp7PKSJ2T1jzELRuSz/a0MmCfs7CbJRWyh8kNGq5bJG6Z1VzXt2e6OfHNysZm5Qpf+S09OsIzV8QaQHe0mwM/+4xBFiurlf+V4/k4uieSSU4wW/iMlzsJljK3AfBPz5BWAj1MQUjZdmOz6kk7z+yV/kwf139V1RePbBXkOhKcrcbr2jWSypozQ9WzzP/UBS74KOqDIKGomIO8raHH+en65uEI4nJQidPr09JUGfJGdYYgFRW1plv0cIfJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ces2iRqIcqel34Z1/HFCW6Ogj+M4ikh/292QOjSyptI=;
 b=avEOTLAXKjJGUqEe/sWzWfWd3EBiEl6V0KWoO8FW8foBLz8prabseA19NfteUa47AanPI4Z1jwXzeh1iPVo4TMyU+wx87j9d/i4UVcZgNWuxlmruX2nd3vw8JWuh/qtdWmRe+9D+JxGbbw8GKMtU1oOz0Apc2DDf9Y3nyEbinTE5D5da0bIJD+59wl/OF8sLnwPCzgm4fogPmdu5iEpEK0geq6TQuGlb8JpAkimKrvQ1qGhWdtNTclhwhpOw+iWxc+oyXf/9y8YVj6kWGwO09wf1TaWU+9mZb08JotSOQcxzXX0zqie1w3HdmQNQndXIYSsbrg26Eaux+7b0A5CnAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ces2iRqIcqel34Z1/HFCW6Ogj+M4ikh/292QOjSyptI=;
 b=s91snpByKewESib0oolZxLRLuVHC6l25jU4u1QymEbNQB3IBBKVOC6SNotZ9AVSfuMMIPCn0nBQbVP5lNDLPhAALiFysCrM2fHWzEDBNvLqsYTLOQyBvxOFz1kaz1YQfTfDRNOh49mEKSXJ5fP0p4E/DoH7aP2jVJqoqrULwaeo=
Received: from BY3PR18MB4737.namprd18.prod.outlook.com (2603:10b6:a03:3c8::7)
 by BY3PR18MB4594.namprd18.prod.outlook.com (2603:10b6:a03:3c1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.46; Thu, 25 Apr
 2024 06:01:47 +0000
Received: from BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::4c91:458c:d14d:2fa6]) by BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::4c91:458c:d14d:2fa6%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 06:01:47 +0000
From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
To: Jiri Pirko <jiri@resnulli.us>, Geethasowjanya Akula <gakula@marvell.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: Re: [net-next PATCH v2 5/9] octeontx2-af: Add packet path between
 representor and VF
Thread-Topic: [net-next PATCH v2 5/9] octeontx2-af: Add packet path between
 representor and VF
Thread-Index: AQHaltYOAVZUsaVMhUStY+HonACP/Q==
Date: Thu, 25 Apr 2024 06:01:47 +0000
Message-ID: 
 <BY3PR18MB47379134443CB002D80A7F90C6172@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <20240422095401.14245-1-gakula@marvell.com>
 <20240422095401.14245-6-gakula@marvell.com> <Ziey7sruZrtq_5Hj@nanopsycho>
In-Reply-To: <Ziey7sruZrtq_5Hj@nanopsycho>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4737:EE_|BY3PR18MB4594:EE_
x-ms-office365-filtering-correlation-id: 85079c2a-f059-4c11-2d09-08dc64ed3103
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?gXWngUoLlGZ5h6ucj6mZ1t8ogxpJmKe8+5wQxcZz5kEQQYvxucLAh9kZ9xLi?=
 =?us-ascii?Q?fWNwA8dT9SiaJgJatoGbQCuzqIzkSPSCtP9BOHP61PiTZhbo5vlUuD0Rz7cD?=
 =?us-ascii?Q?iOE4E0uCmGjE1wrxjqbv25UiarBLTMGEb12+IikUXdTyDrLqJPvGU7dH8+3R?=
 =?us-ascii?Q?pv44I2TaCaKy9PODGgKm6vJe6X2jVl6y/qqyp5GCzLV+AAPVqECfkXu3IhDY?=
 =?us-ascii?Q?/c35C4XiYazmlQLeX5qsvXF11TQPdju/v9d+cFs0TfaOeJxpwmExUo8A8AfS?=
 =?us-ascii?Q?INI4GrBHtmaSAWS0nWMT9+bYCDVaPyyYLeUcxghQPl3/UfKodGgbxV2JRNAo?=
 =?us-ascii?Q?uI97/xoIlmzgum/JU+likpUsiPVTqMcts8cU75h5f5IdVFT8Vfx0yccOGJrE?=
 =?us-ascii?Q?obX+rxQMYVJOcFYi2kSipipqDvxTcnHpyUu9EGoabQBDqFu8SSSQr9wHleEg?=
 =?us-ascii?Q?HLQT9aqSmMpKQojE47wnfxNSm0AVpWMP7CkbxCnMsGjgOj+m5sdb8ZyZ+G6L?=
 =?us-ascii?Q?Qoc0RW9nttSBaZQ7hBtKCg9kaMIPXsa1VoSYK+XFD/0H2SxF/2YZD8cLwUW5?=
 =?us-ascii?Q?xLZrASUsqxz+67pNPH3hFn9ooUg/PVVeluLeQsHvt3HEZx5islc6E5WJva+h?=
 =?us-ascii?Q?lH4RQ7CgjOkIVy/KaLgDC3YctANPBC33Y1mF0UgBBy3lSeCO5e/ylL4vcu0j?=
 =?us-ascii?Q?cSaGpSLKmia6fRBwnb32ppuwvP0xEOfVXodeyxcqe05IEswRllAJMeV/lUQz?=
 =?us-ascii?Q?hlv7B7r1R15IYIFmsM3+JJ76z0h1l+TanjlBZq8xMFF3BFHCX/W7Z+culMgC?=
 =?us-ascii?Q?TI8c9WlIDWl3d4GG85pKWYDRPMSCFMDzCxVU5ekaeo19mLG+c1ySQgpCCQq9?=
 =?us-ascii?Q?LcZygHiTlkh//qgrsrJi+/zMCkeFmXai5pZj3p1CxhRJL4f7KDkp+hZ5Ukz9?=
 =?us-ascii?Q?YEqaDQYUOdo7oLSkbTtPU96JSxlmqBU/ga/K+PYv5cEMyC3Lfhy66RGHwPcf?=
 =?us-ascii?Q?WMeTA8xKD+EWzG0Lw1P5iUNCWzehTfW7ObB/EXeL/cU9HL9Zit+zotKau4Bf?=
 =?us-ascii?Q?9NQwa1311g6WPTQIeFQ9YgfG0IISiOEpavkSkCbx7eZNSjnhgavq2QYOOBK+?=
 =?us-ascii?Q?4/mqxRc+1cG2EWaFY1O3IR5kWRN905MLsM6sRpXfcV/BsQizWMQzg8OSBdnY?=
 =?us-ascii?Q?OuNaq98hX5bKglxCxSQv+oQjfgQs1zcqahHP5LpF3Vei9/Nlm6PPFzxZRlYO?=
 =?us-ascii?Q?XweF9TddQbSRNq2hmxGr5GBpFc0HBZLAj2OEdNIGAwiJXou5626GwMUtNd0j?=
 =?us-ascii?Q?c+OMMHxciRxjoXYuSM6tXG4EL8dUp6IVETI57jL+1eOzXQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4737.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?0mGL7JjOfPmt1fZ2thrhnJih7D6XR2px6HrUnQ3ULnTB5+xF0tMiwo6iiX7U?=
 =?us-ascii?Q?+5PKvfNVqCYrVHPL1L5KaabE58C3uDHFV+P9A2EDZksrvFCDsx/LhOA0c5Nx?=
 =?us-ascii?Q?TGuEAHMPcHxzgJ2eSV6/SX4L1hP6eDp6RZHVxGU36osgRUqUWvgPmIVQjo+g?=
 =?us-ascii?Q?p14z8n4yxvb7wwt96z7kKswI80LwJnGLFQBkEX22jhiZ2wjuIuKcyjCbazt6?=
 =?us-ascii?Q?Hvb000kxlrW9kohlcbChTGDxIrlSsbFahdp3ZE9I8QNQgO1jeIqM6yREGqqe?=
 =?us-ascii?Q?K5ljZO9XFEor9sSYNsYSJEDMAs9cKk/o/ekOwayormiSlBI8SasQQKqNeFNQ?=
 =?us-ascii?Q?CBJaq0SjLBodzdJzROYX8QOPvujrL5Af9yw/buTP1OqvJYV/qEwJfwgIBl9K?=
 =?us-ascii?Q?V4iKQ5KkUWn+NwWJ1NI5LjHAJMWUuXhKhAVNYzpPY9+zdNa0BpdgHm45lXPn?=
 =?us-ascii?Q?3UiPTyRE8OtCODPSA7CEBhZZUewWDJDQrAuHmZFCToT+uwuH0s97e7hyfzVf?=
 =?us-ascii?Q?WcUol0hhCSBKuq9612/lUpJGSZXlBo9NdN92U4+6t6BmFZmZ6T7yI8mRqekX?=
 =?us-ascii?Q?DowRVT4BhNcKaveZg4q5zoKoYXmM6ziB5m405+jyUfvOp0giN7yrUW1O+f/T?=
 =?us-ascii?Q?goMFYD5IMxVRx2BLI5b7ZV0fzO8Dkt3hMy1jeT8kUjipdJiF1JxH+l5Uyoty?=
 =?us-ascii?Q?Gt1AyrdMIY8kGPJbQDhkXjESoFHPYcPY05qpTO9PbLo8hy+fJaOkiyRxpu+1?=
 =?us-ascii?Q?UDdWshI2DW1kIWM93KD98ZfpAYip9fWv32kBZjknFlzeHaN4e287J8ajRyq4?=
 =?us-ascii?Q?UVvKDRu3btyz/JWfgF81p66mICiZ0/pr98lro2s3p9DC9dkpNJAfr31kcarP?=
 =?us-ascii?Q?2W2szJvz/4/gKzQoX40luNhF8aeANOHwxHi+k1Ccv7lyG25HjgvLn9pl42gu?=
 =?us-ascii?Q?Zp/oOZrjsRQjQAVvvI6uDQamysvJzG12Ti0ZdVYdWQV8IWxGMmGU0zDgVYRX?=
 =?us-ascii?Q?hdyMkTsbpgsd0b7NtIeDsxMA+sRc4SBrAVg/KcIfcSx1wahQdVj2F+whxzVG?=
 =?us-ascii?Q?lgF5yKn1Fm0uU3JA+K4OC04FkjGp15BsFlsXxYeqQQDMjn1R+htjO6T6aL1N?=
 =?us-ascii?Q?8G/goIg0+XorJ4xBOhjDkyySeZ3zx+Inpd+6H6iuZ2oPacS5JOTkN7EYnLCh?=
 =?us-ascii?Q?DwYdYABf7Vdxkia0JV/Mhcmve2MFunet+KveFrKyocRdLiZf7Ps4M70TS4Ps?=
 =?us-ascii?Q?tIBEI/Lcbpqk5CVETdQ543lqtZcN0IhJP6Lzgq/yt5C1H0A7dtsAJ7/Au/V5?=
 =?us-ascii?Q?UbVZpbo5htEIP50W2Op6my3Y+otjE4p6tT4mgfQggl/4w+cKuviOYdmR0xtz?=
 =?us-ascii?Q?PTmt6hwOqV2P7eUykAps5F6YfQ0lK0xi6UWkmocXUh8YdepzRkIbmrbMI6pV?=
 =?us-ascii?Q?NzWZ7AVchEtJ/T5PLCvY4XYR1qy6mW3InvGw8lqgpoNxkZU4vnIOPpm34nUg?=
 =?us-ascii?Q?wCZeeCohTq2TkTo00dbN3sRoFkfdUcxmvtcucQKaqNEpvqUzVnS0tygKuSLa?=
 =?us-ascii?Q?k6PbqliAWPs3hT8CCx8KgLH9Mb/phxEaDd1IeSEQ?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4737.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85079c2a-f059-4c11-2d09-08dc64ed3103
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 06:01:47.2040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Utz+T0PrTPk4aCt1676FqZ1hdDMZnBtZn9PvzNFF2HD2tmrj/CMonTOKWH6qD+28OFcr7s8B0QG41CO6+h3w2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR18MB4594
X-Proofpoint-GUID: iKAlSLErPUlOc52tBEfA1zgeJOITMGtS
X-Proofpoint-ORIG-GUID: iKAlSLErPUlOc52tBEfA1zgeJOITMGtS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_04,2024-04-25_01,2023-05-22_02



> -----Original Message-----
> From: Jiri Pirko <jiri@resnulli.us>
> Sent: Tuesday, April 23, 2024 6:39 PM
> To: Geethasowjanya Akula <gakula@marvell.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org=
;
> davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
> Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
> Subject: [EXTERNAL] Re: [net-next PATCH v2 5/9] octeontx2-af: Add packet
> path between representor and VF
>=20
> Mon, Apr 22, 2024 at 11:53:57AM CEST, gakula@marvell.com wrote:
> >This patch installs tcam rules to stree traffic representors and VF
> >when swicthdev mode is set. To support this a HW loopback channel is
> >reserved. Through this channel packet are routed between representor
> >and VFs. "ESW_CFG" mbox is defined to notify AF for installing rules.
>=20
> This sounds very wrong. In switchdev mode, there is no implicit packet
> forwarding. User configures that, either by setting up TC filters to
> match/forward packets, putting representors in a bridge, etc.
> Basically the driver offloads whatever configuration on representors the =
user
> does, in case it supports it.
>=20
> Please make sure you follow that.

In our HW, there is no in-built switch which will forward pkts between repr=
esentee and representor.
When representor is put under a bridge and pkts needs to be sent to represe=
ntee, then pkts from
representor are sent on a HW internal loopback channel, which again will be=
 punted to ingress
pkt parser. Now the rules that this patch installs are the MCAM filters/rul=
es which will match against
these pkts and forward them to representee.

To be more clear the rules that this patch installs are for basic represent=
or <-=3D> representee path
similar to Tun/TAP between VM and Host. Now for any further offloads (eg: L=
2 or ConnTrk)
user will have to install explicit rules via TC filters.

Thanks,
Sunil.




