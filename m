Return-Path: <linux-kernel+bounces-134695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B83189B553
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018551F2149B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 01:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E074690;
	Mon,  8 Apr 2024 01:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EkQzV8uR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86667187F;
	Mon,  8 Apr 2024 01:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712540278; cv=none; b=REmas+z+wJ9VRVa4OrfN1pH/aWbbN/60Yng2ZjqCeGXiL/AwHGdmGLWqc+9+Xsbh3W9wDqzZpEKEF2S7w1BpYqCesWlzG88WnNMPgCcaqZ9hyuEV9LKqGANdycm5REf2P0ir2C4GBbjmxB5DMw0/urArC7pSiv3fLJqbdw2oEHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712540278; c=relaxed/simple;
	bh=FKRr59bnoSJ/cfmYSgW5fo008spilcw+Pq53lNLz3Ws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=As+Yc5Z9azsfqmGbzoL6hEcST6uyg7LKg2FTg5o9KaTivDbPl8BlonWwQtTbVUOOAaU1pdWEPEt9CzvN5J/omNnSu87YtdFmDLuC8RMOYzRtI8Jez40oYtLi6c2Lvh7w78HbseFlNAf27t92QQA4uEQqBZz8iCtTC5OvzH9FoGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EkQzV8uR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBA0AC433F1;
	Mon,  8 Apr 2024 01:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712540278;
	bh=FKRr59bnoSJ/cfmYSgW5fo008spilcw+Pq53lNLz3Ws=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EkQzV8uRHLK7Jvrey/8LA9EwCoYz/rn2pNZRaQA0mf9dOLkrn9jXoYziEtIg7sSvB
	 UOEu0wlhURugkQbrQg22qR/RIZLo6m8uYOja1B0XUyoWwW1L7TxmufrE1Zdb11Cgc7
	 Snoo3IxGnP4Vdf4fKMhEkXGw0G9SpHxolb7XUxfKpQ/T55L7S5JwdhvKumWaqPKRw/
	 CozbYWFwU64BxbwlxerX7J8Vv4L7ZASYXk3ps33FfmrCfFXYzmOx7NxGPd7sWwIBNk
	 vKb1JWYLTr5Ny57gLqK2J5AtgvNoYO/CXB1g2MQmU0y+X9E1pdFGOlx1SwMCKtWhSv
	 JdD8ynbeaVOoQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	phone-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v3 1/2] dt-bindings: arm: qcom: Add Motorola Moto G (2013)
Date: Sun,  7 Apr 2024 20:37:52 -0500
Message-ID: <171254026544.648389.453877144471637208.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <32c507337ab80c550fb1df08f7014d1e31eb4c32.1712480582.git.stano.jakubek@gmail.com>
References: <32c507337ab80c550fb1df08f7014d1e31eb4c32.1712480582.git.stano.jakubek@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 07 Apr 2024 11:05:10 +0200, Stanislav Jakubek wrote:
> Document the Motorola Moto G (2013), which is a smartphone based
> on the Qualcomm MSM8226 SoC.
> 
> 

Applied, thanks!

[1/2] dt-bindings: arm: qcom: Add Motorola Moto G (2013)
      commit: 4785ec47ec890fe66f31ee886a767dbdf2ea6bae
[2/2] ARM: dts: qcom: Add support for Motorola Moto G (2013)
      commit: 49481b6a8f35017af23e9fdfb644095f50a474e3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

