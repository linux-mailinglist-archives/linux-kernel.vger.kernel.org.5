Return-Path: <linux-kernel+bounces-164242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC718B7B4C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:18:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1234C281D94
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:18:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F6014373F;
	Tue, 30 Apr 2024 15:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="IE2G/teV"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961D1143720;
	Tue, 30 Apr 2024 15:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714490270; cv=fail; b=XesEAjWqAO4356dF3SgDNo+P5PU1NNenTEdOmidxrgGdB+yT9oRxedR1LjPpKQYCGzKSCHoMx5gYt4zonIPLzep37sI6Jd279wfU+45YF+hnO+cvEQtt5oqGleqLS7DnPxKhhom4Wikts5RoD0Oq5Txp8Wdc1/hfoTAygGNFbTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714490270; c=relaxed/simple;
	bh=rNCoXK/oIPVjzqEsd0rzs4qvUsEBsPTW4fKiO1lSXh4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YVNstbuNni9Y7Jte2Bt2Mdsic7HRmDXsVeGFt2oYG3DmxtUNQhwqXZQ2ZheAvo3LHrBWjHXw2BHNZdLtSxGjmYMP1Qfl4+kIYdmO9cEeNDzFKL1GiCaz8cweEROs/r94siPG2o9veQimCBDP3Dn1kutgBMy1lMW7IJYVOl+z+50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=IE2G/teV; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43U9Fg69032428;
	Tue, 30 Apr 2024 08:17:34 -0700
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xtwuwhb66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 08:17:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/KIs+op/7UWAcuwGTeJ/ELlCzrZPEm/nuGRB2i/ZgSTSAP/hNQlW2aYsKudP2fxpFcL0ncXe6kLQMytmOkNf3w94xMHPBpKF5gM6I1E+CmFALvMtnGmE403VE5gPNArHKkzpOVJ7MIvwqilqhZXBdSrpZXYDlf0ZEfdlXmXQexGD1eOzqM7BFdJi6rKH/gGMv3gj+ZmLIMUmnPb7uAOSACgMJ0J0yB4Ze3UHton0mkpGLRp7dFrto+tmnMsSuU9pzeqpiOVNLMH4SQg/MM+KOlHi1+SZQ7yqnw6yY44a8gKk+yhsEFbVbWBErfCSId0ikTaV1E8y5CT6i85xR1Ilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNCoXK/oIPVjzqEsd0rzs4qvUsEBsPTW4fKiO1lSXh4=;
 b=lQ2LVgzoIT9UhhauWV5RX8BqQGaD09D06TrpO6ji5RWkV6swV3uer5RNWX97IcQ8dtO0/g+Jbd20V2+9ymW7aZJ+SSNqDmfBtLdQ34U/2279UHnQaAol5b7ybeerRPcWob0ahwxdEGO857SgbePYDu0zBBxhrTOT5V1XZ14JzrbN0RMTfbukryTAPhH0IbJnTgtCsKWvdYvrSUvwXxhWK5aceHf9XfikdHLFbT4Sxh/+CkTUEEJeS6Jd+Wc6L5Kf8+ShmGRElg90FE44IFqHkmXmr/0lT/VCtxRLw6lq3fjRgf3AEx6Zu6Fky761RBnRWpOciCtYpIlld7u2BHEQpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNCoXK/oIPVjzqEsd0rzs4qvUsEBsPTW4fKiO1lSXh4=;
 b=IE2G/teVdcDBpo/G0EX97GkcxV/GRpVQS/9LedcWFI7gZ990oTmzI0aG+ELktapnCZICLtp05PTaQsvOrUZsiJjNFi7TKMpRdJssCqt7AvEJgozGkNogbzAwULEC0KuNAb1m2a3O+zPoo6ggSoKot73N/wntxY33AmOLMn+fqFg=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by MN6PR18MB5544.namprd18.prod.outlook.com (2603:10b6:208:476::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 15:17:30 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7519.031; Tue, 30 Apr 2024
 15:17:29 +0000
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
Subject: RE: [EXTERNAL] Re: [net-next PATCH v3 3/9] octeontx2-pf: Create
 representor netdev
Thread-Topic: [EXTERNAL] Re: [net-next PATCH v3 3/9] octeontx2-pf: Create
 representor netdev
Thread-Index: AQHamVpOk4r/tpYYKkK9e3oUMm7yXbF/H2GAgABOIvCAAPb6AIAAi29w
Date: Tue, 30 Apr 2024 15:17:29 +0000
Message-ID: 
 <CH0PR18MB433976CB436652D485C66FCDCD1A2@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240428105312.9731-1-gakula@marvell.com>
 <20240428105312.9731-4-gakula@marvell.com> <Zi-Fg7oZBCtCvbBA@nanopsycho>
 <CH0PR18MB4339BF5712F2E93835E1EA08CD1B2@CH0PR18MB4339.namprd18.prod.outlook.com>
 <ZjCWPEony0Q22AEt@nanopsycho>
In-Reply-To: <ZjCWPEony0Q22AEt@nanopsycho>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|MN6PR18MB5544:EE_
x-ms-office365-filtering-correlation-id: 52b81b85-65cc-40a4-0a62-08dc6928a6bd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|376005|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?UayWGQYUbpbjJ6QwUW/RaAu1cU2IPdTs4njZzcVpsSqJLjPBd8d+V2N25ul1?=
 =?us-ascii?Q?7gk7W2em/vaYgDzSALQZM7XhTs1vYnf2+UbnnxIcc08kA+oGM64FEkR+dBDr?=
 =?us-ascii?Q?G9i8BkmnGi6NeNjLy32j8mt98CkTf3n/81vfwKlNkTEdfV4P9AAfH2G53F7P?=
 =?us-ascii?Q?y7LrrSWaLhX8E5DQgbhVCgfjwM/YkOZuhOlUNwI4FFhhLHvbnGDfJKTNN3yQ?=
 =?us-ascii?Q?cnC9l9d+QsV6R6dqhSV2rs7uxC811VYHSf4Ty52SO74sXT0Bm1XHXh4XfMuT?=
 =?us-ascii?Q?kxpW1OBvdCBm31hK/29RkwMSQ+HgJpOBIFWedG0aYhpADijnQdJ2Bjlra1ZH?=
 =?us-ascii?Q?YDLc9RJ6Z3tmh6GeAP7G1Njflwlfn7WxvFQt1sBC6xNjQ21PMQ9epA7EZW7k?=
 =?us-ascii?Q?cVE0i0zJJAIBfggmARepshSQQqKnFC3HoJkA06MDLfm7M7fWZhlolS0xHy0J?=
 =?us-ascii?Q?6QskrD6sKCDJrJ/1YVA41sulviKytbDevcl7V9zxHSgmxfsXHeuauDo9LUfP?=
 =?us-ascii?Q?mssTy6UrA5U2azc2fPmGSeBcVjR7cEJ5znbIz+JL/89MgcPsS6lx4/wMRQo5?=
 =?us-ascii?Q?FCaTWFT+An+JaQ9cpc8H3nGXXz3fyJBnA+s/2sUSCl1fdj47ern9Ri/WsW6B?=
 =?us-ascii?Q?ootwr0H2FB2Rx08kSvIFEpDAoi+xu1dGNawPUWiyo7pikAuimCSHDrbklCB3?=
 =?us-ascii?Q?6Hb5T8S7rwlPzhvRboLquQUWi6+O0yJqrdU/IiEDy5HehMM8g7hq2d0tWr+B?=
 =?us-ascii?Q?5OA9dnxnOwA24/hM/xrS1E5p6okvvOt8BpguCzioqVuLzd477+7Spm6nA+Nx?=
 =?us-ascii?Q?TyjT1kaDzYr/NlTmQR84Gj4+Hcj6FTN6ISDDNPepiE9qGoZnAI61Tg1hXc7w?=
 =?us-ascii?Q?NF9LJ8nAQlxzRE+FurtneBa6mH36f1qj2PMrLC890FCl3TQz4lvTsWAkkoRv?=
 =?us-ascii?Q?B4oNOhnlOZOjjO5njBM0boC3ec0O5FRsqFJ+C+n59KsIF0IvsuAe1egpgq/+?=
 =?us-ascii?Q?7bs1uqhqoa/o/4KuBG2kYV7QmC+f/zLs2IsIzqC5cz4NbolymHrb1QtKy1wE?=
 =?us-ascii?Q?MM7hVfEeGKNKuce13P925yYq7bD0FD1fgrGwhg8Nmxd9nkPWU7NE6eKgANkq?=
 =?us-ascii?Q?yTP28ZDldv9vVn2+l5xRdxjR9qTXOWgY5uEkYTAPPShClDEDeamgmt7GIimU?=
 =?us-ascii?Q?vbNMwqwmXrBlLP5Br+PimzToGKcH5xE6yqrPtXigWX3ukWX1obUwsyIn3qZk?=
 =?us-ascii?Q?XAPWO0FOSIASKUewRzfU0Q7QNX1yD+n52Rec+wLCnAF8FB8bmlv/HFwvzPQZ?=
 =?us-ascii?Q?HkgZWLAluLFoveTqwWRevPz2IngnMkiZxnWxu/tk83zaNQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?Lc0kxkB3ezRvDRyUZVJ5xsuKf+/8vQpSTmKIUjfhEwMOXQkXz4ANIvEvfZIB?=
 =?us-ascii?Q?RjIUyKrjvcIsrYc5AquT1d8mBJBAQw9ZC0tMYBk97LUsrGRovx+stuq6NDXq?=
 =?us-ascii?Q?r0wbZ8y3IHXKrLAdCK05XyrZMqfp6pwUuXQPXWcLsqnA0Y8DBMCusVzk0moX?=
 =?us-ascii?Q?LAKHFSpPpG73uybnq0ddfKf41ibtljzBeyQeNpTmC97ukyw98R2I5n+8Bs7y?=
 =?us-ascii?Q?xkBC2wcBl2Y963baAcs6ffVipHpThEt4AVy3F9pMfbs3USDXs1yiertopTOw?=
 =?us-ascii?Q?stiuKjHg3FKjs/nmc5qYzy3FTYqX0FyFbNYKDQEztKhBD3wLVlOeyaLevUgE?=
 =?us-ascii?Q?w17gOtvk+HvQEfSL4LTvmBBfEJJxpfOkXumjeY/qY/5f/xeZ5WOO0p+4/0qQ?=
 =?us-ascii?Q?U1icIS+eeajFbrI/lss74trSNzSf62VBpgXqgsUpyuXsztu0UEzcZqXcXkny?=
 =?us-ascii?Q?rcUDfH3W6wFbgshcdltCvF7hdlSRmeBGl090Rd4nEKuxWUdijITnRLjEWxkd?=
 =?us-ascii?Q?i9//MEjHCZgb3STR0/ypC1+vAOJhODIRBqaf8JcCnnls2BM++rz5YmHWqGug?=
 =?us-ascii?Q?tmaPw4dF5txEesqWOEZwtNdHu6sXn/o82QaJO17aqjxK8F+DIlQTTKvWof3F?=
 =?us-ascii?Q?erbj0tMQ74hHs7oh9tjgqZQJItcFGQw1fLBO30AV5GF0GfisT+t1Fi1hP5kL?=
 =?us-ascii?Q?PkHWuhlNek9n71eHMKh/VT4fM8Jisj8X0dO7iEsNi2hanreM4vsdiE4IczYJ?=
 =?us-ascii?Q?fERoUjOkhyFSYK1E8yCTJfxjYLTnR9Qq8Ai5FArkiu7QNztSSQEnj4aoaoK0?=
 =?us-ascii?Q?qsaylDkkYL3+jz8LEUs/6gPfmjUR0KwNHi7pw6ToV8fKPtTUYVjeslBfhp0R?=
 =?us-ascii?Q?8cYGaCkaXWYlObLeqTPKmpfNqpM6bYIOLR6E2MqEra/2qkxFLRynWCmUFUkS?=
 =?us-ascii?Q?d9aJeUAtIoYrx3RPstaKtVEixk7V5VH0g/uFbHOCvZ0odwvfgiPNyCFJY6Ne?=
 =?us-ascii?Q?mHgt0RRNZDc8vyVWww0lbd+w1oH0m71Z2NcY6zsrcD/F/UVDbJrpTEMdpGMX?=
 =?us-ascii?Q?hVPkn+1N/8NgCvqej0J11EiTpv+po2C4TkrLl6yONaP/5bZ8gh1G8oCiBGcs?=
 =?us-ascii?Q?H8788huhfYnkJHLNQH3TuN2ZhMs7ZzzCoRcOTnvd3uCqSTixh8nfT/Fu9njA?=
 =?us-ascii?Q?wrqoUTJMjWzYa9K2tD9ixCOfovBFQJKLHQbpcvhC3rBMJ0umXlPpYmXP653z?=
 =?us-ascii?Q?nIk/w3dc8YBzDl2VJt9z9iJMXjUShxSKbg6a2Ae+hcuhnOszrc9F/X/+Zv92?=
 =?us-ascii?Q?VL28OFYSuV4o2U14sPeDWTGjb5jVfKr86y4z/zINe0hfLXvl2ggcRw/ChPWW?=
 =?us-ascii?Q?yV4YDqJovQayhA4FFAuIWSK/kwe/h57s5TrKaO/a7D9hElyVChIKywcxQ3xW?=
 =?us-ascii?Q?zxv/McfX/IAOELhRWHWNnQ2vDkZkB5ZDjRZEa0vCon0LjhlVM1QHv4R3HFeM?=
 =?us-ascii?Q?c/bjoN9UFkjHZU3gcVIyDuHa0PKXbzq4v78h4/Mzj6MLrYGsjej5j/dHhV+a?=
 =?us-ascii?Q?KfQ0ABo9XkxouRAio5E=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b81b85-65cc-40a4-0a62-08dc6928a6bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2024 15:17:29.6587
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UBSUJRjmSWbWC44tIr/+polBhEJ824EqOsL87De4EuipkJ1NnFAASApcFgO44nZNYCmJ8WlKWBj/9jlLNYeR5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR18MB5544
X-Proofpoint-ORIG-GUID: DO6A6WIAOx5231HFifs8rPDnhxzkoxgZ
X-Proofpoint-GUID: DO6A6WIAOx5231HFifs8rPDnhxzkoxgZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_08,2024-04-30_01,2023-05-22_02



> -----Original Message-----
> From: Jiri Pirko <jiri@resnulli.us>
> Sent: Tuesday, April 30, 2024 12:27 PM
> To: Geethasowjanya Akula <gakula@marvell.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org=
;
> davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
> Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
> Subject: Re: [EXTERNAL] Re: [net-next PATCH v3 3/9] octeontx2-pf: Create
> representor netdev
>=20
> Mon, Apr 29, 2024 at 06:13:56PM CEST, gakula@marvell.com wrote:
> >
> >
> >> -----Original Message-----
> >> From: Jiri Pirko <jiri@resnulli.us>
> >> Sent: Monday, April 29, 2024 5:03 PM
> >> To: Geethasowjanya Akula <gakula@marvell.com>
> >> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> >> kuba@kernel.org; davem@davemloft.net; pabeni@redhat.com;
> >> edumazet@google.com; Sunil Kovvuri Goutham
> <sgoutham@marvell.com>;
> >> Subbaraya Sundeep Bhatta <sbhatta@marvell.com>; Hariprasad Kelam
> >> <hkelam@marvell.com>
> >> Subject: [EXTERNAL] Re: [net-next PATCH v3 3/9] octeontx2-pf: Create
> >> representor netdev
> >>
> >> Prioritize security for external emails: Confirm sender and content
> >> safety before clicking links or opening attachments
> >>
> >> ---------------------------------------------------------------------
> >> - Sun, Apr 28, 2024 at 12:53:06PM CEST, gakula@marvell.com wrote:
> >> >Adds initial devlink support to set/get the switchdev mode.
> >> >Representor netdevs are created for each rvu devices when the switch
> >> >mode is set to 'switchdev'. These netdevs are be used to control and
> >> >configure VFs.
> >> >
> >> >Signed-off-by: Geetha sowjanya <gakula@marvell.com>
> >>
> >>
> >> Are you still missing creating of devlink port as I requested? Why?
> >Sorry I missed your comment on earlier patchset.
> >Wrt adding devlink port support, our plan is to get the initial patchset
> reviewed and then add 'devlink port' support.
>=20
> You need to do it in this patchset. Rep netdev without devlink port is
> unacceptable from my perspective. Thanks!
Ok. Will add devlink port support and submit next version.
>=20
>=20
> >Will submit 'devlink port' support as a follow-up patch series.

