Return-Path: <linux-kernel+bounces-17282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C31B824AD0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 23:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A9381C21796
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 22:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B779A2CCD1;
	Thu,  4 Jan 2024 22:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XA8pmP3M"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073D32C860;
	Thu,  4 Jan 2024 22:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72BC7C433C7;
	Thu,  4 Jan 2024 22:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704406826;
	bh=MvmGZmrozcWMemmPoI+jhOSNBcJqFQjtCWqa4HzCbIQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XA8pmP3MF96yGkA92skcj+K/MM8N1ih/oM3Wg1HjTMOwR7lrrK7sM4QUegYvImeSS
	 txG4Aq+N1Khq1iQ6RxiJqlLHDXY3rpzdiDo94YGs19GBOivGVp40T7OAfmT8x9Id8N
	 1OD6cEo5a8RI7oVYt04yhRksNL1XgHCNE7BWeL78RFa/bkvTDMLao6PAujM6oGamfH
	 7h50O06PDIfjJ6flUgf5wn5QwEwoO4q63m92KgchCdJjRqfEL9r7dovoe7BLlr5GuU
	 Z8RuY8mVeKYTimZBEa9MNKf0V58VPwCKZdwFgg4yxRMYxOjbcU2Y6YoUVmXJi/mD4q
	 BPtqsOCaPI7uA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 585F6C43168;
	Thu,  4 Jan 2024 22:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sync: Check the correct flag before starting a
 scan
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170440682635.8457.5875385181619423548.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 22:20:26 +0000
References: <20240102180810.54515-1-verdre@v0yd.nl>
In-Reply-To: <20240102180810.54515-1-verdre@v0yd.nl>
To: =?utf-8?q?Jonas_Dre=C3=9Fler_=3Cverdre=40v0yd=2Enl=3E?=@codeaurora.org
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue,  2 Jan 2024 19:08:08 +0100 you wrote:
> There's a very confusing mistake in the code starting a HCI inquiry: We're
> calling hci_dev_test_flag() to test for HCI_INQUIRY, but hci_dev_test_flag()
> checks hdev->dev_flags instead of hdev->flags. HCI_INQUIRY is a bit that's
> set on hdev->flags, not on hdev->dev_flags though.
> 
> HCI_INQUIRY equals the integer 7, and in hdev->dev_flags, 7 means
> HCI_BONDABLE, so we were actually checking for HCI_BONDABLE here.
> 
> [...]

Here is the summary with links:
  - Bluetooth: hci_sync: Check the correct flag before starting a scan
    https://git.kernel.org/bluetooth/bluetooth-next/c/626cef40faf0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



