Return-Path: <linux-kernel+bounces-161045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A788B4645
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 13:59:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC439B23B4E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Apr 2024 11:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2094D5A0;
	Sat, 27 Apr 2024 11:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="h820sYkJ"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF40383B2
	for <linux-kernel@vger.kernel.org>; Sat, 27 Apr 2024 11:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714219149; cv=fail; b=MHj0leWHCvc2CARccZEta/wF68R3eVb1LY+/oFHeVegsKCPVEECynIeo5mqfFcHLVi5Wb434eGGIlz85B1cYAaOaokN/Ru+HoGrpckROw8vh7MYLWzJ+CMj6V1+6O+TuSX+zxSdQjv/KeGwCWVE/TbHfAwoT+V33awx1uGMuXBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714219149; c=relaxed/simple;
	bh=czDXexYTmmurVdkO+L4x7cWyQMBoD//2X/sBBzLutjQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Ja7H3Gl90xe8f+XcglOME+om1kwOJuwMqaLS6iJNVfJRblbJ97nlg00SzEarShrSDQBFbxdTQBYyyi1kE2BXB8DrX7FOI4JCC5+3nVYTHpD4XZb/OoKjjwckTrbhlPxIO5yOitfZ9b2EiaG3tcHKl3VLYSir7nb87AFFuikQiZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=h820sYkJ; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43RBqcEA028521;
	Sat, 27 Apr 2024 04:59:04 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xs0vfr07d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Apr 2024 04:59:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVtlRosSTbJByBeHc4pUvTWUAd5bP57t9RvIeAvDvg65NTPiG28OI8kxkrNbbdMo2IuCW9qnCvmQ1wmxT1kX+zxAmnCioupFRhVs/zBmqmiqvJy9tS5QA8teXRhNDWpl7cmxx//LPF6hI+nfGBoTye88c1bNNfNqKGpjL2Qm7ODOgzCjm0LWGyZLc5kqV6ATagKBv/LtRRhi1ZeJhIL2JSY8/HABqIH39IpIdUspJhe9+RMldcIbJz1/WyJenxFWdfIoeE8EC5I0QIj/hkW1+miJilwkNZoC19REAYA3xlQPulcbygqPDpenI6/aka3/qsd4FiTenDE17SLz8km3ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czDXexYTmmurVdkO+L4x7cWyQMBoD//2X/sBBzLutjQ=;
 b=P0F2lSekqR7AO/vd2NlXwP1esH9aX/zdEBRUbW+mTFEpxYUs5MMHgH0Q5MEa30e9jcoKc1rqi6e0eObgiv3xXUHdct8X0qRZI3kcxAH7r6aEIEJG4AtfU6VMlyw/fWm7wkGU7dIQv70J5A24wzpgTEGeEro5zyJ0KUIeZ5O7dAdVTzmi5MQxQudNrJPRWLTf11+ErcBytrsRjMdrkcABLV0WktDiIGLusADjVkfnPkqv2HWdvAfF/8+eK2OWKiDxPzSJGRwQAXGwQGLo8d13wKnbZkg6kFI/dlmwYR2QyoXDy5grulbWPmVdPgcdxLHszJf5J/+GjhGCDxhgvbwneQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czDXexYTmmurVdkO+L4x7cWyQMBoD//2X/sBBzLutjQ=;
 b=h820sYkJo1s2/ctsix0diGoXl8k1HqZPK3O9c1cXdZBI+LXAAbXq0j+b1jeoliwYpLOT+lHay5b034VDMaCancXadimCxYMg2JPTtptPTIPLTV1GhiGTUAMIv1hMpnjaAM+4Rmpml2kgicH5RB1w27a8f74+g2RV85i4oTNqxZo=
Received: from MW4PR18MB5244.namprd18.prod.outlook.com (2603:10b6:303:1e0::16)
 by CO1PR18MB4538.namprd18.prod.outlook.com (2603:10b6:303:fd::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.32; Sat, 27 Apr
 2024 11:59:01 +0000
Received: from MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::6244:4406:da13:da4d]) by MW4PR18MB5244.namprd18.prod.outlook.com
 ([fe80::6244:4406:da13:da4d%6]) with mapi id 15.20.7472.044; Sat, 27 Apr 2024
 11:59:00 +0000
From: Vamsi Krishna Attunuru <vattunuru@marvell.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: "arnd@arndb.de" <arnd@arndb.de>, Jerin Jacob <jerinj@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v6 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Topic: [EXTERNAL] Re: [PATCH v6 1/1] misc: mrvl-cn10k-dpi: add Octeon
 CN10K DPI administrative driver
Thread-Index: AQHamAZzf+IP1o80O0awgoRP3EPgOrF79emAgAANPUA=
Date: Sat, 27 Apr 2024 11:59:00 +0000
Message-ID: 
 <MW4PR18MB5244E39EEBC3689CBF086050A6152@MW4PR18MB5244.namprd18.prod.outlook.com>
References: <2024042501-stargazer-departure-e5b9@gregkh>
 <20240426182011.2156856-1-vattunuru@marvell.com>
 <2024042704-repugnant-extenuate-f775@gregkh>
In-Reply-To: <2024042704-repugnant-extenuate-f775@gregkh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR18MB5244:EE_|CO1PR18MB4538:EE_
x-ms-office365-filtering-correlation-id: 56f98f51-c8ab-4776-4bd6-08dc66b16d4d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?V89AqtTSE8H259ggrQXFomTBOpWpmIPYK9PysUCr2xToAaUko97JUfHF2BN2?=
 =?us-ascii?Q?gCA1/oGX7ez4dWv/GZmKq0dmFGtRZVes5+0UCNcMPyUF7l/HXiV3Igm3o9D8?=
 =?us-ascii?Q?Ob/BAui5lHXtGJ0TsXCRk02pmKSTFix18ieeWK2Rus8zkVlfYCAr8TOY1fLX?=
 =?us-ascii?Q?K9SQpUyxGxhv4ZyNl2YqbBRUyo0tsxlhPog1KyL2d7sDpzsL1eIJD3DAIBBJ?=
 =?us-ascii?Q?yvvMqiuhwlGgMPTzG1iub2hp3tJtviJREEFKzsOv7p+MwDon4Q9UdmGHeXLc?=
 =?us-ascii?Q?CINIM81H6CBcrlwoidmoy0LmEVm8Ibx7N1YNpT3DfDxhlzQFQJN6iDbxhZD6?=
 =?us-ascii?Q?jB+aXL4N7VdOeHLZ7339ouf8BVmb0RljdVP2ngg4TesM/LC7mxEo+qbFAypl?=
 =?us-ascii?Q?h9kNHzRqeFa9coXD4jKoTfrkqqw+7S5qiUKDCuOFI74iAZjgcVygevTIAwwi?=
 =?us-ascii?Q?wF71OTOH4ArhiNnxBxDtXiRqytyEHfgl/QGSsSK8/kGsDKcJ+g5CXT2O+3xj?=
 =?us-ascii?Q?3lrcDYp5viMZhgF1no8RSTYVv8QNNt8sXFoA2V5Vi4XaFCVy8ulmHBZ98nVv?=
 =?us-ascii?Q?9yE3uQsM0wPKuB55ZQaX+ExvQleGxcdNzadj42rvaBejm0MhJIWf9ZLkeHqf?=
 =?us-ascii?Q?Gkj4TxNX0yVRIEK7ICu+4nsj5e6ZXo0LpZDUd3y+DvW5+pdqrxtMt1IzDnFS?=
 =?us-ascii?Q?nmh/8FNnntNEqrPx/leD+RNFxz57P1AYkzu4Xf6eqkcwAhtLZGKW7cvrVwil?=
 =?us-ascii?Q?1lbJ85hhc0nt1FDIBYhBCbWIiRiURi/UwJgfRM+N+H6UUZQ06Aogwu7bJuBP?=
 =?us-ascii?Q?BMm6SGmfoOvvQOgdAx8qi//r7SluWdjTG3T+vk6pFtB2HZRCMpiifbFHw8ss?=
 =?us-ascii?Q?A7Yx06rEVZzCbI9FxIMD+yJLqUXO3VivueunLsLJx9dDdOchXOoWy7nSIckW?=
 =?us-ascii?Q?KfHizaG31GUJJ8uhDylrqOga+MquMUOVIxARuHNzoTkfEhkAQJX1+mx9AlgO?=
 =?us-ascii?Q?URQIEcwiFdFPhCe06AN71vafgmca2d0x3r0qWpU5GAQYm+y/CoM6jmhLTgbG?=
 =?us-ascii?Q?nwK0v78o1MNt1bjK4ByFm9+zk4qwJbAIWCFObn5UrNW+KIJ41elTRGdXbfE4?=
 =?us-ascii?Q?3guz9BptgQNvVs9vklu4r94QhO9WsbTo8haqLiWCFUOOwHAXryhBcsnhjjrd?=
 =?us-ascii?Q?a7he/quOhTAk5/1SeDcPzflsz8LTVj6fpd/rPrj+qNEGagUC9Y1PO63XwZtL?=
 =?us-ascii?Q?ze4mNvVqTvnxefLm0ufLk3/IxN4ry9+fFHkQ5crCwChSg7D06Qrm+HToh9dG?=
 =?us-ascii?Q?EuPBu/m7GAZIOVJlGtbhrerAsB0cOyXPXhN0dimkBi2B+w=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5244.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?zVfaYyOrvyybIbVpkYkLwKIfp4rAsSlivdyB+2OHkX16FkKHF6haRBQ48c9b?=
 =?us-ascii?Q?iSvfm+3I/fnwFex3biqzvx1Uxb7kPX5IFGRwCMjculGTLlcoBSVF61dukdHY?=
 =?us-ascii?Q?IN5z5i0QTs0OcgZVHqxFcnuF21NqYds7dy5UPGTBHd7lNpD7AqiiZXJpocDF?=
 =?us-ascii?Q?Zuxxd+040ptQHfkrtmJCLdEiPX7nD6f1J3ePsNDXsmO3RUBfSCxmFTPsvBOu?=
 =?us-ascii?Q?LvkYYwP/bclIXpr16Mixdi0C80eDLWJtGXQ7o5e+UNlVg4mA1dvcNZVKtwT4?=
 =?us-ascii?Q?GxYMZqvqMAfCY5d8oqL8Xes5JHdXvYFLgMN1bG4KHKrym43Hsmnkgz+1CKJf?=
 =?us-ascii?Q?P9JEdq+nzV4XW0WdVAAYP3UBb0o2RvoiLmMW/6YQRSXkGh9ozAcpNt3cInID?=
 =?us-ascii?Q?JFXxeww20Id+ZH38QvbcyMKazRxLgylKjkOyLcBIaaf1scqy8rPWmrFjDLuB?=
 =?us-ascii?Q?kiBWagwX8zu9sNeDiwz4OXJKa4rDPReCFqrYdp9J/9Kd4TRDsfjxszzoaew6?=
 =?us-ascii?Q?+1NeE1DPLVIMP/+rUmffTaagWr96RD4WC+PVveBwMlvxwt3jGhsa44dCjXNn?=
 =?us-ascii?Q?vppsfekICqlEYPEhZQ0dItEoXKOKy7K3OddFQtgcIAwYTLVVZrvT+/F11b5J?=
 =?us-ascii?Q?d6R8dgF//lH4NeYfJYRYBDW0DR3iaqUelusHrbYByRcfnc2mv6Cv6G3TDjkW?=
 =?us-ascii?Q?UedddQkhlpJ/13DaUawYHbSc5AePdEi2854FrrLHlm3/ywoUPc479oNAtvg+?=
 =?us-ascii?Q?1T3ayETB1bmYagYRH337VdWEqrPQ8gl18B6TeP6t3tnHYL/oAZDuLcGHERIb?=
 =?us-ascii?Q?g2fwh9F8ojmrunuveCm5TzYHZEi5rVlA0TaMge2fx8H2CT0oC4uniSyWOF7M?=
 =?us-ascii?Q?37DGfBan8C7MFMJo574YYV/qNC4RONg2qbDOaOKffmYtXllQ+JqOG4QGVP4H?=
 =?us-ascii?Q?wEBtpNrwOGzbe8lW5M2nR7SSnOOOYLWCS/XYnvgV3YnPnKXYygx+vyhVTkYu?=
 =?us-ascii?Q?fmpU95Detq52T7O+7F92DefNgMrp5OOoALt7YIzC+ZONEkfcL8nKmfxez+qE?=
 =?us-ascii?Q?iY5587pDR5HGX/k439RdUEYwU0pHy/BQ3pQ4Zi2UiCV0Nvij0PL6TbmW/CMe?=
 =?us-ascii?Q?gRTm2Ojw31jTPxfOyyGJ6+iYA5ERQ4bIdIUCKAz0qBKlij5BowIHVNISzSO3?=
 =?us-ascii?Q?xLr3TfbmI8R4Sd2EbofonneU52nCaORpCns1J6h+QeG3KXfl8dbFShbthiEJ?=
 =?us-ascii?Q?co1iAONAAB/oxbJLFh+7P4VZjUHACNKXBC6vF0KFRjlgij+TU6FzyWAo9VGc?=
 =?us-ascii?Q?CR4wAUW3sTsp78mJX7KLJix8mSC1j3md2ehhnOPmCyN33YfIeDgGcXK9eNuM?=
 =?us-ascii?Q?uRudyiqB59+zJQ/kL3s+1g6jHLD62YCEMrQoK3H7ByGwJXTtpFvAGyAX/EGL?=
 =?us-ascii?Q?iNd/zUM9TrwtMMlWBpxpjmEe8jbiSiV21nTS1r6vTeUeWU2tEDGp/1PZ2rMg?=
 =?us-ascii?Q?RevOyKvwrdI5NfawjCfXTtZlxLGCsEAV6yOiaogb4H28/Nk+5D9TusGuIYxX?=
 =?us-ascii?Q?Jy1JnvHYuk97evTaJ1zp0nIwqanCa3RjyxmGhhY2?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 56f98f51-c8ab-4776-4bd6-08dc66b16d4d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2024 11:59:00.8701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gc6BfVNwe9vRoUJVE/CGRGX021sqArtRlO5QFFy8T+BJLdEtwVuCCE8XuSllq2pv3l6wJ40Mu0L4LTsewO7faw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4538
X-Proofpoint-ORIG-GUID: gTiyMe5xVZqvId96DPa_cuKZrNaavW6q
X-Proofpoint-GUID: gTiyMe5xVZqvId96DPa_cuKZrNaavW6q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-27_09,2024-04-26_02,2023-05-22_02



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Saturday, April 27, 2024 4:37 PM
> To: Vamsi Krishna Attunuru <vattunuru@marvell.com>
> Cc: arnd@arndb.de; Jerin Jacob <jerinj@marvell.com>; linux-
> kernel@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH v6 1/1] misc: mrvl-cn10k-dpi: add Octeon
> CN10K DPI administrative driver
>=20
> Prioritize security for external emails: Confirm sender and content safet=
y
> before clicking links or opening attachments
>=20
> ----------------------------------------------------------------------
> On Fri, Apr 26, 2024 at 11:20:11AM -0700, Vamsi Attunuru wrote:
> > Adds a misc driver for Marvell CN10K DPI(DMA Engine) device's physical
> > function which initializes DPI DMA hardware's global configuration and
> > enables hardware mailbox channels between physical function (PF) and
> > it's virtual functions (VF). VF device drivers (User space drivers)
> > use this hw mailbox to communicate any required device configuration
> > on it's respective VF device. Accordingly, this DPI PF driver
> > provisions the VF device resources.
> >
> > At the hardware level, the DPI physical function (PF) acts as a
> > management interface to setup the VF device resources, VF devices are
> > only provisioned to handle or control the actual DMA Engine's data tran=
sfer
> capabilities.
> >
> > Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
> > ---
> > Changes V5 -> V6:
> > - Updated documentation
>=20
> The documentation for where to find the userspace code needs to be in the
> documentation file, not buried in a comment here in a changelog section t=
hat
> will never show up anywhere.

Sure, I will add the details in documentation file and resend. I assumed li=
ke you wanted the user space code references for the review purpose, so men=
tioned as separately.

Thanks
Vamsi
>=20
> thanks,
>=20
> greg k-h

