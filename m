Return-Path: <linux-kernel+bounces-157077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E5D8B0C8C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 16:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 505311F25B9E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 14:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46DAE15ECE0;
	Wed, 24 Apr 2024 14:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sr2LVEOk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8846D15ECC7;
	Wed, 24 Apr 2024 14:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713969029; cv=none; b=W6rbl95IHZtICYVAfQT6fJvvKC25wQQjifa2TtXgjxoHz1tFqDgY04GS8ArWQZGQhTd8mWdNGPZFYzTIAjK59XA7M7AWs4p3Cbpn5oYEldxhOy38WCREN6/3kQ5vbQvyIv1QeUQ+CnNrYOeU8CyvC9+76RIoFi4HMAYt05y6Xus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713969029; c=relaxed/simple;
	bh=M1cm0t9jToH3lGaAFH2NKA1e80hsoHbeF5wtjnc0wSg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nn9qcN9uMPgLJgj/oyAGaB/kdBPv8oxcuBRnBvMWlPAbAG5IRN6sI1gzbD8mU6G5nqEdSOGFjY/oPYGK5YXxYFfF8QCGJWLd4cc+ndbn3IMOdOsO8sD/4Xk0XgodFEgY+pF2708VAcI1bquxsqga+7G3cZaXIN1r8fMOvhy9AW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sr2LVEOk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1B38CC113CE;
	Wed, 24 Apr 2024 14:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713969029;
	bh=M1cm0t9jToH3lGaAFH2NKA1e80hsoHbeF5wtjnc0wSg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Sr2LVEOkmSCvTiAW71+sPsBokFdg+iP8PqoO7HvJwdZlNCoBRpZtu6tP2KDsjg5HN
	 YxAa6q93ZW2Yt4ho3zflUlIdATLW9nt1O6Xf+kJeKFwnFXBIpA3vuk/8uIfWrsTjOi
	 X3K8UdnKuQTCmp03KxoCOSg4bowBrj4+8KriZ//5ieYNEvKUHmK9d1Q/BD5OlGmZyR
	 gdD4N7rY1nKyd5Qb8jHkEo4mGKr8DYibWFpC/XtEQni4XOg46KZ/x34Han0HOI12+U
	 lj9RbBwdxBDj4owHnCpFQHDTHptybUhOwRr8WKKWpcvfjuvsNuPKFKLD1Fxj3ZZ9mj
	 uMIHSllHtW5CA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 05326C595D2;
	Wed, 24 Apr 2024 14:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 1/2] Bluetooth: btusb: Add USB HW IDs for
 MT7921/MT7922/MT7925
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171396902901.2541.2890926466501511586.git-patchwork-notify@kernel.org>
Date: Wed, 24 Apr 2024 14:30:29 +0000
References: <20240423065157.21805-1-jiande.lu@mediatek.com>
In-Reply-To: <20240423065157.21805-1-jiande.lu@mediatek.com>
To: Jiande Lu <jiande.lu@mediatek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, chris.lu@mediatek.com, deren.Wu@mediatek.com,
 aaron.hou@mediatek.com, steve.lee@mediatek.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org

Hello:

This series was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 23 Apr 2024 14:51:56 +0800 you wrote:
> Add HW IDs for wireless module specific to Acer/ASUS
> notebook models to ensure proper recognition and functionality.
> These HW IDs are extracted from Windows driver inf file.
> Note some HW IDs without official drivers, still in testing phase.
> Thus, we update module HW ID and test ensure consistent boot success.
> 
> Signed-off-by: Jiande Lu <jiande.lu@mediatek.com>
> 
> [...]

Here is the summary with links:
  - [v5,1/2] Bluetooth: btusb: Add USB HW IDs for MT7921/MT7922/MT7925
    https://git.kernel.org/bluetooth/bluetooth-next/c/3d513268312d
  - [v5,2/2] Bluetooth: btusb: Sort usb_device_id table by the ID
    https://git.kernel.org/bluetooth/bluetooth-next/c/2214b639ca14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



