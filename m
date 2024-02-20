Return-Path: <linux-kernel+bounces-72316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F99985B1EB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCC711F23286
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 04:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09BCF5644E;
	Tue, 20 Feb 2024 04:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OU+KIV/B";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HfWaEWXa"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE3545942;
	Tue, 20 Feb 2024 04:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708402984; cv=fail; b=ZexEbBs8X0my62g9wYFucBPnHi+Ve5gYqEirJIN2WgOnr8D2bbVlqX+7UA8xZwhcBaDqgGOTMGferDYhP2uEMal7QssrX54LruluRs5qWPKBoAY5DU3nF0eWChoFIILmXvhYOIeIsP6zpWTP9N7GEtlyD1hQPl0fyumZDncNM/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708402984; c=relaxed/simple;
	bh=7qAFj66+tYAuKDljdnDckpIolq8ubLId1amDNrmwQ8o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QW6mzS0Dh5wzRvXDF8DYM8UFcohz1GFxhnogk1N5KEHJHxf14oFlDZxa/tcdYQnX3PBoP3Cb0Zn0q5IiSZGprs81X29GTig9eve30qfH95IhnsF/h/PqommnVUShNYUSgwuHI0K0JgCTa9zZIxakFZ8ggKthNpFbByedLSoOIMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OU+KIV/B; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HfWaEWXa; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708402982; x=1739938982;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=7qAFj66+tYAuKDljdnDckpIolq8ubLId1amDNrmwQ8o=;
  b=OU+KIV/Baeue9bV0Br/81GRu0dNnKYDTLhqSKZZUGmQmbaG+B8OtPHYR
   rQrpSLCswTITZqhDLEMCThx8TmBoL6jKQiY5dzDlyX4yNIkPCgsnK9Lq5
   nTwotREDoDJpRjGaBb2sKpXkkT6Ywzky9qn1onD1m5xvocRuRlLEUkids
   srAk03Pza6HD6K/DqxL0+HbeFm9jPmgyxSWUagzADpjIhRTWqewtjksF2
   IyS7emVaWl+TPbjPJD1EU0AkVw3NXVRjhmnV5UVWyEGoAYn8O+eNqg2pN
   JznmIpZdTrcim3C1d4WPm2r3JeHM8jw2hzdCjduZm/sPKXtNlO43Zg97W
   w==;
X-CSE-ConnectionGUID: PPjIN4p+Sxm111Om0sbc+g==
X-CSE-MsgGUID: 9RTfaKKoQau1OvgHOC6CwQ==
X-IronPort-AV: E=Sophos;i="6.06,171,1705388400"; 
   d="scan'208";a="16501037"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Feb 2024 21:23:01 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 21:22:01 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 19 Feb 2024 21:22:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EY4Uqi3FjMAFCynJeYAu48wzO7DxDwFg+yIgT2rr6ki5A/L+x1M/jzz236dNt72BCcHsS0FAaS2MgQI2jR7ggLW5c0Kzfr9oa3z4oZf2yCkcq7tt+Hzb1rRN7VOrqOZoYZ0sulNZfDnLOxDviwurfI+ascLcW2hYq0s1KNrl7b1vyD+CySI4aNdKeiqUOCLTFq/xLvdH/07u8GFROl+pN8zEjbq2XcINzzvU9RTLctgAdcI20hkIUVcGb+aWy/0DH3GmLvKRU7yckci6PLNSaM4/BcvF/8K4tfa+IGFruWJVEAugg2ofbYY5e+I3j4CAHnRWpMTcmVq5zw2ffeyLEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qAFj66+tYAuKDljdnDckpIolq8ubLId1amDNrmwQ8o=;
 b=EoJ/3kDmptyUcJd/dW79AkFyurA7n6gbSX97G4NY3G+6zTpxuZ+jd/faRZbs8gpu5f+nm1AHN1sMl/zAVkLrVtXFFnEOOwMDO2y2Xi4zNrkewJIu5Cy8PEisT7tdMkgOF3RvjVWGmeyNU+CWIlcI3hoYCY7F9hx98QJFYmdDU1KfSOqqKi4xf881YD5U06Dubz7ZDcnWj0FLFu3N5epmGBEs4phPz4vzU3KNInTuk1o22UA7uiOMf2k+MkqGtBBqfM6G+cdPaayf7/dAXwwQpAkzb5nyMlmxFFMUFkjLvkrBf8PKYX2hj7lyI6OOn+b6hFOJfZ50HeMtELC4oFyGtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qAFj66+tYAuKDljdnDckpIolq8ubLId1amDNrmwQ8o=;
 b=HfWaEWXaPhxw0DgEfG/MWzNv8+nxHdAfumZVX5HXmw+AoHlG4eZDBXAohpCRKpvnviMVY2tGRj+c3RxKnOOpcHMjYNv+LxkLSIU9CF7kt0++eVLLvyPM7mBLh7A10Cm4ClbVBWvuQJHq7INykdas1c3rA6WlZtgElvDb/8qUjceE+Ed35X8TLYtiMk5n4tsiyxDq/1NuPyrkry5stGBUxa3phHQi3ZaeA+oapsKyRCXKPyJrStA0xAScoMtxoB1TLuCODj9Jxohu6gmCEyuCVxlyRToGpMI8dwOX/1bwWFszdQAtZR8AmMbvNJcC4PokMVXXzQV+306ZiIPXgeGE+w==
Received: from DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16)
 by PH7PR11MB8502.namprd11.prod.outlook.com (2603:10b6:510:30c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 04:21:59 +0000
Received: from DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::c243:33d7:2ff6:409b]) by DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::c243:33d7:2ff6:409b%3]) with mapi id 15.20.7292.036; Tue, 20 Feb 2024
 04:21:59 +0000
From: <Rengarajan.S@microchip.com>
To: <andriy.shevchenko@linux.intel.com>
CC: <linux-serial@vger.kernel.org>, <jirislaby@kernel.org>,
	<gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
	<Kumaravel.Thiagarajan@microchip.com>, <Tharunkumar.Pasumarthi@microchip.com>
Subject: Re: [PATCH v1 1/1] serial: 8250_pci1xxxx: Drop quirk from 8250_port
Thread-Topic: [PATCH v1 1/1] serial: 8250_pci1xxxx: Drop quirk from 8250_port
Thread-Index: AQHaX0zJptU08UpfekCFV+f1gwbHA7ELJEGAgAa8CACAAMqLAA==
Date: Tue, 20 Feb 2024 04:21:59 +0000
Message-ID: <9ae91cfc2ca24d23c5f3bc16208e5d59eccba076.camel@microchip.com>
References: <20240214135009.3299940-1-andriy.shevchenko@linux.intel.com>
	 <063a1804732c619bc4a5c801c9881fedd92ad745.camel@microchip.com>
	 <ZdN_npTcCfz0cI_g@smile.fi.intel.com>
In-Reply-To: <ZdN_npTcCfz0cI_g@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7481:EE_|PH7PR11MB8502:EE_
x-ms-office365-filtering-correlation-id: 75250541-fd46-460e-1543-08dc31cb7af2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0rpbr4b1+gKXs85JIBPOVoDP5nu5OlVdF8dTzevgYHnc1YfCwiPEjjPuVcSjHjNH9QxTaYEHs7DQxPdjmIZ0t5ram5A0gOXsVkypJHJomXOH/DctA+BEPbpsVr2WAGHrW+xig20BIS8PJqCS794fWRjexoxs4PiqpKDeS1Kmk9hdsLXk9qNX9EsDsI+EtOMVSSfZd9pWLrHP+AggGMYYaTww2yF8nrelqoYe1j+TdGosZvyylaXS0wqWpN0cTXBBovTY2HDOn6srcfXrOEE1KcsjmGDH08Ob5up0NjT8d5XCLPx7NDpsH+TDYfxxqPCxF+07V7lvojTHYkXBWOzxQJC6FRpdSNItfYeTJdk+wMssC5cN/e3VkoxgH74WigyQhOd7G38KKJJMBh5fsgr9Bh5ryDOSsC9it4MbdSml4uKiczhoN33kh204fBSo3lcEwTTfeF87BQVRfrjLBmLUZrg25QU/EE5vv5mwGm1Ea6BsuhYSUNFmJ2qPjKVpE1jhmBU4OgjZjFKihzM6VpWBcUfHxnQ1xl5Ehhuoiodmjquz8h29rZRbvIO3lnk3BmIKg1TwRyPp68tYhDFBdWFnunWRZrJldyALdXBe9yK1FtjHfEWY460NQkzyiLSfNB7Q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7481.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZGZZZUNTQytyZDdjWjUxbSt3MVlSQWpobStOV1JCRUVkZWI2NS85VElKd0Fn?=
 =?utf-8?B?QTJITEl3ZTFIK2xZNS9Yd2pOTElZaDM2V3RKT0NCR3BLcHNtcEd2Ykcxam9o?=
 =?utf-8?B?VmlFMCt6a3R5RUwzN0ZvSVRaWjl2YnBKVzEzNGVJMTcyTGhDa0l5UXQwYlNy?=
 =?utf-8?B?VnR4eHdvUk1JWHZlNmdHZ3p1eHVBbFFSaXdOVVFwN0xvZGVWWGh6M3I4Zkxy?=
 =?utf-8?B?SWNDWnMxQXdZL0xiOXN6VmMzNFpwV1pXeGJsQXFXWnd5M1Fld2JmNFM2RDUz?=
 =?utf-8?B?ZTluNXFVa1FwVUM0dXowUmVkdUV3cUZEOXNLRW1PRjNhaHBFZ2JIT3BudW5X?=
 =?utf-8?B?b2NZeE1ScG1sY2plODdhQlNLdzVqT0lucThjMXRTYU0wbU9XTEVyZXErQU4x?=
 =?utf-8?B?cEdhRE9QaXFSMlJDbXY0WDBNL3cwMmdNQXdjUkFOUTFtcGhiOGs2bU9ndE8w?=
 =?utf-8?B?QU9QVVlDMUNKTEwzTlVKbGhEcWVFTDRaTHRoZVN6QUQ3a0RnRDh0cUNXYkRw?=
 =?utf-8?B?RWs2QkY2NnBqVFpPRWgvVUdoUUpEcGhReitpK243dHZFVHBldVVlY1ZOcmhj?=
 =?utf-8?B?UE5iU2RYZ2ZycHhuaU5EM0NEL2UxeVUyWWxPc0UxanBaSllYNU5mMlhmYjdi?=
 =?utf-8?B?QVd0MnNrWWIveFRBdHFoUEZqV3BySnBYcFdhb2t1SXdGZWNsZVB4aUIxVUNV?=
 =?utf-8?B?d2VuaE9ZTDBpYmg1cm1jN1ZYeDB2WnRTeFArN1dndGZRWFg2TVRBQWZ2Nmww?=
 =?utf-8?B?WWNaRi9ESGRVaXV4d2pJV3Z0RDQ2WEIrUlpaUy9YSGdUVU1NRmtSSjhaUjRP?=
 =?utf-8?B?ZVlMRytNVmpzU1U1MTVJM29RRkp2Q2VwdlN3MjB0NHFSdUpHRE5qTFo1eU1i?=
 =?utf-8?B?QXNFSytYNm1tMnBEYWZQTytrZk5Na0lNSUlyamdyc29HMy9OVnFJWjhabEs4?=
 =?utf-8?B?RUdYa0gwcWREeU5xWXZPWWZYdTFMSEZDbkNJRnFqWEttd1hGWkh0bVY0b25J?=
 =?utf-8?B?TjhTM2VyY0o4RjIrTjRIbVZBcmg2WUo0ZG9MRzZtcUxsUVJZckVqTG9GeDRn?=
 =?utf-8?B?Ykl2RGZOZ2hSMUFYR1dhNEFnU05qNjQyTllJZHBhdWZyRzFMWmRvbTJxaU1l?=
 =?utf-8?B?dzJIZUlBa2RkZWFHWTkyVnd4UDNHcWlUazltUXBtazZZaU80bW1qWnd3WVA5?=
 =?utf-8?B?RndOeWZlbzU0U1NNdUxnWUEvb1dQK091MWpwblJHdCtUZ0NMeWFld2lCcTlE?=
 =?utf-8?B?cUkxWmJaaldGZGxqZ0hWaWN3azI5OEtWdm5wVkVEek9oNExpdkpWUFBxZU9n?=
 =?utf-8?B?eGlScWJhNnNxVkM3VmRmbEp4ajYrNGx3QkdZZDA3NVpUK202NWxwbUtzN3hj?=
 =?utf-8?B?R20xZzZsWTZNNjkyOWliVWxMZ0hORExIc2dPcTRNUGw5ZURFQ2hHeFhMSkM1?=
 =?utf-8?B?SFRVV1FudTRHUkVlUEVadkx3RmhjWENRQ0c2dWZRRGlwZWhOVDRWbVBZelp2?=
 =?utf-8?B?enlrc2hvRERoVzNQVmhEdGZ5aVFjYSswVFY0MlV6VFlXV3d2U1REWWFFNUtI?=
 =?utf-8?B?ZkRreTZSZzIxOHgzWWJmUU1rY2p2VVhMTXZhYjN1MW1jUkpxU2ZpNjR5dWtN?=
 =?utf-8?B?clNMTFh5TVlzdldzMFBLUXU3emhPMndFREdkSkw1VllpN2pKaHBoR05WOC9z?=
 =?utf-8?B?c3AraHppNllGbW1zS3NYR2dLYmlIbE1ackd2WU4yYzV4RU5xT1BPay83ZG5u?=
 =?utf-8?B?dE9FcjdiK1NFQVlCWTBsR2hjbTlHSktLWVpZYzdxdDdrdjlTNWJMQTBVVnpP?=
 =?utf-8?B?TXpIUGRHYURFWUJSeTBGbWtCWVB1NGtUWGN3Um1mS3oyY3RBeXFORUkrSDYy?=
 =?utf-8?B?VWVNQlNWVW5KMWNRbHBGNlN5cEV3U1JUaFhOOGRlR25TRGYzcXV0bk53cWsw?=
 =?utf-8?B?Y09wdDFRNFNJTWwxT04vcFp6aTJvcTFqWmRaZVNaVnQyZ3FmenpoQzNFWFh6?=
 =?utf-8?B?VUdtMlRGVFN4N2d3RkFlc3ZsUitSa0F1TDRnNFZRV01FTVdrQnlMMmRYSm9u?=
 =?utf-8?B?bkFnVmJuVithY0VKNG95VVVXMjZ3RWtHNkNqbFM5K0NYNUJ4WFVUbWNTdlBz?=
 =?utf-8?B?TGwwS2tTMDVlUmUvckdkY2lwTE4yVWNvS0RjWFZ5NlZyVHkwbWs4ZDJNUERK?=
 =?utf-8?B?dlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <97F521A4356AB4438AB6967917FAA5DA@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7481.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75250541-fd46-460e-1543-08dc31cb7af2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2024 04:21:59.0512
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vu9GBvES9Xcca8qxEbpDJ7AJIrCu61893mf1FP3mM0JFYth334f1bOxClFfmaLU4ndzk0sSAe8UOtKYfAIubdJgDNxxYgzs1KEQORGLoLaI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8502

T24gTW9uLCAyMDI0LTAyLTE5IGF0IDE4OjE5ICswMjAwLCBBbmR5IFNoZXZjaGVua28gd3JvdGU6
DQo+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50
cyB1bmxlc3MgeW91DQo+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gVGh1LCBG
ZWIgMTUsIDIwMjQgYXQgMDk6MjY6MjFBTSArMDAwMCwNCj4gUmVuZ2FyYWphbi5TQG1pY3JvY2hp
cC5jb23CoHdyb3RlOg0KPiA+IE9uIFdlZCwgMjAyNC0wMi0xNCBhdCAxNTo1MCArMDIwMCwgQW5k
eSBTaGV2Y2hlbmtvIHdyb3RlOg0KPiANCj4gLi4uDQo+IA0KPiA+ID4gK8KgwqDCoMKgwqDCoCAv
Kg0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgICogODI1MCBjb3JlIGNvbnNpZGVycyBwcmVzY2FsbGVy
IHZhbHVlIHRvIGJlIGFsd2F5cyAxNi4NCj4gPiA+ICvCoMKgwqDCoMKgwqDCoCAqIFRoZSBNQ0hQ
IHBvcnRzIHN1cHBvcnQgZG93bnNjYWxlZCBtb2RlIGFuZCBoZW5jZSB0aGUNCj4gPiA+ICvCoMKg
wqDCoMKgwqDCoCAqIGZ1bmN0aW9uYWwgVUFSVCBjbG9jayBjYW4gYmUgbG93ZXIsIGkuZS4gNjIu
NU1IeiwgdGhhbg0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgICogc29mdHdhcmUgZXhwZWN0cyBpbiBv
cmRlciB0byBzdXBwb3J0IGhpZ2hlciBiYXVkDQo+ID4gPiByYXRlcy4NCj4gPiA+ICvCoMKgwqDC
oMKgwqDCoCAqIEFzc2lnbiBoZXJlIDY0TUh6IHRvIHN1cHBvcnQgNE1icHMuDQo+ID4gPiArwqDC
oMKgwqDCoMKgwqAgKg0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgICogVGhlIHZhbHVlIGl0c2VsZiBp
cyBub3QgcmVhbGx5IHVzZWQgYW55d2hlcmUgZXhjZXB0DQo+ID4gPiBiYXVkDQo+ID4gPiArwqDC
oMKgwqDCoMKgwqAgKiByYXRlIGNhbGN1bGF0aW9ucywgc28gd2UgY2FuIG1hbmdsZSBpdCBhcyB3
ZSB3aXNoLg0KPiA+ID4gK8KgwqDCoMKgwqDCoMKgICovDQo+ID4gPiArwqDCoMKgwqDCoMKgIHBv
cnQtPnBvcnQudWFydGNsayA9IDY0ICogSFpfUEVSX01IWjsNCj4gPiANCj4gPiBBcyBwZXIgaW50
ZXJuYWwgTUNIUCBET1MsIFBDSTFYWFhYIGRyaXZlciB1c2VzIGEgc2ltcGxlIG1ldGhvZCBvZg0K
PiA+IGNvbnZlcnRpbmcgImxlZ2FjeSAxNiBiaXQgYmF1ZCByYXRlIGdlbmVyYXRvciIgdG8gYSAi
MzIgYml0DQo+ID4gZnJhY3Rpb25hbA0KPiA+IGJhdWQgcmF0ZSBnZW5lcmF0b3IiIHdoaWNoIGVu
YWJsZXMgZ2VuZXJhdGlvbiBvZiBhbiBhY2NlcHRhYmxlIGJhdWQNCj4gPiByYXRlIGZyb20gYW55
IHZhbHVhYmxlIGZyZXF1ZW5jeS4NCj4gPiANCj4gPiBUaGlzIGlzIGFwcGxpY2FibGUgb25seSB3
aGVuIHRoZSBiYXVkIGNsb2NrIHNlbGVjdGVkIGlzIDYyLjUgTUh6LA0KPiA+IHNvDQo+ID4gd2hl
biB3ZSBjb25maWd1cmUgdGhlIGJhdWQgY2xvY2sgdG8gNjQgTUh6KGFzIGFib3ZlKSB3aWxsIGl0
IGJlDQo+ID4gZG93bnNjYWxlZCB0byA2Mi41IE1IeiwgdGh1cyBzdXBwb3J0aW5nIHRoZSBhYm92
ZSBmZWF0dXJlPw0KPiANCj4gSSBzcGVjaWZpY2FsbHkgYWRkZWQgdGhlIGFib3ZlIGNvbW1lbnQu
IElmIHlvdSBsb29rIGNsb3NlciwgeW91cg0KPiBkcml2ZXIgZG9lcw0KPiBub3QgdXNlIHRoaXMg
dmFsdWUgYXQgYWxsLCB0aGUgODI1MCBwb3J0IGNvZGUgdXNlcyBpdCBpbiBzZXZlcmFsDQo+IHBs
YWNlczoNCj4gDQo+IC0gODI1MF9yc2EgY2FzZSAobm90IGFwcGxpY2FibGUgdG8geW91ciBkcml2
ZXIpDQo+IA0KPiAtIHByb2JlX2JhdWQoKSBjYWxsIChhcHBsaWNhYmxlIGlmZiB0aGUga2VybmVs
IGNvbW1hbmQgbGluZSBtaXNzZXMNCj4gdGhlDQo+IMKgIGJhdWRyYXRlLCBidXQgZXZlbiB3aXRo
b3V0IHRoaXMgcGF0Y2ggaXQncyBicm9rZW4gZm9yIHlvdXIgZHJpdmVyKQ0KPiANCj4gLSBzZXJp
YWw4MjUwX3VwZGF0ZV91YXJ0Y2xrKCkgY2FsbCAobm90IGFwcGxpY2FibGUgdG8geW91ciBkcml2
ZXIpDQo+IA0KPiAtIHNlcmlhbDgyNTBfZ2V0X2JhdWRfcmF0ZSgpIGNhbGwgKG9ubHkgdG8gZ2V0
IG1heCBhbmQgbWluIHJhbmdlOw0KPiDCoCBteSBjaGFuZ2Ugd2lsbCBoYXZlIGFuIGVmZmVjdCBv
biBtaW4gKG1heCBpcyBleGFjdGx5IHdoYXQgeW91cg0KPiDCoCBxdWlyayBpcyBkb2luZyByaWdo
dCBubyksIHNvIDYyNTAwMDAwLzE2LzY1NTM1IH49IDU5LjYsIHdoaWxlDQo+IMKgIHdpdGggbXkg
Y2hhbmdlIDY0MDAwMDAwLzE2LzY1NTM1IH49IDYxLjAsIGJ1dCBzdGFuZGFyZCBiYXVkcmF0ZQ0K
PiDCoCBoZXJlIGlzIDUwIGFuZCA3NSwgdGhlIGZvcm1lciBpc24ndCBzdXBwb3J0ZWQgYnkgdGhl
IGV4aXN0aW5nDQo+IMKgIGNvZGUgZWl0aGVyDQo+IA0KPiAtIHNlcmlhbDgyNTBfZG9fZ2V0X2Rp
dmlzb3IoKSBjYWxsIHdoZW4gbWFnaWNfbXVsdGlwbGllciBzdXBwbGllZA0KPiDCoCAobm90IGFw
cGxpY2FibGUgdG8geW91ciBkcml2ZXIpDQo+IA0KPiAtIGF1dG9jb25maWdfMTY1NTBhKCkgY2Fs
bCAobm90IGFwcGxpY2FibGUgdG8geW91ciBkcml2ZXIpDQo+IA0KPiBIb3BlIHRoaXMgY2xhcmlm
aWVzIHRoZSBjYXNlLg0KPiANCj4gT2YgY291cnNlIGlmIHlvdSBhYmxlIHRvIHRlc3QsIHdpbGwg
YmUgZXZlbiBiZXR0ZXIuDQo+IEJ1dCB3YWl0IGZvciB2MiB3aGVyZSBJIHVwZGF0ZSB3aGF0IEdy
ZWcgY2F1Z2h0Lg0KDQpUaGFua3MgZm9yIHRoZSBjbGFyaWZpY2F0aW9uIEFuZHkuIFdpbGwgc3Rh
cnQgd2l0aCB0aGUgdGVzdGluZyBhZnRlciB2Mg0KcGF0Y2guDQoNCj4gDQo+IC4uLg0KPiANCj4g
PiBBY2tlZC1ieTogUmVuZ2FyYWphbiBTIDxyZW5nYXJhamFuLnNAbWljcm9jaGlwLmNvbT4NCj4g
DQo+IFRoYW5rIHlvdSENCj4gDQo+IC0tDQo+IFdpdGggQmVzdCBSZWdhcmRzLA0KPiBBbmR5IFNo
ZXZjaGVua28NCj4gDQo+IA0KDQo=

