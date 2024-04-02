Return-Path: <linux-kernel+bounces-127359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27609894A48
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 06:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EE6CB24963
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFFF17C7C;
	Tue,  2 Apr 2024 04:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="2SvPbp1M";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="BubfTKY4"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C7F179AF;
	Tue,  2 Apr 2024 04:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712030860; cv=fail; b=QRYDDenkIo1oYXDDGqO4W74DUZVOzFPO2hrrU/Nbpky2CU9P1g0jL5FLC25VysQm8QbSm8Njl3XF3VQpuEb+vq3L/VU1/ZGboXLmBzveyOOSv7BY+EDqp1D31Pv35nu2S1ZuS75wXxQ00QCVyDM97LZ4NBdxSwqp4R7eMg110YE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712030860; c=relaxed/simple;
	bh=klEv+REKaL4U27YOCXkzC1WJ9jbb41qXgVrfO5SBaN4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qck+RFnzJUonwN/4eFmb92qHPyx13dsPyat0UKmBh2alijsvdz4kYZuVLta3DvZ+1Z+bsUKTLkwwBoCjquUX8keHBeYjE5lkEI9Pxg61s4Dqid3vzpyrnFgYxELaIz7Ocs5CA7LwG/F8avhKks/91zxTzFJwBwpFrHbLqpBMEqw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=2SvPbp1M; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=BubfTKY4; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712030858; x=1743566858;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=klEv+REKaL4U27YOCXkzC1WJ9jbb41qXgVrfO5SBaN4=;
  b=2SvPbp1Mjk7C9uuqZoxS7XP0mUIaGZQ/1q3f1CwR1uI1BWzDEJ7nMTBO
   qxtAa6m7pWngUFvsSfhVDMObQvSlRtGTPs8L37rE+gvHt6R0XBBHBojzR
   Y4pCWKXkgOK5E50HAE7VqUF0hAvZvXX1Er61dGMnxUphbN5TRgojHwPeX
   KlZo75NgEmeYSnAv6AsS7aaPiMP15b8BtcXedfASBuiZK0jixdMxbH7Ak
   oKZPWLLskhQGD3QbDB3zHypoH4iMvt/FLp9TOHRVbGf3WveErYxLWofJZ
   M7G1zZ/97e4MdIbhhFBzvDT/rzaTPMfKIaQVRDNh1ZkQKHQtOYiMC5YUx
   w==;
X-CSE-ConnectionGUID: rGmBuFmkQ0+7qol2KmZi0g==
X-CSE-MsgGUID: Ajk5Jfg9Squlyhukx902ng==
X-IronPort-AV: E=Sophos;i="6.07,174,1708412400"; 
   d="scan'208";a="186360544"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Apr 2024 21:07:37 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 1 Apr 2024 21:07:32 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 1 Apr 2024 21:07:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SprJ1EaenVkAlKKRRwMXs3MJqvO/gUjjn1w+di8FDtD+gSkZqSt0Ve654VLTioSRDIZj3MEYM8yDOHEPS1qobMNMf5/cNgsjnDsV3trhOClyDZkzz/ysFxJZiwsTRFlRdeZ24LHYATXRtfnmS6pBOwihdNkPbftouStv6bjD5vv3nlv9/W4N1resVRey1pPC4HPclYExH7YSP3zuSf38v9Uy2tGNqHOKmdhYnayepRi6yyHzkNDVu+yaCY/8qRzDZjfvkYZ8VZQvCruURIa5abXIVaM0uVzvFyWtXRa69ifRfA/KNKcrp3hVZGpbmcWb4RBOG1qiCd2HoOlmaRGDQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=klEv+REKaL4U27YOCXkzC1WJ9jbb41qXgVrfO5SBaN4=;
 b=aY0Ove/iWYoehKVFtm8i13IDulQ0OKS/Q0DpaAdt2zSBMM34bzkBfQpRhEqVgHLYvqBdUx4EVdaJh44PhkDq7PB0Zq/fPqTImMhxMrdSyRrpzUVeeusV+XEFQZ97J/edIuZS6wcgynkrsGjgVViUvRh+VbhHLvYa1S7jvdPEDG48lrHV7NprcVe2rAy2GcRP1e/gvyY3eTAnXsGdogdd9LSHiFyg/hP7cqTJyPYkTBmoxW42OJfrwko31QUinYXy1519fNBvC3YtK48Axo4WchrXljgoCgEaEFmZW1L1YfjazplC+Yi/fg2aABWyWVRbFpYNxylLoUiypGn8xZu58w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=klEv+REKaL4U27YOCXkzC1WJ9jbb41qXgVrfO5SBaN4=;
 b=BubfTKY4x32U2pbl6FhUIbb3Su9yS2FYuTPB3/vUYu6dp6zVpL4myC4cNQxPKO9L6mw3Q0GnbisJmTVGZiYcYUfXX8mdRIjvsMzWGvH8lyRTPTjUcnRK9HL7bbyoAVZkfDwTGarhCGBQ//3J+hskWQQQq6B/Wz8owaQYKydEeo7pZtdMwQWoHFrjf+LfU6kA98RVvqFFsnSpjUGAAxqQMEsmLkunY6qKxMPGB1WJwRVGiwiWeT8XLPej3H621moXMZreuIn9ym5silWJHNzlXC8nNatIFckSN4jpI+e8sr9k9HfOv4tYNjHAtgb+HOCyr+BWaTp0vn14Bn1LmuATBQ==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by DS7PR11MB7949.namprd11.prod.outlook.com (2603:10b6:8:eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Tue, 2 Apr
 2024 04:07:30 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d%3]) with mapi id 15.20.7409.031; Tue, 2 Apr 2024
 04:07:30 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <kernel@pengutronix.de>, <dsahern@kernel.org>, <san@skov.dk>,
	<willemb@google.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <horms@kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v1 8/9] net: dsa: microchip: init predictable IPV
 to queue mapping for all non KSZ8xxx variants
Thread-Topic: [PATCH net-next v1 8/9] net: dsa: microchip: init predictable
 IPV to queue mapping for all non KSZ8xxx variants
Thread-Index: AQHagSnaIDPsgoaHwk600WVBE8Y7cbFUZJ0A
Date: Tue, 2 Apr 2024 04:07:30 +0000
Message-ID: <0331845071e66b8f8f725100f6a138215b77f0a7.camel@microchip.com>
References: <20240328160518.2396238-1-o.rempel@pengutronix.de>
	 <20240328160518.2396238-9-o.rempel@pengutronix.de>
In-Reply-To: <20240328160518.2396238-9-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|DS7PR11MB7949:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a0MAoCT6XS3hKkAqah1n3CuVV9mBRwLhvEiPPUPfRCBTKRJPXUYDiocEA+lZybQqlxrNSFmZ2xvVcFa9D2o1pueqyK1mTWGmtV16jEBKwc3TxmlWa0LFjwRkB9ZJC6CMrE9uHaxwCgLbzLvqLe26QPcyux4Dg7BOg9S/GZoJCYZ/yHrAtCGceRHOExonYesmjm7uVieyPe7xUBWAoxkSJFiGXXjImwNXEniJpcvayb6IvDQlbPoLp4NMC4WhDvk37c7s9yCDXarLrGww+zpLId/5lncvBTjak7iAE4g39ej8s4rck6KgzLp/7sjisEsJvb8/9cDjDLb9KAEl46i71nh1Q7Oge9Hvmy+uLoa3sUKakWR7QRodXOf17yiSTNFcqAxlg0wknGFyhfcwgS6Dz2z3/1SKwKAqYoAKt2augyssFZRxDbxcYSxGlGjM8hW+8YbQJ5fJUfnzrTnubzcg3bfdl9QGHHfkaNo/rbdR/LbJ57/J8v4TUnu75oUZrxx8/GUzEXIKw9Bi9hYNwjlJC4j5FT5bo71DbEKQJjUc6aSYGpUpw0UDAgZ2Owa2V9hD28dJgPPCWmOM5tKHzXFfxjy8cLeuTm0rrvktSLsUS8p6yeUazZe/AeQ74lF7rZrBkME8IQ5kyysO0V9QLcrN8vp5WkkgjyMSVfx4bv5S+Ms=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TCtHVVdqUDV6YzV4WDFHVkhJbWZUSGJqc09FblpJWkxOazdKaDBWem82QVlL?=
 =?utf-8?B?cFdVN050MTNoenYvY01GbDYwWkFVQWR3c0R0enY3cjJBelp1VDl6MmRvSFV3?=
 =?utf-8?B?YS91UnVJUXlnT21Na0VITzltRE9KN2FWQXl0SUVFWVJFY2grOFUvZFNvbjlE?=
 =?utf-8?B?aDZoVS9nQnZNWEN1LzFMVHlWNGZmclVOV0xsTStGdVByNnMwL3NJcWFUMmhq?=
 =?utf-8?B?aEUwQ2d2OEFyajhzTE9VM3VIaVIrNy9QOVZrSGQxSFBoM3ZBS1VVVjNRU1Js?=
 =?utf-8?B?TEUvL2VvRmlHR0J3RFl6blFhN0s2K3NEMWltaEJIb2x5YXhmTHJzL0wzcTVT?=
 =?utf-8?B?TFJ1VDgyWlNaeUxOMWFzYjNYeWVGSDlHQjVCRmM3NE5sdk9JdW1rNHZEWm9i?=
 =?utf-8?B?LytsRmVkc1RYVElTUFNIeGhjLzJzdTNKQy9lRlJITFNyL3gyQXpUZmNzU3ZW?=
 =?utf-8?B?OEszc3Q2eWF5b1BZK1R2RERBaTlkY3JRUndId3E4ejNDVGM3YlRWS0Rwdkc1?=
 =?utf-8?B?WW9LcTJpa1RtaFE4R3VqOEpmSVRlS1V5YnJQc0RHVm45azFvRFA4S3NEaWdW?=
 =?utf-8?B?MzdmUXNKNGUvZFMvZWIvc0U1M0RLN2dmS29QWW9KVjdRVmFyOXlRYjF6RUlE?=
 =?utf-8?B?YzdiZ0diMk5jQVdNd2l4dk5NUWxIcXhTYXhJVk5STXR6UnpPUFNvdUt6ckgx?=
 =?utf-8?B?YlBjMjJTemZOV0x3R1RtWFptUVBVaEpKZHo4WlBWSk9JQUpYRTFBeU1kWHdN?=
 =?utf-8?B?NFZkaXhXOXhjNHRaMFgrWks4V08vL3llaXN1VWZQT2ZGSkFDRy9nL01oUzlF?=
 =?utf-8?B?K29obXRYV1QyUGRjRTR4eGk5MUZ3eWFyanpPT1hMamVLOWFqTUd0NkRWclVI?=
 =?utf-8?B?K2VjT1ZuUlJQVUM0emMzcFRuTjZzdTd4amc3alQyaTlMcUZGc3k4aGcrdmhJ?=
 =?utf-8?B?UXhRelBwUG5HUUYyeWJqSHZsZS8wbHBpRWdTNHFqSW5kVlNhNkJZYjIxNkZU?=
 =?utf-8?B?blJHYzdGTG5MVjN1bFVVVThNa3JkaVRmeWR3QmxnSFlvaERtQXhHL3lGOWx6?=
 =?utf-8?B?TXFBRkJnZ1E1dmV5dzdLdENmMlR4ak9Hc3B5YjByYUJBbGo1NUtPMUpqL0NQ?=
 =?utf-8?B?Ynk1NEN4bUlCN2lTMXBqTW5XbWN5TndWK1JYM0FzQ2h2MnNXZnpmMGxxTzlV?=
 =?utf-8?B?YlQ2SWVqc3pjbEJ4NnhGU2lSeko1V0REeWJYV2Q0dUZseHBTT2dJNjdjTEZD?=
 =?utf-8?B?SHZEb09OMUhybzltQ0wxQTY1cXpWUU5JQ1ZjcS9kZ0FzN0dtbXdyUmNQdW5G?=
 =?utf-8?B?RElpbUlaTmNGcmpBVC9MT2s1SUJPalpmM1NZOUI1UW1pb1VjL3FhbG5NSjRL?=
 =?utf-8?B?cjFYYU8wYUVPbldxTG9ldFRvZjgyeVRldVphMC90ZEtvQXNwRWpvQ0RFQjBm?=
 =?utf-8?B?RU02bFFrT2NBY0VDdVYwcGZMZUsvckVTUThhaGxUdXVnVzlGSlBXbk8xUmJM?=
 =?utf-8?B?WldaUFJmdE9nTEZBQWJHZzBaMmJIVEJiZWFVWjIwQnFxWG9iWEhmWmJxV3Jz?=
 =?utf-8?B?OWtFYzA5THMwM2Q3NzB5OWVNdkVLK0VxdVp0UEdhZHlIbk05bXd1SFlXcStT?=
 =?utf-8?B?dFNOSEFwMVpWN0o3L1d4ZFUrRkhDZmhWdVR2M1VPY1FBa1JzNTR2MHpjV1NJ?=
 =?utf-8?B?Y3pla3BQbVR0b3c1K1o5YjFMT3NOMm5zdHg3bHl3dnhQR0E4SjF1WC9hejYz?=
 =?utf-8?B?OTBqNzZGSStNazh4Slc2bVFBb0FkUitmSUZrdmdneGkyQmxpQkR1MnNrc1VD?=
 =?utf-8?B?RGl2OExpWTZoT1NxMWplZHBlL2NXWWVTZzl4cnFsTEd2SVN3dHcvZ0JvdjFO?=
 =?utf-8?B?RURUTXRoV2l5RE5yVTl6cFNGK0MwbWxQSFdJWWRoUTJsTnNGZFp2WFl0NDdH?=
 =?utf-8?B?UnlFdGdtR0tscHYrTTZPelluVFJqK0FkZDBzOC9ubFdYMk43RnRheTJvV2E0?=
 =?utf-8?B?RnlKalV4Q2xHOVJIMlJhV1kwbnFRRldFanY2T2Nld2ZMZXAxaUtCbzkrT0x4?=
 =?utf-8?B?Rm1QM3lLQ0hWd3paOWx0V0RLTXhxc3hjYnIzZkpCV2FJZlpKOUVjR1dqK0E2?=
 =?utf-8?B?M2N0aG1WcklmSk5DWFNaTTRIYzZLWkg3TmxONXZlMzhwTXBlMEFrZGorWXo4?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <134295212291B14486D4F75A1AAB6451@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8770b6-9e22-4a52-9bcf-08dc52ca6a65
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 04:07:30.1346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bjza0aGsR8lbsEfXCWD0iQuC7jZ1Uz9BKqgpOAiH7QDJCxz4QRGKvKNv4tlZcp8zbW9hR5mO//EIHgF/+h/t7MLXZYlmvzAGR7InG+21xaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7949

SGkgT2xla3NpaiwNCg0KT24gVGh1LCAyMDI0LTAzLTI4IGF0IDE3OjA1ICswMTAwLCBPbGVrc2lq
IFJlbXBlbCB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+
IA0KPiBJbml0IHByaW9yaXR5IHRvIHF1ZXVlIG1hcHBpbmcgaW4gdGhlIHdheSBhcyBpdCBzaG93
biBpbiBJRUVFIDgwMi4xUQ0KPiBtYXBwaW5nIGV4YW1wbGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBPbGVrc2lqIFJlbXBlbCA8by5yZW1wZWxAcGVuZ3V0cm9uaXguZGU+DQo+IC0tLQ0KPiAgZHJp
dmVycy9uZXQvZHNhL21pY3JvY2hpcC9rc3pfY29tbW9uLmMgfCA1MyArKysrKysrKysrKysrKy0t
LS0tLS0tDQo+IC0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyOSBpbnNlcnRpb25zKCspLCAyNCBk
ZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC9kc2EvbWljcm9jaGlw
L2tzel9jb21tb24uYw0KPiBiL2RyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAva3N6X2NvbW1vbi5j
DQo+IGluZGV4IDA4NDI2Zjg1Zjc3MDcuLjc4ZTk2MTAwNDRlYTggMTAwNjQ0DQo+IC0tLSBhL2Ry
aXZlcnMvbmV0L2RzYS9taWNyb2NoaXAva3N6X2NvbW1vbi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0
L2RzYS9taWNyb2NoaXAva3N6X2NvbW1vbi5jDQo+IEBAIC0yNCw2ICsyNCw3IEBADQo+ICAjaW5j
bHVkZSA8bGludXgvb2ZfbmV0Lmg+DQo+ICAjaW5jbHVkZSA8bGludXgvbWljcmVsX3BoeS5oPg0K
PiAgI2luY2x1ZGUgPG5ldC9kc2EuaD4NCj4gKyNpbmNsdWRlIDxuZXQvaWVlZTgwMjFxLmg+DQo+
ICAjaW5jbHVkZSA8bmV0L3BrdF9jbHMuaD4NCj4gICNpbmNsdWRlIDxuZXQvc3dpdGNoZGV2Lmg+
DQo+IA0KPiBAQCAtMjY5Miw5ICsyNjkzLDI5IEBAIHN0YXRpYyBpbnQga3N6X3BvcnRfbWRiX2Rl
bChzdHJ1Y3QgZHNhX3N3aXRjaA0KPiAqZHMsIGludCBwb3J0LA0KPiAgICAgICAgIHJldHVybiBk
ZXYtPmRldl9vcHMtPm1kYl9kZWwoZGV2LCBwb3J0LCBtZGIsIGRiKTsNCj4gIH0NCj4gDQo+ICtz
dGF0aWMgaW50IGtzel9zZXRfZGVmYXVsdF9wcmlvX3F1ZXVlX21hcHBpbmcoc3RydWN0IGtzel9k
ZXZpY2UNCj4gKmRldiwgaW50IHBvcnQpDQoNClNpbmNlIHRoaXMgZnVuY3Rpb24gaXMgcmVsYXRl
ZCB0byBLU1o5NDc3IHNlcmllcyBzd2l0Y2gsIGRvIHdlIG5lZWQgdG8NCm1vdmUgdGhpcyBmdW5j
dGlvbiBvdXQgb2Yga3N6X2NvbW1vbi5jIG9yIGZ1bmN0aW9uIG5hbWUgcHJlZml4ZWQgd2l0aA0K
a3N6OTQ3N19zZXRfZGVmYXVsdF9wcmlvX3F1ZXVlX21hcHBpbmcgdG8gZGlmZmVyZW50aWF0ZSBp
dC4gDQoNCg==

