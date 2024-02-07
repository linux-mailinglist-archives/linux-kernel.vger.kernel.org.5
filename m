Return-Path: <linux-kernel+bounces-55950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6BB84C3F6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 05:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 826DC1F2707D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 04:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA088208D9;
	Wed,  7 Feb 2024 04:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tp/xK/+P"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00987208BB;
	Wed,  7 Feb 2024 04:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707281223; cv=none; b=fsWaW5vZf3tlLhJAXsvi2Fq8vIetbJsFSX4fYKAQsvvLx6TAoKpVdekDWY9CsGGnDa7MJPpXdixZUMjX0L/w068t4zGR1Nw7WIE6wIEUGFnzqHDtMEkbq36DhGewelV8E2S29R87B6+ZUCWRdzvb9d6n5gNwJfNJXXXqnwLeu+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707281223; c=relaxed/simple;
	bh=NoUP9csxhzAbNgBFl7PuU8elps19U3hBA388tPsmTOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I052bPD5lZ7G0QHxVCeqdR7f8DNX6vntZypa49zv8DRGjcfx/vDE7UtPq6bzzaRGkdXVkAIeijYMfgKb09T8ivKKdVZ8vbI8r7lPFVDAahE4EnK2ciDky8LemPvGtWTS9bLMTN7YYF8qQSqOYGnIfJ2ytsuB27qyJ3Mrho7gFNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tp/xK/+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BB56C433B2;
	Wed,  7 Feb 2024 04:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707281222;
	bh=NoUP9csxhzAbNgBFl7PuU8elps19U3hBA388tPsmTOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tp/xK/+PalmVOKhoo+PyLgALLy0R0/iziYBPL+C9JS4sgdT4A9IpQu7u5kaYUseRu
	 cMGvoX/v6kxNzCRMER2hcrQvcxtDY+n1NNaXjqAcpCvt6YlAjJmw/bebkeCDLZk7SZ
	 WeczHvp6CSqvteM+MhVDj3wilDzQ15zKm1yu6Nlh1zgx9UOxB2zcE6NHCQzYwiY6Qa
	 jpqcPc8+gMR7J/pPhDXgZ2+b58rCDLGoTV0hCK7Kfdyiv2PGYHRppgIaWgIKxF7HEA
	 XWvxgVmIM09vl2mkDq5PP76+yyo/eR/Ys5VMtXw+v04iYMVVjgNDte1XXGUQpzFwIn
	 HbDEf1LbiOScQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: sm6350: Add tsens thermal zones
Date: Tue,  6 Feb 2024 22:46:25 -0600
Message-ID: <170728117680.479358.4264274273106317400.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240124-sm6350-tsens-v1-1-d37ec82140af@fairphone.com>
References: <20240124-sm6350-tsens-v1-1-d37ec82140af@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Wed, 24 Jan 2024 16:31:43 +0100, Luca Weiss wrote:
> Add the definitions for the various thermal zones found on the SM6350
> SoC. Hooking up GPU and CPU cooling can limit the clock speeds there to
> reduce the temperature again to good levels.
> 
> Most thermal zones only have one critical temperature configured at
> 125°C which can be mostly considered a placeholder until those zones can
> be hooked up to cooling.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sm6350: Add tsens thermal zones
      commit: 646287950b165b8396a697f7e18e2267b9466149

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

