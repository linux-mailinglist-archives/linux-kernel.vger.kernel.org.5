Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8115575E10F
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 11:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbjGWJxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 05:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjGWJxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 05:53:52 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBB4210EC
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 02:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690106031; x=1721642031;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=VKr5VO15SzVLrupSm+gaAFRMv/RVUz3w0kQ0crk4aN8=;
  b=Puv45gWMCbFIC4f89TdY20Kj5B3Vn56EhTjz8WoXezOF7KQtBLrwHb3i
   RryOIDUId0VYLD7Yq7phCYydo8SlGJ2kBEvV/j7FSlF+2vB8wF+MFSqL7
   gHDxDYzDszW2OeFLyFNNkGu3usI1PB+0Ga7APS60MXxZIaT03yaEgGq9P
   e4LSeRz09/tliJxTO6iCMe63EUeMBU/Mmn5/PqJ6H3nF2siraIoBMm2xn
   5XEgZqM/iD3yg6azs6XfiERM1Dflam6Ei3n9K4nRyD57VCTZV5CgNzE5x
   JAyif0aPplMuKHo72eN+h4RebjF1+A4efBJNNuaHiTyKcLAFQhP71jG0M
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="366155434"
X-IronPort-AV: E=Sophos;i="6.01,226,1684825200"; 
   d="scan'208";a="366155434"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2023 02:53:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10779"; a="719346436"
X-IronPort-AV: E=Sophos;i="6.01,226,1684825200"; 
   d="scan'208";a="719346436"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP; 23 Jul 2023 02:53:49 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 23 Jul 2023 02:53:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 23 Jul 2023 02:53:48 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 23 Jul 2023 02:53:48 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.100)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 23 Jul 2023 02:53:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mfwqS098W3fUUvkZN0wwlNcn/LiXWC7ns54k2y8UhfcQZZQi8n1R59Uhayyiolr/SMQE8CmzJMuOJTsphcjUTsiAOSWUEdA47OFHQFH/ts4LeieUAjLHzUbhOzUoW7qyvViye/VRKMjPEOKbXIeEZsex9n7786IlbR9q50yso+Wg0aLbygO8Je2XGUl8JWPNLEFljduU8UKwzGtVnWAXIkJZ/8YCZNl2FpNSvzPxGsGlpD3XdywC75J6QLtSZk/V2uo6abXuWUwWSqSb40sj7VktA3PQGrSuu58IOn4WDIUTF+GPUKfCPFpPlRpJ9wOU8vpVyMaGUsmYsjkMgbCA0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JnAoIVZv41N6TfU0m4XaDD2GIuhBrXPLopaM4lSSaG4=;
 b=ChvtNqTTaw7GMdbQIdRgF9F6co0haKmJVJzYuIwzwUloyLgAPxN0DdT7xwJMemmxh/1OSNpvtGKEihc/f2c8BvAYT/hcDu5Wv4p9sCUpRF/n1p/R0vAxQXEovlVKpGY0yGeUcBXqe6JPhkAVUuJ3f+nMqj1CHvfbCPisE/dwkwXGwn1ankzXsr80UEN+jIhth49w57+JZPQCfR4LRWXFfd1z3nmdy2BLdx5Yqrq+/yCj2fPh3QkRxA+poO8rfzPwDbrGeuD5nPNkBbTBBwmbsgM33+5f/Ibv2J/EMxXEpYG/jYjsocjGDhNZIYmcbd9BJLDXQzc9YppY9qx9JBMldA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB6734.namprd11.prod.outlook.com (2603:10b6:806:25d::22)
 by LV3PR11MB8768.namprd11.prod.outlook.com (2603:10b6:408:211::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Sun, 23 Jul
 2023 09:53:45 +0000
Received: from SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::50e4:2cb8:4529:af04]) by SA1PR11MB6734.namprd11.prod.outlook.com
 ([fe80::50e4:2cb8:4529:af04%7]) with mapi id 15.20.6609.031; Sun, 23 Jul 2023
 09:53:44 +0000
From:   "Li, Xin3" <xin3.li@intel.com>
To:     Brian Gerst <brgerst@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        =?iso-8859-1?Q?Mika_Penttil=E4?= <mpenttil@redhat.com>
Subject: RE: [PATCH v2 2/6] x86/entry/64: Convert SYSRET validation tests to C
Thread-Topic: [PATCH v2 2/6] x86/entry/64: Convert SYSRET validation tests to
 C
Thread-Index: AQHZu+4IKd+u2a/ZW0G+ZDYDb+tfdq/HHLqA
Date:   Sun, 23 Jul 2023 09:53:43 +0000
Message-ID: <SA1PR11MB6734D85E6D1DB2BBFBBDF069A83DA@SA1PR11MB6734.namprd11.prod.outlook.com>
References: <20230721161018.50214-1-brgerst@gmail.com>
 <20230721161018.50214-3-brgerst@gmail.com>
In-Reply-To: <20230721161018.50214-3-brgerst@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6734:EE_|LV3PR11MB8768:EE_
x-ms-office365-filtering-correlation-id: 2e56e140-7755-408c-cec8-08db8b62b364
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rtdc0sFzytUpG7S95l5P55BJQeRRdrcqpgrNiLE9Dlk1v+DE0SDFst9XRjSzLE1gpJuiUgsfdwQQrX4zqlTKbd8DLNf2RnrUdl31/g3WPh4eWqldYRG+iQ6PY2tLb8irPLE/wFnum7YX5lVhgI+BDHiQ7g+yyU5ITm1DHOvHx4MVaB6VyewHd43LHvqrDAJiF0rZxvehu6r6VhFDruSZaleOO5qePrxc7YlHIaGDK8YbvDA6QV6SSoylpdLBqbJMCtvzQEdOC/mE/2w8FG+7nU9BEmg5aD3orzelIeWnOw3jqUBqG4X2m8kdEFnG4ruyAhdmopepzN31Vxs4os43iT/tbJJWp2VuyB7Yr3r3JdB3abPeArDhB3kjO59JEWYwVPTW1m2U2ZZDIY1GxSHtOZbMLT41FUk2eVV47lqnzkqEiw/VdC9vpl4s32cHlhX0T1q+ft5Qs6qCcRlfNNnBN9UFnxNexwkR4Bji1TyCIPeobPh8DHoslNZDkiwf5cg9lcaWfJaVB+ODr1mLc/N8ixTydFujT2rq8eaYwM1nEul7AJBM2Y0NcLSd6cIkfVfM+LOBOe19aa505u9GEVfsQvnBHisSnEQlkIDIvRORu1Lk64IFBlnY2faPWTvsHMl3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6734.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(136003)(39860400002)(396003)(346002)(451199021)(8936002)(5660300002)(52536014)(8676002)(41300700001)(316002)(2906002)(66476007)(66446008)(66556008)(64756008)(66946007)(76116006)(38070700005)(26005)(6506007)(38100700002)(55016003)(9686003)(54906003)(83380400001)(110136005)(86362001)(7696005)(4326008)(478600001)(33656002)(71200400001)(122000001)(82960400001)(186003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?L2y4NX1x0XvKk+IAwGjkFagOk3TlDyasoniEK9NTx79NhK9Cpuph6ZXA+n?=
 =?iso-8859-1?Q?4ownyswJHj5i5qPjWcR9SxN5srp3Z8B+PhJSCVlKq8kajhfmjagWwm13Pc?=
 =?iso-8859-1?Q?X2OJAK5SCE6OsDpeBTGPfwtkIA0ZnXIfgBsaEnWR35TXAI3EyikDm3SNw0?=
 =?iso-8859-1?Q?7LdcenIWe5+QoWyBEok9OAQNe77tBze3SZdgebEMDN1tYzpi/GWMox2GLu?=
 =?iso-8859-1?Q?kTjGr0SHh1S6aOf9KeJbSr0rgRgG9zbx+chMqSXu+IoK5KBBb1gKWADNax?=
 =?iso-8859-1?Q?WNkZ4rZgVzbzDEalUE7/BV0hSJ6A/RpkGwjFDxHli2rXUl1kSuMa8wpYyU?=
 =?iso-8859-1?Q?0PXqv+Pxshpn0x269FwszDyH4VUs97wGVdnfdE2D9F0tgCgVi78d4vOl3l?=
 =?iso-8859-1?Q?ZzU5MYW3Kmw/JYkDeAViY3qH9qWwC9/8llThPq8bIRqBYrze8pghfnMaUE?=
 =?iso-8859-1?Q?Hs38FRD/ogg29w9HapAior4oWbnXBVgBkapnbVXB2I4S1R2/WGQ6V70g1f?=
 =?iso-8859-1?Q?Mc7/nFQR1rlZ7beo0Me9nYNNVJYXzP4eqwhSksSstEFGPn6zwmjKKqSXgb?=
 =?iso-8859-1?Q?ZgLhdHnouuuB7YAsBqwNufTpOSU4rTUPKxOpYGKpeqT3AcSGQlQtTexg0V?=
 =?iso-8859-1?Q?nSbNEBTnYeb9CYtWi3ZZm9zcroOFSfASnIg8zk+oJGasobNXgQj86uPuoN?=
 =?iso-8859-1?Q?wVw/MovA0dByc5Lw6sM3M6ipr/Vjmw40UuFFd2WCZDN+Wh4zc3gUFCW+xO?=
 =?iso-8859-1?Q?IRv10vM4fpqzSXCGvaBaFFUKPc5afQY7V1GBCb98G5MT56vpvD+JwqE2hx?=
 =?iso-8859-1?Q?998FqDjau0EjvYv70tfXuJLDzS2m2nI4fMkoh/aH17Lm+Rq+x3obk9NY1m?=
 =?iso-8859-1?Q?dKB8F9X7SVwksB4zbIfwrxQeyXA7X/9tH1ZQIilxeGwIG6P0juMMD5Jvb4?=
 =?iso-8859-1?Q?SfQO1UZ4xqF18pCnFP/38SDTLjFK0Lu5dy7ylh71Uljm6iVtBSsiGay2fR?=
 =?iso-8859-1?Q?X+Z68e7Tu5sSNO8A2YDUAPXnazSdQfrJ3JS7hmm89mYkwsK9UhyMIjmDm2?=
 =?iso-8859-1?Q?cufCRHv/f70fgvOXZefMXIiBZPKiL8OF6wRbbVPZlLOb/aF6A15GuBnAWy?=
 =?iso-8859-1?Q?Psgwd56Z+jRGI3uLxp72XDK34kwnJMPcHF7u341zlXPD1BsCCp3zBG8Zoj?=
 =?iso-8859-1?Q?6pLd+Gn15NnOhb9iUvC2mwUmPFHbw+22rURekuoQNyM6ZRuTCDB+HqlkrM?=
 =?iso-8859-1?Q?mpvDVf7NEALOD5dPB/6q/vcYL/T4/cjX0ftYkfl02jt+/mEETxk3kSTeKl?=
 =?iso-8859-1?Q?TsyCmLgWLg+ERTX0IuGXZlo1ohv0X2ILysXXlcSElPQxnAw4L68UVa9FbJ?=
 =?iso-8859-1?Q?mNh2vL6b2lDcubeWhA+Y00xnvMd5I347PB/tRwz90Bvf+X780ZVBZpNL8T?=
 =?iso-8859-1?Q?h/Hez1W5nIekBafh0d9gWKwHlnElkoo5JA/k8/MOyAyhqvV69UAzo1iZP5?=
 =?iso-8859-1?Q?4Qm+UUmJ2bgHYJsf5oZFAbGTrWDHtj/Is9lGPMjRFDgCcD2kCI9shk1Lnq?=
 =?iso-8859-1?Q?x6fpOgjO7BrB9aApSKXfHCai/pfjZNrIroZAccxx80whFAS2xNTbI6GpI8?=
 =?iso-8859-1?Q?FlSgIQXpLfxzY=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6734.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e56e140-7755-408c-cec8-08db8b62b364
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2023 09:53:43.5247
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tOVh3kVU3EpahoHwmFWZGN7plZdAUsE3SPgjnrofIGxplxKEp3MhV93b2gyYK7LoHOx1EhNBqdknBFytloKUjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8768
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> @@ -84,6 +85,43 @@ __visible noinstr void do_syscall_64(struct pt_regs *r=
egs, int
> nr)
>=20
>  	instrumentation_end();
>  	syscall_exit_to_user_mode(regs);

Would it be better to make the following code a new function?

And then the similar changes in patch 6 could be merged into the new
function with #ifdef CONFIG_X86_64.

> +
> +	/*
> +	 * Check that the register state is valid for using SYSRET to exit
> +	 * to userspace.  Otherwise use the slower but fully capable IRET
> +	 * exit path.
> +	 */
> +
> +	/* XEN PV guests always use IRET path */
> +	if (cpu_feature_enabled(X86_FEATURE_XENPV))
> +		return false;
> +
> +	/* SYSRET requires RCX =3D=3D RIP and R11 =3D=3D EFLAGS */
> +	if (unlikely(regs->cx !=3D regs->ip || regs->r11 !=3D regs->flags))
> +		return false;
> +
> +	/* CS and SS must match the values set in MSR_STAR */
> +	if (unlikely(regs->cs !=3D __USER_CS || regs->ss !=3D __USER_DS))
> +		return false;
> +
> +	/*
> +	 * On Intel CPUs, SYSRET with non-canonical RCX/RIP will #GP
> +	 * in kernel space.  This essentially lets the user take over
> +	 * the kernel, since userspace controls RSP.
> +	 */
> +	if (unlikely(!__is_canonical_address(regs->ip, __VIRTUAL_MASK_SHIFT +
> 1)))
> +		return false;
> +
> +	/*
> +	 * SYSRET cannot restore RF.  It can restore TF, but unlike IRET,
> +	 * restoring TF results in a trap from userspace immediately after
> +	 * SYSRET.
> +	 */
> +	if (unlikely(regs->flags & (X86_EFLAGS_RF | X86_EFLAGS_TF)))
> +		return false;
> +
> +	/* Use SYSRET to exit to userspace */
> +	return true;
>  }
>  #endif
>=20

