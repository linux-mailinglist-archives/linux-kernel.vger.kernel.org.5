Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E63237C0168
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 18:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232397AbjJJQRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 12:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbjJJQRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 12:17:22 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39AC094
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 09:17:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68016C433C8;
        Tue, 10 Oct 2023 16:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696954640;
        bh=lvXsPbuo3lNekKcZ4AxUxozr9gHUgje+MPo7mWhXGIo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mkV55KXNd4cDdmEEJUrceq9Ywe6ODR7KI/Vz8WOcxOT1lkl3wvuK71tp7iHQ6+55r
         MtHXaiPLceXpdJINwSmAgx1d0cTGS4erUqGsu/5VH4gg8fI24Lh9xljsTW4twMTlht
         Oa1LYFUPt2ykqW8CovGYTAYMvQoGWXT4wbluWCVUZQxRERlhOgscgB5skjPxKGt7mb
         J8PSXJVI4x2rwSKOoBhAvbkZ3VmgiL40IFk19dCoGOG+SecUeQtVhtE3R1EWppfpwu
         ME/kqWA04AHrpkvtm7t2YVeiaaAOp7G1b3N+BpQqXvQZwernUvyhzSejLmTfx6p/Bq
         RFqfdXd8UxOmw==
Date:   Tue, 10 Oct 2023 17:17:16 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Deepak Gupta <debug@rivosinc.com>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: Re: [PATCH v1 RFC Zisslpcfi 15/20] sslp prctl: arch-agnostic prctl
 for shadow stack and landing pad instr
Message-ID: <c4a77a1b-ae13-4071-98e8-25235e8058b7@sirena.org.uk>
References: <20230213045351.3945824-1-debug@rivosinc.com>
 <20230213045351.3945824-16-debug@rivosinc.com>
 <7c4448d1-4622-436f-8779-f52c4f011783@sirena.org.uk>
 <CAKC1njQuw_nzbQ07BGAQOi3C=vr35JhAc6-TB5nzY3zG3Nff3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ACAhjzT85bg724HA"
Content-Disposition: inline
In-Reply-To: <CAKC1njQuw_nzbQ07BGAQOi3C=vr35JhAc6-TB5nzY3zG3Nff3Q@mail.gmail.com>
X-Cookie: I feel partially hydrogenated!
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ACAhjzT85bg724HA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 09, 2023 at 02:22:51PM -0700, Deepak Gupta wrote:
> On Wed, Jun 7, 2023 at 1:22=E2=80=AFPM Mark Brown <broonie@kernel.org> wr=
ote:

> > On Sun, Feb 12, 2023 at 08:53:44PM -0800, Deepak Gupta wrote:

> > > +int __weak arch_get_shadow_stack_status(struct task_struct *t, unsig=
ned long __user *status)
> > > +{
> > > +     return -EINVAL;
> > > +}

> > Having looked at this further is there any great reason why the status
> > is passed as a pointer?  It seems needless effort.

> I was trying to be cleaner here to not overload returned status with a po=
inter.
> You could say that any negative value is an error. I don't have any
> favorites here.

OK, thanks - I changed it to treat negative codes as errors, I'll leave
things like that.

--ACAhjzT85bg724HA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmUleQsACgkQJNaLcl1U
h9A+oQf+LpsNDfAqDS2nwgFHdh60JolPY8rn6NrF842aj9Y2olxRwTCSw34whng7
5EBGkVw6506Spqsle1zvqdXSzA1VyWFfzZKJ+04ZsH6N6Wn42m0gry/3RnKcphxW
gF3Yz5JSyLRam8m4pGDM3OBDwLReOxIgxhOZs4VjWbaRdlL2MJ4y+gqHYx7JJRCT
fpF5koeDVyLxvPNJVwMHtHRE6adGLqd91yFi/UNL/ERzz4LhYxixwpk8LcZJzLcT
gjlqKcScF9TvoCqnItWWO6ulsNqN/fxtAvK+PYBCEZfiPqMktLztr2oeq238hdg0
3oCa+f5qhH7JF0SgvRu+mPmURwO7Lg==
=7Bqv
-----END PGP SIGNATURE-----

--ACAhjzT85bg724HA--
