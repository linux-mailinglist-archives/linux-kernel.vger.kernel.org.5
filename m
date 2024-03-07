Return-Path: <linux-kernel+bounces-95290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B47ED874BD3
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D61281C228C4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C40A12C7F4;
	Thu,  7 Mar 2024 10:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="uUfVyMj5"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2074.outbound.protection.outlook.com [40.107.6.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB9C839E8;
	Thu,  7 Mar 2024 10:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805700; cv=fail; b=SP8MNqeyyGw6XIIrJCFBvwdbasqTtH3yxX3cs++WFJvivW1xsEMDWhGX/8qWJFPfzDllUdoHnValuULNYd81U1kdtwP4jaDhBLaQsFi1dzimGGSanxSHDyCvITUQ/MzdCn/9l58TFkO2gVblNbPcl2kjPcMeLBPcgN6Mt5+OirQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805700; c=relaxed/simple;
	bh=chOgv484jZWLm14U5WQX9LBHC+856es2MnwncYLl3FA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XmUZLIEWXZ+LN7Jus/LN3S06D6iYQV929buTc+nEj/dwUjoivLu1LzQLp1epB7zTkmlCfVLwR+UGLdMHPi6bTy8/1H+gQFATjqsSnGg+CZAqs3is/s8MX5Xw9dX0KM5CnhJGbHHqiwRVcD+jqxB6+DJNqVlOHzt6IxUOJbEilkc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=uUfVyMj5; arc=fail smtp.client-ip=40.107.6.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nChUeQCXhEWjLHS3E5B7eCXiSjzvGSb9p3ZGoQz2cYYUOlA5MkmwVj/1zVBFpA9PqFQs5kVxODNOhzFeb1KRA9urY3v6UWaZyD1Ii6Q2B7M+ZJQZW1fMDzl65PB79JeJR9xKVziMtBs/KloEeH5nnQO8RY151EQYHILy1SkSZkxa+HvwJzFThRN6X+CsIWH9YpJPXHtuz7fiY/Wv/J8b3He2hrVMMzKYDzG32q4nfAgs9IP/sH1VzZ6uvfSEU/XUQhmlMd35fFTMxKufGme/aWv/Rtt/7y1LDGngFZU2WiDLDFGRGTleBqrgz5ZRPliQRjbxt90PNlScvTVMkQiALw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chOgv484jZWLm14U5WQX9LBHC+856es2MnwncYLl3FA=;
 b=dJc2FnfU74JvmmB2p5v6KKIqs5R8wOjEMZZ/mCSFIqX+6dRoT4dPhw7nQbINb/hHoQq+Wf6+SZRnmx8n7FUx14ilTHuQQS08oxYv4voqqTJKrL9efgh68pe0d3uyxM/pzdj5Lj9tAKnQtGVIYQ7rPfVjC+4m+IuvzXMxz/1PhMcKZkua1clOynO6HVc2bkD04xWwM3bTSeKIjFj8jpvZoY5n7BBywxfjg9UlS4fKTFK0h0QH8gbfGNdUqEvc24Xo6YCYI87+0JFfTPI/ZYYX1hx0bJywngp1CrrynJQqKAO7AJFBP82xKGrPwwY5JW5ayxT1moCoY2tJFfi3CJ+WRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=leica-geosystems.com; dmarc=pass action=none
 header.from=leica-geosystems.com; dkim=pass header.d=leica-geosystems.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chOgv484jZWLm14U5WQX9LBHC+856es2MnwncYLl3FA=;
 b=uUfVyMj5RPopOF1RHqEuIfISAIdZ8dqo0EDB8HWNrXGO4u2GB/+zq1RjjxQ2kI+py78wHBiUNLef4A/qstd0r70y0cdAMYBmGwcgVGrfPX4HP7lnYa3mm+6M38p+s1MlS/if5epXa4/adiqlcRzyfBkXZ3XYhIww9EVR3yRc+FA=
Received: from VE1PR06MB6911.eurprd06.prod.outlook.com (2603:10a6:800:1a4::13)
 by VI2PR06MB9526.eurprd06.prod.outlook.com (2603:10a6:800:224::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.22; Thu, 7 Mar
 2024 10:01:36 +0000
Received: from VE1PR06MB6911.eurprd06.prod.outlook.com
 ([fe80::9256:56bc:4cd2:d41]) by VE1PR06MB6911.eurprd06.prod.outlook.com
 ([fe80::9256:56bc:4cd2:d41%2]) with mapi id 15.20.7362.019; Thu, 7 Mar 2024
 10:01:35 +0000
From: POPESCU Catalin <catalin.popescu@leica-geosystems.com>
To: Florian Fainelli <f.fainelli@gmail.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	"xiaoning.wang@nxp.com" <xiaoning.wang@nxp.com>, "linux-imx@nxp.com"
	<linux-imx@nxp.com>, "alexandre.torgue@foss.st.com"
	<alexandre.torgue@foss.st.com>, "joabreu@synopsys.com"
	<joabreu@synopsys.com>, "mcoquelin.stm32@gmail.com"
	<mcoquelin.stm32@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>, GEO-CHHER-bsp-development
	<bsp-development.geo@leica-geosystems.com>, "m.felsch@pengutronix.de"
	<m.felsch@pengutronix.de>
Subject: Re: [PATCH net-next 2/2] net: stmmac: dwmac-imx: add support for PHY
 WOL
Thread-Topic: [PATCH net-next 2/2] net: stmmac: dwmac-imx: add support for PHY
 WOL
Thread-Index: AQHab+scVJOjKV/i6ECTY9fbEkaV4bEq+0gAgAEEOgCAAA2GAA==
Date: Thu, 7 Mar 2024 10:01:35 +0000
Message-ID: <6db831e0-3063-49aa-a715-8e9b5949deb3@leica-geosystems.com>
References: <20240306172409.878928-1-catalin.popescu@leica-geosystems.com>
 <20240306172409.878928-2-catalin.popescu@leica-geosystems.com>
 <bbe3e611-a310-41f5-a037-4b7d5e914b94@gmail.com>
 <ddd2f984-e5e7-4708-a013-bfd668794466@leica-geosystems.com>
In-Reply-To: <ddd2f984-e5e7-4708-a013-bfd668794466@leica-geosystems.com>
Accept-Language: en-CH, en-US
Content-Language: aa
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=leica-geosystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VE1PR06MB6911:EE_|VI2PR06MB9526:EE_
x-ms-office365-filtering-correlation-id: e925083c-702b-4a53-a84b-08dc3e8d92d9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jBiAhaDK3/HGxONZpoUdtM0UouuOKBVgpeDGOu5+cjdYJyYrUkpPLYXN4LAeuxPpJcSQMPBwfSuJrRD2+MjASOgi9suCoYZW5ZvVQ5Wxh6aZtnBlgP3VSxuwkQWOu7x1+SAswgapIuse7/db8yb7cj1Ch13vH4wyHJvlXjipkUnwjumncIh9WYlj6fl7RdBnkOEKS0gCEVIu4PpuvmePdBzy/eHTeLA3y2g6YAoyJDVactqLn76K07wLbaK/ViGUD7j4C888bTHX8R1SEfC3krxhIp8eFVMQM64MwR1al640KWBC9aQgfX2i7JJa0ApyJ1oEuRlfgAfu3/XsUW2CrPP/tQoOGOnwWfkXydlWOLUEo0iQbbeYbwgepp5063U5JWPh0pGYM4OVJD15cou4grBbIJLuiJdb9n/W888eOtoS7zxwVBGU2mfK5FoxmH2VMzGqYVkZX9rXatWj1/u29s8uBVpb9OuAi2+DIV0u6Jyh58wcugh7nr5Wm3pW5zyqkMi+MoU0lhIRVe9Zq5YJH+1ZhwbuZwpfHeTmlEKbK9VNVlom+wioFkwGigUC2vL6Ryi61S7xwd3jZa3CEpECHprMqk+G9XoeSZxx+BSJ/BCoxhAz7F+4oczfUsUzP6iXxTKSnp4ZsfMZq45wSsXEWOPlFNo59TC6tcI5aaj0IL8tSkTqa9r/4uNa1zc6ExJt6v133F2265oEBqSiOJvH9iUd/rvCF4c4mmb+7VW3fOY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR06MB6911.eurprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Q1VodlpPZk1Yb1F0clVGTVRMSDV0WlBsdmtzVXFieXJPalFndmtHVm82OW5u?=
 =?utf-8?B?bWsvTEY1b1RyRFRJSmt5WXhnODRKYnNRMlhKTzNtV0QxV1FNYjV5QXpSa01H?=
 =?utf-8?B?VFBYdGx1a0xqdThYSXBFekxWY2pRQ2Y5Y3F2QlYxR0xhQmoySTNxTjNYQ1ls?=
 =?utf-8?B?ZWE0N2l4Ujhlc1NjZ2xtZjk5SEpmNTdabVoxWGt4UjFaL0VVeGtVcGg4bSsx?=
 =?utf-8?B?RWIvOE02R3pzWG9DbGp2aTZwR01HbWVLZm96a1BkTys0R1NuZzNQbjlNb21E?=
 =?utf-8?B?MHptalRobVc4TmdjMlhVYzRLaHViMVg2RUhDN1dCbGFmSnd3cGRwUDZGYisv?=
 =?utf-8?B?NkFlajlKZkJYakhTWmtMNjBxRzBRU1VtenArckt5N1gydERmM3dHclJ0ZUhD?=
 =?utf-8?B?YmdTb0UvdUp5Z1FtZ2tPUHFvRnFrSFljU3AwTDZRcE9FamoxZ3NwSm5XbUFG?=
 =?utf-8?B?K0oySkJra0pCd2JPeW9kS0lTdUlwa3d4M3B4cktPRkY1WHAwMmlUd3ZETnhM?=
 =?utf-8?B?Z0ttV3hEZ1lyK0dDeTUrTzNYSjZCVDNQSmVsWXcvQ2tZY3AvRmg4d2NvcEg1?=
 =?utf-8?B?Lzc2NXBTSlQ4SEZ5anRzeFlRazZKYjk4UHk0M0Q2MGRHblFLVDZ0ZjFWbmRt?=
 =?utf-8?B?V1ByZG9NejQ2UFdvU1dUTkVxZWpIc2o2ODRqRFl0b3p6bk9pSmJXSG1LR0pC?=
 =?utf-8?B?K0hKUHAveWk2MWhxWUtWWTJxYkNjeURmNGlkczFHQnRPQlZLTDBnVUd1OHd6?=
 =?utf-8?B?eEFtSk9iYzkzemp6OGdySkhuRmlCVXZyNTJKT01qSjEwaE9QaDV6dnY4cUxT?=
 =?utf-8?B?eUhpWnFhcGFhdjJKQmVuYTN0L2pOei9yRmYwRGJheldxT1hjUzloVmVmWWRC?=
 =?utf-8?B?Mk5LKytRRzduYUZUQng1eGluOXpyZncvMUxvL01UaHZkcW00dit4dDZBcHpw?=
 =?utf-8?B?ZWUrcmxzU3EzRU54a2d5aWYrYzlQUzBHS003R0hteDJNUGZxaVF1U2RPcFZh?=
 =?utf-8?B?SzZjS2p1SVBxcFo3cXpIWWhGa1JMeHZmdnZtc0lGUkZ4M0dHcWhGcldtYzh3?=
 =?utf-8?B?S3NWOFJnL0ZIbnVvZnpSbEkzZURodjJlVStNa3ZGUXVleGZiTGZEWVNnVS9M?=
 =?utf-8?B?Qkw0ZGYyS3JlaVo0SjZzM0ttVmxNSWFSTzJrOXUxR2kzNnFJNy91dUJudzFM?=
 =?utf-8?B?YXBWbDMxdnErUDNSc3BFVUxyWmlmQkxYc2lUTXJLNjczTkxWc1FIb2tEUUth?=
 =?utf-8?B?dWthQkg1eDM2aVZrLzRFOHFsWTlLTVZGOUIzbkRjcXpFakpWWHJVaDIvV3RD?=
 =?utf-8?B?UWQ1TnQ1MVc1NlJkUkpOWjNpU2lFZlBJV0FJK2ttRmx5YlFyblpQN283TEJE?=
 =?utf-8?B?N1NMMnpmOUNCMmZkTmthVUpibzlNelpkOFVYUDFFY3VpTWRQQ0U2bjBGaXND?=
 =?utf-8?B?NkQ0bThFbTJ6YjdxdXE4UktZSUs2VEZiOWVuYU1rcEdmZXdPY3VZY2kzRTQ3?=
 =?utf-8?B?cHZ4cXNUR0dQRE9VdnVPa1Z2S2h2ZmpIb09uWmpwYnFQYmsrMmxtclZmSnBN?=
 =?utf-8?B?WlY3NXpUajJTeTBQQSs5WTczMTY1NXFReHBpWlNKZm9HN2hZakJKWDEwZXhS?=
 =?utf-8?B?TlJhVC96bkNlSklmT3Ruc2IvZGJ4SFB2RUR0d1dzV3VHb2pESTA4QWl1dnJN?=
 =?utf-8?B?WWZUYU9xZFdnbVJqTVg5ME5ETzZwZk56RTVtVXg3dEpjTXg3dUczRHVmdHUy?=
 =?utf-8?B?djVLOHgxTG9ZR1EwNEFaVUxtYmJmQjRyanlxR01oUjVkZDRrdHJ1bFVHSXhi?=
 =?utf-8?B?OFdEODJhWFROdHdXVGtZdFNzZ3Fxa09MRWFDVUMwdlQ3VTZoUFpnTnJRMG5B?=
 =?utf-8?B?bU9Ca25MWklsNUx1MGRIamNINi9vNmIxSG91REtkS1k1UmFlRElrSFpVS0pH?=
 =?utf-8?B?dUdkNmMzcldMTGpIanBuNWo4b0VCd2ZWY1Y3aEsxdzJaanNwWjRBb3pTVENk?=
 =?utf-8?B?Mm9Lak80OHB5OWZGNUp1MzZZUVRjR1JvR3hCMmU0c3g3NXh2Q2N2UGtGTkdx?=
 =?utf-8?B?MDBkRzBlM3QydlpFRUQvYllxdEZBK1RmUlBySktPR1g0V2JWZEd1T2F4UmdH?=
 =?utf-8?B?aGN1QVpqQWdYQk5pR2kxckdtMncxbWk3NktjN1FRUCt5SytFR29mNXp4NHAr?=
 =?utf-8?B?dGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <25080C6E2B2BAD4486E2F91D350C390F@eurprd06.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e925083c-702b-4a53-a84b-08dc3e8d92d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2024 10:01:35.4593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NVpHtjiPQ60bBGapGmt1I83lNUNuZZhcgAh/Jv/jheJwZ3kIl6oIwPJRFu/D5EU3p4EXbOLadbAaXKvZgG/Ose3A+AioqfWb02uxoEhsLnvycA4AU3eC8ZjsInSlo5WO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR06MB9526

T24gMDcuMDMuMjQgMTA6MTMsIFBPUEVTQ1UgQ2F0YWxpbiB3cm90ZToNCj4gT24gMDYuMDMuMjQg
MTg6NDEsIEZsb3JpYW4gRmFpbmVsbGkgd3JvdGU6DQo+PiBbU29tZSBwZW9wbGUgd2hvIHJlY2Vp
dmVkIHRoaXMgbWVzc2FnZSBkb24ndCBvZnRlbiBnZXQgZW1haWwgZnJvbQ0KPj4gZi5mYWluZWxs
aUBnbWFpbC5jb20uIExlYXJuIHdoeSB0aGlzIGlzIGltcG9ydGFudCBhdA0KPj4gaHR0cHM6Ly9h
a2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4+DQo+PiBUaGlzIGVtYWls
IGlzIG5vdCBmcm9tIEhleGFnb27igJlzIE9mZmljZSAzNjUgaW5zdGFuY2UuIFBsZWFzZSBiZQ0K
Pj4gY2FyZWZ1bCB3aGlsZSBjbGlja2luZyBsaW5rcywgb3BlbmluZyBhdHRhY2htZW50cywgb3Ig
cmVwbHlpbmcgdG8gdGhpcw0KPj4gZW1haWwuDQo+Pg0KPj4NCj4+IE9uIDMvNi8yNCAwOToyNCwg
Q2F0YWxpbiBQb3Blc2N1IHdyb3RlOg0KPj4+IEFkZCBzdXBwb3J0IGZvciBQSFkgV09MIGNhcGFi
aWxpdHkgaW50byBkd21hYy1pbXggTUFDIGRyaXZlci4NCj4+PiBUaGlzIGlzIHJlcXVpcmVkIHRv
IGVuYWJsZSBXT0wgZmVhdHVyZSBvbiBhIHBsYXRmb3JtIHdoZXJlIE1BQw0KPj4+IFdPTCBjYXBh
YmlsaXR5IGlzIG5vdCBzdWZmaWNpZW50IGFuZCBXT0wgY2FwYWJpbGl0eSBidWlsdCBpbnRvDQo+
Pj4gdGhlIFBIWSBpcyBhY3R1YWxseSBuZWVkZWQuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBD
YXRhbGluIFBvcGVzY3UgPGNhdGFsaW4ucG9wZXNjdUBsZWljYS1nZW9zeXN0ZW1zLmNvbT4NCj4+
IE5vcGUsIHRoaXMgaXMgbm90IGFib3V0IGhvdyB0byBkbyB0aGlzLiBZb3UgdXNlIGEgRGV2aWNl
IFRyZWUgcHJvcGVydHkNCj4+IGFzIGEgcG9saWN5IHJhdGhlciB0aGFuIHByb3Blcmx5IGRlc2Ny
aWJlIHlvdXIgc3lzdGVtcyBjYXBhYmlsaXRpZXMuDQo+IEknbSBub3Qgc3VyZSB3aGF0IHBvbGlj
eSBtZWFucyBpbiB0aGF0IGNvbnRleHQuDQo+IEJUVywgZHdtYWMtbWVkaWF0ZWsgZG9lcyB0aGUg
c2FtZSB3aXRoIGJpbmRpbmcgIm1lZGlhdGVrLG1hYy13b2wiIHdoaWNoDQo+IGlzIGEgY29tbWl0
IGZyb20gMDMvMjAyMi4NCj4gSSB1bmRlcnN0YW5kIHRoaXMgd2F5IG9mIGRvaW5nIGJlY2FtZSAi
dW5hY2NlcHRhYmxlIiBzaW5jZSB0aGVuID8/DQo+PiBXaGF0IHNvcnQgb2YgV2FrZS1vbi1MQU4g
ZG8geW91IHdhbnQgdG8gYmUgZG9uZSBieSB0aGUgUEhZIGV4YWN0bHk/IERvZXMNCj4+IHRoZSBQ
SFkgaGF2ZSBwYWNrZXQgbWF0Y2hpbmcgY2FwYWJpbGl0aWVzLCBvciBkbyB5b3Ugd2FudCB0byB3
YWtlLXVwDQo+PiBmcm9tIGEgUEhZIGV2ZW50IGxpa2UgbGluayB1cC9kb3duL2FueSBpbnRlcnJ1
cHQ/DQo+IFBIWSBpcyBUSSBkcDgzODI2IGFuZCBoYXMgc2VjdXJlIG1hZ2ljIHBhY2tldCBjYXBh
YmlsaXR5LiBGb3IgdGhlIHdha2V1cA0KPiB3ZSByZWx5IG9uIGEgZXh0ZXJuYWwgTUNVIHdoaWNo
IGlzIHNpZ25hbGVkIHRocm91Z2ggYSBQSFkncyBHUElPIHdoaWNoDQo+IHRvZ2dsZXMgb25seSBv
biBtYWdpYyBwYWNrZXQgcmVjZXB0aW9uLg0KPiBXZSB3YW50IHRvIHdha2V1cCBfb25seV8gb24g
bWFnaWMgcGFja2V0IHJlY2VwdGlvbi4NCj4NCj4+IElmIHRoZSBmb3JtZXIsIHRoZW4geW91IHdv
dWxkIG5lZWQgdG8gaW50ZXJyb2dhdGUgdGhlIFBIWSBkcml2ZXIgdmlhDQo+PiBwaHlfZXRodG9v
bF9nZXRfd29sKCkgdG8gZmlndXJlIG91dCB3aGF0IFdha2Utb24tTEFOIG1vZGVzIGl0IGlzIGNh
cGFibGUNCj4+IG9mIHN1cHBvcnRpbmcgYW5kIHRoZW4gbWFrZSBhIGRlY2lzaW9uIHdoZXRoZXIg
dG8gcHJpb3JpdGl6ZSBXYWtlLW9uLUxBTg0KPj4gZnJvbSB0aGUgUEhZIG9yIHRoZSBNQUMsIG9y
IG1heWJlIG9ubHkgdGhlIFBIWSBjYW4gYWN0dWFsbHkgd2FrZS11cCB0aGUNCj4+IHN5c3RlbSBp
biB5b3VyIGNhc2UuDQo+Pg0KPiBzdG1tYWMgYWxyZWFkeSBjYWxscyBwaHlfZXRodG9vbF9nZXRf
d29sL3BoeV9ldGh0b29sX3NldF93b2wgdGhyb3VnaA0KPiBwaHlsaW5rX2V0aHRvb2xfZ2V0X3dv
bC9waHlsaW5rX2V0aHRvb2xfc2V0X3dvbC4gQnV0IG5lZWRzIGZsYWcNCj4gU1RNTUFDX0ZMQUdf
VVNFX1BIWV9XT0wgdG8gYmUgc2V0LiBPdGhlcndpc2UsIGl0IHdpbGwgb25seSB3b3JrIHdpdGgg
TUFDDQo+IFdPTCB3aGljaCB3ZSBkb24ndCB3YW50LiBXaXRoIHRoZSBuZXcgYmluZGluZyB3ZSBq
dXN0IGFsbG93IHRoZSBNQUMNCj4gZHJpdmVyIHRvIGNhbGwgdGhlIFBIWSBmb3IgdGhlIFdPTCBj
YXBhYmlsaXR5LiBUaGlzIGRvZXNuJ3QgZm9yY2UgV09MIHRvDQo+IGVuYWJsZWQgb3IgZGlzYWJs
ZWQsIGFzIGl0IGlzIHN0aWxsIHVwIHRvIGV0aHRvb2wgdG8gY29uZmlndXJlIGl0Lg0KPj4gSWYg
dGhlIGxhdHRlciwgdGhlbiB5b3UgbmVlZCB0byBhZGQgc3VwcG9ydCBmb3IgV0FLRV9QSFkgdG8g
dGhlIHN0bW1hYw0KPj4gZHJpdmVyLg0KPiBObywgd2UgZG9uJ3Qgd2FudCBXQUtFX1BIWSwgd2Ug
d2FudCBXQUtFX01BR0lDL1dBS0VfTUFHSUNTRUNVUkUgd2hpY2gNCj4gc3RtbWFjIGRyaXZlciBh
bHJlYWR5IHN1cHBvcnRzLg0KQWN0dWFsbHksIHN0dG1hYyBkb2Vzbid0IHN1cHBvcnQgV0FLRV9N
QUdJQ1NFQ1VSRSBidXQgd2UgZG9uJ3QgcmVhbGx5IA0KY2FyZSBhcyBQSFkgZHJpdmVyIHN1cHBv
cnRzIGl0Lg0KPj4gcHctYm90OiBjcg0KPj4gLS0gDQo+PiBGbG9yaWFuDQo+Pg0KDQo=

