Return-Path: <linux-kernel+bounces-46859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB10844582
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:04:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E36A71C218F9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 17:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C030C12BF32;
	Wed, 31 Jan 2024 17:04:12 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2066.outbound.protection.partner.outlook.cn [139.219.17.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B1F6FC6
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720652; cv=fail; b=F0nMBZDsoHO+bdMiKXc5Wbg+d2q0ndsz0ECKUV7kKkHguUclQIy2f5jQ3myipRfetwoBCUFop70mcwgGVrajUW/NTSWkUF7Q0CBB0HknrDbb53O86NxMB7JXgj+1U4ex2johsgEVtIV8Q9EWa2T1LZEb3/1AQEIP+MfDZ+HYP/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720652; c=relaxed/simple;
	bh=78KXdCFu8JZ8rwbFCI44dR0x79tDdCE9CCEiuqcDnPk=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=MNmecEsUX25Wj6keRlyr1KcOdM1R2meMXBPuNxk0jJlH7Vkon416Z6qiaXIkHc0cV9HJveDbf3Y41foVvB7sIRCmVFFo5mj7qO+GiNsbfVIoLg3cs71uHNp6bottbhjhKrzLe5TY3VeZC0OEqeN/zyiS90AnIS6kE1dl5FP52aY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9vKtLHuIwk2g5UIe6v/ObTYT4zhKPmeqVjEt6gviJtv1OHUTD3m3DGQ3G7TWoYC+4FyJKAzWx2Wr9qSecMOY5clPZZZv0DImyCFFwi8vgePQfu++K4We7ZbwZSsUQf2rRlvn0QKdZevdI9S1l4u3x9ojj++PC/PXSVH7hLb/KksXHVfCuAybWUHXyHPwkXUOZ3DmnFMZXqn0ba5IB6SMx/24abLAF1chxQ5oJs0yFI954ewTWGeKwJVknTooIpgd2WyQMtFwrkG4/kDve4+NcqBqKtBm36f60BP9vgWbdTjbL6wcdlEC4c50wMtrb/6esCxLkIy1ygXIjFsdyJ55w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mhk/vSsujS97XOJdi5tV0xrz4lI7P3rabe1TQbMbaSo=;
 b=EDaD7K1kkSZWiDCaguElpuAItFao7P0ioPxNCD2710GTBle7iIRYL4oRKgXNTswCWSligsEU5awa0sNjnD1M62btjwa/+h13/PQlJK8h0toWIxvDcvLcWH49Xs5NIQ27n5mU9Ozmm8QWuk0BbDW7VCBKeTfUkaDjsYx0NVZTbS9cj3Ay++uTMaUp1AqCgIOkDQh5eOcBFqKMsFY/mmPMsd2rWy/hzeHYSoxewy7SEnyOoJYI2S6jlDJANyo7WDDHwA9bu8gpsKkMRv40V725HuAlnGf8ARO5s4Xf4PZrV4skVaqvdpMFo5ZJVfgpdxhc/8ygcgdX6SV3G/kTg+UzZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12) by ZQZPR01MB1107.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.19; Wed, 31 Jan
 2024 16:48:00 +0000
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 ([fe80::ca86:dfe4:6667:5205]) by
 ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn ([fe80::ca86:dfe4:6667:5205%4])
 with mapi id 15.20.7249.017; Wed, 31 Jan 2024 16:48:00 +0000
From: Leyfoon Tan <leyfoon.tan@starfivetech.com>
To: "surenb@google.com" <surenb@google.com>, "akpm@linux-foundation.org"
	<akpm@linux-foundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Compilation time increase with this commit when enabling DEBUG_INFO
Thread-Topic: Compilation time increase with this commit when enabling
 DEBUG_INFO
Thread-Index: AdpUZTKIBFwlG1IkTK20oxH2uhL93Q==
Date: Wed, 31 Jan 2024 16:48:00 +0000
Message-ID:
 <ZQZPR01MB097928D272E733B32A81049F8A7CA@ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQZPR01MB0979:EE_|ZQZPR01MB1107:EE_
x-ms-office365-filtering-correlation-id: efbdd3fa-9db3-40b6-57e7-08dc227c6286
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 9uf5Xdob7N6edF5LWPZPCYOnzQ8A7rs878ote0eeBxX2TNpIQ/skbzGiVRan3dryisHYnvaIY0MnZwgQJgiI2+saPs9QDFISSae1djDNOk7KphkJi9IPvi14kYu9UU4VEl7ln7en6zbVwQK0LDnW7KxWzdtdZc2CykyozrfCjLUEAd0P43ie1JfbNjXU9vd91TcwWo5HwvUM3zgxyiZDWME0lJGNTjS37XFTUwv1A77Qah3JVbVixR6jyVsmTPdwkD+ZUstrHCAdYlpxe8LOrekAc4DHEdlmjkRHd1cdkVDtbQ8rwRteV7Byc7fRfCZzTvpyAHmfVN8xbb7Ip3DN7zHbgDri9Kd0CNlfkoOtjDn1akRf5HT3qfIXi9fkplzilU20ufZLH0QoQbo9qrle6G4pkXyJpKTFjuUgBHPsEnT1CjQ0flHvntXuRBanOvQ5HguvB8eGMzx5bnxct2W5XOOW6IhgWYVEPiCwOaVy/ukfQUn00L9YQg87M724S/8wgAgWj11d7EwomPTsodgCHfcQr+ZLyk7hnkeW6uLWAtGBCFVQS8QmXXYLUrAdsOsE
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(39830400003)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(41300700001)(41320700001)(66946007)(44832011)(4326008)(8936002)(2906002)(8676002)(4744005)(33656002)(5660300002)(110136005)(86362001)(76116006)(40180700001)(66476007)(66446008)(64756008)(38070700009)(508600001)(66556008)(40160700002)(38100700002)(122000001)(55236004)(7696005)(9686003)(966005)(71200400001)(83380400001)(26005)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lpaSTKwTGxfw7akF2TJM2hWTcZ/tysMGyp0KK0TaN7Z1NDpgL/XR3XftBT3w?=
 =?us-ascii?Q?jQxz3QsgkhP5lLcaMEOK7dVg/EUf8/JK/8C2jduQQanwhvhlUHlYrwIkW1VG?=
 =?us-ascii?Q?zv6mjStZlMUss67VKYkO4njAlnhOJH1XP3wE7Mn15IxQPp+l0SchcXLDsB59?=
 =?us-ascii?Q?9JTWH9f4O8hc/yofbyVZI7u6LguR9nAByl2Iel3/daJk4qOVmA+VwhhiGolt?=
 =?us-ascii?Q?qJ0qQCLjBotOndP68IlRw2ONOi2QoZnzmxCpN6IQYneh1v3+zVPG5bMrUQC/?=
 =?us-ascii?Q?y3Pk/gNMGtDJ5pfZRWphk0LHyTSuVhhNfC+l3NdfMINJzmlfXIWhXq4oE94T?=
 =?us-ascii?Q?ddY12fbFfKH3mbivszr7T/voBNQY8/RKF86xjXGvQBRwUGaw7AFdyfZ5Awp3?=
 =?us-ascii?Q?6wm7rrWQKfLxUJgpI+8nZOSXqaLzoH+qKuyxvIjxCbjFKXOXVOgrkjTyfk7q?=
 =?us-ascii?Q?PVVg8mM2S7SL2rxbiBcSzrFvi/zSWwPOPAHA4PPjQxXOKcakylcM35ydPZIY?=
 =?us-ascii?Q?4sh3PVURdfLbtsw49jXQT0S06H4t5HfLfgs8FkN52A+mZaWwgD225Z2Bjglv?=
 =?us-ascii?Q?jzJPVaKOmRa7C+CzGXO/jivxWpKI/kRqWDeso8ZNYjq12XxKRRqqbirQy+8b?=
 =?us-ascii?Q?fHHGCni2g/9xbUmkNxtnF1YGxRYP8wMCNCz74XauktS/Upmp/63IYBeK0xel?=
 =?us-ascii?Q?9byv7R+v5X1jIQAFcpcW7HQktSDOXlHAa0HY2+CjYuIs158PbBKIat4zn6DE?=
 =?us-ascii?Q?o+5X/NGTkEu/lQHvXeU0W4ddpn3wq6qfWMu6d6XAen2Mj6NIfrQxGzlgeopr?=
 =?us-ascii?Q?tSasq8afB0LSzr4XTjA/u/efzMGucvn1CnMNuGftkMRirA1iKfcbU8KUAHUb?=
 =?us-ascii?Q?k2XQq/lhAaTJm1v0Y0Gx62ASWgOLbrFymTY4htRjjGB3mFww6+i+DbmbIlC4?=
 =?us-ascii?Q?d6+ISg5BVGSIkgVgrwKmEXdXkR7H7wXSo7XjdpiwJDTqIf1AtX5033CT8kXB?=
 =?us-ascii?Q?jVhNj7CzcO2KoiRAyWvsMDNR9bw8eZBW7N5yP14S6HKEglL9U6+4S5fywpZt?=
 =?us-ascii?Q?dB+CORb44BMt94GOjtNwE4TFnhKFbc9Sq78G80OCNRlM4/Vb6lgQrr3Cc4ts?=
 =?us-ascii?Q?i9UXeIlNHAOPe1JbnJlSSRL98GE7UWstdnFTVGMH/BTSraj6TQHr/E0Ibywk?=
 =?us-ascii?Q?/j3lcRaDhiZrEc5rnb1vOmZ7crZ26n82k3PyJHzShvoP21Ec4RTy2I8twuuX?=
 =?us-ascii?Q?JLoZOwGd1Rkn0Gv8i+mJ4MZu/2+4s3dEJlleaokcvEgakqjd/2z6nc3p5acA?=
 =?us-ascii?Q?fYzB1MBVWQIQqJe1cmnSU2Jwc8wVx5bMw7GhgJNYbauswvmOLX/0qnh1McX9?=
 =?us-ascii?Q?wglPhNjxuK/vcyRNOTbCL6hj3urH8UDA93X2lNA+KdsgJKbKJ3OKu0tbljnH?=
 =?us-ascii?Q?nGPXzzrTmvKdKG5ZtWTsEO1BGuRR+OCrlg42o+ICimQpmlTtT/lv6yDh6zVc?=
 =?us-ascii?Q?Hl2wiGCfJ/NKGvE/9e/QVU61xuV97hpsUKTcgdtNOJkP/ep8PZcovpuX16nn?=
 =?us-ascii?Q?Lf5+NRXwu3o8TrV8yiH0tDXv8/RhVzkHujDNaHW8EpBIqDEpA5YHHVbexaT7?=
 =?us-ascii?Q?6A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: efbdd3fa-9db3-40b6-57e7-08dc227c6286
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 16:48:00.3900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sL+kjhUUgGtNb/8iFRqnGRT23Nz4OQdZjm2V/xsOCwsnGP+wr7bAtvvTEOEvQj534rXVi/MOpMsLivDCf93k37k+DUGPBMVl43AciUII+tc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB1107


After the commit "fork: lock VMAs of the parent process when forking" in [1=
], the compilation time increases from ~2 minutes to 8.5 minutes when enabl=
ing CONFIG_DEBUG_INFO* (CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT/CONFIG_DE=
BUG_INFO_DWARF4/CONFIG_DEBUG_INFO_DWARF5).
Looking at the commit changes, not sure why it causes the increase in compi=
lation time. Any ideas?

From:

# time make -j
real    1m51.522s
user    59m55.836s
sys     5m29.177s

Increase to:

# time make -j
real    8m31.967s
user    69m24.410s
sys     5m54.588s

Note, compile time above with ARCH=3Driscv, defconfig + CONFIG_DEBUG_INFO_D=
WARF4.

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/com=
mit/?id=3D2b4f3b4987b56365b981f44a7e843efa5b6619b9

