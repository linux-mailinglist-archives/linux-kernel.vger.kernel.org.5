Return-Path: <linux-kernel+bounces-129318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3214D896886
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3B7288E13
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2722482C7E;
	Wed,  3 Apr 2024 08:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="NBfq62dN";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="D+DBodeQ"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADDF6E61A;
	Wed,  3 Apr 2024 08:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712132331; cv=fail; b=oinCNZ8l3jKds0wKhInPQy4YZiCW4kks3GzL8+GAJzFkAGaDR2YGvkBM5P1MsPoHOQ7KZ55/y8Vqe/RZaQ2wXMgSitX/uvhdgb8Bxa75kFhyAVy+2XAUE/7hvInxsBDyx2fWDjT8qX2fRVDuR8ubiGnlj7f8rkbm30S+VHEQRy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712132331; c=relaxed/simple;
	bh=0Trynd9mJs74I/ywF7sAAIEEMEiIHgFmYgiA6qpRF/Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jRKITzJpOuG4WMcfWhMfy9Utyf/6h9qN6p0oWK6BNUDS5dVRgpLZZVdWSz1LfTpM96GJnPflbNGEXgUjdvJXUubx1WiFIPIp5/k7bV1rjwEr+o0/4tDhtYZyViw171veu8lIffPujOXJVLe+sj+h5NTxbjA5qVKX/OeocTM9b+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=NBfq62dN; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=D+DBodeQ; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712132329; x=1743668329;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0Trynd9mJs74I/ywF7sAAIEEMEiIHgFmYgiA6qpRF/Q=;
  b=NBfq62dN07aKwV8imXam9PFf/7CWub8+pZ6h6XVKfqZIpc5qF0f+YwvZ
   Zbd4WPhlNImy/mNocSXaxMYKYzrhc1JYfqfDth8hPBg9XcRagez/rgWo1
   4XCZwW9loxU1NJBr2w+XCGtYhQI+griuGcTc+ml+JrgylrCTHkEBnKDQ4
   p9qkN/iIt9xKPhMNywTArGvxnpJnr9PzICJN3ACjdk7I6EfJv6f3+jiNs
   +8Fp8OChdLomBsAy8JQv0Xw213bt1S1kwGCqVUS3ChNXzWV20OtSfWJBD
   v/uJGLdWElG4iv2Hmml3fSuKzmhuW9HdnyfHMLBnMBkyFCo3WbHtLb7Eh
   A==;
X-CSE-ConnectionGUID: SIp9bB4jSKKC2HOhRTloxg==
X-CSE-MsgGUID: oai5IO5KSMyrlQwFYd8xjw==
X-IronPort-AV: E=Sophos;i="6.07,176,1708412400"; 
   d="scan'208";a="19795189"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Apr 2024 01:18:42 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 3 Apr 2024 01:18:14 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 3 Apr 2024 01:18:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGPN6/j4yGMeAj8osxGc/Y06zJEmyIyAJ6CkIegE+Yb2oCVXGAO1fdM4VWWkj7OVzKHm6Xg/YbuPO9AsquYd7i1BTlo9Q+7Udg8RTqPjY9YpGNVD9kaM2zA1g7BN8Wt9k8f4fFXMlCwvdf+LzIMa6o27dCAFXvDF2K3w87SrLKspMcfK9k+2VhUkiFqPM30j8Br1XiZbCK3t8jAlwDjsb6LSkNVSURrNB5n/SqRDowBr3i+TV7b7EnTXuOLDnPEpuI2x0RQjTzNTYekiSvdGrnO08D3L+Qhp2JBtUdPghDcNNYkX/PnDkA85mkY3UbeBHVxtPDec8U8TyCqT3N1a9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Trynd9mJs74I/ywF7sAAIEEMEiIHgFmYgiA6qpRF/Q=;
 b=QRN6ggsXNV+jJIqw91B+/JccuCYzwH3Txa9wJoEVgkhpEBJ83Y6mW3uYFsN5WgCx65xfBj9MBPLVir6tj2lbpTbvRUIrYXzlECBAV5ZTh+t70/5VTMMLzWHZSr6uN1NwvJkiRqQ7YrzXCsfSdOFuW4XYmWKePkpFp6EiStaOy6NW8foLJMhR17iOV6ZL9F9R43u9zwL5cRivzq3chSXaBUrcE6Jvvc7dWAIrJdAD9wbJtzGJijPNwYJht2oJIlwYtkRCwyu41TytarwHkp0IuBQY9YC6LGnT0b+Qf5IwwuWsbuhvzVRdiTvSTD0w/P2APGAak/oy6uxkhV+APL1cBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Trynd9mJs74I/ywF7sAAIEEMEiIHgFmYgiA6qpRF/Q=;
 b=D+DBodeQrVcUSXTfyPGgznPNxy+qL/xeKcDAY7C3Wf2bpFzMQA+m5D1Xhmq0/IID+GsXLLYBX2OqDI9Ks41kjDvri1iJDA9hMamAmNArHWBIm6QJXu0tWnpuJ0m8QqIBi4kMPuIJWx2I26w3ZpRvrRXBLfL8IEMDJyXYcgzWCzRAoLoRXr/ETHbpSyORWSZh7FO3kl4eKfzr5UTD45+MLcxmuzXvvQIENCfc6adjTtUFfAehat6Ut5bmQvBpkCx5uUfKk0hrvF+1MoubEZsH1gJHGyVsSJstcFb5+3OtzipsjD3jkH72EASKnYxa5Khn4zyt+X4KAEM6tYN3qLoFxg==
Received: from SA3PR11MB8047.namprd11.prod.outlook.com (2603:10b6:806:2fc::22)
 by SJ2PR11MB8565.namprd11.prod.outlook.com (2603:10b6:a03:56b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Wed, 3 Apr
 2024 08:18:12 +0000
Received: from SA3PR11MB8047.namprd11.prod.outlook.com
 ([fe80::9409:3a27:4eb7:404d]) by SA3PR11MB8047.namprd11.prod.outlook.com
 ([fe80::9409:3a27:4eb7:404d%7]) with mapi id 15.20.7409.031; Wed, 3 Apr 2024
 08:18:12 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <kernel@pengutronix.de>, <san@skov.dk>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v1 8/8] net: dsa: microchip:
 ksz8_r_dyn_mac_table(): use entries variable to signal 0 entries
Thread-Topic: [PATCH net-next v1 8/8] net: dsa: microchip:
 ksz8_r_dyn_mac_table(): use entries variable to signal 0 entries
Thread-Index: AQHahP+ioFLJkj0MaEGmEDGDIxBUPrFWNVAA
Date: Wed, 3 Apr 2024 08:18:12 +0000
Message-ID: <5b0ae3ab4522f889798498ba8272abfa78b717dd.camel@microchip.com>
References: <20240402131339.1525330-1-o.rempel@pengutronix.de>
	 <20240402131339.1525330-9-o.rempel@pengutronix.de>
In-Reply-To: <20240402131339.1525330-9-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA3PR11MB8047:EE_|SJ2PR11MB8565:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /+m4Xiey+8JfcxqnmgQCnJeLBpsw9frb1bNBkIcmC0oxvnbKEjtyMQkHp1cF6nQS30Lsk9OEDBJppJCljHokLvCS53PmpBN1lVhopmQHA8kqV13fpokKz0wxXYfXQQiWGk1heKoudQjgXL8XSr4Rzb7XTMasDJedgo41mv7NOu3Fi1pA9+bOGuvQKv2kng5gY9DJkxXRPRAUMTkC1au5EySFjuSVpjLwaFSfdbCI5kr1NFrXiwJ3uYCgpN1Ml0MWMfq2c7nqRuztoE7GNqri5AANFjtbKVRgXvQE5dLnOPTFRKOuxUl1Ac77kHPlZJKgP2SM5dLrBwQEgrjFsBgYzewzTDYg8Jv4LUrQgiN51bpPc7lC7o2BrsIBeez1GopaqCbLYs/T7ZCGUcZJsSbF4/SMjrNHyJXgeV+5/ASF/S3l5zw7dYrS4hZkHc4weFv4EwJ1bjuJn9rr2aUVL0qDNlM9GASQaKhFQ0YpGwDayobkX+matr5fpv0Hzw1/lOQQkDmtc/MAq/KwFhQHSOd2QilCOJ3pD2elpcPRywwLbtJra1wWLEE611/6R4bGl6tJb2RkDZ4fbSnW9YNxkXqa9mS9rnbN1DI+SS8rP5Ib8wKYcFAPb52qrp0ayToifKZNAzZqysQJhidkbFFxhLIfggAhG6FQfkrFQ1mdUuy5F2E=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR11MB8047.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGNGK1JkOWd0eVdxWkt3YWJXOHFMelorb28wUEhkWmdHZ2U2YnhheWJZbUQz?=
 =?utf-8?B?TFIvUkJHQkh4cDdOeW9Pdk50R3RDamMxVVFTZkYxRklRS0ZoTGV5aEcrdytZ?=
 =?utf-8?B?Yk5iNFpkNmFhbUQ0VmhIbTJia1BjYzZuOTdjTnhRRDg2NEFSbVRaUUxLbHd4?=
 =?utf-8?B?b2hERDM4dWRWRGZHdVBIUWdPVE5ibk13RWFnaHoyOWlBMnVkMm9RcHJ6UWxF?=
 =?utf-8?B?eVVOY1hNcDlUUzEwZ00vTm1zNEdWOTdEKzFUM3A0UUlqUkxQcHoxYjFmVlBE?=
 =?utf-8?B?b2l3ckJRdHlsd3RKVmZtSHlwNVhGcmhzRHYyZTV6cGxDL2IyMk11d0NUK1JI?=
 =?utf-8?B?Ym5CS2QreXNBVTc2bDVrRGp5S0hyUFRHVHEwdFNJS0tRcm5MbXR4U3pWaWUy?=
 =?utf-8?B?bnpyNHNYcXJLWG1zaWRLY0kybU5taTlxRU55VGx0cUFrWlA3Snk3djJuMk1D?=
 =?utf-8?B?VDc3M1dGbis5OWhyWEZobXlOR2t2UHFTampnK0V3K28xa25qQ3dTWkFRRkNs?=
 =?utf-8?B?bTZmSndNRmU1aXY3NFFBNDQ0cDJDNHVzalB1UVNhZXk1Sms2TlkzR2RaSzU1?=
 =?utf-8?B?SzkrVDR1RGx5MWNjQUpWZTAwYWxYVGJlQjN3eHZ2dTQ5aWhSTWdDYmtpbWdK?=
 =?utf-8?B?alB5Z0pyM213UnpJT0tvdmorTFFLVHdVWmF4cmJ2TERReVpqTmxBUWlPcGhY?=
 =?utf-8?B?NmlVejd0di9RNUd1L3pKblgrMGtpaGJvQlZFeDA2VmRkdW9xMDUvUkl4cU1L?=
 =?utf-8?B?d1BTbEIvbUdUSTZxQ3dOSVJCaFZHMTZ1a0JXbnpuZWpaRzJTZmUzMXlidEcx?=
 =?utf-8?B?Mkt2VFVSNDh2RnZQcVRLKzQ2TWFxditZcFg2emFCRGp0TkRzd1g1TCtMcVVT?=
 =?utf-8?B?dUlzWjkwdERxZTVETHJldjlic1JQYmw1UmM2S0VscFFZRldEbVhyb29EQzRz?=
 =?utf-8?B?MTFiZjIvZmhIUWJLcGxhY1RmTzFqVm9XQlJVMkdBYWFLMjg2NkJVNWNpZ252?=
 =?utf-8?B?bitaaTg1M2MxcnJ2elIrQlFNYlU3aWY1YkI1Y3ZpMkgrdVhqVG43SmpwT0Ja?=
 =?utf-8?B?d1B5NEFRL0JORVZkVWNFQWQrNDZsdWxBTTVwUUlKSUFNeTJ5R3NpSis5VjVI?=
 =?utf-8?B?aDRlV3VDd2I5c0dncDRPMGk2T1NQKzJVbXpNNGVLdU9yTTdLZmRRR2ZPR0sr?=
 =?utf-8?B?bDlzQ3FSSDRGZm5BVU1hSkR4YldkSDQyUml4RnNiK2V0anJYRU9CdzlodFpG?=
 =?utf-8?B?ODRORWNhK2Zrd0loSjFDbDhqYm12aSt3cHgydzdiWm5mUkNyTlN1a2tYS2ti?=
 =?utf-8?B?cVdnNmlJcTRaU3JyVFBOejdjTTlBaVptZWo0bjJ2TEVyQ0ZkeVBiTzBVa3Yz?=
 =?utf-8?B?MlZnUTJ4QXVnb0gwdDlLL0FicmxOa1g4TmlidlVaSFozNHQyOGxTdUNpRU5v?=
 =?utf-8?B?Q3M1d1pwR2pEME1nbW1PekM5NGdwR2FiVjZpSEMzZ01CM1NOK1NuNjBqRUdq?=
 =?utf-8?B?a3MwRlQ2b3lNWGl5Q2xTSVBPUnhtNWM3a1pEZHVmSHhMc3pkY0F4TEc4TjI1?=
 =?utf-8?B?QmtOL3pJU1RCR3dFSEdWaVJmaGQ0dFc1Wjdob1dpQ3dhNnJHclZRTE01UlhU?=
 =?utf-8?B?Nk9iUGxhVG94UldFbmo0bU9jMVVqdjZmWGZnL3M1N2czK2ZaMUZxUTFBMmNh?=
 =?utf-8?B?bmVkNUNDQzc1UEVMRUhTQkhSOE1ZaERiZWIrT2pzN3BBOWEwU0w3Wk5QK2N6?=
 =?utf-8?B?Q0dadDlueCtxZlNhQU1FYXpXRFlFMURScW5kYkFKWnhWMTlFa1QxRG8yZ3N5?=
 =?utf-8?B?YnJtUDJPazFETSsyaUdHZ09FSXhLNXB2eW5hR2VYT09GWnJmV0F4VCtzR2ZJ?=
 =?utf-8?B?MXkzS0hIYWE0bnJCc2piZzJKNFU3bnRzYzFocG1TNGh0Q29xOFkzUjV4bUhy?=
 =?utf-8?B?bW1Oam1QTkEwUVFNeGZlUWs0dzF5Z3ZXbU9GT245bVZnd2lvUjBPZklHdzFW?=
 =?utf-8?B?cFNxcG0xQ243OFZvYlVMYXJhVGZqNCs1a3RpbW8xSlRtNEhFVmZCSmlaZU8r?=
 =?utf-8?B?OFBpR2lRaFpKOExUWG5aSjdwcFVOYWtEbE1tVGlMV2tyYXlNOEIxdG9tVGJy?=
 =?utf-8?B?UXVzbUZNU3RkZmZVenBqWGNKTllReUtDS1hTTGU5ZmRudXlURGNuYWphU0NX?=
 =?utf-8?Q?3T6bmFKiljbBdc5Gour9Evk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7FB4D59B39E0154D884B6641B56EC04B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA3PR11MB8047.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3c0799d-d6c1-4031-2121-08dc53b69abd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 08:18:12.4918
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0iR8VTaD18Eyr1DsW4L8mEYvexQ2FwhywIXR2x9iGQlM2fWxDTcT7jzXv295AH/wdy4tAjc+gA89LI4BZJnsPVIKWpIUR8+TvqM7DtUkWaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8565

T24gVHVlLCAyMDI0LTA0LTAyIGF0IDE1OjEzICswMjAwLCBPbGVrc2lqIFJlbXBlbCB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBXZSBhbHJlYWR5
IGhhdmUgYSB2YXJpYWJsZSB0byBwcm92aWRlIG51bWJlciBvZiBlbnRyaWVzLiBTbyB1c2UgaXQs
DQo+IGluc3RlYWQgb2YgdXNpbmcgZXJyb3IgbnVtYmVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
T2xla3NpaiBSZW1wZWwgPG8ucmVtcGVsQHBlbmd1dHJvbml4LmRlPg0KDQpBY2tlZC1ieTogQXJ1
biBSYW1hZG9zcyA8YXJ1bi5yYW1hZG9zc0BtaWNyb2NoaXAuY29tPg0KDQoNCg==

