Return-Path: <linux-kernel+bounces-165636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B8C3B8B8EEA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 19:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 596A91F21FA3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 17:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83947182DF;
	Wed,  1 May 2024 17:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="cHhxykkL"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFAFDDAB;
	Wed,  1 May 2024 17:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714583909; cv=none; b=DAfGuaE+7Y2JFQjzJQsnBFoF6D8rjmFPl0xeUzeKFaWgIACy3UJSvpmlromf1LWhlcrWTsmUKn2ChnvF1LxsF7Oz1sOpShdJYjzkRJwoqopPESbDL7DxXeZ30MwVusfBgy+IjkTAE9uYrGrLw416p9cQ9li4qAFUe21Fghf/gV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714583909; c=relaxed/simple;
	bh=Q+1d4Gnsr2lrEMS3UmDxaI6tEyeZXyIHtm2WulLERJQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LNHN8LfTLTxmIKh25Fl9JQ6sCfHBO5D6Glvf2odIeakeLztBdKgxRsrP+aDrHkEZ9dB2e2qz0gZuuiL3bz3Fig8H39AN2Xp4YdkdTmixpTEm4njUFhQqpfZ+lQBluDFIuRC5/RkS+wkbXErI2tUYIKhVnTxRJnPwfJjUx7u1mFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=cHhxykkL; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=uIgYMEKuj7hxe92rvJmgWaiFo3MDqmc6kRLX2X0/8qs=; t=1714583906; x=1715188706; 
	b=cHhxykkL5qL+l4V6dKsWLWZ6wXCo5kbcczhVAM6MffKYgvoqSWdc4WsrgOJeF4kOHq2bsDaaGjx
	GcKh5OfgylF5xqVKmNE4adXmRdfdWk2sRpD9h3zPvgC0ZXL9I3De4T25tivZBLl1zh2vIUE3+mb6J
	zEjtgKx2BTKT8QcBLTRyjDbhKqRRQz8Qs3s3sO1GWo7NFkbJn9J122XcbvwHQMlDQ29Hc9ATzUKad
	3iRCSdJQtxYNhn/o6SW0hoiwTyE2EWzj8OrySZEbQt5pmLd/rIB1lgTNBJUdG7oKbPCi8YdpmO53h
	4JgcdR+KLhiAQZ1VFYxs6ice2qs+GZXKSqug==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s2Db4-00000001w6i-3M2S; Wed, 01 May 2024 19:18:22 +0200
Received: from p57bd90e8.dip0.t-ipconnect.de ([87.189.144.232] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s2Db4-00000001i3u-2CVD; Wed, 01 May 2024 19:18:22 +0200
Message-ID: <72ec7831604326e852eb228072b1d817bab829fb.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2] sh: Call paging_init() earlier in the init sequence
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Oreoluwa Babatunde <quic_obabatun@quicinc.com>, 
	ysato@users.sourceforge.jp, dalias@libc.org
Cc: akpm@linux-foundation.org, linux-sh@vger.kernel.org, 
 linux-kernel@vger.kernel.org, robh+dt@kernel.org, kernel@quicinc.com, Rob
 Herring <robh@kernel.org>, Rob Landley <rob@landley.net>
Date: Wed, 01 May 2024 19:18:21 +0200
In-Reply-To: <20240423233150.74302-1-quic_obabatun@quicinc.com>
References: <20240423233150.74302-1-quic_obabatun@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-ZEDAT-Hint: PO

Hi Oreoluwa,

On Tue, 2024-04-23 at 16:31 -0700, Oreoluwa Babatunde wrote:
> The unflatten_device_tree() function contains a call to
> memblock_alloc(). This is a problem because this allocation is done
> before any of the reserved memory is set aside in paging_init().
> This means that there is a possibility for memblock to allocate from
> any of the memory regions that are supposed to be set aside as reserved.
>=20
> Hence, move the call to paging_init() to be earlier in the init
> sequence so that the reserved memory regions are set aside before any
> allocations are done using memblock.

I was just about to merge your patch when I ran a git blame on the code in
arch/sh/kernel/setup.c and noticed the following commit by Rich Felker:

commit eb6b6930a70faefe04479a71088cc10366782d9a
Author: Rich Felker <dalias@libc.org>
Date:   Mon Jul 31 01:27:50 2017 -0400

    sh: fix memory corruption of unflattened device tree
   =20
    unflatten_device_tree() makes use of memblock allocation, and
    therefore must be called before paging_init() migrates the memblock
    allocation data to the bootmem framework. Otherwise the record of the
    allocation for the expanded device tree will be lost, and will
    eventually be clobbered when allocated for another use.
   =20
    Signed-off-by: Rich Felker <dalias@libc.org>

It looks like that the call to unflatten_device_tree() before paging_init()
is intentional and needed for the device tree to be preserved in memory
after running paging_init().

@Geert: Do you have any comments on this patch?
@Rob: Could you test this patch on your J2 board and report back?

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

