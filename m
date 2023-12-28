Return-Path: <linux-kernel+bounces-12616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE53981F7C9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 12:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26CA81C2223E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28ED6FD0;
	Thu, 28 Dec 2023 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="CBzhdiWl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04olkn2072.outbound.protection.outlook.com [40.92.75.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13FC6FB6;
	Thu, 28 Dec 2023 11:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vt/zy2qLo0dQ/UUn7yvyfQvyaiahCL0lil4NORPWpaGsgZJR+a/+u1aOVzyNsYI1MxKtLuOzhNN0KS13E7pLQWcX7sUe3Yh8ZaMYJ0ISkeQBlfV9mOT3cGAU8wJDbF0m/VTUNRJSVicCgw9uN7mX5qtpykuBuz4TmWmorwQy+GcKYtVSkR43RWZjGzdf8ujqWQWtKvB2sElGUN9OXt2HVg7Rc8Z9PLsU4+EGuzxaB6RTxqlWGTfVgAWTYJgcc6DXQoWLyFf6JB9epjRzsP4zTTY/SJLufGb1z3eGhPHmkR/aCqWLx0bfZTncTRfzq+FOYY5+B5Sap0+5cfJxSH36eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVZESnMbtRH/AuZoizFX9ZcLAZzjlOW+OgvGd5AfFoY=;
 b=XgcKI5d+yD8+sHJMd4zpHRlUy/2ftNUKCashL3MneZoFeF3QTVi5ijaWWXpAl3jUKEDKDiKH4lAWDIn6YDP0BlXEKrD2l9KAlrRQ3F9s4WlBFH839li9Nk4ocKXnVIwNAPk2xi2ewMKmZt7ScZKWco1e4W7/c53yCWdpGK1uGwviGCgf6yWRanRJD3NGNEzFgg9Uq882I0HYYDK8Zg+TTZC5HczIvYmVhQlBNPIOSMVghXuYFBYgJGmE2XoivP6aKLVxBL1rt8RwhmmskpgImZBMN1JI7MRB+oQSHdDPHw9D5hBLNptDagqnHwzSNzvS1tdgVSgZX56Cgf/jIf9Gkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tVZESnMbtRH/AuZoizFX9ZcLAZzjlOW+OgvGd5AfFoY=;
 b=CBzhdiWlJ1Pw/ZC9RsgcS+W7oCePDP08q7nkdlsbczbD3D73dz2m5rK0hioyC8LEw3kef+bsa0uEgiUzIMdc+K2MeuDt74htK0SV3K9LPIrYsKJ1KCU9ucGO4JqtZW1JJxe0M6lj36SZuKtHVgpdzqgKASfXPysKTkALS92C4kVH5Hgm3OJ8Fv3t2uelINXOGUiawZhwuOWVaLQhxtKzfcmiiNEheFbUngZ112jtdnXvxUxprOx3kwTeE8A5vTkFa8TAp+xMBani6gI/88FB8/PuWhSr1M/RZtaNM5OxPbLlP4XbQ8qNv89q1ucChNkY3x5YBChhDIm/0XE99TtxFg==
Received: from AS8PR02MB10217.eurprd02.prod.outlook.com
 (2603:10a6:20b:63e::17) by AM0PR02MB5764.eurprd02.prod.outlook.com
 (2603:10a6:208:18d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.19; Thu, 28 Dec
 2023 11:35:29 +0000
Received: from AS8PR02MB10217.eurprd02.prod.outlook.com
 ([fe80::2b9c:230f:3297:57e8]) by AS8PR02MB10217.eurprd02.prod.outlook.com
 ([fe80::2b9c:230f:3297:57e8%7]) with mapi id 15.20.7135.019; Thu, 28 Dec 2023
 11:35:29 +0000
From: David Binderman <dcb314@hotmail.com>
To: "sfrench@samba.org" <sfrench@samba.org>, "pc@manguebit.com"
	<pc@manguebit.com>, "lsahlber@redhat.com" <lsahlber@redhat.com>,
	"sprasad@microsoft.com" <sprasad@microsoft.com>, "tom@talpey.com"
	<tom@talpey.com>, "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
	"samba-technical@lists.samba.org" <samba-technical@lists.samba.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject:
 =?Windows-1252?Q?fs/smb/client/sess.c:462:20:_warning:_duplicated_=91if?=
 =?Windows-1252?Q?=92_condition?=
Thread-Topic:
 =?Windows-1252?Q?fs/smb/client/sess.c:462:20:_warning:_duplicated_=91if?=
 =?Windows-1252?Q?=92_condition?=
Thread-Index: AQHaOYFrCCXlZ38mvkmOuPmXNZXsLQ==
Date: Thu, 28 Dec 2023 11:35:29 +0000
Message-ID:
 <AS8PR02MB1021708E77D868F8AE5EFD8859C9EA@AS8PR02MB10217.eurprd02.prod.outlook.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [nGjUdUxKBWBOvXbCLZZ9TDpdbyj/Ep4U]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR02MB10217:EE_|AM0PR02MB5764:EE_
x-ms-office365-filtering-correlation-id: d2fb97ee-2918-4982-940a-08dc079917e5
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 OZHLepnlXDqq2E1XTJXmHrau99mQYzbpUjwIJpkgMhlJHATdd7XupCGdxl71JVQJmfm8rpM5UgzISB6rZDkFaSXjKRMPqdFOLqMCrKxnNZb/Fjk14AvPKJO7HoiPobsZy3n8LYRFAfXH/VhaWULt5OxWgRC/GcKFwNVEVt9s8gyMGfIkZ1KhgF0g8iS8N1JQ3slIxqMaVQPaeLjJ4HzVu2+KI7OZlqWTESBhf8tGEAmbziv2xT35cWKRkv/sttwbAm7GYwrcGthwtAa/s6pVx5aI8pKMF9JEGM0ndNEhQXnSQDPRbIjxKaa+IgTczdwYCEFWDfGRmfVz6bH+ieKRzBxxNFo0SMOsy0hDHkD3T0XXBcmDnkn/Qk4JqWzH55T8QU8R+9LJnr4TWQV3hBN1BoRC66JDgwY3THLKRhB3s9gBeg0v2TZxDgtMbLCXSZ3X8XOCJB5ZWoRskMCNLoZwv1NlpT6ZQdgNcc/usvf/9y7ukeKpSOKxB9TcgYaR6PP4aFHTb4xtKe1VNJGTRZFsVlS7xf57EjHvD4lm3uaHmFkuJZyiIhxA+XZg3Gn9fU0t
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?EfjtrhDEwkbX9EZ74UvHoSrbmmRWYyUoyQG1671wm0UEE9ojA2SU2Cex?=
 =?Windows-1252?Q?KWSqo2WASrmjrrL5XD9yhh5KKjGTuqt31A7IqibtxSrrW5yjffUtXibQ?=
 =?Windows-1252?Q?zXGUb4JvffkeztGeCKJiVhdJU+djTlXlTragPsn0zGaU+4/u6TZpqhrB?=
 =?Windows-1252?Q?1dqYx2/5zG5aukn5EApLVjZHVHniG4SScJKfbezBwzEHHq5FsYemJs3G?=
 =?Windows-1252?Q?xSddzXhul7rCSbg4GPztg44HhjtRAZmywNBMEoAQL7jtQHlIevE52vB0?=
 =?Windows-1252?Q?YLR1edt+5dpDQb+0rFslus8zDP38IaPTOnWi8cZ2rDClOcXZ4tnGyUP3?=
 =?Windows-1252?Q?ICX2cewHOCzmVQdldBmWlUZGAR7JHpksUyh2XRUGzytghY4+cSueJlt+?=
 =?Windows-1252?Q?RpUvjX9valyItrypHvAPiBGqh9AwBzkt9CAfbtmMVywy1cm2BdMJK75G?=
 =?Windows-1252?Q?RkAYoKayXG2FksvEfeZDx80jWT/NzJ+YzTLpDn9D5SfDtnQGxnLL6BoY?=
 =?Windows-1252?Q?X2oeXQdBJwORe5Kv7ndzb639tQhTsn9yetSntrVPdNe2jwou7tHfcS4Y?=
 =?Windows-1252?Q?54cnCc6uMbTxkm/46uarFPSna4cNN5H5KS6yCaknA+uWIQ4toF6dIqWr?=
 =?Windows-1252?Q?+GiUwH/0rk8615AyPrp/IBrQZYz5Zv1yKH5Rion2wLvyRJ3EmDz8VXzW?=
 =?Windows-1252?Q?9QPlZxx7x9oGhq0BwHPER5ZIJ/QTYmBCcAM9vf2o1O6lNzbEK85t2dyS?=
 =?Windows-1252?Q?Mr+v08wRUnme0NjnLoOxYesK/+C4XTtK400Xhz6xeJ6hejH/oblv3iPF?=
 =?Windows-1252?Q?wJWBVMiUbx2E+kzz849BCBx6XBvHrfJulbVkzKSrdCPHrJVZ5JIGkTq8?=
 =?Windows-1252?Q?Z6QmX5M4wfl3V8yoocjcGWxuRkbZCzxsQAGLIW90w0DUobwQmfGX47LH?=
 =?Windows-1252?Q?JSXPoWTcuB3uTU9ki3XSGwIifYnPd6MT3OU8zN/TNvw/1OlkdVqXTf5B?=
 =?Windows-1252?Q?nYvZ4qaaspAw87IFBFvuo8hhg4NcG+lLtGKYuyzo4XJoo/sCcAQJRRzh?=
 =?Windows-1252?Q?yh3SDQp72mafatRxZ+up1NddyriIk/10tnjD4tu1mWPQVdTIQ8O97C7u?=
 =?Windows-1252?Q?v08tg759bdWJYdDnfxsa39dsecLMfk8JypiybFWaxZJQIfSV0VcKGWGt?=
 =?Windows-1252?Q?B3EVddM6OZm/7lKJRuiaIepr3c77Y2BrWBPbVuj/lC7iEqECuZ4dZc8E?=
 =?Windows-1252?Q?L9oz+Bb1mnVvgN8WRuIvDy6zp9Hz4wyFdbt3I2SR?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d2fb97ee-2918-4982-940a-08dc079917e5
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Dec 2023 11:35:29.2005
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR02MB5764

Hello there,=0A=
=0A=
Recent development versions of gcc compiler produce the above warning=0A=
in linux-6.7-rc7.=0A=
=0A=
Source code is=0A=
=0A=
   if (old_iface) {=0A=
     ....=0A=
    } else if (old_iface) {=0A=
=0A=
Regards=0A=
=0A=
David Binderman=0A=

