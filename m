Return-Path: <linux-kernel+bounces-137777-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA3C689E6FB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 02:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 486D1B21E96
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 00:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B5610E3;
	Wed, 10 Apr 2024 00:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V28Z7BJM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8300B389;
	Wed, 10 Apr 2024 00:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712709629; cv=none; b=eIzWIOcS1K4YhfZM4RW4d6Bl95dSr42nw1Gx6IzcGayNjmTqSOzndx5w1nIIRJvz1ppDhEIXWk0sLqWyqo9iBqM/UAkQqftCz2f7Fqmup0sOtunC33fNc8/M4XI7QutkJwsYoflgmFET63MKVW4vxkb+ssZnuKUT11HHw+2OZ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712709629; c=relaxed/simple;
	bh=aUA1ELwfLCjzbEMadjR63fa0VXR/DbucV3JFWkjrQFw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZUtvIOGbr9l7298yI6js9Orxu+2d5YHPVTJSgH96R04o8A8d8eWpl77Y6QMlu12389Jyn3yIsqsbFUQuYWLdr3VDXMJej7fKVtVYmKx+ZCeCR2OdL4srSiG6SUd6t70dPa1fEKXVQoh3DMrn1w2zdNW/gBYK74Y0M1dcZoyy/q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V28Z7BJM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57EA2C43394;
	Wed, 10 Apr 2024 00:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712709629;
	bh=aUA1ELwfLCjzbEMadjR63fa0VXR/DbucV3JFWkjrQFw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V28Z7BJMRVulMpngZvE+E8t16lG7IXYvI8NGZrVmTTcmOwbAomMF9CzsZf0t0DPtk
	 cEbOLP1FGxCvne9i155pmWUWhthj8q7K0hcMcTsn/vcwbEGSBSGCuXWjaaTq4W4BAe
	 tNRa0cbVutWCEC4xlSPPROtWbahZDUT6410OyacZHIfRbBvF51k8z9VNUP6X13tD1d
	 3Iozb4yeawq81M77JPxgZDMo5yS8kU0TW0rbh/6YhnhNWlCJm7UN6xNCVSPuSdg/i+
	 ADureUYvmG8xYj5A3hEKO0bIn1ZdVhNzrx9qtI37XzttrLwHkSqS4X0Xa3y7bg3oua
	 +wF4DCPjTyXnA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 415B3C395F6;
	Wed, 10 Apr 2024 00:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: sched: cake: Optimize the number of function
 calls and branches in heap construction
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171270962926.13694.12417499918923919527.git-patchwork-notify@kernel.org>
Date: Wed, 10 Apr 2024 00:40:29 +0000
References: <20240408174716.751069-1-visitorckw@gmail.com>
In-Reply-To: <20240408174716.751069-1-visitorckw@gmail.com>
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: toke@toke.dk, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jserv@ccns.ncku.edu.tw, cake@lists.bufferbloat.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Apr 2024 01:47:16 +0800 you wrote:
> When constructing a heap, heapify operations are required on all
> non-leaf nodes. Thus, determining the index of the first non-leaf node
> is crucial. In a heap, the left child's index of node i is 2 * i + 1
> and the right child's index is 2 * i + 2. Node CAKE_MAX_TINS *
> CAKE_QUEUES / 2 has its left and right children at indexes
> CAKE_MAX_TINS * CAKE_QUEUES + 1 and CAKE_MAX_TINS * CAKE_QUEUES + 2,
> respectively, which are beyond the heap's range, indicating it as a
> leaf node. Conversely, node CAKE_MAX_TINS * CAKE_QUEUES / 2 - 1 has a
> left child at index CAKE_MAX_TINS * CAKE_QUEUES - 1, confirming its
> non-leaf status. The loop should start from it since it's not a leaf
> node.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: sched: cake: Optimize the number of function calls and branches in heap construction
    https://git.kernel.org/netdev/net-next/c/d034d02de882

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



