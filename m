Return-Path: <linux-kernel+bounces-125117-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6233389204F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 947D61C28D76
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 360CA54676;
	Fri, 29 Mar 2024 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSlcchB3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E7F01EA74;
	Fri, 29 Mar 2024 15:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711725303; cv=none; b=e6Jw32CnzKTG1mqyHHZT+K2qC6UeDesc8koa3r7DGKD4+nG2c0wLQ7JCDEFJyMYuuDL7Ivp1I+oZMKOCzUYhki2gM6DahORS6uBXN3qxKeQF7ooPFGIVjJE4ooVo71v86m3RY7/Hr7yGUsmhoUX3pVq9zrxtwiFkuwQAj0PUkXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711725303; c=relaxed/simple;
	bh=0MORES+duDK5aW5KPWWDob7NGSwDm5ohmLEoTy2CmXw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DwTo5W50P6g0Xk2v0GrUyKSzfoh8v7NeQ7/pUIFt4n9a8hbzS6QICT783luQwmehG6itGMdkO6lL++UuWgF17JpPWd8C9xRx96+N8WQ5wUBwqyskgdSXNtRaB3IKrWJRn113/4qb9woAd+IBIPViDzkm54FlY2YjVztChwHyJYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSlcchB3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2C5C433C7;
	Fri, 29 Mar 2024 15:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711725302;
	bh=0MORES+duDK5aW5KPWWDob7NGSwDm5ohmLEoTy2CmXw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XSlcchB3xj18lYBzg8iZzZCKxBu1PaDUbbhGw+kE4WRcb4FDrGE2P84dSBJy7V/ar
	 +fChVCdZ+tSoKvxJeVMwrBlOqEIzabVL85VnOZR1liOicYmZ5IvRfRXwrt7WREvyMr
	 vzewYfwctd0VUFozRFll5VX+9gCHPChLCPaQTzrM885d3Ak9wLCpjQ936PevK3on/E
	 7AliPSXWIlIc7DtYPemXlGmufCRxCFjC1+SXUDjEDydR7BUsmZh7ueBVe5AhRp/8GY
	 Q1NljUOVl7MUPde97A71XuYosbTA6uIh7luACpXcFqLqVgYmHcsrCIZPAswFqk9Lfe
	 S4B7bumvW+cfg==
Date: Fri, 29 Mar 2024 08:15:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <jiri@resnulli.us>, <horms@kernel.org>, <rkannoth@marvell.com>,
 <shenjian15@huawei.com>, <wangjie125@huawei.com>, <liuyonglong@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V6 net-next 3/4] net: hns3: dump more reg info based on
 ras mod
Message-ID: <20240329081501.4460ad4d@kernel.org>
In-Reply-To: <d6c779a5-e4b1-4f21-b4f0-6b37b212890f@huawei.com>
References: <20240327114330.1826631-1-shaojijie@huawei.com>
	<20240327114330.1826631-4-shaojijie@huawei.com>
	<20240328191130.47242c8f@kernel.org>
	<d6c779a5-e4b1-4f21-b4f0-6b37b212890f@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Mar 2024 18:34:02 +0800 Jijie Shao wrote:
> > These seem to be duplicating standard stats from rtnl_link_stats64,
> > ethtool_pause_stats, ethtool_eth_mac_stats, etc.
> >
> > You can add device specific stats, but please don't duplicate
> > stats for which we have standard APIs.  
> 
> Yeah, but these are not duplicate stats for ethtool or debugfs.

Can you say more? I mean there are APIs to expose MIB counters.
Perhaps your driver doesn't implement those APIs today.
But (1) it should, and (2) once it does it will be a duplicate.

> Generally, driver will reset to restore the normal state.
> After the reset, many registers are cleared. Therefore,
> it is difficult to analyze the reason of RAS.

Perhaps I'm missing the significance of the reset when it comes
to counters reported via standard APIs. Are rtnl_link_stats64
going to behave differently across a reset than these debug entries?

> We wang to add this information only when RAS is occurring, And
> these information will help to analyze the reason of RAS.
> 
> these information does not appear in any new API.
> 
> Therefore, we hope that we can add this information to
> reduce the difficulty of analyzing certain issues.

