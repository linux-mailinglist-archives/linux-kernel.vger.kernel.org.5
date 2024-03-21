Return-Path: <linux-kernel+bounces-110501-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68133885FCF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B4F21C21483
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FB8112C522;
	Thu, 21 Mar 2024 17:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Mc+OZNQ9"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEAC56768;
	Thu, 21 Mar 2024 17:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711042441; cv=fail; b=Fl1mGt0iPqAmQSx6MC0P3fiJNX/zNTwqAvpjZMTIO2XruL25BCI7tt/5j/njgFKFkqvgpFpgEZoGFXbdnOdaqYlcLD4cIVdit9RMA/pwMzdfTduwQDvnyTFcxHKkCqo7V+rTAArTWL2M0d83WPcojHA6d+6Y06sLyhLWNrflVnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711042441; c=relaxed/simple;
	bh=ibsvdYEZqsHph1BQf1Jo6TNx7Vd5teVKYbrVAPCVYpI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V7xYrv+plpZqSWbi+AUtzxXycMekiOvMzRsdQwRBgkDfJc6JUYkSUQLotE+AwGyyksJzQjvO46/KWnnj6tjHo1+zsKcRTqJF16z0IYrCXblGBXFRgn3FDMDnjP9NDgQAfoYeayvFiik8H+x/gmRp6FETvpwbiaKcolE9MjuVpTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Mc+OZNQ9; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42LHC9El014385;
	Thu, 21 Mar 2024 10:33:43 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3x04cv4cv2-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 10:33:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oI8lytDo88HxOz4Fa8SHqSQUMt13TmiMixffmAMu9Z2ae7s3KZst5YKa+Z1vljiVc2fDmUzshTYnwb30XGvB9KsN3SaSOZAJrrtN8gf0w+CNvOdvTPc3q7Nbc9MSEBHea0ugWbiAl/XEGN4BQ0yx2ikjvQclFS+PdOKtG54I3TgkwK28NSL6Z+Y70PtDssIRqlJ8/pNGeGs7mTJYyABja8lm6OwrQgkjY0NPVEQVUZ9SR6xM7vajmFoRguXydkKDoNwVb5DLAwrJ6HXXw2dpEtfEaYCaojsmvSrcfW2NQ3hznH9/hYRsO8KKfjYLhZ1FTF3X6jO6K73A77SsMLvpfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+zk/LYWLPLqeGWB1NDuWFLqITy2WfjQUa4kCV4InuI=;
 b=jxuQT1sDsqVqDZAaJ6rX68aB/oKEuo1V8P0OqHod7H8YGehoTac5uonqCcKS1UzUJc7nFWBQsMo0PXNwE1IUD31YHa5Vsq8KtEoLi6rW9a9ATnFSaZQKdqIgZe4U3fh8qQhe8TwZ3Hoo1/FOpQFm+JyHuHbWwYb+YGxeVkQVSZe+MOfMzgtKxJam39zknT3wZzsOS0CqGkufF9T1s0aj2s3iOvf+PDLMKS+gAxBB+Fo7tXwzjB7mzGpsxTEbtfPYAwpE6Z7o7J0eNcBZPDwsBv/1Km1qTdqXHBXmhmU0bP2G5X07fsp/MD6wlqlFa02NdFFx6FlKYF1QCzd4ySmC/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+zk/LYWLPLqeGWB1NDuWFLqITy2WfjQUa4kCV4InuI=;
 b=Mc+OZNQ9s+dnZu4oRsyyGyglU88n/y1d+U60AabqqeEZV6hKh/s9BCLhIeXYwv0itBqTdFvq9lGak23gBztziZrw8M0cXWB145prJHqWyuVs755eIqX1kakFJEOZFzzR62J1BuRwr4UYmJ8DsNH/OKxnLNJjxHjVW+3rC8wj8lI=
Received: from BN9PR18MB4251.namprd18.prod.outlook.com (2603:10b6:408:11c::10)
 by CO1PR18MB4730.namprd18.prod.outlook.com (2603:10b6:303:e9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.23; Thu, 21 Mar
 2024 17:33:40 +0000
Received: from BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::7471:7657:9316:1494]) by BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::7471:7657:9316:1494%7]) with mapi id 15.20.7386.031; Thu, 21 Mar 2024
 17:33:40 +0000
From: Elad Nachman <enachman@marvell.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Taras Chornyi <taras.chornyi@plvision.eu>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
        "dkirjanov@suse.de" <dkirjanov@suse.de>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v2 0/5] Fix prestera driver fail to probe
 twice
Thread-Topic: [EXTERNAL] Re: [PATCH v2 0/5] Fix prestera driver fail to probe
 twice
Thread-Index: AQHaeurjPmANQMrOHkqJdwxY/uh+37FBVLMAgAEesYA=
Date: Thu, 21 Mar 2024 17:33:40 +0000
Message-ID: 
 <BN9PR18MB42517F8E84C8C18078E45C37DB322@BN9PR18MB4251.namprd18.prod.outlook.com>
References: <20240320172008.2989693-1-enachman@marvell.com>
 <4104387a-d7b5-4029-b822-060ef478c6e3@lunn.ch>
In-Reply-To: <4104387a-d7b5-4029-b822-060ef478c6e3@lunn.ch>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR18MB4251:EE_|CO1PR18MB4730:EE_
x-ms-office365-filtering-correlation-id: 230e22e4-f82a-4b21-5317-08dc49cd0c23
x-ld-processed: 70e1fb47-1155-421d-87fc-2e58f638b6e0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 6N0hMmtx6IhxKneuo8JxOIxpPLuF3ZztgrXt04b4TEVRgVe2ftrCnUXnRG2hvNocDaICu29CvSIQDB69wAmEHOcDKqgE3sx3AJTEto/NsVHz/ElBGEBpE2KhNFoAr5FplJsjJ2wlI2QeAVWW68nDAx4dh8Lc20md6eMn1ulXAGwoHCN3BzW26FnogJ3hIYMjkz+HqG1U/8hYxtfrPR2Pm5p88yrOHyKKlag05KvFmRItFFweEIWaxr2Sn28WEN0/DCVlLuid2h9z20CEuCO7piY4/OobgPeDxwm1Yz1Gra4jaiAjP7QnyRSHTx1lx76UX/Y5COAbtoZTGdgR3ho3MgF+yH3slJF68vTg8tg4LPI0CWCf1ZAb96o60VD+7HqqUvlVEOVvX8GOIJqZSUfhU5tT43qnvpa6le9fykuNp+tABy1tSP1KxpxuwznlO+55pzPgU2D+u6xs0Y+RNkOvEeNNRr454Zg3VV5k135hKIjeKBHalne4W8+/1pqKhdYSbkiOm0aJkSzPZGX9EDKKDppGY+1d9K4PLQ/Ag9+ZShUljM5c00THpvSlkk2/yabROkuTzyMLKENjHMx2sFzM6sVXNFXAlT4rGIMuV/yZ4rSSTQDGMneHynSf1jq+TZ0UTK9vpwgAF+ZFAxXZCByGvh/xZEura6pBjPT1JBCzMpyoGC2Phwft75yn72VvoA7iWh6UN6ayyP4OQCKM1sOVwDlhRTORPzNZfqJi0PZxixA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR18MB4251.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?y2r91s3cvzRLsqfR03qeCPa6iyQpNHPqCBJvzPleSPrlydnHb40K05s+uo7X?=
 =?us-ascii?Q?+Odv2kiVHceZflI/dmtLiBTOlZdYdsAXWXXzF/v7vwGkNFw0t2995k8vb9mg?=
 =?us-ascii?Q?4VgBiLFefkMhnUN2xVf7f9coUR32GvvwqS4kGGSQneUHU+N+13ilqR/uhTW/?=
 =?us-ascii?Q?Er4f532yAjHl/Oab4uYWoYyRmYsZ+0BI6V5oilX5f2wyUEucl6UknZkzraSF?=
 =?us-ascii?Q?3CkXGr+82wzNGeZ2Mk1QpKMLzzT12sRJLMgCum6C8QsDGEoqhNzeDIkLk5NV?=
 =?us-ascii?Q?HMCzCpaN5paa43fu/J42Z7T2TiRCikj8H9ObsWgVRVEich9Rln1U9UZQjlDu?=
 =?us-ascii?Q?nTIjQN1pW+Dtpv2a3mitRSszUfWg1AqZMALshSCu3p87bUduXrEn2qZ6Ax0M?=
 =?us-ascii?Q?hVkESeH3/oi9wKrYwZBlMRkYwj4Ja7WBnQ5WX4pyUI2CBAnxzpqbdStOtcn7?=
 =?us-ascii?Q?x1m/2I5fa83/JJtyx37wNTH946FYHAbWCJARCndy57Etm8Ik0AawWnHX5K1D?=
 =?us-ascii?Q?FUDSvxdPptq4E9sIxxAlx77SL7HnjrNTH0JpseS2yXBikEPsdoeICMgWDXdZ?=
 =?us-ascii?Q?xd1o6/9byykr8YxCUOvoAxs3F7k0rk2cUCAooI9uDsuH5mW86HNj3MvXRZnJ?=
 =?us-ascii?Q?yXghdT6lcGAePFET1ojg1oH99BjXELNhyHlxAg1rdCyZbAVFg87bJRIX6NjE?=
 =?us-ascii?Q?FJ++tt/4vlCgRRTp2TTmZN75bodqk0RH0hA9su7Lb3Jizbq/akY+ub1eZusX?=
 =?us-ascii?Q?hR0/FE2qbAwJz9cH0Gc5b77pIXyWhRyQKP+wo+e+hXTeFzBIEbP5CbvBy+La?=
 =?us-ascii?Q?CbcbFVVgcY03Vg7ssRzPwh9h+h5S/UpJjbb8JJmHR061WaynZTW8tRnkleCQ?=
 =?us-ascii?Q?HXHuysVCVvZGB6K/LNQkRy1/AECQFKFqMYS+yJlNzLm9tTJ8M2Ksvhol946Q?=
 =?us-ascii?Q?vbflMoGq5vLsJnHhdo1lt7TnBpgywlnQnUdfpV6iMK2nJdj9wNLYjC+sasRU?=
 =?us-ascii?Q?KWzXsMbfBuA7GU6ecN9sRl1Bg8vmieHVouGUGjT6EkM7WjwXwCrpwOnZZkq5?=
 =?us-ascii?Q?eEiM5WPXD6Xg8mVUqn5HiQwMzYpQuv8Pn5EftZSQW6WJa8OUz/IBJ2dToyEw?=
 =?us-ascii?Q?9ls2na8iDVCARg9PZXOzQmLOqd1Wph/nXykR21qPfgEvXg3N8lyN1A/nWiUA?=
 =?us-ascii?Q?Dmbf2PePQE81EsDz2knp00rRQ1SKMFr/YFo3GkxLHtDEWe3fyNMTS9wDUhKf?=
 =?us-ascii?Q?98YcgruCvrIyK0eN4246wfj4G2QvTc3BoD44S+xmxGKa81dL95IBEPGuBFqH?=
 =?us-ascii?Q?nGFFi9FywiDyBvtjAE39amEjzk/SS4n/GAoNnOitLcS5PMoFRNm1zfF2i5la?=
 =?us-ascii?Q?KBq01/kKhqZtD+SpAWRm1hcHfG748uHisu1vD+3xp+gyxnOFMbaSuXCv84rS?=
 =?us-ascii?Q?5j6qSBR1sQWSCOl5/vYMkm7Di1W1zxxy2mgxeIQv5wMDujyPEavvBC8VBiv0?=
 =?us-ascii?Q?q9PMytSQAh+MbmsRIwMRwsvZInNffnGO9oIgP2dLgT2I/AsMHjOvQoQyon7J?=
 =?us-ascii?Q?cUbsByuV0Um3qSnwnh5tJ0A6Rb1rKUjwWmcsEK5j?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN9PR18MB4251.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 230e22e4-f82a-4b21-5317-08dc49cd0c23
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Mar 2024 17:33:40.0280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H9JcGwTTuXCDObXYDpmWP5aWKaiKMzTtvAp5a29wSZ/9Zi2VeQajt9yjcHk8eJ/VmktZaoVxlNspxvk4vjMBMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR18MB4730
X-Proofpoint-GUID: 6LlCd1BncpSu-zxjLPEdtkctNRdXaowk
X-Proofpoint-ORIG-GUID: 6LlCd1BncpSu-zxjLPEdtkctNRdXaowk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_10,2024-03-21_01,2023-05-22_02



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Thursday, March 21, 2024 2:18 AM
> To: Elad Nachman <enachman@marvell.com>
> Cc: Taras Chornyi <taras.chornyi@plvision.eu>; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> kory.maincent@bootlin.com; thomas.petazzoni@bootlin.com;
> miquel.raynal@bootlin.com; przemyslaw.kitszel@intel.com;
> dkirjanov@suse.de; netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [EXTERNAL] Re: [PATCH v2 0/5] Fix prestera driver fail to probe =
twice
>=20
> Prioritize security for external emails: Confirm sender and content safet=
y
> before clicking links or opening attachments
>=20
> ----------------------------------------------------------------------
> On Wed, Mar 20, 2024 at 07:20:03PM +0200, Elad Nachman wrote:
> > From: Elad Nachman <enachman@marvell.com>
> >
> > Fix issues resulting from insmod, rmmod and insmod of the prestera
> > driver:
> >
> > 1. Call of firmware switch HW reset was missing, and is required
> >    in order to make the firmware loader shift to the correct state
> >    needed for loading the next firmware.
> > 2. Time-out for waiting for firmware loader to be ready was too small.
> > 3. memory referencing after freeing
> > 4. MAC addresses wrapping
> > 5. Missing SFP unbind (phylink release) of a port during the port relea=
se.
>=20
> I don't see any problems with 3-5. Maybe post them independent of the fir=
st
> 2 and they can be merged.
>=20
> Are you really saying it is impossible to determine if the hardware is in=
 the
> boot loader waiting for firmware, or is running the firmware?
>=20
>    Andrew

Originally, the pain point for Kory was the rmmod + insmod re-probing failu=
re,
Which is only fixed by the first two commits, so I see little point in subm=
itting 3-5 alone,
Without fixing Kory's problem.

The problem is not with the hardware, but with the existing firmware code o=
n the
Firmware cpu, most probably secure-boot protected, which lacks the ABIs to =
report to
The kernel what is loaded, what version, what state, etc.

I agree that with better original design, we could have made a better work =
of avoiding
This lengthy reload, but at this point, I believe my options are quite limi=
ted here, unfortunately.

Elad.

