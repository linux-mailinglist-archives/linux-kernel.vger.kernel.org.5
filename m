Return-Path: <linux-kernel+bounces-138727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8565789F9C9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0228B27E6D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65DB16EBE7;
	Wed, 10 Apr 2024 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnGFETR2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602B0163A9B;
	Wed, 10 Apr 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712758230; cv=none; b=AytST1WJIOWCAeNSZNtrdYpWiLd27zHGtT5T8QTKalA80JEu96I5fpn2fW5S/nywnLb3cbe2gNOjlTJ9oaHe0ca2au5SZ7o2i1NPagaoyScAMsPT9VISLvm/JptVgJe/D8hvychvKuTpDjBQCeqsn9Vb9FpURrjSxHmZ5QkDGSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712758230; c=relaxed/simple;
	bh=QD4GuNVWO2iBAn93sJNnqj+EE4EikYnQZUCnjiIqYPY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oDSeqIHeo03iOS1ni/zcGq0+KNo7WxuhvirnLctMxfDe7CGkGX8ay64MWBDYgorz9RtgA0NsnAvVM+w45n0dr/cvFw6ceyLVxZGZFzfXN2uDeYnccj8W3xhJYAz091X1SV+kO76mQAyQMvGwXIFkOfIRYzqWbtwReQY+55/yAwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qnGFETR2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30631C433C7;
	Wed, 10 Apr 2024 14:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712758230;
	bh=QD4GuNVWO2iBAn93sJNnqj+EE4EikYnQZUCnjiIqYPY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qnGFETR2spDASSDilJJRClh/rzIP5uGdeOKWt9lt1DbCGJQcv3h0V36TqRgDPkiCQ
	 5RdcjpUWtYhgObEk7WrUUo7FV4wo82ghcnxQ4MOQrjDJjEDQDTQdpKgHZG5R17Gia9
	 VLaMTMDp6uMD1/jQCdXeX4yRxa1KS9Z9i1qJ4mx8vwRNGtblxKXjLam8BbqcEUn96X
	 sXLjiE6omKARGfjvUQ+UyFhyuHZH3o6jfCa25voNiqHrwtMz4g2FUli3GI3CyR99bU
	 2wuqx5j7QKM95SNpKa+5VxTlXB4oat5Zs4noSkn5USiobF5gfrp45Pyq2oRy00cR6/
	 yTpClrqxy8PKA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 28442CF21C4;
	Wed, 10 Apr 2024 14:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] Bluetooth: ath3k: Fix multiple issues reported by
 checkpatch.pl
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <171275823015.12683.3836355449106412757.git-patchwork-notify@kernel.org>
Date: Wed, 10 Apr 2024 14:10:30 +0000
References: <20240405214225.2170476-1-me@wantyapps.xyz>
In-Reply-To: <20240405214225.2170476-1-me@wantyapps.xyz>
To: Uri Arev <me@wantyapps.xyz>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat,  6 Apr 2024 00:42:24 +0300 you wrote:
> From: Uri Arev <me@wantyapps.xyz>
> 
> This fixes some CHECKs reported by the checkpatch script.
> 
> Issues reported in ath3k.c:
> -------
> ath3k.c
> 
> [...]

Here is the summary with links:
  - [v3] Bluetooth: ath3k: Fix multiple issues reported by checkpatch.pl
    https://git.kernel.org/bluetooth/bluetooth-next/c/df0d03639264

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



