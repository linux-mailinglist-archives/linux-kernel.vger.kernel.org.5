Return-Path: <linux-kernel+bounces-82808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFCD8689F3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBCDF1F2261A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F63754BF4;
	Tue, 27 Feb 2024 07:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="B2x7tkkv"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1942052F90;
	Tue, 27 Feb 2024 07:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709019394; cv=fail; b=gXI80UKrFedpF6rMUcoDJE/LmG9Mb9JUPq5KUM0GL/KvbKRVHiz7bXMILDYRV4Ta8iCcN+qCCciY0+Kh4ZIuwUPtNMk0AGrC1gMuDED06/ZzDd56aT7MMGDkovCVroDbpDtBFz5r93EScB5xYXpBy0oXFoBLOCpjxPB7AsGALv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709019394; c=relaxed/simple;
	bh=tAn7YuRZUQy6PsaUzK6HuEAjH1Y+DVIp2cV/UwKOdwA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XMK9pKLbGXZIuRAt1Gunpbac2q7xG8qkBsmVaVgJ7nH1r85jHwLiE+5x6gSg04c4NiuB2FI7R31BlZ5m+IJ1VgOHB28fGZEpU30JkvZH0l8DcVkPytoErkPeUKS8fUX6RdNz7/oPJkAGCwp+muan+ZPZtxsZ1PCWBG8gi3GxaLE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=B2x7tkkv; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41QLBFYK014442;
	Mon, 26 Feb 2024 23:36:20 -0800
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wgre8v2a8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Feb 2024 23:36:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j1GUE1Tea7IGXYRnp5NTU9z5ibEG6JSWJwfxvPiewsMFM4WFQr+tnqUrEwaoSM6gVU7r0b9BRsXMj104YSac4TU4B01mRSGTfwieXAIVPmO2dCVoAS+fyh8Ii19UiHYugHWp8TFlwlsJ54NOe84BIHgJYuJkHi+p/45WUZyHub8GD8rn91f6FvdAzxk63BTXF9he9MbMaiSnKykbYz7QAvTy6ymFG2qLygUIknEohWrx05hacxPdwtHjvb5SBh/dhJ4nqlLgJ6RFLR0eVO/V1x8LhT45VKefQoe+YpGepM4sS6jB/7KPEHG066hx6QL7XRPSZgJ/cPPa0FLlUK98nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jY2LffFxo7NWJFHH827tnRgY1P6LEDgzXSkSc1gx37A=;
 b=mR25jpDY3OU7HjBRvb37XJpGtXGx/uLlaUxxszchLPw+eDmME/RQl7c+8V1UlnRxCHprFlSnivhJrEzatISqrh2WwivhPCA/PILCbX/Q7IFOYQrv09CeoTOIlixefc6KpdZfO+8jfH94/bnYCSh9bMRlvRYGcUV4GeK+zx7ag1Vpd1RCYOxoB9WAEqppyqNagx64b1wZUIO/Tny1qWmMiLQoSLzIGkhhIQAk82I6HnnyHjgS/Zz3VfZn3ahmvTDO5eoeHUCoXPmVwwBCwzAEwnmV5c/3agiQgqsY11ek1+7qbDvooI2UZ+Ogbx3bp9GJEDsAHoHUmO16mVyBD3rZJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jY2LffFxo7NWJFHH827tnRgY1P6LEDgzXSkSc1gx37A=;
 b=B2x7tkkvxF3JTt43PNnkgpH1XzVnTijgKHW67PR60aFlBFWorRgzLAagnHX1+qTMUYxNeP0FDvpUADTCdgnZQMz26BIwFaFtRs2DmBlKO/xGB9oVI1AJA/mz+jmcTG+tm9vw3F7juy1hPMXOmq1Qo+Nu8/fawGkZKG4cc42ChCc=
Received: from CO6PR18MB4467.namprd18.prod.outlook.com (2603:10b6:5:355::12)
 by PH0PR18MB4937.namprd18.prod.outlook.com (2603:10b6:510:118::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Tue, 27 Feb
 2024 07:36:17 +0000
Received: from CO6PR18MB4467.namprd18.prod.outlook.com
 ([fe80::d200:d2c0:80c5:9ca5]) by CO6PR18MB4467.namprd18.prod.outlook.com
 ([fe80::d200:d2c0:80c5:9ca5%6]) with mapi id 15.20.7316.034; Tue, 27 Feb 2024
 07:36:16 +0000
From: Hariprasad Kelam <hkelam@marvell.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        Subbaraya
 Sundeep Bhatta <sbhatta@marvell.com>,
        Geethasowjanya Akula
	<gakula@marvell.com>,
        Sunil Kovvuri Goutham <sgoutham@marvell.com>
Subject: Re: [net-next PatchV2] octeontx2-pf: Add support to read eeprom
 information
Thread-Topic: [net-next PatchV2] octeontx2-pf: Add support to read eeprom
 information
Thread-Index: AQHaaU+lbCOwZ7NarEOE3SUT7nyDdQ==
Date: Tue, 27 Feb 2024 07:36:16 +0000
Message-ID: 
 <CO6PR18MB4467EA7976DEDD6872D0BC54DE592@CO6PR18MB4467.namprd18.prod.outlook.com>
References: <20240222171542.12995-1-hkelam@marvell.com>
 <20240226170027.6a43f196@kernel.org>
In-Reply-To: <20240226170027.6a43f196@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO6PR18MB4467:EE_|PH0PR18MB4937:EE_
x-ms-office365-filtering-correlation-id: 018a660e-92d0-4726-451e-08dc3766c836
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 5wBEEV7w6qOxUicqcGYOhmgHKaJTtJPcMNzkq80MXUQxoD5lziXEXh678xHnvFNnUJd7EKquPEcZics+nhGEqOcTqcqEunRvOydxv58YBmssyiBZ/YkLBQ3cYAgADx3lGNsQo745Ivej510DQ1vim2r5VAONMY5voAq21RFOIbsY1IYQaBZ/P7M1fWjlb7u5YoDyJp7Dxrk4Bp4F15B6+RfVwS/fBeyD5ME81QSyUM0+1BLp8Nz9gZ9umWSPrk8lIYpArCIhOFy094XLm0G7nUVIlkASLPsctSDeXqI88vHdGev6g8eAd/9VRRkAHexjxi4bgNId8RkXOO2VPHGzvydwBRvdbJUGEHMzjrE+T27q236QRi97qZC6VddmL2FQ7600kOLcdDpHg3tIE41AmpIJIqcVUswU8hxvmgb46JaX/cBz8QAKmtMe4ItKNxskrdHoQCZGB3OYS82Oj48AQQqGxfvpUclon4AGGT1ffyiGZuo8enlxRG/GPeKFBlQ6aaGUCHdGInFp1FmwJFsZpT6S3TUCTTjk+Xx19cmRdQbbbj8iYTbZ8gBzObUuctxB9ev35oPHNkc3S+wVEZe++zkFovqoJzLQTol292kcSIkKlTqTHYoWYWA/nh1PM9yhM0DwOlvqkUMAXpgiysvlXn7RrcGXMWnOVq7qAFBdgfX+AtckPdGCZpZbnCkdaqJ5jRBrfSxrAFtskYBrEGBFa+BhanebJo2K31GtF5o6aPU=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR18MB4467.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?aGtFD9xUbkVgqXQgW3vRJ61FaW0cfBviiMAXQ1Kj8U/3QW5JzpGyrWY8RBzN?=
 =?us-ascii?Q?91ap0GOdFJGhfOQNPX1pHsznNNCH7wzfJYfoI0MnPLgTsJXMDum2qQr0Ciec?=
 =?us-ascii?Q?RxIZiPaHWLyLU2q2wldS/pMOzcCMDgA3QCetHhlveiqsykR1iD65oQRM8yq6?=
 =?us-ascii?Q?QjKRymwBsnIPoWcojqimggKRvMNMs1QXnElL+MVgdBdxypZ8337HdtRRShbf?=
 =?us-ascii?Q?uHxGoDRvcYkdsfIsIezTjxBj410frMZk537h7HUbGzxt/9IejfX6AX2FWvBW?=
 =?us-ascii?Q?McRAe/mGZkzGgcumCCK+9lacn8EHF1+o1TAnCnhRJ1Ti4cBctWOCJtplP5RT?=
 =?us-ascii?Q?eLgTmgDWz2JXD45wmNtb4TRzpLG1VgC+q9tFh2D99hsPVqRh08oBy7KsgUnL?=
 =?us-ascii?Q?/WDIqNjm39Nspl7ehUpSW+zhYftKnAJC2XLR6nEn4UAd7QKT5Xpnmv4P5gEW?=
 =?us-ascii?Q?mN+UIvNQ/KorOEDUWskQ+MFdjpdF8MqLY8UmcnqNIKlBzUpg2vPeQD9yjMRl?=
 =?us-ascii?Q?RF2FwDMF3E7H7fY+PSvprUV+Wb72eGLO5Bzp7YWx1H6XMx8r1nLXM91RN9X6?=
 =?us-ascii?Q?BXCbE3V8WPl7j4mTI3wrwucmsm2dAwvI869nVHcWJ2OqGZqYD5HtYBPT+RnL?=
 =?us-ascii?Q?Q9YcRaBeYpDzK/5sGLILYoW7RGuBPdPD7wm2Ptn9D+mDJVwJObLdCViEUwhS?=
 =?us-ascii?Q?B3BUpVzK7qVQZyZ5ZYtES56FnYEh/1BvtwGZEUGEcg6tH20+Jq1uqcH4k7gK?=
 =?us-ascii?Q?RrWrzYm+0MMQwPLNtMcAUXxdod7PTrmxLFWIqiMtrVqz28eXmqRs/x25naV6?=
 =?us-ascii?Q?fvmitwPnxTxxkN4pv9KvPCVQXhK/rBJH8S+XUbMMyIhFZP88KofD53bokNwh?=
 =?us-ascii?Q?o9A7QRbHXjPp1v4+LnH62yBrvxz1URzTY9jHbgB/dCo8hmcJLow5b+LYiLOg?=
 =?us-ascii?Q?yK6BLV3xoWQi3KOEPEK/anScCb4wfy1g1SSJxXUEI9PWDUdhICSQ4y5+aKKY?=
 =?us-ascii?Q?27c4PnPdwCJLKMC6BnmIYE1TMd2TViZY/09UEAieedy0iBg0SkYdmE/hhxC5?=
 =?us-ascii?Q?om/GN2uwAQPkLjESp+hqOir2IDjQdt4jt0VIFm7gNN6MnwXLDJ1OuISdIFBh?=
 =?us-ascii?Q?BueX1PIbSGQNz9ojuk3CGIyQkPxwSv8Sbf4pl1DJRMD/bbapdkEJOWB2wLvv?=
 =?us-ascii?Q?vWil65c7zKxqzu6Ebbfv7V+jqoBRMPphsWwomqAj7bNCwk3txSCEVilRDei9?=
 =?us-ascii?Q?N9duNF4PUm4ESgXahTIJ93YVEt3ZN4ML/y3yIylRVJNFWQjlTcdK7e840tHM?=
 =?us-ascii?Q?096eF9zWRG8h7AMEfqhAoxZz8bTAK4dlsMfk6k0ypYoTzSHFHFphImrlWTP1?=
 =?us-ascii?Q?3/Hxhie3aYVTokBxkU24eqrCZ0Mk24eY6eVUHnJoFxm49vu+oc/PKYImoe27?=
 =?us-ascii?Q?7ixbNlQXWJg2LeHtFoC+FTNjmv/yUU5ILWo4tB1wbw6dEsHKQVg8GxR2c/Jp?=
 =?us-ascii?Q?QNbAXYYvAMZLr3hUMsGo/3sebKLfXHooOHeIMwV5FD9ntJ24RFINzyoEtHHu?=
 =?us-ascii?Q?eEcwb+PsNC2wLjzRsfQ=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CO6PR18MB4467.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 018a660e-92d0-4726-451e-08dc3766c836
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 07:36:16.4358
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: i9W8BTVVoUmtY+R4AVjKR2R10cvuQk8TCzPWSt4coI6OqArLgX2hdxUooDyt/QLPxPEhAnE4xRpyVMe0nCCelw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB4937
X-Proofpoint-ORIG-GUID: -IUi4Cso-3yI_JWqNuII78k0_NqnZEY4
X-Proofpoint-GUID: -IUi4Cso-3yI_JWqNuII78k0_NqnZEY4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-26_11,2024-02-26_01,2023-05-22_02



> On Thu, 22 Feb 2024 22:45:42 +0530 Hariprasad Kelam wrote:
> > +	if (!ee->len || ((ee->len + ee->offset) > SFP_EEPROM_SIZE))
> > +		return -EINVAL;
>=20
> Are you sure there's a path thru the core to the driver which would allow=
 len
> =3D=3D 0 or the size being larger than when info put in eeprom_len?

 Seems these checks are not necessary,  will remove these checks in next ve=
rsion.

Thanks,
Hariprasad k
> --
> pw-bot: cr

