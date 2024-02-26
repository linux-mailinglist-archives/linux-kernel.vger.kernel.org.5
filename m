Return-Path: <linux-kernel+bounces-82261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48111868153
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 20:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79E7F1C23F13
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3757A12FF9E;
	Mon, 26 Feb 2024 19:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bn7ZuoAR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF7F7F7F7;
	Mon, 26 Feb 2024 19:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708976671; cv=none; b=isMU09TEZQ4syP0nSFoPHgt922+9CzhDpmhSIgMb6KoFg1WS3dGwypqHPOkwvJkCZdQm/t+BQRIVY7Xs6zkS7LyGeZsrkXKXhQXEl6JT5LIAa7OX4PMyg16xdXauj/cqemL890KWawEBByHSZENMb6jNEndbg7p02VrBI1KodGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708976671; c=relaxed/simple;
	bh=Mwv0aNfg9P7giKd7wIo6X0X52T88pKlUu86DfGd/kM4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXpZ0tC0CfSFRL6gFcTi0ZttCszp6QKoCse1DX9xYxNsdz9qRggPKSMMY/w6zq0WcNscoQ0hb3SP/RM9AkfmC2OSZx8/ulz45bUTWFF2hZiC8SYQzPd+fXuJg9pLrRDWBENNblU46NS3xBXPFPUedQkgBiEN1rpSmc5sjt6qO6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bn7ZuoAR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF1CC433C7;
	Mon, 26 Feb 2024 19:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708976670;
	bh=Mwv0aNfg9P7giKd7wIo6X0X52T88pKlUu86DfGd/kM4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bn7ZuoARBiuDF78jzVGaZqPyf0Qm6pD6novxGr9SCaztF1MRlP7uSmC3ScpsKgbC2
	 CKG6zRyVTDRE6XnOa77zpt0pW72E3jQ/QfDf36RSkZrBSNFmnPBy2qi5ju80QJy3/r
	 oRKYzMlrYgn1xT/nrokCmK6f/cxHUwCD9rGnTQQEFDbyGutXnjHs/m23wVwCPWeLcC
	 bZSkKVZ9FJYwpD1dD/atWEi5JrB/8Xeb6d3CpmSD9xICa7krAuoJh7ycj69FYxIZwF
	 aKKNNgi+b0fSgIttcjYuH36U2rpa/qCe6mg1xgUNK3DR+cfEV43GpN9y3kTkFa1ri+
	 umNwX6JuQkoyw==
Date: Mon, 26 Feb 2024 13:44:28 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: devicetree@vger.kernel.org, Michael Turquette <mturquette@baylibre.com>,
	linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
	Stephen Boyd <sboyd@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	linux-remoteproc@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 1/3] dt-bindings: clock: keystone: remove unstable remark
Message-ID: <170897666765.1319236.5035021925179414323.robh@kernel.org>
References: <20240224091236.10146-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240224091236.10146-1-krzysztof.kozlowski@linaro.org>


On Sat, 24 Feb 2024 10:12:34 +0100, Krzysztof Kozlowski wrote:
> Keystone clock controller bindings were marked as work-in-progress /
> unstable in 2013 in commit b9e0d40c0d83 ("clk: keystone: add Keystone
> PLL clock driver") and commit 7affe5685c96 ("clk: keystone: Add gate
> control clock driver") Almost eleven years is enough, so drop the
> "unstable" remark and expect usual ABI rules.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/clock/keystone-gate.txt | 2 --
>  Documentation/devicetree/bindings/clock/keystone-pll.txt  | 2 --
>  2 files changed, 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>


