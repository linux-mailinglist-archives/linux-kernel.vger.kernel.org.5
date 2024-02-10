Return-Path: <linux-kernel+bounces-60440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B80058504F9
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 16:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E9351F23109
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 15:40:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD63F5BAFF;
	Sat, 10 Feb 2024 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f6T7GiZT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A90A5381A;
	Sat, 10 Feb 2024 15:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707579632; cv=none; b=CHoKc1ihGXnW1t27LoWFjt9tkF7OiPNJ4U5nCHCAjUg+T/cHtvkMAk/OOvKc3iEPpukQ87UaIBVehCQw6o5Uzjqk/ZOeNdvRXB/kJ6j1IfD8MF0DD1O6HOb/IlkM8lH0S/4RpjRXic2wCFi6P1yzuA/bm9Hcq5yuOvBRWosEf9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707579632; c=relaxed/simple;
	bh=o90dBGsaOc4h8XZXjOy2Vf5kYvkiA8PHxCs2WzXIIkE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XgcXOW00RADCfs5lRzqMm2plwTZnB7M94Orrbd1OGVJDa3ZZYkj2udTVsOk0BYP/R/39v11A30I0hRxN7toXjNJO6g9cECi6QEPU3wEkNGXc9ByoVKZ8bqHxvtZXiB7sCOrRgxJhWUvQWhd0lGpNICaOxwzH07DD9e697jOojp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f6T7GiZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59049C43390;
	Sat, 10 Feb 2024 15:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707579631;
	bh=o90dBGsaOc4h8XZXjOy2Vf5kYvkiA8PHxCs2WzXIIkE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f6T7GiZTni50nnfBV1omFsyGeirpUSqU6elXu7ewt73RCq5+HOh7VkVrdRvFRHFXO
	 jv/YxV4p119HjSnoK6JdqiqM2se0/BLhlu/K6z+glLLEJHnfWWuLzXOCPJtgBp/o2w
	 tF2MawnXCGeor1yXB1IzOu3WSKSRwVk8/7LP3QkA+fzNPGE36vA+3s9beLRJ4tLU/t
	 hJWl5aUoOkdvlFUIOG6/b0OwmVA+2dAlMGRMOtyyLdohaX6m0UxwcH3fzhK7W2dUtr
	 9V/FXrJt4dFSdAnF9jCaKjiMQpdnnvGvSyxX9opVSY8ubbVEM1jzm2Is+qPH/0Abcf
	 Ex1Gz38JgLzDA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3E5E6E2F2F0;
	Sat, 10 Feb 2024 15:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH v7 00/10] net: phy: Introduce PHY Package concept
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170757963125.14284.2496460448206023966.git-patchwork-notify@kernel.org>
Date: Sat, 10 Feb 2024 15:40:31 +0000
References: <20240206173115.7654-1-ansuelsmth@gmail.com>
In-Reply-To: <20240206173115.7654-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 robert.marko@sartura.hr, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue,  6 Feb 2024 18:31:03 +0100 you wrote:
> Idea of this big series is to introduce the concept of PHY package in DT
> and give PHY drivers a way to derive the base address from DT.
> 
> The concept of PHY package is nothing new and is already a thing in the
> kernel with the API phy_package_join/leave/read/write.
> 
> What is currently lacking is describing this in DT and better reference
> a base address to calculate offset from.
> 
> [...]

Here is the summary with links:
  - [net-next,v7,01/10] dt-bindings: net: document ethernet PHY package nodes
    https://git.kernel.org/netdev/net-next/c/8453c88c7a15
  - [net-next,v7,02/10] net: phy: add support for scanning PHY in PHY packages nodes
    https://git.kernel.org/netdev/net-next/c/385ef48f4686
  - [net-next,v7,03/10] net: phy: add devm/of_phy_package_join helper
    https://git.kernel.org/netdev/net-next/c/471e8fd3afce
  - [net-next,v7,04/10] net: phy: qcom: move more function to shared library
    https://git.kernel.org/netdev/net-next/c/737eb75a815f
  - [net-next,v7,05/10] dt-bindings: net: Document Qcom QCA807x PHY package
    https://git.kernel.org/netdev/net-next/c/dd87eaa13787
  - [net-next,v7,06/10] net: phy: provide whether link has changed in c37_read_status
    https://git.kernel.org/netdev/net-next/c/9b1d5e055508
  - [net-next,v7,07/10] net: phy: qcom: add support for QCA807x PHY Family
    https://git.kernel.org/netdev/net-next/c/d1cb613efbd3
  - [net-next,v7,08/10] net: phy: qcom: move common qca808x LED define to shared header
    https://git.kernel.org/netdev/net-next/c/ee9d9807bee0
  - [net-next,v7,09/10] net: phy: qcom: generalize some qca808x LED functions
    https://git.kernel.org/netdev/net-next/c/47b930d0dd43
  - [net-next,v7,10/10] net: phy: qca807x: add support for configurable LED
    https://git.kernel.org/netdev/net-next/c/f508a226b517

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



