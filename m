Return-Path: <linux-kernel+bounces-90709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E01D28703A9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A6251F27850
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D430B3FB1E;
	Mon,  4 Mar 2024 14:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="R5cT0pc5";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="auoq/zJD"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4E43FB02;
	Mon,  4 Mar 2024 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709561301; cv=fail; b=CB7KUogF31c8nmp/pwHCxKVT76j/hrxoQtxZN1HqDYWTWI1ySwlGBvyKYe5hpQN9SDkSit8l7kv8D1eeVOfnfQGp8DrZOFq66sIkT3Xn0ALl4i8cseqZNPkVJ40ObQHVfXMAeovSX+II2JGKY3XRHwwqR4fR0ke9U24noCqM1Lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709561301; c=relaxed/simple;
	bh=D8p5HD79URqoAg04IbN1hlDKVk6MHcADGIKK3SX51pM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kgN0s8LVVRqcTVoje7nSwMOaPPKUe1h7HTJehIsZQ0JZpoLed1Xo3R8WOILm7DBd88MBoD2Qhki4Myd8IoEA1HJ9DgFbCu6nQN+IUe2f/Kqb3nqLwVZzsXlKI4Z0l0bsG7ghBwKvP0bH+1qqQRQ99LZ+tSi5fc4nxRjvh7gslu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=R5cT0pc5; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=auoq/zJD; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709561300; x=1741097300;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=D8p5HD79URqoAg04IbN1hlDKVk6MHcADGIKK3SX51pM=;
  b=R5cT0pc57p6It6G4b0nA6/l24iJkzPRvaYjAfIHBxOZib1ZVmH+j8z/2
   yHIEm/EIdJcibTUtB3QYJ6s1dyN5WyHOrsX9U+n217ulthrryPyulH/ue
   d4zh89UjoqkNYrAVuLSF4VkyKdWsWw5YDR5L8+izlXqmWO1e1TK3wcXX4
   neeL27xMdVoG8ssuLgmcyJbJGjAoOpg8uvcNdKfCSb9FK0MI5d6lImmz6
   akOWyAilAJSomYozNtrdpTQe53moHx5o4Xki+/f23FNXnDTIlufr+UwvM
   Uf6n0cxGrsd5iNIb184NZ/A+or85KvFV+Y7V2FsV/Yxj/JXjzQxQQ30Ib
   g==;
X-CSE-ConnectionGUID: BkhAZCgORTWhUz7vZVVc+g==
X-CSE-MsgGUID: H8CmFkrxTnWqrl6GqsrVtw==
X-IronPort-AV: E=Sophos;i="6.06,203,1705388400"; 
   d="scan'208";a="17168725"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Mar 2024 07:08:18 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 07:08:09 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 07:08:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3u/gG4OmVM9eoiOG4EiduhEdHj7g9WmGKIF2k5ia8yWZItZjooc02QANmpuY8OBEPpHV+lMoDKBnqennl2ncl5XLRyEosPpPPs+AS84yUk9lmKRlCscIIt66L3u2fJiDoOXupQqhNGQjuaPGVLurJZ6A1InBxLyBfcIbcq14z8hKfShGUlYMeN57fo9gNdLGzZ5ihHwUI+tLbmsojBVMdG5CsYD/4SK4CJUjh4+dtx+8pA16ml6/4rJ2fgcwvT2qh+MBj/0uTOfpAqMaQLFMHmn0tR+HR5QVh1yghT+UiRvtqMm9QtqINmOXlr9M6FDoYcB0VNngaECnWjMU9uVYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D8p5HD79URqoAg04IbN1hlDKVk6MHcADGIKK3SX51pM=;
 b=N6L3lW+T5JhKGvKbbLcBtyCWhaZS9hoRkBpkwlo06+Duh8EJqm2mazK45CynvV/XZNnJN4I4x3q+ZjsqcSPxSLd0v+ErNhLobovrwH8TFhIbHbyEvYKhaoN394mwWW526IjIwOXfmSfCasAgKTuTr4zCamUU1mBQP2gE60mMP35aULV5zZ5leziAyTWR5az+LYa7QbCB8dWOn0CkweOk8tedx1lvXmNatvL3tqSEYPCFbc8094GD//0tzwFL9N0ipWJihqZIgUrLGepht7AnRdc8+pbN9FYJ/CCgkkxzrTOn3cmuYa4x5HzmA3NWYEN5KzAP2T/Amw59ZKAz1B0nIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D8p5HD79URqoAg04IbN1hlDKVk6MHcADGIKK3SX51pM=;
 b=auoq/zJDOCJxT+y2gPFOa0dN/iaWHLqOC9Tu+fKddeMI64lfkR7KvVKvEzwu7y+6bDpEZmzo8FkEpK1hKamq7pEj/lorOkHjvbDT+mPQGnUqClvFrsZ7U1BguouMrDpwbQxFRHjlD+h3NYwgfYERKN9BVqb8hpBwy3pCnaveRUHyiiQdgKyh0B4L0oQ7EEe6Vv3qdoejAsaeR67AvCjO/16XQBjuf1Y++iDClr9vUTNyEikULACkGh+kDRYsOxrDYthSf2f+lwTIFRhmFJpVQf3OlZQYhWlzRgndVtN8pXqtQJzg6rEGN+8K0petz4kesLJrVgkno8RchH/1fyRyOw==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by MN2PR11MB4743.namprd11.prod.outlook.com (2603:10b6:208:260::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.23; Mon, 4 Mar
 2024 14:08:07 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d%3]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 14:08:07 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <linux@armlinux.org.uk>, <hkallweit1@gmail.com>,
	<wojciech.drewek@intel.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <Horatiu.Vultur@microchip.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v3 2/2] net: phy: micrel: lan8814 cable
 improvement errata
Thread-Topic: [PATCH net-next v3 2/2] net: phy: micrel: lan8814 cable
 improvement errata
Thread-Index: AQHabhS0W9OL+SOH70eH2njW1wknRLEnnucA
Date: Mon, 4 Mar 2024 14:08:07 +0000
Message-ID: <869fb04a63de027c486b660e44ca4cb87212f478.camel@microchip.com>
References: <20240304091548.1386022-1-horatiu.vultur@microchip.com>
	 <20240304091548.1386022-3-horatiu.vultur@microchip.com>
In-Reply-To: <20240304091548.1386022-3-horatiu.vultur@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|MN2PR11MB4743:EE_
x-ms-office365-filtering-correlation-id: 2894375b-6198-4711-a71b-08dc3c548467
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4c4TDk3Bwdt/pOqg2Dz3oaRHX7aMYg1cgvLZ8ISevk16kndAqvvC17jdsXXEoz+O0aBBKWqSopSN8hkOAlTrnbqxdFqMhAWt5v940syTF6R93HFDqc08bcdLjvLHECXIdUlz/Z6rGHZz15voraJ3C+Z1bRTZIjtIJHDRDN2nMVIsNa4XQMagIOoVNLJrO+Jyx6Ku9u70rMh+sLn3R24yN6FjYryPBdf250+vI6CXtka6nExX9rkFWXVr63GSG3JJj0JdHZxuPKKxldeRwfOlA1FwCqB+vZKEdXyC1iCOWLVcZvySZkpJmsE2DuQistvCekZDXT9iuOjet6Nfooj4d1RNvGG6hAW47TTIlFPQ++eoHKog3/2T5M2J+Gnmk9T3R9m84PXns1A2Rg+o8m/CTO9zu5EIo2UNuQD2tAq+jvn0md7wWDgR5ernn4S/+4Z6Rm1jQEbyWPS1HunuH/WRkSwlOaJ0ZiGV7wh1Fi8I1l2a278nyA5RA6CsOQQ1RHCMqxfqHXUJWw275EqNFPGJKoaWRYdFZDIT0KzDt67evrbixpvctnfCcFu0mkDeahQMhnVIaeOhxnGAyzqDWaarlG4xbSxIfyo7yQjUBiswBAKWfm04n7a/W+3lp/JTrDrZVhK2vKLGrMyCRdCUwMeU28Rzz5r8ra9L7+PdqKuKU6eo9EVI8Cp/vLhMB4i/ql68eVtyzqZiyWJFLzcPuFeRhA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VzdxQTdGL1VHTWM3SEFuZGxZeFdCYlI0emxObUY1SUJ0NERqT3hSQzZ3N2RM?=
 =?utf-8?B?VW5McVZoMUFibE1Id1Y4azlNdFphM3RLZWlsQzM0aU5jZFVwMXlUem52WHZl?=
 =?utf-8?B?S1JGK0NVL1FkUlBOS3BqcWxIMUViK29WSCtQbUpVVi9BQTlJZ2JrK0pVRHN6?=
 =?utf-8?B?Rm9iaWtrWlZMV0ZKalBOSTBHb3k4VXI1T3YvcS9HL1hZVzVmcFNRRk80U2FE?=
 =?utf-8?B?VkZxSHU0NTdNSEV1U0ZteUhxZVVheW9KblV1ZVFNM0hLVzg3SnEzMW02Rjhq?=
 =?utf-8?B?WDRNM0Fab1RBeHpSeS9EZDZVZEZFSWw4UkNMc0JsdTZscUw0cnJFbFRaR1ho?=
 =?utf-8?B?Q0pDKy91bk1MRU5hV0FyUGZ6NUhqSmZEZTlENlpueFR1NW51dEF3TEdSencz?=
 =?utf-8?B?cWx1QTJLWnFQblZPTEF0RS9Nc0U1VFNHT1loZUFlN2lsTGhzTWpLWmpxOWZJ?=
 =?utf-8?B?SWQyZDBxSUhFTDRhVllDN0ZzUjAwYk5RcGN0ZGxERkFEZnlZMFFzcWRuU0N2?=
 =?utf-8?B?T1lwblVld2NUUkF2Q01XaUJXT3dKb0tCOVpiZm9kaXdXOGwrREw5RThFR1FK?=
 =?utf-8?B?KzJjTkVsUHNNeDFZMDlFZm9CTkFVV2h0UitERE9IQzJ4MUxRbjJNYWNvUHlw?=
 =?utf-8?B?SVhvTlRZaVNpOHRhSTR5VnBVZTFTbUYvYm15Qk1YOVJSNXNTTnNKUXdwZmY0?=
 =?utf-8?B?UFRSamNyMVljbVlvRXZOcHNXMjRGbjFLSGdpOWlJV3lyM1lCUEVFWXNhRHcy?=
 =?utf-8?B?TjVWQjcxbDVqdTFZaGxTekRQcUpPem9xdmZlZ2FnRWFaOVBJYis3ZUtzN2RZ?=
 =?utf-8?B?M3czUENCK0NNZm9zcEFkby9BVXZ0eDNBMmdlbUxOUDlGZmJubDdlY2Jlem0v?=
 =?utf-8?B?VzgreFhuL0RLY2lFMCt4a3MwTmVadzFWSzhIdTZpLyt6bUFPRDhodWllSWZa?=
 =?utf-8?B?MzNnZU9lbmpjOE1uNzdsNm9FOWpkVE4xOW5tT2xKdXpFZFB1emJLQUcxQzJx?=
 =?utf-8?B?MzlCVS9xWVRxY2RxYWNSd0JjVFVIM0JPYjBMcU1IRnpmTU1SQjl1NE1zUU1q?=
 =?utf-8?B?UWMveDh4N0RqSmp1NmtOeCs5cDB1R2FPMHhNVXc0b1JyZ3REL0ZzeUxaV2Z0?=
 =?utf-8?B?amozWHk1MkRHaFQ4VzhWZ0pDaHZ3L09JM3JSWWtKR2V2YVc3eE5nZ2xuN09M?=
 =?utf-8?B?dDlRbEE3UG1aSnNOYTFJeEVML0FZQ0FYOUlVRVVXbzR6cHlGZkdqOGVDUlZL?=
 =?utf-8?B?UDR2d3diTW80a0xMOTNpQklYT3pyQllTd09yYTFjWXVzeWJ5OW5odkFYNFRU?=
 =?utf-8?B?V3dGSnRzYXdYQWhqRVFzblRDU2I2OWNSTWhlNUQybERIcGd6dmt4WittRWpW?=
 =?utf-8?B?UC9UNlFJaEFHM2x2ekVvLzluelhVVmJyb2d1WUg0Q2I3V3QvQmNMdUY0c1h0?=
 =?utf-8?B?eFhyZWlubWQwaUt2MWRRaWxMQlZkLzRGWTRVdTI2djBCbkpwSG9kTnVyZHdP?=
 =?utf-8?B?Y0ovdHVjZmlXcjNJUEtaS1NrWVBKT1ZOUFMvY3I1L0hKeVpiRXJXektFV0NK?=
 =?utf-8?B?SnB6aTFFWGJjS014UHdFdE5PNUdSWWhaSGQydit2VGZpMHAyWjcxRkpzcEg1?=
 =?utf-8?B?aTJwa3E5eFh3aE12d004NmR1ZUtGNjAzOGQ3YTg2S0ttUzVwTzQ5Y2IzK1FN?=
 =?utf-8?B?cDFmRVdNa0pUT2dXQUVyTERpMWNTc3AreDRyUDZsWXA2blJRbTZ1WkxCSnFG?=
 =?utf-8?B?SEFYc0lLd1hKS3dIVUZBaEtyUThKUVBmRGJqMEhQdWtYbkUyMFQ1OEhPeWVp?=
 =?utf-8?B?RFQvWU91YkRhb3QrSlVBeElYTVZUUE1iWkNyejdUWFE5VlFweGhia2Nwc0xV?=
 =?utf-8?B?dDhFS05SVHZpZFlIblJkY3RUWjRHNWYySFBrek1UbDFLTHAyNFdjMFFJamRX?=
 =?utf-8?B?Tk1iaVFjeFZlQ1dZcXJPcktKUTVKdjh5TExaWnpFZ3NwQUhOaEpYdEw0MHhP?=
 =?utf-8?B?YVUwTnVGdmtWS2taTHBxZExRRGpVRzgyY1cyOXI0bnJabTFmSG42RStVcWor?=
 =?utf-8?B?K3RQTlVHUjBtZXFTdzA3clpKais2WEw0Z3puR1dGbm1hYnBoVm9ZYk14Q3lu?=
 =?utf-8?B?YXQrSmZVQVYzRHBma3ptUWlZMjh1TExwTStsTTBqeWdJdnBlN24ybFYrQ2dB?=
 =?utf-8?B?RHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <44716BCE532DEB4C8BACBBAE0CE3D041@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2894375b-6198-4711-a71b-08dc3c548467
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 14:08:07.5507
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m7n3AtknexzOuDPT3gz0fENQ5MxaM0qtadxOL1PYSl10qpsT+SQAecxBRv89O1vL5iNNA1HMUbGOx9E34vCouPEs3+8XHAjTmXaEqrb9Pik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4743

T24gTW9uLCAyMDI0LTAzLTA0IGF0IDEwOjE1ICswMTAwLCBIb3JhdGl1IFZ1bHR1ciB3cm90ZToN
Cj4gV2hlbiB0aGUgbGVuZ3RoIG9mIHRoZSBjYWJsZSBpcyBtb3JlIHRoYW4gMTAwbSBhbmQgdGhl
IGxhbjg4MTQgaXMNCj4gY29uZmlndXJlZCB0byBydW4gaW4gMTAwMEJhc2UtVCBTbGF2ZSB0aGVu
IHRoZSByZWdpc3RlciBvZiB0aGUgZGV2aWNlDQo+IG5lZWRzIHRvIGJlIG9wdGltaXplZC4NCj4g
DQo+IFdvcmthcm91bmQgdGhpcyBieSBzZXR0aW5nIHRoZSBtZWFzdXJlIHRpbWUgdG8gYSB2YWx1
ZSBvZiAweGIuIFRoaXMNCj4gdmFsdWUgY2FuIGJlIHNldCByZWdhcmRsZXNzIG9mIHRoZSBjb25m
aWd1cmF0aW9uLg0KPiANCj4gVGhpcyBpc3N1ZSBpcyBkZXNjcmliZWQgaW4gJ0xBTjg4MTQgU2ls
aWNvbiBFcnJhdGEgYW5kIERhdGEgU2hlZXQNCj4gQ2xhcmlmaWNhdGlvbicgYW5kIGFjY29yZGlu
ZyB0byB0aGF0LCB0aGlzIHdpbGwgbm90IGJlIGNvcnJlY3RlZCBpbiBhDQo+IGZ1dHVyZSBzaWxp
Y29uIHJldmlzaW9uLg0KPiANCj4gUmV2aWV3ZWQtYnk6IFdvamNpZWNoIERyZXdlayA8d29qY2ll
Y2guZHJld2VrQGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSG9yYXRpdSBWdWx0dXIgPGhv
cmF0aXUudnVsdHVyQG1pY3JvY2hpcC5jb20+DQoNCkFja2VkLWJ5OiBBcnVuIFJhbWFkb3NzIDxh
cnVuLnJhbWFkb3NzQG1pY3JvY2hpcC5jb20+DQo=

