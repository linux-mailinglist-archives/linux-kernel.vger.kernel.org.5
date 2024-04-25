Return-Path: <linux-kernel+bounces-158034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 730538B1A72
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BCDA1C221FA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D193B3CF4F;
	Thu, 25 Apr 2024 05:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="UaG+Msb1"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2556C3A1AC;
	Thu, 25 Apr 2024 05:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714024322; cv=fail; b=IKy5KxnmI6uqYoeAUjtWjzAtLWkIWSbsk/Cf0gnwIpV4KcmOv16gzYqVclUtkwxlMZv0mGHepb+Xk0ygf2eyfi/tpfUHjjicy+d+KIpdjJA+OAxO+xJHoVsGWP+epCrMWAr8W1SEDaKIuzHRAF5oaYGVvb//u5S0NL622cSW9m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714024322; c=relaxed/simple;
	bh=kzcR0aaQdWu1xfZk/O17qrnlsPuJh+879RU3izmNSAo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X40ceW5va65Yhj2Ps9WqxIsnoDkHNBoazwSz0FEJUTkcnRZgIYD10w9pnjf+1aPkVEw08DtTzk8NNrhPXy7cEjUH3+ugYQR/7Vh/yAS8IgqCIBifMuilIWtEZJEF1Ib0Dfn7ZfdJXax19EBixghF7i+LlqltnMsvt6JSgoHDTIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=UaG+Msb1; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43OJcRZe012478;
	Wed, 24 Apr 2024 22:51:54 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xpxn1byuc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 22:51:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTkHlipmX+fFEfo6JThrAFMlb8h3Vyn4Ij4eOo9/dZ3qZYJ/EQ2Yf3qCacuZjnpheG6uFmtNSIO5ZB8arztrjLo93j9z7cCyNjye3HK2p5YAT3rwLW7ddVZrR3X1i9+HiD/qA+3UENaqmpBbAJLCdtgas7BNbAps6r7SNhtB905oZEjWuyX0y+Q099RfF9fKDM45ghg/3RtqysNMNBAbpxcEb6jrJte83g98gHb6CyVYATc5osDMiiIc9HodPDDVnbWFEIrhSZa58WlfA7+3ukjK4g5vGrScRo8sZua0BWzLCHhszRpn8/niaFCZwMPBLZ8nCYrX5Ji+79d6jkGLDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1teC6YQG2q+FUE2EDgpLRhBEVX1i7RMIq8J4Mt7XzOw=;
 b=lcV9vMj0i/KCf48DBNDknwb/FioUTxlaq+VfGR+exZJbQmdw9COSl7k8OQkGO0u+8d1s0lU8i/hJI28ZWOONRNBvUJUjYzYjGgqS3EVvNh3rv9OoyCye9knsxl92KyHLBYy2OM5bxTqTXmAupK0W8t7mvHpBWzOFTUK3CI3I4V5uBTtAfPD7qbhKpMiPCqrl8JUBWlZv9hHrWw/cZpz8CMVJ5O9Qi+Z0aqT9/Wgare1Ymcrs+AwADrovRdFVVT2L+5JFVlMt8ArRCEBHHT+vkdhFmeDMsK79rKUPKnbMzkOl35jJ9Hc4pP6WeqjwHZ6UiFPI7MkXxk6NHe2oX6tJGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1teC6YQG2q+FUE2EDgpLRhBEVX1i7RMIq8J4Mt7XzOw=;
 b=UaG+Msb1XoATKmIXHL5T6qsFZweO5DrDECp5SjCNXYHdX+xQE+gR/Ez70dY3yE+614q5LKBiY4CMLC5+z9qwusXBvZl5EYn0lbyjd7QRHBnhbvpv+gfmgVvP8t+0cXADmWA7tqsHgErKPsdsxU+Y0vSdNkjP9OsqQ2NMuqeqVK4=
Received: from SN7PR18MB5314.namprd18.prod.outlook.com (2603:10b6:806:2ef::8)
 by PH0PR18MB4543.namprd18.prod.outlook.com (2603:10b6:510:ac::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 05:51:50 +0000
Received: from SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::f808:b798:6233:add8]) by SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::f808:b798:6233:add8%6]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 05:51:50 +0000
From: Bharat Bhushan <bbhushan2@marvell.com>
To: Dongsheng Yang <dongsheng.yang@easystack.cn>,
        "dan.j.williams@intel.com"
	<dan.j.williams@intel.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Dongsheng Yang
	<dongsheng.yang.linux@gmail.com>
Subject: RE: [EXTERNAL] [PATCH 4/7] cbd: introduce cbd_host
Thread-Topic: [EXTERNAL] [PATCH 4/7] cbd: introduce cbd_host
Thread-Index: AQHalIpkvEF/TJb2IEC//+PWL2n/SLF4f8FA
Date: Thu, 25 Apr 2024 05:51:50 +0000
Message-ID: 
 <SN7PR18MB531474D4D6DB1634FC98CA9EE3172@SN7PR18MB5314.namprd18.prod.outlook.com>
References: <20240422071606.52637-1-dongsheng.yang@easystack.cn>
 <20240422071606.52637-5-dongsheng.yang@easystack.cn>
In-Reply-To: <20240422071606.52637-5-dongsheng.yang@easystack.cn>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR18MB5314:EE_|PH0PR18MB4543:EE_
x-ms-office365-filtering-correlation-id: b212e84d-a6f0-4b25-08af-08dc64ebcd19
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?VsJ2F2C7Tl68zZppYxWd/6GTkazNhUwmcMdZTtfh8VnSeaJiAx7UvshxZv1s?=
 =?us-ascii?Q?GezxIKUGG3LRy7O7/XHyCLXY9469ynnzn+L74kdnI473VrsUvRDMPnPuM3zb?=
 =?us-ascii?Q?nTT1irzpbLRq5ABQQGjqg2cyfc4DhBLqhKY9Hs+EuimufAB3GOBnFO9XbYS0?=
 =?us-ascii?Q?9wCbv4araLRm4N78T6AxBVARfQt8s2mPTzZ8CF8ae24EU7BxMBEdsXEK6g5s?=
 =?us-ascii?Q?0WQUPGFJ8dvbfkcPg8s9+jmAFn8EhsLYMMJGPHp6Vsn+/1sJN8I5JYlUkFQ7?=
 =?us-ascii?Q?Ii9X7i6YhXVhF9wGOEIMfpAckvBO3h1yTzyaeyU9IRmzc7qfN5ytGv0agNVY?=
 =?us-ascii?Q?D3Uxfgv5ot89TcEPYgJQ0xnrDz5ooWAUX4X2gUZNK0djFmKMlQOQwMsnMQoB?=
 =?us-ascii?Q?zieEnTloC9cIpHELcDd9eVhi8/UkRy/nPD0oXz7o2pxOvQfJvOxWuqEC1aqu?=
 =?us-ascii?Q?zX3aZFexeeA9Yt+7gnHxNPHrZvY4rD9aQ/nh0WmOa97izKcYWpo8UDUXcoa8?=
 =?us-ascii?Q?OtexiW/45kBvQovu43+bSxSHVtgyedrc5Wo1ocLlclMmdVnMTVd3NL1lumxX?=
 =?us-ascii?Q?kt890JvQHICrCRHKQeMA1GCPhcomdNbJ8jNUGPQz+CT0QyFcLIqoa7FZJi0H?=
 =?us-ascii?Q?D2ZnVwfM8SfLXyuxEd0SBxiREo6ObeuvB4NuzrkRrHjvOnaFXRb1kpERZHkk?=
 =?us-ascii?Q?BIJcEwl/md3tR4YEP0eeUd3mFRElPQ+GsZfF+7WIOpsEilPotg/siq6zloeW?=
 =?us-ascii?Q?/eI30NvkOoyPIaIKKiH9MG7CXWhEMnGT1DPiPayyLl8lkRakjE3mcuAF15i7?=
 =?us-ascii?Q?cf9HVysS3EA5txfePS/ySXWNcXkaEzPKStXWd+qHM0oswk8enExANf9A2lSS?=
 =?us-ascii?Q?7F4yIjy6ks/ka2dyDTbrFmHIA5WNq+Os20lN02fAWxWVsr6jA2TwAdkK2yS3?=
 =?us-ascii?Q?loaRwNTf/9kTwqiUyOyI6B7CxwXa2ofmQ+OROv1FEOkhY0awdvgv3ee1BNex?=
 =?us-ascii?Q?N2msuLrumpiGOvzcECIdv0SfhVb5HaYW92rhurqhZJuNacel+ktBjJFmBoO9?=
 =?us-ascii?Q?UvqtbeJi7hxwlqvhg5OI9iudSt2PKa7ylG/mc6W4Lpoyv4QC2lT+Y3iSFvCO?=
 =?us-ascii?Q?tgXZ80AgPDts9vUhYMsytGgwTHFkTeDzeUx7d7FP3X7ZDUCqxj7WLS7Ev5Ir?=
 =?us-ascii?Q?aVs1/H3aWuQNMZuK66fJd4rbcoK7PUG4bOnHiYnYXYKMAzJ46jz4ssRhnRKc?=
 =?us-ascii?Q?U94fAP6slYKHSiBLfROf7eTihAmwouECOm7aUp0UT+dIi6SwIDhMR0ftvbJe?=
 =?us-ascii?Q?46Iy4/qdX0Fl78qYbCW5FJKCaWBllpYromlaOcDNM2HtKA=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR18MB5314.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?jkeObSm7sRtVnRjTKdINn/b+u3M//JceyBdxznQzVWLVh4Nn8ZAs5qcYcgJD?=
 =?us-ascii?Q?V6D2XbB6Tm8UFOLEtLPdyxsdmshI+GfNCO6ms4AhS8ZXLX8YJeWBM3mh++GO?=
 =?us-ascii?Q?IcrQE4RYMzMBclhx+5pzDTM/gmwoCxom0sF8+AWSP3CLb3RbGEEEN/b82fQe?=
 =?us-ascii?Q?iYKmf/yyGsERBfKaKDxVKTt4ymtdopgUEHRFMU79bsLIInUyv0XOp+k0UW/a?=
 =?us-ascii?Q?w9/rLiw/WEJYr1XpHtr0Sqm4SJwHcUyld+VLfsa0BFSRxTR2sjk7fQolTbjV?=
 =?us-ascii?Q?zm1CSY0fy2jSAaDVMBz8Fp7Y6qCjU2y78dhim0bEbHMBhmNPwotBA2xwU2nY?=
 =?us-ascii?Q?LUfSLYxZBF6upfwUSQu6dn3TMHQP2pE6EhX5LiukV6mUAiXl+ZyigJoVEuYR?=
 =?us-ascii?Q?5iK6NqXeCILeJe+x2FAAfifjhTnsj/0esfADU8VaJZ2WjHHa21kaegG26xlt?=
 =?us-ascii?Q?Phz035tdYGFBstvysrumCNOk1u+EMinuySwiOBedBvWaXs3LvHSBaMW3DCHS?=
 =?us-ascii?Q?B0yFydLC5sRpeHmOMIfRf5OYpOPBScc+t4eqkdejaCKVQNIN6A4mnrk6eAR1?=
 =?us-ascii?Q?gvHPSIkqaKOilpIeCtDh/6ufn4iqXPs0YqJyWtBwYuVU6YjYeoPnNBdp4R1Q?=
 =?us-ascii?Q?LfTXVvXIKb1c7QyhRLE0SxFxzo2OY0YzIUYNYq2SqY7ja3xlCNiYte+vQbaJ?=
 =?us-ascii?Q?gPgOAurnwH3uh7cF+bRTslTYiwJwOYzJPICF7s5I+gxmalCvhaUCL2iXC/JB?=
 =?us-ascii?Q?K6vj27EEAGcCmqkpC4oGDtzrY7DoeTXm9wmcJZcbp/wNrXXQJ69remspn1zw?=
 =?us-ascii?Q?817ukN9QjWL/dGKwOyTJpOmQVdpK+H+sPj/8McCeOaoIqXskgjAyEL1JRyr/?=
 =?us-ascii?Q?mFeXfg2vN99TwYSVGgSEaSFkgBKlr3keFcunuiHxErt5cE2fDyJMWCNPcB6J?=
 =?us-ascii?Q?PfIG3DfFRsVTE8X09xY+QGlPEUyK1czJqgiWTBhL4U9zdPVxmSB6lywTCS4z?=
 =?us-ascii?Q?vPJeCEdl+fEd/GKYxf47QjWkEQg1kIvCVtESUBQ8HnAOgyn2ZYABGLOqNkI6?=
 =?us-ascii?Q?+zGSPDmO9wQDXw07TeHmB/Ca7QIL7TsL9t86bKGv8uhVO5DjCLBgV0W+qdYZ?=
 =?us-ascii?Q?ud2y+Gibz2vDFBlyer4DhiFlnm3ocGMwUIUzXCB8M4vC1Q7WAJww+I0dLFtw?=
 =?us-ascii?Q?NlBhtXwShghByoqyCcNlD+v66EyFDrMnmf0XUimhHJ74VLl8iZNJHbFJ5rGV?=
 =?us-ascii?Q?xqN9CWHhkhzDIDPVpwjyLmOjmUxfhux8b1WUcBN1kjNarVDJQ2n+bsor+Jxw?=
 =?us-ascii?Q?XVYtif1sqb5BErx60PY+7JVX5gECaNAVZPPzX4DBaRNrklwUu0Hj26Xz9ZOm?=
 =?us-ascii?Q?6HPawP5x2pIO3X5ilfI2XYRWgBfFNz+qRzEYp+8ob8plwmDQfyt//6Nf46t9?=
 =?us-ascii?Q?hMGSkt0BxuraPj9MT2ib5B0lGt8TsdsUgzXe4hO89OkfRzrzHRKryQSrvA0w?=
 =?us-ascii?Q?S1LRQwQn8KV8hqAf2JbnKtzQwzLo89DkdpmSXXrrDGLixDQEqTJDvyNF/WRa?=
 =?us-ascii?Q?1z0RrPg8Z6koMiRs30FbzzEoFNtYl2mO+oIU929t?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN7PR18MB5314.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b212e84d-a6f0-4b25-08af-08dc64ebcd19
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 05:51:50.0257
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XJ6D1vuPiE4MVLLAlU1M0HqnfLOmGtnbgAte7OPcHMU7mvEEZwcvrb02+BqqTDyIECLBjt4nybGSSzJg6OzAWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4543
X-Proofpoint-GUID: o0kKRUNHDba5EZMCJoeaudCgxpb5YosK
X-Proofpoint-ORIG-GUID: o0kKRUNHDba5EZMCJoeaudCgxpb5YosK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_04,2024-04-25_01,2023-05-22_02



> -----Original Message-----
> From: Dongsheng Yang <dongsheng.yang@easystack.cn>
> Sent: Monday, April 22, 2024 12:46 PM
> To: dan.j.williams@intel.com; axboe@kernel.dk
> Cc: linux-block@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> cxl@vger.kernel.org; Dongsheng Yang <dongsheng.yang.linux@gmail.com>
> Subject: [EXTERNAL] [PATCH 4/7] cbd: introduce cbd_host
>=20
> Prioritize security for external emails: Confirm sender and content safet=
y
> before clicking links or opening attachments
>=20
> ----------------------------------------------------------------------
> From: Dongsheng Yang <dongsheng.yang.linux@gmail.com>
>=20
> The "cbd_host" represents a host node. Each node needs to be registered
> before it can use the "cbd_transport". After registration, the node's
> information, such as its hostname, will be recorded in the "hosts" area o=
f this
> transport. Through this mechanism, we can know which nodes are currently
> using each transport.
>=20
> Signed-off-by: Dongsheng Yang <dongsheng.yang.linux@gmail.com>
> ---
>  drivers/block/cbd/Makefile        |   2 +-
>  drivers/block/cbd/cbd_host.c      | 123
> ++++++++++++++++++++++++++++++
>  drivers/block/cbd/cbd_transport.c |   8 ++
>  3 files changed, 132 insertions(+), 1 deletion(-)  create mode 100644
> drivers/block/cbd/cbd_host.c
>=20
> diff --git a/drivers/block/cbd/Makefile b/drivers/block/cbd/Makefile inde=
x
> c581ae96732b..2389a738b12b 100644
> --- a/drivers/block/cbd/Makefile
> +++ b/drivers/block/cbd/Makefile
> @@ -1,3 +1,3 @@
> -cbd-y :=3D cbd_main.o cbd_transport.o cbd_channel.o
> +cbd-y :=3D cbd_main.o cbd_transport.o cbd_channel.o cbd_host.o
>=20
>  obj-$(CONFIG_BLK_DEV_CBD) +=3D cbd.o
> diff --git a/drivers/block/cbd/cbd_host.c b/drivers/block/cbd/cbd_host.c =
new
> file mode 100644 index 000000000000..892961f5f1b2
> --- /dev/null
> +++ b/drivers/block/cbd/cbd_host.c
> @@ -0,0 +1,123 @@
> +#include "cbd_internal.h"
> +
> +static ssize_t cbd_host_name_show(struct device *dev,
> +			       struct device_attribute *attr,
> +			       char *buf)
> +{
> +	struct cbd_host_device *host;
> +	struct cbd_host_info *host_info;
> +
> +	host =3D container_of(dev, struct cbd_host_device, dev);
> +	host_info =3D host->host_info;
> +
> +	cbdt_flush_range(host->cbdt, host_info, sizeof(*host_info));
> +
> +	if (host_info->state =3D=3D cbd_host_state_none)
> +		return 0;
> +
> +	if (strlen(host_info->hostname) =3D=3D 0)
> +		return 0;

Sprintf is safe to provide zero length source buffer. Maybe this check can =
be removed.

> +
> +	return sprintf(buf, "%s\n", host_info->hostname); }
> +
> +static DEVICE_ATTR(hostname, 0400, cbd_host_name_show, NULL);
> +
> +CBD_OBJ_HEARTBEAT(host);
> +
> +static struct attribute *cbd_host_attrs[] =3D {
> +	&dev_attr_hostname.attr,
> +	&dev_attr_alive.attr,
> +	NULL
> +};
> +
> +static struct attribute_group cbd_host_attr_group =3D {
> +	.attrs =3D cbd_host_attrs,
> +};
> +
> +static const struct attribute_group *cbd_host_attr_groups[] =3D {
> +	&cbd_host_attr_group,
> +	NULL
> +};
> +
> +static void cbd_host_release(struct device *dev) { }
> +
> +struct device_type cbd_host_type =3D {
> +	.name		=3D "cbd_host",
> +	.groups		=3D cbd_host_attr_groups,
> +	.release	=3D cbd_host_release,
> +};
> +
> +struct device_type cbd_hosts_type =3D {
> +	.name		=3D "cbd_hosts",
> +	.release	=3D cbd_host_release,
> +};
> +
> +int cbd_host_register(struct cbd_transport *cbdt, char *hostname) {
> +	struct cbd_host *host;
> +	struct cbd_host_info *host_info;
> +	u32 host_id;
> +	int ret;
> +
> +	if (cbdt->host) {
> +		return -EEXIST;
> +	}
> +
> +	if (strlen(hostname) =3D=3D 0) {
> +		return -EINVAL;
> +	}

Un-necessary braces

Thanks
-Bharat

> +
> +	ret =3D cbdt_get_empty_host_id(cbdt, &host_id);
> +	if (ret < 0) {
> +		return ret;
> +	}
> +
> +	host =3D kzalloc(sizeof(struct cbd_host), GFP_KERNEL);
> +	if (!host) {
> +		return -ENOMEM;
> +	}
> +
> +	host->host_id =3D host_id;
> +	host->cbdt =3D cbdt;
> +	INIT_DELAYED_WORK(&host->hb_work, host_hb_workfn);
> +
> +	host_info =3D cbdt_get_host_info(cbdt, host_id);
> +	host_info->state =3D cbd_host_state_running;
> +	memcpy(host_info->hostname, hostname, CBD_NAME_LEN);
> +
> +	cbdt_flush_range(cbdt, host_info, sizeof(*host_info));
> +
> +	host->host_info =3D host_info;
> +	cbdt->host =3D host;
> +
> +	queue_delayed_work(cbd_wq, &host->hb_work, 0);
> +
> +	return 0;
> +}
> +
> +int cbd_host_unregister(struct cbd_transport *cbdt) {
> +	struct cbd_host *host =3D cbdt->host;
> +	struct cbd_host_info *host_info;
> +
> +	if (!host) {
> +		cbd_err("This host is not registered.");
> +		return 0;
> +	}
> +
> +	cancel_delayed_work_sync(&host->hb_work);
> +	host_info =3D host->host_info;
> +	memset(host_info->hostname, 0, CBD_NAME_LEN);
> +	host_info->alive_ts =3D 0;
> +	host_info->state =3D cbd_host_state_none;
> +
> +	cbdt_flush_range(cbdt, host_info, sizeof(*host_info));
> +
> +	cbdt->host =3D NULL;
> +	kfree(cbdt->host);
> +
> +	return 0;
> +}
> diff --git a/drivers/block/cbd/cbd_transport.c
> b/drivers/block/cbd/cbd_transport.c
> index 3a4887afab08..682d0f45ce9e 100644
> --- a/drivers/block/cbd/cbd_transport.c
> +++ b/drivers/block/cbd/cbd_transport.c
> @@ -571,6 +571,7 @@ int cbdt_unregister(u32 tid)
>  	}
>  	mutex_unlock(&cbdt->lock);
>=20
> +	cbd_host_unregister(cbdt);
>  	device_unregister(&cbdt->device);
>  	cbdt_dax_release(cbdt);
>  	cbdt_destroy(cbdt);
> @@ -624,8 +625,15 @@ int cbdt_register(struct cbdt_register_options
> *opts)
>  		goto dax_release;
>  	}
>=20
> +	ret =3D cbd_host_register(cbdt, opts->hostname);
> +	if (ret) {
> +		goto dev_unregister;
> +	}
> +
>  	return 0;
>=20
> +devs_exit:
> +	cbd_host_unregister(cbdt);
>  dev_unregister:
>  	device_unregister(&cbdt->device);
>  dax_release:
> --
> 2.34.1
>=20


