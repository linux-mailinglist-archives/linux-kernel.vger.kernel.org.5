Return-Path: <linux-kernel+bounces-47913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17B2184548C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C721328A7DF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FD780045;
	Thu,  1 Feb 2024 09:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rgKKp9Fb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF3C4D9E8;
	Thu,  1 Feb 2024 09:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706781026; cv=none; b=TjHuVtOsJOdCV2AO6oZfK2MeznItZ1tfkdNuae69TvohgAPB6/tlzDHUZWkukAHZGFeX7Qf1KcGVBbpEyMgPpH7jSqBEopClrT0kjYY4vp63NunPxXel1BVtpf3D7ZPlbvtmOq73sSKXqsZGdWQ88Df04HVDINo560iJHaim9go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706781026; c=relaxed/simple;
	bh=heLY3xnN70UESqZim9udaT6wWjubP3iz/pVeh/8OHPU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BfvQAeFN7sf3hdWEiMXLcJYERgkQLuKYfnbnEP1tq+bK6T5DEDF3P6m+bsb/BNG99CS6pmdHPgrwQpE0TOzkFootgaKMiz8xIJtH21B2g9YKvlmnSGviBkCtMhpvC50L2hkFdNT4gWSOCmmGZnN1PRG5kwbcfYzRMWPjtLLkhqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rgKKp9Fb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F589C43390;
	Thu,  1 Feb 2024 09:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706781025;
	bh=heLY3xnN70UESqZim9udaT6wWjubP3iz/pVeh/8OHPU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rgKKp9FbcwRq7eKMdfalaqj6Y8h8fvF2beSM+I8W6k8QC2MXe8b9mzLL1cKvYwNeV
	 uYzKcPMG5J7KjaLA3L+AV+exroAYZg6LBMU//VkEOt3mK9/ua+nttRjDjIUfLryoDg
	 ZX7UTbfli7eWtjl0Al9lh6JMxofINjyeTDuQ4MAamMcaZCCPYbnQHJr4bpdHuJngHw
	 AUUEUb5igSoX7q9T/rRw0li3C4SyvyMlDcP6xZiGIm1gBKbP99Yv/PHwMkhBiJr4l7
	 GLpDkuRsFpOFHC0t87EIzSFx8h5vXC2sGL3rHlUH3Z16LCRw3/nsR7qEfhy4iIb/cH
	 3ocqvumSGmzDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75392DC99E5;
	Thu,  1 Feb 2024 09:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] dt-bindings: net: qcom,ipa: do not override firmware-name
 $ref
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170678102547.16078.6373938266088244682.git-patchwork-notify@kernel.org>
Date: Thu, 01 Feb 2024 09:50:25 +0000
References: <20240129142121.102450-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240129142121.102450-1-krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, elder@kernel.org,
 linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 29 Jan 2024 15:21:21 +0100 you wrote:
> dtschema package defines firmware-name as string-array, so individual
> bindings should not make it a string but instead just narrow the number
> of expected firmware file names.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/net/qcom,ipa.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - dt-bindings: net: qcom,ipa: do not override firmware-name $ref
    https://git.kernel.org/netdev/net-next/c/b2005bb756e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



