Return-Path: <linux-kernel+bounces-162395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5C98B5A8C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 15:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8ED128B191
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 13:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9ED77F10;
	Mon, 29 Apr 2024 13:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="PHnzRGDe"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FE274E0A;
	Mon, 29 Apr 2024 13:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714398683; cv=fail; b=gotdAvYBM8pfYgUQSOYrMVO5TdI/VXZczbZNmrquXjGhwDkbZ2UnIQ1nsGZAp6MZeO7pdGAmrr102SKA39hfQ0vUa5Fgoe0OUZETwkgIgOxK7/t4uNbH8++RdzfN2751ILy3hsIwm32CR+PV0T+5XXTFQy4ZbedI5zjAl6bs/Ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714398683; c=relaxed/simple;
	bh=81vMX3RBbbbZLooWKZNA5r5AJBM+fxxanNWFbjF7EVU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=A77c/A0RIO6uxqylqReTmGg15z3yDy5cAw3fpFBK8Lkdns1miD5Vtjv1I2lD0FFmSc8/Fd80Qwc8JHJSMP87oB6yY1e7PWIM1H32NIpfdCeSzdbMA74KE44hiFVEDY2tDY1DbKEnBDHaegCL1Sgrx/9bEvMN8GkZ0BXPpdHBa7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=PHnzRGDe; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43T00O14032155;
	Mon, 29 Apr 2024 06:51:11 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xt0mdaxyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 06:51:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3rqsYcioo3Z0SC+NZZpzBhe8weTqipy7O2AGwZMEPAoLZ64/CTz6HwmPCwZkQm94KGEHwTV//GRUW/fxVofb11OgvfT6HkBcngfc49El8+8DLyk+8xh7xhP4hmSh213ig3TJxrx4bGDvrYqyN3e9CX37AVVuJZ0AqiOAa1tb75bVPIUOByVrDmq9bm2zQVFx2ut8TlS3bb0FhcOb27FdyvYul/pU//6brKmXa4UhPZzuhSrjEIwz5WJfkZk3TI7Mu4DwYAzjLEaDIuc5v30XS35ef0rt8bJ3XvfPpqE9eMixwTqqy0XI5+PTkkAg6oyIKpWdpm+MDfgH6wsgas8cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nHLgDlibxayCMU0bOYoyg3NCiQV3IUj2rC1Upc9ZFfE=;
 b=I0PmEK3vcDbmrRQd2lFoQuEDI1BDedQdcQdlh/QADb2OiGKe3k5ODtUlO0Z5iFQwxhKbp1EgVk+wPJJmegmvKzLRq0mK4wkYivhBYD/pU8DISIdpodhVxixWyN7vavwj8bupMGRnVTgTkcz/+jpyV4R/S2p9XRxX+r8dgVLkNO5mX1kkw0COpzf3cTB3D0eTBYHU6rjYOo2aAJylubH+qAbOObJMPgJJm396ECdrMCp7mvrdOUYZEx1bRLZ5I5yuBCs5/01iRKvx9s9MFxLLtojnTLH/bKO31846k2GbHdJ7q/zMF9giZsDy/yABH7Z2nLJPdkXtQ3NMeTWFTrcg9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nHLgDlibxayCMU0bOYoyg3NCiQV3IUj2rC1Upc9ZFfE=;
 b=PHnzRGDeZVbUlT50PtmeR3do8uG2+QqxZr9R0iM+sAqzNvpNT6b+joBPOVBlL3fksch4WiJ9bijw6nHtW1gKvxV2W32CRSEx+pK2Fg1URiyTVltlAXcvzXazr/NVEO5DPzVokK4uPngJcxTMgxoXpf+Kn78Z7sONoYJg6rO5zAM=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by SN4PR18MB4920.namprd18.prod.outlook.com (2603:10b6:806:217::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34; Mon, 29 Apr
 2024 13:51:07 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 13:51:07 +0000
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
Subject: RE: [EXTERNAL] Re: [net-next PATCH v3 0/9] Introduce RVU representors
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v3 0/9] Introduce RVU
 representors
Thread-Index: AQHamVpJ5duk1EpUIE+euxNx4bbU97F/HsIAgAAlqzA=
Date: Mon, 29 Apr 2024 13:51:07 +0000
Message-ID: 
 <CH0PR18MB4339928BE28548F3414E8D27CD1B2@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240428105312.9731-1-gakula@marvell.com>
 <Zi-E_rfFx5LuV_Nq@nanopsycho>
In-Reply-To: <Zi-E_rfFx5LuV_Nq@nanopsycho>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|SN4PR18MB4920:EE_
x-ms-office365-filtering-correlation-id: d70dc6be-bae7-4649-6c86-08dc68536b8c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?Es0sdj0ApmPh8wXCSB1eI/MgpHWydU3a/wsG3TPCOzw823Js4EfBDgEbn+wH?=
 =?us-ascii?Q?UuN9YSBfGlQgxNlqg1jJOTyQp1zve9UKG+DKrEVCr55Eb8SAAuVtOIaJJBrR?=
 =?us-ascii?Q?RZaaOJVk5s5ta3Mg5ILkHFVl+Yh8dsNDOOWBWVCve/FRrpGvEie6AnJMizey?=
 =?us-ascii?Q?84uGAOdrh893xJqMc4sd5EVFp7OGQJJ17ozuMH0mREAojfOH5nCtC6MzeDPT?=
 =?us-ascii?Q?RtYB0VurRC/seWGXFtzsitjv6eT3ZMg1XN0xGfwxkplI8emq48mWZzwKHwQD?=
 =?us-ascii?Q?I9qZcsIL7jKuI3NcBB7e010VmV6tq/5T43EJn1uH+T8tzOQRbkT0VHAtPJed?=
 =?us-ascii?Q?nzOvW5/WAt5HfLKU9u2bFw0Qp20TQVmPibi5y5cLmB50vg2j423L7XyYrHa6?=
 =?us-ascii?Q?CdzkiWZOnQLbYvKsD+7JTb/VoJHJWVSi+WwKUAXm3guUHcDeElS1Pn8iraM7?=
 =?us-ascii?Q?BKgwWFCKnkAvIkoxGRJjXcTl1SayXIUZCvoteXO7LUJOTioiGkGVbwhMAGMr?=
 =?us-ascii?Q?Es2Pe5UMk8IHgZBXWSoCZk7WhQ9be4ZVOtlc87dQSAOd29VJjmssCyjqOlEB?=
 =?us-ascii?Q?nGXS2TtvqekekzvTSzJ5HGiS2kcdFQViOsa6G1Ee6yVUbIm4HCsPHO9lSRQL?=
 =?us-ascii?Q?NjpRIwYXR8OhOmyq7BRvTB/cGnYfL7WbaKlXdzG10TJMq3ywW6qoVGvWxOUG?=
 =?us-ascii?Q?GVGU7CCMR70UU8qWY2lKRHWbr1G/QUJd5ZoJHwtF1x36K4cJbLfTKB6F33Bz?=
 =?us-ascii?Q?oi0++KRVxbRACnR8cy45sDYk0M0BWJnoqc6IUslhroT/GyJTMCUUymJHKfjm?=
 =?us-ascii?Q?eTPz9q9eGfzXJOZiNsgr74w94uhGB5M+3fTSuPWMKDX/fd+8nCL7f9xWIJaA?=
 =?us-ascii?Q?G7BEX8kG8yrLqHIS8tEFsiEIeEwS5JR1PFJe9kcYhRir72zeV22s1j7/0EAN?=
 =?us-ascii?Q?hMRRsR6GwXlH/QEF/AULKwD3sb230kmnsZBoP5paEk20OVBWKaY3XsbEvblb?=
 =?us-ascii?Q?pWvmRB7ERcq3vX/ppHgnjvr42raKPD4z0cEZzzMxwUdaPLFyMjJbB8+ikyqH?=
 =?us-ascii?Q?1MdKUiulxTVPvNDRIrUVWwjc/Iih8R2fnxRwYxH3sYLTLr83oSRQiRAZU8Yg?=
 =?us-ascii?Q?ExXPFV+Erh2HeyAQ02wB82W+bLh9T9Z8d1BwCWG0B3ssUNZDKXnRMbCblvhh?=
 =?us-ascii?Q?Rq/UxS+FBwuOHIdfCIJ5gCNJpZwUZvNuYSOScnHu1vRq8+PUW+tK9LaFPpJi?=
 =?us-ascii?Q?0lA/3E63z0R1jKK2d0pLWa4JNWRm26peUPwzS5oXtsKtQPNt47Vk0JaBPxqD?=
 =?us-ascii?Q?6DuipaUOk1RgmWVUkWricccy?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?q/SQJEzOwvMyiWGRNuA/owp7iZEA4BdiQ/PIV2Lph9MGgECBkcDXsjwhgCnA?=
 =?us-ascii?Q?hfefTaluR8AHyZuw7dhGqnY4Cbolo8t8ceHo9W0ktoilDhCRfkn8M0vN9zP9?=
 =?us-ascii?Q?6/g+jz5cVvsSfwiOKUNOVaye4khWgKA29h0pwTOEs3HE7aJE2MwudffX3R5W?=
 =?us-ascii?Q?pITXc1uLeh7Lqi8JsvrgHu91Dop13ulx1zgVDTgWjlNMZ27ME4WyYrU1KH+e?=
 =?us-ascii?Q?kj79jeWWUkUH3cXz74hXjKeCFkTJ1+nUqMbSzong9JRWrUnQWwdqil/NVcs5?=
 =?us-ascii?Q?0tdvFW9RGhEciEAfEBlMoYRWXGd8ZieEkWqmENzBZGpTC+pNxMf1rkh3dHtw?=
 =?us-ascii?Q?prxuRj6iQdEQtYd4vf14lq9MYDuEQSuImd1BwYhyfKZfOHwosxOcZ2Fszqip?=
 =?us-ascii?Q?kvW8OvyeprU3a/uV7atLoPlPWeJrbrUUhd9nftgniwfNEn/geNTqq1MJwy/w?=
 =?us-ascii?Q?upYHj/qzsPfByNgcI9BGKkXGwdiEwx4rfLaWknzvpBz682/9qAwIz8AbK36G?=
 =?us-ascii?Q?mSIkxISjhLqg4s4jlKNAIIjsTWxH40VX+OYBiM6Hcp0fVmRL6lDX4R80m5bp?=
 =?us-ascii?Q?ZsuU5OTh5dZp33K8qXXusUfdL75lO+7wMTnD7qjvAjxiKNBS3fEKGZwXkI/a?=
 =?us-ascii?Q?Dn3wI08BO5jqo4JPMaghu6s7giPRsgpbGnegq1PgGB6greys7403o8LJ3Lhl?=
 =?us-ascii?Q?uaIodjsRR3TRc9ZGP69K187YM+xS9mxvJ2HxSNQqBtpimXOTa23g74TxNB8d?=
 =?us-ascii?Q?wKfEe0RzfjuYr5mFPPuQ1s9lwbdnRT6jsaxjYbCp+ocGPynVTz7/oiYWVz/9?=
 =?us-ascii?Q?dIsVmiYEj9EA6MbOhxeDiSYG+cqRHkbDe9hjN0H3QzlWDbgrIJ5prt+7B/7D?=
 =?us-ascii?Q?HGWBSUekjFq8RjEXxZdXvx625VHy4POXNwsRX0RPYAFrWHqVMUuqcelMBapN?=
 =?us-ascii?Q?O55cOgSqk/PC0BGdlBvBUPtpyE3N/2EVlskrpkGCiyu6tVrdO4G2n4ADfdiM?=
 =?us-ascii?Q?2Br7SEx5TY5Yo1iVRWSGi2T43w0JtHam3zTpUv4pRlMyIura6guujfxfyUDU?=
 =?us-ascii?Q?NKLc5fDyBafHsXIHKBbYCRQ+L0VXAsTRv2Ndn3/8qQ3pB/kBU+KWQY2lshpU?=
 =?us-ascii?Q?TvgkXcT8mgc0AyrhOo9JW0jo85es/0K72dvRKmBNfdQCiP4ENANeEgqgDcqo?=
 =?us-ascii?Q?xVADBYO8A4hlxrEIJoaf+uzPkpt/ARuL2uiNAKp/FlmA4oJdiPNSiZD1Fo4m?=
 =?us-ascii?Q?5MMua4KKfVS2Q6sFdLg1dB8fnWcU/yQjQTJxwGqMM2xWQ8GL2WNNtO4OaT/C?=
 =?us-ascii?Q?8gotEwNc90mUqS5g0YFGS9/EbYrH2RgwsZyqRBUkA9LpliCfT4pBWXrpjVIk?=
 =?us-ascii?Q?ARMGpBJkV+FfSzGhF0ovOJ4cYWnaR3vN+dlLJPDRTs4Shrabn82O8usH83qh?=
 =?us-ascii?Q?0KFPFsM+jGrZXmewbPnEC4ORJM4shpy0nM8uByQFI7cS5T3s57xB9vZ2lL/r?=
 =?us-ascii?Q?KwMjHr8VkHI17o4FN0sUGyZp+IQflhSB0SYHvR1x7e0r8DNv2GP1hpoEes7g?=
 =?us-ascii?Q?2lG+cd3V6pV7cE1j6Rc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d70dc6be-bae7-4649-6c86-08dc68536b8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2024 13:51:07.5085
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K/G9vXJXjHoQ5XTAp2WqDHle2FYpbPWwVckL6y73ia8C7oA/C6oWIPPtOI9QZHTp0LAceBxo7dBiAHfqHMAXDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR18MB4920
X-Proofpoint-GUID: -BepLy7NHwM2Opd2CBchZi8QhrWnyPpZ
X-Proofpoint-ORIG-GUID: -BepLy7NHwM2Opd2CBchZi8QhrWnyPpZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_11,2024-04-29_01,2023-05-22_02



> -----Original Message-----
> From: Jiri Pirko <jiri@resnulli.us>
> Sent: Monday, April 29, 2024 5:01 PM
> To: Geethasowjanya Akula <gakula@marvell.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org=
;
> davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
> Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
> Subject: [EXTERNAL] Re: [net-next PATCH v3 0/9] Introduce RVU representor=
s
>=20
> ----------------------------------------------------------------------
> Sun, Apr 28, 2024 at 12:53:03PM CEST, gakula@marvell.com wrote:
> >This series adds representor support for each rvu devices.
> >When switchdev mode is enabled, representor netdev is registered for
> >each rvu device. In implementation of representor model, one NIX HW LF
> >with multiple SQ and RQ is reserved, where each RQ and SQ of the LF are
> >mapped to a representor. A loopback channel is reserved to support
> >packet path between representors and VFs.
> >CN10K silicon supports 2 types of MACs, RPM and SDP. This patch set
> >adds representor support for both RPM and SDP MAC interfaces.
> >
> >- Patch 1: Refactors and exports the shared service functions.
> >- patch 2: Implements basic representor driver.
> >- patch 3: Add devlink support to create representor netdevs that
> >  can be used to manage VFs.
> >- patch 4: Implements basec netdev_ndo_ops.
> >- Patch 5: Installs tcam rules to route packets between representor and
> >	   VFs.
> >- patch 6: Enables fetching VF stats via representor interface
> >- Patch 7: Adds support to sync link state between representors and VFs =
.
> >- patch 8: Enables configuring VF MTU via representor netdevs.
> >- patch 9: Add representors for sdp MAC
> >
> >Command to create VF representor
> >#devlink dev eswitch set pci/0002:1c:00.0 mode switchdev VF
> >representors are created for each VF when switch mode is set switchdev
> >on representor PCI device # devlink dev eswitch set pci/0002:1c:00.0
> >mode switchdev
>=20
> I specifically asked for output of:
> devlink dev
> devlink port
>=20
> Why you ignored my requests?
>=20
Sorry, I have interrupted wrongly and sent the output as response to the pr=
evious email.=20
Will add output to the commit message in next version.=20
>=20
> ># ip link show
> >25: r0p1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode
> DEFAULT group default qlen 1000
> >    link/ether 32:0f:0f:f0:60:f1 brd ff:ff:ff:ff:ff:ff
> >26: r1p1: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode
> DEFAULT group default qlen 1000
> >    link/ether 3e:5d:9a:4d:e7:7b brd ff:ff:ff:ff:ff:ff
> >
> >-----------
> >v1-v2:
> > -Fixed build warnings.
> > -Address review comments provided by "Kalesh Anakkur Purayil".
> >
> >v2-v3:
> > - Used extack for error messages.
> > - As suggested reworked commit messages.
> > - Fixed sparse warning.
> >
> >Geetha sowjanya (9):
> >  octeontx2-pf: Refactoring RVU driver
> >  octeontx2-pf: RVU representor driver
> >  octeontx2-pf: Create representor netdev
> >  octeontx2-pf: Add basic net_device_ops
> >  octeontx2-af: Add packet path between representor and VF
> >  octeontx2-pf: Get VF stats via representor
> >  octeontx2-pf: Add support to sync link state between representor and
> >    VFs
> >  octeontx2-pf: Configure VF mtu via representor
> >  octeontx2-pf: Add representors for sdp MAC
> >
> > .../net/ethernet/marvell/octeontx2/Kconfig    |   8 +
> > .../ethernet/marvell/octeontx2/af/Makefile    |   3 +-
> > .../ethernet/marvell/octeontx2/af/common.h    |   2 +
> > .../net/ethernet/marvell/octeontx2/af/mbox.h  |  73 +++
> > .../net/ethernet/marvell/octeontx2/af/npc.h   |   1 +
> > .../net/ethernet/marvell/octeontx2/af/rvu.h   |  30 +-
> > .../marvell/octeontx2/af/rvu_debugfs.c        |  27 -
> > .../marvell/octeontx2/af/rvu_devlink.c        |   6 +
> > .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  75 ++-
> > .../marvell/octeontx2/af/rvu_npc_fs.c         |   4 +
> > .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 457 ++++++++++++++
> > .../marvell/octeontx2/af/rvu_struct.h         |  26 +
> > .../marvell/octeontx2/af/rvu_switch.c         |  20 +-
> > .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +
> > .../ethernet/marvell/octeontx2/nic/cn10k.c    |   4 +-
> > .../ethernet/marvell/octeontx2/nic/cn10k.h    |   2 +-
> > .../marvell/octeontx2/nic/otx2_common.c       |  53 +-
> > .../marvell/octeontx2/nic/otx2_common.h       |  83 ++-
> > .../marvell/octeontx2/nic/otx2_devlink.c      |  47 ++
> > .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 305 ++++++---
> > .../ethernet/marvell/octeontx2/nic/otx2_reg.h |   1 +
> > .../marvell/octeontx2/nic/otx2_txrx.c         |  35 +-
> > .../marvell/octeontx2/nic/otx2_txrx.h         |   3 +-
> > .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  18 +-
> > .../net/ethernet/marvell/octeontx2/nic/rep.c  | 596 ++++++++++++++++++
> > .../net/ethernet/marvell/octeontx2/nic/rep.h  |  51 ++
> > 26 files changed, 1707 insertions(+), 225 deletions(-) create mode
> > 100644 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> > create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> > create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.h
> >
> >--
> >2.25.1
> >
> >

