Return-Path: <linux-kernel+bounces-78098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DBB860EDD
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B299B24344
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 10:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8A15D47A;
	Fri, 23 Feb 2024 10:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b="H6aR7Nad"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2122.outbound.protection.outlook.com [40.107.255.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7735C914;
	Fri, 23 Feb 2024 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708682625; cv=fail; b=tA+Z/gL2LBo3ALplPg1Xx7zpO6lt6QwVpz9D3jRyJwREKoWu27crjHZBSIwnAdkjZZIf2zN21/jZLiK+xBRpqDnVB1QeekjQ46b6xrddx7+pYReyhe0XPHxaMCFBcmtgWQO7zJwJZdpgc+LXakIGoQEkQSjkysu9GM8bSzuydQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708682625; c=relaxed/simple;
	bh=AHhL3E+ZubRVXwpFA7iuk0/5nuGjWGnw9nlQKWKotrY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U8EDbI4dkQWWRwEJ6pEaygdBWbcWs6VC07N9Efk00ebFsGuHrI7+iaA1q4Ymlcw2WGPcUwKLT6j3gCLMxiKKT62ihW+Bu0XuoQTVNzmBihaF9e38SYqXnuJHCO/GrjhQBSGhE9deKk1RErfzFQykV5wZQHZANQRZCACIS/4R8h0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com; spf=pass smtp.mailfrom=qnap.com; dkim=pass (2048-bit key) header.d=qnap.com header.i=@qnap.com header.b=H6aR7Nad; arc=fail smtp.client-ip=40.107.255.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qnap.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qnap.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XI9d3JTBFefceKtjXonzpbJ68sCyEvId4QdebyYioTSCbulFOt5Us10ANA0pRikDMm+wXYXLsmzaskt5Go5+u3dalS4C+r9P/z5T3cTpNWzuWUFS/NNiguyGYaIH7Ifpr2UVw9BXaUnfzRpRGRvptY8/UkfJLsbmDM7GOi3QvbU1JyPwjkOjroaCPat+SeBy9Zs2KPq5DthQpL83jnwLpnxUkKGz336k9LMxUXWz2mDPL1XSeE2FsBbIt9etBsbvAeV03KqYxMbyOHtmFnqwt0OW3cFHEvs7xs3uRqI0NPvMdasIRYjYPwhtQmeiVXlvVjdBDpdNgPtT8S6awzI2gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHhL3E+ZubRVXwpFA7iuk0/5nuGjWGnw9nlQKWKotrY=;
 b=hWZztUzDCX5v8hXxTUXMUSB8EC6WonpwkaVA3cMzZVygA3p9Sm64WHbcCwrAuMCW2D/tZkkFU/8dlfN2rFDVxVaPmaGnuFDrGi2FJ/27zYTrFtHy+vaTAdkcQJFr0jDxPTZFzHv/w+ub/DI38cbrerSbpk1k5c1AV6v+fut3kriRxDTOkRs4j1MLZMQMiCfTHlD1YnTkYkNa6q5OKAHWrALSluZai3MZOmuzQMzu/+UthtCC3OzTqi+BT2ZSM6DagLINkLHlRf9VXpz+UMpqXt5kzO79vulJWkE3flTcV+VjRoKx5rjy8K4qPpk6ceASKCGi7UPInrbHREg7CTdMDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qnap.com; dmarc=pass action=none header.from=qnap.com;
 dkim=pass header.d=qnap.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHhL3E+ZubRVXwpFA7iuk0/5nuGjWGnw9nlQKWKotrY=;
 b=H6aR7NaddW0jpL7/dwAIIuiTB+6EZH5jHyIEnroUi3Fqbv/r4DKPPvlEAEzVHhWV7AXNqpXGgHd8ATWftsJctfcHCcF8bmxABTCgMpnPGYBkENVP1KUEbkpkmlp7I16nV7m7Y5jmitXcdYK+2R5LhKs7Q40Jh8u1po66aQei9mdhGplZzsjaY8UunyU7ISSsR12F53o20XeUL+/cb4m2olwC0cIuj537ffbO/nAhJkcfFXxapxKmrZ83CiFpibaakeGXvmcEiIY/McgfK+UamF69LBWWv/oIqxJm1s7La5FG+WdG6P1EKzaq+NQy65+xzAGI/l7u5zZapXAG3fUdrA==
Received: from SI2PR04MB5097.apcprd04.prod.outlook.com (2603:1096:4:14d::9) by
 PUZPR04MB6158.apcprd04.prod.outlook.com (2603:1096:301:e5::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7316.24; Fri, 23 Feb 2024 10:03:38 +0000
Received: from SI2PR04MB5097.apcprd04.prod.outlook.com
 ([fe80::2f40:e11f:9d69:5bf5]) by SI2PR04MB5097.apcprd04.prod.outlook.com
 ([fe80::2f40:e11f:9d69:5bf5%7]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 10:03:38 +0000
From: =?iso-2022-jp?B?Sm9uZXMgU3l1ZSAbJEJpLVhnPSEbKEI=?= <jonessyue@qnap.com>
To: Hangbin Liu <liuhangbin@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "j.vosburgh@gmail.com"
	<j.vosburgh@gmail.com>, "andy@greyhouse.net" <andy@greyhouse.net>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] bonding: 802.3ad replace MAC_ADDRESS_EQUAL
 with __agg_has_partner
Thread-Topic: [PATCH net-next v2] bonding: 802.3ad replace MAC_ADDRESS_EQUAL
 with __agg_has_partner
Thread-Index: AQHaZiyx1rb/3ipKNkyq6JoPCO9K5rEXrgY4
Date: Fri, 23 Feb 2024 10:03:38 +0000
Message-ID:
 <SI2PR04MB50979AE205E6027BA35B8599DC552@SI2PR04MB5097.apcprd04.prod.outlook.com>
References:
 <SI2PR04MB5097AA23EE6799B3E56C0762DC552@SI2PR04MB5097.apcprd04.prod.outlook.com>
 <ZdhNxWivTVixYRFK@Laptop-X1>
In-Reply-To: <ZdhNxWivTVixYRFK@Laptop-X1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qnap.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR04MB5097:EE_|PUZPR04MB6158:EE_
x-ms-office365-filtering-correlation-id: 4d13a183-835f-4286-785d-08dc3456b4e4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 mZQzeioOD9AGQJQVUp0p5OhXs5WK3aK6o5cFfpmDj9Loh3MOU0WO+VhnWyKSSUSXKfSHJNRCbtg1A5gsuom0mueuXPQ0nItqh2PxSDtjzTFqilaqzYcz+LY35smE6ACbDnTQfVoKm7GPMHqZPc0RP2aYc7p9UHN5R0Vb8BtA9V5M1fUx3reiL1vVo0XeeNxL4o5dRlDizrzSHqWIDZqHcK6acaejAWggLZ5x70cKJOxQmppzRyXGHMI72Ut6w1G6fhgJfkBe+tIRsDinYtA7aGJjRc7JRv2wI1OdrKR6mXP+ftolYMEYS36n7B/re2yqypJYE+3jwO8ASx/vF2KqTkvo+lBtWgIz+k1XTS9HWC0FUXsXFXhcuvVl9Bl1CoSwp5s5wcFmox+KpM94Q4XSGTxEtrBeGBVCs3EL/rEf49eDlBRZ0AdGvivJ/btShAfA8K55tfjFWXEMmTbO+C4vSFWJMK32ZP35EbM8vSlqLgzNfkQPbminDK2xjhNZneCXjSOGC6Kf+wo26go1lrBTM80Dqa4L23VEEL3YUY/xuLCPab0tNxipS1/ThIjeF0/RdBbsI8Z7kU4szzKNs4dK0ldVhNPxdBBiGx2UOj5+mXbmCKb+Vmf3lapMLHXXOE5N
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR04MB5097.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?dGN6amFpOTdwenhyV1ZEcER5clk4bURlSEQzcHhPMmlRVnFreWJOOUpa?=
 =?iso-2022-jp?B?N2Q5a0pRaTFPeElCcWZ4bERTSDNzYUQvRi85STIyUnFGalliZ2NFcEMw?=
 =?iso-2022-jp?B?amdOaVk4bjh0SWtpZnk3NmphUG0zVDJSV214ZDArd1FKVWcyU3JNTEpn?=
 =?iso-2022-jp?B?Wnh5Ty9nMG40Q3l3aTBxWXJMU0o1OTJha2NwQW1vUGlYZWk3cklHdkNr?=
 =?iso-2022-jp?B?ZHZvZWZKVkRHNzRFc0xSNFZHSVhtVFdhWjQxZWJYWlRhQlJEUjVsVjUw?=
 =?iso-2022-jp?B?dStxb25IMjFrN2Vtb0wwcG12Q25hUHpCT0M0RjV3QmVQc3Y1RW5VUDcx?=
 =?iso-2022-jp?B?ZXNzV3pJblhUaGdJQmRFT1dTdS9ObFBjbm9zdFFzTmx0OGxVV05XT2J0?=
 =?iso-2022-jp?B?ZFpoczI1Zk50RnlMd2xTak9xOFloR2NBcVA1azNXVFhYK3RJZ1VXckNt?=
 =?iso-2022-jp?B?TlJaWnZpd09qeU8vdkFVVzBScWxtaDRRSnQvOVgyNlUxK0Q5YVppMmZ4?=
 =?iso-2022-jp?B?NUp2M1FVYmZFaks3MzRJaHVIQjFBNVBFRWluT0U4Z2FBZm1UcXUxYVE4?=
 =?iso-2022-jp?B?SmxIZzd5UGdWdGlHbmZRM2I5bC9IT2U3Y0FHZTdqNmllNzI3R1FxbUxC?=
 =?iso-2022-jp?B?UVh2RzErREVYU2lRM3pDZVVxay9EMkozaEhUajdEMi9JRElyaWFiajJv?=
 =?iso-2022-jp?B?UkovcFFkZDhEaDhlOUhDMmhiTjg0RDZCZ2E3Zld0bmVzVzJubkYvVEo2?=
 =?iso-2022-jp?B?QjBpQUx2Sk92VDVhTW4zU2pmWTMzcTQwR1VYdmZ0NDlIZlE5T3pUbFMx?=
 =?iso-2022-jp?B?S0oxTHY3Mzd0NkNFcjlWRG1vOVBCM0IxR3VGYndsalZVeVI0OEZFTXdp?=
 =?iso-2022-jp?B?M0xyM2NzTUdrY0p5QnNpdVYyQlhBeENQdEJ6U1JwTG11MVB6czNmenV3?=
 =?iso-2022-jp?B?enFyMERyME9rdW5xbUZxOVVWZGRjTmNvUm1kcVZjMyt2SDcxZEoyM3Ba?=
 =?iso-2022-jp?B?a3U5UllBQTU3ZUNTaGRxVmhyM3BYNFNiVk1mYUl0OVZiYzVwT2Z5WFJ4?=
 =?iso-2022-jp?B?d1NTZTNnM09ROXdXSDVMY2VPbER2ckVhTkRtNDhjNGN1ZTl1SWNwdm5m?=
 =?iso-2022-jp?B?YWxIMFdCZVIrNmExckMwUVZCQm8xUEdSNlRoYWFyM0xRanZaN05nTWVN?=
 =?iso-2022-jp?B?RGw5ZEt2YzZGQTZ5bi9oNytuekw2MXdFT0kwcmZPdWtRZm41bThXZ0NK?=
 =?iso-2022-jp?B?QXpaZjZuOFFDd2NLSndjUnJkd29QbXdlZGxVL203R085N0dyd0kwODcw?=
 =?iso-2022-jp?B?UnJNajJ6UnluOGd1Q0xkZFYydFFxUDZVSFovaG56azRic2hQcGxHcUpR?=
 =?iso-2022-jp?B?cEIybmxsdHpPaW1DcVZETlQ2TWpUR0tybFY2dWR2TXk2V1o5MTZGdE9R?=
 =?iso-2022-jp?B?OGRiTmdnSHpXQUowVXVSNmh1Ym90RFRVaDVZRjIzc3p4a0ladTgrRk9a?=
 =?iso-2022-jp?B?cVpYT21mTjZab1NHNUo3RFBCZnNaSUVNeGJIelMyd1FUZ1hxZ3NsVkxJ?=
 =?iso-2022-jp?B?d1NvTC8zTGhGNWszVVR2andzazU3d1MwYngxUXVZUXVqbnRwSzNxNFdv?=
 =?iso-2022-jp?B?NlcrM0JrSUs3YUtPaHZMQUs4MnR4MzQxZUpETU9IOGhVQm1TNFJidWNY?=
 =?iso-2022-jp?B?UVdCQW9GU0pOa2Foc3Nzc3orUTNwaWMyVG5KYUd2aHdlRVl1OFBScklx?=
 =?iso-2022-jp?B?UWhsWnlFdkh4S3kxUng0b1Q2Y2RaV0VZd3JPWFNVckc2VVd6YUhhR3pk?=
 =?iso-2022-jp?B?VVJNU21OMVZCb0xwQ1JWVEVuU3JZek9VeGpzVDU3Q3o5VTNCU1Jsc1BO?=
 =?iso-2022-jp?B?RTVMbkpwRkZ1TERQcGN5M2t1RnYzZ2g5Um4vVVVpMy9WcWtXQmN3L1Rl?=
 =?iso-2022-jp?B?TXg3NTZ1Kzl0cE90ck9ycUdEK3MxZnVIZ3lyK3lPN0h0T0FIcXhvU3dv?=
 =?iso-2022-jp?B?aXo4dUJTdzB3ZUxiUVJOVkNmdHRUbGZ4YXY4aGl2SE1RVDFqL09QSXIw?=
 =?iso-2022-jp?B?U0cxK3krTnhkNFR0V3EzZ0g0bGI0cndTdVE3ZGN3Wk0xTHVTdDE0aE1n?=
 =?iso-2022-jp?B?TmtmbDI1MEZMOFZ4alF5ekFZZy9WT29PdS9xaDFJQnNUbXFudTVScEZI?=
 =?iso-2022-jp?B?b1RXMDMwUEdOQWhYOFI5Ukl4VEFtcU80Y09pSVlUMEpmb3ZJcXlCVWV1?=
 =?iso-2022-jp?B?WnRQaTQxUFA3eS9ONWxrNUZqczR3QnVYUT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: qnap.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR04MB5097.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d13a183-835f-4286-785d-08dc3456b4e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 10:03:38.6345
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6eba8807-6ef0-4e31-890c-a6ecfbb98568
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ydWGzHIsCjDuOb7Trd6yc6Yqa2gUXgPZ2RlmSIQCrULw1bTK02APJqAw1aQ0/eS+31OnZU9/2DHp12XWXCllOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR04MB6158

Hello Hangbin,=0A=
=0A=
> MAC_ADDRESS_EQUAL and __agg_has_partner are not the same thing.=0A=
> =0A=
> MAC_ADDRESS_EQUAL() is only same with __agg_has_partner() when verifying=
=0A=
> agg partner mac addr with null_mac_addr. The description could be more=0A=
> accurate.=0A=
=0A=
Thank you for kindly reply! Yes you are right my description is not clear.=
=0A=
=0A=
> Since you want to replace the null_mac_addr checking for MAC_ADDRESS_EQUA=
L().=0A=
> Maybe we can also replace the null_mac_addr checking in=0A=
> ad_port_selection_logic(). This should be safe as the=0A=
> aggregator->partner_system and port->partner_oper.system has been compare=
d.=0A=
> e.g.=0A=
> ...=0A=
> With this the null_mac_addr definition could be removed.=0A=
=0A=
This new one looks better! Will come out a v3 and test it :)=0A=
=0A=
--=0A=
=0A=
Regards,=0A=
Jones Syue | =1B$Bi-Xg=3D!=1B(B=0A=
QNAP Systems, Inc.=

