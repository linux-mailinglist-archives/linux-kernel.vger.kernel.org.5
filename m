Return-Path: <linux-kernel+bounces-142001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 541C88A25FA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 07:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 046ED283663
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 05:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2021E1C2B3;
	Fri, 12 Apr 2024 05:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R8E4AgwL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58DCB1BDCE;
	Fri, 12 Apr 2024 05:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712901113; cv=none; b=JblpwUE3zGUJK5u/Wu2rHWAl9APFW6FmAh9A0yzn5Qn31nRW3XYIue82JCzLwy+Ts8uqQBvbQh1z+yGk+FBsDQ2cNocYQuZGVsUbjcxvspDlL2I9a8p4fXt4t9dmsrhiFyW+pe+Q8EEN3B+qmQyG6v2D4/IbMN6FXnrxowde4mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712901113; c=relaxed/simple;
	bh=wVUXt48dKkyfO/TAmagdFTJmIwVv+LsLAIcc4G327ME=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=q2vSFc0KBVigH0yN9pGOaE8OAHYpEtCJlG4XaIvPLPuXUijV59w7pW4ERUasg8NzPEhDCqsQMJfE6Sv7VxUjxKUOm4Xha2kdRfgcKhVd5ZysoraMIazCCPXoh1enR0k8YE9lWUiCepAzfDX2w5EM+KVUoO+12E0F3fgWuv/FdCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R8E4AgwL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77E7C2BBFC;
	Fri, 12 Apr 2024 05:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712901112;
	bh=wVUXt48dKkyfO/TAmagdFTJmIwVv+LsLAIcc4G327ME=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=R8E4AgwLGXe5zWynRCN5oUzGUhtWE9tE8biVLWECoBAIekb1AQqE/fWTxAMOVMX44
	 fL1fbykbr7Ya51T6Ucd9M5b0dc00Bze1fNt8eg8dRprVud2bOFC+pRFnKtVD1Rq+jP
	 Bi4TtIdwttGjPpNsvapT2qzuSqzGPoN9mUjCUpdDUHNUv6mDvqJ9omfkDvyHb2q2zN
	 8klxhfyFsjHjSgZ9Gs/BU4kX65NkEBqb6ofvJ8EffWfwEE+K/rv26sqIAMaOtDqNtR
	 FTf8Tjimi7wmNWuYsE3FOvZdnESpNBQlvPDGlm+IBj9BwBAnJTSvHmADcZMwMw89yQ
	 C8d0cU+bjlyeA==
Message-ID: <9c2ec88689da0122758e697e04bccc3b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <IA1PR20MB49531E437735A71A163694AEBB052@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49531E437735A71A163694AEBB052@IA1PR20MB4953.namprd20.prod.outlook.com>
Subject: Re: [PATCH] clk: sophgo: Make synthesizer struct static
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To: Chen Wang <unicorn_wang@outlook.com>, Inochi Amaoto <inochiama@outlook.com>, Michael Turquette <mturquette@baylibre.com>
Date: Thu, 11 Apr 2024 22:51:50 -0700
User-Agent: alot/0.10

Quoting Inochi Amaoto (2024-04-11 16:24:38)
> Let all synthesizer structs are static to make the compiler happy.
>=20
> Fixes: 80fd61ec4612 ("clk: sophgo: Add clock support for CV1800 SoC")
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---

Applied to clk-next and I added the robot tags.

