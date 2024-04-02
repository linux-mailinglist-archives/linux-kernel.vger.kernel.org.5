Return-Path: <linux-kernel+bounces-128116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E91E5895652
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 16:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 489FA284BA1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96E7126F16;
	Tue,  2 Apr 2024 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9ejCqdl"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DBF74262;
	Tue,  2 Apr 2024 14:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712067028; cv=none; b=I2DHBof16wX7+5GF+Jot3nwdpcA2CV81s+DWQWZzpVC6IY6GS/F262YfzFzw3+id4uzLNR8IlZ8JtG6Vog/lKMhsKwQ2X3xqisHo24s3nmp4MD4wjoDI3scWSwiQXhHMl0Kb5UixrliSZX1ktSYs/7lg8qMCTGJMgxBEr7ktCCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712067028; c=relaxed/simple;
	bh=6/gaVejmho+6gxtK4B1sWMwBKvhxjxSbV/MyNET8rRw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QfJK2BCkSNAGOi1vmVUc4pzr7OTgq5pDlN9DSK0apn4Qfms12aPSzeEcGFLTxIjrYwaX+EkYEn+gY3Z/Q/p3pK4YMIqRGa/6UQua1xTQhJ39gahaX1IdR62YvvbDhhMvKSR0FbGia+Q+bpBBNqFt3RzkPB4BM7k8H3oI2pZuSRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9ejCqdl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9370DC433F1;
	Tue,  2 Apr 2024 14:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712067027;
	bh=6/gaVejmho+6gxtK4B1sWMwBKvhxjxSbV/MyNET8rRw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E9ejCqdlolfsY80nizbS0Awh8t/GWEyC6EIf3L+vmEsiLa/VuNWGZHEW4oULhqS4H
	 pgmLIkUVnlOvgDNVdg08Kz4QwZuSYwGggIq+aimDZZ1lh0/6DZp6pbrDA70RZ7e25S
	 60up/ZHuB+m3Tgnsjmy/nVIeUZ7rJfGebZceZ2SCSNshzHasHXRAVzfxXtTYQRyKr7
	 Gnys4jEPmrhXMjRn2TcadPymvzcEBrurUBqvV4sEzUppwdESoCwNUf+sggwPyL9M80
	 fCHasAtWfLsanxmPSrpCJieHVasJDzJ9E0hS0Eep+6BaP9fxriEeMRnWMptCcX022B
	 svffvgz8rqdYw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 80279D9A158;
	Tue,  2 Apr 2024 14:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf: fix typo in uapi doc comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171206702752.6673.7807180542850602789.git-patchwork-notify@kernel.org>
Date: Tue, 02 Apr 2024 14:10:27 +0000
References: <20240329152900.398260-2-dlechner@baylibre.com>
In-Reply-To: <20240329152900.398260-2-dlechner@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Fri, 29 Mar 2024 10:28:46 -0500 you wrote:
> In a few places in the bpf uapi headers, EOPNOTSUPP is missing a "P" in
> the doc comments. This adds the missing "P".
> 
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
>  include/uapi/linux/bpf.h       | 4 ++--
>  tools/include/uapi/linux/bpf.h | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

Here is the summary with links:
  - bpf: fix typo in uapi doc comments
    https://git.kernel.org/bpf/bpf-next/c/ca4ddc26f8ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



