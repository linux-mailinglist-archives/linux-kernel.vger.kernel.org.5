Return-Path: <linux-kernel+bounces-155522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8672B8AF381
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 18:09:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD61D1C21C2B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 16:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAECB13CF83;
	Tue, 23 Apr 2024 16:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Vq9EsyMx"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B96D13C66C;
	Tue, 23 Apr 2024 16:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713888555; cv=fail; b=n+buDhbNAryFKGD2+rN60YfiU7+tZGjTPsaDzPL49TNgXETaXGe5Nmh74aKr16fiLTb06CeiFfvCrwglpwzrqSo8E3iX3rzh2VZFAMkSjC34RamEDZLmxKy4OABHsptFURO9TIKp1qgYGfewAdfguY3vtucxknuyUTf2iVDAIrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713888555; c=relaxed/simple;
	bh=1f6Hw/+RkH9QRRKicjtROKEcU/H3c5/zqsvW9Zntf+U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bd/Fxjr6rL8g7qZmh752Rs1xOFn5gCBPkW/pifhEMbMI0VWjG0SJEVj5PCygc1E8UxMXIC7b6NWfWaQXTo9lApy/H1GVOz7sTofjS8F8rh+bDZRLFtfcVDnr2HeEdZBodvsI3R4mLpT27jHm2vqv7ChtpFuudFPldQP7F4XCmhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Vq9EsyMx; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N5buqL016956;
	Tue, 23 Apr 2024 09:09:05 -0700
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2041.outbound.protection.outlook.com [104.47.57.41])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xmd7ghspp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 09:09:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TF0JQgdw/1okolosuatc8qOv2izvdOKCYB3NpnyKi2pJOHEItEKnw8epfoQr82vJy20LTkZPhDqi8Z8BbiAoztJ9MBtR+uU/76nPoI31HQHJRhzsGTewjWUBCsM7fK4zq8k6BgEQ6sbdk+P5YzvlQkwHtldJcT2SJRtDaXgJzHHsf8Si4/3V/XM6Y+AcSSAJTjlTQCKd/jsozr7pRHlH0/vtuJeRqRuJhf7bKDg1YsKFFn9+yCO+xqrarky6qcZfpkLDU0b0iV4JCjcQoQQVO2NR/h2ozHBYY3ZYbCZE50g4ONj2rfw09fVDhfIS16YhD03mPACIr0ML/eSlMbpyng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9UEMsrCCKBIOs9bfmsswbTa3Ijf/uu7wy9CH+8hmVk=;
 b=YW396x4ej4ajfQOcLWuZDkhvTCPuL7vf7gTcGBsnGcwzGqAMThtQ5x9UIRWmie31V/9yYTL0Lx32awN5NLI5zi9zWYgYTmQK/AidAmoiXidZbKjeF80/RXZnX2ViBqbmbCp8U1UJKpanq0SLl7o/5ZuE0NB5HF9W/mlL7xSNzfcQ6BhmyFPmIYxrlfB6C1zR7TvLquc3nx3BfugJb+pLE1+T5lR5i5Se85bHC5L2nX1K79IL/uY+/sEaHiu3dvx7X7h3y1a63t427wgFkQmxHMFis9FdHq5hZZQdzKnhQFT2u2zs9jC3zXXc0CcUnLYLl9DuuAz1mt+yFEvbAL/3Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9UEMsrCCKBIOs9bfmsswbTa3Ijf/uu7wy9CH+8hmVk=;
 b=Vq9EsyMxPCxClLhDieRRsWLp21kMKaXg7UMbfZgyIxMQ7sEiDcn3FPwl8F0CRiDpoG8OT4yfcc1lDanTQkgSgWfe0/nngfCvK4ImrEqkdes3JO7WcXguHkd7rJbqD5TGR+9L/Zy/J6ARcaoUqWCMuzQJUcN14zSbp/xiQHMq9l0=
Received: from BL1PR18MB4342.namprd18.prod.outlook.com (2603:10b6:208:31e::16)
 by SJ0PR18MB4479.namprd18.prod.outlook.com (2603:10b6:a03:37f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 16:09:03 +0000
Received: from BL1PR18MB4342.namprd18.prod.outlook.com
 ([fe80::9e3c:b30b:67cf:1d16]) by BL1PR18MB4342.namprd18.prod.outlook.com
 ([fe80::9e3c:b30b:67cf:1d16%5]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 16:09:02 +0000
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
Subject: RE: [EXTERNAL] Re: [net-next PATCH v2 7/9] octeontx2-pf: Add support
 to sync link state between representor and VFs
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v2 7/9] octeontx2-pf: Add support
 to sync link state between representor and VFs
Thread-Index: AQHalJsVB1fMpBcrLE6y6oPYaOQD67F11OkAgAAswtA=
Date: Tue, 23 Apr 2024 16:09:02 +0000
Message-ID: 
 <BL1PR18MB43427F05CB1F5D153DD54907CD112@BL1PR18MB4342.namprd18.prod.outlook.com>
References: <20240422095401.14245-1-gakula@marvell.com>
 <20240422095401.14245-8-gakula@marvell.com> <ZieyWKC7ReztKRWF@nanopsycho>
In-Reply-To: <ZieyWKC7ReztKRWF@nanopsycho>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR18MB4342:EE_|SJ0PR18MB4479:EE_
x-ms-office365-filtering-correlation-id: 178d2027-7259-4e95-ac1b-08dc63afb18a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?8lPMnMn7mtzq2tvRuIBNopaJ74qW+uzjOmoZgF1OdGVD/L9Sq76mLqfj3NBF?=
 =?us-ascii?Q?NT60l8PueklfnxERx9gsN8kp3V+SLObzBatfGj1VFv4LmPNBKJiN48PtokGD?=
 =?us-ascii?Q?YMGFar0HSb3VVa121MoPpFH5gVFI14SNK0QgTcjgRAn845DGctADz9grgkzj?=
 =?us-ascii?Q?zzDLbvu4S8ggaoDeKoemvH2zCDmKhgFT/LfeihHQlk9WNKLnFB974fGAbJKx?=
 =?us-ascii?Q?UlOSx0OISrIVkr1EMYBHq/hBIyVtdz1oBkXBGo5Urws2A80PhcFmExk353jP?=
 =?us-ascii?Q?Zr2FwUGQmUrfx08o4WnL2rBwZnlJd+VRHrGl0tZQv+IkVVl0Q6/sKXxTGbf1?=
 =?us-ascii?Q?Zo1k1kKdCn3asx2s6CBVXYkmhK/vu2oOupH3k4azmnKv/lUsKlg1yBrH0U9e?=
 =?us-ascii?Q?LsKJu7zFMv6/wPqRIB+mxEKD04+499ytFrP/UjMvAcOmnmG+zC6mVZjCS7Yt?=
 =?us-ascii?Q?mC1j3B31VYCAwlmdcoEgGGLBf6tqDXHIrRlgYJVNRvtlkdSP6iV+e6L61xhm?=
 =?us-ascii?Q?MRexqOvMe5E5cSXjN0S+ej0o7I4lSkqgaz6OGNivaSmSycQZxMmKhGCtOcIi?=
 =?us-ascii?Q?ohn1HI4zh0W85iTFjxeh2qeKX+h4WUybK1Aku4tChVq57BpYmoPdAl5JxbWi?=
 =?us-ascii?Q?joYCTMvMMrQ85Qo3tP0CGaCoYoLYiaa9YYUGNqIgpbPl4POt68YFsic1jKRx?=
 =?us-ascii?Q?5zdN8eV3pKhnzs8ggSGIk87xgC0qSMftYQXypnpoAwlXLnTmuQBovf+Shrs0?=
 =?us-ascii?Q?IxhXfaRVlbIZiTmnWQ84W1y4fY8HNUJqARufrDQlsGD9hOOezSpwUpHtlRoz?=
 =?us-ascii?Q?KgFJMhARHAnOCC60Q2iFSQ1209aQcsM5BhxLV1Dsr8UIdvrFqywllIEd3tWA?=
 =?us-ascii?Q?12HaS9kTvr0WxKyTyxMcjUFX26zYFYfTgkQG8V2sn24l6E5V234HP1LAFxJH?=
 =?us-ascii?Q?QDhJbRe/wbuNPViUMJz1r8qfgrITwnd7o0nbZtJ6e0om7C5Pgvj9gdTx/1Cf?=
 =?us-ascii?Q?2JqwAjixKckMVsvvrQRwOB3oTzT3MspfyfTGJ0EQMg5BU//ezOnUMwAklTo/?=
 =?us-ascii?Q?875DGNGFSpeQ5gd9xP3Th0keRR9cRh8a/o+vxos359uLEWwC8ppBcOGPw0JZ?=
 =?us-ascii?Q?YCDa835Tu6f85pQJA4Rq+azh+T9Bc33gTkkLw5VcHCh5ZgVL4se2Kf+7jWh6?=
 =?us-ascii?Q?iaBPbzFMG3DBWty979D8y/kiDfgMATKf0wktnsNc3540X3NYDvTQYiae1z10?=
 =?us-ascii?Q?bLEtsbZc0qroW+7GLCmIVFAlD3KiJcazGp9duCro4nVQFBhiIdIis5oHxe3B?=
 =?us-ascii?Q?onE3CNxYWfiW9H5ymupNPVwHzvsRDDEhlAtAhkfH03zThg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR18MB4342.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?18cRytvj9oLQslyFKLgXC+ZIDvJ/47QGOjwPGi+BtJc17MDNRWXPyUl2alys?=
 =?us-ascii?Q?I/toP83rLumGOzR5LRSKmq5tABZOXQw4S7HFaz2BtYBPnKqi1+/qPy27hVBJ?=
 =?us-ascii?Q?TwuoW5Ly0VHpIEVZguj+ANQUyxVzcL1Mno4jvFwDg6GTV2/MXaFmXoWSJ9HH?=
 =?us-ascii?Q?59G7tGxR1QLBsAMkry0X/0vLHxjt4MyqUvfZb9doLs5zriZeEeCXLU2GkKR9?=
 =?us-ascii?Q?yNb24xld+qZpNxvD+tzR1CuFvI4DmZDNqLSzw0kiiMIk1VONUTxssi05RR5U?=
 =?us-ascii?Q?HSUjYU8sCSc5EV/xLDu8Hl9AkY8Erv0Jqgu6gSAOod5LaRVT3JMYRDYUeNBM?=
 =?us-ascii?Q?xbd88VBeRUYQh4HPO+MgymRFzr34G8gp0ghO1NFGI2NpIsa5oHYc7UerFuni?=
 =?us-ascii?Q?u24DYXL/P63zJA72ewDDYcV9VRN3QttBURapLqcKfruRlvSTvA8jIb/xmh8L?=
 =?us-ascii?Q?bXkX3ORT9Q6dluaznzCw2vf8ntc7LLVWxYsQv8Bl3kFKZHQAkh/BLwK7WRJ6?=
 =?us-ascii?Q?AfJlUKPeI6OZ7BbuEepjailalGQqzQhrgNA4N6EXAH7Vd/tvDyXRnf7S3ACD?=
 =?us-ascii?Q?gXYxLfpmLhJlKKZWU7LgVQaoKl+n58uGx8zVADkkcQHvNYghnTpAVEWV/r5M?=
 =?us-ascii?Q?mBA0FXXYaviGca41Fe8dsPx3YP1WcjgXtH6xeCMsCogeWOewOHhw3EN6XVlg?=
 =?us-ascii?Q?NaYdaInpMGtfHToaTryA0fe7nPtz/gBCfUy6QoTwQvSCPukdaYdoYg1yBAel?=
 =?us-ascii?Q?mMGSUt7tZ1lyh4C2csNCtn5U7JNlli5Njyf5M2FkxCSY5kP3eo2QBrTozn5N?=
 =?us-ascii?Q?5CzPUffaepR7DEJXCwcnjRYw22xoXuwln6GqXYz1FwQwqel/tDywKI50eBfT?=
 =?us-ascii?Q?faY/AE7TAXcAS6Z4SqKYSEa8fXYz20sp0QcqO8UBSqCVGIsGLxSF4KX/+E1V?=
 =?us-ascii?Q?dcGUeXgj5u1x4TVm7uAWIyVodjnXpbFHDv2bWrc3o0ySZgYzaZDLlp1hUFOt?=
 =?us-ascii?Q?a6gFklY8sLqOeASK9uJaQSg7QaDdkaiqqPTaNJWCn5z0v6KLHCkwbzNvVeaG?=
 =?us-ascii?Q?SzowUEl+Va/fzYNQ8hvfE/m5ddvXY8PQtdi+WBekGGaKJ9fHdi8KNQyGXJj8?=
 =?us-ascii?Q?dkSBIZViot8XBLibE9bnWf7ll4QWYHZXLqexZtAYM/lYs8BGD+4ldqjTFkGF?=
 =?us-ascii?Q?UOor3O0NP74ArqZqSodUkipwkPDb9ALqqhDmQhwKWvXr1UGs7kvktLkdB/6u?=
 =?us-ascii?Q?mKM96SDCftjRyuaeFW08eBe1jsa/PXsxJ1uABgECsZCSrqvjTNOR37yPkalw?=
 =?us-ascii?Q?7I4E83n2pqLPiJWPaxE2DpoOPBZ+KgAxvbacBc+MuKApVPpfPWOmkDfYbOOr?=
 =?us-ascii?Q?NUgAuksPO0B9lBjqG7PINWXg/I92Ab1BsdKfqlEreG6HwAkIBlZEefPvJmac?=
 =?us-ascii?Q?0bPr1t7/UMgHnWczzL9i8RdM9+NWitdNRhhgURwyKuIDC3WI64AJEzb56N73?=
 =?us-ascii?Q?uDSot9HqOr4j7fGZTRtNHvD8P6LgUkxoGc8MHm+uxfNgMh8iOLvoZWnWGPaL?=
 =?us-ascii?Q?9rg1E0UVHsNr7Wj618s=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BL1PR18MB4342.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 178d2027-7259-4e95-ac1b-08dc63afb18a
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 16:09:02.8346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g5wo8GbsiglhUfPCXAOybRGGBGrUVxakQF7LavbrXIBxH81FBlHvzH0Tc9YSymYfBn69NaAK5dof6QRb+Ss5RQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR18MB4479
X-Proofpoint-ORIG-GUID: cdWd-Eq4HqPb5ZuOrX6RcHjOA7m4O2Xb
X-Proofpoint-GUID: cdWd-Eq4HqPb5ZuOrX6RcHjOA7m4O2Xb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_13,2024-04-23_02,2023-05-22_02



> -----Original Message-----
> From: Jiri Pirko <jiri@resnulli.us>
> Sent: Tuesday, April 23, 2024 6:37 PM
> To: Geethasowjanya Akula <gakula@marvell.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org=
;
> davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
> Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
> Subject: [EXTERNAL] Re: [net-next PATCH v2 7/9] octeontx2-pf: Add support=
 to
> sync link state between representor and VFs
>=20
> Prioritize security for external emails: Confirm sender and content safet=
y
> before clicking links or opening attachments
>=20
> ----------------------------------------------------------------------
> Mon, Apr 22, 2024 at 11:53:59AM CEST, gakula@marvell.com wrote:
> >Implements mbox function to sync the link state between VFs and its
> >representors. Same mbox is use to notify other updates like mtu etc.
> >
> >This patch enables
> >- Reflecting the link state of representor based on the VF state and
> >link state of VF based on representor.
>=20
> Could you please elaborate a bit more how exactly this behaves? Examples
> would help.
>=20
We patch implement the below requirement mentioned the representors documen=
tation.
Eg: ip link set r0p1 up/down  will disable carrier on/off of the correspond=
ing representee(eth0) interface.


"
The representee's link state is controlled through the representor. Setting=
 the representor administratively UP or DOWN should cause carrier ON or OFF=
 at the representee.
"

>=20
> >- On VF interface up/down a notification is sent via mbox to
> >representor
> >  to update the link state.
> >- On representor interafce up/down will cause the link state update of V=
F.
> >

