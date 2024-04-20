Return-Path: <linux-kernel+bounces-152085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE818AB8A1
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 03:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52683B2128B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 01:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EE0610E;
	Sat, 20 Apr 2024 01:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gw8kZV+W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7380A8F5D;
	Sat, 20 Apr 2024 01:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713578322; cv=none; b=SPx4pSbbu/KXw3hyonem8UXAo0OOA4F6VlONg3tC96IU5vtkEgHPUfC2Sc7leG3S0ADXndqEfXtsmcsbnovo/ggdVXxCiYe7+wrUYgHsIi3q1Tg89V2Lo+gbtF6gwp6cU68TRsiDNDFePaNXADxlguP3OMTiyPASZgPBkEgj8+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713578322; c=relaxed/simple;
	bh=9/GGNhCWgeyo359YPa7ktspH1lRxj40sQs0eNhq3IZ4=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=sbpmHjQE9nxYhLejbkJs5ZpJVoAMgRUOktsfmBYBCZ82HzZFpA+hXA2YTHvjnbl8haJBdIIqMiEnZpDpNlm+BYymL+MhjnWGJtyC+r07ttUGtwgt4Pz9gQ6RLm1ORwQ53oVrnf+w9Cd3RFttL5r7jHToDNi/VCfgG32MXVRxwms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gw8kZV+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEC64C072AA;
	Sat, 20 Apr 2024 01:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713578321;
	bh=9/GGNhCWgeyo359YPa7ktspH1lRxj40sQs0eNhq3IZ4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=gw8kZV+WkbYMpWnM33FT7Fl/m5JvvFVOO9Rka8hSySK8A+IPcRVhAnFD6aAm/4XUy
	 scw+hypatzHaRI6ETcZv1uREeK8PavsM41xgDGctgJKVX+4X4GN6nsDL4aiusVOpfD
	 r3+wVY5XZmz63HZyeD1H28legmmOMoSUa5SaVVCnlHQR+Sd67l6EJR6aCd6A0V5A8o
	 JrHicse6/8Xx+GeN0KKYQdDlBGwxFJycwP9Xth+hnae5UpAjHaz4P4faE+CFUFazeF
	 hSTwcMVWu66JWAbxZw8x8d3c4DIxiVTh8VnL9uew2NrNtU9uD4r4farSRqp2EaEL8q
	 nNwnVwTK3w+XA==
Message-ID: <cf4bf8cc6ca756b72aefa0212ced5512.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <556770c7701868f9f1c0569674903bee3eff30cb.1713015940.git.christophe.jaillet@wanadoo.fr>
References: <556770c7701868f9f1c0569674903bee3eff30cb.1713015940.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] clk: gemini: Remove an unused field in struct clk_gemini_pci
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>, linux-clk@vger.kernel.org
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Michael Turquette <mturquette@baylibre.com>
Date: Fri, 19 Apr 2024 18:58:39 -0700
User-Agent: alot/0.10

Quoting Christophe JAILLET (2024-04-13 06:46:09)
> In "struct clk_gemini_pci", the 'rate' field is unused.
>=20
> Remove it.
>=20
> Found with cppcheck, unusedStructMember.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Applied to clk-next

