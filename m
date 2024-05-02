Return-Path: <linux-kernel+bounces-166758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A05648B9F23
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 19:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B33828A102
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E825E16F909;
	Thu,  2 May 2024 17:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPmI2I5L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342A615D5A6;
	Thu,  2 May 2024 17:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714669254; cv=none; b=dIx+umo5kJqawfdXEpWDmxxS69uL15KPXX1u1cSAB1EhxuRw5BagXjSIKEc/h2hdlb673BP2SwDhuD7DPDmJEySbFvSKUgU6rkZuS0998V/R2h/gdU6yOwdZPhJE4X+do8GnU0hNMrqW+80q7PSSvCz+HyZ3S2765fvLIB6/yPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714669254; c=relaxed/simple;
	bh=IXPlEwfwp75+6cYqzARY+ouvPniGVrcbLA4YwU0vDuo=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=mNcmBdde8ajIvpk1arpMyooebWre3ikw72v3o77IdsLX9Jtw59/+etNgWylAd4cpxkxZmPPchyu8BRgIdonnJ/Z7064wnGw4ouq5HlcqEos8VxdgOSIpvvbQBIpIUa2lPgtHfVsN8nDK6uwJp6GDBhNtZQwxPVa4A/OsFwc4sak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPmI2I5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EACC113CC;
	Thu,  2 May 2024 17:00:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714669253;
	bh=IXPlEwfwp75+6cYqzARY+ouvPniGVrcbLA4YwU0vDuo=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=hPmI2I5L3nXawSVbzXh1ZmcFmSiho5NdxJMDvjtNaOk62Sqkiz4T7OOwX7scWH2pF
	 azP2y9LxN0h4MZVIIJU1Td/vI4Yvoz4qq2w3PqzQjbabKxA/mEYO84gqpUCGpCw2Ns
	 EJwfnaWxVxLvWg3FKsTOxLboj2O+s6STbe3ie23hD7z2LTM0VqNwQpOES7dheg2NJ4
	 BpnqrQcaeS+nnPbMYn1uRZr0tEUKQ/poie23amB5uFsD7QSTI/B1QmMUryclyNPEJx
	 YyWL8gxkRSO3UPg17xPepzlkZx6wN9A14woDj1XpVBfe2dyyUflO0FOr7/UCmD4kwn
	 9aJsJXYakQrxg==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240424045521.31857-1-krzysztof.kozlowski@linaro.org>
References: <20240424045521.31857-1-krzysztof.kozlowski@linaro.org>
Subject: Re: (subset) [PATCH] dt-bindings: mfd: allwinner,sun6i-a31-prcm:
 Use hyphens in node names
Message-Id: <171466925079.1213177.7158816605938803187.b4-ty@kernel.org>
Date: Thu, 02 May 2024 18:00:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Wed, 24 Apr 2024 06:55:21 +0200, Krzysztof Kozlowski wrote:
> Underscores should not be used in node names (dtc with W=2 warns about
> them), so replace them with hyphens.  This should have no impact on
> known users: Linux MFD driver does not care about children node names.
> DTS was already adjusted in commit 0f47ef3ff1bd ("arm: dts: allwinner: drop
> underscore in node names"), so without this change, we observe
> dtbs_check warnings:
> 
> [...]

Applied, thanks!

[1/1] dt-bindings: mfd: allwinner,sun6i-a31-prcm: Use hyphens in node names
      commit: 334fbae01f66a81bcbeed2dd0ac954660beeb4aa

--
Lee Jones [李琼斯]


