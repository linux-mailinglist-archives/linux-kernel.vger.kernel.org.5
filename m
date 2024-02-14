Return-Path: <linux-kernel+bounces-64701-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6118A8541B1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 04:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1F431F24C76
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 03:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7625DBA2B;
	Wed, 14 Feb 2024 03:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EV1L11It"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFEC944D;
	Wed, 14 Feb 2024 03:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707879631; cv=none; b=i4qGoAhNdEPcBNmzaeYwwc7Huh6zVWuEs0SQa7wA8aZbRpTP66nDUvQprPpa8PO2VQAk20SgVWdhDt1njWJ7Q3GMiRcflDT2Ocr9+ygG9iR9vJpIjuKkg5lqnniZja9kIACNN3HjTuUeqqD8EFIr7CRpWxWMs0XYFAxi9M5c8Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707879631; c=relaxed/simple;
	bh=Ef+XRJ4FZJ/N5CRIUrLmj8nX+Oe1wesb7u5TmVd3GUA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DJs52PSKkZBzN0PImY7hG0pp0LlByv57XqlaPbwDi3jubro8xdPf7mBMENICZtU3JM2t48it45sw97EFMxuEROsnvoeiPpTPUOnzzPnyxDnBJuxeZbosLezTqKgi3nKY2FL2UT/RKzw2JAqNUvaRrBeBOdnzJ0FYO/tBC0/mkfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EV1L11It; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2BF84C43609;
	Wed, 14 Feb 2024 03:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707879631;
	bh=Ef+XRJ4FZJ/N5CRIUrLmj8nX+Oe1wesb7u5TmVd3GUA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EV1L11ItGBKIzwgWJ9pWY7yF74ivBEFTHpkP0o1eBvnfgsT2Qc9Zy5dRrrRB/9f+0
	 BWFw4s+U84/xz0QogV7Fes5laZsejUizqu9Pka3wWu0JwXRYub+KRHmq/oBdVWOg+A
	 UOue9+//I8novz3RIjaq1GG7R5AxuOm0tQSttoS0XcNJsbzZuX8/sHgakXxHOwvpnw
	 CM2Sq43ZC5SYdLHkiRN4n/xpPvHO/2/KZh63a6O8KtRJPXRMTwbhHw9B+7vs9QMKVY
	 2qEwBZMEUEL5Bc/JhqwlO6xsZkwbS5B/ouRlOFWhro81bCYWH5ECCH/tpAEuo455pO
	 c7ekCueY+l79A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0FD5ADC99FD;
	Wed, 14 Feb 2024 03:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] dt-bindings: net: qca,ar9331: convert to DT schema
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170787963106.17924.6649356151141856536.git-patchwork-notify@kernel.org>
Date: Wed, 14 Feb 2024 03:00:31 +0000
References: <20240212182911.233819-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240212182911.233819-1-krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 o.rempel@pengutronix.de, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Feb 2024 19:29:11 +0100 you wrote:
> Convert the Qualcomm Atheros AR9331 built-in switch bindings to DT
> schema.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> [...]

Here is the summary with links:
  - [v2] dt-bindings: net: qca,ar9331: convert to DT schema
    https://git.kernel.org/netdev/net-next/c/4a78f0173be2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



