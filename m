Return-Path: <linux-kernel+bounces-87794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F3D86D918
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9C491F25014
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:43:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7AA36118;
	Fri,  1 Mar 2024 01:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIm6aNNy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE0A2E40E;
	Fri,  1 Mar 2024 01:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709257348; cv=none; b=bncxwX6T8SriFSuqiH8raxMAiAF7Eau79n8Wn3D0Dds5FuEbeT3ZFmog5/ZDCzeeW4YKBkskTs7k7CudttUQjZMei86hQnn/iAeVFYtaxwAL4gqI22EBEG2Csqo4ndLgz1X7n1/nFSAp0Hk2q75r970jelqr5XC6ge11cuF55Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709257348; c=relaxed/simple;
	bh=C6GrbXyKhQ/53cioiYQj+qavhzuh+NWCKiVcOEXlD5U=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=MFqA2YPpp2KfRdnF89RY630CA65MXPD3m8vXxI99cdzzgwedDuD+9GxPUVUsY8yM5mBYwDWQ5EYt5kk1F2rw9uzbKLEKwEYvrOjRtgMT20jffmuHgE5v6KrpSc/GvVSiecXGdEhbOuzaZAZN9Z9NfTX+E5Cojfua2Zi0hRfKR7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIm6aNNy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F8BC433F1;
	Fri,  1 Mar 2024 01:42:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709257347;
	bh=C6GrbXyKhQ/53cioiYQj+qavhzuh+NWCKiVcOEXlD5U=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=qIm6aNNyAeHcfji1JRmEEOg5KuHDf8RZrQHjguspUvQoaJOV11W7tE3dWgZvVgKZa
	 SUSJHk+W/C5/DP3WKmagAKTrwN0s7DxPiy7Pu8e2H3YheCeogVpBE5AhoioT8QzrF4
	 Fcm+NpPcUhIrEKochPofbqJpmHWWLVWGnotKXaHM6m5WwoEP79CZ2NObRL1ye+3NUb
	 gvZhMc7hmaI8CrgzdGdhM/yTGKrjQC8YZ4dCYN8QpzJelz51IpwIjDWF6LCfnTHAWr
	 kdJfmhH3GzeZcunSA37EldSUs+7ghuYiJu/h6HwKklN04wkzHWqVfqjYMBg7FWVp86
	 o/VAjI+RGYURg==
Message-ID: <97787cc46d663b08b2e571841fb1bd6b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <SEZPR06MB69598A991B4CCF633E764CE7965F2@SEZPR06MB6959.apcprd06.prod.outlook.com>
References: <20240224-mux-v1-1-608cc704ef43@outlook.com> <0db752d31016823ccd3799925255a74a.sboyd@kernel.org> <SEZPR06MB69597E78EA08D5BDF66DBEBC965F2@SEZPR06MB6959.apcprd06.prod.outlook.com> <f8bcec654f618f8639a882bf70273618.sboyd@kernel.org> <SEZPR06MB69598A991B4CCF633E764CE7965F2@SEZPR06MB6959.apcprd06.prod.outlook.com>
Subject: Re: [PATCH RESEND] clk: set initial best mux parent to current parent when determining rate
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>, Yang Xiwen <forbidden405@outlook.com>, Yang Xiwen via B4 Relay <devnull+forbidden405.outlook.com@kernel.org>
Date: Thu, 29 Feb 2024 17:42:25 -0800
User-Agent: alot/0.10

Quoting Yang Xiwen (2024-02-28 18:33:11)
> On 2/29/2024 10:25 AM, Stephen Boyd wrote:
> >>>
> >>> Is the problem that we're not using abs_diff()?
> >>
> >>
> >> No, i think. It has nothing to do with the code here. It's because of
> >> the initial best_parent/best_parent_rate.
> >=20
> > Alright.

I will have to fix this as well in a different patch.

> >=20
> >>
> >>>
> >>> ----8<----
> >>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
> >>> index a3bc7fb90d0f..91023345595f 100644
> >>> --- a/drivers/clk/clk.c
> >>> +++ b/drivers/clk/clk.c
> >>> @@ -542,7 +542,7 @@ static bool mux_is_better_rate(unsigned long rate=
, unsigned long now,
> >>>                          unsigned long best, unsigned long flags)
> >>>  {
> >>>       if (flags & CLK_MUX_ROUND_CLOSEST)
> >>> -             return abs(now - rate) < abs(best - rate);
> >>> +             return abs_diff(now, rate) < abs_diff(best, rate);
> >>
> >> Without this patch, the initial `best` rate would be always 0. This is
> >> wrong for most cases, 0Hz might (usually) be unavailable. We should use
> >> a valid rate(i.e. current rate) initially.
> >=20
> > Ok. But you set best to the parent rate. So why not use 'core->rate'
> > directly as 'best'?
>=20
>=20
> I can't remember exactly. I just add this piece of code and found it's
> working. Is this field already filled prior to setting rate? Anyway,
> your suggestion is very reasonable. Maybe dear clk maintainers can fix
> it as i'm not familiar with clk core code.

Yes the 'struct clk_rate_request' is pre-filled with many details,
including the rate of the clk and the current parent rate and parent hw
pointer. I'm pretty sure you're trying to fix this fixme from clk_test.c

static const struct clk_ops clk_dummy_single_parent_ops =3D {
	/*
	 * FIXME: Even though we should probably be able to use
	 * __clk_mux_determine_rate() here, if we use it and call
	 * clk_round_rate() or clk_set_rate() with a rate lower than
	 * what all the parents can provide, it will return -EINVAL.
	 *
	 * This is due to the fact that it has the undocumented
	 * behaviour to always pick up the closest rate higher than the
	 * requested rate. If we get something lower, it thus considers
	 * that it's not acceptable and will return an error.
	 *
	 * It's somewhat inconsistent and creates a weird threshold
	 * between rates above the parent rate which would be rounded to
	 * what the parent can provide, but rates below will simply
	 * return an error.
	 */

