Return-Path: <linux-kernel+bounces-160156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4668B39F1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 16:28:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF766289AA9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 14:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE49D149C6D;
	Fri, 26 Apr 2024 14:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q/zg0/JL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290CD14884B;
	Fri, 26 Apr 2024 14:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714141595; cv=none; b=NMeii71MHIIq/etD7H2s+mMbd2CPEnmhpgPhj40d3nWiPW5/A9HKOcE13m5N678okceK/GpLvpRSQrz/EsUkW1SagL65bWHBWDO5sNXvGm6C+jxi0z+8bEpsyZNtcAywSQePGxoTBRmXmULo1TcOibC7oQ34D2maZ8LqqUCWxwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714141595; c=relaxed/simple;
	bh=SKecwnhJLO6qiYpZ/vNEzw2bRyqrPwNVSjtPzGEAWzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B43hpJLUwDMPF0khBODxAf8b23p+5kAFlIAjvUYGnKH9pLvz38o5NE0BbJcsa7ia6gNDZt/fVx1wC814AuuF1WIGwc59ZfLxL6aVxKwgEJlirhp47bfB3kfguGOF0p9LxtStVTtlBMP7syrAxTknTl9lXvgYXUyBu4S0g513cAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q/zg0/JL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87B9C113CD;
	Fri, 26 Apr 2024 14:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714141594;
	bh=SKecwnhJLO6qiYpZ/vNEzw2bRyqrPwNVSjtPzGEAWzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q/zg0/JLWDS1mrTmw6xYjan/krNKUcPDf3KGY4uS8UJMGZthrM63ejCmyLQHbjBO/
	 h2s+UBuAOasen9R3PIRD4vylD4Y7xUYwWZMH2+sDwU1gJdEwlH3hmp1v4xKelUj3ut
	 iiFyguyAozUaVnMCP7iDP8NZTUraZGVAzRtaLuefFU6UBZ4Xlr00sETmcAxaBZwoZ8
	 9mKOM9mdOijbEPafhxWvSFRGrWa9poLjNwm0L5/OJkKBYpnbj6dqDPtRjRh4x+Xl8F
	 RSfCnvyZLTXHrxlbJDbi0txOUXsM0QNO4soBj2cwEAWLNrj3FEY6xn+D2q1AJcX4DT
	 amtEGh8cUk0Bg==
Date: Fri, 26 Apr 2024 15:26:29 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jiri@resnulli.us, shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 net 2/7] net: hns3: change type of numa_node_mask as
 nodemask_t
Message-ID: <20240426142629.GD513047@kernel.org>
References: <20240426100045.1631295-1-shaojijie@huawei.com>
 <20240426100045.1631295-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240426100045.1631295-3-shaojijie@huawei.com>

On Fri, Apr 26, 2024 at 06:00:40PM +0800, Jijie Shao wrote:
> From: Peiyang Wang <wangpeiyang1@huawei.com>
> 
> It provides nodemask_t to describe the numa node mask in kernel. To
> improve transportability, change the type of numa_node_mask as nodemask_t.
> 
> Fixes: 38caee9d3ee8 ("net: hns3: Add support of the HNAE3 framework")
> Signed-off-by: Peiyang Wang <wangpeiyang1@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


