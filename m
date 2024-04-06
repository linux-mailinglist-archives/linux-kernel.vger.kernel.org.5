Return-Path: <linux-kernel+bounces-133841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 002C189A99B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 09:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9581A1F22475
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 07:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFB3B2836D;
	Sat,  6 Apr 2024 07:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="AGXSoiWO"
Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857B222EF4;
	Sat,  6 Apr 2024 07:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712389501; cv=none; b=L0N43fz09ia5MrEOgmBGV0J5FWbsmTuUD5Hitdt0BA2dEINye25uyWdCP8Xdw6I6SVDnRpK+371fSh3q4X9WEZN7aLtXYIKTZWN4SNDNOP8yYKlSjLkQMp6/evjHZGphFwvJNK3Ms4MG9i77KaVnzXaWp7f07ZoZvCoDukYWVVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712389501; c=relaxed/simple;
	bh=bv00TIb4GiZh1yN2UePLDExfIIgWKvhzD46SDHmzgHc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DdFkGhFNqpkMKJGd+5bVgOzbizWEaUS35t8Q9zuzI9d/fjlePRs2Ws/fFv3jnDJAgR+fYQLxtZ1xTxr7DggBLM30suEMxvY2iTmhoETkOVOVwLxqaP95JaHEMx4/uHq8LaiASq/31UobD9hYXXre6dU0Kd7wODNSAMuIa3ZjxvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=AGXSoiWO; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id F3FD11B18CE;
	Sat,  6 Apr 2024 09:44:49 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1712389490; bh=mNp+ImAS7xB+lsKKsyoHRq0t1TQ5mzQI20TvQDfDTZc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AGXSoiWOgQ9Z1Q1I65hFjuaFWQTHBWCAF1mH9+oPFb35QTZGCAAgUthWBAGqKGrsD
	 4BBjDnW0GD35OwDn/fSg9eO5d7vKIgtj7nri26v3gOXGWdBrFTPgCRallgol9sxGsy
	 hAEwt0nX9vVtCTOMs8F7HsFMBjrowJk3Yr/GOPvcjW/ZjEXL7XFeX7RZBXNVhEn9FT
	 jGPEyN7mNdhzJKbg65V/HXzZkoMhOg7RcZ8pMC2YozAlxGPpHzZbp4IxEIS/q9DFvj
	 MgeVpvijPdXbyQx8ScY88IoI31hNXxtpquWkFKIjV8Frql87nYcZTb28fZ9Kc8m1Gl
	 W4mLkM0pzGLsQ==
Date: Sat, 6 Apr 2024 09:44:49 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, open list
 <netdev@vger.kernel.org>, Linux regressions mailing list
 <regressions@lists.linux.dev>, open list <linux-kernel@vger.kernel.org>,
 "Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>
Subject: Re: [PATCH net] u64_stats: fix u64_stats_init() for lockdep when
 used repeatedly in one file
Message-ID: <20240406094449.1ac182d0@meshulam.tesarici.cz>
In-Reply-To: <CANn89iLZ9rkSpT6crP89RV-GPSnSxhUkjPSSh3PmiLNDH103yQ@mail.gmail.com>
References: <20240404075740.30682-1-petr@tesarici.cz>
	<CANn89iLZ9rkSpT6crP89RV-GPSnSxhUkjPSSh3PmiLNDH103yQ@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Apr 2024 23:08:58 +0200
Eric Dumazet <edumazet@google.com> wrote:

> On Thu, Apr 4, 2024 at 9:58=E2=80=AFAM Petr Tesarik <petr@tesarici.cz> wr=
ote:
> >
> > Fix bogus lockdep warnings if multiple u64_stats_sync variables are
> > initialized in the same file.
> >
> > With CONFIG_LOCKDEP, seqcount_init() is a macro which declares:
> >
> >         static struct lock_class_key __key;
> >
> > Since u64_stats_init() is a function (albeit an inline one), all calls
> > within the same file end up using the same instance, effectively treati=
ng
> > them all as a single lock-class.
> >
> > Fixes: 9464ca650008 ("net: make u64_stats_init() a function")
> > Closes: https://lore.kernel.org/netdev/ea1567d9-ce66-45e6-8168-ac40a47d=
1821@roeck-us.net/
> > Signed-off-by: Petr Tesarik <petr@tesarici.cz> =20
>=20
> I thought I gave a Reviewed-by: tag already...

You did, but at that time I didn't know which tree should be used to
merge the patch, so it appeared as a stranded patch on LKML. Once we
agreed it should go through net, I sent it again, but the resend didn't
have it.

Thanks for your assistance!

Petr T

> Reviewed-by: Eric Dumazet <edumazet@google.com>


