Return-Path: <linux-kernel+bounces-68330-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88D678578D8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F30E2857A2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 09:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D331BC31;
	Fri, 16 Feb 2024 09:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JE7m6T32"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CC61B969;
	Fri, 16 Feb 2024 09:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708075827; cv=none; b=qKppDOVjF5mI28GUqq1o2NLK01GosptpeLn5tZeQFQcG8oH2nnSxB+y2umlWhUwBojKH6xh09atwueYMVL9mnYNwHn1JmMclM6R/1JkLTpVrp1scI7oZXWCto7cJMfVGumms2FfBbF4Wx0QP3+cUanSyZV+4MMT+B1E2OYBLxtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708075827; c=relaxed/simple;
	bh=868cPAo486JsPKZQ4r7ZwFHfeK2sVZkZMKZTtbn+Nhc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kSoSFSeqU0g+0R7ze56nYInGNpVP2XHF86gWbZNgSUDbVbHTKOPZFd35HAHOuBhW9M9DMP23p80sI1dA0jfni+2QPoi0z+ab1m+eLpaAqZGpjv0bN9XmQ/66K1hXDykrPzm9jLZvH9l5GTJbWwCHbLx2+3bbv4btZIehxZJ1JN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JE7m6T32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CD25C43390;
	Fri, 16 Feb 2024 09:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708075826;
	bh=868cPAo486JsPKZQ4r7ZwFHfeK2sVZkZMKZTtbn+Nhc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JE7m6T32MHUu0VdclptDsXWhjIy8BEz+K5BoCkyAA8uMxT1jF2tZGRhz13LIXp2oE
	 S3ZCIDtgsTXjwPmfL4a/x0U2eJIwS5LpO/ke+r+DOBloamqzTf+NkXdzZ8Wv3rpDs0
	 n0EanC0tenXKETiNLX8v+WJiyX05JsYOpzwbiWZ7ITSfOLXtH5lbXtuGRJHeVRZaAY
	 s68TFdkM9/lYAObfHu4Z72wII+Vqn4aSvCumjnMPylCtg67/O08ooL3CqpVuS31Wi5
	 UucxsWWJqnfA0eixk3+FMK7eNewQJaFha2o9uHD8mIDNImdmG9MkqrFs4kqbXe9l+T
	 we1lsiK9xFTsw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62D4BD8C97D;
	Fri, 16 Feb 2024 09:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/iucv: fix the allocation size of iucv_path_table array
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170807582640.17481.13466288273481184309.git-patchwork-notify@kernel.org>
Date: Fri, 16 Feb 2024 09:30:26 +0000
References: <20240214163240.2537189-1-agordeev@linux.ibm.com>
In-Reply-To: <20240214163240.2537189-1-agordeev@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: wintera@linux.ibm.com, twinkler@linux.ibm.com, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 14 Feb 2024 17:32:40 +0100 you wrote:
> iucv_path_table is a dynamically allocated array of pointers to
> struct iucv_path items. Yet, its size is calculated as if it was
> an array of struct iucv_path items.
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  net/iucv/iucv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - net/iucv: fix the allocation size of iucv_path_table array
    https://git.kernel.org/netdev/net/c/b4ea9b6a18eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



