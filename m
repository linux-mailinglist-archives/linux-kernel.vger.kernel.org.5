Return-Path: <linux-kernel+bounces-164759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8612C8B8226
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:52:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B36A7B23514
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 21:52:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A8E1BF6EC;
	Tue, 30 Apr 2024 21:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4KPYsGV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8DB1BED7B;
	Tue, 30 Apr 2024 21:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714513918; cv=none; b=uvZaY1w7T6IJ/7nW6NLv6qrUCXhQwIGxw+Kyd813ABZPJ4lrh2ezhJ8onCDrbROx5mAMOANY96kaBL/jrjb7s+v2264UzF6M8rzWmrDFtH3wYup5GalpZEQu1056WIFqXZnVIyRAXDPKMHMEmF0LDf+38ytgje8fnrHUSSoE5VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714513918; c=relaxed/simple;
	bh=g5Qi1tHymeTjnCSRSPj7oULka92b4osrJP/l8mYQ/mw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uZa0WLEp7iz/djAyMc/nqTXoj7ZQoDfT6pG6jDfsDPYfXH5e8b0i6Hqj8TYUIzHO0x8IIKwqUWLYHddWYlq/vDUba3IQYvMxZJ/amNx++ZMLqvWcjAYNZxNEGNstfpWmG8QE6AifaRQ3WAD0VW7tS18bX5UbK/OXmSrESlU0058=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4KPYsGV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0CBE6C4AF17;
	Tue, 30 Apr 2024 21:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714513918;
	bh=g5Qi1tHymeTjnCSRSPj7oULka92b4osrJP/l8mYQ/mw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F4KPYsGVDu1YikkrFdPHDN8TX7+XtPs+J6hUwDueyU/2IrTe/re6Bu+c6FqkvWeOx
	 /iAIMmpNgXagWVpxbUdTU0KGvM3sJ7hsonvn8dzk2TU8Lk0CpwMuJQB6PcsdsLZMHh
	 TgRFRJs/V3VlE02A+weQw9ZHAac1IgRCj3/if7ajIuKY26Xaa/K1G9Y3moEScy46d7
	 T6gTf4sC69DbAWYjrQ+aOk+fxCOljNKiJ/Zc+WZw8hFiWrLkJ0lOmF/LeJTE7DZWNy
	 ggpCapk+r3pcdros9O/pC88tRxqabm/4tp6jn/+rcJqJ5KJjLQswEVnlWfQCIpbkfh
	 22S5dQKSlqHgw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E9323C43616;
	Tue, 30 Apr 2024 21:51:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/3] Bluetooth: qca: generalise device address check
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171451391794.30746.12874463532882564623.git-patchwork-notify@kernel.org>
Date: Tue, 30 Apr 2024 21:51:57 +0000
References: <20240430170741.15742-1-johan+linaro@kernel.org>
In-Reply-To: <20240430170741.15742-1-johan+linaro@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, dianders@chromium.org,
 quic_janathot@quicinc.com, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 30 Apr 2024 19:07:38 +0200 you wrote:
> The QCA default device address apparently comes from the NVM
> configuration file and can differ quite a bit between controllers.
> 
> This series adds support for storing the default address when parsing
> the configuration file and using it to determine whether the controller
> has been provisioned with an address.
> 
> [...]

Here is the summary with links:
  - [v2,1/3] Bluetooth: qca: add missing firmware sanity checks
    https://git.kernel.org/bluetooth/bluetooth-next/c/fd10f4fe66a1
  - [v2,2/3] Bluetooth: qca: fix NVM configuration parsing
    https://git.kernel.org/bluetooth/bluetooth-next/c/882125a9cdb9
  - [v2,3/3] Bluetooth: qca: generalise device address check
    https://git.kernel.org/bluetooth/bluetooth-next/c/aa63c8b7b1c2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



