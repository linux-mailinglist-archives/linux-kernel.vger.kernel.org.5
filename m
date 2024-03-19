Return-Path: <linux-kernel+bounces-106974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B5E87F631
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 04:53:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B121F2296D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 03:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F927BB1C;
	Tue, 19 Mar 2024 03:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="BRaPHW37"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1985F7BB0D;
	Tue, 19 Mar 2024 03:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710820403; cv=fail; b=iQEqXyJ9yj4/JcOgvwiOXUfAaMfF5q7GUxXIxojfKBVCN2iFTklmbus3CvSaYvoCS1YXX77CGtjpHMtQn5cZ+X7YRKD8/OhQnc/XpWGR2fnvZ/12oGIia/BZF3aE/TJWFKQ0Scwtu1BW3dY9gccBqzCBZLPueXkbjMtQFoHdX8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710820403; c=relaxed/simple;
	bh=pe0i1PTeKgpJglctjIg1lUymXOmm3LXx1kntgsWEVeQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l094Ud+2lVO98ZXX5KW716RlAkbDGNU9ynclg6dflOg3oxgACCIFEz5rdCtSiMyP/kIc8Q6gA9KB8WskYlDsA4oYpbVU3nmgkLMTvsQxHyX1IF6rU4QexO65l1y6kg1b/47eoRhfaVfPzjNRiogZ2plh09xYu7Y65qOp20gQico=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=BRaPHW37; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42IKt71p010332;
	Mon, 18 Mar 2024 20:53:08 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3wxka4tyvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 Mar 2024 20:53:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfvfC3Q8dfORi9QGLmAPPg1XpbwhuCbouzUAbzfUqjbE6waAUyNhEvppYlJ5PmTF+k8wsOUHyK6mkREDoizqVz9agN8a5pbbCM7bg5v16vofuln4h/UfyB4O4VbdFSCqjsyGe+0YAE6WZ8qaMnh0rtFK/5Xx8UwGAryD1TGR/3Ht8cOTeXHSqPQvUeOHyYaDVFUMFDX5+OcNgEXz8LyOe1yOcAUxxy4YR2+QeIAgb+jE5PAizrTVLuBhYccwc3wzZOjvksEKi8bh+K6iH+jMuSQew0qxpRJsvLnEFocTSIXnZqoYFTRZl4LfBG9+cypjuTYU+Fo3cdaAYrpc3SgYEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pe0i1PTeKgpJglctjIg1lUymXOmm3LXx1kntgsWEVeQ=;
 b=FWv8N/yezyA4c8v7G6E34PP0nZOXK/nIdOcLsU1sQqosjam2Vp57JZhMPeXIr5SABB7Po/vE1j0ICDdPf+HdVSM6d43SsP4pFx+jk5cCT4SdPJCozJ77YjWNzMQgzhUgmp1ifkzYUZlTBuTzlY7HxzUfsKyymc7Odqc0YMSY9B4NcKKd1frAN5MopGigvv2Xf1954DnGvyFm2072Sntz9k9ph+9iyE7xQTz2LxVAaLvQyWvsL3hRrH8Hbg3orQnJKhVpdd+uEBoW8dqI2FPdjy2nnXRZg4znt3ljNG8z4QM6Tl+zCC8R09UtvEwBK1Jo4qcBtfZRHhN455/nlJB7JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pe0i1PTeKgpJglctjIg1lUymXOmm3LXx1kntgsWEVeQ=;
 b=BRaPHW37KAYLkhEzhdK1CQppwIl6uvp2m5VZNisJ/PXSfGKJcPAbbcmyTizHn7fjDSp8TGPRf0nyid7RHCJ86i4tWfNuPS2x+5oQy9Wqq7iYrF68U85kpBb0GOMHkWe5Y3TCnLHEw+kPEl410MbiD90anroPwV/+vOvn4pESHFY=
Received: from SN7PR18MB5314.namprd18.prod.outlook.com (2603:10b6:806:2ef::8)
 by CH3PR18MB6119.namprd18.prod.outlook.com (2603:10b6:610:1e1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.26; Tue, 19 Mar
 2024 03:53:06 +0000
Received: from SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::926a:6eb8:6d4b:656a]) by SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::926a:6eb8:6d4b:656a%7]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 03:53:06 +0000
From: Bharat Bhushan <bbhushan2@marvell.com>
To: Stefan Berger <stefanb@linux.ibm.com>,
        Stefan Berger
	<stefanb@linux.vnet.ibm.com>,
        "keyrings@vger.kernel.org"
	<keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>,
        "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "saulo.alessandre@tse.jus.br" <saulo.alessandre@tse.jus.br>,
        "lukas@wunner.de" <lukas@wunner.de>,
        "jarkko@kernel.org" <jarkko@kernel.org>
Subject: Re:  [PATCH v6 06/13] crypto: ecc - Implement vli_mmod_fast_521 for
 NIST p521
Thread-Topic: [PATCH v6 06/13] crypto: ecc - Implement vli_mmod_fast_521 for
 NIST p521
Thread-Index: AQHaebDzhpsuFipBKECq76mynky9XA==
Date: Tue, 19 Mar 2024 03:53:06 +0000
Message-ID: 
 <SN7PR18MB5314BF150747EB61D10B16BCE32C2@SN7PR18MB5314.namprd18.prod.outlook.com>
References: <20240312183618.1211745-1-stefanb@linux.vnet.ibm.com>
 <20240312183618.1211745-7-stefanb@linux.vnet.ibm.com>
 <SN7PR18MB5314CB6B4CF9678BDDF0D012E32D2@SN7PR18MB5314.namprd18.prod.outlook.com>
 <4151f2f0-aa92-480d-aad5-2bf4333b4265@linux.ibm.com>
In-Reply-To: <4151f2f0-aa92-480d-aad5-2bf4333b4265@linux.ibm.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR18MB5314:EE_|CH3PR18MB6119:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 7rHHbKRv6Y9hCAuogCVW6jleJyRET2oaYKHV3ZyNZdqmEh5vwIsGNIQxnvg4Q92nwFzOIhBTZA6YqG6QCKRQuOLsINSpCLZgkuuKPoQj149HCbOnnKWrGbspX9787ji6nT4E5EGQdbv+zyccVdIFQpf7n1121BGMRGkF/Wc1jznDgY7+Uttvmz4Rk6xbq1Etdft1GK0BQs42v88AwytXe+Ym1pygWxh/wH63u1CuAs1+Plbfo5ESZIz64m95s2B4aFYFadBtyC2nUuTyABXYUrTQXLWEDrrnwK88XSlO9NJH+gGns/xxR9DPnUGoGOlxMS86UOSbXwg6Vakr0+8kUfpCVWdfLuq+zsXD6ZNQ2oqIQu8DdvMKd46tQ2nARwe7yK5lo1YuH6BG9JGr7qPs/UEoHw4Iw3gc9P5Pc4JoZ0jiGFzqNQYXNWaG81iNIbRGtKzCT0RWvVIXSoVII/fqbEvr3FKgvjLLgbQyek2GJFXqTy4VxQQctbWCdViiMdTDAu8eID9xvlTrKFDgpPHlWtqW5t2/q2J8EuG06ZAFWt/OqzJGBSH+/vrzLm09j+aJxW81PrdjLGlqgIQSBvZZioER1g7IlKpeVAQpXD5qSnYjXkyBjowwHkTvLh7AJba9ySwgaNdvDPgaiUEZrRZVSBXfSdcOGEXXvxGYu+uLrS4=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR18MB5314.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?YVdoaWdhZjZBR3lKdXlrd1loeGsrdERlcjJEc0hlSkdWVlFEZ1I4SzVCbFZV?=
 =?utf-8?B?Y1VjUFEyektyTVNxRm5vSFBldW9TNElmZlFaTkhxZmduN0JUYlI1TkZHbEpZ?=
 =?utf-8?B?aEdqckliNXVGOGZ3ajBDV3cyS013L2pXaEx5YWxOQnRWWkRXUDRBUzdoTkhH?=
 =?utf-8?B?RlovenRRWUdGNkIxclJqVmx6NnlHMkUrdUJzdmZtOUJicEhoZmtwbTFqSXd3?=
 =?utf-8?B?amF2ZWppMmVGTVRzU1N6eklWUUUrSGxHTzA2TkdHb2ZES1BaWEl1RUovZ25M?=
 =?utf-8?B?UHFKQVN0d1MvNkdqVzhMR2ViWk91UlcvMnY0a0FGaExKSlFyVTFZdFVHOTA4?=
 =?utf-8?B?cGZkVTRxY0lrRTFiUUozTGNKTjR5QVV1aVJXc1g0WkZURGFmaFdnQ1plS3RS?=
 =?utf-8?B?amV1R3VyRi9WWGlRWks2cXloWWczTXJpVDQxZmR6eXNkVkRyRGlzN3JsZkxQ?=
 =?utf-8?B?ZXhOWXRPbGp4MVlvWXI0Y2JORjJoMjFwb29mUmlSNmU1cWtpTU81MjZaUUJK?=
 =?utf-8?B?U1hDUFQrL2JhQ0tRdkJkWkM5enV5SFhBVUpxTmYvR0xVcUcxZE96bFZuQU5S?=
 =?utf-8?B?Wk11cHJHbDJyWjRpd2VoVFdnS21HSE94L1p4d1h4Kzhxa2xqckNCTW1aaDZL?=
 =?utf-8?B?TXIzbFlRR1BEcDhGQWkyMks0MklsZzZWRDFYekxJNnlSbzF1aGFuZ2pQZzV2?=
 =?utf-8?B?eS9KRk05WDUwODY5VlVlVVpYSVJGVS90ZGN3NGsvZmNRQ3hlYzBjUnZkSWcz?=
 =?utf-8?B?MzY4WkswUEV5MjY0NEtPUGFFaTJqZ1BJTlZCRXJPUWJoY0ltREdtY3BGUlNt?=
 =?utf-8?B?RnZMdmJVUUU5Vk16ZkxtMy93bGFJZHJQNFpsd2srbDI1MkdoWWV6Y09MZFVM?=
 =?utf-8?B?bXRaYVVZQ2FiNmlRVGtKMkxlNkpxZ3BaejN2clFXdTgxMFJERXptdk1YU3FC?=
 =?utf-8?B?NFBNenpvK3RwcjBuR0RnUTltTnd1OW1ibVk5NDNFa2JybmVnRlVCRUxxS0xJ?=
 =?utf-8?B?cXArcXlrNUJMRWFVdUpsN25FVThiUDdVa0hzTllzSnh6aGtPelp2dUhLM0lZ?=
 =?utf-8?B?dEpSZWpyWWhsMEt0M2pLVzgvSUNmOVNta3BkclpMdDlBN015M2RySVNpZ0Fi?=
 =?utf-8?B?ZHBUREN5OWw1K3gweDlzSEZmenlyN0FINHVqMUtscmliV2h4UDcrK2RZeHlQ?=
 =?utf-8?B?MnZKQWRFY0lCdHA0ME02T3pCKzdvYTFDWm1zM1lkdFFkY1p4VHNYZkZrQVU2?=
 =?utf-8?B?eFBPTDc4a2ROMkRpNUhCc1NjUEl6V2hYTDNHbUhDcE03U1VieUhQcDRvVTJv?=
 =?utf-8?B?akFzdkJHSEpSZDNBbU5EcHp6SW5pSG1hZ1FieUdValYxTUxkYVJUelB3bzJX?=
 =?utf-8?B?UUQyVGVVWmlrMktGTk1nSlJrNzU0VEtMVVFuYmdWZ2drVnZUcHhhemlNR2ZS?=
 =?utf-8?B?emJSaEFBL09NcFNvZkZEZitzV0tYSS9RRDBHWFhKOU81MWZ5VDFXTnA0ZktF?=
 =?utf-8?B?VXNCYzhVY1E5aTNOOEZQbFRPR25Bb1U1aGxIVEJ1OEVGUzFVVmh1UmYxWnls?=
 =?utf-8?B?cXg2WGNVREFkVnk3ejRCeHVMNlNsUi9wNHMzTmlNUjUrWU9id1JTMmN3K0ZJ?=
 =?utf-8?B?NTlidFFMbW16VXJVM0JjYjE5blNrQ3pIQ29RdHFOT0tOZG11ZElKbTJveEwz?=
 =?utf-8?B?UlNKSWpVOWZzUWp1TEk0YkFvVmVpQlpVcWRRRXA4eXQ3b2lSSXVXbUpCNXNh?=
 =?utf-8?B?VUpsekNIUHBxOWJnclNyYmxKMG1mWXowKzYvZ3hXckdVYUNqbjdrVUlPSGJV?=
 =?utf-8?B?VVpXTU9WaVZpZDJIem9WeWVFRjZJY1FZcjdVdmg4K3VXdGpTc2NFazY2UDZQ?=
 =?utf-8?B?cEMzc2V1MHJ2Uld3NGgzVGhhbG9EQjhhVHU1dzVBWEY0eVJnM3BBZEpCMkI5?=
 =?utf-8?B?S3BhZnhkWWZvY3lISDVMTHNhMlF2VXVwamF0MWpGenMwU1drN2FLaEVaYXUx?=
 =?utf-8?B?S3AxR3UwemhxemVGbXo1YXNCZ3U2d0NjNlQ4UVBSQlI4YlMyNGVxWkhQbmpj?=
 =?utf-8?B?RithN3hYUFh1cUQ3dmtLVS9idmNmb0RFSkNjei9vejBHSmZWOHhLUEZaZUhh?=
 =?utf-8?Q?8n/EWi2GYRxVgA7SD3hobwPxT?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN7PR18MB5314.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 973b35fe-586a-41da-1671-08dc47c815bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2024 03:53:06.3557
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dQVsiCsOq8Hmy4epm5gd+n6jyGSM1ykFDNtm2jkW4Woxw2FY+tudSHTkr76pAVsoERyHEgnRfbscaK3hNa106Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR18MB6119
X-Proofpoint-GUID: y3lhJp1vdx5JMEI5xHYnaVaZC1WdLJ3J
X-Proofpoint-ORIG-GUID: y3lhJp1vdx5JMEI5xHYnaVaZC1WdLJ3J
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlZmFuIEJlcmdlciA8
c3RlZmFuYkBsaW51eC5pYm0uY29tPg0KPiBTZW50OiBUdWVzZGF5LCBNYXJjaCAxOSwgMjAyNCAx
MjowOSBBTQ0KPiBUbzogQmhhcmF0IEJodXNoYW4gPGJiaHVzaGFuMkBtYXJ2ZWxsLmNvbT47IFN0
ZWZhbiBCZXJnZXINCj4gPHN0ZWZhbmJAbGludXgudm5ldC5pYm0uY29tPjsga2V5cmluZ3NAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC0NCj4gY3J5cHRvQHZnZXIua2VybmVsLm9yZzsgaGVyYmVydEBn
b25kb3IuYXBhbmEub3JnLmF1Ow0KPiBkYXZlbUBkYXZlbWxvZnQubmV0DQo+IENjOiBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBzYXVsby5hbGVzc2FuZHJlQHRzZS5qdXMuYnI7DQo+IGx1
a2FzQHd1bm5lci5kZTsgamFya2tvQGtlcm5lbC5vcmcNCj4gU3ViamVjdDogW0VYVEVSTkFMXSBS
ZTogW1BBVENIIHY2IDA2LzEzXSBjcnlwdG86IGVjYyAtIEltcGxlbWVudA0KPiB2bGlfbW1vZF9m
YXN0XzUyMSBmb3IgTklTVCBwNTIxDQo+IA0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IA0KPiANCj4gT24g
My8xOC8yNCAwMTo0NywgQmhhcmF0IEJodXNoYW4gd3JvdGU6DQo+ID4NCj4gPg0KPiA+PiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+PiBGcm9tOiBTdGVmYW4gQmVyZ2VyIDxzdGVmYW5i
QGxpbnV4LnZuZXQuaWJtLmNvbT4NCj4gPj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAxMywgMjAy
NCAxMjowNiBBTQ0KPiA+PiBUbzoga2V5cmluZ3NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1jcnlw
dG9Admdlci5rZXJuZWwub3JnOw0KPiA+PiBoZXJiZXJ0QGdvbmRvci5hcGFuYS5vcmcuYXU7IGRh
dmVtQGRhdmVtbG9mdC5uZXQNCj4gPj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IHNhdWxvLmFsZXNzYW5kcmVAdHNlLmp1cy5icjsNCj4gPj4gbHVrYXNAd3VubmVyLmRlOyBCaGFy
YXQgQmh1c2hhbiA8YmJodXNoYW4yQG1hcnZlbGwuY29tPjsNCj4gPj4gamFya2tvQGtlcm5lbC5v
cmc7IFN0ZWZhbiBCZXJnZXIgPHN0ZWZhbmJAbGludXguaWJtLmNvbT4NCj4gPj4gU3ViamVjdDog
W0VYVEVSTkFMXSBbUEFUQ0ggdjYgMDYvMTNdIGNyeXB0bzogZWNjIC0gSW1wbGVtZW50DQo+ID4+
IHZsaV9tbW9kX2Zhc3RfNTIxIGZvciBOSVNUIHA1MjENCj4gPj4NCj4gPj4gLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
DQo+ID4+IC0NCj4gPj4gRnJvbTogU3RlZmFuIEJlcmdlciA8c3RlZmFuYkBsaW51eC5pYm0uY29t
Pg0KPiA+Pg0KPiA+PiBJbXBsZW1lbnQgdmxpX21tb2RfZmFzdF81MjEgZm9sbG93aW5nIHRoZSBk
ZXNjcmlwdGlvbiBmb3IgaG93IHRvDQo+ID4+IGNhbGN1bGF0ZSB0aGUgbW9kdWx1cyBmb3IgTklT
VCBQNTIxIGluIHRoZSBOSVNUIHB1YmxpY2F0aW9uDQo+ID4+ICJSZWNvbW1lbmRhdGlvbnMgZm9y
IERpc2NyZXRlIExvZ2FyaXRobS1CYXNlZCBDcnlwdG9ncmFwaHk6IEVsbGlwdGljDQo+IEN1cnZl
IERvbWFpbiBQYXJhbWV0ZXJzIg0KPiA+PiBzZWN0aW9uIEcuMS40Lg0KPiA+Pg0KPiA+PiBOSVNU
IHA1MjEgcmVxdWlyZXMgOSA2NGJpdCBkaWdpdHMsIHNvIGluY3JlYXNlIHRoZSBFQ0NfTUFYX0RJ
R0lUUyBzbw0KPiA+PiB0aGF0IGFycmF5cyBmaXQgdGhlIGxhcmdlciBudW1iZXJzLg0KPiA+Pg0K
PiA+PiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW4gQmVyZ2VyIDxzdGVmYW5iQGxpbnV4LmlibS5jb20+
DQo+ID4+IC0tLQ0KPiA+PiAgIGNyeXB0by9lY2MuYyAgICAgICAgICAgICAgICAgIHwgMjUgKysr
KysrKysrKysrKysrKysrKysrKysrKw0KPiA+PiAgIGluY2x1ZGUvY3J5cHRvL2ludGVybmFsL2Vj
Yy5oIHwgIDMgKystDQo+ID4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAyNyBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9jcnlwdG8vZWNjLmMgYi9jcnlw
dG8vZWNjLmMgaW5kZXgNCj4gPj4gNDE1YTJmNGU3MjkxLi45OWQ0MTg4N2MwMDUNCj4gPj4gMTAw
NjQ0DQo+ID4+IC0tLSBhL2NyeXB0by9lY2MuYw0KPiA+PiArKysgYi9jcnlwdG8vZWNjLmMNCj4g
Pj4gQEAgLTkwMiw2ICs5MDIsMjggQEAgc3RhdGljIHZvaWQgdmxpX21tb2RfZmFzdF8zODQodTY0
ICpyZXN1bHQsIGNvbnN0DQo+ID4+IHU2NCAqcHJvZHVjdCwgICN1bmRlZiBBTkQ2NEggICN1bmRl
ZiBBTkQ2NEwNCj4gPj4NCj4gPj4gKy8qDQo+ID4+ICsgKiBDb21wdXRlcyByZXN1bHQgPSBwcm9k
dWN0ICUgY3VydmVfcHJpbWUNCj4gPj4gKyAqIGZyb20gIlJlY29tbWVuZGF0aW9ucyBmb3IgRGlz
Y3JldGUgTG9nYXJpdGhtLUJhc2VkIENyeXB0b2dyYXBoeToNCj4gPj4gKyAqICAgICAgIEVsbGlw
dGljIEN1cnZlIERvbWFpbiBQYXJhbWV0ZXJzIiBzZWN0aW9uIEcuMS40DQo+ID4+ICsgKi8NCj4g
Pj4gK3N0YXRpYyB2b2lkIHZsaV9tbW9kX2Zhc3RfNTIxKHU2NCAqcmVzdWx0LCBjb25zdCB1NjQg
KnByb2R1Y3QsDQo+ID4+ICsJCQkgICAgICBjb25zdCB1NjQgKmN1cnZlX3ByaW1lLCB1NjQgKnRt
cCkgew0KPiA+PiArCWNvbnN0IHVuc2lnbmVkIGludCBuZGlnaXRzID0gRUNDX0NVUlZFX05JU1Rf
UDUyMV9ESUdJVFM7DQo+ID4+ICsJc2l6ZV90IGk7DQo+ID4+ICsNCj4gPj4gKwkvKiBJbml0aWFs
aXplIHJlc3VsdCB3aXRoIGxvd2VzdCA1MjEgYml0cyBmcm9tIHByb2R1Y3QgKi8NCj4gPj4gKwl2
bGlfc2V0KHJlc3VsdCwgcHJvZHVjdCwgbmRpZ2l0cyk7DQo+ID4+ICsJcmVzdWx0WzhdICY9IDB4
MWZmOw0KPiA+PiArDQo+ID4+ICsJZm9yIChpID0gMDsgaSA8IG5kaWdpdHM7IGkrKykNCj4gPj4g
KwkJdG1wW2ldID0gKHByb2R1Y3RbOCArIGldID4+IDkpIHwgKHByb2R1Y3RbOSArIGldIDw8IDU1
KTsNCj4gPj4gKwl0bXBbOF0gJj0gMHgxZmY7DQo+ID4NCj4gPiBDYW4gd2UgZ2V0IGF3YXkgZnJv
bSB0aGlzIGhhcmRjb2RpbmcsIGxpa2UgOSwgNTUsIDB4MWZmIGV0Yy4NCj4gPiBPciBhdCBsZWFz
dCBhZGQgY29tbWVudCBhYm91dCB0aGVzZS4NCj4gPg0KPiA+PiArDQo+ID4+ICsJdmxpX21vZF9h
ZGQocmVzdWx0LCByZXN1bHQsIHRtcCwgY3VydmVfcHJpbWUsIG5kaWdpdHMpOyB9DQo+ID4+ICsN
Cj4gPj4gICAvKiBDb21wdXRlcyByZXN1bHQgPSBwcm9kdWN0ICUgY3VydmVfcHJpbWUgZm9yIGRp
ZmZlcmVudCBjdXJ2ZV9wcmltZXMuDQo+ID4+ICAgICoNCj4gPj4gICAgKiBOb3RlIHRoYXQgY3Vy
dmVfcHJpbWVzIGFyZSBkaXN0aW5ndWlzaGVkIGp1c3QgYnkgaGV1cmlzdGljIGNoZWNrDQo+ID4+
IGFuZCBAQCAtDQo+ID4+IDk0MSw2ICs5NjMsOSBAQCBzdGF0aWMgYm9vbCB2bGlfbW1vZF9mYXN0
KHU2NCAqcmVzdWx0LCB1NjQgKnByb2R1Y3QsDQo+ID4+ICAgCWNhc2UgRUNDX0NVUlZFX05JU1Rf
UDM4NF9ESUdJVFM6DQo+ID4+ICAgCQl2bGlfbW1vZF9mYXN0XzM4NChyZXN1bHQsIHByb2R1Y3Qs
IGN1cnZlX3ByaW1lLCB0bXApOw0KPiA+PiAgIAkJYnJlYWs7DQo+ID4+ICsJY2FzZSBFQ0NfQ1VS
VkVfTklTVF9QNTIxX0RJR0lUUzoNCj4gPj4gKwkJdmxpX21tb2RfZmFzdF81MjEocmVzdWx0LCBw
cm9kdWN0LCBjdXJ2ZV9wcmltZSwgdG1wKTsNCj4gPj4gKwkJYnJlYWs7DQo+ID4+ICAgCWRlZmF1
bHQ6DQo+ID4+ICAgCQlwcl9lcnJfcmF0ZWxpbWl0ZWQoImVjYzogdW5zdXBwb3J0ZWQgZGlnaXRz
IHNpemUhXG4iKTsNCj4gPj4gICAJCXJldHVybiBmYWxzZTsNCj4gPj4gZGlmZiAtLWdpdCBhL2lu
Y2x1ZGUvY3J5cHRvL2ludGVybmFsL2VjYy5oDQo+ID4+IGIvaW5jbHVkZS9jcnlwdG8vaW50ZXJu
YWwvZWNjLmggaW5kZXgNCj4gPj4gYWI3MjJhODk4NmI3Li40ZTJmNWY5MzhlOTEgMTAwNjQ0DQo+
ID4+IC0tLSBhL2luY2x1ZGUvY3J5cHRvL2ludGVybmFsL2VjYy5oDQo+ID4+ICsrKyBiL2luY2x1
ZGUvY3J5cHRvL2ludGVybmFsL2VjYy5oDQo+ID4+IEBAIC0zMyw3ICszMyw4IEBADQo+ID4+ICAg
I2RlZmluZSBFQ0NfQ1VSVkVfTklTVF9QMTkyX0RJR0lUUyAgMw0KPiA+PiAgICNkZWZpbmUgRUND
X0NVUlZFX05JU1RfUDI1Nl9ESUdJVFMgIDQNCj4gPj4gICAjZGVmaW5lIEVDQ19DVVJWRV9OSVNU
X1AzODRfRElHSVRTICA2DQo+ID4+IC0jZGVmaW5lIEVDQ19NQVhfRElHSVRTICAgICAgICAgICAg
ICAoNTEyIC8gNjQpIC8qIGR1ZSB0byBlY3Jkc2EgKi8NCj4gPj4gKyNkZWZpbmUgRUNDX0NVUlZF
X05JU1RfUDUyMV9ESUdJVFMgIDkNCj4gPg0KPiA+IE1heWJlIHRoZXNlIGNhbiBiZSBkZWZpbmVk
IGFzOg0KPiA+ICNkZWZpbmUgRUNDX0NVUlZFX05JU1RfUDUyMV9ESUdJVFMgIChESVZfUk9VTkRf
VVAoNTIxLCA2NCkgLyogTklTVA0KPiA+IFA1MjEgKi8pDQo+IA0KPiBJIHRoaW5rIGZvciBOSVNU
IFA1MjEgOSBjYW4gYmUgcHJlLWNhbGN1bGF0ZWQuIEl0IHdpbGwgbm90IGNoYW5nZSBhbnltb3Jl
IGluIHRoZQ0KPiBmdXR1cmUuDQoNCnByZS1jYWxjdWxhdGlvbiBmb3Igb3RoZXJzIGlzIHBlcmZl
Y3QgZGl2aXNpb24gYnkgNjQgYnV0IG5vdCBmb3IgUDUyMS4gU28gdGhhdCBjcmVhdGVzIGEgbGl0
dGxlIGNvbmZ1c2lvbiB3aHkgaXQgaXMgOSBhbmQgbm90IDguDQpTbyBpbiBteSB2aWV3IHdlIGNh
biBlaXRoZXIgdXNlIHNhbWUgbG9naWMgdXNlZCBmb3IgRUNDX01BWF9ESUdJVFMgb3IgYSBjb21t
ZW50IHRoYXQgaXQgaXMgcm91bmRlZCB1cC4gQW55d2F5cyBub3QgYSBtYWpvciBjb25jZXJuLg0K
DQpUaGFua3MNCi1CaGFyYXQNCg0KPiANCj4gPg0KPiA+PiArI2RlZmluZSBFQ0NfTUFYX0RJR0lU
UyAgICAgICAgICAgICAgRElWX1JPVU5EX1VQKDUyMSwgNjQpIC8qIE5JU1QgUDUyMQ0KPiAqLw0K
PiA+DQo+ID4gLyogTklTVF9QNTIxIGlzIG1heCBkaWdpdHMgKi8NCj4gPiAjZGVmaW5lIEVDQ19N
QVhfRElHSVRTICAgICAgICAgICAgICBFQ0NfQ1VSVkVfIF9ESUdJVFMNCj4gDQo+IEluIHRoaXMg
Y2FzZSBJIHRoaW5rIHRoZSBESVZfUk9VTkRfVVAoKSBhbG9uZyB3aXRoIHRoZSBjb21tZW50IHNo
b3dzIHRoYXQNCj4gaXQgbmVlZHMgdG8gYmUgdXBkYXRlZCBpZiBldmVyIGEgbGFyZ2VyIGN1cnZl
IGNvbWVzIGFsb25nLg0KPiANCj4gPg0KPiA+IFRoYW5rcw0KPiA+IC1CaGFyYXQNCj4gPg0KPiA+
Pg0KPiA+PiAgICNkZWZpbmUgRUNDX0RJR0lUU19UT19CWVRFU19TSElGVCAzDQo+ID4+DQo+ID4+
IC0tDQo+ID4+IDIuNDMuMA0KPiA+DQo=

