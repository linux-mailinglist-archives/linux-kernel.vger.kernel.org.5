Return-Path: <linux-kernel+bounces-13207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA29A82011F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 20:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106D7283945
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 19:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E1F134A5;
	Fri, 29 Dec 2023 19:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s4YcQPcG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD3612E4E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 19:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D981EC433CC;
	Fri, 29 Dec 2023 19:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703877024;
	bh=Ri74LIwEC9/3K1qM7Hw/JxzXKBrH1rB3W05Jf9Ft5fA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s4YcQPcGh39Vs0Snr6lEdMBC9XSHn5ag0IUp4v+Nq76HH4kaMaLZ+4CTqxCSHD0MY
	 YaP9Ku/tDq8dnNqjxULHBxxkZMjk/Mj4uKpgRjUW7o0+eMAQul/nrFUO0iadNgc+C4
	 nraFl4I84XOIZzpwCu9pllofsV/XDdk2v+BS0Pblsx/pXiY3d116Fb2CwGu2G8UlMh
	 IXr14/i9qXFQ4xJM67/3PYcWZrOLfH6k2PWBAv7I2grjEX1h0T955tesMtSimRUf61
	 d3wtgjamIq+W2A2Bc5EjjYLyZuI2HB8YI/KSWdtsmMqgfd59sFgmlu1Qxl7Vzhba2b
	 7PAv3VVSjywDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE132E333DA;
	Fri, 29 Dec 2023 19:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH V2] f2fs: fix to check return value of
 f2fs_recover_xattr_data
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170387702477.8173.5505716820349568272.git-patchwork-notify@kernel.org>
Date: Fri, 29 Dec 2023 19:10:24 +0000
References: <1702347327-24181-1-git-send-email-zhiguo.niu@unisoc.com>
In-Reply-To: <1702347327-24181-1-git-send-email-zhiguo.niu@unisoc.com>
To: Zhiguo Niu <zhiguo.niu@unisoc.com>
Cc: jaegeuk@kernel.org, chao@kernel.org, ke.wang@unisoc.com,
 niuzhiguo84@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 12 Dec 2023 10:15:27 +0800 you wrote:
> Should check return value of f2fs_recover_xattr_data in
> __f2fs_setxattr rather than doing invalid retry if error happen.
> 
> Also just do set_page_dirty in f2fs_recover_xattr_data when
> page is changed really.
> 
> Fixes: 50a472bbc79f ("f2fs: do not return EFSCORRUPTED, but try to run online repair")
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,V2] f2fs: fix to check return value of f2fs_recover_xattr_data
    https://git.kernel.org/jaegeuk/f2fs/c/86d7d57a3f09

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



