Return-Path: <linux-kernel+bounces-131752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 887BD898B76
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D9FA284BE9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630A612AAD1;
	Thu,  4 Apr 2024 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZW3d0pYN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9682F129E8D;
	Thu,  4 Apr 2024 15:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712245540; cv=none; b=j9aLgkyiDlbqagVEjBhmbSTWotTRafdDQXqK+tTqLlzrwVLqVXcJk0KoP8KAOgCcQp+cJprSpDi9gVPhN3AwQNT0MzGCYeudTxWVbHKM8CsmdZszRJ7M0PKKg7nDPzGGUeYPxdGfWtBJmecvhtHgj6Fh8nwZI2EOzAQU3oHndhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712245540; c=relaxed/simple;
	bh=06LltEwRa6hVHukKdlRsi3VG2JyLvZ9do/OpA5AoXpg=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=gIWDhbnceb1CMjq3pmJmWKrC9WUgFbZIKyzOmh+hnyefm/u79gF1Rs2ZdkHVtl48TAnl/EGDih9ofefUbPVVSB3KxrUZsi6shMtWOjx1tTIolmITAzD4ulfMxiad1iCmd4WvJCgboHWMXPG1kJxR0Y+p9cF44DzXtkl56XYijOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZW3d0pYN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B176C433F1;
	Thu,  4 Apr 2024 15:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712245540;
	bh=06LltEwRa6hVHukKdlRsi3VG2JyLvZ9do/OpA5AoXpg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ZW3d0pYNqxfCnLK9j1vk2ztek9ZkO0Tt8EA0wlGrDSNbnmgTeEOerca+Dm9APhtPp
	 TLXdj2dQ6gf7zKLXIx5mEWgdvT8/+1wI9V+t1kI02MH2BUO3Fo7W7r6v1GbqgJrnQ9
	 tmKDea9C1KF/hn/+AWLEA57YTeQipxbi+gdfCy8R4fO2acXYowKhAa321CC/szp8OI
	 TLo+oC9J8GyK3EIui4+GBTHj8U8K/KE2StnZXB7MYYBh4VS8J3KgsFt0oOlqW4KPw0
	 YjO6YKe8bgdHqNTtv6dSHLPWGhUuY+L2RfTX1o6XensvKN9Iya9anF5Fa50uRt3bXq
	 Xd9OFPn0z5TGw==
Message-ID: <613b6a72867cbbbbca39888a53f26fa7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6cfb0e5251c3a59a156e70bcf6a0cc74aa764faa.1711985490.git.christophe.jaillet@wanadoo.fr>
References: <6cfb0e5251c3a59a156e70bcf6a0cc74aa764faa.1711985490.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] clk: nxp: Remove an unused field in struct lpc18xx_pll
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Michael Turquette <mturquette@baylibre.com>, Vladimir Zapolskiy <vz@mleia.com>
Date: Thu, 04 Apr 2024 08:45:37 -0700
User-Agent: alot/0.10

Quoting Christophe JAILLET (2024-04-01 08:31:53)
> In "struct lpc18xx_pll", the 'lock' field is unused.
> Remove it.
>=20
> Found with cppcheck, unusedStructMember.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Applied to clk-next

