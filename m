Return-Path: <linux-kernel+bounces-84914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A6386ADA4
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:39:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37EE1C22F50
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539B01649A7;
	Wed, 28 Feb 2024 11:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKYsrabL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A55A149E0E;
	Wed, 28 Feb 2024 11:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119832; cv=none; b=NnIUMd8knNQDjCmJ3q6CXaOzQ2p3KBrymmEP9j55O6JLl8Jt+lLcyKhpoVs6i3nsuRpvmv5LZnyZ8L8wP+Zvdu1Vfxnqv/hgfHjF7nnQ/GOTEOY2mbqGKZXMmKzVWtZoP1XnXsuns6Jl+EOLoyVHIzeUBq91elYjYb82IruTUao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119832; c=relaxed/simple;
	bh=lFcJGAGA5lcdDj56mNYSZV+dF9xdORWlqOqFhmkTMpY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FddFSenXGwnVwcXW4hksmH+l7h5+iwBxGCIWNUW9Qb7EFuLCh5EKxdBOsPO8kzGb6zbRMha2x6h4R3pg8lbC6hVnk8yESZTBkWkcuenV6OS10l1noVdua4s8KyKWP5CH3lXFOFb4x5KSTCKoGotjzJNiu/Rr/A0QLxvvL25RRRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKYsrabL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4E8F8C43141;
	Wed, 28 Feb 2024 11:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709119832;
	bh=lFcJGAGA5lcdDj56mNYSZV+dF9xdORWlqOqFhmkTMpY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CKYsrabLBrEuo0epyrgwkcdozKSzdA3nAWk/hRMw/4XGMv6R3FxqaFS1S2pCp/ylG
	 ZzCbjUrMiDzAOvpDffiU09oYBVuSGRSpWWuJL6dnFs/9JM9/jvqjHz0ipEgn7mPy5j
	 qkLNn3DkXKQhjRolmY3X3mdPI+JTfEAowua/gnWRiDDRcV0KSBhyqbIRu7uF9MFSTO
	 YwcKOmBLxN05f34Ap46Z2m6zNQo42x4AJU8YuhGL1GQ8IFh2Rr1lAD8mNAjN3zDtLk
	 TMTt/vdwcqWCl352R+w7Pnx04fcPueo3Ya5x+yA2f3dqppt7YNMYfDFOZ/4AjLwz4Y
	 UjvwBowqe4RYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 34ECFC595D2;
	Wed, 28 Feb 2024 11:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: stmmac: dwmac-qcom-ethqos: Update link clock
 rate only for RGMII
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170911983221.5841.1928393024313525974.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 11:30:32 +0000
References: <20240226094226.14276-1-quic_sarohasa@quicinc.com>
In-Reply-To: <20240226094226.14276-1-quic_sarohasa@quicinc.com>
To: Sarosh Hasan <quic_sarohasa@quicinc.com>
Cc: vkoul@kernel.org, agross@kernel.org, andersson@kernel.org,
 konrad.dybcio@linaro.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 psodagud@quicinc.com, ahalaney@redhat.com, robh@kernel.org,
 kernel@quicinc.com, quic_snehshah@quicinc.com, quic_jsuraj@quicinc.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 26 Feb 2024 15:12:26 +0530 you wrote:
> Updating link clock rate for different speeds is only needed when
> using RGMII, as that mode requires changing clock speed when the link
> speed changes. Let's restrict updating the link clock speed in
> ethqos_update_link_clk() to just RGMII. Other modes such as SGMII
> only need to enable the link clock (which is already done in probe).
> 
> Signed-off-by: Sarosh Hasan <quic_sarohasa@quicinc.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: stmmac: dwmac-qcom-ethqos: Update link clock rate only for RGMII
    https://git.kernel.org/netdev/net-next/c/26311cd112d0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



