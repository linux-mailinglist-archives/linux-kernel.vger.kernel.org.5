Return-Path: <linux-kernel+bounces-158213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 236CA8B1D0B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 10:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71551F23B80
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8CD7FBC6;
	Thu, 25 Apr 2024 08:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="RrRAMsDQ"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2085.outbound.protection.outlook.com [40.107.7.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EB97764E;
	Thu, 25 Apr 2024 08:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714034984; cv=fail; b=Jnx06+8uijF80wHIGxqz83Kljcg2ZpwzY6ox9NR55gqQXLyClHfjHeCdRAMZILY749j1VNEAsjZqgPzqLMQxvRDb2K2Q+K+MXlRc9FH8hFbqTZvkm/y6nv8JN86PFw80jDXJAZb6wgpR2Q0UNH26tT/kaUvJXbwXYUpeyDSDAQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714034984; c=relaxed/simple;
	bh=G3LGzws/H/gyEbfT2rHe77sP8u7Rilg8iQBNP+ttzLw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=doUpczoi0vONPcIqQ8Li2V2D0oUeuPoHEbx1U0xopxBfUUuyK9kV74kl8jZl6Bg5M5K2qOiHCn0ah6QIEP+B0MNvicaeyJBrWTgLn9npYRrco2iOBiIqXmlmLvPcHtTBgw36vFWnUnoV4tdj5vUvayW08DrzeZX1h2+ip1sjdps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=RrRAMsDQ; arc=fail smtp.client-ip=40.107.7.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIeGnOadZ4gsQCMdGQfkA7t9F3d8HC13Gx4W5pu4nA/PexKaq11oHhdb50Ag+UVBJlFxgqLdnlklTloXJPBXKovENVWmXwIXqfNkj/8wGMxr2Zz4O7yoOVI6JfzVNpHGCLUcqq9+raK14eWYTdm/WEyPMcJX+quP1fXVMpvGN0BhZvPXaPWVQc8dzcSWeWvDvl9g8vFXKNJHZhliHfk5RZHRYFRCzzeMp6I0bSNEGV4geKxoT/s0ubQo6RAnHicfemu1JzDTUNyret/SYFzdf5xLn0Td6wGt8U+tF0dtwGKVU1nYCw7vxmBO3dSSNfCksouC+3CnwKX6ALljwO/2IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G3LGzws/H/gyEbfT2rHe77sP8u7Rilg8iQBNP+ttzLw=;
 b=fZkpsPjZwmnxDacd/dcbrgWQ9UUy6cwPRwynimp0/ZxMFrdQRymE9vSKEJWKs0+LdCf46eiYleBmwLAAvL2bBygJ0Pme0o10uuJV91jDdQ1yDbct4C29+LjiaGoBTpHcsdCYvqm9zlnyTdkch7DuFdHhas7bFSbun5URw3A3oT+mt5Fn/gLpZvhprvgTHrUO4wcJxQ5CLOY75/DrZJqvOrCYCb9MVg9eIEo1KxiNdX8VjX477+LzezAH4/RNn1DJQ/I3HVnfDMfzD8FQr8H6FV8czao/ProI9WvOam9HFD1NrEXun7QAhrLnj4iQfausmLg0ZtzqTsWTxYr2l43o6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G3LGzws/H/gyEbfT2rHe77sP8u7Rilg8iQBNP+ttzLw=;
 b=RrRAMsDQH9qlRSzcutMRhgai8eq1i7+CgX0iOUAB+5QiWQuKAgbPvMyR6s0EptcE2v6khZWqReA/hScT5AG32LqMLQELjnWggues/G9HSP6om5g9AAKudD8oQTaDrpn7AamtK2amxVMj2aOryPX2FmoXrpxmfsmL0Rx4t/MB1bw=
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by AM9PR04MB8633.eurprd04.prod.outlook.com (2603:10a6:20b:43c::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Thu, 25 Apr
 2024 08:49:39 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::4fa3:7420:14ed:5334%6]) with mapi id 15.20.7519.021; Thu, 25 Apr 2024
 08:49:39 +0000
From: Bough Chen <haibo.chen@nxp.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: "brgl@bgdev.pl" <brgl@bgdev.pl>, "linux-gpio@vger.kernel.org"
	<linux-gpio@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH] gpio: vf610: always set GPIO to input mode when used as
 interrupt source
Thread-Topic: [PATCH] gpio: vf610: always set GPIO to input mode when used as
 interrupt source
Thread-Index: AQHalSX3LJYhygbqkUe2wC+6G48jP7F1u+eAgAAHv6CAAXxfYIABbibQ
Date: Thu, 25 Apr 2024 08:49:39 +0000
Message-ID:
 <DU0PR04MB9496B8F91EB56D222BDD8C2A90172@DU0PR04MB9496.eurprd04.prod.outlook.com>
References: <20240423022814.3951048-1-haibo.chen@nxp.com>
 <CACRpkdaRxoEZT1_KyJ3QMDgBcciw1XUXKr=cEiPxbcwSnpmyiA@mail.gmail.com>
 <AS1PR04MB9502BE89834E7F9DA3E8D70B90112@AS1PR04MB9502.eurprd04.prod.outlook.com>
 <DU0PR04MB949691D7F68E2F32371B604F90102@DU0PR04MB9496.eurprd04.prod.outlook.com>
In-Reply-To:
 <DU0PR04MB949691D7F68E2F32371B604F90102@DU0PR04MB9496.eurprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR04MB9496:EE_|AM9PR04MB8633:EE_
x-ms-office365-filtering-correlation-id: b7a93801-b97d-4944-e9ae-08dc6504a467
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|376005|1800799015|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?aFpGQnNwQzFudFg5eFo3eFhyOGxoZlZiSFNVWmQ2RG1OT2IxdUtYZ0lIZm9R?=
 =?utf-8?B?VzNIM2VwUkhHQzJmZ1o1T0FLQWlicm9UTmZNUGtselphWEdaR3hFSVErVWlY?=
 =?utf-8?B?ZzNwcXNVcEozTUhrc1l4VkNocE5UWG90QkNiZ1FBSnBURlBIR3lPdlVIcTJx?=
 =?utf-8?B?Q3hPMk5LREVwTzFxTmpycEhsR2ZPamhZSVhUUFFwLzN6Wk5jQW91R0pjWGl6?=
 =?utf-8?B?YS8yZnhOazhpeDBjWFhnTTB2ZEhmcGFjaEJlblptbnpxays3djRiS3pwYlNr?=
 =?utf-8?B?NThEK2ZXVXFIWmtoVUZPZjlkTUR3VzlGZDkyVU9Nc1dab0JUOTVZcm1UWDQ4?=
 =?utf-8?B?cTV0bzRUNzU0WEUzZUduVjd2NHgySno5eGgxQjFKMXV6cERDWXdOUFZkU3h4?=
 =?utf-8?B?VGx6Nk1ienVDejNpcUdYU3NGQ0ovTmpXY3B6d25OZ0taSGZmK1FtQXVmelFx?=
 =?utf-8?B?Yk54ZUhpOUNQdmY5NmNCbElnUHV2dXA5TnJkYmNSbkxOQ3ZMblB3SzBROTR3?=
 =?utf-8?B?ZERkYldwai92d3JQazNwWDBwVUdHZ3pJb2dRclpuZFVHam4veERCcXdtaUxG?=
 =?utf-8?B?ZG5pODlSM21iMGoyRUFMY1RSY2FBZE1MaGVmeldKSFU1ZDMxZmp2NTc4eHNB?=
 =?utf-8?B?d2poNHdsNmJrQ1lBdFFuWW4rNXM1RWJ1Z1cvbm1HeHFKUFhPdURodDQ2K1E2?=
 =?utf-8?B?bis0bFhoWnNWK2s4NEkrZ0JkZnhYVHJ2SjM5dFNXL09kZVFlVjdIV1lNN3B1?=
 =?utf-8?B?NmlPZjhBRjB2ZzlkclgwQjhMUzl0SDk1N1hZTDBJM1ZsTXg0ZGF1amIxK2xJ?=
 =?utf-8?B?UHplTlFPaUljNy84NVdmSVU4cDN6SFU3N0pIbWFrOXZtZHJlaHVycDNqb2Y1?=
 =?utf-8?B?QjBCdWhJTWR5eCtiQm9uRE9BbUYrMzdLL2FHaU9vNHB6U2xQeXJOQU9KczlR?=
 =?utf-8?B?TFU2Y2Y4MlE1K1NrcDhvR2xBYWdKcFlWb1d1Mjc4MDVEV0ZKMmhSMHFxQnJy?=
 =?utf-8?B?WUdPdisrNlZIZDh6Z0krajNCMUE3YlNkQjdseGVnN1JoU3pnUGJFR3RCMXNU?=
 =?utf-8?B?bEp3Q01FeHZsd05nYU9Sd3RiV0FRWnNkWnNMam5TcWNmd3FzbkdzRXpHajFW?=
 =?utf-8?B?d1d2YytESTJsaWxrYVZoRHdpQmxVemUwWUVibTNkeTRJakM2TUZQVTNJSkIw?=
 =?utf-8?B?RExmcnZCTWFVamhnREtDNFJEbEZVNThZNVp4YkR3Zk9tMlkzYTZ4SDF0bmtz?=
 =?utf-8?B?V1BzNEJ0UzFkcjdrdmNIb1NjYlk5WGhRVkJKQzVLTTE1YjFIeXM1WEtITDlW?=
 =?utf-8?B?eFhSbjNacEl6aEl5K2VOa0R1a3BFZndTcFVYTjRHVkJKMFVuYncxOFhwUm9L?=
 =?utf-8?B?b00zc0w4UlVvazE3aVdOcFNPZjdXSEZqb2xudnZtVFVvR0Z2RFpIK1FnbGpz?=
 =?utf-8?B?YndhSzFSZHQ2cFJZc1k0Zml4dzRaeGlsWHdUdEdNOEd5YXIxNElNSTNENFdS?=
 =?utf-8?B?aXFqSjhKYzZlRVY1K1E2TFRrV0pqNnk4TUI3VWg3Y1ppR05RK3RmNTQzT2VX?=
 =?utf-8?B?SlZsYzFiOFV5ZTJ2MzdzRiszclp5M1d1RUtzYitQMlZWb2hKRUoyUGVaOXFS?=
 =?utf-8?B?VTREcU5YblBuNFpzSnNNTkZuSkxlWnVlb1RBRTFnN01GaW9ZUVRtaVdGTE9q?=
 =?utf-8?B?K0wvMTM2NjZieHRuNDdScGVxUzhnMkZOTGRpR3FYSzY3MHVRVllFZk42T0tv?=
 =?utf-8?B?eDM5ZnEzYnJVS05rbkw0cCs4bHFQdTFkSWtSS0R0RUs2b2tjVkNzd1N2Slhn?=
 =?utf-8?B?dTZ6TEp1dm9oSFdTNUJ1Zz09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bU5LeUJoQVFweldZT3BkeXg3WHBLaUVVc2h3MnYxM2x1YU9mdVJSOEc5cmts?=
 =?utf-8?B?MVErcTBJODJRZHZsZEdvQkVDN2ZnOGNQTkJ1ZWlhV3NKV2hpUE9NbTRTZk4z?=
 =?utf-8?B?MVBHbEpOeE5CblJHTUhIRFk0WE5uN1pBSnVuUk5WR2dHNUtqak0wc29VWnAx?=
 =?utf-8?B?TkJZTzlLR2NhTG5HaURwcGY0U0lGOThJbUxZYkxLTUVzc205TXJkWGNyOEU0?=
 =?utf-8?B?M200aDZQVDhTMGZNcVoyVDFDS3hNR05QUHczV3hoMmR0UGg3Q1VVbjVkbnpH?=
 =?utf-8?B?T2p2TG9NeFk4MnBlZUQ2SVMyaHB1N1RPUUpIemJhUktCK2NEOHZEVXlNVVRs?=
 =?utf-8?B?cngzMnlMcnFEWUZmN2pIeng1azdmcGF1ekVxbWt1V3JvdjliV05mOTJHVFE5?=
 =?utf-8?B?bnl2WHVSSVAyRmF1ZGpBemI5RCtnQ1VXOG8rT1Q0U0M3VDh3WmZHRkNGM1hj?=
 =?utf-8?B?SWxjQUd5V3VlV3V2L3c2N2tZYVNqTWJyRmNzd09QT2JML3k1SjR0ZHh4d2NY?=
 =?utf-8?B?K0tWdXo1azdXRXNvSmZRVzAvZFoyODhxRmRtSmdBYy9sYTVlelpuM1dLWE5R?=
 =?utf-8?B?M3RlcCtHcE5ZYm1Gam9IVHg4a0pndzZsK3I4WVFkOUZxYVJsWlNsUHF2Qk5B?=
 =?utf-8?B?amNqNUthYWk4NTdZeWl6ODFVZTlTVUNPaEM0SkMrbkx0ek9ydktGN25FMEpV?=
 =?utf-8?B?ZngwOXlRZjdyQlh0VmFvTlRLSUlteEw5S1U4c0N4b3dTWEtmb3BIVHREYnJZ?=
 =?utf-8?B?dEJITHR4SFZQOUs3YTR2ZXEwZ1Q5czZGOTJNempWMjJoSlgraWh2Vm5uRmpN?=
 =?utf-8?B?ay9ZMGJYMUFtemFFM2hNdmF3bXU5TFJFaUprMmw5OHdaWSs3OVhDV2cyRTZY?=
 =?utf-8?B?djNSMWg0SjZGZjY0ZGFna3lSWldQaUxTNzRVbzliMjVGbzUvNDZUN3VSNHpx?=
 =?utf-8?B?VWdSS0p2bVV1YWV0NzNuWG0wei9zN3BxUVA3RHlVTkYzK05KakU1Y1RIb3du?=
 =?utf-8?B?UVBMKzZoMTdFbTc3OUljRzlVdElraUwvRWRUa1FKejlkRndoaTZwdXFaUk9l?=
 =?utf-8?B?bVVoc09KYTRBN0F6NVUySXdoRkpUVzEwejAxdXdHM0ZEL214cm5rVHM4WWVJ?=
 =?utf-8?B?OVdOSXhRQnplSm5Vbld0cWNxNXpaUDlxMjBHODBMU0ZDcjVIZUhBWCtvdHg3?=
 =?utf-8?B?c3lWL0o2L3c3V1B1T0dDMC91ek8ySmY2ZUFGY1JqemxYc2hvOHdlVXpOZ0E1?=
 =?utf-8?B?bDloeTJjaFRzdEU0b0w2V1FaWk9Qb2ppRWVVSnZsUXQ1QlFCVnQ4T0NPRFQx?=
 =?utf-8?B?bnQrTkVUMnVTdU41SE81NGN5YnVETGpnaEZnelp6YlFKdU82bjljdml4SXBU?=
 =?utf-8?B?N3FIMDIrNEZET0JnYS9UMFNDWHJNQi9JeUF1K1NYMjNCT29kK2c4eTFqVlNt?=
 =?utf-8?B?Zk83QkVvaDB6VlNSNFlJTktpbVExc0h1TDV3MUVhbUpTTkYzLzdKa0ErbEdx?=
 =?utf-8?B?M2gxZW53eGYvMitBUUtuN0IyTXVDeDArQVhSOGJxMVIwMjJTVjFQcHdKR1RF?=
 =?utf-8?B?YVU4L0xLeTN2UEpTVkY1K3NYNnM2UktQTngwdXVEdFRtTzl6dlorb0Z5dXVs?=
 =?utf-8?B?azFGVlRYNG0vakFENkwrYmlIcFZOeCtjNkpNNHRSbjhLaXF4bUtDZlJ2VHJL?=
 =?utf-8?B?VGgxV09pTWlqQUZvMW9lcnViK1hwTFBTVkY1QldSNnRCTkpjaUppS3VWZkFD?=
 =?utf-8?B?a0MzRzlWK1U0eGFRb2FuZTZqQ1k5eHlISTFmOTNjelpHUlJ4aFliVmVtUTFW?=
 =?utf-8?B?TGVaT0xJdEtxVHRZNDdWTmgvUVlaellzbG9GUUZ3bG1mbXJaTk9Rbmg0K2lE?=
 =?utf-8?B?eExzYm82NVUyQUE5L3lxYUNTWktGQlN5cUZXNHYwbFcxOEsyaEpNL09Nc001?=
 =?utf-8?B?ZGRrMk5XWFRtMlBxYU02WXIvZGtVNDZ4NTNXbEtxY1hJUlRjaXhjS2xzNGpr?=
 =?utf-8?B?WC9ZTDJZQkUzNi85MzhVSE5HUXVMVXV5WGFnOUYvZHNCdHVkNlZmcHA4S3Jz?=
 =?utf-8?B?ZmxkOFlkRS80c1JsTjBKd1ZCN29Hb29qRWhiTVVNUE1oc0F6c0ZiYWFOTjIy?=
 =?utf-8?Q?Cl+A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7a93801-b97d-4944-e9ae-08dc6504a467
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Apr 2024 08:49:39.2218
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AeNPvJ59qk2ElRaT85dMEKMTW0dJFyoRPkedNjjZ58SJrvgQ3NolTClz3yHXKq7K0wSIUZhDL6BRyd8qvxKF7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8633

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCb3VnaCBDaGVuDQo+IFNlbnQ6
IDIwMjTlubQ05pyIMjTml6UgMTk6MDENCj4gVG86ICdMaW51cyBXYWxsZWlqJyA8bGludXMud2Fs
bGVpakBsaW5hcm8ub3JnPg0KPiBDYzogJ2JyZ2xAYmdkZXYucGwnIDxicmdsQGJnZGV2LnBsPjsg
J2xpbnV4LWdwaW9Admdlci5rZXJuZWwub3JnJw0KPiA8bGludXgtZ3Bpb0B2Z2VyLmtlcm5lbC5v
cmc+OyAnbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZycNCj4gPGxpbnV4LWtlcm5lbEB2Z2Vy
Lmtlcm5lbC5vcmc+OyAnaW14QGxpc3RzLmxpbnV4LmRldicgPGlteEBsaXN0cy5saW51eC5kZXY+
DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIGdwaW86IHZmNjEwOiBhbHdheXMgc2V0IEdQSU8gdG8g
aW5wdXQgbW9kZSB3aGVuIHVzZWQgYXMNCj4gaW50ZXJydXB0IHNvdXJjZQ0KPiANCj4gPiAtLS0t
LU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+IEZyb206IEJvdWdoIENoZW4NCj4gPiBTZW50OiAy
MDI05bm0NOaciDIz5pelIDIwOjIxDQo+ID4gVG86IExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxl
aWpAbGluYXJvLm9yZz4NCj4gPiBDYzogYnJnbEBiZ2Rldi5wbDsgbGludXgtZ3Bpb0B2Z2VyLmtl
cm5lbC5vcmc7DQo+ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgaW14QGxpc3RzLmxp
bnV4LmRldg0KPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIGdwaW86IHZmNjEwOiBhbHdheXMgc2V0
IEdQSU8gdG8gaW5wdXQgbW9kZSB3aGVuDQo+ID4gdXNlZCBhcyBpbnRlcnJ1cHQgc291cmNlDQo+
ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBMaW51cyBX
YWxsZWlqIDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+DQo+ID4gPiBTZW50OiAyMDI05bm0NOac
iDIz5pelIDE5OjQxDQo+ID4gPiBUbzogQm91Z2ggQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0K
PiA+ID4gQ2M6IGJyZ2xAYmdkZXYucGw7IGxpbnV4LWdwaW9Admdlci5rZXJuZWwub3JnOw0KPiA+
ID4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgaW14QGxpc3RzLmxpbnV4LmRldg0KPiA+
ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gZ3BpbzogdmY2MTA6IGFsd2F5cyBzZXQgR1BJTyB0byBp
bnB1dCBtb2RlIHdoZW4NCj4gPiA+IHVzZWQgYXMgaW50ZXJydXB0IHNvdXJjZQ0KPiA+ID4NCj4g
PiA+IE9uIFR1ZSwgQXByIDIzLCAyMDI0IGF0IDQ6MjjigK9BTSA8aGFpYm8uY2hlbkBueHAuY29t
PiB3cm90ZToNCj4gPiA+DQo+ID4gPiA+IEZyb206IEhhaWJvIENoZW4gPGhhaWJvLmNoZW5Abnhw
LmNvbT4NCj4gPiA+ID4NCj4gPiA+ID4gVGhvdWdoIHRoZSBkZWZhdWx0IHBpbiBjb25maWd1cmF0
aW9uIGlzIElOUFVULCBidXQgaWYgdGhlIHByaW9yDQo+ID4gPiA+IHN0YWdlIGRvZXMgY29uZmln
dXJlIHRoZSBwaW5zIGFzIE9VVFBVVCwgdGhlbiBMaW51eCB3aWxsIG5vdA0KPiA+ID4gPiByZWNv
bmZpZ3VyZSB0aGUgcGluIGFzIElOUFVULg0KPiA+ID4gPg0KPiA+ID4gPiBlLmcuIFdoZW4gdXNl
IG9uZSBwaW4gYXMgaW50ZXJydXB0IHNvdXJjZSwgYW5kIHNldCBhcyBsb3cgbGV2ZWwNCj4gPiA+
ID4gdHJpZ2dlciwgaWYgcHJpb3Igc3RhZ2UgYWxyZWFkeSBzZXQgdGhpcyBwaW4gYXMgT1VUUFVU
IGxvdywgdGhlbg0KPiA+ID4gPiB3aWxsIG1lZXQgaW50ZXJydXB0IHN0b3JtLg0KPiA+ID4gPg0K
PiA+ID4gPiBTbyBhbHdheXMgc2V0IEdQSU8gdG8gaW5wdXQgbW9kZSB3aGVuIHVzZWQgYXMgaW50
ZXJydXB0IHNvdXJjZSB0bw0KPiA+ID4gPiBmaXggYWJvdmUgY2FzZS4NCj4gPiA+ID4NCj4gPiA+
ID4gU2lnbmVkLW9mZi1ieTogSGFpYm8gQ2hlbiA8aGFpYm8uY2hlbkBueHAuY29tPg0KPiA+ID4g
PiAtLS0NCj4gPiA+ID4gIGRyaXZlcnMvZ3Bpby9ncGlvLXZmNjEwLmMgfCAyICstDQo+ID4gPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+ID4N
Cj4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3Bpby9ncGlvLXZmNjEwLmMgYi9kcml2ZXJz
L2dwaW8vZ3Bpby12ZjYxMC5jDQo+ID4gPiA+IGluZGV4IDA3ZTVlNjMyM2U4Ni4uMzA1YjBiY2Rl
ZTZmIDEwMDY0NA0KPiA+ID4gPiAtLS0gYS9kcml2ZXJzL2dwaW8vZ3Bpby12ZjYxMC5jDQo+ID4g
PiA+ICsrKyBiL2RyaXZlcnMvZ3Bpby9ncGlvLXZmNjEwLmMNCj4gPiA+ID4gQEAgLTIxNCw3ICsy
MTQsNyBAQCBzdGF0aWMgaW50IHZmNjEwX2dwaW9faXJxX3NldF90eXBlKHN0cnVjdA0KPiA+ID4g
PiBpcnFfZGF0YSAqZCwNCj4gPiA+IHUzMiB0eXBlKQ0KPiA+ID4gPiAgICAgICAgIGVsc2UNCj4g
PiA+ID4gICAgICAgICAgICAgICAgIGlycV9zZXRfaGFuZGxlcl9sb2NrZWQoZCwgaGFuZGxlX2Vk
Z2VfaXJxKTsNCj4gPiA+ID4NCj4gPiA+ID4gLSAgICAgICByZXR1cm4gMDsNCj4gPiA+ID4gKyAg
ICAgICByZXR1cm4gcG9ydC0+Z2MuZGlyZWN0aW9uX2lucHV0KCZwb3J0LT5nYywgZC0+aHdpcnEp
Ow0KPiA+ID4NCj4gPiA+IEp1c3QgY2FsbCB2ZjYxMF9ncGlvX2RpcmVjdGlvbl9pbnB1dCgpIGlu
c3RlYWQgb2YgaW5kaXJlY3RpbmcNCj4gPiA+IHRocm91Z2gNCj4gPiA+IGdjLT5kaXJlY3Rpb25f
aW5wdXQoKSwgbm8gbmVlZCB0byBqdW1wIHRocm91Z2ggdGhlIHZ0YWJsZSBhbmQgYXMNCj4gPiA+
IEJhcnRvc3ogc2F5czogaXQganVzdCBtYWtlcyB0aGF0IHN0cnVjdCB2dWxuZXJhYmxlLg0KPiA+
DQo+ID4gVGhhbmtzIGZvciB5b3VyIHF1aWNrIHJldmlldywgSSB3aWxsIGRvIHRoYXQgaW4gVjIu
DQo+ID4NCj4gPiA+DQo+ID4gPiBTZWNvbmQ6DQo+ID4gPg0KPiA+ID4gSW4gdGhpcyBwYXRjaCBh
bHNvIGltcGxlbWVudCBnYy0+Z2V0X2RpcmVjdGlvbigpIHdoaWNoIGlzIGN1cnJlbnRseQ0KPiA+
ID4gdW5pbXBsZW1lbnRlZC4gSWYgeW91IGFyZSBnb2luZyB0byBjaGFuZ2UgdGhlIGRpcmVjdGlv
biBvZiBhIEdQSU8NCj4gPiA+IHJhbmRvbWx5IGF0IHJ1bnRpbWUgdGhlbiB0aGUgZnJhbWV3b3Jr
IHJlYWxseSBsaWtlcyB0byBoYXZlIGEgY2hhbmNlDQo+ID4gPiB0byBrbm93IHRoZSBjdXJyZW50
IGRpcmVjdGlvbiBmb3Igb2J2aW91cyByZWFzb25zLg0KPiA+DQo+ID4gWWVzLCB3aWxsIGltcGxl
bWVudCBnYy0+Z2V0X2RpcmVjdGlvbigpLCBpZiB3ZSBkaWQgdGhpcyBiZWZvcmUsIHRoZW4NCj4g
PiBmb3IgdGhpcyBjYXNlIHdlIG1lZXQsIGZyYW1ld29yayB3aWxsIHByaW50IG91dCBlcnJvciBs
b2csIHNhdmUgbXVjaCBkZWJ1Zw0KPiB0aW1lLg0KPiANCj4gSGkgTGludXMsDQo+IA0KPiBJIGlt
cGxlbWVudCBnYy0+Z2V0X2RpcmVjdGlvbigpIHRvZGF5LCBmb3IgdGhlIGNhc2UgdG8gcmVxdWVz
dCBvbmUgZ3BpbyBhcyBpcnEsDQo+IGdwaW8gYXJjaGl0ZWN0dXJlIHdpbGwgZmlyc3QgY2FsbCBn
cGlvY2hpcF9yZXFyZXNfaXJxKCksIGlmIHRoZSBST00gb3IgVWJvb3QNCj4gYWxyZWFkeSBjb25m
aWcgdGhpcyBncGlvIHBpbiBhcyBPVVRQVVQgbW9kZSwgd2lsbCBnZXQgdGhlIGZvbGxvd2luZyBs
b2c6DQo+IA0KPiBbICAgIDIuNzE0ODg5XSBncGlvIGdwaW9jaGlwMzogKDQzODUwMDAwLmdwaW8p
OiBncGlvY2hpcF9sb2NrX2FzX2lycTogdHJpZWQgdG8NCj4gZmxhZyBhIEdQSU8gc2V0IGFzIG91
dHB1dCBmb3IgSVJRDQo+IFsgICAgMi43MjQ4MTZdIGdwaW8gZ3Bpb2NoaXAzOiAoNDM4NTAwMDAu
Z3Bpbyk6IHVuYWJsZSB0byBsb2NrIEhXIElSUSAxMSBmb3INCj4gSVJRDQo+IFsgICAgMi43MzE5
NzJdIGdlbmlycTogRmFpbGVkIHRvIHJlcXVlc3QgcmVzb3VyY2VzIGZvciAyLTAwNTAgKGlycSAy
MTEpIG9uDQo+IGlycWNoaXAgZ3Bpby12ZjYxMA0KPiANCj4gQW55IHN1Z2dlc3RlZCBtZXRob2Qg
dG8gYXZvaWQgdGhpcyBjYXNlPyBNeSBwcmV2aW91cyBtZXRob2Qgd29ya3MgYmVjYXVzZQ0KPiBk
cml2ZXIgbGFjayBvZiBnYy0+Z2V0X2RpcmVjdGlvbigpLg0KDQpIaSBMaW51cywNCg0KSSBmaW5k
IGdwaW8taG9nIGNhbiB3b3JrIGFyb3VuZCB0aGlzIGNhc2UuDQoNCkkgYWRkIHRoZSBmb2xsb3dp
bmcgY2hhbmdlLCBjb25maWcgdGhpcyBncGlvIGFzIGlucHV0IGluIGdwaW8taG9nLCBzbyB0aGF0
IHdoZW4gdGhpcyBncGlvIGNvbnRyb2xsZXIgcHJvYmUsIGdwaW9saWIgd2lsbCBzZXR0aW5nIHRo
ZSBwaW4gdG8gaW5wdXQgbW9kZS4NCg0KKyZncGlvNSB7DQorICAgICAgIHB0bjUxMTAtaW50LWhv
ZyB7DQorICAgICAgICAgICAgICAgZ3Bpby1ob2c7DQorICAgICAgICAgICAgICAgZ3Bpb3MgPSA8
MTEgR1BJT19BQ1RJVkVfTE9XPjsNCisgICAgICAgICAgICAgICBpbnB1dDsNCiAgICAgICAgfTsN
Cg0KTm90IHN1cmUgd2hldGhlciB0aGlzIGlzIGFuIGFjY2VwdGFibGUgbWV0aG9kLiBJZiB5ZXMs
IHdoYXQgSSBuZWVkIHRvIGRvIGluIHRoZSBncGlvLXZmNjEwIGRyaXZlciBpcyB0byBpbXBsZW1l
bnQgZ2MtPmdldF9kaXJlY3Rpb24oKSBjYWxsIGJhY2suDQoNCkJlc3QgUmVnYXJkcw0KSGFpYm8g
Q2hlbg0KPiANCj4gQmVzdCBSZWdhcmRzDQo+IEhhaWJvIENoZW4NCj4gDQo+ID4NCj4gPiBCZXN0
IFJlZ2FyZHMNCj4gPiBIYWlibyBDaGVuDQo+ID4gPg0KPiA+ID4gWW91cnMsDQo+ID4gPiBMaW51
cyBXYWxsZWlqDQo=

