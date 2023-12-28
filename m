Return-Path: <linux-kernel+bounces-12632-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0E2381F803
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 13:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97BA8284FA6
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 12:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0764B7475;
	Thu, 28 Dec 2023 12:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="nJx0smHF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01olkn2107.outbound.protection.outlook.com [40.92.66.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2F06FD6;
	Thu, 28 Dec 2023 12:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifAhGxu4VYVMH31FXxT4U1M8kIr4967wcSGtvj0x1CfOIr6RmSMk7tx4EN/gX/9mrmdXXj/ZLj32M2cUOhx2gKKxa618NVm6i8r09UHLg+Jy4aksQjaPy2ohPClIShCJ1bZQRLcnhnZxudnYxbN+9qHhweCBbgx0ayg+BZBADs4mEmJ178oaQu/5i1gIGZvJNgr3/SxC682SWPo/0wU6mYFgGZLDxKagvQVHhAamSkvC/hioC226HX/EGH1NYZdIFQS/EORrDQq5QCmbC8iJYFbcNucEJ94BP9q9GIgPZ7G8PQyWVtJNSwOhNsIuxPgdLO+VWX7TH+gLa+9sUJOMOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tQoKt9CoIBfbklrWmpRJC3fivC82Dm9M/D6YlDRoPiY=;
 b=JdRfBtV4nhTICAqG5RT1IxWmDWtTarB3m8pZqHwL6tAAeyPCBSfyHK3f2Sbwyt9Foqn0VQJ8KjNGlnP2SURgyt+tnVTVi8/hI/yafUs4T6lJaFjp6lQ1SZgyn9sPupB9b7m/Iu8WJsJ0yyhXlpPtPYDKFgK+k0gRZQAD59pXpK4dejWMf4GV/taWj97J4Kca1XLzGy1vwgDRUqgCo+Je6OJKH7b9/f5JmBu8mHthLLx/SQmICFMltZX1iOafTU+/IvUw53M1n2mDBuvmNzES5RBbKnJ0hih8wA53MZpuRBUoo7UiB71A0X2DoJlwiPQBKIkTsYUERFjno/ZRD/RKkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tQoKt9CoIBfbklrWmpRJC3fivC82Dm9M/D6YlDRoPiY=;
 b=nJx0smHFr5bpDwrAmCMpGe3tfOBMH+9+OK8ufAE6UKIkC2cjjAAnSJWzy/XmuYQa58t/8HU9avRjlMcDuXvZxgis4MqP0v4gjZkSyOLQCMAftIjZuftL0AU6ktxT9+0PrMh+nyenh2I4H0LjmzcOtgpxLGLVYfOCUJn/IFwjbfAsk5sRyg5yeo/xPzVwAVfAT9zLo4n4TVZPKRqPXaDFsPS5diutNk2pOIu8alIJi0RriomCWQr7IlQBB9Rgy8w4v/oOkXWMcwZ6IS0bWWWv5Sa0lMaUZkecJxNccfmyY6ienfTEZoch1TuT5ibHLqWbC4w5GlbzFPsJof/zgf0F2w==
Received: from AS8PR02MB10217.eurprd02.prod.outlook.com
 (2603:10a6:20b:63e::17) by AS2PR02MB8949.eurprd02.prod.outlook.com
 (2603:10a6:20b:5e5::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.28; Thu, 28 Dec
 2023 12:03:21 +0000
Received: from AS8PR02MB10217.eurprd02.prod.outlook.com
 ([fe80::2b9c:230f:3297:57e8]) by AS8PR02MB10217.eurprd02.prod.outlook.com
 ([fe80::2b9c:230f:3297:57e8%7]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 12:03:21 +0000
From: David Binderman <dcb314@hotmail.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>, "sfrench@samba.org"
	<sfrench@samba.org>, "pc@manguebit.com" <pc@manguebit.com>,
	"lsahlber@redhat.com" <lsahlber@redhat.com>, "sprasad@microsoft.com"
	<sprasad@microsoft.com>, "tom@talpey.com" <tom@talpey.com>,
	"linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
	"samba-technical@lists.samba.org" <samba-technical@lists.samba.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject:
 =?Windows-1252?Q?Re:_fs/smb/client/sess.c:462:20:_warning:_duplicated_=91?=
 =?Windows-1252?Q?if=92_condition?=
Thread-Topic:
 =?Windows-1252?Q?fs/smb/client/sess.c:462:20:_warning:_duplicated_=91if?=
 =?Windows-1252?Q?=92_condition?=
Thread-Index: AQHaOYFrCCXlZ38mvkmOuPmXNZXsLbC+lZgAgAABi2Q=
Date: Thu, 28 Dec 2023 12:03:21 +0000
Message-ID:
 <AS8PR02MB102175EE04EAB5CAB6E459BEF9C9EA@AS8PR02MB10217.eurprd02.prod.outlook.com>
References:
 <AS8PR02MB1021708E77D868F8AE5EFD8859C9EA@AS8PR02MB10217.eurprd02.prod.outlook.com>
 <ZY1hcE5E3Mizv2il@archie.me>
In-Reply-To: <ZY1hcE5E3Mizv2il@archie.me>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [uvvdClGaHx6ZPGH8LMT02Eoj+lqj97YJ]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR02MB10217:EE_|AS2PR02MB8949:EE_
x-ms-office365-filtering-correlation-id: e0a1ba68-ce17-4a5d-592f-08dc079cfcc5
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +pXoZjTy+8MLtVuOohnUuAG/d+BY4yJ2zReslutUjipyXD1XfSKHtSOtP2qNh1QLXkzOtknkjK3KEEu3w1WLc/ikmbOVx5DzZ+zeDj7m9sCQTBwAMJKf5q0Ynd4QDLH3p5HcvI+HglK5aHRC7qFPT907UlL0cZPcSu/iFowrw/8lpiDPP0fWEHOpAMgMHhOoqKQhgmhoPtqGGueVk7A/TRBm+kInmk7VFl5Bnze6WZveXyCKSteq+qice4htnf2hGKtDQHVxIqiWSpV0VKZv7FJPewlVYrMxdZs/EZtDgWArwbvaq/XNhw0lVAmSviRo39YI0u6+72Sqr5Lqyfegcy5eg7NS7P6Gf5Vgvn1537nbx93tZl5YC2bLx8L8O5NaW/NVhpJkyyZj9imZQ4/3VrJAr5/FmztfFt0YESJdcGTaR6wEHatb5EonA1m2YJ7gM31qGNYfK9kFYDgWsRb/TEJXS/4wMuWlw8Pg+QuNCMGyv8CEks5wjIwzLoLdg/WlcMFOjdOvYyVAxWLZuUO97BXq5OobtfVe8c7zvwF4ncgjV7DCDNBrROBVwomULDW6
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?DL5ZFIJyZnFaHG17Eo75DyjLOIo0jzlW0Ee3In8WJb8kHwzn9kBBDzpl?=
 =?Windows-1252?Q?Zgy5o8eUci6KdydmjKEY+722LCh+4RJj1sDimwFs5Sz2NZmUGIKHDROx?=
 =?Windows-1252?Q?FmXe4IYQG0990JeTextHEVvhqEpREsNXhKwTcwSlQEcyUClkXYklZk+x?=
 =?Windows-1252?Q?CIvEyTm02wcQyTGa9I7QB8uLzKa5fc4bUvvF25UHG1wqZjDnSBwlwaPt?=
 =?Windows-1252?Q?ksGbHLjV0s8EfXYfqVOAgs3x9kMA4z4bKzSelBaO5HncJL1P8+ZzUunl?=
 =?Windows-1252?Q?JtMxMQqa9/0WxtTnSPMVlYJKfLSAOel3Do7uy7sBDlGZlgErP32xgM7q?=
 =?Windows-1252?Q?Gr5thiAz4QhXnWzcsdjh9lGb7OAWaVf/Ly6HltakfqQOtXvAFIRLwu2g?=
 =?Windows-1252?Q?8qvkJGJcw7ZDC4Ct721pSxG3AgqAMV2sOXFmC+UHw2BuC35+sol8+rle?=
 =?Windows-1252?Q?U1b8mfDc9op7bq6eLVM0H0xMd6I22A0UM37L+Y1IoBAS+NC6UDKdyDHX?=
 =?Windows-1252?Q?7Q+US7vuem8elS8NoTZ9rDkdopICMEgCFRBi4B4EojyFysnvN4kTfNDm?=
 =?Windows-1252?Q?eNdUK1iDS2t2lwqZZQpmD+JCwFms7K5hteIXqjFKFQC75nHKyNefRVdh?=
 =?Windows-1252?Q?15xLiH1G7b4QnA85zRg0XehhZ8iTPgyOBnhuKuzF4pNdRlkeNoFFIn41?=
 =?Windows-1252?Q?xWlfC7L7ihjIQRAygRswpmAgNVaa6umAzVSW4wxkFyiiBviTLjA3fhsQ?=
 =?Windows-1252?Q?FYr0T1VBAd/YlQd+2/mzl5h2EpXxJHrmv+NbzzstCms9LmyH9clY9wWf?=
 =?Windows-1252?Q?xStSbFv5AEwkGfQYLTd0WDnXTxBfR3bIv3ckr8AxFcWDG2En1+suQhMf?=
 =?Windows-1252?Q?325/KOlleV5SiFJ+ZffXx7iZqIk0xEvo8JjV6n62IfSA4RPEHwG21wfe?=
 =?Windows-1252?Q?0EYjkHolrwEGdXKYd00m4UkqeQTznDAPpiLRtoQP6pzjYJXbmvHgJENe?=
 =?Windows-1252?Q?wL/NeKRfUr0tuMeAyP6HlJAk11S8bVoIkExbd6iURROnrq/zgMp8m29B?=
 =?Windows-1252?Q?VlDH14FRQHmBjYwk9+cH6jsPP8S9S/qNV36XruAricplQoQwmGMpaQmc?=
 =?Windows-1252?Q?HZ/1i8t9f+yuUkId51uoDIgTpnY3tpHeXvCpxrZGFz/EHNJYds+UVGHi?=
 =?Windows-1252?Q?0ojOlt1LkJ9dxmgDSaCpIzKSCQZPtOm3mDQacSOdL+q2fDY8g8JCapgc?=
 =?Windows-1252?Q?iTekPeW6WM8GMOuG0EKP2uMzEmn2dQHZtnY+3rYC?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-bcc80.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR02MB10217.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e0a1ba68-ce17-4a5d-592f-08dc079cfcc5
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 12:03:21.6472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB8949

Hello there,=0A=
=0A=
>What warnings? =0A=
=0A=
The warning mentioned in the title.=0A=
=0A=
>And what gcc version? =0A=
=0A=
Probably most versions.=0A=
=0A=
You will probably have to switch on gcc compiler flag -Wduplicated-cond=0A=
in any random released version of gcc to see what I see.=0A=
=0A=
=0A=
Regards=0A=
=0A=
David Binderman=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
=0A=
Confused...=0A=
=0A=
=0A=
=0A=
--=0A=
=0A=
An old man doll... just what I always wanted! - Clara=

