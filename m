Return-Path: <linux-kernel+bounces-75867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D884485F004
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 04:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0798C1C22AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 03:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9555A17567;
	Thu, 22 Feb 2024 03:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="wGKCm4Fh";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MkdyBJLM"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D16101F1;
	Thu, 22 Feb 2024 03:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708573343; cv=fail; b=h5PHb1Ne3QR0Up29JCmqsI33aWoaK+DFs+3iJ+I4yFQpkXKh/FZ5CqMKQXgKWV8qgMwI5tmvAPuofgJ6Y5e9TKwXNo9TwIyNCGZwn7+AFMljh5VRRC/geR2sQEGFFcqsKUbnUbr2DPExQ+rWrb7ae3xHEKVDR2ubzx9bg83Boq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708573343; c=relaxed/simple;
	bh=mHDlMQDK+/3/Q8XpU2wkBmjyhwzqu3tlmiS72aFu5Y8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=o5rcrp06cHMcl8iWzqCy3gUa95Mth5kR/XXffelPOwfxc8+h9n6SIzcA4sPK1zM3Ir9PqU0l07xzqrJyFN4gJ5waiWS8g9/0gCGLUY7He9oQ1E4Tq9uhJHP4ahZ8s1n+Qtp0obClSI7aSqlqj6zw8YwZkgUQFq6eNlmp4kcI4Xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=wGKCm4Fh; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MkdyBJLM; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708573340; x=1740109340;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mHDlMQDK+/3/Q8XpU2wkBmjyhwzqu3tlmiS72aFu5Y8=;
  b=wGKCm4FhgN2UYr83RKBtXEldIegHq2aTwKBe5VYtZ8IExc7CtYlhxMC/
   hEujomJMkZlRDIQiPtft+mWkv8hDbtmkMrZPERmDRl9KhcPi3h6MFbjGF
   5PX6nbkkp9J5LOM71oOn+y/Fz6v/VCMLvxMuKblLVzWqSLYQ7GbNo9nx3
   0I90nJ+ZSVoWMRuMnrmGD8sjGCnT4ab7XkJtUOC50Bs+RU1dVaD5A8M5C
   JS3d3O67kc4YMF2M+w6X17nFBkKR9rWDrPM8kLzvTQ6/yFQZ/QsNWi+1p
   3xQfKR2a8h0BMoRsS3HHLblTki9pmgGruChgkhAB4xAFph5cbEmba87dv
   Q==;
X-CSE-ConnectionGUID: hr7RiBATRpCQW5a+mWPH7A==
X-CSE-MsgGUID: Rw6WaTAHQ1a227Qrqwlzpg==
X-IronPort-AV: E=Sophos;i="6.06,177,1705388400"; 
   d="scan'208";a="18163496"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Feb 2024 20:42:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 20:41:31 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 20:41:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IYQKlhf2r2yc5u+GQn8/xQp/CzHDjGEPvZF2A6P073hgloCD7xU4lWzbU8Hzvf7Bl99Zf0Xub6Ug2bFGDMdpctXDqrbM9fQZ9L1jhlbLvE2JF06gxP8dtAQ5eGqXVbL0z3OXtpsQjXPFtg47skDs8V3DJsWrvLIiUk/4ytjMCB/ZAONQVY8C+jfujDt7ZcK9GbxKJwzTA0FJAqLd0nOPRboM23Kj1yFHQHHIMm8sUzdFC4+bc6soULJ0m7xSeb8e36/73YBFNx0puBBbDQsqcxR1kMV/fqu0PXENQCkHN95gnMeHz5hekOF/3wLNxUAYM1TVfsym9u0KSjp7DR9/Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHDlMQDK+/3/Q8XpU2wkBmjyhwzqu3tlmiS72aFu5Y8=;
 b=nbCDKIH3gBaLoCAvPTABmYxBJH2D96aMdbETPjHfUO10m3FIO7/YRMvcao9IrydGvhAsL/l9cexLDAYoKKTcRxClProoArTzFD/sd1ACllkul3gfeMDsPytBCHbdwp1+dGp3Y7nyVopklFvVYGHPNuuLZNr7nge8XrnzYQcpc1Lxc+k5U+4b3RQChixkTXUIoQF7IeK6LZzUoAX4foKUBfImvc4n5hmohIwy16dO4ZgONAO0Nw41RsLwrPU1pl/DGNLvkBDBaivJiBwh7aFA5ttJCNtV5PuS0MUHYw2MIhqQWpJrieIOKuu8MvJkBZnxXIlijjkHMZCQxx+FIFPHYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHDlMQDK+/3/Q8XpU2wkBmjyhwzqu3tlmiS72aFu5Y8=;
 b=MkdyBJLMzHlVAWGhx2WpOzcB4L40iRUgEecxGWgWALg4gC0n3TH9rCcY927+L+nxnAEpjh/n4DUeSRiYgOHQnssMBQlANbKiuulrKAyYQ3WD1+kxEh6hm7U+rNHr9f8hmmPBGjYaFBU2kiIfy2vSPqLk1ds2SPUt9+MwUlgByF9+0Qp4/4LbeJdAqsJ1w2g8XJpx4+20jkUNezBaK942rWQyLGn997t9xhvzn4lQyjMt9rZ7I5bZD52CiLwmVd6SkPZG71Q/upg2pA+18OX7e0fgmaMNFrk0Eerm5bJpirODsoFJ3qYpcRyF0t1n12a0/8h7kSv5KolrCv+bo9Vk6g==
Received: from PH7PR11MB6451.namprd11.prod.outlook.com (2603:10b6:510:1f4::16)
 by LV8PR11MB8748.namprd11.prod.outlook.com (2603:10b6:408:200::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Thu, 22 Feb
 2024 03:41:27 +0000
Received: from PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80b9:80a3:e88a:57ee]) by PH7PR11MB6451.namprd11.prod.outlook.com
 ([fe80::80b9:80a3:e88a:57ee%3]) with mapi id 15.20.7270.036; Thu, 22 Feb 2024
 03:41:27 +0000
From: <Dharma.B@microchip.com>
To: <conor@kernel.org>
CC: <robh@kernel.org>, <tglx@linutronix.de>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
	<claudiu.beznea@tuxon.dev>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2] dt-bindings: interrupt-controller: Convert Atmel AIC
 to json-schema
Thread-Topic: [PATCH v2] dt-bindings: interrupt-controller: Convert Atmel AIC
 to json-schema
Thread-Index: AQHaWz8HvDl6LGSGcE+Fqy+8rXoJf7EGw2QAgADu8ACAAPjDgIAJL6qAgAHV8oCAAhrVAA==
Date: Thu, 22 Feb 2024 03:41:26 +0000
Message-ID: <4ca76047-2142-4b07-b34e-707f8b5c1f3c@microchip.com>
References: <20240209100122.61335-1-dharma.b@microchip.com>
 <20240212140824.GA107736-robh@kernel.org>
 <003d61c9-b914-4e1c-b3f8-1140ea640039@microchip.com>
 <20240213-estranged-charger-bf0372f367e0@spud>
 <a97650cd-8e06-4df6-9757-826c00a4d7cc@microchip.com>
 <20240220-carmaker-subprime-112c44f4f2e6@spud>
In-Reply-To: <20240220-carmaker-subprime-112c44f4f2e6@spud>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6451:EE_|LV8PR11MB8748:EE_
x-ms-office365-filtering-correlation-id: 1ba82e8f-c6cd-4127-6c4b-08dc3358261f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lVOJGYiW8B5n7bgGnFcnIOIOlJE8olQFGhUfVEUyliANV5cQSV2z1pWLw1+hPKLDh+RGA0l3x3O1MPXA97fkoQP6v+1JqC9bTs5yaC7up0Dd3nTXeGOHhVbYYw/YQR5cxcNOdMnt6GDiMvBRHLWwYkuTnp7a8OZGBH3mUkwy3WfZAv50UOvvf0oca0JBkTOvgYuwZNebdUozOCJafiFewZYBkxttibuiWOE/fIBQF3i7Lt9D9+nxEoowHHbARnTHS8g4IarBGjZilXNGxd4tlicfKjtq7ZMFzal2pZ2V8tpuL0L9QLiPQ2RBpqlS1MYpfDfLPHrSGdTarZRt9ss2w5PeJnKnrSPpyOWtX+DTb6SkVng3JmhuoU4Wm75FEYCrzhPS1o3xgdodCMPqj0hCfpkwuKBiq7ybQ4VlV58CKI/CxjmBDsDexLJx0BMSHzt3czvf+4iUni+nTePlZF1BUyYlRv3ln/h/9kJapdHX530Q9nS2TF/bIY0eWY6BediKEdZIddY4cbzMsbEHzFJssJ7S8TZWpuDRgKnNUjek/gjN0rvNC4Xxi4Dhs/UrZH0EEZaYWTtjcT0NHeFHvkCrxZdl+jBu+7sGgn78HBO6blMfH+TEPBLm9TJYevCDZvoF
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB6451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M1N3V003cXl1R3pSQ0F0OVNNV09QUXhveUNPNERMQTNnU1NYdGliVXp2bzEx?=
 =?utf-8?B?VnRZWkJPMGVxWTlNTmtGYzdTdm1mSjE2OG1KOFlRWUkvM0pIU1pOWWoyRmhk?=
 =?utf-8?B?V2RwcFFWZ2FtdkpWNS9yTVJWVzZkVDB4QzEyZklqZUZ6eFZVNzhYRmFzaHUy?=
 =?utf-8?B?NHlRT2hyOVRvT2lMWDVURG4wd1JRTDJSNlBYSllyY0JwQXJHVHNqdTBmQmU4?=
 =?utf-8?B?alMwdnBBcnhpUUVEem9lbG8ybWNNNk1UbzZXVWs1Z1ZRRzFwMTBSQldsTmxz?=
 =?utf-8?B?TjUwdS9VVHpyOCsrak52QjZrMXZFNEZpbXRzVitxbTRvSEJ3bUM1dDlBb0ZC?=
 =?utf-8?B?SlNmN3lMbzh2akFNSWhzcytGcjVCNWNMZEY4V1QzbXVJYWZ4OEg4U0IyOCth?=
 =?utf-8?B?UmV5Q01QR1YvZGk4bGEzdmpoWFBFS3g0QWxnQzdMajhKdVo4SWovU2l5ZGdH?=
 =?utf-8?B?aVBHL3RxNFBYOWYvY2toTWszbHgvcU9pQWM0djdRL1c5T2J6M3JwYXhIdjFZ?=
 =?utf-8?B?ZEZrSkpFVHBCM0k3OXZPRzdpM3BQRHFWWWhqN1ZEMlNaYmJ1TStLd3J1aWFB?=
 =?utf-8?B?d3UwbVhpZzJjamo3QXVEaDVVZFFraXkyVlBwOC93VU16RDFkRmNxMjB3ZktL?=
 =?utf-8?B?VHJRa0JDVHpJemtGVlBPcEVESndJcGR1M2FVTzJJNEIvdXUwdWdaeHJKVFgv?=
 =?utf-8?B?b2xxV1lVa2M2Q3pkSzRMMXJpSDJFZnhmRUhsUm1YN2VGajh1WCtyWncwdkFR?=
 =?utf-8?B?NVBYVTJNa0NZRXZBV2pGWTJpWThxRVQvQzVweFM4S1hhQzhKait3WTRLQlYz?=
 =?utf-8?B?WURKeFloL2JxYkJETzZxY09PbzdlQmdxME1CanRFZEtSMXlYRGZFYkh2S1I0?=
 =?utf-8?B?ZElPbGRYdEcwSlgvQ1pGM1NxdnBFbHpSK3pYZ09Zd2kzUWd0OHpXZVd2VGdu?=
 =?utf-8?B?VlVhSG9YRy9oMzJKWnVENVhicEVNZ0VEK0I0UFlYcWdjQWp4UVNFRGwvemNk?=
 =?utf-8?B?bUdCdm5sN0xlQzFyZ1puRUFpWmFCSWJCNGtFQlhHaFBsU3djc01ydUJvQVhk?=
 =?utf-8?B?OGpuejlDRll2QVU2YkNzUmtEL0t6WjRSRldqMStPOVk0Y083T0dEMkpUTWdY?=
 =?utf-8?B?cjMySW85dG1mdUlrdmszV2JpMnowZVRpajVkQWFnVzRoSnRSajdERlpFTDRi?=
 =?utf-8?B?cEdrNjFXbnRSaVFWbDJzRXJWb25oRStIbEo4aG9MMC9zMUlzbW1lWnRicWIy?=
 =?utf-8?B?SndOT294MFBDc2ZhN01VazZzWFcydWZDdDgrUlRHWTJMU1dKY2RTTUZyQkt6?=
 =?utf-8?B?N0dtMlZ0aGpzNitjcFBXdHFMNDdEclFUa1I3Q2pCY2ZHUnJBQTdHcDE4b0xO?=
 =?utf-8?B?WW1iSjR6YkZsUlVBRlJzYmZYejZlWXpnbm5odFAvcWFwc2EybFZCNjdycXRP?=
 =?utf-8?B?N1E0ZEwzRVpIdmFKT1BqRmRBQ3NFR3NKS2dwamkxd3NiK3NVZGx1a25qWnFp?=
 =?utf-8?B?eEJuZHlqSlFTdWVlbWFwTjB3UEFZNmNYNU45aVRyZVhMdzN0aXc5eXBNWmNu?=
 =?utf-8?B?WExGME0waUlQVkFLMk01WHUzaDJ1UEpsYUlUOXJXbHVNRGhPc1kzdUpoR3pG?=
 =?utf-8?B?d0U0UFBRbWlvQUdzam1ocmpqalBpcm8vYUk1bUZzN1Y4c0U0eGNIWXJFMnVs?=
 =?utf-8?B?ZUtUclhNendVdjM2ZFd4M0pJYlh1bzU1bHdqUi81M3BvRm51aFNTTzRkeVJs?=
 =?utf-8?B?NXZocm1qUk1JOXFDMEc2ZWJ4alF3RnQwNU9nMVFqeXJVQXowaTVocXNpNC9w?=
 =?utf-8?B?eVVaMGdzL1NWOHFqeVREZVpNNytrcXE3c1NOeXpVN1A0Y2EzdFpBS2NUVWRt?=
 =?utf-8?B?OHV0ZzFoUjRRekdwbnkzRjdlcElOTHdnVWNmUXZBendHdGtyMWdlLzFLd3g4?=
 =?utf-8?B?dnA3L3p3VzVnS1dQaVVKY0NySXJVeEtZdVpZR0VPTXAwNnEyQjhxbHZpQVVq?=
 =?utf-8?B?OW1CSzMyam1jYVRpN1pIVkhOekJBU3ZscUg0Q2swYXAxTGxaSDVmdXF1RVZy?=
 =?utf-8?B?NTc1Z3R2dFRnZ0hYSklUYmdwSU4xK0NvdENYTTc3cGgySm1scWtTVnZha1RX?=
 =?utf-8?Q?SzB57C3pSbJAfMGdh5D5ydS6E?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <755299CA2933C14CBA3554D2BD26FE8C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba82e8f-c6cd-4127-6c4b-08dc3358261f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2024 03:41:26.9158
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zKfGcvQ3fNv1gVRLff33ke3WjO458NdLK5LApFq7WvDTMmYGvcWQhRStALr2iByxGyDpJhpwkkyMmJrYwmGBpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8748

T24gMjEvMDIvMjQgMTowMiBhbSwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBPbiBNb24sIEZlYiAx
OSwgMjAyNCBhdCAwMzozMDo1MlBNICswMDAwLERoYXJtYS5CQG1pY3JvY2hpcC5jb20gIHdyb3Rl
Og0KPj4gSGkgUm9iIGFuZCBDb25vciwNCj4+DQo+PiBPbiAxNC8wMi8yNCAxMjo0MyBhbSwgQ29u
b3IgRG9vbGV5IHdyb3RlOg0KPj4+IE9uIFR1ZSwgRmViIDEzLCAyMDI0IGF0IDA0OjIzOjM2QU0g
KzAwMDAsRGhhcm1hLkJAbWljcm9jaGlwLmNvbSAgIHdyb3RlOg0KPj4+PiBPbiAxMi8wMi8yNCA3
OjM4IHBtLCBSb2IgSGVycmluZyB3cm90ZToNCj4+Pj4+IE9uIEZyaSwgRmViIDA5LCAyMDI0IGF0
IDAzOjMxOjIyUE0gKzA1MzAsIERoYXJtYSBCYWxhc3ViaXJhbWFuaSB3cm90ZToNCj4+Pj4+PiAr
ICBhdG1lbCxleHRlcm5hbC1pcnFzOg0KPj4+Pj4+ICsgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMu
eWFtbCMvZGVmaW5pdGlvbnMvdWludDMyLWFycmF5DQo+Pj4+Pj4gKyAgICBkZXNjcmlwdGlvbjog
dTMyIGFycmF5IG9mIGV4dGVybmFsIGlycXMuDQo+Pj4+PiBDb25zdHJhaW50cyBvbiB0aGUgYXJy
YXkgc2l6ZSBhbmQvb3IgZW50cnkgdmFsdWVzPw0KPj4+PiBUaGUgaGFyZHdhcmUncyBzdXBwb3J0
IGZvciBleHRlcm5hbCBJUlFzIG1heSBkaWZmZXIsIHdoaWNoIGlzIHdoeSBhIHUzMg0KPj4+PiBh
cnJheSBpcyB1dGlsaXplZC4gVGhpcyBjaG9pY2UgaXMgYmFzZWQgb24gdGhlIGZhY3QgdGhhdCBJ
UlEgbnVtYmVycyBhcmUNCj4+Pj4gY29tbW9ubHkgZXhwcmVzc2VkIGFzIGludGVnZXJzLCBhbmQg
YSAzMi1iaXQgdW5zaWduZWQgaW50ZWdlciBwcm92aWRlcyBhDQo+Pj4+IHN0YW5kYXJkaXplZCBz
aXplIGNhcGFibGUgb2YgcmVwcmVzZW50aW5nIGEgYnJvYWQgcmFuZ2Ugb2YgbnVtYmVycy4gVGhp
cw0KPj4+PiBzaXplIGlzIG1vcmUgdGhhbiBhZGVxdWF0ZSBmb3IgYWNjb21tb2RhdGluZyBJUlEg
bnVtYmVyaW5nLg0KPj4+IEkgZG9uJ3QgdGhpbmsgUm9iIHdhcyBxdWVzdGlvbmluZyB5b3VyIHVz
ZSBvZiB1MzJzLCBidXQgcmF0aGVyIHRoZSBmYWN0DQo+Pj4gdGhhdCB5b3UgZG8gbm90IGxpbWl0
IHRoZSB2YWx1ZXMgYXQgYWxsIG5vciB0aGUgbnVtYmVyIG9mIHZhbHVlcy4NCj4+IFRoZSBwZXJp
cGhlcmFsIGlkZW50aWZpY2F0aW9uIGRlZmluZWQgYXQgdGhlIHByb2R1Y3QgbGV2ZWwgY29ycmVz
cG9uZHMNCj4+IHRvIHRoZSBpbnRlcnJ1cHQgc291cmNlIG51bWJlci4NCj4+DQo+PiBTb0MgICAg
ICAgICAgIEV4dGVybmFsIEludGVycnVwdHMgICAgUGVyaXBoZXJhbCBJRA0KPj4gQVQ5MVJNOTIw
MCAgICAtIElSUTDigJNJUlE2ICAgICAgICAgICAgMjUgLSAzMQ0KPj4gU0FNQTVEMiAgICAgICAt
IElSUTDigJNJUlFuICAgICAgICAgICAgNDkNCj4+IFNBTUE1RDMgICAgICAgLSBJUlEw4oCTSVJR
biAgICAgICAgICAgIDQ3DQo+PiBTQU1BNUQ0ICAgICAgIC0gSVJRMOKAk0lSUW4gICAgICAgICAg
ICA1Ng0KPj4gU0FNOXg2MCAgICAgICAtIElSUTDigJNJUlFuICAgICAgICAgICAgMzENCj4+DQo+
PiBUbyByZWZsZWN0IHRoZXNlIGNvbnN0cmFpbnRzIGluIGJpbmRpbmdzLCBJIGludGVuZCB0byBt
YWtlIHRoZSBmb2xsb3dpbmcNCj4+IGNoYW5nZXMuDQo+Pg0KPj4gICAgIGF0bWVsLGV4dGVybmFs
LWlycXM6DQo+PiAgICAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9kZWZpbml0aW9ucy91
aW50MzItYXJyYXkNCj4+ICAgICAgIGRlc2NyaXB0aW9uOiB1MzIgYXJyYXkgb2YgZXh0ZXJuYWwg
aXJxcy4NCj4+ICAgICAgIGlmOg0KPj4gICAgICAgICBwcm9wZXJ0aWVzOg0KPj4gICAgICAgICAg
IGNvbXBhdGlibGU6DQo+PiAgICAgICAgICAgICBjb250YWluczoNCj4+ICAgICAgICAgICAgICAg
Y29uc3Q6IGF0bWVsLGF0OTFybTkyMDAtYWljDQo+PiAgICAgICB0aGVuOg0KPj4gICAgICAgICBt
aW5JdGVtczogMQ0KPj4gICAgICAgICBtYXhJdGVtczogNw0KPj4gICAgICAgZWxzZToNCj4+ICAg
ICAgICAgbWluSXRlbXM6IDENCj4+ICAgICAgICAgbWF4SXRlbXM6IDENCj4gSnVzdCB0byBwb2lu
dCBvdXQsIHRoYXQgaWYgdGhpcyBpcyBub3QgcHN1ZWRvY29kZSwgdGhlIHN5bnRheCBoZXJlIGlz
DQo+IG5vdCBxdWl0ZSByaWdodC4gSXQgc2hvdWxkIGJlOg0KPiANCj4gYWxsT2Y6DQo+IC0gaWY6
DQo+ICAgICAgcHJvcGVydGllczoNCj4gICAgICAgIGNvbXBhdGlibGU6DQo+ICAgICAgICAgIGNv
bnRhaW5zOg0KPiAgICAgICAgICAgIGNvbnN0OiBhdG1lbCxhdDkxcm05MjAwLWFpYw0KPiAgICB0
aGVuOg0KPiAgICAgIHByb3BlcnRpZXM6DQo+ICAgICAgICBhdG1lbCxleHRlcm5hbC1pcnFzOg0K
PiAgICAgICAgICBtaW5JdGVtczogMQ0KPiAgICAgICAgICBtYXhJdGVtczogNw0KPiAgICBlbHNl
Og0KPiAgICAgIHByb3BlcnRpZXM6DQo+ICAgICAgICBhdG1lbCxleHRlcm5hbC1pcnFzOg0KPiAg
ICAgICAgICBtaW5JdGVtczogMQ0KPiAgICAgICAgICBtYXhJdGVtczogMQ0KPiANCj4gQnV0IHlv
dSBjYW4gc2ltcGx5IHRoaXMgZnVydGhlciBieSBhcHBseWluZyBtaW5JdGVtczogMSAmIG1heGl0
ZW1zOiA3DQo+IHRvIHRoZSBwcm9wZXJ0eSBkaXJlY3RseSBhbmQganVzdCBzZXR0aW5nIG1heEl0
ZW1zOiAxIHdoZW4gdGhlDQo+IGNvbXBhdGlibGUgaXMgbm90IGF0bWVsLGF0OTFybTkyMDAtYWlj
Lg0KPiANCj4gVGhlcmUgc2hvdWxkIGJlIHBsZW50eSBvZiBleGFtcGxlcyBpbi10cmVlIGZvciB5
b3UgdG8gY29weSB0aGlzIHNvcnQgb2YNCj4gdGhpbmcgZnJvbSAtIGNsb2NrLW5hbWVzIGlzIGEg
cHJvcGVydHkgeW91IG9mdGVuIHNlZSB0aGlzIHVzZWQgZm9yLg0KDQpTdXJlLCBUaGFua3MgZm9y
IHBvaW50aW5nIGl0IG91dC4NCg0KSSB3aWxsIGFkZHJlc3MgeW91ciBwcmV2aW91cyBzdWdnZXN0
aW9uICJyZWcgYmVmb3JlDQppbnRlcnJ1cHQtY29udHJvbGxlci4iIGFzIHdlbGwgaW4gdjMuDQoN
Cj4gDQo+IENoZWVycywNCj4gQ29ub3IuDQoNCi0tIA0KV2l0aCBCZXN0IFJlZ2FyZHMsDQpEaGFy
bWEgQi4NCg0K

