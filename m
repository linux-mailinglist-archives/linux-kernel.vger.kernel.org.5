Return-Path: <linux-kernel+bounces-132927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E819899C17
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:52:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A09D282EDA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657D716C852;
	Fri,  5 Apr 2024 11:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DIg4SUpZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A2C16C843;
	Fri,  5 Apr 2024 11:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712317960; cv=none; b=urUa8R8/mbW3cOH3vyZnDDigJtNoVZML4SvNSL7lyUkE+OHYjqx7ayrVRVyx4AYsTbNzMErBnAibFFRpU3EhuPGaAoQbpDC4iExSbsh9J9LJchTMfKZS+VMmbHs7pkkgw+28Elo7ffmlrKRDbwZmzR/7dTqP/w/yV0Hny5Yl60I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712317960; c=relaxed/simple;
	bh=iYJ2qgWwpyiw9ZpIe6TCSRFO2eBB+DAzhwOAZcKpxr4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ConR3+m+9eL1jewXcxYyEEJ5rp0lbktykByvFG9hOjIbYoSlIJw+Zs2ZaeSvU/FEE2ZYvX18fSbmoCzQaScI23ElaTGhu4z+ZfguLuGGoIrIXeFy2X+jd+bzrHd3qz92RQpBIwPQ/Ym/p33v0Z+kqZ8ffLQ/t6I1nej4YpcJlJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DIg4SUpZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E623C433F1;
	Fri,  5 Apr 2024 11:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712317960;
	bh=iYJ2qgWwpyiw9ZpIe6TCSRFO2eBB+DAzhwOAZcKpxr4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DIg4SUpZ8TfNnVULf5iNlaGS2Mx3Ix4zXJWWad7du1vLGXiNGAIaERPqU14NQjwE2
	 h0nTd2kzbaUnr2xy9311ZjOEXhJdoA92pmI6p/6JZY5Y7z+UenEkenoU0cONNX5ZJU
	 AZWAGpszuwIDEnEO8kJunzyzujQrJVEJkGBS3QFMf0OBUsxsLF2kGGT1+bu3ZkZXAQ
	 YHzkigV3aYgTBz1xJq3cb0gQyey8RjDdySc6UzSzk1s/8cd7FuK8RPZr4ztyCaMJ5t
	 JUKhoHGK2nPRX2Gkhthlkve8jMklXbvV0s092jAoYHQPqjrD6pm6QtCfqxHAIITyWj
	 j8Ile0+FT3yig==
From: Vinod Koul <vkoul@kernel.org>
To: linux-sound@vger.kernel.org, 
 Bard Liao <yung-chuan.liao@linux.intel.com>
Cc: vinod.koul@linaro.org, linux-kernel@vger.kernel.org, 
 pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
In-Reply-To: <20240326092030.1062802-1-yung-chuan.liao@linux.intel.com>
References: <20240326092030.1062802-1-yung-chuan.liao@linux.intel.com>
Subject: Re: [PATCH 0/7] soundwire: add support for link clock source
 selection
Message-Id: <171231795763.278895.15128022643962329162.b4-ty@kernel.org>
Date: Fri, 05 Apr 2024 17:22:37 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.3


On Tue, 26 Mar 2024 09:20:23 +0000, Bard Liao wrote:
> Since CannonLake, we've been using the XTAL oscillator as the link clock
> source, but since MeteorLake the hardware offers two additional sources:
> the audio cardinal clock and the internal audio PLL.
> 
> This series adds support for link clock source selection.
> 
> Pierre-Louis Bossart (7):
>   soundwire: cadence: show the bus frequency and frame shape
>   soundwire: bus: extend base clock checks to 96 MHz
>   soundwire: intel: add more values for SYNCPRD
>   soundwire: intel: add support for MeteorLake additional clocks
>   soundwire: intel_ace2x: move and extend clock selection
>   soundwire: intel_ace2.x: power-up first before setting SYNCPRD
>   soundwire: intel_ace2x: set the clock source
> 
> [...]

Applied, thanks!

[1/7] soundwire: cadence: show the bus frequency and frame shape
      commit: 8292c815bbb71ea9f86331c3d07d2b9530b93565
[2/7] soundwire: bus: extend base clock checks to 96 MHz
      commit: 7eca9c722eed80f76cd272a52d9fa98f89322e7e
[3/7] soundwire: intel: add more values for SYNCPRD
      commit: d0a69cd0369a390cc1c100e52e78a273695a170c
[4/7] soundwire: intel: add support for MeteorLake additional clocks
      commit: 09ee49e3de6bcecc57028682c673d180ec2d436b
[5/7] soundwire: intel_ace2x: move and extend clock selection
      commit: 769d69812b42f0fc710bdf16b9f3979c959910b7
[6/7] soundwire: intel_ace2.x: power-up first before setting SYNCPRD
      commit: a206d2e3409f58733c9097523e5f62ebb920fbbf
[7/7] soundwire: intel_ace2x: set the clock source
      commit: 5b3f661b244973374626f7cc798cea91345786e8

Best regards,
-- 
~Vinod



