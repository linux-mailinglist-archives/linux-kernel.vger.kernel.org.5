Return-Path: <linux-kernel+bounces-116380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C71948899A9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82C732A25F3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF2C12F5AE;
	Mon, 25 Mar 2024 05:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SQ9l/4Uu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5F614A607;
	Mon, 25 Mar 2024 01:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711331664; cv=none; b=eQvtIeT/x6+Sx8008NjFf81zrfZJkScPHocK3KJLBuRx1EabrPxscAhNue8SyZjltWlTpN36FwUh2vnXrlJNhBDzYGVvOjmGuI1l4g//ww1R8NlMBPmWuKlwWwnQxiLLl8YBRjn6MZUTCdGAdRkMoodol2nqWOGgvCj9hgkFdKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711331664; c=relaxed/simple;
	bh=jTE0MklFyVljrNqL6V+CgGiuGtazGxVhxfIOrxWLw1o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JKNfdybS5Sdc8op4Ashb3QhF4+cbyTu32tFPaoRPVffCVlK9kANrip+EejIpcULuK8uym6DW5HwX+d36pXS4faeet1fPTOxpDOdw/g9LETmviOo3YzzJ7I4RbGwoKXE1obDmIPvW2EKsjIag98ygGiUx9WSuTGab0af7l6WhK1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SQ9l/4Uu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D787C43609;
	Mon, 25 Mar 2024 01:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711331662;
	bh=jTE0MklFyVljrNqL6V+CgGiuGtazGxVhxfIOrxWLw1o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SQ9l/4UuB6GxZaV8MJGOGmNUcDQNuTwhIjW33Uh7FzeGulhZIUvgCCofoIkca517O
	 d73/GlOJJJ6AwjEoT8C8j4z5lqGbuaEv1T4qdrC/j8Qr82TAz+6cBmnRbI5lqdVtS3
	 Ybocixt2ZWtCymVVRfFcqCb4+ZtczM2wmko9Wb17nkrf49CxKlBLihK8M1I5dhlltR
	 ppgIpBkrfFOD51gnZaSMDVeLuKx0Buy+SkvbNfurkvqZ5hCAf++or2wFvGWIBDFe1K
	 jwPbo/CxjyV6itqMEdJ7WtoxcNzcV6A9q7czZ627JJ0H9aEjFGeJnTDVduYI1+syYC
	 ZN0man3D6ITrg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74374D2D0E4;
	Mon, 25 Mar 2024 01:54:22 +0000 (UTC)
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
 <171133166247.9916.9029995993391940885.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 01:54:22 +0000
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

This series was applied to chrome-platform/linux.git (for-kernelci)
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



