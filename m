Return-Path: <linux-kernel+bounces-164735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05E7D8B81DD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BECB82866A6
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756261BED61;
	Tue, 30 Apr 2024 21:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUQwX16Y"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B051A38DC;
	Tue, 30 Apr 2024 21:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714512289; cv=none; b=jcnT5u3luB/+sL0gaiqFIHyb1rgVmvH7yzqUXJS5pqQ8RD0wJugvDVeI3ejLO+6UfXCD1cYtJzOf7c2zoERWK9eK6ntkl6TVdc8epUHnGKsfBUn2quxDGflfz+9D3oVBVOv5rMVcX1M6WqUr84cXlsj6IWHFYpDotvlSNkDQZUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714512289; c=relaxed/simple;
	bh=Nr5PmSGMQPefRC+4B+dUJLySenVFlvsYqWT3rnlD9i8=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=GIQENMwlqHh0VIhM3gqHZ1x8gQo0vqfFpzhRop4jQuJnKh4U4WBA2y6upvRqDZEDHU4npV6srdfvcTYb6LdVxAIrS49FWZ0EVFomNQipH6+x8LxF6pgkSPGs2x0NtolZKsQIA85g/ta63w6fUrLq/Eo8x3ncADNe1bObZSY9iDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUQwX16Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B2BC2BBFC;
	Tue, 30 Apr 2024 21:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714512289;
	bh=Nr5PmSGMQPefRC+4B+dUJLySenVFlvsYqWT3rnlD9i8=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=sUQwX16YkqFFu05qj/j/D+qicatYaVabFaKbUJbB6OnHMyvYeaq8GQNg350aICltQ
	 MkKVg4GtiNV1ePckPJlfoXEJ8uSIJyOLTcs0xikecc6B995CDIIAjlCHzGz30hcTkc
	 Y3n62y9kdbW88nISGPxlIHVAxXS5lmUfSCdG2+owj/RsVJ544kt+m5v0kNNTEJw7kJ
	 gamW1sQfcndXfXpu09tmlZ9mAnSao+XoathuwvT/vD7Z8fWnyOdOWBAliAv9YrQ2lR
	 0KvLNgKFuDKne1m+FgU4YPXxA7d2Q95pnmJaGsTP9wuJTCYkG3cI8Fm59ghXPF47st
	 y56l/um3TUS5g==
Message-ID: <1ce3c1873130ff696101f781b4df239b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240430184656.357805-1-krzysztof.kozlowski@linaro.org>
References: <20240430184656.357805-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [GIT PULL fixes PATCH] clk: samsung: Revert "clk: Use device_get_match_data()"
From: Stephen Boyd <sboyd@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Michael Turquette <mturquette@baylibre.com>, linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Date: Tue, 30 Apr 2024 14:24:47 -0700
User-Agent: alot/0.10

Quoting Krzysztof Kozlowski (2024-04-30 11:46:56)
> From: Marek Szyprowski <m.szyprowski@samsung.com>
>=20
> device_get_match_data() function should not be used on the device other
> than the one matched to the given driver, because it always returns the
> match_data of the matched driver. In case of exynos-clkout driver, the
> original code matches the OF IDs on the PARENT device, so replacing it
> with of_device_get_match_data() broke the driver.
>=20
> This has been already pointed once in commit 2bc5febd05ab ("clk: samsung:
> Revert "clk: samsung: exynos-clkout: Use of_device_get_match_data()"").
> To avoid further confusion, add a comment about this special case, which
> requires direct of_match_device() call to pass custom IDs array.
>=20
> This partially reverts commit 409c39ec92a35e3708f5b5798c78eae78512cd71.
>=20
> Cc: <stable@vger.kernel.org>
> Fixes: 409c39ec92a3 ("clk: Use device_get_match_data()")
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Link: https://lore.kernel.org/r/20240425075628.838497-1-m.szyprowski@sams=
ung.com
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

Applied to clk-fixes

