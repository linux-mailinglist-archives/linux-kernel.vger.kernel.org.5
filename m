Return-Path: <linux-kernel+bounces-128238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C240895828
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EC261C225F2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FF413173F;
	Tue,  2 Apr 2024 15:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="zvRe/aJc";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="PDaofFwb"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13C585262;
	Tue,  2 Apr 2024 15:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712071724; cv=fail; b=rwGxE7RazN5TbqKcc/LrzedzmVKh/ML5KJ7np6809mqKmhwaTsh56sm4YZm0EHzSAH++x3F3h1QtHgngeLkVUo1o9DkEGxcpm0JcQCvYaMHdLZeEsBj/mohEcnktk3Q/8EBNLa1Qh6qhy3Daw9GMA0B0B6G4EElyDnWTai6hIwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712071724; c=relaxed/simple;
	bh=GSM0wyNA7ww1bt7FXdGfOCzmRUO7WTj/IgUXnsjYAYU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qdCu3o/vrZV0ZG+j8YabfaeUq91pGOpx94KctGPLkaMa/xzw3ciUgyiOrDj9H4xYxyzFixMSOtiyaq5/PnsZXsapqDD11UJFGuO3r0Eerz20teeq1D8sy9iR8wIaV5UIaGhVbRJ80pZkMQmxcM6wGdB6blM239PT6NxWr9Mi+7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=zvRe/aJc; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=PDaofFwb; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712071721; x=1743607721;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=GSM0wyNA7ww1bt7FXdGfOCzmRUO7WTj/IgUXnsjYAYU=;
  b=zvRe/aJcuzwoZDfE9FSi9jIHzz2PPT+9WJUkioQZ/uJYGJcLdXCUC7u0
   fRszL65tlXulUUXSZrqN9iab5lbx1ve6pjrEZ8I1/+K73qZ/nWK3+Orx2
   c0ktoTJBA8fh14nNoDjohR2En3cIa3HHZcdeFZsJO3/1vNS/p5MDmt5ul
   uW1o5g3ELNDOK5xgZQIDxRK8MgENVIk9aSDgRrdj3pJge4CyiK19gg93x
   zYeT7UFjjg43eoigWshfLL7QxYUw1Vl8KdBB9OD19kyqYBrS3CHBLl4Af
   KTgjkyRIXdxom3+YjLtRAF4E3CQItI9McnOhADXPm93uk9fN49ejAVaMP
   g==;
X-CSE-ConnectionGUID: ZOJgTcHqSnOIk9vxbkcJDw==
X-CSE-MsgGUID: POcYJcwES6+lLGjW/FlBHg==
X-IronPort-AV: E=Sophos;i="6.07,175,1708412400"; 
   d="scan'208";a="21075309"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Apr 2024 08:28:40 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 08:28:04 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 08:28:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DxPU9AIVYm3/RUDKuAGf8oLpR3blRc92Wk0rz4/3LPybbekDO7I/1eJim9ahxfsejbulQfVEOObPZbF2Dxt4b+6/3CjVLo5CpNMrilVhLnw7XSquhtdXcYUFOn0OOFmUPJjdBJn6NZXYLa2eLAf9kYXa8jQfevZqfZaYZQEWesIn5ePkLXssZydDO13RtirR63plVfC8jKrgzNwqNT8NtG7xNZOQcwBhfCwjMn+osoNOUB2aOvXg7LLJOVuWv2EWFsfJAsiE8OlYvUm/CO5pqYdyRzqxXhqvi4R4dTz6EU9+R6JUDU8cgDHd9Bd9+V051YsaEQ/3X8fvQzdazWTjHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSM0wyNA7ww1bt7FXdGfOCzmRUO7WTj/IgUXnsjYAYU=;
 b=IBRjXzVBzawIcNXU7Q5HC1kwQBe/zENQb1WkvzOjwwygFRhJSdXT+LASkPQ4CEJJ3K43J412BORXDWhrBNgXrJtJkP2rJuc7OhumrKPxYJOkggZ/ixg3idyuK+4wvCf0+ETFLYTO4nU92CeDmSXQRkyqxRTsC9nvjNGNuRV4pKj8e+rlA3DHutbdqP+tsYYolPfdcY/2qXr6fsGSP5sJ1zon1uuyGoV+ZDIukxl2+3TXAIwk9/zhmFjAiAw1bJaY2yWYDVUjcMsckVFupuhK7d7u01FRDjxNUNtupLisOZwlPFncYj9A/6EhbIFrGGlG6hZWu0XI6lGD7lyEzy5/zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSM0wyNA7ww1bt7FXdGfOCzmRUO7WTj/IgUXnsjYAYU=;
 b=PDaofFwbHk7VrLjNW6sPPdCOlYmwmxjdAgrpkGePXgrRoyXjFYrftzd2qPSlTLWtjctWBCHO2LUd6ddzsz+QIq0k/3Ii6ZTNK4HZjM6O/xL7nWWuznqVlFvHqKYkyBlUgpIju0/iioq3FupQU0luN/PbO16Y/V00MZDrtD2ZlqRzsORptelRYKjwIfXITGLWSEh5F3RzNbvojR2bgrHn4i/JusQneyUIF6Mzbce3SosZrzAH+kvQJLBhP/oVJnMJZjT/S683+TkuCoJgTalNYr0p4jDeVBJvJCGh6RuiuPWixyiyxKizOQknnYYYI0i25zC+qqXpaD1BBecW4fEDfQ==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by MW3PR11MB4649.namprd11.prod.outlook.com (2603:10b6:303:5b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 2 Apr
 2024 15:28:02 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d%3]) with mapi id 15.20.7409.031; Tue, 2 Apr 2024
 15:28:02 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <kernel@pengutronix.de>, <san@skov.dk>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v1 1/8] net: dsa: microchip: Remove unused FDB
 timestamp support in ksz8_r_dyn_mac_table()
Thread-Topic: [PATCH net-next v1 1/8] net: dsa: microchip: Remove unused FDB
 timestamp support in ksz8_r_dyn_mac_table()
Thread-Index: AQHahP+hzR/idaVB7Ee8QVvIt5mYQ7FVGxUA
Date: Tue, 2 Apr 2024 15:28:02 +0000
Message-ID: <d770dbda6b910f068ee34a33e72a45ba78813017.camel@microchip.com>
References: <20240402131339.1525330-1-o.rempel@pengutronix.de>
	 <20240402131339.1525330-2-o.rempel@pengutronix.de>
In-Reply-To: <20240402131339.1525330-2-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|MW3PR11MB4649:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lw+pbirVYQ31qJq9hNLv84Hu2ls06aTUbjaA9w5OEpXK8/w0L+J5yqSnEdGXoIUmfUZtG03boKJ0OxRSZKtiPS8DisS/n10eyJpz5NnkbgdAb3/hsg68b63Df5OPoirQKc9ejZk1jc2tUi51LcFdH0m8EgCls/k6h7fi6jIxKz8b0jibxCMkrZCYBb9ksX1pZx5g+PIaO3b7SanO0WPwk9OGEUxk7eQxEhgxfOg4Uz0zcE4InWpxG5Qj7tPwHPZHEYIGILcTx/sNCZnSBBrJRb224OIDE3zuP2SJdLlcibaReLo2HDxip2YShhZ2mRGSmUU/vbvrB1s6sFXL+hl54/7pgR2gm1gLdTSyU3yAVBSEl9VoPayNgtBDf/H2h5a/S/THnvJnGtzy52iklt8tzIDXZVQBoBHeK/TgtempsOnjVoWoGKdBjoYhEzUPe0hL0xzd1msS3sLBo915+qUHm2Bp6jkt90Q9ov3zBdD9bXaFc1v/hdoAql4MkSpCTWUu6E6KQJ8gqhfOTrivu5sKUFDz1nk+6S1r4O3xroF2dxLisfpuBSyMPuojcX+aNm3ZvxX3uidpV+li8F8vR9JJGdco1363pMXQ9lxzcId9ENkdyR9VuFCd+42dh4LelqF4rwuWIe842DEDRNR12x+cT7SN/PD6he1gIsUDmBK0jeI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TSt2ZndRK05uMjV2ZEg1b1JtNmRLaXpZQkF0SHlTMmdiSUFrK3ZzbmhMcEtU?=
 =?utf-8?B?cEg3THZDcFUzMlRpRy9HUjRmR1ROVmlWWUF5VmZlWEhENFdXQUgyQzViMHkw?=
 =?utf-8?B?WjhYemFmemJ4Uk1SR28rdXJsT2Vqcml3b3VuZTByY285cDMzRi9sbUpEeTNI?=
 =?utf-8?B?WHVVRlBxZFBzWjlaV1pTZDhVL3F5Y3I2Sno1UDBQZmxxUDZCbzJ0dE1qeGlR?=
 =?utf-8?B?M1JWUVBDZDFhbGdHVHJMaFVma1dxWFRrZHlzc0o3RlZicWJZY2xiZVpSS3pX?=
 =?utf-8?B?TGU5b1FMVUF2dks1Q2wvVzJ1eStnbTQ2SHVtRm1IbEdoL1FSRnBValJtUW9U?=
 =?utf-8?B?VjdSYUFmanJUd1FseTRrSG5oeThUZmFjUFpITmRwVnJNRU9mTWw2ajN1alBk?=
 =?utf-8?B?bzE2cmZSL216aFllM3pSYS96OFJMTXJhU3dkTWlPcmd6aklWaURGaEhldnBD?=
 =?utf-8?B?aDBUOW5QcnhEL2pWZ0Z2eWVzQzZySTh2dkdhK0Q5dnNaUEJMdmI3WWU5K2Iy?=
 =?utf-8?B?TEYwOWhieXN6RjlhL0R6NkZaU0IvVTVWTHhVL2RzMEZqMlRaVG05SVUrc0hj?=
 =?utf-8?B?ZkZpeXFSK0wxS09Rd0g1SFBRN1YwNGtjZVlrNUFpNGdza3pKNEkxVHduTTBt?=
 =?utf-8?B?RkZoTzBGb0ZCblk2NUY2RVd1cU1HbEZPRHRvNXJob1NSZkVHUzhON0FHcWJv?=
 =?utf-8?B?UWt2L2t3dS9ZVmQ0S05KemYzQk4vR1VYL0tCSVdUekE2b2pkWG1WclBJM2xL?=
 =?utf-8?B?UnFvb0lqamNXcWhCT1RhU3BBWkJqa2w3ZmxtV1g3ME15RjZnaG0xNEdFdUxo?=
 =?utf-8?B?eGw1bGliaG85U3RZcU15VDhUd2JiT25KbnBiZThaYndlb1lvMVhFc0dsMXJj?=
 =?utf-8?B?Q0llaUNLWldNVFRBZ2dTU3dlVjh2aDFSWE1VaWErSjA4UG5FQ3o4Ykg2WVNU?=
 =?utf-8?B?K2VIaFZ5V2IrRWFVNXh6NlRjeE0wZ1hiZ1pqb2NLanhZb296RUVOMmNkREJ5?=
 =?utf-8?B?SXRQUWpUZ3k4cnpndDFGY0Q1bnV3aWUrR3YwRXdsOFdCd1E3QkU5SHRvMFZS?=
 =?utf-8?B?ZnhaVDNLM3lPeEdDWXR6MjM5cWRnU0N3R29vYVcycUlDZkc0UW8vMzBpZWZR?=
 =?utf-8?B?VEI2NUJTc0dubjJaQ2Q3R08zUmlSZWxqMXBiM1pGSTU2U1d0cjRwK29qalBQ?=
 =?utf-8?B?RTVMd1hpNEREU2pnaVBKT2hlcUNaZ1BiaWMxMGRIRTdrWHVSV1J2bEVjdDJ6?=
 =?utf-8?B?NHkrOGlmTzNRRUwwZ256RjJURUJvbUhZU0QxZmwyR0VWbG9ZQTNKeVc3L1BQ?=
 =?utf-8?B?T2ptcVlZU1NJMHBRZmhiWFQrRW1ia2NVMDROZEJCODdiNkU4dEFSUi9hRmtE?=
 =?utf-8?B?eTQzRi9IeUhWZkh3ejN6NmpYbmwvdTFUZHI5dWt2RmdZOVhyZ3IrdGR6TnBx?=
 =?utf-8?B?Rm9Ma3dLdG1aWGg2dlN5Y2pWdkVWdklGaUR0QjA3Sk10U2ZDY3JVU01BRWYz?=
 =?utf-8?B?U2I1cDlrRXBqVENENVpCY01BVWFjU1ZpQmdIZUZBZmlIbllSbXFydXF3RTVu?=
 =?utf-8?B?VFZVTlVtKzJ4RjRpeUQxRGJHblVsVVI0ZkZBYXVNbjZUZTVZUW9Kb05NdEo4?=
 =?utf-8?B?Vk8weVpOSlVNNVduRnRJSU91dHIyRG1mTkpOYk82MzJiZlpwZ3FOYjhZcGxi?=
 =?utf-8?B?UGYrTy9zQXdZYVl6MTNtazFTY05pNW5Kbk5uVVZvbXZGMGo5YU1OZk0rQi8r?=
 =?utf-8?B?dTdvT0VuU0Q0MW8xT0IzL1ArZ3cxWGROMTJuNEt2b1Y2RmhxRlpBOSs5eTU2?=
 =?utf-8?B?TEtuelg5dUhvcXgzL1RGSEhqR3JDOXNJWi9NbksrNndMRU9zZHF5R0I0ZmJ3?=
 =?utf-8?B?NDNEVmRyeUNsd3dRNkhSVFdsSDRRdVR0SjNrcXEwTjhuWCtzZ0wreVlkcndR?=
 =?utf-8?B?d1Z0dVBhQVY3c244dWlCSW83NDNtWmdxSFhQRmpZQjFjL29Ib2pIcHM4R2Yz?=
 =?utf-8?B?ZHBiOHIrSUVkTUpHUlIxQ3luVlkzdmxpWGY1OVBTS2JCbUFaSXRMTjcxS3p6?=
 =?utf-8?B?ZFFONy9IR1FtZ2tEdFVKT0hzQUphVFpJaS9EREdjaWUzbFVXRlg2SUFkUUVm?=
 =?utf-8?B?eXJhd05CTHp4ODU5VVExc2hZc2h5a0l5dDBobjBFVEl6bG13MEJTeGJtOEJu?=
 =?utf-8?B?MlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E6B087F3354104AAE31CE961A12DC18@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b68f03b4-894a-40ff-23ab-08dc53297c74
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 15:28:02.6200
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b4F5TkqgZ6E+/VZnaR6+eqKGhHHCqnxd2IlRVj6wMqzjXJgCIze7yWZFtxiAUtlnJyJAhXlOC2yfYXmpJhlUjzQ3H9TMOIGMTZEdxH7HQaM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4649

SGkgT2xla3NpaiwNCg0KT24gVHVlLCAyMDI0LTA0LTAyIGF0IDE1OjEzICswMjAwLCBPbGVrc2lq
IFJlbXBlbCB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+
IA0KPiBUaGUgRkRCIHRpbWVzdGFtcHMgYXJlIG5vdCBiZWluZyB1dGlsaXplZC4gVGhpcyBjb21t
aXQgcmVtb3ZlcyB0aGUNCj4gdW51c2VkIHRpbWVzdGFtcCBzdXBwb3J0IGZyb20ga3N6OF9yX2R5
bl9tYWNfdGFibGUoKSBmdW5jdGlvbi4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE9sZWtzaWogUmVt
cGVsIDxvLnJlbXBlbEBwZW5ndXRyb25peC5kZT4NCg0KQWNrZWQtYnk6IEFydW4gUmFtYWRvc3Mg
PGFydW4ucmFtYWRvc3NAbWljcm9jaGlwLmNvbT4NCg0K

