Return-Path: <linux-kernel+bounces-166992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C34B8BA30C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 00:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35AC51C21525
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 22:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB1657CAC;
	Thu,  2 May 2024 22:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aT15/1MI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B926557C87;
	Thu,  2 May 2024 22:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714688284; cv=none; b=uD2VFAyRJxVqSZOB2HvnJiVijdl+KJoVFdPxvO7s3/IApZnmBRjtvOXjs9SFctKePAF6aY7bgNOCDALOTONer2ZspM/ZlmolDDHNpc16pcCHFEMrtR84tEOQXxU0BNZZb9yh8q6sQH3dujlRa/VGEdNjxDLMlDDYePkltN+duJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714688284; c=relaxed/simple;
	bh=nSbGf7eXvsPQVd66lCd4VpOIjVzzxqvSc9uW1Yf03dA=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=brPoXGVSP83gzyhX1m5BYXsSsyJWMDULe0Lx250VUEDEJIJAypWiNEsqvoZl4q/k9WBhxP0mFKtboLXRH10/ief2/tosRSdVukc5c8+LM6PMSysH0lv3V0fnD1jB1NpYAucYIksEa9ahAiBxWCqjsSoVByOPtocSqY8fmTt0TbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aT15/1MI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC12C113CC;
	Thu,  2 May 2024 22:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714688284;
	bh=nSbGf7eXvsPQVd66lCd4VpOIjVzzxqvSc9uW1Yf03dA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=aT15/1MIAmCfgLum4oxM5pHXZm+TqfRNwxiDosqUNA8ITvgDErXYRRQvk+4D+2dve
	 1+UkVQxGjWLQqfjcpyVdwveB5ShVIrZhkS29XCKIm5CDwX04eO7YA61DTHrCbUvXpW
	 mPJxhumMdVnlMXxsrB77c5cUDnJa9gRVOfCBqpMgru6+lnBWec8LtV3un9BYz9+Ysv
	 Lo0m3xvIN9A2JvJyWee2u5Xh7WAjocUZIsJZErzgLAd+LMhhblcBkg2b0bF6YSpk8s
	 4B326zBWZLJn2V2yyPx7+Q5Z7taR3vo8Ixmyo8x9RrVi/BFiW95Rj1BgWjeEeCEnIx
	 ljAISEJOdZH/A==
Message-ID: <0628b0141236db57156d744727df0c48.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZjN0NkYifXY0OsZt@shell.armlinux.org.uk>
References: <E1rl62V-004UFh-Te@rmk-PC.armlinux.org.uk> <e15b8a1165a5437ab1fa868ccd0b629c.sboyd@kernel.org> <560549ed7db5da2f2727dc053a5d196d.sboyd@kernel.org> <ZjNIiDeXIjXhJlT4@shell.armlinux.org.uk> <ZjNNT+KBNpQL+U3b@shell.armlinux.org.uk> <ZjN0NkYifXY0OsZt@shell.armlinux.org.uk>
Subject: Re: [PATCH] clkdev: report over-sized strings when creating clkdev entries
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, Duanqiang Wen <duanqiangwen@net-swift.com>, mturquette@baylibre.com, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To: Russell King (Oracle) <linux@armlinux.org.uk>
Date: Thu, 02 May 2024 15:18:02 -0700
User-Agent: alot/0.10

Quoting Russell King (Oracle) (2024-05-02 04:08:38)
> On Thu, May 02, 2024 at 09:22:39AM +0100, Russell King (Oracle) wrote:
> > On Thu, May 02, 2024 at 09:02:16AM +0100, Russell King (Oracle) wrote:
> > > On Wed, May 01, 2024 at 06:02:54PM -0700, Stephen Boyd wrote:
> > > > Quoting Stephen Boyd (2024-05-01 17:59:16)
> > > > > Quoting Russell King (Oracle) (2024-03-15 04:47:55)
> > > > > > Report an error when an attempt to register a clkdev entry resu=
lts in a
> > > > > > truncated string so the problem can be easily spotted.
> > > > > >=20
> > > > > > Reported by: Duanqiang Wen <duanqiangwen@net-swift.com>
> > > > > > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.u=
k>
> > > > > > ---
> > > > >=20
> > > > > Applied to clk-next
> > > > >=20
> > > >=20
> > > > And backed out because I get a compilation failure
> > > >=20
> > > > drivers/clk/clkdev.c: In function 'vclkdev_alloc':
> > > > drivers/clk/clkdev.c:182:17: error: function 'vclkdev_alloc' might =
be a candidate for 'gnu_printf' format attribute [-Werror=3Dsuggest-attribu=
te=3Dformat]
> > > >   182 |                 res =3D vsnprintf(cla->dev_id, sizeof(cla->=
dev_id), dev_fmt, ap);
> > > >       |                 ^~~
> > > > cc1: all warnings being treated as errors
> > > > make[5]: *** [scripts/Makefile.build:244: drivers/clk/clkdev.o] Err=
or 1
> > > > make[4]: *** [scripts/Makefile.build:485: drivers/clk] Error 2
> > >=20
> > > It builds fine for me. I don't get this _error_, and it's really no
> > > different from what it originally was - instead of using vcsnprintf()
> > > we're now using vsnprintf(). That should make no difference what so
> > > ever.
> >=20
> > ... and I've just checked, and it builds entirely cleanly for me.
> >=20
> > I'll merge it.
>=20
> It should be in tonight's linux-next tree.

Ok thanks

>=20
> I also note... the kernel build bot never flagged the above, not even
> a warning for it, and it would've built the patch as it was Cc'd to
> linux-kernel.

Indeed. I see a report here[1] but it's only a warning. And there was
some work a few years ago[2] that I forgot about. Seems there was a
possible fix[3] as well.

> So my conclusion is the error you are seeing is somehow
> specific to your environment. Maybe you're building with an additional
> set of warning flags and -Werror?
>=20

Yes I build with W=3D1 but I didn't think that turned warnings into
errors. Maybe that part is new.

[1] https://lore.kernel.org/all/202403110643.27JXEVCI-lkp@intel.com/
[2] https://lore.kernel.org/all/20210310085937.GF4931@dell/
[3] https://lore.kernel.org/all/20221111071809.3440-1-liubo03@inspur.com/

