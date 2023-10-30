Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3797DBE7A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 18:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbjJ3RET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 13:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbjJ3RER (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 13:04:17 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2050.outbound.protection.outlook.com [40.92.45.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD5B0DA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 10:04:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MR+ki5V3e+gPVOz5iIWrXStNviKK6VYVQNqlDvXmwjny99MlYICChLvleHIZmhpt2Bh2fyj5r7avwnYLNlaw8ZTbIXf6FvoI5BXz6EEdh+rSRyWYIQ3Z/bHCTHL0bRRroHdlHAev7wKFskMKSc4zXz8hQ1KOGwjtMaEPhYrWzP9RUMsUxVN/11B+O64X13dmmk1TEpij74hRMX5luy4kz0gqKsgGKv9Tb5Sn696AIlCzFrtWWsHBxT6sTcp8HeBcSaSufn2GYkUxzlUMkD3BeQKUsGQVJi+hFscXG9ul/nf3VY3JQMgV63p4oKOxoJwMUY365osIGTwUK4nMIF1e6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRpi/M4iKUvuSUnZpfJjYC2Fb442ODgEpCkCeyXx0EA=;
 b=J/uDUBI5OIKIjtRpkdSIKAVArc+nUFi5ODACq5c7IJdXk78OnUImtNee91ZDKLzRTCVq1y8K2C1mvWUYHF2j49ccQQTWidbrypH4qfuSUfh/CetdMKntQsv/Pc3kQk4oU0aTRAcx7ky6FcI8JA4rsF4BftUpa40rKZxnguVpzOGYN4Y0b80p9qOEJx3DXbDNiO1+NYDX2SgorB6LcyUHoYRgHX2GdCzmWOIekrMdit1LQ0t5AHfg/zZqk00uwpNHSSiuaUOzzYUZNG+TxDb9KeZWfiVii9tPDwSzE8BF/GGHSgf6gUyuhvLtoICLwwTgK+0YPUA5lNFbBWh1F1Be4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gRpi/M4iKUvuSUnZpfJjYC2Fb442ODgEpCkCeyXx0EA=;
 b=tnZ/2LOjL5ephSR4IVRa+ihojGucTedUS2SkfBHJsMKE1RdqYEdG8nIIO1mo3IepOL863erqcvuhh7cHMyXWxOx4queN5QKR0trXngq6kTKxyBXiZQULIgfG1qx4O0brAqXTEjSFkJ4XGExYmL9imzsY8ybZT+nhJv79iSfQMeoCHT1dgrjEFsy5oKJwvZexL9o8FBmiNWeuzW+pLxdz5bGYA4pXsEWhajTh2wmHk3CdhWTCoDHt/SK/iEeN/8kOyxPnaBXDAa+Lq8sT5Jc4Tby9S/O94cPzUW4haZaiMgeY3wLQ1L5kmk4o417U7WEFDYuV6UVd2iSrx2zEpocZPg==
Received: from BY3PR18MB4692.namprd18.prod.outlook.com (2603:10b6:a03:3c7::12)
 by DM8PR18MB4472.namprd18.prod.outlook.com (2603:10b6:8:29::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6933.28; Mon, 30 Oct 2023 17:04:10 +0000
Received: from BY3PR18MB4692.namprd18.prod.outlook.com
 ([fe80::759:5762:b4b2:9a82]) by BY3PR18MB4692.namprd18.prod.outlook.com
 ([fe80::759:5762:b4b2:9a82%7]) with mapi id 15.20.6933.028; Mon, 30 Oct 2023
 17:04:09 +0000
From:   Michael Kelley <mhklinux@outlook.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "elena.reshetova@intel.com" <elena.reshetova@intel.com>,
        "isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
        "seanjc@google.com" <seanjc@google.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "decui@microsoft.com" <decui@microsoft.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] x86/mm/cpa: Warn if set_memory_XXcrypted() fails
Thread-Topic: [PATCH v2] x86/mm/cpa: Warn if set_memory_XXcrypted() fails
Thread-Index: AQHaCR9Hql4IagyvH0uJcaVc1KiiI7BikxFg
Date:   Mon, 30 Oct 2023 17:04:09 +0000
Message-ID: <BY3PR18MB46927F8909976A62E202C4D1D4A1A@BY3PR18MB4692.namprd18.prod.outlook.com>
References: <20231027214744.1742056-1-rick.p.edgecombe@intel.com>
In-Reply-To: <20231027214744.1742056-1-rick.p.edgecombe@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-tmn:  [io1PEiUXbHllNwzKcjDRZg==]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4692:EE_|DM8PR18MB4472:EE_
x-ms-office365-filtering-correlation-id: 01c15dcd-4076-4d41-74c9-08dbd96a3bc8
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +5KW7jYVPVcwvQo770cUUBNJzZmDnGbNdiPE0OBRbJ18CLIDIS8er2VFRIXtmQGLr89O7XjFAocE1iUzl8h62Dds1HWAfrSeL1+Wo7FLC42v3K826a+dnuUqL+bSExgN58eneOnXkZoHDLnF32i4ypNkGQipDmy44SVcw4e4lIOenLtTR1kCvmFsIZADTGXLAyKQ27JEARVPxX3DTdxSn4pjf4fpFFk1Fpibnmg630QsQbyxa9c86RdjlHq4cahsarmOGOh3FrB5Q7EZO4Zp4mG7+OS7EiKEvdjFYnQMhfy1mwZedlsxhbRyBQOrwFtX4x41ZJ8cwQzjZp+DAnN7TefX+2wbseFAtGbUuiNqYC89OeRIPjlKa4TkJB5xTV86GudFn5+qnAYuhbYq/OcMIC6toDt9c5Dwj+xQ8E1wmBFnNVCmvrgzZb5TgAlQo91+/u6shn9aIMKpU93B+16FAEsCgF0ZADKRioBrnEYQlSRqT22P6mlCvLwCI8IuYWMcGClHWOg0g3Bgu6QPMd04ro93tucNIMb80q/xA6xdmt2II2O/FaWZG11OX2f4WzMcmgik+0ZCWL+UVVEnvcHuiiDfJnpjaXte6PzNTxkKgFg=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?haUZs7tkLb915O1hNzMi9LDQkVLt6izrBV9R/vrZcB4VA0SYPzLrfqr/Xjxv?=
 =?us-ascii?Q?IsKy8brYzPsGNArRM0+QCIXK9Qkjh0BVuvrXnFaNv2BRoSW6MLCnh8mbhjW4?=
 =?us-ascii?Q?lC8qT1qLimLG1zNIZwyi55pIJo6z/9waOMqoR7B4lpoya/OeXERDaNOlD0ka?=
 =?us-ascii?Q?BfscUm9yYfnxracvuH8K/9gHTBgRrV1cVPB9C2sKK+WNtdZlWLVPKJA91ZsW?=
 =?us-ascii?Q?vWjr53ypWwptRKFB0jxcx0fsdOjRE7rXPUQuQ8t/RXPRMn0Q/EzfuT9Y9d1r?=
 =?us-ascii?Q?bwjkGpsItAlwFoZmH3nSRKuE/xTqTkMywqJICfPT4H/neTnId/u/dyQlgcKW?=
 =?us-ascii?Q?SGMXqRgmeISptVY2hff7yf5zElz+24OQXlYVhNMC2uCTXGILhUEjo491y9I7?=
 =?us-ascii?Q?57WD8F9x4Lf4jvzCa2X0r5fBh6apkYynvczz3eg7+N5DHE6+6Pavlokp+oyC?=
 =?us-ascii?Q?CmPA6K8wDdZXMQzNUk0u/Z3MaXddqkM6Baexdo7Qxy+ZJkbZudId2ntW90nI?=
 =?us-ascii?Q?1oDRfAhhqHYJLN9PSY39EHQK8C2l9TsubNyIxSVPvJnTBQb527tLo6eXhDAO?=
 =?us-ascii?Q?CekOsGRXIN1ODESClFMQcgdkl0/rck/fVHfAV6G8ttyDeCuGPCzHdZob6Dts?=
 =?us-ascii?Q?v2W7ga/BTn9FrLfz+ZucwfpwiIGRIUbB7u/fFnf/BqycHTUuoJ9r2rHJODBs?=
 =?us-ascii?Q?46GfIhFppmnw+ErAKG9PLmb3o/VyhWpgQOAdFAFdWs0UZyjJkCQ8cGvnp4iu?=
 =?us-ascii?Q?K6r1tZD6mdRu3CJqAiDuh/6Al5tqdW1yhYDXSSTP/OL0JAoyUeNkURAjlaNY?=
 =?us-ascii?Q?9v6+erloEU+UR6TELR6Gm+ez0qeJ5b5n3AIUho978qfhSLvt9LpXwfL1DcbJ?=
 =?us-ascii?Q?FmdQni/mMl1EtiS/DHfTPmzAhloWCcHLNeY+e6aH6wBRCZb7wi7OJXJdQBVy?=
 =?us-ascii?Q?k2sS0wA08ny8vXQR0TMAPcUPTxRx3MckkZHhGrVzN+Fn7bIMd9dA3YQtMg/R?=
 =?us-ascii?Q?POkMEbPRVns8aAplZPlQPc/gDIv5klNuJb5oFZqmB5kQlKYxL0YrNlow5kmv?=
 =?us-ascii?Q?VCFdbtDcbeXyWvexC9uApfKMzzrBiMwVQiglaC4OJR2CakaSQpfmaO+GBlnJ?=
 =?us-ascii?Q?I7ZuyhAfBKRngG5MO6akUPeXziZwDTwLl5LYWh90lwTAPFSQmyNp9LM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4692.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 01c15dcd-4076-4d41-74c9-08dbd96a3bc8
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 17:04:09.5774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR18MB4472
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rick Edgecombe <rick.p.edgecombe@intel.com> Sent: Friday, October 27,=
 2023 2:48 PM
>=20
> On TDX it is possible for the untrusted host to cause
> set_memory_encrypted() or set_memory_decrypted() to fail such that an
> error is returned and the resulting memory is shared. Callers need to tak=
e care
> to handle these errors to avoid returning decrypted (shared) memory to th=
e
> page allocator, which could lead to functional or security issues.
> In terms of security, the problematic case is guest PTEs mapping the shar=
ed
> alias GFNs, since the VMM has control of the shared mapping in the EPT/NP=
T.
>=20
> Such conversion errors may herald future system instability, but are
> temporarily survivable with proper handling in the caller. The kernel
> traditionally makes every effort to keep running, but it is expected that=
 some
> coco guests may prefer to play it safe security-wise, and panic in this c=
ase. To
> accommodate both cases, warn when the arch breakouts for converting
> memory at the VMM layer return an error to CPA. Security focused users ca=
n
> rely on panic_on_warn to defend against bugs in the callers. Some VMMs ar=
e
> not known to behave in the troublesome way, so users that would like to
> terminate on any unusual behavior by the VMM around this will be covered =
as
> well.
>=20
> Since the arch breakouts host the logic for handling coco implementation
> specific errors, an error returned from them means that the set_memory() =
call
> is out of options for handling the error internally. Make this the condit=
ion to
> warn about.
>=20
> It is possible that very rarely these functions could fail due to guest m=
emory
> pressure (in the case of failing to allocate a huge page when splitting a=
 page
> table). Don't warn in this case because it is a lot less likely to indica=
te an attack
> by the host and it is not clear which
> set_memory() calls should get the same treatment. That corner should be
> addressed by future work that considers the more general problem and not
> just papers over a single set_memory() variant.
>=20
> Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux=
.intel.com>
> Suggested-by: Michael Kelley (LINUX) <mikelley@microsoft.com>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
> For v2:
>  - Update commit log to call out importance of PTEs being shared in
>    guest for there to be a problem, and that some users may want to
>    terminate the guest on any unsual behavior. (Michael Kelley)
>  - Remove out label (Thomas Lendacky, Sathyanarayanan Kuppuswamy)
>=20
> v1 is here:
> https://lore.kernel.org/lkml/20231024234829.1443125-1-rick.p.edgecombe@in=
tel.com/
> ---
>  arch/x86/mm/pat/set_memory.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
>=20
> diff --git a/arch/x86/mm/pat/set_memory.c
> b/arch/x86/mm/pat/set_memory.c index bda9f129835e..34f2c0c88a6b
> 100644
> --- a/arch/x86/mm/pat/set_memory.c
> +++ b/arch/x86/mm/pat/set_memory.c
> @@ -2153,7 +2153,7 @@ static int __set_memory_enc_pgtable(unsigned
> long addr, int numpages, bool enc)
>=20
>  	/* Notify hypervisor that we are about to set/clr encryption attribute.=
 */
>  	if (!x86_platform.guest.enc_status_change_prepare(addr, numpages, enc))
> -		return -EIO;
> +		goto vmm_fail;
>=20
>  	ret =3D __change_page_attr_set_clr(&cpa, 1);
>=20
> @@ -2167,12 +2167,19 @@ static int __set_memory_enc_pgtable(unsigned long=
 addr, int numpages, bool enc)
>  	cpa_flush(&cpa, 0);
>=20
>  	/* Notify hypervisor that we have successfully set/clr encryption attri=
bute. */
> -	if (!ret) {
> -		if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
> -			ret =3D -EIO;
> -	}
> +	if (ret)
> +		return ret;
>=20
> -	return ret;
> +	if (!x86_platform.guest.enc_status_change_finish(addr, numpages, enc))
> +		goto vmm_fail;
> +
> +	return 0;
> +
> +vmm_fail:
> +	WARN_ONCE(1, "CPA VMM failure to convert memory (addr=3D%p, numpages=3D=
%d) to %s.\n",
> +		  (void *)addr, numpages, enc ? "private" : "shared");
> +
> +	return -EIO;
>  }
>=20
>  static int __set_memory_enc_dec(unsigned long addr, int numpages, bool e=
nc)
> --
> 2.34.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
