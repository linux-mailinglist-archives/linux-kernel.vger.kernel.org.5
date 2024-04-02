Return-Path: <linux-kernel+bounces-128276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07913895893
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AB041C24070
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53D96135A40;
	Tue,  2 Apr 2024 15:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KICY3Q7T";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HFzLsS/2"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845FA132C19;
	Tue,  2 Apr 2024 15:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.153.233
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712072782; cv=fail; b=UO78MQ4ej7ijr2R4/1UIQjV4F3OkKt2x4ven+6YjllI7lld9awkqoM8B4bnKuT3wutkGRe5ynyUuHey6K43hmC6NODz80HlzqDq3/5xmLVRvcDunEeJzm1RYvf/ufPqT228aCfbva4fflY+9Q0TYwP+ijc78uhWO+hOV6Kk/5Es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712072782; c=relaxed/simple;
	bh=Qawpq9gaSaBxyqXRa6Be7L4YNjwJfpa6mBryxq8p8ls=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=hqf5qOg8WMj/jCBXSK+80kL9AoilDSb0HOcH3XIAim8atXDddMZZBif+CW2yydkFJ/pb1HFkN4JmdJcviMryKu++NZHUbG178L9y3wQ7G4qEUChR7EoKC8L1iJNzl+KT569UoVQke3mofeTFWET7ch7YuKtzBkVvro1Lnq9qNiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KICY3Q7T; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HFzLsS/2; arc=fail smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712072780; x=1743608780;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Qawpq9gaSaBxyqXRa6Be7L4YNjwJfpa6mBryxq8p8ls=;
  b=KICY3Q7T6oedJMlF48XQ4jG9dQjSUoUc82lNffTUncCfpQCyWFCLfvBR
   MeBL0VlBMGO+qlYlkJP9cm/hL8d0LJB4il0DVjyrmQTaLEg3vY7QIXxe8
   lvhH1hbRpjuV79cAbhNnxFUhgHByvAM2qp8w9qLbQBveYXmvE0FhQJiol
   SHJzQ981AWl9L1XRmTww4WJqFGzts2YaizyrLnNXOeVig0rfYkuI0gq9D
   7bBtD6RqisR7t5mJlli2vhMccmKpT1S7im5px64fxeHgUSBYnLWPyezRH
   HURsSQMuMIGTicoyq9WZlTqhpbE8dY6UrQm07Jvu5aVaA9wJYKdkaWlss
   g==;
X-CSE-ConnectionGUID: GiBjbXcMSZq0Sn35jAxgOA==
X-CSE-MsgGUID: Y27So6oWTbmjN4ZHE/a0Tg==
X-IronPort-AV: E=Sophos;i="6.07,175,1708412400"; 
   d="scan'208";a="21078123"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Apr 2024 08:46:19 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 08:45:57 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 08:45:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KZ2ATH/5R3Le4p8BuUWcsWLRNCd4M4Manx65gqqRCyqa04aptkEgl6X6b0Ij4AwfiGRWD9pezrcR/obCR4uWdzh02mUstHQDC8SGcfVx0recQFgokVzfACn1qMmJaY89UckvycPRYE4D0Rt4M82W9rhJ3K16d7Af5hAc1QZAmHqooJ3ooxwptEXdNzjmDi3iI7YIPzoaZIXmRWRlEm9qrlUMYqov0m5hNvATx59YiOJk5ypi5Jh5eUez1WWzr6/hLevRRFTnYSk5wCLlsmxXWUC1yoFLEy3QI7lNEIZFSs/VqdEDmFzy88py2dgS73nmtcL03FAB7ZwsNDbPq3eZMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qawpq9gaSaBxyqXRa6Be7L4YNjwJfpa6mBryxq8p8ls=;
 b=jJnuocO64mL9dZMQcilSR8oJEKkCcyycxWRksTwVs2dLn+LkInHkQ6L3jD9V7W606lunW+qEOTRt/STQ8UkYASe+0R8Hc1Pyi3g/zTMbP2aPTnpaORo/mFEULWLr0SMnFB6EtDR7a/Hxf1QzH8U7hc6S1d5dIDWKnhQRgRdlwEaKKv8DjMgbCSDsQCaDDenq9YKR5joGjihHzDgYV8/BXiqBaDzpA7hQSgWO6+6yN5FcgLkdfknqXKZTSI1HsLkcR3evFK+oUvMxt5l7IvWG4VTxugDLvTL3ePjiAgGvKPdHOwpVy7CRqrdkAUpuwJS1/RWhfJSeX0rNz9drKo4aGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qawpq9gaSaBxyqXRa6Be7L4YNjwJfpa6mBryxq8p8ls=;
 b=HFzLsS/2pkN6l6hqGOQbw9pbOmISJ+BBlwvT6AOn/idZ3VJdqTYtQ2fqMSuGPK7KiY4D3YlCOJpsZZDH1uU71lrGi47sEbZKPZDkkXGaOiJsntNfUWmkdWkkR/++JA6yeUNcK7jBQcrAobdTbRZ6BeW1xoDErGbpzM+IU3D6aEnQUbpgXac+xZDOoatzSaNtFWcJ49XyJtxXPZqVT/k6em9X1gxCNWJzxKKiTr5j8KsYZhQ47nhPOFWS41OwBj9T4FhPZYmjcbXx0JmdJ2cVkmKBv+LZ1ORBvj1q8Oo0hyqbtfd9v3OOQSkQSsRlRpRnWYpcl9zy+MUdd+fVPjQwfg==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by SN7PR11MB6604.namprd11.prod.outlook.com (2603:10b6:806:270::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Tue, 2 Apr
 2024 15:45:54 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d%3]) with mapi id 15.20.7409.031; Tue, 2 Apr 2024
 15:45:54 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <kernel@pengutronix.de>, <san@skov.dk>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v1 5/8] net: dsa: microchip: ksz8: Unify variable
 naming in ksz8_r_dyn_mac_table()
Thread-Topic: [PATCH net-next v1 5/8] net: dsa: microchip: ksz8: Unify
 variable naming in ksz8_r_dyn_mac_table()
Thread-Index: AQHahP+k3j2XRzM8L0i3TQx9T6gG/7FVIBMA
Date: Tue, 2 Apr 2024 15:45:54 +0000
Message-ID: <2fb0049162ce4513e2b9abfd873b35b12cd117d8.camel@microchip.com>
References: <20240402131339.1525330-1-o.rempel@pengutronix.de>
	 <20240402131339.1525330-6-o.rempel@pengutronix.de>
In-Reply-To: <20240402131339.1525330-6-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|SN7PR11MB6604:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wiMd3WRy6WKmqqkllxVg41M2jtnew8xHR9+oXVTtEsId8iZvrzwHz2cCDy46zMMla6oKIdy/6Jvgz8wxMzkUr9CGhMRRwMueObHbdIRJxbMUvMdGBGDdO7cZ43NG34x9T6pMBOaQXeCg/TOlc0arspXWyGjXKsbcp1QKcs8C9GNEXlzJ68fvsx4JtndOlFaUngxOVGOJHVNIJYgs3WGdAEL8rC6b4URBji7uhXE0YM0yiRnIwRV1KmOTGKqXA7YF8hIZAtxS4nSkdAYn9m4J83IXjPKCyGYgQ/0UqXNhZXrc71qeJbt9ZRWtE9QQ+UqOqoznI8sbwTXGD8HOvDGv9yJdy90tl+79V45sFN8eXmGFEYOqNjrR+xHQJE03J8DTa3Gw9moyL3YX+fsHyma3XLQ8V40cAUNrssztvOXgqcwCyril1caYpLubUe5PzQLogT2PTHSbzi6m7rqQGVnElK4QL6u2WZ9PjJFSAZnBdX9zjUEzniiePgkReF7AtUxMWGgXdE5eWe/xProX0KAlxy9o/EK4n1ZaA9YGJLnRZ8WPY2nD1z3faWbpnrnP2JWzPwwdQiiJBGcpyWUljO0YxQsJIewkx4k2kvCYAqvlOD98DYvGI4ChFL+FB1O5Uf96CfS0mJJArnHwtFz4RM9qaQ29NVxh2pqEFafnFbsR4dU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGxsZzNtaVpSVE5teGVCWFc0a3BWZStNNkI4QkR1MFN0U005UjVzOHBxMVpj?=
 =?utf-8?B?TGIvcDJKS05Ed3VZTkRUL1kraTM5RlUrY0UzOU9BL2dwL3FRV2hyZFk2bUFx?=
 =?utf-8?B?RTdWam9HeEtPOG5lRkZ3N3RvWm1qbElhcFkyVXFGK3UvUFNpeHVmVWx2SlVB?=
 =?utf-8?B?Qjl3b0UzSTVIZWV1bm9DdHoxa1hHbldKcFFURjk4NEdGaWl6L2dEbENVZks1?=
 =?utf-8?B?bGx3ZFd0VVVEWmFBakU5bjR6Uyt6T1oyY1RhMjhzb1NtaVFQRGFXR1FTQUFN?=
 =?utf-8?B?SWd6OUIwVjI4T3pXQkpBZDZ6THpxb0NkcVdxUjQxaDVKSElNUjRlVGpDOHFr?=
 =?utf-8?B?MkVYL1BVSGpVcmMwa2hBOTdGcks3Z0JhTUc5TnljRnRrbk9jc2RsVkZLTkVR?=
 =?utf-8?B?NTFGNHBFNTcwQjA1d0Y0ZDVVdEZxMnBqQ1RycytjTy9sU3FucjlJSS85UTZQ?=
 =?utf-8?B?K3RpRG9GNjBHckFOcVVUc1JaOS84cFpBeWVTMEtVWlNVcjRYS1ROY2JLL1dr?=
 =?utf-8?B?RWpjektOVWtvS3JhMTVwWHkyZDB3VjVabEcva2VlMmlGOGVjM0JubDd0NlJD?=
 =?utf-8?B?QXdHMG5OcHUwRW1ieklGZEJwM0ZxVm9zNkM3cW9sYkx1MVJIY2IxVlNBOEVr?=
 =?utf-8?B?d244Vm5EbFFmN2dyc084UDdZZWpETFMvZlpOUkdEU01zN0oyMlJENE5WUXNi?=
 =?utf-8?B?NVhsV2JTRzVIOUtTN09uZHQ1R2pVZTN1dWZCSVI4aGZtekpuREp0UXVGMkdq?=
 =?utf-8?B?RnFmcU9YZUNqdWE3SUZKY1VhMy9zVFR2NjV2YXZJeHBvQlo5OHNRS0w3ci91?=
 =?utf-8?B?Y0FIMjUzUGZaQURGdmtaWk94RVBnRWlXQjNNeE9rcThPUXFhZ2pKZ000Y3Vj?=
 =?utf-8?B?WU5iVVowNC9UZ0J2MzZaQWZpY3NIQVFpSjJQaUFwckpCUzhDTnVxd0pab3BZ?=
 =?utf-8?B?MUJxME5VcHRmb0daQlhKVDRGc2ZsdlZPQUw4U2VqTUwva1JIM3ZLam1wTCsw?=
 =?utf-8?B?eVFlN0xuWklNeTJDVEZjZnRlbFRYUUUvNzZjeEVRMmJlM3dXVHBZeG4rS08y?=
 =?utf-8?B?SCtFQVpNbXY2YTl0b0VGVHlZcFFGZ2lrN0FaS3B3K3RFclJTOVM4K2s1NjJa?=
 =?utf-8?B?THFPT1c2WmhOM1QwMWJqUGFCV0RUdTBpU1JSRVZpWTBBeGllZmVJVThINGto?=
 =?utf-8?B?UjNUUGwvenA5MEkyeGZtVEE5VzNjcmZqQzdmVGhiYjB4amFrL2lTMTVhSnp6?=
 =?utf-8?B?ZldHL0FsTjg1bEFzREZzbVpOQVIzbU9HVnNTWGI0WHczQzFET25OOFE4dncw?=
 =?utf-8?B?Y0wwcEZONkFUWGVKY2FKWE4xd2g2cEgvOUtXTWdqTTQ5YndxRXdjakU1ZjZS?=
 =?utf-8?B?c3NNRW1pZHZIV3k3akliR0VPK2o3czBRbDdBd1pJbndBK0E3Wk9qaDRQQUND?=
 =?utf-8?B?c0dmR1R0OVpsY3dVVFBBWWZPN1pKTk5wYXdwc0NVSThWNiszYzBIT1o4ZDNX?=
 =?utf-8?B?NHI0dzdadS9aUE81TlN0WEg3azIyNFhJRWJHNXBUUDZLdnlJcnlFRG00bXRk?=
 =?utf-8?B?UHp3dE1EVkRzeTZVd1lxdjBpV2YzSm9NWldoL2dzT1ZXWExaWjF6ejErQ29p?=
 =?utf-8?B?MnVBUXRtaUcrN0lCRkozM0ovV0czV0J1b3RScTdDWXlaRGh5enIrcWl6OWxU?=
 =?utf-8?B?dElVYkFwNXRNaXQ5dWNxVlhGVlhOeDZVSlA3Y1hCdUVSNzBiK2JUNjBtZmdG?=
 =?utf-8?B?a0hVNXEwY2JrNWt5cFJ0ekhVZDlZajRNclBZWkxIdWJmamVrSTdmWWkraU5Z?=
 =?utf-8?B?cTYrOHV1RFY1aHVWTWlRVURDQ045c3N0Uy9BSjhxQ1RoYWhuZjRUZkZqTWZl?=
 =?utf-8?B?M3M2TlpBR1JrVGVEWVhzNVRjbFUxM2dJQllDRzZwWk56cy83cnNBWUpBc3Bt?=
 =?utf-8?B?V09IYjB0ZWh3ZFpmWHovMlh3Uk1kNWpDQ0MvUUxUUTFmQkR1ckZudmZCbEEw?=
 =?utf-8?B?R0puT0kwbHpMRWoxbkZsblNYSmxrQmNZc3RVdTlPNzJ6ZFJUeEViWE0ydm9S?=
 =?utf-8?B?dVlaVnFNeG11N3ZRRzhyYUxLYW1yTkdvYTZGNjh5a3NDQkphZGlmNHNnQk9x?=
 =?utf-8?B?NUp1Y1RaZkJxcUhBMllSZ1dtS1JsaWdoRGoyYjBNV0ZqWExlaDNwSGI3ZGlx?=
 =?utf-8?Q?dBelbRZdb6JfO2ADmLrtVN0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8A6858B4DD24ED40923679375CD8B78A@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feb934a0-ac7e-48f3-d71d-08dc532bfb73
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 15:45:54.6581
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pKOI7TPXmB6Z4lz0ZSRz+4AT0NfiAVeTL1G8j8B1IzSmJb9f+WN/WWyvcOrSoQH4DlP+JCaQ0ZNDAbPh2cTqgrrsIvtLs2uiA4UZryhodUk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6604

T24gVHVlLCAyMDI0LTA0LTAyIGF0IDE1OjEzICswMjAwLCBPbGVrc2lqIFJlbXBlbCB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBVc2UgJ3JldCcg
aW5zdGVhZCBvZiAncmMnIGluIGtzejhfcl9keW5fbWFjX3RhYmxlKCkgdG8gbWFpbnRhaW4NCj4g
Y29uc2lzdGVuY3kgd2l0aCB0aGUgcmVzdCBvZiB0aGUgZmlsZS4NCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IE9sZWtzaWogUmVtcGVsIDxvLnJlbXBlbEBwZW5ndXRyb25peC5kZT4NCg0KQWNrZWQtYnk6
IEFydW4gUmFtYWRvc3MgPGFydW4ucmFtYWRvc3NAbWljcm9jaGlwLmNvbT4NCg0KDQo=

