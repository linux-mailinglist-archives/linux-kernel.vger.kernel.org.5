Return-Path: <linux-kernel+bounces-74703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6163785D7F9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:37:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0FD1C22664
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 12:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F4C669D23;
	Wed, 21 Feb 2024 12:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YO1nHeeq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACD369D02;
	Wed, 21 Feb 2024 12:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708519053; cv=none; b=MZ2t4LHa2rzd2b9STx2tLkrlLZKpM/zLRHt/tLvKgqNOqjWUGGZs38ExCsrwSoN/Vd57eX9MGpQNh2QGVjPEWeIgTUnLHU7LKtrXVDc2fcPFQnyD90BDxWLmwNO5BtsAQQOTP412YB0AQQRxBMUefdpf24ZlM5oRw54tZJZ+iq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708519053; c=relaxed/simple;
	bh=ESR5FUVH7HdQuYDC2PkSSIiu8ZJk0BRHYo1/BQuDM/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHpvzDEWmJNX9PR0fDVuXA1Gnc9wbRLgMsAzyFGBcl17LvF3kn92S6CBZzV2SIBOn4CYH3PuzGETi+Sg7NEEN11AzbjwI4JwHUQGf/KwG7QPrW7O7I4toYsCDZi0K3VrYbfxOrOcHf7X8bgVDS4ZTF4U6mgKQlFe1yRJpAUPMjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YO1nHeeq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3C8C433C7;
	Wed, 21 Feb 2024 12:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708519053;
	bh=ESR5FUVH7HdQuYDC2PkSSIiu8ZJk0BRHYo1/BQuDM/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YO1nHeeqGoI+x+F6a3bmVPJFPcdxoe6zwkhq9LxK4lbUfYKnN90wjj4moyiPoQC8y
	 PiUKWbGfeZI8Ozr/omEKFkiAzKTKDc5BfW4u2DlvoV73mdb8M7D/9jBSxyQfaZu/I+
	 lApKCHtWM1Jul6kevOEi+qf1/loA78A+AglWToxU=
Date: Wed, 21 Feb 2024 13:37:30 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Daniel =?iso-8859-1?Q?D=EDaz?= <daniel.diaz@linaro.org>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de,
	jonathanh@nvidia.com, f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de,
	conor@kernel.org, allen.lkml@gmail.com,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 6.1 000/197] 6.1.79-rc1 review
Message-ID: <2024022122-diminish-astrology-3635@gregkh>
References: <20240220204841.073267068@linuxfoundation.org>
 <c873370c-c12f-4f03-a722-1ae59743089b@linaro.org>
 <7e1faa29-a154-41fc-aebc-38d5f355ea90@linaro.org>
 <10ad8f935e598244d4cb68aa20130952a26ba2ef.camel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10ad8f935e598244d4cb68aa20130952a26ba2ef.camel@ew.tq-group.com>

On Wed, Feb 21, 2024 at 09:16:32AM +0100, Matthias Schiffer wrote:
> On Tue, 2024-02-20 at 19:40 -0600, Daniel Díaz wrote:
> > ********************
> > Achtung externe E-Mail: Öffnen Sie Anhänge und Links nur, wenn Sie wissen, dass diese aus einer sicheren Quelle stammen und sicher sind. Leiten Sie die E-Mail im Zweifelsfall zur Prüfung an den IT-Helpdesk weiter.
> > Attention external email: Open attachments and links only if you know that they are from a secure source and are safe. In doubt forward the email to the IT-Helpdesk to check it.
> > ********************
> > 
> > Hello!
> > 
> > On 20/02/24 7:04 p. m., Daniel Díaz wrote:
> > > On 20/02/24 2:49 p. m., Greg Kroah-Hartman wrote:
> > > > This is the start of the stable review cycle for the 6.1.79 release.
> > > > There are 197 patches in this series, all will be posted as a response
> > > > to this one.  If anyone has any issues with these being applied, please
> > > > let me know.
> > > > 
> > > > Responses should be made by Thu, 22 Feb 2024 20:48:08 +0000.
> > > > Anything received after that time might be too late.
> > > > 
> > > > The whole patch series can be found in one patch at:
> > > >     https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.79-rc1.gz
> > > > or in the git tree and branch at:
> > > >     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.1.y
> > > > and the diffstat can be found below.
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > 
> > > We see a regression with PowerPC:
> > > 
> > > -----8<-----
> > >    /builds/linux/arch/powerpc/kernel/cpu_setup_6xx.S: Assembler messages:
> > >    /builds/linux/arch/powerpc/kernel/cpu_setup_6xx.S:124: Error: unrecognized opcode: `sym_func_start_local(setup_g2_le_hid2)'
> > >    /builds/linux/arch/powerpc/kernel/cpu_setup_6xx.S:131: Error: unrecognized opcode: `sym_func_end(setup_g2_le_hid2)'
> > >    make[4]: *** [/builds/linux/scripts/Makefile.build:382: arch/powerpc/kernel/cpu_setup_6xx.o] Error 1
> > > ----->8-----
> > > 
> > > This is seen only on PowerPC with GCC 8, GCC 13, Clang 17, Clang nightly, on:
> > > * allnoconfig
> > > * tinyconfig
> > > * mpc83xx_defconfig
> > > * ppc6xx_defconfig
> > > (at least)
> > > 
> > > Reproducer:
> > > 
> > >    tuxmake \
> > >      --runtime podman \
> > >      --target-arch powerpc \
> > >      --toolchain gcc-8 \
> > >      --kconfig tinyconfig
> > > 
> > 
> > Bisection points to:
> > 
> >    commit a65d7a833f486d0c162fdc854d2d5dd2e66ddd95
> >    Author: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> >    Date:   Wed Jan 24 11:38:38 2024 +0100
> > 
> >        powerpc/6xx: set High BAT Enable flag on G2_LE cores
> >        
> >        [ Upstream commit a038a3ff8c6582404834852c043dadc73a5b68b4 ]
> > 
> > 
> > Reverting that commit makes the build pass again.
> 
> It seems that backporting the mentioned commit verbatim would also require
> 2da37761671b5bdedbe04e6469cfa57cd6b6ae45 ("powerpc/32: Fix objtool unannotated intra-function call
> warnings") to make SYM_FUNC_START_LOCAL/SYM_FUNC_END available. Please drop this patch from 6.1 and
> older for now.

Now dropped, thanks!

greg k-h

