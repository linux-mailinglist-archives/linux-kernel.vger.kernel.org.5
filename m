Return-Path: <linux-kernel+bounces-90262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AF39786FC97
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:01:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AB61B20F56
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B333D21109;
	Mon,  4 Mar 2024 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XnvsfNRn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1AE218057;
	Mon,  4 Mar 2024 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709542829; cv=none; b=Vmbal7e8dTiMUtWs9+53K/Mbd0pwvMctiuqlZ4Qm1ri+HFWA8SuLrrZm9N1hCHxi65LHsZZculwfSrQxfo4NxXPYEtOmMs1p5OTWm9dPXmNLiWlFGMSwmCk+C0kO+lDSOg7Mef10eSmph2G1/Lj1SETjH7JbDuXCXq62PB4CJo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709542829; c=relaxed/simple;
	bh=lpAla7wjpZULTCy4CgRg13SFGYC/LTxCvynPKvFBgk8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VlJ9QnG+KXMFALb2ybhcn8gAM88jk8tL7jp7ojrfjtpSBQYOc7bsAWzV4dpu7K3yYQJ13F6jO4/rCDNY37pGwmEU0oFY38roYQmuPjqSAbglF4qDmx6+MoxcOzH0qy6r29fxl8BCq8r3tHi2bFaWOg455YN7XOZnhq1qMudByjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XnvsfNRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B56BC433C7;
	Mon,  4 Mar 2024 09:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709542828;
	bh=lpAla7wjpZULTCy4CgRg13SFGYC/LTxCvynPKvFBgk8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XnvsfNRnh9tx/jEHrAcvA/yuL9T/HFNvTfMk0RTZm8y3C9/zHiRWhZyn9SEB8k3dw
	 tWmc10pddGxCElPg3ZbJ8OgW3o1I8yMDzU+Zqy02/lWmOhpg+Hr59XsjA608von66v
	 +S5ofjpQ9GZNXTUC0FBHErTwV8Pg3MgKxPN0L6DWaoC00GVbtZfZxPAD3iqeCQE67a
	 Ojqqm6M791SZyH+e7jIS0dIUdLQyNsoQOR/Y7g6LpGTI1jU4jkggL//xcSQ7DSib+m
	 HUbJnvhoAZSGuAdnGUeDSGQEra9S6fKw0O9tlX+Vg7un/6nERST1AMEnHu0H1Vf+WZ
	 sOlBIu75ea8Aw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4AB5CC595C4;
	Mon,  4 Mar 2024 09:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND] dt-bindings: leds: pwm-multicolour: re-allow active-low
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170954282830.2135.17625030566348982975.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 09:00:28 +0000
References: <20240229-excluding-bonelike-d8f01dcc0623@spud>
In-Reply-To: <20240229-excluding-bonelike-d8f01dcc0623@spud>
To: Conor Dooley <conor@kernel.org>
Cc: netdev@vger.kernel.org, conor.dooley@microchip.com, robh@kernel.org,
 pavel@ucw.cz, lee@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, sven.schwermer@disruptive-technologies.com,
 ansuelsmth@gmail.com, linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 29 Feb 2024 18:24:00 +0000 you wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> active-low was lifted to the common schema for leds, but it went
> unnoticed that the leds-multicolour binding had "additionalProperties:
> false" where the other users had "unevaluatedProperties: false", thereby
> disallowing active-low for multicolour leds. Explicitly permit it again.
> 
> [...]

Here is the summary with links:
  - [RESEND] dt-bindings: leds: pwm-multicolour: re-allow active-low
    https://git.kernel.org/netdev/net-next/c/df620d7fabe9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



