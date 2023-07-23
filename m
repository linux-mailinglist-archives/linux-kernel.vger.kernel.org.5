Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E2F775E163
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jul 2023 12:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjGWK2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jul 2023 06:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbjGWK1v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jul 2023 06:27:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4321130F4
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 03:27:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D61C60C77
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jul 2023 10:27:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68553C433C7;
        Sun, 23 Jul 2023 10:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690108029;
        bh=8VJc2tD2YELzixtvQn5M61U40vb9YcAHPcXQfgf7Q44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GNXCXw5BJNcKTo+7KeMYXFsbJ1F79bgksCry1yFSSu+tXu0WRMfqPOBPfiPjadaEo
         O8v6w0Cc+uo9jKBm1NG4wejosRkIX7kvyju1eQX/L4AMV0sOyEflpq7/dOYSUm9lbi
         7Ov9Reh+bFumn16h1HCg4tUH0b2qtcN3PYzZf3tpbU0uH4fyQs/iily+vaO8uEV/63
         VeeUezUzGamNHKzB59HYiJjyForQ+pAQ22+qPtgKtS8/K+bYBS480DSSEghZPcQt6S
         p3f0sgAkEtLDPb5XyHgmbLLxlFaVJ1zqIpwFNMRma35fhIZl221G4JWRxMwkwRNCHA
         rNc9SFrTDYAZA==
Date:   Sun, 23 Jul 2023 11:27:05 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Torsten Duwe <duwe@lst.de>, Palmer Dabbelt <palmer@dabbelt.com>,
        Li Zhengyu <lizhengyu3@huawei.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Li Huafei <lihuafei1@huawei.com>,
        Liao Chang <liaochang1@huawei.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liubao918@huawei.com
Subject: Re: [PATCH] riscv: relocate R_RISCV_CALL_PLT in kexec_file
Message-ID: <20230723-sprig-audacious-4fff0306735d@spud>
References: <20230310182726.GA25154@lst.de>
 <e02fdfce-4574-8e7e-ec96-8e8eaa4067bc@huawei.com>
 <20230321160349.3b3a46df@blackhole.lan>
 <fc1a945d-368c-4385-b1cc-69978e0f4657@spud>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="w/YJr8pXLUA/bSjV"
Content-Disposition: inline
In-Reply-To: <fc1a945d-368c-4385-b1cc-69978e0f4657@spud>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w/YJr8pXLUA/bSjV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey Torsten,

On Tue, Mar 21, 2023 at 03:35:38PM +0000, Conor Dooley wrote:
> On Tue, Mar 21, 2023 at 04:03:49PM +0100, Torsten Duwe wrote:
> > On Mon, 13 Mar 2023 11:13:17 +0800
> > Li Zhengyu <lizhengyu3@huawei.com> wrote:
> >=20
> > > On Fri, 10 Mar 2023 19:27:03 +0100, Torsten Duwe <duwe@lst.de> wrote:
> > > > Depending on the toolchain (here: gcc-12, binutils-2.40) the
> > > > relocation entries for function calls are no longer R_RISCV_CALL, b=
ut
> > > > R_RISCV_CALL_PLT. When trying kexec_load_file on such kernels, it w=
ill
> > > > fail with
> > > >
> > > >   kexec_image: Unknown rela relocation: 19
> > > >   kexec_image: Error loading purgatory ret=3D-8
> > > >
> > > > The binary code at the call site remains the same, so tell
> > > > arch_kexec_apply_relocations_add() to handle _PLT alike.
> > >=20
> > > R_RISCV_CALL has already been deprecated, and replaced by R_RISCV_CAL=
L_PLT.
> > >=20
> > > See Enum 18-19 in Table 3. Relocation types from=20
> > > https://github.com/riscv-non-isa/riscv-elf-psabi-doc/blob/master/risc=
v-elf.adoc=20
> > > .
> > >=20
> > > It was deprecated in ("Deprecated R_RISCV_CALL, prefer=20
> > > R_RISCV_CALL_PLT")=20
> > > https://github.com/riscv-non-isa/riscv-elf-psabi-doc/commit/a0dced850=
18d7a0ec17023c9389cbd70b1dbc1b0
> > >=20
> > > >
> > > > fixes: 838b3e28488f702 ("Load purgatory in kexec_file")
> > > > Signed-off-by: Torsten Duwe <duwe@suse.de>
> > > > Cc: stable@vger.kernel.org
> > > >
> > > > ---
> > > > --- a/arch/riscv/kernel/elf_kexec.c
> > > > +++ b/arch/riscv/kernel/elf_kexec.c
> > > > @@ -425,6 +425,7 @@ int arch_kexec_apply_relocations_add(struct pur=
gatory_info *pi,
> > > >   		 * sym, instead of searching the whole relsec.
> > > >   		 */
> > > >   		case R_RISCV_PCREL_HI20:
> > > > +		case R_RISCV_CALL_PLT:
> > > >   		case R_RISCV_CALL:
> > > >   			*(u64 *)loc =3D CLEAN_IMM(UITYPE, *(u64 *)loc) |
> > > >   				 ENCODE_UJTYPE_IMM(val - addr);
> > > >
> > > > .
> > >=20
> > > Palmer, please apply these references to the commit message.
> > >=20
> > > Reviewed-by: Li Zhengyu <lizhengyu3@huawei.com>
> > >=20
> >=20
> > Ping?
>=20
> It's not been all that longer than a week & you're in patchwork so you
> won't be forgotten,

Turns out it did get forgotten, or more accurately, marked as "Changes
Requested".

> but I noticed a complaint when I went looking on
> patchwork about your fixes tag:
>=20
> Commit: f28b81e30b4b ("riscv: relocate R_RISCV_CALL_PLT in kexec_file")
> 	Fixes tag: fixes: 838b3e28488f702 ("Load purgatory in kexec_file")
> 	Has these problem(s):
> 		- Subject does not match target commit subject
> 		  Just use
> 			git log -1 --format=3D'Fixes: %h ("%s")'
>=20
> The fixes tag should be:
> Fixes: 838b3e28488f ("RISC-V: Load purgatory in kexec_file")
>=20
> Note the capital F & the missed RISC-V: prefix, checkpatch should have
> complained about this.
> Checkpatch also complains that your suse email in the Signoff doesn't
> match the lst.de email that you used to send the patch (IOW you're
> missing a From: header that send-email would add).
>=20
> Could you fix those things up please & I suppose you can take the
> opportunity to make the changes that Li Zhengyu suggested to the commit
> message itself at the same time.

Would you mind resending this with the Fixes & Signoff corrections?

Thanks,
Conor.

--w/YJr8pXLUA/bSjV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZL0AdQAKCRB4tDGHoIJi
0tfSAP0QWC0Z93lHBZdkNOp+3L2ooUp4Y6wLUlFIEnzmb0yAlgD9GLB8lnvQSQHj
8tpflQZTVoJmy3fz+qAd/hsh/AE0GA0=
=PHll
-----END PGP SIGNATURE-----

--w/YJr8pXLUA/bSjV--
