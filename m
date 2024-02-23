Return-Path: <linux-kernel+bounces-78024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D614A860E19
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 470911F26516
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7491F22EF5;
	Fri, 23 Feb 2024 09:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fwLyxO/D";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="uGiFkZ5P"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A50A5C5F5;
	Fri, 23 Feb 2024 09:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708681007; cv=fail; b=ISEIPF8sbGaX8P26inFqLEQcURltpdYIVlfhx3oAIA/BLXPHZeioA3qUjeUHSvlGF8QjILb7/yJJew36gNjMbXVNAUAa8y1PF3yOtpNCQ9fOPGcEtqCHPwUgwU2U8T8/HrzF8+z6W0lgns/oXeoU8zGw2bXz/StMbiJ7YtYJJ2U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708681007; c=relaxed/simple;
	bh=uThbRjelR1rsaAOf7qWkyMItbN+eIgyDVixoOgyGMio=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cgs28XIp0mZTY9MEdvCFJSWiZXwQl0KaJtJcYuGKQIiQSqI9OfJJWlruHrEOrjnLmUk9VyQGsk10H+kmdGT5WoMf15d85/eS0pECcqWxaNN+i7zWip5xKIHnEWPJC5+ODS5/bi8DSMe/BS/9SKsXpx4JZKPiLyP9pY4TaN389Ew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fwLyxO/D; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=uGiFkZ5P; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1708681005; x=1740217005;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=uThbRjelR1rsaAOf7qWkyMItbN+eIgyDVixoOgyGMio=;
  b=fwLyxO/Dgo5JGVl9MCfaVC6Oc46BnWa4GgGhz1TjMwMendJGbUuH6a5p
   Z9LT9pRxPt2Fpjoqn7jCIW1eo1Txe/TkPWIka/B+mNAd0MtF6+vhPZtCZ
   4K78vwNSjUssA+79vx5NXeyzGoC5QzirLOYDYQD8xZEb/5OXuDnctV0Df
   Bt8laCpLOjDxYQDwvKsb/RCr5ZvuEz5c76PztTm1XLSvWw+RPjxDjHm/8
   k45M8KEKvkqvrZL8Qf98UmmNrmfIB+8HYjHP655Bb0FZKBKApwwLJ3H62
   n2QAnGIgGagIM+Mr1qP3ECR5g9P9SseVDMByNjCXzPpZdwcJIkWBkrbAd
   A==;
X-CSE-ConnectionGUID: aLemeij8T1azblktoXh/xQ==
X-CSE-MsgGUID: K4f4RB1mQXGgnoa3wNLorQ==
X-IronPort-AV: E=Sophos;i="6.06,179,1705388400"; 
   d="scan'208";a="183987969"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2024 02:36:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 02:36:43 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 02:36:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfiO7yFqHLFki9uYSu8fABCEoiTwW3GZhJJqE5dGUFoslkfx/NeW3L4ZPf9lUhegZGo1yPFNWxfgKuLNTF6UrOzhKf5T5KUdUmZnoKuxCPpLooJBegorl5+Ne68eg4xem/15XHlnX5ZR27ivECD03GmvCId2wEEwQ2N5UFcImjlDjPOE+kE9QhcSFBjAtfC0rGkX7yRD00l6OvUdVSyLn4v6/H3HuoKb8jsI+RsSQwWCTA+40UcFErwohON6TFt85kOxGv6eSeSBMKecfwvyzmdCnwPMdBHgOaxl07+4wRbt5AwJHVy9ca6W8H4fmCpERj7nwdvIlgmG5qH7TxF/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uThbRjelR1rsaAOf7qWkyMItbN+eIgyDVixoOgyGMio=;
 b=MYAcArWtAQzVnezJuBojqbVtJOm6Sw3UECdKF2niNMAinyKATA0g3C4DL5uJvDjh58I7ohRBl2bgz/KAQsCph0wEf+5cTdqBDhq3XGibsd+VHPMaxKVnEW1vZPweDGXGACIZJv5f6Jjpd2ePBWVz9WD9aBtATPwQL7AYKdsHvCWyAwpsFVUQKzVXZljXBkx5yEIfx9J+R2lIgUFc5odcNQ2fAagKGFxlqF6i/2XakML6VILljgnW24LJUHT3YTGwUgvQ/gHcEeiXzP7kJnqckgGY4zcloMigDBROA/JHzz+va1bB3LtXa738iMupbn69LOfiNu7IXngl/dp9/lexwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uThbRjelR1rsaAOf7qWkyMItbN+eIgyDVixoOgyGMio=;
 b=uGiFkZ5PHOrWRN2i7q1E22bbAj2OUR7uPpNeg9lpkUoFmqE7Yq7Wmxq3V1gIDDkZqPzabnLGtGPI3QYWGFwl4LlPYyUsOqyG3811l41aCv9FfdWsTWsDp60vaqD35Cf19OtwSmlqH2xTg+4JmJbybNbOPEfZRw47heDJEEeiKblQSne6Y+iO9QtgER9xK3D3mgT7Lleio1Ltcoxs2fJrUV9+nsZW7cJfwiuBNQwJkx0k5Bv5iG8imJVVyeET3nNrZnzBQGVitzjaFUAOI8x6JCJl2g0ig0O/h2Z9NNo26zJyuqlsAl9fsal/U7t62BLwJiVO/Ub5Z3BoNUeJUu9BDA==
Received: from DS0PR11MB7481.namprd11.prod.outlook.com (2603:10b6:8:14b::16)
 by MW4PR11MB6809.namprd11.prod.outlook.com (2603:10b6:303:1e9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Fri, 23 Feb
 2024 09:36:41 +0000
Received: from DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::c243:33d7:2ff6:409b]) by DS0PR11MB7481.namprd11.prod.outlook.com
 ([fe80::c243:33d7:2ff6:409b%3]) with mapi id 15.20.7292.036; Fri, 23 Feb 2024
 09:36:41 +0000
From: <Rengarajan.S@microchip.com>
To: <jirislaby@kernel.org>, <linux-serial@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <Kumaravel.Thiagarajan@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <Tharunkumar.Pasumarthi@microchip.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 tty] 8250: microchip: pci1xxxx: Refactor TX Burst code
 to use pre-existing APIs
Thread-Topic: [PATCH v1 tty] 8250: microchip: pci1xxxx: Refactor TX Burst code
 to use pre-existing APIs
Thread-Index: AQHaZZZL0nj0fFzSz0iXzZOI5AQ+c7EXclSAgAA2nwCAAACkAIAAA5yA
Date: Fri, 23 Feb 2024 09:36:41 +0000
Message-ID: <cc783f74fe180c2d035dc3f79e9e772c15280e46.camel@microchip.com>
References: <20240222134944.1131952-1-rengarajan.s@microchip.com>
	 <5bf4ba6d-d8e3-4ba6-a889-cfae8c3ddabe@kernel.org>
	 <e93048e64c3f8aa2731575d4b296c473e8dadb82.camel@microchip.com>
	 <254db026-5f9d-497f-ac44-c81d9d5947cf@kernel.org>
In-Reply-To: <254db026-5f9d-497f-ac44-c81d9d5947cf@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7481:EE_|MW4PR11MB6809:EE_
x-ms-office365-filtering-correlation-id: 20d8ea8c-68cb-426c-4e03-08dc3452f0d5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w8+CpdKX0CGlwTiABfdVxfM+GuNijPWkLie2iwBvkZ0z8FtU5Ba/K+CkrtF8lyzaAu9kqUbDevCwx4NkbSon9aXAvL3kAoZBXxo3lRjWRL9Uvva3x16eVwjDYSlGLwCMuiAk9yHXbdwsydqsvHiAGOYCJKHHav2lVafHI7GPWMYZZ+A7e0vD5meSaZj+lslsOmrnURyYZ6jbaG4Sjv3brdqWyc2nhvp5TXhsnp9OWQ3vdxkzy9VQgt4hOtKsBLwci0VgWhmE4m0EfPIK7N09YVMeojWy43Cz5QeZBGB1XCLjD7/lhCISBPigfMecrxE+rwyifS0l+tHD5qznVduJHiM9QB1yMnCxpJM6c4ihOVfRRMVj7ugqmMjPzOOnG64Zyxqs6Dg8MFJvcYYNE19CSzmuqP5RJKHA7UgUb4r7rsAHkprvckKXGizn0Q+84IU3rwm+NeJ5wlnZ/uV8UdTGMfWUx5f8Ezm5dXEu73oIaCRbTDZRXjhpnYBcNfE1YnFTZKIugVdfGJ5cf3J3QeymDOuCujXgCjlv7RiO0lPJ0zI0hE2qZkN3lRFoRtftvTzBHuYT0ZuGpeyxihIKCu/ReK2RjkLpTmsepPOUKqX02u4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB7481.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V3MvTVpTRXJLaUJyS3RaZ1gwRGVBWVZKelpuQVVhYUdWSFpBMERWeUQ5SnRF?=
 =?utf-8?B?bnpNZGxQV25UUitFVzR6dkZjM0hYa2J3alpwVVowVmJ4emVraGtleHJBYzZ6?=
 =?utf-8?B?VlE1MzRPcit4SDZHVldKOHNEaE1ub1l5ZDVmRlBTMDc2ZnR1OWdpZDJGak5h?=
 =?utf-8?B?OEJ2dkJpTTBkQjhkRUpsWksyRWZoeFVML3NTYjMzY3ZBU21CSVNuQUZZdXkv?=
 =?utf-8?B?VWluQVo2QUVKZXVJemZzQVNDNFpEN3ZCTE9nUXhZOVhISmEyOWlKR2swRmlM?=
 =?utf-8?B?NGtoNGcxT0M3eVE5aERNRHdZZDhGb3JuYjVFSG5tUGNBRmdBUmhRa1BrR3JP?=
 =?utf-8?B?MVVtWWRGVnIyUk0xTUYwOXBneFA5ZytpWlI2Q2g0QzNvTW9nLzdnVExGT3Nl?=
 =?utf-8?B?SW1xVDEvTVl2TE12a2tDWVM0V0hlTEdjNkdqZjRIMVgyVjVENmJqNFd0NmJ4?=
 =?utf-8?B?SVhYMllDWGVaVytrdXlZSDdrdWxDczRnRDJ2ZDFJU0xQN0IvcmZVT1dudkZX?=
 =?utf-8?B?WFE0Qks0T29YRHlTUWplOU5rK1dtQlo0ZmR5TWNWNmVucXZFako5RlNwaXQ5?=
 =?utf-8?B?T3EwUDNuNXBJMXNVeXBnbHJJdGJTTUlwMU1PK2dEd2Z0VDNaS0tqREtvQkpj?=
 =?utf-8?B?Yno4a1ZmZHhhSlZra1ZBbzJnaVJiNmhwKzdqeTR2SG4rRHVMcHJoYkxNK3dF?=
 =?utf-8?B?OHZseHhWNlFnVzZ4aHZmNkJya2xBRWFjb1NZRkJQQWdCc3ppMnVBcDhpK0Zj?=
 =?utf-8?B?RkxkNndRRVFJZGtEaHgvUDU1K1pUNGN0UFlOeGpWYjdyc2pYMFlSL0gvYWRu?=
 =?utf-8?B?UXJoVnZwNW1KRWFOL3JEaGtaVVdGN080ZDRla2hBZmpiNGJ3R3hrM2xVNEY2?=
 =?utf-8?B?SkVLQjRPY1FLcHlGTlEzNHZ5cUZtN3BhYnd3VEEwam1KUmFSU0VKaXZpOTYx?=
 =?utf-8?B?UnFweFN6cnYvYzdLR0ZZYmo1QmI5UlRvaGlPNWVFbzhBaVdFLzdjaUJwaXhR?=
 =?utf-8?B?eldiQ3Y3dFdLL084N1p3REFTYVJlZTVnQlExYTN2QlE1Q0xmMy91Tzd4YmRs?=
 =?utf-8?B?YUUxQkMyNWhOaE9JU09rcFJPalBQY1g3NU9vSjJVL0JGbTl5UytGVE5LY3ZP?=
 =?utf-8?B?RFRSWkpDV09lNVlyRWNnZWZpT0VtWXJ3UFhUZEs2SkJEaW5qRXl3c0xFL2cx?=
 =?utf-8?B?UTZOaXJOWUtXWE1OVk50ekdZdmdDNFA0UHQ4Nk9ydngxYVV4bDRwR3piMWhO?=
 =?utf-8?B?WmdsSDlZUHp5VFI3NFZWVVpPczhxRFVBZnRleTRlbXNpckYvV21YeC9pY0pt?=
 =?utf-8?B?Y2xVMWRCMExFM2lYdld3UWxUQnpSaHdwM3dUYVJHdHk5TUxCblpnZUp0bmE1?=
 =?utf-8?B?eis2eGhmdkVRaS91NmxzaUk1ZG1wSHp1Njk3MFRoWisvdlBsR2pDOVZ5aU5X?=
 =?utf-8?B?SiszUFVVTVFEcVRjMERDR3NFaXlMNHgvak1lbUJUNlNQeFlmU0NoeC9oUVF5?=
 =?utf-8?B?Rm1kVjRBS3lOZlJDQ0F5T3M5M2g3ak1IajhLaGthclZ2emtkUUl0Zys3Q2JY?=
 =?utf-8?B?UnFZbVZGOGZtR3N6d3pWSUFlQkVrZkpxZmNCK3hYSEZ5dWNrSk9rS3NJSitJ?=
 =?utf-8?B?eEZpNnUzS29XQUR1U0pLai8rTDVaWXQ5UWJ3K243eFR0Mlk3NG41S0JWVnpH?=
 =?utf-8?B?bHFQTTBDdVZqM1ByVmI4L1lZalU4S01PYkdFdVg2YjVOOTZoNHFwNUlFVlE2?=
 =?utf-8?B?NTlXQ1A5eEVLT1JJNlY0czNQdFViRml0S2ROWHo0RXdoa2tGekVyZXlTa3BY?=
 =?utf-8?B?WEZuaG9iajFyY3B1SDJJSGV4N2szQjE1Y0M1UnRNeERHQVFqQkc2eGxOdC9v?=
 =?utf-8?B?cWd5UnVPeWFVaGxIMENBWjBFQitPWmxETmRjeEdwOXlhcGJQVTJNK2RGQ2Zp?=
 =?utf-8?B?My9UZFRISlRrVzRNRDZmQnkxSDNHYW9qaG13RXRXL3BWV1BzeHdocTdHVDE4?=
 =?utf-8?B?L2l1STlrTmxNbDNEVmRnajZTV0g5YmtJYzQrTHhld3hZcUZqdjAyNmI1OEJS?=
 =?utf-8?B?d0hiSWNQNm5UeGo1VE1WMFRSQ2FsTC9zbnAyV0ozeDZEUDhBTjJxRGw5Zm9w?=
 =?utf-8?B?LzZlMHYwcm9KVlR1Z2g3RUszZzFIVUlRdzV0cnNqYmlncmZqRjkxdm1YdC8z?=
 =?utf-8?B?S0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7CEFBA42F4C10046AB4DAF548F1FC217@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7481.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d8ea8c-68cb-426c-4e03-08dc3452f0d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 09:36:41.1949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y4nBGw48Nn0cYMTdeC2Wawzr0JY5jTflOsjjlXX5qzoz8n6WLGqTOBGhozrH0og7uZFwk357rvnyKKiP9MrT9gyUsq+S+DpDOTFssNkizz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6809

T24gRnJpLCAyMDI0LTAyLTIzIGF0IDEwOjI2ICswMTAwLCBKaXJpIFNsYWJ5IHdyb3RlOg0KPiBF
WFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdQ0KPiBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDIzLiAwMi4gMjQs
IDEwOjIxLCBSZW5nYXJhamFuLlNAbWljcm9jaGlwLmNvbcKgd3JvdGU6DQo+ID4gT24gRnJpLCAy
MDI0LTAyLTIzIGF0IDA3OjA4ICswMTAwLCBKaXJpIFNsYWJ5IHdyb3RlOg0KPiA+ID4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3UNCj4gPiA+IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiA+ID4gDQo+ID4gPiBPbiAyMi4g
MDIuIDI0LCAxNDo0OSwgUmVuZ2FyYWphbiBTIHdyb3RlOg0KPiA+ID4gPiBVcGRhdGVkIHRoZSBU
WCBCdXJzdCBpbXBsZW1lbnRhdGlvbiBieSBjaGFuZ2luZyB0aGUgY2lyY3VsYXINCj4gPiA+ID4g
YnVmZmVyDQo+ID4gPiA+IHByb2Nlc3Npbmcgd2l0aCB0aGUgcHJlLWV4aXN0aW5nIEFQSXMgaW4g
a2VybmVsLiBBbHNvIHVwZGF0ZWQNCj4gPiA+ID4gY29uZGl0aW9uYWwNCj4gPiA+ID4gc3RhdGVt
ZW50cyBhbmQgYWxpZ25tZW50IGlzc3VlcyBmb3IgYmV0dGVyIHJlYWRhYmlsaXR5Lg0KPiA+ID4g
DQo+ID4gPiBIaSwNCj4gPiA+IA0KPiA+ID4gc28gd2h5IGFyZSB5b3Uga2VlcGluZyB0aGUgbmVz
dGVkIGRvdWJsZSBsb29wPw0KPiA+ID4gDQo+ID4gDQo+ID4gSGksIGluIG9yZGVyIHRvIGRpZmZl
cmVudGlhdGUgQnVyc3QgbW9kZSBoYW5kbGluZyB3aXRoIGJ5dGUgbW9kZQ0KPiA+IGhhZA0KPiA+
IHNlcGVyYXRlIGxvb3BzIGZvciBib3RoLiBTaW5jZSwgaGF2aW5nIHNpbmdsZSB3aGlsZSBsb29w
IGFsc28gZG9lcw0KPiA+IG5vdA0KPiA+IGFsaWduIHdpdGggcnggaW1wbGVtZW50YXRpb24gKHdo
ZXJlIHdlIGhhdmUgc2VwZXJhdGUgaGFuZGxpbmcgZm9yDQo+ID4gYnVyc3QNCj4gPiBhbmQgYnl0
ZSkgaGF2ZSByZXRhaW5lZCB0aGUgZG91YmxlIGxvb3AuDQo+IA0KPiBTbyBvYnZpb3VzbHksIGFs
aWduIFJYIHRvIGEgc2luZ2xlIGxvb3AgaWYgcG9zc2libGUuIFRoZSBjdXJyZW50IFRYDQo+IGNv
ZGUNCj4gaXMgdmVyeSBoYXJkIHRvIGZvbGxvdyBhbmQgc29ydCBvZiB1bm1haW50YWluYWJsZSAo
YW5kIGJ1Z2d5KS4gQW5kDQo+IElNTw0KPiBpdCdzIHVubmVjZXNzYXJ5IGFzIEkgcHJvcG9zZWQg
WzFdLiBBbmQgZXZlbiBpZiBSWCBjYW5ub3QgYmUgb25lDQo+IGxvb3AsDQo+IHlvdSBzdGlsbCBj
YW4gbWFrZSBUWCBlYXN5IHRvIHJlYWQgYXMgdGhlIHR3byBuZWVkIG5vdCBiZSB0aGUgc2FtZS4N
Cj4gDQo+IFsxXQ0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvYjgzMjVjM2YtYmY1Yi00
YzU1LThkY2UtZWYzOTVlZGNlMjUxQGtlcm5lbC5vcmcvDQoNCg0KU3VyZS4gV2lsbCB1cGRhdGUg
dGhlIFRYIGltcGxlbWVudGF0aW9uIGFzIHN1Z2dlc3RlZCBhbmQgd2lsbCBzZW5kIG91dA0KdGhl
IHBhdGNoIHNob3J0bHkuDQo+IA0KPiB0aGFua3MsDQo+IC0tDQo+IGpzDQo+IHN1c2UgbGFicw0K
PiANCg0K

