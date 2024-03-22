Return-Path: <linux-kernel+bounces-111784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A298870F5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D47C1C20A7E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920FD5CDC9;
	Fri, 22 Mar 2024 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="emrsbpiK"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2086.outbound.protection.outlook.com [40.107.241.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B235E2208F;
	Fri, 22 Mar 2024 16:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711125271; cv=fail; b=ps9G2ApkBrZQ0Y7cZG3A4yizAb5P+wLSSLxFO/CydGax6gG7DL7vyRj4vtyIGR3SV4NqAUOzKbsyuTEU16g32KajE8dGnmKKRovGMniIQfXl6mTfkbgDNSn6i6+NqvCj7DkSqctBwTCv8T5gnLNMBEFZYtfjau7D6A2tCseK9vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711125271; c=relaxed/simple;
	bh=dydPSn1y/UeEiDgxpc2Xom3Y8R1cwnzw2uOMGFmEAc8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tYi1Ww52CtlhHw+MXdJ1pUco8HbaC/5onsbbWRBaitE1YrZCZCiu9q0XsMmaGDolrQcOBz3Lk6Fun0k9t8djKRkff8QyK3PaH9+faHcHIrEN1dT4jvxPI3ndwjM5IIp/cqmCWH+Fsxd9GpdlJ0VqEskXgBFhIBtdccQSqgP7QVM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=emrsbpiK; arc=fail smtp.client-ip=40.107.241.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JIVpHye0vRVrpGiEnuSguyg0R9PqSHAYQIKI9bZCdSs59tY4+PGAXkHIoVxnJTHEqmAt5Xnm94aZ0zC8z8wtXpXP4XDFR9Moc10Conh8SIPZov9GFQG60QrlnCwNWPm9NF9kpZ2bXs7O5lC6nrZgpiz06sCuTiAVbiEHcTo+LX/n/q0/QIyRUmI1Rj1e3kWP6ATgWGb69zNJBcwFNnmnvWCC37HNmh9YFWhLXFRZlrmJuiq/NFeADWk6xiqkObnzwsWx9J1oc4lvSrt8+Hmv7X4ahgiJxELnZoWdOACQQsIGOrpzGODZ5Li9CNus122Os9K+y5l0laSpz7xPWZv4eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dydPSn1y/UeEiDgxpc2Xom3Y8R1cwnzw2uOMGFmEAc8=;
 b=CZYQ6oVK+EhmzpsVF5LRDeagsvjqp7YwWZjl/S2kJ0afukX0ogGZdH/OeaZxjQkqXHQm8VymF385y/NmNMUWS6yDzwApn54nYpboQ84g2CMuUQdVNK9hUP3qDr867UZF1OvNGF8HXiMpUMIrWhfLGXHoXpykbLMhxzGDUKReveVOXTmPPZ1Nx+0QoKLwlYKDYRzNLkx3QBwRE/zLhm5E+h2nJNC46DQO/JAyQ+DczhbMeaGhdGpnILbJ0S1wf+dv+WOZyGAT6CKiN+SgBDFR6T7Rmh3xaZ/0FNRvOy9Ve7OOrcZ0H18VySg2zlrCdUnkSWV+p49ijUS39Ev5ZnLx+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dydPSn1y/UeEiDgxpc2Xom3Y8R1cwnzw2uOMGFmEAc8=;
 b=emrsbpiK22quL0uyTwxP8lE2ntRuo1AAl7Pk/2jbq/65wKPVDnZxj+NgW4RVDYPU9nJVSGjwYhYbZeXxJbR2Q1VpcmUfHWjJwYIaovG54+mjok843YsjGxh6ZGaivvX1/M6HQQxOX5Z8jRk2zyksX7QKb5i7tFDvPQpO6/gtwQw=
Received: from VE1PR06MB6911.eurprd06.prod.outlook.com (2603:10a6:800:1a4::13)
 by AM9PR06MB7316.eurprd06.prod.outlook.com (2603:10a6:20b:2d0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Fri, 22 Mar
 2024 16:34:26 +0000
Received: from VE1PR06MB6911.eurprd06.prod.outlook.com
 ([fe80::9256:56bc:4cd2:d41]) by VE1PR06MB6911.eurprd06.prod.outlook.com
 ([fe80::9256:56bc:4cd2:d41%2]) with mapi id 15.20.7409.023; Fri, 22 Mar 2024
 16:34:26 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "linux@armlinux.org.uk"
	<linux@armlinux.org.uk>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	GEO-CHHER-bsp-development <bsp-development.geo@leica-geosystems.com>,
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>
Subject: Re: [PATCH net-next] net: phy: dp8382x: keep WOL setting across
 suspends
Thread-Topic: [PATCH net-next] net: phy: dp8382x: keep WOL setting across
 suspends
Thread-Index:
 AQHab+nNNjxI3+NV+Uir0lLTLIYJU7ErVY4AgACd/ICAAh4MgIAVbpyAgACDAICAAAqVAA==
Date: Fri, 22 Mar 2024 16:34:26 +0000
Message-ID: <80d8a0ed-e54c-4d81-934b-94b16c84351a@leica-geosystems.com>
References: <20240306171446.859750-1-catalin.popescu@leica-geosystems.com>
 <8de1d4e3-6d80-45a5-a638-48451d9b5c15@lunn.ch>
 <b53818a7-66a4-4c7a-b687-efaea6cb9e4e@leica-geosystems.com>
 <f8bfbe80-f308-4b8d-b8f0-5a5f6ca5fa0e@leica-geosystems.com>
 <e9b85f71-f494-4fa6-acce-13ee8e147c21@leica-geosystems.com>
 <5746c9da-1d45-4d06-a925-4150e680b8ec@lunn.ch>
In-Reply-To: <5746c9da-1d45-4d06-a925-4150e680b8ec@lunn.ch>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1PR06MB6911:EE_|AM9PR06MB7316:EE_
x-ms-office365-filtering-correlation-id: febe7683-25d1-4c4e-b830-08dc4a8df0a9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Uj0BysVn1UT8xP/5WOEJcjJNzcrBS6TwOwsCCbQRPuVdgYzM6EegyDDvzyhYnCOxIhDzh3zz9+w1X02hpEsWXTfha8dCy0brJ996CTAslpXfP3GvmJ4SDHRe3fghzFU6R2yrvZwW1eDRU0xvn2ZnEdCAOHiPU93MmIeTQg4q7HcwxE3mzIsbi6lV/VLYd263QkduCy7T/pTnMDG036lmd1q+MjhwFpIdPAEu3xj6oSn/sUeWBJTXHU0QE8KFCQsWstuwY81ILJ5znLZXLhi2weK3sTYAhNcmCskdu4XuT/mY4NxUB7oYDVtUXrvd20DHB/LUI0sN1uGnIFawsgi9aAs/B93xCEqwASI5ZzApXvkryHxWepjIH2dtO1qudkiVRUhEl3cmeZFmhuI0Ze33KPn3fXdiss6QpSXjcABHL2bWnkT0WFcC0FbiH8IW/VMlcdm5c1Jw03MgC/CESSg9jknP35C4u5j1y5zMTYfLJUNf3GLn5v0m5Y4aX5Tsd+ExSGrdoI5ZXwkkwpoazQxjg3Ht63RLnoZO5PazW2FlUO1fwtdv/O9LCrc7b0XvKCJIdKzsYSADfqbfDjNn/7X5C+9+/ZM6+J9fYhhjH/wzHvioglETX+Oq5k5VDFaQaBKa2/bnP3zFJs7VGc0hXC/9rXrTm5loBDMVrkqn2Wm+lIYsltiJ3xaXTMkYQgOfC8E9Bk/7gGUHEr1OYQRtymgxk26XIjOflSmvzOQ7hJO/CdM=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR06MB6911.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NC8rS28xU1djcWtEdlFiK0dBb2tKLzdVUWR5Zmo5T0F4U0xWWlF3eXpBRHcw?=
 =?utf-8?B?SWRoZTgzSUU0dzIwelB0TmV0QVBGOFY2TzRqYkF3WEVpbDZyaWI2aFUzazVl?=
 =?utf-8?B?cTRhS3psa25mZ2xzMkZHd1lRa0paSGliN1prM3NCWEI4b3Y1MUs1dlNVL2Uv?=
 =?utf-8?B?VmEzRTlIZ2NaYXY3RCsyR09zQzB1RXBwTU1yWXBIWjhpWE1GVnVKRmRFY2Qz?=
 =?utf-8?B?R1U5TmtWQnNpRGhLcCtCL0NCV0hEbUdiWnVOZDJqVzdtdFBGYU9yN0lSMDhC?=
 =?utf-8?B?UDJjYzQ3bEZ1N0I5WHR2V1NjODhRM3RlVkJuRHI1VVMrY0p4dHpGSUVLVjRL?=
 =?utf-8?B?RCtGV1E0dWMzVUtESklBbmp4T3lJbjNzZzNvVGhiNUpMTjBsUHlWVnI0UFlt?=
 =?utf-8?B?RUYrOHBGNFdTZXdqYTZJOFUrTXBMWWUxN25nVThRSU1zS3R1RGQwOUpTMnAx?=
 =?utf-8?B?SzFQUVVUc0xrTHVWS3I5cXIyY0NUTDM4QkpQVkl5NmxLZGZOWmtlL1Fwa0wx?=
 =?utf-8?B?SEF4Umx0Yy84bTVLSmpkS21MdVpXamxUNzdYbTFCMTQ4VGpxaHk3MkRMaHhP?=
 =?utf-8?B?UUFoV2hjSUQxK3BjN2l6THB1cCtXNUNrc1hnNWlQYy9Ma2ptV2hHa0Z4QXU0?=
 =?utf-8?B?d24zMU9yZzlEWFVVbHJPZ2puNUd0K1J4L0dEOXR1OXFDWnY1ZU1KMllxS2FT?=
 =?utf-8?B?bHVSVVZYMDNxS3BIeStYUUh6TDlRb2xOM3RrWW1TTm5KQUR1STA0aEZOK0Vx?=
 =?utf-8?B?Z1B5RHNTcEo3b2RNcXgxRyt4a0hxOU03a2FZMmtZTEdIUmY2UlF1VkRjRW53?=
 =?utf-8?B?c2IzRVlJbHBKQTdncVFQbWY4VnB2VWlsQjRzVkRQaHV2RnNXTXU4TjBwZlQ0?=
 =?utf-8?B?aDlpbTFkMWt5RUlLN01hb29iMiswSEViMDRtam01cjY2TmVLTjRXU2dPS2c4?=
 =?utf-8?B?eEptWGJrZ2lQbks1VGpnRS9icXd1eW1XTU9oSmNvR2JYdXplbjlvaWpvWGZP?=
 =?utf-8?B?elZNdlljN2NrRmVPcXR4aW90RlBmR1RXVVNQM3huYXJSM3FnTkRabXB3Ly9v?=
 =?utf-8?B?MXBmOGh6NXRSMFlZRmFyR2U5aFVxbkdtNXhWQjE3Zk9xUGdFbmZ1QzlMdHpJ?=
 =?utf-8?B?Q2QxR1g1VkpzWEhhQnZOZjI0N1JsbzhIdEgvNjJXdGw0YTFaOTFPSmhaU3NH?=
 =?utf-8?B?UllxRnhwbitWbzdlbkg0M1UxUEcxdVJUbThRSVB3bDNEOFlHMWNLQU80Vnlq?=
 =?utf-8?B?bzNuRjlWN1RzUGlZY0ZlL3kxemJUOFgyWmVpMGVxRDA5bFU0d3l1d3FiNUwy?=
 =?utf-8?B?WkhtN1Z5UWVMVG1CaDBYazJ2TWtzVlJDVE1DejF4aldKY0MrTHlTcHZReEpU?=
 =?utf-8?B?WmM3Z0hOZ3Urb09QbFhPMmx0Z0xPQnAzQVpTZlZXSXpkNGpySzlKN3JTUGsz?=
 =?utf-8?B?d0FEd3JpM2V3M1k3MG9ibVR4cysyMVoydnJzenBjZ0kvVjR1YXhvRXJudGlI?=
 =?utf-8?B?bk5iWmpCOXEreUNCUXprWDBHdmRlWXQraFF6WWZoWHNyd05ZQTZVejhMT0Vh?=
 =?utf-8?B?NjQxd2NwRWJSY2ltcXlNK3VhWUdPU1cvMHcyQjM5QzgwMTA3NnY5ck8wWVZL?=
 =?utf-8?B?dSt2THBZeHRVL1U5MkxLcXFRcmVXMUxBTzBmc1JTMkJCdXIvNFlzZjVxNndZ?=
 =?utf-8?B?M05ZK1gwRXJwemZ3QVUxM3dvak9leW5USUFpdWdYYWJQbHNYZ1g0UlZIOGh2?=
 =?utf-8?B?UjZFZEhQTnNaZGg3VitLb1UzK1ZhdWlGcm9CMmcwZkxVOWlZanhrTWtXWDlP?=
 =?utf-8?B?bnRPVTArTmVOZE5JMkNhY1ZSVjI0bGdNMEtTVnBZeEljUGZiZFJuZjcvMiti?=
 =?utf-8?B?QzhoM1N4S2p1YXF0dm94Unp2OXdreWgweTdBWG0xZ21TZ2xLWkNXUTJaQjNN?=
 =?utf-8?B?bFVwSThTSkQ1cUF2QndtU3NlamlrZklRSmtpK3dPWXB1WkxLazhzMWlPVjQx?=
 =?utf-8?B?WjAxdUM2VnB3YVZTUFJsVW54bUJ6bmJMdFN3eGRtQlJTMmVWVmlpTE9oY21E?=
 =?utf-8?B?ekt0RTAyWm5XYktIV2k2VUVsdlRLNFRXbkxIY1E3enFNK2s2NzdzcUpYTjBw?=
 =?utf-8?B?KzN3Ti9xTUdHOXRXMzNPUndjblYzamJZdFVRVnBXVkIyWFluVitsTzFsYjV2?=
 =?utf-8?B?NkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA45452A64A5F34CB7FC81614F581D4B@eurprd06.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VE1PR06MB6911.eurprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: febe7683-25d1-4c4e-b830-08dc4a8df0a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2024 16:34:26.8075
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GnMI2HOzLAskuS9dNQ8nxR+gvsIP5AGbwwxJ6M0gTOn0EzOI++pCCY2NpAFZWdEcy1Tj1WmoJkMg5Ll/Wj+RxZ8byvZxc+Kdc/JaI4OagO9EeDu5lD0rqou8jEnKucDF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR06MB7316

T24gMjIvMDMvMjAyNCAxNjo1NiwgQW5kcmV3IEx1bm4gd3JvdGU6DQo+IFtTb21lIHBlb3BsZSB3
aG8gcmVjZWl2ZWQgdGhpcyBtZXNzYWdlIGRvbid0IG9mdGVuIGdldCBlbWFpbCBmcm9tIGFuZHJl
d0BsdW5uLmNoLiBMZWFybiB3aHkgdGhpcyBpcyBpbXBvcnRhbnQgYXQgaHR0cHM6Ly9ha2EubXMv
TGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4NCj4gVGhpcyBlbWFpbCBpcyBub3Qg
ZnJvbSBIZXhhZ29u4oCZcyBPZmZpY2UgMzY1IGluc3RhbmNlLiBQbGVhc2UgYmUgY2FyZWZ1bCB3
aGlsZSBjbGlja2luZyBsaW5rcywgb3BlbmluZyBhdHRhY2htZW50cywgb3IgcmVwbHlpbmcgdG8g
dGhpcyBlbWFpbC4NCj4NCj4NCj4+PiBJdCBsb29rcyBsaWtlIHRoZSBpc3N1ZSBJJ20gdHJ5aW5n
IHRvIGFkZHJlc3MgaW4gdGhpcyBwYXRjaCBpcyBub3QNCj4+PiBzcGVjaWZpYyB0byBkcDgzODJ4
LiBSaWdodCBub3csIGRlcGVuZGluZyBvbiBpZiB0aGUgUEhZIGlzIHJlc2V0IG9yIG5vdA0KPj4+
IGR1cmluZyByZXN1bWUgKGVpdGhlciB0aHJvdWdoIG1kaW9fZGV2aWNlIHJlc2V0X2dwaW8vcmVz
ZXRfY3RybCBvcg0KPj4+IHBoeV9kcml2ZXIgc29mdF9yZXNldCBjYWxsYmFjayksIHRoZSBXT0wg
Y29uZmlndXJhdGlvbiBpcyBlaXRoZXIgdGhlIFBIWQ0KPj4+IHJlc2V0IHZhbHVlIG9yIHRoZSBC
SU9TIHZhbHVlLiBJIGNvdWxkIHN0aWxsIG1ha2UgdGhlIHBhdGNoIGJ1dCBpdA0KPj4+IGRvZXNu
J3QgcmVhbGx5IG1ha2Ugc2Vuc2UgdG8gYWRkcmVzcyBvbmx5IGRwODM4MnguDQo+IFRoaXMgaXMg
YW4gaW50ZXJlc3RpbmcgcG9pbnQuIHNvZnRfcmVzZXQgdGhlIGRyaXZlciBpcyBpbiBjb250cm9s
DQo+IG9mZi4gSXQgY2FuIHByZXNlcnZlIHRoZSBXb0wgc2V0dGluZyBvdmVyIHRoZSBzb2Z0IHJl
c2V0Lg0KPiBBIGhhcmR3YXJlIHJlc2V0IGlzIGEgZGlmZmVyZW50IG1hdHRlci4NCj4NCj4gSG93
ZXZlciwgaWYgd2Ugd29rZSB1cCBkdWUgdG8gV29MLCB0aGUgUEhZIG5ldmVyIHdlbnQgdG8gc2xl
ZXAsIGl0cw0KPiBzdGF0ZSBpcyBpbnRhY3QsIHNvIHdoeSBhcmUgd2UgZG9pbmcgYSBoYXJkd2Fy
ZSByZXNldD8NCg0KSSBjaGVja2VkIGFnYWluIHRoZSBjb2RlIGFuZCB0aGUgZGF0YXNoZWV0cyBh
bmQgSSB3YXMgd3Jvbmc6IHRoZSBkcml2ZXIgDQpkb2VzIGEgImRpZ2l0YWwiIHJlc2V0IGluc3Rl
YWQgb2YgInNvZnR3YXJlIGhhcmQiIHJlc2V0IDoNCi0gImRpZ2l0YWwiIHJlc2V0IDogcmVnaXN0
ZXJzIGFyZSBwcmVzZXJ2ZWQNCi0gInNvZnR3YXJlIGhhcmQiIHJlc2V0IDogcmVnaXN0ZXJzIGFy
ZSByZXNldA0KVGhlIG5hbWVzIGFyZSBtaXNsZWFkaW5nIGFuZCBleHBsYWlucyB3aHkgSSBtYWRl
IHRoZSBtaXN0YWtlIDopDQoNClNvLCBpdCBtYWtlcyBzZW5zZSB0byBwcm92aWRlIGEgcGF0Y2gg
Zm9yIGRwODM4MnggdGhhdCBlbnN1cmUgd2UgZG9uJ3QgDQpmb3JjZWZ1bGx5IGRpc2FibGUgV09M
IG9uIHRoZSByZXN1bWUgcGF0aC4NCg0KPiAgICAgICAgQW5kcmV3DQo+DQoNCg==

