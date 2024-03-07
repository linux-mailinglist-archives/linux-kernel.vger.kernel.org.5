Return-Path: <linux-kernel+bounces-95412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE56874D54
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 12:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC9331F25B8D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA3E31292F9;
	Thu,  7 Mar 2024 11:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="WDsDhK19"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6261292D0;
	Thu,  7 Mar 2024 11:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709810670; cv=fail; b=fhnAhzfJk14kTTbH2h/ZH81P9dDA4fX9P3bGmI6U6dVp6MBV+8oxUZoWycofz3yc49XHZK1MsqrVP+ZvFMG/zuLXtdqnqwGiUI+91U1IBoRk/c0odsr/t12RLKTmQwhkPCN1x3RmQeQQVX9ITy4k+FCG2PBOwC6fbzI9oU72WEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709810670; c=relaxed/simple;
	bh=0hNex6TojrychVSCwhwv5QAa8CeTXGjBnZsHYC1ciWw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FAHfHgMwSUqy5d8ZxFvwyxSIw/T9oF3aPAJJAoCm0gQE59IzV3Jyx5WgP1VVR3QDI44ynwDY8dFJ/8H3n4+UTbvDQknN/qmlAGREd4IpFn9lAitZfniWHfaIz0bEqMc7mZNAkVqD9CMpt6jneVQb6J5o7utLKR8U7xM+ddeW8kY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=WDsDhK19; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4275jbQo008239;
	Thu, 7 Mar 2024 03:24:12 -0800
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wq7q8rxdj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 03:24:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hIsRt8fZqHh1aoOW9qD4LkePNE2ye56WV9EW52ClGdu9Swm8UFnf1wOAB62YcViyim05DE73lO9VSkExn3z9HIKXNdEOBYAIR6v70FnwJ1qGwDVwwpFmGYQyylk4EtA3KqUb405ynFY9K1p3VNRt6cg61mpZi61gRQxTc2lc12EGdWm+r3CWF3TAzh+dg47nhXFvFinI2q97OC5Bq1lXRD34g4Xj2dQUs4nKvWNrJBE2hEWPxYZIegA4BnRSJkZiBftSlUrbNNXDe4sLWyjitPkXH7B5kVBYGCPO2SSz6dtwBe27qVbe8hvwi0VUo9DXFvTsIMqQJ8bY0849k/Z+Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hNex6TojrychVSCwhwv5QAa8CeTXGjBnZsHYC1ciWw=;
 b=B7iTn9lR8XmIJyIYzpUhcVpOZq8FKb2ANQ8T1Zr0lyxB/MYBs37hVrJx5JuQzxWs6cX7+TsLW8BDfG4Rfv0/rPQ+l1gxZw0ZmXIMXi9MGba2Dwsya/dJnH7a0s7/61DRcrpMU/QS8TZAy4zRiMXJIUeZFY1KzHRDftPGToPsJLtiu1D39QgoPnClrwZlk/GKhxhjIhp9G8Bce29p+tUFjoM5h9vtCuLPNOMn5y5ueKppSdppml9XORCkBYUSGYMSfRTnt/GsOIzvGcNUyCjUT0ihaRQR6BqTa2Sn8Cqcj4oV0kxEaRvxkakLJCXiHeWyGeJ5NRtoaa+twwDhhSbr+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hNex6TojrychVSCwhwv5QAa8CeTXGjBnZsHYC1ciWw=;
 b=WDsDhK19CtGlazA+bjHVW4Tg6xsdfh0CHAsbsAGZGOKTvDBCaxo+kBcnl5j93Y+h6RxslReX9fG5IoMcXokCrjhG+K0XDZvyURiW+Jy+ni7wPbMemGme18ThpeQf+bdRkpvNkRPlaL2PbvRsazijaY+qxBpFGO/3xD9qQt7mRyQ=
Received: from BY3PR18MB4737.namprd18.prod.outlook.com (2603:10b6:a03:3c8::7)
 by SA0PR18MB3694.namprd18.prod.outlook.com (2603:10b6:806:99::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Thu, 7 Mar
 2024 11:24:09 +0000
Received: from BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::4c91:458c:d14d:2fa6]) by BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::4c91:458c:d14d:2fa6%6]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 11:24:09 +0000
From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
To: Jijie Shao <shaojijie@huawei.com>,
        "yisen.zhuang@huawei.com"
	<yisen.zhuang@huawei.com>,
        "salil.mehta@huawei.com" <salil.mehta@huawei.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>
CC: "shenjian15@huawei.com" <shenjian15@huawei.com>,
        "wangjie125@huawei.com"
	<wangjie125@huawei.com>,
        "liuyonglong@huawei.com" <liuyonglong@huawei.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE:  [PATCH net 6/8] net: hns3: fix reset timeout under full
 functions and queues
Thread-Topic: [PATCH net 6/8] net: hns3: fix reset timeout under full
 functions and queues
Thread-Index: AQHacIH5VlO91nqK4UmHdb6rsYfgfQ==
Date: Thu, 7 Mar 2024 11:24:09 +0000
Message-ID: 
 <BY3PR18MB4737FA1796C8BC8180296BE8C6202@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <20240307010115.3054770-1-shaojijie@huawei.com>
 <20240307010115.3054770-7-shaojijie@huawei.com>
In-Reply-To: <20240307010115.3054770-7-shaojijie@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4737:EE_|SA0PR18MB3694:EE_
x-ms-office365-filtering-correlation-id: f7bc8c39-64c6-4e29-ecfb-08dc3e991ba9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 stl6tDsYwkbtz1WoAY6MrXfVwGCDWwbO3n15o9uepFoA9E8CuDQCEKdCz+YxVZMkwxR2LEqWVu0Ps74fkAfjE6srr9trKiNFjnNvDOfeeVjlI0H08vrCdtRlTpUWVzGYMZYxlIquHhOeeGg6yXk5PFzKq/JESzKmCtsrZeTw1vzwI0+xj8e9t5Izj0wD0bgYqNWoQBitFMf2sqyufGYHnvDAIg8VFVzo3ktR7N+kAoELW+s7Uc8ElQRxCq8Z7gKyJjYUUSJw3+/m317eDZxW+WgVsO2J7kiAo8ZptKvNp0Tvp8uKGOy/yY8OuYjlxrDmd10t6zkQojzZdpUjcAeJqAZ5PyQQEKBWJH1G51E7vRIzNJrUzCELW13Gqwp92zNXPi5ifH+k81Y3ENpYBLZRolF9ZezULkL0YK+ngfUTMFvIoSBaY0R/vF9baXW4ONi7a30lQx0055gcf99mDuPWqIoTDncCXPz/JDOJs960ZpwB7Nm00SVvZAanQcxYNXwb/DWB5dWOQabA1aCaf5hVYfe6k4cKd/CzokX4vpk0WXDyLrZJEoZfV2AiNgdfd0hS1Mzk/wIkNeoA15W1deDe0aU/pfSkBP84OGHAOHZqUwef+LBn4yoayx5nIj02NQaXwOMWsvnh6lmHuut7DoOQMnxXhrx80LJN/Rvu/uJzJKrmdM+2nqVacdVLpv/Cww5hU1ouylGc2mKg1O3EKE1jp5NGKj1NHQU52XI6Xdt1wEg=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4737.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?KPiPGIdY9jXHDUrVYgUzqyIr7UsT+NvXX9dSH4aIK11FAJjVHCT7m7KQ3JIc?=
 =?us-ascii?Q?sh4fkvKsP180Y7Y8N+ATyHC1tBp7ziXwe12Y3+6TIKY6vr/6YBQgWJp2jgJ6?=
 =?us-ascii?Q?pjzI37/mZ4DybqA+DXEdEehU1dB+dVjizooe5UoVITumklcPoMv+u97gkG8/?=
 =?us-ascii?Q?C/Od0Px+FHxf3bSgFg0oiGMhb0W+fWI1+j9GKdSWaeMbXoVSxRRXNJExdi0X?=
 =?us-ascii?Q?e70El113OU+f95Tlku30ZtTRRj7FaZrtWdJJGBoJOsy/sjmV5DYkDvHjlO13?=
 =?us-ascii?Q?+myxKTnEdx1biY6XM4NmT7NHqGYx9PMxE48LDtwAiiQTKsnl2V4Dfn3CPgHz?=
 =?us-ascii?Q?qf5n3WD8GoLVbMgNfH+36UDzTUQoUJbY/ug3mBsAzSsUbfjimt405ob1GvfJ?=
 =?us-ascii?Q?ujFNdONMQ+nfeWLkDD3uEZWmcDgmMzMEE0C4USu2rdDMgJQq3NipiZ2hlvRF?=
 =?us-ascii?Q?xUOGcghipiOgrMEjmo9MgsKcQLNL7cKVEli1/IOzxOztcQy0/Z6FHLBliur4?=
 =?us-ascii?Q?Sk/LuI0DGLs7tFAMLz/pXkdxH9tYnbfY/uPR33IegzQidMlJ1NDp4sWf+kpi?=
 =?us-ascii?Q?HG3jMp9OigPTaX8ZQ8TwV5fOcBKH7dfmTQ0uhoE80jzLv2mfy/B6ABFbXah6?=
 =?us-ascii?Q?uzkYnYsMsa8unTvyNc2bpckOUxW19t4kA7vjuDdvJ9qSFFCkcDvx4vC/rsV6?=
 =?us-ascii?Q?nEjM/L6iHptBf7AnzIyFdhJfVA8xmYT2Lte4DEJRYtdaj8J/QWFkPBNarBbe?=
 =?us-ascii?Q?+piWVFCnEVoakGArr1j84dmYHXpW3Me4Ebn6IpLriymNQ6kjy3Khi/UOGyi4?=
 =?us-ascii?Q?JGvw06i8PoWKZHRWdP7LPWJQxWTpylkx7U/8YzEM224DRAEaSOsgmASJ5dPU?=
 =?us-ascii?Q?TO8onebR9c3QcUE+8GYPth8oN+ZZHijlFiyZQo0V00FQ8WJwMb+I94FkVpl4?=
 =?us-ascii?Q?oW/SAnGsrPpAOjknLLs490RTfTMQ7Dtye0LpTn5mepUsSH+wIg5x4QsjSvNo?=
 =?us-ascii?Q?FnHnb7Ok0jOoLoAf9+qywAm5teenO/JGfFBMbo3+WJ4wMmE2ZZt7WX10pdmC?=
 =?us-ascii?Q?oHsy/CQ2mtYTO/NQxX48CDiMj26nSjrEiwk13bluerDf2MlsrDUQ5NHZOAx/?=
 =?us-ascii?Q?12MOKY5jltaEI6zhkdZMwBKs4/zGL/jHmmkeZHg1OhX/HkWfiOOHcago1Mt+?=
 =?us-ascii?Q?2EJeq7Ee+hCScNyNGz/XU42sssDaY1wNiTtkZpDdbrjFVd5jk0hk4Sd52j0c?=
 =?us-ascii?Q?5r+zswF1dddRAgVQYplKrK3S4NUd0mJoh4njcUeciirWtKedKz0xAJ4eyVQr?=
 =?us-ascii?Q?wpTgnxit4ZNnaRskFB/VWb9wx2xSDuJKHqYePuPlp77nDSms5FNtAf4t2f44?=
 =?us-ascii?Q?yje9iRjsXP0800CeWUAGEl2qybjidd8Lfs1lxRWTHH5mc+TRk9QpTDAWobZ+?=
 =?us-ascii?Q?0Ma1K1GNaCL6fdJRtDjOsmOT1OsAXQAFtv4yw59cvbu1Hm4yUFaRKXnALJWm?=
 =?us-ascii?Q?4JuJPfDjFulzRww561GR1Fa+do8ky2mDyApQOUTaQmwWY9h+LynbVSRl8GfW?=
 =?us-ascii?Q?I1Xjw90Y0jzJi8QJduHXeyKhG9fF4ysB2IePhLNi?=
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
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4737.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7bc8c39-64c6-4e29-ecfb-08dc3e991ba9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 11:24:09.4758
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H2uOpi3J4WpRzILHM6XDRGU/Fkl4360oZLq8E1Zg6yBDHCzSraIYCWeyF/u7MC6lGF2bhzl2J/5RS2t8W+ROhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR18MB3694
X-Proofpoint-ORIG-GUID: WGK22gbNDWa6swa6X7uHMhDMLcOx2n3d
X-Proofpoint-GUID: WGK22gbNDWa6swa6X7uHMhDMLcOx2n3d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_07,2024-03-06_01,2023-05-22_02



> -----Original Message-----
> From: Jijie Shao <shaojijie@huawei.com>
> Sent: Thursday, March 7, 2024 6:31 AM
> To: yisen.zhuang@huawei.com; salil.mehta@huawei.com;
> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
> pabeni@redhat.com
> Cc: shenjian15@huawei.com; wangjie125@huawei.com;
> liuyonglong@huawei.com; shaojijie@huawei.com; netdev@vger.kernel.org;
> linux-kernel@vger.kernel.org
> Subject: [EXTERNAL] [PATCH net 6/8] net: hns3: fix reset timeout under fu=
ll
> functions and queues
>=20
> From: Peiyang Wang <wangpeiyang1@huawei.com>
>=20
> The cmdq reset command times out when all VFs are enabled and the
> queue is full. The hardware processing time exceeds the timeout set by th=
e
> driver.
> In order to avoid the above extreme situations, the driver extends the re=
set
> timeout to 1 second.
>=20

Reviewed-by: Sunil Goutham <sgoutham@marvell.com>

But one observation, loop of udelay(1) for 1sec seems a lot, probably bette=
r to use usleep_range().


