Return-Path: <linux-kernel+bounces-90728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B4A870414
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 15:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25B221F278F5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 14:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5748545953;
	Mon,  4 Mar 2024 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OnP84st+";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="J0psfx0W"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E253EA88;
	Mon,  4 Mar 2024 14:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709562384; cv=fail; b=XSaT5Hz/vIo/GwqedpZohkDpzcFBE6qObogrLBTf6AcCSPakgV7v8C1FOafCW0+FVnpk65xwtoLoSuSV/L8GEHmLJDubz+mIAQtdKRM9OWzFCOkkGsaRG5yOagF6bG7oIanxyLe/iO/qVZpLLkbUgcquQkyWHQ+ezum91F3fViw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709562384; c=relaxed/simple;
	bh=RQZYZ42sDR9l6mG41GloMiBQifjkCDnUnWjWnaIoPWo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LcUjHGaBtKx/K7x0VWEDKxfzWVBypy3mi+Z1lOKmwhDtJi5oB0d3luLWdkzZEYBqlPX+AjU3loJWjuHJlkX3YEJX8O7AugRNKzAjfEn8IH3evYYJ4KVt8162zaPfPxuWVFPUx+vI6ogoUVF+eyp4PAEsV8UEYEDgXaA8AQJ7p+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OnP84st+; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=J0psfx0W; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1709562381; x=1741098381;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=RQZYZ42sDR9l6mG41GloMiBQifjkCDnUnWjWnaIoPWo=;
  b=OnP84st+KsBIHDRaU8gL6qcoJ3cC1quXmvzDGxnlLTcNBaMu/B6k1/QU
   9sE0Q3c0t1MspKS2ycAzRoiNMROtl8inboW3i3Z6UhQ3tbD9BhGBTaA0V
   jfNMKppk1FkZv+/na4iHUgjTzmszJbUzEzFr1h2lT2QU7nz5IB30guXIL
   P5NsA020mACoUFrqyGfvwl8huCTgEBn3s8ubMSCsBuyhAg4spXbK+dfL1
   wZHSryBwGWaVPUHSMySjBH0Yl95rAmdLQyOicni44GgSYwEDg1ECcXi5z
   PGPydvqsKzWsoWLcwdMJ7dcY8+rgE+9p7Q3ejiUWDOd6U8cYYNJ4gFXA7
   g==;
X-CSE-ConnectionGUID: wbqaBKoIQbiL1cpr4iY34w==
X-CSE-MsgGUID: p2CQivnxTKyNFfWE0NPbLw==
X-IronPort-AV: E=Sophos;i="6.06,203,1705388400"; 
   d="scan'208";a="17159211"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Mar 2024 07:26:20 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 4 Mar 2024 07:25:57 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 4 Mar 2024 07:25:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YTK73c+ut2USh2XT1WFV0sAorlQqP+lxgkjYqE9fFNTN46TCkIeWnSpFpa6XwGb6Po6QKOGdKFwCVvExdj0//BZQ98VkFm7g+jqC4F34/njTcyu5f3YDD6f4nheabEnb8SVIZ5sSRMWQkFx+jmoBxI0QuV2kaNB4mtSrsekyggWwAj9RlqDIsufbj5vJDm5bRItDKpm/aPb+gtBuIh+HRZrTlsEXRaGTCxaMlsDwINDLDdTc2psEBaC9oEqJ/mdIIxzmvbFjEsfMFqZXviO80DYJO7LqzyQYRq2TkhM/Lx8YxerV+5ANeYTwbTZopQi01iC+/IOQ8ZFJaOJl5q2cvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQZYZ42sDR9l6mG41GloMiBQifjkCDnUnWjWnaIoPWo=;
 b=nsoZ2V0fRFBgxiwB7Fmj2/oBARxOA6BqtmEAFpt0rjso7ufCG/43y2xBWBG+tnWwooC7KpH7syEnrTonqsKEjEMslnGitEFXRTEJeoNUK7nMW5tmkty6577EtZGEBORfmBwRmiXoWoyswL2ng0D6HfevFuYfMUEMiocIJcc26Yf6Jd5JaREkTcvdVShf9R36WcGnLsQKbnzjzg9RTfA0v0sqJlbQxg5grhRyhWpYCNGXjMp0vnPOvFtM03JHa9G6zIommQPGOmrdtCXHsmQIjRJc5dMFFKvDXan3gGpN5WRuQLCRR+sfh8lphUlKKxfzLNJ6WlOqchAN9uyi2iUULg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQZYZ42sDR9l6mG41GloMiBQifjkCDnUnWjWnaIoPWo=;
 b=J0psfx0W9vllgNxQKKhHaGIJuQ1jIJtV1ZwA2XFYV+psXHBg7CrVe82Zu8wdekh2w6mTExwsiQ2IOmIsbw+N4KMFq9J3khQjsEA9ILlmlHgIG3GtTrsj5/MYOwvlLFNAZSZWn4VENhJpHLO4qKhMhJqI3dXkqMh/FKhPa7wZp+bKC9ZEeJQEPr6F3aDNl096bvLLGYCSbWHVjuUAYXITiMgXH6kPKCQJLBH35vygwjdZ5h4cZb7ve5NE4Vet998kRJ4BBzW4AXxdVPWLAXKw4cQHdOBWygeQspNa67HoiuJhQ61T0hURjUG0LrDKOsAry4k6qw0oOLO/pnxR9iIpfw==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by DM6PR11MB4691.namprd11.prod.outlook.com (2603:10b6:5:2a6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Mon, 4 Mar
 2024 14:25:54 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d%3]) with mapi id 15.20.7362.019; Mon, 4 Mar 2024
 14:25:54 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <kernel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net v1 1/1] net: dsa: microchip: make sure drive strength
 configuration is not lost by soft reset
Thread-Topic: [PATCH net v1 1/1] net: dsa: microchip: make sure drive strength
 configuration is not lost by soft reset
Thread-Index: AQHabjvPBJBDRZGVUEeFFR6wD7M/DbEno5CA
Date: Mon, 4 Mar 2024 14:25:54 +0000
Message-ID: <5a830dd5c253d12d719a5e979a1d43c5fb47e011.camel@microchip.com>
References: <20240304135612.814404-1-o.rempel@pengutronix.de>
In-Reply-To: <20240304135612.814404-1-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB8033:EE_|DM6PR11MB4691:EE_
x-ms-office365-filtering-correlation-id: 975958fb-e36e-4403-9b63-08dc3c57004a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WbqouSmyRhut46Ii8HGqGDU03W/9AJargBfK3DT672e0tgglKgo0FnfwBDgZRFAjPq3THXbiwwub2foVU1miHEuRbwdN5PZCozy9xl4RyOd/+WPNPC06AFxdFfpqZV6Gup1hBDkju0uOPNcNFo9p8DDgEzxqI3dindEFsjBx0rprobxmpsXOwS64IjrD6s5mz8GpFacBLHlqpKQ2HxPMLI/uNn5dn1EWJEiT2cScYBCti1Q9r2/ybzm1GDgAqRCsGaFeO3+96xsRqRY6MIS5YP2pwBAK9AaivBvPcEhjzSRkMpsUToyUpMF0m4WihNoQsbUGn2KTXRdIm7UpJ4d/5GORtzxBBsuM+rBrDeSSXtsclKWkOu/Fna1UnFxcybJDfJhC9OTkcyAl3zDUpQt6N80YHc7KXiZXZ40QU8Z/F/PmJvi+L312zNOE/dmatZYLlE6VEDmRH5ZeSVSpz0kQT7W/XPju7O83u9Z+rqKB9jZvF3vu1lUrdv1gCVmCcqyv5+Vs6sArXB3auRp1sgIEZMbxiFQXSeKAAnHuxWuMu/prVe7i1arhSG2tdamCgu3DwX4Q4VhPU7JyiiLGzzxKEp7ht9pN/Rr/W97yAyJWBXU4ggGllFBChj2oCLhMnLnxb45DFKY0Q932bXTprqTYdsmk7TLoY8u01f6DlR4qksbXkbSgJshbgBOwrJ2VmUghTWQ+wFveVwu7qyg+mmWMzGxtV16DeEyFWLokzXjzhIE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L1JNL2NieW5JOENBWk1rZXpxRkN0bWRQUXJRZ20zUXMweGFGV0Y1NHErbHBW?=
 =?utf-8?B?NlREVFJqalBvYWJadEJ6RVBpY3FQR01qZDVXcUpkNVFkZ3BENlhlclF4RUlO?=
 =?utf-8?B?aUVxVE5BdXBFbnEzTmkybG5qRVV6aFFpWGxIUklJeTM0SG5Bd1FNMTMyNFF5?=
 =?utf-8?B?RU1FM3BOakdOMVJkZ0NxdTRXZjJ3eWZOa0ZKbGRYZ2taUkhiZlZMWTJET2dM?=
 =?utf-8?B?UVFUdFhHNVg1MnBUS00rclc4aGRPNGZMUWRWVE9uN0NONXpaajdlQmFPM3VE?=
 =?utf-8?B?Mk5LSGFnWjJJNUdhTStEUnduU1ZDVjYxM3RYVUV5alYvVXJ6OXZZblBvdjF0?=
 =?utf-8?B?Z01nMXlaQlFIaVNrYUFsbUhlR1BuYk5LN2xoSDRrY3VXODhJRFdOSkduNXJV?=
 =?utf-8?B?OVgwZjY2aEhPa3pFYmJYWWFLeUFjeEI4cTM4a05JRzdiV1oyYjZrN24yZmRW?=
 =?utf-8?B?b2pvV01UTWlDLzVSbzdBYkdlK0ZzbWg1V3ZrOFRWK0hleXI5WlVBRGlsNk1v?=
 =?utf-8?B?bUU5c0JpaFR4ZUNWR2ViRGk0dWx2czRJTVJvK3pKWGJESHVBeXdpMWZlYVBG?=
 =?utf-8?B?c0M3bjA5NmFVaWR1NG1wTndnckE5dXc5VWtYMEZjR2ZWTzBNcVVLWGFTS3pa?=
 =?utf-8?B?WS9sRDNOY1E1RXg0V09JdFZnY3J2RVJtaEh6TlNXRDBST0sxL25LTHlCdFpE?=
 =?utf-8?B?U0Q5QW1xYlZlbzlERU1jY0xSOWxQSUhFSHFEM212TXpPajdVWDUxK3RKOUQy?=
 =?utf-8?B?VnBoM0NhaHZBWERadktEQUV6K1NxUlpYNHM1WklVSUpsb3pBdFdySDBGcTRq?=
 =?utf-8?B?dFlMeXF1bHptN0JoUDhUMFc5RkJEUXhMWnlFTDRBdHRFWjRxNld5amZKZHFZ?=
 =?utf-8?B?aVhpWURyYnl5clJiUDVjLzdMQ2FnekNBRjhhazRCbmd3NjQzOWJ1UVhWYldl?=
 =?utf-8?B?c3R3VlBYZWhuTkdUVnQweXBGVzV4VFI5a2xnU0lqdGtpbXcwZGV0eDZPQWNW?=
 =?utf-8?B?dU5zSU93b1dBci9xVzkrZGROR2pkOHg5bHlFdHozVncrZkQ2WVJCQjZVZE8v?=
 =?utf-8?B?US9nRGlnNTBIVU5RTUNiTzc3Yk9CZW8wM01sL2VuSlQ1azVXRHJZQ09iZStC?=
 =?utf-8?B?OTRwOEgxUVo0eUFwbGJiRVZBdFY0WmJUQ2lEVlNYczhwWUV5eWlLU0VwREhX?=
 =?utf-8?B?VlF2UVN5VVlpYmdtaVY5TENXWjMrRVZXbHdscUdGSG1RQmI3VXVHNlZwNmZK?=
 =?utf-8?B?bnYrc1ZzVkt4bVVIR1pwZXNyckY4RnVzbHVsYjRNYVJ0RTVjVW9sSC84MUpK?=
 =?utf-8?B?SFRwOGJiaGdaaUFzMVV3MzhXMms0dE5kU0hoaFR5YjNXTytMRXJZR0dqZHh4?=
 =?utf-8?B?OVZxVm9aWXRRNndIOWZYditpa0N5Y25nSlJ3QVpaVXFIOVBMVWVIRDU0MjEr?=
 =?utf-8?B?cG82eU5EbzJzTjNETTIrTjVMOW03NjNjNTJLdTAyODBpRStOUFpLc09Wd0FX?=
 =?utf-8?B?dGVoSEZhUUFSbVYyMGVveHhHSDEvOEJrYWJ3VExHR3BDMmErT0JQUzNmS0l1?=
 =?utf-8?B?U1RLWkkvVjIzcmErVjZVZFk4SEtOT0c3STZwaCttMzF3bSsyL2M3djhud24z?=
 =?utf-8?B?aXMzK29mT1Y0T3BtQjA3eFBTaUZibEF6ajBSVy9vWlpRd21hdWJwUnJvcTh3?=
 =?utf-8?B?YW5DSVUxK0ROblFTbnJuU0M2YlB6MThrYVRxaC9aRmpTREpQUk10Q3dWUzFo?=
 =?utf-8?B?dHFwNnV0L1dvSjdCeWtmWlhCeUlscXBacXRmNGtGMTFQNHBSNUh3VmpVNjFL?=
 =?utf-8?B?QVBYYXRaeHdBOElQTGdhSVpqaElpMndENk1TRDVVUFc5QmN5ems5ZlpYdy9K?=
 =?utf-8?B?ZndNdU05MmNzckZ5SmtGQkVYTDFvbFFOODVYWGNGYkxETFF0b1l2UGpUSTBi?=
 =?utf-8?B?d1R6Q2NoZlhrSEx6Wjh0Z3JJd2ZjQ3JORCs0am5yYTFqcWtRZ09mUUdWQzNH?=
 =?utf-8?B?ckY4Um10OHU1L3N5RWhMU3A0NjhpUG45VERFSVZPWmpkVU8yMlZMaWJrNlc4?=
 =?utf-8?B?QzZHUU5Uc1Fwek5VVWVUU1JVdk81K2xBZXVxdlRibGpOOHhEQlZ3QWRFRTk4?=
 =?utf-8?B?WWhGSjNac1IvZ2NyYlNpaStCSVl2SU1QTGlJODRBTnk4MGFFVEtQVkdSRmJk?=
 =?utf-8?B?U3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <59F1E19B9CD9AD4698E4020601C6D3AE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 975958fb-e36e-4403-9b63-08dc3c57004a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2024 14:25:54.4396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 36v1ECm8r2jjl1UkvQFM90tU7+Uzqi+t1NpEZ9zR5KIdDifSvtArjwN9y2mdfhIBRIXxY5XVQsRphEFs6RDpIFbIY2DCWSdU3QJl6JMebPo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4691

SGkgT2xla3NpaiwNCg0KT24gTW9uLCAyMDI0LTAzLTA0IGF0IDE0OjU2ICswMTAwLCBPbGVrc2lq
IFJlbXBlbCB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBv
cGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+
IA0KPiBUaGlzIGRyaXZlciBoYXMgdHdvIHNlcGFyYXRlIHJlc2V0IHNlcXVlbmNlIGluIGRpZmZl
cmVudCBwbGFjZXM6DQo+IC0gZ3Bpby9IVyByZXNldCBvbiBzdGFydCBvZiBrc3pfc3dpdGNoX3Jl
Z2lzdGVyKCkNCj4gLSBTVyByZXNldCBvbiBzdGFydCBvZiBrc3pfc2V0dXAoKQ0KPiANCj4gVGhl
IHNlY29uZCBvbmUgd2lsbCBvdmVyd3JpdGUgZHJpdmUgc3RyZW5ndGggY29uZmlndXJhdGlvbiBt
YWRlIGluDQo+IHRoZQ0KPiBrc3pfc3dpdGNoX3JlZ2lzdGVyKCkuDQo+IA0KPiBUbyBmaXggaXQs
IG1vdmUga3N6X3BhcnNlX2RyaXZlX3N0cmVuZ3RoKCkgZnJvbSBrc3pfc3dpdGNoX3JlZ2lzdGVy
KCkNCj4gdG8NCj4ga3N6X3NldHVwKCkuDQo+IA0KPiBGaXhlczogZDY3ZDcyNDdmNjQxICgibmV0
OiBkc2E6IG1pY3JvY2hpcDogQWRkIGRyaXZlIHN0cmVuZ3RoDQo+IGNvbmZpZ3VyYXRpb24iKQ0K
PiBTaWduZWQtb2ZmLWJ5OiBPbGVrc2lqIFJlbXBlbCA8by5yZW1wZWxAcGVuZ3V0cm9uaXguZGU+
DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9rc3pfY29tbW9uLmMgfCAxMCAr
KysrKystLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9u
cygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L2RzYS9taWNyb2NoaXAva3N6X2Nv
bW1vbi5jDQo+IGIvZHJpdmVycy9uZXQvZHNhL21pY3JvY2hpcC9rc3pfY29tbW9uLmMNCj4gaW5k
ZXggZDU4Y2M2ODU0NzhiMS4uODNhNTkzNjUwNjA1OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9u
ZXQvZHNhL21pY3JvY2hpcC9rc3pfY29tbW9uLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvZHNhL21p
Y3JvY2hpcC9rc3pfY29tbW9uLmMNCj4gQEAgLTIyNjAsNiArMjI2MCw4IEBAIHN0YXRpYyBpbnQg
a3N6X3BpcnFfc2V0dXAoc3RydWN0IGtzel9kZXZpY2UNCj4gKmRldiwgdTggcCkNCj4gICAgICAg
ICByZXR1cm4ga3N6X2lycV9jb21tb25fc2V0dXAoZGV2LCBwaXJxKTsNCj4gIH0NCj4gDQo+ICtz
dGF0aWMgaW50IGtzel9wYXJzZV9kcml2ZV9zdHJlbmd0aChzdHJ1Y3Qga3N6X2RldmljZSAqZGV2
KTsNCj4gKw0KDQpJTU86IG1vdmUgdGhlIGtzel9wYXJzZV9kcml2ZV9zdHJlbmd0aCggKSBoZXJl
IGluc3RlYWQgb2YgcHJvdG90eXBlDQphbG9uZS4gU2luY2UgdGhlIGZ1bmN0aW9uIGlzIHVzZWQg
aW4gb25seSBvbmUgcGxhY2UgYW5kIGl0IHdpbGwgYmUNCmxvZ2ljYWwgdG8gZm9sbG93LiANCg0K
PiAgc3RhdGljIGludCBrc3pfc2V0dXAoc3RydWN0IGRzYV9zd2l0Y2ggKmRzKQ0KPiAgew0KPiAg
ICAgICAgIHN0cnVjdCBrc3pfZGV2aWNlICpkZXYgPSBkcy0+cHJpdjsNCj4gQEAgLTIyODEsNiAr
MjI4MywxMCBAQCBzdGF0aWMgaW50IGtzel9zZXR1cChzdHJ1Y3QgZHNhX3N3aXRjaCAqZHMpDQo+
ICAgICAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPiAgICAgICAgIH0NCj4gDQo+ICsgICAgICAg
cmV0ID0ga3N6X3BhcnNlX2RyaXZlX3N0cmVuZ3RoKGRldik7DQo+ICsgICAgICAgaWYgKHJldCkN
Cj4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+ICsNCj4gICAgICAgICAvKiBzZXQgYnJv
YWRjYXN0IHN0b3JtIHByb3RlY3Rpb24gMTAlIHJhdGUgKi8NCj4gICAgICAgICByZWdtYXBfdXBk
YXRlX2JpdHMoa3N6X3JlZ21hcF8xNihkZXYpLA0KPiByZWdzW1NfQlJPQURDQVNUX0NUUkxdLA0K
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICBCUk9BRENBU1RfU1RPUk1fUkFURSwNCj4gQEAg
LTQzNDUsMTAgKzQzNTEsNiBAQCBpbnQga3N6X3N3aXRjaF9yZWdpc3RlcihzdHJ1Y3Qga3N6X2Rl
dmljZQ0KPiAqZGV2KQ0KPiAgICAgICAgIGZvciAocG9ydF9udW0gPSAwOyBwb3J0X251bSA8IGRl
di0+aW5mby0+cG9ydF9jbnQ7DQo+ICsrcG9ydF9udW0pDQo+ICAgICAgICAgICAgICAgICBkZXYt
PnBvcnRzW3BvcnRfbnVtXS5pbnRlcmZhY2UgPQ0KPiBQSFlfSU5URVJGQUNFX01PREVfTkE7DQo+
ICAgICAgICAgaWYgKGRldi0+ZGV2LT5vZl9ub2RlKSB7DQo+IC0gICAgICAgICAgICAgICByZXQg
PSBrc3pfcGFyc2VfZHJpdmVfc3RyZW5ndGgoZGV2KTsNCj4gLSAgICAgICAgICAgICAgIGlmIChy
ZXQpDQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+IC0NCj4gICAgICAg
ICAgICAgICAgIHJldCA9IG9mX2dldF9waHlfbW9kZShkZXYtPmRldi0+b2Zfbm9kZSwgJmludGVy
ZmFjZSk7DQo+ICAgICAgICAgICAgICAgICBpZiAocmV0ID09IDApDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgIGRldi0+Y29tcGF0X2ludGVyZmFjZSA9IGludGVyZmFjZTsNCj4gLS0NCj4gMi4z
OS4yDQo+IA0K

