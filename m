Return-Path: <linux-kernel+bounces-31910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCDE833648
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 22:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 725121C203BD
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 21:12:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1949D28360;
	Sat, 20 Jan 2024 21:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d6RpqXL/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485E91772B;
	Sat, 20 Jan 2024 21:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705784999; cv=none; b=EsC7VGWt0FchA3ApYShZm16jZj16U2bXjLMBvGTW/m0vZtovnic0c4SnZmNW+eBCGaaK0bqP/K6fG9syaYFkM3SmVvQswFzHb757iF9YVbfHzrvxOI3gGp3xavtSW6o3mS04lg0eGKRPjykOXmdTuJ/EY9VnTKvSUYz+n1Jxgp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705784999; c=relaxed/simple;
	bh=q+nub84U23nvD+cn7YvgYkoUGFiaXs85dZdXJ4xFhpU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qA5VpQA/38RgucgfkOaby+7+Xd7ylNGR8Eqsnl3aEyH3CR62PSGkKZh7BcvhOppkM/yf9H3yZx6VI52DGMmdfP7VTKQ7wr9Xf9/QSfCXmt98/J42FBqG7pFMZeAtvKYInHWfxmI4qZ3w/A3tp7KH6G6OXh3lYd226Sdwkfnt13Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d6RpqXL/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BECB1C433F1;
	Sat, 20 Jan 2024 21:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705784998;
	bh=q+nub84U23nvD+cn7YvgYkoUGFiaXs85dZdXJ4xFhpU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d6RpqXL/1LZrgglNCxscGX37U9C04RSJDlu9mrU8bupnby5ZS4JKTlFT4eeYAlWsC
	 Rq9sXv9czypfWp6lI5AP8UmCHdyVB/BU1/0vRAbpo3oUfmrKIDev9To7g+kagjcGwt
	 DPecFerWRld02oOeW9OUjgHXT8uCI5bt1XlZX7+o/HaLB4YZb058QLztbDYN6wjLmk
	 rtaf91Q6Gp2xnO1AdFujjlrTfI6f1N4QzRCUm47BRCqcSpvyzqYt6Um9rrSsiIzMLt
	 AW3dUIOZalnqBPYOn0FSC8c7gz007wJU4RrazDsq/0hR8JM06FSCGxYcYRQKLNlv00
	 rvSGfy6pM1SUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AE98BD8C96C;
	Sat, 20 Jan 2024 21:09:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] riscv: dts: sophgo: remove address-cells from intc node
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170578499871.24348.8897896227923136554.git-patchwork-notify@kernel.org>
Date: Sat, 20 Jan 2024 21:09:58 +0000
References: <20231024-maternity-slang-fd3dcfb211c0@spud>
In-Reply-To: <20231024-maternity-slang-fd3dcfb211c0@spud>
To: Conor Dooley <conor@kernel.org>
Cc: linux-riscv@lists.infradead.org, conor.dooley@microchip.com,
 chao.wei@sophgo.com, unicorn_wang@outlook.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Conor Dooley <conor.dooley@microchip.com>:

On Tue, 24 Oct 2023 09:20:35 +0100 you wrote:
> From: Conor Dooley <conor.dooley@microchip.com>
> 
> A recent submission [1] from Rob has added additionalProperties: false
> to the interrupt-controller child node of RISC-V cpus, highlighting that
> the new cv1800b DT has been incorrectly using #address-cells.
> It has no child nodes, so #address-cells is not needed. Remove it.
> 
> [...]

Here is the summary with links:
  - [v1] riscv: dts: sophgo: remove address-cells from intc node
    https://git.kernel.org/riscv/c/e80ed63affc9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



