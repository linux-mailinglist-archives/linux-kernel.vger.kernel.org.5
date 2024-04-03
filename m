Return-Path: <linux-kernel+bounces-128980-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BAE98962A5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 04:40:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2CA42B24607
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 02:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE151BC4E;
	Wed,  3 Apr 2024 02:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2xt6AxI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAF44C8F;
	Wed,  3 Apr 2024 02:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712112031; cv=none; b=ls5mmkhnkDZHCFM/M0PZSo4mRQQzJ4kV2xsgHc5Ae9idvgC4HPSLr4ZyMNGOLsS16WFcpTonwPbf5g1N/N5S8Ed36eaQUizRgGgzs0j2R2r1zYuORsjmv9SBlXvTiaT1JtUXOJWM+IlNc80aRr5rtXt3pjFsbx6cxAcPphx0LSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712112031; c=relaxed/simple;
	bh=vpqaqlSWC6/eipbM8VeBCBHZ0OjU5M+EVX2HsFIphNI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=X76AkVK2dPug+cIEnzFoj8GFlPId1vMmccPAbp/KWuKNTLWJ/634sqkGnRAeP5TZzu5ClVqSkYfC8MEimPx2fVzBbNVF8QqG9xFI6JrS3Xkucg79ssFzjc9i4ZJgy3e0qDZTmHusysMs3zE+dZUwdRARrAvEtV5ntLrc8XgjSMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2xt6AxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A76F1C433F1;
	Wed,  3 Apr 2024 02:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712112030;
	bh=vpqaqlSWC6/eipbM8VeBCBHZ0OjU5M+EVX2HsFIphNI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X2xt6AxI9xYIRPdS5PFGeoX8YmzdTbmSe+TFQW4E3jR4o0TMg0S+R6O+e/M5xt/sJ
	 mm8HxFHpF7S8RNfZ6gz+ffzeGAy7LbxHCsdjkPOpUvoboOSuvGlnjcHoGZVpLfYe9t
	 VhtUPITTKfLmsFEmUkfP0Md5b2GLSQ8fsBTd4QsDAXCkYPjXen8Rh1hXQnjZEQzPRm
	 SWg4kon+Qj+3Dsd3gBehQTPKFSr27Q66pDelvaXQGBzZEolpiMm64/fwKOuYdqElmQ
	 xLKzS9LzB9aQxtihmiPnXW7pRatGiLmJUpH7Vhz0nH09pbu8ccETMvFANKNXaxBR8N
	 i972ZVnjbssFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9880ED9A14F;
	Wed,  3 Apr 2024 02:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dt-bindings: net: snps,dwmac: Align 'snps,priority'
 type definition
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171211203062.15246.4053010370038669671.git-patchwork-notify@kernel.org>
Date: Wed, 03 Apr 2024 02:40:30 +0000
References: <20240401204422.1692359-2-robh@kernel.org>
In-Reply-To: <20240401204422.1692359-2-robh@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 alexandre.torgue@foss.st.com, peppe.cavallaro@st.com, joabreu@synopsys.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Apr 2024 15:44:22 -0500 you wrote:
> 'snps,priority' is also defined in dma/snps,dw-axi-dmac.yaml as a
> uint32-array. It's preferred to have a single type for a given property
> name, so update the type in snps,dwmac schema to match.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/net/snps,dwmac.yaml | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] dt-bindings: net: snps,dwmac: Align 'snps,priority' type definition
    https://git.kernel.org/netdev/net-next/c/992c287d8778

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



