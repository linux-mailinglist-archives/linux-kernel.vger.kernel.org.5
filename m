Return-Path: <linux-kernel+bounces-142626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFD38A2DFA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 14:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E636C2852D3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 12:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1B856750;
	Fri, 12 Apr 2024 12:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="mzkEOI57"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EE04C624;
	Fri, 12 Apr 2024 12:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712923670; cv=fail; b=Qi1EmVHKSk/7oU/rPz36UrbV7yVB7GIryqI2YQf7AgYtG6Xz1vtF9oLEXNNNqRqltyGxaiQFX2ROR/WaWe3kkKfJqTCBJsFDZR4e5Nzt0nnWABloUrP2b77G7xKK6QYsj6Q+/KIVST/lQNjXb5a9/FK0ELtk71MAwCjr2KxqhKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712923670; c=relaxed/simple;
	bh=1IDQuHpCMmk781vmQ1tYKTjHR458//wGRp8F/KhhT9A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=G/q008s+yjzouU1F2GX/uezRLT7+H1ShEHQlCrKiaDCdAo8trXRk/h/sI/l2rHNDgDnhMj8p9g7lF3QYVRTyFD3oWNPWQwvMcj5sjBxIQB129uioaIpWa49QONuuQgI0xlHsRf5ovGRVH2eVfNWXy3QnHfX2SpHeEt1su25ufbM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=mzkEOI57; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43CBkr3D032185;
	Fri, 12 Apr 2024 05:07:43 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xexsah598-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 12 Apr 2024 05:07:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pf+9vVXi+0a+ZWIPd3Jnu7DVwcDdM14pXmTA1kMocv3II+Ur7FRN+xePBACkODI9kj+9De3++w2WYGlHvmbqymnwALebLEZZ2DqLq6THiW3in2VWbV3pVCoPqub0uHsfNtoBx5KKhw11UtMeuihQbyln01o7Ji8u6wjqDM4xr0GGAyfnFibM7kHoA3VtVo25357Ta0R4Tyrqyf/d1TF906XcsT5flaGZ4XvqJ0iLTWRfXKYVJKP4b2F4jqOhTWs1d3Db0G7lc5ggDO42D1lzKI4WB5A4WfBgpsyeNOeJ/O8HbLpiCY75H5i/nlJuXuoIXgT6/rR/4SEnuBoFQ/KPnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1IDQuHpCMmk781vmQ1tYKTjHR458//wGRp8F/KhhT9A=;
 b=oZDUXalinRm6Co2vH83CCAkP7gDvWAA6ERQX2nT1fzGeEa/53ZD8kJThwsq57V0S5oEE3qi8V4Q735h0NKgEUxufOC6yM+ST5xSBjb140nofIWkB7ItD3PcmjvjA5l2wt5GBwWQYgWPYBL67adkJP3dGWAd8NFYkIAY0cw/W/sfdp67gvDTPraSG81Nyw3thgYSEJg8s2EmNqwGycSAxCXAhEh1ojpyEq/LdHQQ0uE/n3wpg/H4gcOTr2ZqmIIEkM20yWrTtGZb3wIijfu/SItzBB5S118CJWEKfPG8qdN3oXlBINuUeJjFcHTYUvvYi9tj4jBBIhFPeJugekiOXXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1IDQuHpCMmk781vmQ1tYKTjHR458//wGRp8F/KhhT9A=;
 b=mzkEOI57QFzOFegrUpNa7qOhNGMZ+NjUVm/4+x4yIyVRwcaFG9M21bUOl/3vyV03UH3gjRmBkMHkCylOPPxzhM+wgKaU1kYrRu4uWIUxAZzBGZ9MksbBUgPCGQ3UZ4R93SXdkQfTovcqdLgt3+VyAAqQ3OFMvWngBILxbTqyk3o=
Received: from BY3PR18MB4737.namprd18.prod.outlook.com (2603:10b6:a03:3c8::7)
 by PH7PR18MB5057.namprd18.prod.outlook.com (2603:10b6:510:15c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Fri, 12 Apr
 2024 12:07:40 +0000
Received: from BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::4c91:458c:d14d:2fa6]) by BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::4c91:458c:d14d:2fa6%6]) with mapi id 15.20.7409.055; Fri, 12 Apr 2024
 12:07:40 +0000
From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>, Hariprasad Kelam <hkelam@marvell.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Geethasowjanya Akula
	<gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>, Linu Cherian
	<lcherian@marvell.com>,
        Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
        Naveen Mamindlapalli <naveenm@marvell.com>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [net-next PatchV2] octeontx2-af: map management port always to
 first PF
Thread-Topic: [net-next PatchV2] octeontx2-af: map management port always to
 first PF
Thread-Index: AQHajNIEkFklwUV4yUCKEkgnURAeSQ==
Date: Fri, 12 Apr 2024 12:07:40 +0000
Message-ID: 
 <BY3PR18MB47373F66158D5E98147EDFCDC6042@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <20240410132538.20158-1-hkelam@marvell.com>
 <20240411195532.033e21fb@kernel.org>
In-Reply-To: <20240411195532.033e21fb@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4737:EE_|PH7PR18MB5057:EE_
x-ms-office365-filtering-correlation-id: fa53836e-f819-4c31-8c60-08dc5ae926b1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 TOWFe0e9m2U9MN9jwyQqbDemgfeQxQDEVMY+/wgiwmFvGzINN1npxng8jkNxJujIMyUslZe0/NJpfgO45pMU9QQ7JnyldNYQtsYdVFXNIfZp2CwEJS5W1GD8CNuwFz0wkJW7xMJVFCvOWyBpz8W0Jv2lH+z/2x2k7rVcbtp8NUx2x0D4jXW5k4YU5dtmTOxN1OFgPSLrYDlEBYgErf17E1df39YmaIfauYQle4DAT+RCFEG4oiqxu5aXUjLYtMFtQiPMssK3pBjYOc+fNJ+Gm33H51RhB8A5afzz+uvMyBnjxHcF576ERxHxbWagenmXS56id/O2tsfpLRMqEHwz4baBNyCn4KST5vDQWbPuxe823nTAovqskFFiJnVUqP81l7fokLqkHVVkjqp+ggqFMBJlXoR4efL+EcYMr4oO/9zt9z0ACFGctgBTuvCixOL9xA+3rzKrR9DZeN9qLhQI8z13P5ASKmr87+zx4DkHsmMycYr8RHcQ9EU29vVy8saxMa2m6qZ+qf/s1+ggHWt61aSYKL8htFEtgVPqp5xu9AsvPr3oZhPQEKBHafjNWcGWuVlt29f3Q2c/b+jDdQeuXk/SDJ2Ff1jB4xGsl9cllIAK9k9hPKZQVtIKqZIs2Ao4W4b3/LEg5Lqwk19kKMLhZIFyQ5C5nu4RXYW4Vux1gmTWrN/+BLiar7P5UqEml6DV8dcpn2mmyCwlPxxmiNl6IQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4737.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?lTJ50dxUa3TCDgQS8TYQfm9scdfFltKuPP3k08Z6ilRdFhcxij2kZN3VXe4U?=
 =?us-ascii?Q?hjo4XZWC53VzPd6xpzLCKd5ht7ERhioyFcVmubz13gVxbM8XZT+jt/jmxQes?=
 =?us-ascii?Q?0N9xJ7MyGOqGyvhqqL+x2l3Wf3hdGegprMuCLN8xoY1SXYgIOEetFNkvJEuc?=
 =?us-ascii?Q?LGqF9lQqWOPvqhVHs371eEflrHPqJkGnKkOMLaUDixyJJ6sLsCgpMtvsx+wm?=
 =?us-ascii?Q?iuIqeaYR2G1GG3Lk4V/aC5GHXxX20C0eGAvAMBrJSvSoazgasfvz48sg+UOB?=
 =?us-ascii?Q?qC+QedK+mxa4nO/UghPZ8oqNutAFkfcJpAexGsNbNZgctfRnIxKRzR7Ri6sb?=
 =?us-ascii?Q?XUFEC5P2EbGMlSHZVM7bQl8x46VJqWxn9nF0Q1DF+hP93rP6563NvQoPM/d6?=
 =?us-ascii?Q?Jgt8sLYvix0UScVjOdsAGEH2nKD9OyM4QqVTV4E1ucLOEYNl1kJjlglPwFnB?=
 =?us-ascii?Q?OBCgocFzgAnxa3HpbBIIYWdHiBC6W9UPjlUOGJrheD7DTrK9/q93hq8marij?=
 =?us-ascii?Q?MozV/WhGeOAi29RdDTLUI200LzCsy9a96njch2Y0RLP8OwXmaYVYN118pk4z?=
 =?us-ascii?Q?jKpuNjhlNBNpbvzmoVm9Bjexy90GtpKtUmxe8ooIbQUM9sEs4Ifq0A1IbE5w?=
 =?us-ascii?Q?lobyVnlBgSVFXbaNSl5SbV9vHl2wDC7wwW4HyHVvyoLa/Xs5QGNyQUvI0qUT?=
 =?us-ascii?Q?sRkyZXP/TI8HTKP4RDUi/3Y3UGYjSYhfSWZN9kqAJKfd5c4zmVVEVDdQAyYC?=
 =?us-ascii?Q?ReM2DmghiPyS+gQP6Bbuag9jrGzMfbMY8TDkjS8+KoMVT46L2INyHg6Kip6o?=
 =?us-ascii?Q?iaV9QxbUMnb8L4Q8gqY0dY9RGFj75CFcj97X4kmoraXRhRIv8CaWfLJBs6q9?=
 =?us-ascii?Q?aqn+PS+sO3nfQ7wJlhpEK51+keYI5aMS9ow6L6E5FPMiHPCkjc6dq7wwQaCe?=
 =?us-ascii?Q?IQpPzFG7JR/9b9K+KUxcdypHUv4vtjeqq9Jkb/Esc9W2g+0GdhfSGosO3cMQ?=
 =?us-ascii?Q?uQ9MRznKYguqGJ9CwN4IcRR5tM6lAsfSG+sJIe026uztgYbomvzelQIZuFTi?=
 =?us-ascii?Q?bzPYkbHgJQv5se3p+UKJM4XL0jUYWvYO3qZQdPI1cBGdYLb7pHuyts907Px9?=
 =?us-ascii?Q?GR9S4WQuGjcjzmqe/2KLovB0NQxVf7gzxOiTAIT1l/m35AxJNREF/aKnC4hV?=
 =?us-ascii?Q?hiz4mxU7aRAfz7KAPcLjB8mMcm/mwhBsnkWZjjzW23Tb3znLymvbLR8IYQrP?=
 =?us-ascii?Q?dBl3Hz7Qm/xTZ+1zFGrtOadIcPStiVjw+H7GMb8FrdulhYoWeWOgkEdmAUe8?=
 =?us-ascii?Q?iQd9EBWz5WJDFQQTDRLE5ak5sjOALJ1qzEQPvjjbB5Ele1drtmYr0SOsGJfB?=
 =?us-ascii?Q?vBkMBFmzP/r59aJI9LIjZ+7Kko/335oQEw8t9LeE88QHSdxdItudbwPubcDj?=
 =?us-ascii?Q?QlyWmFDWLIcePpSGvkk2SO14G5FagvX3uLmOdEiSfrIRJCriceYWGdOctZIA?=
 =?us-ascii?Q?Rh76XDTIvQ+srdhsI/4uRm8b0awEQ6880lp/46XFTiEtzVfTFu/9c44rwKbF?=
 =?us-ascii?Q?F1lC+lIGwZ+fg8aQlMz2WBvKSfdNgzA/d0F+5gBN?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fa53836e-f819-4c31-8c60-08dc5ae926b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2024 12:07:40.2771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C3vFkP8IMWlk/cuQ4Emr5FA9LnjMAySgSrdrRd4AQBDJJkiU68fqkwiv+lDoR6Yw+sEmTzNGIq6WWhoS/Yepfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR18MB5057
X-Proofpoint-GUID: QeU6Ov45KQpKcVbfybfkp7AqcXrcKUat
X-Proofpoint-ORIG-GUID: QeU6Ov45KQpKcVbfybfkp7AqcXrcKUat
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-12_08,2024-04-09_01,2023-05-22_02



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Friday, April 12, 2024 8:26 AM
> To: Hariprasad Kelam <hkelam@marvell.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> davem@davemloft.net; Sunil Kovvuri Goutham <sgoutham@marvell.com>;
> Geethasowjanya Akula <gakula@marvell.com>; Jerin Jacob
> <jerinj@marvell.com>; Linu Cherian <lcherian@marvell.com>; Subbaraya
> Sundeep Bhatta <sbhatta@marvell.com>; Naveen Mamindlapalli
> <naveenm@marvell.com>; edumazet@google.com; pabeni@redhat.com
> Subject: Re: [net-next PatchV2] octeontx2-af: map management
> port always to first PF
>=20
> ----------------------------------------------------------------------
> On Wed, 10 Apr 2024 18:55:38 +0530 Hariprasad Kelam wrote:
> > The user can enable or disable any MAC block or a few ports of the
> > block. The management port's interface name varies depending on the
> > setup of the user if its not mapped to the first pf.
>=20
> There is no concept of management port in Linux networking.
> I may be missing the point, but I'm unable to review this in the context =
of the
> upstream Linux kernel.

Agree, that there is no concept of management port in Linux.
From Octeon hardware pov, there are multiple MACs and each MAC (internally =
called RPM) is capable of supporting multiple interfaces (called LMACs).
Let's say there are two RPMs on the board and RPM0 is configured to 2x50G a=
nd RPM1 is configured as 4x10G.
When kernel boots with this config, let's say the interface names are eth0,=
 eth1.. eth5.
If user is using 'eth3' for NFS, DHCP, SSH etc (ie for device management pu=
rposes) and then if user changes RPM0
config to 4x10G, then in the subsequent boot the same RPM1:LMAC0 could be n=
amed as 'eth5' now.
Customers have reported that their scripts are not working in these scenari=
os and they want some predictable naming.

What this patch does is that, RPM:LMAC0 which customer is using for managem=
ent port is always mapped to=20
same PCI device, so that interface naming remains unchanged irrespective of=
 different RPM configurations.

Thanks,
Sunil.




