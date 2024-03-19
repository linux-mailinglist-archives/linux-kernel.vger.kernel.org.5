Return-Path: <linux-kernel+bounces-108114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D52880629
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CED6B22391
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:43:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4083BBEC;
	Tue, 19 Mar 2024 20:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEOo/Twb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFB23BB38;
	Tue, 19 Mar 2024 20:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710881012; cv=none; b=BhrSns6OtNDtOwNcZ/dShwiO1r8tEW0L9HB00GBZ9F3pimYq4L+CsYkHdPbF/s0tZVlP6pwJJagndt1WLxfdhuSWBdWLWaCZxD+UGYT3q5c/lasshW0c095is2kI0R7K1P5Do4LsGoySeUmJXZYQmO8w27d6ECGPG1ASO9OM8tI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710881012; c=relaxed/simple;
	bh=l66zTaS3iIbt2drJxrv68MnYKqMvhoTk3Lhw/r+aN4c=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=tHxv7Q99Y5Gt+s/f0a0Xr3PQ/g4WDQpCL+Xf1lSSMsaWQCcVkb81nSpdMR2MSJT3tsxfE5UIGS4f2LUK5X+9b3rfjXG7XtDaykV30mw8p+mu4XU2Ox6XCIk/2YPW+QHeR5yWUsH6hUJNzmv3CrNwIeLZKkk8M0yJgIdpkJdroMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEOo/Twb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594D7C433C7;
	Tue, 19 Mar 2024 20:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710881011;
	bh=l66zTaS3iIbt2drJxrv68MnYKqMvhoTk3Lhw/r+aN4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AEOo/Twb8QSdW4k0JLHhm5FEwLyp3cQ6wBQiX5jNMTs/IKhv+IjED535s2nSyBelk
	 17x+figjKpuFFOvnarfQrIyB/nvvtfrIFXyl0XqtdHekLhgCvYjqIj1IqVW0rog693
	 rYfNfL5j18iCzOFmPp2K7R0IqpkXKVy5ZI5UWXfWU//ja+D6U/MaN9OKZXQqrT6m8O
	 WvRByrE+Avn8ceIttRVhNJ0J+EhymnLZFBe7J/I/MtqeQfa8iFgNzJqVNoVUTKK53d
	 T/+p8HPOaAViEF7DdqAVcM6a5mpu/3e2uWl+utEiUM93YLy5gsWFccKNvOOc+2qYsh
	 0NbdCJvGAY8gA==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Mar 2024 22:43:28 +0200
Message-Id: <CZY0P8Z9MKWI.UDXUUC9BD43U@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, <linux-kernel@vger.kernel.org>
Cc: "Jason Gunthorpe" <jgg@ziepe.ca>, "Mimi Zohar" <zohar@linux.ibm.com>,
 "Peter Huewe" <peterhuewe@gmx.de>, <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Update W's for KEYS/KEYRINGS_INTEGRITY and
 TPM DEVICE RIVER
X-Mailer: aerc 0.15.2
References: <20240226062245.2279635-1-jarkko@kernel.org>
 <eaa5107ac4f982b6fd6e80b522643a591e719dc9.camel@HansenPartnership.com>
 <CZEWILFMZ5L1.2TCZXVS7GTDKZ@suppilovahvero>
 <3bae009a24a55902d93e4055ecd13f9f54cdbb37.camel@HansenPartnership.com>
 <CZG2JXJ83L7K.32PU7BZTQNHLV@kernel.org>
In-Reply-To: <CZG2JXJ83L7K.32PU7BZTQNHLV@kernel.org>

On Tue Feb 27, 2024 at 8:22 PM EET, Jarkko Sakkinen wrote:
> On Mon Feb 26, 2024 at 12:11 PM EET, James Bottomley wrote:
> > On Mon, 2024-02-26 at 11:26 +0200, Jarkko Sakkinen wrote:
> > > On Mon Feb 26, 2024 at 8:49 AM EET, James Bottomley wrote:
> > > > On Mon, 2024-02-26 at 08:22 +0200, Jarkko Sakkinen wrote:
> > > > > Add TPM driver test suite URL to the MAINTAINERS files and move
> > > > > the
> > > > > wiki
> > > > > URL to more appropriate location.
> > > > >=20
> > > > > Link: https://gitlab.com/jarkkojs/linux-tpmdd-test
> > > > > Link: https://kernsec.org/wiki/index.php/Linux_Kernel_Integrity
> > > > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > > > Cc: Mimi Zohar <zohar@linux.ibm.com>
> > > > > Cc: Peter Huewe <peterhuewe@gmx.de>
> > > > > Cc: linux-integrity@vger.kernel.org
> > > > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > > ---
> > > > > =C2=A0MAINTAINERS | 3 ++-
> > > > > =C2=A01 file changed, 2 insertions(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > index bf77be03fb2b..6380c1109b86 100644
> > > > > --- a/MAINTAINERS
> > > > > +++ b/MAINTAINERS
> > > > > @@ -11947,6 +11947,7 @@ M:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Mim=
i Zohar <zohar@linux.ibm.com>
> > > > > =C2=A0L:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0linux-integrity@vger.kernel=
org
> > > > > =C2=A0L:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0keyrings@vger.kernel.org
> > > > > =C2=A0S:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Supported
> > > > > +W:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0https://kernsec.org/wiki/index.p=
hp/inux_Kernel_Integrity
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 Missing L
> > > >=20
> > > > James
> > >=20
> > > Thanks! I'll fixup that.
> > >=20
> > > "linux-tpmdd-test" is the suite that I'm using to test your patch
> > > set. It has swtpm integrated. I wonder if there was easy to way to
> > > tweak swtpm to emulate "interposer", i.e. reset its state while it is
> > > running (preferably not by restarting it).
> >
> > The way I do it is to use a qemu patch
> >
> > https://lore.kernel.org/qemu-devel/20231004184219.6594-1-jejb@linux.ibm=
com/
> >
> > which allows qemu to connect to the mssim (or ibmswtpm2) TPM over an
> > inet socket which means I can execute TPM commands from the host (like
> > resetting the TPM) as well as the guest and snoop the TPM traffic.
>
> To which exact and most recent possible QEMU version I can apply that
> cleanly?
>
> My build configuration builds both QEMU and swtpm [1] for every build so
> I could pick that patch, copy it to board/qemu/patches/qemu, and set the
> version in the BuildRoot configuration appropriately.
>
> [1]
> https://gitlab.com/jarkkojs/linux-tpmdd-test/-/tree/main/package/libtpms
> https://gitlab.com/jarkkojs/linux-tpmdd-test/-/tree/main/package/swtpm

Friendly ping. Still looking forward to test.

I cannot recall exact review comments for v7 but what I can recall is
that they were cosmetic.

BR, Jarkko

