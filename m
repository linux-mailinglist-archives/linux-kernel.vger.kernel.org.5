Return-Path: <linux-kernel+bounces-91089-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A0387096D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 19:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 003E6282962
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5539562171;
	Mon,  4 Mar 2024 18:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8Avz4dH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F40362173
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 18:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709576429; cv=none; b=YfSVx3LNXRVSr9LvM7BomGRGvH37tBXShFW6hZaY+9gPHwkedDtMBoDjuHea5az9K9/Ya7j3ur9JWOm4LI4QBkxoRGvGqlOtVN75trf/9Q84dCQq42rLuAp1hDtBJLgPavNTCrmgu/zNhBKepc/gAcc31hcNcZTMzQWKMFAbr2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709576429; c=relaxed/simple;
	bh=t0ZE3fuXMKbZQWvtdv7075xw9wqlU8kEK4OZdYpNEnI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XxVh0KiHOFt8zxaakc6B3cATmf/A5AqQatydzPcsB9n+mCHqzZiBuxYKDH9eu3ZS6hp7edxbSBTCBKra4hNqYqkzoKy/JqSu5E+P77I9lOT++up+7jTaohHg/v4XdNJtT/E6EN7KN0KoWPK4R3D43Oj7FH3l0CChql1t8uOInmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8Avz4dH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2BC1EC4166C;
	Mon,  4 Mar 2024 18:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709576429;
	bh=t0ZE3fuXMKbZQWvtdv7075xw9wqlU8kEK4OZdYpNEnI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X8Avz4dHUd89U6+LNm6Hfe0xsVR2mJePRT8J32cS95S+x6/PaCdn5u+jrxbHHPRkg
	 gg+7vNXkZMg6fIWGTw73A4rPI9Vw/93nwPZQBwhNLyxnqXT7pbHQcm98lD/XsQLWQo
	 pg+rWqlOd2kj+DuH82e6q/4IWYnv7FbsGIMZTrRRMzDfyFvylvSdamXRF3Xg+BLu3n
	 UODi5xsPn7F9IhHgQXbq6PSs9CETuNwZXUTIYWcD7YME1XaEA15yaZ8DpQA+57/6Dv
	 03Al+u5caf3hOxeADtIned0RuJF8LkcsGpBpIY3qN/iddai8atDleFEWtYiWkT0WJz
	 d8xPYm6GsSNpQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0ADE1D88F8A;
	Mon,  4 Mar 2024 18:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix to use correct segment type in
 f2fs_allocate_data_block()
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170957642904.16816.7612730438346906986.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 18:20:29 +0000
References: <20240225063628.2086320-1-chao@kernel.org>
In-Reply-To: <20240225063628.2086320-1-chao@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sun, 25 Feb 2024 14:36:28 +0800 you wrote:
> @type in f2fs_allocate_data_block() indicates log header's type, it
> can be CURSEG_COLD_DATA_PINNED or CURSEG_ALL_DATA_ATGC, rather than
> type of data/node, however IS_DATASEG()/IS_NODESEG() only accept later
> one, fix it.
> 
> Fixes: 093749e296e2 ("f2fs: support age threshold based garbage collection")
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: fix to use correct segment type in f2fs_allocate_data_block()
    https://git.kernel.org/jaegeuk/f2fs/c/732485823782

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



