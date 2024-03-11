Return-Path: <linux-kernel+bounces-99191-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9E08784B0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 17:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A11BA1C21378
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825BE482C4;
	Mon, 11 Mar 2024 16:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="nTy3fWIp"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2DF4206B;
	Mon, 11 Mar 2024 16:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710173510; cv=fail; b=aw19bMxx1mamK4UIZnGACd6jKQ9ltp2I86cZmncZORZJeIyIuM1b6aADjoag8gU3i4fMF1haXTINaL3dCXdQYaITm7ZSmDwKh6Bk5kwZrK1rKmrJF81bBZ7ShdUrvxA2CRbf3J+4Rs3cdLIm+mP1rsiHp74La0ieijY15AvyNrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710173510; c=relaxed/simple;
	bh=Xv6DyDW1Ta4jHEtfJiepbxlEeNpGS2gqoiV7Wr3UcnE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KZbR7IAI+f+RQKgYm3pJ+rcSg/kJ/zTlD7SMfnBdUe22dvTyGhmRk23kgBfjUcYmy5cRouOG8H1pLpG+7GyIwlOkVevdyYZpbJLd6+jSoVcLCf9F0TLsL5Kbj+aBCkkB6QjoWNVvfD+lkaa3HkvbvXnELmVT1hSwHshrDFSVAH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=nTy3fWIp; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42BG39XW029178;
	Mon, 11 Mar 2024 09:11:39 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wt54n01dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Mar 2024 09:11:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHAcFbPc02OMdzH0BgHJjJOv0fmp7irGAxPgbBVZ9oidS8inEc760uFpGzspHGaGOaKKryoya3/XDDjU5SmMI2dpjzXAkP5VxPKRCNPjvJfl9l0SB1myU3Boq3KJs5K/ecP1+RkMji3hGNZnJdrYf7Rymwkq7QTbRI+XewWY8hTPRtXMMZplfexMPrwfp4jMmSOdk0zdiS3lqkbR6oRQHXhhiWN0gWcmp8sVgwDj0aoqprxHDagsPpscTZT8tGe1aulgM83ptXQQUycQvFhmB1Bveu2c6ILI1/tQS8JYMfg/s32n4+TLKzj5N7ER1hQ7BXFtjntwq6YOkhoKbbSK4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xv6DyDW1Ta4jHEtfJiepbxlEeNpGS2gqoiV7Wr3UcnE=;
 b=J92ad1jSxfD0XTWOdUaaf5KClnfdCNahUrDPmbajs+5FZW32kK5cJAtKX/Vn5r2APIALEeNflbbOh6vPPpZ7KGKU3qfKD1pmVzksEpj6h5ERg+geBRthIxG3tarYhpdv/xzdE0J1yg65txRsH1Z5RSVlzX76wWRQX2DSGRQr5spDWeoyqCiw1zcFTGzlV1o24TBoWVfaEeLZSMXypJTpGfUFid6uRIm2EOE6K611oVtfZj2+Bk0bAhxUdi8PdMUbHWnTa+fC1e5tLos79Tx+9b0PCxTFsutmRIbHlXCEmPM3fm0ZEGonyo1GfDOrB/jLF+trvTnj5jU8pR0iwAmrGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xv6DyDW1Ta4jHEtfJiepbxlEeNpGS2gqoiV7Wr3UcnE=;
 b=nTy3fWIpSxyfBcV/B1yc8QRNZmPEaOHMwNaM3VTBzWVhyxHaa+SN1tx2aRW70njMnTiJQ/4L5qCEvezjbyKUOgBb5R1UwLXiJOvtHa/VxNazWT/rv7ee4YlNen7eZM+j1Ti39qS7oAuC85vZAzEukbH0PVhAxXTam+q+BNPGp8o=
Received: from SN7PR18MB5314.namprd18.prod.outlook.com (2603:10b6:806:2ef::8)
 by DM4PR18MB5122.namprd18.prod.outlook.com (2603:10b6:8:4a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.33; Mon, 11 Mar
 2024 16:11:34 +0000
Received: from SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::926a:6eb8:6d4b:656a]) by SN7PR18MB5314.namprd18.prod.outlook.com
 ([fe80::926a:6eb8:6d4b:656a%7]) with mapi id 15.20.7362.035; Mon, 11 Mar 2024
 16:11:33 +0000
From: Bharat Bhushan <bbhushan2@marvell.com>
To: Stefan Berger <stefanb@linux.ibm.com>,
        "keyrings@vger.kernel.org"
	<keyrings@vger.kernel.org>,
        "linux-crypto@vger.kernel.org"
	<linux-crypto@vger.kernel.org>,
        "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>,
        "davem@davemloft.net" <davem@davemloft.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "saulo.alessandre@tse.jus.br" <saulo.alessandre@tse.jus.br>,
        "lukas@wunner.de" <lukas@wunner.de>
Subject: RE: [EXTERNAL] Re:  [PATCH v5 05/12] crypto: ecc - Implement
 vli_mmod_fast_521 for NIST p521
Thread-Topic: [EXTERNAL] Re:  [PATCH v5 05/12] crypto: ecc - Implement
 vli_mmod_fast_521 for NIST p521
Thread-Index: AQHac7zgfvWREWp5TkqNt/DFQYJH/bEytbqw
Date: Mon, 11 Mar 2024 16:11:33 +0000
Message-ID: 
 <SN7PR18MB5314BE0B64652FCCE7193C41E3242@SN7PR18MB5314.namprd18.prod.outlook.com>
References: <20240306222257.979304-1-stefanb@linux.ibm.com>
 <20240306222257.979304-6-stefanb@linux.ibm.com>
 <SN7PR18MB53143E3480E99EA90B9FEB88E3242@SN7PR18MB5314.namprd18.prod.outlook.com>
 <5ea60bdb-6059-4345-bf46-004c0af8382c@linux.ibm.com>
In-Reply-To: <5ea60bdb-6059-4345-bf46-004c0af8382c@linux.ibm.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN7PR18MB5314:EE_|DM4PR18MB5122:EE_
x-ms-office365-filtering-correlation-id: 22a70f1c-12ae-4325-27c7-08dc41e5ebc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 rGtgr7eCXG1qtNA5jwGoEpqqKdKUp06R9x3O/IZqplt+eUAuvZEKCbj9yY/Pvi08gmU1tSCfXKwDXNuzyO/76rGAb31Awek61xbs5h/AfBmDn39FVz/J5s9nmS8lEyo1PPSYk+zVvL+cTLqczFiZJ00OHxRw3t9UGcItypvsEneIw/uqSYBdeBG5y5wL/bIYEGroxRC9oCAGiSwYNtqehvVgbTxDoU5LcWRx5HKin6tpsCDQJyn2DBAL5iUFChWMots+S0QEkbQV9pXUs3DSjFwzHSxHUxu1v1vZY8N9Iv+B1hjcMC0GkSmap+Bb6gCD5xh8/wmbxTZsIEstcXowVBMj8ANGJ6X7DlB4zHpNPCf54NLVU7L3lbyX2W8tsyqnl8Pd0u/gd0DRECPyGyqPmku8B/61GrECuE3H3h3sK+ypBjC54omzIqMSi1EyyhaxtWxMPkL+//piO2h1S7byM+PKICT0xMpZqm9Ot/nl2qUZG0ctZsUmnpgJmU/f0iFPesCS0em9yNAGIyl3k3MZI7QFYjdbBE6LTeiBfXaBnElAD7Bf6P9/rTJVHjdf5PcM0aFedYOUEJLytL6JzFZfLmlC0+icCb5HeRX6refsentthgkm4FT1KR1hJrWtSomxNBp6cVxU9W6VlGAMhaFzNu5o1+EtYVa9lTRCPo3QpWK/q/aFRGNKMzFK8GLJHIJWStF2sYR1UYrLESzlVTLrX0SffqPZ2aLGpy+VGCx6Krw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR18MB5314.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?enlaSEdRTGNKektMR0dnRlRBY1o1am5sZXl0MVZWMUV0dnZQZnlQL2JseHMy?=
 =?utf-8?B?YlhBWFhvTVN2TkZHd3A2YXY3bkI0TnBEOVlLRVo3NDM0QjdiS3ZGYXAyY3BJ?=
 =?utf-8?B?UXhVQlBwRTRFOFhnWjdNYnZGL3NEOHg4WURIakd4QndVRVR1d2NHM1NsR2Zn?=
 =?utf-8?B?dUlRUzhPR3l1YUhjYi9MOEF1SFdGNGJGSld5ZEJDaGQ1WnhhUUlnUkFVNVRG?=
 =?utf-8?B?L0hQM3FvS0svcjljV3NYVUxmSkRvZjRja09JeXZGMUQxakJZU3NxUmhwM3FF?=
 =?utf-8?B?b29KNGpjQ2dvc0lMQTFCTkd5R1FvRnFPYWFydUpMcnpXdHN4U3l0WnVMRXJT?=
 =?utf-8?B?a0RrNHBOQmhjWHE5bHp6VG9OYWd6b2p1dmc1ZStyVHdTU2JkVjZORGsySWxB?=
 =?utf-8?B?R2x2WUlUYTlSbGUyKzBGQng1a2traVhhU29aTWd2em9sOGtYbUtxdGNOa1Vo?=
 =?utf-8?B?ZFhsOGJ1WW5HcnU3NDUzdEhld1pxcUozd3h0eWE1cjkzTWhpVG9rZGJCZjlS?=
 =?utf-8?B?U0lMV1VPWFgxUHJ0Tmh3SHVJZHAzVTRxNlM2WFBkUWxIKzFLRWVBN3hXWlRw?=
 =?utf-8?B?UzhvS2hTZFgydlVNTExkVXYwMmlXeS84amhvUnk2SWNCVElOVUN3ajRZSm03?=
 =?utf-8?B?VThVZXU3WndzTnp3bTFWLzJnMjRkT2VrWVZJc3BqM3NzYVpyZ0lIdVJmMGdD?=
 =?utf-8?B?dGwrY2VXOGx3d3hhcys3cVA1QkRJNEpnenN5Yy9vV2RGdWloL3pMVHB5RC82?=
 =?utf-8?B?RS92YXBXOXZCVnhmL2F4Si9Td0dPZFpyYXdWWC96eU9pTVd5YVNZQUlWMmhw?=
 =?utf-8?B?THRjN0swRnRRaXhGTnJBSjVKbjdLZUp0T0NDblVUeFNiM1kwMGRjT1h1L2pk?=
 =?utf-8?B?Qm1RcE5qNWxIa1dna3BqUWExSWFoTVRkYTZDbGJKMm44WWhwUWdEZ0RidHFM?=
 =?utf-8?B?bHhSZGJBK1NrbjZxZHB2eE5ZL1VUNGd6QXk2MEVDcFhNTEVSaW5LVmhxcG9X?=
 =?utf-8?B?bDJJL3hzZUhCVFR6QVhlZFhHT1BBeWdsMzFhUzl3L1FpVkI5eG0yWE5WUTd4?=
 =?utf-8?B?UjVIQTFJTkY4TnZUNkpaZVQ1ZFZySG5qNjR2eXJxaE1FQlZFWUV1QXBBbWl5?=
 =?utf-8?B?eit0dzB5SVdHdlpkTVB1dEFzZmc5Y3U0RDYrZnpzTEdOZlFzRklidVNmc3Z2?=
 =?utf-8?B?MjYzaW93dTIvdUJnYmZPbGdWMkl5blhNUEdDQ0VzeHNHdWxxQWRQWW8wdmgy?=
 =?utf-8?B?SnlMc0NXVlhIYldoaXR3M1c5TUx3U2RPYTVZY0JlSHhHckFqeG43WkxZT2tJ?=
 =?utf-8?B?cmh1ampXNlI3UlBEVXZUQzhPRDF3c0FpWURjMlJvSGpwN1RBeDJ2RndVdjBr?=
 =?utf-8?B?NTh5R0dCd2haTTg1QjRtOGdPWDhYUVM3ejBQRktJOHJMcy96VlBXZVZyQ2Rt?=
 =?utf-8?B?TjFUaDZYbEM0YXkyMVd1OGNLa1c0YU1lUnI4S3BaZlYwWnhnK1dFQlMvdjBM?=
 =?utf-8?B?ZVhmQWp4K1dUeGlQZTRhbHBVMjFvVDZ3K3dheEpSaTBVZGpzWlpGaHpINVNo?=
 =?utf-8?B?YVpDRkU4RmxaUFBvWHhIZFNxQlltZkd5UXM2enBXNUlYVHkwNjdwenFaSzZQ?=
 =?utf-8?B?Z3hCZ2dTSDVsRHExZFZIbEpob0RaUG9DbU81Q21lcWU0enJnVlRmYXlKdjJG?=
 =?utf-8?B?Y01jZldDUXdHUm96ajJ1ZlZNVkJoTG9RVmxZa1ZvblFqSmNBTS9hZ1RtOG9l?=
 =?utf-8?B?WE53Z0RCQnJxTkg0Q2EwSkF4TGhDZTNvenl2QW1GdnJHTWpXb1IydDNBa2R6?=
 =?utf-8?B?Rzl1d0FoN0RaN1loYUt2czF3KzZtQm1oNHNhLy9wcjhLcVR6Zk5wYnhaVDdx?=
 =?utf-8?B?anhub2E1SGVFSEs3Njh1b0Jyc0kxRDU0RVBsb2xUZGdhR1lPaDZqVnRJSkVr?=
 =?utf-8?B?cThPSy9KNTF4OS9NN2d0c0lzb2c5VDh2QkJuNVBtcHI0M0o0QXRLSTlVOGFX?=
 =?utf-8?B?RXdNYzNLQnFxNStBYnZXY0x5L1k1Qk1OVzBkNlFVY1ROU3hlZC9CVW1GaVMv?=
 =?utf-8?B?YkhYL0FPSWg4dTJSeGsyQ2J5QlRYQ1h5R3pyUFFhR0o3a0ZWb0w4YmJwa2pR?=
 =?utf-8?Q?eiIf/uXu/Xcy+XTa0kOoCIDoe?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 22a70f1c-12ae-4325-27c7-08dc41e5ebc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2024 16:11:33.8821
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VMRzvKZ8AQYUELWce/UodIQGwTKljqLjDHTBLEB6iSiliNaC5CURoc3d6rqln6q0H8V6h1DUMwzops+e3/lLUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB5122
X-Proofpoint-ORIG-GUID: m63t-pk6QPssKGB_BEehWXEdoqX7-4ZR
X-Proofpoint-GUID: m63t-pk6QPssKGB_BEehWXEdoqX7-4ZR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-11_10,2024-03-11_01,2023-05-22_02

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3RlZmFuIEJlcmdlciA8
c3RlZmFuYkBsaW51eC5pYm0uY29tPg0KPiBTZW50OiBNb25kYXksIE1hcmNoIDExLCAyMDI0IDc6
MzMgUE0NCj4gVG86IEJoYXJhdCBCaHVzaGFuIDxiYmh1c2hhbjJAbWFydmVsbC5jb20+OyBrZXly
aW5nc0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBjcnlwdG9Admdlci5rZXJuZWwub3JnOyBo
ZXJiZXJ0QGdvbmRvci5hcGFuYS5vcmcuYXU7IGRhdmVtQGRhdmVtbG9mdC5uZXQNCj4gQ2M6IGxp
bnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHNhdWxvLmFsZXNzYW5kcmVAdHNlLmp1cy5icjsg
bHVrYXNAd3VubmVyLmRlDQo+IFN1YmplY3Q6IFtFWFRFUk5BTF0gUmU6IFtQQVRDSCB2NSAwNS8x
Ml0gY3J5cHRvOiBlY2MgLSBJbXBsZW1lbnQNCj4gdmxpX21tb2RfZmFzdF81MjEgZm9yIE5JU1Qg
cDUyMQ0KPiA+IA0KPiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+IA0KPiANCj4gT24gMy8xMS8yNCAwMTowNywg
QmhhcmF0IEJodXNoYW4gd3JvdGU6DQo+ID4gTWlub3Igbml0cw0KPiA+DQo+ID4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IFN0ZWZhbiBCZXJnZXIgPHN0ZWZhbmJAbGlu
dXguaWJtLmNvbT4NCj4gPj4gU2VudDogVGh1cnNkYXksIE1hcmNoIDcsIDIwMjQgMzo1MyBBTQ0K
PiA+PiBUbzoga2V5cmluZ3NAdmdlci5rZXJuZWwub3JnOyBsaW51eC1jcnlwdG9Admdlci5rZXJu
ZWwub3JnOw0KPiA+PiBoZXJiZXJ0QGdvbmRvci5hcGFuYS5vcmcuYXU7IGRhdmVtQGRhdmVtbG9m
dC5uZXQNCj4gPj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHNhdWxvLmFsZXNz
YW5kcmVAdHNlLmp1cy5icjsNCj4gPj4gbHVrYXNAd3VubmVyLmRlOyBTdGVmYW4gQmVyZ2VyIDxz
dGVmYW5iQGxpbnV4LmlibS5jb20+DQo+ID4+IFN1YmplY3Q6IFtFWFRFUk5BTF0gW1BBVENIIHY1
IDA1LzEyXSBjcnlwdG86IGVjYyAtIEltcGxlbWVudA0KPiA+PiB2bGlfbW1vZF9mYXN0XzUyMSBm
b3IgTklTVCBwNTIxDQo+ID4+DQo+ID4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+PiAtIEltcGxlbWVudCB2
bGlfbW1vZF9mYXN0XzUyMSBmb2xsb3dpbmcgdGhlIGRlc2NyaXB0aW9uIGZvciBob3cgdG8NCj4g
Pj4gY2FsY3VsYXRlIHRoZSBtb2R1bHVzIGZvciBOSVNUIFA1MjEgaW4gdGhlIE5JU1QgcHVibGlj
YXRpb24NCj4gPj4gIlJlY29tbWVuZGF0aW9ucyBmb3IgRGlzY3JldGUgTG9nYXJpdGhtLUJhc2Vk
IENyeXB0b2dyYXBoeTogRWxsaXB0aWMNCj4gPj4gQ3VydmUgRG9tYWluIFBhcmFtZXRlcnMiDQo+
ID4+IHNlY3Rpb24gRy4xLjQuDQo+ID4+DQo+ID4+IE5JU1QgcDUyMSByZXF1aXJlcyA5IDY0Yml0
IGRpZ2l0cywgc28gaW5jcmVhc2UgdGhlIEVDQ19NQVhfRElHSVRTIHNvDQo+ID4+IHRoYXQgYXJy
YXlzIGZpdCB0aGUgbGFyZ2VyIG51bWJlcnMuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFN0
ZWZhbiBCZXJnZXIgPHN0ZWZhbmJAbGludXguaWJtLmNvbT4NCj4gPj4gVGVzdGVkLWJ5OiBMdWth
cyBXdW5uZXIgPGx1a2FzQHd1bm5lci5kZT4NCj4gPj4gLS0tDQo+ID4+ICAgY3J5cHRvL2VjYy5j
ICAgICAgICAgICAgICAgICAgfCAzMSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+
ID4+ICAgaW5jbHVkZS9jcnlwdG8vaW50ZXJuYWwvZWNjLmggfCAgMiArLQ0KPiA+PiAgIDIgZmls
ZXMgY2hhbmdlZCwgMzIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+Pg0KPiA+PiBk
aWZmIC0tZ2l0IGEvY3J5cHRvL2VjYy5jIGIvY3J5cHRvL2VjYy5jIGluZGV4DQo+ID4+IGY1M2Zi
NGQ2YWY5OS4uMzczNjYwZTdiMTlkDQo+ID4+IDEwMDY0NA0KPiA+PiAtLS0gYS9jcnlwdG8vZWNj
LmMNCj4gPj4gKysrIGIvY3J5cHRvL2VjYy5jDQo+ID4+IEBAIC05MDIsNiArOTAyLDMxIEBAIHN0
YXRpYyB2b2lkIHZsaV9tbW9kX2Zhc3RfMzg0KHU2NCAqcmVzdWx0LCBjb25zdA0KPiA+PiB1NjQg
KnByb2R1Y3QsICAjdW5kZWYgQU5ENjRIICAjdW5kZWYgQU5ENjRMDQo+ID4+DQo+ID4+ICsvKiBD
b21wdXRlcyByZXN1bHQgPSBwcm9kdWN0ICUgY3VydmVfcHJpbWUNCj4gPj4gKyAqIGZyb20gIlJl
Y29tbWVuZGF0aW9ucyBmb3IgRGlzY3JldGUgTG9nYXJpdGhtLUJhc2VkIENyeXB0b2dyYXBoeToN
Cj4gPj4gKyAqICAgICAgIEVsbGlwdGljIEN1cnZlIERvbWFpbiBQYXJhbWV0ZXJzIiBHLjEuNA0K
PiA+PiArICovDQo+ID4+ICtzdGF0aWMgdm9pZCB2bGlfbW1vZF9mYXN0XzUyMSh1NjQgKnJlc3Vs
dCwgY29uc3QgdTY0ICpwcm9kdWN0LA0KPiA+PiArCQkJCWNvbnN0IHU2NCAqY3VydmVfcHJpbWUs
IHU2NCAqdG1wKSB7DQo+ID4+ICsJY29uc3QgdW5zaWduZWQgaW50IG5kaWdpdHMgPSA5Ow0KPiA+
PiArCXNpemVfdCBpOw0KPiA+PiArDQo+ID4+ICsJZm9yIChpID0gMDsgaSA8IG5kaWdpdHM7IGkr
KykNCj4gPj4gKwkJdG1wW2ldID0gcHJvZHVjdFtpXTsNCj4gPj4gKwl0bXBbOF0gJj0gMHgxZmY7
DQo+ID4+ICsNCj4gPj4gKwl2bGlfc2V0KHJlc3VsdCwgdG1wLCBuZGlnaXRzKTsNCj4gDQo+IEkg
aGF2ZSBhbHNvIG1vZGlmaWVkIHRoaXMgaGVyZSBub3cgdG8gaW5pdGlhbGl6ZSAncmVzdWx0JyBm
cm9tIGxvd2VzdA0KPiA1MjEgYmlzIG9mIHByb2R1Y3Qgd2l0aG91dCB0aGUgZGV0b3VyIHRocm91
Z2ggdG1wLg0KPiANCj4gPj4gKw0KPiA+PiArDQo+ID4+ICsJZm9yIChpID0gMDsgaSA8IG5kaWdp
dHM7IGkrKykNCj4gPj4gKwkJdG1wW2ldID0gKHByb2R1Y3RbOCArIGldID4+IDkpIHwgKHByb2R1
Y3RbOSArIGldIDw8IDU1KTsNCj4gPj4gKwl0bXBbOF0gJj0gMHgxZmY7DQo+ID4+ICsNCj4gPj4g
Kwl2bGlfbW9kX2FkZChyZXN1bHQsIHJlc3VsdCwgdG1wLCBjdXJ2ZV9wcmltZSwgbmRpZ2l0cyk7
IH0NCj4gPj4gKw0KPiA+PiArDQo+ID4+ICAgLyogQ29tcHV0ZXMgcmVzdWx0ID0gcHJvZHVjdCAl
IGN1cnZlX3ByaW1lIGZvciBkaWZmZXJlbnQgY3VydmVfcHJpbWVzLg0KPiA+PiAgICAqDQo+ID4+
ICAgICogTm90ZSB0aGF0IGN1cnZlX3ByaW1lcyBhcmUgZGlzdGluZ3Vpc2hlZCBqdXN0IGJ5IGhl
dXJpc3RpYyBjaGVjaw0KPiA+PiBhbmQgQEAgLQ0KPiA+PiA5NDEsNiArOTY2LDEyIEBAIHN0YXRp
YyBib29sIHZsaV9tbW9kX2Zhc3QodTY0ICpyZXN1bHQsIHU2NCAqcHJvZHVjdCwNCj4gPj4gICAJ
Y2FzZSA2Og0KPiA+PiAgIAkJdmxpX21tb2RfZmFzdF8zODQocmVzdWx0LCBwcm9kdWN0LCBjdXJ2
ZV9wcmltZSwgdG1wKTsNCj4gPj4gICAJCWJyZWFrOw0KPiA+PiArCWNhc2UgOToNCj4gPg0KPiA+
IENhbiB3ZSB1c2UgRUNDX0NVUlZFX05JU1RfUDM4NF9ESUdJVFMsIEVDQ19DVVJWRV9OSVNUX1Ay
NTZfRElHSVRTDQo+IGluIHRoaXMgZnVuY3Rpb24/DQo+ID4NCj4gPiBBbmQgZGVmaW5lIEVDQ19D
VVJWRV9OSVNUX1A1MjFfRElHSVRTLCB3aGljaCBpcyBzYW1lIGFzDQo+IEVDQ19NQVhfRElHSVRT
IGRlZmluZWQgYmVsb3cgaW4gdGhpcyBwYXRjaD8NCj4gPg0KPiA+PiArCQlpZiAoY3VydmUtPm5i
aXRzID09IDUyMSkgew0KPiANCj4gSWYgSSByZXBsYWNlIHRoZSBudW1iZXJzIHdpdGggdGhlc2Ug
aGFzaC1kZWZpbmVzJ3MgaW4gaGVyZSAoaW4gYW4gYWRkaXRpb25hbCBwYXRjaA0KPiBvbiBleGlz
dGluZyBjb2RlKSB0aGVuIEkgY2FuIGp1c3QgYWJvdXQgcmVtb3ZlIHRoZSBjaGVjayBvbiBuYml0
cyBoZXJlIGFzIHdlbGwuLi4gPw0KDQpZZXMsIGNhbiB1c2Ugc2FtZSBkZWZpbmUgaGVyZS4NCg0K
VGhhbmtzDQotQmhhcmF0DQoNCj4gDQo+IA0KPiA+PiArCQkJdmxpX21tb2RfZmFzdF81MjEocmVz
dWx0LCBwcm9kdWN0LCBjdXJ2ZV9wcmltZSwNCj4gPj4gdG1wKTsNCj4gPj4gKwkJCWJyZWFrOw0K
PiA+PiArCQl9DQo+ID4+ICsJCWZhbGx0aHJvdWdoOw0KPiA+PiAgIAlkZWZhdWx0Og0KPiA+PiAg
IAkJcHJfZXJyX3JhdGVsaW1pdGVkKCJlY2M6IHVuc3VwcG9ydGVkIGRpZ2l0cyBzaXplIVxuIik7
DQo+ID4+ICAgCQlyZXR1cm4gZmFsc2U7DQo+ID4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2NyeXB0
by9pbnRlcm5hbC9lY2MuaA0KPiA+PiBiL2luY2x1ZGUvY3J5cHRvL2ludGVybmFsL2VjYy5oIGlu
ZGV4IDRhNTU2YjQxODczZS4uZGUxN2JjZGViNTNhDQo+ID4+IDEwMDY0NA0KPiA+PiAtLS0gYS9p
bmNsdWRlL2NyeXB0by9pbnRlcm5hbC9lY2MuaA0KPiA+PiArKysgYi9pbmNsdWRlL2NyeXB0by9p
bnRlcm5hbC9lY2MuaA0KPiA+PiBAQCAtMzMsNyArMzMsNyBAQA0KPiA+PiAgICNkZWZpbmUgRUND
X0NVUlZFX05JU1RfUDE5Ml9ESUdJVFMgIDMNCj4gPj4gICAjZGVmaW5lIEVDQ19DVVJWRV9OSVNU
X1AyNTZfRElHSVRTICA0DQo+ID4+ICAgI2RlZmluZSBFQ0NfQ1VSVkVfTklTVF9QMzg0X0RJR0lU
UyAgNg0KPiA+PiAtI2RlZmluZSBFQ0NfTUFYX0RJR0lUUyAgICAgICAgICAgICAgKDUxMiAvIDY0
KSAvKiBkdWUgdG8gZWNyZHNhICovDQo+ID4+ICsjZGVmaW5lIEVDQ19NQVhfRElHSVRTICAgICAg
ICAgICAgICBESVZfUk9VTkRfVVAoNTIxLCA2NCkgLyogTklTVCBQNTIxICovDQo+ID4+DQo+ID4+
ICAgI2RlZmluZSBFQ0NfRElHSVRTX1RPX0JZVEVTX1NISUZUIDMNCj4gPj4NCj4gPj4gLS0NCj4g
Pj4gMi40My4wDQo+ID4+DQo+ID4NCg==

