Return-Path: <linux-kernel+bounces-125963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 99171892EB4
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 07:57:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAB401C20B7B
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 05:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B45C7490;
	Sun, 31 Mar 2024 05:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNclNJZg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A16751FA5;
	Sun, 31 Mar 2024 05:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711864632; cv=none; b=ZW38HUr/o+jkA9B2bu3be2rcYegaVKJ7VRduTVbk8apTeqHnOWVh/j/XtOh8bmN/YLRAnBIYs0tTHYJQTs4gj2bZyve4Oo1xhWgfmaDrkCeu/JI6W/omwCDTJtu6+nUnLYyzHT/SdapbZTyNekRvVy3nuMW2cYz5jOYgshHxm4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711864632; c=relaxed/simple;
	bh=7w6jg6OmB2qnyRYmKgtEEoQj+UdPBhumHjjeDUqYjNY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=rB5TJDhtssy3jucUc+g9QkgXF1MRY+EmSJZosQfSjeOpsqmUTzbPscwawV1mBoF+8IxvKsPPIg6a5lg6TvSO8Z3C9g6/QD1PbsFYnI4vz/SbK/NTFzoj0WkkPmv/1T247/JWTwOWLoAat/O2IIZ72zx3omIbuzphRhkUaML4q9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNclNJZg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B460C433C7;
	Sun, 31 Mar 2024 05:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711864632;
	bh=7w6jg6OmB2qnyRYmKgtEEoQj+UdPBhumHjjeDUqYjNY=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=oNclNJZgbWqAMSgkEDQHSPMGSQ3TqFZHv2rvBYS5H5kRsUYKc+7fR5zCcSn9YKwLl
	 Zn7aWKzFzNUwOR9yQS+yW57zFcJHE6hHCuBibUA4kluUTjhMH0kSjKBX+CO7pby76a
	 BnmnasM/Lr0JgqpAuMX1SSgsuxpRbI5KKCi0qf5FQ+69nxHzNEW5kGTG2R2fybrzE6
	 iMf8UzGu42xxw+IV3+TbbQbjkuU2UdfHlAaLXcwKqufWke9CnDo9zW5JtAzoJ54G+Q
	 yxHYw7w65f4pE8ObZg/iXeyTMYX9SHimMlNYvwF1GdzcHuVtIGqZ1FGney2qBl8+QZ
	 0SKLvwis3CS4g==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 31 Mar 2024 08:57:08 +0300
Message-Id: <D07PD5NTOXSQ.30D5V19O6KMQS@kernel.org>
Subject: Re: [GIT PULL] tpmdd changes for v6.9-rc2
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>, <dhowells@redhat.com>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 "David Howells" <dhowells@redhat.com>, <linux-integrity@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <keyrings@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240326143838.15076-1-jarkko@kernel.org>
 <CAHk-=wgNpPQFJyLe5dwEVH66ubviuiwM1_tjbyzQv4BytPw7dQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgNpPQFJyLe5dwEVH66ubviuiwM1_tjbyzQv4BytPw7dQ@mail.gmail.com>

On Sun Mar 31, 2024 at 12:32 AM EET, Linus Torvalds wrote:
> On Tue, 26 Mar 2024 at 07:38, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git =
tags/tpmdd-v6.9-rc2
>
> So I haven't pulled this, because the subject line (and tag name)
> talks about tpmdd, but this is clearly about key handling.

OK, point taken and it is evolutionary issue really but definitely
needs to be fixed.

I review and test most of the stuff that goes to keyring but other
than trusted keys, I usually pick only few patches every now and
then to my tree.

So obviously we need better grounds for putting this content together.
So probably fastest path to that would be if e.g. David just opens me
push rights to his tree, and then i push the stuff that makes sense
to me to some branch in that tree.

In other words: David would take care of sending the final PR.

As per trusted keys, should I start to make a separate "trusted keys
PR" with its own separate tag? It's fine with me but I just need to
know how to move forward. E.g. now there is one new hardware backend
upcoming for trusted keys so now it is good to realig if any need.




>
> Also, the actual contents seem to be very much an "update", not fixes.
> And it doesn't seem to be an actual improvement, in how it now does
> things from interrupts. That seems to be going backward rather than
> forward.

That's fine and can cope with this np but yeah the first paragraph is
something we need to tackle now :-)

>
>             Linus

BR, Jarkko

