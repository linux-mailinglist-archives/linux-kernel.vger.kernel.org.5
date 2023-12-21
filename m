Return-Path: <linux-kernel+bounces-8251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CC081B479
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC9F283F51
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EF66A34B;
	Thu, 21 Dec 2023 10:55:13 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2063.outbound.protection.outlook.com [40.107.117.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B3C6720B;
	Thu, 21 Dec 2023 10:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cixtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cixtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGRTjykwJ+sJFLYIeDp8VfjHlHJxAAQbOgXWFFEmYzunVG77i6wsyshNcNsmQxBX9Mo5svyUfp+vpzcZtWGTPh2kYvL4juXLuS2LQCR+nTatmU0dVPRr4dyidGv4H1S+yw0LtHJFFN5/LZ7DQxM/WoAojBZg1B7FZrt11Rp1odl/k2y8uf+ZGXR+8X4BoMCjoGw10fwcN2aBAAT7WlhSZSA2hrvtCMojsW/QsSG76/5twLwl9UWcSkXUX9mj+DHd5WeQ6hXdHXVbFjvQHcrzxqf6E+ND821L6jKwtxIKF57ytnScvaH922ytBxHgYx69O+Z8QX3rQlzSHZGaqilH9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XiZKQk9d5sNMNcVeU/TszM+XLYvBJUDmtMPBxmBGluw=;
 b=mmFSiInkG9sAM6vrST49XQFFIF0XdUdTraZlh6MDSY0gfTQHKcPqD2OT9/YwtSQ36kh8EXiqxIvOisEIliM+20Vb23pk224bV2p7uv401cjCVKlnsCLOYBfBKXMoveCWHntLPRX5NuSbBfJIe9tKtoG0d23sj9YRvCZ+1MQoTpej88HyxWUPekUHEEhHCVqtSbd8CIGGTvKujev/Bci7/f6tlf1s7BaI5yT36e8yYZgDWg42pT5UZ3cDgTDI2ry5IzCVYgJev3yxV5JfsHFD5ycOv+GNsmVhGkeBA9S7mD7Z4zKSgQzoeoR8AN+RiI9i0UrhhFrVGivRXrWEXghDQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cixtech.com; dmarc=pass action=none header.from=cixtech.com;
 dkim=pass header.d=cixtech.com; arc=none
Received: from PUZPR06MB5498.apcprd06.prod.outlook.com (2603:1096:301:101::14)
 by OSQPR06MB7231.apcprd06.prod.outlook.com (2603:1096:604:28e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 10:55:04 +0000
Received: from PUZPR06MB5498.apcprd06.prod.outlook.com
 ([fe80::f3a3:b8e8:6e3f:70b1]) by PUZPR06MB5498.apcprd06.prod.outlook.com
 ([fe80::f3a3:b8e8:6e3f:70b1%3]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 10:55:03 +0000
From: Xinglong Yang <xinglong.yang@cixtech.com>
To: Sudeep Holla <sudeep.holla@arm.com>
CC: Cristian Marussi <cristian.marussi@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>, "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] firmware: arm_scmi: Check Mailbox/SMT channel for
 consistency
Thread-Topic: [PATCH] firmware: arm_scmi: Check Mailbox/SMT channel for
 consistency
Thread-Index: AQHaM2j73q0S6m9b4UmorQvngEo3CLCzio0ggAAGIICAAACPMA==
Date: Thu, 21 Dec 2023 10:55:03 +0000
Message-ID:
 <PUZPR06MB5498E03F4E6F59E44295AEB2F095A@PUZPR06MB5498.apcprd06.prod.outlook.com>
References: <20231220172112.763539-1-cristian.marussi@arm.com>
 <PUZPR06MB54988A8170D462FC8EE43A05F095A@PUZPR06MB5498.apcprd06.prod.outlook.com>
 <ZYQY20PlVujcKB9H@bogus>
In-Reply-To: <ZYQY20PlVujcKB9H@bogus>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cixtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR06MB5498:EE_|OSQPR06MB7231:EE_
x-ms-office365-filtering-correlation-id: c7283a60-7cec-4963-e3c4-08dc02134938
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 6PXn1jT9GXi0McdACTkEkwenmFf+D6wBhrgQHzB8ba7OnlezttFU1wR8vjCQWxW7P0wMPd30cA62yKD1+DtnxwGEhC59UVcmgkSGJ2wkuaqZ056w/tdTNstBgE76u37gzatXscI+cb9lzml388t4y/ts/0TjeAcTS58wex/D73HHsXjeOiQmoWs3tck/rUQvHtCOnMcygDZF07JXc1nLmdbF9Ykiv5TClAz2OUs/EWMzvm8NUb8ayGpTnR56+3kykAmWXpIFfiUSD4jL7+uLdzFMiTQO9Bs8Z05yRi53y4FMAm1er9mLEHpi6v9m65GAtnupHwT+7B4gYDCgBX+oZZeTw9DUTnO1p6hs/npLsT85OU7QCLghOW5RjBzyiwAR5ORgVilEtwURi6hN38fvspozFfaSbSuIZBfJfam90SSJSICZohQKAx1woamw55ArVV/sIw8yxspGYde0ra5gMNvsBxOZ1OjsxtYsbMhJN8W259jS/pSEpcnyzaHYbnYr4YeurrpegmTVBvT5KH4gGu2JIsf386dDmocOF80Lba7ETLfl/lGzAEJwizknpp1cnt7iAzjKfDGwDBjekXr7j6reJpQZ4nO+b0SWnDxResrh8GrDj0f9BbfPsalN+fuX
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR06MB5498.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(136003)(366004)(346002)(376002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(478600001)(44832011)(7696005)(26005)(71200400001)(6506007)(9686003)(66446008)(64756008)(52536014)(66556008)(55016003)(76116006)(66946007)(66476007)(8676002)(8936002)(6862004)(4326008)(2906002)(5660300002)(54906003)(316002)(4744005)(38100700002)(33656002)(122000001)(41300700001)(38070700009)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VwlTk18Mb0IfAbqVYvemETu0CGOvi24MTwkRcL7Fqby5EzoMF4NKliQ91tkx?=
 =?us-ascii?Q?QJwbOBGLD/cEZEmKYirIwwhgoFbdvavpZBQeB2fQ2N7Zp1bqwOwpNnUKvTAx?=
 =?us-ascii?Q?GkSKa/U+/+Xn+40UQix8Vb39Or/ulXlRRly8UAyUkZZRqM8S4wjnms8CWXAZ?=
 =?us-ascii?Q?XPPytb3hJehsCa49Lfqz31hQYzC4wyudZv0+vomZuB1hw3PBkXAGx+O5IdpD?=
 =?us-ascii?Q?3ysTSKxKt8UyBf9YWot+3Avjrr5Asm0xK3vW09PhzLI3n60bMQLsULyEr3DY?=
 =?us-ascii?Q?f6UMUdn1QuUyZ5qylBunqDSdiX85RfUVOhnUqw7KbUvMJ4I1yj75RwbUpUbL?=
 =?us-ascii?Q?HV2VHBk4VaWpSHjNveapWcBzq+RZC03tbnZbI9lg6hzDZrwJQphTJNvtbHLj?=
 =?us-ascii?Q?d9wZ+alN3+ShoC4jJAnfVCIOoy7G/8DwRLzKseh98Cp373ZaHow9Vv07gfLu?=
 =?us-ascii?Q?40+xW/tkIAAhyBAxdS6iRfp68V3J/fjFABlFK0tIbvGF1hjc7yyAtaxGSsbY?=
 =?us-ascii?Q?LEiXNuZTuVlUg5XU3Nsr8tO9e4tREtkWXICUJXIiM3UsLuLfFSN6Cz/c95MO?=
 =?us-ascii?Q?hcntTrUlC5lO0njcaZhTkqS+yG9un6Fj7a1ABzUQnpME1TwDUfkyyLy0+Amf?=
 =?us-ascii?Q?ZJVrhQhK/3Y6IZL2SdoM3cA2q8ooz6PsZgoDq8SrqJbDUpcaqNrek8f9WC8e?=
 =?us-ascii?Q?OpzFjuh/4cdZaiH1+RzGpUWMa8garvuKeX9QFb4+wGV7OQ2YmjhBBaGoBjwl?=
 =?us-ascii?Q?vr+5IEZZsuAyLfDHAXr7sjmduzx200TE4abaC4AG3jx4lXbm0djuRflB0at8?=
 =?us-ascii?Q?I9yo8FVi/Vv1OwkWa9YO3XcdCcF/dPiph4vZWyn0zZEc2ClVYugarXTzgdWD?=
 =?us-ascii?Q?/bVFUs2y0BvcOeMGRG4ZHHFmUvkrVhNXEDLo+24UDwRi5J1v2/cBcwhB5sPv?=
 =?us-ascii?Q?IfIo4fnLVos4eIZcj/HNFVE23vUU/O//GfQx13atRq3Wil29934SfhypdefI?=
 =?us-ascii?Q?gkBF4rrvhZD+0zY8lHNnnuFy6OmWofWOHsM31ItNknf6LLD5vn6Vz0j3XOOB?=
 =?us-ascii?Q?PIJCb2p23u62h+ZTiLIkPAAb3X5ZHDlAe5eBX1o2nfJk6qJE4ss1otnslhRj?=
 =?us-ascii?Q?4k4Pnc0vKODl+rD8hTcC0+Pit0g4kpNl1MQaGskVc6Isy7bmghgPcsS3VkjM?=
 =?us-ascii?Q?rhg3PJjnuCb55P1k4WxmiUKj179VJuMwb6ZFcCKM7tLEPEJ2IRQU7QSlgeaT?=
 =?us-ascii?Q?ff+Uyt36oz+CPkc/0QhyVvxbZO3d1pmc6yTIOx129PqYCPAJf+paz5tzoHg4?=
 =?us-ascii?Q?Qkm8GeIR5eqUDyOT2rHcDLZ2/fPzryiWmBHNrdoQAKXCuq0MohDpMNKGfBLe?=
 =?us-ascii?Q?x3lvAZ8LpzL8fz0psai2T2hvItIyJ+g0u2Gi+bwxTNN+43OegPZqEpaRk0z7?=
 =?us-ascii?Q?M73rEwn/QE1DRLK7kCqpEByPCvsS1NcxwnA+Cmmhg6pDpMnx27zbp92ChJ4p?=
 =?us-ascii?Q?dWx4+FX+hAb0fY1Bcr9g0CFyJBXv06deg1gwPdI5sWAwibZrfOzCRiQMJL2u?=
 =?us-ascii?Q?u9tb41A51iOKhfOfky/kFfJELCQ3/4XZVUbAGlym?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cixtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR06MB5498.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7283a60-7cec-4963-e3c4-08dc02134938
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 10:55:03.5333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0409f77a-e53d-4d23-943e-ccade7cb4811
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BjI0vq8XljyisO+5fDY5fES95pqklulJcn2iF7ISCUbFtf8x0ab0fvUtEmXHsMzgT3DiBgyJ0fXAieRCDuM1BghmsiWlKyQ9qES2kws5lgA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSQPR06MB7231

It is ok.

From: Sudeep Holla <sudeep.holla@arm.com> Sent: Thursday, December 21, 2023=
 6:52 PM
> On Thu, Dec 21, 2023 at 10:31:29AM +0000, Xinglong Yang wrote:
> > Hi, Cristian
> >
> > This patch successfully solves the bug.
> >
>=20
> I take this as:
>=20
> Tested-by: Xinglong Yang <xinglong.yang@cixtech.com>
>=20
> Please shout if you don't imply that.
>=20
> --
> Regards,
> Sudeep

Thanks,
Xinglong

