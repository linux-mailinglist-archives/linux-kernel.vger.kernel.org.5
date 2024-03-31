Return-Path: <linux-kernel+bounces-126092-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 509D5893212
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:36:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 023DA1F214DE
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 15:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23098145342;
	Sun, 31 Mar 2024 15:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcaeLPw3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B7814532F;
	Sun, 31 Mar 2024 15:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711899409; cv=none; b=XGXBGhLGc7rVTgbQUWboLROSuPKYk8Aedsql7ZUfaO7nkoVRiZ/m2HzE8At3uw53ChQ1pfcCMVfbCwkp/hFVEz9md6Gf4+zdDgbz9HkxKPRiSQ/JXRBB6gqsRggP75tTpuxEssPPcdQJN2xodJJjEwsMygIm6DZ1KhCstTm1Avo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711899409; c=relaxed/simple;
	bh=EO0diDbRgsZEbN2TcPtZ7YLdJoEklsL6WFWb3kUz6HI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=GV0X/CAf41Kz7pNs0R6/F3+/gPYd0e96N8+GRQXlEAymN8XmPcJP3xJVszePwitmz2S+/9FxXU+v5YkL6VK56NbgjZkZlGbw7Otfn5m4p0SJQm00Y8iSRSdiwMkykmKBdU1Zb8TTwY7WCyD25ZeUGuicYGUoNqs3cu7CwsXdT7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcaeLPw3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36D0AC433C7;
	Sun, 31 Mar 2024 15:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711899408;
	bh=EO0diDbRgsZEbN2TcPtZ7YLdJoEklsL6WFWb3kUz6HI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=BcaeLPw36L04BNIfVEGloxji4Zr3k542ti7bKCWs+oUhFfDM2oNUEEoyvQh41ZOI4
	 5ZZ+R/ZDo0VZGIO4I+Z7zAh5WCU5MIHwavTwvsMgvVKPiM7ugac3z6jZIbV8AOCG5h
	 YQNYb7TnChvt1vHryDczJ+Q57oDSAOiQ8+GYg+6yK4lLcBIorcWqddTCf2tYhFxQxs
	 tDvXr83DGvY2l9Z4bwd/HlFtHmm7Wjwtos3Is32h8Ygdj+ARLcmmRyeeW7zBLBuqJA
	 hfOxXOjHNo+uKqmu9ydW0WlTNuSExLM3Ul/YLb6K0CrWj7l5DPvjGxW07Sqp+4EhiM
	 aU8hj1IxNPZjw==
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 31 Mar 2024 18:36:45 +0300
Message-Id: <D081OXSNVFWG.3QW7GEWS2QYAB@kernel.org>
Cc: "Peter Huewe" <peterhuewe@gmx.de>, "Jason Gunthorpe" <jgg@ziepe.ca>,
 <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <keyrings@vger.kernel.org>
Subject: Re: [GIT PULL] tpmdd changes for v6.9-rc2
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, <dhowells@redhat.com>
X-Mailer: aerc 0.17.0
References: <20240326143838.15076-1-jarkko@kernel.org>
 <CAHk-=wgNpPQFJyLe5dwEVH66ubviuiwM1_tjbyzQv4BytPw7dQ@mail.gmail.com>
 <D07PD5NTOXSQ.30D5V19O6KMQS@kernel.org>
In-Reply-To: <D07PD5NTOXSQ.30D5V19O6KMQS@kernel.org>

On Sun Mar 31, 2024 at 8:57 AM EEST, Jarkko Sakkinen wrote:
> On Sun Mar 31, 2024 at 12:32 AM EET, Linus Torvalds wrote:
> > On Tue, 26 Mar 2024 at 07:38, Jarkko Sakkinen <jarkko@kernel.org> wrote=
:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.gi=
t tags/tpmdd-v6.9-rc2
> >
> > So I haven't pulled this, because the subject line (and tag name)
> > talks about tpmdd, but this is clearly about key handling.
>
> OK, point taken and it is evolutionary issue really but definitely
> needs to be fixed.
>
> I review and test most of the stuff that goes to keyring but other
> than trusted keys, I usually pick only few patches every now and
> then to my tree.
>
> So obviously we need better grounds for putting this content together.
> So probably fastest path to that would be if e.g. David just opens me
> push rights to his tree, and then i push the stuff that makes sense
> to me to some branch in that tree.
>
> In other words: David would take care of sending the final PR.
>
> As per trusted keys, should I start to make a separate "trusted keys
> PR" with its own separate tag? It's fine with me but I just need to
> know how to move forward. E.g. now there is one new hardware backend
> upcoming for trusted keys so now it is good to realig if any need.

Also using separate tag works for me. These changes are synced
in all cases (I sync up with David or vice-versa) so that is
equally good as far as I'm concerned.

BR, Jarkko

