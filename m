Return-Path: <linux-kernel+bounces-152084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9EF8AB89E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 03:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0214E1F2237F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Apr 2024 01:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5199A6ABA;
	Sat, 20 Apr 2024 01:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hKuBCzDR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EABAA40;
	Sat, 20 Apr 2024 01:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713578312; cv=none; b=OzvzgX67bmfyZcaFmyKHiNoYgKahtZYI84M12EaZsJIQ1naBBDDvqh6BH0iLu6TF+Y3O3i2yBAGTjT6CGA8iT80hTOswovfBSplcj6ltCYkfhsMbpiP61Ks4OVpfWz/UzWf92Wp6uFgADIEdi3f73LveWX+n2STKnAVvqmESIoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713578312; c=relaxed/simple;
	bh=9/GGNhCWgeyo359YPa7ktspH1lRxj40sQs0eNhq3IZ4=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Y0saiwmDF8kkNrRLF+iZBwBQxoTJDSkcZglZUhdqigZtZc4vLmlHod9xP1xsSm+Rjb1Hy+PCU64srvk6+WlKurR9AC+Yyd32U6f0hpzVHUqKIsXTinZ1S7Kd8JPu9Ww4uqFtjFd3v4l03BCOT2TttKtt1xZoq00FGAQnx8Q1Uxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hKuBCzDR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D704C072AA;
	Sat, 20 Apr 2024 01:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713578311;
	bh=9/GGNhCWgeyo359YPa7ktspH1lRxj40sQs0eNhq3IZ4=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=hKuBCzDRAvmIW6yrupqyZm2r6xRHxgPyqUunUQZ98rurXmGTPv630Jy/MO0I0Xsno
	 mycRveCRELThMgsigncf4iT72zCr57RK/7y5JFOJhbP21x0+j1tNIE5ZEmyYxvktnd
	 McaOvTvA0FXWkMJqCpyby14N0jKdN++02S/9AnX3stG9349ShxVOSn1ZI1ZkZhhUJ3
	 s7F/fDe+8LSoH2v9/o+4B/2rNxdxoXx35CQdEd9FjCwmGhqZ6gGkP6jpxj0+EZ4QUL
	 bJcuADh1HwlQVoojsE+P1h1W85wQdlBFlySpIf57Wmxb1k02R2Tt2juO2Ct/QhtQYC
	 nqjgrVuWwjXOQ==
Message-ID: <ef03d9b284da50449d0365c0304ac8e2.sboyd@kernel.org>
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
Date: Fri, 19 Apr 2024 18:58:29 -0700
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

