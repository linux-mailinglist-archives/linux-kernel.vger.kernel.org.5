Return-Path: <linux-kernel+bounces-518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D85081425F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:28:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5F45B218AD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A1ED507;
	Fri, 15 Dec 2023 07:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KQANRfl6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB1210787;
	Fri, 15 Dec 2023 07:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MKEjJ3/WD4ZJEZIF0m/Of1yIfXD6xDcO1njD9ZWSGRlGgPL4dkEuqvmEr81Hwo5DMiSgki1DM0nRK7/jh0YZ++GNJ68NvpXQ0QI9mRXOkz/kgcvu9LFgW8VqRQTRpSivwID32c+MSh6fjekxx81IoDvbMgMsvxn35G0Pk4reqk2QzAc/XXF0MZeWVQB5cfoPZdbuovRG6DAx8Bphd8DqrRWDLW0ww2UHYBhV/EQCihUHmLwhUWOmx78IlpfRLQYShHeJ8NpDsk7r3/mPphzOZO2qfoTKiqVtDYo1FTbQPoQ8mXKGLMqaJ5SO/w1h47PBXhEA8jt8ZgA1eJ+E4AF5Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1qxNt1VJKzA1qy4pp9hiB/aRj+EpQYb6FbhBzxmHro=;
 b=jW8yQxGGHfZdq1wjbZEoR6tSlDk3fM9V/OQy4mIuOmlxhKdQugjo49GNMl7AiftnRDAUGOxB4SMbae3o5bQcLPsqKpQz354FOV6g0/7/sLsBEh7AkGCtN8ISsAXty4VwAI4+fCeJDw8+FEJbJ2h5dP/EyTkaS6x1mE1i4JhvYfGRQbE6ihCYpl1SJByuMfFpEhVFaywHSG81CUkbI0ChgSpI5hse4DAWmfz4XjD2IVTToLaXHX+1NwTkqHwHWUQu4WolMJy7dMbpO7nuVZ/2OFSJxxEJHdmNy8ruxW+3WAk43Ikz2L0hgYRWiDg96s3kYNuQqAdishZuKwt9/gRqMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1qxNt1VJKzA1qy4pp9hiB/aRj+EpQYb6FbhBzxmHro=;
 b=KQANRfl6ooLveIVxvgtiC6FbTmoYVBWDbjuTjWMPHsvMbQb0ivZc4XeFLeL6bkoGHpdFmppivP0hf2ucG9aL06JLROdr2BDuAx3C4kcPTQo0Siwpi0m0/REis0hjMr7tN4n+Vhkz5S6mvF0mcsCE5hvgidUA55rJlb4papz/ixI=
Received: from BN7PR12MB2802.namprd12.prod.outlook.com (2603:10b6:408:25::33)
 by BL0PR12MB4898.namprd12.prod.outlook.com (2603:10b6:208:1c7::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 07:28:02 +0000
Received: from BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::2a35:852d:bc78:ed64]) by BN7PR12MB2802.namprd12.prod.outlook.com
 ([fe80::2a35:852d:bc78:ed64%7]) with mapi id 15.20.7091.029; Fri, 15 Dec 2023
 07:28:01 +0000
From: "Mahapatra, Amit Kumar" <amit.kumar-mahapatra@amd.com>
To: Michael Walle <michael@walle.cc>
CC: "broonie@kernel.org" <broonie@kernel.org>, "tudor.ambarus@linaro.org"
	<tudor.ambarus@linaro.org>, "pratyush@kernel.org" <pratyush@kernel.org>,
	"miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>, "richard@nod.at"
	<richard@nod.at>, "vigneshr@ti.com" <vigneshr@ti.com>,
	"sbinding@opensource.cirrus.com" <sbinding@opensource.cirrus.com>,
	"lee@kernel.org" <lee@kernel.org>, "james.schulman@cirrus.com"
	<james.schulman@cirrus.com>, "david.rhodes@cirrus.com"
	<david.rhodes@cirrus.com>, "rf@opensource.cirrus.com"
	<rf@opensource.cirrus.com>, "perex@perex.cz" <perex@perex.cz>,
	"tiwai@suse.com" <tiwai@suse.com>, "linux-spi@vger.kernel.org"
	<linux-spi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mtd@lists.infradead.org"
	<linux-mtd@lists.infradead.org>, "nicolas.ferre@microchip.com"
	<nicolas.ferre@microchip.com>, "alexandre.belloni@bootlin.com"
	<alexandre.belloni@bootlin.com>, "claudiu.beznea@tuxon.dev"
	<claudiu.beznea@tuxon.dev>, "Simek, Michal" <michal.simek@amd.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "alsa-devel@alsa-project.org"
	<alsa-devel@alsa-project.org>, "patches@opensource.cirrus.com"
	<patches@opensource.cirrus.com>, "linux-sound@vger.kernel.org"
	<linux-sound@vger.kernel.org>, "git (AMD-Xilinx)" <git@amd.com>,
	"amitrkcian2002@gmail.com" <amitrkcian2002@gmail.com>
Subject: RE: [PATCH v11 00/10] spi: Add support for stacked/parallel memories
Thread-Topic: [PATCH v11 00/10] spi: Add support for stacked/parallel memories
Thread-Index: AQHaH4DWk85ayhAN50GzHAcX+0JPbLClsDGAgAGh+SA=
Date: Fri, 15 Dec 2023 07:28:01 +0000
Message-ID:
 <BN7PR12MB280267F8478681A1ED48A2D1DC93A@BN7PR12MB2802.namprd12.prod.outlook.com>
References: <20231125092137.2948-1-amit.kumar-mahapatra@amd.com>
 <30ffd8378d3ef1c4fa6dfe4324b18345@walle.cc>
In-Reply-To: <30ffd8378d3ef1c4fa6dfe4324b18345@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR12MB2802:EE_|BL0PR12MB4898:EE_
x-ms-office365-filtering-correlation-id: 9f4ebcd3-7d79-4351-5fb2-08dbfd3f5ec7
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 DBs4tti4xyWzCQD3UoYWlcULg1RE0TvzGj6snW2J7CTmA0vh4Dic1Q0E1oJT+OMZAuwpjm8/JCRHvXS1agNE07qg2BEuimWqiSpxD+80yKqsJ4Te23sOPFcDJ9NolqaU79INjHcmhvaMtefCzTeHYbc7gSaFRVzEI/D6B6SJCQG8L8pfrXOJCjEk2/ZnDJdllRKCeWnQLWj8ZpOrmaQt5S2Xsw1YPK7D/QKVdfxy7wCGAhR2vwt6WbBalL6af+bIynj4Nz921aUzZ0HNu+z1QGDBNEjgnJO+lg9izOEwMwVg+wkeYhkr/ESMbCsc7SBXurmQxToOj5T0S0vd92vih3eY3t8a6yC7YZVebBVA5+eviSXJkX0fnCW54YGLAaTIieW7yYvxoIEzqPg6uJYN28MTRIQrB8cx228BSO/JNPKYZKu4SVV/LipcCCu/5yvr+rfctmW691V5Fvz9nayc36KI9S6JIY4JpR3SNtbb63Uh72VzNMq90bMCvcGWcSCntGvKFPDsdrppVlfCSZuaRtbHTyyj4r2dCibtgTPsnBaOlptxf9mj2UkBsTnT3uP46tsmqPxmrWo0axemOAzBxW7RbAahj8m1Hb2ruoTfBeKDtn5UeAnSmOFrcr6O267n
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN7PR12MB2802.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(376002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(4326008)(8936002)(52536014)(8676002)(2906002)(7416002)(5660300002)(478600001)(6506007)(7696005)(9686003)(53546011)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(316002)(6916009)(41300700001)(38100700002)(122000001)(55016003)(33656002)(86362001)(38070700009)(71200400001)(26005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?nwB2bHhWPqOu4O8k9NXequEAXrH09gpK2BpCd/SiFQtlYAykZKqx0xSAKq3c?=
 =?us-ascii?Q?kjWOQ6OuD6e79yS6cWtkkJlKZITpG/m3HLPbQ3EVsNT6kb5FtvcWSJdewy1p?=
 =?us-ascii?Q?GM/gtyyprzAVB1cycpxKpRmjlNBtSMhMETl4o+ySCQxtKvHwvDxLLJpk2pej?=
 =?us-ascii?Q?KdQssN1/XXxqfOTP7df2QrMzqlAu2vCKQ8gzAVf6iDwUyMhhCt4cOXf3Peva?=
 =?us-ascii?Q?TRy5/j9QLmqrFvpTj8p36ruaniXOWnm4zXrg0HXTRP9sNTFrkYksA6JHTSNJ?=
 =?us-ascii?Q?Eznf2tRkSV7UrvqyAwxPfwyH9/vO9SJVeWJtWpkuvm0Lq1bTFBcfwXqClsws?=
 =?us-ascii?Q?hV6IgEVNBGVSTq5cdqwX6piMvchOhgoudIAPg4xaNpidGN4nIHH5ZzvYYJmU?=
 =?us-ascii?Q?oS+N95q3s8EFad4lM2/EqK6qmgD0mtJUrm23WtUgdSTK/eH7GjaBDJvz+mNf?=
 =?us-ascii?Q?Gq8bWXP1Aih6YpJQsAF51Su/5QsOKMkxcOBWqhuXRT1aOX0mBfUoybLDGT9O?=
 =?us-ascii?Q?3TIOfczsypMDaoN94hrC/vC6diPhcd8tCr5jB6hNQYsjPTxK0FeJosFtUIOL?=
 =?us-ascii?Q?uESblRaWcW8hwbvAIS1aFTDQTxe5vmAxHqRUfEGR9EE3ejfe+vO3OYYZl68q?=
 =?us-ascii?Q?UL4uazXzv/GyPzZ5DV1Rw3UqiA3KgUhA7vS4QyeDsHmJF0om/2zqZDlZB/7D?=
 =?us-ascii?Q?CLIPVSnmibmOdbAha9SMpwF2tgjWuW4ZUGJMVrO0cwKZ26cRCMYZqPUk6nbV?=
 =?us-ascii?Q?XzvSKNNCA5qGvV2k4rXlaVkeHQfn2kgN/JDYcbpcvLrsu/1haSYUYsi7SkX4?=
 =?us-ascii?Q?XcJ3ZOJGBFB/lWLpvzyOVSiR2qzckVy50dEc09vI6pJhmBj2KW5GPT61Om0C?=
 =?us-ascii?Q?M4DoIxKW46X3YjOtKOtROJbEic/2cqAihfWHjRtWk9dc6+IqW9Vx8euTfKdF?=
 =?us-ascii?Q?k7KStu4q5Ujghr8ulE0Yd6fw1s17HOyxIUkFaRXHBoG2jXry/tgqaTeEPy75?=
 =?us-ascii?Q?YJnhzfTBLlysfKajqawEAlua14d3Qe5gP0vGfGYC6wQ6nzMs7IaVBO6XVQPI?=
 =?us-ascii?Q?BJkA2/KWLOEQBVaHEfFVUKPS3LBQEmx9g08vFlOdwJqlIZPZHasFQnW1W5ud?=
 =?us-ascii?Q?caf9OU4Q/puPNT0WdDsyyjiwG+bo8RGr0eH+s5xNdMbDkXbZrb/VaPRet5cO?=
 =?us-ascii?Q?GwdPtOwLdrdGjgfIKvU+mElXklxCr8CAuFBTR1swZV2upTYEUjnvW7wmg7AN?=
 =?us-ascii?Q?S4uwf+WYJzGSbuw+fmrwzuqi/3NcAvmFX5XF08www4ou9bved5ii3bSviuuQ?=
 =?us-ascii?Q?5uYrEh6cDaElNwouBsRTp8pelM24GE5IM2vgfavdahty4Yh9EyCxicoHZ0/e?=
 =?us-ascii?Q?5PnYO7ANdfGfB1y/KXnSToYcx1AfnuJqn6b3zURx24nu3Glm/z0FiAbb8lmU?=
 =?us-ascii?Q?gNfb2mRpqIDCJ95K/L1reO9EnkN+Vn3y2YNrPy50gVHlPgggHNIJcIymuuoQ?=
 =?us-ascii?Q?zWU24lIX3VDeg+LPOon4LONYmglMbP+ZrGCvZ4ttNRKbw4h2G6eXxS5P/iOu?=
 =?us-ascii?Q?xDG1xHWRXTXI/hhqccw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN7PR12MB2802.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f4ebcd3-7d79-4351-5fb2-08dbfd3f5ec7
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 07:28:01.7399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S9WSAYyOnA1CKmg/ARMjkMj1kuuuN6el2HZD+Vk+SxAF6YdjY/XHT3j5e7TCpA0mOyOjiLO1mZ3gLYnxYSViQg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4898

Hello Michael,

> -----Original Message-----
> From: Michael Walle <michael@walle.cc>
> Sent: Tuesday, December 12, 2023 6:05 PM
> To: Mahapatra, Amit Kumar <amit.kumar-mahapatra@amd.com>
> Cc: broonie@kernel.org; tudor.ambarus@linaro.org; pratyush@kernel.org;
> miquel.raynal@bootlin.com; richard@nod.at; vigneshr@ti.com;
> sbinding@opensource.cirrus.com; lee@kernel.org;
> james.schulman@cirrus.com; david.rhodes@cirrus.com;
> rf@opensource.cirrus.com; perex@perex.cz; tiwai@suse.com; linux-
> spi@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> mtd@lists.infradead.org; nicolas.ferre@microchip.com;
> alexandre.belloni@bootlin.com; claudiu.beznea@tuxon.dev; Simek, Michal
> <michal.simek@amd.com>; linux-arm-kernel@lists.infradead.org; alsa-
> devel@alsa-project.org; patches@opensource.cirrus.com; linux-
> sound@vger.kernel.org; git (AMD-Xilinx) <git@amd.com>;
> amitrkcian2002@gmail.com
> Subject: Re: [PATCH v11 00/10] spi: Add support for stacked/parallel
> memories
>=20
> > This patch series updated the spi-nor, spi core and the AMD-Xilinx
> > GQSPI driver to add stacked and parallel memories support.
>=20
> Honestly, I'm not thrilled about how this is implemented in the core and =
what
> the restrictions are.
> First, the pattern "if (n=3D=3D1) then { old behavior } else { copy old c=
ode modify
> for n=3D=3D2 }" is hard to maintain. There should be no copy and the old =
code
> shall be adapted to work for both n=3D1 and n>1.

Stacked mode serves as an extension of single device mode concerning data=20
handling and CS line assertion. In both scenarios, the driver only asserts=
=20
one CS line at any given time. The existing code has been expanded to=20
determine the CS line to be asserted based on the requested address and=20
data length. This modification accommodates both single (legacy) and=20
stacked use cases.

In contrast, parallel mode differs from the legacy (single) mode in terms=20
of data handling. In parallel mode, each byte of data is stored in both=20
devices, with even bits in the lower flash and odd bits in the upper flash.=
=20
During the transfer, multiple CS lines need to be asserted simultaneously.=
=20
Consequently, special handling is necessary for parallel mode.

>=20
> But I agree with Tudor, some kind of abstraction (layer) would be nice.

I agree too.

>=20
> Also, you hardcode n=3D2 everywhere. Please generalize that one.
>=20
> Are you aware of any other controller supporting such a feature? I've see=
n

Currently, I am familiar only with the AMD-Xilinx QSPI controllers that=20
support parallel/stacked configurations and AMD-Xilinx OSPI controllers,=20
which support stacked configuration. However, it's important to highlight=20
certain aspects of these configurations. In parallel mode, each byte of=20
data is stored in both flash devices, and the QSPI controller=20
automatically handles the byte split and the simultaneous=20
assertion/de-assertion of multiple CS lines. Hence, it can be stated that=20
parallel operation is a controller feature, and other controllers wishing=20
to operate flashes in parallel mode should be capable of data splitting=20
and asserting multiple CS lines simultaneously. This characteristic might=20
be specific to the AMD-Xilinx controller.

In contrast, in stacked mode, only one CS pin is asserted at any given=20
time, determined by the memory address and the accessed data length.=20
Stacked mode, unlike parallel mode, functions as a software abstraction.
Once implemented, any SPI controller with multiple CS lines or with a=20
combination of native-CS and GPIO-CS can operate two or more flashes in=20
stacked mode.

> you also need to modify the spi controller and intercept some commands.

Command interception occurs exclusively in parallel mode, not in stacked=20
mode. In parallel mode, data must be split during flash memory read/write=20
operations. However, during Flash register read/write operations, there=20
should be no data split, as the identical data needs to be written to=20
(or read from) the register of both flashes. Consequently, the driver has=20
to intercept the command before activating the data split feature of the=20
controller.

> Can everything be moved there?

In stacked mode, determining which flash device needs to be asserted is=20
based on the flash address and the length of the requested data. This=20
information is handled by the spi-nor core. If the operation spans across=20
multiple flashes, the command, address, dummy (if required), and residual=20
data must be issued to multiple flashes. This process should be carried=20
out in the spi-nor core layer( or before spi-mem) and not in the driver.

 That is why >=20
> I'm not sure we are implementing controller specific things in the core. =
Hard

As explained earlier the parallel mode of operation can be controller speci=
fic,
But the stacked mode is controller independent.

> to judge without seeing other controllers doing a similar thing. I'd like=
 to avoid
> that.
>=20
> If we had some kind of abstraction here, that might be easier to adapt in=
 the
> future, but just putting everything into the core will make it really har=
d to
> maintain. So if everything related to stacked and parallel memory would b=
e in
> drivers/mtd/spi-nor/stacked.c, we'd have at least everything in one place=
 with
> a proper interface between that and the core.

I agree.

Regards
Amit
>=20
> -michael

