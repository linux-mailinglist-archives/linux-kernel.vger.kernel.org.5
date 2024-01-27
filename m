Return-Path: <linux-kernel+bounces-41428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EDC83F0D0
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 23:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BE14B25FBD
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 22:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B291E536;
	Sat, 27 Jan 2024 22:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7WbNoAj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E03241E6;
	Sat, 27 Jan 2024 22:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706394891; cv=none; b=AftQDfpCBjksemJNkwlmsHZrc1Ypcjsvo3/n+LasiwU421pJEzJNyq5tvqqIw17wW89xfErhNhqMZ8gzFEQrrJ/oNQOV599YxykdjPAfKqX9UtGKzccXAAQYGOxLn3gVCfOxEDDsbEMp6vPyAajiR3AJs3UAjL9Sew86R1xwSjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706394891; c=relaxed/simple;
	bh=3MtbqTRUkghGjkybbP36SJXviTXb0b228TDWVW5PFz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hrYi8JEy6uE09cQ6UNLFHBzRC0y6hKJDJkesA7vPfU2jIebggD/Ris5FT47E+Yk2bFLRO2J4wZieZSjrMXZUMzjri4p6RNNjgcjImXOMOgMqT/H0xZTqnXMBRUWl9bJwbQj+1x8AqTvtLVe5Ff8sPrUjzLjNj8u54494DaIwcqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7WbNoAj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53BDBC433C7;
	Sat, 27 Jan 2024 22:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706394891;
	bh=3MtbqTRUkghGjkybbP36SJXviTXb0b228TDWVW5PFz0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a7WbNoAj9S4ZcRMQdS4RyxpWHOdBkP3QOvgTJjg7UNReoHSnfOAMCr3tKGJgRwu0p
	 ZNQ2QuJ50PNUAOIJXw1zK72yX/O1RDfOSZ5/eaP8Pn0pgsgnricuwz61Sem5gQ8vV9
	 NbBiyArE11rtplRHF1hNjAQvfRv0KKZoEZ4wsErG/FXyKVLgPg7nBbg/KAV7gEjwSl
	 EfhienstjLbWrsjDOQdgdRyyek2qXMv1OF2QuoxzBRbyt1v+EVtr3D2GPPxmXVP4sy
	 RKlktbRBwJ6XbmI8rdpGb6kd7GpWPZ/bPTHF/XGUTuhHe5HhROtM6riV5emTGra5d1
	 8A8MHJJUf0d4A==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Amit Pundir <amit.pundir@linaro.org>
Cc: linux-arm-msm@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gcc-sdm845: Add soft dependency on rpmhpd
Date: Sat, 27 Jan 2024 16:34:42 -0600
Message-ID: <170639487720.21016.8909458221744793614.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240123062814.2555649-1-amit.pundir@linaro.org>
References: <20240123062814.2555649-1-amit.pundir@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Tue, 23 Jan 2024 11:58:14 +0530, Amit Pundir wrote:
> With the addition of RPMh power domain to the GCC node in
> device tree, we noticed a significant delay in getting the
> UFS driver probed on AOSP which futher led to mount failures
> because Android do not support rootwait. So adding a soft
> dependency on RPMh power domain which informs modprobe to
> load rpmhpd module before gcc-sdm845.
> 
> [...]

Applied, thanks!

[1/1] clk: qcom: gcc-sdm845: Add soft dependency on rpmhpd
      commit: 1d9054e3a4fd36e2949e616f7360bdb81bcc1921

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

