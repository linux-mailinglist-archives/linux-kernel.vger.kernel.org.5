Return-Path: <linux-kernel+bounces-74294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AD885D25D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 09:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EF0A2848B6
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FFD3BB3F;
	Wed, 21 Feb 2024 08:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="FRZ8GEDg";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="g4yn0CHZ"
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600143BB20;
	Wed, 21 Feb 2024 08:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708503419; cv=none; b=RZQwvH8MmrtFJ2mCYlECf43uLMPYnc9KYKD1Kwk+pQdT6NfSyx3DhataXoikm5ACsjLfPb6zEH65dXzXMN790zyVDlgmkxihhOv99EzpNC8OxRRjlP+K9c1FDn42irkZQ0p0/XkGOkAOzVCgG9p8U+8jeHFIA2L6h/dqTIyx82s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708503419; c=relaxed/simple;
	bh=ImDO1ptRcuiSvjyuf1c7UuMOp5LedFax4WXeJTjLDPc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZqknnvMjSOHhpRQnfezdb2Q1c6MiVOB6IXdKXPkMM7YSVtiFjudzofzick3z9j10dM68ViJX7r9s27kAg44D6oKO/Vy/vnKAI9xmeRORcxOfKRFuZSzK8ZEPA0m5mo51adXkLPnMRwqn71AQzNZxImLGoEe6T6ishmGVvEGEtIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=FRZ8GEDg; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=g4yn0CHZ reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1708503415; x=1740039415;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=eG8P+rnyI2xfiyStzAxuAUfnk5thsJblifMaExi1E7E=;
  b=FRZ8GEDgsr+USbq2dOH4+iUMLRTuW2/Rr84jRunrcuZbcfxAsPVSWBmc
   fu0BVJkrUSjsjm6OYaefsiL6wmHDL97vU0+vFRkxUbLjuKFXKi/bQOefT
   P3HmCy8UPzkEe4DTfiSQVk2XDwangq8gKI8uDtGfzFNMdcsklnacicEB5
   4EiSGOqUED2ramUh0+1KEkSzCPbfaTjZiVdD+FYfx9tO70QqHMJOdRiWL
   qykyCcoTV8tanjlfy4sB8uznFSXuexb0teDb36zQBndCvsumHN8aUj+Ao
   dXWXV03QH4osG84Pasiww2aHyCNSOBXRTiuQnfeLqfbKdSAUOKBppLHd/
   g==;
X-IronPort-AV: E=Sophos;i="6.06,175,1705359600"; 
   d="scan'208";a="35514693"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 21 Feb 2024 09:16:52 +0100
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0ABCB170D96;
	Wed, 21 Feb 2024 09:16:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1708503407;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=eG8P+rnyI2xfiyStzAxuAUfnk5thsJblifMaExi1E7E=;
	b=g4yn0CHZiOBUJqPxWCfvfeyvve7kFL7lYbskofXYjiiw0VMUHGMLtulodvGn56l0Lz+sBR
	rqopJ7qUu87ZpDZM8jSYhwdF7D8l5luepJedo3TjF+AkTeNCh6Ig+FOdyvDoHdwNgGIU3C
	6a9kkpS3+7sMJDXYcQ2ltX08YJTfMsr3rUyj3X4Q8BB945BWGbyRzpPtmXxX8tZtGQt4CJ
	+7Bb/KpBnMuZCw0OQQz5OeEroo8OudlEttIuV3T7p6m1Q8Yso6N0zJvF5aG4k/bhOi0/uj
	1OfBOcAXFoAB7RPLLJQPTBx/R8tD2GmtSvNKTTA5J+keWgKmltguPDPdfEh1+Q==
Message-ID: <10ad8f935e598244d4cb68aa20130952a26ba2ef.camel@ew.tq-group.com>
Subject: Re: [PATCH 6.1 000/197] 6.1.79-rc1 review
From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To: Daniel =?ISO-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>, Greg
	Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net,  shuah@kernel.org, patches@kernelci.org,
 lkft-triage@lists.linaro.org,  pavel@denx.de, jonathanh@nvidia.com,
 f.fainelli@gmail.com,  sudipm.mukherjee@gmail.com, srw@sladewatkins.net,
 rwarsow@gmx.de, conor@kernel.org,  allen.lkml@gmail.com, Christophe Leroy
 <christophe.leroy@csgroup.eu>, Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 21 Feb 2024 09:16:32 +0100
In-Reply-To: <7e1faa29-a154-41fc-aebc-38d5f355ea90@linaro.org>
References: <20240220204841.073267068@linuxfoundation.org>
	 <c873370c-c12f-4f03-a722-1ae59743089b@linaro.org>
	 <7e1faa29-a154-41fc-aebc-38d5f355ea90@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Last-TLS-Session-Version: TLSv1.3

On Tue, 2024-02-20 at 19:40 -0600, Daniel D=C3=ADaz wrote:
> ********************
> Achtung externe E-Mail: =C3=96ffnen Sie Anh=C3=A4nge und Links nur, wenn =
Sie wissen, dass diese aus einer sicheren Quelle stammen und sicher sind. L=
eiten Sie die E-Mail im Zweifelsfall zur Pr=C3=BCfung an den IT-Helpdesk we=
iter.
> Attention external email: Open attachments and links only if you know tha=
t they are from a secure source and are safe. In doubt forward the email to=
 the IT-Helpdesk to check it.
> ********************
>=20
> Hello!
>=20
> On 20/02/24 7:04 p.=C2=A0m., Daniel D=C3=ADaz wrote:
> > On 20/02/24 2:49 p.=C2=A0m., Greg Kroah-Hartman wrote:
> > > This is the start of the stable review cycle for the 6.1.79 release.
> > > There are 197 patches in this series, all will be posted as a respons=
e
> > > to this one.=C2=A0 If anyone has any issues with these being applied,=
 please
> > > let me know.
> > >=20
> > > Responses should be made by Thu, 22 Feb 2024 20:48:08 +0000.
> > > Anything received after that time might be too late.
> > >=20
> > > The whole patch series can be found in one patch at:
> > > =C2=A0=C2=A0=C2=A0=C2=A0https://www.kernel.org/pub/linux/kernel/v6.x/=
stable-review/patch-6.1.79-rc1.gz
> > > or in the git tree and branch at:
> > > =C2=A0=C2=A0=C2=A0=C2=A0git://git.kernel.org/pub/scm/linux/kernel/git=
/stable/linux-stable-rc.git linux-6.1.y
> > > and the diffstat can be found below.
> > >=20
> > > thanks,
> > >=20
> > > greg k-h
> >=20
> > We see a regression with PowerPC:
> >=20
> > -----8<-----
> >  =C2=A0 /builds/linux/arch/powerpc/kernel/cpu_setup_6xx.S: Assembler me=
ssages:
> >  =C2=A0 /builds/linux/arch/powerpc/kernel/cpu_setup_6xx.S:124: Error: u=
nrecognized opcode: `sym_func_start_local(setup_g2_le_hid2)'
> >  =C2=A0 /builds/linux/arch/powerpc/kernel/cpu_setup_6xx.S:131: Error: u=
nrecognized opcode: `sym_func_end(setup_g2_le_hid2)'
> >  =C2=A0 make[4]: *** [/builds/linux/scripts/Makefile.build:382: arch/po=
werpc/kernel/cpu_setup_6xx.o] Error 1
> > ----->8-----
> >=20
> > This is seen only on PowerPC with GCC 8, GCC 13, Clang 17, Clang nightl=
y, on:
> > * allnoconfig
> > * tinyconfig
> > * mpc83xx_defconfig
> > * ppc6xx_defconfig
> > (at least)
> >=20
> > Reproducer:
> >=20
> >  =C2=A0 tuxmake \
> >  =C2=A0=C2=A0=C2=A0 --runtime podman \
> >  =C2=A0=C2=A0=C2=A0 --target-arch powerpc \
> >  =C2=A0=C2=A0=C2=A0 --toolchain gcc-8 \
> >  =C2=A0=C2=A0=C2=A0 --kconfig tinyconfig
> >=20
>=20
> Bisection points to:
>=20
>    commit a65d7a833f486d0c162fdc854d2d5dd2e66ddd95
>    Author: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
>    Date:   Wed Jan 24 11:38:38 2024 +0100
>=20
>        powerpc/6xx: set High BAT Enable flag on G2_LE cores
>       =20
>        [ Upstream commit a038a3ff8c6582404834852c043dadc73a5b68b4 ]
>=20
>=20
> Reverting that commit makes the build pass again.

It seems that backporting the mentioned commit verbatim would also require
2da37761671b5bdedbe04e6469cfa57cd6b6ae45 ("powerpc/32: Fix objtool unannota=
ted intra-function call
warnings") to make SYM_FUNC_START_LOCAL/SYM_FUNC_END available. Please drop=
 this patch from 6.1 and
older for now.

Adding Christophe and Michael to cc. Is backporting the additional patch an=
 option (and if so, for
which kernel versions?), or should I send a new patch that does not use
SYM_FUNC_START_LOCAL/SYM_FUNC_END for stable?

Thanks,
Matthias



>=20
> Greetings!
>=20
> Daniel D=C3=ADaz
> daniel.diaz@linaro.org
>=20


