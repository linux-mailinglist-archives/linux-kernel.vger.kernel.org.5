Return-Path: <linux-kernel+bounces-110572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A60A88860C2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 19:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7C201C21A66
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D41133991;
	Thu, 21 Mar 2024 18:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hi2ULJS/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BA118BE7;
	Thu, 21 Mar 2024 18:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711047027; cv=none; b=TCYSawvhWKVc2bmKTTuYmQfikvwEuLywDEqFe2wjDODRB4zDpLcFd3fmQgmx86t9bGnbdNgsszIQYyN0E3ovdWSjO+D06a4w3S0YAnRv6iKCMIkKqZCCD7pJ76KWs0oPHE/0u9na7ByyPf5w8cVSvTc80NCRsd005BKrFR2m0hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711047027; c=relaxed/simple;
	bh=xTGMHb3ItKHFcyDlKxuS5tVuQdBda+qz9Z7oILmcmn8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rJF/TdswCd/NrHphGCZ65sAV3CoqHptyE3u9Cq4iu33f9z7AlXs04lgh6KcQYjILBxkgfuZDLWr+VISV6scDb1MXF20HNsUhcEHi+PcAS3w/Q9euMWxSq6umtwssiXLn6+lcF2UGNoTc6w3oFcq0uUokDomH1tkkqLp55Y0SFC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hi2ULJS/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 280D1C433C7;
	Thu, 21 Mar 2024 18:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711047027;
	bh=xTGMHb3ItKHFcyDlKxuS5tVuQdBda+qz9Z7oILmcmn8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Hi2ULJS/bExwZadNGYcDOCCaeb5cOy5j5wQaqXxY15kLC/V2YFSLtu5YNhJ53pSlV
	 sxVs3iL+/GVi4CVJcSkr2Wsr+/Nm9h4tlkYnmv324juyk60lk7P3nGDNl8dUhnZybM
	 zfQGiRITQ5EO0JZJGZfMf1ibUqp5V/z930pyWHtgyhBk6w6cd7Qg81l2wzeruOqHly
	 wcIWDI0388AYQ6M2lcDxjlM1O17cJsZSCz/2L67FpwCSNamuFQ+DIPwn8axjiw75sC
	 /OkyHwt4rrcxm8TvHms230oJJGQLqKSVLr6XOdTHobFoSD4yyY8tgrKohMIU2okKcS
	 7iHJumTlI37nA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13635D982E3;
	Thu, 21 Mar 2024 18:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] libbpf: Define MFD_CLOEXEC if not available
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171104702707.24409.2393183534870190384.git-patchwork-notify@kernel.org>
Date: Thu, 21 Mar 2024 18:50:27 +0000
References: <ZfxZ9nCyKvwmpKkE@x1>
In-Reply-To: <ZfxZ9nCyKvwmpKkE@x1>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: andrii@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Thu, 21 Mar 2024 13:01:58 -0300 you wrote:
> Since its going directly to the syscall to avoid not having
> memfd_create() available in some systems, do the same for its
> MFD_CLOEXEC flags, defining it if not available.
> 
> This fixes the build in those systems, noticed while building perf on a
> set of build containers.
> 
> [...]

Here is the summary with links:
  - [1/1] libbpf: Define MFD_CLOEXEC if not available
    https://git.kernel.org/bpf/bpf/c/ddb2ffdc474a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



