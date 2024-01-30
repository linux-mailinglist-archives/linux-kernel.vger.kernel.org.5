Return-Path: <linux-kernel+bounces-43940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F18CD841B41
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 06:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B1BC1F24BD8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 05:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D810F3771C;
	Tue, 30 Jan 2024 05:09:47 +0000 (UTC)
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2046.outbound.protection.partner.outlook.cn [139.219.146.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE40C376F2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 05:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706591387; cv=fail; b=RtCWNC+yLkckBrVJEUqk8XB4j2TubE/PXaZWiAvaoHa+a2HnkCMUjTnxVi9xfaI1Mt49axaiFRrL3qlQDT/KGjt3IkQvFJRfl4HPUeVJOrcE0foRkfJJs1PO/jNNABCQYQqbtr1giaCgZh3ChvolhbJpF/JVCpJcMoQkex2KL0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706591387; c=relaxed/simple;
	bh=J8Adtm6qYkz1gxVFf7RME346Fpr5ToV9FIp+5yWXGbo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n35Wnmao7YpijSqbLIoPRLBReDUPN2/Buwy7flrTTecHbJ1hIyOBuhSUAAHmKzCpXcLUAXRengt8GNxbOrYDWpHciHxsuUjtExBsWcjxNByCYh2Vs5DWpYtGM4dpthAxU+MCZmK7vjkRH60wX3wgjoSc4jNI1HzNh+87ep+BspU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcyJ1H/MmNrX01oR7cV2pCatJRU8JDWBJp/bRX+Iu6T/8/mg/c5IL0Nr1o4pw8Gwjxic+RD0HumxSedWNPlwf13vy1gmkfmKE8wiDxQvHIodxXzgavGInw720qF1uUXa8/WlKeVe5IKNIfYA3XUWEE04W6j0VitTWCtiaWRZutETFxm3sdvwU8RRECPiIGlLcqyo+KNkmmvnseOBuFbFWYrrlkNkZB5sYuOaZ2wuqolt0slQHfx/xhnOw8DLPFOhVTrNQcrfa50JUf7VFrNBU7lrmGYwo5ikjsRl3BKRLY0NLrSVRlJHdrKcObW6lpg++hlxSZwOKkptCwz513CwCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEPtxa0ROSusAr+5Ulo7JJUMZJ11e3YOqNyD3r7bGUk=;
 b=MwO/Xhjn0jC/MF+Un1PkhC3TmG634tqvIWxH/3FnV7GVczLSYN94Z3YOoWuj0/612YyXyzyD3u7MCWYIpxNrPUSvP4ynXX7AsXHSZUn3CP9EsJBvNmPSDwntL/N3gvywH0K0FrTQG5x+ZJX4itrv5NaaKpqWu6n3N8FIcspyOEM6LHVYBOxDm1RsT2dXuxDK8afVnIGyGfHim+KTcQGnAgQBRdB1MLTqqgUkjsXo97Mpa3+f7SJF5Y+UyZoCMfd6ktlWGwrLFONTy5Ult5E6ukzLZEisCUHaLYeeXQFmS/G7+nbnOUTMhPDpA5vBimacXpcjG3YrPgrSvQwpOJvOOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:f::16) by BJSPR01MB0834.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:1c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.37; Tue, 30 Jan
 2024 05:09:32 +0000
Received: from BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn
 ([fe80::3862:65b4:c857:c4a6]) by
 BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn ([fe80::3862:65b4:c857:c4a6%4])
 with mapi id 15.20.7228.029; Tue, 30 Jan 2024 05:09:32 +0000
From: JeeHeng Sia <jeeheng.sia@starfivetech.com>
To: Conor Dooley <conor@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"paul.walmsley@sifive.com" <paul.walmsley@sifive.com>, "palmer@dabbelt.com"
	<palmer@dabbelt.com>, "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>, "robh@kernel.org"
	<robh@kernel.org>, "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
	"suagrfillet@gmail.com" <suagrfillet@gmail.com>
Subject: RE: [RFC v1 0/2] riscv: Cache Population Code Refactoring for ACPI
 and DT Support
Thread-Topic: [RFC v1 0/2] riscv: Cache Population Code Refactoring for ACPI
 and DT Support
Thread-Index: AQHaUokvDmoQ0eJwi0KkFvpqCqpN+7DwrYAAgAEgxTA=
Date: Tue, 30 Jan 2024 05:09:32 +0000
Message-ID:
 <BJSPR01MB0561CC865A63D6E84DF0CFB69C7DA@BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn>
References: <20240129075957.116033-1-jeeheng.sia@starfivetech.com>
 <20240129-disburse-plug-9f4a37c550f3@spud>
In-Reply-To: <20240129-disburse-plug-9f4a37c550f3@spud>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BJSPR01MB0561:EE_|BJSPR01MB0834:EE_
x-ms-office365-filtering-correlation-id: 44b10dfc-2238-4af4-cff1-08dc2151a555
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4BgjlgEdRt705iKzq3hQxHAMTzljmm9j55rfH3sZ+gmmxuuw0cfeQLs9Bk+h6zC7ID6Fq7+I/NkNwHiTLtZDjXn22WjL6gOUEh8PWExw32Wzyf7ybVHkHck0ncLjz20GXmq+3wFhKKwr8QeHpikhz+lKxvw5Z1pnTrL5xvU9ZoQ6n7lpuUGJBt8Zz6uvyUw72an8Myi5E+M1gkFaMdaafraSzQV9uJcNE7E6OOZ80IhqpShyJMP/3y5jRKNm9PCF3ArVv4jgLMGAGYRebyNqnLr96U8ckaQkkFnidiNboLJIg8K4V44qGnH6uiOP7O05uVI7zEAx6ficMQyoJyVQVuKaK08pzeWE44cIKP6BjKdwiWKcSSs586LcASJJz6dJV4lwWMGgh2U7Vg/X3phds46YI5gQE4gnKi8N8pSlFXR7iy2saGtePg4Z/fJ8vugYmj/5h6z9wQpo7dvdZw9OhdV+u8+os3fI4AGv1Z84NUVCYfK8wDca+TyHDdPBjfy13wU3I0t/AnUDrKapJLX1/aY7mf6qqhwUXnJy1KTONbOjKRIRYtlT7zLlOivDK+z8
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJSPR01MB0561.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39830400003)(366004)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(122000001)(26005)(4326008)(83380400001)(33656002)(40180700001)(8676002)(38100700002)(966005)(508600001)(54906003)(7416002)(66946007)(76116006)(8936002)(64756008)(71200400001)(5660300002)(66556008)(6916009)(55016003)(2906002)(66446008)(66476007)(86362001)(41320700001)(9686003)(40160700002)(41300700001)(7696005)(53546011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?GcqjPLsBOsD0vYTYtI4y9JPd0dWlMYMusFdUCd1+yEbHAJRddgEO28qh4hry?=
 =?us-ascii?Q?esSq6PtOiZEdo1aVMtzj+mpKOpwuibRoQuZQ74kqWDCR1WVrenkWoKDAtKCi?=
 =?us-ascii?Q?ee2l75cJCo5SXXKgINeKMCFJruQ2TqOnb7AisbRHs3FHc+xUeWhfZ36uvgQa?=
 =?us-ascii?Q?/C8HQI894a7TcLggfBUynoKPpdCP/4Jm8TAwkzYUbDLdijhhiil0drpHgyxw?=
 =?us-ascii?Q?5kruNz8AlLZzbDO2AtKQ2ferLa21TvU81iHncH1CMNisgBtEF5IxvX2C/6wD?=
 =?us-ascii?Q?kVWDdGXCEjUTUNlJ3v04c7dfGvRulgA7BYDQbVppAOnSvFEtZzOA9kxSB87R?=
 =?us-ascii?Q?GZq0kQ+IIBOlEdniEi8EKVcWv0qRmKS66CRbR1Z0qiNrMvigtmvYfrOMjd4z?=
 =?us-ascii?Q?KQ9l6oyeHuJcXFrD3nbjhKUXmm9EVNHSRM3FTUu/+nJWMqgG/aVNXyaNfXwO?=
 =?us-ascii?Q?WPqNk+TJ8pQh4N6Tn41kjGxsosM58g+4c0VSRi1T24avNhKbyVh95OqmBhts?=
 =?us-ascii?Q?2hZy9ZbQtnrXfgnEG/FgBwofsR+3lhi+qnQqy/2C8lAHhqIAmirpxBsOyyBv?=
 =?us-ascii?Q?hz1Z9Ei6fpRHggpLcLX0EnUlmPmzWCw8nvr40O741r/xF0mNIJOXFLy9yaA8?=
 =?us-ascii?Q?csIeQ9GUbSmAqb6tUS0/11RB51Kyac5NHztlrhX5REGfIYVszdpdysN5mtE0?=
 =?us-ascii?Q?qXiGTrPRAekUc31k97KohIyRnSqJZXavFNtyp2w5wMezugACJychbi2ydoHk?=
 =?us-ascii?Q?+P5TQoqCKgECt9tubarW2e+fYjkMnAkqTPUE0TBGnz6r9YmQ/qHAFlsoQu8y?=
 =?us-ascii?Q?3Rr9Ff+9ZYS53GZwg328aSCu5paTfkz5AyfAvg0QReFTymdVEsN0KkUbMz8L?=
 =?us-ascii?Q?0auuPsdGnNs9TajRVFSoOU7c++KeYiMj4Von4Y6UEF6zotmrMZEGoStF7iQ1?=
 =?us-ascii?Q?dEsL5QsFNmMnz/cuUT0q1mEFzxng1JTthl0t/krxC1WD2sF88M4ru/tBzB4o?=
 =?us-ascii?Q?shH9cQ+lAbY6C1RxeZeX8cUnfjavyQaoLNpnrOA8sm8pxBATQUzHHjllib/J?=
 =?us-ascii?Q?PJAIxjJfhfQU3M1sideX5rlY/e43OzAr15vn/l+W8O9KUIM9BpbyzNV8KTdV?=
 =?us-ascii?Q?AepzwS287ZSq3DNbiJqmSfnclWOj367VsJPSBZx75Xbq4GaCyHu5LrGzuNtE?=
 =?us-ascii?Q?pwlRWjDMC7G27G3GdgM5dpuP7ylRRZNWTB+1N7MipqtAojxt+cFZPf2goWtk?=
 =?us-ascii?Q?1vVmr7UxnIntynJn/8/RvlcbaC7QrkOlzAFC+eHDBEYENgKdURIYc20BrWbV?=
 =?us-ascii?Q?FXWTp8C7VaVAIYKXdAzLviIUzvGBTvmg7b8h/nToiU/yzRQH0iRsseX5z5Td?=
 =?us-ascii?Q?e/MQwOo9bY3LAfLOvQYAoujdmwztdRZHp7CVKde7uRihrCERKSMJGUlPvIm5?=
 =?us-ascii?Q?doom1Ba5DFun15cFgmGYnhx/qKjNqT6U0G192nAiYxafZ961UrT71b5radva?=
 =?us-ascii?Q?JqqDhTw1WFa1JTRlPzM/Ww0KcjEupObYbNg+mYDw1htrps7kXPTnP1BjuOKB?=
 =?us-ascii?Q?6SuStM84JXf7g3qvJoLFQ6pRQyaPuY1d9hJ2sLmLEjXbHaeVEM8e9BqBSiNW?=
 =?us-ascii?Q?ng=3D=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b10dfc-2238-4af4-cff1-08dc2151a555
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2024 05:09:32.9149
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t6Y59SPceRv48FGIUMNT+mw3CrObSTJXScD4eZBY/PBcwkdz68XFEOC/YvGvVUy7GwkCkEChHS/HI/PhOTWUPvf4dGp5nyMIw7Q2KE+MUlI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJSPR01MB0834



> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Monday, January 29, 2024 7:50 PM
> To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> Cc: linux-kernel@vger.kernel.org; linux-riscv@lists.infradead.org; paul.w=
almsley@sifive.com; palmer@dabbelt.com;
> aou@eecs.berkeley.edu; sudeep.holla@arm.com; robh@kernel.org; conor.doole=
y@microchip.com; suagrfillet@gmail.com
> Subject: Re: [RFC v1 0/2] riscv: Cache Population Code Refactoring for AC=
PI and DT Support
>=20
> On Sun, Jan 28, 2024 at 11:59:55PM -0800, Sia Jee Heng wrote:
> > This series of patches refactors the cache population function to
> > seamlessly accommodate both DT and ACPI-based platforms. Additionally,
> > to streamline the code, the unused parameter in the ci_leaf_init()
> > function has been removed.
>=20
> Why's this an RFC? I don't see any mention of why.
My bad, I should have mentioned the reason in the cover letter.
Btw, the reason treating this as RFC patch is because I am seeking for more
opinions as it is the first try for riscv acpi based cacheinfo.
>=20
> Thanks,
> Conor.
>=20
> >
> > Sia Jee Heng (2):
> >   riscv: cacheinfo: Remove unused parameter
> >   riscv: cacheinfo: Refactor populate_cache_leaves()
> >
> >  arch/riscv/kernel/cacheinfo.c | 50 ++++++++++++++---------------------
> >  1 file changed, 20 insertions(+), 30 deletions(-)
> >
> >
> > base-commit: 41bccc98fb7931d63d03f326a746ac4d429c1dd3
> > --
> > 2.34.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv

