Return-Path: <linux-kernel+bounces-22808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 769FF82A32C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:17:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3F3A1F239AA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B37E4F5F8;
	Wed, 10 Jan 2024 21:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="m1j82+jb";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Apx2R6UA"
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09304F5E9;
	Wed, 10 Jan 2024 21:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1704921461; x=1736457461;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=b3/x+NVwIv4zyU9+V7EOtGVmS1MiBfeSBIDXCUFJYNY=;
  b=m1j82+jbetBVZl4ecUBcYjPUnuPEJ8ZpVlE+6f7WqHSPplUNe1BrE0ek
   UF/dbSWQhvpcZs6DcqKFEQZr9kzESltm/PpLdY5TCqljKs/rIpn6ZFNIL
   H2OLD9nmpyoc5ZCH/n11Rg2rpWa0PfbFPWQWLLi1HaXlXD9nEg0aLKgm0
   4WeAP+YFJ9JKseK2K9P6GWjDJRMQQuaPaxwsZyIivtNsIHV8KPo57vmYj
   7tSmprMPoPWPG300eYg2lKOP6sxwj49KPwnUqaoQBpMNY2d/wJtI00ihY
   Sul6gmMF+a805YHGMFUuFVfpd8KTLKaYR6+gTEAqk6Z+ZfRr175XVrBGk
   w==;
X-CSE-ConnectionGUID: FJl8ZIHhTF+so6h/iXswdQ==
X-CSE-MsgGUID: i9boEqsqS1iE+3bIXWv0RA==
X-IronPort-AV: E=Sophos;i="6.04,184,1695657600"; 
   d="scan'208";a="7068361"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 11 Jan 2024 05:17:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iWqqOp8ca60lTyJy7isrvApIB2rS3hXZWt/sb/qMC2jnkJF08zTD8yxPVzATlgtvXp7DyTzsdBq67sEQEiiXhDvaj1ppH2dSvhJePxFG8TxGpBRxA2aSYY4eCc4kee17JcVsZr41yGjPA6iTd5cgytXJahtBxU/um+lipf/lQjUr3wtWtpgzwp1ECnvgYwRfSWNvaV61+zBzb7iTYrDXz3e7lwzp074jkC7Tu/1ihmybVzmdCHwPsacN4LxnXdmBsjQpKdgrUSuAU7rSUzBza5IsI6lbHzCVqQ6w4CdNEu3hABKDwO5N1KM3W3CdVpl/JR5kYgfc1bd3ivVivDkwsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3/x+NVwIv4zyU9+V7EOtGVmS1MiBfeSBIDXCUFJYNY=;
 b=TUu05vIM3onw5ShQbuFOI1RgY28nQaZwyyAWfwTDnO+0EHS9hpbOEbspuoGHbjUq6h6w4kNx8FL8vrVpblbnWmL/Gmltodadtumyga/GlWfMA81sMTsag/3tLgfxdQyL8a/B6EnrCalpVi8gK6ufcqlI8Tj6I9A3WOqusmGNWuthb4D7xkT0YihpBEllPCWj+LU0yapMd6JPRmAnfIoQ06r0kdiYpKGiEtXoG7FwsjvAlY3hiSw+oVPbijtdmS0WIqCrPn0XD9WnPBgrQGuB6uN8+2K/9pinUNONbdenJ9F6/FoNWVB7lrSMg/lXYnhftJK1YoeXy6TWmSOB1m2ZkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3/x+NVwIv4zyU9+V7EOtGVmS1MiBfeSBIDXCUFJYNY=;
 b=Apx2R6UA9psyo6qiQ8okAERk1tdfio4DQkQvl7hB6TYjvO3OjTsFb1NwoNBiKePbWppq89IN9EcKsEmSvZe0LPCKohR2ani1nwbcXrczoblB3dJnNKCFGqjjPV0xM603AOQG/NDQEfxQTWTft7Wr+B1OhD6DCCVKnmsAasKayBw=
Received: from BL0PR04MB4850.namprd04.prod.outlook.com (2603:10b6:208:5f::14)
 by BN0PR04MB8205.namprd04.prod.outlook.com (2603:10b6:408:15c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 21:17:33 +0000
Received: from BL0PR04MB4850.namprd04.prod.outlook.com
 ([fe80::56e9:30a:5826:79fa]) by BL0PR04MB4850.namprd04.prod.outlook.com
 ([fe80::56e9:30a:5826:79fa%4]) with mapi id 15.20.7181.018; Wed, 10 Jan 2024
 21:17:33 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Rob Landley <rob@landley.net>
CC: Petr Vorel <pvorel@suse.cz>, Tim Bird <tim.bird@sony.com>, Cyril Hrubis
	<chrubis@suse.cz>, Geert Uytterhoeven <geert@linux-m68k.org>,
	"ltp@lists.linux.it" <ltp@lists.linux.it>, Li Wang <liwang@redhat.com>,
	Andrea Cervesato <andrea.cervesato@suse.com>, Greg Ungerer
	<gerg@linux-m68k.org>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap
	<rdunlap@infradead.org>, John Paul Adrian Glaubitz
	<glaubitz@physik.fu-berlin.de>, Christophe Lyon <christophe.lyon@linaro.org>,
	"linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux ARM
	<linux-arm-kernel@lists.infradead.org>, linux-riscv
	<linux-riscv@lists.infradead.org>, Linux-sh list <linux-sh@vger.kernel.org>,
	"automated-testing@lists.yoctoproject.org"
	<automated-testing@lists.yoctoproject.org>, "buildroot@buildroot.org"
	<buildroot@buildroot.org>
Subject: Re: [Automated-testing] Call for nommu LTP maintainer [was: Re:
 [PATCH 00/36] Remove UCLINUX from LTP]
Thread-Topic: [Automated-testing] Call for nommu LTP maintainer [was: Re:
 [PATCH 00/36] Remove UCLINUX from LTP]
Thread-Index: AQHaQhGbMR/7MaUknku9yjrZLvyb+bDPsNGAgAO+XIiAACGIAA==
Date: Wed, 10 Jan 2024 21:17:33 +0000
Message-ID: <ZZ8JbCPd3rq4u7iG@x1-carbon>
References:
 <CAMuHMdX0s0gLRoPtjJmDnSmZ_MNY590dN+JxM1HKAL1g_bjX+w@mail.gmail.com>
 <ZZVOhlGPg5KRyS-F@yuki> <5a1f1ff3-8a61-67cf-59a9-ce498738d912@landley.net>
 <20240105131135.GA1484621@pevik>
 <90c1ddc1-c608-30fc-d5aa-fdf63c90d055@landley.net>
 <20240108090338.GA1552643@pevik> <ZZvJXTshFUYSaMVH@yuki>
 <SA3PR13MB6372498CC6372F8B16237244FD6A2@SA3PR13MB6372.namprd13.prod.outlook.com>
 <20240110141455.GC1698252@pevik>
 <40996ea1-3417-1c2f-ddd2-e6ed45cb6f4b@landley.net>
In-Reply-To: <40996ea1-3417-1c2f-ddd2-e6ed45cb6f4b@landley.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR04MB4850:EE_|BN0PR04MB8205:EE_
x-ms-office365-filtering-correlation-id: 5335a178-577a-4fd1-6f39-08dc12218fbc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 2AGQOBr5hNUb8tiBxtQ5GOq9maAvTLTndTo6bZT9iOc8dokGOH+mkm2WadUmYfC9vCIXqruubLSUIvDJL6nmohm1CIfmTgR0ILnqHYk1S0cYe9fWkjf4jkq/r4xzk7x94uia0LpK/TogjgGnl3/OZ7VuqaFUkxjauxs5axIym4MAHc4MPprkF3isGwZheGQ54YQ97LAD5NgGiy0IcJgaAhjWz/1ETpt2FOx59VyKRoX3Ofxbc2fgOdsYr0Q+DUo9tey9sV8ktY5olOF+K6YPmAHBM1Fk1LE9UiGrjmbT4gHwPCzt41uF2/bCv0CinY0Qek5TtIPl9ro0dpbjCHfj99taeKAIEAvOmibhdTsKgTo9ltI0+s1SqCRH8IIwW/fXB+8nbOm/r7d8DG9H/J1bdev8A87tuBf9fQhT5vwn/yojMBWARKYSx3OCA3JSGqLJxGR9ktdM/lfWLLkKmTNaW/dCT7gMdoDTPSTINkLIjeZIgYlvK9c5IQ0OFkmOqHw68SvxqHxU8Gts4rLWav5S3UNr4lt7Vg312FvFB6ng81Hm1WGffDT7vu/HD6p7yYJn9wmtxX61BfQcGIAt4T138cvkJx47L2ArmVXjWDhU3FzYdlvl2Sh09P7NUGy+gWDW
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB4850.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(39860400002)(136003)(366004)(346002)(376002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(7416002)(5660300002)(4744005)(8936002)(8676002)(38070700009)(4326008)(2906002)(41300700001)(33716001)(478600001)(38100700002)(122000001)(26005)(76116006)(71200400001)(6512007)(9686003)(91956017)(66946007)(66556008)(6916009)(66446008)(66476007)(6506007)(316002)(54906003)(64756008)(86362001)(6486002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?E28fibFmwXdzfjbvsy3NJ70Ss2vpnTk7fX7fdEvcjNQCO8rtnwxN7uhKwxIi?=
 =?us-ascii?Q?Tyus+PcGD33hKuQ0wjvGMKGht0riS693mz/SdJheYma83Z+A7w2EGmvTZXpc?=
 =?us-ascii?Q?N4QzAZWrdy0pcXsdjpGPBmQvTbrXD4QXbDSGDgnteZyLLG6y4vOUJw0SjvCC?=
 =?us-ascii?Q?x2OafVEBr04vMLUDW1MtKBgG6UPJqb4HNzCXEeUH/DUTE7pes5eRGXhmbYoj?=
 =?us-ascii?Q?KnpGGmAhXjb4V3itYCN5tDQhpmR9TvRmyNRPc61nZRaurPEhleeZPmDy5t3/?=
 =?us-ascii?Q?RZQfZOaumSqWw9eJ0FIPVW/v6JQ6fDq82R8qYW20cJAgBRixnwW7PBaF9bQK?=
 =?us-ascii?Q?ZGCCi4RxBLGwK1w2D8Dd2anAgpYI4tStnNP3el6i5mXxqHA5rFC6eua/dwBg?=
 =?us-ascii?Q?lLkcxxIFiBf3N4M6jefswyh0AAGYrA47OYq1wWEvkrLrqBtmpLHPiBUwrO3B?=
 =?us-ascii?Q?oBFE1bH0ij0JVXaBDEtNsMjHKuvFnEqX8oPN8bU4zHIPJAeOSP3Y8i+meaVa?=
 =?us-ascii?Q?FAIcIwdhMDWnwrSC9ipRzhZPOL4UG3egeo7XumTAf/2HcNz+7p5w9TrZocak?=
 =?us-ascii?Q?EbDQRzBRPsbLZrnO464ngQlHuTeAWn7AV+gho5wmuoYLNNehtV4hWoMx0aE1?=
 =?us-ascii?Q?6w5E3USoAAD4PBX6SrG5dZGo+dqk4T9As3qJwZ59nRwVm2g312OXdZ7YDj54?=
 =?us-ascii?Q?jlk9Y8KapQ7SIIlBJBao9N4Yi0U2vpz1wpLqXLUiVwFgf56pOQRYa+L4vIBK?=
 =?us-ascii?Q?iTwu4z8yCARkkhSiGcOwx2D2z9N+hcOvMCfGVBjl6oA3iDWs85keNZbXyF5e?=
 =?us-ascii?Q?3UGaR4ulIxggbGoUFMqVLS0EzcAQ3gZoayx9x5P5bZyZ888PMliscUhWxgyn?=
 =?us-ascii?Q?H8ygWqr2yGF1HL50OzY+3Rb5HjNto3ZMbziXnnPRvoMnu0hdy3WVWgTDrEFf?=
 =?us-ascii?Q?0x3LE66sLM1IETWArasxMnSWYBY0Oaq/uEGrKmUk5Iiwu+UwoboF95OUatZc?=
 =?us-ascii?Q?Aik//akhIZ0TaQpvadVZCw4x6jy56R7fTSFozlKwq7Qq2ulJmXLM7N0Enzcy?=
 =?us-ascii?Q?pQgkmI+rhgHAuZeJ6Ye/3Q9U2ldqrhD68ZB3ks48ep+IcuQeeNkeE8/Ur2mf?=
 =?us-ascii?Q?BWJayDkqArQ679iVuQ9yr/305s/kzW7dFPlbfIUATzNvMgX7YWY5sbzgiQR+?=
 =?us-ascii?Q?HISMBMRGHgRnVV94pFq58K/VD7o3m2yZIaugz7PiTAXtGTI45rFi8ukq6g2V?=
 =?us-ascii?Q?Bge2YKMN9eeS55c71eQBmPV91LgCNr4eP2AvHWFPyL34eoBkl/UX7CPEfdHG?=
 =?us-ascii?Q?lz0HaWe3P0SBC9YENzcCPomHmHgMlY8QN53+9+RF4udFRV/L+ZArTvPUzbz6?=
 =?us-ascii?Q?HHOiFdJyulIWV3F6Ff3wJPyAQ+3Awr7ATeI98qoNu7U81GfckMu3tnj48Ht0?=
 =?us-ascii?Q?TZtk2SzG8FhdVfF/1gmDtf15v1/Hh8t/Lp0KEyN1cX3DchLnrXIcZBey2EQ9?=
 =?us-ascii?Q?ASi4oQ3kO0JRYaaxhjhyk+TvyAAOZe+uTg70XonMgGnQmNenkrF31xHQv1jW?=
 =?us-ascii?Q?BEav9VRJkojbDe3XHHSUpPHCB6ZCkcU6NWxJ4k5Yp4ytsfM17Ll1tU/ni2cO?=
 =?us-ascii?Q?pA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D0EE684CEEEBCB4F9B30529F4622F2BC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KxJ6n7KptPQC0IsWWxLkAi5SKHDASz8X4e2/XRkPKViPutqtSzW+6HTW4wirjNJnYvmjwdx2XP5oejDJAFahISxlwOHT6EzqKu8TZY1uEc0EMl/54cWBu//GmML1edA0tOZlByb3+zJlXG2DQs59paddfSHsHQf8lAVSFZ0EkxiOBe2bvtA/jepi7bzd6WLyuRyY8PMjvHU0IMqVwOy7f8WBvT/xw4ImOoZHOl7CaoBfDUEhLTYzli/0UTu2O/Lu4Ed94PoKdGAK5VJ8c5SYReFieeZMZHHUlWjYq4oCKOwR6Z9vdqIWLqvYkEY4WNZmK+kQTn1o7nvH4TcL/HviUapOck6ad2Yn61YXOdtnTuBBIxcyEAbH0djms7bcyz/+N7xuZFuEASkWVW/GYETXsg1tidcSh66po/XiB3Qb42vj9bNwI0zPr8QedL80/pTdM/y9iZ+vzGgxr+2m3WIX4bo85QBxyiLX3I5EYed1jgOMzOhOKoX1mpG9jkwrNXzfvnc3c8x5ItpK2Li3kmnJxauiDYtUtYrpBnd+7ELTAgIZ55BnOPo2jJrRo3e2lpyYEEKIEMZVZx82pQC7aiCfpH87c8TxxxklV+7go5EGIs2h2fztUWXRkfjWXHM+QGHc
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB4850.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5335a178-577a-4fd1-6f39-08dc12218fbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 21:17:33.3934
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RCiK2NIFFVcpTKzw/4XxnJbcNdCPegZHqth4w6rgSbiPQTvBBtfJvZySDNcvEJmLSnXl0wrYZvSJseQh723M/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR04MB8205

On Wed, Jan 10, 2024 at 01:23:51PM -0600, Rob Landley wrote:
> UCLINUX is a long-dead distro. Linaro died in the dot-com crash and its f=
ounder
> Jeff Dionne moved to Japan for his next gig and never came back. On the w=
ay out
> he handed uclinux off to someone else, who didn't do a lot of work mainta=
ining
> it. Most of the actual support went "upstream" into various packages (lin=
ux and
> busybox and gcc and so on) before the handoff, so you didn't NEED uclinux=
 anymore.

s/Linaro/Lineo/


Kind regards,
Niklas=

