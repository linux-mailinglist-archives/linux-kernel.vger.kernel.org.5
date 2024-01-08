Return-Path: <linux-kernel+bounces-19930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CA58276F0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ED301C21901
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 18:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962E256773;
	Mon,  8 Jan 2024 18:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KPLEgK7a"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32A054BCA;
	Mon,  8 Jan 2024 18:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82C0CC433CC;
	Mon,  8 Jan 2024 18:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704736824;
	bh=ZPtCBC9L0AvdsOpji1pM9ayh3zDXg4gMWbVp5crgq4Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KPLEgK7a0Glokga2cTTT2aCJjMLwhE7Z6f1CPbXcz5o5TpbDifdNN2Evs6LiRvbl1
	 ki/W0m7b0LyY4wyhjfP89wzF5FLsCAcCtx8/g/g4niwoZ2Uidec9L1609Gby7cKuyo
	 HLY9ZxjdcQBaHIYBTp1i6XUiBJoiCxwXAVRf3g4KRnWv3ya8++7rpau8dDMu9/HnoG
	 C+7zXt/yWYwk3QEsieL9FvjLUUdDPVbqgIu/O9nipi72oOwAiF/zyFoYQ32OVh+tM7
	 IqEvcJZEMh4SW14/1H8WO4Eqb+0fV8jc+caUDJaWxQVln84H+Ae1OsyMV1GCItiC8V
	 sf/5ZeHowdriQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5CA2AD8C977;
	Mon,  8 Jan 2024 18:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V3] Bluetooth: rfcomm: Fix null-ptr-deref in
 rfcomm_check_security
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170473682437.30343.8024937175045116311.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jan 2024 18:00:24 +0000
References: <20240103091043.3379363-1-20373622@buaa.edu.cn>
In-Reply-To: <20240103091043.3379363-1-20373622@buaa.edu.cn>
To: Yuxuan-Hu <20373622@buaa.edu.cn>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, sy2239101@buaa.edu.cn, pmenzel@molgen.mpg.de

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Wed,  3 Jan 2024 17:10:43 +0800 you wrote:
> During our fuzz testing of the connection and disconnection process at the
> RFCOMM layer, we discovered this bug. By comparing the packets from a
> normal connection and disconnection process with the testcase that
> triggered a KASAN report. We analyzed the cause of this bug as follows:
> 
> 1. In the packets captured during a normal connection, the host sends a
> `Read Encryption Key Size` type of `HCI_CMD` packet
> (Command Opcode: 0x1408) to the controller to inquire the length of
> encryption key.After receiving this packet, the controller immediately
> replies with a Command Completepacket (Event Code: 0x0e) to return the
> Encryption Key Size.
> 
> [...]

Here is the summary with links:
  - [V3] Bluetooth: rfcomm: Fix null-ptr-deref in rfcomm_check_security
    https://git.kernel.org/bluetooth/bluetooth-next/c/6ec00b0737fe

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



