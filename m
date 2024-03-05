Return-Path: <linux-kernel+bounces-91640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72DBA87148B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 05:05:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9678A1C21C54
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 04:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD3E3C087;
	Tue,  5 Mar 2024 04:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=asus.com header.i=@asus.com header.b="F9tI9Ljq"
Received: from ms.asus.com (ms.asus.com [103.10.4.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22492940D;
	Tue,  5 Mar 2024 04:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=103.10.4.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709611500; cv=fail; b=l+ePrw5Z2CwuJLp4eHYmEoRllXKkk35fc3aPa1p8Mz9YwGxhp3OJhHfq5yGHeDql9jWRgvvDGMWz+u0gLAuH5TnQY4+kpqhjucxE/SCuBqP1unyK33ULSaBfNdBbFXeN6axGhYFEVSZAEUwJu/fe0Y8MVOppC0JXJdau1jP5ipc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709611500; c=relaxed/simple;
	bh=yWXspTEg/VGyrHTTo0lOGsg3pxwUINMdJRkV3/j6vdk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gvjkRvN+Khj8LeeXMDmtYd5+Ia8V34gTPXJrnBFbVDqcdo+N5bQ5C/bfRa358hT6ABf2aXO1VbloCZ9YNw0uimbUfNgipBNDxqWfwuKOIwXL0lIUUvIYMS08V+CdGeFsogW7hb+HGjGIZNESSla3GLKvu2BnHMflnXKZP0dpVU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asus.com; spf=pass smtp.mailfrom=asus.com; dkim=pass (1024-bit key) header.d=asus.com header.i=@asus.com header.b=F9tI9Ljq; arc=fail smtp.client-ip=103.10.4.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asus.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=asus.com; i=@asus.com; q=dns/txt; s=asuscom;
  t=1709611498; x=1741147498;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yWXspTEg/VGyrHTTo0lOGsg3pxwUINMdJRkV3/j6vdk=;
  b=F9tI9LjqrSpiKH4hwAL8xi+cWaPBenjU4w1QGjhgPFg9t7+3BwWczKk6
   ErnzabusFwBsDBToPKUHSSREWMHE4V426aU+3hASTrFnZowSQTJfLOpmu
   yY9FNXZaWHKpvxHOE0s0IMDpcLj+/qH36gnPECG7wco2RvT2HqRbowfmz
   c=;
X-IPAS-Result: =?us-ascii?q?A2EeAwDsmOZl/w0GFqxaHgEBCxIMQAmBOwuCOXqBYYRVk?=
 =?us-ascii?q?WcDiiGBP5BRKoEsFIFfCw8BAQEBAQEBAQEHAQEuFgQBAYUGAhaHXSc1CA4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBCAEBAQUBAQEBAQEGBAEBAQKBGYUvSoJcAYN2AQEBA?=
 =?us-ascii?q?QMBIhFFDAQCAQYCDQQEAQEBAgIZDQICAh4HChUICAIEAQ0FCIUkAzGVZZs6e?=
 =?us-ascii?q?oEyGmeCFgRKr1UNgSwSgRcJAYEQLoFphh8eAYFWgWyCM4NBe4JPJm9CgWaBA?=
 =?us-ascii?q?j6CH4FvARIBIwUQFQwCgyE5gi8EgTdcgxIpgzCBKIxNgRKELYVuCUt/HAOBB?=
 =?us-ascii?q?QRaDQUWEB43ERATDQMIbh0CMToDBQMEMgoSDAsfBVQDQwZJCwMCGgUDAwSBL?=
 =?us-ascii?q?gUNGgIQGgYMJgMDEkkCEBQDOAMDBgMKMTBVQQxQA2QfFhwJPA8MGgIbFA0kI?=
 =?us-ascii?q?wIsPgMJChACFgMdFgQwEQkLJgMqBjYCEgwGBgZdIBYJBCUDCAQDVAMgdBEDB?=
 =?us-ascii?q?BoHCwd4ggmBPQQTRgENA4E0BooeDIMPAgUjBCaBWwNEHUADC209NQYOGwUEH?=
 =?us-ascii?q?wEdfAWiLROBKRAQFC5wKxVQES5Qj3WCQIM/SYtpjgOUD3ANgwyBA5k0gX2GK?=
 =?us-ascii?q?xeEBYx6hlwDkkmYWyCRUJZiAgQCBAUCDgiBQSUDgSFwMz2DN1IZoiJ4OwIHA?=
 =?us-ascii?q?QoBAQMJhkiCJgUvZ18BAQ?=
IronPort-PHdr: A9a23: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
 o3hhssHRw6jaA16/CY=
IronPort-Data: A9a23:BEhBaK+JkApbcY4hslgcDrUDKH+TJUtcMsCJ2f8bNWPcYEJGY0x3x
 zQdD23TPv2JZDSgL9F1aIu39E4Cu8Ddy95gQAY4q3wxFiIbosfsO4+Ufxz6V8+wBpSYFRo4t
 a3ySTViwOQcFCK0SsKFb+CJQUFUjP3OHPynYAL9EngZbRd+Tys8gg5Ulec8g4p56fC0GArlV
 ena+qUzBXf8s9JKGjNMg068gE431BjCkGtwlkAzY/lNoGjfmxE9ZH7IDfrpR5dQatA88t+SH
 44v/pnglo/q105F5ueer1rOWhZirog+neS5oiE+t6CK2nCur8Gpu0oxHKJ0hUx/011lkz3to
 TnkWFPZpQoBZ8XxdOohvxZwHCo5Mqhm0737LlOEiv656RTPbVmw6qA7ZK02FdVwFudfKFl83
 KRAcR09RFaIgPiuxr+nDOB3m99LwMvDZdxF/Cs6i2+fVK1OrZPrGs0m4fd70TM0l/duAPDRT
 8MCdCEpZxPFC/FKEg1NUMNix7j21hETdRV0sQ63oagWpFOKzVIvyIrnH+DvUdqjEJA9ckGw4
 ziuE37CKhIAJs2E2yaC/DSvgf3LmjzgW4M6ELy+/+RtxlqJyQQ7EAUXWlu8vOK0okG7UtNbb
 UcT/0IGt6849A+nUvH+Uge+rXrCuQQTM/JTCf8r8xORzaSS4AGLAm8bVT1AK9A6nMs3QzUw0
 RmOhdyBLTdotrqPCn6B3rSZtzW/PW4SN2BqTS0DQA8t4dz45oA/yBvSJv5qFqKvg8LdEjb8z
 juNqjMinagYkYgA0KD99E2vqz6huJnCQxIv6wj/QG2o9EV6aZSjaoju7kLUhd5ELYCEXhyIp
 n1BmMWE6u0KJZWMjzCWBuQLEqug6/uMPHvbm1EHN50g8Sm9vne4ZY1d7Bl6JVx1KYADazvga
 lSVvhlejLdXPX23fep0bpi3BsAC06ftD5LmW+rSY94IZYJ+HDJr5wk3OhTWhTqrzg51ysnTJ
 KumTCplNl5CYYwP8dZ8b711PWMDrszm+V7ueA==
IronPort-HdrOrdr: A9a23:P5QN8q7kGF71daX+QgPXwYSCI+orL9Y04lQ7vn2ZFiY7TiXIra
 yTdaoguCMc0AxhIk3Jmbi7Scu9qADnhONICO4qTP2ftWjdySCVxe5ZnO3fKlHbexEWs9Qtrp
 uIEJIOReEYb2IK9PoSiTPQe71Lrri6GeKT9J/jJh9WPEZXgspbnmJE43OgYypLrX59dP4E/f
 Snl6l6jgvlXU5SQtWwB3EDUeSGjcbMjojabRkPAANiwBWSjBuzgYSKXySw71M7aXdi0L0i+W
 /Kn0jS/aO4qcy2zRfayiv684lWot380dFObfb8xfT9aw+cxDpAVr4RG4FqjwpF491HL2xa0u
 Ukli1QfvibLUmhO11d7yGdnzUImwxel0MKgWXo/kcL5/aJAg7TwaJ69Ntkmtiw0Tt5gDkHup
 g7hV5w7PBsfE79dGCX3amXa/mu/nDE+kbLVYYo/iBiuUx3Us4PkWVXxjIqLL4QWC3984wpC+
 9oEYXV4+tXa0qTazTDsnBo28HEZAVEIv6qeDl3hiWu6UkgoFlpi08DgMAPlHYJ85wwD5FC+u
 TfK6xt0LVDVNUfY65xDPoIBZLfMB2EfTvcdGaJZVj3HqAOPHzA75bx/bUu/emvPJgF1oE7lp
 jNWE5R8WQyZ0XtA8uT24AjyGGFfEytGTD2js1O7ZlwvbPxALLtLC2YUVgr19Ctpv0Oa/erLs
 pb+KgmccMLAVGearqhhTeOKqW6AUNuIPEohg==
X-Talos-CUID: 9a23:tISw1GCjmx+eQPj6EyZss0EROusnTnL290ziCWnhAHhLFJTAHA==
X-Talos-MUID: 9a23:YNdQuwXAdnbdsz3q/BP12BNmNuYv2P2vVh4Vo58pgfOvMwUlbg==
X-IronPort-Anti-Spam-Filtered: true
Received: from unknown (HELO APZA001EXB.corpnet.asus) ([172.22.6.13])
  by ms.asus.com with ESMTP; 05 Mar 2024 12:04:55 +0800
Received: from APZA002EXB.corpnet.asus (172.22.6.14) by
 APZA001EXB.corpnet.asus (172.22.6.13) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 5 Mar 2024 12:04:54 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (104.47.26.108)
 by APZA002EXB.corpnet.asus (172.22.6.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28 via Frontend Transport; Tue, 5 Mar 2024 12:04:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gbxmx/LPoj07xJfrDmeFWAwSe6xd9NLdRGohVhklL7oyPI18z8AxOh5riPnNOxr/qKzOKUGA4KdZdsroqfhzO+NKfE9tJvWLCpzYvsdRlFbcZva26Yp5iR+hXpVBiC7jqIKJjEqJh1cWx9AHPaqQA4t4wydkd3jGJJME3NahQ55NlBQxoTXKmaD8/u9uMlv2DVVGz2OrzDxrn+mfqWZUyxG5j0YuH83vn/w9oaPW6HYARM7my6zxByHPP2PxZivKNVeQGlVkh8htYVzfISlwFrE/tvgcWJjzSGB1pvTW/xtOvsb7JvJcRPFjlF46qR2mCdh4rHo+Dlw7mjPnmfpRiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DCvQvKbr6xPBNQTbcGNK/7wcg+u7kyTCTYC0+imQB0o=;
 b=Y1/w1P+eonjxB2CFOe75AIP1pvYO3pinxzR5CUfJzYlfP4GCwcTDmG1Vr+Mx8VoVt1S05LH81yZjeuA6BcJslfa8taW4l/4XsG4gLYkTQo3IhlAQvwnt2gZAvdvpbXMjCisvWKlL5fN+HsvHyX+eYecqTh2eSsdFAmQN9ZMFBOdM18XK0eHTa6HIb8GxBjgGDTrN5MrESlkRvZUgewYhvADbN6JXq20dRDcvZHNxPM/ChGgC6oZPWLgvgVKyrnUkkcubS85Asil4r2XgejfuKascMJ6ciMNEKXML+Qgd2irDKofSVX29k/ACKKWGRWQVkuZeOkoMDrR7yQZfoRl5rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=asus.com; dmarc=pass action=none header.from=asus.com;
 dkim=pass header.d=asus.com; arc=none
Received: from TYZPR04MB6596.apcprd04.prod.outlook.com (2603:1096:400:28d::13)
 by TY0PR04MB6267.apcprd04.prod.outlook.com (2603:1096:400:265::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 04:04:52 +0000
Received: from TYZPR04MB6596.apcprd04.prod.outlook.com
 ([fe80::ceae:2258:3883:29e6]) by TYZPR04MB6596.apcprd04.prod.outlook.com
 ([fe80::ceae:2258:3883:29e6%3]) with mapi id 15.20.7339.035; Tue, 5 Mar 2024
 04:04:52 +0000
From: =?utf-8?B?S2VsbHkgSHVuZyjmtKrlmInojokp?= <Kelly_Hung@asus.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Kelly Hung
	<ppighouse@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>
CC: "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "joel@jms.id.au"
	<joel@jms.id.au>, "andrew@codeconstruct.com.au"
	<andrew@codeconstruct.com.au>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, =?utf-8?B?QWxsZW5ZWSBIc3Uo6Kix5bm85bKzKQ==?=
	<AllenYY_Hsu@asus.com>
Subject: RE: [PATCH] ARM: dts: aspeed: asus: Add ASUS X4TF BMC
Thread-Topic: [PATCH] ARM: dts: aspeed: asus: Add ASUS X4TF BMC
Thread-Index: AQHaU1pVz0U1vnDOQESBbDEICKEggLDyDdQAgAAcroCANo/RAA==
Date: Tue, 5 Mar 2024 04:04:52 +0000
Message-ID: <TYZPR04MB6596430000EF2FA3B32757759D222@TYZPR04MB6596.apcprd04.prod.outlook.com>
References: <20240130085652.198010-1-Kelly_Hung@asus.com>
 <20240130085652.198010-2-Kelly_Hung@asus.com>
 <c1dc602b-12aa-497a-8672-cb04cdb68ad2@linaro.org>
In-Reply-To: <c1dc602b-12aa-497a-8672-cb04cdb68ad2@linaro.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=asus.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYZPR04MB6596:EE_|TY0PR04MB6267:EE_
x-ms-office365-filtering-correlation-id: a48395be-a763-4b16-7b69-08dc3cc96910
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ojZHET9Jhi0M/EGq4tNiAFWpnr4swJkY0m8I18q79JhAOPmc92lpmeUjpwXFAOEa7dZkqkRKyuhpYTdlee3ybnqTf1MYL2dSYBm/rUHkk6cy4Um3gIf6sun7liCjlD80A+rmCxKFfCaEI8GkBhL1tt+/99OuspcuSxVHJ6Iijut4BLMzBbVhl9T2vcuSVMWluU56DAtaQwPRUnC4KYQ1nXJ+tiUCKlIcdgLnP4LEL5NcweDmBUkco/K+7H3W9rjy0k4XIri0e6108eV48y4Ak6oe+juO5P64T8XVPSqMbRs03E8pfoWtHVF0MYEHU+82pfhMBrZqeoKwxpFa9jjjJYoTf7bG0+5K0lIXQOandr2XeUfDevmv78oxu6nGD75vFVRLrqhPNAW4CC8u/JkCnQg+Mm/qjveK76Ha64skcC7D2voEjjTaXIBevra7ddk3xBqVmGd8GyfpSpxnMrGSvmJs+PeJ/9LYAP0F3uFS6fLhznbF3DepN5QHw12Z7s0gtyw2x6suFNQTTMS6cjnW8GErAa5Cgr6Q5PkxJyMqhGnmR+LlUi6+3Un52y4lhT11hho89qXpJTfqPkUq36gE17OyqYa4hpIRSWHBaqUX1Q6HW9JBt6OQdjemZ0LS4p55a5aDDd8OTuZGJlq4uSUm0xX5ak8mrcm+W8H6OJteFeMrL0w9d3+VqkUlNwMQdB+2mxn1PGXt1F/JjiNGNPq4wfy8/l7JqFm/gpXPvqeQWwE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:zh-tw;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR04MB6596.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RTBxNWthOFltY3dINFlFQnhMVlBkYmpWaTBHb0UzKzgyVGdPaUdjY3o1MXVq?=
 =?utf-8?B?aEdiU0Zia1piT0RVWWVuRElUVWFSU1A3UGhVNGVyUmxLaFRoNEx0cWpjVVFT?=
 =?utf-8?B?YUx0TzE4YjMvOTI1S25Zbmd2UXFCblc3RDJjTTl5OTdVNE04TFNmd3ZqZllJ?=
 =?utf-8?B?eW1aeUlMd0lFWGFyMG1ZSHVLVUsyZThEYVhiSy9SUXN1UUFUeFZNSlhiUUZG?=
 =?utf-8?B?QkI5Y2FiSFVwQXpVNTJXa1lyRE9KSzRndXo2cnFscHdMRDdEZ1RNZFpRQUpX?=
 =?utf-8?B?Z25xWk1scDhMbktpWW1TV1NlM0ptTC9hMDBRT0dVeUMzSnN1TE5EMUhqKzJn?=
 =?utf-8?B?T2hpVHdrRFJuZmtxT0FGUldWQjFUTkRHUTBiWHoxU3BJSjBweGg2ckRva3RR?=
 =?utf-8?B?V3BUUTRpVlB3cU9naUtpNDVxcUNUdXNmWU5TYjlKR3VwSWd5NlI2V013c2hk?=
 =?utf-8?B?aFZISG9oT2ViVWdDQWFFZ2QxdDZzdHAyZ2Q5aHNZeFd5bVZVczd6SENXZGJP?=
 =?utf-8?B?TEI4SFdsN3lnSm1JMjBheThsWnF6SmlGZFpFeThrSWZlQ1g1TndLNFJJaGZy?=
 =?utf-8?B?UXVBZnhacVZmWDdsWjJ0c1BsRzZYOW9BTWFRRnpZYVZLUUF3VGhranoxMjhy?=
 =?utf-8?B?ajFRaFVpTUQwYk43NHVvSWpJaDU4T3h3UkZLdFdiUFVBT1R6T2NIVlUrMkxz?=
 =?utf-8?B?UUMzaFphcU5GWlZadUJEOWFRWTd2N24yRnBqTjlZd1NmaG8rbjJ5WGwwK3BK?=
 =?utf-8?B?RTYvNkRsZXNKV0txZXdhaG1BTnRXUGVDV1JhY1lkUmpiSXlCOHdTM0wxQi9J?=
 =?utf-8?B?MnYvTWtpb2hkVGc5ZFNmejdPM0VyaWVzb25PSWNOTWFKMnRKSko0b3BiT0Vz?=
 =?utf-8?B?em5MbHZQRjlsbHB1NUJYaXk4YXE2NmVQc3dSc20vcHNIdGsrZE00ZWRENHhz?=
 =?utf-8?B?cWNmNnNjLyttUnVWY1Nwa2dIY3BOZm5IeUZ3b3FMSVFWL2tncGR3a0I2S01x?=
 =?utf-8?B?dEtiRGJaUTFLMllPSU1HYXZIcnFIRG0yRExMSVB2c1J0V3JNSC80Uk5wMW1H?=
 =?utf-8?B?RmUvQXAyRnRWQmxzbDNiWjQ2WTRCZUJoSHQ3Q1YybEhTT3MwU2F0NmlENUJF?=
 =?utf-8?B?QTJmV1o3RWdsNXBYRmlBTG95am9MRVl1OXV6YTNockkwb3VrREtsQVY2aVNZ?=
 =?utf-8?B?clplNXI3UHUrSjlRQXFpeWVhSkdRWHEzRmU0UUJ0MFNwQmtlTGMxdG45YUtn?=
 =?utf-8?B?VE1aaGUrc0JkY0FBbXErOENiMS9UT0RwanQvNGZVOFh4bm9XTk5vaEo5Unpq?=
 =?utf-8?B?SjNJem4yVHBzT1JxUWNOQ0I1eEdqWGxOTVRUVnVjZHlUTEY4QkNQcVB5RHMx?=
 =?utf-8?B?VVQva3Vpc09QbEMzN1NZcUZpakhzWVNNanVvdi8rNy9jT3BxZGF4MllaWlJn?=
 =?utf-8?B?YmFrTm1XVlJ6TE9CT2hCVDI2Uk1qUlVLNDZQR0lkdXlOQ0tIVjVxdW5ieWJz?=
 =?utf-8?B?TUYrZEdMZ3Z3TXVFanFmKzhGeGhNdEsvK01yY1laUUFXZS85SjVCdFdVRmM1?=
 =?utf-8?B?QkVPdVZSQWhQOFVYVkl2NzdrUWxsc1djRkswc2hXbVlHN01PR3VvWm44amZo?=
 =?utf-8?B?bUFQcER0d2toamhXODBrQk5wT0tGTXhKTG9SaFUyWkozdXczbUpZU1RzeENJ?=
 =?utf-8?B?MXFaVkZWTWFlTmFzZXFENlR2Z1VhNkdrcEs0eHE0STY0bHNwdnVtcEs1bzUx?=
 =?utf-8?B?bkNqU2daNDR1enIyNWFJSHpXUitqc0hha2pXZXcxcWZBNDVBaFQ2b2llVHpH?=
 =?utf-8?B?RHJNZUhUNGFZb3REaFVlamhRUHdYOEZIYzJmaHg3YkgrbnVtVU1VZ2w5UkFx?=
 =?utf-8?B?T00ybmJnNXNUUzU1WXQ2V201M1JQSGt1a0xUVjlQcGF2SVF4aE1sYmZvRk5t?=
 =?utf-8?B?SlYzaFY4UE1wNUIram5meTJmYzduZFVHa3laT2JLZ0ZvYWRNNk1CZHhzS01m?=
 =?utf-8?B?Y0pPL3NoYmM3UWNncUpTbTJXYjF6ZnJULzhIanNNb01TRmx2OWMrN2lMajhS?=
 =?utf-8?B?TUdLMU9JYlNOTFRWWmF5UXVRaVBjYzhjYVpZNGIrRmNJVkVMM3pOTHdqL0JZ?=
 =?utf-8?Q?jYJsmdKNfFJzRlxGT6zUgoWSE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYZPR04MB6596.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a48395be-a763-4b16-7b69-08dc3cc96910
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Mar 2024 04:04:52.8241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 301f59c4-c269-4a66-8a8c-f5daab211fa3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZoFpduJg/xODQ/1BtSNkNvwYoiyD1phMDHdozpgRLq2vUjHcOgcCfZP8twGdnopCpUSNJfs7SLXlDvnlFUd5wg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB6267
X-OriginatorOrg: ASUS.com
X-TM-AS-Product-Ver: SMEX-14.0.0.3197-9.1.2019-28232.001
X-TM-AS-Result: No-10--14.872900-8.000000
X-TMASE-MatchedRID: csPTYAMX1+H5ETspAEX/nh4g9sNAOK6GET56SaIP1M9rCeDLQ4/ueY3W
	UTA/WwJAbMfz7GIBeY6o9XaKRAPTbjtTpXlgTP+n49YPmLx5ryajiIJqRFExTZOCyMF3fA3/fHe
	DyUgVCF8d79Smn/h5xMBpfYymAZLfw1Ig1YPEDndsBBK+dj8AxczxpgphKt9T7cMpRZQWIiyvng
	kjHjojpIsbA2pKD5UGiw//l/NOpJaOE5LwLFwrNKJYuGaIjh0/IOKWWMbJYW077qjv6+rnxIapX
	62+c/wA7W8bsBibn14u2vyI5+Wtq5l0oUhHFbMx
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.872900-8.000000
X-TMASE-Version: SMEX-14.0.0.3197-9.1.2019-28232.001
X-TM-SNTS-SMTP:
	6029BE5634E54EEBF6D39DD18BFFFCA5C5676035604ED9C5B80EEAC99A0E17422000:8

SGksIEtyenlzenRvZiwNCkknbGwgdXNlIHRoZSBmdWxsIG5hbWUgaW4gZnV0dXJlIHBhdGNoZXMu
DQpUaGFua3MgZm9yIHJlbWluZGluZy4NCg0KQmVzdCBSZWdhcmRzDQpLZWxseQ0KDQotLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9m
Lmtvemxvd3NraUBsaW5hcm8ub3JnPg0KU2VudDogVHVlc2RheSwgSmFudWFyeSAzMCwgMjAyNCA2
OjQwIFBNDQpUbzogS2VsbHkgSHVuZyA8cHBpZ2hvdXNlQGdtYWlsLmNvbT47IHJvYmgrZHRAa2Vy
bmVsLm9yZw0KQ2M6IGtyenlzenRvZi5rb3psb3dza2krZHRAbGluYXJvLm9yZzsgY29ub3IrZHRA
a2VybmVsLm9yZzsgam9lbEBqbXMuaWQuYXU7IGFuZHJld0Bjb2RlY29uc3RydWN0LmNvbS5hdTsg
ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsgbGludXgtYXNwZWVkQGxpc3RzLm96bGFicy5vcmc7IGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc7IEtlbGx5IEh1bmco5rSq5ZiJ6I6JKSA8S2VsbHlfSHVuZ0Bhc3VzLmNvbT4N
ClN1YmplY3Q6IFJlOiBbUEFUQ0hdIEFSTTogZHRzOiBhc3BlZWQ6IGFzdXM6IEFkZCBBU1VTIFg0
VEYgQk1DDQoNCkV4dGVybmFsIGVtYWlsIDogRW5zdXJlIHlvdXIgZW1haWwgaXMgc2VjdXJlIGJl
Zm9yZSBvcGVuaW5nIGxpbmtzIGFuZCBhdHRhY2htZW50cy4NCg0KT24gMzAvMDEvMjAyNCAwOTo1
NiwgS2VsbHkgSHVuZyB3cm90ZToNCj4gRnJvbToga2VsbHkxNzMyMDAwIDxLZWxseV9IdW5nQGFz
dXMuY29tPg0KPg0KPiBUaGlzIGluaXRpYWwgZGV2aWNlLXRyZWUgcHJvdmlkZXMgdGhlIG5lY2Vz
c2FyeSBjb25maWd1cmF0aW9uIGZvcg0KPiBiYXNpYyBCTUMgZnVuY3Rpb25hbGl0eSBhbmQgd29y
ayBvbiBBU1VTIFg0VEYgcHJvZHVjdGlvbi4NCj4NCj4gU2lnbmVkLW9mZi1ieToga2VsbHkxNzMy
MDAwIDxLZWxseV9IdW5nQGFzdXMuY29tPg0KDQpQbGVhc2UgdXNlIGZ1bGwgbmFtZS4NCg0KQmVz
dCByZWdhcmRzLA0KS3J6eXN6dG9mDQoNCg0KPHA+PC9wPg0KPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NClRo
aXMgZW1haWwgYW5kIGFueSBhdHRhY2htZW50cyB0byBpdCBjb250YWluIGNvbmZpZGVudGlhbCBp
bmZvcm1hdGlvbiBhbmQgYXJlIGludGVuZGVkIHNvbGVseSBmb3IgdGhlIHVzZSBvZiB0aGUgaW5k
aXZpZHVhbCB0byB3aG9tIGl0IGlzIGFkZHJlc3NlZC4gSWYgeW91IGFyZSBub3QgdGhlIGludGVu
ZGVkIHJlY2lwaWVudCBvciByZWNlaXZlIGl0IGFjY2lkZW50YWxseSwgcGxlYXNlIGltbWVkaWF0
ZWx5IG5vdGlmeSB0aGUgc2VuZGVyIGJ5IGUtbWFpbCBhbmQgZGVsZXRlIHRoZSBtZXNzYWdlIGFu
ZCBhbnkgYXR0YWNobWVudHMgZnJvbSB5b3VyIGNvbXB1dGVyIHN5c3RlbSwgYW5kIGRlc3Ryb3kg
YWxsIGhhcmQgY29waWVzLiBQbGVhc2UgYmUgYWR2aXNlZCB0aGF0IGFueSB1bmF1dGhvcml6ZWQg
ZGlzY2xvc3VyZSwgY29weWluZywgZGlzdHJpYnV0aW9uIG9yIGFueSBhY3Rpb24gdGFrZW4gb3Ig
b21pdHRlZCBpbiByZWxpYW5jZSBvbiB0aGlzLCBpcyBpbGxlZ2FsIGFuZCBwcm9oaWJpdGVkLiBB
bnkgdmlld3Mgb3Igb3BpbmlvbnMgZXhwcmVzc2VkIGFyZSBzb2xlbHkgdGhvc2Ugb2YgdGhlIGF1
dGhvciBhbmQgZG8gbm90IHJlcHJlc2VudCB0aG9zZSBvZiBBU1VTVGVLLg0KDQpGb3IgcHJpY2lu
ZyBpbmZvcm1hdGlvbiwgQVNVUyBpcyBvbmx5IGVudGl0bGVkIHRvIHNldCBhIHJlY29tbWVuZGF0
aW9uIHJlc2FsZSBwcmljZS4gQWxsIGN1c3RvbWVycyBhcmUgZnJlZSB0byBzZXQgdGhlaXIgb3du
IHByaWNlIGFzIHRoZXkgd2lzaC4NCj09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo=

