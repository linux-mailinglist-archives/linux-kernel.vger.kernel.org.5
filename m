Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2559776E4D8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 11:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbjHCJo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 05:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232926AbjHCJoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 05:44:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725993595;
        Thu,  3 Aug 2023 02:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691055871; x=1722591871;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PM/FfZ0vfzEPppWtxflf4gMuWXsZGV2oeDBfvYpCndY=;
  b=LuaY9a+Ehwlj6i5zeYELFEW7oVwiIzCUvSz/hqfnYLT7ty0MuEE5m7zR
   50X3A0bR6s76jtPjq2RgMMZdosVKkYjG+Gg3i8q9rZ5p4/g0ULwYeil+T
   anOZI3Anj01JcybqA6naMyoEPRDm4C+yP8Boh8iV4b6K8dmBD55pnhpNK
   XlAY+3vPisMO7fHhnym9yaRLUcn7H9roZuuopdMkCdDfF37v6DqyBDaiC
   wFK2ok750Pipgbt4Sk5ggyGfgcAAB28XY8xQqNaFAqxez34nQsEU+gWsi
   UVDW47VQnfVK0gJYVea0NgdvCBEhsJxFjO7nN+yKpEhNl5riDoC4JESlT
   Q==;
X-IronPort-AV: E=Sophos;i="6.01,251,1684825200"; 
   d="asc'?scan'208";a="227978460"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Aug 2023 02:44:30 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 3 Aug 2023 02:44:05 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 3 Aug 2023 02:44:03 -0700
Date:   Thu, 3 Aug 2023 10:43:26 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Nylon Chen <nylon.chen@sifive.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <geert+renesas@glider.be>,
        <pavel@ucw.cz>, <vincent.chen@sifive.com>,
        <emil.renner.berthing@canonical.com>, <aou@eecs.berkeley.edu>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <conor@kernel.org>, <zong.li@sifive.com>
Subject: Re: [PATCH v4 0/1] Change PWM-controlled LED pin active mode and
 algorithm
Message-ID: <20230803-caretaker-voicing-e982f2334067@wendy>
References: <20230803085734.340-1-nylon.chen@sifive.com>
 <20230803-vehicular-leggings-2830239f818a@wendy>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tzX8viRnXMQ13hWc"
Content-Disposition: inline
In-Reply-To: <20230803-vehicular-leggings-2830239f818a@wendy>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--tzX8viRnXMQ13hWc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Nylon,

(I yoinked the reply to 1/1 to here, as it makes more sense in this
context)

> On Thu, Aug 03, 2023 at 10:15:10AM +0100, Conor Dooley wrote:
> > On Thu, Aug 03, 2023 at 04:57:33PM +0800, Nylon Chen wrote:
> > > According to the circuit diagram of User LEDs - RGB described in them=
anual hifive-unleashed-a00.pdf[0] and hifive-unmatched-schematics-v3.pdf[1].
> > >=20
> > > The behavior of PWM is acitve-high.
> > >=20
> > > Removed patches: 1
> > > New patches: (none)
> > >=20
> > > Links:
> > > - [0]:  https://sifive.cdn.prismic.io/sifive/c52a8e32-05ce-4aaf-95c8-=
7bf8453f8698_hifive-unleashed-a00-schematics-1.pdf
> > > - [1]:  https://sifive.cdn.prismic.io/sifive/6a06d6c0-6e66-49b5-8e9e-=
e68ce76f4192_hifive-unmatched-schematics-v3.pdf
> > > - [2]:  https://sifive.cdn.prismic.io/sifive/1a82e600-1f93-4f41-b2d8-=
86ed8b16acba_fu740-c000-manual-v1p6.pdf
> > >=20
> > > Changed in v4:
> > >  - Remove previous updates to the PWM algorithm.
> >=20
> > Why? I don't recall the conclusion on the previous version being that
> > that patch was not needed.
>
> I apologize for forgetting about this update earlier. Just now,
> I tried to pull rebase master and noticed that other developers seem
> to have made some fixes to the algorithm. Upon closer inspection, I
> found that they addressed the part we previously discussed with Emil
> and Uwe, such as "first pwm_apply_state."
>=20
> Therefore, my instinct tells me that they have already taken care of
> the issues we discussed before.

I didn't see anything in linux-next that would solve this problem of
inversion. The last meaningful change is:
	commit 334c7b13d38321e47d1a51dba0bef9f4c403ec75
	Author:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
	AuthorDate: Wed Nov 9 12:37:24 2022 +0100
	Commit:     Thierry Reding <thierry.reding@gmail.com>
	CommitDate: Mon Jan 30 16:42:45 2023 +0100
=09
	    pwm: sifive: Always let the first pwm_apply_state succeed

which predates your v3 by quite a bit.

> I will review the conflicting parts in the pwm-sifive.c code in my v4
> version once again to ensure there are no omissions. If I find any, I
> will submit v5 accordingly.

And if this patch is okay in isolation, please reply here explaining
which commit fixed the algorithm, so that I can pick it up.

Thanks,
Conor.

--tzX8viRnXMQ13hWc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMt2vgAKCRB4tDGHoIJi
0o+tAP9T2YoYk//o5k7MVQwS/3aSXKAO4fwzn4VO7kYKb3jOPgD+KA7Bv5tRvwou
PaimuCQYfr42wST7wH8mSiR9MZA7zQ4=
=Sx/n
-----END PGP SIGNATURE-----

--tzX8viRnXMQ13hWc--
