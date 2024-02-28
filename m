Return-Path: <linux-kernel+bounces-84760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9212886AB2A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E7FB1C22E93
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C384F36103;
	Wed, 28 Feb 2024 09:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="S6FqG+71";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="o/Ypv7Qt"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4102D05C;
	Wed, 28 Feb 2024 09:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709112525; cv=fail; b=I3m6k1lnBjNEmT3XNUzVDVe957vXzX4mTDxviWWo2b+MdbDfqGoFNd+t+sZWT1FgrV7yuroJaBxMesND8IhFM3jfbsMT9tQvZIRxuOwW5BIFmBZ3IUuVK33ug83BUq5hwZr2Kmyj0BSdarVTNLoSdb59LYfJcrY8XY6bU+32pO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709112525; c=relaxed/simple;
	bh=mTslRi4J3KzTdCxs/3O/ZppGD6cWwSrtQK+xfqA+dRs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SSmnT6wW1lcZV/Adbl8/e/ZCopxTlKAvUxjBFODqcN3QfbyEs5dhXvv+e3pp/OXYj1ZQNz/riDZT2W0iZSgnEn7opR3mLk3i+T/uJA7Znf4nAz6Jz16VuFOY10fQNtjabCy8+tJxqo5Wl7ytmfIcXUMAkfqDlwhmlXEBAlNz3N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=S6FqG+71; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=o/Ypv7Qt; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709112523; x=1740648523;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=mTslRi4J3KzTdCxs/3O/ZppGD6cWwSrtQK+xfqA+dRs=;
  b=S6FqG+71OWvb3JZ7dlSuNM7VFCrI+S0JO3cMXQ9lxLeN4TUO1E0T5tnV
   k7g9b/uC1vkeU/TQX8vNOLJXI67jQN8EtDphzxfuVDm2a5/MY4lRLlavY
   37nJSlo4VkOrFoJOy8LGiLQu4ZilbXUBpdEgPYLCeOPhHZcPhFiKxr9Ok
   72QeapivQH+xGhzqPI3O1rIRFYnATu9YhULPaDF/tQvO3nUgcRXmrjqrs
   hlS5LDfqIP5sa+1aFf6xDes4IKyTRv7OlpbexoOklXzC+vaPSua0eWlrk
   iEYgqbEstEp9PliaRP19k4DY4ZOQKvCAVRex5HDbb4A8z05rcF/B8NYa4
   A==;
X-CSE-ConnectionGUID: UHTWV0a1TDysE3T+eyCPfA==
X-CSE-MsgGUID: I4/bz+jPToyKwk7zBufhXg==
X-IronPort-AV: E=Sophos;i="6.06,190,1705388400"; 
   d="scan'208";a="18523918"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Feb 2024 02:28:41 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 02:28:39 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 28 Feb 2024 02:28:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VWStqnoxYSbWFe9saSzX78tt8k2fbAxaHrcspSDc1GlFX/dw3c5/6MZ3aYeEIPQQ3BkN2qEw9YmYHzuZen7pcPq1O2TEKvcb14H3Nqve19/RGpc6JuWRtLw8jSSxLVQThmADcjzNriI0p0Qq/Usz3jky9X33sa58Wtwjn/v2cc6lMKYMuLtv9daCzPlPwdINJKquucn8iSIj632ZtnNuz7oGndwiBkzl1YOV54a+Lcde8CVUfWFGZ8eO6Iolseg2hMts7B/E1pgxQZWmCXdC6/9ajYmj1gFLmvxbDVRpi2owRHBTHV9Hvr0SFQ5k9b+iC6Q7oQIcPC1oYz8yTSVgnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTslRi4J3KzTdCxs/3O/ZppGD6cWwSrtQK+xfqA+dRs=;
 b=lEBQUp+5TQcKtTkEL9YxrEMZ1YN6SFhkquIzilUMugD+6XXKN9KdcgwO3fd6H81T5wAzpr2ww99jqqnn4lgEOcayUrEr35GtFAUTroLXIQN5QsR4IegTXbHNJ28lW8md8WTSBa7rARGeP3ZVWWTDVArVSyYapcJdi2V4OqqkxWh/zspB9YM8Q7+S1Z6U8xce0DblkdIogi2hmBF/ShApfk1QlQAFnH8/BxJU5t1ZzMzNGKcGO7IafWbPGT1Bb9T0fnk2FLBstX17zJn9GE/6G3z03ijLnzbQMt4OCmgAQfOsdqKZJ+SYPiv1IfJj1W+GX88fmXn8Mny13mqNpgDFIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTslRi4J3KzTdCxs/3O/ZppGD6cWwSrtQK+xfqA+dRs=;
 b=o/Ypv7Qt95EUP2lhQUKYsrJoksw+HPNWuD5AQquQYi4df2zq9tKjDeEYDdOdSvpEXXaZ/BObZ3j/QMTEs792bo7OeZernDbMMCDnhRKKHhWhi1hlLusW8fu+m/ACKLcaQjGgT+B17ui3XPFj9kU4Izi4B9cWCJCFaIyIlspo6cIDu2/qWpZfqF/kLYVtsLFpYnY+3pvAR09ceV/fT22+cG3jqjCV7mtRQet455m4RkUz8a1iSUsEpUAG7xuKM8Psv8Kr2uZWaQSEN7DHnQbSsZMsYVpsqSCOGVt8TyhxnJIb/CqIVNzGsi7C39/fkE+liaDauI2SuxfjmOI9+xY6JA==
Received: from SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17)
 by IA0PR11MB7936.namprd11.prod.outlook.com (2603:10b6:208:3dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.26; Wed, 28 Feb
 2024 09:28:37 +0000
Received: from SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::f65f:f05e:4faf:4433]) by SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::f65f:f05e:4faf:4433%4]) with mapi id 15.20.7339.024; Wed, 28 Feb 2024
 09:28:37 +0000
From: <Varshini.Rajendran@microchip.com>
To: <tudor.ambarus@linaro.org>, <broonie@kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux-spi@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 16/39] spi: dt-bindings: atmel,at91rm9200-spi: remove
 9x60 compatible from list
Thread-Topic: [PATCH v4 16/39] spi: dt-bindings: atmel,at91rm9200-spi: remove
 9x60 compatible from list
Thread-Index: AQHaZn2FbTCyBgC4WkWdEC0ep2K0s7EcWiWAgAMp5YA=
Date: Wed, 28 Feb 2024 09:28:37 +0000
Message-ID: <98fedd3f-b55d-4ad1-b2ca-1efef0a19505@microchip.com>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172638.672366-1-varshini.rajendran@microchip.com>
 <19da0e57-379b-4db3-ba8e-db7efe336e15@linaro.org>
In-Reply-To: <19da0e57-379b-4db3-ba8e-db7efe336e15@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR11MB4719:EE_|IA0PR11MB7936:EE_
x-ms-office365-filtering-correlation-id: f7373a14-1aa3-4b35-383d-08dc383fa462
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nchnrFlgoAXCgH3ym/QI7tSlYIzr+kR/Gbge+8zbF0ODQFoGbm00ALsYgTgYssqEW8FliTvfZEI079CF11m7/UJT/AGf8APoJlCRxhzlzluPw+FtzrfaEjNk9ssjbftHPlFU2GXgbFeQIjEPgImLLWAGypGzmXqr/Atz0Q2x9YrKtYjTRSfyohoHv7wIv6BIauhnnNGgQoadOMRl5hZBN4zHS3f+3rm7Hn0axQTQK+Ux2Q9R2t/kFTR2bXBHmqVQw6RvMp6Stenps9vA76VfzJxnVk5V2ivJ0WB+Y9zZ96jR10ZXdLMQlRLRTlDi+o+SDnfQrnzuSdTocQEPGGngpGOYGOA5JQwr52yPGHI8MSrD+YXfY3GTekftO/XpuIOFdLZgLeXBwJ5QsTzJcHtM1LSWMAjmYA9/KJ1xQuhMC5jeFiuEshZYD811FibAoZIzM5Vnv46QZHi6WWeMMjoPJwwgIa93OBk/+FL/T2MDvb57FFxPvVGxNP7TFN50zR5tTwCqAlkgyigiZ6tx8YATu+oaQuJbWoVHSftOTziyXYbf+FxDqKUmJaCQNgE/KxXQ7rqy5SLL/13Tiv6I3kadXxtLKfxNQojs5F5e+Z2Avt//vIorv9BTVPalxq6qAeGpCCtq6waVsG6ZeS5OScGe+4k91FcDEA4jzfOxMGYnRXtYVZEQChkf5VbZq4uhkk2ToZYH0pu/aDPO4NUqykpNtfUXwIGybNyL+I8KY//ufFs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4719.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009)(921011);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVVFeGFOaVU0c3M3ZHVkV3NWeDZZQ3p3STNZWitlOFNsNUZtTHRUSmwzRk96?=
 =?utf-8?B?Q0ZqRC9nV3BPSE80RGNxYlNBbHlGY2x5dXloT095bExmRFZGdFhpaDBuTnZC?=
 =?utf-8?B?ZjJSbmhQZVVKYkV4a2M3eGtYM2FQaVBHNzAzeUxSMXd1VXpEREtvSWVwdUFz?=
 =?utf-8?B?NDMvK2N6WWdkQi9UR3g5MFpHUi9QdGZrL0ZMMDhQOE9GQmVlR1NwaGJ6QUtU?=
 =?utf-8?B?cFFXNCtCMElmK2tyVkRid3NWQ2NYSWVxb2ZKUHFQZkhBMDNtbDM0ZmcvWTJ1?=
 =?utf-8?B?aGRsN3pDNVZPWTYrYzd4R0JtNnBjdlo3WE9HTUhHeis4YjlnNVRHL21DbnIx?=
 =?utf-8?B?MmdodVE5aHFwa0RjV3BpaHBTREEzNWlGam5ucllQQndNakx6WmpXM053WVV5?=
 =?utf-8?B?OVN2Y0JmNGJXSU96OGxLSXE0UG1CTklOR0phb1RPNkJHSnozMm90QUtLekxM?=
 =?utf-8?B?MnpKcDNiZWJpL2xsNndReDZsNHpaTjdVY3ViaXM1TWY3QXhJN3N1NDY2cTVQ?=
 =?utf-8?B?azZTRXZVdXJzM3FhL2YyNVdBVXRDUEtTVHVEUEtRY1ZWenZld0xoYnZZWXlo?=
 =?utf-8?B?WUFwNEVjeExCaGViS3llVkVWS05LU0lsRldqb1pRYzhXVXZxbXRMcUNoWi8x?=
 =?utf-8?B?OWRyNkhtdlZUeXc5Ti80Mkg5SWdjdWtYRkVFei9WS2J6OTFQVk1vVGZVSVlX?=
 =?utf-8?B?eUNGVmRML1R3RGRSTEhwYVV2YVMwSVBrcWZGbGEyY2xITWVTcTdiYmx2MTRP?=
 =?utf-8?B?K1YzRDRIOU4yY1czQnVIMHpaQ01UKzRwNDIwSWhtL2laQTFiNm1mbzJWNU5t?=
 =?utf-8?B?M1c5Nk5Gdy9HbCtHZUFUYUFFSnNUMU1vRXBMTG8yaytVN1BjSWZ3Wjh5VzR6?=
 =?utf-8?B?dmV3Um4zVXExamwzUzVUT244SEwxemZSYjZEMkljNThmNTkvTUkxUkFlaURY?=
 =?utf-8?B?SWdhM3VNWVhYSm9OZ0lGSUtjZE43bGQ1Vng3MHI0ZkkvUEFNUGtJSHVQelVG?=
 =?utf-8?B?cU02YlNIdG0yVSs4bkp2RUxxWnF4elhDcjQ1ZU4vMUIrY3hlR3d6OTUwc1Jk?=
 =?utf-8?B?cTlMaUZ1dFhHZHNuODdSNWtuMjhDTVlhK1NXRmkxa2hSWFkwNEVQTFdDVDJn?=
 =?utf-8?B?eUh4Q0R1R3l4U01oYXBGd2RkeGhZaUlyb3BQQ1M3OS8va0RldFVyWmg2dXJv?=
 =?utf-8?B?Q1J3WTZPL2lzOWpVUjJPUnNzU1AzMEg1c2VYUndhOWIwNHpCMDFlQlI5TXEy?=
 =?utf-8?B?SzNNN3ljL3Fsbm1IdDVVTTBaMC9jTTY5UmJUWG9wdGswZ3gwQlJ6T3lKYUxJ?=
 =?utf-8?B?NitqTFRaU2hYWWQ4OXdxNGw5cGpBem5CTFVaendPTE03djZpaXFiTzVGOWo2?=
 =?utf-8?B?elpvOEtJWjRxKzBRd212dW00WmhTSE9yWk4zREdtWnZEMUZ6YVJVUlU1WmR4?=
 =?utf-8?B?V1g5dXVIVndqZVZzM0ZLczdxOVJFQ3lUY0o4RlB2cVF6OHhRdURoSHZ5UDUz?=
 =?utf-8?B?VEtadGxHT0xLVWk4N25JUkdBQzRPKzJ1UnhvTEk5RGsxS2N2NkZCTFRESUtS?=
 =?utf-8?B?bXk3a0dFL2F5VHpqMzhZN29INTRBOEhJNEM1aWdPdXJWQzJmVUNlcnhNUXlu?=
 =?utf-8?B?aGdGNkZOZHNTQnYxT1ptbmpveUJ1STBuaHdTT3A4blV0dExBNHZyZUUwcWFW?=
 =?utf-8?B?ZjRNb0RRTWVJV0NmbExYb3NTSWZWMGU2VldmeTFFQll2dnAzUkdkUTJDcjQ5?=
 =?utf-8?B?RXdFRTRyZ3BFSW1vMlpKbTAyclY5S0NINnpDUmtia3MvOC9JQ0xsZGFETWs0?=
 =?utf-8?B?ZWw2alFaSzJOb1V4TytKSlBqc09JU2RwU1F0TjUzaXZJWXRhT0lNa1hhalg0?=
 =?utf-8?B?UUVUQzJLSStnR2htbHhNZXlWdHdLVU91d0hyTlRlakNkczFQdVRuUFAxVldM?=
 =?utf-8?B?Z2tubVcwbjZuL2t4OFQxQ3AxeGF6enp1TG56RFBiaWJHaUNvY3pncE9zQXBh?=
 =?utf-8?B?SXVoZTM2alk5K1kwY3pPVmx2NUdRZlIycGhPb1p3dGVmVWRnaFNiQVV5RHRJ?=
 =?utf-8?B?cDVaZkxHSGNpT2xJUENHYlU3eUtKZ04xTzFFUDl3NFFMUmNGdS80NUN2TU5y?=
 =?utf-8?B?dFZKOUZRNTlSa2Vacmd2YjMwb2JiNzlwNy9yeHczSXFRY3lOY04raDJ2dmha?=
 =?utf-8?B?Unc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ED6F4FBDC8BD60438EAAC786BE84954A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4719.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f7373a14-1aa3-4b35-383d-08dc383fa462
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 09:28:37.1649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZSlYheFU/QRaq2jaUQlW9pV6CHIVU4fa4W0NTTdmP4J1dvnmuBCmcTb/l6u/lgEoZZ04kfjfYvC76/qJIE+sayLz6HxDT3hm2Bw9eZenljgecT99KW8TwiPj57QQCwys
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7936

SGkgVHVkb3IsDQoNCk9uIDI2LzAyLzI0IDI6MzkgcG0sIFR1ZG9yIEFtYmFydXMgd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMjMuMDIuMjAyNCAx
OToyNiwgVmFyc2hpbmkgUmFqZW5kcmFuIHdyb3RlOg0KPj4gUmVtb3ZlIG1pY3JvY2hpcCxzYW05
eDYwLXNwaSBjb21wYXRpYmxlIGZyb20gdGhlIGxpc3QgYXMgdGhlIGRyaXZlciB1c2VkDQo+PiBo
YXMgdGhlIGNvbXBhdGlibGUgYXRtZWwsYXQ5MXJtOTIwMC1zcGkgYW5kIHNhbTl4NjAgZGV2aWNl
cyBhbHNvIHVzZSB0aGUNCj4+IHNhbWUgY29tcGF0aWJsZSBhcyBmYWxsYmFjay4gU28gcmVtb3Zp
bmcgdGhlIG1pY3JvY2hpcCxzYW05eDYwLXNwaQ0KPj4gY29tcGF0aWJsZSBmcm9tIHRoZSBsaXN0
IHNpbmNlIGl0IGlzIG5vdCBuZWVkZWQuDQo+Pg0KPiANCj4gSSBmaW5kIHRoaXMgd3JvbmcuIEkg
dGhvdWdoIHdlIHNoYWxsIGFkZCBjb21wYXRpYmxlcyBmb3IgZWFjaCBTb0MuIEFyZQ0KPiB0aGUg
cmVnaXN0ZXJzIGFuZCBmaWVsZHMgdGhlIHNhbWUgZm9yIHRoZSBTUEkgSVBzIGluIHRoZXNlIDIg
U29Dcz8gRXZlbg0KPiBpZiB0aGV5IGFyZSB0aGUgc2FtZSwgYXJlIHlvdSBzdXJlIHRoZSBJUHMg
YXJlIGludGVncmF0ZWQgaW4gdGhlIHNhbWUgd2F5Pw0KDQpXaGljaCB0d28gU29DcyBhcmUgeW91
IHJlZmVycmluZyB0byA/DQpJIGFtIG5vdCByZW1vdmluZyB0aGUgZGV2aWNlIHNwZWNpZmljIGNv
bXBhdGlibGUuIEkgYW0gb25seSByZW1vdmluZyB0aGUgDQphZGRpdGlvbmFsIGZhbGxiYWNrIGNv
bXBhdGlibGUuDQoNCkFzIGluLA0KDQpjb21wYXRpYmxlID0gIm1pY3JvY2hpcCxzYW05eDctc3Bp
IiwgImF0bWVsLGF0OTFybTkyMDAtc3BpIjsNCg0KaW5zdGVhZCBvZiwNCg0KY29tcGF0aWJsZSA9
ICJtaWNyb2NoaXAsc2FtOXg3LXNwaSIsICJtaWNyb2NoaXAsc2FtOXg2MC1zcGkiLCANCiJhdG1l
bCxhdDkxcm05MjAwLXNwaSI7DQoNCmZvciB0aGUgc2FtOXg3IGRldmljZXMuDQoNCkhvcGUgdGhp
cyBpcyBjbGVhci4gSWYgSSBoYXZlIGl0IHdyb25nIHBsZWFzZSBsZXQgbWUga25vdy4NCg0KPiAN
Cj4+IFNpZ25lZC1vZmYtYnk6IFZhcnNoaW5pIFJhamVuZHJhbiA8dmFyc2hpbmkucmFqZW5kcmFu
QG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+IENoYW5nZXMgaW4gdjQ6DQo+PiAtIEVsYWJvcmF0
ZWQgdGhlIGV4cGxhbmF0aW9uIGluIHRoZSBjb21taXQgbWVzc2FnZSB0byBqdXN0aWZ5IHRoZSBw
YXRjaA0KPj4gLS0tDQo+PiAgIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkv
YXRtZWwsYXQ5MXJtOTIwMC1zcGkueWFtbCB8IDEgLQ0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBk
ZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3Mvc3BpL2F0bWVsLGF0OTFybTkyMDAtc3BpLnlhbWwgYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc3BpL2F0bWVsLGF0OTFybTkyMDAtc3BpLnlhbWwNCj4+IGluZGV4
IDU4MzY3NTg3YmZiYy4uMzJlN2MxNDAzM2MyIDEwMDY0NA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9hdG1lbCxhdDkxcm05MjAwLXNwaS55YW1sDQo+PiAr
KysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL2F0bWVsLGF0OTFybTky
MDAtc3BpLnlhbWwNCj4+IEBAIC0yMiw3ICsyMiw2IEBAIHByb3BlcnRpZXM6DQo+PiAgICAgICAg
ICAgICAtIGNvbnN0OiBhdG1lbCxhdDkxcm05MjAwLXNwaQ0KPj4gICAgICAgICAtIGl0ZW1zOg0K
Pj4gICAgICAgICAgICAgLSBjb25zdDogbWljcm9jaGlwLHNhbTl4Ny1zcGkNCj4+IC0gICAgICAg
ICAgLSBjb25zdDogbWljcm9jaGlwLHNhbTl4NjAtc3BpDQo+PiAgICAgICAgICAgICAtIGNvbnN0
OiBhdG1lbCxhdDkxcm05MjAwLXNwaQ0KPj4NCj4+ICAgICByZWc6DQoNCi0tIA0KVGhhbmtzIGFu
ZCBSZWdhcmRzLA0KVmFyc2hpbmkgUmFqZW5kcmFuLg0KDQo=

