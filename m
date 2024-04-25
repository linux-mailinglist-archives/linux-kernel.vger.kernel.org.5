Return-Path: <linux-kernel+bounces-158015-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B8EC48B1A2E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470B71F21471
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 05:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08BFD3AC0C;
	Thu, 25 Apr 2024 05:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="MktUHUxp"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA2823CE;
	Thu, 25 Apr 2024 05:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714021900; cv=fail; b=lbgMm4haFZUUQKIIdKcoowgyfOGhT9FoFm6itOXMv5GaQkspKpJ4Hnt2pjNXQlJcGRgDZyFFlRYYJ0eUHDcJAm/rdW5I2W7Y4kNhm/jnZcqFBMO+TfF6e59TSZpQRCa0Uo7ybOOn3D67vipdt5/V7+flzTKZt1j8mZBxenUBnUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714021900; c=relaxed/simple;
	bh=NkAla3AsBELsFKv7IBgm3x2NExapi5k8cOvCpeNozSQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MSW29By2F+W/bWsgqJs5ZLAgc8Z52u30DBdsp7+7tj7Qrcf9nJqNqrp3CNEmhjHJGM3fZ33XylPN2KMOlZLv750pxvzlyvCNs33z4uqHIRc2/pnGyitmpI4eNTpJrjw2fLPQy3sS7m4V0HjYqocfAuRCdY8ajX6xNs+30p+ZZFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=MktUHUxp; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P21hwW031357;
	Wed, 24 Apr 2024 22:11:25 -0700
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3xq284bard-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 22:11:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EHwGq1/A5Tj1Y+bzWE7SuscKbDheDCaN30F4nN0lDtp82rO7bcW/+3ttxyr2RzL/z7ur8NXAQvDXet94rxFr/18COmS88z4RtBnYejMNLhvqd5pIxqjh7MzVuBIygTk/C76nQeuObpW2gBDWz92VtdTfnNrGPAUEGFMhV6GHLCwiAHzPkbriOKK2SZvrJy5VmtZOTF5o44p5I2+YNcBnAu7G7FWG5z92RkWYiqTiGVjiWcWkNl/DYu4NPCbutFvMDII9kgxQxGv5gRYslF3zE6PrtSJVVRzFBDEv5BvUiqgt7AQowLwXyjQEbPPhuzwZnA4BimGLAXo4VME/ikFdzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I9Dp1BFQZ+Te02XBGH/v425mUbkQonkhoL/QnhLhzFE=;
 b=COPhnqtuimLxKd+AW0OJ7nZnbU2vePteh2uY9mXT88yLpX81Ltwhj0qFhwDGoJUSwQyoTEZ3Z6tJbflAJ++8QqdGYPo68kexI10Cb/7r0VkF66bzDTVZVpwr+KxiiuJs2W0dZ+af0iNGdvjGpVYHc6qm41BCnrxmDufrIYWu4rAPwdLp7UZIkP04gpfVfW0p9DZBOnOtkBoe4YrOmsZR4b0u4+ZT5oIHH+6RhbRxQGzA2WV6XuBaM/6M0j2GWB0PiOJ7vRNqLljKgZtQFyjUtSJeowzTHSQAN9/5JrINVfrYfnTQPWS+vehNyo7iKWPT9jPlhHvB8QO16immQC/AJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I9Dp1BFQZ+Te02XBGH/v425mUbkQonkhoL/QnhLhzFE=;
 b=MktUHUxpgOUtZ1fvwvgrGCTuhim0JAdEPO2xhyDq8ZfsGJzZOObVqryWaeKf5EuJabXh8FEXUpnV9dJtehhTAn6o2PVkDBSMezNUjbdhBZHXS9jfu7nP2O4dB83nPFDgl/lg5XvEnv1/rYBHzaJS2T9jvPPrmViaIFrVouCTBrQ=
Received: from CH0PR18MB4339.namprd18.prod.outlook.com (2603:10b6:610:d2::17)
 by DM8PR18MB4424.namprd18.prod.outlook.com (2603:10b6:8:39::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Thu, 25 Apr 2024 05:11:22 +0000
Received: from CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af]) by CH0PR18MB4339.namprd18.prod.outlook.com
 ([fe80::61a0:b58d:907c:16af%5]) with mapi id 15.20.7472.044; Thu, 25 Apr 2024
 05:11:22 +0000
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
Thread-Index: AQHalJsVB1fMpBcrLE6y6oPYaOQD67F11OkAgAAswtCAAYApgIAA8oPg
Date: Thu, 25 Apr 2024 05:11:22 +0000
Message-ID: 
 <CH0PR18MB43397A40A3073E3F995286E5CD172@CH0PR18MB4339.namprd18.prod.outlook.com>
References: <20240422095401.14245-1-gakula@marvell.com>
 <20240422095401.14245-8-gakula@marvell.com> <ZieyWKC7ReztKRWF@nanopsycho>
 <BL1PR18MB43427F05CB1F5D153DD54907CD112@BL1PR18MB4342.namprd18.prod.outlook.com>
 <ZikaJcqEqwhN-RSE@nanopsycho>
In-Reply-To: <ZikaJcqEqwhN-RSE@nanopsycho>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR18MB4339:EE_|DM8PR18MB4424:EE_
x-ms-office365-filtering-correlation-id: d242269a-20ce-4a1c-e2e8-08dc64e625e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?KamvEpcoXbyOcV/Pw7/xQ4Z/i9ruqJ9siuWEQB/P73buCL2XD4QZAYf3Ss69?=
 =?us-ascii?Q?h8QxofuhClUkmJma58Y2+g27oilTUNmKjqzagR0OnXzx2Iyv1U7QbtBDQrdU?=
 =?us-ascii?Q?/wkPZ2ENvzG67Nxa3d0ekRtmVwoZyrNVViTL8Gw50m9YVtNqpUG7iWhMRtWc?=
 =?us-ascii?Q?jdTO60TAGsKP00f5NsmQMLLJ7OGsrchrXa/vzi2SnAadSP7Wqy4vFiED89a6?=
 =?us-ascii?Q?vt65jvZSsD+DJp8s/8sI5q30VtYjeMwRNxs+7/OSWBkyKGcFbLo5mEMKmKRC?=
 =?us-ascii?Q?oTUgMZnpYfWntqeQLQGoVUwrFIfHsbJ83y+sqqt2y2EyULDUDOsYaM9606r9?=
 =?us-ascii?Q?tXJrmj+EXjbBhDKsBcx8381GX++iV+LeBHQPUCrjdmIMY4YqZkN5tOmhBj+f?=
 =?us-ascii?Q?IOox9U+n9WfuMV7+MsjqGeKy/FZ1N2W2D9JXfqdUObzU+/NKpIZPJhp7NOCp?=
 =?us-ascii?Q?XVfAA6Af7alzCZTM7KYP/tZQOz00dyrXQqUFpodxJidODoYhgSu6bz5s8nRH?=
 =?us-ascii?Q?5pR4v++yz0ykd0DZdrpC9L3sJ2nlUBDzkOMv/ggo2d90PMuYZqQrOS7D2K38?=
 =?us-ascii?Q?NB7WfRQdgvXnzFCloQD9vt0MrISnGcTwTvWzgvSRmy3ncASxeWrWcSyICNZk?=
 =?us-ascii?Q?+pCy1/54G+6UjWN/VL9GYh0auATK6AErbAJny5rkV6nCALtxu5dw9myKvGrF?=
 =?us-ascii?Q?UWIU7LwFWQjci8VciJdmD6RJ0QG424NThcD41xsJ9j++MCPE/1BlhnH59KeB?=
 =?us-ascii?Q?Qi5Cmmf+Mn3aHqmXLEWhMSoC8zVjJBxVtgL3vnaEpd8x9dZKu9glhsK/l+dc?=
 =?us-ascii?Q?tIXXrEaudEJlef/x73ScrW2wpycafZg/svBT574sy+DROczqS5mj4hToNxAH?=
 =?us-ascii?Q?e02kKlRcgnAZcszIE6RGRvCx5w7xp4PaLlatHTYa5JOf6PKvA6pHNTHhZc3R?=
 =?us-ascii?Q?UmpCBDmZ3XMylHIuxuKUVOx94KSt42+YyFXuN8jjuXGBbcCXkgaTItA+DpW6?=
 =?us-ascii?Q?NZkHG9MAo3zkqSd5IQedpV+CqPwMqRNzd0Z8xHRQ1LfKM1BZuRgDzEIRilR9?=
 =?us-ascii?Q?sJrCU39880jAD0VtHJyxJsOHnH71S8d6RBfnvNdbQgWv+9vFBZ8KZ94PgCFJ?=
 =?us-ascii?Q?brNhdk0uHRqMQpn79ViiNV3uz3d0VfIrtyFnehLrirfRG/l3o1RSeDGBeBEl?=
 =?us-ascii?Q?5PgozeC46y4XG/jAJyEpYEem6WTdHEOfu5FK1mGzVhe1VQ0vvz09uf2yqwjT?=
 =?us-ascii?Q?qzstfjTJ6DmXY0SsWdftR70hiBx9O5lOE7h7u8Wj8jAfHWLDSAMItYcffouA?=
 =?us-ascii?Q?iF6tJ+tx4RsNtLE9AOFCvSAfaY3TSjfTEuGaspJ+S/A5oQ=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR18MB4339.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?f2Nepk1YTbIrRO+t3DXQjM/HnVwE/hS5wQcEi0oVbPWv5oa+shacVVn9Q2p3?=
 =?us-ascii?Q?tcK6hCIaZBR6n4kJfIVGv7HfhkLHqZL1ZGcqUC40moWEHB1iJGXyqn7MnRbS?=
 =?us-ascii?Q?HPR5DnLTb+0pTbKHNh1k8qKmL/Vw/49l3e0rHW/BtPVCgGAlASLwyLNK+jTX?=
 =?us-ascii?Q?7h2Q4xrIgMRWbZFpwO4VVzofjBjh8DBB93xGxv6w4xetR9C2ymslRVnAVmYr?=
 =?us-ascii?Q?HKhFdYOAdtF/6y6eoBI12kLvyC/OBzxYLFC4yCHMeVP4ke8/1Y1smVsPy6Tc?=
 =?us-ascii?Q?QKQuKIjp728j+ylaZR4PR7fc6eba/SnU59oEv+urzs25BpW3QxE9nfCpYiqB?=
 =?us-ascii?Q?bnrFJQASCQyOB1ZSn4M4dkaEy2Y+rR0FgMnQJIoKfWSYWvoTVpaOk8Du9owI?=
 =?us-ascii?Q?L01uh0XesztgFXGCkORrLlSNF5Ui1TchRtCigFnaUZ5aV5dLc3V1GOH7tjCM?=
 =?us-ascii?Q?O4bsrvIxRdNyHFKicklFzmbL7zY0S3md1nM5b5CCNfHq1jnv7CsmTxFtlEk4?=
 =?us-ascii?Q?xHEYVp9uOBYvHBpPE/6+zWIAa/B0PjxuntgoY893VL6RkWBZfJPwU9Qa1kNC?=
 =?us-ascii?Q?PbHOgpysEfyX/CoYbcy0xVXhYpH20IMZX3nd6O9w9vETNBQQ26ZUtJVN/nbL?=
 =?us-ascii?Q?dNAX7+ctLrcwuzZLI9FiKJsaZNdwMeFVMsSOBbYm5dZtrvElu6OfacoIb96p?=
 =?us-ascii?Q?uLtN0uzu6dNEnBSSEkCTqjA37TpQ0C0SAddR8AAJf9YL4mXFqad/PegrcXgP?=
 =?us-ascii?Q?kfPpY60v1L0bTJftUQ001XaBy98/w2ZoAfKok+Wtir1iR6nuDL9reRxvRVLW?=
 =?us-ascii?Q?6s2NX5ZzQzczNrHG7h/F6nsCQCKzs/dxHp+YzRPpBLqSI4qxFAB6MEku3B8S?=
 =?us-ascii?Q?Y943AF3FvSRrYRctCNTN5mh1HiYw5eSyR+jge1wAaoBRSbzEMDp0cmHlYZC4?=
 =?us-ascii?Q?ieD1bEJrYWJHgUvEmtRun+a2wLu/7udgMNf7cmWyQfLXsQEm1QrR2KSjV0dt?=
 =?us-ascii?Q?KjFi0ztL4t0b2NmRx51JgNp7AgcteI3sf8SlcHBZY4JW41QOYZ5nH6Q8/C8T?=
 =?us-ascii?Q?mHRdexum2FhklqOlEp1EIcLjWfQ+RjFdAcCi8S0PFlBQbTIsyJjreaxHATtq?=
 =?us-ascii?Q?ejkGhfnZy2M757/kRukez3RVOGjyGStWHwKvivBh3DUPnojoeHNFQ7vL41jZ?=
 =?us-ascii?Q?uQBXh6NqC97PkBZ0KhiriX7Eadax4GrVJKIk72Xr8YRO5IKXr0RsPyMHF3oI?=
 =?us-ascii?Q?/xJmlmlhAZewI03JleY70cCV4/19cvTAk7CrQMWJ4h9L7J8ffrZuFIaEn9BQ?=
 =?us-ascii?Q?9qMOEeQHmIWVLjx4dngfor6W31HWV9Xq/0XyJqrfYEGjBy0oncw5VS5PVbHF?=
 =?us-ascii?Q?GbUmJgPPqsydK7sE5fCpnnnw1T2PsCNulY24aCIgdxLvnUKmTPUATBEo3/VL?=
 =?us-ascii?Q?tA2PsWXiLcz9SC70tVqcE9W7MzT6zaaEgRosU9iX+XdfnvN0ZCmRfiNb5gHM?=
 =?us-ascii?Q?p3ax6iIMTR0U9PTHZ3HckK7SNtH0Yiz/SAJluLVmxSdvZk1qqDGOR/uF0LmU?=
 =?us-ascii?Q?O9dqcyFm4MRvI688IBw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d242269a-20ce-4a1c-e2e8-08dc64e625e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 05:11:22.0240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wrF7VB1uG44wjYDEfv3h5s0PWrfG3MgLpbM5ot0zXBTEqD+VNtC7asjI5YZIurjg501IR0UNUQ4ftFQy/i2Ccg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR18MB4424
X-Proofpoint-GUID: k1x6ZXk_RldlDoHW5yLLZPzJgSLYMn7A
X-Proofpoint-ORIG-GUID: k1x6ZXk_RldlDoHW5yLLZPzJgSLYMn7A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_04,2024-04-24_01,2023-05-22_02



> -----Original Message-----
> From: Jiri Pirko <jiri@resnulli.us>
> Sent: Wednesday, April 24, 2024 8:12 PM
> To: Geethasowjanya Akula <gakula@marvell.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org=
;
> davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
> Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
> Subject: Re: [EXTERNAL] Re: [net-next PATCH v2 7/9] octeontx2-pf: Add
> support to sync link state between representor and VFs
>=20
> Tue, Apr 23, 2024 at 06:09:02PM CEST, gakula@marvell.com wrote:
> >
> >
> >> -----Original Message-----
> >> From: Jiri Pirko <jiri@resnulli.us>
> >> Sent: Tuesday, April 23, 2024 6:37 PM
> >> To: Geethasowjanya Akula <gakula@marvell.com>
> >> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org;
> >> kuba@kernel.org; davem@davemloft.net; pabeni@redhat.com;
> >> edumazet@google.com; Sunil Kovvuri Goutham
> <sgoutham@marvell.com>;
> >> Subbaraya Sundeep Bhatta <sbhatta@marvell.com>; Hariprasad Kelam
> >> <hkelam@marvell.com>
> >> Subject: [EXTERNAL] Re: [net-next PATCH v2 7/9] octeontx2-pf: Add
> >> support to sync link state between representor and VFs
> >>
> >> Prioritize security for external emails: Confirm sender and content
> >> safety before clicking links or opening attachments
> >>
> >> ---------------------------------------------------------------------
> >> - Mon, Apr 22, 2024 at 11:53:59AM CEST, gakula@marvell.com wrote:
> >> >Implements mbox function to sync the link state between VFs and its
> >> >representors. Same mbox is use to notify other updates like mtu etc.
> >> >
> >> >This patch enables
> >> >- Reflecting the link state of representor based on the VF state and
> >> >link state of VF based on representor.
> >>
> >> Could you please elaborate a bit more how exactly this behaves?
> >> Examples would help.
> >>
> >We patch implement the below requirement mentioned the representors
> documentation.
> >Eg: ip link set r0p1 up/down  will disable carrier on/off of the corresp=
onding
> representee(eth0) interface.
> >
> >
> >"
> >The representee's link state is controlled through the representor. Sett=
ing the
> representor administratively UP or DOWN should cause carrier ON or OFF at
> the representee.
>=20
> Put these into patch description please.
Sure. Will rewrite commit message with commands and its output in next vers=
ion.
>=20
> >"
> >
> >>
> >> >- On VF interface up/down a notification is sent via mbox to
> >> >representor
> >> >  to update the link state.
> >> >- On representor interafce up/down will cause the link state update o=
f VF.
> >> >

