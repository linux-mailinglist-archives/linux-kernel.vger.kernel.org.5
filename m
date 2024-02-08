Return-Path: <linux-kernel+bounces-57539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9A084DA6D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 07:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C1DD285570
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 06:55:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A8C69301;
	Thu,  8 Feb 2024 06:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b="pqmJvfqr"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 961BE67C74;
	Thu,  8 Feb 2024 06:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707375321; cv=fail; b=D5BH0eJsqCSEaqYakJzCI7oZHevHrmmNaosOupDlGkfm2xBlFH08gM5vQr9SKYR7A9ws1gMTAmhZK9I3dlajZCo5Hv79lhWrGRoGaOT8rdsBaQPtSKmYLmN2Vm6pw3uDTSsZQ+ajRZ/aVSFLur+UIlYfPZSWUoBl/Eql5UeL224=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707375321; c=relaxed/simple;
	bh=Qne2Qecf0ZUwnQmBwpTo20Lqa0KqSrWVic7mGn+fNAI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hkyNYoY0M8V5Lq1RpzeA7XIXjIWS6TXVI0dvmMwM5EQr8B3UikVaVKvcl7Y8kmVNaobGL5GEgtcNYDlGgVZ9rkPFP6A3GR473LgfmzYpKn7i4NzfYNk4zuiPSziadM/YTh+lkVCRwW42c2lIZfhvMdo0rGOFbv3F4RR81O0Dtc4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.onmicrosoft.com header.i=@marvell.onmicrosoft.com header.b=pqmJvfqr; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 417Jm1b2001478;
	Wed, 7 Feb 2024 22:54:54 -0800
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3w46k7w59d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 Feb 2024 22:54:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hpd34xB9347xZZ+9ApQNH+xl9ltET3zJCNNEqN2zfwFYylfxMGUtsFhR11AVBA2vFB8sQoMzq2DZaAQcL/OydI8TZquOjMlgO4e0IOvljiq0lD/RV1ooHoLswDYRVeIyZuCnRR6WY71vERGlIirUnGVMj9JRByMLzfUiplIQYhpbEhMeSYtYpaBKotrb69lqDk/cdt56hcVtQKC+Fq1F4jBSFeUgWy1RaFs4KH7pMu7Y3clcR1HrkcnuGC2PYJm73u2RJ7/wSGPrtAFUxhQgckvTAzPeje8N/xfOJV4wCF4N662kPwlDa+s6oKooBt/4fOJVswyMWIQRQ5TejrKu1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qne2Qecf0ZUwnQmBwpTo20Lqa0KqSrWVic7mGn+fNAI=;
 b=GwYbt15YkrCA7+BGA/EpmH+2B2oVUPkbPmkhYfdixMz5V/lgkYVI7glMvWJwKseqijaVJFP30qZR0H2elhML3R/qtt+KOnM1hnHRIhHZUoysrzAwx/LnIvUdA9bC4m8LZ1+O5X5OCuHK9QBMLLtndA2SYUPqCxoe1tezc69Vwy0r9iKhjXcH3rkt4cSg1Vv5wGfrkV6eD88In+zZhdcnP9YEfthtDNbnBgXJ5cn9jmDpl9BzViniC2oFFX7jtpB7PDKmefkplkFxwGqXrj0thiz23uFGwxpGh0VTy29ZVYFubwZKmbK6Ir2e17TRPQEUmRjULqiIKkRS/ShkddzmEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qne2Qecf0ZUwnQmBwpTo20Lqa0KqSrWVic7mGn+fNAI=;
 b=pqmJvfqr6MTBpn1FA/MQagDhJfrcIwPEEvGXe2svv0ez463/eXwtqKSpXsk/tol9Mc75N+yKxpltYTD4vV+uaSn9CVQqhc7S1an2kI7s7r8NLNgGU5v8SUlqRZjf4BTBsOIzVD8KC615lFB8tREIXwDiRcLgEGQuqSagdqxBkdc=
Received: from CO1PR18MB4729.namprd18.prod.outlook.com (2603:10b6:303:e8::13)
 by MN2PR18MB3527.namprd18.prod.outlook.com (2603:10b6:208:267::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.24; Thu, 8 Feb
 2024 06:54:51 +0000
Received: from CO1PR18MB4729.namprd18.prod.outlook.com
 ([fe80::4de4:ea89:9e4e:889c]) by CO1PR18MB4729.namprd18.prod.outlook.com
 ([fe80::4de4:ea89:9e4e:889c%3]) with mapi id 15.20.7249.038; Thu, 8 Feb 2024
 06:54:51 +0000
From: Shinas Rasheed <srasheed@marvell.com>
To: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Haseeb Gani
	<hgani@marvell.com>, Vimlesh Kumar <vimleshk@marvell.com>,
        Sathesh B Edara
	<sedara@marvell.com>,
        "egallen@redhat.com" <egallen@redhat.com>,
        "mschmidt@redhat.com" <mschmidt@redhat.com>,
        "pabeni@redhat.com"
	<pabeni@redhat.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "horms@kernel.org"
	<horms@kernel.org>,
        "wizhao@redhat.com" <wizhao@redhat.com>,
        "kheib@redhat.com" <kheib@redhat.com>,
        "konguyen@redhat.com"
	<konguyen@redhat.com>,
        Veerasenareddy Burru <vburru@marvell.com>,
        Satananda
 Burla <sburla@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric
 Dumazet <edumazet@google.com>
Subject: RE: [EXT] Re: [PATCH net-next v6 5/8] octeon_ep_vf: add support for
 ndo ops
Thread-Topic: [EXT] Re: [PATCH net-next v6 5/8] octeon_ep_vf: add support for
 ndo ops
Thread-Index: AQHaWZJDhRL31pJsKkmO0QSKuJjTg7D+hueAgAF859A=
Date: Thu, 8 Feb 2024 06:54:51 +0000
Message-ID: 
 <CO1PR18MB4729F6BCDB221F9E61551000C7442@CO1PR18MB4729.namprd18.prod.outlook.com>
References: <20240207065207.3092004-1-srasheed@marvell.com>
 <20240207065207.3092004-6-srasheed@marvell.com>
 <CAH-L+nN04MuWS-QOxpPfQMD5iAvdZPFCp0nffuhB43+puLgk_Q@mail.gmail.com>
In-Reply-To: 
 <CAH-L+nN04MuWS-QOxpPfQMD5iAvdZPFCp0nffuhB43+puLgk_Q@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR18MB4729:EE_|MN2PR18MB3527:EE_
x-ms-office365-filtering-correlation-id: 9b436445-f187-4230-289f-08dc2872d946
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 pnMaf0rKvlXBScRAxvUjsio+UY0+fA5689mx8sojef58F4zKn4roPksKiXk3Sk23AN/JoEnorxdJDyAd3LYX5Mt9kAYt6lYHK1+bBtydsPSVWTJdTuuuh5ni59bucId16K3yS73Trp69Bo2o3hI80ikANIdF1Sdvi0B5amQgs34Q6scSlIDWdSscIYN1+zLQNyCPzW6tg18Yl3IwdPyQlprsveZPvx0kCvMYFXwDaZlymmkq1QYwX9/AS3Z0i6IjSCS8zVHOJaW2cGmqc34qRB6ozTaq/4vAk2zlU8BCl467duMeREjeh6RuVpo4gkKQcw7uUkiH5wzgggS9O9GhJJa8LPNvNn/W/Gum7VArKP8ivUXqvoEtypwwww/2d8IzpE1DYKanU0wnDPjWqIZ4FYodJixv2hPlpDD9zqxgbVbp4OKKHrrzyWRIwRpoApAarOFHP154VVV77/cySa7s58sq/3PUvTmLxUecWbX6LNuhb2JgzsEAlq+SHXCaiDN52QPNRQUmRhC2s+M1f8/4vQ0G7GXXLyGvWIPirso1Gufj2yosRSv7CazxNFn5yge5+B+jk32Qev8mPYJKaRy5qpBW1xDWJeXXwc1K/QbIx8rWhHCP6SJvWwd1eC1dO+Cw
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4729.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(376002)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(5660300002)(4744005)(7416002)(52536014)(54906003)(316002)(41300700001)(2906002)(38070700009)(26005)(33656002)(122000001)(38100700002)(86362001)(8936002)(4326008)(6916009)(8676002)(76116006)(66946007)(66556008)(66476007)(64756008)(66446008)(6506007)(53546011)(9686003)(478600001)(7696005)(71200400001)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?QWo0K1hBOE1rb3M4bGEzU2pDVXg4K00rRzlGQkxwODc0aG5tcWZvdWpBSHhk?=
 =?utf-8?B?WTQ2YllXaXhRUHM1K2prd0d5NlIyUy8zMGx3QTY1NHJocmhGMzBBVTZHa01z?=
 =?utf-8?B?dFhkRER4aHUzZ1R1Y0RkM0xOTGtKWWtsMTlIWHlkNi8ybkJ6eERyQmMrNnNl?=
 =?utf-8?B?QjcyUW1NcUJlTnplbnJWQ0xSQm9RSEpqeU4zZDNXWEhGVFJxUmFmOFdoWWhM?=
 =?utf-8?B?WjdveHBmZWFjT0UvQmxWcld5R3VnaHI0ZCtOc1JYeDhMODNtL3cvaDViQUdo?=
 =?utf-8?B?N2hhNTJXZTdxZmVQR2VJMDJhOWk3S2hzRklRblBjU2hEdDBheW5kbXlFVEh0?=
 =?utf-8?B?bStucExKQWFMWDlwclkzS3Z6c0VLelZEclFBUTRLVUh4M3JLUVlzSFFNZS9o?=
 =?utf-8?B?SlE4eUFhbm4wN0RXRVArRVNZK2hWR25LRUFWOWxtVHk4VWpocDFoVzN5NFJj?=
 =?utf-8?B?N0l2UHFiZHVBbnFHdXFVanExMUc0c0F2QmRUMmpKZFRiczdsRmVTa1h4SFly?=
 =?utf-8?B?K2ZHWEl5c1NTOFREMUtTb09ISHJQVGlIRXBDZTZOOEFNUHNobElrbldtdC8z?=
 =?utf-8?B?TDJBS0tDTktsWUhSZm8wd25Dc29qL0RsWE1zY1VFaEhFUmYvZE9EZ05oTDN4?=
 =?utf-8?B?bUNPRG5CTWNaUnFXZkJpMlEyTXJ0T2MxUzN0NjRhbkRicG9zM1UxdFBoZk5n?=
 =?utf-8?B?cWlpRWdVQk4rYlFGSGpwdlBORmhURENaSmllMW5GSy9KZFdGOTJUYWhCN0Y2?=
 =?utf-8?B?NmY0U21IUWRib05zTTBPMElPS0V1VkV6WFN0bEhLRVlYTGR6Q2xCVFdhQXNk?=
 =?utf-8?B?cEY3Z0xTcWVORU5Jd1VUSHE3dmVLYWE2NkdjTU5mUFN0WUx1NTBpR0VSeml6?=
 =?utf-8?B?Rk5QRXYyNlJyZlhhNVpmdEIvRUg1VktXalZ3N1VRZzZmMlR4b2lxYWJLQWh2?=
 =?utf-8?B?bGxFUEZLa3ZlL1c3R2tPOEpwVmRCZXlNOXFIYjVSa0lXYUFPd0J0UUVCN2NF?=
 =?utf-8?B?aU84cUZoYXl1ZlNJZE5XbzN3dnBxTmR6K2RSODRwWGtKNlhyY1MzWWg1ekRl?=
 =?utf-8?B?K0dRZXlqYzNZcnprRUVvNFlpWUR1VzdMZE1HREFpUE93V05wRlNveDZPa0RQ?=
 =?utf-8?B?LzhGcWllWHozR0sySGM3a09KcEIyZ09nZk1VMlRHLzNEQWxCZTFVcFVDWTZ0?=
 =?utf-8?B?a0cyVTV4Q2U0VnptZ1VOUitlV0VPOVlrQ1V1L3VBWldiWTRCejVPV3dlcTN1?=
 =?utf-8?B?cEY1MzVOVThlcVE3QUtDMjNYcnA5RktNMlROOS9ReHlyV0l3bTluMGpHV0pH?=
 =?utf-8?B?Zmx2NWtPenJRQW5QMHYrYUdDMGFxMVkveEpWSUUyUkQ0S3ZIOUxzeDkyckZX?=
 =?utf-8?B?WXhIMWEydXR0YWRrS3Iybmg4dy92WmtNS08wdUM0TVpGM1pwWDVCbnZNTGlW?=
 =?utf-8?B?OFBQMW1ad0lkYUsyNGNsbW1xL1V3aHF0L2VkTFI2WkxUS0RERFFqWFVJWldX?=
 =?utf-8?B?WTgxMzNaOGFMaGFkM0JjUS9kSStHanE0cERwcUd1WHpxVGEvT1dhU015USt0?=
 =?utf-8?B?b05kakpxN2lLd2Izc1lheEVxR1hTRVV1YUZDOEdhTkZRZi80VkhWa015TGx5?=
 =?utf-8?B?K2hRMHhXcThBdVhKRDlsUW5JKzNyQ0QwKzIxR0tpZjUwampMTU1kbzk2UlVq?=
 =?utf-8?B?N2tCa1BuRFNJMytYYVRtM00yN3NTcjNvRHd5NUQ5ekp2c2RTbS9WSXVkREht?=
 =?utf-8?B?eThUN3JMWjY4ajhuSnI5WTNSZzB4dWkwR0QrS2VqWWRNYWZUVHBtQVJBVC9u?=
 =?utf-8?B?NUJCVXZFWmhobGNBRUpxd1ZnVmtBMmR3eDN4ekh0YlNrK3J0QjRudnNaT3Vq?=
 =?utf-8?B?Wm1NMHR1bUFUMXNiZEZOTzFlaVdTeSsyMWdaQy9hODFkTXlyZVNtRXFUM1dK?=
 =?utf-8?B?Q0lVSVZKY0lSb3lNK2loZkRyenVDUGRhZkczM0VGZ3A1a3U0YVpwWm9tajds?=
 =?utf-8?B?ckNVbVFTd1lNdWE2WjdjMWxLY1VXRDB0OWxjaEFwOGJQTVNYVThPbWV5c3Fk?=
 =?utf-8?B?SjZYaCtGRDhuT1pnRkQ3TUYrZEtFNWlvbkZIZGZDV3dPOVVJMWRoN1dpWUE5?=
 =?utf-8?Q?+kz+jJ43FjkXq0sVuf1xEQyGN?=
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
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4729.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b436445-f187-4230-289f-08dc2872d946
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2024 06:54:51.5955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wk3SIdNPo3zQ81RsNQw2momEDvYUTd3S8jeraVTpR7s6wUvSICiCKGWrSqIuRM0ReBxxmR0rfQ7qngI0lbKAeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB3527
X-Proofpoint-ORIG-GUID: 7Kjp4BtcrdGgbXNOwfCB5yuxS5zfAmk8
X-Proofpoint-GUID: 7Kjp4BtcrdGgbXNOwfCB5yuxS5zfAmk8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-08_01,2024-02-07_01,2023-05-22_02

SGkgS2FsZXNoLA0KDQpGcm9tOiBLYWxlc2ggQW5ha2t1ciBQdXJheWlsIDxrYWxlc2gtYW5ha2t1
ci5wdXJheWlsQGJyb2FkY29tLmNvbT4gDQpTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDcsIDIw
MjQgMTo0MCBQTQ0KVG86IFNoaW5hcyBSYXNoZWVkIDxzcmFzaGVlZEBtYXJ2ZWxsLmNvbT4NCkNj
OiBuZXRkZXZAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBI
YXNlZWIgR2FuaSA8aGdhbmlAbWFydmVsbC5jb20+OyBWaW1sZXNoIEt1bWFyIDx2aW1sZXNoa0Bt
YXJ2ZWxsLmNvbT47IFNhdGhlc2ggQiBFZGFyYSA8c2VkYXJhQG1hcnZlbGwuY29tPjsgZWdhbGxl
bkByZWRoYXQuY29tOyBtc2NobWlkdEByZWRoYXQuY29tOyBwYWJlbmlAcmVkaGF0LmNvbTsga3Vi
YUBrZXJuZWwub3JnOyBob3Jtc0BrZXJuZWwub3JnOyB3aXpoYW9AcmVkaGF0LmNvbTsga2hlaWJA
cmVkaGF0LmNvbTsga29uZ3V5ZW5AcmVkaGF0LmNvbTsgVmVlcmFzZW5hcmVkZHkgQnVycnUgPHZi
dXJydUBtYXJ2ZWxsLmNvbT47IFNhdGFuYW5kYSBCdXJsYSA8c2J1cmxhQG1hcnZlbGwuY29tPjsg
RGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PjsgRXJpYyBEdW1hemV0IDxlZHVt
YXpldEBnb29nbGUuY29tPg0KU3ViamVjdDogW0VYVF0gUmU6IFtQQVRDSCBuZXQtbmV4dCB2NiA1
LzhdIG9jdGVvbl9lcF92ZjogYWRkIHN1cHBvcnQgZm9yIG5kbyBvcHMNCg0KDQpPbiBXZWQsIEZl
YiA3LCAyMDI0IGF0IDEyOjIz4oCvUE0gU2hpbmFzIFJhc2hlZWQgPG1haWx0bzpzcmFzaGVlZEBt
YXJ2ZWxsLmNvbT4gd3JvdGU6DQpBZGQgc3VwcG9ydCBmb3IgbmRvIG9wcyB0byBzZXQgTUFDIGFk
ZHJlc3MsIGNoYW5nZSBNVFUsIGdldCBzdGF0cy4NCkFkZCBjb250cm9sIHBhdGggc3VwcG9ydCB0
byBzZXQgTUFDIGFkZHJlc3MsIGNoYW5nZSBNVFUsIGdldCBzdGF0cywNCnNldCBzcGVlZCwgZ2V0
IGFuZCBzZXQgbGluayBtb2RlLg0KW0thbGVzaF06IFlvdSBhcmUgYWRkaW5nIHN1cHBvcnQgZm9y
IG9ubHkgb25lIG5kbyBob29rICIubmRvX2dldF9zdGF0czY0IiBpbiB0aGlzIHBhdGNoLiBBbSBJ
IG1pc3Npbmcgc29tZXRoaW5nPw0KDQpJIHRoaW5rIHRoZSBwYXRjaGVzIGdvdCBzZXBhcmF0ZWQu
IFRoZSBtdHUsIG1hYyBjaGFuZ2VzIGdvdCBwdXQgaW4gYW4gZWFybGllciBwYXRjaC4gSSdsbCBm
aXggaXQuDQoNCg0K

