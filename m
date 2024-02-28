Return-Path: <linux-kernel+bounces-84584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99E8586A8A9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 08:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4271C22435
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 07:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B8923746;
	Wed, 28 Feb 2024 07:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jHaj411J";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="6Kg3qrz+"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E35B2263E;
	Wed, 28 Feb 2024 07:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709103816; cv=fail; b=Tzd/w2hyfO0azCJfqqwh7iROSfFVyDTIjOki84YIv6ztaApD2xwKkLKUm45crV9KCk4bmeXUDtxGRtN9mUvlhmavApU/js/Pg9BVWopMs9fcqitaKPlwFVXLMOeqPknLD8FRB9PKumJyTjShw2R++SsJMtZb/gYj5pX6d7JGYys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709103816; c=relaxed/simple;
	bh=IELmI+aoEOyR83XahOBge0qMsWeQ+xp4xxqvocVHEjg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LcpFr43EHlCJjlEzS25DtaNcUi0/HAzBCCDrB3HidW+vnqYXFEguFXng0S90lIZzJjj+QpcOE7AMGJZRA8GKjeX+IkKYBjxBlo4L23s0l/K88IIETH09Pz92rPa1D/5emhnoAZM0GKxNKAasvsvQRr0Wfh48POUUe3BkMMelsLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jHaj411J; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=6Kg3qrz+; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709103814; x=1740639814;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=IELmI+aoEOyR83XahOBge0qMsWeQ+xp4xxqvocVHEjg=;
  b=jHaj411JD4VJykXerRP24qZ2Efoqq1XBgJq7n4m2HPibdu5+QQE6l1j7
   iZGVIiCL9mjLmPORrZXWsu1nbuIeg+QmDHSQNGI67Oud1bnP4VwgjXNEA
   IT4yPpX4Iec2jNSszJpBGS+hQn151Vu4dJ0Ma9ZmUO4ZTjOZLc8PjdwVQ
   fMUFaTJMQ1e/aYTOsr9QBSLqmKCIEQuocCMFgZumww9tITBEieOeX+IY0
   HbdqRjVEcnv+bAchyoWqwpmey9b0t2glKvh1QX9puZutzyT2CxgTcobC5
   DKwYo5de/DI1KZw/GaJQWH2jZEcVccqvajxIdT3TdiFgaCQn8rM0JwD5G
   w==;
X-CSE-ConnectionGUID: spAPJmjJT+etFHBotITZJQ==
X-CSE-MsgGUID: JSI7Ym8xQ2W+YhDbt0PMcg==
X-IronPort-AV: E=Sophos;i="6.06,190,1705388400"; 
   d="scan'208";a="18517744"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 28 Feb 2024 00:03:33 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 00:03:02 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 28 Feb 2024 00:03:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6wc3GaPGfxuHLG7ChniIiyE76Yvt2rCERtY5on3WiSlJI/qrnI5OZDDsMv71tLYf5+N2P7wPMG4NsEKkIjx6TNnnDeTX+4ZUotG6u7xAukgfjtRDrmF/6clcW9/TJ0nN/ETDTBz9FNmQsc6iqUoPl5lRrphBP6qu5kabepzCIgTmUzInBgKuGClrVp6FqgjfkD3v4JUgreYCPcKWgAZLIh88vZLhumWgmIr2eXVMfAJP86GrUqCY86zFYz6JPLSPpEw5t6yc4BguuUf70bFQkdh0tW/lz7I11Mu64Wft6QZw6Deng5Z2pfbxk7WPyxBDNrbXqliImjYH4JHWKITLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IELmI+aoEOyR83XahOBge0qMsWeQ+xp4xxqvocVHEjg=;
 b=gvDPi1hXIMVJucwIyCxxmqHNfV7VpZ4BrQdp9eLZVVN6O6ebAIaA2ls58LdUjZd6N9JTbYwG6oDkCC04m0E/VtfyDcXht2z7zsP+VwoeqtK6TKzw5vM5ftWpvVz7Rs3tf3amvBRSUHw8hgKMZzYROGedrtyDBxBsujINXV38bM8UUggbHLLUG5mKqw5EO2H4fDQgai99wdFBKCSezPclRDZ60FAC3uNPtZQXHsHN5+CfticJurQ6FWyFrXzEt7nhfIk0rTYrfZcBCNrluhUmFX+mgiblwqmNf4UhJPRSw6TFXuhtR7kaQ3yceu4W/C+KqrVoh91Hd70aieYg9dKfyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IELmI+aoEOyR83XahOBge0qMsWeQ+xp4xxqvocVHEjg=;
 b=6Kg3qrz+bNPFmHdCO5/FRSFB/AcmQrKMgaK/T/1KgbcAKALjSQeYLONN5n4UOrZb7Al05UhGA7esHWcJ5Ojrqf8pZ/X1Pl0SkJMg0J036u7dFbaGOsomDAGe0amkMEFVODy3TIdIXswA+wLjjSjutNWB/iIYDhgtN/OT8q0rR8fK/R/s3ihiSdf2RSWsEwN8BZkOdtNakxG7RdWbXV+wy0b9Sqtz7Az+08hpRNTKoD2RvS4h1B05CmHrsd8IOwQxtyY2Y2wymRIRORkT86sZvo+OogV/KkLPMJJnH3tFqm90qA1xz5er/XJOXBK7OdPaJ3YzuG4/fPNQrJXWVlOXYg==
Received: from SA0PR11MB4719.namprd11.prod.outlook.com (2603:10b6:806:95::17)
 by CY8PR11MB7686.namprd11.prod.outlook.com (2603:10b6:930:70::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.25; Wed, 28 Feb
 2024 07:03:01 +0000
Received: from SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::f65f:f05e:4faf:4433]) by SA0PR11MB4719.namprd11.prod.outlook.com
 ([fe80::f65f:f05e:4faf:4433%4]) with mapi id 15.20.7339.024; Wed, 28 Feb 2024
 07:03:01 +0000
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
Thread-Index: AQHaZn14iyGqXAZ1bkm2FnuRR0qAfbEZ68sAgAVvkYA=
Date: Wed, 28 Feb 2024 07:03:01 +0000
Message-ID: <b49572d4-b52e-4655-8d10-2709e2fbe803@microchip.com>
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172559.672142-1-varshini.rajendran@microchip.com>
 <20240224-kimono-stress-898eae80abd3@spud>
In-Reply-To: <20240224-kimono-stress-898eae80abd3@spud>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR11MB4719:EE_|CY8PR11MB7686:EE_
x-ms-office365-filtering-correlation-id: 5df5cea3-b1ae-4ae0-6478-08dc382b4d51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ramMqoAO0f8N3YKFBfI9sgEBjZGoCIzaQ34TUAdAt1RnFUUGdNr8J9e22RiLfj8uaHQugBAlU1LgUV3I1Sm7H5mnufkXIseNl+xZCrdmzLrXjo1Nq1mj13FechjD1yyIArtfiBGkC0SAl9srwjy7Y7aHepTOML12LwQHNwPcSKpD8Mha07tRaSgTqGuMNBzd1Mmx1M15oKC+gxUb4018H6To+c7gtujfn6Prh00AX6f3BquJQYwypZ13rqV3R+N2sqpPXJOgnvPn4BvH5ZbM0AC3mi3wjJQLk6f179yy9JoXtt//poMLLyPmTOjobFKp06b34EaaLLugqWylbh3cia1h9p2JBqAgQ/w0IheWtB+cRUYod96fikBZ0Uw0QI8OjgvMj6gTdgyuf3iUQ56ceRKgWJ+MRxUi39pLV0i+4QDc7H5JCpz/42qdjhaolksOhE2jtqeoeOwqiorL5l0PK7O5g26oKsd4q1jkeKBb13Mw+MW6KErPaEzTBip4g8iW2f34XLEcAKpPIf6+GYVTxlCxwcjs3F0rrciG2BlfwV+C5hyI37eSWJIMGvlRvcuGePNomgrcw/TuUV+DsHtb61Uwgk5vH/ZoNIi3QYfR7DvjF0Am0iYk822sywv0M4o7hgVt18HilGzE+MW5jUAcZif4sdL3bdtOfvWTsI1S+YemgSX+elKbFLWsmQA/PjnpFiwMjxZbjMbUzJFlSMGWSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR11MB4719.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZlFZOFNwdGNtNTdPUlJ1dTcvVmpMZDBocmJRRTE3alE2b2MwSmxXVjlsa2xi?=
 =?utf-8?B?blRCZ01NaDlQVVV6VlVITTNtYnFEUlkwMzRRYTQ3NzhFazJyOFE5c29ZOWJj?=
 =?utf-8?B?SFd0U0VIRWd0cU9CT1Q4ekEwU1FzcitwNnY0TzFhSDlYbmtzQVVrbnVZOUJ5?=
 =?utf-8?B?Wmh4WVQwbEp4c3VMUTNpQ2hNS3ptdUErUmRncTUvZ1VQTG5QKzRqeXdwazFG?=
 =?utf-8?B?RDlLTTRISzZ0bHppYk1HUjZGUG1IQms2K2IzcG9oWnVMTTJPdVVhRDFxOElR?=
 =?utf-8?B?ZGRmbm9YMlVUY1piTWYvN1FzWlZkTm5zczJlQ212NWh0RmJleEx2cnl0S21i?=
 =?utf-8?B?QTZ5MitYb2hJNGYvMmtGRlFtbjM1MzRvaEFRcHFrL2VVM1RiOXJ5NGJhME1I?=
 =?utf-8?B?aFg1T1ZHS3Y0ZXQ0TVROLzcrRmpBVklPa01hWHpOcWtxeS9nb0VXa3pBdWFD?=
 =?utf-8?B?Qk9ZVWRXME9VUzBPdFhzV0Vqbitjc3ROeHkyZUZIUVhWSGgvdlpLd1BicFRn?=
 =?utf-8?B?SWc4eU9sVVZaZDJ6ZmNCZExGT2RiV0syMmZwZnA4WTBHV2svRnV1a3BsbnlG?=
 =?utf-8?B?T1VoeXdPMk9qOS9pUEZaczVyWnRDTTlZTElBejJTM2J4c09lZUxJSzhwZDFm?=
 =?utf-8?B?SjU5VFVzbTFNK0hnbDFkYlo3NDRXOWxzV0VJUTBYck80YlJIZC9KR3JvTkN4?=
 =?utf-8?B?ZmU4Ym90bEVUdUZUMEFyMCtyNkQ1TTk3OUh5cjk2MmYyMUkwN1F3SGZNb01B?=
 =?utf-8?B?dUt6K0M1ZkFpSlg2VHFJRVYyZEJReGIxWWl6dmx3N2paK0x1V2JkclJrcFNx?=
 =?utf-8?B?V05EWUc2WlptZ2Z2NzNQR1k1dEdrYXJCTjQ3c0lrQzZrSVRHWGYxYVNyNHhC?=
 =?utf-8?B?MlE5YVlLWkxZUGptbjI0RVpqc3BXQW1aeXhDZUNyREZRNE9GWm1BWXRobFVT?=
 =?utf-8?B?aXoweEdiRDc0NWRFaGRXdjdTMHpmdzFjQkdQSk5ybDVtVnhhZ2F2UjI4VEpn?=
 =?utf-8?B?UlN2WG9lNGNKVFVEWGREdE9TTDhXdFhYbnRHY1NDQzB4a2V6dS9QL0NreUsy?=
 =?utf-8?B?Z0tCeHdadm1PcDI2K3IreVZlS2R5YkhVNEN0ME0wY2dVeTVxalp0WXUwd2Vm?=
 =?utf-8?B?VjJ6cUFTRG4xSW1vNDg4UUE0dmdHUDBLTUE3Mm8xemFBUDNoZW4yajZJRkhC?=
 =?utf-8?B?NXBIcEh1Mytublc5bDZiNURpV0JZN012cm1uWEZwUkdHTkR4WWRmNTA4ek1F?=
 =?utf-8?B?RlJoTGh4OG5STFNHbldqUDRGcHZ5aWZjZ2k4K1JvVWxBME1Oem1maGo0dUp2?=
 =?utf-8?B?RUE1dlNVQk0yYW1vTmFlTEQ2SVV2ZUJ6Z3V6TFFQNXFzdi9sZHVHZUZIOFcw?=
 =?utf-8?B?Zy92a2ZXeDV1ZEx1ZmVPb2dCY1F6cnVNWVlhTVZxNTF3WXIyMkZHdlFUU1Y3?=
 =?utf-8?B?UFpSSUNJcTZEalArdUVIb2FVQ0YrS1UwWVVqL0QybGI3dEtoUFdENXpiWnRP?=
 =?utf-8?B?SEpxTnhHaE1PaHhKZWNmOVp3UlZLeTZtaENFbHZ3SmprOEsvekRRTm1GZE9K?=
 =?utf-8?B?UUwzYW1vUGxyWW1kQ2tDOG5PK3lqdndlWnpZQlVqWDhxM2dtRjd2cHRmNUlD?=
 =?utf-8?B?dWZPemM0eW5JczRDaC9sd1B5QU9EdEd2a2t0WmdQWjN1YnFkSUhTcUpmV2ts?=
 =?utf-8?B?RnNNMnEzRCtJUmdRbDIxRFBDVzU4K0pjZm8vQlQwdkF5cEV3Q2NEL0k0VEIz?=
 =?utf-8?B?Z2l5cHozOStkNEV5YngvT1RlLzNoNUJrc1J4R1ROTy9aM2tweFNGcnc4Zlcw?=
 =?utf-8?B?bi9BQ3YzTlROdkI4eEhwNkhrMnFjRVdNdFF1NUpCYjkzZ3g4WU9lT1BFNjJN?=
 =?utf-8?B?eitGOTA3MHlSN2J1NytTQ29zdmxhbjE1eklUVEtwTDVLRERkckU1QjIvWTBJ?=
 =?utf-8?B?SFpnSkJ2SWY2azJHWEZLaWNla2hWNnB4dHZLWG5uMXgzUWFLQUhLY1EwVlpQ?=
 =?utf-8?B?eGE1bENqdEdCS2owVC9kMTdSK0kwUld6UEpNNWR1VXA2YnBYanpzYXBkMW5z?=
 =?utf-8?B?dUVrczZRZzh0MDVGckc1UHNwdDZ2c0dqUjNid3F3azlSNGNneitXM3B6am5X?=
 =?utf-8?B?YUYycmpZamkzNjVDNHZuNS85eWlGZU05a3B4dWNaTlFVS05GSTJJOUxRd3hC?=
 =?utf-8?B?clE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D0E55E44F9B5564599CC225DF661AEE3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR11MB4719.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5df5cea3-b1ae-4ae0-6478-08dc382b4d51
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 07:03:01.1266
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q2pEAR+jiXoptlKEcQ6dugnPLLc0tH8+U1fH4lMGQljFc1HdJIt7WUkyX6ASEO5yu9sPPiYlGqijYwLF+nFavxdPHbkNW/pt1rc9FyeZM25GYANgyLEOvMhpjyzDkIcC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7686

SGkgQ29ub3IsDQoNCk9uIDI1LzAyLzI0IDE6MzIgYW0sIENvbm9yIERvb2xleSB3cm90ZToNCj4g
RVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVu
bGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IE9uIEZyaSwgRmViIDIzLCAyMDI0
IGF0IDEwOjU1OjU5UE0gKzA1MzAsIFZhcnNoaW5pIFJhamVuZHJhbiB3cm90ZToNCj4+IEFkZCBz
YW05eDcgY29tcGF0aWJsZSB0byBEVCBiaW5kaW5ncyBkb2N1bWVudGF0aW9uLg0KPj4NCj4+IFNp
Z25lZC1vZmYtYnk6IFZhcnNoaW5pIFJhamVuZHJhbiA8dmFyc2hpbmkucmFqZW5kcmFuQG1pY3Jv
Y2hpcC5jb20+DQo+PiAtLS0NCj4+IENoYW5nZXMgaW4gdjQ6DQo+PiAtIEZpeGVkIHRoZSB3cm9u
ZyBhZGRpdGlvbiBvZiBjb21wYXRpYmxlDQo+PiAtIEFkZGVkIGZ1cnRoZXIgY29tcGF0aWJsZXMg
dGhhdCBhcmUgcG9zc2libGUgY29ycmVjdCAoYXMgcGVyIERUKQ0KPj4gLS0tDQo+PiAgLi4uL2Rl
dmljZXRyZWUvYmluZGluZ3Mvc2VyaWFsL2F0bWVsLGF0OTEtdXNhcnQueWFtbCB8IDEyICsrKysr
KysrKy0tLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25z
KC0pDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9zZXJpYWwvYXRtZWwsYXQ5MS11c2FydC55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVl
L2JpbmRpbmdzL3NlcmlhbC9hdG1lbCxhdDkxLXVzYXJ0LnlhbWwNCj4+IGluZGV4IDY1Y2IyZTVj
NWVlZS4uMzBhZjUzN2U4ZTgxIDEwMDY0NA0KPj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3NlcmlhbC9hdG1lbCxhdDkxLXVzYXJ0LnlhbWwNCj4+ICsrKyBiL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zZXJpYWwvYXRtZWwsYXQ5MS11c2FydC55YW1s
DQo+PiBAQCAtMjMsMTEgKzIzLDE3IEBAIHByb3BlcnRpZXM6DQo+PiAgICAgICAgICAgIC0gY29u
c3Q6IGF0bWVsLGF0OTFzYW05MjYwLWRiZ3UNCj4+ICAgICAgICAgICAgLSBjb25zdDogYXRtZWws
YXQ5MXNhbTkyNjAtdXNhcnQNCj4+ICAgICAgICAtIGl0ZW1zOg0KPj4gLSAgICAgICAgICAtIGNv
bnN0OiBtaWNyb2NoaXAsc2FtOXg2MC11c2FydA0KPj4gKyAgICAgICAgICAtIGVudW06DQo+PiAr
ICAgICAgICAgICAgICAtIG1pY3JvY2hpcCxzYW05eDYwLXVzYXJ0DQo+PiArICAgICAgICAgICAg
ICAtIG1pY3JvY2hpcCxzYW05eDctdXNhcnQNCj4+ICAgICAgICAgICAgLSBjb25zdDogYXRtZWws
YXQ5MXNhbTkyNjAtdXNhcnQNCj4+ICAgICAgICAtIGl0ZW1zOg0KPj4gLSAgICAgICAgICAtIGNv
bnN0OiBtaWNyb2NoaXAsc2FtOXg2MC1kYmd1DQo+PiAtICAgICAgICAgIC0gY29uc3Q6IG1pY3Jv
Y2hpcCxzYW05eDYwLXVzYXJ0DQo+PiArICAgICAgICAgIC0gZW51bToNCj4+ICsgICAgICAgICAg
ICAgIC0gbWljcm9jaGlwLHNhbTl4NjAtZGJndQ0KPj4gKyAgICAgICAgICAgICAgLSBtaWNyb2No
aXAsc2FtOXg3LWRiZ3UNCj4gDQo+PiArICAgICAgICAgIC0gZW51bToNCj4+ICsgICAgICAgICAg
ICAgIC0gbWljcm9jaGlwLHNhbTl4NjAtdXNhcnQNCj4+ICsgICAgICAgICAgICAgIC0gbWljcm9j
aGlwLHNhbTl4Ny11c2FydA0KPiANCj4gVGhpcyBkb2Vzbid0IG1ha2Ugc2Vuc2UgLSB0aGlzIGVu
dW0gc2hvdWxkIGJlIGEgY29uc3QuDQo+IEkgZG9uJ3QgcmVhbGx5IHVuZGVyc3RhbmQgdGhlIGlk
ZWEgYmVoaW5kIG9mIHRoZSBvcmlnaW5hbCBiaW5kaW5nIGhlcmUgdGhhdA0KPiBhbGxvd2VkOg0K
PiAibWljcm9jaGlwLHNhbTl4NjAtZGJndSIsICJtaWNyb2NoaXAsc2FtOXg2MC11c2FydCIsICJh
dG1lbCxhdDkxc2FtOTI2MC1kYmd1IiwgImF0bWVsLGF0OTFzYW05MjYwLXVzYXJ0Ig0KPiANCj4g
U3BlY2lmaWNhbGx5LCBJIGRvbid0IGdldCB0aGUgcHVycG9zZSBvZiB0aGUgIm1pY3JvY2hpcCxz
YW05eDYwLXVzYXJ0Ii4NCj4gRWl0aGVyIG1ha2UgaXQNCj4gICAgICAgLSBpdGVtczoNCj4gICAg
ICAgICAgIC0gZW51bToNCj4gICAgICAgICAgICAgICAtIG1pY3JvY2hpcCxzYW05eDYwLWRiZ3UN
Cj4gICAgICAgICAgICAgICAtIG1pY3JvY2hpcCxzYW05eDctZGJndQ0KPiAgICAgICAgICAgLSBj
b25zdDogbWljcm9jaGlwLHNhbTl4NjAtdXNhcnQNCj4gICAgICAgICAgIC0gY29uc3Q6IGF0bWVs
LGF0OTFzYW05MjYwLWRiZ3UNCj4gICAgICAgICAgIC0gY29uc3Q6IGF0bWVsLGF0OTFzYW05MjYw
LXVzYXJ0DQo+IG9yIGFkZA0KPiAgICAgICAtIGl0ZW1zOg0KPiAgICAgICAgICAgLSBjb25zdDog
bWljcm9jaGlwLHNhbTl4NjAtZGJndQ0KPiAgICAgICAgICAgLSBjb25zdDogYXRtZWwsYXQ5MXNh
bTkyNjAtZGJndQ0KPiAgICAgICAgICAgLSBjb25zdDogYXRtZWwsYXQ5MXNhbTkyNjAtdXNhcnQN
Cj4gb3IgZXhwbGFpbiBleGFjdGx5IHdoeSB0aGlzIG5lZWRzIHRvIGJlDQo+ICJjaGlwYS1kZ2J1
IiwgImNoaXBhLXVzYXJ0IiwgImNoaXBiLWRiZ3UiLCAiY2hpcGItZGJndSINClRoZSBjb21wYXRp
YmxlIGhhcyB0byBiZSAiY2hpcGEtdXNhcnQiLCAiY2hpcGItdXNhcnQiLCAiY2hpcGEtZGJndSIs
IA0KImNoaXBiLWRiZ3UiIGZvciB0aGUgZGV2aWNlIHRvIHdvcmsgYXMgYSBkZWJ1ZyBjb25zb2xl
IG92ZXIgVUFSVA0Kd2hlciB0aGUgY2hpcGEtPHBlcmlwaD4gaXMgdGhlIGRldmljZSBzcGVjaWZp
YyBjb21wYXRpYmxlDQphbmQgdGhlIGNoaXBiLTxwZXJpcGg+IGlzIHRoZSBmYWxsYmFjayBjb21w
YXRpYmxlIHRoYXQgdGhlIGRyaXZlciANCmFjdHVhbGx5IHVzZXMuDQoNCk1heWJlIHB1dHRpbmcg
dGhlIDIgY29tcGF0aWJsZXMgYXMgMiBlbnVtcyBpcyBub3QgcmlnaHQuIEkgd2lsbCByZXBocmFz
ZSANCml0IGFzIGJlbG93Lg0KDQogICAgICAgLSBpdGVtczoNCiAgICAgICAgICAgLSBjb25zdDog
bWljcm9jaGlwLHNhbTl4NjAtZGJndQ0KICAgICAgICAgICAtIGNvbnN0OiBtaWNyb2NoaXAsc2Ft
OXg2MC11c2FydA0KICAgICAgICAgICAtIGNvbnN0OiBhdG1lbCxhdDkxc2FtOTI2MC1kYmd1DQog
ICAgICAgICAgIC0gY29uc3Q6IGF0bWVsLGF0OTFzYW05MjYwLXVzYXJ0DQogICAgICAgLSBpdGVt
czoNCiAgICAgICAgICAgLSBjb25zdDogbWljcm9jaGlwLHNhbTl4Ny1kYmd1DQogICAgICAgICAg
IC0gY29uc3Q6IG1pY3JvY2hpcCxzYW05eDctdXNhcnQNCiAgICAgICAgICAgLSBjb25zdDogYXRt
ZWwsYXQ5MXNhbTkyNjAtZGJndQ0KICAgICAgICAgICAtIGNvbnN0OiBhdG1lbCxhdDkxc2FtOTI2
MC11c2FydA0KDQpIb3BlIHRoaXMgaXMgZmluZS4NCj4gDQo+IFRoYW5rcywNCj4gQ29ub3IuDQo+
IA0KDQotLSANClRoYW5rcyBhbmQgUmVnYXJkcywNClZhcnNoaW5pIFJhamVuZHJhbi4NCg0K

