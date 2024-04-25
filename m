Return-Path: <linux-kernel+bounces-157871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 094CA8B17D2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 02:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BC2A1C22689
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E246A3D;
	Thu, 25 Apr 2024 00:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFmMIE05"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8C94C89;
	Thu, 25 Apr 2024 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714003828; cv=none; b=Y7y8EWBHtO3ajiBxrm5AwxunG5RwmlPgckRohSGUfjRpHTD1TAg0/e3d1GNoBrLvse3NnMez1NgTCr4TpY0OkKMlaBwjVQqUwCcgStZNeFM1xZeuhiWZtbzSDjpEERc8C/IanRf1DMPKW/cy8+xrfP7i84c9QG5P/ln1T4ubJyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714003828; c=relaxed/simple;
	bh=ngfIbfTxCSdaDPDKMaOh3a+iXzLk5cK0ZApeslIh9D8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sKwsr+Y0m4E1lndWtwlFbZJ+Jgng2qQ01G7JkHSdb3UmBEKc/RZEalNFAiuoOFujPmzmOKq/bD4ycLjWOW++EYlCQYvjQ9hcw6+4WqTxM/mWPFVWku7QnpS2kPTgntWX2AOHLKRt77iWNHDDz7vrJXc9UUhoPadKSqtWA/jxWw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFmMIE05; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39EA4C4AF07;
	Thu, 25 Apr 2024 00:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714003828;
	bh=ngfIbfTxCSdaDPDKMaOh3a+iXzLk5cK0ZApeslIh9D8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GFmMIE05nAWggvnhAIOOb36+6ROmLZHVPHTEdLexf0gWFHAsyaACvprLjQfNlLuUf
	 3+lLZqh9tMKhY3qvNA7eHUKK7GlPk5g34WAK/eAOY04bXyZC9ap2VWKNlY0R/npmjc
	 j3QFmPXxZ5Hy8O0Yd6KP6JvkIO5uwbjFf6QtqUJanGw7dyU7pKewL74ychhM0gDVc3
	 scpOoGMBoTFBecnNDLWFv6TRPLFT1CdckuoCnVvpGEu2hkreNgKnCAo2UsJgkYEbJW
	 n9IafJKMiBKVAYhgyUOTW46dygejNC7BpHqpGaDSijMVcKyW30BVnXmoSMYMHX29BB
	 wErAQVoUFPRow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 20851C43614;
	Thu, 25 Apr 2024 00:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: openvswitch: Release reference to netdev
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171400382812.11572.13295936875688940773.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 00:10:28 +0000
References: <20240423073751.52706-1-jun.gu@easystack.cn>
In-Reply-To: <20240423073751.52706-1-jun.gu@easystack.cn>
To: Jun Gu <jun.gu@easystack.cn>
Cc: pshelar@ovn.org, netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Apr 2024 15:37:51 +0800 you wrote:
> dev_get_by_name will provide a reference on the netdev. So ensure that
> the reference of netdev is released after completed.
> 
> Fixes: 2540088b836f ("net: openvswitch: Check vport netdev name")
> Signed-off-by: Jun Gu <jun.gu@easystack.cn>
> ---
>  net/openvswitch/vport-netdev.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] net: openvswitch: Release reference to netdev
    https://git.kernel.org/netdev/net-next/c/66270920f90f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



