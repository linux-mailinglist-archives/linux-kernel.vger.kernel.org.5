Return-Path: <linux-kernel+bounces-44080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D87841D16
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 08:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2FD52852F3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 07:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5EE5467B;
	Tue, 30 Jan 2024 07:58:06 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2049.outbound.protection.partner.outlook.cn [139.219.146.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D0453E29
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 07:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706601485; cv=fail; b=qK9OP8a0pQAJ0QXQRorrA+LOXeGZ0327LL1jKRllFdNjXJxiVTRA3EEfgbuBZD6/DdUnbIrgi9XVCwKBOxP6GEcUj0ih02dj+bgah6WGJnIMrLq3WozH9ETNWGAwGr/qgC1g1MlEmoZEBrGLt9KUcTttjcOC8HrRlxwPLio9sBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706601485; c=relaxed/simple;
	bh=5syT/BxWaIKSWAPNdF6o4qcB98rXqgoqLqOFhfZ7qso=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LOaoh34KdfCbcQdu3HTLTdBWxr5/lFxyYYpmqaMjTFKIzMDk1CA3ZVh/bi5Gtq4RkTxb/TMvVhcWaBjqu7grPdWkiYXQ81NPcKGhoaWpduf3RssjgVzvWVC6oNDNP32HLbjeuqTVJZvl5ANfGoE/KYlf5bE56iN0tZ0KpROijhI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BbYw+kQ5GE0q+WeuQCd33+JAeeirzXiNKCgRin3FoNJ4cM1Y6C2riQZZ48V3ypEN5i3PTkvqT+nZxxgoxMc1GxvRVAoHPv8k+mtq1vjKZAqzG+5ir4LYOvpg40uf5kaUHotY03S4xTdBY1eXRNn56nLQQ5VnM/avCJIfOyyHrhtR+XZ4EQ6OPmT0ut0H3K18J3kT3ZRry/4yz4qrC0HC+02Ilq8BruqOUXRHlwhrxQfLhZxtSSWeBExd2dtPGLQ3LsKCAJmkrpfsT+vSaGOCl3uQ6mSxN9HtRmv6JU5vTx2uzZ+sP2XOUt7cZOsbCaVrm8MFPRD8Ky4hrnfsncGApg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Pez1c1lUwBjJAz+4SfGUDfVzmHiQof580/knX/FjMk=;
 b=co0xvAIPxGkSrCmCkvh7lLqawMAsiQ6MxPfK5vMmoeVylAL7qpMvswQ23Cy+gkgh8P9ODCNZUpma6H9eBTd+dZeyZCTH5FfQgS9v5EUnw3vFtwYUpLXPgEk4na2wT81bPvEIJl4c97EaPGaAVDZMHVl1BrZ0355l3IVUGWdCIw9z09Bo3LZRyADYx5zb2eRxr3Y4J2kBTaiaMFip1aVU2X27ozUj8dgAd9GE1ZpQjQSvHb8j2Bn+hFlFGkrXWE28KL7veovtBCfj03Zsy1hW2BP1Ynp844mp8A6NvpLLwXJ70JZ+hd+18iEt7Be25iHohDr+2ICeEboB9sDgHz9WSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0674.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1e::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31; Tue, 30 Jan
 2024 06:24:44 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7228.029; Tue, 30 Jan 2024 06:24:44 +0000
From: JeeHeng Sia <jeeheng.sia@starfivetech.com>
To: Conor Dooley <conor@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "palmer@dabbelt.com"
	<palmer@dabbelt.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>, "robh@kernel.org"
	<robh@kernel.org>, "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
	"suagrfillet@gmail.com" <suagrfillet@gmail.com>
Subject: RE: [RFC v1 2/2] riscv: cacheinfo: Refactor populate_cache_leaves()
Thread-Topic: [RFC v1 2/2] riscv: cacheinfo: Refactor populate_cache_leaves()
Thread-Index: AQHaUok0xUbmLQ6q7k2OZq+prRHjuLDwuPSAgAEXBNA=
Date: Tue, 30 Jan 2024 06:24:44 +0000
Message-ID:
 <BJSPR01MB05611B1A4DDB1F73FD9E0A829C7DA@BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn>
References: <20240129075957.116033-1-jeeheng.sia@starfivetech.com>
 <20240129075957.116033-3-jeeheng.sia@starfivetech.com>
 <20240129-parrot-dropout-c4ece33a98da@spud>
In-Reply-To: <20240129-parrot-dropout-c4ece33a98da@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJSPR01MB0561:EE_|BJSPR01MB0674:EE_
x-ms-office365-filtering-correlation-id: 94bd6c0d-e34c-4e65-eb3b-08dc215c267b
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jPXXUJn3+uQHd/FQWgCmcy8TCoSeuQ3lGIbZaIUnize5WS1ocywjdWcmu5kBDor20+u5P8kvHo7prU4O9VAgVHNTj0glCb38fZqFQF8kqiiqGPigYN5V89FLtwoZswV4soIYttyYAhbzEFZxT3kYIHOxtGiy25cgfQV+z6TeAaWaExHUmh5s+HbSdJZw+rPDFi+ILf/wjV/JFlYELHGfBXLsUcegCPpRlIpqCJ4Ndo+21ASAq61+e2EVSa7G3uehrEgikPN7a5SXSNKVKtcYCjCq8co7Fkx6jTs33AzeqiO0k1O42FQ2JFFy65nu94hsaT1TQwB0EuSdAcao/WYIBt+AWYqBdji7m0WciD6GJD1p2gazs2yDhZC3vtkTKVoaWzJjOLse81Q49XALAD9QQapZ5EM8P3pbD+524QYsGKdt/zozSUb0fNLBKeyf6mq3L97e5Np+X03Cflurd46Yn2lugK9k3xK3/+q2wZ4nhZOdpK2+wcjqCfpsdKkDDZ3xP+XbzA5peI+XEWVwWjsqM82pNGVLxVgYe/V/Nraag7OWi9XRgCeAnn9Gd/FcMYiU
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39830400003)(396003)(136003)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(41320700001)(55016003)(7696005)(71200400001)(966005)(83380400001)(9686003)(53546011)(26005)(33656002)(40180700001)(38100700002)(122000001)(86362001)(40160700002)(38070700009)(2906002)(41300700001)(5660300002)(508600001)(7416002)(8676002)(66446008)(66946007)(6916009)(66556008)(64756008)(4326008)(66476007)(76116006)(54906003)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Kb8Zk6ie4sr7lcY+KFgdU5Xhzt9Hk/yTCJRdLjuSW4s4/CeYFn+f1JdNTkn1?=
 =?us-ascii?Q?Bb58jtpGpDyI6FlRo83iQWWD7iRURpxzeeOgENTYffEFpXRSvdI1dCSiZop2?=
 =?us-ascii?Q?H8kPMZhYbCPT7eJDC5he6Xcag/cYuHROseWTWy8vYRQqKTpBWGUGCSIuay7O?=
 =?us-ascii?Q?gkymNJp72XJ64TY40GCSLMbml+u/0T6UqhSXFTmNVLEVuejuiXvtJXN2Ju+Z?=
 =?us-ascii?Q?FpjEndeB5fbVM1ZaHE32hHXU9VRR4+x9Vb2QI7d84wl8Qn+oQnc4PH4gVQ0w?=
 =?us-ascii?Q?TN6pSdMwPDz8wZ0stVzz7b/jp5h8ayWoMR61KWmx5jkgxUcfoT6O6u/TvVFm?=
 =?us-ascii?Q?Yp0WG2QtO5mb7wwvmojzPcexc0iHVIHcUdVRlAQ1Q+xDXFK1oQofVgmUpsMw?=
 =?us-ascii?Q?LAc/F/MAYl6nh7clcI4mXH4hbzDAqy2VTBr2p6j4xJtCv1CI3vnadyQ5/PKH?=
 =?us-ascii?Q?JAufN9RUgur83ea2LsJTsnDOvtlSweUXzl7Ntc61wStB4bn9GdQJbkpS6X5r?=
 =?us-ascii?Q?HpD7z1XVwOvG6I/kpPHEgu1lK0LbE81bBE946iOyYDviHMv15XaEKLlxCtLe?=
 =?us-ascii?Q?ukJ4nS4r8PYRw8S02Cd9OvUH8z0hhWsY3Yjyi6ZSil42dVP4bFR45nNqR6Zj?=
 =?us-ascii?Q?6xUgDvKe2APpzgPw6w1ucE/oMpTIfVqqmFbcIjz4M9QjSk1mtHOOxDJdLzTl?=
 =?us-ascii?Q?5tV16BGKs377j2pegSBT3AsKtk1TSiB7CmM4J0sBJ1DtfNTzfXduCuYC5DBV?=
 =?us-ascii?Q?5/8aUUfCnKtBs/b34xNUGG2jstJonCLkvLz4FOQWxW9JjCvJ/wVWCcoqb97Y?=
 =?us-ascii?Q?2DGyO2qPoLxA9k7YCoKhgQ0mcDezzHCbzgTtfbE6wWUO0/wcGk3i6pJGle4C?=
 =?us-ascii?Q?9WeODKbnziaaeBfyyPqROXRLRO1k0T1sy3qsag/4Ov0NHFYAY3euK/dMwqEJ?=
 =?us-ascii?Q?ttmxN/zKrQGvnPeCh+DSYYhTg5sdWsXG2DBSL78S2D5BMd2nIxiTmoByBCQ2?=
 =?us-ascii?Q?qU8xiyrQM/YHB9WPBeNcLxZQ5n8rlnjK5mbooRaNHtjBcAp7clxm2Cx3++Ob?=
 =?us-ascii?Q?+0tXNnOSlqJ5P9NqvWO/n5cK7KOW9YKp8Q9MiUfkoir8RZTf+GYjJfSYxqi9?=
 =?us-ascii?Q?wl4hHJjfZWKIWyKuR+uJRV1G69bPUOrlI/7XDMNc4NcIfM5WY+qDq3PfyyMs?=
 =?us-ascii?Q?MkJVBYxpU9ywzdPAX0wIUT+sIdu0jaRBl6x5kKxjC9zMcVCn/tie0EzBo5hh?=
 =?us-ascii?Q?TgYJvnaMnXZ0t97NKLY+N5TnJPpXPtIyzealNCkzqc1Y+unkCF/I4r0u8H0L?=
 =?us-ascii?Q?whi8xaSY+/YNCC9LwqTo8SkQmRdijoAUSxHtmwqLqmhCK0cmhatk6XMI6/9x?=
 =?us-ascii?Q?SXYU/LjMfoK6udOtqMcw2yFnrlnZ8wk2/xJGzNxzgmyf7cHfOaLkravnbSKF?=
 =?us-ascii?Q?2HQkk8wS+pA7F0Oi6GQCpZvCcB9++TgvqMijdIIsniN+SkcaQsi1COv9n63t?=
 =?us-ascii?Q?WLyCBroWcM1WBZ1qqcrU1dzqOlA6W58n/FC1dnUD1EgHn1J2fATY97KBgI2q?=
 =?us-ascii?Q?Hursd3/GidCISvIXuFJQJQaoBAIPWGebsQ5xiCSzZC7y7HApWyWrzZi9KGbq?=
 =?us-ascii?Q?sg=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 94bd6c0d-e34c-4e65-eb3b-08dc215c267b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 06:24:44.5543
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1kfmMXwoicdn4XDAdzvuTWvsA2uX+R8d3+Rg+i0nqWyYVA37XY6TEPTHCc201pRg+l4eFW3Y5iGujZVe+CyGrKqN2yzWkrzPaF2pSDvID1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0674



> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Monday, January 29, 2024 8:31 PM
> To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> Cc: linux-kernel@vger.kernel.org; linux-riscv@lists.infradead.org; paul.w=
almsley@sifive.com; palmer@dabbelt.com;
> aou@eecs.berkeley.edu; sudeep.holla@arm.com; robh@kernel.org; conor.doole=
y@microchip.com; suagrfillet@gmail.com
> Subject: Re: [RFC v1 2/2] riscv: cacheinfo: Refactor populate_cache_leave=
s()
>=20
> Hey,
>=20
> Firstly, the $subject should really mention that the motivation for the
> refactoring is ACPI support.
Noted. In fact, the main motivation is to support both DT and ACPI.
>=20
> On Sun, Jan 28, 2024 at 11:59:57PM -0800, Sia Jee Heng wrote:
> > Refactoring the cache population function to support both DT and
> > ACPI-based platforms.
> >
> > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> > ---
> >  arch/riscv/kernel/cacheinfo.c | 47 ++++++++++++++---------------------
> >  1 file changed, 19 insertions(+), 28 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinf=
o.c
> > index 30a6878287ad..f10e26fb75b6 100644
> > --- a/arch/riscv/kernel/cacheinfo.c
> > +++ b/arch/riscv/kernel/cacheinfo.c
> > @@ -74,36 +74,27 @@ int populate_cache_leaves(unsigned int cpu)
> >  {
> >  	struct cpu_cacheinfo *this_cpu_ci =3D get_cpu_cacheinfo(cpu);
> >  	struct cacheinfo *this_leaf =3D this_cpu_ci->info_list;
> > -	struct device_node *np =3D of_cpu_device_node_get(cpu);
> > -	struct device_node *prev =3D NULL;
> > -	int levels =3D 1, level =3D 1;
> > -
> > -	if (of_property_read_bool(np, "cache-size"))
> > -		ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
> > -	if (of_property_read_bool(np, "i-cache-size"))
> > -		ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
> > -	if (of_property_read_bool(np, "d-cache-size"))
> > -		ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
> > -
> > -	prev =3D np;
> > -	while ((np =3D of_find_next_cache_node(np))) {
> > -		of_node_put(prev);
> > -		prev =3D np;
> > -		if (!of_device_is_compatible(np, "cache"))
> > -			break;
> > -		if (of_property_read_u32(np, "cache-level", &level))
> > -			break;
> > -		if (level <=3D levels)
> > -			break;
> > -		if (of_property_read_bool(np, "cache-size"))
> > -			ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
> > -		if (of_property_read_bool(np, "i-cache-size"))
> > -			ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
> > -		if (of_property_read_bool(np, "d-cache-size"))
> > +	unsigned int level, idx;
> > +
> > +	for (idx =3D 0, level =3D 1; level <=3D this_cpu_ci->num_levels &&
> > +	     idx < this_cpu_ci->num_leaves; idx++, level++) {
> > +		/*
> > +		 * Since the RISC-V architecture doesn't provide any register for de=
tecting the
> > +		 * Cache Level and Cache type, this assumes that:
> > +		 * - There cannot be any split caches (data/instruction) above a uni=
fied cache.
> > +		 * - Data/instruction caches come in pairs.
> > +		 * - Significant work is required elsewhere to fully support data/in=
struction-only
> > +		 *   type caches.
> > +		 * - The above assumptions are based on conventional system design a=
nd known
> > +		 *   examples.
>=20
> I don't think this comment matches what you are doing.
>=20
> For example, the comment only requires that split caches cannot be above
> unified ones, but the code will always make a level 1 cache be split and
> higher level caches unified.
>=20
> The place you took the comment about the split caches from does not
> enforce the type of cache layout that you do where the 1st level is
> always split and anything else is unified.
Correct, I meant to say 1st level is always split and anything else is unif=
ied.
But, do we agree with the statement?
>=20
> populate_cache_leaves() only gets called in a fallback path when the
> information has not already been configured by other means (and as you
> probably noticed on things like arm64 it uses some other means to fill
> in the data).
>=20
> Is there a reason why we would not just return -ENOENT for ACPI systems
I don't think that we should return -ENOENT otherwise the cacheinfo
framework would failed.
> if this has not been populated earlier in boot and leave the DT code
> here alone?
This function is shared by both ACPI and DT.
>=20
> Thanks,
> Conor.
>=20
> > +		 */
> > +		if (level =3D=3D 1) {
> >  			ci_leaf_init(this_leaf++, CACHE_TYPE_DATA, level);
> > -		levels =3D level;
> > +			ci_leaf_init(this_leaf++, CACHE_TYPE_INST, level);
> > +		} else {
> > +			ci_leaf_init(this_leaf++, CACHE_TYPE_UNIFIED, level);
> > +		}
> >  	}
> > -	of_node_put(np);
> >
> >  	return 0;
> >  }
> > --
> > 2.34.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

