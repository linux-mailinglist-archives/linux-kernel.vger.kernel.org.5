Return-Path: <linux-kernel+bounces-158053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CF77B8B1AB8
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E7C21C21536
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A623F9D2;
	Thu, 25 Apr 2024 06:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="P/QAu+zI"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069403B791;
	Thu, 25 Apr 2024 06:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714025363; cv=fail; b=RUXM+sXpOXvY3bR3+95LZ9Sbw0kweZlB/Ca3I1WXbn92gvpqOi4GqNN95X/NmDLBFFwCOH7XO2VUNS4uZ/jRfrsW18iy1joL7lKMvTiXNPoNLnj9b686hjLXSJaIBpz4gOSg6GObhJJfLLdZdOL7JZ6DBLkYLaEZezPqOrpmcuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714025363; c=relaxed/simple;
	bh=WB9IalGR9iQeNDcCm5ZRm/GffCdkOoWGOA5o8xkq7d4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VYf5ziaAn0fQFWBhNB3jktAO3eMxH3+Q+QJtOKa4z9QHBnjQlTORG3HZIh9CK3oV0hpWp2SbfEQYSO3zQ2FXLXonuB4GNBrDw7a3BhukOAsAcY5RRO3MXUiY8UeAstAM75DemyJWBfObZI24nv7Iuil4Qjg5twObOS1zP9TrSec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=P/QAu+zI; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43P3kP8h002258;
	Wed, 24 Apr 2024 23:09:07 -0700
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xpxn1c21y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Apr 2024 23:09:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ou5bGj/miFdyadp9UPiDfszcl4llbO1PFpR4sdKDYUWfUdEF/muWCeHgylKqJcw/1RXBTveEbltgfEngv7xFv61K6YUPw8OG9TtSqZZ0DqQEMAQTlVSMjmCwBD+v27tXriC7977MK3XVUIRQ+lXLnandtOztfFFg3Aly4FZ4gUjmfVqHgIyxV5D1ztp9oLYONSySNn44tPv2Nm3luLvfddpn/X25A/O5ORWHWXdjbiXT6B2QSfEtifmh0H9QtJEx3PzaiFFoIBqzN/2zltIdoIp2kJrVT7q4IKIH6Hk6MY07kVJ5STp8EVkS1+nPF8JipQxQ+hqS3v6XL7Jm0lA4dQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tmIYPkgdl8FmsuZb8hERm+a1w+RUcQf1vm6QF5ZcnA=;
 b=CxSmFTtsdkUXQQyChAaW775uZxz9yYR22LHLiwGnOIcxucnG1YwKAxvAilZ8nt7+JU+Xnt6DUOFc0l+N0xQLjqm2wN1ErXe1YN/IF0DBDLNCz4SDRTIug84coWI5jloa7qLg/qL4qzvQ4TVf5gYRkkLliM+PhHXmhgM6UmjIs7AWnumWl+OoLFgq4PqCC6YPgQDKRfZUF1iO6lf/J78HfP+mXGp2oVmaB1YjksDlBlB4ND9gSrA77iO87Ze0/3Xk60WStCNXdeZgQuPDHtt1iPS8LksMctCLA44PQcWckdxIopfXN3f+N/n+qmOEt10QU05EHW+upOYfd8J+X/2p7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tmIYPkgdl8FmsuZb8hERm+a1w+RUcQf1vm6QF5ZcnA=;
 b=P/QAu+zIOZDtwtjA8tYg3KgzaoV5FsH6ve/XwxzBMeylfTtnNxxL4qLpXvUkeIrw8pIQ8sTjfX9gnFgq6QfMd5kmSXRIxQpYXlmYiKKGT3n/bWIPQNM6IJdylR4yHWXNZ2bUOkoF/ntVvrDAQkCSC6HZDlJwH+M5rcYiP50g5fE=
Received: from BY3PR18MB4737.namprd18.prod.outlook.com (2603:10b6:a03:3c8::7)
 by BY3PR18MB4594.namprd18.prod.outlook.com (2603:10b6:a03:3c1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.46; Thu, 25 Apr
 2024 06:09:03 +0000
Received: from BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::4c91:458c:d14d:2fa6]) by BY3PR18MB4737.namprd18.prod.outlook.com
 ([fe80::4c91:458c:d14d:2fa6%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 06:09:03 +0000
From: Sunil Kovvuri Goutham <sgoutham@marvell.com>
To: Jiri Pirko <jiri@resnulli.us>, Geethasowjanya Akula <gakula@marvell.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "edumazet@google.com" <edumazet@google.com>,
        Subbaraya Sundeep Bhatta
	<sbhatta@marvell.com>,
        Hariprasad Kelam <hkelam@marvell.com>
Subject: Re: [net-next PATCH v2 9/9] octeontx2-pf: Add representors for sdp
 MAC
Thread-Topic: [net-next PATCH v2 9/9] octeontx2-pf: Add representors for sdp
 MAC
Thread-Index: AQHaltcSQF6kPRO7FUa6u9PRmmEs/Q==
Date: Thu, 25 Apr 2024 06:09:03 +0000
Message-ID: 
 <BY3PR18MB4737A73191B281ED6BDB466FC6172@BY3PR18MB4737.namprd18.prod.outlook.com>
References: <20240422095401.14245-1-gakula@marvell.com>
 <20240422095401.14245-10-gakula@marvell.com> <Ziex5kCf3XwNQzjK@nanopsycho>
In-Reply-To: <Ziex5kCf3XwNQzjK@nanopsycho>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4737:EE_|BY3PR18MB4594:EE_
x-ms-office365-filtering-correlation-id: ddd2d453-374b-4244-b9a2-08dc64ee34d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?QPi7iomrCS/Jnqe32gnZJjO4pa1IC3eNphacUyjn4VNpo/eoVr3LKnTFnUfm?=
 =?us-ascii?Q?UtE9npw8gBzxaZLHKTrEEL5r2XAhF4L6VZbS0IpmpTyY2Oou5fiuv3A2xIZK?=
 =?us-ascii?Q?HmFVFj8P80UA3Qabk7srz2WNH8hwakXFx0Ro1E7jN3mfk+7BYNbj5WKvN35+?=
 =?us-ascii?Q?J3RQBg8M+kdZ9tmPH9zP5p+oCcFlcpQgo+CldjXPz3t7PuWg2UWk9J8vYnzv?=
 =?us-ascii?Q?47iQqhSbsl2z0NdyzjItg5Oh4FOtvNmljUp293u9VQbdxY6oqB7RXF166Mh/?=
 =?us-ascii?Q?k0DKNVECIxLgVZUw5PBIk98g8uazLFKnBymTdM27hQ4RrR/wWYLN90OjmpAb?=
 =?us-ascii?Q?yMO8ifyfcZAplzg4RVI+dHkQBM/L2YeZlH2Ond13IdDFioyUxJT1qEg/GuE9?=
 =?us-ascii?Q?ESz1oyglxTU3ANOv8d/052l9IRcgPKwVFD/yL5NBZ3G04ubfbIdLzx1E+NBy?=
 =?us-ascii?Q?IvoI340LyWhLJW1SL+HWcq1JE04lxtsIhCoQw3n1OexwEngBhFtIEJ9Etjcx?=
 =?us-ascii?Q?QkOxptjI9eI7M9mulaxderZ542BRT80/UcZk9kNjaH5kneXH9MasHjfNKB0A?=
 =?us-ascii?Q?XE12Y33KD/a1JhbCbug8RzD7F9MtVmsGz2oqsut1HPzsrEK3n9o72eI5oMma?=
 =?us-ascii?Q?na4HfQpyTSmSuqxwYRKg+GwnoDvVBpHM4aizfstdpWSBBbq8ohVbO/8kVfNP?=
 =?us-ascii?Q?8SQ1vYxBIMPhoK14jg3mckFfsSXTayMZex3Nv9A9XeVpMpLWmGYNlgRXEUrL?=
 =?us-ascii?Q?lOp4+TOTpbRj/u4EsmqF2onMDD0ufLgxsBPnQonZL/xfL3kAbVYGMfb4kCKk?=
 =?us-ascii?Q?nm48Ysp8EiBBOjhw81fKn0pErOTZQAyUqcgIyzvw14pofTLIAWLMtH6VraO/?=
 =?us-ascii?Q?um+Y6fwDkcEnj1DT9wynsbz98uTohtkroF7MoswEl88ypPnPMRLlFpj2XN2t?=
 =?us-ascii?Q?XaGXDtg+mW+jUI7gp4Tg77RKLx/tXRnqlwtZYmUipKeqNwx68jAekA8N+cFo?=
 =?us-ascii?Q?z45YiHWdkIq0zyKV3ZItMJD4R5XKoB1s/HV7QDYmAzgKG7e8kP5NNjp9EJiw?=
 =?us-ascii?Q?lpvmAvZsG/RsKqSmlk3SQdPFRBd+j4Q3G8tZ0QwjZXOCPqufqRKAfSu45fpm?=
 =?us-ascii?Q?ISFEbMd/fZxT4Pa+i7Lik9sBUU51dI4Dpt7LYCW5Hfn0bkhb9+c3am0Kht+m?=
 =?us-ascii?Q?72x0vbWLWdSqsxij31e793eM1RumASdTptQ33OY1mSVk3FkTGN/RajdWifnh?=
 =?us-ascii?Q?PcahQkc5oKtAhpDINa6k/Nm8EggrR7elcIqIs8Gp7SX/w/FN8wRFJm7jzDSV?=
 =?us-ascii?Q?Y9mSM1G/bBr6CqE2KBn+T59szTC6Fhi7GiVX+16zzUAmPg=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4737.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?pweOGPKBy9bRMotnR8IXEzCIDeDl32wC7YbYkJL9GOo14rPs2cleYyLVCb0x?=
 =?us-ascii?Q?0WYQoQsJZQ7hlr1fPgC6igK7g7QT762w8iUxGzPNj9Lp5ZMGeFbQhAcDsMsM?=
 =?us-ascii?Q?7od6OxgoJQoTzp5+iCphGy9ggXpLqsFNvrj52tOB02I1/kpqovE8rTprKjOz?=
 =?us-ascii?Q?BXuej4PPpYf8PPSPKmrUmMFTn1onLyR6/2UjUXJ+Asr+rqu0NHStLcEcwFzo?=
 =?us-ascii?Q?2VwT8XYgLkNSTjHjMzdPCvzUK8S/RsCqecs6PXPDjyc0pTSlG/AW0WXFwApw?=
 =?us-ascii?Q?miMUjYAHyHj1/Fi4E1WRKzGGyEsqQOZtNgfCKZOMPRDX0gJW+Q5bRWm0W7ZK?=
 =?us-ascii?Q?M74CbDk5vHKrg62lmXbY3r6Snyg/cwIJ1mZ5YSkIucX4/0kkOtpn4gTMNv1O?=
 =?us-ascii?Q?FAbZ92Vl7Pwn5CXEBnQV14ChNmqvfOUD/QH5t/kFaiXbZ6+TGAV4x8ggYxwF?=
 =?us-ascii?Q?WUxsJ3lrN4fMpcaEf8b1BnSUGRFii5mCX5VBFTneD1dKRcysUGefQvxiqATX?=
 =?us-ascii?Q?CplcHhGJ6DbfT8RjtNhWybFThSGx15555gMcXUmJ8jkOGyEZiXtTNi5M+4xd?=
 =?us-ascii?Q?wFgNsyZe/T4azUxHArcCIA2nd3nVavQSAWZUkV1g+Y6jM00X9WQiSMDb+CcV?=
 =?us-ascii?Q?fk0skDfiG1jY3U/eqzRfN9bvtu17AoJejW7CGPPQfjlIreEjR1LOLV5p9Cfj?=
 =?us-ascii?Q?JbfYFt8neqsJCMOyKDIOnDxh6ABhgXYhDGuKSYrkg5pqvHk0R59Ak4kTZZPy?=
 =?us-ascii?Q?vtk7nKybE6D8moNi1KoN4OUyUHdUVK+MP12OPCNyw2hn069ICp1za0B5Y2mU?=
 =?us-ascii?Q?GMyLWbkc/O817mbIgyQsP4CFfVUpbxv3Ii7tT8uorlK/3g1Khz6QTzICQBSE?=
 =?us-ascii?Q?ENAJzcolA2cOfDylBi7xjKY2+Y46yE/11QJ72xWI9zHByhI2ZdDLIGsh1Cf0?=
 =?us-ascii?Q?TFMncb5Mg1yVZZKFuiLT2//aMNh8Fe32Eq2wMP74jy+SJzq0C2NV5dXcS5Op?=
 =?us-ascii?Q?9GEh+bUMLwuBHaRQ4RCm+y3JD6sqgVIUAPG0GmgJHz1xM43w/+i6NwPnzxwU?=
 =?us-ascii?Q?VEaQS1El6022EjvEkoVNyAwUyjXanmCvG4bnoexxP/m+yDrwuO07MHKsGj3V?=
 =?us-ascii?Q?rqhmFwzgqB5OHPKqHdxBs3N0UUI6n7cNpt4nHq20edNtsdXF5/WhnlqonCdM?=
 =?us-ascii?Q?dvTFOlb3fdLwQjdHdzjNto9+R5LMTD+CMPU550h/GtCC8Q9iuFd7wVDc+N5D?=
 =?us-ascii?Q?TQeShtLdShxX6Bg+aXezfaU9AxHT9V4pFpoiIj85H4IIRWaaWVqfdk+32VPa?=
 =?us-ascii?Q?WQZ74xNGPkY4FVqgW/8nd1IEtJvuCt20EWv8pljSPP6McRSLxYhpCoiFv0hM?=
 =?us-ascii?Q?nHyC/k2CbODjsmXS41mTXIKpaA3BQIaq9f/VFYDOcdq3uZl4OoO0IkNoah32?=
 =?us-ascii?Q?kEurc9iRYu8blWC8K2wotc9scyBgeWxbYT23q2lS1ZvZ6BZYclzGywpEZ4RV?=
 =?us-ascii?Q?bS1hBYW+d+pYkMxq6YnjYwtz/BK9AhDjgfOzQY4Sph/qMJlyGT5nMz00oVN6?=
 =?us-ascii?Q?XXycCrVFwkto7A4N/EWz6aiASriGak/oYoFyG93k?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ddd2d453-374b-4244-b9a2-08dc64ee34d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 06:09:03.0918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3eCVbTOffBJKRorfX4h/czBrKEhwC6MRtuT1RdpQAUUaOpPKJeML7cX5yE3V/zQ95cAbrgMuAvZ7CAvojjS95g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR18MB4594
X-Proofpoint-GUID: eKTNycTk-PDULAwNyov9kRgcy62j6RVD
X-Proofpoint-ORIG-GUID: eKTNycTk-PDULAwNyov9kRgcy62j6RVD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-25_04,2024-04-25_01,2023-05-22_02



> -----Original Message-----
> From: Jiri Pirko <jiri@resnulli.us>
> Sent: Tuesday, April 23, 2024 6:35 PM
> To: Geethasowjanya Akula <gakula@marvell.com>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; kuba@kernel.org=
;
> davem@davemloft.net; pabeni@redhat.com; edumazet@google.com; Sunil
> Kovvuri Goutham <sgoutham@marvell.com>; Subbaraya Sundeep Bhatta
> <sbhatta@marvell.com>; Hariprasad Kelam <hkelam@marvell.com>
> Subject: [EXTERNAL] Re: [net-next PATCH v2 9/9] octeontx2-pf: Add
> representors for sdp MAC
>=20
> Mon, Apr 22, 2024 at 11:54:01AM CEST, gakula@marvell.com wrote:
> >Current silicons support 2 types of MACs, SDP and
>=20
> What's SDP? Care to elaborate a bit here?
>=20
>=20
> >RPM MAC.  This patch adds representors for SDP MAC interfaces.
> >

Hardware supports different types of MACs eg RPM, SDP, LBK.=20
LBK is for internal Tx->Rx HW loopback path. RPM and SDP
MACs support ingress/egress pkt IO on interfaces with different
set of capabilities like interface modes. At the time of netdev driver
registration PF will seek MAC related information from Admin function drive=
r
'drivers/net/ethernet/marvell/octeontx2/af' and sets up ingress/egress
queues etc such that pkt IO on the channels of these different MACs is poss=
ible.

Thanks,
Sunil.

