Return-Path: <linux-kernel+bounces-140669-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA158A178E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CC3D1F21883
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4344E10788;
	Thu, 11 Apr 2024 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i6/S8A8b"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7732DD518;
	Thu, 11 Apr 2024 14:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846383; cv=none; b=I8F4ENRWgOsI3RpNWRpNyZXyx4MhpV6kSVqzag8t3vbQBzjBK/UA8NwP5QU4pOansUbQq8+ijHf1EglbUroRG+s5dlU64M40BLq5yzCwzB1dqGSVzka+U0+FlZK3jMfrekpp3A0AfN1JfkUJ4ishBqAP/Ka/KUXet7u1b7e/7b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846383; c=relaxed/simple;
	bh=HYiF5RVgmWfeB2q5YS1rVM15Tb6+J3pcTtrzx/qL7YA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aak4ioRJXBrmqa+EUxbscrJz9HeGLy9tqgc738Tky+zJwlW4QrsRHYseMS+Z39rbPoQe2+ptX4AzLpd8fT+B48cYTlX73BihuYg1rXsQ4stAAGu9oR9yAwwEDVVqtXAgoyW8sNRfkae+RlhNDvWjXVh8kj78Lqo2/0QNucGEFXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i6/S8A8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5052FC2BD10;
	Thu, 11 Apr 2024 14:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712846383;
	bh=HYiF5RVgmWfeB2q5YS1rVM15Tb6+J3pcTtrzx/qL7YA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i6/S8A8bTGR+/yvGoSEMsFzMc3SDFPyIcz7MVXzsI0mE+HlMOkMHlf+/HetMJnANR
	 oXT1H1DE2utRxYKEbHL66S1AyyUraB/Qa8DLoz0qDXRI0WoYD2ItdUATJeXC476g3l
	 yh/mxKvAiWl4kq6pstH9+oH0YIH8Ii8xYh6sUvLrhasoTFT/3zzxSSihWSftzzvVy/
	 WHvOizJES3haTKNglUJ/wGxyFVbteZj/6GFHVquN8nct6RAGCh08wfi5nBQDCTGrFs
	 xaTTEiIWBWUYTjo3tjY8VVokU0Hb8oB7BWpNI2AyU15UbxP8XZRAXxItBBKyJplpP8
	 fF3IH+BqY7IBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3EF45C433F2;
	Thu, 11 Apr 2024 14:39:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND. PATCH v2] Bluetooth: btusb: Add Realtek RTL8852BE support ID
 0x0bda:0x4853
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171284638325.18150.6436513987613825530.git-patchwork-notify@kernel.org>
Date: Thu, 11 Apr 2024 14:39:43 +0000
References: <883A1BECA61AB8B7+20240329023440.191799-1-wangyuli@uniontech.com>
In-Reply-To: <883A1BECA61AB8B7+20240329023440.191799-1-wangyuli@uniontech.com>
To: WangYuli <wangyuli@uniontech.com>
Cc: Larry.Finger@lwfinger.net, marcel@holtmann.org, luiz.dentz@gmail.com,
 gustavo@padovan.org, johan.hedberg@gmail.com, guanwentao@uniontech.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Fri, 29 Mar 2024 10:34:39 +0800 you wrote:
> Add the support ID(0x0bda, 0x4853) to usb_device_id table for
> Realtek RTL8852BE.
> 
> Without this change the device utilizes an obsolete version of
> the firmware that is encoded in it rather than the updated Realtek
> firmware and config files from the firmware directory. The latter
> files implement many new features.
> 
> [...]

Here is the summary with links:
  - [RESEND.,v2] Bluetooth: btusb: Add Realtek RTL8852BE support ID 0x0bda:0x4853
    https://git.kernel.org/bluetooth/bluetooth-next/c/cf396a443d37

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



