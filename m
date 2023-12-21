Return-Path: <linux-kernel+bounces-7849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBED181AE2F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 05:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C6A41F249D3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA2B9463;
	Thu, 21 Dec 2023 04:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PxyFw2L2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102098C18;
	Thu, 21 Dec 2023 04:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 740A6C433C8;
	Thu, 21 Dec 2023 04:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703134699;
	bh=Y7Unia0MjNq+xhf/SdLTJJEFwi9X+AFo3gAm06VmdUg=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=PxyFw2L2iNUVJDzrI9VTkR9HhM5eCtfp2BT4lZrs1fnvEIImg/gjyB6xjjz/yUlRH
	 kmA6C8Z8254W2usVvRjg+tii8pqDFZLcG22/41Em1eK8FQCHASjyiuJtisaudxFi6H
	 nIzODL3DWKdPXRIFhmB0jQ0VWYf8WLJuuSq+G1kRSjuHCGaQOGP+hEjUJ3G4e+Fii0
	 u/3bZm3JnAQUcX/k8ay839dsQZTtcLEISWmMSnHtiGMJPFfSuZvWN8MHI/F//XpWbq
	 u4Dh1HHr+adP6d/bolTLU/vuoWK3CioN8cUNyrwRIWQ540q5f9//kFmBNUhsQTLfFH
	 VbT7LcPPQBJug==
Message-ID: <ad35ba42d316a51626a031c4d7d3485c.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <IA1PR20MB49535E448097F6FFC1218C39BB90A@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB495354167CE560FC18E28DC5BB90A@IA1PR20MB4953.namprd20.prod.outlook.com> <IA1PR20MB49535E448097F6FFC1218C39BB90A@IA1PR20MB4953.namprd20.prod.outlook.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: clock: sophgo: Add clock controller of CV1800 series SoC
From: Stephen Boyd <sboyd@kernel.org>
Cc: Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>, Emil Renner Berthing <emil.renner.berthing@canonical.com>, Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org, linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Albert Ou <aou@eecs.berkeley.edu>, Chao Wei <chao.wei@sophgo.com>, Chen Wang <unicorn_wang@outlook.com>, Conor Dooley <conor+dt@kernel.org>, Inochi Amaoto <inochiama@outlook.com>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, Rob Herring <robh+dt@kernel.org>
Date: Wed, 20 Dec 2023 20:58:17 -0800
User-Agent: alot/0.10

Quoting Inochi Amaoto (2023-12-17 20:04:03)
> Add definition for the clock controller of the CV1800 series SoC.
>=20
> For CV181X, it has a clock that CV180X does not have. To avoid misuse,
> also add a compatible string to identify CV181X series SoC.
>=20
> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
> Link: https://github.com/milkv-duo/duo-files/blob/main/hardware/CV1800B/C=
V1800B-CV1801B-Preliminary-Datasheet-full-en.pdf
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied to clk-next

