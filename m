Return-Path: <linux-kernel+bounces-166798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1CA8B9F9E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40367B228ED
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB4416FF4D;
	Thu,  2 May 2024 17:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="oxqVJCo4"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2128.outbound.protection.outlook.com [40.107.247.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C7428FC;
	Thu,  2 May 2024 17:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714671349; cv=fail; b=UjpDoMkXsTkFCYUsAf2sgD9NFwH069MTekgIVve3SmR7kgpv64rZIDurfCxQ9T0UU1ZP9BsVJpAZKHFXQpyA+dDZTUs3b/NBcFlwVKyNx0a1YI6WDooVBB2wFPCW6J5tuIvT+aMzE3MQO15sbOrtEIRSSrA88yvXKF7RPpNG9jQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714671349; c=relaxed/simple;
	bh=/rnvAeSdzhq6PpKHqIkBM4XOXWfq84e4O/Apty4/Wlo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E90eDG0fyj0dlzYUTgoQ5+EWLlQhQT7K0/2OCFTmcHbRLl5Ho7OWdVogDZZ2+wHXuMDcfQDMvs7m9CLhfsaaBwS9XJLx+Phf2px5js9Q3fpGIUbVaIh68x3NVB2JcoFQY7zRYMItsHuechRhqODlb/EavZzoSv8457o6XMuuPQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=oxqVJCo4; arc=fail smtp.client-ip=40.107.247.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOphoSyqmJWA+cxkcozv5XI1tja+0zlCcYHoWwJS8U6/MADF+lbhk4AEDjS/CcncYozAY31fK3mmqu1f9xWn/SkjFpb/Xbg/19YpkdzgYKv+Wg0BUXke9QlDVJB6XcVlvqquTOmOJZmDUkJNH7B5SIYBWw7UA9U9BWyrrdPKSg56+HB1cK6H2slSuLt0NQIho+UxBRulSzPu+8nEwPpQcyLPoOaWua1zlizLLTgWAlO38swLnrKfF2TtQIffLUJrvm04CZrGrtjhmzOck/+4B0QKtgBsJks6U44BTOurnxcmJYjp5MujVZROgkGEnqUE8rnp7WYWApWgP+FceM+Gxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rnvAeSdzhq6PpKHqIkBM4XOXWfq84e4O/Apty4/Wlo=;
 b=CkxihokXwQWIAbUDMqxTPFb4Ykf0R0m6a+PiLWmL2mtrfrOEbs5chtcrXVfOeVzQmjHQfvNvpdsxzIoTOy1UG8H4PP6YIWMo4fb1UMNByCu/NRDcwzMw5aEUqlvvTMlcZKvG8U7VHPrE6D6FiUdYM23CtrQ7xa8QKKFoFkWUx9380qEdhC3gk4jNYo/fwPc1fuOC3o9GDe0gWUT9Q9c0iaPgIp99teB5PsNy7XeoecvlRFS5bzcEJsvE1gQ6wTXWYfLFpj4nAE+SN3dG5h2LSwdbcdsof2k1ib9dQDyjorfFytz5RGGYMzJWg66kkiTpp9sku1MheqER6lYcrHBvRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rnvAeSdzhq6PpKHqIkBM4XOXWfq84e4O/Apty4/Wlo=;
 b=oxqVJCo4kY3nLCo7cfV3lIfH/gshsetvQrtiP9T6NIQXoi9QUmcQvyI8AAsNUvIgCok6tEMJwV9LtuA1D1GlUJLOJPl6RJlkD/e9Q+dYbBrxNY6pUfybi7HF4mX4CQAVHtUFMqSCJxjANP12zIE0KI29tnLl3rYiN+NL81OJocs=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by PA4PR04MB7997.eurprd04.prod.outlook.com (2603:10a6:102:c9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Thu, 2 May
 2024 17:35:44 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 17:35:44 +0000
From: Josua Mayer <josua@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, Gregory Clement
	<gregory.clement@bootlin.com>, Sebastian Hesselbarth
	<sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
	<conor+dt@kernel.org>, Rob Herring <robh@kernel.org>
CC: Yazan Shhady <yazan.shhady@solid-run.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] arm64: dts: add description for solidrun cn9131
 solidwan board
Thread-Topic: [PATCH v4 4/4] arm64: dts: add description for solidrun cn9131
 solidwan board
Thread-Index: AQHanIzFj3t0e7qcckiINn2lwLvOULGENTeA
Date: Thu, 2 May 2024 17:35:44 +0000
Message-ID: <d72c7637-e59f-4104-93e9-6faab2da0836@solid-run.com>
References: <20240502-cn9130-som-v4-0-0a2e2f1c70d8@solid-run.com>
 <20240502-cn9130-som-v4-4-0a2e2f1c70d8@solid-run.com>
In-Reply-To: <20240502-cn9130-som-v4-4-0a2e2f1c70d8@solid-run.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|PA4PR04MB7997:EE_
x-ms-office365-filtering-correlation-id: 6c12123e-94b2-4498-672b-08dc6ace4b6d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|1800799015|376005|7416005|366007|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?cFJvRWNPNnFBbzN0bjlzQjc4T21mSE5xdzBFOW9tL2I3QXRLYlpvdE5NaFhv?=
 =?utf-8?B?bkcvWXQwdXQ2SVdpTzN2cTB5QnR5ZGlPTkpLWVBtUTBBUGJJbTZtN0ltUTQ4?=
 =?utf-8?B?MFlFVkxUaDlTeWNiNFhNcEo5WkUvSENmVU9QN2dtRG9VeFNFV0t5NkM1dEZh?=
 =?utf-8?B?bFJSQVVJUU03djZDZnhHZ3pBN3dyam94K1FoZTYvYnRzSFBmSHkwclBaNHpn?=
 =?utf-8?B?OGI0K3NkUGM4V0ovOWRVVDM0dUFpcWVrbkxlVkg4RXlXdjJEZFV3ZUJjUlkw?=
 =?utf-8?B?RlJheEc2RGRKendtRGFEcFZ6Q3dKYUlSZnFvTVB0VVdaWk82WEFMWU1IbTBW?=
 =?utf-8?B?MFBzWVlTU1huRlRycjBQSVRLSDY5a01zS25xUDRzY2NyVEtKUnhqYXZOemxC?=
 =?utf-8?B?QUo3VEdJWkE3aGZ0ZEVOV2pMRWN2VHI5aEFaTWtrKzNtY01OVzZoaklNclVC?=
 =?utf-8?B?TE9ldmhKVEE2UlJGQVV0N1hFVHlYTGRhbkZNTUhhdWZoR0lzSjduZTdnN21n?=
 =?utf-8?B?eGNQTmFTU2hXMVE2N3JjTTRhVTdqWDNMK2FLcE92RUl6a1VMaVlEZzk3TERj?=
 =?utf-8?B?aTU3clZJc0M1Nm1DL3pGeVdJTXpOenk0T0pkSEIrRWt5Y25aelJYaHlVQnFQ?=
 =?utf-8?B?YUhYSDVvUUhMTEEwMEJGcDVRckZxa3ZucWxMUTFSTWhTZG9ZcWl5RktXWjRy?=
 =?utf-8?B?VkhIdVFNRkE2amNrYURNSzNqdW0xZGtOeUkrZzVkTnV5amZFS0hBSDQ4S1pj?=
 =?utf-8?B?RmJ3aE5xTFJxSlU3L09nMVl4YUUyUkJBaXp3dU5VUmtuYlZxT2dNYXNSNVQz?=
 =?utf-8?B?bHczNHNXMmtxci9zL0NXcFc4UTdvTnZjOHhmWU9BSkVDZ0xROEgva1lJSC9h?=
 =?utf-8?B?K0Jwb3hqblltK0FleDk5Z1BNK2tBN2MwOHp1QUFEMEE1bVdFUzBkWHR6NUFS?=
 =?utf-8?B?SHB6SHhRZm9vSWhkcnBWczJSSWdIQlA3Wmt5bDVEaUtyOTJaSmVjYzlpdk5w?=
 =?utf-8?B?SndyTnpyQjlkZFk2YVN3L0pJb3dCOXRLWG9nZHhRMUJ0WEswRjJ6TjM5WXR2?=
 =?utf-8?B?NzFHVXBIY0RyemUyd0lDOXcwaGc1enRrcDJjR1BRYjlDNllKdFlGU2FORStR?=
 =?utf-8?B?aTcwa3o2dFVZU1JZcUZJanVKQng2aEJ1VHd1N0pVOWdsMHhRVEo5Z2JUQ0Jj?=
 =?utf-8?B?bGdiWTdNK1BHbUZEL0ttRStaeDRJQ0dMZ2EwS0JLenRpZ2dET0VmYkl6TDVC?=
 =?utf-8?B?Kys1YkhwdGZnK0ttY0IwTlkzQk9pcktIelgycDZNZHZsdkhJZm9RNHRpODI3?=
 =?utf-8?B?dEdPeFJEQ0t4ZVRSOUI3NTFUc0RqMGpIOGVVcFhFVnRnSjQ0Z1crTGh3azRk?=
 =?utf-8?B?a3ArQzFpcE0rY3BYOWJFVUxBSXRFai9ESWl3WGJtMjRCNTVFOTBDODBJeTBj?=
 =?utf-8?B?YnFiYlAvaDAvMHUyakc3T3hxdDNRbkxncGN5aEhUeTdrWGhOdWNrN2hHTWNR?=
 =?utf-8?B?T2hYM0IzMWFGSkFTOVpxQ3NnMFVaWGVlNk5CdllEM3hhVURrUERKaW5RME9a?=
 =?utf-8?B?RGtPS1h1bjNlb0kvMWRKTTJVcmJ5b3VUSkdaeW9OZTgySXY3ZjdOb1kvNTJ1?=
 =?utf-8?B?OXpESGlUNVRCWVRMK3hHQ0dqQ2s1ck1QR2RxVjFEc0dTOXZVbXBRdDVhemtR?=
 =?utf-8?B?UjZNNk82NnFLU1RURytqRUFvampVMTgwdUd0SHMwb0tFcmY2NjREQi9YaU1p?=
 =?utf-8?B?a3N6ajVWcnBXM1ZmYlFkREl4eUJNbGp4ckpWVkpCQzQvQTJJN3N0L3JXOVkx?=
 =?utf-8?B?d1JlRnJaWnlScDhCanQ0UT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dmROWTQyOTMzR3NmR1VHN3Qzd1RBY0NyNTRsV1QxaGpDMFdENHQrVm1tMmxv?=
 =?utf-8?B?VjhsTXRIU0ZtZS9scDh1NGVlUWUxTzRZL2Ewenk0b1M4SDBieVhBU1ExWmhl?=
 =?utf-8?B?SThjSzh0RmNZdEtTTmVDd2NXMHJRUHBqbHlIUTBodElRUFdocVpnUTBhTWJm?=
 =?utf-8?B?end1RHBlVThIUjh5WVpzU0ZUdVdPaUQ5dHRTcDVHVCtyVXZjQ2Uxay9YL2tI?=
 =?utf-8?B?RTM3cjk4eHlxQTJhanpxVTM1c1lMMVpZVVBtYktkQ2tIdmNvSFdjZjNrQkhP?=
 =?utf-8?B?aHlOZWdEYko4R3hlRVR6QzBaN3dzaHFaVHIxYTVPdmY5UDcvZTgxZHkzaW1M?=
 =?utf-8?B?QVlXTzVmRzlLZlc0dHU1dlFwdklNbTRpZ2xCTmZlRkxQeDEyNFRRZDRmdWl6?=
 =?utf-8?B?TlBOUmI1Z1B3TE1mQko0Z0twMkk4TXhxY3JXdmM5OURtTkVJNVdWRFhRaENS?=
 =?utf-8?B?dk9QeGkwMzNXNXo2VjhiaFRpTjFBZ09nSnZxcm91eFJWeTlhVEVkM2FtcmVi?=
 =?utf-8?B?R1B1U0I4RW01WlZUQXF0dWI0YkxFcCtENFhOVExQUkl1UFNCQnd0OEp5aDZD?=
 =?utf-8?B?UG9OV3Q5SWVBaUZBMW5obXZ6TnRHYTQ5MitoV0gyOFFEU0kyZjJ0OVBVS3kx?=
 =?utf-8?B?ZnNtZisydFRRMldSNCtSRUdLYitCV0NEbkNOSHZldFppMzVKYkxZQjFYMkRT?=
 =?utf-8?B?QlNqdlU1TC85SzFhQm9IbzhqcS9zR3Q2ZDZuNzN3SkZRY0NhNmZ5Q1lRUlpT?=
 =?utf-8?B?T2J2SWhRRmp3cUxXSm9xZkphZkQrTHVsMXhOOUVMZnZGZHhDejIwVnJucTZT?=
 =?utf-8?B?L3NSaGt6U2ZUNXY2WVFtVDA4WXRzOFRSS0JSUTg1akxaWWhISjBaSk9JOHNY?=
 =?utf-8?B?bEJ3YWd0UjR5enNUbTJRQnVlOEpMbU1xc3YyN1lYMXA3UXR6Y1lDbzZWYVdC?=
 =?utf-8?B?SndncDhaSFN1QUZkakl5V3dvZ2FTTUpLMHljTGUyeEdYVS8rc3JBM2hlSnkr?=
 =?utf-8?B?NXFkUEJIZzZ3MDZtWTVCd1R1aWtQQ3E3Zi9OT2xrMGZYMTBKRFpYMTY2cDNY?=
 =?utf-8?B?RzBZdkFHOGl3ZWlMZmNuc21uTytxZFIyV3BSdHBWVmE2OG96NjNMQTBiaVlQ?=
 =?utf-8?B?YVhXaXJlRVYwOXV5Sy8wbnRhRTI2aEhJdmVIVWRCeEpjNGNMY2k3b2VHZmZ1?=
 =?utf-8?B?TUVUOVRBblNTNVltWlJzQVdrRFNTSUVaVi9RWnZ6NlZFWktSeTB3YTRkS0tG?=
 =?utf-8?B?Yi85aS9uU3RXQTZuaUJMaGJldXgxdk5penVBMFY3YjNCTkZWd05uamtLN3lq?=
 =?utf-8?B?QmZLNk5UUFNiM2IzdEZQSXlGVzBlQlA2RlFrYndFVEdzMWxsTmxZSXdNZGlN?=
 =?utf-8?B?Q0tXa1JlU29hL1dwdk5ocjY5aEZwem1hUEZDRXdoaE5OSzZOQm1hdmNSc05a?=
 =?utf-8?B?bktqdUNHcnVJYXFoMTQ1WkRNblFxc2k0ZjBiL0Z3eExpdm03R3RKc1RmMWU3?=
 =?utf-8?B?SW1pZ0RRcXo3TmhOZnlZblNianlialFuZkR3OEFuU3ROUzlwd3B3UVpxUTFR?=
 =?utf-8?B?aG84Ym94OEZJWHNpQy9MbnplazBFMmN3UGFxQ0tsZzVyVktwbXQ0REkvNTVy?=
 =?utf-8?B?Q1NJK1h5Z1g0blltcGNkMjJIL3I2ZnVnQWo1L3pmMXE5Qng3aGx5OUluR3BO?=
 =?utf-8?B?eVBvYXlUZ1VYZEpEbTY4aTljaWpnMllqbGNYbWlmN2xseXhzRk9CVnZYMXor?=
 =?utf-8?B?SWpXMG9CRGJiVW1PTDQ4YW1zcjBhOUhKc1huR2NRRWJsSGZTSHZLNGJmcTU2?=
 =?utf-8?B?eXUzNGJnZ3BYVUdiRkQzTG1kWDVsaXAvc2lYMitmbVVrVjFGN29nTFJVT2tE?=
 =?utf-8?B?QytHaVFadnFSaVBjT1VYTHVRcDBWOU1JUkZReWs5R0REU05peGR1ZFV0RzRN?=
 =?utf-8?B?bWlBcHBqZXppbVhtS3NxdE5hRkczMEd2ZVFEQ3FSZzhoSXpuZFhQR0pmOTVP?=
 =?utf-8?B?Uzk2amw0SFlxM2Y2UkgxbzJYVTdZSVE3RmtFb0VCSFIzZitHWHJkdTVubFlJ?=
 =?utf-8?B?KzVuNGtYRGlHaDB4Y2w5ZmdodWIzcWJpb1A2NVRYeHlJUmowZlB5Y1hERVo3?=
 =?utf-8?Q?b0byg61V5GfTi/FdpoQ9UWhTe?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <624F3B7525B1E544931A00708AB88ED5@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c12123e-94b2-4498-672b-08dc6ace4b6d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2024 17:35:44.0869
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pukrz4TkMcOKDOT6CgjeXcmlnAo6tjx0yPFMAUXa14vhowLzlDZO3C1ZdSHFQcQ8m3D8ynjukkCQU+U4r4wW+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7997

QW0gMDIuMDUuMjQgdW0gMTQ6MzIgc2NocmllYiBKb3N1YSBNYXllcjoNCj4gQWRkIGRlc2NyaXB0
aW9uIGZvciB0aGUgU29saWRSdW4gQ045MTMxIFNvbGlkV0FOLCBiYXNlZCBvbiBDTjkxMzAgU29N
DQo+IHdpdGggYW4gZXh0cmEgY29tbXVuaWNhdGlvbiAgcHJvY2Vzc29yIG9uIHRoZSBjYXJyaWVy
IGJvYXJkLg0KPg0KPiBUaGlzIGJvYXJkIGRpZmZlcmVudGlhdGVzIGl0c2VsZiBmcm9tIENOOTEz
MCBDbGVhcmZvZyBieSBwcm92aWRpbmcNCj4gYWRkaXRpb25hbCBTb0MgbmF0aXZlIG5ldHdvcmsg
aW50ZXJmYWNlcyBhbmQgcGNpIGJ1c2VzOg0KPiAyeCAxMEdicHMgU0ZQKw0KPiA0eCAxR2JwcyBS
SjQ1DQo+IDF4IG1pbmlQQ0ktRQ0KPiAxeCBtLjIgYi1rZXkgd2l0aCBzYXRhLCB1c2ItMi4wIGFu
ZCB1c2ItMy4wDQo+IDF4IG0uMiBtLWtleSB3aXRoIHBjaWUgYW5kIHVzYi0yLjANCj4gMXggbS4y
IGIta2V5IHdpdGggcGNpZSwgdXNiLTIuMCwgdXNiLTMuMCBhbmQgMnggc2ltIHNsb3RzDQo+IDF4
IG1wY2llIHdpdGggcGNpZSBvbmx5DQo+IDJ4IHR5cGUtYSB1c2ItMi4wLzMuMA0KPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBKb3N1YSBNYXllciA8am9zdWFAc29saWQtcnVuLmNvbT4NCj4gLS0tDQo+ICBh
cmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvTWFrZWZpbGUgICAgICAgICAgICAgICB8ICAgMSAr
DQo+ICBhcmNoL2FybTY0L2Jvb3QvZHRzL21hcnZlbGwvY245MTMxLWNmLXNvbGlkd2FuLmR0cyB8
IDY0MyArKysrKysrKysrKysrKysrKysrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwgNjQ0IGluc2Vy
dGlvbnMoKykNCj4NCmN1dA0KPiArCS8qIFR5cGUtQSBwb3J0IG9uIEo1MyAqLw0KPiArCXJlZ191
c2JfYV92YnVzMDogcmVndWxhdG9yLXVzYi1hLXZidXMwIHsNCj4gKwkJY29tcGF0aWJsZSA9ICJy
ZWd1bGF0b3ItZml4ZWQiOw0KPiArCQlwaW5jdHJsLTAgPSA8JmNwMF9yZWdfdXNiX2FfdmJ1czBf
cGlucz47DQo+ICsJCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ICsJCXJlZ3VsYXRvci1u
YW1lID0gInZidXMwIjsNCj4gKwkJcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8NTAwMDAwMD47
DQo+ICsJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDUwMDAwMDA+Ow0KPiArCQlyZWd1bGF0
b3Itb2MtcHJvdGVjdGlvbi1taWNyb2FtcCA9IDwxMDAwMDAwPjsNCg0KSXMgaXQgY29ycmVjdCB0
byBzcGVjaWZ5IG92ZXItY3VycmVudCBwcm90ZWN0aW9uIGZvciBhIHJlZ3VsYXRvci1maXhlZD8g
SXQgY2F1c2VzIGtlcm5lbCBtZXNzYWdlczoNCg0KWyA3Ljk4ODMzN10gdmJ1czA6IElDIGRvZXMg
bm90IHN1cHBvcnQgcmVxdWVzdGVkIG92ZXItY3VycmVudCBsaW1pdHMgWyA3Ljk5NDc1Nl0gdmJ1
czA6IElDIGRvZXMgbm90IHN1cHBvcnQgcmVxdWVzdGVkIG92ZXIgdm9sdGFnZSBsaW1pdHMgWyA3
Ljk5ODc5Nl0gdmJ1czE6IElDIGRvZXMgbm90IHN1cHBvcnQgcmVxdWVzdGVkIG92ZXItY3VycmVu
dCBsaW1pdHMgLi4uDQoNClRoZSByZWFzb24gSSBwdXQgdGhlIHByb3BlcnR5IHdhcyB0aGF0IHRo
ZSAxQSBsaW1pdCBpcyBhIHByb3BlcnR5IG9mIHRoZSByZWd1bGF0b3IgY29tcG9uZW50IChOQ1Az
ODAtMS4wQSkuIE1heWJlIHRoYXQgaXMgdGhlIHdyb25nIHByb3BlcnR5Pw0KDQpJdCBhbHNvIGdl
bmVyYXRlcyBhbiBpbnRlcnJ1cHQgZm9yIHdoaWNoIEkgZm91bmQgbm8gc3VpdGFibGUgZGVzY3Jp
cHRpb24uDQoNCj4gKwkJZ3BpbyA9IDwmY3AwX2dwaW8xIDI3IEdQSU9fQUNUSVZFX0hJR0g+Ow0K
PiArCQllbmFibGUtYWN0aXZlLWhpZ2g7DQo+ICsJCXJlZ3VsYXRvci1hbHdheXMtb247DQo+ICsJ
fTsNCj4gKw0KPiArCXJlZ191c2JfYV92YnVzMTogcmVndWxhdG9yLXVzYi1hLXZidXMxIHsNCj4g
KwkJY29tcGF0aWJsZSA9ICJyZWd1bGF0b3ItZml4ZWQiOw0KPiArCQlwaW5jdHJsLTAgPSA8JmNw
MF9yZWdfdXNiX2FfdmJ1czFfcGlucz47DQo+ICsJCXBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7
DQo+ICsJCXJlZ3VsYXRvci1uYW1lID0gInZidXMxIjsNCj4gKwkJcmVndWxhdG9yLW1pbi1taWNy
b3ZvbHQgPSA8NTAwMDAwMD47DQo+ICsJCXJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDUwMDAw
MDA+Ow0KPiArCQlyZWd1bGF0b3Itb2MtcHJvdGVjdGlvbi1taWNyb2FtcCA9IDwxMDAwMDAwPjsN
CnNhbWUgaGVyZQ0KPiArCQlncGlvID0gPCZjcDBfZ3BpbzEgMjggR1BJT19BQ1RJVkVfSElHSD47
DQo+ICsJCWVuYWJsZS1hY3RpdmUtaGlnaDsNCj4gKwkJcmVndWxhdG9yLWFsd2F5cy1vbjsNCj4g
Kwl9Ow0KPiArDQo=

