Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEAE804C03
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 09:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbjLEINL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 03:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234856AbjLEING (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 03:13:06 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C699192;
        Tue,  5 Dec 2023 00:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701763991; x=1733299991;
  h=date:from:to:cc:subject:message-id:reply-to:references:
   mime-version:in-reply-to;
  bh=+5S4F3T/FBDoxciqj9rGoi4n0Xagz4XSh13nmg+mktk=;
  b=Uq7Qf1RbDBwdNnTRTyDazhTfI+I00U9aGN9VEs78OrzmCyPdfYHl5vxM
   MTawhsKgMtu3zDeNbo535aisirfXVmPZKnCf2Zt03zNA6nylwV8yYXJvt
   SyiAAOSQ+cJbKW4wmFGZVCBKC8l3b9urYUrl55CH87WOAiZs5dn9ov7IE
   3/NonXjDERdSzbeLT1wsre2IEbZVLz+vHm22/xsl3gaboE0WToAaaFgvn
   192iVHEyGJ8VqG3lFOiJCrQWnLtZeI4IHro//O46yM/b3l/Fjq/GGfQYH
   6jykj6I/s6KAzum8MgU+N/6mfZGyTrkta9KTwygmQhS2g5VzSQ9d/43dS
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="425020290"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="asc'?scan'208";a="425020290"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 00:13:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="1102374087"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="asc'?scan'208";a="1102374087"
Received: from debian-skl.sh.intel.com (HELO debian-skl) ([10.239.160.45])
  by fmsmga005.fm.intel.com with ESMTP; 05 Dec 2023 00:13:06 -0800
Date:   Tue, 5 Dec 2023 16:12:08 +0800
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/x86/uncore: fix a potential double-free in
 uncore_type_init
Message-ID: <ZW7bWGy+ZhcBUo73@debian-scheme>
Reply-To: Zhenyu Wang <zhenyuw@linux.intel.com>
References: <20231205032709.9525-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/cosUcUmE3dfT48V"
Content-Disposition: inline
In-Reply-To: <20231205032709.9525-1-dinghao.liu@zju.edu.cn>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/cosUcUmE3dfT48V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2023.12.05 11:27:09 +0800, Dinghao Liu wrote:
> When kzalloc for pmus[i].boxes fails, we should clean up pmus
> to prevent memleak. However, when kzalloc for attr_group fails,
> pmus has been assigned to type->pmus, and freeing will be done
> later on by the callers. The chain is: uncore_type_init ->
> uncore_types_init -> uncore_pci_init -> uncore_types_exit ->
> uncore_type_exit. Therefore, freeing pmus in uncore_type_init
> may cause a double-free. Fix this by setting type->pmus to
> NULL after kfree.

Change is ok but the call trace you wrote here is reversed or malformed??
With that fixed or cleared.

Reviewed-by: Zhenyu Wang <zhenyuw@linux.intel.com>

>=20
> Fixes: 629eb703d3e4 ("perf/x86/intel/uncore: Fix memory leaks on allocati=
on failures")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  arch/x86/events/intel/uncore.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncor=
e.c
> index 01023aa5125b..d80445a24011 100644
> --- a/arch/x86/events/intel/uncore.c
> +++ b/arch/x86/events/intel/uncore.c
> @@ -1041,6 +1041,7 @@ static int __init uncore_type_init(struct intel_unc=
ore_type *type, bool setid)
>  	for (i =3D 0; i < type->num_boxes; i++)
>  		kfree(pmus[i].boxes);
>  	kfree(pmus);
> +	type->pmus =3D NULL;
> =20
>  	return -ENOMEM;
>  }
> --=20
> 2.17.1
>=20

--/cosUcUmE3dfT48V
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQTXuabgHDW6LPt9CICxBBozTXgYJwUCZW7bUwAKCRCxBBozTXgY
J/bDAKCOA0aNY/nPoT08vmvKOA1I+3JF7QCgi4vd8mjY23YX1OMaIspmA7NwJLI=
=n/Bj
-----END PGP SIGNATURE-----

--/cosUcUmE3dfT48V--
