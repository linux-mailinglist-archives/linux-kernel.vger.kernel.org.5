Return-Path: <linux-kernel+bounces-77700-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC630860933
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 377FD1F25181
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 03:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 591B6D30B;
	Fri, 23 Feb 2024 03:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIcewTEm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E5BC2C6;
	Fri, 23 Feb 2024 03:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708657826; cv=none; b=EXZzjSzG4CPu7qcmepvNATDsSUR6sdL/Ofq+iUCsD5KDfMOwyxB1XtM+RmKCtIy5PrGMGfAJZ2lwsTLz5EQTNVFC3Q9fSl+f9Rb6RZ03tY2ReXfcuKnK4fMpnd00GwH4SoLWF5UUGicr/FL5adARcyv9L9YRxvuOL7P/IwKhk+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708657826; c=relaxed/simple;
	bh=ShyPs+sk9cjghhKS+XmCdRWwHN7rYc+/GlEjmNvnqUM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o9YjxDmmTeFMgFo1+bd5MHMws21gYHAZg6R9N91sgJauurJidMXqF+4YjANBjL0od+yipJHXvgVD0Ln4yTyrI6aI5cFd/tQjz135XjmNmK0FIywp4yJA4p1OsAVxGFZPO56mUtWYj317s0R/gO6o6zIYumcbNf04E7Pit9wApq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIcewTEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66A49C43390;
	Fri, 23 Feb 2024 03:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708657826;
	bh=ShyPs+sk9cjghhKS+XmCdRWwHN7rYc+/GlEjmNvnqUM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bIcewTEme+9ObupVYZoPyDLHY731JB2tvS1z2pUHm+T3TRz7pwNIaHbkZMgGGLPIl
	 W1FwjhhuQMl1k8QTADCEHb/EY1UyNxl9X8mWj26mcZ4jLLXdyiFY8Z3t4jmBk8otv0
	 EUmldRYB1qcff7S1YscfCGBqrr7xIXMGdrC9cdhNBBpWt49fWeir/IsftVJWHoAqpt
	 4OphOD/O4RXE955nF+hr2LpkXZEf3uXS1vo9cOehQIt5BbyOeO0fY8B3bfNCvq7kv2
	 Dq8hQF1NsPlYJX+TQM5k6IxThjYMsHyY2l1QF5oQqvfcjBhlQfDatAy9sU22XyTg9V
	 W7Bnj8qqUbCOw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4D0C2D84BB8;
	Fri, 23 Feb 2024 03:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] netlink: Fix kernel-infoleak-after-free in
 __skb_datagram_iter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170865782631.16544.1371911549002746191.git-patchwork-notify@kernel.org>
Date: Fri, 23 Feb 2024 03:10:26 +0000
References: <20240221074053.1794118-1-ryasuoka@redhat.com>
In-Reply-To: <20240221074053.1794118-1-ryasuoka@redhat.com>
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, anjali.k.kulkarni@oracle.com,
 lirongqing@baidu.com, dhowells@redhat.com, pctammela@mojatatu.com,
 kuniyu@amazon.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 syzbot+34ad5fab48f7bf510349@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Feb 2024 16:40:48 +0900 you wrote:
> syzbot reported the following uninit-value access issue [1]:
> 
> netlink_to_full_skb() creates a new `skb` and puts the `skb->data`
> passed as a 1st arg of netlink_to_full_skb() onto new `skb`. The data
> size is specified as `len` and passed to skb_put_data(). This `len`
> is based on `skb->end` that is not data offset but buffer offset. The
> `skb->end` contains data and tailroom. Since the tailroom is not
> initialized when the new `skb` created, KMSAN detects uninitialized
> memory area when copying the data.
> 
> [...]

Here is the summary with links:
  - [net] netlink: Fix kernel-infoleak-after-free in __skb_datagram_iter
    https://git.kernel.org/netdev/net/c/661779e1fcaf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



