Return-Path: <linux-kernel+bounces-151975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E208AB682
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 23:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14C1FB22994
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 21:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3134713C9C8;
	Fri, 19 Apr 2024 21:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/lY6Xyo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F772BAF3;
	Fri, 19 Apr 2024 21:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713562710; cv=none; b=fVsia2LROtYDXo5u1dZRkLIZ3s/xlr1QfltB17jz6v5HXoViRxl0lPahunJReBDo73kIHZPyMAKhZXNsBDGWju+hNyLkzU6kjpivblrNLrXxr+qRZiXq1ffM2cdaeET8qeQ9ff7MKkmXdH6HvR9Ra5kYwSag0rXaqXqs2knzjG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713562710; c=relaxed/simple;
	bh=mvlAGfAA1dpSHwoNQqk6yoKk8MhHUYLf1wO+6CpQT9A=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=kJASqVDp0UzgripF7aSIvlVRtdDLdNJrk1zVCLfTO9fTrKOm30xxboGAaPi2kk7Cc1KPIcli767RQ49C7GJqte/BdyGN+0MbnVXri2Xi2IjVJjkRa1Ij/YZ92dkEoHDkOD9AWYlhcoQQDj4lp2LSvlimUd2PQ28Pw+h+qKe3GW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/lY6Xyo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2695C072AA;
	Fri, 19 Apr 2024 21:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713562709;
	bh=mvlAGfAA1dpSHwoNQqk6yoKk8MhHUYLf1wO+6CpQT9A=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=q/lY6XyofpQ4pgXSBr2EJkqjmE+Zz+WYXO8otUTSZJNlL7h+AcJLQVDs+6k0GE4MY
	 SOHA6dvW7L0BJdq/N6azYIRyLWCzYCEk2Iu0KWqbu79AEzoEUBCop2dtfZqPT4B0Ob
	 ix6bUSrJ7C7vB364cm08bljAzYOLea1Fp3kvX/6A0xhlO4X7sDacsD/DeFf8eflM+a
	 Zus2ebq8E0G5IQKvBv3hAC4u6w/EHxYxllqvt3RCCO4gcS4HY1WIc4hMC8UHv+iJa5
	 4SJBC7ZgcCOI5I+riRFUZ/e+iGLa081AbxEWSQFqvzlOUqJFAyBvfHdLVsrU2SYO0o
	 eKHynq6bOrjZQ==
Message-ID: <ba929890d6c6fbdb78f3aa8d9b761184.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240415134532.3467817-1-arnd@kernel.org>
References: <20240415134532.3467817-1-arnd@kernel.org>
Subject: Re: [PATCH] clk: sophgo: avoid open-coded 64-bit division
From: Stephen Boyd <sboyd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To: Arnd Bergmann <arnd@kernel.org>, Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, Michael Turquette <mturquette@baylibre.com>
Date: Fri, 19 Apr 2024 14:38:27 -0700
User-Agent: alot/0.10

Quoting Arnd Bergmann (2024-04-15 06:45:20)
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> On 32-bit architectures, the 64-bit division leads to a link failure:
>=20
> arm-linux-gnueabi-ld: drivers/clk/sophgo/clk-cv18xx-pll.o: in function `f=
pll_calc_rate':
> clk-cv18xx-pll.c:(.text.fpll_calc_rate+0x26): undefined reference to `__a=
eabi_uldivmod'
>=20
> This one is not called in a fast path, and there is already another div_u=
64()
> variant used in the same function, so convert it to div64_u64_rem().
>=20
> Fixes: 80fd61ec4612 ("clk: sophgo: Add clock support for CV1800 SoC")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Applied to clk-next

