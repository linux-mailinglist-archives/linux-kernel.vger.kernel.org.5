Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3BE79B452
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354711AbjIKVzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237318AbjIKMgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 08:36:00 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDD81B9;
        Mon, 11 Sep 2023 05:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1694435754; x=1725971754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nJFDCSCYRu6WgqpO0P8o9k8Fk7g2YG2V+UabQjK1F0I=;
  b=tbr5O28nmmcElYk0C2EDcm8Z4qgOoIPFQLHARaBm2/uzSuX0yBIXECfQ
   oFV/45FfAyfoA2wvEdIRZuVliGbIyo/xpL7W3J5atccj/kANg9ek752g0
   ucD1te2ouWEYnKEFUgs5s8YFYBPfgz58HE8m4xrvu/43vorkQGC7KesH9
   e2tGKreRF0IXeT+iuPwTgL5/PV0VBQYmnHOKTqsWnoSYrzB51GSALS16z
   vSu8G5ng7CW9JH59Jdn4piKWixkJYMjrNZdny/BXQraKwdDwgpo2E697g
   2dyBVZwBPAaA51uaK0t5LtuR1pHZTPklQmkPa4Z2YlnZTydTOBUNUMAbJ
   w==;
X-CSE-ConnectionGUID: 6ljN90N3QJ+9ydbJ9OLrug==
X-CSE-MsgGUID: K4MjJXbnQt6wrUlyUlkyaw==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.02,244,1688454000"; 
   d="asc'?scan'208";a="3976159"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 11 Sep 2023 05:35:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 11 Sep 2023 05:35:40 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex04.mchp-main.com (10.10.85.152)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Mon, 11 Sep 2023 05:35:36 -0700
Date:   Mon, 11 Sep 2023 13:35:21 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Yu-Chien Peter Lin <peterlin@andestech.com>
CC:     Conor Dooley <conor@kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <atishp@atishpatra.org>,
        <anup@brainfault.org>, <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        <ajones@ventanamicro.com>, <heiko@sntech.de>,
        <samuel@sholland.org>, <geert+renesas@glider.be>,
        <n.shubin@yadro.com>, <dminus@andestech.com>,
        <ycliang@andestech.com>, <tim609@andestech.com>,
        <locus84@andestech.com>, <dylan@andestech.com>
Subject: Re: [PATCH 3/4] riscv: errata: Add Andes PMU errata
Message-ID: <20230911-worry-reformat-fbb5c473085d@wendy>
References: <20230907021635.1002738-1-peterlin@andestech.com>
 <20230907021635.1002738-4-peterlin@andestech.com>
 <20230907-158e1f7e1e866d8c02726c9c@fedora>
 <20230907-7bc08398d2f95c14e1c0bc76@fedora>
 <ZP6ADIAqZn0kkxwB@APC323>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+9uiuXeVPrdkDknr"
Content-Disposition: inline
In-Reply-To: <ZP6ADIAqZn0kkxwB@APC323>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--+9uiuXeVPrdkDknr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2023 at 10:48:44AM +0800, Yu-Chien Peter Lin wrote:
> On Thu, Sep 07, 2023 at 12:02:46PM +0100, Conor Dooley wrote:
> > On Thu, Sep 07, 2023 at 10:27:03AM +0100, Conor Dooley wrote:
> > > Hey,
> > >=20
> > > On Thu, Sep 07, 2023 at 10:16:34AM +0800, Yu Chien Peter Lin wrote:
> > > > Before the ratification of Sscofpmf, the Andes PMU extension
> > > > implements the same mechanism and is compatible with existing
> > > > SBI PMU driver of perf to support event sampling and mode
> > > > filtering with programmable hardware performance counters.
> > >=20
> > > If it actually was, you'd not need to modify the driver ;)
> > >=20
> > > > This patch adds PMU support for Andes 45-series CPUs by
> > > > introducing a CPU errata.
> > >=20
> > > I don't really understand this in all honesty. You don't have Sscofpmf
> > > support with a bug, you have something that is Sscofpmf-adjactent that
> > > predates it. Why claim to support an extension that you do not, only =
to
> > > have to come along and try to clean things up afterwards, instead of
> > > accurately declaring what you do support from the outset?
> >=20
> > Reading this again, I don't think that I have been particularly clear,
> > sorry. My point is that this is not a fix for a bug in your
> > implementation of Sscofpmf, but rather adding probing for what is
> > effectively a custom ISA extension that happens to be very similar to
> > the standard one. As it is not an implementation bug, errata should
> > not be abused to support vendor extensions, and either DT or ACPI should
> > be used to inform the operating system about its presence.
> >=20
> > Cheers,
> > Conor.
> >=20
> > >=20
> > > (and just because someone already got away with it, doesn't mean that
> > > you get a free pass on it, sorry)
>=20
> Apologize for any confusion caused by the name. I thought it would make it
> easier to find the related functions and files in OpenSBI, didn't expect
> that it may have misled people to abuse the use of errata, you are right,
> I should have chosen my words more carefully.

I'm not sure what you mean here. The commit message is not the problem,
nor is the comparison in it to Sscofpmf - my issue is with pretending
that things like this are errata and using mvendorid etc to probe them.

> In my opinion, this is simply a pre-sepc solution to enable missing perf
> features before the standard is finalized.

Right, I don't think there's any disagreement about that. What I am
objecting to is adding more cases of pretending that something never
intended to be the standard extension is the standard extension with an
erratum. I know the T-Head stuff does do exactly this, but I don't think
we should continue to allow feature probing using the errata framework,
but instead communicate supported features via DT or ACPI. (If I could
re-review the T-Head PMU patch now, I'd say the same thing there).
Maybe Palmer et al disagree & there is some extenuating circumstance
that applies here.

> The underlying logic remains the
> same, so we can still use the errata to patch a few lines of CSR accesses
> and align with other vendors. This way, we can make minimal changes and
> avoid performance overhead to the driver.

I think you're conflating errata with alternatives. I have no problem
with the use of alternatives for this purpose & the perf parts of the
patch are okay to me, if the overhead of having a platform specific ops
struct is unacceptable.

Thanks,
Conor.

--+9uiuXeVPrdkDknr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZP8JiQAKCRB4tDGHoIJi
0sHNAP90SbNP+JXIdUjtQoulfh1Ab/AVAk4Yd7SL2NtaDT8a/gD+NOzFbAhx9vMW
gJg2KArKlDrcTTo/q2pWYEbItZdvowc=
=k83d
-----END PGP SIGNATURE-----

--+9uiuXeVPrdkDknr--
