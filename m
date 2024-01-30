Return-Path: <linux-kernel+bounces-43731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 842A4841873
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 02:38:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 209211F26AA3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 01:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DF7364C7;
	Tue, 30 Jan 2024 01:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h9Awpp9r"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C84364AC;
	Tue, 30 Jan 2024 01:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706578698; cv=none; b=QG/xACDOKK8GLb+SpNx6QWQN5Sv/Tf+TQDILiuDrQLvN1ObEkUFU6bEUKx7y3WVRQuP0zRAWQkjcVwfT5SjOKsNGb42ofCAag9vNynfnoq0a8HmAdOc5yG1nRWWki5uF5jPdxn2p8gY+vDHtKEYXArlb/OsGvm8W+ZgwwQj2t2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706578698; c=relaxed/simple;
	bh=FnZu9QEvGwPfCnOCIJnCqZeFRcf8vBh2tOD6uhocqnM=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=FYDoatQ9A8MXUssX0F94bwfPAMYSznclEHNFr3ALXkTClXpZfagBjm2PlZhWO8rjkPUkBWD2TICIjl4YCPPAszMY2FJFnfUssGYVhd5wo/F7nyknGVLfcsuo4EuBjYZScC6N9O/FUBKMltGC2S7Gbsm5PHu+6745Xr+LLBDy7fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h9Awpp9r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 474EEC433C7;
	Tue, 30 Jan 2024 01:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706578698;
	bh=FnZu9QEvGwPfCnOCIJnCqZeFRcf8vBh2tOD6uhocqnM=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=h9Awpp9rFbGk2VlryMd4lFi0CIjAFVKsL7Rjq9OHaP8FwDhNXPXI0Xys5ZZZON7za
	 cGx0bxKuhCUtxuTpMrQzw21RcZNNRd4P2C8vAeJfNqDp+1vZx66u/p6Kah+SGMuPt1
	 SBrPRnU5vaJU0NZhjBZ2uEUMxCHEopam5j9s/rKMB5ZETBrsvILh8vJT1hYSdbErR1
	 IFnbgbNw3DBgHZopvZ7cfV1jVPEzMEvK1b04S1Nh7xA74S4U6qi8IumtzbYKh8z+Oa
	 5sUkMGcreYSB246XQrFyo7h5128wJ4VQxkLqwtlMPndeNjmTd89AndoUuTs4KiG+vw
	 jAc8BTMjUP18A==
Message-ID: <9706c321d259d4c904e4ae8c6bb95b80.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240125082538.164262-1-krzysztof.kozlowski@linaro.org>
References: <20240125082538.164262-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [GIT PULL fixes] clk: samsung: fixes for v6.8
From: Stephen Boyd <sboyd@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, linux-clk@vger.kernel.org, Tomasz Figa <tomasz.figa@gmail.com>, Sylwester Nawrocki <snawrocki@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, Peter Griffin <peter.griffin@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Michael Turquette <mturquette@baylibre.com>
Date: Mon, 29 Jan 2024 17:38:16 -0800
User-Agent: alot/0.10

Quoting Krzysztof Kozlowski (2024-01-25 00:25:38)
> The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd3=
3d:
>=20
>   Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)
>=20
> are available in the Git repository at:
>=20
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/sam=
sung-clk-fixes-6.8
>=20
> for you to fetch changes up to d76c762e7ee04af79e1c127422e0bbcb5f123018:
>=20
>   clk: samsung: clk-gs101: comply with the new dt cmu_misc clock names (2=
024-01-22 11:40:12 +0100)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-fixes

