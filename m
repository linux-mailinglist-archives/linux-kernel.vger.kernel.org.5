Return-Path: <linux-kernel+bounces-128212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B6389579F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 17:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6988F1F230CC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 15:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295F212BF26;
	Tue,  2 Apr 2024 15:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MoPbbFFf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B90129E78;
	Tue,  2 Apr 2024 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712070029; cv=none; b=XB3D5O94ZIJmrBF9ELPQTrXejy0ZkDDD+7KTYv9XQmyCNPFrUyZcEPZbvyafWfPusWPL/72uZKg9gxZQ5PkAYfEXFb0iPx7aT8h5pAUbPsAsP1pcEZuYxdgtehsaE250xV4EYrqnSpeKEBw0qjF/Kf/kusxm/LPcvJw+PXApfY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712070029; c=relaxed/simple;
	bh=u/7bxZbXRG5DNxY1VggdK8feKUAFNIpn7Mh+B5nrScQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jg1b3KNDoi5ErkfM0i/LT5CUx3HhjpVdRIO96Ok8rqc9+cK0QZTjMoX72XGTeyyxPukHyW/ZYDZ6UPlIZUDDIRIKXHvwXrsDvbQ/AcEHv08xJMfhth+RptMQGWovJfb7Ae0Nx8U2tAKMeRqTMV3+2DkWa333ZcT6lrohQpGSao0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MoPbbFFf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3F3CC433C7;
	Tue,  2 Apr 2024 15:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712070028;
	bh=u/7bxZbXRG5DNxY1VggdK8feKUAFNIpn7Mh+B5nrScQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MoPbbFFfEZeVfCf3h+zH18GLREIRAlEm5drLCWXIxOhyFPgg8aEW6yCnUwTr31Lyw
	 EtKqF11INZ0xt0TnCfLUb9IbbOE7gQOv0el3QPL4PQAQAUxcl+XsO35LNsbqYjc8H5
	 7/j19/qIrfdep8wPU2jvDWkeN8s7hL7/vXDHSLA9V7fNFjPVz4hVVP6pAjcnm3NwtJ
	 oQ43GRgSqkNm1vZoCKpGcWubSUWViVmW6ce0uaZg+tFjt1UUNuBH5TPFkU41QVX4HH
	 ExbewYMdI/ku/eTNuYcSxJDrNI1qxe1GBhhAa/biTS6B4aVbJMqKm1Gw4OFF//3kfW
	 W0NmWwqeQ8I1w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C4F8DD9A158;
	Tue,  2 Apr 2024 15:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next] bpf: Improve program stats run-time calculation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171207002880.6823.10928573091892123397.git-patchwork-notify@kernel.org>
Date: Tue, 02 Apr 2024 15:00:28 +0000
References: <20240402034010.25060-1-josef@netflix.com>
In-Reply-To: <20240402034010.25060-1-josef@netflix.com>
To: Jose Fernandez <josef@netflix.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Mon,  1 Apr 2024 21:40:10 -0600 you wrote:
> This patch improves the run-time calculation for program stats by
> capturing the duration as soon as possible after the program returns.
> Previously, the duration included u64_stats_t operations. While the
> instrumentation overhead is part of the total time spent when stats are
> enabled, distinguishing between the program's native execution time and
> the time spent due to instrumentation is crucial for accurate
> performance analysis. By making this change, the patch facilitates more
> precise optimization of BPF programs, enabling users to understand their
> performance in environments without stats enabled.
> 
> [...]

Here is the summary with links:
  - [bpf-next] bpf: Improve program stats run-time calculation
    https://git.kernel.org/bpf/bpf-next/c/ce09cbdd9888

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



