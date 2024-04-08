Return-Path: <linux-kernel+bounces-135244-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3231389BDAD
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92A9FB211D6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1345657B0;
	Mon,  8 Apr 2024 11:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rreDV8Pj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA29B60260;
	Mon,  8 Apr 2024 11:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712574035; cv=none; b=OsvWtkz17CuDomDUtz2l2wwPqpXwC1XsmYTs22Rgwv+IEz22BaMLD4NZieinv4ipi0kcLy6XE7rdw2l8o2tLgVVciWrP4hOmcdqf1dzIm/dLyHJgKPEK7k+1bNBwnJ66FDaSgNEE3mhrQFYQMlyL1lx3QpIMj3R7oFL3iCMpDrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712574035; c=relaxed/simple;
	bh=HbeOSTm2sxkRzI1ptMnZ92ADLHFoQ1xwvYsVAagxJzk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bJn3GKWT6Jo8Bvs/FKlfnMrrOkp6N5Wav7oI5OhiGbf/UlctnPq4gi6z6XV5A4mDn7CKuTOaShmP7gGnU//Q63bVrtBQq6qOBAesGNrn1gaDHULGwY1nsrlrvXUtA4GbuX9VA3IYKou1DNh3ekodiO1czZP5+ep4REJK0A6BGV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rreDV8Pj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C54C5C43390;
	Mon,  8 Apr 2024 11:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712574034;
	bh=HbeOSTm2sxkRzI1ptMnZ92ADLHFoQ1xwvYsVAagxJzk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rreDV8Pj2c/Nd3BUAreHDSJd5asr4Sc3WMhsr/GbgbVeAWp3Vfjs3Wz2tei+/JuP+
	 NLhtLWlaO7L7Q6bneHxCxgVhqO6sXesDai8urXttN5GCs4hf6vjH1w5iHgoKSl4FdK
	 nTc1wZeGp+bL/Fx1gWCLSwGYWyutnI+fmoqPvr2o8qJfCADacqqJYWbBi+QfDx5V7+
	 JFT5+Ekone/JmiUS0hhYfGiCOfDKSCfhbi1eY3XTYhxYSWPnu9RXfjKv17U9DJDGv3
	 KClK/ytowRhWWcnkZAdT4YcW7haUAuRkBnhx044TNGB1ClN6ho9A/pu6XQjrP+Pv9t
	 oU6qjYkfVGFMQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8C8FC54BD7;
	Mon,  8 Apr 2024 11:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/1] XYZ: Handle HAS_IOPORT dependencies
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171257403468.26748.18118428857352948104.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 11:00:34 +0000
References: <20240405111831.3881080-1-schnelle@linux.ibm.com>
In-Reply-To: <20240405111831.3881080-1-schnelle@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 m.grzeschik@pengutronix.de, mkl@pengutronix.de, mailhol.vincent@wanadoo.fr,
 netdev@vger.kernel.org, linux-can@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-hams@vger.kernel.org,
 arnd@kernel.org, hca@linux.ibm.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  5 Apr 2024 13:18:30 +0200 you wrote:
> Hi networking maintainers,
> 
> This is a follow up in my ongoing effort of making inb()/outb() and
> similar I/O port accessors compile-time optional. Previously I sent this
> as a treewide series titled "treewide: Remove I/O port accessors for
> HAS_IOPORT=n" with the latest being its 5th version[0]. With a significant
> subset of patches merged I've changed over to per-subsystem series. These
> series are stand alone and should be merged via the relevant tree such
> that with all subsystems complete we can follow this up with the final
> patch that will make the I/O port accessors compile-time optional.
> 
> [...]

Here is the summary with links:
  - [net-next,1/1] net: handle HAS_IOPORT dependencies
    https://git.kernel.org/netdev/net-next/c/a29689e60ed3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



