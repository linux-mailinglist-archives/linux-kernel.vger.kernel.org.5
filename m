Return-Path: <linux-kernel+bounces-75252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C8285E546
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:10:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 965EAB211C0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B4F85624;
	Wed, 21 Feb 2024 18:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PuLDK1fF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCD684A26
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 18:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708539031; cv=none; b=QTA2d6Vgfv/9U5g6Pi9s7amYqmDJ8L52ITZeywtwJr03gGjVZnGaa82dvCS1SdYGui8jQeE1aWr2a1xb2Sm4UERvMExzH0LVKFD6wmfNkaheV3sO9ScmgyqZZPGJzF82DaA/wOmyJcFfCUqwg+XehyrU0wig6A1OKmjW2iDwLsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708539031; c=relaxed/simple;
	bh=m+WgYxlYIKix88Gefl0qOHfj0XJUP9gj9mnEbpOqYwk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lrmd+zT6JZeCS88+GMROGsXRCBlZjBVz0TuSiug7TCcxLyJWH++IAEXWssIGgder15njlHanNCu/11NskslD3JzpQ8tqp+S4QILYcQhvpxOuy8/056+ddFUqQOqJQVrJBK8mh0KxvWDXi4ykdAGJ+HWd/K5koe18WvX54p9lrj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PuLDK1fF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 102F8C43399;
	Wed, 21 Feb 2024 18:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708539031;
	bh=m+WgYxlYIKix88Gefl0qOHfj0XJUP9gj9mnEbpOqYwk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PuLDK1fF7Z7eEJ/258n6I6WDfnqCl2/fyH+dUS6tLkQ9xxUpIZHaQKwI8UTrponrL
	 MuUly7g0fl2X1yfRSQG5esKwtyO2KaBu1xkSZhj1/WsULNjY8JNbG4lp2PeuIGKEUz
	 +FtMrn8C2SvwBX5HAWRRfy6HEv29Sbr+en0D8lKXCA92Yi72+Ac6ETZ4TsSZ8D+Kos
	 oCc3npGr2JUd+m3FNFgnt1KlaPGx93QZsMDf0KPVTZOdhQzbfr1FRgu73QvaI1jQcq
	 POiBC/yV0zP8Xqk6QMexhLj9jVzVQ2gd4UM3H0wgjZlrSbxMdR+u2ymVEZVWriHarv
	 snVmisN3++14g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EA033D84BCC;
	Wed, 21 Feb 2024 18:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: support SEEK_DATA and SEEK_HOLE for
 compression files
From: patchwork-bot+f2fs@kernel.org
Message-Id: 
 <170853903095.7043.8191554159559684336.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 18:10:30 +0000
References: <20240215201633.2365333-1-daeho43@gmail.com>
In-Reply-To: <20240215201633.2365333-1-daeho43@gmail.com>
To: Daeho Jeong <daeho43@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com, daehojeong@google.com

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Thu, 15 Feb 2024 12:16:33 -0800 you wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Fix to support SEEK_DATA and SEEK_HOLE for compression files
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
> ---
>  fs/f2fs/file.c | 21 ++++++++++++++++++---
>  1 file changed, 18 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: support SEEK_DATA and SEEK_HOLE for compression files
    https://git.kernel.org/jaegeuk/f2fs/c/ef952ede4a7b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



