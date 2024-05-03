Return-Path: <linux-kernel+bounces-167932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFA348BB14A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 18:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A0F21F22BB1
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CFF4157A55;
	Fri,  3 May 2024 16:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="Yjl3UbpW"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DC778276;
	Fri,  3 May 2024 16:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714755450; cv=none; b=WND4QpR/hwcjkofmviKrm4jd+FkoVb0j3AxNurv6c6/ldDaLIowbsr+EEbNlzsldWgv60c5tHJatsvWkpCI03ngL0tEIL+gi2VeS7OOKwuzlnlcTm4ceCkyWT1d50wVdZyIHzxzxCKeeKyB7Qd/zZxMiCLQD5vgGtYz/OILzJeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714755450; c=relaxed/simple;
	bh=ucrXEs+zZhHZbIACJA0Q8StcD9DvMmwHYZhjFRxy19w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Op2fctDJ/Z94NdV5KZSqrJR+unpGwBje5mN3vjC0bWwunxqmZxeCBZtkUSZDWUQfJT0K56iVIVTQjWW8yS9gWcb8/SpnRrLlc6nkIl1bdszJqi3dxyD4O6nxwX0Tec1BvD5v1ZFJjdhzf7dJlO/bNk/pJ7aHqNTHnpzyELHZFOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=Yjl3UbpW; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=HiwZmHGYcEvG/kquEv/XsuMyZc6hfd+7Q7WBI0uslTA=; t=1714755447; x=1715360247; 
	b=Yjl3UbpWYT1Z2arPU06czYgVZSb7vAFZjTSm/lQqLLa308pSgNtQsiRFSd2XMBG6dO8zEQu+QJ6
	KxGOoxpeXo7PcV9f32l/jQZEkF5mxCt5XpULqR+wsPsB3CYtdCYiodwk4LropDQJGe8miQK7elyH9
	LbanJUHaGRPgsS9gv8X8RHxFCDmdeF6uSWkVMV1cWJPMFUJVGUtlNQLc23GR+wk0N/s5XDiaLsiTn
	+oaC/b1waGQ7dJuiacYjSA3XuSbfzYU+zErqowgjewWkFwUkTPlOG3R35KyGzXObB4ce08XAFWxqv
	tKTd9w1r/ZobxVFpt5iCAimNoOh4sNPmpD+w==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s2wAM-00000002YKO-0Q9C; Fri, 03 May 2024 18:53:46 +0200
Received: from p57bd90e8.dip0.t-ipconnect.de ([87.189.144.232] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s2wAL-00000001J2a-3eDt; Fri, 03 May 2024 18:53:46 +0200
Message-ID: <272a909522f2790a30b9a8be73ab7145bf06d486.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 00/14] alpha: cleanups for 6.10
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Arnd Bergmann <arnd@kernel.org>, linux-alpha@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Richard Henderson
 <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
  Matt Turner <mattst88@gmail.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Marc Zyngier <maz@kernel.org>,  Linus Torvalds
 <torvalds@linux-foundation.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
 linux-kernel@vger.kernel.org, Michael Cree <mcree@orcon.net.nz>, Frank
 Scheiner <frank.scheiner@web.de>
Date: Fri, 03 May 2024 18:53:45 +0200
In-Reply-To: <20240503081125.67990-1-arnd@kernel.org>
References: <20240503081125.67990-1-arnd@kernel.org>
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

Hello Arnd,

On Fri, 2024-05-03 at 10:11 +0200, Arnd Bergmann wrote:
> I had investigated dropping support for alpha EV5 and earlier a while
> ago after noticing that this is the only supported CPU family
> in the kernel without native byte access and that Debian has already
> dropped support for this generation last year [1] after it turned
> out to be broken.

That's not quite correct. Support for older Alphas is not broken and
always worked when I tested it. It's just that some people wanted to
raise the baseline in order to improve code performance on newer machines
with the hope to fix some minor issues we saw on Alpha here and there.

> This topic came up again when Paul E. McKenney noticed that
> parts of the RCU code already rely on byte access and do not
> work on alpha EV5 reliably, so I refreshed my series now for
> inclusion into the next merge window.

Hrrrm? That sounds like like Paul ran tests on EV5, did he?

> Al Viro did another series for alpha to address all the known build
> issues. I rebased his patches without any further changes and included
> it as a baseline for my work here to avoid conflicts.

It's somewhat strange that Al improves code on the older machines only
to be axed by your series. I would prefer such removals to aimed at an
LTS release, if possible.

Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

