Return-Path: <linux-kernel+bounces-83831-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0B2869F02
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 19:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E59981F269F3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B8725757;
	Tue, 27 Feb 2024 18:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+xS4utr"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77571448C7;
	Tue, 27 Feb 2024 18:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709058159; cv=none; b=ZPvJvK/GQkNYyOFiPomhVApOg735T3vxjo6PYNpWbFgsxOAjkbxayyAD8CVSVuaszOjY8jPpJ6wCLXpqK9ZqF6M4UU573fGm58CmFTyxMEC9QA4diMYlsGUkXa1qaScp8m8OtZtBSLHi6jSlWSWOeEI1yMq6dbJzKOC6qL32jks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709058159; c=relaxed/simple;
	bh=t2X04j+6tfN8ZmDHgEQnpC0hzPKjfflCDkJqlGYzc7o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Vtben52FNEpNcDzKqrjX8Tn88+oaN7VKHJBsKc4H+0/lymyypwDaZ+6ArgPfaV8eQiPEBvan3CYuot1eTh/Ja8lvm+bxYFCUDf13bw20U+6BQa2yAcEXWfV5oOrTtzzbOl3JNa/+SO/I48JXXI7khV2BdCF8uWUlM88FacJloDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+xS4utr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2636C433C7;
	Tue, 27 Feb 2024 18:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709058158;
	bh=t2X04j+6tfN8ZmDHgEQnpC0hzPKjfflCDkJqlGYzc7o=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=t+xS4utrMWntP2B/9DJJ/zz8WsOFQeKVMpDXoItRXCD93ze4LlLHJxBMnpyqTOq4v
	 Xy0Hqil1rSY+mZO5DUY7uO9MqmpzbVvvb/6MMXJj9qPU6uDh7V56tIQJVdk6YCbNRo
	 CYQ4sP+Iyo8E2VaBK9UgCb0ERsdnLipW3uk1yA28ABCiBNGbfLpa2f64iMyVFyI8DC
	 v7g9cldhUXk6C9XaST/V1xcUe/zvUiT9qNYVJcGP8FR8Ljc5o2r8h19rzXYn1+PxIN
	 FoND9OVZuw0oYNiBsD6v77Fd8ipNN2dtY74Tle4ssrT+5tVPSdwgfTKovI7SQ9BA/O
	 BSYdUTxLAQjEg==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Feb 2024 20:22:34 +0200
Message-Id: <CZG2JXJ83L7K.32PU7BZTQNHLV@kernel.org>
Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, "Mimi Zohar" <zohar@linux.ibm.com>,
 "Peter Huewe" <peterhuewe@gmx.de>, <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Update W's for KEYS/KEYRINGS_INTEGRITY and
 TPM DEVICE RIVER
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240226062245.2279635-1-jarkko@kernel.org>
 <eaa5107ac4f982b6fd6e80b522643a591e719dc9.camel@HansenPartnership.com>
 <CZEWILFMZ5L1.2TCZXVS7GTDKZ@suppilovahvero>
 <3bae009a24a55902d93e4055ecd13f9f54cdbb37.camel@HansenPartnership.com>
In-Reply-To: <3bae009a24a55902d93e4055ecd13f9f54cdbb37.camel@HansenPartnership.com>

On Mon Feb 26, 2024 at 12:11 PM EET, James Bottomley wrote:
> On Mon, 2024-02-26 at 11:26 +0200, Jarkko Sakkinen wrote:
> > On Mon Feb 26, 2024 at 8:49 AM EET, James Bottomley wrote:
> > > On Mon, 2024-02-26 at 08:22 +0200, Jarkko Sakkinen wrote:
> > > > Add TPM driver test suite URL to the MAINTAINERS files and move
> > > > the
> > > > wiki
> > > > URL to more appropriate location.
> > > >=20
> > > > Link: https://gitlab.com/jarkkojs/linux-tpmdd-test
> > > > Link: https://kernsec.org/wiki/index.php/Linux_Kernel_Integrity
> > > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > > > Cc: Peter Huewe <peterhuewe@gmx.de>
> > > > Cc: linux-integrity@vger.kernel.org
> > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > ---
> > > > =C2=A0MAINTAINERS | 3 ++-
> > > > =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
> > > >=20
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index bf77be03fb2b..6380c1109b86 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -11947,6 +11947,7 @@ M:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Mimi =
Zohar <zohar@linux.ibm.com>
> > > > =C2=A0L:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0linux-integrity@vger.kernel.o=
rg
> > > > =C2=A0L:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0keyrings@vger.kernel.org
> > > > =C2=A0S:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Supported
> > > > +W:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0https://kernsec.org/wiki/index.php=
/inux_Kernel_Integrity
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 Missing L
> > >=20
> > > James
> >=20
> > Thanks! I'll fixup that.
> >=20
> > "linux-tpmdd-test" is the suite that I'm using to test your patch
> > set. It has swtpm integrated. I wonder if there was easy to way to
> > tweak swtpm to emulate "interposer", i.e. reset its state while it is
> > running (preferably not by restarting it).
>
> The way I do it is to use a qemu patch
>
> https://lore.kernel.org/qemu-devel/20231004184219.6594-1-jejb@linux.ibm.c=
om/
>
> which allows qemu to connect to the mssim (or ibmswtpm2) TPM over an
> inet socket which means I can execute TPM commands from the host (like
> resetting the TPM) as well as the guest and snoop the TPM traffic.

To which exact and most recent possible QEMU version I can apply that
cleanly?

My build configuration builds both QEMU and swtpm [1] for every build so
I could pick that patch, copy it to board/qemu/patches/qemu, and set the
version in the BuildRoot configuration appropriately.

[1]
https://gitlab.com/jarkkojs/linux-tpmdd-test/-/tree/main/package/libtpms
https://gitlab.com/jarkkojs/linux-tpmdd-test/-/tree/main/package/swtpm

BR, Jarkko

