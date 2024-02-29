Return-Path: <linux-kernel+bounces-86352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B85E386C44E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 09:55:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3962D1F26720
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 08:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2DEA55C1D;
	Thu, 29 Feb 2024 08:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zntpuhBB";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ayNVoUoL"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CF154FA9;
	Thu, 29 Feb 2024 08:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709196938; cv=fail; b=FKmLHrmJIy+rbn+cmRBJWnkMP8mkazH3R7RMY4not/1DwdFG5XmspkY5Q73COIT0TIK8CW36q6p6r1mMhOq1jGhqq++XGZNKQYZ/yz2NbybIsNTmPAsoARzzFsv32Vg2DhDm9Q8ZwBjdyDP9232RRZdJ/TMuXZjQYizBmoFbmHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709196938; c=relaxed/simple;
	bh=+waadFx1VTu1DA9Gb4IDZa01N5JRWVEVdcJy7IWL4TY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bDLAtBxJeQHqayjbDgwA4WqCA9v7hhC9Rbbv37Cd8TPDDBeD7AGoesbNiNYcJ2p4JnttDoJ8aSHuhbpOvnxjRJLQOcsqxaWbiYeJL8fuYbQWPfova8AcWZgvIxDdLCfTgQP9i+snT61PZTR4ly4P6nDVLSG8PPVwsfO89GtiufY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zntpuhBB; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ayNVoUoL; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709196936; x=1740732936;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=+waadFx1VTu1DA9Gb4IDZa01N5JRWVEVdcJy7IWL4TY=;
  b=zntpuhBBp1E6ALT//R0/G+yla8/nffC12y92YiFU4X+jpOoT3pIjZMpB
   eOid4MhTzXGpoag01GAGzen+sVDslVh/xesaqnBgaFKV6Q0WpTShkiQ2g
   HWr/Wt8rHU3//0IGGxJ0L5rXoKlKsIWvYTPUWSlLeJ78DW0OvOvamDDP6
   JaZJdh+WL7zeZwwGB957iwBvUwSse2WmOxeUVN9w8zA0xX5ZN1kZVMMsS
   +W7DDWHgi7Lype8nHUH9g8YWKhdHUjnderH7g3MO6ptvNk77fvbUk3Aa8
   IaqVrXV+/DCpqSCDPoPsRBr3oCoOyvbUc8y+BA9nW9NWoXaKyRibdtqvv
   Q==;
X-CSE-ConnectionGUID: 5bdFyTMaTXyfg+TtmkWY6Q==
X-CSE-MsgGUID: oFENGAbPQ0uLG1mSEofqtw==
X-IronPort-AV: E=Sophos;i="6.06,192,1705388400"; 
   d="scan'208";a="17532723"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 29 Feb 2024 01:55:34 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 29 Feb 2024 01:55:13 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 29 Feb 2024 01:55:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGK/hmklzlPr9//JsRvx8ZUYJb0CrhdafjwaAxSH8rXoxBXSC0TgzGOAy1Iw864ivomTbccNr3ONFKtxwDp6o9uZaSizz1iGFUeWc9rQ3zGKuTFUW9258RfOw51vnfkCGBnwQCgGzTwUcV3M26yoGFOm0E3Er/48t+AhTA5P4lB9DDIaaE0mYgigEtXQeClzTuYloA+evX8DkByUgL/L9okZqIu0mqGWr0HTF1XlAVvIYiufTQeIL6cydkATlKjQ/awSF+3OVFeD3B8E/CQhepzmdOaWR0PuEjHKymJIaUJ4H75gn7b7iOesX4OWYWxVzTiNAKekMxFji78MTRwCqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+waadFx1VTu1DA9Gb4IDZa01N5JRWVEVdcJy7IWL4TY=;
 b=FvIfoJPR/s6lMYEbPhyWBSsOYkFe3wT0GVjzTHfNaN1Nm3CwlHxSjj6s4zs7qTdJLCTwSIIfbZNtZ0HSwMMWuZFVMHBkXwkFu7a1FICah2Sr7uSuP51ipwRNsfwIZMd1GbUFQx2xHf6kLXesDFh+B5OdIjviV9unwZzt0pScUUbikXKKGI2dsTJajwxy0f+JKwpUKBY+lohUCUis6Y7pnMTr0gzSpm61TQ2vPnzlQTDMHFzKQHUu0cG50ECtdtSe7jm94PlMUTNYDa9HYukiplLNdifVkbXd5qOEQAuOXRC0jUuh4JSuda6ASkXvfTdrz3kVyYNmHdZEccRMqWSkBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+waadFx1VTu1DA9Gb4IDZa01N5JRWVEVdcJy7IWL4TY=;
 b=ayNVoUoLTUf1+u7Nf5LDYegFOVjf+N3o+CR9w/bYIlfwckt/vO4Udo+oMC+SfwXEtPiIUYGIu7eAGpN6sCTLCLz9hwnb3hjuarFuInFUBzN4wrh7fSDWNEw9MtpDMg73Ca6/ury6nqJzzZf7YRytbcwMuKIAiJOShD0gLFTZzcKDw6qyIyyzn3MLfcZFJmRCqFMiGh60hZSqpaBuAjGYopz59u8jAPnehZovONJl02wcBhiHjwIC8FkOx6chnamqC7RLuReJKT5/0cFabs81M1phs95qF6Dzn95g9i3hNWr3iWSTcN2rI1oFpYQVi9WEQRVexpVH2cdvoRfUVXl3iA==
Received: from SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17)
 by IA1PR11MB7319.namprd11.prod.outlook.com (2603:10b6:208:425::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.12; Thu, 29 Feb
 2024 08:55:11 +0000
Received: from SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::f65f:f05e:4faf:4433]) by SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::f65f:f05e:4faf:4433%4]) with mapi id 15.20.7339.024; Thu, 29 Feb 2024
 08:55:11 +0000
From: <Varshini.Rajendran@microchip.com>
To: <conor@kernel.org>
CC: <radu_nicolae.pirea@upb.ro>, <richard.genoud@gmail.com>,
	<gregkh@linuxfoundation.org>, <jirislaby@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux-kernel@vger.kernel.org>,
	<linux-spi@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v4 12/39] dt-bindings: serial: atmel,at91-usart: add
 compatible for sam9x7.
Thread-Topic: [PATCH v4 12/39] dt-bindings: serial: atmel,at91-usart: add
 compatible for sam9x7.
Thread-Index: AQHaZn14iyGqXAZ1bkm2FnuRR0qAfbEZ68sAgAVvkYCAAFAXAIABYZeA
Date: Thu, 29 Feb 2024 08:55:11 +0000
Message-ID: <16e37a0e-74d0-4632-b0a2-403f74a3a379@microchip.com>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172559.672142-1-varshini.rajendran@microchip.com>
 <20240224-kimono-stress-898eae80abd3@spud>
 <b49572d4-b52e-4655-8d10-2709e2fbe803@microchip.com>
 <20240228-capital-nickname-696dfcd655de@spud>
In-Reply-To: <20240228-capital-nickname-696dfcd655de@spud>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR11MB4719:EE_|IA1PR11MB7319:EE_
x-ms-office365-filtering-correlation-id: cdee4a1e-6ba1-4848-faf7-08dc3904237e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U1hsysBjwRk5kr0EhW0HoA0n94B8ISOlAjD4nLpV58qcmukEEO8Xxq6QRrYcVirxcnm1qf5cLuTAsKlFx6JxGSUw4TWhhLUKoFDwhCBNZhbbwWb8O3YXk6uJmrUstgzj3/oMgjlfnMONYGO35HMXu3bMyoaxqxw9p+XLNUjUVFDU+oY6Yq1lHe7DTTJ/Iabau5zaWtop3WrqkY1ohnvwcQO/SVV+qOGfRX6hjhJ8mYwzpFnc0eG6+Ei9u5GWUUJ8FsDQL5EIUkixLlAA4m3ezo16B2urqNNvzHA6dmPHsHp2R3yhYQdwmjuiLbaJyhwIKcdiuL7agjeLNc+EtQog0NwPSCIR/a2ZlGPFx0NfvgDSoGOrwjsjDWWzsZ+3RnGb1h7HiOK71TGFOgI23XIj7M1Bi7+QbgXwp6D4OATQEwWjj2RQZNnZGocwKutXK36jFhAiDdky91AU0WLwdPdUtP6DqATuhoZ1DS9QneRG12JLrwGSa2/lP4V8e9WsDJPGejpTMsoRfFLTrZRIVbBPN+nshm26lbSWXqD0iP7V5Y7JdMSIvFKjpKQ0d6AAFOJCjfWBhhVX1+6M6m7LRomOzIYgFyu2jhYryZTEnk9c4ZMpHA8C+RTxFRGjJNdVp+kfJLHsc4ajR6QPlH9QGnW6jaci0Ie6cjJL+ZK4sFFjNo/OTuaabrU+GT78fEifzrkT1enMLdlVCLED7+raFwURrw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4719.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dVd0YTlsajBOQlNWM3NIOWwxZ0haNTJXRTZ2Vi9hYlQ3cjlvK0ZnWGxlMTVU?=
 =?utf-8?B?c0dlWXV1YnUweisrZ0VoOFliU05EZUdpMWFySitIaUFhVDZhWmtBaGg2L2tJ?=
 =?utf-8?B?UHlleVJLZzZPUm8wVXNEY3pUSEpyK1VKYTdwVzg4NmQvTVJRblByZzZNZTBh?=
 =?utf-8?B?QW9jc2t2NnBNaWRFakxqY0w2bmNoVzllSUQ1a0c2TUlMNWtoOG92OEtjNnRr?=
 =?utf-8?B?OVhYK0RpRDFJUCthYU1uN3AyNXo2eGdQQkd2UmpNMVBIZ1RTQzU2bEp2TVhK?=
 =?utf-8?B?OGllMXVtRXJFVUNQT1ZWL1ZsMXlpSzRNdG9KOU1HajhWMkwrNTRmNHZaSHdS?=
 =?utf-8?B?VGR6eUk5MnR3d2xkMGZxWG51U0lycFY5UE56ZWh6MytTZCt0d1hKOEpMeTVP?=
 =?utf-8?B?OThzTEw4TnQvOGF4a3Q4VXMrTC91ZXdtWVp2b1RtNk1rVnZGM3J2SnRkbjQz?=
 =?utf-8?B?RGQ5RkVnTURPZ2Evb2lkU2NTR3pabm1QL0NUc093bnlhbEhIclNLdUJoK3pG?=
 =?utf-8?B?WHFEd2V5WCt0cFNKc3dyeUV4TEhxVE00QTlkNVJoQVlyY0RkWlV3VWJNcitL?=
 =?utf-8?B?NEk4VFh0ODc2Mk9wSGRsVG9CSVZJK2NHUjFLNjM2a3BVYkQwZkVPYjEzTlJo?=
 =?utf-8?B?aDNNWW02c0JFNlRZSTI5VE4zeGUvbnA4MklPNXV2cFFxYzJPRG0vbEEwN0g1?=
 =?utf-8?B?QUEwV1Z0QlF1b20zRDZQUE54VlZtNE9hakJXVTRubHMxUzA4VUJsTkdId1Ra?=
 =?utf-8?B?WlJwNzAvKzRkMkFkTUdERjFodjd4Y2grYjJnRUl3KzJqR2FMWkNyK2UxTjdR?=
 =?utf-8?B?eStDNUgzVER6akQ0RFJjK3RGQUdXV3Bnb1M0b3NNUC9UMG5EWXYwbG5RNXY2?=
 =?utf-8?B?QUdHVHFrSnBPSUExVkZ3QUhBM2ZlR1ZQQzR5bFNCU1dtYTBDUExKZVo5czlz?=
 =?utf-8?B?OUNpbkEzeFcySVhhQkVZemZWc3BqZ09wbnpuWEhWWGNySWhvT1l4TVZPQ2RO?=
 =?utf-8?B?L244MWFITHp6ZHNIWXkra1NzMTRmNVcxT1F0dEJDc3NLMmZIWWZQcDdWcTNR?=
 =?utf-8?B?VWxNMHd6dTFsYVhyZTJlMUpqQVRYVnkzNU9aY1dDMVd2UHMybkNaTEh5VUIx?=
 =?utf-8?B?YklBL0djMEZyeWdUYnF3aG5scGFOR3ExVlRRS0xvSitoRmdsNEh4NjU3ZGpj?=
 =?utf-8?B?VnZCaVRTSTFFWHhCeHBiWVZ5aW81b2I1aVFuSVI0aDViOHJWVkVXbzhZcDdE?=
 =?utf-8?B?RjlOZXBWZWdKeFlKMWhQaDRSc3lRQzRiaExqS3lNT2tGNGZmR0wyYVZwTnFn?=
 =?utf-8?B?NFRzSmdGbmxNS2d5WFBJMXVTb3FMNHJyWUtGTHNLdGxMV0VnQkR5U1hzbTA5?=
 =?utf-8?B?NzRxZjBzRUJyM0lMREtqR0NnTXc1aXJNcHBOdW1xelpTNVhjVHBrYXFCRXdT?=
 =?utf-8?B?RVJ6RFc0WjlaVmdDM2VBdDU4SlNPSXlTMzd2WTdOZlFkRVNRaXkvSFV1Mk90?=
 =?utf-8?B?WmRWWVVDVVYya1cyTHpPem1TaWlyMnpLWHJKZE9SdncrcTd6cUMzUFArSndh?=
 =?utf-8?B?elF5aTdMVTZUN0QxRisvYXFEQkVKMGF4NExoRGxpakxRV1g2M0ZrNDRldkgz?=
 =?utf-8?B?aXpOWS9IZG04Ri9RRXdYbmhLd1FkUFpLbXdtcDZ2ano2OHZsazhUWFAxV21Y?=
 =?utf-8?B?VVVWQmMxdnhDQTlGcTB1WmFaMk9nRE96YnZ0WGphN0U2c3NMNU9ZVFNRckJH?=
 =?utf-8?B?a3FGbFQ4Syt4Mzg0dkoxYXlJaVhaT04ycndHVmxGTnFYK2t2Z3RxVDNxejdo?=
 =?utf-8?B?SEl3MldNZmxxcko2KzZ4RW5VNUZWQlhYUUJSZHdFeGh4TS8wQmgvOFh1bEFs?=
 =?utf-8?B?b25qelcvcnY4cEY0M3gwbXRBWjNPTzlVSEtKaXlNbE5rOGpGSDhuMWdGNmlP?=
 =?utf-8?B?V01JMWcwR1ZMNGFIclBlcTZJNy8yc0FhMDRpYkt5YXZ4SzRURE5IMEVhZUg1?=
 =?utf-8?B?TXJZeWpLSXIvN0NKVXRoSDh0U0lOVEdsVWxPQ3FHSnE5VnQrNnRVbkZqWEdU?=
 =?utf-8?B?NmxiV0V0UFRQT1FubUV6WkJDbTdUbDJYeWtZUEFsSHBWdEY3bjdFdnk1dkc3?=
 =?utf-8?B?QWg4TnVGWlgvTERuZ0FtYTdNNzlGOC9qRXkzeFZCU2pZdWtrQ0tzeG1uNGwv?=
 =?utf-8?B?ZVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0D7573CECE1DE74D97D21C9F0CA66D15@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4719.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdee4a1e-6ba1-4848-faf7-08dc3904237e
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Feb 2024 08:55:11.7867
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mCtBQCEukZ9E3zVWMqyKblZKX87Fcix5II32SfuUWC4X4CmDYttlQOafwN+p5Mi+CM54PiIasuagK4D99Qd2IZTGYZa5Q1NjNBWAS1rhppzpod7+JrtT6xURH3E/haaY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7319

SGkgQ29ub3IsDQoNCk9uIDI4LzAyLzI0IDU6MTkgcG0sIENvbm9yIERvb2xleSB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IE9uIFdlZCwgRmViIDI4LCAyMDI0
IGF0IDA3OjAzOjAxQU0gKzAwMDAsIFZhcnNoaW5pLlJhamVuZHJhbkBtaWNyb2NoaXAuY29tIHdy
b3RlOg0KPj4gSGkgQ29ub3IsDQo+Pg0KPj4gT24gMjUvMDIvMjQgMTozMiBhbSwgQ29ub3IgRG9v
bGV5IHdyb3RlOg0KPj4+IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4+IE9u
IEZyaSwgRmViIDIzLCAyMDI0IGF0IDEwOjU1OjU5UE0gKzA1MzAsIFZhcnNoaW5pIFJhamVuZHJh
biB3cm90ZToNCj4+Pj4gQWRkIHNhbTl4NyBjb21wYXRpYmxlIHRvIERUIGJpbmRpbmdzIGRvY3Vt
ZW50YXRpb24uDQo+Pj4+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IFZhcnNoaW5pIFJhamVuZHJhbiA8
dmFyc2hpbmkucmFqZW5kcmFuQG1pY3JvY2hpcC5jb20+DQo+Pj4+IC0tLQ0KPj4+PiBDaGFuZ2Vz
IGluIHY0Og0KPj4+PiAtIEZpeGVkIHRoZSB3cm9uZyBhZGRpdGlvbiBvZiBjb21wYXRpYmxlDQo+
Pj4+IC0gQWRkZWQgZnVydGhlciBjb21wYXRpYmxlcyB0aGF0IGFyZSBwb3NzaWJsZSBjb3JyZWN0
IChhcyBwZXIgRFQpDQo+Pj4+IC0tLQ0KPj4+PiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvc2Vy
aWFsL2F0bWVsLGF0OTEtdXNhcnQueWFtbCB8IDEyICsrKysrKysrKy0tLQ0KPj4+PiAgMSBmaWxl
IGNoYW5nZWQsIDkgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+Pj4NCj4+Pj4gZGlm
ZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvYXRtZWws
YXQ5MS11c2FydC55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Nlcmlh
bC9hdG1lbCxhdDkxLXVzYXJ0LnlhbWwNCj4+Pj4gaW5kZXggNjVjYjJlNWM1ZWVlLi4zMGFmNTM3
ZThlODEgMTAwNjQ0DQo+Pj4+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9zZXJpYWwvYXRtZWwsYXQ5MS11c2FydC55YW1sDQo+Pj4+ICsrKyBiL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvYXRtZWwsYXQ5MS11c2FydC55YW1sDQo+Pj4+IEBA
IC0yMywxMSArMjMsMTcgQEAgcHJvcGVydGllczoNCj4+Pj4gICAgICAgICAgICAtIGNvbnN0OiBh
dG1lbCxhdDkxc2FtOTI2MC1kYmd1DQo+Pj4+ICAgICAgICAgICAgLSBjb25zdDogYXRtZWwsYXQ5
MXNhbTkyNjAtdXNhcnQNCj4+Pj4gICAgICAgIC0gaXRlbXM6DQo+Pj4+IC0gICAgICAgICAgLSBj
b25zdDogbWljcm9jaGlwLHNhbTl4NjAtdXNhcnQNCj4+Pj4gKyAgICAgICAgICAtIGVudW06DQo+
Pj4+ICsgICAgICAgICAgICAgIC0gbWljcm9jaGlwLHNhbTl4NjAtdXNhcnQNCj4+Pj4gKyAgICAg
ICAgICAgICAgLSBtaWNyb2NoaXAsc2FtOXg3LXVzYXJ0DQo+Pj4+ICAgICAgICAgICAgLSBjb25z
dDogYXRtZWwsYXQ5MXNhbTkyNjAtdXNhcnQNCj4+Pj4gICAgICAgIC0gaXRlbXM6DQo+Pj4+IC0g
ICAgICAgICAgLSBjb25zdDogbWljcm9jaGlwLHNhbTl4NjAtZGJndQ0KPj4+PiAtICAgICAgICAg
IC0gY29uc3Q6IG1pY3JvY2hpcCxzYW05eDYwLXVzYXJ0DQo+Pj4+ICsgICAgICAgICAgLSBlbnVt
Og0KPj4+PiArICAgICAgICAgICAgICAtIG1pY3JvY2hpcCxzYW05eDYwLWRiZ3UNCj4+Pj4gKyAg
ICAgICAgICAgICAgLSBtaWNyb2NoaXAsc2FtOXg3LWRiZ3UNCj4+Pg0KPj4+PiArICAgICAgICAg
IC0gZW51bToNCj4+Pj4gKyAgICAgICAgICAgICAgLSBtaWNyb2NoaXAsc2FtOXg2MC11c2FydA0K
Pj4+PiArICAgICAgICAgICAgICAtIG1pY3JvY2hpcCxzYW05eDctdXNhcnQNCj4+Pg0KPj4+IFRo
aXMgZG9lc24ndCBtYWtlIHNlbnNlIC0gdGhpcyBlbnVtIHNob3VsZCBiZSBhIGNvbnN0Lg0KPj4+
IEkgZG9uJ3QgcmVhbGx5IHVuZGVyc3RhbmQgdGhlIGlkZWEgYmVoaW5kIG9mIHRoZSBvcmlnaW5h
bCBiaW5kaW5nIGhlcmUgdGhhdA0KPj4+IGFsbG93ZWQ6DQo+Pj4gIm1pY3JvY2hpcCxzYW05eDYw
LWRiZ3UiLCAibWljcm9jaGlwLHNhbTl4NjAtdXNhcnQiLCAiYXRtZWwsYXQ5MXNhbTkyNjAtZGJn
dSIsICJhdG1lbCxhdDkxc2FtOTI2MC11c2FydCINCj4+Pg0KPj4+IFNwZWNpZmljYWxseSwgSSBk
b24ndCBnZXQgdGhlIHB1cnBvc2Ugb2YgdGhlICJtaWNyb2NoaXAsc2FtOXg2MC11c2FydCIuDQo+
Pj4gRWl0aGVyIG1ha2UgaXQNCj4+PiAgICAgICAtIGl0ZW1zOg0KPj4+ICAgICAgICAgICAtIGVu
dW06DQo+Pj4gICAgICAgICAgICAgICAtIG1pY3JvY2hpcCxzYW05eDYwLWRiZ3UNCj4+PiAgICAg
ICAgICAgICAgIC0gbWljcm9jaGlwLHNhbTl4Ny1kYmd1DQo+Pj4gICAgICAgICAgIC0gY29uc3Q6
IG1pY3JvY2hpcCxzYW05eDYwLXVzYXJ0DQo+Pj4gICAgICAgICAgIC0gY29uc3Q6IGF0bWVsLGF0
OTFzYW05MjYwLWRiZ3UNCj4+PiAgICAgICAgICAgLSBjb25zdDogYXRtZWwsYXQ5MXNhbTkyNjAt
dXNhcnQNCj4+PiBvciBhZGQNCj4+PiAgICAgICAtIGl0ZW1zOg0KPj4+ICAgICAgICAgICAtIGNv
bnN0OiBtaWNyb2NoaXAsc2FtOXg2MC1kYmd1DQo+Pj4gICAgICAgICAgIC0gY29uc3Q6IGF0bWVs
LGF0OTFzYW05MjYwLWRiZ3UNCj4+PiAgICAgICAgICAgLSBjb25zdDogYXRtZWwsYXQ5MXNhbTky
NjAtdXNhcnQNCj4+PiBvciBleHBsYWluIGV4YWN0bHkgd2h5IHRoaXMgbmVlZHMgdG8gYmUNCj4+
PiAiY2hpcGEtZGdidSIsICJjaGlwYS11c2FydCIsICJjaGlwYi1kYmd1IiwgImNoaXBiLWRiZ3Ui
DQo+PiBUaGUgY29tcGF0aWJsZSBoYXMgdG8gYmUgImNoaXBhLXVzYXJ0IiwgImNoaXBiLXVzYXJ0
IiwgImNoaXBhLWRiZ3UiLCANCj4+ICJjaGlwYi1kYmd1IiBmb3IgdGhlIGRldmljZSB0byB3b3Jr
IGFzIGEgZGVidWcgY29uc29sZSBvdmVyIFVBUlQNCj4+IHdoZXIgdGhlIGNoaXBhLTxwZXJpcGg+
IGlzIHRoZSBkZXZpY2Ugc3BlY2lmaWMgY29tcGF0aWJsZQ0KPj4gYW5kIHRoZSBjaGlwYi08cGVy
aXBoPiBpcyB0aGUgZmFsbGJhY2sgY29tcGF0aWJsZSB0aGF0IHRoZSBkcml2ZXIgDQo+PiBhY3R1
YWxseSB1c2VzLg0KPiANCj4gVGhpcyBleGFtcGxlcyB3aHkgeW91IGhhdmUgIm1pY3JvY2hpcCxz
YW05eDYwLWRiZ3UiLCAiYXRtZWwsYXQ5MXNhbTkyNjAtZGJndSINCj4gYW5kICJhdG1lbCxhdDkx
c2FtOTI2MC11c2FydCIuDQo+IEl0IGRvZXMgbm90IGV4cGxhaW4gIm1pY3JvY2hpcCxzYW05eDYw
LXVzYXJ0IiB0aG91Z2gsIEkgZG9uJ3Qgc2VlIHdoYXQNCj4gcHVycG9zZSB0aGF0IHNlcnZlcy4g
SWYgdXNlZCBhcyBhIGRlYnVnIHVhcnQsIHlvdSBmYWxsIGJhY2sgdG8gdGhlDQo+IHNhbTkyNjAg
ZGVidWcgdWFydCBjb21wYXRpYmxlIGFuZCBpZiBub3QgeW91IGZhbGwgYmFjayB0byB0aGUgc2Ft
OTI2MA0KPiB1c2FydCBjb21wYXRpYmxlLg0KPiANCkhlcmUsIGlmIGl0IGlzIG5vdCB1c2VkIGFz
IGRlYnVnIHVhcnQgaXQgaGFzIHRvIGZhbGxiYWNrIHRvIHRoZSBkZWZhdWx0IA0KdXNhcnQgY29t
cGF0aWJsZSB3aGljaCBpbiB0aGlzIGNhc2Ugc2hvdWxkIGhhdmUgYSBkZXZpY2Ugc3BlY2lmaWMg
DQpjb21wYXRpYmxlIHRvbyByaWdodD8NCg0KVGhlIGNvbW1vbiB1c2FydCBjb21wYXRpYmxlIGxv
b2tzIGFzIGZvbGxvd3MsDQoNCiAgICAgY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsc2FtOXg2MC11
c2FydCIsICJhdG1lbCxhdDkxc2FtOTI2MC11c2FydCI7DQoNCm1lYW5pbmcgdGhlIDFzdCBvbmUg
aXMgdGhlIGRldmljZSBzcGVjaWZpYyB1c2FydCBjb21wYXRpYmxlIGFuZCB0aGUgMm5kIA0Kb25l
IGlzIHRoZSBmYWxsYmFjayBjb21wYXRpYmxlIHdoaWNoIHRoZSBkcml2ZXIgYWN0dWFsbHkgc3Vw
cG9ydHMuDQoNClRoZSBkZWJ1ZyB1YXJ0IGxvb2tzIGFzIGZvbGxvd3MsDQoNCmNvbXBhdGlibGUg
PSAibWljcm9jaGlwLHNhbTl4NjAtZGJndSIsICJhdG1lbCxhdDkxc2FtOTI2MC1kYmd1IiwgDQoi
bWljcm9jaGlwLHNhbTl4NjAtdXNhcnQiLCAiYXRtZWwsYXQ5MXNhbTkyNjAtdXNhcnQiOw0KDQpJ
biB0aGlzIGNhc2UsIHRoZXJlIGlzIGEgZGV2aWNlIHNwZWNpZmljIGRlYnVnIHVhcnQgY29tcGF0
aWJsZSwgYSANCmZhbGxiYWNrIHRvdCBoZSBkZWJ1ZyB1YXJ0IGNvbXBhdGlibGUgYW5kIGFzIHlv
dSBzYWlkIGlmIG5vdCB1c2VkIGFzIGEgDQpkZWJ1ZyB1YXJ0IGl0IHNob3VsZCBmYWxsYmFjayBh
bmQgd29yayBhcyBhIG5vcm1hbCB1YXJ0IGRldmljZSB3aGljaCBoYXMgDQpib3RoIGEgZGV2aWNl
IHNwZWNpZmljIGNvbXBhdGlibGUgYW5kIGEgZmFsbGJhY2sgdG8gd29yay4NCg0KSW4gY2FzZSB0
aGUgZGV2aWNlIHNwZWNpZmljIGNvbXBhdGlibGUgaXMgc3VwcG9ydGVkIHdpdGggc29tZSBvdGhl
ciANCmZlYXR1cmVzIGluIHRoZSBkcml2ZXIgaW4gdGhlIGZ1dHVyZSwgdGhlIGRlYnVnIHVhcnQg
YWxzbyBzaG91bGQgZ2V0IGl0cyANCnBlcmsuIERvZXMgdGhpcyBtYWtlIHNlbnNlPw0KDQoNCj4g
SW4gYWRkaXRpb24sIHRoZSBjdXJyZW50IHNldHVwIGltcGxpZXMgdGhhdCBzYW05eDYwIHVzYXJ0
IHN1cHBvcnRzIGFsbA0KPiB0aGUgZmVhdHVyZXMgdGhhdCB0aGUgc2FtOTI2MCBkZWJ1ZyB1c2Fy
dCBkb2VzLiBJIGRvdWJ0IHRoYXQgdGhhdCBpcw0KPiB0cnVlLg0KPiANCj4gVGhhbmtzLA0KPiBD
b25vci4NCg0KLS0gDQpUaGFua3MgYW5kIFJlZ2FyZHMsDQpWYXJzaGluaSBSYWplbmRyYW4uDQoN
Cg==

