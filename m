Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5D37E1416
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 16:28:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229461AbjKEPZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 10:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjKEPZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 10:25:35 -0500
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2102.outbound.protection.outlook.com [40.92.15.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E15BD9;
        Sun,  5 Nov 2023 07:25:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cPVH1cFsx5zXiqVLcYngUHGYVmJRkFogId/dhX62lZkbe5xYrsSCH4PhCC1pbzmMz1MiqUY7kZXIf9EgzJIdpd7R+bpmmTjJd18fZ5lyYj+M8zmhyylieU9kgCWnocsCGL+V+nUiPWIAJhnqBGZTKz4ghlDIy/qXOTD5+tu0mY8g8egXUV4ErFpCncjBiMHoUzOIRQh35Mgbt143VgzeB3HuVx0DPPxuF0Aha4QulvEoDQdLGztmkJrYOdVssADFOqT/HW1fiDwMbt/t6hEmrrZZpmoUFvL/ZvFR3ao/ri7jqeSwcaIo9/YjRGxQ82D2s6siKuzmkM9zwdyZBzk+6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYWv8/RVDEXY8NPRY94oloibhk87wmzTR6IgJWLzfxc=;
 b=JSVPGYBChOb5YWGPYx4yKLTrAS6jNPrU0SAdjvPYRFteL6oDld2xd0YGNL1rW52oG/fzoQED4qm7hEaY8vtl420ubrVEQ3RjozcnnnE/tf+T0P2GmDh1yHsmTHCWV9pmffnOtVPSuNQ8P9bC3Mc5AUbtNszmhYVxrNK5jvd/VJGAOTbeXhEo8WXovVI78zQOD7ccDzcSxEVVoy92082lBLm0upn4hSjBmwE+agjM7WHCTdOyQ8tDhBmxOP9NiD0FukqpBpK49qPGHoG5Wg57eWIBexomuYax25CCntKIrZNxS6gtLtbQTnbnivSbqSwNnW3wbxWraefkXRoH/BgIXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYWv8/RVDEXY8NPRY94oloibhk87wmzTR6IgJWLzfxc=;
 b=DEY/PpUUoFuQCzjURno7c3EIuLm0Jcq9XziKcbu3VfWBwGKIxqIOmwB3yyhGD4/Ql8jpcUbI2PwAS5LQJe+11H/oeJfcjQDIB9v/38LV10a/7oA6T5xz7j7qMjUQ+Vk6VxmvLlYEVR8ulr7JzuWU7M+J9oYBRAuhnskOf+jIArM5qRWfwoPBjOvHf6cUjIu+lnmJ1k1AJODdcZpBq9S9I81fkWelOkrm343lK1bwmYVupWvCKSxAYW9WkFSpef5VP5n7anAI1twjWzBKRmM8TPLMUqcQYk7JRraOT4h7FTWZKG8Hpr/rQcXghC/tL5CHoNvtL/XkP23fY4Q0msnKFg==
Received: from BY3PR18MB4692.namprd18.prod.outlook.com (2603:10b6:a03:3c7::12)
 by CO3PR18MB4880.namprd18.prod.outlook.com (2603:10b6:303:170::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Sun, 5 Nov
 2023 15:25:29 +0000
Received: from BY3PR18MB4692.namprd18.prod.outlook.com
 ([fe80::4fa4:77da:f114:612a]) by BY3PR18MB4692.namprd18.prod.outlook.com
 ([fe80::4fa4:77da:f114:612a%6]) with mapi id 15.20.6954.027; Sun, 5 Nov 2023
 15:25:29 +0000
From:   Michael Kelley <mhklinux@outlook.com>
To:     Abhinav Singh <singhabhinav9051571833@gmail.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "decui@microsoft.com" <decui@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
        "kys@microsoft.com" <kys@microsoft.com>,
        "niyelchu@linux.microsoft.com" <niyelchu@linux.microsoft.com>
Subject: RE: [PATCH v2] x86/hyperv : Fixing removal of __iomem address space
 warning
Thread-Topic: [PATCH v2] x86/hyperv : Fixing removal of __iomem address space
 warning
Thread-Index: AQHaC4N+bOiR656qyEeXBoVVQcrrrbBr31AA
Date:   Sun, 5 Nov 2023 15:25:29 +0000
Message-ID: <BY3PR18MB46927A33E493191AA4F23B03D4ABA@BY3PR18MB4692.namprd18.prod.outlook.com>
References: <20231030225003.374717-1-singhabhinav9051571833@gmail.com>
In-Reply-To: <20231030225003.374717-1-singhabhinav9051571833@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [ob4cX/hZPBLDPuKIMIfnMfeES3s/eJHJ]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4692:EE_|CO3PR18MB4880:EE_
x-ms-office365-filtering-correlation-id: 0ef495b2-990a-48a4-84ef-08dbde13716c
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /TKLQrw4cyNJ0zEuMHzFo/WWNL/BaVgiybk2wk6+FZyWT26zCLWKehEXCPVNWEqkm2nbLKpgU9ThLSGRZAZymDiY9AZeRVqtpFAVXUe2COWb3gjjLhUc/ymq31oVGugA6EjFZ0+lY7QYpVB5kYPaz+xs9XLx/7wuj+du0eKLhJwNfcPHchdttvkuP2oGJwsDVCr6jnJUqrCQ1deVrg40MiCyl4aqVj+47q2eWBcw486mYnhcOoxqUA63kOutbYnXerpKA3VB3ndd8mWMuSR0w7yrc3Kr86iZ/YapKJ5uqifHUinDchBVHpYQWx3LZNK4lfKkX+N7p12rLURSt5+IdQms1ysc/005YkOUNfO0MA4WLiiWAV1lv31cwDGigbIPigUI2s3/qO6dXUU6S9r4wIdRuspgrSkFtGowNQNL8FpJY86UNB7l6Smx/Q9jJA8lj3QtP3Ou04bmNmlSM/MPbn3iFg88Nl7p4xgkNz+hdP75O0PPP0WU/3AibzbD50NQrFABZNU6l4YkV1ipHFA78YoGiTlg7kkqGxuxw21Il2VHnhcmTe2q8ntlf+z/lP4jHw5Awl3iga83b/s1rQYbi3dmOgTWJfRzSH4Ws+9oTt0=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?js88hjQjR8ykcy3+wi2zavvvzXoskjFHXDIOxVI33yerlPIt+/H2Sy8zv6dF?=
 =?us-ascii?Q?VFSFnwub4V1TART3N4urSQUGevSjU8bb5GdivACpaW+lwsXMGmisHb+WHMQ2?=
 =?us-ascii?Q?an+RJgUx2SwoEWy0ag3AR4W5wpCv7FSjjsG6ijOfAx5Nt/vMgI+yJnhFoGxw?=
 =?us-ascii?Q?/7fnCN+AVwZ4Ty7To0cFMyuFrJOTunzyJ0NwVlEVV3nZVQQjxM3hX2q5Tt9B?=
 =?us-ascii?Q?Kp9OqME165sQVn+vaC93dipdUYzTybEW2EgR01yuUSLkQxUXNNezwBGdufRm?=
 =?us-ascii?Q?phgVktfQlbU5vRn8r7snP3Bs9SFpks9OXOlFYDNPiyfwT7/PY5FOkxPogFS5?=
 =?us-ascii?Q?jiZ2xbz6TnVzKAXImwvY1tJnU8f+JHa8NlUPrjfEvIeWg+HaTx1sP+qWZyqj?=
 =?us-ascii?Q?Y0u09jAIfB3NFil0Qg7JuaJ6IXgcxetp2HNfXhIPFsgRiOdKjl+jQbu6hgsR?=
 =?us-ascii?Q?XVInVVNElEPb/UzY6ou2D6p9SJ07WW5+L74G3xqvfZJp88+A9gYUES23ix6/?=
 =?us-ascii?Q?PjbayFiOuSBb7yDTKljI1IZMt+xgfmvAz2XR06VIG9amafXcaG9w1aC8uEBA?=
 =?us-ascii?Q?CI7SIEs5CyQemXUb5n/EoRn9rOFyq5GDAAbnXg9c4e1LQjtzdU6c+Oh41r1N?=
 =?us-ascii?Q?oT7/9KxjeWcsFQVMdbxHpnWy4USPhrF9RUepF+dI6btp+gV32g7rBFS8H4wD?=
 =?us-ascii?Q?Acrw/tlNQ3YzcZ7hYXW7zOKj1xGn5cHnXtF73ySIAPQobkYXtc/gV8cU7I9I?=
 =?us-ascii?Q?kIi0IP1pIKb1BytbMz4a0cNeYS/+1kDcl+/0EQbd15RfeF0OyJF7FEKO8sBl?=
 =?us-ascii?Q?Pe8B34V+voOOX3TQIpFtq7Ior6fmMA+KL9yel7akjHCMFJovrxJRAYI++TAr?=
 =?us-ascii?Q?41LUFWqi64oiusEbQmI4qCwusfwBwI4M9zgZp0Mt/hyzUzloPMcMLOsyBdv3?=
 =?us-ascii?Q?PfKBJkqE7etOd1obnwXtqoa1MzSOLpnWwco+tNzuJQ/oJU9CmThEe2zR8rav?=
 =?us-ascii?Q?DnoMq0p33PLRMDmpVoGMfolQhPHuiDAmhVm6AMs2fJarOHElujJnDwsiF0bl?=
 =?us-ascii?Q?afuuK3ZITwk180iX8M342HEFAJ1CQKwTj718bbt0ptOYe4BRTM4kbkWBhNOv?=
 =?us-ascii?Q?R+voWTPFI0ojFEpjiIz3r2I0DJ3YGO1Q1UmhULxJMv2Sr2XLA63th38VIuQZ?=
 =?us-ascii?Q?fJeIXakg4dVQ4DHHLH4JlnjR8OCICX9uCpBpnQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4692.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef495b2-990a-48a4-84ef-08dbde13716c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2023 15:25:29.1452
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO3PR18MB4880
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abhinav Singh <singhabhinav9051571833@gmail.com> Sent: Monday, Octobe=
r 30, 2023 3:50 PM
>=20
> This patch fixes two sparse warnings
>=20
> 1. sparse complaining about the removal of __iomem address
> space when casting the return value of this ioremap_cache(...)
> from `void __ioremap*` to `void*`.
> Fixed this by replacing the ioremap_cache(...)
> by memremap(...) and using MEMREMAP_DEC and MEMREMAP_WB flag for
> making
> sure the memory is always decrypted and it will support full write back
> cache.
>=20
> 2. sparse complaining `expected void volatile [noderef] __iomem *addr`
> when calling iounmap with a non __iomem pointer.
> Fixed this by replacing iounmap(...) with memumap(...).
>=20
> Signed-off-by: Abhinav Singh <singhabhinav9051571833@gmail.com>

Since Nischala has posted her more comprehensive patch,
this patch can be dropped.  But see one comment below for
future reference.

> ---
>=20
> v1:
> https://lore.kernel.org/all/19cec6f0-e176-4bcc-95a0-9d6eb0261ed1@gmail.co=
m/T/
>=20
> v1 to v2:
> 1. Fixed the comment which was earlier describing ioremap_cache(...).
> 2. Replaced iounmap(...) with memremap(...) inside function hv_cpu_die(..=
.).
>=20
>  arch/x86/hyperv/hv_init.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 21556ad87f4b..2a14928b8a36 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -68,9 +68,11 @@ static int hyperv_init_ghcb(void)
>  	 */
>  	rdmsrl(MSR_AMD64_SEV_ES_GHCB, ghcb_gpa);
>=20
> -	/* Mask out vTOM bit. ioremap_cache() maps decrypted */
> +	/* Mask out vTOM bit.
> +	MEMREMAP_WB full write back cache
> +	MEMREMAP_DEC maps decrypted memory */

This isn't the right style for multi-line patches.  Correct would be:

	/*
	 * Mask out vTOM bit.
	 * MEMREMAP_WB full write back cache
	 * MEMREMAP_DEC maps decrypted memory
	 */

Section 8 of coding-style.rst under Documentation/process covers
these details.   Note that the style is slightly different for code
under net and drivers/net.

Michael

>  	ghcb_gpa &=3D ~ms_hyperv.shared_gpa_boundary;
> -	ghcb_va =3D (void *)ioremap_cache(ghcb_gpa, HV_HYP_PAGE_SIZE);
> +	ghcb_va =3D memremap(ghcb_gpa, HV_HYP_PAGE_SIZE, MEMREMAP_WB | MEMREMAP=
_DEC);
>  	if (!ghcb_va)
>  		return -ENOMEM;
>=20
> @@ -238,7 +240,7 @@ static int hv_cpu_die(unsigned int cpu)
>  	if (hv_ghcb_pg) {
>  		ghcb_va =3D (void **)this_cpu_ptr(hv_ghcb_pg);
>  		if (*ghcb_va)
> -			iounmap(*ghcb_va);
> +			memunmap(*ghcb_va);
>  		*ghcb_va =3D NULL;
>  	}
>=20
> --
> 2.39.2

