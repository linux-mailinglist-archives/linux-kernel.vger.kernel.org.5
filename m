Return-Path: <linux-kernel+bounces-155490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1708AEB48
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 17:40:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E5191C225A3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 15:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C903A13D281;
	Tue, 23 Apr 2024 15:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="QwGmaGhL"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111DD13C695;
	Tue, 23 Apr 2024 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713886768; cv=fail; b=p8VVhK7NxrXo0f65n9Mo5sbxDMjn1YRj2AttopC5PdXMGS5VuQb6D3lxOmEXfxHsee4IqkKtGlbSSauUh9Y+/wWUiTHCksbsdbjIsNPMAGidWSaad5YxMQlwDTJA/WzaJC7Q5346NnmEfOqcsWwdRKLTUbNhLkdcR8+kA/DkPVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713886768; c=relaxed/simple;
	bh=f9DvW8F+qriGFTfF6fVj1ROx7rLXKysTAh7ANWvI2w8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=drbnsuVPllKRyE/6+OUNrb37Hn8GmnmSRx0aJQFoN6sjGLGA8zWJ0JGal94UPVIHDcAqiglvxC0RlIi4pXy4s/NRKjNYnTj47nFxtpSF/5YPgKho3+No/CshIrlm0wBYrmcJS+4LLL95g/qBt83UevI1yCiytdHMaZnidB9LXCI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=QwGmaGhL; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N5c11i017553;
	Tue, 23 Apr 2024 08:39:20 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xmd7ghnpw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 08:39:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dRKFJY2L/RpcM3X1yq9RGeCuD4XS6bkTjOX9tegHmWT0nxhUf9CcAcfrt2BISXNnMlV81hpjdaPJdc+G4L/hGXmAi8vRUqVF56zKDbPhJumM/kZXBUxbs/g0RRx3oPw8sDwl7BF7nS9hvQn+9sch98HVbHy18FEgIaxjc+ySbGhLShMb0UCn7Sh36EDovCBY0elx475ctwM1c3qT8FW4GGtBwnwzKNSToJfk3G2p1hsiIW/Eql8O7SzIcjdvAt8SL16PTMYMjkSYnQOaZnpy4+gCVWLV1dbP19LIFc4/9S4NYkIodTblBNI5c7GskamW0uMMWl6O9kN+EZ+cD5WtUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MCaTDFjVPC/mu9S9udLqrIhXsELd/w9Iw3UijeYgoSI=;
 b=mGZXbzmJ8ibXwxz8qmADZjteoXmUz747cLkeQepWaXJ0Sy6bQGu7iiAPZqcjm8gtcdI1y0s0S61+DsjkRUbyZnChkT9kQtaafWXaY7Nw3jpQ5biRAVbA1RPVJpuSO/CZaRIekfajUxtVV6OTk0m+C8i4AKthiTO3zJB6yMziYzcDq4kpTDOuzZF4zEGoOHPx9AilPdLzZYep5vWOCM7oLqjM4AjIVnmrgozrzVuM1ROHt1+ssDLSkZzdhJueS7PqkYXpOLsnyyJyZE1THrzKnFmW2BB3Ipq/cuDPTET1C5rXY63E6AwrvmY/9LpFWL1OdJX4dXj9D9RJ/tYtwg1ivQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MCaTDFjVPC/mu9S9udLqrIhXsELd/w9Iw3UijeYgoSI=;
 b=QwGmaGhLd99QuwI2ZNoacIMBomWeenZvPF5JOSPh+vME6IltYK3O0BogKJWpVW6foCcITu4VsCkojmchMuRBWrqWQ7YLLzIFV2P4CW2jkAhHgAOkiyNH+BN4AzOXPA/Y/6AlwVPwe5tVVDoetuN0uBneK39odlAYbulJ/lV8Mlk=
Received: from BL1PR18MB4342.namprd18.prod.outlook.com (2603:10b6:208:31e::16)
 by DM6PR18MB3442.namprd18.prod.outlook.com (2603:10b6:5:28e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 15:39:16 +0000
Received: from BL1PR18MB4342.namprd18.prod.outlook.com
 ([fe80::9e3c:b30b:67cf:1d16]) by BL1PR18MB4342.namprd18.prod.outlook.com
 ([fe80::9e3c:b30b:67cf:1d16%5]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 15:39:16 +0000
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
Subject: RE: [EXTERNAL] Re: [net-next PATCH v2 0/9] Introduce RVU representors
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v2 0/9] Introduce RVU
 representors
Thread-Index: AQHalJsFkqfhspWruUiIYa8/IeAzYbF10/0AgAAqKiA=
Date: Tue, 23 Apr 2024 15:39:15 +0000
Message-ID: 
 <BL1PR18MB434216126F143177DE9A1D9ACD112@BL1PR18MB4342.namprd18.prod.outlook.com>
References: <20240422095401.14245-1-gakula@marvell.com>
 <Ziexkkz8HCtIVRap@nanopsycho>
In-Reply-To: <Ziexkkz8HCtIVRap@nanopsycho>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR18MB4342:EE_|DM6PR18MB3442:EE_
x-ms-office365-filtering-correlation-id: 8a1a030b-d4d9-46fd-81d8-08dc63ab8877
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?8nhqIIVzDpgC05sVPyld90VYG45IoK5A0K1JE3pKs8sR+1HxLNeEd/dQ6Yb8?=
 =?us-ascii?Q?Pz/RhY1kPAp2VSONY2xziQ0GfA3LBNeGG5W1Rq1vV5tfB2Rit6EyC4oEv5FE?=
 =?us-ascii?Q?hZrTQgHVXPgBLQWOtjCZvgWoJuotX2crD5ci52Of6sorEAZlWIIkbtFrhDKa?=
 =?us-ascii?Q?zbHE8HeBAG+JN09ojickA+EZ4ulZFSVXCI4njdpyEGOaIRJDcTpHxN7jceVr?=
 =?us-ascii?Q?wLXxBP8S+tU9eGtf6PaERmn2yItZk8qYCf3eXO4i8pHkdvNJpf8yjRT4yV0y?=
 =?us-ascii?Q?Bpw5/rDO1DnYDUwhBM6mdy+UoqSV5WemxqU4jM1onoFjF1c6YDc9GxH6Ba87?=
 =?us-ascii?Q?niBbKvrZtilA9e+NctH5r4+4V9U6E+4HwNI/pqTK2cZsxpP39pvIQy50ZSef?=
 =?us-ascii?Q?+lhzGC913Gpb7aAbT5BHLbzllNKG8g7aXYn7xvfCPgrzG+H/898iunYO90RJ?=
 =?us-ascii?Q?SIKVSqd6erT35Lqbrqi+bz1FvI55YuOni9FlpFYBcacUQRHtY3/1Hv7xErUR?=
 =?us-ascii?Q?lqT072yg1aM9/11JuD7OqVd8zD5w8LYsOrHQEvdMIkc0zTYRBkyG6xJAHgPl?=
 =?us-ascii?Q?tWvmF1VIl1V/9DUSs83b6nBRoaxv0pN+2l20eCnbId5XCTtJaXyWuM+8O6V1?=
 =?us-ascii?Q?aPOUaBWivubWkDrNTrcH4Wfc7fsLIT33FnJZ2dvF6og1jIdqeWWP9x0ZGWzI?=
 =?us-ascii?Q?8qg/SDMvH0JDDtCfFtjnVkcUWXsyavFDOLFhivgP5dpc7McScAn8rDPJYF1i?=
 =?us-ascii?Q?eFubLbtblDBT1zsOOOWH9UIkJSWTL6XTk7p1PirAAwV5hnnSF7myVGgmvqAn?=
 =?us-ascii?Q?FikALpo4WnlZE9r/ilR3S3NOPlIbrAA3CMzZlxO6wyyMmZ81js+fK+x2ZeFq?=
 =?us-ascii?Q?21H0gHTO9wQWVhxiT9TtLduRE2MSVkSp0fd+nNr8os+PBi2Xb5WwDZx3shXx?=
 =?us-ascii?Q?f34qHMHVgyGb/uwVFcJKCMGtf5ORukAByb4sl8/oa/FwCGi9okp+ELK6JKne?=
 =?us-ascii?Q?DuIzq4rK8MP2foxQQsSBMKiT8LzKnwQbJju73VGdJDltCIXal4rZwTXiM5LD?=
 =?us-ascii?Q?xREFhqlMKlxkF8izFFbkVmVPZBVKUZFWEpQr4nQ7B/z6zjCoZh1OK59TGqU6?=
 =?us-ascii?Q?vFTAkrB2cvl+E2k7tug0+bfbVPdeWjzm7FshWCGAjuHiZ6JxPragXhO9/asj?=
 =?us-ascii?Q?XnJ30EJKUJkPLCsMprvoWI3dt/lCVGWc8YS+lu40bd3GG2eHUyJRiaviaTmK?=
 =?us-ascii?Q?BuWJqnyOwRjYXiiAc6vkytcf2++QBLkuYO/HD32ndQ0VjJpxmWQZucNHfCNf?=
 =?us-ascii?Q?LvtZBDSAiBzM5L4sHTsYbSCP?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR18MB4342.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?V1ceUGcqMj0/GfjzIt2N3xvnrm1RVtwEkaiviy5/aJrh4uO+ntKiqOY+pI0U?=
 =?us-ascii?Q?0t38PrAkXC4E/4JwkIaNvN4kK/eA23SssWr8ks+Y/Jpl+doe7RwmcdvOlQSk?=
 =?us-ascii?Q?5SCJsBEqq49hO6kA6xVfcPCaZHZDEJaKQSHzXbNDkzN0Qz1Mdkdq3PTqxmM7?=
 =?us-ascii?Q?eDLfuQzZmGKsPfBvnZMqE7f97y00/ih+f1mkfp20kbRIZ3PsHkbauZLmKb6G?=
 =?us-ascii?Q?E5bBAakqor+5KPG2wEBD9ODNMK/9xwfT145dwqEWtZvqFRVQ/m7Sw2Ba/oVk?=
 =?us-ascii?Q?YN6/ogcIgnGiyP3UlftAJF5uWEmutjlFMFQGvU3Aw3Kj6WVIssN7jZBboQvQ?=
 =?us-ascii?Q?otmWx5Cl6QZ6U55RzwOr5GTbetePgA7I2uNV74j/whS4X3gtP5cP4tzlOVXO?=
 =?us-ascii?Q?VjzimPQIK7vqGAzb610JZiLD3oqamWC7Un5CHgQQOJbvw+S3keTNzuEu2qiu?=
 =?us-ascii?Q?iK3i/OsHz2+486vXJeanZC2o1ApUr6xb6kel10cjSVIxD7KxtK83JBPNDwX5?=
 =?us-ascii?Q?lHAPSZWAiXzDiQXATIdNbCjzASGlg/JTXcV9AN3HcNLrg720x3Chmw26Nzey?=
 =?us-ascii?Q?I2M3LQvI82zIjMuTxG1DcN7PQXcPJa0BGxTDCNj7op3ptejozh1ljMzX+FM5?=
 =?us-ascii?Q?OnwCcyEi5eGGVVzmrPIFouvmW+7Nf2HcMocCSOd9j9qq02mZlvnksSpAhkPf?=
 =?us-ascii?Q?DzR48OCOAKFKbePLFiDGdnR7aZT8Dobl4ngk7QmZ+WGNkHa35cmNtw91/9yu?=
 =?us-ascii?Q?px8Pcbk7xI4/GOeUatoxX/uNPgQnWOVoyzitjWarAnbudN9PqRqViaL5rttH?=
 =?us-ascii?Q?JtTnXnngOft6cIHxNjfFJQ+7nOQHwlW9m5fI6RzzgC1Va38e5DFZJov98PHZ?=
 =?us-ascii?Q?bAWH0QW7grC0ohi886+R5se8OJrHR1VkxvqkUJb8jAwFkJ3YdsVzKEkJSctM?=
 =?us-ascii?Q?vpwHLqS7UygJLOS0uFtWHuJUhDysWbPxKKLMgXL26AT16dMWG2acVibtKT17?=
 =?us-ascii?Q?f5AHKJj6AL3quh7FJJQyJEDv4p5QAWz7Az6nes+XnYShgITPWbTOwsBAKdXP?=
 =?us-ascii?Q?yWt5fVHcSq4UxUPyEpD7Ad3T8fVtCoi23gX3Cux6B9Fr5mB1Gdx7pKzlnqTs?=
 =?us-ascii?Q?WpMHX4vDpYDzaV7OT7fuzQ0ysdyNmr8yTJe5dZPyzOvBz4T0WdQOKMAYjkr+?=
 =?us-ascii?Q?/Ys+/0ZcBLrYnd8mhWQFirQpecI6JPcZxX3Ea+2Vm0YinyKJ1WOL5eodwrh5?=
 =?us-ascii?Q?82qBFuprOg3Ltrdg2iCdcJ0cfVNeZWdU6wWKkhL0jrBoBaJ0rpRpqJcc41U+?=
 =?us-ascii?Q?JhnUkMFqL1zWII+yPB/hiRfO1SZhT1MYGp3DAwxSgga0Xb3qTLwOuYHisPcU?=
 =?us-ascii?Q?x32KvMhDyfJgaEthz3NikH4JdLLlc/mjpoxci9LynOiI/k2/5jwFLF3phZp2?=
 =?us-ascii?Q?YvztHP1t1UBNNOv5TtKi5V8X3fwHi9xHqcvicd4dpkKOFwne2VmZfoy7qlzV?=
 =?us-ascii?Q?Vg1kQtGywaIq4RA0VCMGKumeZJRyU0gWdPpgVMg11UIm8tEuzSrGaDDM04oz?=
 =?us-ascii?Q?N0wL3ZteU9DQ4/eQCtg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a1a030b-d4d9-46fd-81d8-08dc63ab8877
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2024 15:39:15.9533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I8fNhYczbJ1H0I1ZYhzmybPap3kQdg4W1WgXRcZckuAWrrkZ/qJ0M6W3QJeh+0kDTHG7PLPzTEPVPoW7OIDgQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR18MB3442
X-Proofpoint-ORIG-GUID: 6sLNtIOOxsaF9Ut1FUKx8NhQx8laKhpA
X-Proofpoint-GUID: 6sLNtIOOxsaF9Ut1FUKx8NhQx8laKhpA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_12,2024-04-23_02,2023-05-22_02



> -----Original Message-----
> From: Jiri Pirko <jiri@resnulli.us>
> Sent: Tuesday, April 23, 2024 6:33 PM
> To: Geethasowjanya Akula <gakula@marvell.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org=
;
> davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
> Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
> Subject: [EXTERNAL] Re: [net-next PATCH v2 0/9] Introduce RVU representor=
s
>=20
> Prioritize security for external emails: Confirm sender and content safet=
y
> before clicking links or opening attachments
>=20
> ----------------------------------------------------------------------
> Mon, Apr 22, 2024 at 11:53:52AM CEST, gakula@marvell.com wrote:
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
> >- Patch 2: Implements basic representor driver.
> >- Patch 3: Add devlink support to create representor netdevs that
> >  can be used to manage VFs.
> >- Patch 4: Implements basec netdev_ndo_ops.
> >- Patch 5: Installs tcam rules to route packets between representor and
> >	   VFs.
> >- Patch 6: Enables fetching VF stats via representor interface.
> >- Patch 7: Adds support to sync link state between representors and VFs.
> >- Patch 8: Enables configuring VF MTU via representor netdevs.
> >- Patch 9: Add representors for sdp MAC.
>=20
>=20
> Could you please add some command outputs to the cover letter? Like $
> devlink dev $ devlink port
>=20
#devlink dev eswitch set pci/0002:1c:00.0 mode switchdev
> outputs at least.
>=20
>=20
> >
> >-----------
> >v1-v2:
> > -Fixed build warnings.
> > -Address review comments provided by "Kalesh Anakkur Purayil".
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

