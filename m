Return-Path: <linux-kernel+bounces-116518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD41388A04C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ACBE1C37406
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332B113E415;
	Mon, 25 Mar 2024 07:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DhmNMN2t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EEDB13E6CF;
	Mon, 25 Mar 2024 04:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711341755; cv=none; b=GDFh5XHwg9ZS2TuHlYos9RCEtapuV7tfj6/WABJ1W/heT97e5uRMSp1O6H9PPlx5EgWHhb95+AVX94MZ3+1mTLU8o1IyRve8beWYsdjTWFZXgVMbY8DrP2oqiY/WC0EI3VEIe1HFkANAEqdPuKqtE9LTkOVDM2wsHsJyBnXPTaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711341755; c=relaxed/simple;
	bh=983c2mSpRtzHZd3RX0FbvmlLGvQpO2bWYGuEJVdPXiM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SHYG8//jYNw4N4uYX1WYDxaK/LMWrEAdSoqOu7olXWxiTGn5XJhqcQI6BXTV+su30Np+1NWD0UtksNGqkjI9cDm0JAL0IOHT3vmK8pKAH03j6PjlC0RzVVV2TUe0X/N2VSAxeq1gzzMn6KPFaeMyK8mqARDJC+miQiPgxgEJ4xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DhmNMN2t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 92948C43394;
	Mon, 25 Mar 2024 04:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711341754;
	bh=983c2mSpRtzHZd3RX0FbvmlLGvQpO2bWYGuEJVdPXiM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DhmNMN2tF/acZiHHFVovBVnZwiaO1oB814vBKArondxj3E1Byyz1qqTWxsohjhYg6
	 +gI7iq0jLQCxC9L57FIwH5krZFrHzIQMVBnYaoXC4vKu59wvi0mNYTQJvad+gSMoAp
	 5aO1xde4w9zblgHpuzrJ7ndoEMK/drH1yiaqc5EZnMC0J0Zxf3FrYFIGQQ/KYzW8sM
	 y7ugrQNZYbu3t0noHgiLkMX8Ie1VIkarzj05tC/ONvktMIOf9+Ru2uSf9InpLcX7IS
	 0qts8mBqdqFKCakLJw0lmbLK39TOQHEOzIalOU4A/6VUzfyJEreK9Ue9aPfxudRl5h
	 M4d8b/4W3VvWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 857A0D2D0E0;
	Mon, 25 Mar 2024 04:42:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/4] riscv: sophgo: add reset support for SG2042
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171134175454.18749.13038964057011467100.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 04:42:34 +0000
References: <cover.1706577450.git.unicorn_wang@outlook.com>
In-Reply-To: <cover.1706577450.git.unicorn_wang@outlook.com>
To: Chen Wang <unicornxw@gmail.com>
Cc: linux-riscv@lists.infradead.org, aou@eecs.berkeley.edu,
 chao.wei@sophgo.com, conor@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 palmer@dabbelt.com, paul.walmsley@sifive.com, p.zabel@pengutronix.de,
 robh+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 haijiao.liu@sophgo.com, xiaoguang.xing@sophgo.com, guoren@kernel.org,
 jszhang@kernel.org, inochiama@outlook.com, unicorn_wang@outlook.com

Hello:

This series was applied to riscv/linux.git (fixes)
by Inochi Amaoto <inochiama@outlook.com>:

On Tue, 30 Jan 2024 09:49:08 +0800 you wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> This series adds reset controller support for Sophgo SG2042 using
> reset-simple driver.
> 
> Thanks,
> Chen
> 
> [...]

Here is the summary with links:
  - [v3,1/4] dt-bindings: reset: sophgo: support SG2042
    (no matching commit)
  - [v3,2/4] reset: simple: add support for Sophgo SG2042
    (no matching commit)
  - [v3,3/4] riscv: dts: add reset generator for Sophgo SG2042 SoC
    https://git.kernel.org/riscv/c/1ce7587e507e
  - [v3,4/4] riscv: dts: add resets property for uart node
    https://git.kernel.org/riscv/c/08573ba006ab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



