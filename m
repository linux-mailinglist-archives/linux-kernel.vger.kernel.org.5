Return-Path: <linux-kernel+bounces-123672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C689890C73
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 588F428FD3A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A7213AD00;
	Thu, 28 Mar 2024 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6KyZeS4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C0240842;
	Thu, 28 Mar 2024 21:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711660940; cv=none; b=G6KNF59FMEWWD/3/wHAVSwaP5o4rJp3N7ibz8PaqwIE4Dqlrht81ANkSkrIFxaNxfZeuxx0igjA2T69hhiyN/pJq+CxUKEsXLtPzOilkKJaFJxugYVyVIjfvCTUUvMwRsUi96f/9ffJQ5D4QAhQk37dq0cmnMg0OE0jKqrn/0Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711660940; c=relaxed/simple;
	bh=08HHgve+hGTmOTCrIOzqWVz1iHc1ZVS5yvxBVoo+PpM=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=EUkio1KUdF+BvdclACN+7MhkjjU6NNrXo2Gs9PLLTWc+lzwC74f+q6YpQp9uQ11426WVgJxj9SXFEgqRhEd7sOCq5m7VnswoardXYVwuPEeZfGK+GugbKoLU7LwfRGJbOf+54SDWOi4llQzF0B0TBwaUdx9RISpuX1R/3ozWrLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6KyZeS4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97FE3C433F1;
	Thu, 28 Mar 2024 21:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711660939;
	bh=08HHgve+hGTmOTCrIOzqWVz1iHc1ZVS5yvxBVoo+PpM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=U6KyZeS4S5DaRpwt15Fx52JSO4rdZJDLBzn1z9MpqRYo9ZttVdpFW7yoPJMfo/Y74
	 1/5RnFEOSOfXfdAEuhXOdKFvkh1ky0UjUNSsmrtfsJ6RLA81k0SeWioUPoXzePR3lF
	 C39xUp1r/ACL5u589hIpQYBixbngbRsuNIppyYXV3Bg6dzslSZy7X4n3BBJ8/wWQ4D
	 yfzQhAFdiEpdKtPqMMsInIOsKhvdGvUfnnrObxaKZF6JqE3btAeK7ZQU9ZXFHTclH6
	 bDkaHoRw0utqZPo2V1Q5Ty7qrzIw+mxTly/Kad0fn0EwaHHRU6Xa89hp9moprV+e3I
	 DtkuGQz6ZLvqg==
Message-ID: <fa350b549fd5dc16ac1aaaac3921d26f.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240323032806.14356-1-yuehaibing@huawei.com>
References: <20240323032806.14356-1-yuehaibing@huawei.com>
Subject: Re: [PATCH] clk: qcom: Fix SM_GPUCC_8650 dependencies
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, yuehaibing@huawei.com
To: Yue Haibing <yuehaibing@huawei.com>, andersson@kernel.org, dmitry.baryshkov@linaro.org, konrad.dybcio@linaro.org, mturquette@baylibre.com, neil.armstrong@linaro.org
Date: Thu, 28 Mar 2024 14:22:17 -0700
User-Agent: alot/0.10

Quoting Yue Haibing (2024-03-22 20:28:06)
> CONFIG_SM_GCC_8650 depends on ARM64 but it is selected by
> CONFIG_SM_GPUCC_8650, which can be selected on ARM, resulting in a
> Kconfig warning.
>=20
> WARNING: unmet direct dependencies detected for SM_GCC_8650
>   Depends on [n]: COMMON_CLK [=3Dy] && COMMON_CLK_QCOM [=3Dy] && (ARM64 |=
| COMPILE_TEST [=3Dn])
>   Selected by [m]:
>   - SM_GPUCC_8650 [=3Dm] && COMMON_CLK [=3Dy] && COMMON_CLK_QCOM [=3Dy]
>=20
> Add the same dependencies to CONFIG_SM_GPUCC_8650 to resolve the warning.
>=20
> Fixes: 8676fd4f3874 ("clk: qcom: add the SM8650 GPU Clock Controller driv=
er")
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---

This is superseded by https://lore.kernel.org/r/20240318-fix-some-qcom-kcon=
fig-deps-v1-2-ea0773e3df5a@kernel.org

Bjorn did you want me to pick that series up?

