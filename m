Return-Path: <linux-kernel+bounces-84467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 011DC86A722
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 04:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF89283EB7
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 03:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4C72031E;
	Wed, 28 Feb 2024 03:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nl64v+Q2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7611DDF5;
	Wed, 28 Feb 2024 03:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709090432; cv=none; b=Gf6QYoJ49v83VEkaruyklFpKuJg4o7Pf7l8WLeliE6Y+Mwh1ak8wpQqZzM8GVDNE0kSXnZyovKAOnKMDCZ4o9wVXileyDC3DDpDw5/FyRIMtxepJv/kiIe+ZJh+2eq/X+pDmQdiE+q09NUfShAuv8FujUf3k7jO1pCOoYt3o9mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709090432; c=relaxed/simple;
	bh=Tie5XtoEakgyp91HZ1L/FLDkGzkh11gjzWIlmIe20PI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dzAmc5qFrc+qIhMU5xvBwZzxZr7CvLu8FWIff36Rblnip8668LJhNGbcAvKoFFiHru7rMIM+gwCfMei03wveWPH7S5C0I9CA0cHxVJbt6gh/HXCBIc+LINdcWcdtuP98EHXdcn6kmj7HJpVWT/G7ym1k1YQTDypHUmjUdKPkENQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nl64v+Q2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BCEB6C43399;
	Wed, 28 Feb 2024 03:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709090431;
	bh=Tie5XtoEakgyp91HZ1L/FLDkGzkh11gjzWIlmIe20PI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nl64v+Q2q5qbUVpolMTA6ZoYHSQONZSb4ufpQnJBmEQqak2Tw8KJ9/3FvtQiG3cph
	 C6rwwqblhrtcZdDvJEeFSx1Ysjlcy6yV3qd35i/JzO7RDv6K0KL/8eM0+b0E6KvYdB
	 wEESqUMVdlCc/sCFnlYznOjP73U6D4zySp4e1L+XjEBDWALXfBveysYBxVYvOk8uK7
	 ATw8dIzbGwrFftcuLkAON44CEveK/tPeGfas5/VC7nZDBGEQOYLof01UZSKK8GFT9t
	 dWveiGGKYHXJBKcVlcEGPnOoCJa7iEBpenPttbYBEJAHxxJl96nGJoJz7z1ZtFRhFw
	 5YzEYb4OO7WJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C14AD990AA;
	Wed, 28 Feb 2024 03:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] uapi: in6: replace temporary label with rfc9486
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170909043163.27277.7611137336558798707.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 03:20:31 +0000
References: <20240226124921.9097-1-justin.iurman@uliege.be>
In-Reply-To: <20240226124921.9097-1-justin.iurman@uliege.be>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Feb 2024 13:49:21 +0100 you wrote:
> Not really a fix per se, but IPV6_TLV_IOAM is still tagged as "TEMPORARY
> IANA allocation for IOAM", while RFC 9486 is available for some time
> now. Just update the reference.
> 
> Fixes: 9ee11f0fff20 ("ipv6: ioam: Data plane support for Pre-allocated Trace")
> Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
> 
> [...]

Here is the summary with links:
  - [net] uapi: in6: replace temporary label with rfc9486
    https://git.kernel.org/netdev/net/c/6a2008641920

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



