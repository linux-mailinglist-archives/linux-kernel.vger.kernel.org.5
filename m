Return-Path: <linux-kernel+bounces-143805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECE68A3DA6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 18:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D3531F21A1E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 16:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F374E1A2;
	Sat, 13 Apr 2024 16:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="au0ayviM"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B84A4CB2E
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 16:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713025051; cv=fail; b=XXG5/FjLRoYqcjxQnD9jcczJTTbOJbGTikOKExrQ4Fxtoun95BjAy81FbyZQMicjtFgR/gXMN4mJgz3pT+6c9vjaIZlQ3YXzhdmt19w7BeYi/GlrJHRU6RxhtI75C//+v3Mawt+8KkmJkziVmN7wSsa62ug//NhjdTEoJSul6E0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713025051; c=relaxed/simple;
	bh=5cANmtQ7ZRmx4wbzMfsOK/dxJcSIbD3DOvF3H4bonvU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MQel5tI3gBENWF7o/VhIksgUCIno9njxeg5HNOKmCsrngCRtUHY/NTY/s5+d3ZxmvzsefwiI/pzZninTyBxnSUwRxqbuiDtZcuHTslbBMJK2y6Z63bTwbfMtEoAc9OtEq2FTZvrxlINhtcWKUH7srL6Wv2AgDJdw/dID4r+p69o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=au0ayviM; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43DFtx5n026567;
	Sat, 13 Apr 2024 09:17:23 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xfsjg0bhs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Apr 2024 09:17:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eqwosA61iGsX7Ukx0c5vY0HGMWK189t7jn2isvE3l3+Qoph5qyLJbQxJcV+w7AWH6h5XFQSOYJzmvj9gXGcWlwzEnk4EOUygFI9lJqV/DE4hJ7DXdPlLbB/EJ375QxV7eU2vRFUu3JNuF3Oo1nDUnUmMKJTw/4EvNlfp90TDyCT4U9HmgyrrhIv6vDSVN220WXknJZ3QV2kUISPr11iJ0Yca3IDysH+Qgg949LOxqIUW98FhDY0y5YNW3Cm6oUCoIpP6Q1VHvfC2fTrlnrd6Eq2CgPDmmYkQmElLF7It9lFOoknu6wX8wVIDsIZXXiLScfCT+2NhDgTbmCQJ4oMJwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P5F91F8kXGOvdNVd4kDjBHUtwNDx9muNqZv7VvhCMRs=;
 b=nG/N2yQ6RE4MjmcfAgQgnqFb0tRt3ONLal9RkH2Q3vqNC6fvlQcNfufSqwPxQIt7QIvC4VY63wsp5xrjlwrZpBXK3FSyNPW0JnufKfaWd+8omn4CLoqssKsOc0XhsnWrkC14G2yi65lmh+Kkec3ZhrTtUHaAVPpeUZUDP/P+Ptrs8F6/zBIP1SfPAKvGuSPKML+IyhEH3KGyEhMz5ART80zHl1axvluZ9eUTpBqEcRDj2Bf6FaD5kM7EfjL4PA9nXH5h3WV56n9+e6uVBjZpY1AHYw0NoLYg2w6oFESjGupJgSKeOIstBx/6UYl1x/fwH41rXuFMvUu1rqe15LL8TA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P5F91F8kXGOvdNVd4kDjBHUtwNDx9muNqZv7VvhCMRs=;
 b=au0ayviM4RfhHulShbQklSo2x1h/ij9OE75vqiVydpIUq3MpaW2EnVpfr3ArkyXncRuwzs+tKmgg3uP0OyGNisLZ2ZQkSM976ND0J+UXCOUSPVv0uoJq6HE5sAU/LSowgkXoJtXusmj7cPZYY4f0RPdhOWWkX4c5Q37hkNPR+Gg=
Received: from MW4PR18MB5244.namprd18.prod.outlook.com (2603:10b6:303:1e0::16)
 by SJ2PR18MB5562.namprd18.prod.outlook.com (2603:10b6:a03:567::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Sat, 13 Apr
 2024 16:17:19 +0000
Received: from MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::6244:4406:da13:da4d]) by MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::6244:4406:da13:da4d%6]) with mapi id 15.20.7452.041; Sat, 13 Apr 2024
 16:17:18 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Jerin Jacob <jerinj@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Topic: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Index: 
 AQHajNJlUzRgj48oqke7eNtbl1jogrFkj7+AgAAOmwCAACXXAIAAAZzAgADsugCAAFXs8IAACFkAgABEXHA=
Date: Sat, 13 Apr 2024 16:17:18 +0000
Message-ID: 
 <MW4PR18MB5244807D8DE91CA01EEB91B5A60B2@MW4PR18MB5244.namprd18.prod.outlook.com>
References: 
 <MW4PR18MB5244C76290A15737DC94FFDBA6042@MW4PR18MB5244.namprd18.prod.outlook.com>
 <20240412121005.1825881-1-vattunuru@marvell.com>
 <2024041250-nursing-tidy-db7e@gregkh>
 <MW4PR18MB5244FA7231C64F8A7928B83EA6042@MW4PR18MB5244.namprd18.prod.outlook.com>
 <2024041258-reminder-widely-00c0@gregkh>
 <MW4PR18MB52447D1E7F0CD0D1CA6BAACCA6042@MW4PR18MB5244.namprd18.prod.outlook.com>
 <2024041351-endowment-underrate-4b8d@gregkh>
 <MW4PR18MB52449EBFE3862D7C3065D22AA60B2@MW4PR18MB5244.namprd18.prod.outlook.com>
 <2024041310-bundle-patio-8a22@gregkh>
In-Reply-To: <2024041310-bundle-patio-8a22@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR18MB5244:EE_|SJ2PR18MB5562:EE_
x-ms-office365-filtering-correlation-id: 3540b287-2519-49a9-8ac9-08dc5bd5310f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 +mbyOODgFeKP4Qd3rhC/L2AuEv2AYGI162xH6YH5g/sqgcSdb6Vd3kiIevrqWjswZcZIDGXl8Msrvut+PIoBpdMWO/rXdnQPxUBAUfDgKZvycv5CzzvJbliZfqmjuuANBYxH1DZbbO65cKehs66ZFOC+7JN//0V5w/0suEg1VoKeXFH3kKDhOjlY2nW2x4iJ/PARNpxie5DmLxxAGlOe54G4rfjVUPhXQCYTVmtSOQyGiBnU5NUdRyO4gvRHfoc/ErlyesBZrJuclOnbNmkFdl9O1Hg+fE4XRUWrWHBBy0M6T7Fxm+DhGfBa6JEYyncIyHvpnmXWajF0gsNykNlOfy5m0IVbvUSvFY0eIu+KIRRBur3HbGPQRHk35VU1mQo5CY+C5q5iDd5PFCjtsPx4656VgsLX7ySuD3jPmeg4jEli3tfCISLjUA9Nses1ZX42DXwfiQAsk2n3tJilrACJEAoGKOPeEz+4hksfLmqVnXVo3vOfHF8ImX0G13iYKuAGJfLZoaf83b0UPdXNndsjHS1tVDt7mp5MDDpjQ4Oq5jFcybkWd5qT0H66YoMoVscWi7k7b4FAqzwBM98gqqotsQMX4kIjsCGtkq1T47H3MpnVph2Knn9elipFm00FAtNVp12JT4EC/7hEszEPPHg7i4kH8v/IvPFlqkKzoCG5cfg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5244.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?i6ZzFs3Ph1z1J20InDfg1+6lKIYVMs6BeQO31ZRIfT0ycHjpabJRRTqv6uwf?=
 =?us-ascii?Q?HKxjkTQMfXHcU8pPPL2QH6QspfUZ8DZB+A1gd9cwMQJG9stgKcD2U+U85Z7k?=
 =?us-ascii?Q?uCZRyPJheTG+Q7msVKTBQiJ+rASknQqsvz8S0or5YBJL0WSsFPRxo8WjzoAi?=
 =?us-ascii?Q?Jc21NsD6kE3LEODYJqFBcEnSNKCeOlU51KKrqbpgYBpJXOLQKCopgFCNxzbp?=
 =?us-ascii?Q?PGF4YIdPinwX84ZDdsAF0k3DSoXTPmvQXe1KJ/ePpXL9gj2E2UeBT1PVbcR5?=
 =?us-ascii?Q?KkTqYjrFysgHlp1kPLYOmG54Xlto3rLw2vNgWfqGGrQhXQqRkgfPiUQK6Ntk?=
 =?us-ascii?Q?nO0ImZq9WUCVlR9uhpN0nipFJPUgI46AAKekeYmqUB6oOUTky73kLhK/rv8o?=
 =?us-ascii?Q?Ml7WWSMkkOaBPHHXXlENXghlXFfePe2Y0YmFXf8QBpoFrAelPz3xXSdUgX8/?=
 =?us-ascii?Q?y72f6G/02Gb2uNo2bHd4sWd49WaAoEJB8s3YTiQFcqOUx5Z191im+dps6+bm?=
 =?us-ascii?Q?ikNeSTVYrDdl6gcNUyYdlWLditUSre9OZ8SF15P9NROXYQvZS8sG7LOGNRj3?=
 =?us-ascii?Q?AJhYurV3h7hx5aM8TI1ZOeNn0xBIAfRhvruABmbtlQQzupYe+MvlxNi8SaxF?=
 =?us-ascii?Q?FrVZkj7aOTHJ7jlJTNaT82a32C3x222unFyKJ6O6Bv70/ut0UtMBiFJqu5+z?=
 =?us-ascii?Q?+vNkIjUunMpszpqTALJlGj67CfUTuPULN2W9AVsGUacbgYKSyg+FBnXmxq/z?=
 =?us-ascii?Q?sqB337SKwyG7a18gTr7MMrLNqLYR1q0Zq3vTuM/PXpyfCjR8TIqGaylc/7FM?=
 =?us-ascii?Q?FMGSgJkKCHMg/Do/nAigtTJranyqAScWcrA1eHACyJGPx35TeccEukemsDqV?=
 =?us-ascii?Q?lGhM6eeKI5bytPpDNOUmDuDl83CV48j96P7cajb5Z5apIWK+DU7ZyyJE6Bz8?=
 =?us-ascii?Q?+AzW3SR+ldsd5wIZZH0QkDY81vo7KkQ5pJ/Fb+aDfl3mp/6Sbm4E19BZvclI?=
 =?us-ascii?Q?Bl/quvhF05xQAprcB9q+HU4AINLHYiiKWcyDOgCWoKAArWnowqEo/88P4620?=
 =?us-ascii?Q?hrGy2cB10zBwV1NMTY8TqI68UZ5eYNrLTsItmUWkvZcwVNGkSIKk0aNe47R4?=
 =?us-ascii?Q?edRO3ZkVU7Snv8QcBlEV6kIX6yP0S20HJbZyNf89RLoGFmo6yjRpoWcGpKH+?=
 =?us-ascii?Q?jkkCOfZhXAMfgBSTUVLa0F2Z0q2mTpJojv0+anDNYvfepKdvgUUQFgbl2u2s?=
 =?us-ascii?Q?fgoVJnwo3IgiV4huyO/7bEp98F3UbNDKILCBsaQFobXEqX+wcB2VT+fLsUPM?=
 =?us-ascii?Q?Giu+ZqznZkS5CsZVqKI6PRlEnFJtRcPwmvWLnCjTyEix/azYULoSWcJlszBM?=
 =?us-ascii?Q?dvPxZUmDZUvh4ko39KZdJM/2veyvXzIVOFyZjRMGjPetn24XTMYqlV7t3bcL?=
 =?us-ascii?Q?CubmOMBInV1J2aq9Gk7XD/kpZH18suRMyYgTJG3cmYJo9UqtbG1w+BUY3Thi?=
 =?us-ascii?Q?RVQ724HpVQRGhzyDVFmmTkWCabaRvwGjqMB7N1qm4gdiwCrEGE8JdqEnQTLh?=
 =?us-ascii?Q?QNsawwjl4sPGlHbb5pSMS3oORQUvcAvHQt5T6H2u?=
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
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5244.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3540b287-2519-49a9-8ac9-08dc5bd5310f
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2024 16:17:18.8918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jMEw4rNgIM6ovLV7dYtTJq7vCba1Eie0OoCz5z55jz4/US7heuXv7Bwl0m7oRZm/XxWhsx1ET2hbX5IYDEqE3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR18MB5562
X-Proofpoint-GUID: R4o1xhDffTvmb1MviOWuaZDQ8hmSVOvZ
X-Proofpoint-ORIG-GUID: R4o1xhDffTvmb1MviOWuaZDQ8hmSVOvZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-13_05,2024-04-09_01,2023-05-22_02



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Saturday, April 13, 2024 4:55 PM
> To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
> Cc: arnd@arndb.de; linux-kernel@vger.kernel.org; Jerin Jacob
> <jerinj@marvell.com>
> Subject: Re: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add
> Octeon CN10K DPI administrative driver
>=20
> On Sat, Apr 13, 2024 at 10:58:37AM +0000, Vamsi Krishna Attunuru wrote:
> >
> >
> > > -----Original Message-----
> > > From: Greg KH <gregkh@linuxfoundation.org>
> > > Sent: Saturday, April 13, 2024 11:18 AM
> > > To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
> > > Cc: arnd@arndb.de; linux-kernel@vger.kernel.org; Jerin Jacob
> > > <jerinj@marvell.com>
> > > Subject: Re: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi: add
> > > Octeon CN10K DPI administrative driver
> > >
> > > On Fri, Apr 12, 2024 at 04:19:58PM +0000, Vamsi Krishna Attunuru wrot=
e:
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From: Greg KH <gregkh@linuxfoundation.org>
> > > > > Sent: Friday, April 12, 2024 9:05 PM
> > > > > To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
> > > > > Cc: arnd@arndb.de; linux-kernel@vger.kernel.org
> > > > > Subject: Re: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi:
> > > > > add Octeon CN10K DPI administrative driver
> > > > >
> > > > > On Fri, Apr 12, 2024 at 01:56:36PM +0000, Vamsi Krishna Attunuru
> wrote:
> > > > > >
> > > > > >
> > > > > > > -----Original Message-----
> > > > > > > From: Greg KH <gregkh@linuxfoundation.org>
> > > > > > > Sent: Friday, April 12, 2024 5:57 PM
> > > > > > > To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
> > > > > > > Cc: arnd@arndb.de; linux-kernel@vger.kernel.org
> > > > > > > Subject: [EXTERNAL] Re: [PATCH v5 1/1] misc: mrvl-cn10k-dpi:
> > > > > > > add Octeon CN10K DPI administrative driver
> > > > > > >
> > > > > > > Prioritize security for external emails: Confirm sender and
> > > > > > > content safety before clicking links or opening attachments
> > > > > > >
> > > > > > > ------------------------------------------------------------
> > > > > > > ----
> > > > > > > ----
> > > > > > > -- On Fri, Apr 12, 2024 at 05:10:05AM -0700, Vamsi Attunuru w=
rote:
> > > > > > > > Adds a misc driver for Marvell CN10K DPI(DMA Engine)
> > > > > > > > device's physical function which initializes DPI DMA
> > > > > > > > hardware's global configuration and enables hardware
> > > > > > > > mailbox channels between physical function (PF) and it's
> > > > > > > > virtual functions (VF). VF device drivers (User space
> > > > > > > > drivers) use this hw mailbox to communicate any required
> > > > > > > > device configuration on it's respective
> > > VF device.
> > > > > > > > Accordingly, this DPI PF driver provisions the VF device
> resources.
> > > > > > > >
> > > > > > > > At the hardware level, the DPI physical function (PF) acts
> > > > > > > > as a management interface to setup the VF device
> > > > > > > > resources, VF devices are only provisioned to handle or
> > > > > > > > control the actual DMA Engine's data transfer
> > > > > > > capabilities.
> > > > > > >
> > > > > > > No pointer to the userspace code that uses this?  Why not?
> > > > > > > How are we supposed to be able to review this?
> > > > > >
> > > > > > Userspace code will use two functionalities (mailbox & ioctl)
> > > > > > from this driver. DPDK DMA driver uses the mailbox and the
> > > > > > dpdk application uses the ioctl to setup the device
> > > > > > attributes. We are waiting for this kernel driver get merged
> > > > > > to update the corresponding support in DPDK
> > > > > driver and applications. I will provide the pointers to both the
> > > > > use cases in userspace code.
> > > > > > Meanwhile below is the current dpdk dma driver that uses sysfs
> > > > > > based scheme to convey mbox requests to the kernel DPI driver
> > > > > > which gets
> > > > > replaced with hardware mailbox scheme once mrvl-cn10k-dpi kernel
> > > > > driver is merged.
> > > > > > https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> > > > > 3A__github.com_DPDK_d
> > > > > > pdk_blob_main_drivers_common_cnxk_roc-
> > > > > 5Fdpi.c&d=3DDwIBAg&c=3DnKjWec2b6R0mO
> > > > > >
> > > > >
> > >
> yPaz7xtfQ&r=3DWllrYaumVkxaWjgKto6E_rtDQshhIhik2jkvzFyRhW8&m=3Do3EhoL
> > > > > s7dsod
> > > > > > -YHS438Wl2Pf_MKMBYegGSKteoX3qFTB0HV897ykpCVbTp-
> > > > > nmj4e&s=3DA6TJDFUtPm3ksJh
> > > > > > qop89CL8GgKj4sjkJIVi1-RdnUr8&e=3D
> > > > >
> > > > > So this is a DPDK thing?  Ugh, do the networking people know abou=
t
> this?
> > > > > If not, why aren't they reviewing this?
> > > >
> > > > Actually, It's not networking related. Like the Linux kernel, DPDK
> > > > also supports multiple subsystems like network, scheduler, DMA,
> > > > mempool etc. Regarding the usecases, the DPDK Marvell DMA/DPI VF
> > > > driver interacts(over hardware mailbox) with the mrvl-cn10k-dpi
> > > > misc
> > > kernel driver(administrative driver) for setting up the VF device
> resources.
> > >
> > > So this is something that the PCI core should be concerned about then=
?
> >
> > No, it's a normal PCIe sriov capability implemented in all sriov capabl=
e PCIe
> devices.
> > Our PF device aka this driver in kernel space service mailbox requests
> > from userspace applications via VF devices. For instance, DPI VF
> > device from user space writes into mailbox registers and the DPI hardwa=
re
> triggers an interrupt to DPI PF device.
> > Upon PF interrupt, this driver services the mailbox requests.
>=20
> Isn't that a "normal" PCI thing?  How is this different from other device=
s that
> have VF?

Looks like there is a lot of confusion for this device. Let me explain
There are two aspects for this DPI PF device.
a) It's a PCIe device so it is "using" some of the PCI services provided PC=
Ie HW or PCI subsystem
b) It is "providing" non PCIe service(DPI HW administrative function) by us=
ing (a)
Let me enumerate PF device operations with above aspects.
1) Means to create VF(s) from PF. It's category (a) service and driver uses=
 API (pci_sriov_configure_simple()) from PCI subsystem to implement it.
2) Means to get the interrupt(mailbox or any device specific interrupt). It=
's category (a) service and driver uses API (pci_alloc_irq_vectors()) from =
PCI subsystem to implement it.
3) Means to get the mailbox content from VF by using (2). It's category (b)=
 service. This service is not part of PCI specification.
DPI PF device has the mailbox registers(DPI_MBOX_PF_VF_DATA registers) in i=
ts PCIe BAR space which are device specific.
4) Upon receiving DPI HW administrative function mailbox request, service i=
t. Its category (b) service. This service is not part of PCI specification.
For instance, dpi_queue_open & close are requests sent from DPI VF device t=
o DPI PF device for setting up the DPI VF queue resources. Once its setup b=
y DPI PF,
then DPI VF device can use these queues. These queues are not part of PCIe =
specification. These queues are used for making DMA by DPI VF device/driver=
.

>=20
> > > > DPDK is one example that uses this driver, there can be other
> > > > userspace generic frameworks/applications where the virtual
> > > > functions are binded to userspace drivers and interact with
> > > > physical/administrative
> > > function driver running in the kernel.
> > >
> > > Are there other devices/drivers that do this today in Linux?  Why
> > > make a device-specific api for this common functionality?
> >
> > The apis defined in this driver are specific to Marvell DPI hardware.
>=20
> The api, yes, but that's the point, shouldn't this be generic for all har=
dware
> that supports this?  Implementation should be device specific, in the dri=
ver.

No. As mentioned above, it is not generic for all devices. (3) and (4) are =
specific to Marvell DPI PF device/driver. (1) and (2) are common for all th=
e PCIe PF
device, which, this driver is using APIs from PCI subsystem.

>=20
> > For instance,
> > the variables molr(max outstanding load requests), fifo_max, ebus_port
> > are DPI hardware specific. Generally, drivers use driver-specific api
> > to configure any device-specific configuration which does not fit in co=
mmon
> functionality right.
> >
> > Mailbox operations like dpi_queue_open & close are requests sent from
> > VF device to PF device for setting up the VF queue resources.
>=20
> Why is an ioctl to a random character device the correct api to userspace=
 for
> this type of thing?  Shouldn't this go through the PCI layer api instead?

No. Because it is not part of PCIe specification. PCI specification operati=
ons are controlled through PCI config space and extended config space.
These are some DPI device global configuration operations(ex: DPI_EBUS_PORT=
X_CFG, DPI_ENGX_BUF cfg) which are NOT part of PCI config space or extended=
 config space.
There by, it does have any role in PCI layer API.

>=20
> thanks,
>=20
> greg k-h

