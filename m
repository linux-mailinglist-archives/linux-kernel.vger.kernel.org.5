Return-Path: <linux-kernel+bounces-134760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6229C89B67C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97073B21D13
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CF94A3D;
	Mon,  8 Apr 2024 03:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="UIS5XuI2";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="acQSHpNU"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1FA1869;
	Mon,  8 Apr 2024 03:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712547739; cv=fail; b=Cupf2CDTrr4PabkNBRyskbgdvaHpM9K5ocufOViQktR37coicrrvYwFCFQC4g71/YPmR7L9L5ISqi8xmuf62xnXC443EK0G+DQeAG+AfGn8eQZ8xckvIB6opcY/jmP5JzGWBWmrtgIz5em8L28oyYZZRAfvZvsES89ciX01t7Bo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712547739; c=relaxed/simple;
	bh=opefP7tcZzjRad5UdSOkfi9SwEDKX7D3tX+fvE6y63c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Puid1HoDgA+03g0H1Mzyy0Ht0LO/jeHXRofmEeBj/7pm4Wki0pjGFUWl0wmZSEJJ5lvvJA26fD0g6XKXJKLRYU+ls6gmDgifrPNj3PxJfgbJ239dzreoBhGtOEHRjeXC7nQVeBIImp2eMbqSs7cFZVanv2utyOtJ/hXJPowMKLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=UIS5XuI2; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=acQSHpNU; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712547737; x=1744083737;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=opefP7tcZzjRad5UdSOkfi9SwEDKX7D3tX+fvE6y63c=;
  b=UIS5XuI2DrAbjkGZ6jwJ7gY7Y+gCLuCHMLk2yYbEp+spRI4E1Ik+Yxol
   dvZtZirKvSZQOqwv4SsvXxkFyKMsrHUswtWFZ1quzAyym6Qzb2IhCTfHW
   UQ8lBJl3wiyiX1W7vAsMhCS8PewR3xfx1tTMpoiY5TwZRG5oIk6xbOnyf
   xzhR+pQxAHH1dmsQOKiIcVqmZx60mKejUlKaIwwqK2sjj7NbSg7vUKODv
   JcxFFjYNZrlY+vcKyJsXBswlDhqbv1/Vs/p9p7AR17TNcar5FfAZoIEEe
   Tx6D4jvKkgSNYr+0jgpXBbWMFC1mjIorRA2qQ1QTPp4pYithsscN7h1ao
   Q==;
X-CSE-ConnectionGUID: OMAQjfAfQaOlbQTD/1k5AA==
X-CSE-MsgGUID: VME6Z+o2SpWbR6I7HoAT1w==
X-IronPort-AV: E=Sophos;i="6.07,186,1708412400"; 
   d="scan'208";a="187241422"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 07 Apr 2024 20:42:15 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 7 Apr 2024 20:41:48 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 7 Apr 2024 20:41:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dd1+h6zcwNeckdWKgNsN51BesQdarrb3Y9JAAT9uazJ1UCxOZBHtIjT34gtgyEo2BGfstgYDKKyBT0/goMZKZyxehNRB9AEIfgHLWvwRKE4WpMsN4CvFDy0Fr9CeFy+1L9wZCzwdW2NtTuoy8hh99OaB0QdGmZ1khovVtD1iB+Zi2/KYcgd246yN7o05TAUYdJr3kNOXTtad/6JORwi4f4TFGKHiC8ZDn2Ls9Uj05aw/2TVJG1ZySdNUbN2Q4bQxw8ODlArq5iUTKteEa+I+CcQ45/d37cu/NH4f+kTcQLuwaUOtSkrFBqHd2YYz3KWd5TNX57V8uz5Yiz2+0bWM+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=opefP7tcZzjRad5UdSOkfi9SwEDKX7D3tX+fvE6y63c=;
 b=ZMtRaxrRVTfZ7xYp2ucQ4XKOBu3wxhSPmwHDTMPEiKLOkS0HeH6vtdcAW2iVS7DZOGRP4oWh7zHZkkFW/VMt8kpiwmJlwd6Bng559tKuZRoPEn1czN6N8GbtU5FjKFb5XhrHJHijolzhl5PLMLJlzqbm2ZTMhAQZrz4fQywmfSTaFJwNNsU6ip2Ute2P+QpyUV1phPr96ud4xQMYByefKfG68dGQYEr85PBvnyo+I2WAvLBp+wmx59FBZGKKqUKY7bnpXuARqTusoDpxWhCPz/HW4V2qlMAK9Gd/8LHcZmP03CM8PYPDhcAtqb3UJQPvAHAhlBy0STDyO4mfHlUJZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opefP7tcZzjRad5UdSOkfi9SwEDKX7D3tX+fvE6y63c=;
 b=acQSHpNUckaY63+STvC+K2YSoC6L/SaCuunTzhS/Qy77HOBtYfskMNFR/U+XlzbkzOo/5QrXNgVUcqSb/yVr+hW5ezsb+x61fmbK4GlfC9k2ket1gIx4w80ux2pb03G4KdY6rr0UsW2UUViqr99SkobdAhVm1i4NaG8Yco9vEmkt/Ih+Q5cl1NHbYG0AQCeSLawjxZ580iBWJPshcOJdqY1E4xfhPzDwhq/28WlfRZ0cqcLUPEx8UIMOo9PM5wAhdvk8xmNUTDeYcv9fLmR9xyynN4VoKqWNCBMORRdkSH42VCVY06pvcjipIUiI4jEnFL7lCP1r/C8iavVqlQo2YQ==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by CY5PR11MB6534.namprd11.prod.outlook.com (2603:10b6:930:42::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.25; Mon, 8 Apr
 2024 03:41:46 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d%3]) with mapi id 15.20.7430.045; Mon, 8 Apr 2024
 03:41:46 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <kernel@pengutronix.de>, <dsahern@kernel.org>, <san@skov.dk>,
	<willemb@google.com>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <horms@kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v3 8/9] net: dsa: microchip: init predictable IPV
 to queue mapping for all non KSZ8xxx variants
Thread-Topic: [PATCH net-next v3 8/9] net: dsa: microchip: init predictable
 IPV to queue mapping for all non KSZ8xxx variants
Thread-Index: AQHahz8ZTS23qhPLcEmVfUcG2EgKIrFdv0sA
Date: Mon, 8 Apr 2024 03:41:46 +0000
Message-ID: <39a736262d87b06ad65e67753c440a1d489c8f8c.camel@microchip.com>
References: <20240405095216.353829-1-o.rempel@pengutronix.de>
	 <20240405095216.353829-9-o.rempel@pengutronix.de>
In-Reply-To: <20240405095216.353829-9-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|CY5PR11MB6534:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hiq9D0Gva86MjcupHzcbloFjbBKBcHkXS6mddco3JxA013moGk4SBLXzgbnFbm89pYW90QVxfC1SwCQHv9aH8le/YJ8j/xY6Q6YRZ1A7ajuFROdIIQX0uBHciU6HuhLTY7AD8serE4b5Fgj0/xbtrdoz6BhD8/EPDegC1SUt5YKJMhpqlVVeQU0byPJu1Tpdc0pM/ejkHjtd1r62GD2M1yRI45z1Vp3FIOzWQ2nzHwA50uJDqnrbqjfhpzXRKaZPpIrWoyiXXuP90fmaCEs4B7ODxEtPKcHTjeCmuPeAkfuBfgpKKzBNx9XSK9sH+oKxQSfDtNWxBuJguAOe5AYpGiRmj2EqVZX24GjjiyxTFDIdsAO9ShIJ2YCUL4igdCFw1/3DRbFqpjK74oSLR11wcUY/098Js8mVJ8enndXGips3k/J4BHWZKuokFJ8uy2EVSZ4XrHjkIP/BxqM1wK5qLnBYugM6puZD+dpVgsI5j30CHQIbrEZTvt2Dhu0hTGoVFLwNUXy9nPRriwWQuqtRt54JgV6AWQlyd/TEQJsn6nsSHQf7N3AQMp2Vdxs9QCLbgez34LWVIt1hHB55bhOYKDK0bcJGfeDetX52V5z/AJRmq7iDe1jNh/WO0WykcU4OymOGnqg2EmxUUnOmh94OP1il48DuZgMJUhc83RYhVPI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U2R3eHl2NW9LaURjWlU2WWMxZW1uYXNSdCtmOTh5ZVBhYnFnSDNidFNnRjdS?=
 =?utf-8?B?UzhUb3pJSWRVeUtFRU0xTVdkK05TK1dWTU5NdE9TQUNNRHQ5bDNoM2NCeHBx?=
 =?utf-8?B?SHBlbmJYUnFnRXdsbjNxb282VW9yV0tIY0FadEYwV3dON2hmb2tlOTZzWTRP?=
 =?utf-8?B?WmxVenBYZ1pzMzhWdnN5Y2RoaWNrT3NTTDJWNXpZdnFVUDFSQUNMMWhoTTZj?=
 =?utf-8?B?dGgyNjlyMmEzNzhCNkdHN1QySXpVTk1UeVpOa0JGTExUTThpSWZNZmhjaG52?=
 =?utf-8?B?R0Y4UUJ0ZnhaV0M1ZzlGS0lCaDQycVhsRTlZSUEzQm1QbU1ZOHQvWHJ5K3dE?=
 =?utf-8?B?WlhaSStjdis0TWNvM2pzOVZyWUswTzhZK0sxWWExc3AwaVAvRWhCT1VaNEtM?=
 =?utf-8?B?SkZSU2pIdjYvdkhIdG9BcmdRNS9KK2hnSXBrQWhjVUs4aHVZMFJMSmxNdlFU?=
 =?utf-8?B?T0tkaUV6MzhVYXN4MHdVRWM4bTQ1endhVW9ZMTRReVM1WXVwNlVvK1hORlRa?=
 =?utf-8?B?Mk0xaXVEOWdZVWpLUkVNdWpXR2lLTjc1WE4xWjhKd2xaaEdLVDBUUVVpR0c1?=
 =?utf-8?B?eWhKWWxueFVXRlpIZEtXNERnUnl1QzkvQzhYZU5EMmJzTURxNERacVZJUmJj?=
 =?utf-8?B?K1ZBVDdQajcvK0NxblpRcU9jeXcrL2Q5bXJBQjV4LzF4Q0NyZ25XUW4xaGlL?=
 =?utf-8?B?UjZBSWlXVHltT3hGazBSejY1VnVWV1lWNWkvYmZBYWprZklucUdFRUJ4c01O?=
 =?utf-8?B?TFRKY0NnZVErTXkvYklMZnduY1ZyTTllc1gzVzJaOEk4bjZEY29mdktnNDFX?=
 =?utf-8?B?YUN1d2tObzhydXZuMVp5ODZUdk9RRERTVGFQSzhrWmlSSUF6Vm5JcnVHZUdx?=
 =?utf-8?B?SldxUUpRandkeVBxempXbVNJL3VwN0RUczhDcXFnK1Q0NzBCRFQxdm5SQkdt?=
 =?utf-8?B?M295V254dlpjaENMZ1dJLy9BL0ZVTU1pdHgwZmR1QTZ2cXR6RXQ0c3paeTR6?=
 =?utf-8?B?QnU5WjZOK0xycGNCWUNkYjlNdWJvRDBrcXp6VnhCUWRjTXZTT0FudnoyWGs4?=
 =?utf-8?B?aXZNNWNXZmxLc1RKVUdEQ2F3QUJZZ1lab2Y0aUFmQjFIV2N5eTA0cXU2c0FQ?=
 =?utf-8?B?dENML3luVlUvZ3JZc0FTUlN0YXE0ZUhyRHo0V3dEMUlHZ3J0SFhFSmxtN3B3?=
 =?utf-8?B?TWlVc2V4UUlkMDA2T1NZNmtmb21YZ0ZFR2Q4VW5xTUhzMEVCcDBqeTExT3VD?=
 =?utf-8?B?S0ZxNWh0TUVXWEhIc1g0VVk2WlNPbGRRQW1wb1BZRUdTUWhXWDFYeGhtRDA1?=
 =?utf-8?B?VXAvMWlLSWJlUnJUMGFWUzJxbkIyQW5DWW5IMDFnU2ZRN1FIcE9MeUdFczZz?=
 =?utf-8?B?MlhZN0ZXbDlRTWZMaXRDL042cTB3bXRlNjdTdkNCUHEwVUowY2NpZGRRSFpJ?=
 =?utf-8?B?dUEwR2Z2M2YrTVkrZUhDeDhPczVUWUJxOTRUNUw4RnhFcWY5UjZ4c3FlT0JG?=
 =?utf-8?B?cjEzK3dCaGF6eS9mZytoZEw5RWU4U1A0bloyZWt0MThsMXQycmhZZVpuVjJ0?=
 =?utf-8?B?Mm1VbHdWMHp5Ymp2UDVSd1hvS3U5Nkh2QnZpR3UzZGNzamxFRkJuQzNCK1ZY?=
 =?utf-8?B?cU5RNGJ5SndCNXliRkZTZ05mN2hFU2RwN0crSXoyZXBRTDhxSEdzWkhmSzl2?=
 =?utf-8?B?SmprQkN3SnM2V29rcTNDWUF3VlgveFhiV1JXVUFwTWVSR3g0MFhhQm9FT29W?=
 =?utf-8?B?akFTUUpBU3BLSGJoZVkvWmpWdG55Q0VqM0tHTnMvTFBIdWFqZy9SZzVuaW5U?=
 =?utf-8?B?Zy9Nb0ZZNlZTdUd2Y2c0SmtGaDBkS1ROZTgzQ29OT2E4Zy9BNTVVNXg5UGhZ?=
 =?utf-8?B?cUJtWmE3NDBlS3Y2UTYxL2pDcWtnVGMxeVpXTXFSem1SNUp0REduQlUrL3dF?=
 =?utf-8?B?cTREV1dEaTVzTUVpbU1ncVoyd0lUS1htdmk3ZWFqSHdqZTlqbisweENpUGJV?=
 =?utf-8?B?eVJvb3JoSmkzQ3JvT0JkRGZrZkFOZW03WlBBRy9BMXgyOE9zU1RpYnZtcHRO?=
 =?utf-8?B?cUlLcVlxWmJIL2NER2NpcitST3IreWk4NGFFR3dIVm8yT1NsYi9YSkwvUEtm?=
 =?utf-8?B?WGphYVZ0UHFvLzA1SFNsNUFzaG1vN1luUldRN21xbnFrekYyWGgxb01PNlVa?=
 =?utf-8?B?SFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <07C89B4B3EA705488BC14335FE3F5AF2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acd8d18a-7461-4ae8-aaa1-08dc577dd0a0
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2024 03:41:46.1926
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: caZdLtqNgYXpAfyBTc3VfgPbdckz+Wm0H/ANclL9cHXeLchidxv90rU6XtgbTXO4F217tf4RfwXNKeDGeNK87i7W4nfEFt668gB7dSod1+I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6534

SGkgT2xla3NpaiwNCg0KPiArc3RhdGljIGludCBrc3o5NDc3X3NldF9kZWZhdWx0X3ByaW9fcXVl
dWVfbWFwcGluZyhzdHJ1Y3Qga3N6X2RldmljZQ0KPiAqZGV2LA0KPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGludCBwb3J0KQ0KPiArew0KPiArICAg
ICAgIHUzMiBxdWV1ZV9tYXAgPSAwOw0KPiArICAgICAgIGludCBpcHY7DQoNCkp1c3QgYSBzdWdn
ZXN0aW9uIGZvciByZWFkYWJpbGl0eTogaWYgeW91IGNhbiB1c2UgY29tbW9uIHZhcmlhYmxlIGZv
cg0KY291bnRlciB2YXJpYWJsZSBsaWtlIGNudCBvciBuIHNpbWlsYXIgdG8gcmV0dXJuIHZhcmlh
YmxlIHJldCwgaXQgd2lsbA0KYmUgZWFzaWVyIHRvIGZvbGxvdyBpbnN0ZWFkIG9mIGlwdiBoZXJl
LCBxdWV1ZSBpbiBvdGhlciBmdW5jdGlvbi4gDQoNCj4gKw0KPiArICAgICAgIGZvciAoaXB2ID0g
MDsgaXB2IDwgZGV2LT5pbmZvLT5udW1faXB2czsgaXB2KyspIHsNCj4gKyAgICAgICAgICAgICAg
IGludCBxdWV1ZTsNCj4gKw0KPiArICAgICAgICAgICAgICAgLyogVHJhZmZpYyBUeXBlIChUVCkg
aXMgY29ycmVzcG9uZGluZyB0byB0aGUgSW50ZXJuYWwNCj4gUHJpb3JpdHkNCj4gKyAgICAgICAg
ICAgICAgICAqIFZhbHVlIChJUFYpIGluIHRoZSBzd2l0Y2guIFRyYWZmaWMgQ2xhc3MgKFRDKSBp
cw0KPiArICAgICAgICAgICAgICAgICogY29ycmVzcG9uZGluZyB0byB0aGUgcXVldWUgaW4gdGhl
IHN3aXRjaC4NCj4gKyAgICAgICAgICAgICAgICAqLw0KPiArICAgICAgICAgICAgICAgcXVldWUg
PSBpZWVlODAyMXFfdHRfdG9fdGMoaXB2LCBkZXYtPmluZm8tDQo+ID5udW1fdHhfcXVldWVzKTsN
Cj4gKyAgICAgICAgICAgICAgIGlmIChxdWV1ZSA8IDApDQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgIHJldHVybiBxdWV1ZTsNCg0Kd2hhdCBoYXBwZW5zIGlmIHRoZSBudW1fdHhfcXVldWVzIHZh
bHVlIHBhc3NlZCBpcyBvdGhlciB0aGFuIDEgdG8gOC4NCkZvciBleDogaWYgaXQgaXMgOSwgdGhl
biBpZWVlODAyMXFfdHRfdG9fdGMoICkgZ2VuZXJhdGVzIHByX3dhcm4gYXMNCmludmFsaWQgbnVt
YmVyIG9mIHF1ZXVlIGFuZCByZXR1cm4gcXVldWUgYXMgMC4gaWYgd2lsbCBub3QgZXhlY3V0ZSwg
c28NCnF1ZXVlX21hcCB3aWxsIGJlIHVwZGF0ZWQuIERvIHdlIG5lZWQgY2hlY2sgZm9yIHZhbGlk
IHJhbmdlIG9mIHZhbHVlcw0KaW5zdGVhZCBvZiBqdXN0IHF1ZXVlIDwgMC4gDQoNCk5vdCBzdXJl
IHRoaXMgc2NlbmFyaW8gY2FuIG9jY3VyLiAgDQoNCj4gKw0KPiArICAgICAgICAgICAgICAgcXVl
dWVfbWFwIHw9IHF1ZXVlIDw8IChpcHYgKiBLU1o5NDc3X1BPUlRfVENfTUFQX1MpOw0KPiArICAg
ICAgIH0NCj4gKw0KPiArICAgICAgIHJldHVybiBrc3pfcHdyaXRlMzIoZGV2LCBwb3J0LCBLU1o5
NDc3X1BPUlRfTVJJX1RDX01BUF9fNCwNCj4gcXVldWVfbWFwKTsNCj4gK30NCj4gKw0KPiANCg==

