Return-Path: <linux-kernel+bounces-128240-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A36895835
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87C8F1F22870
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D693B132C19;
	Tue,  2 Apr 2024 15:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jmpMIKFm";
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Uj0wiX4v"
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B082512FB01;
	Tue,  2 Apr 2024 15:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.154.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712071800; cv=fail; b=sjWo/Z2SDnk42tPSsPTv/C+LRBymKSFIOkcPJ5GOuknxClN+VCULOHTMcSJgGtweZU2CVFnlIEg5WCRbPDu72ptKysR2JXNpAVZaKVCW4kB4pxYDVSEaDy9/GH+iX0q/loHkuKfblJK0iEbNCEJZLUv/hVeHShYCy3ZkgNfdAlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712071800; c=relaxed/simple;
	bh=mniHGddx/0nhrp2CJP8SKDXD9JOHmeqBHEosvRzDTFI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NRvjkqyAXMtfboFmGwrYKV3B3dREhbn8u21bXrxmdcdAe5DRAZT0iIIswlytAhRSrWpZHNncpONTarvgvzzfmW1eaHTTCqJ9mIkq1uBtnPmjaiKZrXwMPBx55aLFxtI5hRPJ3hARfb/YkL8OUJB9l/Xs4gKZlJSQBUyKqJVMFRw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=jmpMIKFm; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Uj0wiX4v; arc=fail smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1712071798; x=1743607798;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mniHGddx/0nhrp2CJP8SKDXD9JOHmeqBHEosvRzDTFI=;
  b=jmpMIKFmbEgOw0NzwBJf3xzjU0Z7XARma7fCbEWOyYIa6MyWP+ymkv4K
   emWmMnSQ9dq7r5eOaRt5KlUqc0GlhGKMaIo1NWyR4GZ/bMGTFY/CJTDnU
   Ajp42/CKvQbih76gZIeUsUzhIEY4XSF1EPjq2kmavL3b+HRmwMJcwC9MW
   V8o6yhK5Nz/hd6dV1skS6H0VX8TCWH7tBqu4puuva60cqbbJIXwJR8cjN
   C5j75APQyWdR0LgPk7pBzoVfuQkFk2d0CwaZqxZKUlvmMjEqvZQtmXiaW
   HCGKI0amkNVgX6WC+qjKkMc6FDV3hhcvGNwK1RmJLPDexeCAZv9ZJp6y+
   Q==;
X-CSE-ConnectionGUID: q4+89QF6QUqb/+Q6d2zdWw==
X-CSE-MsgGUID: taeLBC8NSHe079O+ZIN+WQ==
X-IronPort-AV: E=Sophos;i="6.07,175,1708412400"; 
   d="scan'208";a="186446398"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Apr 2024 08:29:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 2 Apr 2024 08:29:18 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (10.10.215.250)
 by email.microchip.com (10.10.87.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 2 Apr 2024 08:29:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WiqkB+xYZxhSnJgKE2JiJU7SfSfFSF3x8xDgOSo8envaalSOvdSXP+6ZMkWYIlz3XI2+rF6hKrhDJWWdq+iYeUk8e+OFqvMADGLu6AFz1iszJ5xtMpq60CY/4UxwpIl5l4H175BrTRBGNm3j5W75Z/rhBsWagp5vZmUixqtsn0RvCekUkb6/GvfrH5p86sv+73sJdysq/OHYxXZqqCF/nk/sINqkH0o1Qwu87lgkS5YLS+RFtXDzL59P03xVNQvAqf44qOz52Ogjb0yum6UquBCEAdrWz3vCuibp1ZBeuwzEQhF82F3H0xFW1ZLG5ByIUhmRXRoX8MEFNUb6RCCxDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mniHGddx/0nhrp2CJP8SKDXD9JOHmeqBHEosvRzDTFI=;
 b=C0z8zt3PTnRSAsmE3FomqzR3HJXFiuPNt8k3AI5T/U+iDZzYKPVt7IZeDtfpmePlkD5OaSs8ajkuDrvxGwRmfD7f8ZYOFIcVDjdbxjOIpzN/1uUNx51sqX0/Ko9frjcN/TRyOen/+EPs38D4HbrtapVPd4QNDgDvH3uimO4ZLBmtlUeZg3zd1vC+vGT150/rP/Jqi2lqwfwKiHUHUwdkgitWYOdoo50EYTZddUvxsLHhAU9AUvAbgtEf+Ndo44JfHz70DNRWLxPdT/ug/xJYGw0v+K3devnup9H7cEMvPG0oO9HUHmyyBg2tP6ATU/a2W808etFqbTCTrGHlV0048g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mniHGddx/0nhrp2CJP8SKDXD9JOHmeqBHEosvRzDTFI=;
 b=Uj0wiX4v4EAPsWpNGdye0P3LOYuYyCS3tEImiXGd5FvGteyAD1BKeW6SiBz9EA04ivkx8/QplVCMgpCZvL/oPrQawdA/j7DmLHJqgH/AnjgUaSuzb5lylJxC5duUmIyCH8lfsB5zxhOYvcQSR0j/DONHzlsfuEzqffHqJQ3bzD5zSpZwb/8nrE0P7TKrqGCDJlV3UVMli1DS3p5ZovkHUFG77d17fw+6gA7+LTWjrXmKMeA8m5w+0nQJGQ0bUOl7Ugxo8P7p6AUNGbJ+11gdeOPhWSSUq6WrJJ04954t53vaw2skqPBRfz21w/IvVhQSqn6Es62fSGgPnbAe/6XXWA==
Received: from PH7PR11MB8033.namprd11.prod.outlook.com (2603:10b6:510:246::12)
 by MW3PR11MB4649.namprd11.prod.outlook.com (2603:10b6:303:5b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Tue, 2 Apr
 2024 15:29:15 +0000
Received: from PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d]) by PH7PR11MB8033.namprd11.prod.outlook.com
 ([fe80::d529:f716:6630:2a1d%3]) with mapi id 15.20.7409.031; Tue, 2 Apr 2024
 15:29:15 +0000
From: <Arun.Ramadoss@microchip.com>
To: <andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<Woojung.Huh@microchip.com>, <pabeni@redhat.com>, <o.rempel@pengutronix.de>,
	<edumazet@google.com>, <f.fainelli@gmail.com>, <kuba@kernel.org>
CC: <kernel@pengutronix.de>, <san@skov.dk>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net-next v1 2/8] net: dsa: microchip: Make
 ksz8_r_dyn_mac_table() static
Thread-Topic: [PATCH net-next v1 2/8] net: dsa: microchip: Make
 ksz8_r_dyn_mac_table() static
Thread-Index: AQHahP+ifZkQz1pgUUe+5YICVKP74bFVG2yA
Date: Tue, 2 Apr 2024 15:29:15 +0000
Message-ID: <bc396b7d3f71e242dc61e24dbe25cd0e43cc5f40.camel@microchip.com>
References: <20240402131339.1525330-1-o.rempel@pengutronix.de>
	 <20240402131339.1525330-3-o.rempel@pengutronix.de>
In-Reply-To: <20240402131339.1525330-3-o.rempel@pengutronix.de>
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
x-microsoft-antispam-message-info: 0YM78ICEVMKsOYOYCfCkmd6FzZnI3Idbw9RTbJ0X7XaGOHLF1DyLPG8OWW0dDwM+MB5/hs04ITw3/rWxuMwUN6xF12y/9JYsbGgL5KzzN0d/ImHRC5QKaQLmQm6+jQuLEHoV/x7fm1Rw/1yadGnkzuRcS1AUhh93EI4s7P2XBm3Gziipe1y8W1LDDpjuJ9ZmWpKV98YpHUqUSVqFI2A9pQ2W+O9H5MkT0rDn7cY+ca6nbu3vxtH7sJuVAWfKH+Tks/j14Vcx494n0cEmYqupu4phWxXjVqpifdX/eWYvGX43rhRVAANBAjg/Xs+gI0INQroJ6mthHGDqXrxysksCZcgiNqABdLDGpmC7RCsWr+nELNXF2M1o59pEw319vcniEAWGwE957f6sKRoQbySvddqEMBlyYLNYCEkC14gBA3JBQbtqAysU/70xyMUogaQ4Ed13pR02nRWh6BZ3dh+CYZ5wTwQn/5Eo2lmlo36N7Aj8AminI0PDqoQFaAT4r2ODpvtGOwA95h63ll41OQjJ6czt2H5Ueo4+UakQbEEIlC+q16GAgv1QXAnmUmajl4p78L2XKNPW3kCl1RhAG8kRsv+c21oTqhV3TCSYjDbhyMckOtnA0vF656ANO27yVaXnSOueLXCbnUKM+ejafFprDazmxnrka9qicx4YBU9lIdo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB8033.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGFMQWJBblRvZWRucFJvazl1a09CdkM2VDVzUjBiK3FFQ2FSdWVzd2NjS3ZR?=
 =?utf-8?B?S3lnaVc0UmZCZ2hQQlBFNmZrUmJkWGFVZmRsSmtldGhXQ29odlU2SDNMU1Rt?=
 =?utf-8?B?UUdtK3Q5cENFWTdhdFBrcVhIV1dmWGU2ZVRZZ0pMS0NJMkFUdlZNKzJJb2xD?=
 =?utf-8?B?eUhZcEhXNGlESVp5bUZERDMwaGRxMU9DenVvOXRaS0svcjQ3WWUyRkRpOVIw?=
 =?utf-8?B?TlVVc2Y1WTBTb3BDRDhIdzBVaEJZYzJsZjdNYUZLek9FYlVlbHc0TXdFK1BT?=
 =?utf-8?B?NDZBaFAwc3B2azI0NGdHTUlRWnYycVlGaGtpSGJrWE4ybmprOUxqYk1FNVM3?=
 =?utf-8?B?d2prNXZUM0tER2Q0YmgwWVpSTHkyY1htTFo3TDJqU1RnREZFZlZLNHlCYVR5?=
 =?utf-8?B?cVQrSXZTTlZUMFB4WHdUM0dsUHpOajFmcUlKUExwQzNzb0xnWUZUd1VDMElK?=
 =?utf-8?B?WjlVTUFqRUF6ZGdaSUJLMkl1dDV4TURhZUJuSDJUTjRDcXlMMmw2VnFHNmU2?=
 =?utf-8?B?eGhZL05JS2t4cEJTQkZ4RDE5ZmM4VjAwb3RHZmpibFNzUUttdkpodDNsU1lz?=
 =?utf-8?B?Y1pFOVhDVnFNNnFyR1ZqNFpGYy9wZHNiNkdhYjV3UHVnSVptbjdWVmFDNTRB?=
 =?utf-8?B?R0RtQ1J1aUtKUCtXOHhpRkdoYTFlUWJNR01uRUx0NjJvcytiUjE0WngyQm52?=
 =?utf-8?B?Qm5QZUx5eTZQWWgyNHpDd1pkeHREd3NWWWU0dk1XTjFMNzVtZUl0S0ZnQlRp?=
 =?utf-8?B?TU94ZTVLdEtHcmV4NlQ2OUFwVllVTVBvYytKV3hCV1RmbG5zL2tWdk00UUhq?=
 =?utf-8?B?OFBuRWVFQldieHZaNngrbnAzVHQyeCtQOGhkOS9ueFVzdlBCZzRrblpiSTAy?=
 =?utf-8?B?aXFsMjczQXpLUWdkYXJWQlBXK0xheTBjNnZ1SU1OL1V3MGNLSlhieVcyZldQ?=
 =?utf-8?B?ZStEZ1VieE11bFZmaUNPdDUrK3FZU2ZOUHhSc3ZBbGk0Vmk4VXptVVlRbGNL?=
 =?utf-8?B?Q1IyUU1JbjBHNzIzRWNyZSsvd1ZQaHI3VDlkaEJJMUU0OVZORlNnTHVqeHBq?=
 =?utf-8?B?UHhkRGxFVDYzWUxsYnFXaHRIMHdNWXZqTUZKZ3Z3WjNNclBNQ3VHRUdtVzE3?=
 =?utf-8?B?UkJNNGF6Ni9uV2dnT1ZORHhpbUlONm9qL3NKZW1OOURsd2l3aWI2U0Y3TUtE?=
 =?utf-8?B?OWVsZHcxbk00UWVWUDdKSHcwMFMvV3NIZGFNVXlUK1VjZlBOaGRLUjMxY3RB?=
 =?utf-8?B?cWhQc1FwN2FlZUJ1cXhsaFdYVThFbzVJanhiZzN5VHVqd3Q2bUJPRFd5NXAy?=
 =?utf-8?B?QnFnMTNrVWJWTVNyejZCdzN4R3RMQ0ovd204anpPQ253ajkxY25OZXpRenJE?=
 =?utf-8?B?QUFWNDNVM0lmeWZ2SHgzcVREaUp6MDBiZ3J0RUliaE9pbDRyWTJmc0szclZS?=
 =?utf-8?B?WXFZOVNZSG9MeWpETno0K3d1eUtLakxGT1RZZFVqMnhGUnVyTFV4QTZvWU55?=
 =?utf-8?B?anlxT08wc2lEMm1TSnArcGFFUmtaTVVLZkZ0M2c4c3FveWFBVVJkdWYzMHN0?=
 =?utf-8?B?RzgwVGJCa2F5d2szOW11amxKdDh4K2tyOElkNFlNdHl6RHNnbkUwbllqU3NX?=
 =?utf-8?B?ZytqL2lhU1NLL3FLamV2eXFYMWNkeFhrcXE1eHFOZ2xoV2R1TkdVY09YbENU?=
 =?utf-8?B?Z3JVL1ZhWm5Vb1BoUE1XR2lCTUFDdUM1OUdMeEM5aTdSTUxwTjJod0IyTDIx?=
 =?utf-8?B?ZmV0Q1g5eUU3Qk5uTVhYTklONktPL1dWbUptYktqMlhmRnBnSTFWYmhKeXgr?=
 =?utf-8?B?cnhEVjBmc2tlcStsZW55Vm13VFJEMU54bkY3V0ZmQzhHRlQwTndrZS82T1BS?=
 =?utf-8?B?V2xPVTQyR3k3cmNFdEx4SFVkUHZ2dldzWFdnajJjbEJ2Wm85L0J1ZzZ6Q2lS?=
 =?utf-8?B?M3JoeUhqaWhkWFNxTlhkR0JzVnUzYXVoSG1OdWp6eTJadmlTdG16dUUwUzdq?=
 =?utf-8?B?dWN2eWlEOUZScHZ0TzhWeEw5aitrbm83Q25IV0xyNElIa1VIaG1OZ0YySVBt?=
 =?utf-8?B?Z3VpN1BmOG1TUDFOaUhGeUhQR0lnR0xVYURkR2Q3YmxOa3Zoazc5SWdDa2pp?=
 =?utf-8?B?dDJWR1BsVXVMaFUzTEhhM3YyMkNzQjM0eSthUENPQ0IzaWxWajFjanpDcmJW?=
 =?utf-8?B?YWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5E7A4ACEAB76B648AFCAFFE6012B74DE@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB8033.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 648ae87f-f8d7-4c88-9269-08dc5329a7d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2024 15:29:15.4115
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: csJysmyYwi59Wx68baQRJMxFgnWKGFl47vrysrVDgHq9DrO/EH7q+LxQEkoiaIZ9EUGaif2sdnbvO2AhXHF97jpLnXId3NpoQG6nDXshW2s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4649

T24gVHVlLCAyMDI0LTA0LTAyIGF0IDE1OjEzICswMjAwLCBPbGVrc2lqIFJlbXBlbCB3cm90ZToN
Cj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3UNCj4ga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBrc3o4X3JfZHlu
X21hY190YWJsZSgpIGlzIG5vdCB1c2VkIG91dHNpZGUgdGhlIHNvdXJjZSBmaWxlLiBNYWtlIGl0
DQo+IHN0YXRpYy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE9sZWtzaWogUmVtcGVsIDxvLnJlbXBl
bEBwZW5ndXRyb25peC5kZT4NCg0KQWNrZWQtYnk6IEFydW4gUmFtYWRvc3MgPGFydW4ucmFtYWRv
c3NAbWljcm9jaGlwLmNvbT4NCg0K

