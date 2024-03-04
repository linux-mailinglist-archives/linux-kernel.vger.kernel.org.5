Return-Path: <linux-kernel+bounces-91090-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2A287096E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBBA01C244AD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556A562172;
	Mon,  4 Mar 2024 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fgr+72qo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A37626A4
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709576429; cv=none; b=VoDaPYyKfsiTw5B+t1/+clbH+lJSmwkQB8hre1sXk2smY6fmS0Tuz0srH0RV4s0sZz5Y7XXcPvJafhUTU+m5BP19Lo/NYuqmZwFucDogZYvcN349ps2C7Y7oe7k2Znh25uiHo7LlbOFuUPL408J91GEGs4yPV6XwmDL06tPH+W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709576429; c=relaxed/simple;
	bh=47i4aSHcYknJkYX0Y81klwd89NWLRQui2X+yMo/YfRw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T9UO1Ye0DQvylFVWgcQzBZZDP0WvjAWCeBOuPyWzBsdPwggugSJqAzhhaUit+oE78Ia1ixWGZFjD6IeXwmcUVNBA1NpR80c8GRUde1V7wkI5TZ+gNv6cGv0C01egnuptFOccHMq0vSMqPN2IOTMtVWa+HgkamnLSeQShV+SQFXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fgr+72qo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1EC95C43141;
	Mon,  4 Mar 2024 18:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709576429;
	bh=47i4aSHcYknJkYX0Y81klwd89NWLRQui2X+yMo/YfRw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fgr+72qorvkWFihJFUq5HNnufjMJUan51KutZDP3MRCQZ8tg3YCN0wujp5JEAVj6R
	 KG/hdpKSoHY3Z4fE+WgX+u8+6/GzOadBamxKeVUwfLEwHNMppmfq7fZHWS4Lkaiq3l
	 gdlwMOeO5pjWLtAkt+AoaF8sgo3xjnP0W3Z7t7vyuRavEn5hfBgCgcSGzkQZqu61bR
	 yuOPjf4N2hRccMQnT18dGxy4m4or/Q0oLZXiEaQhLqDEYOBzLHu5e2C5kJIJi73pg0
	 wxAD5AeEuRdSslI9U0ugPPmfVga8pkWB4rbLbw139sT6MR0l35g1bhEkon2iOFzuj5
	 CDp7r/XlP/ejQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 041D8D9A4B9;
	Mon,  4 Mar 2024 18:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to do sanity check in update_sit_entry
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170957642901.16816.14170425948750995798.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 18:20:29 +0000
References: <1709121594-22314-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1709121594-22314-1-git-send-email-zhiguo.niu@unisoc.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, ke.wang@unisoc.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 hongyu.jin@unisoc.com, niuzhiguo84@gmail.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 28 Feb 2024 19:59:54 +0800 you wrote:
> If GET_SEGNO return NULL_SEGNO for some unecpected case,
> update_sit_entry will access invalid memory address,
> cause system crash. It is better to do sanity check about
> GET_SEGNO just like update_segment_mtime & locate_dirty_segment.
> 
> Also remove some redundant judgment code.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to do sanity check in update_sit_entry
    https://git.kernel.org/jaegeuk/f2fs/c/36959d18c3cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



