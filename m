Return-Path: <linux-kernel+bounces-56079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EB71384C5A9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 08:32:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48017B26B27
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 07:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00E11F958;
	Wed,  7 Feb 2024 07:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AP/KQB0c"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0E11F944
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 07:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707291114; cv=none; b=nBxNVaK04MlyKV18Hj+JNwFeK3djBbrjeNQ5AXEvlCrcJY2FwnxxrIOWc8laCh5poHFTCOBH8VGvZBdNxAuECuK3e/bcrjOYxzGUzqAXNBAJmUufNdISjUz0GYtw0wwoDCGDqEFb5g2F7/pB7L47Fp5mQXcrxOu88WKS3jOSyxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707291114; c=relaxed/simple;
	bh=vp7VHi0c5IIQULsvLjc3Nr5nJVCOlHEIEdYOhJMfoTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xo2P4NqivgE1LheuqHaOohEbil3HqHAdLIf7Yg8aFOQ8BaLfz6WYNmSkozZ3a1sraHjbi5BKXuCJQCJFv7Jj1z0ProVmGLBJsmwO8mAjpug8dw2ir5MODzYERFS7mgBdZ87sVxK8apWOwfZEeDYNbV5n3J5cDYfep+S6f/e97Sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AP/KQB0c; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=VBy0lm1YU3coKSkFq55oL6SDo4AuSJkW2B09HFeXe1s=; b=AP/KQB0cUwVhwXyVG15RN0C/OC
	dlgge4Clq7o0kmod9h+xTi2Zh0xUzGi0p9bq+ziIilAVlR0Y50IY/zLHc1hoU+6Jzg6u4VcFOqD2L
	ExB8AjF4IDLH7TLYUl7Lre2/Dg6r3zwzScGCKz50hFBMRhfOMFtjo9vQOba+Tn7QsS9ycES8sqJep
	K9gHzc2OQ5c1I/1h33Tk8h/Itk4kGxhUO4q8XeV2KWxvETbUdRJiRbGENaGGrWPzGQyAgwr8+BWhM
	ngpd/FcK9kAAZWKmi3MfNioghK5cY1BhETIz7l98MP0d86CmQi+jAaW42qagmIm1tvsGn68fZSRl9
	ZfZgc/Sw==;
Received: from fpd2fa7e2a.ap.nuro.jp ([210.250.126.42] helo=[192.168.1.6])
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXcPD-0000000Cs4G-352s;
	Wed, 07 Feb 2024 07:31:40 +0000
Message-ID: <dcca34fc-18b9-471f-82ed-3d455587ad8d@infradead.org>
Date: Wed, 7 Feb 2024 16:31:32 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/ps3: select VIDEO to provide cmdline functions
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>,
 "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Thomas Zimmermann <tzimmermann@suse.de>
References: <20240207033744.13028-1-rdunlap@infradead.org>
Content-Language: en-US
From: Geoff Levand <geoff@infradead.org>
In-Reply-To: <20240207033744.13028-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 2/7/24 12:37, Randy Dunlap wrote:
> When VIDEO is not set, there is a build error. Fix that by selecting
> VIDEO for PS3_PS3AV.
> 
> ERROR: modpost: ".video_get_options" [drivers/ps3/ps3av_mod.ko] undefined!
> 
> Fixes: dae7fbf43fd0 ("driver/ps3: Include <video/cmdline.h> for mode parsing")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Cc: Naveen N. Rao <naveen.n.rao@linux.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: Geoff Levand <geoff@infradead.org>
> ---
>  arch/powerpc/platforms/ps3/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff -- a/arch/powerpc/platforms/ps3/Kconfig b/arch/powerpc/platforms/ps3/Kconfig
> --- a/arch/powerpc/platforms/ps3/Kconfig
> +++ b/arch/powerpc/platforms/ps3/Kconfig
> @@ -67,6 +67,7 @@ config PS3_VUART
>  config PS3_PS3AV
>  	depends on PPC_PS3
>  	tristate "PS3 AV settings driver" if PS3_ADVANCED
> +	select VIDEO
>  	select PS3_VUART
>  	default y
>  	help

Seems good.

Acked-by: Geoff Levand <geoff@infradead.org>



