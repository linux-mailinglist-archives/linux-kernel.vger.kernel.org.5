Return-Path: <linux-kernel+bounces-104120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7ACB87C93A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 08:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47B14B22AB3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 07:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61E91429A;
	Fri, 15 Mar 2024 07:31:54 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2105.outbound.protection.partner.outlook.cn [139.219.146.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D54F12E71;
	Fri, 15 Mar 2024 07:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710487914; cv=fail; b=ZDUhAlzoN4InKKCNVPQWzkm2khDjTBcYQrjcKRQIacMBj8fUcevfKzxEbn/4Rw6D660wnIsXD78UWDzIG2GbSXb5MGG/lKm75rlkvbEYXT0diTQ+cnCpjAP0KGXUXMR2UK3+uRMWJveD8rzhkuQRkp3JdYvXPSbQZaMlA06ANkw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710487914; c=relaxed/simple;
	bh=nf8RYDzVAU9BiPSRohWg9KQHumZyeZiiz3lwiPFezRY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U1yTe3lupDBgyNoi7PHlcgrRyAOQZJ0mqkDR1lxZ3YN5J9QFbCaL/W4ugG7avZHUEXGxA0Ty7SKaCCfH6aori2i24KrH6I2GIlbWz1eGaPMfEFnOZ/r3WnGFoW37tO2/03+RSKP6AVc+XxKHC1Rf4MzBLlxYYHMVn1ltBO835Y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zk092j5g7AAEoCqsOlcHUSxbILE5adIhGs5pmx7/fm4LfuQxox/aEFaJA2Za2zTnsyxbowgHBmmjepxMmdB1JXPOSQeTHw2pSUMgqRpyRUOOqRtO0rccDV0GX0B6KEkzbZEvPSbCW4JxEatyAGjzi1yhFBcOExLZNpK04T0Mh3cXn5s+0nfo5r/623eQv07OafXm/KaexTgR9J79+RW0bqLTBmNpfgQ/CH2bUDDLXdxrX8JQjg+KJYB2ClKd2NB5mbBi0k7sk6zciGxAF9A+EkqomnsELicvYk7+ncBSMK9AvTf017ReyOO4CPT1tHGbTJ+rTTigVcsnvMwi8dCLLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bU/PzgpUP4raVzJcbD3oFqIhGDWiwMkh6SAJnqbJaZU=;
 b=K19TkpYligKxZmaGadzIs0DmRzc5uw9at9KKlYQBd4c6jU8WEjrR616TIDjNtWMtNZ3OPSMHUFNi56jLS50acfMirzSiTBsOUSJ0vnnRZq1+t+yJkB+5uePmjyVw+6I/OqEgjlK6kUupy9XPIPfLoRL9br/PRLSVcj+YuHSpnIJu28DpJqdIm35EQpEuPjS7kG127Eh1cZ1fsJdpV9zdVThR90QHT6+hqrxSt6tsrE3bpy/UqMMgi3n3Gf2LuPTWmZpbNc1q3V/H8AsLyIr4dcyl/MCyIhJRyDD//4ZyLa9jQoOtKbCL9yx44jkSCgZMF4X4RIIBpDUaFF8ypr6KDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0756.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1f::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.22; Fri, 15 Mar
 2024 04:55:57 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::fcfa:931b:8b1d:6af5]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::fcfa:931b:8b1d:6af5%5])
 with mapi id 15.20.7386.021; Fri, 15 Mar 2024 04:55:57 +0000
From: JeeHeng Sia <jeeheng.sia@starfivetech.com>
To: Samuel Holland <samuel.holland@sifive.com>, Palmer Dabbelt
	<palmer@dabbelt.com>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>
CC: Albert Ou <aou@eecs.berkeley.edu>, Andrew Jones <ajones@ventanamicro.com>,
	Conor Dooley <conor.dooley@microchip.com>, Leyfoon Tan
	<leyfoon.tan@starfivetech.com>, Paul Walmsley <paul.walmsley@sifive.com>,
	Pavel Machek <pavel@ucw.cz>, "Rafael J. Wysocki" <rafael@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: RE: [PATCH] riscv: Do not save the scratch CSR during suspend
Thread-Topic: [PATCH] riscv: Do not save the scratch CSR during suspend
Thread-Index: AQHadLdqgBiYlFfag0upukB5n1Ud1rE4QBkA
Date: Fri, 15 Mar 2024 04:55:57 +0000
Message-ID:
 <BJSPR01MB0561EC63D6654543D1266AD79C28A@BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn>
References: <20240312195641.1830521-1-samuel.holland@sifive.com>
In-Reply-To: <20240312195641.1830521-1-samuel.holland@sifive.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJSPR01MB0561:EE_|BJSPR01MB0756:EE_
x-ms-office365-filtering-correlation-id: 86bf6fad-949b-4c6a-c04e-08dc44ac33f9
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jpWZZDsmpBhUEosZD0GC56PcVTGGdE+nemu5xv1OmvfoXab45xARhIMiBVBlCl8xX6LIJZAavYUWpiU9TDrdnGddbMpK/D8md1aSRa0GuzffAGn5sfsUYW5qBMRE1xQFywCMB7Jsp8VFjnbrbvg91ZL6f3Hr/E6NsE62EHOlP4X5rQyXvwIeSrz0r6ba5Kcb66oA661jrPmoqga3D15phLUMWJ8NpViKxqlCx46A/krJy8SAMOBKxHRWGxFEnkRG2pDw3PMciTxHqUGAflAA5h6UY3r7QLwbIAuhtExLIcBgZJdAER1gLFkI1p1X+Ws+3gd9xbPD3zHRlHcWfIeE4W+be/4rP8B4ARDeEwaNo/NcHuuWIn4WGxEe71fjxJFWYSalbn9TZv4HEu5MFExNqsBtGJt7fWA654pnmp/P0GA/ZWLkV0uadvtXhz5dJrp4a/pmgc0iChZq0QEnmwnqcym4GezqtA0ABbipmNQc6PAfhMR2C3i35UYP3G1FUESxdNVwmdkBHaHC8+gM22XFhftuIc4dJaq9KBRSHca0oJfwk64z1AF33aaw0IZTavc1sAa+D3128uEuTgHST1SN7m6clVK/bxz+urKhpUntBpo6N6Dh5bwqoLVSjgkoiDY7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366007)(41320700004)(1800799015)(7416005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?y3YB8GMdX0G1bqJ1BHrwUtaBPOzSDfaCCIc4ALMoFvvvly6GL2tBqzL3Wxnn?=
 =?us-ascii?Q?JjBQjr1PIqdCF3RXm3H6mc4TsT2A7wwFiF5S3H5zwM61jj0a1ngTU4Dz/8A/?=
 =?us-ascii?Q?Y8apQS1IhEDWUrwx2CiM/6iBk6qfnM6m3LoNE/vNexTQxAEaU7xiFJn/gEAt?=
 =?us-ascii?Q?em3g+Ell3e3fVWnJiq6aPG0GZ3Z6Cph3sjk0Rf34fDnUOHp8DXOgmPopcPhF?=
 =?us-ascii?Q?5jRzqandh8f9a3ygEXgKHdidkGucLVVQRjRffktaOyllN82VmkRSozPoLhqj?=
 =?us-ascii?Q?91xzjOIvGHx7YgcTM1SYOt90upmOHq8cPSxaZxPRFFgObn1QqZJguIx9v5vE?=
 =?us-ascii?Q?mnIeIVH1bLAXtMHYvdouzV6q3GeRbpz9Eq1lhLZAm9eSkMmS8MQLpgJIX/ND?=
 =?us-ascii?Q?3bloDEb/IfJfNsk+0P3dMt2EvSR/4rhbOWLM/H3THPVMX0O+Ti5Ff0SUBbb2?=
 =?us-ascii?Q?gSSKJ/JJ8ctPxEysCR9W6gpOzuigID34GPUhLuVO7i+urwz2bwWbWkwkcIUO?=
 =?us-ascii?Q?fMA5F8mQ3a5QaZfeRMjQG6dMbOEeqFyBgXJlLsrCgni6GC7NUBdsHLKUz970?=
 =?us-ascii?Q?S06Oq8o1inPdWR8LbgaH78NkpeLbanC7LeoTsSymc6qnzPfCt//wEsYYWFC7?=
 =?us-ascii?Q?k88sLF6vSu+2u35S7Cax2jnIq1R5+PY030YsQmppqyjgvy7H6QXXtTxCg5fM?=
 =?us-ascii?Q?fivUm10xIfCFNjvoWpRdWNjfYK3R4fjqWNTWTJql/SJeshMZu3xlKszweb1o?=
 =?us-ascii?Q?bYsS9XqU86VvXWCvGSdLvZAJ1iFXuT987l28GYpAtnrPESxAG55kuFkmIpIX?=
 =?us-ascii?Q?wmyl3Kw3vWpZ8yl9XgQc+jnVAB+pcPEiGEFhmQuEco+8lBWr9O5CawopAmkT?=
 =?us-ascii?Q?gytHtS9vsKNgmv2ncd9dLyJGe/tH/CFUTem2V+lN/qESWeDFvMai6p/4eQJz?=
 =?us-ascii?Q?7KtdSq9aIGUvTTtqJeTeuq0zearkBBY+8FGww0A0MuwGWCo0h14FniZKQRag?=
 =?us-ascii?Q?HTVQiUyfVJJ68sGoBU/XIFRsjTcwNQZpViiFcmM/XyMWFOfAHB/h4eSXbWXk?=
 =?us-ascii?Q?sZVGb3+gR118qGinPxjtfuwqQjnH3w/7RAfx/AyBKc5NUAkx3vWu/C72O4CI?=
 =?us-ascii?Q?uGaCHDvSi1jabGezXWQ/Uhi/rgVKZp0A9xynq40F/wATN16E4ZvmLXr/Qxxn?=
 =?us-ascii?Q?H+ik5dPDwWK8Ustx6neu0mqtjc6aPhLeQ/red14NqsMRfHe8KO3skXMS+RRg?=
 =?us-ascii?Q?Y4YbUvGvLqnlcbJmDSVvVaPgsTt23yjGDFNFGWfulVb6t2LKznSj9OVtOtfI?=
 =?us-ascii?Q?427UbWhr1BORIXGlLSYRo7fDhh3RImHJ6lcPFxMhNRyPsztYQdSlNOKHBu+2?=
 =?us-ascii?Q?wgqPY6NKV2Drf61/JOyyVsNgrwc5NH/OEvUEciy9sjpAK12CCwMEJ5cNdWGY?=
 =?us-ascii?Q?hS4fXkDlv9ExeQQ5bhegsDQ+2sdkjWqwxmrOJ7owzuO9xEvjORkeNwGJUXoG?=
 =?us-ascii?Q?QHiUNO7iqkVBawvAEOhGhM5O8tTDBduO+79b0402hxuNcF5QqXE5jUOnCbCB?=
 =?us-ascii?Q?EoqR5cVet5ABfH5S1k5750qNoWzP9mpXMiyZ3ZGlgLlK9FVP7+IGJS7Zo+2C?=
 =?us-ascii?Q?VsMQvQOlww4YykD8OeWgeqFl/XWHHtc7fPuXxmheRfQhEYad6ynA72qpGBYN?=
 =?us-ascii?Q?QPU0jw=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 86bf6fad-949b-4c6a-c04e-08dc44ac33f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2024 04:55:57.6738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JnEvZnaUIbWLuD0kbmNcOVbqwQplsE05FZh6i2qfxJdm7t14jgXZ6ZaTEnn0fg+VnnKIkYN2Q33B8WmmEC1uXU5Kh9MDdqQdbQnWLDtCWno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0756



> -----Original Message-----
> From: Samuel Holland <samuel.holland@sifive.com>
> Sent: Wednesday, March 13, 2024 3:57 AM
> To: Palmer Dabbelt <palmer@dabbelt.com>; linux-riscv@lists.infradead.org
> Cc: Samuel Holland <samuel.holland@sifive.com>; Albert Ou <aou@eecs.berke=
ley.edu>; Andrew Jones <ajones@ventanamicro.com>;
> Conor Dooley <conor.dooley@microchip.com>; Leyfoon Tan <leyfoon.tan@starf=
ivetech.com>; Paul Walmsley
> <paul.walmsley@sifive.com>; Pavel Machek <pavel@ucw.cz>; Rafael J. Wysock=
i <rafael@kernel.org>; JeeHeng Sia
> <jeeheng.sia@starfivetech.com>; linux-kernel@vger.kernel.org; linux-pm@vg=
er.kernel.org
> Subject: [PATCH] riscv: Do not save the scratch CSR during suspend
>=20
> While the processor is executing kernel code, the value of the scratch
> CSR is always zero, so there is no need to save the value. Continue to
> write the CSR during the resume flow, so we do not rely on firmware to
> initialize it.
>=20
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> ---
>=20
>  arch/riscv/include/asm/suspend.h | 1 -
>  arch/riscv/kernel/suspend.c      | 3 +--
>  2 files changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/su=
spend.h
> index 491296a335d0..6569eefacf38 100644
> --- a/arch/riscv/include/asm/suspend.h
> +++ b/arch/riscv/include/asm/suspend.h
> @@ -13,7 +13,6 @@ struct suspend_context {
>  	/* Saved and restored by low-level functions */
>  	struct pt_regs regs;
>  	/* Saved and restored by high-level functions */
> -	unsigned long scratch;
>  	unsigned long envcfg;
>  	unsigned long tvec;
>  	unsigned long ie;
> diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
> index 299795341e8a..3d306d8a253d 100644
> --- a/arch/riscv/kernel/suspend.c
> +++ b/arch/riscv/kernel/suspend.c
> @@ -14,7 +14,6 @@
>=20
>  void suspend_save_csrs(struct suspend_context *context)
>  {
> -	context->scratch =3D csr_read(CSR_SCRATCH);
>  	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_=
XLINUXENVCFG))
>  		context->envcfg =3D csr_read(CSR_ENVCFG);
>  	context->tvec =3D csr_read(CSR_TVEC);
> @@ -37,7 +36,7 @@ void suspend_save_csrs(struct suspend_context *context)
>=20
>  void suspend_restore_csrs(struct suspend_context *context)
>  {
> -	csr_write(CSR_SCRATCH, context->scratch);
> +	csr_write(CSR_SCRATCH, 0);
If the register is always zero, do we need to explicitly write zero to the =
register during resume?
>  	if (riscv_cpu_has_extension_unlikely(smp_processor_id(), RISCV_ISA_EXT_=
XLINUXENVCFG))
>  		csr_write(CSR_ENVCFG, context->envcfg);
>  	csr_write(CSR_TVEC, context->tvec);
> --
> 2.43.1


