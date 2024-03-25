Return-Path: <linux-kernel+bounces-116406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 301AA8896ED
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:02:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63273B36E66
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3879214659C;
	Mon, 25 Mar 2024 05:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PsuO+u6Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D2B153561;
	Mon, 25 Mar 2024 02:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711332788; cv=none; b=pEH790EPPJR/0E7CSx+MIQkmPVvy49THZU9eZIm1nJmH7INi1fquh8RMzRoHnDbEzyNldUWQG4oVGLPhrlbDlaYD8o4poL/y4zwTjqC5LtzX1PuvJyMs35VueOaLebrgN5baZtksnwt78+bCJaCreYFIYroadiKw3b64aJL20Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711332788; c=relaxed/simple;
	bh=evMOFmZK484xlLF3mbfZYs94akT76sZvcDHwhEbS+nM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QDwAIi7aMC/h0DNeqkxdBzfYyqijNCG4LSExgM0k3Ng28A2HBTTQyywHUhaojN/ThkELHAsCmt79sezciEFxK7M+pK3m3fbnjKm2MztRy7W7jy/Gn78wkdBs/zh8FDXj4JprsQXuHQVUjk8MxfYIi68zUOIf8MrIH6Qikib9T+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PsuO+u6Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D975C43141;
	Mon, 25 Mar 2024 02:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711332787;
	bh=evMOFmZK484xlLF3mbfZYs94akT76sZvcDHwhEbS+nM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PsuO+u6Q0XR0u82SlNdTexPTnY51mzkSycxKfVdeetqtiRstJ6lwIwPwJtmqDz+TI
	 Cjb7XZel1TyhfwzeNc0W1Y3SlcraM7r2QYRyKYPm+wn6YigjZy0UCEalsNYqJxlKEY
	 XpyHDtV9f/8UbZJGpuNB4grES3cNXTnU05+QgV/nViPG7cZhCzVlXBXWtG03N6CX98
	 mVigrxyNtq/RfkyQzbn7G/NtO66TDhRJowV5WHctInoeIY2u+0/5qh7etAsYTngH8F
	 SxdWxK703ADDfzfwRBuPDzE6OOm0iFjja3ZuwgD4SOKusrY2ymUizC/WoYdpraV587
	 ThutESjB6XNMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 75B2FD2D0E4;
	Mon, 25 Mar 2024 02:13:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] platform/chrome: typec: xHCI DbC
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171133278747.9916.12140929449356804470.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 02:13:07 +0000
References: <20240213130018.3029991-1-heikki.krogerus@linux.intel.com>
In-Reply-To: <20240213130018.3029991-1-heikki.krogerus@linux.intel.com>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: pmalani@chromium.org, gregkh@linuxfoundation.org, bleung@chromium.org,
 tzungbi@kernel.org, groeck@chromium.org, hadrosaur@google.com,
 mathias.nyman@intel.com, rajaram.regupathy@intel.com,
 ssradjacoumar@google.com, samjaco@google.com, uday.m.bhat@intel.com,
 linux-usb@vger.kernel.org, chrome-platform@lists.linux.dev,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to chrome-platform/linux.git (for-next)
by Greg Kroah-Hartman <gregkh@linuxfoundation.org>:

On Tue, 13 Feb 2024 15:00:16 +0200 you wrote:
> Hi,
> 
> Changed in v2:
> 
> The quirk is now wrapped inside an ugly ifdef CONFIG_ACPI :(
> I don't have better ideas better ideas for this I'm afraid.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] usb: roles: Link the switch to its connector
    https://git.kernel.org/chrome-platform/c/9a270ec7bfb0
  - [v2,2/2] platform/chrome: cros_ec_typec: Make sure the USB role switch has PLD
    https://git.kernel.org/chrome-platform/c/56403220577b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



