Return-Path: <linux-kernel+bounces-142028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 588628A266B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89B9D1C22733
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38FEA2C853;
	Fri, 12 Apr 2024 06:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNo0dQhw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72B853E48E;
	Fri, 12 Apr 2024 06:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712902926; cv=none; b=c6oneA8/IbwKmveSvR1NGhkHNBgUPyiZolDo6ZocACJ8BDeuMNphJpdzcemc0+7CcN5Eri2RbSBuntXrmG+aKOCrju4VzgJ9c1+tOfI3Fnr4WeCV4yzINpiq6f44xPYjO+NGihVIJsC1lX+1gDsH9qbMVCjVzTdIwO9XwN9NJEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712902926; c=relaxed/simple;
	bh=pZYfYfvm+jnX/RwGqdypPJz84vtXIB+UYrSq9SPSCuI=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=RtIZn3rxwruMtsOrkZOvEv303rzRszkvjaL9uKaZOj/RXuAar83zmD/veCi71o3IWnJIqn8gG/l6RkiaGK9V/4+WJDRDijXRAtp8wqlmxTMqvnzJcM0aqpIm6zZcDpHnZPNfGZm+eWBeUhxED2eywYvS+3Ml3nOpSl0Px2AyIXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNo0dQhw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 258B4C4AF0C;
	Fri, 12 Apr 2024 06:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712902926;
	bh=pZYfYfvm+jnX/RwGqdypPJz84vtXIB+UYrSq9SPSCuI=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=KNo0dQhwNSlTYrQz2rTgROGsm/QrvfLZGW44bDnZK90DIu5dtDZBsieYfjQjQZYRd
	 wwWqFc7iOomf7ArYi+0RzxnEUlZpzXO4Xs6NKOCqU39GtAbMhHzyXxbedCaAohkAz3
	 cyZWgSNiE14MYuAoP/H9ighfq9fmnlEvqU9NmegUg2/qn5OLJ72E0cQoN8TbYSsbMK
	 csLz3rouTscy5p63r7TP3fqLfK9tJi5iZDL43MWTE9DkIl5EAqcsrrTB/Ij7NA890o
	 M2syH3ypg5eKEaDw5hT2d8pyXVh8QECtHmVrZJ/DdxCYXFp8DirHrWa4+mQKb3Oga/
	 EQL5aoVGLrk+A==
Message-ID: <7efb8858995d0c97ad2deccb24318353.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240411092453.243633-4-gabriel.fernandez@foss.st.com>
References: <20240411092453.243633-1-gabriel.fernandez@foss.st.com> <20240411092453.243633-4-gabriel.fernandez@foss.st.com>
Subject: Re: [PATCH v11 3/4] clk: stm32: introduce clocks for STM32MP257 platform
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, Conor Dooley <conor+dt@kernel.org>, Gabriel Fernandez <gabriel.fernandez@foss.st.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Michael Turquette <mturquette@baylibre.com>, Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh+dt@kernel.org>
Date: Thu, 11 Apr 2024 23:22:03 -0700
User-Agent: alot/0.10

Quoting gabriel.fernandez@foss.st.com (2024-04-11 02:24:52)
> From: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
>=20
> This driver is intended for the STM32MP25 clock family and utilizes
> the stm32-core API, similar to the stm32mp13 clock driver.
>=20
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>
> ---

Applied to clk-next

