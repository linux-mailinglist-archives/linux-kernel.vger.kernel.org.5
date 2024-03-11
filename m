Return-Path: <linux-kernel+bounces-99529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23258789A4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 21:44:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19D211C210A0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 20:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5C352F82;
	Mon, 11 Mar 2024 20:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKI/BRla"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB6D3C0C;
	Mon, 11 Mar 2024 20:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710189877; cv=none; b=FCToJvoTGTp6TRf1v8z9yK/xu5QehBjFR8S0DuFLGxdrt5rR9UjCKyuGIBpjRGulEjJkSzJ5gQ4SKk03qMY9ETMFG+kT05Ss7nfTX8iuqyjzcwSqKCYLY14x1DdBHuHUVZI6APQclAIE0ITWXHA8nRxDY4LTv9cOmIrYesK3Yvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710189877; c=relaxed/simple;
	bh=fcJhJ0MWCqBw8chXp9vtaAHiJeUJVUgJd4Am03lKKY8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tPsGWd7BEwu5aQbsyPH74y2iu7LKZJIJWNTiiL2crUZalC/g/4w/GumNOg+crP4P9uw72/i4E7SL+8QbMsxKKWOMlm4aQ9DVBxuvwTcI2Pg7rE5mYX0fODgbOnMbpGMAq/9vjK1AXjYhZQ7HkVrL+l2wzKc1vVtR2a14pV5T4YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKI/BRla; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6510AC433C7;
	Mon, 11 Mar 2024 20:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710189876;
	bh=fcJhJ0MWCqBw8chXp9vtaAHiJeUJVUgJd4Am03lKKY8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HKI/BRlaYOLgO54Igy/9p4OLYto4NXnD0zMA2B+E6q9lunvb+oDIz/ttQoiSnPfMg
	 xpPgG/W7cTne0xDiMcRLUBh5IcD65aAbWFyVdS5g8TEdYfr3dD8KZCBvd8YF0//cPm
	 zeVzTK3wkjox4uGnlE5vT/yMJasMJY3D9rSRfEVS6wLgCPAoXUTSMzrbUkNSxwE3Kc
	 R2yIxFi6LbcRsD7KJuns4iHm/AB8rRiCy7Cln/00OYyB6wlHvCjeOhx7jYq2e5EXVK
	 J2e8Pk/Cv5YIWdFh8+xwkwlFFQbA6ki1mLYc06+hpBjlwXmydC3OOnp1tK6H3BsDZV
	 4NYG91Gx6B2dg==
Date: Mon, 11 Mar 2024 13:44:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Daniel Borkmann
 <daniel@iogearbox.net>, Vlad Buslov <vladbu@nvidia.com>, Marcelo Ricardo
 Leitner <mleitner@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, llu@fiberby.dk
Subject: Re: [PATCH net-next v3 0/3] make skip_sw actually skip software
Message-ID: <20240311134435.19393f98@kernel.org>
In-Reply-To: <20240306165813.656931-1-ast@fiberby.net>
References: <20240306165813.656931-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  6 Mar 2024 16:58:08 +0000 Asbj=C3=B8rn Sloth T=C3=B8nnesen wrote:
> During development of flower-route[1], which I
> recently presented at FOSDEM[2], I noticed that
> CPU usage, would increase the more rules I installed
> into the hardware for IP forwarding offloading.
>=20
> Since we use TC flower offload for the hottest
> prefixes, and leave the long tail to the normal (non-TC)
> Linux network stack for slow-path IP forwarding.
> We therefore need both the hardware and software
> datapath to perform well.
>=20
> I found that skip_sw rules, are quite expensive
> in the kernel datapath, since they must be evaluated
> and matched upon, before the kernel checks the
> skip_sw flag.
>=20
> This patchset optimizes the case where all rules
> are skip_sw, by implementing a TC bypass for these
> cases, where TC is only used as a control plane
> for the hardware path.

Linus tagged v6.8 and the merge window for v6.9 has started.
This feels a bit too risky for me to apply last minute,
could you repost in 2 weeks once the merge window is over?
--=20
pw-bot: defer

