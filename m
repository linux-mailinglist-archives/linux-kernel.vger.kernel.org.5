Return-Path: <linux-kernel+bounces-135642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7C889C916
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F03A1C21B08
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB241422CD;
	Mon,  8 Apr 2024 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="B/4PRm6e";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="z2UnEQSf"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2201422A6;
	Mon,  8 Apr 2024 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591729; cv=fail; b=LqOWc73zLdNB7KmaJzQSYU/iHXXJPb2EVmmaoZd350dpKr3Jq3/qrTfYVGg4E5gyy7alXjW7vT3l3Lgpyjz9ZilogC7FLB4AFJs5jRqwn8y4SvYJ6ZwiHj8yQ7P8VwHbwLZ2cC97favIy/TKWxsKKJGv5aPatJp3C0pdO5IR1AE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591729; c=relaxed/simple;
	bh=gU51C1MxQ/YbvD0xXdczHdcC8fwAPMHfxca8lnl/7ns=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r1BJgNLjpnGr+5R2KkhzVrhCw2GSmzp5HjTsq7C/Jp3Y8IKkOiikj4icg6VDhH/t76BuyZHy/W9yfzE++vJbX6s/v+c1ryqLdInd625Jjp/zIGuEqTYkYY8KsXiaJOucxjCb/OFAg4m1pBKLFChO3hUow/t/15EgZjTi5h7oDMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=B/4PRm6e; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=z2UnEQSf; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712591728; x=1744127728;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=gU51C1MxQ/YbvD0xXdczHdcC8fwAPMHfxca8lnl/7ns=;
  b=B/4PRm6eSE8iKmpE2kbX7p7eW3Efa1yiR81hlYey3M5kJQ5NwVVWYf/t
   rdJ66DcswQBu7tH3n1G+9+FqTm88kRIyF3r4au4b5mtctV0z5Xyj82q0+
   wkqGY3KzV94rN6I1oUElHhHFC7Ofis1UE4pnTfJIPup2Wuh+a6/QjIBM4
   yivD+zit++IzI6TS05mFJ997//Xel36IIi2cunb70SR65o4vkRj3AUnNy
   OObeyWkVSG0rxbiSeKUrAsZ/sDeQqqVX4zlwZ7WC8IFKxSh+0EJqgD+kt
   ElbTqqHCz3dPo6AsjYK7XZZs0XJ3Qw3X5wf4dCsHlwQIWt+HBgiTsBPVA
   w==;
X-CSE-ConnectionGUID: DcvkUWtSTkeLpSaAcbP3XQ==
X-CSE-MsgGUID: IMSdbHIGT92qRFlb0/+POg==
X-IronPort-AV: E=Sophos;i="6.07,187,1708412400"; 
   d="scan'208";a="20039637"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Apr 2024 08:55:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 08:55:09 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 08:55:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jpfpi/sv/0u8Xm7XYn72zDirUu3U92X9w+0MVGeP8mNYp+GaBNK3SIv1Zbw73RW70tgBHPitp/zCojeufQY2tr17tlnDRfx2L87XvWCouIBGT47A7+6abQ/Vf0claBTDqSAhrgsy43j/74Dd+99Da7wz/5T3Xh7d5hyg7fx52RDLxV8Me8Xmm4CueXbUm86RxZvG+AV+GS3U3ckFYZnEuSZ/84kzXaN/ctkabFE46dUq3m/L8f1Ux4FRT4Ny2/COk0mXJBSU/WRXi5KsxgZz2pqxcXZEzFnp5z/7VPjZMmUPMa/ygCNpG0CxQ/YFTN/lS0IGwe83kfJYsel2LXkPnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gU51C1MxQ/YbvD0xXdczHdcC8fwAPMHfxca8lnl/7ns=;
 b=TXnn4f710rJBhdIndTjJJCHOTIZLC1jYbTXrRkQGQNgN5vC9pyF291o+5m3vZl/FDcGO0d0xAcGGhSx4WKXoNaaIII4d4NXrcs9BiVfiBJ3trE8D2Lwy4Aan6HXMXwZMVq9sEgxEyhsm6zVgGbj/Y2wSnEaeIHCej/zKzgQjHSdbyRfjsSTNidGdTQkxIp3xdPKDKql3u3kE0XaB4aTMbNDVHQlL+3UOp8r7cBpg8s6unjaTh7uWbaRrLzX4rmIwndcUm2ES0VlcFZ3q2S/5Pum5DyssKmbD81YoRCTh5gdzKLZEpp5+t+eSBZhdNCHl63AE9TgEDZh5dZCm14v9pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gU51C1MxQ/YbvD0xXdczHdcC8fwAPMHfxca8lnl/7ns=;
 b=z2UnEQSf0GmdHP6hLOyoHbcWjz+tzOPOYrMXHIuPkFeb9+BddkMFSrXGsPDKADfgQcU8ijirck80AnR7MROHap13r4f4r5LdUt+SLJVPaVkYuDbJfJlOgx3mlywAMJBmj1YEVJYdf35T3qt7exMyJG3yUhkjefjEumOlZ8Vbp3xmRQQRG1+NHeGHrLiEdVAes1CUENxuh2xXTKSTfdd2o/QryE2KUdTc5YlI7X8hFytFGYSwxmGDwXEC12t/pA5y/1Oq4hE3X0S4AwHAh10rcAfFdoF4HS49U0V0ctKw3sozoDO8vm5MNUmZn02KnvXkYFVzhp41HS8nVoRdVxPXuA==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by SA0PR11MB4766.namprd11.prod.outlook.com (2603:10b6:806:92::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Mon, 8 Apr
 2024 15:55:07 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d%3]) with mapi id 15.20.7430.045; Mon, 8 Apr 2024
 15:55:07 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <kernel@pengutronix.de>, <dsahern@kernel.org>, <san@skov.dk>,
	<willemb@google.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <horms@kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v4 9/9] net: dsa: microchip: let DCB code do PCP
 and DSCP policy configuration
Thread-Topic: [PATCH net-next v4 9/9] net: dsa: microchip: let DCB code do PCP
 and DSCP policy configuration
Thread-Index: AQHaiYk9dEFtVxX3Wky4OHP8Vjm2EbFeh5yA
Date: Mon, 8 Apr 2024 15:55:07 +0000
Message-ID: <00a1b758271bb1a38877d6c60d5071ddaae34481.camel@microchip.com>
References: <20240408074758.1825674-1-o.rempel@pengutronix.de>
	 <20240408074758.1825674-10-o.rempel@pengutronix.de>
In-Reply-To: <20240408074758.1825674-10-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|SA0PR11MB4766:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8+bGTAwvC/MmTcKKhM/+GN4VHPzKT7/Pi4nd1sNLodXV0DgKKLK0s7LPNSJUF3GxLTg/pcLIfYjCOaRW8dJT9ebwk5vZyztRUZMAbNVyC98FOd8NsLVwYk/3RJVTLLK++TwFXjlT6ukurj4Q3OccItYbXov7anHj3QVbXSCQshaXDx3d25UqeYYRRM8RpJo37GTkaoL9o8uOHavZQejxFXYEcPKvkpbGemUqZXy8NBTUXDdBARttjGmVxofJCZ2w8LO1IU7MOLiMeoufpinKv/cIJDPIoMbtKihNrFYsahTEqs4ovaqqoF/unQlGrmZ3ohdctHVovkQ+VOvdcBvz9jI0V2t/YIcU+vlc/YoWGuqIK4MuUspErmfKB1phsIICK1dl1AwAAXNzW38G15lc0DJT1CcCmjsDQcWL00Zj0J6DJ4W5w0IkF4YLNSizWiBe1l7CJ8FvA9p/9yVZbEua73BXYM8vWVmAYKU/wNCjhimBHbTF1EE966GWSVhLcc5TnowGVnFUsXEMDjIK5dq3j/5F2akIZdvJENk5O9rDl4yTSYEk7EVL2iUT6q0lw81MFdaOmTjBpgdHniVWGvu388hmOveIgAnxPkVa2zGTW68Q/n2yAj/i+LWSdjd0MlaVii8mvFFvp5fZhGkks/iJYNIA1ps8HgD8YN/7NjZmcTQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TlRaM3pwck1oYUIrWnhJVlkrUkp6bEs4Y000dCtoRVpGUTBoR3grZmZTVkZS?=
 =?utf-8?B?dUljUHpOTno0aU5oRkdTQUpNVTJudUdlSENJWWNYM1g2c2haL1ZwL0RqbUEv?=
 =?utf-8?B?ZXZTeElydjYvZ3RnZmFjVnhPMWNqdFhGbVBoeWhEeWhOcU1ZaWJnT2xLWTBr?=
 =?utf-8?B?VWhBMzlzRDNMUk10bnlUdnVNcDB2Z0pKdlc5RkpHRHFYdERob0R6OWRteG81?=
 =?utf-8?B?L0Z2WVlCTVBtQjJBT1pheW52ZTJPbWMycmRFL3NLLzU2OG45YVR0UmJrU1dE?=
 =?utf-8?B?bEl3d1VZdE1kNmV3TnZldFZwbVBKeGoyWTJIcmcxMlZtTXlxZHlsNEFTcXlu?=
 =?utf-8?B?M1NiNGpIbmdDd1c1M3RNbzkvZTRaQjFKNTVYMHRrWEZtNVZoVTZXUlN0ZVhr?=
 =?utf-8?B?NFVlV0xKYjMxSGdRRHRWaHpLZVNzSEQyVXhiV240S0libE9kQlZmK1hUN3RK?=
 =?utf-8?B?V0FEUEl3NHNKTnFjclRrSFE0MERyR2R6VjcrcWZqa3YraGhCNmNMQVpMR21B?=
 =?utf-8?B?NHRnWEJzZ2JvT1R6OXViTmZhTUM5c0RNSkpKWWJZQmU0bEEzSi9uUTlzUDlk?=
 =?utf-8?B?RXkzWUpGVHVhU1hoTTlGQ3g3TzBWWTQxNzZ1T0pHcWxPajVOVXlDMzNKdWU3?=
 =?utf-8?B?TjZCSVUzRkZleTFJSmwvZlNVRTYrZDZYRVpMNW82WXN5aHFFSTl2alRiNi95?=
 =?utf-8?B?NkJ3VE9BTGxDQ0xYaTlyblQ0dG1MZWNGQmkxUnFxQmFLVHlNU0NVVjVxTUNr?=
 =?utf-8?B?WkR6eDFkMEorYUtmTCtSRkxQWjhJeGZKS0NTcGZ6SXNvQTNxeFgrOENZNTJH?=
 =?utf-8?B?VSsvQUhBZ255eGJRNk5BYWpmQVVVc0s5cGIzdWlHVEFSaTNUV0VodWh4aDdv?=
 =?utf-8?B?ZVlZaUQxK01YcWxLdHZSWEJxNXhFRGM1dWhrS1o4dFV4blYrVk9ZY0tWZCtQ?=
 =?utf-8?B?V0tOR3BCZjVzSlU0ck5YcmZXRXFMOWdqdTFja2NNQk5MbWdnNHNrNGZVRzU0?=
 =?utf-8?B?c1RqSjRQNDRnNTNmcElTNGJudlBQNzEvdjQxTjYwVzUzNnVVd0kzYzkrMVhI?=
 =?utf-8?B?cmlvbjZoNXZhbzJXaldXOTNtcU9oakVjVzh3MEEzQk42c0ZNWlY0bnZYTUtG?=
 =?utf-8?B?QzEvT3RsRFptSHdaS1FlcXhOM290NVhkd0lsY2JEWlRUcEg0MGJpeWJaVDY4?=
 =?utf-8?B?c3VXRXNkZXRreGtscjBKUmhWK2w1eTJCd1ZWY2g5WXh3eFZ2cXVqLzY4MmxJ?=
 =?utf-8?B?VTdxemVNT0FJZkNGNjZURTJ6aHJmTHUrK1pBUlVNeU8wWXdBb3RxSUJKaDJo?=
 =?utf-8?B?aEs0N0VKalFIR09aenFUYURoM3gxRjUzakpMeVg1R1ora3pobGtSa2lmNDRW?=
 =?utf-8?B?Yi9aZmhQRkRlR25RVnZ5ZklndnZGNm5laThTNk8zbm9hb1ZwMy9JOE5IWkZt?=
 =?utf-8?B?K1pNODVLQWkzbGhLTkpFNEhCRmlYMmY1djhUSG53Z05XMnRXVytuN3Y3dCtM?=
 =?utf-8?B?bngvcmsxeDFTeVdMZERFait1SG9sQTM3UDZPbWxlUXp2TXJRRkhHcVkxZTRO?=
 =?utf-8?B?UDNCOC9RNDJVbVU5dW1LTGdFbk9lMmRFVEJ2R2ZZcDV6b254Q21yeklZSGdq?=
 =?utf-8?B?VXE2SDhjYTgzQUppeEVYRDhZVjdBN2l5RmRndEFYZU9kbnhCZWNEeGsvZHpZ?=
 =?utf-8?B?Z3MzV3gxV3FJQWVVMHU5bVVqbkNQSDhhUy9tcG54Zi94dEZub2E3dzVKSXJM?=
 =?utf-8?B?UE93MlFBVmtaRGN5N1BxTEZDSDErWlJ1SHNSTHVPSGNUTUV2a1JmRFQ3YUV0?=
 =?utf-8?B?QVVIUkRuUGluUkl2NXBxalAxOWszaVFSZlhCdFdIV2V1UXNTS0dSYWxIMmNq?=
 =?utf-8?B?ZSswRUYxNjM0NGtiWk16WkMrbHNyNG95czNKVWNSM2RZWUk4YlhlQnJQZlU1?=
 =?utf-8?B?TjZpOUtiTXZZdyt4NHN0VngrSWxaS25SUGxxcUx4T1E4N1Z2SmxPWGRyYUZ6?=
 =?utf-8?B?STZZdyswOGJDZ3BjdUVTdjhrUVBCdXdFT1c5OXhGTzZJaGEvRjFBUm1oeXJL?=
 =?utf-8?B?OS9sU205cHZLSi9rdDVLZ0hzQ1piemNRdTVyVVhLc1JXekZHV0ZFd0RzVjFs?=
 =?utf-8?B?UDNVY1c4VDI3cFBqYW9IMUlOVWYyOERVYTQ3Um0zZUwxZWFRRzBublFENElW?=
 =?utf-8?B?Mmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D53013600693234DBF9A2244A8CF142E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88627fd6-1b70-41a3-a351-08dc57e4436f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 15:55:07.4921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TMnfsi02NZ2eYQrYbhVinSqTBTGtMaDFuQvN/ODg3iL0e08ES17O7T7jqwqneeaTVGajUGU5WpKbHnxgwhHPmyrRwoP8eUFnxBWekUyS+0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4766

T24gTW9uLCAyMDI0LTA0LTA4IGF0IDA5OjQ3ICswMjAwLCBPbGVrc2lqIFJlbXBlbCB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiA4MDIuMVAgKFBD
UCkgYW5kIERpZmZTZXJ2IChEU0NQKSBhcmUgaGFuZGxlZCBub3cgYnkgRENCIGNvZGUuIExldCBp
dA0KPiBkbw0KPiBhbGwgbmVlZGVkIGluaXRpYWwgY29uZmlndXJhdGlvbi4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IE9sZWtzaWogUmVtcGVsIDxvLnJlbXBlbEBwZW5ndXRyb25peC5kZT4NCg0KQWNr
ZWQtYnk6IEFydW4gUmFtYWRvc3MgPGFydW4ucmFtYWRvc3NAbWljcm9jaGlwLmNvbT4NCg==

