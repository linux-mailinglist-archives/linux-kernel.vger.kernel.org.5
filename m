Return-Path: <linux-kernel+bounces-121698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AC088ECA1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 18:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97232B236D3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 17:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD48814D704;
	Wed, 27 Mar 2024 17:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Ztkricb4"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E6BF4E2;
	Wed, 27 Mar 2024 17:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711560480; cv=fail; b=bvVCxL4twD7mO5zkk+euysvRmRQV9VNhQI7LsCyhplk8XXTOrwT1Yt9767be78g8KXZPYZnk6ndgiTktxNbJPzCX5wz8BarpXLbJwSbxXzxwtF/2ZilIwcP0N9vVCSI6Kn9Kwav5MlVBUIxBjVg8217NxNwoGu4gTcfR4i9oAcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711560480; c=relaxed/simple;
	bh=6+6x+HKT+owSnqmkNoOtElCcVIQqNYvalo2eiQlplog=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UZBR07A/Y7h0j9OVQ8K0TQbUxrVfYod7heeZa8PIIgZEwzVdJ2pFCSIlwI/2RThoLp+82aPWAfS7AMrIl2S6ZNq8H7/dprxHsXY/DRZ+0bDhTGsvOA5ChIx4LvC5M9mtOoJ0nGao8yio4mmhrvDKq51z4veB4WxyWNhmqKvWgLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Ztkricb4; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42RALgAr002468;
	Wed, 27 Mar 2024 10:27:44 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3x4hmp9v80-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 27 Mar 2024 10:27:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMSGsyJt8yI8f18ZlCWotZzzcLfcxZMvisTPChjG30zC5x5TcZ+oFo6DeRkvEN5S+85p4iORYpniB3EqlMNKiCZxDZt55MC1BVzS0F47wAOqI49xGCiIFP/FRVMxovw5T0dK8d7qmMlPH4Bnr/mhM9pbs+We2Lla73X+itUfCzudj4xsrMoUpxq1k0h8/Hf9KrYRStTPiG5qoLlKtDBWLiMbTdDwtsOhKPAMG40Q9+4AY1GbZGE/490OjQB8CqrQkx2t4is+qpTG7jPFg/Bg7hNE0cpIi0t7zhFRR7P/2bwMpKXLArnW/PE+sLel4sQPUQFX7NMJuHOSPkkYpynuRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pW0RW5iO2UyYJ6B4rJAgFKPTWFoiS9673Y0ovxBjbx8=;
 b=cbh15CDWj8bGoH/0ysqLPb3k+jTWeVGwKLE+ANKXLMaNFD0WPULWJjTft33OvkH2GMIgErKt5wXmpUl/r/uf+Gbiz3Z1tuAgXxsr8wYwcl9FTnocBvL7pmfRKlEEMX0u0H0tSU75l1deqXEmnkFXKFn3h1PTFSEQ/jrsvkcCpGJ8s0+sYC35JmBDhcHlqjeOFWtrS3S1TTzvlEqvJAMjP3BmIrguVmlbexapaz+rjVLaBRGddgSb2YHhkwaVObsD3mXW1dcJa7ANi74v0s0UV0Qx9q2oY5XdSWDPDYfUBKUxPSneszcXIs7PaEeGz96gKjJgP3mjkN3t6Nq4X2UjUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pW0RW5iO2UyYJ6B4rJAgFKPTWFoiS9673Y0ovxBjbx8=;
 b=Ztkricb4aerxZa+EVavtCA5x3yswSEdgaRVGZlEa5j98vgYuPjX/54ZVvql8UMfUzvKsPSENOiQh5R7HIckIJX9dYpPqodEzc+EXrcuAkPVETSkqrcK2soZJMkWWSmGp8bz9Ou5n/QDxSrtmjmMJK60XFSXv0Se27Xt2edDRXcQ=
Received: from BN9PR18MB4251.namprd18.prod.outlook.com (2603:10b6:408:11c::10)
 by LV8PR18MB5855.namprd18.prod.outlook.com (2603:10b6:408:223::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 17:27:41 +0000
Received: from BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::7471:7657:9316:1494]) by BN9PR18MB4251.namprd18.prod.outlook.com
 ([fe80::7471:7657:9316:1494%7]) with mapi id 15.20.7409.031; Wed, 27 Mar 2024
 17:27:41 +0000
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
Thread-Index: 
 AQHaeurjPmANQMrOHkqJdwxY/uh+37FBVLMAgAEesYCAACDkgIAD853QgACBRQCABNdBkA==
Date: Wed, 27 Mar 2024 17:27:41 +0000
Message-ID: 
 <BN9PR18MB4251B1533E14523AEADBA22FDB342@BN9PR18MB4251.namprd18.prod.outlook.com>
References: <20240320172008.2989693-1-enachman@marvell.com>
 <4104387a-d7b5-4029-b822-060ef478c6e3@lunn.ch>
 <BN9PR18MB42517F8E84C8C18078E45C37DB322@BN9PR18MB4251.namprd18.prod.outlook.com>
 <89a01616-57c2-4338-b469-695bdc731dee@lunn.ch>
 <BL1PR18MB42488523A5E05291EA57D0AEDB372@BL1PR18MB4248.namprd18.prod.outlook.com>
 <6dae31dc-8c4f-4b8d-80e4-120619119326@lunn.ch>
In-Reply-To: <6dae31dc-8c4f-4b8d-80e4-120619119326@lunn.ch>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR18MB4251:EE_|LV8PR18MB5855:EE_
x-ms-office365-filtering-correlation-id: d9ef1118-f7f7-4e7d-d231-08dc4e8334e4
x-ld-processed: 70e1fb47-1155-421d-87fc-2e58f638b6e0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 0+VgTA6HTr8JI4SqdoC1Xldqoso4ItdkVL8AUV4N31kdkQaT1fFVpo1aQ8aauj0VmNqCMGDV358MDqWhoIuOOR3x/rMTRMAMOkRcXptJtSmI0Wje5OVzfQLWGIH8IwbagSsTULRpAuDGk4EH/3X3KE431n1Lxgo+Q0hc+IKfq8D39iruWW1vAZPyM9gHUU0bX4LU/TOHqMlDXAPthCXhD3+KKbqC10185ku77NRuHEIAL/BkrtvHJyIGe39HVMI1PrR5+ACxXs/quTz3mpM8sLZnORtx8IxVItuhCFhUtc5SqrkL+cPO/vaE8WqlPUZBig6I+V76TGOj+4lStRRf52bqFsQKTUlclPTHCWaYFfkI/k6obdQtLcyI6Rzb3QrWc95PNYlucikTq8axMda8hvY2Kn/nXIOX+a/R/K2c7yI2gqSrAIccbrqHUIbUEV0eYIcbCC7Hin/L8GmkUKZPBCysd5XFtTPnocd0vKR7kEzVa5pULIFOSu/tYrUAaMxs5aM794Ch4qZwoulOynCNRGsCSrMSqdp5FfjsPEP8V7gJ00qpSYliZNmwFj63pP2/aqgeUTM5OM07rUfLySFdhtXlEE2xjYvI7pa50+nCDvQd1urEqGID8MK6uDJLUTShZ86yd8iYHO4dHNI3/gZJ9kdmJAHSrznTLXVszmdU8qA=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR18MB4251.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?iso-8859-1?Q?WqZMR/EGSQAGVGQiEq5CK+owlfJpS53FzQ3k+7osQC4r4myaRJ9PNthzIQ?=
 =?iso-8859-1?Q?I+A44+K1BM1otABHHKv9s95+e2HSFQT5TPfo8DxWgzH87R2l3mF57tF1VF?=
 =?iso-8859-1?Q?XBk2NAM8jCI6fM6XSTse3Izg2nQhJXv91jRsz0NcfPME+o1+tS1oDPNOp4?=
 =?iso-8859-1?Q?ECyeHbinOT1PQHxWbx1r08PmV02nFYUcueDVlljB+coTIgNONUajp7Nkr1?=
 =?iso-8859-1?Q?JxnvCIoeMRkNY0FEOPxqAWBn3t/WJ28dqLt12BRKy1EYognE6oMwRgJwvt?=
 =?iso-8859-1?Q?hOF7UBNJviYNEU5/rJ0kZElXn5K+XYj/M9Stie0oo4AN7ZDXBspacnGqi+?=
 =?iso-8859-1?Q?SCrOwPTzHgH7JQhvG11heXSHj/vcAQlNJorF+w3OJg6UP9llFNwuLwxy5Z?=
 =?iso-8859-1?Q?wFhOkczCEzEWbsqBDhTCEwq8edCLdavepIksD8ZvwZZYuCVZJJjCc/1tiy?=
 =?iso-8859-1?Q?Yt9cbx5UZzVnkMCfThbsViUzdalccMhzgbT+b5fX0AJPAC4PC4/n46eKKV?=
 =?iso-8859-1?Q?yWXTInSfzroHfLew6WnSV8x6PuskYzmVxhob+tQxlaA3ABMwH0pDCmJtCM?=
 =?iso-8859-1?Q?eP3Zn/6bQ944KGENGi5RQg5PyKgPJ7UfMolHlwsNaeyEPsc5uImrCAMEKN?=
 =?iso-8859-1?Q?tg5R+9dtJXqsj4jPSscIrntGbDMAjZXHcz06f9EOj4kIZgmxo05UPaYZ5h?=
 =?iso-8859-1?Q?eY8LgL4obDy7swcD2v9h58NGmAMunLN8K0gBQzvCjA1r2M9ihB0TUiJDYm?=
 =?iso-8859-1?Q?ZcYTswdqqi9716JjzJnxEKWng5a5jQdhWdsQzIwkyAZOMQuWS+Mf35ouq+?=
 =?iso-8859-1?Q?MsdAL7IS95StPko+hjPc/WfKvvDtEZWS5qjj+vsuDCNaav4OvQ7/vBHAEj?=
 =?iso-8859-1?Q?9D8lG08jIfU4L+Anu7UCB1Icnffy1j55laNfwXAtR6Tod7LYH98UAZtrRU?=
 =?iso-8859-1?Q?B4wN/7//bAGd9Vidu4+4t3gAu2RX99nVwKzeFHaeY5EbS2dE2eG1Vf27ff?=
 =?iso-8859-1?Q?JqovnEnR7w5hK/OAi4hhHfCwY4BGPivmUa6kt9mShu+eO1Hn+vOefRnpyJ?=
 =?iso-8859-1?Q?tP+vfZnnPGHTXxr9D++Y037XLNEeYwXxF2+6Ma7J/hUfeaQMPHInOCDmEp?=
 =?iso-8859-1?Q?MfKA6zzoNOfOJIG7mrbkH2VF21fDb2HPVUt2Q4AOammXbj5/0Gz/455FfM?=
 =?iso-8859-1?Q?TrYaopZ/cWUHLKY+7UkR7MYNwW1Wj0OMQHzzKaOngfUuNKthZBUqjVCkHs?=
 =?iso-8859-1?Q?msD2sbJs0dkbj9cv7g6Heb+KeS/rZq8g1tpiToNltBEASA7l0wH8hYb/lB?=
 =?iso-8859-1?Q?p8z1Vol/DcNWSsVFfluy8WXDQyvmp8nyqp/ejmvFyvdpHY/9b37hdhDWVs?=
 =?iso-8859-1?Q?LMwlR/97HlJCjnQgMIzhvbchJscAKAae+H2M1TbLKOVjZHnK9jerAZ+RD9?=
 =?iso-8859-1?Q?V/GZ0rY7kOFvJ+ygJXLn5v56orwpm4bgF8I76rOq8Ota2Pqp2VriCH0/yO?=
 =?iso-8859-1?Q?owF+nIUPq2W6Tm70mvg67ADZh3kjaqE/ek0tJh7uBdPEhB/H+J5znhLwHL?=
 =?iso-8859-1?Q?qwKw9AfSdKuOgIf2Ek2XkfiomWgGMIkjS5D4NOPa3OTMXj8i4g7af6qgyt?=
 =?iso-8859-1?Q?nzWxyyDyupsZYZHghY/kSMrV5BX/ASU9ib?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ef1118-f7f7-4e7d-d231-08dc4e8334e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 17:27:41.4290
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5y1vIH08GKNEx2mQUHUbymchkGS4B+uIGg5e9qXSrnzdIc2YPEyJZMGpdxkAx1nivCHRcd3UG9cFd+2QeVkW4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB5855
X-Proofpoint-ORIG-GUID: MX057xmhy6dEYHOlHIXAtskouQcmLRKL
X-Proofpoint-GUID: MX057xmhy6dEYHOlHIXAtskouQcmLRKL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-27_14,2024-03-27_01,2023-05-22_02

Hi Andrew,

We have made internal technical review of the issues you have raised (retur=
n version API, try to get version API before starting to initialize and loa=
d the firmware, clear configuration API) versus the delay saved (almost 30 =
seconds minus several seconds to perform and complete the API calls) - arou=
nd 20 seconds or so.

Existing customers we have talked to seem to be able to cope with the exist=
ing delay.

Unfortunately, the amount of coding and testing involved with saving these =
20 seconds or so is beyond our available development manpower at this speci=
fic point in time.

Unfortunately, we will have to defer making the development you have reques=
ted to a later period in time.

Elad.


> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Sunday, March 24, 2024 5:25 PM
> To: Elad Nachman <enachman@marvell.com>
> Cc: Taras Chornyi <taras.chornyi@plvision.eu>; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> kory.maincent@bootlin.com; thomas.petazzoni@bootlin.com;
> miquel.raynal@bootlin.com; przemyslaw.kitszel@intel.com;
> dkirjanov@suse.de; netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [EXTERNAL] Re: [PATCH v2 0/5] Fix prestera driver fail to pr=
obe
> twice
>=20
> > > > Originally, the pain point for Kory was the rmmod + insmod
> > > > re-probing failure, Which is only fixed by the first two commits,
> > > > so I see little point in submitting 3-5 alone, Without fixing Kory'=
s
> problem.
> > >
> > > I thought Kory's problem was actually EPROBE_DEFER? The resources
> > > needed for the PoE are not available, so probing the switch needs to
> > > happen again later, when PoE can get the resources it needs.
> >
> > No, the PoE is the general high level application where he noted the
> problem.
> > There is no PoE code nor special PoE resources in the Prestera driver.
>=20
> So here is K=F6ry email:
>=20
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__lore.kernel.org_netdev_20240208101005.29e8c7f3-40kmaincent-2DXPS-
> 2D13-2D7390_T_-
> 23mb898bb2a4bf07776d79f1a19b6a8420716ecb4a3&d=3DDwIDAw&c=3DnKjWec2
> b6R0mOyPaz7xtfQ&r=3DeTeNTLEK5-
> TxXczjOcKPhANIFtlB9pP4lq9qhdlFrwQ&m=3DSD1MhKC11sFmp4Q8l76N_DgGdac
> 4aMCTdPsa7Pofb73HEqAGtJ-1p0-
> etIyyldC7&s=3DVWat9LPub52H3nUez4itmkpuMipnYD3Ngn-paFC9wd4&e=3D
>=20
> I don't see why the prestera needs to be involved in PoE itself. It is ju=
st a MAC.
> PoE happens much lower down in the network stack. Same as Prestera uses
> phylink, it does not need to know about the PHYs or the SFP modules, phyl=
ink
> manages them, not prestera.
>=20
> > The problem was caused because the module exit was lacking the so
> > called "switch HW reset" API call which would cause the firmware to
> > exit to the firmware loader on the firmware CPU, and move to the state
> > in the state machine when it can receive new firmware from the host
> > CPU (running the Prestera switchDev driver).
> >
> > >
> > > But if that is going to take 30 seconds, i'm not sure we can call
> > > EPROBE_DEFER solved.
> > >
> > > The later patches are pretty simple, don't need discussion, so could
> > > be merged. However, i think we need to explore different possible
> > > solutions for firmware {re}loading.
> > >
> > > > The problem is not with the hardware, but with the existing
> > > > firmware code on the Firmware cpu, most probably secure-boot
> > > > protected, which lacks the ABIs to report to The kernel what is
> > > > loaded, what version, what
> > > state, etc.
> > >
> > > Can you at least tell if it is running firmware?
> >
> > There is no existing API/ABI for that.
>=20
> Do you at least have the ability to determine if an API call exists or no=
t? It
> sounds like your firmware needs extending to support returning the versio=
n.
> If the API is missing, you know it is 4.1 or older. If it does exist, it =
will return
> 4.2 or higher.
>=20
> > > Can you explain the boot in a bit more detail. Are you saying it
> > > could be running an old firmware when the driver first loads? So you
> > > need to hit it with
> >
> > Exactly.
> >
> > > a reset in order to load the firmware for /lib/firmware, which might
> > > be newer than what it is already running?
> >
> > Right. And there is also the configuration. There is no telling what
> > kind of Configuration the existing firmware is running. Just using the
> > existing firmware Will lead to the situation where Linux kernel side
> > will report certain configuration (via ip link / ip addr / tc , etc.) b=
ut the
> firmware configuration is completely different.
>=20
> Well, during probe and -EPRODE_DEFER, linux has no configuration, since t=
he
> driver failed to probe. However, for a rmmod/modprobe, the firmware could
> have stale configuration. However pretty much every device i've come acro=
ss
> has the concept of a software reset which clears out the configuration. S=
eems
> to be something else your firmware is missing.
>=20
> 	Andrew

