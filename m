Return-Path: <linux-kernel+bounces-139935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3A98A094A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 09:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4698DB24E26
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A05013EFE4;
	Thu, 11 Apr 2024 07:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hx0elqZ2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C7D13DDDE;
	Thu, 11 Apr 2024 07:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712819271; cv=none; b=Jk0W+gx6xNAk3VDvHWsju+M0JyA9fZXauim8N4vciNhV+4LAfNg7MMKT+/OLlGOQZTQttVhd3Ls4F40lra91KZKs6vupb/7OsKUlqpFqS3WVBJy+LnND7q2Dm7GHA6ogzkobSUDFZA7PU+1hRysnfjWEoMymgggvbEBpwG2H4YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712819271; c=relaxed/simple;
	bh=Eg7nKhlQ45pThDmInT2Pa1BtHQZJf9V/GW2+v72Y/Mo=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=mywQ99+hoZKZ26kAlqBS9IN98nb0SuojIO/n5DUvOBHtrjhucXFBqRCKuVlpf1/0dLIFAoETunGeAr6/tMYBhVHEl/HqLWq8n/Kx7hCadXTXHvfEQXXmOmkYgn0OManFKoab9BnSu/xsGAlXH2mXbckdQp7nC11ZL9zSTgYh4eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hx0elqZ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 456FDC433C7;
	Thu, 11 Apr 2024 07:07:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712819271;
	bh=Eg7nKhlQ45pThDmInT2Pa1BtHQZJf9V/GW2+v72Y/Mo=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=Hx0elqZ25lfBI3qu9ExJoALiB8EBOQTiRMso2dzTuIlFts6YWT8fYoAWmp6VylQ0V
	 mspLu0J/kFkSXNjh4edmv7H+aMZfX3OWLKc5WApPfwJ8NP+gPy8XrcP//ZGd2L2f1K
	 XLXOorBu3DRMQVpe+whzSj2KbFz62zOOL2yao4AXWT5YG2eXbajiEsyl049k/llyN9
	 vPjUatvjFqJk916L0u1XksBfmlWaZhwXTuIIum5YZHgrIzMHQ71voeUs6qjLCiG4xo
	 6FMfcN07UKC+gbJG97xmJH3wF889JNj7C12FogkwY3ODqjlDaZc6/m2TWoiq3okpwi
	 5G3rZrXsT34QQ==
Message-ID: <fb7ffc03721f54b3217725ec2f276f66.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <IA1PR20MB49537156E71B64483F15C0F2BB262@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB4953512A4DCAF293D7B1CBC2BB262@IA1PR20MB4953.namprd20.prod.outlook.com> <IA1PR20MB49537156E71B64483F15C0F2BB262@IA1PR20MB4953.namprd20.prod.outlook.com>
Subject: Re: [PATCH v9 4/6] clk: sophgo: Add clock support for SG2000 SoC
From: Stephen Boyd <sboyd@kernel.org>
Cc: Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>, Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
To: Albert Ou <aou@eecs.berkeley.edu>, Chao Wei <chao.wei@sophgo.com>, Chen Wang <unicorn_wang@outlook.com>, Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@outlook.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Rob Herring <robh+dt@kernel.org>
Date: Thu, 11 Apr 2024 00:07:49 -0700
User-Agent: alot/0.10

Quoting Inochi Amaoto (2024-03-09 01:02:54)
> Add init code for SG2000 SoC.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Link: https://github.com/sophgo/sophgo-doc/releases/tag/sg2000-datasheet-=
v1.0-alpha
> ---

Applied to clk-next

