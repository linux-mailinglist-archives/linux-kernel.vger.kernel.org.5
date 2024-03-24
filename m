Return-Path: <linux-kernel+bounces-112615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB55887BFB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 08:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DB911C21490
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 07:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70CB715AC4;
	Sun, 24 Mar 2024 07:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="HCIQZKGe"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AA01426E;
	Sun, 24 Mar 2024 07:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711266834; cv=fail; b=YNDKIaxvaL1GYtL4Uy/EATc2i8ydaGxhfZ48x1dFpVuu841ChK4MW0MxNu/V7GzXP+c6rFO5VDyjHmlTPPeig/XQCGcCDXT97grFNFbTPGmd4pIISXBPXZWYd/Tb3yT8fz3cDPBejw6Spm89E9BJgSTj5K77SPQEAOv+cWbdpKg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711266834; c=relaxed/simple;
	bh=z+hkFQEYyVRjugZ57866YPMpTMegtvG+elSab0R2q5s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZK+R+wQsf8ikDWFTkgLdrRYOYhgD/zs+7ByXC93tnysw1BqmfEPTXbnq3N85iPU53amDF2rSZQk2fPsdQX25dA/WLHXVZ04MjYRN3Z9avLB0MTKt2nx0pFbHHOhOLj3RrmZJV9BRAtkb9OJ8i8qhrrVz9pHAsB7hZsB9OMtpUdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=HCIQZKGe; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42O5hGQt018820;
	Sun, 24 Mar 2024 00:53:22 -0700
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3x1xkhbb49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 24 Mar 2024 00:53:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WjXyLP3qh30nXRdksKfybpFHIf3odenzMQmW2unUWjucUwAbE68t85WbdQ5AUolxgyhIYqwKgaRNeA8J9v+gDZ/AXEQY7i4jfON4KfTwrzFtzClxkrNmLcIXrn/ZTNDwVKpHXDVVWVOiCeaWKMEh8aBXOYzYyka/qijvII0R9cZS1UB3sgs4g3lkkYH8hj3SuYRZDVBO5z3ZLyeDmU5/zlW25VUqOSr/Q8UC+DptisFxxyo9kohIoQ7hzZOp++JuFYgY31JDezC1eNROf9BTQnKNcHiBMfnTrViTZFBtFew1RSqbjxWR4eA+KfQUmPUq7RHxCqIWZ4LPY7VkQAxJPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hCv7GaHn+H0XwA2yI1nmyMJlpT0aevkqglNDfAkEBuE=;
 b=FbnHbI0k4WksLp1x+xAYtu73mfU8zaKg0UvtyeWO9ogaGF51jrvjpu3+J46Q97gLpuSQfIDIZ9voXJ6VeuogBPx+YIeRm8n4J9IBfJfgogYlUhNwopJtbdsY/ZtjCCP+4zqzxSLGVqYXe8z0WYGwZeVX20olT28cPGsWRU5Niu/t7ZHgXUdZefefj7/V30+tJsMk+pj4CcAzmuyeJEeScoOnPAsTWeJrreegXljW7ZTrKHMv/D9CHbd+Vm5WEHbn1dZ5sA6R4CymEA+u+RyvA9Jx5skF3eOsLvY+v9BabckNO9rSKEm4WYqjoRGmChQNdP7gCyLojjSBTXTZNfKElA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hCv7GaHn+H0XwA2yI1nmyMJlpT0aevkqglNDfAkEBuE=;
 b=HCIQZKGedsVI7EWDKWd8lNtN/FfbZcDLRcfAqXA6alWQE2cWgwzOroPhcWukPIYWXjG93fcIJ15E05aJ64xJL0yJx4NVw/KgegFI4GNe2OBSBZg87cDgpv15LfN464W51aM7HYobsGvVLaZj/owkKCGrnBfJIfftit1ZgtrL5Bc=
Received: from BL1PR18MB4248.namprd18.prod.outlook.com (2603:10b6:208:311::15)
 by PH0PR18MB3863.namprd18.prod.outlook.com (2603:10b6:510:49::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.24; Sun, 24 Mar
 2024 07:53:17 +0000
Received: from BL1PR18MB4248.namprd18.prod.outlook.com
 ([fe80::1aec:98f1:125e:8fbb]) by BL1PR18MB4248.namprd18.prod.outlook.com
 ([fe80::1aec:98f1:125e:8fbb%2]) with mapi id 15.20.7409.028; Sun, 24 Mar 2024
 07:53:17 +0000
From: Elad Nachman <enachman@marvell.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Taras Chornyi <taras.chornyi@plvision.eu>,
        "davem@davemloft.net"
	<davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "przemyslaw.kitszel@intel.com" <przemyslaw.kitszel@intel.com>,
        "dkirjanov@suse.de" <dkirjanov@suse.de>,
        "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [EXTERNAL] Re: [PATCH v2 0/5] Fix prestera driver fail to probe
 twice
Thread-Topic: [EXTERNAL] Re: [PATCH v2 0/5] Fix prestera driver fail to probe
 twice
Thread-Index: AQHaeurjPmANQMrOHkqJdwxY/uh+37FBVLMAgAEesYCAACDkgIAD853Q
Date: Sun, 24 Mar 2024 07:53:17 +0000
Message-ID: 
 <BL1PR18MB42488523A5E05291EA57D0AEDB372@BL1PR18MB4248.namprd18.prod.outlook.com>
References: <20240320172008.2989693-1-enachman@marvell.com>
 <4104387a-d7b5-4029-b822-060ef478c6e3@lunn.ch>
 <BN9PR18MB42517F8E84C8C18078E45C37DB322@BN9PR18MB4251.namprd18.prod.outlook.com>
 <89a01616-57c2-4338-b469-695bdc731dee@lunn.ch>
In-Reply-To: <89a01616-57c2-4338-b469-695bdc731dee@lunn.ch>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR18MB4248:EE_|PH0PR18MB3863:EE_
x-ms-office365-filtering-correlation-id: 6d393fc3-b650-49e4-dd3f-08dc4bd77781
x-ld-processed: 70e1fb47-1155-421d-87fc-2e58f638b6e0,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 il7TGruOxwGgerDQXdSTIf6LnTwlhnunUTYmBCjEWUxo+MWc6ELjxYqLPoVHIHGkBvht4Uh1EsfALUBCfql24NLyKNojHTmp4Bpbzm3+dbEnnwUsHVsmbnTbTrBrWgrERWl4dV3AK0+BCJgT32szP3KhED+LwvvGr8N+crKTsh7PVGoIGRr+8/TS0zuaX6esqd5DGIQlNfh8YRjwaDzfRQ5WkMjbJZ7//KHP+sO2Zg8Niqzpy8kzxSSSs3yLqafksk6KQkahZa1gV9FrMQjbxgCRTVks3nCepPWnu6941AJ/nMIk1BrYObJ7vqTFCkVNgTn3qd85s5mhsR90LcK4TPYonOiudb1QcZOfZ/2QohAsiHYirebR0CBa+oTmDSYT6R1AexpxxcGrFyljCENCmBjqP1x0Shi9BZP32z/IXXaWdMc+OWx0O1p34wrxQn1j0LrUhILTLUceYdMxB2WGAawMHgDeVXam2dRNfS3Z1/wFaKsKJtzg5huWMHlWqkYVxQ/84OGliYuiaK7tx7f2JEkT91O/6Bevsvb5EFGQJ2UKMliJ7U6ykgHY7H+Feo29J9JNZgfwl+FbFwddCvZT82TSFuoYjwapRYZc7pSuf5US4JJFADUImv65xvoc5fII6OPCyVjF8C6rR8lC/xNVnayDio0nWDInFFBTxE3RpQBxtq81EKp9tDs4cwdOUJeJPYHyKiWjmK1f+Wx0TGOyG0gby7EACDCIIROmqZ6Pc14=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR18MB4248.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?MyFEsX9PVgujvIFjoM+PcUGn2bNroaKfcMPdsqkW1WodI7OA8FJyyjBtC4Cg?=
 =?us-ascii?Q?y/4uUOSBiEZL/KYAF9YupRVUIkVl4Q4apD6ngk78QlFonyQhCjvMn1pn+Ltm?=
 =?us-ascii?Q?Mh3HKs0abzRVNHCSTFyeXwKwHgcpsxkM3U0Z4hHfjizKUItxZ+8d/rySGMjm?=
 =?us-ascii?Q?zBAB9ILngDkLfX2qJT+9N0tmPa+6H9y4I/DGBrHbBCKYojBBg+0PBbfoG/DE?=
 =?us-ascii?Q?07tGf8qCulq1ZbtWbS39Y7vl0GYodKc75Bao7AN17JzZqoYFGUKh1bJzCG52?=
 =?us-ascii?Q?f+Kurue+5RMRr5KTlOJawqCYCQRK8XJArDHM6wYO8eFGO5aAdcbYJqJixOCX?=
 =?us-ascii?Q?3NuaApa96tZQ0bIWpaKsEd3TUw2NqikthDAbC9sak9aYryWAArjR2bj0GcPq?=
 =?us-ascii?Q?hMudzE7KPaUukrsinKiJA8HeY1TgC8rUhCG6gIeLl2M3Etxvh1yhuf7jRt/J?=
 =?us-ascii?Q?hLtTwBwBls3NLBi5XoNi7hxLeQTyXrkdNbdQnfSxRrQh4tgUgGy5GAw5h5qn?=
 =?us-ascii?Q?yxuY5HvoFKZWcjCA9Qr34OPBsGoV/JSBQiOj0be0PfRbqTWQizj/FGDAGuGX?=
 =?us-ascii?Q?of2Y/ijOjNjMYDTnx/tyZGXBty5lbKQjMK1pittyppU+TeyvePcnqogY8ESY?=
 =?us-ascii?Q?ze+bWT4caHDB+xnYt6XP1HAZW/ytlfjEivsByzywppGlzAwkeE3l/IOaLDG4?=
 =?us-ascii?Q?MOnkguNRIUGhI6A56oqadg0LzL1vkRGHto1hcCyOSOuURzSOqKiCk9Ad2Inl?=
 =?us-ascii?Q?6EVQin6U2c5u0X5JYWAl9zY6INE/UB4llPj3rRlH6FlhYqMdta0fvroSQfZv?=
 =?us-ascii?Q?sLJYFo8xHWA7YlVqjWznApl5z+epW7RZTbGHhebwTUYNPCmBVHXwdYHSjMKt?=
 =?us-ascii?Q?Hjxftpar6Q9FPDoRLEdIErnJ0qh/vGsN/cO58nRkdPCHxmt0DFX1Vc+yN7SL?=
 =?us-ascii?Q?UChikzhvpjYtxg8MyjGuTMfKKdsVikYZUshOiuUOFg2KmJgPKV8pQFMPYej4?=
 =?us-ascii?Q?Aice0AWOPSN1bHdBNTq10s6yK3Ft9tifE92Nvt1YU/0FPwmiuWA2PiSxc2Ad?=
 =?us-ascii?Q?HiR1Tf5d0VeQmB8MXiZX/qbyKRy2EQ8nj6Sc/EBI9PL3ebXv590E3Ugqd3EV?=
 =?us-ascii?Q?HrjnS/9Vr+hKjaOKduR0WGdeDKEJoB6uOujb/AkFV+IqTHE6lBVivDsd3IR+?=
 =?us-ascii?Q?wty8ic3DPmBeyEqwbJgFnsupWfjdN4lOFdHDO6jbWiudXp40Om1XPJ6VFP18?=
 =?us-ascii?Q?1rdU4NN95gZASmvnbNlV2Om/EvSe8laIkJSm/8qE9TGPBDkwINcEZqo+aDTJ?=
 =?us-ascii?Q?bGGGze0Z+YsF3pz041nT9J6h+8jKSxtXWwBPG/qyKnUh4VO4cZCpvee238lY?=
 =?us-ascii?Q?d5cHlQBVgcLGA2CM4Tpc/MiBh7gYaCygg3J5rZywe3PJ7CWa+EZtWGLalIlW?=
 =?us-ascii?Q?pCoEcA9Cbih+0aaQmL/lM0orktQ5C5vSijpBpAZUTSsQXHCJ7ri7/3l/2DTq?=
 =?us-ascii?Q?NTfBo1RaZ68v+gIxEV4jYKCsv09OEPCtgl/6u5OP4LsAqRJJMiaTsgOb8YSu?=
 =?us-ascii?Q?E38NltSmdAXpKAamHdHUKugpidxUa2ASLoWOhDrF?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR18MB4248.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d393fc3-b650-49e4-dd3f-08dc4bd77781
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2024 07:53:17.4725
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xxG807mSScFNsqRyODXW4PeHnLVFubZJGPysRdOHD/mCwKL1dGJkLaglfjjBR/c3KBukQ4NQ3m8moTJMVKqwqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR18MB3863
X-Proofpoint-ORIG-GUID: 7KvjaJp8lFiz-9KXu6p_CBUNnnrv-DrO
X-Proofpoint-GUID: 7KvjaJp8lFiz-9KXu6p_CBUNnnrv-DrO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-24_04,2024-03-21_02,2023-05-22_02



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Thursday, March 21, 2024 9:22 PM
> To: Elad Nachman <enachman@marvell.com>
> Cc: Taras Chornyi <taras.chornyi@plvision.eu>; davem@davemloft.net;
> edumazet@google.com; kuba@kernel.org; pabeni@redhat.com;
> kory.maincent@bootlin.com; thomas.petazzoni@bootlin.com;
> miquel.raynal@bootlin.com; przemyslaw.kitszel@intel.com;
> dkirjanov@suse.de; netdev@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [EXTERNAL] Re: [PATCH v2 0/5] Fix prestera driver fail to pr=
obe
> twice
>=20
> > Originally, the pain point for Kory was the rmmod + insmod re-probing
> > failure, Which is only fixed by the first two commits, so I see little
> > point in submitting 3-5 alone, Without fixing Kory's problem.
>=20
> I thought Kory's problem was actually EPROBE_DEFER? The resources needed
> for the PoE are not available, so probing the switch needs to happen agai=
n
> later, when PoE can get the resources it needs.

No, the PoE is the general high level application where he noted the proble=
m.
There is no PoE code nor special PoE resources in the Prestera driver.
The problem was caused because the module exit was lacking the so called
"switch HW reset" API call which would cause the firmware to exit to the fi=
rmware
loader on the firmware CPU, and move to the state in the state machine when
it can receive new firmware from the host CPU (running the Prestera switchD=
ev
driver).

>=20
> But if that is going to take 30 seconds, i'm not sure we can call EPROBE_=
DEFER
> solved.
>=20
> The later patches are pretty simple, don't need discussion, so could be
> merged. However, i think we need to explore different possible solutions =
for
> firmware {re}loading.
>=20
> > The problem is not with the hardware, but with the existing firmware
> > code on the Firmware cpu, most probably secure-boot protected, which
> > lacks the ABIs to report to The kernel what is loaded, what version, wh=
at
> state, etc.
>=20
> Can you at least tell if it is running firmware?

There is no existing API/ABI for that.

>=20
> Can you explain the boot in a bit more detail. Are you saying it could be
> running an old firmware when the driver first loads? So you need to hit i=
t with

Exactly.

> a reset in order to load the firmware for /lib/firmware, which might be n=
ewer
> than what it is already running?

Right. And there is also the configuration. There is no telling what kind o=
f
Configuration the existing firmware is running. Just using the existing fir=
mware
Will lead to the situation where Linux kernel side will report certain conf=
iguration
(via ip link / ip addr / tc , etc.) but the firmware configuration is compl=
etely different.
Loading the firmware again will configure the switch to the default setting=
, making
Sure that the Linux kernel switchDev side is synchronized with the firmware=
 side
And the actual switch configuration.
Unfortunately, there is currently no API/ABI for warm-boot synchronization =
from
The firmware side to the Kernel switchdev side.

>=20
> That would imply the device has FLASH and has a copy of firmware in it? A=
nd

Not of the firmware, the flash holds the firmware loader code.
This is a limited functionality code which has only the minimal API/ABI to =
load
The next firmware.

> if that is true, i think that also implies you have no way to upgrade the=
 image
> in FLASH? Otherwise you would implement "devlink flash" to allow it to be
> upgraded. You then would not need to load the firmware on driver probe...=
.

Right. This is a limitation of the design made. There is no option to upgra=
de the
Firmware loader binary on the flash, and many boards have it in secure boot=
,
Which means it cannot be upgraded without bricking the firmware=20
CPU loader binary...

>=20
> 	Andrew
>=20
>=20


