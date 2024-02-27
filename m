Return-Path: <linux-kernel+bounces-84120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A27F186A297
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 23:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38586B230BB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 22:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE381552EA;
	Tue, 27 Feb 2024 22:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PJ7RkUro"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37104CE17;
	Tue, 27 Feb 2024 22:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709072398; cv=none; b=bO2Rkwmy23aOlBpbmWddrCHECM/NrTE7prcABvD7KpDl68kl6e35AVP/bMROFkLKYpgo4awRljNuewUbCTlWZtlQYmmWpD30N0gmnWqO5O0Ik7H3Kczo6Fe133GfFSD9ZakZRed20tBu7T7MrGH+ToC+54q+9XlRpqMkIdg4ENc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709072398; c=relaxed/simple;
	bh=P/0Lp3p6cjbqRs5cbmbM4sQpMmROWRh/vOmI9Hf8Tec=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=tWCMocXGnebNAro5FGduDvpUoHrGyG6TjgNW3D5bk2lWi7W3c1/c4rs2P9GfyWof6rJxoR+sZwjDPEO204d4lT1+6Gf+J3D6eQUAwu9RlKHA8pcgEBRr9Oswg8QbWZ1EmAilELt59uDwjNKiiCjAexmX9IGP4IMICpp3MmSUwe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PJ7RkUro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C6DC433F1;
	Tue, 27 Feb 2024 22:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709072397;
	bh=P/0Lp3p6cjbqRs5cbmbM4sQpMmROWRh/vOmI9Hf8Tec=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=PJ7RkUroYvPF+8SdbsWVu1elpR9/MXJeixdEofD456gkMjrAUcbbpX7TRtY6bjn1M
	 tEKUw9n9bFqsMvhGBLQS+z5m2drpwEuwEqXT9+yoiaNpU+ltulYnNtpLiNlzl4wAE2
	 Czyy3s+sd0H+am7RI0+2C3yKQtGdoal2Dyfla7yW71J889W6ym2SxEgExeVeyzg2nu
	 ElnN4ALHeD5mqHrZBkzBc0MfWRC2J60dU3Srzk18ooRK5jvtTEhs/0ENMsBlfoujiu
	 jDvZSNYwmpbaU1QDgL/lZhzz5UpvonwWmpnZeVpjDa8acmgIJRwcQM8Pte6km9uabK
	 YI11CnWXrwYPg==
Message-ID: <b622146261a3719ae9168d80aeb680ef.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240227075835.33513-1-krzysztof.kozlowski@linaro.org>
References: <20240227075835.33513-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [GIT PULL] clk: samsung: drivers for v6.9
From: Stephen Boyd <sboyd@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, linux-clk@vger.kernel.org, Sylwester Nawrocki <snawrocki@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Peter Griffin <peter.griffin@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Michael Turquette <mturquette@baylibre.com>
Date: Tue, 27 Feb 2024 14:19:55 -0800
User-Agent: alot/0.10

Quoting Krzysztof Kozlowski (2024-02-26 23:58:35)
> Hi,
>=20
> On top of the previous fixes pull request - my previous tag
> samsung-clk-fixes-6.8 - due to context dependencies.
>=20
> Best regards,
> Krzysztof
>=20
>=20
> The following changes since commit d76c762e7ee04af79e1c127422e0bbcb5f1230=
18:
>=20
>   clk: samsung: clk-gs101: comply with the new dt cmu_misc clock names (2=
024-01-22 11:40:12 +0100)
>=20
> are available in the Git repository at:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/sam=
sung-clk-6.9
>=20
> for you to fetch changes up to 61f4399c74d0677ee64e42f7b8d4ab01ee39de45:
>=20
>   clk: samsung: Add CPU clock support for Exynos850 (2024-02-25 17:07:34 =
+0100)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-next

