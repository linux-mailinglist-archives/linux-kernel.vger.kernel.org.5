Return-Path: <linux-kernel+bounces-135641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A67689C910
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EFE11C21DF9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 15:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED70E1422B6;
	Mon,  8 Apr 2024 15:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="O4sqrbRy";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="14AWppvU"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358C11420D3;
	Mon,  8 Apr 2024 15:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712591678; cv=fail; b=fZshA4qJOXQBfMZs/Y3E9+mwf2dEiVwfY7vPrnMNCeFzc8sU3r1Bfs9fSo5W/f/vWczrASlvPyubZzp5pmcOv2ocIjvGgPg3Df6srOKPSFAgUQSgrN6zwmaqqnUyZvVq+YcMsJLyOyHBFPC2g/yIldWDqQbGEOzzwqZJMaSJKSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712591678; c=relaxed/simple;
	bh=DOeen7WH1IE/YCqtaLTqKHZbeMcAp54wIRWcPg9aAA8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lBf8wp+wkJ7GWZb7o4N+tqYKkrqB2GU3eVLCcBvgg2ltO/+Ay0/wxq2yMo1WCRAZrhp2vQsu0MkPTRUyI0r+0oAWkrYKrsREI0TromFUv+UYbA+I6sj3UnEQSUtQXXjNIcU49Lz9Et/6/04OjTKtmLarrRcfABybTHlbjHBrSHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=O4sqrbRy; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=14AWppvU; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712591676; x=1744127676;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=DOeen7WH1IE/YCqtaLTqKHZbeMcAp54wIRWcPg9aAA8=;
  b=O4sqrbRyk7zAIfijjpfzcbJes4DaKoRP4CnVt2FQ8M6Pdkie/wVxsfr5
   CbGRAWKlEZNqfPR0ArqP+ZFGGpkPRVWqH+EE8RNtSedWfkOLIXepZlsPL
   wLn0G+WLgft7V37Qn4Gl/hyiuGl8CojlJ5V3z0I+hEoGfIKR8Y1W87+T0
   mJwfLp9JGezPTqK5tMqqfO4guJRIY5tprkitAIsog75iNu97TWLD1RmTn
   HYG/hKoEoVLY0jxwnnmfPSUbG8TO4JAB0PrwEsL6JNWhS57yc9Zs1a6iZ
   zMzsmXcE935PXbx+7R10ZMnwT9csP+3ML54cT/O2p7uQfDXP7O5VeSgm+
   g==;
X-CSE-ConnectionGUID: bvPEYrFmQumPH2XhvEkbZA==
X-CSE-MsgGUID: aNZvXsCmTJuHif3QU2B7KQ==
X-IronPort-AV: E=Sophos;i="6.07,187,1708412400"; 
   d="scan'208";a="20039473"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Apr 2024 08:54:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 08:54:25 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 08:54:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m3WXKc8jxEIgBYfKEfqK734+c2BvL6rTfctJdSPl3KOsufW4wLIJiVjN4Rm3CJ3DPFY3R8LK+JA4OdCMn57pOp/zEQ9MVA3Umq2Hzsp+eCzbSWjsQrREpMdzVCkOc60vJpDs+lUr+GSWSsJzrxP6Cw9W6+uZfrDn8k7C61w5VtdIB0I/VqIp47ZWXNEs472ic6Ov3YEo2apN9f5MZalGVuRVY0mdL8hznw9B4SQoMefg4px4nCQY4rbctxuXkFWAA2jvIcnrZtxVeEHFn9Hq2yB1BO88fUyF6cwU/wp+dI3an58aUQC/Ea1WbFLFIe5rT3beuIqYMxE3lOs+M0J+bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DOeen7WH1IE/YCqtaLTqKHZbeMcAp54wIRWcPg9aAA8=;
 b=PBz9USonxutg5d83Cpwzy2WzChlouwjWst14jHWBncezgc0KtwQN8xJTzfrCDzjWMZIq/Gol/3T+MZfeVWH/WPaD7KvoUtF6U1bHtbOoiCWzlpmgX4tqqf0Qw+UM7J/RhuoVZ9qWbycQxVWwOgH5cTiJhjbVB8muLiKn/BC8cpJqzWfSxX3c8Aj5RRdA01H4Q9I0mRXo0Y0hV3L00jk9VBMAvND7O4/bHz2uS6R7JlitbNwZim1+dcSp4jvNYtJtYNd85notpHDR/CMQGme33PSnMR8TEpRS2wsQfrEnklfG59cjP1rT1MCQQ7i9ZrBUnp5wD3UoUBDDDRIlzH9KTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DOeen7WH1IE/YCqtaLTqKHZbeMcAp54wIRWcPg9aAA8=;
 b=14AWppvUP3L6LI2TR9ETyyET6dNSgFxXNoTV0jNobQ6SMGMSq9MCwDcWmKGYYfdz7p+K4wQFuTYCq10qDiYn9W8bWoOlTapYWteD+5KJVivObxZlhbMmpvtL+qDOStaWOoC5PtL9ZJ8Jaq4Ij76AQRGOIC0ID9nxYQZFJA56v884Kb++L1hX2Kn5tBZ6jLVXytjFiJpQyXD7Hhg/JOwirr4zeCuNP0Y8zGmQ3cS7RKkZ7iamOpMG7C66fONJdSXnDwNK7MzhAQ7DAU9N7EzM19JwDRHyUs1LWkhlF3m8HptdR8Rs4j+5gYmkT58VkjmeFgVFivOu4a/o8xUSXMie5g==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by SA0PR11MB4766.namprd11.prod.outlook.com (2603:10b6:806:92::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Mon, 8 Apr
 2024 15:54:23 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d%3]) with mapi id 15.20.7430.045; Mon, 8 Apr 2024
 15:54:23 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <kernel@pengutronix.de>, <dsahern@kernel.org>, <san@skov.dk>,
	<willemb@google.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <horms@kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v4 8/9] net: dsa: microchip: init predictable IPV
 to queue mapping for all non KSZ8xxx variants
Thread-Topic: [PATCH net-next v4 8/9] net: dsa: microchip: init predictable
 IPV to queue mapping for all non KSZ8xxx variants
Thread-Index: AQHaiYkjteT27dqtzk+Cq97wQA1vLLFeh2iA
Date: Mon, 8 Apr 2024 15:54:23 +0000
Message-ID: <10fa28b9e45b5cfa6e1176217384c57ad0df8fb1.camel@microchip.com>
References: <20240408074758.1825674-1-o.rempel@pengutronix.de>
	 <20240408074758.1825674-9-o.rempel@pengutronix.de>
In-Reply-To: <20240408074758.1825674-9-o.rempel@pengutronix.de>
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
x-microsoft-antispam-message-info: GBxHaMarih2fctOCzJqhIrrkv2Ugora3PnRGQK5qTG4twfWVOJHh1f3gJPdyuEGs4mAalST5TIAOlL76voYUBNgy0mAETHd2XlGOuWKBRLjqPTdN6TOmyR6aRjuN4wcAEUxwQ6OYQ/O+ewgSAJC83BG2zcWe9bZ+XxK/eWJKu875M41WRKB7zTGhm7FerdrS1RTh2+tmZBFWD7jQP2GBCkb4bth5gHvTXTpj50yeh5lAtx2fIAa1QroSqeMaPP2cQ8q3rwIOTH6ueiCv80LE9hd7bA+AqLcrrvytWS12You2Wy36xO/lEJ62CR09libkZrR7nQ33b+0RQBY9+GtQtDej7/fyfZjwBGqCElgoNb4DT4GcdNOIDe9VNiULh13GAHQlvNWeivnqcnOsN6tCZA2z5gqLgyCWiVASH0+hPIOQJisCZgJNwRqhcLjm2lO4TPE3NcHuJuHAq55B9pe5L153U8/c7jvpkvzKlm93WutPQZAJY6p24yw2277+dO+pcUyRSVOkUANeoFTy+x1cO4OsFoSXTLTi5Ei4ndAeYcb/v9g0TgGrBtAFbNBTk6ZkJ/f11g9g/XsWIr+dc0fpH+abGvCk1PxCwjz4vVegyb5+wy+tjft6L+tjXODXsIPRSFyItiHmjIyF5TWka2jHwS+iCmt/ios/FnMQ7hMPibg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(366007)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SitvTXdYUTk5dmVHTTlYVEdiTTBRbGhhRW1KV29ocDhJc3FvNVNXandkbFRy?=
 =?utf-8?B?SW5xdks5K2xaK2VEN1VtNkJUMktsdGZtN0lDUnJpTktPc1dlMDR1WWpFVnhj?=
 =?utf-8?B?WlZKUjFZSGlCNTBXeGdwajZyYU9ha1UxdDYwemNlemZYUUFQcUVvREE3aFBD?=
 =?utf-8?B?THZDL3VTYkdHRmQ1bFpFeFo2cHo2MVBWN3Y5QnB4TE5jcGp6NG5SVllRQlhq?=
 =?utf-8?B?NGdVWGJCdjIvS1A3V0NHWUZTTXIvdy9XK2M1ekMwRVB5WldHYVpTRGhsbzUv?=
 =?utf-8?B?c0d1T1BjVi9md0J1NmNCUWNBTktMdTRvbTNYRVQzRDJhUno5c3hWbDBXRTN2?=
 =?utf-8?B?WlZydEU0WlhTOGp6aUtZMmNHMDAyT2pxN3RXRHdaOVRpZW1rNzFWNEdHRGNE?=
 =?utf-8?B?M3VMK2dmU3FlQkxoWjJkOUdUSXdNU1FydlcwcjRwSXh2TElPcXI4cW0weE10?=
 =?utf-8?B?TkZwQ1FTa3FkK3FuZXRzWVhvUzVKT2RqZGQ2bnBadVRHRkU4cGVrSkZXNUw1?=
 =?utf-8?B?KzF5R1ZsQzN4dExuRWFqV0ZHYnR4NTVOQzVsM05rZ2FMSkJQVCtpQWo2aE80?=
 =?utf-8?B?REJSQ1RTKzhFZUZFa0dSY1pERGtOSWNJMXE5WlZXTTlBd2JpQ0RTUmJzTEp1?=
 =?utf-8?B?a1l4SXl4UDJKZU4vM2NFZlpBbnhjbGVFV0JOZVJpRThwSEpVM1Nwd2xmRXpv?=
 =?utf-8?B?QVZmWWNXb2FzWlA4ZGR6bTVoSU5GTnA1b3lFcmkxY0ZFY0hzbUhmRkhqREh6?=
 =?utf-8?B?TTF1RXB6ajZKcGk3WHFFS3BYR1BXMnJJOVJJYlpsazZxdzJwOGM3eDYyUkoy?=
 =?utf-8?B?UEtpditwY0NVYktKODl6bnhXc1o0SEZPcFA3M1BMUEpDczJkRkxvUGN4REJI?=
 =?utf-8?B?Q2swa3E3UE12bHZUdUNuOVRLV2k0ZWo1Z0FZc3ZxMGZnN0JKVTVmUG92TjhF?=
 =?utf-8?B?VS8xRnYrTFptRlJqeWZXYUdydnNiUFFVNFZ4WEp2WGZ1WExDdXp6bUpYb3N6?=
 =?utf-8?B?U3p5WVBXSlNNSXI5djQ1MXZtQ2dLNk5sdWxmK1VET21BVkVSVkJqdWhnV2dh?=
 =?utf-8?B?ZUdJUmxzSUlJbzE1WGhiWGRLRkcwWGJyRlNnRkpUTUVucHoyTTVUbTNzNmM2?=
 =?utf-8?B?ekVtWmZGczRpSWg2QVZianlHTjBwN2d5d2tWeHZWQVRkU2dCeklaTVdPWXRG?=
 =?utf-8?B?U0granNyRHB0cGJNeEFPc0xrUFJjcTBRcFA5VUdBeGFtenZrSDNDWGkwY3Jh?=
 =?utf-8?B?aVU5dzNoSWN5UW1MUGVENEF0MG1GNmZLcmlvdFlROUdUU3NRWE92OURCaWlC?=
 =?utf-8?B?bVJYdlRvYzdnbHd6dG9sTEVNYlpyOWVwRjdKNTcwdU1qeFZOWWZKdDloSjlK?=
 =?utf-8?B?aWxrdVZCek9hMDh2UFg5cVE0Z0EzSkV5NzZleXE0Uk04Wk9iL3ZlZVVsQ0ZX?=
 =?utf-8?B?c2xBSHlnejdCKzFMN1k5R3BzVjFORDlGNThtckxaSnhpQnpnWCsvV0tnQnVn?=
 =?utf-8?B?WnRxeFJOVjJ1Mm9zK2pzSU1qS0NOcjdoeFN2Q2N2NDE3OFVQT1RuYnhOQ1FL?=
 =?utf-8?B?TXdwbXdmY1F0anllaVUyS0h1S0hEWEcyd1BaVXRGbnZub01HeDJrYVcwNDJu?=
 =?utf-8?B?SU81NjlJc0MrV2lJN0pHVlJENEtadGdpRDUyMytNOVdJZURjQnhVTXhEcFFx?=
 =?utf-8?B?UW9iRjdnQUt1U1Fabmxxa1BkS2l1NWExWjJzdVo5ZkFLTkpleWFSYlFTMkxQ?=
 =?utf-8?B?M1ZWeHZhaTBwQlV6Z0thdmFQNURlSnFhYzBrTXNoYkE5aTN5VUpaNC9Yc3ZE?=
 =?utf-8?B?TTFPWHhSdmNEUVhnRWUyUUEzOXZWUG9qbWNEZW8rY0hDYzFacHdaZnh3Z3hV?=
 =?utf-8?B?dFIvQ09tdG8zZTV2WU1kdnVDUjVuR1BROFVQbWk5UXk1L2Vjb0c0RTQ3d1p0?=
 =?utf-8?B?RzJjTkE4c05aRVVvR3A1WUxzeDJRSlhmNmgyMmZmRzY1R2w2bmdnVDh0SDgr?=
 =?utf-8?B?U3hYeEd3R2JzZnVjQ05ZaUJ6SnJhSUUwWnNmSUU1Tk1zZUsyOS8wVzAxbEp1?=
 =?utf-8?B?bmVvUFlGU1JXTnNFMkFpanpiaG5NYkY1UXI3U0dWRENUQjVjRkt2UHp4Tm4y?=
 =?utf-8?B?TEpNRzU5dGFNYVRuZGYvS2tHb3RVdUFQY21aV0lraHJLZUpVbmRtNGNCR2FC?=
 =?utf-8?B?cVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF0A96A351B28A42A380D38A99FAA056@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6415787e-5194-4f49-a59d-08dc57e42930
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 15:54:23.4488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mpkFjzGXSpKZWXGkXhNdPh6unwGVGIT6n8n+Y+LS9H60lb7NmWyGMYvFAnP19l61P5NH4BO6tV/DLnc2jUa+OGMY56EoJbH9f6fT0B5q1eM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4766

T24gTW9uLCAyMDI0LTA0LTA4IGF0IDA5OjQ3ICswMjAwLCBPbGVrc2lqIFJlbXBlbCB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBJbml0IHByaW9y
aXR5IHRvIHF1ZXVlIG1hcHBpbmcgaW4gdGhlIHdheSBhcyBpdCBzaG93biBpbiBJRUVFIDgwMi4x
UQ0KPiBtYXBwaW5nIGV4YW1wbGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBPbGVrc2lqIFJlbXBl
bCA8by5yZW1wZWxAcGVuZ3V0cm9uaXguZGU+DQoNCkFja2VkLWJ5OiBBcnVuIFJhbWFkb3NzIDxh
cnVuLnJhbWFkb3NzQG1pY3JvY2hpcC5jb20+DQo=

