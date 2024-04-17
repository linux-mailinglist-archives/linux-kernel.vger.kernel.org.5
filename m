Return-Path: <linux-kernel+bounces-148618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A51518A8528
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15CF1C21997
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EAC14039D;
	Wed, 17 Apr 2024 13:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="Yx+sem2E"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F66D140360;
	Wed, 17 Apr 2024 13:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713361547; cv=fail; b=mYuqyIPsvIUKIhrrrlK9VU3Dt4RUAeg4QuqVNG6KQ0ng6t/2iyskb1d0hq8qQ5poEW6DmkxsTYaMB65ssS06Wukn982LbAUjY3iAErZ549xt30KBW6dImjOHHQesQ+Tpu3960tSt9zYCQXQcIOTuKBP0JKlUEyYif9kSSP3kSxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713361547; c=relaxed/simple;
	bh=bDHtxWxBlx9OXrIZroMSp7dubIBUO+rjgRoXlmFECjI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h6LyNFwXPcML/5nc7PwWlXhCJRay/Dj8fHaXQw4qYeh/EYzpqqg+OTwEPsGeVGtGqNrdChtTcPbUiCMgyeoPuS0LOO8oUmMaALKw4OhuRCza3DpUMt0W7CFLoKus8sDW0ySjY7dBYPy/nRwucx91QDWRnsdid5X+06ASzgZuslA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=Yx+sem2E; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43H7VN6w031261;
	Wed, 17 Apr 2024 06:45:34 -0700
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xja4196am-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 06:45:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6dBhoC5ArBR7YB3j5JGsvBOf1sN7QHMN5CHIligWFCH6YrHpnwIktI9LJsRqk3Nqutzr6ZphMXLEfwWbM6pNCoRNFXf8WIhLe1OLbGj0sleyHyfep8Z9oQw6dVQRWzKryxMvryEAAPFsu8DN6gauwjgA2syMXwtU6+myh3oR3XhycU2+bmdJnlZRqqipidgxPCJHCMi/8EDk91NwncWCg3wPBCtf1t4KaPfC0m2IS2ItUzAq3dMIofp1YHKOQiHAzBauBOzQ30rUtZQzzyzjRx63b3Qwh1q4g14SX9qdylh81uy8pMsn1ongPVSQ+4qHylzK/J+1iz4NN2+OpUVSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VtEdKkzCN/iJ3jRwTfLRJ4nb5dBGI8o6QZYeVJi+/iM=;
 b=drTCMIbxUx2Hru4KbGQvWXjIlUDWu83ZyXEC+V4E0OJc0IPF/dd4/HqNZNbD5dUYqCx0BwBwFrOJTFHLbkJUhuksUMsSv0azfY1Vgw6q/pYYpd/wCALOA00jpX0xNKCeq5pMp59V4DEyaYFQFfCE8fKyNgRaw9Ejfh6/R/MC1xSKLwrCPqX66OKPkefkwt6X3NeRhge9C++Pn/QCwmczHifOmI68DjUPFgkBMjzyq4YnJ4tmMCmztcps1SF8BU9qwKEl8Wt16s4NhDr4AL/m+14carPqNfCYYx6QPOJrlWig76DOpp/bYLMtEZidup5hkWXUgSanaOsek7pYzwqv2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VtEdKkzCN/iJ3jRwTfLRJ4nb5dBGI8o6QZYeVJi+/iM=;
 b=Yx+sem2ENUIYfqMwrGzQj1SIrU/mBmNJTe5uk7CT9N9aAgtArXs3r1EiNWDQ3lMz6ZiPc5cjl/JIRrQ8KDI9xB2rEo8pNLoiazXPS5gLZOVTNT/NrMc0z/6Zq+nwOLyc5MqmK05XiPdDEKaL1LWLyT2SfF8KnVZr8AXUyKRrYZk=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by CO6PR18MB4515.namprd18.prod.outlook.com (2603:10b6:303:13a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Wed, 17 Apr
 2024 13:45:28 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 13:45:28 +0000
From: Geethasowjanya Akula <gakula@marvell.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
        "oe-kbuild@lists.linux.dev"
	<oe-kbuild@lists.linux.dev>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
CC: "lkp@intel.com" <lkp@intel.com>,
        "oe-kbuild-all@lists.linux.dev"
	<oe-kbuild-all@lists.linux.dev>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Sunil
 Kovvuri Goutham <sgoutham@marvell.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: RE: [EXTERNAL] Re: [net-next PATCH 2/9] octeontx2-pf: RVU representor
 driver
Thread-Topic: [EXTERNAL] Re: [net-next PATCH 2/9] octeontx2-pf: RVU
 representor driver
Thread-Index: AQHaj7vZFA2SON2HBESfh0LFpSC0crFseXAAgAABokA=
Date: Wed, 17 Apr 2024 13:45:27 +0000
Message-ID: 
 <CH0PR18MB43390E834F5AA7E8911B1AF7CD0F2@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240416050616.6056-3-gakula@marvell.com>
 <546b7783-78ec-4fec-b338-f1980a5871d0@moroto.mountain>
In-Reply-To: <546b7783-78ec-4fec-b338-f1980a5871d0@moroto.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|CO6PR18MB4515:EE_
x-ms-office365-filtering-correlation-id: 6b7a6820-0710-430b-385e-08dc5ee4a42c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 korIE3F7g+nDREKUbxhVpg2l8R6DXTncdaDnyBwikRO1LY7m5Za4C/kD0NM7Ier8v0MpmgqLTF5L5VvQ7ayfgjOM9ZAoY3gBPNsKeQN0Z89i+jjOMeKbryxipQ6ow1WmqoMUKlXWHCX1Ua+Pgl+2GH95JttiZvxUD6g8EWrVgxIUpKFuHkUXjrphFWuqKJPyBpW4sGOjYzzaFpkw4WLRQmyQQZ1wOPwHIUEQsi1UywTwPbP+H45XWoExNPkdG/8RowS3+i67NCUNjJSWpEW7vgEWPDXJ4vhZAhgLzQUHWRloQKiH5WlocksuItCZO8cvF3JW/Np5nM/OsrDoI/760CMsfwYjvhQ/Xj1BGXPfBNPSOtsB6NMDJ8eQPljVtssB9w4pgqicDWCRgUQcczDu6tPukUZoIeTcXtD53jTrnPTIfNBvG/UWCLsbgDHRYL2S4u0gQBRjLHqtjc8k+77adZLsSXQVDgwH8PYhR2VDBHoCmRJzswxPlBP+9ygDUd2a1iARKxT2aR5dw1itSoYQVxuzg3szZ9d6O7dAB33f6U/N/h2JDNvUasM2olJaK65hcEi6E+dkYjSSwMWL5xZtoP/f3hATGAx0WBCytP28/C8eG+eWaWNbtGoxaxffhAn6T3tppF53mU794Fu1Qg8UGa96sk/0HoZLQENHu2Ag85w=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?q7+vXWXqauLWUU5W/1MS+z2vZvKpTj4B/557qQ9+o+qTMt5Qeu4uWVtjrMbN?=
 =?us-ascii?Q?VbjBmbB3W61dPFJTmsQfOTvwOLlIDsh3QkmKmKW4NVaNnu2jzj8U27B/g6Yy?=
 =?us-ascii?Q?8jksFf6PIkYCqEnFnYwp/DnhaB3Vu/ljU61taw0H1yJavvm79CZuTa+D8ILl?=
 =?us-ascii?Q?SNNlmzqAaO2bMdUI0RM91NvjWCHdMbjWF0gSeyLwQCfRa6pycuuiUmj6iKoL?=
 =?us-ascii?Q?NyzN1kKlho7DYm1v5uDFCkUPIit+t9XYtbblqb5xa7poTMkg28vn12l7o9ns?=
 =?us-ascii?Q?AP/JJE27pJIkRgK6D0NhZT+dhyaAQUf26Q15Cr1MXyfHSs31yaGrT6XLu8s6?=
 =?us-ascii?Q?jcJEnzoEsmWjMX4fVfn5cJGXMGGqoJuzZy4Kt3wQu6WSZt7kcj4o/Orp54L5?=
 =?us-ascii?Q?NCTryTZoSwTrtkTVZ2uO/m8dam/mJkvnn9Pv5zUOeq99z6YCeAOkW0wGW9f+?=
 =?us-ascii?Q?ujUZGva2P3DO0eTwEzXqBOy1pHjhRWVfZzEQCzsDHNJZxG/W/nfJEi+dqx2M?=
 =?us-ascii?Q?5LVjEkQINePIV9y5ULxMzqYGzrDQzMXziVsu+06HFw3Z+uTEvf60c1IngLds?=
 =?us-ascii?Q?0FRDqEEqRsGFWMHW1cWnmsh3yAn+Eh+ezecwBLNbrOB3JHu4VNmfq5PWupp1?=
 =?us-ascii?Q?LA0pIKDzTOTAaE8L2t+ZWPMCv9HFfjFnfFeRUdGt6gnGj/JBkUQIq42kbSxw?=
 =?us-ascii?Q?H1b+ddOGqbwgO6wpMx4OYVj7QYBfAdrtV31V/6BcidldOKPa0lCRR0Ofwl7M?=
 =?us-ascii?Q?YaxY9Sl24q4vuh+covwsRJr69urCij4+iTUUe8TNQL5aCEFBG4PJhhzsnGiE?=
 =?us-ascii?Q?CMArShYeAAD0Ia3DkysO45XVFEFhdBgizc87uZqI9LbGwwDz5X/BJL/soxvC?=
 =?us-ascii?Q?jX/3x8nuj6B4Ym1ZebD+yVH3rguwoyJaB+cbe6KsyOBdjlLJTLYe+UTNfIZ8?=
 =?us-ascii?Q?zPLoTVnu6KHeOe27ejAHUzVa6C0n0FgQnQLSKwDZ6IpDm/0mPz6vBXKoSp8q?=
 =?us-ascii?Q?i+q5PzDvA83CR24M+5py+iq2djcVCk2Gi6EOB33SoQI4o+8Q8pzG71TiM6gv?=
 =?us-ascii?Q?7QXs8PDfGwHdNOoEfkUVqUysALyUUsIsuDYmH8HLEM2bVYCWo6ms0nqSfbYK?=
 =?us-ascii?Q?gR3HDvQzhHhrGeqnByAcooDgYGq5uM9K2fAPYC0ebeqKQCc1mW9KPAsaAoYI?=
 =?us-ascii?Q?/Izv4bClBg5X5dBBn/29deHBqVOA+PlYi484YX8pyWIbdYN2/BgMwVvobXSJ?=
 =?us-ascii?Q?TY5Q3bUtVJ5cuUhw/7kbhJpjpk0fkAMDro2r5H/HHQEre75O11/yXqT8XIRJ?=
 =?us-ascii?Q?6edTZ5TbuiNuBkTGEfUR97G6gHl3K5t0n4XwSVvHkLHmiczRadLFxZeZtLmC?=
 =?us-ascii?Q?Hc49QkAXtIsaqApD8S0ALgehpkggRc8LIMteLFcYrB5HAgvJ54e3l4cpPtRo?=
 =?us-ascii?Q?ACTv7ceSC1gexxIqUmQZmzoJptXhDKFXT+rhC6e7k2milRK4uem3q+LMeRna?=
 =?us-ascii?Q?VRTioCH6Vi2C/1wTTIM6qR3p+WnYpDJmqYq7OWXoazOgc67iYs1kR1dFxANq?=
 =?us-ascii?Q?cW56Igx7QLb4Ge5zifw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b7a6820-0710-430b-385e-08dc5ee4a42c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2024 13:45:27.9069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6KtcaWIt631bhSThhRQH/rRT7OExbMkFiiOJPEolFqMHG/RH29bbIOkQ2PgK496XXMmfXTxI9A138kg4qYIfFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR18MB4515
X-Proofpoint-GUID: CiXD4JTecNQZxKiz8Ya6Un373bOnKnxr
X-Proofpoint-ORIG-GUID: CiXD4JTecNQZxKiz8Ya6Un373bOnKnxr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_11,2024-04-16_01,2023-05-22_02


> -----Original Message-----
> From: Dan Carpenter <dan.carpenter@linaro.org>
> Sent: Wednesday, April 17, 2024 7:08 PM
> To: oe-kbuild@lists.linux.dev; Geethasowjanya Akula <gakula@marvell.com>;
> netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Cc: lkp@intel.com; oe-kbuild-all@lists.linux.dev; kuba@kernel.org;
> davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
> Kovvuri Goutham <sgoutham@marvell.com>; Geethasowjanya Akula
> <gakula@marvell.com>; Subbaraya Sundeep Bhatta <sbhatta@marvell.com>;
> Hariprasad Kelam <hkelam@marvell.com>
> Subject: [EXTERNAL] Re: [net-next PATCH 2/9] octeontx2-pf: RVU represento=
r
> driver
>=20
> Prioritize security for external emails: Confirm sender and content safet=
y
> before clicking links or opening attachments
>=20
> ----------------------------------------------------------------------
> Hi Geetha,
>=20
> kernel test robot noticed the following build warnings:
Sorry for the noise. Will submit v2.=20
>=20
> url:    https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__github.com_intel-2Dlab-2Dlkp_linux_commits_Geetha-
> 2Dsowjanya_octeontx2-2Dpf-2DRefactoring-2DRVU-2Ddriver_20240416-
> 2D131052&d=3DDwIBAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DUiEt_nUeYFctu7JVLX
> VlXDhTmq_EAfooaZEYInfGuEQ&m=3Dpcjq_-
> V9lD5zAfvLDvrlTSM6DYTEg3uJVXYiddlZa89uqDZsmg4dN-
> MbQRGQK6ji&s=3DChDNOMytP7EFyLLxwRY3cHm7DMPhPlK3Wv2IEhbgJ6g&e=3D
> base:   net-next/main
> patch link:    https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__lore.kernel.org_r_20240416050616.6056-2D3-2Dgakula-
> 2540marvell.com&d=3DDwIBAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DUiEt_nUeYFct
> u7JVLXVlXDhTmq_EAfooaZEYInfGuEQ&m=3Dpcjq_-
> V9lD5zAfvLDvrlTSM6DYTEg3uJVXYiddlZa89uqDZsmg4dN-
> MbQRGQK6ji&s=3DYSpWxF94IMzRZMCAUDJtHTF24ZOUEQndVX3_OEwQeT4&e=3D
> patch subject: [net-next PATCH 2/9] octeontx2-pf: RVU representor driver
> config: alpha-randconfig-r081-20240417
> (https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__download.01.org_0day-
> 2Dci_archive_20240417_202404172056.MpOMwcGB-2Dlkp-
> 40intel.com_config&d=3DDwIBAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DUiEt_nUeYF
> ctu7JVLXVlXDhTmq_EAfooaZEYInfGuEQ&m=3Dpcjq_-
> V9lD5zAfvLDvrlTSM6DYTEg3uJVXYiddlZa89uqDZsmg4dN-
> MbQRGQK6ji&s=3DQOW0AEuofAe4zzEOmhoLGIMNdsEeECwaFcWF59IbfGs&e=3D
> )
> compiler: alpha-linux-gcc (GCC) 13.2.0
>=20
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> | Closes:
> | https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org_=
r
> | _202404172056.MpOMwcGB-2Dlkp-
> 40intel.com_&d=3DDwIBAg&c=3DnKjWec2b6R0mOyPaz
> | 7xtfQ&r=3DUiEt_nUeYFctu7JVLXVlXDhTmq_EAfooaZEYInfGuEQ&m=3Dpcjq_-
> V9lD5zAfvL
> | DvrlTSM6DYTEg3uJVXYiddlZa89uqDZsmg4dN-
> MbQRGQK6ji&s=3DjPDXgsvu9jd0deKZBs1
> | uke91fxvHYp_S6gFl1gnq5Rk&e=3D
>=20
> New smatch warnings:
> drivers/net/ethernet/marvell/octeontx2/nic/rep.c:95 rvu_get_rep_cnt() war=
n:
> passing zero to 'PTR_ERR'
> drivers/net/ethernet/marvell/octeontx2/nic/rep.c:140 rvu_rep_probe() warn=
:
> missing unwind goto?
>=20
> vim +/PTR_ERR +95 drivers/net/ethernet/marvell/octeontx2/nic/rep.c
>=20
> 1e15129a77b419 Geetha sowjanya 2024-04-16   76  static int
> rvu_get_rep_cnt(struct otx2_nic *priv)
> 1e15129a77b419 Geetha sowjanya 2024-04-16   77  {
> 1e15129a77b419 Geetha sowjanya 2024-04-16   78  	struct
> get_rep_cnt_rsp *rsp;
> 1e15129a77b419 Geetha sowjanya 2024-04-16   79  	struct mbox_msghdr
> *msghdr;
> 1e15129a77b419 Geetha sowjanya 2024-04-16   80  	struct msg_req *req;
> 1e15129a77b419 Geetha sowjanya 2024-04-16   81  	int err, rep;
> 1e15129a77b419 Geetha sowjanya 2024-04-16   82
> 1e15129a77b419 Geetha sowjanya 2024-04-16   83  	mutex_lock(&priv-
> >mbox.lock);
> 1e15129a77b419 Geetha sowjanya 2024-04-16   84  	req =3D
> otx2_mbox_alloc_msg_get_rep_cnt(&priv->mbox);
> 1e15129a77b419 Geetha sowjanya 2024-04-16   85  	if (!req) {
> 1e15129a77b419 Geetha sowjanya 2024-04-16   86
> 	mutex_unlock(&priv->mbox.lock);
> 1e15129a77b419 Geetha sowjanya 2024-04-16   87  		return -
> ENOMEM;
> 1e15129a77b419 Geetha sowjanya 2024-04-16   88  	}
> 1e15129a77b419 Geetha sowjanya 2024-04-16   89  	err =3D
> otx2_sync_mbox_msg(&priv->mbox);
> 1e15129a77b419 Geetha sowjanya 2024-04-16   90  	if (err)
> 1e15129a77b419 Geetha sowjanya 2024-04-16   91  		goto exit;
> 1e15129a77b419 Geetha sowjanya 2024-04-16   92
> 1e15129a77b419 Geetha sowjanya 2024-04-16   93  	msghdr =3D
> otx2_mbox_get_rsp(&priv->mbox.mbox, 0, &req->hdr);
> 1e15129a77b419 Geetha sowjanya 2024-04-16   94  	if (IS_ERR(msghdr)) {
> 1e15129a77b419 Geetha sowjanya 2024-04-16  @95  		err =3D
> PTR_ERR(rsp);
>                                                                          =
     ^^^ s/rsp/msghdr/
>=20
> 1e15129a77b419 Geetha sowjanya 2024-04-16   96  		goto exit;
> 1e15129a77b419 Geetha sowjanya 2024-04-16   97  	}
> 1e15129a77b419 Geetha sowjanya 2024-04-16   98
> 1e15129a77b419 Geetha sowjanya 2024-04-16   99  	rsp =3D (struct
> get_rep_cnt_rsp *)msghdr;
> 1e15129a77b419 Geetha sowjanya 2024-04-16  100  	priv->hw.tx_queues =3D
> rsp->rep_cnt;
> 1e15129a77b419 Geetha sowjanya 2024-04-16  101  	priv->hw.rx_queues =3D
> rsp->rep_cnt;
> 1e15129a77b419 Geetha sowjanya 2024-04-16  102  	priv->rep_cnt =3D rsp-
> >rep_cnt;
> 1e15129a77b419 Geetha sowjanya 2024-04-16  103  	for (rep =3D 0; rep <
> priv->rep_cnt; rep++)
> 1e15129a77b419 Geetha sowjanya 2024-04-16  104  		priv-
> >rep_pf_map[rep] =3D rsp->rep_pf_map[rep];
> 1e15129a77b419 Geetha sowjanya 2024-04-16  105
> 1e15129a77b419 Geetha sowjanya 2024-04-16  106  exit:
> 1e15129a77b419 Geetha sowjanya 2024-04-16  107  	mutex_unlock(&priv-
> >mbox.lock);
> 1e15129a77b419 Geetha sowjanya 2024-04-16  108  	return err;
> 1e15129a77b419 Geetha sowjanya 2024-04-16  109  }
> 1e15129a77b419 Geetha sowjanya 2024-04-16  110
> 1e15129a77b419 Geetha sowjanya 2024-04-16  111  static int
> rvu_rep_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> 1e15129a77b419 Geetha sowjanya 2024-04-16  112  {
> 1e15129a77b419 Geetha sowjanya 2024-04-16  113  	struct device *dev =3D
> &pdev->dev;
> 1e15129a77b419 Geetha sowjanya 2024-04-16  114  	struct otx2_nic *priv;
> 1e15129a77b419 Geetha sowjanya 2024-04-16  115  	struct otx2_hw *hw;
> 1e15129a77b419 Geetha sowjanya 2024-04-16  116  	int err;
> 1e15129a77b419 Geetha sowjanya 2024-04-16  117
> 1e15129a77b419 Geetha sowjanya 2024-04-16  118  	err =3D
> pcim_enable_device(pdev);
> 1e15129a77b419 Geetha sowjanya 2024-04-16  119  	if (err) {
> 1e15129a77b419 Geetha sowjanya 2024-04-16  120  		dev_err(dev,
> "Failed to enable PCI device\n");
> 1e15129a77b419 Geetha sowjanya 2024-04-16  121  		return err;
> 1e15129a77b419 Geetha sowjanya 2024-04-16  122  	}
> 1e15129a77b419 Geetha sowjanya 2024-04-16  123
> 1e15129a77b419 Geetha sowjanya 2024-04-16  124  	err =3D
> pci_request_regions(pdev, DRV_NAME);
> 1e15129a77b419 Geetha sowjanya 2024-04-16  125  	if (err) {
> 1e15129a77b419 Geetha sowjanya 2024-04-16  126  		dev_err(dev,
> "PCI request regions failed 0x%x\n", err);
> 1e15129a77b419 Geetha sowjanya 2024-04-16  127  		return err;
> 1e15129a77b419 Geetha sowjanya 2024-04-16  128  	}
> 1e15129a77b419 Geetha sowjanya 2024-04-16  129
> 1e15129a77b419 Geetha sowjanya 2024-04-16  130  	err =3D
> dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48));
> 1e15129a77b419 Geetha sowjanya 2024-04-16  131  	if (err) {
> 1e15129a77b419 Geetha sowjanya 2024-04-16  132  		dev_err(dev,
> "DMA mask config failed, abort\n");
> 1e15129a77b419 Geetha sowjanya 2024-04-16  133  		goto
> err_release_regions;
> 1e15129a77b419 Geetha sowjanya 2024-04-16  134  	}
> 1e15129a77b419 Geetha sowjanya 2024-04-16  135
> 1e15129a77b419 Geetha sowjanya 2024-04-16  136
> 	pci_set_master(pdev);
> 1e15129a77b419 Geetha sowjanya 2024-04-16  137
> 1e15129a77b419 Geetha sowjanya 2024-04-16  138  	priv =3D
> devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> 1e15129a77b419 Geetha sowjanya 2024-04-16  139  	if (!priv)
> 1e15129a77b419 Geetha sowjanya 2024-04-16 @140  		return -
> ENOMEM;
>=20
> goto err_release_regions.
>=20
> 1e15129a77b419 Geetha sowjanya 2024-04-16  141  	pci_set_drvdata(pdev,
> priv);
> 1e15129a77b419 Geetha sowjanya 2024-04-16  142  	priv->pdev =3D pdev;
> 1e15129a77b419 Geetha sowjanya 2024-04-16  143  	priv->dev =3D dev;
> 1e15129a77b419 Geetha sowjanya 2024-04-16  144  	priv->flags |=3D
> OTX2_FLAG_INTF_DOWN;
> 1e15129a77b419 Geetha sowjanya 2024-04-16  145  	priv->flags |=3D
> OTX2_FLAG_REP_MODE_ENABLED;
> 1e15129a77b419 Geetha sowjanya 2024-04-16  146
> 1e15129a77b419 Geetha sowjanya 2024-04-16  147  	hw =3D &priv->hw;
> 1e15129a77b419 Geetha sowjanya 2024-04-16  148  	hw->pdev =3D pdev;
> 1e15129a77b419 Geetha sowjanya 2024-04-16  149  	hw->max_queues =3D
> OTX2_MAX_CQ_CNT;
> 1e15129a77b419 Geetha sowjanya 2024-04-16  150  	hw->rbuf_len =3D
> OTX2_DEFAULT_RBUF_LEN;
> 1e15129a77b419 Geetha sowjanya 2024-04-16  151  	hw->xqe_size =3D 128;
> 1e15129a77b419 Geetha sowjanya 2024-04-16  152
> 1e15129a77b419 Geetha sowjanya 2024-04-16  153  	err =3D
> otx2_init_rsrc(pdev, priv);
> 1e15129a77b419 Geetha sowjanya 2024-04-16  154  	if (err)
> 1e15129a77b419 Geetha sowjanya 2024-04-16  155  		goto
> err_release_regions;
> 1e15129a77b419 Geetha sowjanya 2024-04-16  156
> 1e15129a77b419 Geetha sowjanya 2024-04-16  157  	err =3D
> rvu_get_rep_cnt(priv);
> 1e15129a77b419 Geetha sowjanya 2024-04-16  158  	if (err)
> 1e15129a77b419 Geetha sowjanya 2024-04-16  159  		goto
> err_detach_rsrc;
> 1e15129a77b419 Geetha sowjanya 2024-04-16  160
> 1e15129a77b419 Geetha sowjanya 2024-04-16  161  	err =3D
> rvu_rep_rsrc_init(priv);
> 1e15129a77b419 Geetha sowjanya 2024-04-16  162  	if (err)
> 1e15129a77b419 Geetha sowjanya 2024-04-16  163  		goto
> err_detach_rsrc;
> 1e15129a77b419 Geetha sowjanya 2024-04-16  164
> 1e15129a77b419 Geetha sowjanya 2024-04-16  165  	return 0;
> 1e15129a77b419 Geetha sowjanya 2024-04-16  166
> 1e15129a77b419 Geetha sowjanya 2024-04-16  167  err_detach_rsrc:
> 1e15129a77b419 Geetha sowjanya 2024-04-16  168  	if (priv->hw.lmt_info)
> 1e15129a77b419 Geetha sowjanya 2024-04-16  169
> 	free_percpu(priv->hw.lmt_info);
> 1e15129a77b419 Geetha sowjanya 2024-04-16  170  	if
> (test_bit(CN10K_LMTST, &priv->hw.cap_flag))
> 1e15129a77b419 Geetha sowjanya 2024-04-16  171
> 	qmem_free(priv->dev, priv->dync_lmt);
> 1e15129a77b419 Geetha sowjanya 2024-04-16  172
> 	otx2_detach_resources(&priv->mbox);
> 1e15129a77b419 Geetha sowjanya 2024-04-16  173
> 	otx2_disable_mbox_intr(priv);
> 1e15129a77b419 Geetha sowjanya 2024-04-16  174
> 	otx2_pfaf_mbox_destroy(priv);
> 1e15129a77b419 Geetha sowjanya 2024-04-16  175
> 	pci_free_irq_vectors(pdev);
> 1e15129a77b419 Geetha sowjanya 2024-04-16  176  err_release_regions:
> 1e15129a77b419 Geetha sowjanya 2024-04-16  177  	pci_set_drvdata(pdev,
> NULL);
> 1e15129a77b419 Geetha sowjanya 2024-04-16  178
> 	pci_release_regions(pdev);
> 1e15129a77b419 Geetha sowjanya 2024-04-16  179  	return err;
> 1e15129a77b419 Geetha sowjanya 2024-04-16  180  }
>=20
> --
> 0-DAY CI Kernel Test Service
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_intel_l=
kp-
> 2Dtests_wiki&d=3DDwIBAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DUiEt_nUeYFctu7JV
> LXVlXDhTmq_EAfooaZEYInfGuEQ&m=3Dpcjq_-
> V9lD5zAfvLDvrlTSM6DYTEg3uJVXYiddlZa89uqDZsmg4dN-
> MbQRGQK6ji&s=3DbeFB4KCroPb-eEJRShM4cz1uR-BfmmzYTAhp7-xEqqc&e=3D


