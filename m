Return-Path: <linux-kernel+bounces-166301-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 828748B98C0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 12:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F551C219A7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 10:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C409458AC3;
	Thu,  2 May 2024 10:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b="IhQcEI+/"
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF2F5490A;
	Thu,  2 May 2024 10:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.133.4.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714645618; cv=none; b=rvBbilBDF9+H3i1qkG75JL9ZuQDCqIxcUsTza8stKH15iMPa4R9Y4fGD9LxKJLOl/6TQ2F0KJKbZO6Ny4BP5GUZiOn/TzDVEWt3VCiQdUkfXwMzj0KFUtY4DaAnRXbzNfFsR5nmbdDL0ua+rK4AYoYXAdUjhpAD5EcKS0bcUN1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714645618; c=relaxed/simple;
	bh=vsokJlEAs2pLfpkrKP3KPyZHTycX48VeFSxd1MFdfcw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mMhnjDqADKOUkpU9MS1jcvDoEw0YsB99BZGjBNHQLBChjh63mB3WNUoJEbm5AScF24nRIqkknuVfyF6iM4vbGWa1Mdh9QU+tQFrzZpey1W9WxpkAgUKc3235WypmdqImHWZCUISh+fDr8X4reBrcqxJIkcEOr18sqJVvFo9c1nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de; spf=pass smtp.mailfrom=zedat.fu-berlin.de; dkim=pass (2048-bit key) header.d=fu-berlin.de header.i=@fu-berlin.de header.b=IhQcEI+/; arc=none smtp.client-ip=130.133.4.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=physik.fu-berlin.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zedat.fu-berlin.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=fu-berlin.de; s=fub01; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WL4pbRyudVWidx2o5kr5Q1pZoZ/278JM0VwjKQ5brso=; t=1714645615; x=1715250415; 
	b=IhQcEI+/vG0G5RjW3QFo3u9Weyk3uu23uCh2aUpOhilJd2hVkfKyOo7Vfl80/hN8SEQI46/Rujz
	wrhPOmDP93I6L9RY6gg6PzXrMayCFdAnPX+IRCNURMF3uimCg40pbzrMWNuqAqV5mE1WrTSnQqeMj
	grtAIwWDgALOQjwXwyrGuvbWSf03juWiWDMXJoJ4ZvvAMkmWgDSeEWQeAgAVQatMnY9e2UjsWX28N
	JYmFr7o0e2pT9aB7BIR3AcrSfYJ88NGqNvYQQ45eY3lQVbTkHEccbqVxLmGiBy56SeJyJAcdsQpg8
	0NiwsU1gU7Z5YrUmbzxb+kOJ71LgqpiBy3EA==;
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.97)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1s2TeN-00000001xZc-3m9C; Thu, 02 May 2024 12:26:51 +0200
Received: from p57bd90e8.dip0.t-ipconnect.de ([87.189.144.232] helo=[192.168.178.20])
          by inpost2.zedat.fu-berlin.de (Exim 4.97)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1s2TeN-000000007IT-1iDt; Thu, 02 May 2024 12:26:51 +0200
Message-ID: <84b635b9706205147038bbc152aee4a2da92c2ac.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 0/7] sh: Fix missing prototypes (part two)
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: Geert Uytterhoeven <geert+renesas@glider.be>, Yoshinori Sato
	 <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, Arnd Bergmann
	 <arnd@arndb.de>
Cc: linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 02 May 2024 12:26:50 +0200
In-Reply-To: <cover.1709579038.git.geert+renesas@glider.be>
References: <cover.1709579038.git.geert+renesas@glider.be>
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

On Mon, 2024-03-04 at 20:10 +0100, Geert Uytterhoeven wrote:
> 	Hi all,
>=20
> This patch series fixes more "no previous prototype for <foo>" warnings
> when building a kernel for SuperH, and is a follow-up to [1].
>=20
> This has been boot-tested on landisk and on qemu/rts7751r2d.
>=20
> Thanks for your comments!
>=20
> [1] "[PATCH 00/20] sh: Fix missing prototypes"
>     https://lore.kernel.org/r/cover.1709326528.git.geert+renesas@glider.b=
e>
>=20
> Geert Uytterhoeven (7):
>   sh: cache: Move forward declarations to <asm/cacheflush.h>
>   sh: traps: Make is_dsp_inst() static
>   sh: mach-highlander: Add missing #include <mach/highlander.h>
>   sh: mach-sh03: Make sh03_rtc_settimeofday() static
>   sh: sh7757lcr: Make init_sh7757lcr_IRQ() static
>   sh: sh7757: Add missing #include <asm/mmzone.h>
>   sh: sh7785lcr: Make init_sh7785lcr_IRQ() static
>=20
>  arch/sh/boards/board-sh7757lcr.c                |  2 +-
>  arch/sh/boards/board-sh7785lcr.c                |  2 +-
>  arch/sh/boards/mach-highlander/pinmux-r7785rp.c |  1 +
>  arch/sh/boards/mach-sh03/rtc.c                  |  2 +-
>  arch/sh/include/asm/cacheflush.h                | 12 ++++++++++++
>  arch/sh/kernel/cpu/sh4a/setup-sh7723.c          |  3 +++
>  arch/sh/kernel/cpu/sh4a/setup-sh7724.c          |  1 +
>  arch/sh/kernel/cpu/sh4a/setup-sh7757.c          |  3 +++
>  arch/sh/kernel/traps_32.c                       |  4 ++--
>  arch/sh/mm/cache-sh4.c                          |  2 --
>  arch/sh/mm/cache-shx3.c                         |  1 +
>  arch/sh/mm/cache.c                              | 14 --------------
>  12 files changed, 26 insertions(+), 21 deletions(-)

Applied to my sh-linux tree in the for-next branch.

Thanks,
Adrian

--=20
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

