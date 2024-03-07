Return-Path: <linux-kernel+bounces-94977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 478E087477A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 05:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF8151F25709
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8611BDE6;
	Thu,  7 Mar 2024 04:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwu9z77S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E783D6B;
	Thu,  7 Mar 2024 04:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709787028; cv=none; b=eXJ+5f1+DgXNxiZRVw0Igwrp7yElFzMi27CYTY7XsTr87jqxMw9XrObJmLC3JSHuoJkEIA3UpVqDt0Zh2QJNtNlMQ9YZEOKA5rQGBOc+N8g9vpQZ63lxihqlZ6NOAOUVwtOpklq8xHNpn7mgTpIW+7Trth0ZL04U3xt5vka0/xU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709787028; c=relaxed/simple;
	bh=X5d+n8yY7yu891hIsAhkVV4aNq8U3dmq+Nmcr6tPkDU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IK3/9kEnaZ9wex5QNzir/YxD4Fp9wJd9eYDpwezog1NqU+lG9WNIqSHgmr8jP3oNdFh5Jr7DZC2A/PBRQiIaNVoGUS+A65YOzPRVL7zroaEZbdjE05fTpGOe9+a7qU04MqERnCn01mDGls90ZQW5ExGcc/e/6iOrPb+TqrPkXBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwu9z77S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9635C43390;
	Thu,  7 Mar 2024 04:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709787028;
	bh=X5d+n8yY7yu891hIsAhkVV4aNq8U3dmq+Nmcr6tPkDU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bwu9z77SiLG8qlMHg4yJThEf5C7IEK9Btn4QGu8dEaCIL4aa/rCUTsNxiOSpoiZ8V
	 09VR6PHiWS+70yZ0+RQzxmNPyDAuCONbQhXqdbgcvZCF97ZHSboYKyfp0ex/muFu75
	 OHDGefbSiZaHF724ZukHl/0jcG6rfbQV1xQ2kjgqZmTAmK5q6/XYFRqQ+s/1Hrj2oB
	 uW1vyu5/CfhLIV4tmu2rsBcfVtcYMUIsc2mc7vIWRNZP+Rqrym4RGR9Btx8dFsVn7g
	 FwpGxD/v3j4w6hSgq6nZkcjxf4VA8lbG4e63V9urYv/aWwnkYWyRKXlGSrDuAB2nr+
	 WWe9xxWd8zw0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7827C04D3F;
	Thu,  7 Mar 2024 04:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] mlxbf_gige: add support to display pause frame
 counters
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170978702781.12804.10600811373220093437.git-patchwork-notify@kernel.org>
Date: Thu, 07 Mar 2024 04:50:27 +0000
References: <20240305212137.3525-1-davthompson@nvidia.com>
In-Reply-To: <20240305212137.3525-1-davthompson@nvidia.com>
To: David Thompson <davthompson@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 asmaa@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 5 Mar 2024 16:21:37 -0500 you wrote:
> This patch updates the mlxbf_gige driver to support the
> "get_pause_stats()" callback, which enables display of
> pause frame counters via "ethtool -I -a oob_net0".
> 
> The pause frame counters are only enabled if the "counters_en"
> bit is asserted in the LLU general config register. The driver
> will only report stats, and thus overwrite the default stats
> state of ETHTOOL_STAT_NOT_SET, if "counters_en" is asserted.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] mlxbf_gige: add support to display pause frame counters
    https://git.kernel.org/netdev/net-next/c/c22341619852

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



