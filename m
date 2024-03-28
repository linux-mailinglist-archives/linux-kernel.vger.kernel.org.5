Return-Path: <linux-kernel+bounces-123656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 373F8890C49
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633481C2D369
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8F7A13A89E;
	Thu, 28 Mar 2024 21:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJb/PbFk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218956519D;
	Thu, 28 Mar 2024 21:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711660272; cv=none; b=sypmk18oLE4xGU7kabU0dfnwVVrcs+QMeZOvxjzCW6nHseh8zcvlNrqn4BdbPn8J1+PB1Fhng9wup4M0uPZsjFs7NTF5h61a+yVma5MzGsQatuI0IcEhg0GgmsrBSOIMQSCWltOl2d9902WqM7oU5xOsZ901nCtPeV07QNHihGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711660272; c=relaxed/simple;
	bh=z/Cuj9LA0Xa+ZmEp2IaF0jg2a2SqBYyo+Qx1gEBlZ4Q=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=nzUQbve3uGbYIL4bH9lt3vAeoZmpUQbTwh4MJNWrznL9PRFvLD3QQz2OrTgCS44YRa9LcGO1QAkdgKYUiWMdX2lQFDsauPehEZXKSv2+TOyOQH0A5m85rba6bCL7zwm2MYX5Lz9jS7dM5a+OJUjUCOGQajy8gmd3Nj1yQAEaDNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJb/PbFk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B615C433C7;
	Thu, 28 Mar 2024 21:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711660271;
	bh=z/Cuj9LA0Xa+ZmEp2IaF0jg2a2SqBYyo+Qx1gEBlZ4Q=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=dJb/PbFkhKeWQW3nrlKB/eUsLXiqQAybCDxyo6QVeBaJWG9uZ3Gk8JdHO0bx0EqWC
	 JV4qreNyeLwvbrnJOvvQiSiUIPLUTFv7hq4KLCH2eRI1x2VmXdrKQgx5DhqwatvvD4
	 RNFyc3NtRGHy4CA3LRYjIVkynsunONgoX0/VOuVdj/cCnJGHIldR8PUAe1rdk20Bns
	 vxrbhVmpMm8n0fCy6dQyuHD4HyY43518l1bW4/yCYgXD+sryj2m9MzByL2mQiKLgoH
	 98A3hzSQEPqpwBlAvltDkCxFQ4Dr8qVpxRFy34euNzdtVPK3ZkPPf+8Cx4YBvVlhP3
	 RsX/RW9+mBlug==
Message-ID: <8615090f3ccdfc6c7d8e3e0dc7f55e32.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <tencent_4FC67CBE4B41306D52C71C5CEC989690FF07@qq.com>
References: <tencent_2E60E33C1F88A090B6B3A332AE528C6B8806@qq.com> <tencent_4FC67CBE4B41306D52C71C5CEC989690FF07@qq.com>
Subject: Re: [PATCH v1 3/5] clk: k210: Deprecate SOC_CANAAN and use SOC_CANAAN_K210
From: Stephen Boyd <sboyd@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>, Michael Turquette <mturquette@baylibre.com>, Linus Walleij <linus.walleij@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>, linux-gpio@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, Yangyu Chen <cyy@cyyself.name>
To: Yangyu Chen <cyy@cyyself.name>, linux-riscv@lists.infradead.org
Date: Thu, 28 Mar 2024 14:11:09 -0700
User-Agent: alot/0.10

Quoting Yangyu Chen (2024-03-28 10:06:11)
> Since SOC_FOO should be deprecated from patch [1], and cleanup for other
> SoCs is already in the mailing list [2,3,4], we remove the use of
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

