Return-Path: <linux-kernel+bounces-133654-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D34F289A6B3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 23:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 855331F23933
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 21:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CA11C6A8;
	Fri,  5 Apr 2024 21:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RX3fk6+q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B99175577;
	Fri,  5 Apr 2024 21:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353657; cv=none; b=N2zM8sGty3AI66BhqjX8gv00yg+gn2e/gdDOlQZP92w5plsLzZrJq3kvskNXg24rgBKBGBhrhKdTjl7oqOVljIZHeU0ZjTOyK/9brK8nocFjiLMvHFIlJT7IKY/m6dcIJt/+6mLD3tJ2yVbBLYYhbNAJCcExT3osUomdBm3amVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353657; c=relaxed/simple;
	bh=7AnKOjpqHD/dkn52EQIuZvJZctpRFuWFmYBrrBbGDkY=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=fGBECAiNEMHeUKEvRznIN5LmEqoaG3vuVcarNLDHZKuiVIOovzLp1DmgvjNjk3liJ0ZuqCJQ8DmjoOW5VLU5HG/nM/sVYY5uiEzQQT5CJAvXTlrtRVWEfT4aZ756ZKlZIo/NvP5JCI5VYCkmBSQ8+EHtnF/vj0wlissHrn9HGN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RX3fk6+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0CFC433C7;
	Fri,  5 Apr 2024 21:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712353656;
	bh=7AnKOjpqHD/dkn52EQIuZvJZctpRFuWFmYBrrBbGDkY=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=RX3fk6+qOgJP/okKDKZ7F8WWRB7QwxIBQy7ZBnhgT6LifaWqwHN5firDGzQhKrqAQ
	 wh4OCm5GA7IMkrKOdJB9GwB3p87xMKAf6L6YSSqs17u925hXhudylZLH5mbbg+2dBs
	 Nhi00J6C4XEvix+7Pt2+TCdFF6oM5a4LzOH4v7Kv7HMJnVoOjB45uwqOXL8l1F9oTn
	 KGcj5RAEtYCVVIf0XahJoObTVRYPubR2Ggs4UTOi+kb4gaTQlCx/yc/oZqIDSNMV81
	 ybNap5miE/pr7lBSs4ykEbbcLf3Ls5BF4utEkKbisIdxLvFGzR3N3s2gr/oHkT/cuC
	 PoMWyqfROmXPw==
Message-ID: <0e0a3e9cb0a7f2cd1b0bde1e8ffaf7ca.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <tencent_F06FC1196D1D47235C8898CF10ED4632BE07@qq.com>
References: <tencent_F76EB8D731C521C18D5D7C4F8229DAA58E08@qq.com> <tencent_F06FC1196D1D47235C8898CF10ED4632BE07@qq.com>
Subject: Re: [PATCH v6 07/11] clk: k210: Deprecate SOC_CANAAN and use SOC_CANAAN_K210
From: Stephen Boyd <sboyd@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, Yangyu Chen <cyy@cyyself.name>
To: Yangyu Chen <cyy@cyyself.name>, linux-riscv@lists.infradead.org
Date: Fri, 05 Apr 2024 14:47:34 -0700
User-Agent: alot/0.10

Quoting Yangyu Chen (2024-03-23 05:12:19)
> Since SOC_FOO should be deprecated from patch [1], and cleanup for other
> SoCs is already on the mailing list [2,3,4], we remove the use of
> SOC_CANAAN and introduced SOC_CANAAN_K210 for K210-specific drivers,
>=20
> Thus, we replace its drivers depends on SOC_CANAAN_K210 and default select
> when it has the symbol SOC_CANAAN_K210.
>=20
> [1] https://lore.kernel.org/linux-riscv/20221121221414.109965-1-conor@ker=
nel.org/
> [2] https://lore.kernel.org/linux-riscv/20240305-praying-clad-c4fbcaa7ed0=
a@spud/
> [3] https://lore.kernel.org/linux-riscv/20240305-fled-undrilled-41dc0c46b=
b29@spud/
> [4] https://lore.kernel.org/linux-riscv/20240305-stress-earflap-d7ddb8655=
a4d@spud/
>=20
> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>

