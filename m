Return-Path: <linux-kernel+bounces-21482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E7A829006
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CE9F1F26255
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 22:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477EF3E46A;
	Tue,  9 Jan 2024 22:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="iqcRV0oW"
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E4612E41;
	Tue,  9 Jan 2024 22:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 409MU61p002548;
	Tue, 9 Jan 2024 22:37:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : mime-version :
 content-type : content-transfer-encoding; s=S1;
 bh=JXzGxs6Stn5IBMnrNbACinWYPG1iyEmivXZPCbRsS6A=;
 b=iqcRV0oWM9+S2ybp2514u10l2/4vfU+nGAsWou/PuQ/UqX6rOXTzjSUE8gf4+zBRHxLe
 lIMgMQCpO4LM96STKf7URqmW3GhE2oX6z8CZ1L0o8whsJrKBPmOHAV1jrHk3S9jCZ2Wk
 KZPS5OyrM15ZDcgDEkSDe4kncyU/pyrmddZg5G2EHJOWpFFD4KKjsjiF/pF10E30p8tl
 8VwyRSPACBKvAklzG1cDtMFVcdQocymO5+Z/jViy7+/t50nTrPLLCOnFqJqq2GddfwZr
 ZVQe927MM0mD/rNcWjN93EnnDY4kZWYoUlAFVTtx0gcmGMVB/23/ZbiUvH9L59OsgFwa kg== 
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3vf23w32gq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jan 2024 22:37:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FRmuIQVDpPYgQDwONAnObnsxHwFNNJk8qQb5W351KGYqtaFVMn2k/BR6cpp0ACiXXtcTloPeR8x0yKY02IK1dK0knUcxif8mvroaDnSwtl+z3rfxnxFYYGGyOjewx6dPJNKDqDrk6qT1m4U/z3sSYeXt9oQc7jViMrBL5XDy0fSnqVQg6RSBbgzMyDD/bKGYYJwuOUWwlr3QYfyKrPOMlRjkBlFSg/k6xYBlvfzvpfhnNz8kjF0efaCq7reGeb83u2Jr8R08joqW55n0zW3rn77pEEN2MYIFUQMapHpXPCpFeujXxKT+Z1yrkgdPu0dixpvw3rk2LNsduShcbRsyIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JXzGxs6Stn5IBMnrNbACinWYPG1iyEmivXZPCbRsS6A=;
 b=Wwqv9ydyF0rlRwpcUS3S2Xvd7WdNUZBnIo+iawznlenl0wW3ggdDIE4p8Y/80JbdvNXCRa/5G2Mj/WI4mQQDSc2xk8brUa7VzsJ3K2dcrpz9XJa3mnTzghOLQ8QFFvGE8C1uRqNuRD8ooPsyjKWZWVsMli82JYYogjnCKqDaYthdCnux31uTeMG4tKqJHoqf5HJpEHLMFK4vFe+S+YCXyl7vO6fJWuUFa5+HE/r6fHK0eSKw8mtZSOhCY0FLeF0OZJwGDNolL1lmQTvbUSggQM5Ty5ZCU9OihYHQjA9Isp0gQszQns8jj91zbIQ7noiWLzRzUSeU2W4TwgVpmpIhHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from SA3PR13MB6372.namprd13.prod.outlook.com (2603:10b6:806:37d::13)
 by MW4PR13MB5459.namprd13.prod.outlook.com (2603:10b6:303:182::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Tue, 9 Jan
 2024 22:37:38 +0000
Received: from SA3PR13MB6372.namprd13.prod.outlook.com
 ([fe80::ca00:2b32:e9c0:805c]) by SA3PR13MB6372.namprd13.prod.outlook.com
 ([fe80::ca00:2b32:e9c0:805c%4]) with mapi id 15.20.7159.020; Tue, 9 Jan 2024
 22:37:38 +0000
From: "Bird, Tim" <Tim.Bird@sony.com>
To: Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>
CC: Rob Landley <rob@landley.net>, Geert Uytterhoeven <geert@linux-m68k.org>,
        "ltp@lists.linux.it" <ltp@lists.linux.it>, Li Wang <liwang@redhat.com>,
        Andrea Cervesato <andrea.cervesato@suse.com>,
        Greg Ungerer
	<gerg@linux-m68k.org>, Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap
	<rdunlap@infradead.org>,
        John Paul Adrian Glaubitz
	<glaubitz@physik.fu-berlin.de>,
        Christophe Lyon <christophe.lyon@linaro.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM
	<linux-arm-kernel@lists.infradead.org>,
        linux-riscv
	<linux-riscv@lists.infradead.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        "automated-testing@lists.yoctoproject.org"
	<automated-testing@lists.yoctoproject.org>,
        "buildroot@buildroot.org"
	<buildroot@buildroot.org>,
        Niklas Cassel <niklas.cassel@wdc.com>
Subject: RE: [Automated-testing] Call for nommu LTP maintainer [was: Re:
 [PATCH 00/36] Remove UCLINUX from LTP]
Thread-Topic: [Automated-testing] Call for nommu LTP maintainer [was: Re:
 [PATCH 00/36] Remove UCLINUX from LTP]
Thread-Index: AQHaP9i+nPde0Zv90kmfJ6SqZmE5/rDPo4mBgAARuoCAAl6a8A==
Date: Tue, 9 Jan 2024 22:37:37 +0000
Message-ID: 
 <SA3PR13MB6372498CC6372F8B16237244FD6A2@SA3PR13MB6372.namprd13.prod.outlook.com>
References: <20240103015240.1065284-1-pvorel@suse.cz>
 <CAMuHMdXGwyS-CL0vLdUP4Z4YEYhmcmDyC3YdGCnS=jFkqASqvw@mail.gmail.com>
 <20240103114957.GD1073466@pevik>
 <CAMuHMdX0s0gLRoPtjJmDnSmZ_MNY590dN+JxM1HKAL1g_bjX+w@mail.gmail.com>
 <ZZVOhlGPg5KRyS-F@yuki> <5a1f1ff3-8a61-67cf-59a9-ce498738d912@landley.net>
 <20240105131135.GA1484621@pevik>
 <90c1ddc1-c608-30fc-d5aa-fdf63c90d055@landley.net>
 <20240108090338.GA1552643@pevik> <ZZvJXTshFUYSaMVH@yuki>
In-Reply-To: <ZZvJXTshFUYSaMVH@yuki>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR13MB6372:EE_|MW4PR13MB5459:EE_
x-ms-office365-filtering-correlation-id: 4b4df69d-774e-4cb1-ccde-08dc11639512
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 c9G8MZ20E7QAmhxdz4gs5WCazPqAiejWDa6XVNVANQp2ch/lLMHm0H5CxgEE2GCB6N01JXF1fsaJTRzHK44aQ405KQKXMzEBTCLt5IvhcGB7uLjnRw1T8FfhB11USHoNGtFRmiUINY6raeAxl+kF5eyYiziljzCy+s/ePu59ieqJasuqagQRJO79rmWd47B0p10++imEJVBVy9sHtts9kpsGygmg0w9ZGvw9/VtUZPJzF+o1NjS5p0Tp8etJdfdmytWyMFPytjxp4eTFuVcQhY4gKP5FaeVD+0lhkARMPnsi2xgXqMaRfgee6g6mh3+PD4DTaFKpix9R+pZvaTgqMU8OjpkFQWDcdN7gCoZoS3c5jTufw9MYicPgPcBpwA8y1cLymn/YLJGrNyXeKAdt48doiO6iPrF7dHPYiGT+4N10jkJmZXs/t7ToOaYBC1fk5a6NvgDMFhbc/dULvaCoXRLI32txZDrE2FFLROdC5IHFl4k02nKBvw+sN5PSK1BzanLKwM3JS+GbT67/U+euxV+XowLoS+jkJi8PYMR5MhvrETvUglrN8NVxJRLWuQ4Wf7He5ikg4I2OLnN3EpG3IJRvI+ZHcX56zC5otfvcIPAnG2djcx1F0CqYiALGRWl8F5PRXqxncozSQ/fS07hUx2ObatYRsxj+0wzLyJMEwnw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR13MB6372.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(5660300002)(2906002)(7416002)(33656002)(86362001)(38100700002)(478600001)(82960400001)(83380400001)(7696005)(26005)(122000001)(9686003)(38070700009)(71200400001)(6506007)(8936002)(8676002)(316002)(4326008)(52536014)(76116006)(41300700001)(110136005)(54906003)(64756008)(66476007)(66446008)(66946007)(66556008)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?UK1HE9hrBxsfhaV2n1sECNOAATGeaZ8RkhXQbdBZp4jmMFkeWqcTLGgggOj3?=
 =?us-ascii?Q?zvyPtUCXvYvytWuMzjJFgL9t1mFFHNO7c+EA1y6zR0OUpt/uKqHzIh+y4CQj?=
 =?us-ascii?Q?KwpZCyzJGxKfcQ0IYZCs8xBIpxy7EQvEW+2DX7fhk64QE0LMEI1es1L3t+TF?=
 =?us-ascii?Q?7793i94Qc3pqi4NDBAxrJBLXsM6rKPTR5d4eYA7aPrVhBRRkFl0BohENJBIO?=
 =?us-ascii?Q?pMxGwZVMRhoWEmqWE/0AABkwfM1frpwmMX+thUo2m2eygIJsmtOR8MdAQtbJ?=
 =?us-ascii?Q?9QdNmGg1YM0IhNjO80ybC1pc2mVuOdLEiVYyMAuWzcTjUDgRd+m2jb+vFg/o?=
 =?us-ascii?Q?SbcJUnyRPWlbJYOscZgFGzdHnd9Kh1z4Pvm7earSY7Vqfgs1h7rzuDcjR9Xf?=
 =?us-ascii?Q?ZbJ3xJlh+hSaPEgR0R8uX+Fu+P1GEqMvejcwDW0OtNS2W9iDSfgWWPWp2zrk?=
 =?us-ascii?Q?ieY2HaahAow5KnCCfcfebeeAn1X//aTSsKiOf7fe/UgcPXm/Q4qIr5Ous9Q2?=
 =?us-ascii?Q?mSwlpeCIxAEz3lZCnIujlxh6s7NvSjrTwpn2YyA9HB7Ap7DWhffZWFxxoMHY?=
 =?us-ascii?Q?IZSICToj9xCuq7ONok7eSDbWes7tqSKr4VbRr1LOWl82hE+5akufvVYlZl7I?=
 =?us-ascii?Q?S5LSWPvN3fZXx+zv4Vn0NpSAVg5d8HmO/PMq4qzlunDpEkdmcGB7I9R9sGRf?=
 =?us-ascii?Q?N6Vcq2lkRJBnNV5PUb1fWYjm4oi2Qf0xbB9FF2D+BA2nDT+33uyr2Dg+o4iC?=
 =?us-ascii?Q?J6FN27IpX9DG3bRC+y7TjIr5N7cxFtHT22Vsp+fcm2nEJM6tGSU/q4BMXI6O?=
 =?us-ascii?Q?rQUHs9H7g3Lr3/wBIcZpYChAHmXjW7LfxKZJP7x16x2t6k+0M+WiHk5qp7UO?=
 =?us-ascii?Q?kLyrLnRKvkLFJVG1/H9y9kJkYF/3HigM3szyI9Mh5U/bzqC9jDvRu/EXJKhN?=
 =?us-ascii?Q?4W0GpY1tA4z7Fw7fUndKih6Cxm3sxM5mnsO4c6fGSYudsh/q/E7RsHE7cgFA?=
 =?us-ascii?Q?7xcVDqxZ8Fm2kSTHeAEu2EHI6978U6pXdrmw43qC9vf5InAv6KX/KFxO1Ggn?=
 =?us-ascii?Q?V0knSaKDm41iL04y2XqwZ5hh5sSdVWo98JHEuL8m6r2AOxGi0E+yvda+akXf?=
 =?us-ascii?Q?DxouUgGRErgQfVG5eu7O83w+ojldGs9OTdlya61LhOZcFUQDxag/Mn7SBEJb?=
 =?us-ascii?Q?GzjRNyg11vvJJSwmGtDAEazkLroO9EFWhLg1TR6+Ib9CIvpKHMPEuGYUe7K2?=
 =?us-ascii?Q?sXcXXtEX2zdQ34D44OEPBIcZWlXGSnFnyYyGWkct0h5k2M60TAzJriQSzv7J?=
 =?us-ascii?Q?h9HorrQQUQmd4gUZBvRuKa7bTH8m4nx2dGFRP+iOAtGozM7h0XrJ4ZlUNqkR?=
 =?us-ascii?Q?zkC+IM5F4UzugvuIcRrmywrbWHPTMuzzn/GzFoIflmsR5jr0qKTY0U2G6gAc?=
 =?us-ascii?Q?+Nd68dsXoXWmyo3knIeuVDreiM4l+ih6l/5yu9F0jM+iQu+5AJJrvdgEuV8B?=
 =?us-ascii?Q?J2sdH6sN6GY3/5UnJ+V5ABDdsxNq9yJDwH8A+ai25UW4JR26+ANPs9wHrJpU?=
 =?us-ascii?Q?OJtLMjJH6GsTOUNQU0I=3D?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hTdxRjf+lC3ldsIG39e6r5UhPevNALKJoEmIGyixVyrBrOMajlFeDCPID14KEdmoZk3dZH8YvV3vuG5LSpbSotF1LGyW01edVt1WzH1d3eic5RmX0ZmXwY/wprEJbSc7aiU4K7044jcUSfkUMTWn83mnJGlaojFCXMPUJ/6Q5mdyU9tbhaBjHF9gTQ3I0msUnUabcjgzdJ6pojDw4JlCpe8VmfmtkZwdY1c8BXrf32JKN6H7QjY2Kk3dY5aZfvkjUt8zp+UXC+z/2KUH9l8jc2JcY9/M3KLotzswEJhyeRioKm7AQ3NjGiVZSRJeOiKC0HF2YKoVeGZaOeQRDSiNZtjnWDO0h2BoXbPrJDcMVjtto9gdwBCrshZY99RjGVdAJIAUt9QKo5FgkMmF4xs2QpAPnKGdcELubchCMxYNt8uR7NlWilpeMI24WR5pxYYt4ri4FDrvEyY4kZ0Jvh7Vxqd8X9K7gre5Db1dc/gWuqTlMvofFGFxmI9PCpBfR5wC131bKNzbS3fNSAbD0Ne+nGEZBEIHtf8nXoOHn2h0/g40+6qx+e9bA3+vbD+H8qNvYTlmEtZu9cDmV1L73By1uS8sCLkOFsK7SoRsJiwxp9ngcCbPUvb/hmTuPf6Ni9F4
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR13MB6372.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b4df69d-774e-4cb1-ccde-08dc11639512
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jan 2024 22:37:37.9824
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NwzkhAudYNNDNf3XbiQJ2XoMWjptUSH9/J20xglEQQe/soX6y1VWgk4dkm2zw7hESDbr/Md5mlazz40zUqJ06g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR13MB5459
X-Proofpoint-ORIG-GUID: XNttZybjFJ9vBXk87idEj1148j8TZufP
X-Proofpoint-GUID: XNttZybjFJ9vBXk87idEj1148j8TZufP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Sony-Outbound-GUID: XNttZybjFJ9vBXk87idEj1148j8TZufP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-09_11,2024-01-09_02,2023-05-22_02

> -----Original Message-----
> From: automated-testing@lists.yoctoproject.org <automated-testing@lists.y=
octoproject.org> On Behalf Of Cyril Hrubis
> Hi!
> > But as I said, if anybody from nommu decides to maintain it in LTP, I'l=
l try to
> > support him in my free time (review patches, give advices). And if nobo=
dy
> > stands, this patchset which removes the support in the old API will be =
merged
> > after next LTP release (in the end of January).
>=20
> Let me highlight this part, we are eager to help anybody who is willing
> to pick the nommu work, but we do not have resources to drive it.

I have a couple of comments here.

I think it would be good to give a little bit more time to try to find a he=
lper/maintainer
for this.  As Rob pointed out, a lot of embedded Linux developers are using=
 very old
kernels (and, if they are using LTP, likely very old versions of LTP).  The=
y are also
notorious for not being active on the mailing lists.  So this might take so=
me active
outreach to find helpers.  (I realize that this thread is part of this
outreach effort).  For this reason, I'd like a few more weeks to try to adv=
ertise this
need within the embedded Linux community.

I am not using nommu systems myself, so I'm in a similar position as Petr i=
n terms
of it not making much sense for me to be the maintainer.  However, having s=
aid that,
I have had for a few years now an idea for a background project related to =
LTP
that might make this a more interesting fit for me.  Sony uses NuttX, and i=
s considering
using Zephyr in some of our low-end processor systems.  This includes some =
nommu
systems.  For some time now, I have wanted to experiment with using LTP to =
test
the compatibility of those systems with the Linux system APIs.  In full dis=
closure,
I have no idea if this is a feasible or useful idea or not.  But it's somet=
hing I'd like
to investigate.

I realize that testing non-Linux RTOSes is out-of-scope for LTP.  But given=
 that that is
something I would like to do, and that it might be relevant to the Linux no=
mmu tests,
I would humbly request a few weeks to investigate this before the nommu cod=
e is removed.
This delay would be to see if it would make sense for me to volunteer to he=
lp out with
maintaining this otherwise abandoned code.

I can't promise anything, but I'd like to find out more about:
1) what parts of the current LTP are not supporting nommu (what's currently=
 broken),
2) how much code we're talking about, and
3) what the desired roadmap going forward would be, to continue to support =
this code.

Thanks,
 -- Tim


