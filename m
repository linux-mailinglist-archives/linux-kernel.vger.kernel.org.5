Return-Path: <linux-kernel+bounces-69464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 575508589E5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 00:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A68F1F28601
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E44914A4F1;
	Fri, 16 Feb 2024 23:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="odrj2f42"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F7014900F;
	Fri, 16 Feb 2024 23:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708125054; cv=none; b=ixYIjZrV7eIURNm4JK37k3Fqw6P6KDznVH3Ka85Ez3KaAhp+kwMmZ2tO78HJEqw8JyRcLDfQd62hGg9KBF4yG1ASpxQeZz6GdoePNzv0hUgWkNYdr8WLsYTHOhHM3v1XMhQ3xyEZUAYc/NzzdS4Hz8g4PT1j9StReP0NmVFWzfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708125054; c=relaxed/simple;
	bh=iBsqvuJx9/Q2mBm8XmU6WQRn/IPKZuxa3TbJISaCg2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=efgPzOGxrpSY2AlGhHLOIGjpwCtARtwU8bJfA9PBz35kmZN3kwc7gq0thcBiRATkCx3JB1oAT8jOq2Rje8k9DnKtBXwbdAsozfGPsaz92Aj7NR/mXbYj3cNsl39eVX6B265vaYLeGheDcaQtyEBE7tAtvVBPg4CfQEloBnj3Ars=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=odrj2f42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DB83C433B2;
	Fri, 16 Feb 2024 23:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708125053;
	bh=iBsqvuJx9/Q2mBm8XmU6WQRn/IPKZuxa3TbJISaCg2c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=odrj2f42ooh6z4ljcUNzH7WcqJrODOUpXLeoAFuMQPEDsd91GQFO1OvMuK04yJqx3
	 WcU03WwarfutjrV1eZNdyb66MtWCfbmLOwtUAw/qNC+Uki87cBF5l+BgYMoVe4I02c
	 mr06K5RZkwVGE7006QYP4NHgg2Ybq79GUzyFtzvdbVKveA8YT+GWIg7ror/FVHcLuc
	 Jay75OLSPKHzWtNvAndwZMevalckocMaIuyUmG5f1O0ECOKZMmRm91e1zUKk/SLsJK
	 d9woVUroyFRnRewtCi37+vJlN97Z6dvYzNMEVHUxCh3IfHE5onojJaWs6orZJ3nb8u
	 +kIyp1rOUstcQ==
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Luca Weiss <luca.weiss@fairphone.com>
Cc: ~postmarketos/upstreaming@lists.sr.ht,
	phone-devel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) [PATCH 0/3] Add PPG support for PMI632 LPG dtsi
Date: Fri, 16 Feb 2024 17:10:38 -0600
Message-ID: <170812504026.18043.12596968738983352722.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240205-pmi632-ppg-v1-0-e236c95a2099@fairphone.com>
References: <20240205-pmi632-ppg-v1-0-e236c95a2099@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Mon, 05 Feb 2024 10:51:37 +0100, Luca Weiss wrote:
> Hook up the PBS & SDAM to the PMI632 LPG so that we can use the
> hw_pattern for the LEDs.
> 
> 

Applied, thanks!

[3/3] arm64: defconfig: Enable QCOM PBS
      commit: 9c5c14c066f353ac1f4e3b4dd6e19451eac61e0c

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>

