Return-Path: <linux-kernel+bounces-139931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7867D8A093D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 180901F21D1B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212E414430F;
	Thu, 11 Apr 2024 07:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzJYR4hU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C5C13DDDB;
	Thu, 11 Apr 2024 07:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819240; cv=none; b=Cdg+WDYAsoaofwCgxEfiNGXaNF0DT3NvgYTDXOnYlf1KHuNUVvmsZBMkevrtgmp+KDff5KHvVec6eoVnfYKQoki0dYlSh3su/nhyD1gJNU4Nb0B4N4uR5gWimEQvQHnf9l9hRNx5SxVUPsWjQkwLY0zUEBpTysNkx6gTUakXmVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819240; c=relaxed/simple;
	bh=ZWKo/BX8/wnIgRSCduC2T39SHdhV8zk/gZ6Kmh/NggA=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=eNlEiw3wu8KN8Da/LjQyEBtm/NDKuDLHkdcwF6hihjbCzbDWGxkNyJ52h7M0md2e+3H2DKGj2wfJXO0IwXXsLiLMm34qI1Yn+Dh/s6VpXWWkQy2N1vR8olAoyvzy8gUlE0715atyinUW5u2pT5HNsep0/sqwkJLLyAj5vuq4yj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzJYR4hU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE093C433C7;
	Thu, 11 Apr 2024 07:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712819239;
	bh=ZWKo/BX8/wnIgRSCduC2T39SHdhV8zk/gZ6Kmh/NggA=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=jzJYR4hUhmT6Kl4If/IktSrI4kI39dvhnqJVPZi8XL3OJQ6B7z/bCr6fzqW179Qus
	 0CvwEsjxORzC7U2Fm3KZ0BSdg9XS1o76AbbHGT2/QQNm/aOGqj0szRN6QghWpMxShD
	 ImqMahK7eRn3PA5zSXDiZ/KtFFb1c5odGVD7iK8ArEk0RGqXsL2q1Wcy8s3DKFUY23
	 AZQmuyi4JpBNKQEDR5v5uhrCUFCkQMk4M5ACA1KTL4IqVgYzedtwcMbHPVrHM50z5D
	 Z6XMB3hbvu45PyYviTKnoGg07mxjgnFCmHCpUnk7G5G3zDYzz2LdTWJlWstfhSUYRg
	 AXjPsu72VkqCw==
Message-ID: <2fe3cd148e400a93754e4d97fb3275ae.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <IA1PR20MB495368F185E018767CC6714ABB262@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953512A4DCAF293D7B1CBC2BB262@IA1PR20MB4953.namprd20.prod.outlook.com> <IA1PR20MB495368F185E018767CC6714ABB262@IA1PR20MB4953.namprd20.prod.outlook.com>
Subject: Re: [PATCH v9 1/6] dt-bindings: clock: sophgo: Add clock controller of SG2000 series SoC
From: Stephen Boyd <sboyd@kernel.org>
Cc: Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>, Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Albert Ou <aou@eecs.berkeley.edu>, Chao Wei <chao.wei@sophgo.com>, Chen Wang <unicorn_wang@outlook.com>, Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@outlook.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Rob Herring <robh+dt@kernel.org>
Date: Thu, 11 Apr 2024 00:07:17 -0700
User-Agent: alot/0.10

Quoting Inochi Amaoto (2024-03-09 01:02:51)
> SG2000 series SoC has the same clock as CV1810 series, but the clock
> related to A53 is functional in SG2000 series. So a new compatible
> string is needed for the new SoC.
>=20
> Add definition for the clock controller of the SG2000 series SoC.
>=20
> Link: https://github.com/sophgo/sophgo-doc/releases/tag/sg2000-datasheet-=
v1.0-alpha
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> ---

Applied to clk-next

