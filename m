Return-Path: <linux-kernel+bounces-129419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44783896A87
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDA6E283682
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A06134CCB;
	Wed,  3 Apr 2024 09:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="PuCAyD4G"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D74131E2F;
	Wed,  3 Apr 2024 09:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712136505; cv=fail; b=iQmkAxcPCSia6QfJF20vQafRqGTB2ehjw/z7QEPgEfXkwk8ci2XedoUws8yADEgV3rcEckbb2mlHniEdZSHDB2spfWWJ93SAR+3hsTIlEyLL6T1UH/5Coc5fdd31JXVO8zrETY+xA7ZOZv8Hjcfh0IwyjKgWSZ1vbU5XDHyqcco=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712136505; c=relaxed/simple;
	bh=/lbkdl65j5B+oAi5RBb4oCqC5mMc0U/vSlTLAlch0Dg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HRbTNW2YT8yDHC47d5NozHDbQM85d0Y8ZT35ukkalpuAtLGgQtVsNDplvE2XjrQKbMaH0P7GpWiggHgefdWRFyutq3Zi/8sov3LMb6qF2q+8oePrRE0aRY58/B4EZoTCEJZdLsQzUi0XKKGJMYaUf279T1ABbb7BjWziC1ZdbOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=PuCAyD4G; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43364hFa019292;
	Wed, 3 Apr 2024 02:28:04 -0700
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3x91h6gjyt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 02:28:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D9/yCP2/3QG1mZHcjKxEAgl54k124j5V2lnL6j/O+c8CbIHnwxgmKCNUZRECztanNnDKwjyO/ys6L7Goatvop/RfvWVHtD+RQYgW1pPRz1WHE1xd2WYz47H/UwiZr0c1V3xEIfkH4mXTetBvBgX0LdT7SpIbvFxE5iKcwiFarYsJGxdRGTwsCTG730voYwXH93LPlcd+d7WzZhP8hz5a8WpmvN3yUuqtKVoXUmGkMWyQE5Ps707ni5kTNMs5EBK03+aKIZ7VoPvwnxj442LkVI3F9n9qXzeeQZOD4puSFE+vLcRu0Mnt8s3FQ+2KPm7tmGhE1bs9Jv+MfYuMyRTpCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/lbkdl65j5B+oAi5RBb4oCqC5mMc0U/vSlTLAlch0Dg=;
 b=d6oVwV05tEp05TwXxAccJ3y+b+QHr44gETLhPKSODL6C0rydG8kXdvp0AEVNAm1pqkvIyUuZwQ+M+Tf8uad+5yMuTpm6Y1ff19m7cyla9/Zf5Gns309t5BCnd8RrlPxyqZdJY3ygQgUC3Yu2iDuoTzEgHwl1grK0xeUB0S6IztLwWKGudWkMEByMDS+Lt0wxX9rotkFRnlyqCBJjZchJJo6o1Sszwc/NZR7Ct/9cb+viKRS8gYKajU/lRtNM9QrdwTLPYdQ/5IwXlx2bh+RbZJ6cgIrrtyiOXRPB1OXII50G68wjpue0vnrsjcFSXp9o8bawUQ+Fewr3XYoS38y7Yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/lbkdl65j5B+oAi5RBb4oCqC5mMc0U/vSlTLAlch0Dg=;
 b=PuCAyD4GKgc/NfGuW1+l2yyHutSg/78qHf52lnowPqGyuVR4P9G59HRgOIfUDSH7d5XSegzASZXiOkhXhBDQ+uDncO2Z/zMjRplF9BwrVhF3gT+Ha5oJ5+Lx86ZB7tlavSY8kWEXkmGc7+civgBzRsBO2nvrj8JD+0rZbb5ibro=
Received: from MWHPR1801MB1918.namprd18.prod.outlook.com
 (2603:10b6:301:68::33) by SA1PR18MB4630.namprd18.prod.outlook.com
 (2603:10b6:806:1d1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 09:28:02 +0000
Received: from MWHPR1801MB1918.namprd18.prod.outlook.com
 ([fe80::cfab:d22:63d2:6c72]) by MWHPR1801MB1918.namprd18.prod.outlook.com
 ([fe80::cfab:d22:63d2:6c72%4]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 09:28:00 +0000
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Paul Barker <paul.barker.ct@bp.renesas.com>,
        Jakub Kicinski
	<kuba@kernel.org>
CC: Sergey Shtylyov <s.shtylyov@omp.ru>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni
	<pabeni@redhat.com>,
        =?utf-8?B?TmlrbGFzIFPDtmRlcmx1bmQ=?=
	<niklas.soderlund+renesas@ragnatech.se>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: Re: [PATCH v2 1/2] net: ravb: Always process TX descriptor ring
Thread-Topic: Re: [PATCH v2 1/2] net: ravb: Always process TX descriptor ring
Thread-Index: AQHahak4H8FO2ka9Iku6FdEF5cLu1Q==
Date: Wed, 3 Apr 2024 09:28:00 +0000
Message-ID: 
 <MWHPR1801MB19181555D42FD13C7EE2D8BDD33D2@MWHPR1801MB1918.namprd18.prod.outlook.com>
References: <20240402145305.82148-1-paul.barker.ct@bp.renesas.com>
 <20240403033932.GA1652207@maili.marvell.com>
 <b683f659-23c6-42b2-b690-e3684f37cebf@bp.renesas.com>
In-Reply-To: <b683f659-23c6-42b2-b690-e3684f37cebf@bp.renesas.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR1801MB1918:EE_|SA1PR18MB4630:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 xYVN16ZDBH8v0Do9dZ+3Xn5Nkiy6Y4n3qcaci+rSZ6rCiANujoW+qG+mjcLOmyQFAVCLzFZTIS2Tih3RK92uSWxLbYOs2dfhmWEIw/l7QzVeA4zQ+MzqxCaTdDCaU7vCLMFAYjEADeb8K/EIAnzF1NVa2sutggs2U8g+FTBa2b9xMhTbVP3ylD6wJvItZ4Jo8NbyTGGkREUaQtv/YK5h3pE99s1G8qasvqeQx74jtRfZz7UC7Id+Uaftwdkh8gLLZr9djgaAkB8gt6fssVZ+OKZXnWe6GVetjHkhByJ7dCUNicFZ0JoKH2t2Xp/9zw7DVi7rFFlRNZyBMfhw75uiAMBKpdA3gX6TMRKX2jLlW4C/PaDaM4LhiO5xWTcDCxR4z5HFCGIhBnzF4OKT41RmQxTrN5r3SJTGoUeHGbY9OxeLDTyZQCNLJusJRcE0Z9vu4PUeRim3vREaAZ96+Fv/m3gJGGFjnGpRBvl7SeN7Z9U1XYZHX+5t4xZ6MbDhW86UqBavZq9nfIhk8QRz1i71giOJ/6bHYlHeBSS3E3i8/9IcZ4IUwyD7MjZPlKv1Lg2Cy6FuNob7q57BV/gPeuWjJ5I2iiNzEyl+wIbpiYXa+Z+G/fZeB0D4oxqVNsotMXxlskNoZBXJdnLkrM09UTZ7/fMLeX4TWLb/8AfHcHxkhXM=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1801MB1918.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NnRRYnlJRjlTa2ZreUY5TWVEalFMaGZBcU43dlg5UFFxSnNWNldHNXRZZzh2?=
 =?utf-8?B?cWlmTGwxZ080M1p6dFlucW1nUmJwclAwdGxwSXk3WnBKNFk0VkJVazl1Wm9i?=
 =?utf-8?B?QmRoSE9aNzFwUm9DUFhsSi8zc0k0dlQ0djE4U1l2U29reFBnTE5RR044dTkx?=
 =?utf-8?B?ai9ERmVNckVTRWNVZVU0ZUpVSE5rRFBSTm8zVTdPOGlac2l4Z25OZWRuMlQ1?=
 =?utf-8?B?akk0NzEvWnRGbzFSSnBkeko3bUk1MzdFMG1lMzRkd0Y0eEJiMDVBM0ZCMXpI?=
 =?utf-8?B?QlpyMGxYU044ZElYRldnamVuSFo3YVFkOW01OHMvTjh3S1Y5WnZpU1g3M1Ro?=
 =?utf-8?B?ZEFmczlzdWdMYkFTbnZWOUo1b1VuZlM0bU5wUGpIdnNzZ0NSWTJnc1hSaWM3?=
 =?utf-8?B?eUdEVVY5eE5ZZUw0Y1dHTDBnSlZmak5Ld3U0NmpXY1ZBbTNIMFd3eG14T2cr?=
 =?utf-8?B?V2tENDExMVlQYnI3aGk2MTQxcFM3c2JrdWw5bTcwQnBOQWVtYzNJeU8xYzFo?=
 =?utf-8?B?ZVFtTWdlTmpkYjUvR1FXUFRYVVRlamlPL1pvSVB2a1F3OHg4bmxPZ3Bwakp5?=
 =?utf-8?B?RWtIZDNPWEpBSXlUQ1I3dDBSdXlmL2xCVS9IVThjYit5VEpzZDFiWisrMWlO?=
 =?utf-8?B?REJObzhzVktVS2xKVzd4b0orcVpNNjRLUVNuanMvZ01zSFRMNGYvazBUM0R6?=
 =?utf-8?B?Q0hpUndibXR1bU9ibXJSeXRhUnR5bndyRVpzSG9vS2NJZ0xEQ1NsUFFTbjFs?=
 =?utf-8?B?QktDaU9qZEsyWkN6RUVsNTVyZ0ttdG9KaEtkNTlBYmRoRVJTQ0QzQVhkdE9R?=
 =?utf-8?B?b3ZveERCalpFZG5LWmlOZHBvYlFDWG9vVlQ0RVB0anp5SHlCUnRrd2xxS2pM?=
 =?utf-8?B?OGxYOTkxZ0J1VkJMOEM5WndMa3lRdmNpbVR3Mm91Mk93d01XcUZQWjNuckZI?=
 =?utf-8?B?MjR1dUxpQVd1TjJNOGdtcXFTSDJLZHBVeEthSTRsNjJtd0JBVE9vL2NzTDVx?=
 =?utf-8?B?VmFlSWlWRis0K2V4SzF0UW0wblB3VFNneXpwZXdMRWg0S2g1TkFoSWIrcnBL?=
 =?utf-8?B?THRsNGxXK1kwa1k1MDRsU0YyUE43UitDOVFwTk1OdFI0R294cStJeWpNYlc4?=
 =?utf-8?B?aGdLL0NrWm55RVp5UHRaZW0ya0NPcXRpRkxlRURvTVJRVVdmREJZSndkZVlz?=
 =?utf-8?B?eWpDZ0RyUzBwRUxMUlU0OW9iTFdIcGk2MWVwaWdYUHlnOFg1eWdlTXB3bTZP?=
 =?utf-8?B?Sk5obklqWjI5YkhjUGkwbElRQzRNcEt4QVhyQXY3UWNsY25TTlhqNHd6cjhm?=
 =?utf-8?B?QXNhM0ZRMnZZSVlGaHBUSGNEK1JwV2t1bnc4cGlwTmh6UzRpZTNQM1ZBSDB0?=
 =?utf-8?B?NUZQWGJrUkRDbDhtSjZtY2xpajNzRmZ5M1dMSDFYcXNkNVNuaEV2NDRJTVVX?=
 =?utf-8?B?VFJFTmRKZlRJRktKSFRtTkJHS2VmNmFheXdNQzFUR0tENHZmM0VkWkxRMUQ4?=
 =?utf-8?B?NDhPcmNKZTF5SXVUNkNBZ0R0cUEwOHZWQ09URkwxc05uSzV3TndXdHUyd1NB?=
 =?utf-8?B?QkRJOGU5elNsUTVEVG1hSUFGMkpoMXpLTzBzamhsN2llMmt3S1N1djVNVWo5?=
 =?utf-8?B?RThOTTYxa2Jna253ME5EbEtYdURNT2h0UEsvQ3QvcHFXMmRkYTRIbjdEVHgv?=
 =?utf-8?B?cWRldEVHRFhicWRZM0pWN1dhOHBBZ0ZxZU96RGhNV3E0elJqZEREc2t5Tys4?=
 =?utf-8?B?SFM3OW95MUlpSVdFZFJkbE1qV0VKRUNOU3YxTTkrZ1FWbDdNS2tibFZ4ckpY?=
 =?utf-8?B?ckpOalFRU0d5TGw4N3JqQjRjbzZOZkMrUldTZkI5Wk0xR045dFA5aXYvRkJM?=
 =?utf-8?B?cVg2NEJ3cUhFLzNkNHFFL25RcWhKSVZJcHgrMzduMnZuSk9OV09TY0dZM2dw?=
 =?utf-8?B?K2xNZzNLYldZRFVESDRBSjZFUXRLYytzb203WUs4Z1FOdzJHOGMrVW9uN2Fr?=
 =?utf-8?B?TlFYMFdTc1hBb1ZYMCtmSEtUMk9DMDV0SkY3MTRsYkZUUC9qWW0wMWJNa2xh?=
 =?utf-8?B?S3U5VitqMHYwYUdnQkdVRi9rSHVRcnpYSlpBK3pDMVlHVldoNnNPZHBCb1FT?=
 =?utf-8?Q?yN0PcIoKCrWZM9ghGdkggF6jV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1801MB1918.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc91428-c3e2-403d-38cd-08dc53c05b3a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 09:28:00.8539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: El0nzkA5jgvtOcmyuHB3BQVHi12Xs+smWH71wB7G5oYY4ymdHKbgEafxO5FY9GhuQl8Q3UMBKE4ourAAkvac+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR18MB4630
X-Proofpoint-ORIG-GUID: Y2ZRbEzgEbo624Q4NJNS86aM1U4Yw50D
X-Proofpoint-GUID: Y2ZRbEzgEbo624Q4NJNS86aM1U4Yw50D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_08,2024-04-01_01,2023-05-22_02

PiBGcm9tOiBQYXVsIEJhcmtlciA8cGF1bC5iYXJrZXIuY3RAYnAucmVuZXNhcy5jb20+DQo+ID4g
QUZBSVUsIFRYIGlzIHByb2Nlc3NlZCB3aXRob3V0IGFueSBidWRnZXQuIFRoaXMgd29udCByZXN1
bHQgaW4gcnggd29yaw0KPiA+IHN0YXJ2YXRpb24gaWYgVFggdHJhZmZpYyBpcyBtb3JlID8NCj4g
DQo+IFF1b3RpbmcgdGhlIGRvY3MgaW4gRG9jdW1lbnRhdGlvbi9uZXR3b3JraW5nL25hcGkucnN0
Og0KPiANCj4gICAgIFRoZSBtZXRob2QgdGFrZXMgYSBgYGJ1ZGdldGBgIGFyZ3VtZW50IC0gZHJp
dmVycyBjYW4gcHJvY2Vzcw0KPiAgICAgY29tcGxldGlvbnMgZm9yIGFueSBudW1iZXIgb2YgVHgg
cGFja2V0cyBidXQgc2hvdWxkIG9ubHkgcHJvY2VzcyB1cA0KPiAgICAgdG8gYGBidWRnZXRgYCBu
dW1iZXIgb2YgUnggcGFja2V0cy4NCj4gDQo+ICAgICBza2IgVHggcHJvY2Vzc2luZyBzaG91bGQg
aGFwcGVuIHJlZ2FyZGxlc3Mgb2YgdGhlIGBgYnVkZ2V0YGANCj4gDQo+IEkgdGFrZSB0aGF0IHRv
IG1lYW4gdGhhdCB0aGUgUlggd29yayBidWRnZXQgcnVubmluZyBvdXQgc2hvdWxkIG5vdCBzdG9w
DQo+IHByb2Nlc3Npbmcgb2YgVFggcGFja2V0cy4NCj4gDQo+IE90aGVyIGRyaXZlcnMgd2l0aCBh
IGNvbWJpbmVkIFRYL1JYIHBvbGwgZnVuY3Rpb24gZm9sbG93IHRoZSBzYW1lIHBhdHRlcm4gb2YN
Cj4gcHJvY2Vzc2luZyBUWCBwYWNrZXRzIHJlZ2FyZGxlc3Mgb2YgUlggYnVkZ2V0IGV4aGF1c3Rp
b24sIGZvciBleGFtcGxlIHNlZQ0KPiBpeGdiZV9wb2xsKCkgd2hpY2ggcHJvY2Vzc2VzIFRYIHBh
Y2tldHMgZmlyc3QgKGluDQo+IGRyaXZlcnMvbmV0L2V0aGVybmV0L2ludGVsL2l4Z2JlL2l4Z2Jl
X21haW4uYykuDQpBQ0suICBUaGFua3MgZm9yIHBvaW50aW5nIG91dC4gSSBoYWQgc2VlbiBzb21l
IGRyaXZlcnMsIFRYIE5BUEkgcm91dGluZXMgZXhpc3QgdG8gYnJpbmcgZmFpcm5lc3MgdG8gcngg
YW5kIHR4LiANCkp1c3Qgd29uZGVyaW5nLCBpZiB0aGVyZSBpcyBhIGxvdCBvZiB0eCB0cmFmZmlj
LCB3b3VsZCBSWCBidWRnZXQgYWxvbmUgY2FuIGRvIGZhaXJuZXNzIGFtb25nIE5BUEkNClJvdXRp
bmVzLiANCg0KDQo=

