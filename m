Return-Path: <linux-kernel+bounces-128251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF6E6895855
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DB91284975
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565901327FE;
	Tue,  2 Apr 2024 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="lHdb1dLz";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="5iggvRsY"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3657B1E480;
	Tue,  2 Apr 2024 15:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072336; cv=fail; b=BE+BMo0JzRuFb5Ua9XqaU80JYsai5Yc6CBlp8lg6z1m1RK72ruLyp4n3ahXlehRiHQQq68co6EeZM6eBIzv6x88Kg0xQDXoQNQrjseWgQXqDVPE4d3Apx/zqq/dyTfyZqu0qoPk1o5MEYa2U1+EhPiHDc6LNYDUrD6+peTy19sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072336; c=relaxed/simple;
	bh=JX3VN+T2vnnYSHtOb2zUb8lYQKcP/JOKoiwoDfxPucM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N8pkUC9EwvBJ7it0Mk032An2KVEdanJSiRBVa2PKbrxC9XkxvmcqE5+SEbPdFt87aTOKUCmDbBGjBISCOBiknXXNTx6JjNpms9OwkRpxGYB6L53V5CENklRFWO4S3g0B4mgiEuoMPX+3uQ3FHY1ckY3MJUcZS5bz0E7iv56G9RA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=lHdb1dLz; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=5iggvRsY; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712072335; x=1743608335;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JX3VN+T2vnnYSHtOb2zUb8lYQKcP/JOKoiwoDfxPucM=;
  b=lHdb1dLzWMMfPMdIyQPQsePcL3/o+FPH88jdCmvNU27S4VRh4bZTmF8E
   w43/DJjpT4iad/4SAwpmxwgam1kR0VQn11dEp7iIxAYnoc2r9MW3o5Lp6
   ZizSr08nF7kMP8MuQAmmo0AWAaCZcZEiVxNWel3VDVrig/jXYilqrMSTy
   NmjPG1o9GEs5AbC3HvNCjEHtLmRaVH/d27OLuvUinChFB58qns70fkLXl
   Bg9idREAzdqF3N3OKMhUJ6ENaFhsreZodOEnBikXKwxzALqbeMrqGNGCA
   TXAo6Bm32BCBn5ico8LCJdigJtssA95eo0QHq823jjMdam7dyHLDfnCxs
   g==;
X-CSE-ConnectionGUID: pfw07NcySMiJQgOAKBiirw==
X-CSE-MsgGUID: z3lHocf3Qd+IF7DlaWGNmA==
X-IronPort-AV: E=Sophos;i="6.07,175,1708412400"; 
   d="scan'208";a="249968845"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Apr 2024 08:38:54 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 08:37:44 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 08:37:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j4pDz2sxPLaHq+e+k9ar9Sv4uds2p31IAeGtwoQppxHwFQHZt6IpkMmqi5AZG6n3F+7abpHHbBa/+vIo6D36DdwsS1m/bDhVuW8qCL3J/72Ew/6BkfIXoHD2xsn/GjEGOtKsvq01Z4kCAA376p9YSGI+49JItgTA28/FLhEuB2FOSVQM59u0lWy0DiEBdIQkRCUozLKHQ5fe/a7LwxFI5dSdeNOWt4PzYfPIwviDXN0iCCUQN6j5ndVXC62PmBNtCpYSEir046iakFJVB0Hde20SowJ21bvL7I/V14HArpgTDpzdl9Z7Lj7ts8jK82SmVT0Ec4sx0vuRJzWmh1ShKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JX3VN+T2vnnYSHtOb2zUb8lYQKcP/JOKoiwoDfxPucM=;
 b=ArFUWHPIsjmYI+KwjUZoz+pCe6PeZy+bLr5SSzeoxk1NUW0VqWnhszOl+0yaNlSIHFF0qXzlNuBNgjreyZDq2CgRlwwJI4ESVUxSv5Atmwa+lg6zavagolFn1hqkm0QDEoz5ySSc9YmKWu1679YKB912ZQ4aK76PUVzyVcN7/3CH/EZKdnN2jhk2xq1JzvXQbyOBjBJyXCx0Lz2jrMFD9fA9Cj0tbKI0KgqeB1UQ13sgW0/2N0TcDfeYdnNKiBZB0/8kQAo4mvI27Uv2xCeYUPZDI+0UA1k2PAOxhuqbdoKinl1wH7PQW7d7leWahOMp+/kJD92D2HNFjI3ZG704ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JX3VN+T2vnnYSHtOb2zUb8lYQKcP/JOKoiwoDfxPucM=;
 b=5iggvRsYr8llni58J/2t45uDX2S6vnGpmnyP+n3F2xDiBnGuvMFhPTn2vS9+yuESDmnXSDa/rEsX8JagV3+hrp3bUfZeC9X3fI4TTE788luCcrJMq+qN5kZ1cOT0/K+TZOSHbM8JwfAt29PrrwqZXmeRyDD9wYaIWfgMlSUyf2uRmxLNQqtDU74yO4AH0lBdZ/i4b3GBzr1wNzLhArAaSKwChUK168vf3yhMUMYntk37SQ2O+uWQNhH+5TwePd+QWqvb5skW+bJsuZswvRKNyPKYK/CtlW9aPXZal4zybrfmIOpeF6OxR4zKXKzx84gFvHvX9sv92vMdmjeGpZ1inQ==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by MW6PR11MB8365.namprd11.prod.outlook.com (2603:10b6:303:240::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 2 Apr
 2024 15:37:42 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d%3]) with mapi id 15.20.7409.031; Tue, 2 Apr 2024
 15:37:42 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <kernel@pengutronix.de>, <san@skov.dk>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v1 3/8] net: dsa: microchip: ksz8: Refactor
 ksz8_fdb_dump()
Thread-Topic: [PATCH net-next v1 3/8] net: dsa: microchip: ksz8: Refactor
 ksz8_fdb_dump()
Thread-Index: AQHahP+qjyoZwP8F6E2cZFkxH7e7cbFVHcYA
Date: Tue, 2 Apr 2024 15:37:42 +0000
Message-ID: <c0d1cf2420e103a36fd309ee1fcbbd4106ecdc48.camel@microchip.com>
References: <20240402131339.1525330-1-o.rempel@pengutronix.de>
	 <20240402131339.1525330-4-o.rempel@pengutronix.de>
In-Reply-To: <20240402131339.1525330-4-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|MW6PR11MB8365:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yMnC1XA353D8GZKSos71JAke1Q7yWFrjEkyvrIGIigGLCBqxZSKQSCBQXVpg9Fs3V7zty9G4NSU8IEqHdbDfKDdNhe572HyE7InxXonizT3iY8Ryh6wcyLYxOpyF6L1qgRo5okGbvvyz7Ox/a7uCF4OOwHkhRXVE+VXxR0m2s6vG23dxNb/DaLmQghjuFhIzXeUeyUsuz9Ll7Vshkf+6ibtMFL3UmvuifUf+GaUB/2HEPij/OMZy2b8+kaoZanrSpDPeuUQsBDswGgQL/4q3bfpl8OPdB27L+j2tKn3EtO88IxK+GyhYoqghYQuq0+2mlpWPz2MtpP7Ca42FdYYJ0BZE8EtRX16eutOjxMoaczS0NtrxBmRUyJnQLFC8sNVXUGkSh+MQP9WEx67Ub6aOgibPtZXoIyRc75Wqjwm6pnhU63aA7yDrntdjT2wztb6EdvJmvEvBDtuSXep7k9bqZHg4WP7BiLyHSXJdltq9THAPUEt2ZXMy/d32d+MWn9s64dfnIrVlkUrHYhJrDaOeCCBMIZ6ZU3rRoodOdgS+XUKxtCa/WMOTwL9Umc4xImzNXwaMhO7piMZpaN/nVLxFeEL+bZxmSy1NBCr4EuE7YKcaWnKzOSMZqGiBsWl2SwGTn6KxSUqgZR9R6oDgZYOqhBJJif4qk4KQinYBqthFB5s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVhuV2FzaERSYTVXUHhvdURzVFl3VE90REFITSttejVreGRoNnhZUjNiRHlR?=
 =?utf-8?B?OXVFVlhzTGF4cklhNWhHQnBHZG52b1Z0dUZUYzVpV0pIYVo1Y0RzZTdEV2VW?=
 =?utf-8?B?bFhDR2wrL2YvaTZyc0VGQkk3SW9qRi9UVzIzbWc5UzBkQVdyU1lpTXpRT2sv?=
 =?utf-8?B?Z25IaDVwQ3dxMlVScHFSOUZiRXlCeml0NCtrMUt4RElZSHJJSS9QeHdMMjRL?=
 =?utf-8?B?VnJCNGc0QVdUdjBFZElvc0Vkc1g4UGlDK1BCZ2o2YkRVK2dBby9JTWYyS3hE?=
 =?utf-8?B?YUZRTHlzM1VYSEMvZHVwS2JZeFJ4YW9kZm12S3VZNHhsVzUwRWFMYk16eWN1?=
 =?utf-8?B?NFM0Tk5Gb2VtZlRNUHFFdTBLcCs0K0YwRHVJQTcwZjZyM1N6MHl3SEVSdGZL?=
 =?utf-8?B?b2h4YnRVRTY4NlRLdEFxdWJVTS9xOGdYYkYxWDNVNXBQbHNzYlZYZWs5RGNx?=
 =?utf-8?B?YUs5OTYzRmJmNnpGY1phL3R2Q2w3aUl4cDg5RWVFc2ExbEpSekxCQk9CeGtk?=
 =?utf-8?B?YmRXNU9YV1ZxRXdqUkowTkxDS29EZnFpN09xTWZ6RWlyMEQydHdTRkxxWmEr?=
 =?utf-8?B?dDVXQytEVG43aTlxblVFQkVPWDRuMXdaZmdpRENYQkVvQWdXWGpOU09DTVh5?=
 =?utf-8?B?OTZrZ0kwWUs3eTZWbE9PTFkvdldhUjB2QmJZNFA3UlpWcHNNclplcGZhSmtv?=
 =?utf-8?B?ODR2alRHWHdHM2dCbndOTGZNOWVQcHpDSGVQQktrTk5PSWJXdHZlZEpDd2RX?=
 =?utf-8?B?N0ppV0hCOGFEeXlKRExxOFlMSFIxQm50Q2R6UWF0SzNUSHlNalhzYm10TWYr?=
 =?utf-8?B?U2FCV3ZlZEtnZWJoamZpVDRkQnBudDBOYmZMQUFZNUt0dHd5TkVtYlJzaTdQ?=
 =?utf-8?B?a3ZIaGdxa3NMQm5vaXMxcVl3bjZwVTVVS0ozQ2FDaERQTVJtejUwRjhiWHQ4?=
 =?utf-8?B?REN0elc4S1lrQmcyTmxjUE9rV2NidGdjZ3dka3VFY2xDRTBtWkZyTi8yRnNQ?=
 =?utf-8?B?cjAvM2NITWg3ZEEyZXBySGwrRWhzelRVUzA3WWl1cW5vSFpTRmViMTZBVGFO?=
 =?utf-8?B?dktlY0xkaU1Jb0xrRjVzbmpUVUlPeTE4cWc1dm1zRkFvS1BKbHUwcy9UQUlK?=
 =?utf-8?B?VnRraFErdDFtRlpoc3NoNkpRMSt5UXp3NGlrb2oyWWs2Rngwdk5xS2pjWVdD?=
 =?utf-8?B?Tk1pMnl6Rmpja3doUUlNNFhjVEY4T2RHZWxhUytWM2RSUzZNaFVYOHorMElh?=
 =?utf-8?B?QnUydjRvbEZDTTE5dTlxMWljZTZBYjV1Q2xneVg2MllmS0l2c2RiY1lEbTJQ?=
 =?utf-8?B?SjA5QzdiQUEyMHBza2svVStKZGRVOU9xWGpEejczdWYxTjRmSi93RWFTVVNu?=
 =?utf-8?B?Yy9UejY0Q1ZvWTdRaGs2SlRnbFQyeFpHNGVKNTg1SDVxRXdhaG5hNktWbFM2?=
 =?utf-8?B?aTE3Vjg1SHNURzJTb1hScHhPRWRBWTliTkE0R2NJNDBxenBDT2FnKzVHd2ti?=
 =?utf-8?B?b25XNTFwSHZZcDJ3elJOcHhqcm9DRHJQRUF3NjFRcGg4NHBYaklXS0Mva2Rx?=
 =?utf-8?B?aFBJZGduczhyUE8wWHJZbE14V09yVkMxMUNnV3hpWmJqeU5WTkZOcFhFV3NR?=
 =?utf-8?B?YW1oT1JhUzVFbmRiM2ZacS9yR1RqNm5WVkNLeEdGUEhpVkg2N01iS1lwSmZX?=
 =?utf-8?B?NFJiRU1JTG9hcUVBZWZibU5JcSs1bVFjL3hwTkRWcys0d2FvUktxNURVUDZO?=
 =?utf-8?B?MHFicDZZbitsbEhpMUZ4eDJra1ptVXludHp6U3VML1oyYWxRWlUvL3hqTWdR?=
 =?utf-8?B?ZXdvMzhkSU1haDYzRzdlSVZwWnB2dDVjbUt0MjRQYjUydFpORENrc3BNUWhy?=
 =?utf-8?B?U1hBZCtEcW1SWENEVzlNSXVTSHNLVUxwVDNkR2NDWTMxbGMySjZaMDlDUUs4?=
 =?utf-8?B?Wm5mOU15akliRnFmVmltTjJYYmlPRnM5bjR5cEVmQS9HUG5tTjBCQnNxT2pW?=
 =?utf-8?B?ek5aekdma2VOellHMDF3UERPR0VYSUk5MWFUQ043SUxXU2hUVmJMLzY4SlRi?=
 =?utf-8?B?VzR0RFpTTnlCVm1VcXRhTUVIV3RibnVSWExnWWRiRGJIaFE2c1BjUVNxaUQy?=
 =?utf-8?B?UnlZOTJCMktDanRhQnZ5eklUd0lqRmpVeUd2TmpzWnF1a3hYcDZMMTh3SVh2?=
 =?utf-8?B?Rmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <65B1CCA19AAC714989818411EB356DAD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84a5526b-683b-4563-a17b-08dc532ad618
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 15:37:42.5217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: atZfgfmO+cXYPtGIEtPpx4D5JkvmnlSXJ4fUpsAdayZ1a36f4YFUF9c0iR7b2KdXo2p3DZYif11ueIpy+xSlKxyykBbio7yUZDrULEBeOSM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR11MB8365

SGkgT2xla3NpaiwNCg0KT24gVHVlLCAyMDI0LTA0LTAyIGF0IDE1OjEzICswMjAwLCBPbGVrc2lq
IFJlbXBlbCB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+
IA0KPiBSZWZhY3RvciBrc3o4X2ZkYl9kdW1wKCkgdG8gYWRkcmVzcyBwb3RlbnRpYWwgaXNzdWVz
Og0KPiAtIExpbWl0IHRoZSBudW1iZXIgb2YgaXRlcmF0aW9ucyB0byBhdm9pZCBlbmRsZXNzIGxv
b3BzLg0KPiAtIEhhbmRsZSBlcnJvciBjb2RlcyByZXR1cm5lZCBieSBrc3o4X3JfZHluX21hY190
YWJsZSgpLCB3aXRoDQo+ICAgYW4gZXhjZXB0aW9uIGZvciAtRU5YSU8gd2hlbiBubyBtb3JlIGR5
bmFtaWMgZW50cmllcyBhcmUgZGV0ZWN0ZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBPbGVrc2lq
IFJlbXBlbCA8by5yZW1wZWxAcGVuZ3V0cm9uaXguZGU+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQv
ZHNhL21pY3JvY2hpcC9rc3o4Nzk1LmMgICAgIHwgMzggKysrKysrKysrKysrKystLS0tLS0tLS0N
Cj4gLS0NCj4gIGRyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAva3N6ODc5NV9yZWcuaCB8ICAxICsN
Cj4gIDIgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9rc3o4Nzk1LmMNCj4g
Yi9kcml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2tzejg3OTUuYw0KPiBpbmRleCBlNDA3MTExZGI2
NjM3Li5iNzBhYTJjMGE4NWVjIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9kc2EvbWljcm9j
aGlwL2tzejg3OTUuYw0KPiArKysgYi9kcml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2tzejg3OTUu
Yw0KPiBAQCAtMTE5MSwyNyArMTE5MSwzMyBAQCB2b2lkIGtzejhfZmx1c2hfZHluX21hY190YWJs
ZShzdHJ1Y3QNCj4ga3N6X2RldmljZSAqZGV2LCBpbnQgcG9ydCkNCj4gIGludCBrc3o4X2ZkYl9k
dW1wKHN0cnVjdCBrc3pfZGV2aWNlICpkZXYsIGludCBwb3J0LA0KPiAgICAgICAgICAgICAgICAg
ICBkc2FfZmRiX2R1bXBfY2JfdCAqY2IsIHZvaWQgKmRhdGEpDQo+ICB7DQo+IC0gICAgICAgaW50
IHJldCA9IDA7DQo+IC0gICAgICAgdTE2IGkgPSAwOw0KPiAgICAgICAgIHUxNiBlbnRyaWVzID0g
MDsNCj4gLSAgICAgICB1OCBmaWQ7DQo+IC0gICAgICAgdTggc3JjX3BvcnQ7DQo+IC0gICAgICAg
dTggbWFjW0VUSF9BTEVOXTsNCj4gKyAgICAgICBpbnQgcmV0LCBpOw0KPiArDQo+ICsgICAgICAg
Zm9yIChpID0gMDsgaSA8IEtTWjhfRFlOX01BQ19FTlRSSUVTOyBpKyspIHsNCj4gKyAgICAgICAg
ICAgICAgIHU4IG1hY1tFVEhfQUxFTl07DQo+ICsgICAgICAgICAgICAgICB1OCBzcmNfcG9ydDsN
Cj4gKyAgICAgICAgICAgICAgIHU4IGZpZDsNCg0KSU1POlNpbmNlIHRoZXJlIGlzIG5vIGNvZGUg
b3RoZXIgdGhhbiBmb3IgbG9vcCBpbiB0aGlzIGZ1bmN0aW9uLA0KdmFyaWFibGUgZGVjbGFyYWlv
biBjYW4gYmUgYXMgYmVmb3JlLg0KDQo+IA0KPiAtICAgICAgIGRvIHsNCj4gICAgICAgICAgICAg
ICAgIHJldCA9IGtzejhfcl9keW5fbWFjX3RhYmxlKGRldiwgaSwgbWFjLCAmZmlkLA0KPiAmc3Jj
X3BvcnQsDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmZW50
cmllcyk7DQo+IC0gICAgICAgICAgICAgICBpZiAoIXJldCAmJiBwb3J0ID09IHNyY19wb3J0KSB7
DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHJldCA9IGNiKG1hYywgZmlkLCBmYWxzZSwgZGF0
YSk7DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIGlmIChyZXQpDQo+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+IC0gICAgICAgICAgICAgICB9DQo+IC0gICAgICAg
ICAgICAgICBpKys7DQo+IC0gICAgICAgfSB3aGlsZSAoaSA8IGVudHJpZXMpOw0KPiAtICAgICAg
IGlmIChpID49IGVudHJpZXMpDQo+IC0gICAgICAgICAgICAgICByZXQgPSAwOw0KPiArICAgICAg
ICAgICAgICAgaWYgKHJldCA9PSAtRU5YSU8pDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJl
dHVybiAwOw0KPiArICAgICAgICAgICAgICAgaWYgKHJldCkNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgcmV0dXJuIHJldDsNCj4gDQo+IC0gICAgICAgcmV0dXJuIHJldDsNCj4gKyAgICAgICAg
ICAgICAgIGlmIChpID49IGVudHJpZXMpDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVy
biAwOw0KPiArDQo+ICsgICAgICAgICAgICAgICBpZiAocG9ydCAhPSBzcmNfcG9ydCkNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQoNCklNTzogc2luY2UgYWxyZWFkeSBtYW55
IHJldHVybnMgaW4gZnVuY3Rpb24sIGlmIGFib3ZlIHN0YXRlbWVudA0KcmVwbGFjZWQgYXMgYmVs
b3cgd2lsbCBpbmNyZWFzZSByZWFkYWJpbGl0eS4NCg0KCWlmIChwb3J0ID09IHNyY19wb3J0KSB7
DQoJCXJldCA9IGNiKG1hYywgZmlkLCBmYWxzZSwgZGF0YSk7DQoJCWlmIChyZXQpDQoJCQlyZXR1
cm4gcmV0Ow0KCX0NCj4gKw0KPiArICAgICAgICAgICAgICAgcmV0ID0gY2IobWFjLCBmaWQsIGZh
bHNlLCBkYXRhKTsNCj4gKyAgICAgICAgICAgICAgIGlmIChyZXQpDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgIHJldHVybiByZXQ7DQo+ICsgICAgICAgfQ0KPiArDQo+ICsgICAgICAgcmV0dXJu
IDA7DQo+ICB9DQo+IA0KPiAgc3RhdGljIGludCBrc3o4X2FkZF9zdGFfbWFjKHN0cnVjdCBrc3pf
ZGV2aWNlICpkZXYsIGludCBwb3J0LA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvZHNhL21p
Y3JvY2hpcC9rc3o4Nzk1X3JlZy5oDQo+IGIvZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9rc3o4
Nzk1X3JlZy5oDQo+IGluZGV4IDdjOTM0MWVmNzNiMDMuLjBkMTNhNmUyOWIwZTYgMTAwNjQ0DQo+
IC0tLSBhL2RyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAva3N6ODc5NV9yZWcuaA0KPiArKysgYi9k
cml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2tzejg3OTVfcmVnLmgNCj4gQEAgLTc5NCw1ICs3OTQs
NiBAQA0KPiAgI2RlZmluZSBUQUlMX1RBR19MT09LVVAgICAgICAgICAgICAgICAgICAgICAgICBC
SVQoNykNCj4gDQo+ICAjZGVmaW5lIEZJRF9FTlRSSUVTICAgICAgICAgICAgICAgICAgICAxMjgN
Cj4gKyNkZWZpbmUgS1NaOF9EWU5fTUFDX0VOVFJJRVMgICAgICAgICAgIDEwMjQNCj4gDQo+ICAj
ZW5kaWYNCj4gLS0NCj4gMi4zOS4yDQo+IA0K

