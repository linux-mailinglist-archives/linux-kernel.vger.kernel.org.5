Return-Path: <linux-kernel+bounces-128275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD1F895890
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F101F1F26490
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AD1E1350FA;
	Tue,  2 Apr 2024 15:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="aKP+T/8M";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="5mCkl00g"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C99413280D;
	Tue,  2 Apr 2024 15:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072679; cv=fail; b=DR/wtE5I9Gu0P+owP9JUWTIFuakcPId3WvK+M4YKnw9eFHrm29T+EK3CkXeVeFS3EUsaaEGzxh4b1rhTlZeBM9+udgz2wJcdPeNx3NLkY2h5A3/Meta0VdB8ve9kg3tta0Uf/txCzcbHB+d7D58/ZQg6inINRVZ72zVtsOuqKNQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072679; c=relaxed/simple;
	bh=1ATPteMg78zGmhRWqCXyMrwb92MCZTP6+ehBcTMacLY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FKIuLL437FXQW9qIl+QohGTM6LJ6l925iRkZjOqnZV2KMQhY0+pyCeED18VeZBhG6BH3lG/GXO7+MgB91rsDRpMpE+UGCHqfdXJMot3g/PhvTbVJWOb3J0DbL+WfQD73rxf4qBXRNLhmtdZxCrdGaNayNW8Aft2a/Eewv17rif0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=aKP+T/8M; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=5mCkl00g; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712072677; x=1743608677;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1ATPteMg78zGmhRWqCXyMrwb92MCZTP6+ehBcTMacLY=;
  b=aKP+T/8MhEOumBwEMHtxejCniONe0WWDLLLgYuDNg0nJ8pd7Tkj58qlB
   gySatcJe6BH68z/codmvoTcGQo+IyvDevtgKiqM9xm8re7fC00LfLSrK7
   Lso7EkqWEDci8S3PuKlXrZT02991Vg9HiuSx1kkgJeQB/ypdVGvGSaQSU
   27a6cQqF8UCnVLJ0PTZG7bc1lvdEyAkTFgToKdeUbLE24DGbyHG+Ws/Ie
   X5ytcMj/1iTFQkeg5uvmHUkOUmYnD1iDQDAREwbz+YF4nFtWQFt//bXqK
   u63D8MZc1ykUwqGhfMe+/IOajOJemC0nVsB/3i8gdhnmO4r6H2kzCz+oK
   g==;
X-CSE-ConnectionGUID: DiWZsDf1TGu9cupbdfXmcg==
X-CSE-MsgGUID: 9Cey973ZRuu4K7rVVHbunA==
X-IronPort-AV: E=Sophos;i="6.07,175,1708412400"; 
   d="scan'208";a="21077893"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Apr 2024 08:44:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 08:44:36 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 08:44:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuyV0t3JyTS8BurB5DKhQ4ZfMTA2GM6rPqAYpt87f4zS6BbRE3zavjYHqj92FnXHz+Ub1Ac5MRr6Kig+h9uqADJj2Fq50NO99JYxGIBo179TEpyrnrWcaHpdusPqePFJpClzKtQlzGCauD+hrB3ZHSSypsd4QwlVrA7+Bhkh/Yyos4eTw3FKUyizjRW3D7Cmpvf6X6e+vUzY87r6NbGqboDZ/gUQafofGKrQltB1U6o2sxrlUsGW/GwnauJgtx+79lJg6BUt7zSp97QwUsD68e6afJJS80dmAuBN2vz8uNIy9LrzZvh5wv0E2l2GvvIv7KM56VCgYLlBHQbXZZB1Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ATPteMg78zGmhRWqCXyMrwb92MCZTP6+ehBcTMacLY=;
 b=N1uaTvVhI9UntYWPfHeEQvHKv2qdHNw9NwIspvMOf4xO/rGTmbhCheYqXKgayKZzZjxAO26cczoulVibwZeypKHGdE2lKXM2g/iWIroUOZ2UVs0MignePfNYJHs2lagTq8Am0/fz9mK6tNSRUdhT97MjJqblCpFKM/x1cKD9/aZNqvdGRSkAFQJVADJXVoC+4w/51Kd6/xtM+ZEm9o0QJveJ1nfWgWN4htGZK9et+imwLS6o/ebKyQqO/x9A5FW8FpSio43ABtzWy91BmTj2QIDHINg56mCAeuOxsM626hFdbdEW5A/S4pemzh1QKXqzdEbPPZmLGzNAKFcWeiyQnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ATPteMg78zGmhRWqCXyMrwb92MCZTP6+ehBcTMacLY=;
 b=5mCkl00gvYe8nTat0MJAPcMr00r1/pXyNgyNNvm0LzIrYAI0ZL6mKwkwO6eWbgStznTfctKbD2IgJz8H7tibqpz/vbEvHjZOPw2Tskp7tIFF0Nejaxs4LWBOlrNLPMK0jIp1ekTGULuaXRmOxTKik6AcpXRok+wzKCXsnmiSrpizxrjrJ0AZn/mRohfj7ovmnYq8YXZBvrFSjDkZ1HLv9haeqXCkZJcaOxORnXG8xbmIgVnE835BQN6nb9e91hq8Gg+8Bavdsnk8Db5yQ3DLaxdHiPcQ/vD0TYbH0Aesoj6sy4U42r2XwgA4xZyey/sTWq4DvwbagTtuGMWMs6O+KQ==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by SN7PR11MB6604.namprd11.prod.outlook.com (2603:10b6:806:270::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 2 Apr
 2024 15:44:31 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d%3]) with mapi id 15.20.7409.031; Tue, 2 Apr 2024
 15:44:31 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <kernel@pengutronix.de>, <san@skov.dk>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v1 4/8] net: dsa: microchip: ksz8: Refactor
 ksz8_r_dyn_mac_table() for readability
Thread-Topic: [PATCH net-next v1 4/8] net: dsa: microchip: ksz8: Refactor
 ksz8_r_dyn_mac_table() for readability
Thread-Index: AQHahP+qo7HmD6hSgUCB9mn13z1DTLFVH66A
Date: Tue, 2 Apr 2024 15:44:30 +0000
Message-ID: <e559c5c81e90039f17b555b66c5b3837d410c489.camel@microchip.com>
References: <20240402131339.1525330-1-o.rempel@pengutronix.de>
	 <20240402131339.1525330-5-o.rempel@pengutronix.de>
In-Reply-To: <20240402131339.1525330-5-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|SN7PR11MB6604:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r3xfuNITuTcmScWGog7JCZ7evh5Lv+oQZonk06Jd8bq/wkog4YCumVp49P11k8CzCBB5C4/Yy3q/oyZA5vC1s6PBs3Tb2cp3ATWRjbm7Ogt4wX0vS765Iy+ajbv9qB/fiCoCuEU0nzMPuM406Qq/PRmd2x5i4Zgr0Bv/gl6v+1rfYuGRAprRaKakRXB4Wr3LQb5j0zCjefli9teniiYP9WG6IuRvlrcZzHHLm9d9kFJ+23UDlAwou3fKeatYAAAeovhKlMo5bIXtsp+SVJ3oVtqVrX05Ocd2n/g+CSepJ2bzRmS1ufeBtc+uqpky4leYTwIUokOcnvk6ZPj9fdvwONZjRCFKfVtE3gdi8cclLxEhy65iKTwQm4Jnhv6yVnolX4oK2BP6YBPA+V2b63Svao7/QsthXJ13eXj4MeTE+oE4Igg3f+qwrZV/GGaeFYp4glLYPD1HwmBgLY+L56j2ijtrwfSR5wdz51+ScAOsrxPAz0gDcYZC7kHzO6mnFrskWpt70g12TEFMFpKdIDr0MSHIBGER/+edB1tT1o+LOKfSrbrmD2m5oW7DLtOrrnNNs8A16QlPL7AEEMvlaDNa11iw8/6ytfjgucJr7AqvrUournMq8FnSSu10BmYX+ywW8HNwKUFjwOsLMNc//vSjkUF1hR2XScmkQW2iStkdTo0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c0t4cTkzQjJTUTFTTTBlZ1dIMjZpVDNoYjBDRXdlSDE3aGJjbERyUWJkOFo2?=
 =?utf-8?B?LzNEWkxkS1l5U2Z1ZEVjWUhDcU01U2JHZjYzaE9WRTBvZWJ0N0F6dDlwRTdh?=
 =?utf-8?B?Sm1wMEtESTFpc1ZOblNXV3d5RXdkbExuczlvd3ZZeDRmK0FYdVczMnFWSnFR?=
 =?utf-8?B?N0J3VGF3UEdtT3B4aGhyNG0zKyt6TnU3bHRQRW5ETHdWalRUcVpvVThrejQ4?=
 =?utf-8?B?WEJzSFZhamNoMnJmeFhXMXpzVGZKcXpkcndubkNnbldTUGt5aHgxMzVaT2xR?=
 =?utf-8?B?czFVUW9wMUxkdXpTUDN1Q044VDZ0Z0syT1Mxekp2WVBCVzBwdG1lWVg4MDZJ?=
 =?utf-8?B?dVNxZk8vVldVanlsY0FqRlJUSXRPQ2w3am5OTVcxN0YrVzhQOGpva1psZ0t6?=
 =?utf-8?B?VFhwcFU2MUVDZHVqQ1ROVGJ6QnhScVlwMEdtTi8xZFlHVUpiR3FEbmlvYWtq?=
 =?utf-8?B?MXQvMWplT1lXUFZLTCtXV2Z6UTN4dWpwbUZHWHJkYXNxT1BWZERwbTdQRVNp?=
 =?utf-8?B?Q1dGbEJoZmdqWW5LVFNhWGd6NmZEZ1YwcVpPOU9xeGdNcE4xTjNlNlB4VlBZ?=
 =?utf-8?B?aVdPTitxZEhaMVdMb1o0MEZHWXZ2TEJCaEljR2EzMXJFeWVoSUl3eWlmTGFV?=
 =?utf-8?B?NlN2VTJxbTFTTUNHMlpwcVNtWVJPYjYySlJ3b1ZFSTdKS04yTmFkaFZMMVk3?=
 =?utf-8?B?R1lacktaSjVCZThxSjBONkxlOTNmTmlWN2JhNXRFcmo0OHIzbThUU1ZWSHNF?=
 =?utf-8?B?QkVNZmJxMEExbHBGQXk5Q2tRb2ZsM3dvYk1kaUNVNC9ZQVhoaHE5aXdFZEtE?=
 =?utf-8?B?bDcvcmEzQ0h4SkVPUEhhUlcwNnQrR0o2RUYvSWN0dGZuRjcweU51dkRzYUR4?=
 =?utf-8?B?aUc2TENvSjFPRENDMHNGYkY0OVd0NGw5NlBBNk9Xa3RvaGdlaXBKNE1JVFVm?=
 =?utf-8?B?cm0xNi90MFFXT3c0cS9rd2ErVmltUk1HRjY2dDliOGZxT20reWtFT1IxZnZJ?=
 =?utf-8?B?Znh0QUdiQzNFcmVRQVA2MFlQbjBBc1FIVHJ6RUxIWnRPOXhnbm40aTF0YjR4?=
 =?utf-8?B?NzdOZEZSZ3hEL3Job0JEUiszZFY0ckxhS0ppYW5YL2psNG9xQkczSjVaQU1v?=
 =?utf-8?B?d1p0MGFVS2x6a0wwZzlNYzNsaWc2RmVBVUVOZHhNU2w3UUVNZHlXRnVFT1RZ?=
 =?utf-8?B?TmgxYkYyTy8vVXR3bWh1T1JiZWRMZUt3YmFDVXlYb0ZnNVZYOVlsMUFmSzJ3?=
 =?utf-8?B?UE0wSnk0WGhhTUxGWEdBQ3k4QW5heW8xOWZ1VzE3ckpWYm8vazFwUXNHQksz?=
 =?utf-8?B?dWtoZmtiOWNGcHpoYy9PZ2VIMWx4Z3F3REFHUmgvcmJlR1lmY1EyMUlzODQr?=
 =?utf-8?B?NDMwMDBNQ0xkUy8rY0xaOTZ0OWJLSjBpR3pTU1F5L053bm8vclY4QUdmbGQy?=
 =?utf-8?B?NmZOL3dacWJ1eG00RkNBVU1EeTg0K1d3b25FbFRBdXlaSExWZTd1QU5mWnRW?=
 =?utf-8?B?TzdPcjhCV0VKekpIZ085a0wycFk5Ymc4REdVTkp4QXk5bWVWQnh4d2FuL2tD?=
 =?utf-8?B?ckNRbElheXo3aFRJQVFra1l1SHdaRnZGUGR5b3JOVmk0UlJ5NmhSNXBobXNV?=
 =?utf-8?B?Ry9HTUhKd05nOVh0YXp2YVVqcXNNaGZjQkJRVGJMYVkvMXdZaGZYeVd1TGRh?=
 =?utf-8?B?YnVjblhJOC9VNk1FTHVhcjNFU3JZMEg4QUtXdU11UThURmZKVUU0RUVQMUF5?=
 =?utf-8?B?YUxWd3BEdDVJZHlsRUFxVjQvRlMyUnFMS0VtV1JxVHBPRFpvc0ZWWDRHMWlQ?=
 =?utf-8?B?cjh4SzF5d2RBaUQ0TTZzL09ja0pkbUhya0d4OVlVZ0RBL3JRTi9YRC9nY1E4?=
 =?utf-8?B?bUxJdmsrZ2F3eWJwTC8wQ2FDSmlJdVF3bXhzNjFENVg4MTJzVEpBNkVDeFBE?=
 =?utf-8?B?bWE2QktDZHVIcmhSL0lUSFhoN2tQbm43dVdxT3A0Sko5b1BweCtzYVd6YUh3?=
 =?utf-8?B?bFI0M3dVUHM2YzRUMFR0akhSSmFJWmF5aHdjMTdUR285MDRUZ3dqS1JxaUZq?=
 =?utf-8?B?OVVmVnN1RGR3S1FFNzZXUFNuQ2tITkRnczU1cmFEaVpMUi9laEd1T2ZTdGRs?=
 =?utf-8?B?RW1ieTUxK25wVFhGMkdhUFJsaG1kQzBKenpTWlpxdjFyM1piNzlKenJPSUY3?=
 =?utf-8?Q?CE8n0+gnnG3uhCRthdS+TPM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <39EA3F623EA1714A9D2CD05FACC5BD3C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a816c20-fcff-4ce7-a968-08dc532bc993
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 15:44:31.0166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UX+dv5W1LYP8aDK9AanDa2vabaEpkFO7sZ0fnk4LtdeBYssvodu7UdwSzWLgzm5zvBy3QJ58HwvPRhKp5DQAnNDBFBOWxnoQ9Jnnsw70V+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6604

SGkgT2xla3NpaiwNCg0KT24gVHVlLCAyMDI0LTA0LTAyIGF0IDE1OjEzICswMjAwLCBPbGVrc2lq
IFJlbXBlbCB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+
IA0KPiBNb3ZlIHRoZSBjb2RlIG91dCBvZiBhIGxvbmcgaWYgc3RhdGVtZW50IHNjb3BlIGluDQo+
IGtzejhfcl9keW5fbWFjX3RhYmxlKCkNCj4gdG8gaW1wcm92ZSBjb2RlIHJlYWRhYmlsaXR5Lg0K
PiANCj4gU2lnbmVkLW9mZi1ieTogT2xla3NpaiBSZW1wZWwgPG8ucmVtcGVsQHBlbmd1dHJvbml4
LmRlPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAva3N6ODc5NS5jIHwgNjAg
KysrKysrKysrKysrKysrLS0tLS0tLS0tLQ0KPiAtLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMzEg
aW5zZXJ0aW9ucygrKSwgMjkgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy9uZXQvZHNhL21pY3JvY2hpcC9rc3o4Nzk1LmMNCj4gYi9kcml2ZXJzL25ldC9kc2EvbWljcm9j
aGlwL2tzejg3OTUuYw0KPiBpbmRleCBiNzBhYTJjMGE4NWVjLi4xOTYyMTk1ZTE2YTZmIDEwMDY0
NA0KPiAtLS0gYS9kcml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2tzejg3OTUuYw0KPiArKysgYi9k
cml2ZXJzL25ldC9kc2EvbWljcm9jaGlwL2tzejg3OTUuYw0KPiBAQCAtNDE2LDcgKzQxNiw5IEBA
IHN0YXRpYyBpbnQga3N6OF9yX2R5bl9tYWNfdGFibGUoc3RydWN0IGtzel9kZXZpY2UNCj4gKmRl
diwgdTE2IGFkZHIsIHU4ICptYWNfYWRkciwNCj4gICAgICAgICBjb25zdCB1MzIgKm1hc2tzOw0K
PiAgICAgICAgIGNvbnN0IHUxNiAqcmVnczsNCj4gICAgICAgICB1MTYgY3RybF9hZGRyOw0KPiAr
ICAgICAgIHU2NCBidWYgPSAwOw0KPiAgICAgICAgIHU4IGRhdGE7DQo+ICsgICAgICAgaW50IGNu
dDsNCj4gICAgICAgICBpbnQgcmM7DQoNCklmIHJjIGlzIGluaXRpYWxpemVkIHdpdGggMCwgd2Ug
ZG9uJ3QgbmVlZCB0byBhc3NpZ24gcmMgPSAwIGluIHRoZQ0Kc3VjY2VzcyBwYXRoLg0KDQpCdXQg
b3RoZXJ3aXNlDQpBY2tlZC1ieTogQXJ1biBSYW1hZG9zcyA8YXJ1bi5yYW1hZG9zc0BtaWNyb2No
aXAuY29tPg0KDQo+IA0KPiAgICAgICAgIHNoaWZ0cyA9IGRldi0+aW5mby0+c2hpZnRzOw0KPiBA
QCAtNDMyLDM4ICs0MzQsMzggQEAgc3RhdGljIGludCBrc3o4X3JfZHluX21hY190YWJsZShzdHJ1
Y3QNCj4ga3N6X2RldmljZSAqZGV2LCB1MTYgYWRkciwgdTggKm1hY19hZGRyLA0KPiAgICAgICAg
IGlmIChyYyA9PSAtRUFHQUlOKSB7DQo+ICAgICAgICAgICAgICAgICBpZiAoYWRkciA9PSAwKQ0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAqZW50cmllcyA9IDA7DQo+ICsgICAgICAgICAgICAg
ICBnb3RvIHVubG9ja19hbHU7DQo+ICAgICAgICAgfSBlbHNlIGlmIChyYyA9PSAtRU5YSU8pIHsN
Cj4gICAgICAgICAgICAgICAgICplbnRyaWVzID0gMDsNCj4gLSAgICAgICAvKiBBdCBsZWFzdCBv
bmUgdmFsaWQgZW50cnkgaW4gdGhlIHRhYmxlLiAqLw0KPiAtICAgICAgIH0gZWxzZSB7DQo+IC0g
ICAgICAgICAgICAgICB1NjQgYnVmID0gMDsNCj4gLSAgICAgICAgICAgICAgIGludCBjbnQ7DQo+
IC0NCj4gLSAgICAgICAgICAgICAgIGtzel9yZWFkNjQoZGV2LCByZWdzW1JFR19JTkRfREFUQV9I
SV0sICZidWYpOw0KPiAtICAgICAgICAgICAgICAgZGF0YV9oaSA9ICh1MzIpKGJ1ZiA+PiAzMik7
DQo+IC0gICAgICAgICAgICAgICBkYXRhX2xvID0gKHUzMilidWY7DQo+IC0NCj4gLSAgICAgICAg
ICAgICAgIC8qIENoZWNrIG91dCBob3cgbWFueSB2YWxpZCBlbnRyeSBpbiB0aGUgdGFibGUuICov
DQo+IC0gICAgICAgICAgICAgICBjbnQgPSBkYXRhICYgbWFza3NbRFlOQU1JQ19NQUNfVEFCTEVf
RU5UUklFU19IXTsNCj4gLSAgICAgICAgICAgICAgIGNudCA8PD0gc2hpZnRzW0RZTkFNSUNfTUFD
X0VOVFJJRVNfSF07DQo+IC0gICAgICAgICAgICAgICBjbnQgfD0gKGRhdGFfaGkgJiBtYXNrc1tE
WU5BTUlDX01BQ19UQUJMRV9FTlRSSUVTXSkNCj4gPj4NCj4gLSAgICAgICAgICAgICAgICAgICAg
ICAgc2hpZnRzW0RZTkFNSUNfTUFDX0VOVFJJRVNdOw0KPiAtICAgICAgICAgICAgICAgKmVudHJp
ZXMgPSBjbnQgKyAxOw0KPiAtDQo+IC0gICAgICAgICAgICAgICAqZmlkID0gKGRhdGFfaGkgJiBt
YXNrc1tEWU5BTUlDX01BQ19UQUJMRV9GSURdKSA+Pg0KPiAtICAgICAgICAgICAgICAgICAgICAg
ICBzaGlmdHNbRFlOQU1JQ19NQUNfRklEXTsNCj4gLSAgICAgICAgICAgICAgICpzcmNfcG9ydCA9
IChkYXRhX2hpICYNCj4gbWFza3NbRFlOQU1JQ19NQUNfVEFCTEVfU1JDX1BPUlRdKSA+Pg0KPiAt
ICAgICAgICAgICAgICAgICAgICAgICBzaGlmdHNbRFlOQU1JQ19NQUNfU1JDX1BPUlRdOw0KPiAt
DQo+IC0gICAgICAgICAgICAgICBtYWNfYWRkcls1XSA9ICh1OClkYXRhX2xvOw0KPiAtICAgICAg
ICAgICAgICAgbWFjX2FkZHJbNF0gPSAodTgpKGRhdGFfbG8gPj4gOCk7DQo+IC0gICAgICAgICAg
ICAgICBtYWNfYWRkclszXSA9ICh1OCkoZGF0YV9sbyA+PiAxNik7DQo+IC0gICAgICAgICAgICAg
ICBtYWNfYWRkclsyXSA9ICh1OCkoZGF0YV9sbyA+PiAyNCk7DQo+IC0NCj4gLSAgICAgICAgICAg
ICAgIG1hY19hZGRyWzFdID0gKHU4KWRhdGFfaGk7DQo+IC0gICAgICAgICAgICAgICBtYWNfYWRk
clswXSA9ICh1OCkoZGF0YV9oaSA+PiA4KTsNCj4gLSAgICAgICAgICAgICAgIHJjID0gMDsNCj4g
KyAgICAgICAgICAgICAgIGdvdG8gdW5sb2NrX2FsdTsNCj4gICAgICAgICB9DQo+ICsNCj4gKyAg
ICAgICBrc3pfcmVhZDY0KGRldiwgcmVnc1tSRUdfSU5EX0RBVEFfSEldLCAmYnVmKTsNCj4gKyAg
ICAgICBkYXRhX2hpID0gKHUzMikoYnVmID4+IDMyKTsNCj4gKyAgICAgICBkYXRhX2xvID0gKHUz
MilidWY7DQo+ICsNCj4gKyAgICAgICAvKiBDaGVjayBvdXQgaG93IG1hbnkgdmFsaWQgZW50cnkg
aW4gdGhlIHRhYmxlLiAqLw0KPiArICAgICAgIGNudCA9IGRhdGEgJiBtYXNrc1tEWU5BTUlDX01B
Q19UQUJMRV9FTlRSSUVTX0hdOw0KPiArICAgICAgIGNudCA8PD0gc2hpZnRzW0RZTkFNSUNfTUFD
X0VOVFJJRVNfSF07DQo+ICsgICAgICAgY250IHw9IChkYXRhX2hpICYgbWFza3NbRFlOQU1JQ19N
QUNfVEFCTEVfRU5UUklFU10pID4+DQo+ICsgICAgICAgICAgICAgICBzaGlmdHNbRFlOQU1JQ19N
QUNfRU5UUklFU107DQo+ICsgICAgICAgKmVudHJpZXMgPSBjbnQgKyAxOw0KPiArDQo+ICsgICAg
ICAgKmZpZCA9IChkYXRhX2hpICYgbWFza3NbRFlOQU1JQ19NQUNfVEFCTEVfRklEXSkgPj4NCj4g
KyAgICAgICAgICAgICAgIHNoaWZ0c1tEWU5BTUlDX01BQ19GSURdOw0KPiArICAgICAgICpzcmNf
cG9ydCA9IChkYXRhX2hpICYgbWFza3NbRFlOQU1JQ19NQUNfVEFCTEVfU1JDX1BPUlRdKSA+Pg0K
PiArICAgICAgICAgICAgICAgc2hpZnRzW0RZTkFNSUNfTUFDX1NSQ19QT1JUXTsNCj4gKw0KPiAr
ICAgICAgIG1hY19hZGRyWzVdID0gKHU4KWRhdGFfbG87DQo+ICsgICAgICAgbWFjX2FkZHJbNF0g
PSAodTgpKGRhdGFfbG8gPj4gOCk7DQo+ICsgICAgICAgbWFjX2FkZHJbM10gPSAodTgpKGRhdGFf
bG8gPj4gMTYpOw0KPiArICAgICAgIG1hY19hZGRyWzJdID0gKHU4KShkYXRhX2xvID4+IDI0KTsN
Cj4gKw0KPiArICAgICAgIG1hY19hZGRyWzFdID0gKHU4KWRhdGFfaGk7DQo+ICsgICAgICAgbWFj
X2FkZHJbMF0gPSAodTgpKGRhdGFfaGkgPj4gOCk7DQo+ICsgICAgICAgcmMgPSAwOw0KPiArDQo+
ICt1bmxvY2tfYWx1Og0KPiAgICAgICAgIG11dGV4X3VubG9jaygmZGV2LT5hbHVfbXV0ZXgpOw0K
PiANCj4gICAgICAgICByZXR1cm4gcmM7DQo+IC0tDQo+IDIuMzkuMg0KPiANCg==

