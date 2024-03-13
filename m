Return-Path: <linux-kernel+bounces-101022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA4587A0CB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 02:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1321C2153E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 01:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F9910965;
	Wed, 13 Mar 2024 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajGNHnJ6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68194C2C6
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710293430; cv=none; b=HNA018C0zBJ2ggQpn6BnPjMTC0FsOgVA638pIx3OAruFHUwQqvNv8vew1yYHEihQBBS6on8+3DKHwVYxaE+FeEyD42RxjLyTX1jAj0COAn2si7uUYDrG3O7J/nq0EE7vd2+axUp19cYHtqXeCh8bdsvwxz5r2yAdwOc/G+K9ojY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710293430; c=relaxed/simple;
	bh=OQb9DEIyewBv8qB6meNGfkMEIZr3SBbCQwUHZtkIEF8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZsGYhDI8a3rDJWujjSWH9dz/aVDGGouge19WymQGet2VT4gYEjsGmcxYAkFBtnJ7D5aq0hJ0N16AcsRNNQWCsZE0Otc4kmxr8f8J33M+JE+p/9TlIG5Rbtac8vYUZ7MpXaXkcvrcTfvOgRjV/Lv912rbXJi2AlI2rFXsuh67TM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajGNHnJ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 181E1C43399;
	Wed, 13 Mar 2024 01:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710293430;
	bh=OQb9DEIyewBv8qB6meNGfkMEIZr3SBbCQwUHZtkIEF8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ajGNHnJ6J3T7uBEQayjD+YFUqTfrBNs6ZBpiYtKbHykLDcRAfc6Bjs+eG5QPux4ov
	 kxJUE795cSh2H8u+jGpcaHDmOtfln+brgUgZHLxlhyYN1BkAGPLh+PWTagyEozQ9Yh
	 YOLvz8erKyVKQDJIbmJQV1u2mbOdezWJUJora0He4SJ+eW1H8yqMRdTnpixp/zYHW7
	 nIqUZ64FbfE3rBGMkEHO+oV4ZP79GjXnJd76gGJBXpo+M1auuk3ktMPBpJKZyH+xr4
	 B6RFsucug9CzKLgVSmL9BWXLm1stCkTSON0R8xd0ICL5GqXNVbYbe6pD4gCbqnYLn/
	 NaEZ2abPLStvg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EB71AD84BAD;
	Wed, 13 Mar 2024 01:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH V2 1/2] f2fs: compress: relocate some judgments
 in f2fs_reserve_compress_blocks
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <171029342995.17296.13814508095953932881.git-patchwork-notify@kernel.org>
Date: Wed, 13 Mar 2024 01:30:29 +0000
References: <20240306034746.3722986-1-xiuhong.wang@unisoc.com>
In-Reply-To: <20240306034746.3722986-1-xiuhong.wang@unisoc.com>
To: Xiuhong Wang <xiuhong.wang@unisoc.com>
Cc: jaegeuk@kernel.org, chao@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 ke.wang@unisoc.com, xiuhong.wang.cn@gmail.com, hongyu.jin.cn@gmail.com

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 6 Mar 2024 11:47:45 +0800 you wrote:
> The following f2fs_io test will get a "0" result instead of -EINVAL,
> unisoc # ./f2fs_io compress file
> unisoc # ./f2fs_io reserve_cblocks file
>  0
> it's not reasonable, so the judgement of
> atomic_read(&F2FS_I(inode)->i_compr_blocks) should be placed after
> the judgement of is_inode_flag_set(inode, FI_COMPRESS_RELEASED).
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,V2,1/2] f2fs: compress: relocate some judgments in f2fs_reserve_compress_blocks
    https://git.kernel.org/jaegeuk/f2fs/c/b7d797d241c1
  - [f2fs-dev,V2,2/2] f2fs: compress: fix reserve_cblocks counting error when out of space
    https://git.kernel.org/jaegeuk/f2fs/c/2f6d721e14b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



