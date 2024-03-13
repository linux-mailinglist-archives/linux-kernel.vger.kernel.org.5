Return-Path: <linux-kernel+bounces-101143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3E4A87A304
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 07:44:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B101C283082
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 06:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A03171C1;
	Wed, 13 Mar 2024 06:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="O7SsYXnI"
Received: from PA5P264CU001.outbound.protection.outlook.com (mail-francecentralazon11020002.outbound.protection.outlook.com [52.101.167.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF69171A3
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 06:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710312263; cv=fail; b=ZRH131qu5o01aU4x7aqb/Zhonplw/ZSzEqzbG50lISL31kkVKdzdQjqtZ+xxuQzbJDr+8EtCJ267ZExV8Ro/UQ/phy15ZygRR3wDBaC+3Ajp8YjHvNCFy1fMoDXEVxMRGYJ5h+68b0+KIO8j/bNxLzHPRLxUD9gnWK6MzgEJPHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710312263; c=relaxed/simple;
	bh=/L3z+BP3VUFqhApGXnNokY8u1qM2I6Ql428FvM2aico=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GSGC1cfq0a2oiSKkXNkxYJkCa6BR7ATl+w0v0DzOPOP/yrjMenGYds1BB86Wpw+ZWoOiQ4cuZCUkYfNpKJTaUzw6iP/1j0ay5Q95JaH+7zVR+EJZqCByS/RfbWh3w4TsCpr2zDRq/OQrnWlluEAfy9n2eI++EzqOngAkwgJh0JU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=O7SsYXnI; arc=fail smtp.client-ip=52.101.167.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJf9QT6aBJAFYn+OEKwo5znB6zYDbbEoUGPpocBGiy8LFLCgbo0aLln3ZgqKLzkHWXMQ0E0wPWYKpcma/W39bv6AfLJ5uEJx4hyd4T3RmT1exXjlgr8vbVKxEWvfQFWwOC48t8FYse6y5tk/wmLqJieOx82T3swoEgU1zfLW/btI7hnk847kHeZOKGmg7WnrDKApdEh9HSaWA7OhnR2Jk0BCxE+x0n55TPXk0iF3FQf8NLy3qRBcym7K8t5e3TDmMkCzfp2BaEUkl8PZ9iB8rOngDqswrCoFG8yJzjyVMz7cV0cJla3tvzeT/Qj0JIKnPaVGdUtS5I7xog4+57Zc2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/L3z+BP3VUFqhApGXnNokY8u1qM2I6Ql428FvM2aico=;
 b=Te8zTx0y8VJ5IhpI8H4ZOSTPUSoC5WB/0q+lWAzMoOdLhMcSGEiR8UVfOnx8Rrw5H0fyqqO5pOwhR/JwAa3bELYSUdctZawY3HDrFYLxGococg4qCA4tkHzmpu50VWG1wahlZbLNbUERkNw/+bkb4E587PPkhWCLpFQNvJ7lMIfh9kcdFxTCXlWDGUoVRDntO9ocRsZwr3SehPTds7vtkrFQNcG8Nye1u0Om0Emk5i4GyubEtlw1FTW8FLw+X6KJDFFhfT8wvoPhSPESGKNP8pA4Th5a9ih7eAp9cyyEZxU3JTE5yKl3PD5yZSDngfP28kkpNTtG5XX5rS1IynYj3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/L3z+BP3VUFqhApGXnNokY8u1qM2I6Ql428FvM2aico=;
 b=O7SsYXnIrC7msum34iGDvgh9tYc/c9QhQvGrs+xHYzqs9idAf5RVxfoMDqbU7WCw7y39Fj9kSouQaYr/mcLRJcpZHoUEzbnmmBXNKwC/fEqLtMBBqmxrcPylhK+PHi9aXn5miiO8W4WlU1GrRpWqUhTzAAmfx54RVDakCd7cyyX4Jc7QsqdhZjeDNY/dUlPWLFrTrWLH2Hq7J3qM6nR2pWoeqAMfulMUpslmr+iZp2l+fcmrTDTTwf3XENBSowK2lJOawwyt9SVLhtYBQ0fn3PQMJSJJvBe1F6PGl+iEp6ZjUqofDNzRRBnnRp3joXxmR1TObDtD5IiYcpQgU+wJ3A==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB3132.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.19; Wed, 13 Mar
 2024 06:44:15 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::c192:d40f:1c33:1f4e%6]) with mapi id 15.20.7386.017; Wed, 13 Mar 2024
 06:44:15 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>, "Liam.Howlett@oracle.com"
	<Liam.Howlett@oracle.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>, "bp@alien8.de" <bp@alien8.de>,
	"broonie@kernel.org" <broonie@kernel.org>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "debug@rivosinc.com" <debug@rivosinc.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "keescook@chromium.org"
	<keescook@chromium.org>, "kirill.shutemov@linux.intel.com"
	<kirill.shutemov@linux.intel.com>, "luto@kernel.org" <luto@kernel.org>,
	"mingo@redhat.com" <mingo@redhat.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"x86@kernel.org" <x86@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, Michael Ellerman
	<mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, "Aneesh Kumar K .
 V" <aneesh.kumar@kernel.org>, "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v3 07/12] powerpc: Use initializer for struct
 vm_unmapped_area_info
Thread-Topic: [PATCH v3 07/12] powerpc: Use initializer for struct
 vm_unmapped_area_info
Thread-Index: AQHadMzQIHn7qs2SgU2jZMQNeEdnxrE1Oh8A
Date: Wed, 13 Mar 2024 06:44:15 +0000
Message-ID: <dad7735d-dc57-4c89-a2b2-29d971f3cf69@csgroup.eu>
References: <20240312222843.2505560-1-rick.p.edgecombe@intel.com>
 <20240312222843.2505560-8-rick.p.edgecombe@intel.com>
In-Reply-To: <20240312222843.2505560-8-rick.p.edgecombe@intel.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MRZP264MB3132:EE_
x-ms-office365-filtering-correlation-id: 8aaf867f-4638-483f-c9cc-08dc4329002b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Gh9bN9ILP94FL2r6sqNfuvcyQhzL1lMvCFz+BhhrvTeQpy7GidMCSlzopebqqG5RpC+pyDKJglTT1LBz+TLp9MH+LOwBlcas9L+eKmAx2vbHTqXd+eNARlp+EkdTayfeiOSHLroZ5URkoglGQm9BNFPXrLWR8vJtEtX1iHwuWuGSqwAOr6DSjD5e/vyUwp9nvKKJdGb3JqRYunK+LHnMsrcJ5z3kYvJm3ncqfLlB5MecVePemlnC7HE4FuNutmaSTBikyv0vkrx7neRSOIrWd1jCpTvVRtt1D8kf5UtuPFm4zi7eE8Ppiu6YVXtrou/GPgbRLMxFhgxrGz+5mPxH1DxzvKf4pKeOEoazeCui9+Oljcn2vgXxOfaHq8hcvsWoA0nGDl7sO59XowungDXveSvX65LCnawtly1If/M6obZOLl3Yo2Efwp+GJVy2ixL1yUyCDj1OtSwxLalYPMVa0/Aw2W8zl1QHW2rQC9AcqwGKTRWMsh1G+UPyyFaw6NHbKYLDD+WkE5fQLj+hD5vhSCajVZXJ6NP4NMgakm12n4rtPijjtUjzFbbMstHQCulHqEi5HhIbSxU8TGPQHKlpl6JjtFro2YyeEZ/PHN6WU4uisvqCtF6Pvy4FocYo1zFBJBB2UUbPFYe6pPMxFmm8eL6M7WcmbZ/n2hp2za/ovPDg6IjouOSY3Ot8l+dI4ZWE
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(38070700009)(921011);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?STZYbVlmd1pQT0JDQ01wK3h6STZlUkdLdXR5MUVIMHI2U3BXcEhMWWY3YjEw?=
 =?utf-8?B?c1RhNGU1YytYY3ZVSDZxZS9jbng4aUwwU3lLQzd5VlNIL2swOWVmR0R4Z0FV?=
 =?utf-8?B?UU9GV1hpdXp4REkyWlFGTlJ1bSt0K2VIdEdzQTAweXF4Q0s3VEw0YWNtaWV5?=
 =?utf-8?B?Mkp3TXdyWG1hQTYzZUZDNEhNd2Y1UW0zY2pNdGEzRUtNMnBzWUpFL0dGQkRw?=
 =?utf-8?B?Yk9US3A5R1lUY3ZNMkV1bHRPSFNSUUhUWTg2NGFiRVlJaHNISmtaMlBtTk4w?=
 =?utf-8?B?a1MxSXQxQUJhd0Q0czNsWTBSTnc5bEpNRmpxTkVrQXVMSFhCS3o4K2tIWjZT?=
 =?utf-8?B?c1kxMDRJZ1hHRnZKZHVsZ1VIakNZclJtTWR4cGZFaWtOeEVmbmliZk0wSDNj?=
 =?utf-8?B?ZEFCUjBna2JtSWFLMXJlK0crckluOGhVZlhYT0xYS2VONy9TcXJOS3J5OC9z?=
 =?utf-8?B?ZlA3dzM2ZUNTSzM4dENwT0FPdUxkU0tvc0pibVUybHlheVJMUHY3RnpkY3ho?=
 =?utf-8?B?ZU1DZWpOVWsraHVGNndDNE1FZ2FWd1pRV0FsbU14dnlGSkVDd0NwOGxDYkZ0?=
 =?utf-8?B?OUJ6aVBtZURwSkxmakczMlJmU3FTYWVNVGVqN2s4Y0dlYVhzRTZ2UmZaM2xR?=
 =?utf-8?B?MktDdER5OVFwNkw0Zm5Tc1RJVXNpZHdJM2MwS29xazVjbm85TVQ4Ty9JdE1U?=
 =?utf-8?B?RzM2WmVTQlpMYXY4bmMyU1YyMW8xRHlmL2JscEp3K083N010Y1J3bGxZRVQx?=
 =?utf-8?B?eTd5MDJGbW1PdDBFZkVBOEcwY1hYS1BMZ2xjTTQwVmtUaTJ5bG8xSUpyQUtJ?=
 =?utf-8?B?clYzNGg0bjJwZ3VERS9QaGdqSHd3MFJ2UWhTcjJkK1FxMThVVzJxWTJob3Rz?=
 =?utf-8?B?elZDSjFXRE1OdUlKb0F3NUtmTkE0emM4L2VQSkZoOGNkM2xUaEV1b0lYSHNj?=
 =?utf-8?B?dnRlWVRKbm5qN2s5MHE3Y09CcHZaY2tCdnhqUEV0c2V5ZVNvUUk1RGF6cjZu?=
 =?utf-8?B?bzIrVnR1clg3L2xjZllIU3NpR3ROQVpod3N3WmdPQmp0Sy9Ya0NLQXN5UnZS?=
 =?utf-8?B?S1BIQnluYi96S1Ezd3c1N3BWYXJhYWNHZFRXQzVYVUpKcFRyYkJ0Y3EwRUMy?=
 =?utf-8?B?VVRGOEU0azJwL1FyK1g3Q3FCSjZsWW5mSlBlOWI0OE5vQ0JlRk0zV0ZxeXlI?=
 =?utf-8?B?ZWdpSytqUzI0T1VOQ1FNYmt3WmlnZGFpa01iWHorMkxOYkZrVVU1MDlZM1h2?=
 =?utf-8?B?QTZLYk5iRk1vNmFzUnU1NW9wMWpBenArYWRNV0xIRTVLTFJVejdNQit1ZmFq?=
 =?utf-8?B?endvUFdFa0IwZE53UE9RUmRXNE9BZm1jUG01UUlsakZ0UEhMbWFMZGpid3oz?=
 =?utf-8?B?aU04N1JtNjRUbDhXSkFMNHNnVk9Lamh3cHdUUDB5VnRKeUdDWmNhUCtQZVFy?=
 =?utf-8?B?OUR2Z0luTktQV3F6MW40VW9VZDVDOUNIWjJybVV1aGZHc1RHcXh1aXo0ejN2?=
 =?utf-8?B?S2xYTnE5c0VZVEtWR2ViK05GcmRidFk0a2tsM1QxMGVsU1l0TFlDTUJyenRi?=
 =?utf-8?B?M3g3Sm5TMjJkV3RHaE43eWFxbWZyMU1jUUZhdlV6a1QvWkR5NWx0UUczU2J2?=
 =?utf-8?B?M0doMWE4bUJIMGdlQ25vUFlTdmFDOEFpVlhiRGp2SElFQVY4TWd1WnNPTXNB?=
 =?utf-8?B?ODR2ckM4ZnM0dHR2cjFkTzF5bUtmekdvR093dTJxUVZNMkE5VWx0T1BRSVpz?=
 =?utf-8?B?VjM4czRVL3hVcm1wNW55WlhVRWNXaW82QmxnS3k4M09RT2k3QnhhVGZvQ05F?=
 =?utf-8?B?Z0ZONVV3OWp0c2VtZ2k4RHNETTJJYUZoNng2amx1YjhFcVdXdllKRi9HQVR2?=
 =?utf-8?B?QjBTWTk0aG5lOTlzV1h2Z0g4cktnSXpMM0pRdEl1MjN6NWMzSFFCMC9id0Ix?=
 =?utf-8?B?QTdZcVFNVUZNL1ZmL0EzMzV0akZSWHhTWHhUanpDckJXWEFjbUthQ2NrNjlw?=
 =?utf-8?B?cU1zS1VRYlloV0JOaGxxcVNDYnByVlJkbWx6U1dUKy9uVU5oemZJZVI0My9u?=
 =?utf-8?B?YWZqRVFHUjVjVnExcHozdHJ0dktqMGd1b3hSbVU4MDIvcnE3UUROOVREUVU4?=
 =?utf-8?Q?vzrHt1N8J54RtdapFtUaa4a63?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34A05BFC12D8944784A33955D5B2A584@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aaf867f-4638-483f-c9cc-08dc4329002b
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2024 06:44:15.5229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cnDhXAn+2J6Rlv8Xo3p+Z1jz8xm1uFcRDAKCGD1Mw3TsHLhO1+prSvaD2hHN8bAoUERWcN7ZiMqBEtQq36bFpxULHvD6akAnMPjJGd7t17w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB3132

DQoNCkxlIDEyLzAzLzIwMjQgw6AgMjM6MjgsIFJpY2sgRWRnZWNvbWJlIGEgw6ljcml0wqA6DQo+
IEZ1dHVyZSBjaGFuZ2VzIHdpbGwgbmVlZCB0byBhZGQgYSBuZXcgbWVtYmVyIHRvIHN0cnVjdA0K
PiB2bV91bm1hcHBlZF9hcmVhX2luZm8uIFRoaXMgd291bGQgY2F1c2UgdHJvdWJsZSBmb3IgYW55
IGNhbGwgc2l0ZSB0aGF0DQo+IGRvZXNuJ3QgaW5pdGlhbGl6ZSB0aGUgc3RydWN0LiBDdXJyZW50
bHkgZXZlcnkgY2FsbGVyIHNldHMgZWFjaCBtZW1iZXINCj4gbWFudWFsbHksIHNvIGlmIG5ldyBt
ZW1iZXJzIGFyZSBhZGRlZCB0aGV5IHdpbGwgYmUgdW5pbml0aWFsaXplZCBhbmQgdGhlDQo+IGNv
cmUgY29kZSBwYXJzaW5nIHRoZSBzdHJ1Y3Qgd2lsbCBzZWUgZ2FyYmFnZSBpbiB0aGUgbmV3IG1l
bWJlci4NCj4gDQo+IEl0IGNvdWxkIGJlIHBvc3NpYmxlIHRvIGluaXRpYWxpemUgdGhlIG5ldyBt
ZW1iZXIgbWFudWFsbHkgdG8gMCBhdCBlYWNoDQo+IGNhbGwgc2l0ZS4gVGhpcyBhbmQgYSBjb3Vw
bGUgb3RoZXIgb3B0aW9ucyB3ZXJlIGRpc2N1c3NlZCwgYW5kIGEgd29ya2luZw0KPiBjb25zZW5z
dXMgKHNlZSBsaW5rcykgd2FzIHRoYXQgaW4gZ2VuZXJhbCB0aGUgYmVzdCB3YXkgdG8gYWNjb21w
bGlzaCB0aGlzDQo+IHdvdWxkIGJlIHZpYSBzdGF0aWMgaW5pdGlhbGl6YXRpb24gd2l0aCBkZXNp
Z25hdGVkIG1lbWJlciBpbml0aWF0b3JzLg0KPiBIYXZpbmcgc29tZSBzdHJ1Y3Qgdm1fdW5tYXBw
ZWRfYXJlYV9pbmZvIGluc3RhbmNlcyBub3QgemVybyBpbml0aWFsaXplZA0KPiB3aWxsIHB1dCB0
aG9zZSBzaXRlcyBhdCByaXNrIG9mIGZlZWRpbmcgZ2FyYmFnZSBpbnRvIHZtX3VubWFwcGVkX2Fy
ZWEoKSBpZg0KPiB0aGUgY29udmVudGlvbiBpcyB0byB6ZXJvIGluaXRpYWxpemUgdGhlIHN0cnVj
dCBhbmQgYW55IG5ldyBtZW1iZXIgYWRkaXRpb24NCj4gbWlzc2VzIGEgY2FsbCBzaXRlIHRoYXQg
aW5pdGlhbGl6ZXMgZWFjaCBtZW1iZXIgbWFudWFsbHkuDQo+IA0KPiBJdCBjb3VsZCBiZSBwb3Nz
aWJsZSB0byBsZWF2ZSB0aGUgY29kZSBtb3N0bHkgdW50b3VjaGVkLCBhbmQganVzdCBjaGFuZ2UN
Cj4gdGhlIGxpbmU6DQo+IHN0cnVjdCB2bV91bm1hcHBlZF9hcmVhX2luZm8gaW5mbw0KPiB0bzoN
Cj4gc3RydWN0IHZtX3VubWFwcGVkX2FyZWFfaW5mbyBpbmZvID0ge307DQo+IA0KPiBIb3dldmVy
LCB0aGF0IHdvdWxkIGxlYXZlIGNsZWFudXAgZm9yIHRoZSBtZW1iZXJzIHRoYXQgYXJlIG1hbnVh
bGx5IHNldA0KPiB0byB6ZXJvLCBhcyBpdCB3b3VsZCBubyBsb25nZXIgYmUgcmVxdWlyZWQuDQo+
IA0KPiBTbyB0byBiZSByZWR1Y2UgdGhlIGNoYW5jZSBvZiBidWdzIHZpYSB1bmluaXRpYWxpemVk
IG1lbWJlcnMsIGluc3RlYWQNCj4gc2ltcGx5IGNvbnRpbnVlIHRoZSBwcm9jZXNzIHRvIGluaXRp
YWxpemUgdGhlIHN0cnVjdCB0aGlzIHdheSB0cmVlIHdpZGUuDQo+IFRoaXMgd2lsbCB6ZXJvIGFu
eSB1bnNwZWNpZmllZCBtZW1iZXJzLiBNb3ZlIHRoZSBtZW1iZXIgaW5pdGlhbGl6ZXJzIHRvIHRo
ZQ0KPiBzdHJ1Y3QgZGVjbGFyYXRpb24gd2hlbiB0aGV5IGFyZSBrbm93biBhdCB0aGF0IHRpbWUu
IExlYXZlIHRoZSBtZW1iZXJzIG91dA0KPiB0aGF0IHdlcmUgbWFudWFsbHkgaW5pdGlhbGl6ZWQg
dG8gemVybywgYXMgdGhpcyB3b3VsZCBiZSByZWR1bmRhbnQgZm9yDQo+IGRlc2lnbmF0ZWQgaW5p
dGlhbGl6ZXJzLg0KDQpJIHVuZGVyc3RhbmQgZnJvbSB0aGlzIHRleHQgdGhhdCwgYXMgYWdyZWVk
LCB0aGlzIHBhdGNoIHJlbW92ZXMgdGhlIA0KcG9pbnRsZXNzL3JlZHVuZGFudCB6ZXJvLWluaXQg
b2YgaW5kaXZpZHVhbCBtZW1iZXJzLiBCdXQgaXQgaXMgbm90IHdoYXQgDQppcyBkb25lLCBzZWUg
YmVsb3cgPw0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSaWNrIEVkZ2Vjb21iZSA8cmljay5wLmVk
Z2Vjb21iZUBpbnRlbC5jb20+DQo+IEFja2VkLWJ5OiBNaWNoYWVsIEVsbGVybWFuIDxtcGVAZWxs
ZXJtYW4uaWQuYXU+DQo+IENjOiBNaWNoYWVsIEVsbGVybWFuIDxtcGVAZWxsZXJtYW4uaWQuYXU+
DQo+IENjOiBOaWNob2xhcyBQaWdnaW4gPG5waWdnaW5AZ21haWwuY29tPg0KPiBDYzogQ2hyaXN0
b3BoZSBMZXJveSA8Y2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1Pg0KPiBDYzogQW5lZXNoIEt1
bWFyIEsuViA8YW5lZXNoLmt1bWFyQGtlcm5lbC5vcmc+DQo+IENjOiBOYXZlZW4gTi4gUmFvIDxu
YXZlZW4ubi5yYW9AbGludXguaWJtLmNvbT4NCj4gQ2M6IGxpbnV4cHBjLWRldkBsaXN0cy5vemxh
YnMub3JnDQo+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyNDAyMjgwOTEy
LjMzQUVFN0E5Q0ZAa2Vlc2Nvb2svI3QNCj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGttbC9qN2JmdmlnM2dldzNxcnVvdXhyaDd6N2VoamphZnJna2JjbWc2dGNnaGhmaDNyaG16aUB3
emxjb2VjZ3k1cnMvDQo+IC0tLQ0KPiB2MzoNCj4gICAtIEZpeGVkIHNwZWxsaW5nIGVycm9ycyBp
biBsb2cNCj4gICAtIEJlIGNvbnNpc3RlbnQgYWJvdXQgZmllbGQgdnMgbWVtYmVyIGluIGxvZw0K
PiANCj4gSGksDQo+IA0KPiBUaGlzIHBhdGNoIHdhcyBzcGxpdCBhbmQgcmVmYWN0b3JlZCBvdXQg
b2YgYSB0cmVlLXdpZGUgY2hhbmdlIFswXSB0byBqdXN0DQo+IHplcm8taW5pdCBlYWNoIHN0cnVj
dCB2bV91bm1hcHBlZF9hcmVhX2luZm8uIFRoZSBvdmVyYWxsIGdvYWwgb2YgdGhlDQo+IHNlcmll
cyBpcyB0byBoZWxwIHNoYWRvdyBzdGFjayBndWFyZCBnYXBzLiBDdXJyZW50bHksIHRoZXJlIGlz
IG9ubHkgb25lDQo+IGFyY2ggd2l0aCBzaGFkb3cgc3RhY2tzLCBidXQgdHdvIG1vcmUgYXJlIGlu
IHByb2dyZXNzLiBJdCBpcyBjb21waWxlIHRlc3RlZA0KPiBvbmx5Lg0KPiANCj4gVGhlcmUgd2Fz
IGZ1cnRoZXIgZGlzY3Vzc2lvbiB0aGF0IHRoaXMgbWV0aG9kIG9mIGluaXRpYWxpemluZyB0aGUg
c3RydWN0cw0KPiB3aGlsZSBuaWNlIGluIHNvbWUgd2F5cyBoYXMgYSBncmVhdGVyIHJpc2sgb2Yg
aW50cm9kdWNpbmcgYnVncyBpbiBzb21lIG9mDQo+IHRoZSBtb3JlIGNvbXBsaWNhdGVkIGNhbGxl
cnMuIFNpbmNlIHRoaXMgdmVyc2lvbiB3YXMgcmV2aWV3ZWQgbXkgYXJjaA0KPiBtYWludGFpbmVy
cyBhbHJlYWR5LCBsZWF2ZSBpdCBhcyB3YXMgYWxyZWFkeSBhY2tub3dsZWRnZWQuDQo+IA0KPiBU
aGFua3MsDQo+IA0KPiBSaWNrDQo+IA0KPiBbMF0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGtt
bC8yMDI0MDIyNjE5MDk1MS4zMjQwNDMzLTYtcmljay5wLmVkZ2Vjb21iZUBpbnRlbC5jb20vDQo+
IC0tLQ0KPiAgIGFyY2gvcG93ZXJwYy9tbS9ib29rM3M2NC9zbGljZS5jIHwgMjMgKysrKysrKysr
KysrLS0tLS0tLS0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgMTEg
ZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL21tL2Jvb2szczY0
L3NsaWNlLmMgYi9hcmNoL3Bvd2VycGMvbW0vYm9vazNzNjQvc2xpY2UuYw0KPiBpbmRleCBjMGI1
OGFmYjlhNDcuLjZjN2FjOGM3M2E2YyAxMDA2NDQNCj4gLS0tIGEvYXJjaC9wb3dlcnBjL21tL2Jv
b2szczY0L3NsaWNlLmMNCj4gKysrIGIvYXJjaC9wb3dlcnBjL21tL2Jvb2szczY0L3NsaWNlLmMN
Cj4gQEAgLTI4MiwxMiArMjgyLDEyIEBAIHN0YXRpYyB1bnNpZ25lZCBsb25nIHNsaWNlX2ZpbmRf
YXJlYV9ib3R0b211cChzdHJ1Y3QgbW1fc3RydWN0ICptbSwNCj4gICB7DQo+ICAgCWludCBwc2hp
ZnQgPSBtYXhfdChpbnQsIG1tdV9wc2l6ZV9kZWZzW3BzaXplXS5zaGlmdCwgUEFHRV9TSElGVCk7
DQo+ICAgCXVuc2lnbmVkIGxvbmcgZm91bmQsIG5leHRfZW5kOw0KPiAtCXN0cnVjdCB2bV91bm1h
cHBlZF9hcmVhX2luZm8gaW5mbzsNCj4gLQ0KPiAtCWluZm8uZmxhZ3MgPSAwOw0KPiAtCWluZm8u
bGVuZ3RoID0gbGVuOw0KPiAtCWluZm8uYWxpZ25fbWFzayA9IFBBR0VfTUFTSyAmICgoMXVsIDw8
IHBzaGlmdCkgLSAxKTsNCj4gLQlpbmZvLmFsaWduX29mZnNldCA9IDA7DQo+ICsJc3RydWN0IHZt
X3VubWFwcGVkX2FyZWFfaW5mbyBpbmZvID0gew0KPiArCQkuZmxhZ3MgPSAwLA0KDQpQbGVhc2Ug
cmVtb3ZlIHplcm8taW5pdCBhcyBhZ3JlZWQgYW5kIGV4cGxhaW5lZCBpbiB0aGUgY29tbWl0IG1l
c3NhZ2UNCg0KPiArCQkubGVuZ3RoID0gbGVuLA0KPiArCQkuYWxpZ25fbWFzayA9IFBBR0VfTUFT
SyAmICgoMXVsIDw8IHBzaGlmdCkgLSAxKSwNCj4gKwkJLmFsaWduX29mZnNldCA9IDANCg0KU2Ft
ZSBoZXJlLg0KDQo+ICsJfTsNCj4gICAJLyoNCj4gICAJICogQ2hlY2sgdGlsbCB0aGUgYWxsb3cg
bWF4IHZhbHVlIGZvciB0aGlzIG1tYXAgcmVxdWVzdA0KPiAgIAkgKi8NCj4gQEAgLTMyNiwxMyAr
MzI2LDE0IEBAIHN0YXRpYyB1bnNpZ25lZCBsb25nIHNsaWNlX2ZpbmRfYXJlYV90b3Bkb3duKHN0
cnVjdCBtbV9zdHJ1Y3QgKm1tLA0KPiAgIHsNCj4gICAJaW50IHBzaGlmdCA9IG1heF90KGludCwg
bW11X3BzaXplX2RlZnNbcHNpemVdLnNoaWZ0LCBQQUdFX1NISUZUKTsNCj4gICAJdW5zaWduZWQg
bG9uZyBmb3VuZCwgcHJldjsNCj4gLQlzdHJ1Y3Qgdm1fdW5tYXBwZWRfYXJlYV9pbmZvIGluZm87
DQo+ICsJc3RydWN0IHZtX3VubWFwcGVkX2FyZWFfaW5mbyBpbmZvID0gew0KPiArCQkuZmxhZ3Mg
PSBWTV9VTk1BUFBFRF9BUkVBX1RPUERPV04sDQo+ICsJCS5sZW5ndGggPSBsZW4sDQo+ICsJCS5h
bGlnbl9tYXNrID0gUEFHRV9NQVNLICYgKCgxdWwgPDwgcHNoaWZ0KSAtIDEpLA0KPiArCQkuYWxp
Z25fb2Zmc2V0ID0gMA0KDQpTYW1lIGhlcmUuDQoNCj4gKwl9Ow0KPiAgIAl1bnNpZ25lZCBsb25n
IG1pbl9hZGRyID0gbWF4KFBBR0VfU0laRSwgbW1hcF9taW5fYWRkcik7DQo+ICAgDQo+IC0JaW5m
by5mbGFncyA9IFZNX1VOTUFQUEVEX0FSRUFfVE9QRE9XTjsNCj4gLQlpbmZvLmxlbmd0aCA9IGxl
bjsNCj4gLQlpbmZvLmFsaWduX21hc2sgPSBQQUdFX01BU0sgJiAoKDF1bCA8PCBwc2hpZnQpIC0g
MSk7DQo+IC0JaW5mby5hbGlnbl9vZmZzZXQgPSAwOw0KPiAgIAkvKg0KPiAgIAkgKiBJZiB3ZSBh
cmUgdHJ5aW5nIHRvIGFsbG9jYXRlIGFib3ZlIERFRkFVTFRfTUFQX1dJTkRPVw0KPiAgIAkgKiBB
ZGQgdGhlIGRpZmZlcmVudCB0byB0aGUgbW1hcF9iYXNlLg0KDQpDaHJpc3RvcGhlDQo=

