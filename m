Return-Path: <linux-kernel+bounces-119317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD08588C701
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:30:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88D8C3208E5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8898C13C919;
	Tue, 26 Mar 2024 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpWdrLGo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A3258220;
	Tue, 26 Mar 2024 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711467040; cv=none; b=Pr3uWkLPFYOmKA87B/+4/04fWNHDRMiI5tuRv3ptDzRdjkIC92ihYoevwr1vMZOGVH0GdTiZiieK4Lcddgy88lL7zbG+fEox9OY0Xl2wXWJ0LEHn00I4AaGJHAsFP1Fk1eDwP53W8VdoQXyBoZSXUHPDytbWQfVsAAyBlNNEgZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711467040; c=relaxed/simple;
	bh=XJotx7SDA6uGR4v8KxMLQ7h0N4gsqiAlZu8rWZ9dRm8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RcebrBCfBFqa17rkwlWYxHvVpPKjNznTMpoeR+URmxaHTD0uf1tKOTtO5KvzrOVFwrTzVc8Abj5/KXrzBGuDw0gZs1IVZgPL30wesCtqXhSCaLc1thNiM++3TnrmRV4H1R0N7A3XPoS9sclhlkBfP1SZ83S7qN6YElsGHm5U5IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpWdrLGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69559C433F1;
	Tue, 26 Mar 2024 15:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711467040;
	bh=XJotx7SDA6uGR4v8KxMLQ7h0N4gsqiAlZu8rWZ9dRm8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VpWdrLGoy382RyEOvpIFPA8aNqPDNFumg8vT0RyYesdZbfqyiRWSzNLlAQMDvv+be
	 2xLvNvCqNZX6SW4wJLgEFL30gTBipmT4pMMN5r1tNCh+HZtW1zYXKUtu3JmLXdCk0+
	 xS+Fm4cw1zzHPdmLuaa1JE0eYu3MHbi5MKeT5yWrz7yd84NlEzocP7JC3kDtFcaeiN
	 x1CEZejE5BWOGP8pKk9yBzjfJ0IWaexCJvi+zKkUGMguWv8m7/MCxaYWSf9Wcagfck
	 cQPtlSLapO7K7GNMxmDuY7UxJQmU3bUXlU88siFJ9ohmXzoPCToA3ZJ6Chek2m8Cr9
	 +DHgH0pvKZjeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 588E3D8BCE8;
	Tue, 26 Mar 2024 15:30:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode
 exists in DT"
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171146704035.9961.13096206001570615153.git-patchwork-notify@kernel.org>
Date: Tue, 26 Mar 2024 15:30:40 +0000
References: <20240314084412.1127-1-johan+linaro@kernel.org>
In-Reply-To: <20240314084412.1127-1-johan+linaro@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: luiz.dentz@gmail.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, quic_janathot@quicinc.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Thu, 14 Mar 2024 09:44:12 +0100 you wrote:
> This reverts commit 7dcd3e014aa7faeeaf4047190b22d8a19a0db696.
> 
> Qualcomm Bluetooth controllers like WCN6855 do not have persistent
> storage for the Bluetooth address and must therefore start as
> unconfigured to allow the user to set a valid address unless one has
> been provided by the boot firmware in the devicetree.
> 
> [...]

Here is the summary with links:
  - Revert "Bluetooth: hci_qca: Set BDA quirk bit if fwnode exists in DT"
    https://git.kernel.org/bluetooth/bluetooth-next/c/ac0cf3552972

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



