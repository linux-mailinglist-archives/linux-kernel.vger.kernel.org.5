Return-Path: <linux-kernel+bounces-90116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A8086FA89
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:13:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6D428351E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2C61134C5;
	Mon,  4 Mar 2024 07:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="Hctgih6Y"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2055.outbound.protection.outlook.com [40.107.247.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F8553A6;
	Mon,  4 Mar 2024 07:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709536418; cv=fail; b=OwHzHLACvRD2Qhjuh3iudq9PvH2VQy6KXnfuFgvmHFKVrHrq3wP+WZjoqifpiH79MoESbghpG4XW0yA0DwJrYR5guEz2ZKZSQnBPwKNVckzqfTZULzVSC2ZWGxqSwvxMC6/kxmH//0XHSKWvMx/b3e/2TxpG6O7QYcaPOwEvnP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709536418; c=relaxed/simple;
	bh=GSbIfK0yebG/iaYoECCwP0wTjUPAqqfXlqLjR1SnywI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rd7kwW+1bGX1EjcJDKyuV8l54tRoXspXdwZfUvJmBjmd7exPLChD2noF+3J/rurELfbOskS1Vk7DmGc5Hd5ieZrXDmFVg+rBx4JqxnRqE74xvAKO8PAQJKGhRq2kUjgcoFiYzasRzcqT0iRK1iuJ+3Al1DCqdq1/f6tnX9T/Gbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=Hctgih6Y; arc=fail smtp.client-ip=40.107.247.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iXRhJBWB9R+DjjELrywV9YhOgCQHBeqXk4i8VJ2axIKi831T+NyMGzopqP1uP+ms3I8q2bJrXyY/ia33lAKOy9omEfOV6K8dz9jlbIC0hYZ2zcD3z2Z+dEgNIvSGYDU7mEmT788jd8BV+/NGvZg6yYJmM0gNH1+fq4y/7LUhbg3OX/Fnk6N4pdMzLR1aWDoBcH1AvbjXsiK+YXUAMfSpfrBA3P8DxINBdkTsivwXvaEAnYcsSiW0BGEPb5VqdlmOG7RhtTTPJJXVEabTiVxeDKwxFCZWiB1jJFACv/GDxO3pOxmI7iQPAXBsn9L1m4yORQwk9oMQM0RjR6Wbzoaywg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSbIfK0yebG/iaYoECCwP0wTjUPAqqfXlqLjR1SnywI=;
 b=K+exlgPpVHGDcv/rOhR+/2wFZArGTJ7duE9peNBpFvgQzOQZK3UxUg75p88/lotRiy+xCsCWanNYIyhB59B6FQ/cB8AOSj8U0/y5oIpmXTWVQGnRKaPijelmsN8KIycJ+ud8ruVYmOJLtC60ZXTccMZObOLsR7N7v2ohCNiahRcbqqQdBTZbvrN49lwWWyt2MPWtRs610FScaXx0H2LT4hI1wmZYVjVUs9menak/DHW+4cpCiLahuHVnK0ZciCvc722tXo1lF6NIIcsqArwpXEXaHXkMsCe76yB5kJtQPIaE5Y942k12xQLe/BjGNLrrd/5NIG1CdSB44C2zaHLeFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSbIfK0yebG/iaYoECCwP0wTjUPAqqfXlqLjR1SnywI=;
 b=Hctgih6YJiHkruwM9jmLFTbr16MJQYfuYRDbH5/igy/5nJr/EdOfzzOUsrD7ZCWE9ZZC1eQkZ6Eu+6VIIzoF6IN5WoYjgSkgCtpZZcnUevpr8S6lqtTGZX9E4lVpEASaE8e4PhFeNvWaeiHMRNKv64EeOKyFvj8/+wqI3sa+Cgusr4sBiiV5URUFHS2w3BJWGt3Jz4cwOirf5uCM642bbOqisjY96W4VS9h13vwKxdZMO7JsgQQcXdr0tXBrx3hMvPZfXZgNSMtYfghX9iiHQRhl+TD1lbnjz2Dip7fckNFyeme1RiTDnY5S4PfrnGkWmuWp3WkKArHFFJbZ/wX2pw==
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5b6::22)
 by GV2PR10MB6743.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 07:13:32 +0000
Received: from AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ab67:6d35:16b1:81c8]) by AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::ab67:6d35:16b1:81c8%3]) with mapi id 15.20.7339.035; Mon, 4 Mar 2024
 07:13:32 +0000
From: "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
To: "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
	"sherry.sun@nxp.com" <sherry.sun@nxp.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "ilpo.jarvinen@linux.intel.com"
	<ilpo.jarvinen@linux.intel.com>, "robh@kernel.org" <robh@kernel.org>,
	"shenwei.wang@nxp.com" <shenwei.wang@nxp.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "jirislaby@kernel.org" <jirislaby@kernel.org>,
	"robert.hodaszi@digi.com" <robert.hodaszi@digi.com>
CC: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "frank.li@nxp.com" <frank.li@nxp.com>
Subject: Re: [PATCH] tty: serial: fsl_lpuart: avoid idle preamble pending if
 CTS is enabled
Thread-Topic: [PATCH] tty: serial: fsl_lpuart: avoid idle preamble pending if
 CTS is enabled
Thread-Index: AQHabdet765+VjOUbUytOxBi69jITrEnKz2A
Date: Mon, 4 Mar 2024 07:13:32 +0000
Message-ID: <2e1b1eae2e9d3cedcd270e35cfcf8086b914b7ff.camel@siemens.com>
References: <20240304020712.238637-1-sherry.sun@nxp.com>
In-Reply-To: <20240304020712.238637-1-sherry.sun@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR10MB6867:EE_|GV2PR10MB6743:EE_
x-ms-office365-filtering-correlation-id: fcff67c8-b668-4fdd-657a-08dc3c1a99c9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 UmxwlhTy+WjAxcl1BYBK8AxBJZH+NpDPAP7+9fS8HvmJPTl1oMOZqrlWuLYvVePo/Me1yg5DtuI/tuS2VUbPeEneVjIwytqFS13kUMEb4jrQeDEgYjCjcGhb7ueE42hXoOrngpMRaYlVf3d+RbK+eNVpmY+Rkn3d3aSSPco/EuC7l6qqdMeGy2BXW0OySDtMjN8mylAe37sF7og3DBdX3X6JVGbmm9iQpDgvDUq3hnMCXQ1jlPfxUAl7b0tTWRWSRagUSIqfOUhMM5wGYAviLkJochetJs1czCCF6WQg1LzDdDI6TVk5La8bwgRqkOQYZM0FTciBroz+D9a+/7C5GXgfIQ9k6sAfiDkyMOqc6jW9cFOYLRLi78rLKWeQ0V4Dw61VwmnwMz66LXGSzAlBy8QBkXnvcxApIuXcDbnwgwFR2DCyXTZFlpShg6ELUBxdrTfPiTUCqjFS0w3Lk20C0DdY2Dz9CpaajkZUleK3OIy/4s4zC2KJ4n8sfFUUsMWytLDrYYaV++eCPNtsg84WqcP0rOY/tZ94KC9TPruc8AoA3qa69I4i/mzVy4in3GHADiO8JjMuVFjFmRP9xoHLIOv/f7tNHfXiAIjTGpmpvHU9jA/+pV4innDyRBm1i0LFTAatjHGtXq7hK4yYmTG64acBmJO1pHBaSxWKfHF8nSI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Nkt6RnRQaXRtWDFjL0RTOGg2enA3UkllRVBvbWJpL2ZhMk9LSzdQYjVMckY3?=
 =?utf-8?B?SWxBMVkvd1hUOEMwd0pFL2k5emlmOUdmYm1TSmpyYmxiZHR2VDhhYW5zNCsx?=
 =?utf-8?B?NndBL3dmVjN0MUVJRkRnNldjRi91cDltVDRCNTJyZnM3bnhGejdnRWhqcitp?=
 =?utf-8?B?R0pXcUhVb2pUQm9pV1NXQ0s2SHlHYnU2U3VocjEreUpad0RSTXhqRTVtbWpP?=
 =?utf-8?B?ZjZxWW56bE1sbEpUSE5hUmZQTEV1L2hiTjVrb2VsMy9IZ1ZOOHF6UWVHM0cz?=
 =?utf-8?B?WS9URW5wY25RV1c1WUdWZ1lYeGlaZ1dGR1BjNnJSQ2hac2UwRml1cWMxcWFO?=
 =?utf-8?B?VFZBcy81WU1CbFVLcWpyd2ZpV1VidWlIa1NxTm5xakY0K2RYMXY2bWFaekpH?=
 =?utf-8?B?V2ZPbWc5YURibDA0SlM5T3BoMUhYcHFSdTJydTdYNmFTKzd0NTJua2hlVEsr?=
 =?utf-8?B?QTlWc2xsR3RVWWlyRzRZQWhML01kK0RZdmVMZXozb2doVVVMbFZDS2IzK3l6?=
 =?utf-8?B?djJRVUVYblNKcncvcEs2NHV1TExJVWVKUXJpWW14OVNNZVUzWjZwTUNkaGpC?=
 =?utf-8?B?aUxudmUwemwwS08yblRzbjhYOHNDZXcwT0wvZHFtakV6M0xIT3RJTDVCcjd4?=
 =?utf-8?B?SVF1WWUzd0svY1V4NDBidVRHUW1pek9Ea3U0QXBzdUE1RlFKS2o3Q0hTSGZC?=
 =?utf-8?B?NzNqanNVNHN3ai9YVE0raWQ3ZXQwa3FMOVhEaGJiSi9ZRkZ3UWdqV0ZVM0Uw?=
 =?utf-8?B?cHYxWG1KUUQ1SEFCZC92Zy93YjU3M1pEaHgvN0k1d2l6ZVRCNEp2ZmY0bGQz?=
 =?utf-8?B?UmZKWlVySld4UURicHBGRDViV3JWUzZqTmsxb29TQkorMnN6aEo2dE1ESXhI?=
 =?utf-8?B?S1BCVHE1eFR2SFk1ZFZUVFlMQ01MajBJRFU1Qjg4SEh6UWtHa1lyWmg5T1c1?=
 =?utf-8?B?NzlmUEZ1TXFwcjJjZFdJRkxSeEkwem5iVmppVy84bHNSNy9mQ05sYlNzZWZz?=
 =?utf-8?B?UEwzV20xd1JkRVRDQURXL0Z6YnY2TEhXZGU3M2c2SjljUjE5RmpWdXRVbGht?=
 =?utf-8?B?QnlzZ3hRZ1EraDhXdUNuYksxZkVpWFlCSmQzc3FzYVYwUW5CODdVNDl5Ky9Y?=
 =?utf-8?B?TGNva1prWlhncno0RjdXcGhZbWhvZ0VTT2RqaEVxeUYzMnRhUWZRYVpDK3JX?=
 =?utf-8?B?VjF6TGlPRjlsRXJNTHFxekhiZm5tR1JiaHV3MlNXaXB5RzFkelRFbWl4OSt5?=
 =?utf-8?B?eC81Tlk5ZlhYRGtha25jbUV0UHVmak1vWGdQYWtOVkxLak1kSzAwQ01SbGFm?=
 =?utf-8?B?MUJCUGdjUkd2YVk4WXRXSXAxUEJ3Q05PNFkwbDhtaDNUaW5WbVB2N2lGbmJK?=
 =?utf-8?B?Vk5jSlRWekhUOG9NZVd2ZHNTMzdkS2JXbXNBbzc0VUJUOWlNdTBzU3B0b2xz?=
 =?utf-8?B?MW1KUFhuWkp5ZHJ5T0hhbHg0L2J2d1BMV0RPaVloNForNk5DWnpEZ2lMUllm?=
 =?utf-8?B?TE9YMHlHVGR4TjdpdURHV2VXZnRNUWo2V0dWMnFLQ3A1QVgwOEswOWZ2UjEv?=
 =?utf-8?B?a2FwR0dXN3plUk54bnUrcmxHUDkvcEVteGdxb0syT3VIWWJzcWhhTldIdWc5?=
 =?utf-8?B?cXNIU0ZlajVSeE1TVVRJMmdMR3ZRZG5GN3IzVTNsZW1nR1pkUDI0Ukk1WkFZ?=
 =?utf-8?B?U3QxMGlQbGVjK2kvQStKVkRvL0cvUjJJWTZTVGZMeC9PNlE4N2N1RWx2UUp3?=
 =?utf-8?B?UUFSdWRIVkdIckZXSDVSL3p2WDRPeTZvMm84QjlJZjJKTGFEYURGUFhlWG1m?=
 =?utf-8?B?SjBpRDltak55RitDcy93SStOMHZldnNSVnF6b0Zyc3BTS1R2TUFXcFpWN1I3?=
 =?utf-8?B?QzI3dTFqcmJWMGxKYlpscWpDUmZmcUtzTFF6WGNEQ2ZrNGFnZ1A2OGRyMlZJ?=
 =?utf-8?B?M3dJdnRES3YwdVNiRGVTQkNSNERST2NDY29vYnVxNnVzcmN4dHlSQmE3dVdH?=
 =?utf-8?B?RDJWdjhINVZiL2ZKQS8rays2NXpJTk1BVUlBbUkwS09RK3pQaXNEb2lhWXRR?=
 =?utf-8?B?bzNxNlFaUXpBTGtOZlhiaVI4c3JmKy91REkzSnlWdEdIcG0zMjRBelRNOFgx?=
 =?utf-8?B?YjFvQ1pGdUpFQVpHbHZubEpNM2U2ODQ1azdyUmFONFluSUF6b3laTzd0bzRH?=
 =?utf-8?B?U05janVlSlJVR0grZGVLZEdmdlU2alpGUlF0WnhHRnJuSE4vSGtnSzFERmk5?=
 =?utf-8?Q?Pf7VPXu3SWDhFlJU+53lHAe6km9gHnpube5aC2DB+M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <828CA9219CA6A140B977F754973E8929@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR10MB6867.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fcff67c8-b668-4fdd-657a-08dc3c1a99c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 07:13:32.6536
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XV+Bis5wYHIaY4CbllEfGFcUC5KhBXJreXYNZYfGq19LbOcH0sV1/Bl/xUdzkL+FY3fYLXvIlID+WfHZyKTGx2B+PHKeJ0h+ScYD0MVVZQc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6743

SGkgU2hlcnJ5LA0KDQp0aGFuayB5b3UgZm9yIHRoZSBmaXghDQoNCk9uIE1vbiwgMjAyNC0wMy0w
NCBhdCAxMDowNyArMDgwMCwgU2hlcnJ5IFN1biB3cm90ZToNCj4gSWYgdGhlIHJlbW90ZSB1YXJ0
IGRldmljZSBpcyBub3QgY29ubmVjdGVkIG9yIG5vdCBlbmFibGVkIGFmdGVyIGJvb3RpbmcNCj4g
dXAsIHRoZSBDVFMgbGluZSBpcyBoaWdoIGJ5IGRlZmF1bHQuIEF0IHRoaXMgdGltZSwgaWYgd2Ug
ZW5hYmxlIHRoZSBmbG93DQo+IGNvbnRyb2wgd2hlbiBvcGVuaW5nIHRoZSBkZXZpY2UoZm9yIGV4
YW1wbGUsIHVzaW5nIOKAnHN0dHkgLUYgL2Rldi90dHlMUDQNCj4gY3J0c2N0c+KAnSBjb21tYW5k
KSwgdGhlcmUgd2lsbCBiZSBhIHBlbmRpbmcgaWRsZSBwcmVhbWJsZShmaXJzdCB3cml0aW5nIDAN
Cj4gYW5kIHRoZW4gd3JpdGluZyAxIHRvIFVBUlRDVFJMX1RFIHdpbGwgcXVldWUgYW4gaWRsZSBw
cmVhbWJsZSkgdGhhdA0KPiBjYW5ub3QgYmUgc2VudCBvdXQsIHJlc3VsdGluZyBpbiB0aGUgdWFy
dCBwb3J0IGZhaWwgdG8gY2xvc2Uod2FpdGluZyBmb3INCj4gVFggZW1wdHkpLCBzbyB0aGUgdXNl
ciBzcGFjZSBzdHR5IHdpbGwgaGF2ZSB0byB3YWl0IGZvciBhIGxvbmcgdGltZSBvcg0KPiBmb3Jl
dmVyLg0KPiANCj4gVGhpcyBpcyBhbiBMUFVBUlQgSVAgYnVnKGlkbGUgcHJlYW1ibGUgaGFzIGhp
Z2hlciBwcmlvcml0eSB0aGFuIENUUyksDQo+IGhlcmUgYWRkIGEgd29ya2Fyb3VuZCBwYXRjaCB0
byBlbmFibGUgVFggQ1RTIGFmdGVyIGVuYWJsaW5nIFVBUlRDVFJMX1RFLA0KPiBzbyB0aGF0IHRo
ZSBpZGxlIHByZWFtYmxlIGRvZXMgbm90IGdldCBzdHVjayBkdWUgdG8gQ1RTIGlzIGRlYXNzZXJ0
ZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTaGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+
DQo+IC0tLQ0KPiDCoGRyaXZlcnMvdHR5L3NlcmlhbC9mc2xfbHB1YXJ0LmMgfCA2ICsrKysrLQ0K
PiDCoDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jIGIvZHJpdmVycy90
dHkvc2VyaWFsL2ZzbF9scHVhcnQuYw0KPiBpbmRleCA1ZGRmMTEwYWVkYmUuLmRjZTFiNTg1MWRl
MCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy90dHkvc2VyaWFsL2ZzbF9scHVhcnQuYw0KPiArKysg
Yi9kcml2ZXJzL3R0eS9zZXJpYWwvZnNsX2xwdWFydC5jDQo+IEBAIC0yMzQ1LDggKzIzNDUsMTIg
QEAgbHB1YXJ0MzJfc2V0X3Rlcm1pb3Moc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwgc3RydWN0IGt0
ZXJtaW9zICp0ZXJtaW9zLA0KPiDCoA0KPiDCoMKgwqDCoMKgwqDCoMKgbHB1YXJ0MzJfd3JpdGUo
JnNwb3J0LT5wb3J0LCBiZCwgVUFSVEJBVUQpOw0KPiDCoMKgwqDCoMKgwqDCoMKgbHB1YXJ0MzJf
c2VyaWFsX3NldGJyZyhzcG9ydCwgYmF1ZCk7DQo+IC3CoMKgwqDCoMKgwqDCoGxwdWFydDMyX3dy
aXRlKCZzcG9ydC0+cG9ydCwgbW9kZW0sIFVBUlRNT0RJUik7DQo+ICvCoMKgwqDCoMKgwqDCoC8q
IGRpc2FibGUgQ1RTIGJlZm9yZSBlbmFibGluZyBVQVJUQ1RSTF9URSB0byBhdm9pZCBwZW5kaW5n
IGlkbGUgcHJlYW1ibGUgKi8NCj4gK8KgwqDCoMKgwqDCoMKgbHB1YXJ0MzJfd3JpdGUoJnNwb3J0
LT5wb3J0LCBtb2RlbSAmIH5VQVJUTU9ESVJfVFhDVFNFLCBVQVJUTU9ESVIpOw0KPiDCoMKgwqDC
oMKgwqDCoMKgbHB1YXJ0MzJfd3JpdGUoJnNwb3J0LT5wb3J0LCBjdHJsLCBVQVJUQ1RSTCk7DQo+
ICvCoMKgwqDCoMKgwqDCoC8qIHJlLWVuYWJsZSB0aGUgQ1RTIGlmIG5lZWRlZCAqLw0KPiArwqDC
oMKgwqDCoMKgwqBscHVhcnQzMl93cml0ZSgmc3BvcnQtPnBvcnQsIG1vZGVtLCBVQVJUTU9ESVIp
Ow0KPiArDQo+IMKgwqDCoMKgwqDCoMKgwqAvKiByZXN0b3JlIGNvbnRyb2wgcmVnaXN0ZXIgKi8N
Cg0KVGhlIGZpeCBtYWtlcyBzZW5zZSB0byBtZSENCkkgc2VlIG9ubHkgb25lIGlzc3VlIHdpdGgg
YWJvdmUgY29tbWVudCwgd2hpY2ggY29tbWl0IDM4MGM5NjZjMDkzZTcNCmFscmVhZHkgaGF2ZSBw
dXQgcXVpdGUgc3ViLW9wdGltYWwgKGFmdGVyIHRoZSBhY3R1YWwgd3JpdGUpLCBidXQNCnlvdXIg
Y29tbWl0IG5vdyBzaGlmdHMgaXQgZXZlbiBmdXJ0aGVyIG1ha2luZyBpdCBjb21wbGV0ZWx5IGRh
bmdsaW5nLg0KU2hvdWxkIGl0IGJlIGJlZm9yZSBsYXN0IFVBUlRDVFJMIHdyaXRlPyANCg0KPiDC
oA0KPiDCoMKgwqDCoMKgwqDCoMKgaWYgKChjdHJsICYgKFVBUlRDVFJMX1BFIHwgVUFSVENUUkxf
TSkpID09IFVBUlRDVFJMX1BFKQ0KDQotLSANCkFsZXhhbmRlciBTdmVyZGxpbg0KU2llbWVucyBB
Rw0Kd3d3LnNpZW1lbnMuY29tDQo=

