Return-Path: <linux-kernel+bounces-104041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8E087C838
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 05:06:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 350C01F212FC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD8F7DDAA;
	Fri, 15 Mar 2024 04:05:58 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2105.outbound.protection.partner.outlook.cn [139.219.146.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E6FD530;
	Fri, 15 Mar 2024 04:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710475557; cv=fail; b=QgpbIVpKOkOSvF8Jz70iXWpCen/8X7Ykob9gyRKGzy8RLjVOwwf/GYvQp6FECIBBdNnge0971+JTnl8oRh2+JeDLntFBuIw9OKCpiiCn97LJ6rTIp5uaqd+7rQzFPczPjqWhjxquXePrJTh9+Zrm1619WjS5CIjEhufdu48eLac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710475557; c=relaxed/simple;
	bh=+NMOeyv4xdGP4Vryarl1g3Z3cfUCEu8smRDTAs5kjqU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fNKqNf+ULs/KpBVJIOFEDGTXBFEPQvj/lINa1ok0dd439tSTkK2rdrJIJsJLr9EmpAKZC2OFgTXFM/Tz4FdY1ozMXTyNrBAhWpouGWyFS6RgAHQlQAwTt4AuWl11tFkinxY3jeLE6a3FyAVufZIl/EM9iBMwBLSSpiyOK4HT0pE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BcyGxD0/FWjOsYg41BITKtTYg5CNhVFJrvLGQpPTDtj8TSQl5XqVog5Px2B7rGML+QaX8lrJsJ2Waq6R9CfozxssQLKglhsTwKDCQhl6I0QYUAw6in1Puj4xqwNoCYZohAN5CZIFhSySURDT+wbLDnClSXid81Y7fuxMYxrn4DGVRiqlN0LwGiDI6xKZ/eMtfgMb9d5ezn0N+/pO6AllHcS3f0CbqElHJRr4E57wx4gZ1+WADT3+0IDK9HmN8vVRSZ5JPagd6bmWZo+KH7Car1b3bdleU8rwddaGHV3WjfqcXANdF4zbHPBo00Z4CGbXs86HfF51ulLWTtwbRshaUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+NMOeyv4xdGP4Vryarl1g3Z3cfUCEu8smRDTAs5kjqU=;
 b=DcwIkdElcINt7wo4MTRPUw6SAh3phAoXbE3Qfvzl73sUYdb0TGTuZeykORI2TkFPHllhMtPZw7EUvoGw4r4ONY/rzH0IBm2UM9X2bbATDr/ub6En92yZcGq8+6rUZl486VNjZzofe2wPZEFxoDwE/4dsU4ecNwHNttCr/0sDCUc+zT6CJjJzbNRLW+Ayd/kSY2muSmGo/lvRV7kplAA/yT8LP/fOMxG6BMIFuMh5IMXfa4b2kKlAMEdOQmuLZGMRODINK+44apJZrb8IIznl4IC/C4P96a3o6gzr6cUyTUXauP9CoOi2NnpbfWTMzxVT97eNzw46e6OEb+EXacZ7og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:8::10) by NTZPR01MB1098.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Fri, 15 Mar
 2024 03:50:37 +0000
Received: from NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
 ([fe80::4568:1008:233b:760b]) by
 NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn ([fe80::4568:1008:233b:760b%2])
 with mapi id 15.20.7339.045; Fri, 15 Mar 2024 03:50:37 +0000
From: Xingyu Wu <xingyu.wu@starfivetech.com>
To: Xingyu Wu <xingyu.wu@starfivetech.com>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>
CC: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
	<sboyd@kernel.org>, Conor Dooley <conor@kernel.org>, Hal Feng
	<hal.feng@starfivetech.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-clk@vger.kernel.org"
	<linux-clk@vger.kernel.org>
Subject:
 =?utf-8?B?5Zue5aSNOiBbUEFUQ0ggdjJdIGNsazogc3RhcmZpdmU6IGpoNzExMC1zeXM6?=
 =?utf-8?B?IEZpeCBsb3dlciByYXRlIG9mIENQVWZyZXEgYnkgc2V0dGluZyBQTEwwIHJh?=
 =?utf-8?Q?te_to_1.5GHz?=
Thread-Topic: [PATCH v2] clk: starfive: jh7110-sys: Fix lower rate of CPUfreq
 by setting PLL0 rate to 1.5GHz
Thread-Index: AQHZ1EQ/GNd4hMrDKUKxcZ0GCVVgKa/0XFGAgAFMYYD//9WpAIBKZ2EAgPl4x2A=
Date: Fri, 15 Mar 2024 03:50:37 +0000
Message-ID:
 <NTZPR01MB09565DB26C91BC43D6DA479F9F28A@NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn>
References: <20230821152915.208366-1-xingyu.wu@starfivetech.com>
 <CAJM55Z_XxHeC-X2d4qcsRK6THLyqWV4SsSW3S+cC8yszpPD9Og@mail.gmail.com>
 <07ddac3c-eb6e-d187-b942-102f117f8d13@starfivetech.com>
 <CAJM55Z-gYpn_FjG2Zb__Nt=rbrNQN8QDNB=KEFdeVkz9Ptv72Q@mail.gmail.com>
 <cafa2a29-931d-2f00-5880-e627a4d474df@starfivetech.com>
In-Reply-To: <cafa2a29-931d-2f00-5880-e627a4d474df@starfivetech.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: NTZPR01MB0956:EE_|NTZPR01MB1098:EE_
x-ms-office365-filtering-correlation-id: ccde90c2-cded-4ff5-4b85-08dc44a31341
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 5kuUP0ig60CK8O73KtPV3KHg322hDbSxOuIGVbEXdYa3xHOaWyCinhsAsCWhpvmJCCnPz7OSCZva95GxnwQ5UffBtxGINlYWQ9V0QpWkd8M7pDTia1VuBqdJ05tl3I2GkmNYelDfEgSMpatbSocvsMAjciywi8ZBHEHQXOWLjU7giKke/lox+MU/xrs529nbfQmTuhrW7aXwGTocQNDZHhMiMpCasD3PaLnhRUP5x5797slBdKJNqpxvSpHFzXPIiHMftCDrx4rx0BEIQgaAj53b8UPUsVgZiUhf6LYWobiR03yR8PDMRBgZKH5PfUm3NKyHLP2m4vs4Q8RicXbN8p2TaW1mPec14Q1VPzPQWmrD/1iaasT1Bp7Tzz2ov3QFZJx0QOCMSSDtLomqiW9m8Pq+M1jGV3Wbe1GRyhL+Rh752TFSztn82/okybxEsPL8yHX1Kbm0mVaMQrlB1evHReK9td6ORl30LYJ/EMrkW+QXGuTzj8+iFZP6bh4Uz4Kh7sZmggEEl6kb4PqVOe9vc/yFMrHo/AJRvDMlYnEwAsn+omqVS1KxszABJoDMvlEdL2TC6Dr/uWtZj3QtF+mr61846ELy/Dv+RBBMGvFC5QeJ00P9GuWoeprD5lHL8u1X
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L3ZkM2p5YzU5dTFjY2VFK3hzVGFxZzlZam9LR3BqNDRXSHFlaXFhaFAxVTcy?=
 =?utf-8?B?RXZ5VnR4Z2Fkc09nSGMrZ1poT2p3MUZIcDlCYWt5YlFUTy8zZjNQQ04wSkQr?=
 =?utf-8?B?QkV1R2FtKzRDSW9PLzc0QXV6NGdiUDBIMHlGMFNmZlNFMzc0bXJXbkFNWmZr?=
 =?utf-8?B?L1Nsa1dYcVFUNlF6V3JGZVVvTjJoL2J5WEppdytDTkZFMVFJN1J0TkhhVmNR?=
 =?utf-8?B?Qzd5SnF0b3M3Skp3MDczYWNUN2d3dVBob2lhMjFRNk43UEpaeHJHY3RHbDVW?=
 =?utf-8?B?UzcvdVhITXpOSFFiTTZ4UVQ3VUtqVUR4NjZ5QTFnSnkweGs4TTRUR1Uyanhy?=
 =?utf-8?B?aCs1Nk9pb3hMQnVJOFV4eFp1K0lBZHYxMWs4c09qZkdtb0NsZk5hcDZiZGdB?=
 =?utf-8?B?SWp2ZmtGR2xEZkhpM2hVeWlSeU9oVVZ3SWJkS1BQbndxcDAwb1Z1TkpGa2tI?=
 =?utf-8?B?WElGV2tyN3REd0w0S3Vqb1NkeWtmZ0U1Rzhob0hzbyttck8rSWl2TE1DY1pC?=
 =?utf-8?B?SW5VcXlwaXJrdjdsNzJ6eXFmTDZ2V2IwOURsbUN3U09sTnB5OWMvVVpQVkVa?=
 =?utf-8?B?alFaTFRoWnZxN0s1NXFyL0VUWWZJQ2lGQllBT1ZMb3BRVk14SXV6SUM1bnh1?=
 =?utf-8?B?V1dJQUViOVlKdkNYOUpNeTlXYW5FVHVmUm52RXU3SThPZllXVVNidXg0aHFY?=
 =?utf-8?B?RW11K1JISkxackJ3c2s5YWUyQlJ4d0crYlFIUXZMY3NLTGtxY3RqUmR0M24v?=
 =?utf-8?B?U0o0S01YcmMzdGg3bWF6UTg2MHlmKzdMaFZIaUM2dnd3UGhXc1JIcUU1U2gy?=
 =?utf-8?B?anpSZG1jUTlMSGpHNWxTRGk0MTcxNnZrcWJ5WWtuTHNsZ29IZGZ5RXlEV2xF?=
 =?utf-8?B?YXJyRDRLZ1dQdnU4UGFvOUZhd0hYMkM0OExsT0l6TFZSOEw0VWlXdzdPNVJk?=
 =?utf-8?B?OXJ0RG9WV1NTUWVMd1dxUXYzdEN2dUZFTzF0dFIwNDFrL3YxejRwOFhwQ1Ri?=
 =?utf-8?B?bnY2T2lYOCtXb09GeHZVc0l2QlJFaG9sa21vbzdsWE5lRkIzeCtxSVc5aUo0?=
 =?utf-8?B?Tzh4cVVxbklPUHcwQ1pyd1ptRlJTZGo4SDN0UUljRFU1RXVaYTNHOTBZZWRh?=
 =?utf-8?B?aTY4UFg2dlJDQnp1SlFiVGlYSVE1aE5QZWk4N0tzRGJGL0wvaHg2WHIwQkNm?=
 =?utf-8?B?UFl3eEp6eUlVc0p0S3pLU3RnNlF2WlZObXY5ZWxFaTdCbU85RjZiTFNweW1C?=
 =?utf-8?B?a24yaWxjNHd3VEwyclh1bHBZQ0d4b05WV05Nem5nNVFJdExXNXVwb0hYNjFi?=
 =?utf-8?B?akxjQnMvckgyOEE2STd3dEFiNDcyVERnMW4reWdoOVhsTjhRR2VUZXg5NlNm?=
 =?utf-8?B?NVR3djY5QmZEdXg4WlZrZHlHZVV0K29HN3JSSlpuQ2RxQ1V3LzZCcXZ3dnEw?=
 =?utf-8?B?a1AwMFM4RTB4cSsrN3FXRUttRUJvNFFWMEVzV0l0VGdvd3Z2SlJnd0pUVHNq?=
 =?utf-8?B?VGVwMGhIa3JFLzN4eVBOVFpUVHhSTS92WnFJUG12MGRVRmk3bzY0VkJaMWd4?=
 =?utf-8?B?WWdMQTV6L1hiYzAyUUNFOWhkRmxZRDB5OUZOclVTeUJHTzYyUUZZT0MwRjd5?=
 =?utf-8?B?THZteU9mOU16cStOUFJSR0o1aHVUa2xhcDQzcVdqd2tLWXBFSGNIQ1JaMnNF?=
 =?utf-8?B?ZWZ6MmJxc0Nhd0RQT3dvMFdOUmptblJQWWNxZytFL2hiT21kMUxBQ0pqTzdS?=
 =?utf-8?B?STZ4MGJTY0J2RlZ1TmJkTjVpUyswSTR0bW15ME9SUStPc2djN3JLNFNuT3BP?=
 =?utf-8?B?eU5wQlkwSVIra3hXU3ZDM0lhMkRSSHFISmtSRzF6cnI0RWw3NEVLL21mWXg4?=
 =?utf-8?B?SHRGQmdVWUJLTTYwRS9WZ1BSNkdSR01aSGp0Tm0yWWhFTGtwZXB5THV5VXZL?=
 =?utf-8?B?QWVkUGZoc2UxVGx0Q05OU2xQRnBPK0xNSDBJaVRmSmdBRGtDK0dNc1NjR3RO?=
 =?utf-8?B?Nk1vRmw2R2hkbHpUT2VtSzd1amtoR0dTYXp6c1Z0bGlUQ1hURXp3d1F4Q081?=
 =?utf-8?B?YUZRU1pyeVRjV2pRaDYwMWVIdVRwZlp4dnZrOGZOSCtyUE1aU0ovTHVCeElL?=
 =?utf-8?Q?vIf+4IijqxEGfCakOnOiHEnBi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: NTZPR01MB0956.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: ccde90c2-cded-4ff5-4b85-08dc44a31341
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 03:50:37.2837
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fxY3r9eA0zpYGj6evrqS6P9Y5sULdBUdyS5zIk8hwmq09p91MLN8F1luwofhVN9Lt8p131UtjPwzvNytPo8SFu3j54MlzVtwRi6pEvG3cwI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: NTZPR01MB1098

PiBPbiAyMDIzLzgvMjIgMTY6NTYsIEVtaWwgUmVubmVyIEJlcnRoaW5nIHdyb3RlOg0KPiA+IE9u
IFR1ZSwgMjIgQXVnIDIwMjMgYXQgMDU6MzMsIFhpbmd5dSBXdSA8eGluZ3l1Lnd1QHN0YXJmaXZl
dGVjaC5jb20+IHdyb3RlOg0KPiA+PiBPbiAyMDIzLzgvMjEgMjM6MzgsIEVtaWwgUmVubmVyIEJl
cnRoaW5nIHdyb3RlOg0KPiA+PiA+IE9uIE1vbiwgMjEgQXVnIDIwMjMgYXQgMTc6MjksIFhpbmd5
dSBXdSA8eGluZ3l1Lnd1QHN0YXJmaXZldGVjaC5jb20+DQo+IHdyb3RlOg0KPiA+PiA+Pg0KPiA+
PiA+PiBDUFVmcmVxIHN1cHBvcnRzIDQgY3B1IGZyZXF1ZW5jeSBsb2FkcyBvbiAzNzUvNTAwLzc1
MC8xNTAwTUh6Lg0KPiA+PiA+PiBCdXQgbm93IFBMTDAgcmF0ZSBpcyAxR0h6IGFuZCB0aGUgY3B1
IGZyZXF1ZW5jeSBsb2FkcyBiZWNvbWUNCj4gPj4gPj4gMzMzLzUwMC81MDAvMTAwME1IeiBpbiBm
YWN0Lg0KPiA+PiA+Pg0KPiA+PiA+PiBTbyBQTEwwIHJhdGUgc2hvdWxkIGJlIHNldCB0byAxLjVH
SHouIENoYW5nZSB0aGUgcGFyZW50IG9mDQo+ID4+ID4+IGNwdV9yb290IGNsb2NrIGFuZCB0aGUg
ZGl2aWRlciBvZiBjcHVfY29yZSBiZWZvcmUgdGhlIHNldHRpbmcuDQo+ID4+ID4+DQo+ID4+ID4+
IFJldmlld2VkLWJ5OiBIYWwgRmVuZyA8aGFsLmZlbmdAc3RhcmZpdmV0ZWNoLmNvbT4NCj4gPj4g
Pj4gRml4ZXM6IGUyYzUxMGQ2ZDYzMCAoInJpc2N2OiBkdHM6IHN0YXJmaXZlOiBBZGQgY3B1IHNj
YWxpbmcgZm9yDQo+ID4+ID4+IEpINzExMCBTb0MiKQ0KPiA+PiA+PiBTaWduZWQtb2ZmLWJ5OiBY
aW5neXUgV3UgPHhpbmd5dS53dUBzdGFyZml2ZXRlY2guY29tPg0KPiA+PiA+PiAtLS0NCj4gPj4g
Pj4NCj4gPj4gPj4gSGkgU3RlcGhlbiBhbmQgRW1pbCwNCj4gPj4gPj4NCj4gPj4gPj4gVGhpcyBw
YXRjaCBmaXhlcyB0aGUgaXNzdWUgYWJvdXQgbG93ZXIgcmF0ZSBvZiBDUFVmcmVxWzFdIGFuZCBz
ZXRzDQo+ID4+ID4+IFBMTDAgcmF0ZSB0byAxLjVHSHouIEluIG9yZGVyIG5vdCB0byBhZmZlY3Qg
dGhlIGNwdSBvcGVyYXRpb24sIHRoZQ0KPiA+PiA+PiBjcHVfcm9vdCdzIHBhcmVudCBjbG9jayBz
aG91bGQgYmUgY2hhbmdlZCBmaXJzdC4NCj4gPj4gPj4gQW5kIHRoZSBkaXZpZGVyIG9mIHRoZSBj
cHVfY29yZSBjbG9jayBzaG91bGQgYmUgc2V0IHRvIDIgc28gdGhleQ0KPiA+PiA+PiB3b24ndCBj
cmFzaCB3aGVuIHNldHRpbmcgMS41R0h6IHdpdGhvdXQgdm9sdGFnZSByZWd1bGF0aW9uLg0KPiA+
PiA+DQo+ID4+ID4gSGkgWGluZ3l1LA0KPiA+PiA+DQo+ID4+ID4gSXQgc291bmRzIGxpa2UgdGhp
cyBpcyBzb21ldGhpbmcgdGhlIGRyaXZlciBzaG91bGQgaGFuZGxlDQo+ID4+ID4gYXV0b21hdGlj
YWxseSB3aGVuZXZlciBjbGtfc2V0X3JhdGUoKSBpcyBjYWxsZWQgb24gdGhlIFBMTDAgY2xvY2su
DQo+ID4+ID4gVGhlbiB3ZSBzaG91bGQgYmUgYWJsZSB0byB1c2UgcmVndWxhciBhc3NpZ25lZC1j
bG9ja3MgLw0KPiA+PiA+IGFzc2lnbmVkLWNsb2NrLXJhdGVzIHN0YW56YXMgaW4gdGhlIGRldmlj
ZSB0cmVlIGluc3RlYWQgb2YgaGF2aW5nDQo+ID4+ID4gdGhpcyAxLjVHSHogcmF0ZSBoYXJkLWNv
ZGVkIGluIHRoZSBkcml2ZXIuDQo+ID4+ID4NCj4gPj4gPiAvRW1pbA0KPiA+Pg0KPiA+PiBIaSBF
bWlsLA0KPiA+Pg0KPiA+PiBUaGUgZnJlcXVlbmN5IG9mIFBMTDAgaXMgc2V0IGFjY29yZGluZyB0
byB0aGlzIHByb2Nlc3MgdG8gYXZvaWQgY3Jhc2g6DQo+ID4+IDEuIFRoZSBkaXZpZGVyIG9mIHRo
ZSBjcHVfY29yZSBjbG9jayBzaG91bGQgYmUgc2V0IHRvIDIgaWYgUExMMCBpcyBzZXQgdG8gMS41
R0h6Lg0KPiA+PiAyLiBUaGUgcGFyZW50IG9mIGNwdV9yb290IGlzIGNoYW5nZWQgZnJvbSBwbGww
IHRvIG9zYy4NCj4gPj4gMy4gVGhlIFBMTDAgaXMgc2V0IHRvIDEuNUdIei4NCj4gPj4gNC4gVGhl
IHBhcmVudCBvZiBjcHVfcm9vdCBpcyBjaGFuZ2VkIGZyb20gb3NjIHRvIHBsbDAgYmFjay4NCj4g
Pj4gSSBkb24ndCB0aGluayBhc3NpZ25lZC1jbG9jay1yYXRlcy9hc3NpZ25lZC1jbG9jay1wYXJl
bnRzIGNhbiBkbyBzdWNoIGENCj4gY29tcGxpY2F0ZWQgam9iLg0KPiA+DQo+ID4gUmlnaHQsIGJ1
dCB3aGF0IEknbSBzYXlpbmcgaXMgdGhhdCBpZiBjYWxsaW5nIGNsa19zZXRfcmF0ZSgpIG9uIHRo
ZQ0KPiA+IFBMTDAgY2xvY2sgY2F1c2VzIGEgY3Jhc2gsIHRoYXQgc291bmRzIGxpa2UgYSBidWcg
aW4gdGhlIGRyaXZlci4gSWYNCj4gPiB5b3UgZml4IHRoYXQgYnVnLCBhbmQgbWFrZSBjbGtfc2V0
X3JhdGUoKSBvbiB0aGUgUExMMCBjbG9jayBkbyB0aGUNCj4gPiBwcm9jZWR1cmUgYWJvdmUgd2hl
biBjaGFuZ2luZyB0aGUgcmF0ZSwgdGhlbiB0aGUgUExMMCBjbG9jayBjYW4gd29yaw0KPiA+IGp1
c3QgbGlrZSBhbnkgb3RoZXIgY2xvY2sgYW5kIGFzc2lnbmVkLWNsb2NrLXJhdGVzIHdvdWxkIHdv
cmsuDQo+ID4NCj4gPiAvRW1pbA0KPiANCj4gWWVhaCwgaWYgZml4IHRoaXMgYnVnLCBJIHNob3Vs
ZCBhZGQgdGhlcmUgc3RlcHMgd2hlbiBzZXR0aW5nIHJhdGUgaW4gdGhlIFBMTCBjbG9jayBkcml2
ZXIuDQo+IEJ1dCBob3cgdG8gZ2V0IGFuZCB1c2UgdGhlIGNsb2NrcyBvZiBjcHVfcm9vdCBhbmQg
Y3B1X2NvcmUgaW4gdGhlIFBMTCBkcml2ZXI/DQo+IEl0IHNlZW0gdG8gYmUgb25seSB0d28gd2F5
cywgY2xrX2dldCgpIG9yIGlvcmVtYXAoKS4gSWYgdXNlIGNsa19nZXQoKSwgdGhlIHBsbCBub2Rl
DQo+IHNob3VsZCBhZGQgc3lzY3JnIGNsb2Nrcy4NCj4gSXQgbG9va3MgY29uZnVzaW5nIGJlY2F1
c2Ugbm9ybWFsbHkgdGhlIFNZU0NSRyBkcml2ZXIgZGVwZW5kcyBvbiB0aGUgUExMIGRyaXZlci4N
Cj4gDQoNCkhpIEVtaWwsDQoNCkknbSBzb3JyeSBmb3IgZm9yZ2V0dGluZyB0aGlzIHBhdGNoLiBJ
IHRlc3RlZCB0aGF0IEkgYWRkZWQgdGhpcyBzdGVwIHdoaWxlIHNldHRpbmcgdGhlIHBsbDAgcmF0
ZS4gSSB1c2VkIGNsa19nZXQoKSB0byBnZXQgdGhlIGNsb2NrcyBhbmQgYWRkZWQgdGhlIHN5c2Ny
ZyBjbG9jayBwcm9wZXJ0eSBpbiB0aGUgcGxsIG5vZGUsIGJ1dCB0aGUgc3lzdGVtIHdhcyBub3Qg
d29yayBhbmQgY3Jhc2hlZC4gQ2FuIEkgb25seSB1c2UgaW9yZW1hcCgpPw0KDQpCZXN0IHJlZ2Fy
ZHMsDQpYaW5neXUgV3UNCg0KPiA+Pg0KPiA+PiA+DQo+ID4+ID4+IFsxXTogaHR0cHM6Ly9naXRo
dWIuY29tL3N0YXJmaXZlLXRlY2gvVmlzaW9uRml2ZTIvaXNzdWVzLzU1DQo+ID4+ID4+DQo+ID4+
ID4+IFRoaXMgcGF0Y2ggaXMgYmFzZWQgb24gbGludXgtbmV4dCgyMDIzMDgxOCkgd2hpY2ggaGFz
IG1lcmdlIFBMTA0KPiA+PiA+PiBkcml2ZXIgb24gdGhlIFN0YXJGaXZlIEpINzExMCBTb0MuDQo+
ID4+ID4+DQo+ID4+ID4+IFRoYW5rcywNCj4gPj4gPj4gWGluZ3l1IFd1DQo+ID4+ID4+DQo+ID4+
ID4+IC0tLQ0KPiA+PiA+PiAgLi4uL2Nsay9zdGFyZml2ZS9jbGstc3RhcmZpdmUtamg3MTEwLXN5
cy5jICAgIHwgNDcgKysrKysrKysrKysrKysrKysrLQ0KPiA+PiA+PiAgMSBmaWxlIGNoYW5nZWQs
IDQ2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPj4gPj4NCj4gPj4gPj4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvY2xrL3N0YXJmaXZlL2Nsay1zdGFyZml2ZS1qaDcxMTAtc3lzLmMNCj4g
Pj4gPj4gYi9kcml2ZXJzL2Nsay9zdGFyZml2ZS9jbGstc3RhcmZpdmUtamg3MTEwLXN5cy5jDQo+
ID4+ID4+IGluZGV4IDM4ODRlZmY5ZmU5My4uYjZiOWU5NjdkZmM3IDEwMDY0NA0KPiA+PiA+PiAt
LS0gYS9kcml2ZXJzL2Nsay9zdGFyZml2ZS9jbGstc3RhcmZpdmUtamg3MTEwLXN5cy5jDQo+ID4+
ID4+ICsrKyBiL2RyaXZlcnMvY2xrL3N0YXJmaXZlL2Nsay1zdGFyZml2ZS1qaDcxMTAtc3lzLmMN
Cj4gPj4gPj4gQEAgLTUwMSw3ICs1MDEsNTIgQEAgc3RhdGljIGludCBfX2luaXQgamg3MTEwX3N5
c2NyZ19wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+PiA+PiAgICAg
ICAgIGlmIChyZXQpDQo+ID4+ID4+ICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiA+PiA+
Pg0KPiA+PiA+PiAtICAgICAgIHJldHVybiBqaDcxMTBfcmVzZXRfY29udHJvbGxlcl9yZWdpc3Rl
cihwcml2LCAicnN0LXN5cyIsIDApOw0KPiA+PiA+PiArICAgICAgIHJldCA9IGpoNzExMF9yZXNl
dF9jb250cm9sbGVyX3JlZ2lzdGVyKHByaXYsICJyc3Qtc3lzIiwgMCk7DQo+ID4+ID4+ICsgICAg
ICAgaWYgKHJldCkNCj4gPj4gPj4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ID4+ID4+
ICsNCj4gPj4gPj4gKyAgICAgICAvKg0KPiA+PiA+PiArICAgICAgICAqIFNldCBQTEwwIHJhdGUg
dG8gMS41R0h6DQo+ID4+ID4+ICsgICAgICAgICogSW4gb3JkZXIgdG8gbm90IGFmZmVjdCB0aGUg
Y3B1IHdoZW4gdGhlIFBMTDAgcmF0ZSBpcyBjaGFuZ2luZywNCj4gPj4gPj4gKyAgICAgICAgKiB3
ZSBuZWVkIHRvIHN3aXRjaCB0aGUgcGFyZW50IG9mIGNwdV9yb290IGNsb2NrIHRvIG9zYyBjbG9j
ayBmaXJzdCwNCj4gPj4gPj4gKyAgICAgICAgKiBhbmQgdGhlbiBzd2l0Y2ggYmFjayBhZnRlciBz
ZXR0aW5nIHRoZSBQTEwwIHJhdGUuDQo+ID4+ID4+ICsgICAgICAgICovDQo+ID4+ID4+ICsgICAg
ICAgcGxsY2xrID0gY2xrX2dldChwcml2LT5kZXYsICJwbGwwX291dCIpOw0KPiA+PiA+PiArICAg
ICAgIGlmICghSVNfRVJSKHBsbGNsaykpIHsNCj4gPj4gPj4gKyAgICAgICAgICAgICAgIHN0cnVj
dCBjbGsgKm9zYyA9IGNsa19nZXQoJnBkZXYtPmRldiwgIm9zYyIpOw0KPiA+PiA+PiArICAgICAg
ICAgICAgICAgc3RydWN0IGNsayAqY3B1X3Jvb3QgPQ0KPiBwcml2LT5yZWdbSkg3MTEwX1NZU0NM
S19DUFVfUk9PVF0uaHcuY2xrOw0KPiA+PiA+PiArICAgICAgICAgICAgICAgc3RydWN0IGNsayAq
Y3B1X2NvcmUgPQ0KPiA+PiA+PiArIHByaXYtPnJlZ1tKSDcxMTBfU1lTQ0xLX0NQVV9DT1JFXS5o
dy5jbGs7DQo+ID4+ID4+ICsNCj4gPj4gPj4gKyAgICAgICAgICAgICAgIGlmIChJU19FUlIob3Nj
KSkgew0KPiA+PiA+PiArICAgICAgICAgICAgICAgICAgICAgICBjbGtfcHV0KHBsbGNsayk7DQo+
ID4+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBQVFJfRVJSKG9zYyk7DQo+ID4+
ID4+ICsgICAgICAgICAgICAgICB9DQo+ID4+ID4+ICsNCj4gPj4gPj4gKyAgICAgICAgICAgICAg
IC8qDQo+ID4+ID4+ICsgICAgICAgICAgICAgICAgKiBDUFUgbmVlZCB2b2x0YWdlIHJlZ3VsYXRp
b24gYnkgQ1BVZnJlcSBpZiBzZXQgMS41R0h6Lg0KPiA+PiA+PiArICAgICAgICAgICAgICAgICog
U28gaW4gdGhpcyBkcml2ZXIsIGNwdV9jb3JlIG5lZWQgdG8gYmUgc2V0IHRoZSBkaXZpZGVyIHRv
DQo+IGJlIDIgZmlyc3QNCj4gPj4gPj4gKyAgICAgICAgICAgICAgICAqIGFuZCB3aWxsIGJlIDc1
ME0gYWZ0ZXIgc2V0dGluZyBwYXJlbnQuDQo+ID4+ID4+ICsgICAgICAgICAgICAgICAgKi8NCj4g
Pj4gPj4gKyAgICAgICAgICAgICAgIHJldCA9IGNsa19zZXRfcmF0ZShjcHVfY29yZSwgY2xrX2dl
dF9yYXRlKGNwdV9jb3JlKSAvIDIpOw0KPiA+PiA+PiArICAgICAgICAgICAgICAgaWYgKHJldCkN
Cj4gPj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgZ290byBmYWlsZWRfc2V0Ow0KPiA+PiA+
PiArDQo+ID4+ID4+ICsgICAgICAgICAgICAgICByZXQgPSBjbGtfc2V0X3BhcmVudChjcHVfcm9v
dCwgb3NjKTsNCj4gPj4gPj4gKyAgICAgICAgICAgICAgIGlmIChyZXQpDQo+ID4+ID4+ICsgICAg
ICAgICAgICAgICAgICAgICAgIGdvdG8gZmFpbGVkX3NldDsNCj4gPj4gPj4gKw0KPiA+PiA+PiAr
ICAgICAgICAgICAgICAgcmV0ID0gY2xrX3NldF9yYXRlKHBsbGNsaywgMTUwMDAwMDAwMCk7DQo+
ID4+ID4+ICsgICAgICAgICAgICAgICBpZiAocmV0KQ0KPiA+PiA+PiArICAgICAgICAgICAgICAg
ICAgICAgICBnb3RvIGZhaWxlZF9zZXQ7DQo+ID4+ID4+ICsNCj4gPj4gPj4gKyAgICAgICAgICAg
ICAgIHJldCA9IGNsa19zZXRfcGFyZW50KGNwdV9yb290LCBwbGxjbGspOw0KPiA+PiA+PiArDQo+
ID4+ID4+ICtmYWlsZWRfc2V0Og0KPiA+PiA+PiArICAgICAgICAgICAgICAgY2xrX3B1dChwbGxj
bGspOw0KPiA+PiA+PiArICAgICAgICAgICAgICAgY2xrX3B1dChvc2MpOw0KPiA+PiA+PiArICAg
ICAgIH0NCj4gPj4gPj4gKw0KPiA+PiA+PiArICAgICAgIHJldHVybiByZXQ7DQo+ID4+ID4+ICB9
DQo+ID4+ID4+DQo+ID4+ID4+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBqaDcx
MTBfc3lzY3JnX21hdGNoW10gPSB7DQo+ID4+ID4+IC0tDQo+ID4+ID4+IDIuMjUuMQ0KPiA+PiA+
Pg0KPiA+Pg0KDQo=

