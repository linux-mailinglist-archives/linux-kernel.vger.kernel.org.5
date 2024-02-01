Return-Path: <linux-kernel+bounces-47843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF20845399
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 866171F285FB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1106E15A4B1;
	Thu,  1 Feb 2024 09:16:57 +0000 (UTC)
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2091.outbound.protection.partner.outlook.cn [139.219.17.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B65158D8E;
	Thu,  1 Feb 2024 09:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706779016; cv=fail; b=jpXiq5aB2iHTFuAAvlOrDVBeQ+KzZMDsoZVpkwCAW98waoVT0B0FRp2+ZPzmLMJXklmSMPkOmIv0ykmyn1x2k+Mb07t1O9fgj5eR05o4CuQCdSJwxWnEWfl4IHMb6By14+OkblEHewt+RjmKu2nY5h1TXacK2yI8g5fkkapg4VU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706779016; c=relaxed/simple;
	bh=j7pinLOfXrlzvvIruI3WWCMhf8OHjLOki9SqXxg8/AA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=O/4HqXZWFzMHgFvPjB1Y5BoiR1ZsVtBfj4RjplJxKi0eUyp9j/KJNBpW3dEwAQ95ll2nNurDaCWZthJF6wbIyiLfCyJh2NdH7Vr8SFIu8tJoPBXTCDemk4/jPe80r83fW13yScxqxcffoR2r6JgQjnPMQgfC1KekIQeKGPeKEJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LBb04XTDPaN/u27HUqiHgc3aoDXdC/xAlRNHTZg7n9ngVXuAcLmdJ/qK3sXz0Pf92QAWWq8nnZUrN2Jd/kClzovrczhxpoQT2Iq2xOChPrtVhAo4To94nlB2wfZCCEtwIcJQzHrPPWbGyj4LRzrBoMUNar4Fc2NtD4Tbhrx7/TBKynOrYK1YLC3gPR+z4XkUYsOs4Zp0QdVeI0WFz8/vG+SkkFlXHkCfVzh01E6QJEV/zjLlG9vCxavrriD+QIHLej7ePK4wuRM6uNX/8yQpnG2HjlS7um/cGYkG/tYwz9pepXfk8KHqdzZ4GSMHW8mCfLVds+1saEBNs278dU9+6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j7pinLOfXrlzvvIruI3WWCMhf8OHjLOki9SqXxg8/AA=;
 b=EF5qKX9mibZCaJ+tHgR15/KGLYCbW9crCvHpGZzN3/+CITxwlxAdArlgWKACr/kV5cMU8/0cTD4ZNkCL8RQhVd8ZiIPuSqJ96ZFbDgOV+MEKmXUmI04YpGSa1AoQsxYW+lEaKcMek/Vzf5AN5bVVebl+9OihPEN3w4XbfFrjB8zDRz7zWchH3VoKSOymKRlEYt7r6Sgb9JP65qBa8+EDjLu0/5MkpR0t6HvmlcCDTG8h6o3PMNOm+k9hhE4RFeqGJ/ySRREsI1JoPnQqYsx7woron7vNapu8tR0xuqJDsepcy8Qq2E0tWqmBfIIvAzg53BkYWo73s4Dxsq3TO3Y0nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::16) by SHXPR01MB0880.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.28; Thu, 1 Feb
 2024 06:40:09 +0000
Received: from SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
 ([fe80::f66a:7cf2:72ea:df3e]) by
 SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn ([fe80::f66a:7cf2:72ea:df3e%6])
 with mapi id 15.20.7249.024; Thu, 1 Feb 2024 06:40:09 +0000
From: JiaJie Ho <jiajie.ho@starfivetech.com>
To: 'Herbert Xu' <herbert@gondor.apana.org.au>
CC: "'David S . Miller'" <davem@davemloft.net>, 'Rob Herring'
	<robh+dt@kernel.org>, 'Krzysztof Kozlowski'
	<krzysztof.kozlowski+dt@linaro.org>, 'Conor Dooley' <conor+dt@kernel.org>,
	"'linux-crypto@vger.kernel.org'" <linux-crypto@vger.kernel.org>,
	"'devicetree@vger.kernel.org'" <devicetree@vger.kernel.org>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/5] crypto: starfive: Add sm3 support for JH8100
Thread-Topic: [PATCH v2 4/5] crypto: starfive: Add sm3 support for JH8100
Thread-Index: AQHaSFqmtg6Zzl/qkUuu0ddSCEXpi7Drn0sAgAgJJNCAAWlFgIAACDkmgAAAhAA=
Date: Thu, 1 Feb 2024 06:40:09 +0000
Message-ID:
 <SHXPR01MB067059F064CD56ED58DE6F9A8A43A@SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn>
References: <20240116090135.75737-1-jiajie.ho@starfivetech.com>
 <20240116090135.75737-5-jiajie.ho@starfivetech.com>
 <ZbNCKrTLXmPcsrSH@gondor.apana.org.au>
 <BJSPR01MB0659C3FE1262DF8CC7F7DA468A43A@BJSPR01MB0659.CHNPR01.prod.partner.outlook.cn>
 <Zbsu39gZn2cGrnew@gondor.apana.org.au>
 <SHXPR01MB0670720DD9EAB09EE8A1B13E8A43A@SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn>
 <Zbs1xy4DesZDkFC4@gondor.apana.org.au>
In-Reply-To: <Zbs1xy4DesZDkFC4@gondor.apana.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0670:EE_|SHXPR01MB0880:EE_
x-ms-office365-filtering-correlation-id: 34391265-901b-49f9-adf4-08dc22f0a286
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 kXqae8NORKHfG2l8w1tRJ2vkoVDR+VlG9QEwI/EyUejMVvKLDnXyJ/XQZbQ/+WjEVBxgb2zeXNQ9hXWWTAtRxBVI0JsSb4A3lXGPzs168K4qA1wCAFKOQGGg2/pARu1zBCDtve/pkJ/SXvbXy5ZvDQMS0rKNMTPllDCvDUoiP0f4KE3cIvg14XXaWl1l8uv/+HHM/KHvu4Of231t/094n43sDNdBcZBEDb5MO199XQZRsqGGvbhUdfCc4PdU+dA+s2H9tA7lnK2Pv0ai1F9EBQGio50yjCquoqKf/XXXnwYC2Aw4zg0LWn4Uyay0HyUnz690iRmo5nT9/RNVmyAT94QQz9RuS+waFl5Z0gYHrCvVbf1SUXNEFYYKTBAAzhGEQrRJovUODME0N93gYvFqlowGjqvnGcybIWtaLF9IxywIdBpxZjEEZoAs+5SKVr+NA5cAWaAtds0/bVAkYhjQjlGmyXZBzs1ei9cnyAUzDnpCR3YO+8faOB7aubchpdhkvAwPhUV6QZHJHYl6Y+T/JQP76iQBCQ1I3gqiLy4m7NJoo76i2yZB58oUG3wsLIkc
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39830400003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(26005)(41300700001)(55016003)(41320700001)(6916009)(38070700009)(508600001)(64756008)(40180700001)(40160700002)(9686003)(71200400001)(54906003)(7696005)(38100700002)(122000001)(8676002)(66446008)(5660300002)(76116006)(86362001)(66476007)(4326008)(8936002)(66946007)(2906002)(66556008)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?oR0Io1aye8+Y/7JfptN6c3Ly0MVEhmYmqAbyS0GcKUrBWu9BNKjnR9LFxCQv?=
 =?us-ascii?Q?zw+0DjMwpNZsIz0xKmHX6HAKDzjmZ9b3xB3o2cZic+aqrLMInQcXs41ZsonF?=
 =?us-ascii?Q?41jDLbXwOd6DgeZMhObEw4r1lCPkWkdoms5QE0V7OdqFGgGWcg1zOkJmH+6O?=
 =?us-ascii?Q?RIV2F5p7d9+gR9xfQZgQsa1JubIZfTYxYUzKFiVgq16u6iSRegjBHIk5s4JL?=
 =?us-ascii?Q?gAYTtWDVthUfUKN2X4c/86IXPgnq4MkFWT0Y144pA1IOu6zuv4F8Zq3sCHFy?=
 =?us-ascii?Q?DdttP0RAOytA1F5l1LdOx9hefth0c9u5VwJDLRLWGCs66qZJrbnc9Qs18WwS?=
 =?us-ascii?Q?+/1bTKL61kfWPGPDpKHg/t+WgkZx9AQ2Z+Eu1Y++ZX07dv+QZPagaR6mgt9B?=
 =?us-ascii?Q?l56OmDnYupa4e69fSzKgQBiUTdBvkXQEcC9GAR1d4J8ked8QPFIoBSb4rhJU?=
 =?us-ascii?Q?Vs4nnQokG1VVnpwWB0FhYazqZzgU22erJqYI8uQRjDLHzCLPH+tmJEegAdC/?=
 =?us-ascii?Q?C4WPdi00EY5ZaIGbF2DIA2hio9mqYZ2qiA12IEGYO7f/+f4sxLPVhReNXHDY?=
 =?us-ascii?Q?iMElVScnskdkSAmyc6uB+XoT/HipijqPBS6VoNM4iqj+IfppsXyZ0l7bpQ/V?=
 =?us-ascii?Q?pJDmU6NzfpAy6vuP0GHKDrxwyHN0r7k+rPSNCmdmwvB1ogEBU8LytbX7LqSc?=
 =?us-ascii?Q?2nEsui+IgGcNF8suFHJfxF/fLGBt/fDJX7D33kQq7UPRFhBXrewx8zlbXTIV?=
 =?us-ascii?Q?Zv086C2lqh1F+jMct0x7HKwFEWlrfbrITvpu1gi4xAHf4ehoWtNq9QF6Vq33?=
 =?us-ascii?Q?t6rTqr9JOxlTzzC54ZHvKKCKOS7pWcROBzeMuDhEd0TCW3XKne7bW5QIR8Qp?=
 =?us-ascii?Q?Mk5ZJfwdzXyWSa2cXsIatp/4fOv/CSCmcL0io8AE2gzwnme1oNXohOEqePcV?=
 =?us-ascii?Q?cqW3dMo0B1koj7KTTmrQcUXZWxGL3U6Wa+Nrfu0AwCpiAqaj/fT2m2YHK/aU?=
 =?us-ascii?Q?FnXpUjlKjEOW1iODsHnGdFIk1rZyBNNu2rRDiF7h3iE/6jxKHAW9M3ixMyo5?=
 =?us-ascii?Q?7S0H2Bx3EXsD4WVdtp3vIQBC7ZWxxnbMTiarinaurQqSHLz7pqgoHOcqa1Dq?=
 =?us-ascii?Q?IxfS/LI6F0eGWp98802injjsUQpPVn5q1QvB4dE+W35R5qDJ8WUSIPVi+IrW?=
 =?us-ascii?Q?WjXDq8XzDqJhBuihBbh3MXtjqPl208WG5fQTQBDYQiDxBVVx0mfgLixQza92?=
 =?us-ascii?Q?zVj1i2Rcjk3z4cyGxWGn/6ujFAomOPTTtGnLqJJ656W22AEmaL38NimyTAVb?=
 =?us-ascii?Q?CSSeT3uoFOl5z+GD/Q5P72kKjYF2wPmdUIK3kYys3x9ce6fWzPYX6X7+du+a?=
 =?us-ascii?Q?920DRa9ciQBkXn5KkyOFPa0e2x1F7yEf2K/YkRohtZ/1UYTS+1LKLQSnLZkI?=
 =?us-ascii?Q?iv9AvrRQVOhe+vzzaiXzVtg9vZdgtvkaRXRTIw/L0CkzsN65bzb4LCxT6+P0?=
 =?us-ascii?Q?NYtzH9rg3Mj6vScn1m5NrHz8QyybSP9g3fVOsZuEy4QFtxx9xmiFStCXg3uS?=
 =?us-ascii?Q?ENnXmvsswmyqwRQ1+ghHD6/dl/Vv1/IwHapNagssLVAiAS2or4Wtty08NWwX?=
 =?us-ascii?Q?Tw=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0670.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 34391265-901b-49f9-adf4-08dc22f0a286
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 06:40:09.3195
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y8ewIx5fbH6UFMFVuBD9rukieTODpVS5dr0ta9rmUvEpBjucaU2+vJ0U9s20+fdauqHiyI4Q4Z0xRifndbA1Ju3yClAPmXjNnEfpmMWGIec=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0880

> > Currently, the object files defining new algo register/unregister funct=
ions
> weren't included in Makefile for unsupported device.
> > Compiler will still check for these definitions if IS_ENABLED is used i=
nstead of
> ifdef causing build errors.
>=20
> Please point me to specific examples of something that's included in the
> output and shouldn't be.
>=20

When compiling both CRYPTO_DEV_JH7110 and CRYPTO_DEV_JH8100 as module,=20
the compiler flags the following functions as undefined even though they ar=
e folded in IS_REACHABLE

#if IS_REACHABLE(CONFIG_CRYPTO_DEV_JH8100)
int starfive_sm3_register_algs(void);
void starfive_sm3_unregister_algs(void);
int starfive_sm4_register_algs(void);
void starfive_sm4_unregister_algs(void);
void starfive_sm3_done_task(unsigned long param);
#endif

ERROR: modpost: "starfive_sm3_done_task" [drivers/crypto/starfive/jh7110-cr=
ypto.ko] undefined!
ERROR: modpost: "starfive_sm4_register_algs" [drivers/crypto/starfive/jh711=
0-crypto.ko] undefined!
ERROR: modpost: "starfive_sm3_unregister_algs" [drivers/crypto/starfive/jh7=
110-crypto.ko] undefined!
ERROR: modpost: "starfive_sm3_register_algs" [drivers/crypto/starfive/jh711=
0-crypto.ko] undefined!
ERROR: modpost: "starfive_sm4_unregister_algs" [drivers/crypto/starfive/jh7=
110-crypto.ko] undefined!

The object files defining these functions aren't included for CRYPTO_DEV_JH=
7110 in the Makefile.
obj-$(CONFIG_CRYPTO_DEV_JH7110) +=3D jh7110-crypto.o
jh7110-crypto-objs :=3D jh7110-cryp.o jh7110-hash.o jh7110-rsa.o jh7110-aes=
o

obj-$(CONFIG_CRYPTO_DEV_JH8100) +=3D jh8100-crypto.o
jh8100-crypto-objs :=3D jh7110-cryp.o jh7110-hash.o jh7110-rsa.o jh7110-aes=
o jh8100-sm3.o jh8100-sm4.o

Thanks,
Jia Jie

