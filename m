Return-Path: <linux-kernel+bounces-123779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE64A890DAB
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C2471C31F2F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDDA525753;
	Thu, 28 Mar 2024 22:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISvWRiMA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268091D68F;
	Thu, 28 Mar 2024 22:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711665360; cv=none; b=YGYen09pj+YbotcgifqRn16SJ2tUjvGQjhrL6WVxd1N4mKD4exhdAPAMoOasEkQreEzOm5f/b8Wk3De/fF/iD2mrWijh1zFe7NnhZ1Ca0+PDtqGTEHchvr0Ge2Lv8CiVNvHnoxnfuTuXZHNUi4a/zZl5mzKW5kbzQ2sgX7LUvrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711665360; c=relaxed/simple;
	bh=rvKtehwqnoxcmSN8NJNR3HB3kRar7BGFCncNbtbOnyA=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=rWu8pM8hR7Z3LNOFC+2xWFqisZeyP3uJ7hyRHp9PLRZVJ+YseCn8EEWh8n9UlnoLXkuFE/6zrMMUPYshUAX0T8QXSm2fiS0BM4xKhfLGIF9jGHAQCQ/H7Q7d4kt/T5pWkcJ9Svvm4byne8dxI1/Exa4WUq+x0LZMXG8MD2a7uAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISvWRiMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CA27C433F1;
	Thu, 28 Mar 2024 22:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711665359;
	bh=rvKtehwqnoxcmSN8NJNR3HB3kRar7BGFCncNbtbOnyA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ISvWRiMAPRsPznDPIhk/gvq27KHn4eT3kzjQPlvdxCV5Lma7AiRhTS7Jtst4LnTUF
	 RvgXgUQBB4glRDuFIlHq3qeAr6hoMUlIeve/zid2LADwCuekRHx+L3sKuxNnBQMQwk
	 5S2G+Cp5yTkVtlq7Idxfy2XAaqmxYjbYiUGuoK511oT0CMxEdFcYG+FcjG2jk2lL76
	 DYcEIuugn9YiBt2obFSG80G2LXW+9vj1C7z8DyPdJtTjKo8h+KRoGKZpEMCJwx8CM7
	 Bu8VquHxxTE6+TcgBjmH3XbwgE/urw3AxPMApgL3iZygE+TWEmq2TKC8l+/+uetXw8
	 ZrNlQ2t881+ug==
Message-ID: <d95554f623f023a2f5499fa2f6f76567.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240327073310.520950-2-u.kleine-koenig@pengutronix.de>
References: <202403270305.ydvX9xq1-lkp@intel.com> <20240327073310.520950-2-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] clk: Provide !COMMON_CLK dummy for devm_clk_rate_exclusive_get()
From: Stephen Boyd <sboyd@kernel.org>
Cc: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, oe-kbuild-all@lists.linux.dev, kernel test robot <lkp@intel.com>
To: Uwe =?utf-8?q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Date: Thu, 28 Mar 2024 15:35:57 -0700
User-Agent: alot/0.10

Quoting Uwe Kleine-K=C3=B6nig (2024-03-27 00:33:10)
> To be able to compile drivers using devm_clk_rate_exclusive_get() also
> on platforms without the common clk framework, add a dummy
> implementation that does the same as clk_rate_exclusive_get() in that
> case (i.e. nothing).
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202403270305.ydvX9xq1-lkp@i=
ntel.com/
> Fixes: b0cde62e4c54 ("clk: Add a devm variant of clk_rate_exclusive_get()=
")
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---

Applied to clk-fixes

