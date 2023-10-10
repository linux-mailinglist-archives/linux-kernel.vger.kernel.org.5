Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643377BF7BA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjJJJpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbjJJJpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:45:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64BE7DB;
        Tue, 10 Oct 2023 02:45:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6229C433C9;
        Tue, 10 Oct 2023 09:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696931104;
        bh=hUhxVV/r1YPfIeCuDKqwVl2dHJIY/ryh8R2T9W5FnNs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ViZSVuDA5h6MjVAyHgd386jZGWsUxL1q8d2JHfY7u59hJ+U2cdoaslL1D+zHe4IE0
         S+gm2btrT1YYZtosgkd5TneRtsWgolGLfFSKZw/4U4jHj3PnWplIcMn2y0y/C7ovz0
         +9pNpypqHUACfGFcLNJK0K6Jcfo7MEvmMIKxtbdqdT2n7l9otGMJDAG+M2FIXJrWiC
         d2KWTEGb+XKEtizjhwnSCJZ5Wwc052e+mKMnC4GPMQhtzoRb5dZYGjXWWkb0VV9ZPx
         lpn4g7RHRDiKcRRSm/AP2Kz9o1LynOoleCkgbBw+oYWzzkpDcM5Yj7AhYn/VBk91Tt
         Y4trnemz0Zr9g==
Message-ID: <7e729488e2f841f384b719d0509a4f78f491d477.camel@kernel.org>
Subject: Re: [PATCH v7 00/13] selftests/sgx: Fix compilation errors
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
        "Huang, Kai" <kai.huang@intel.com>,
        "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Date:   Tue, 10 Oct 2023 12:44:30 +0300
In-Reply-To: <f2726c67-87f7-409a-9ac2-e845249348cc@cs.kuleuven.be>
References: <20231005153854.25566-1-jo.vanbulck@cs.kuleuven.be>
         <119aaa2820be5dc58144e74574cfaa7777f79604.camel@intel.com>
         <f2726c67-87f7-409a-9ac2-e845249348cc@cs.kuleuven.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Folks (sorry for top posting): I've now taken my old NUC7 out of the
dust and tested the series :-)

Tested-by: Jarkko Sakkinen <jarkko@kernel.org>

Off-topic: I wish both Intel and AMD straighten up and deliver some=C2=A0
"home friendly" development hardware for the  latest stuff. Just my
stance but the biggest quality risk I see in both TDX and SNP is that
the patches are made by an enterprise and reviewed (properly) *only*
by other huge enterprises.

I skim status of both from time to time but yeah not much attachment
or motivation to do more than that as you either need a cloud access
or partnership with Intel or AMD. "Indie" style seems to be disliked
these days... You can extrapolate from this that there must be a bunch
of maintainers around the Linux kernel that feel the same. Not saying
that particularly my contribution would be that important.

Sort of even if let's say Intel would provide me a partner access I
might not be that interested because I prefer my own (physical)
computers.

BR, Jarkko

On Fri, 2023-10-06 at 11:51 +0200, Jo Van Bulck wrote:
> Thank you, Kai! I'm not familiar with any next steps to get this merged=
=20
> upstream, but atm all commits in this series have been reviewed by at=20
> least Jarkko. Let me know if anything further is needed from my side!
>=20
> Best,
> Jo
>=20
> On 05.10.23 23:25, Huang, Kai wrote:
> > Hi Jo,
> >=20
> > Just FYI I won't review the rest patches in this series.=C2=A0 One of t=
he reasons is
> > I am not that familiar with the rest.=C2=A0 Jarkko has reviewed anyway =
:-).
> >=20
> > On Thu, 2023-10-05 at 17:38 +0200, Jo Van Bulck wrote:
> > > Hi,
> > >=20
> > > This patch series ensures that all SGX selftests succeed when compili=
ng with
> > > optimizations (as tested with -O{0,1,2,3,s} for both gcc 11.3.0 and c=
lang
> > > 14.0.0). The aim of the patches is to avoid reliance on undefined,
> > > compiler-specific behavior that can make the test results fragile.
> > >=20
> > > As far as I see, all commits in this series now have an explicit revi=
ewed-by
> > > tag, so hopefully this can get merged upstream? Please let me know if=
 any
> > > concerns remain and I'd happily address them.
> > >=20
> > > Reference output below:
> > >=20
> > > .. Testing=C2=A0=C2=A0 gcc=C2=A0=C2=A0 -O0=C2=A0=C2=A0=C2=A0 [OK]
> > > .. Testing=C2=A0=C2=A0 gcc=C2=A0=C2=A0 -O1=C2=A0=C2=A0=C2=A0 [OK]
> > > .. Testing=C2=A0=C2=A0 gcc=C2=A0=C2=A0 -O2=C2=A0=C2=A0=C2=A0 [OK]
> > > .. Testing=C2=A0=C2=A0 gcc=C2=A0=C2=A0 -O3=C2=A0=C2=A0=C2=A0 [OK]
> > > .. Testing=C2=A0=C2=A0 gcc=C2=A0=C2=A0 -Os=C2=A0=C2=A0=C2=A0 [OK]
> > > .. Testing=C2=A0=C2=A0 gcc=C2=A0=C2=A0 -Ofast [OK]
> > > .. Testing=C2=A0=C2=A0 gcc=C2=A0=C2=A0 -Og=C2=A0=C2=A0=C2=A0 [OK]
> > > .. Testing=C2=A0=C2=A0 clang -O0=C2=A0=C2=A0=C2=A0 [OK]
> > > .. Testing=C2=A0=C2=A0 clang -O1=C2=A0=C2=A0=C2=A0 [OK]
> > > .. Testing=C2=A0=C2=A0 clang -O2=C2=A0=C2=A0=C2=A0 [OK]
> > > .. Testing=C2=A0=C2=A0 clang -O3=C2=A0=C2=A0=C2=A0 [OK]
> > > .. Testing=C2=A0=C2=A0 clang -Os=C2=A0=C2=A0=C2=A0 [OK]
> > > .. Testing=C2=A0=C2=A0 clang -Ofast [OK]
> > > .. Testing=C2=A0=C2=A0 clang -Og=C2=A0=C2=A0=C2=A0 [OK]
> > >=20
> > > Changelog
> > > ---------
> > >=20
> > > v7
> > > =C2=A0=C2=A0 - Add reviewed-by tag (Jarkko)
> > >=20
> > > v6
> > > =C2=A0=C2=A0 - Collect final ack/reviewed-by tags (Jarkko, Kai)
> > >=20
> > > v5
> > > =C2=A0=C2=A0 - Reorder patches (Jarkko, Kai)
> > > =C2=A0=C2=A0 - Include fixes tag for inline asm memory clobber patch =
(Kai)
> > > =C2=A0=C2=A0 - Include linker error in static-pie commit message (Kai=
)
> > > =C2=A0=C2=A0 - Include generated assembly in relocations commit (Kai)
> > >=20
> > > v4
> > > =C2=A0=C2=A0 - Remove redundant -nostartfiles compiler flag (Jarkko)
> > > =C2=A0=C2=A0 - Split dynamic symbol table removal in separate commit =
(Kai)
> > > =C2=A0=C2=A0 - Split redundant push/pop elimination in separate commi=
t (Kai)
> > > =C2=A0=C2=A0 - Remove (incomplete) register cleansing on enclave exit
> > > =C2=A0=C2=A0 - Fix possibly uninitialized pointer dereferences in loa=
d.c
> > >=20
> > > v3
> > > =C2=A0=C2=A0 - Refactor encl_op_array declaration and indexing (Jarkk=
o)
> > > =C2=A0=C2=A0 - Annotate encl_buffer with "used" attribute (Kai)
> > > =C2=A0=C2=A0 - Split encl_buffer size and placement commits (Kai)
> > >=20
> > > v2
> > > =C2=A0=C2=A0 - Add additional check for NULL pointer (Kai)
> > > =C2=A0=C2=A0 - Refine to produce proper static-pie executable
> > > =C2=A0=C2=A0 - Fix linker script assertions
> > > =C2=A0=C2=A0 - Specify memory clobber for inline asm instead of volat=
ile (Kai)
> > > =C2=A0=C2=A0 - Clarify why encl_buffer non-static (Jarkko, Kai)
> > > =C2=A0=C2=A0 - Clarify -ffreestanding (Jarkko)
> > >=20
> > > Best,
> > > Jo
> > >=20
> > > Jo Van Bulck (13):
> > > =C2=A0=C2=A0 selftests/sgx: Fix uninitialized pointer dereference in =
error path
> > > =C2=A0=C2=A0 selftests/sgx: Fix uninitialized pointer dereferences in
> > > =C2=A0=C2=A0=C2=A0=C2=A0 encl_get_entry
> > > =C2=A0=C2=A0 selftests/sgx: Include memory clobber for inline asm in =
test enclave
> > > =C2=A0=C2=A0 selftests/sgx: Separate linker options
> > > =C2=A0=C2=A0 selftests/sgx: Specify freestanding environment for encl=
ave
> > > =C2=A0=C2=A0=C2=A0=C2=A0 compilation
> > > =C2=A0=C2=A0 selftests/sgx: Remove redundant enclave base address sav=
e/restore
> > > =C2=A0=C2=A0 selftests/sgx: Produce static-pie executable for test en=
clave
> > > =C2=A0=C2=A0 selftests/sgx: Handle relocations in test enclave
> > > =C2=A0=C2=A0 selftests/sgx: Fix linker script asserts
> > > =C2=A0=C2=A0 selftests/sgx: Ensure test enclave buffer is entirely pr=
eserved
> > > =C2=A0=C2=A0 selftests/sgx: Ensure expected location of test enclave =
buffer
> > > =C2=A0=C2=A0 selftests/sgx: Discard unsupported ELF sections
> > > =C2=A0=C2=A0 selftests/sgx: Remove incomplete ABI sanitization code i=
n test enclave
> > >=20
> > > =C2=A0 tools/testing/selftests/sgx/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 12 ++--
> > > =C2=A0 tools/testing/selftests/sgx/defines.h=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 2 +
> > > =C2=A0 tools/testing/selftests/sgx/load.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 9 ++-
> > > =C2=A0 tools/testing/selftests/sgx/sigstruct.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 5 +-
> > > =C2=A0 tools/testing/selftests/sgx/test_encl.c=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 67 +++++++++++++------
> > > =C2=A0 tools/testing/selftests/sgx/test_encl.lds=C2=A0=C2=A0=C2=A0=C2=
=A0 | 10 +--
> > > =C2=A0 .../selftests/sgx/test_encl_bootstrap.S=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 28 +++-----
> > > =C2=A0 7 files changed, 77 insertions(+), 56 deletions(-)
> > >=20
> >=20

