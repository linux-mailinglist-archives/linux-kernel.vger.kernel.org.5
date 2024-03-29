Return-Path: <linux-kernel+bounces-124051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C84CB89118E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 03:15:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34203294FBA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 02:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C1237160;
	Fri, 29 Mar 2024 02:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bC4mL/G8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76EA0364D4;
	Fri, 29 Mar 2024 02:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711678292; cv=none; b=bWY6NwG1Ck+Iuk4PyaSkU/m59kbfgvPNoHSMufBRltbgImr4zfYgITwdQslcDrgzSal0M9gm7l5VkKq3WDnUEAIorIGa6LZ3pkmXAnBu1FMwP2dKM09kAObg7SdW6ulqWG3SOyXhIqLAjVeCS7VR40WjQOoVD9ckp4M/NDbhvAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711678292; c=relaxed/simple;
	bh=wiI8l6P+7khO2WSmx7RdBmkoeftWtC5/LdFSc3a+f2g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZOnn3F49Mh8roiqTce4cSm2PAMEaRSp9y2NvibloM3q88tbTEy6dtg1MTXsMGQaWFnpu1sM3+vU13c7tBim1m8Jz/ywnqTEyqV/xwVQXqPgQPu9X2CjoWoet1GTvIx63Mckr+ItxDElG17QhRK8SwDi9pgaFmVRRVrz6+GS1zTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bC4mL/G8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F371C433C7;
	Fri, 29 Mar 2024 02:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711678292;
	bh=wiI8l6P+7khO2WSmx7RdBmkoeftWtC5/LdFSc3a+f2g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bC4mL/G8N8W3xmsPmhYd+hXIg9o6jIChDaoLSVIrIAqpWpMERjBw7zFz2aLi5b+VA
	 FbGBLdHwNItDrHjWojTW4cKxW2M0rl7rnCDQwX6JK5lczqYU82yTTnLeuBFYUDD82N
	 1gQFz/6A9+qhvqsPkHut16b3b+/Uom5ZEKifEeX3Jo0M7cMPWz+tp56tlWozVk2NF2
	 0wtlLsimkRUCZBr/9AVUvQ0YPvTJfN9wwaDvqZRG84BY3gG6Z0qCFE1v80J6DQYFrU
	 K1EMekTmh+WG5hRKdQE10R+fJ0M4K3dDKrjVx9oOJIEloC1NVuvueqgZtF16iOVQ/O
	 fDoAj1jfNz5Gw==
Date: Thu, 28 Mar 2024 19:11:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <jiri@resnulli.us>, <horms@kernel.org>, <rkannoth@marvell.com>,
 <shenjian15@huawei.com>, <wangjie125@huawei.com>, <liuyonglong@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V6 net-next 3/4] net: hns3: dump more reg info based on
 ras mod
Message-ID: <20240328191130.47242c8f@kernel.org>
In-Reply-To: <20240327114330.1826631-4-shaojijie@huawei.com>
References: <20240327114330.1826631-1-shaojijie@huawei.com>
	<20240327114330.1826631-4-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Mar 2024 19:43:29 +0800 Jijie Shao wrote:
> +	}, {
> +		.reg_name = "MIB_TX/RX_BAD_PKTS",
> +		.reg_offset_group = {19, 18, 29, 28},
> +		.group_size = 4
> +	}, {
> +		.reg_name = "MIB_TX/RX_GOOD_PKTS",
> +		.reg_offset_group = {21, 20, 31, 30},
> +		.group_size = 4
> +	}, {
> +		.reg_name = "MIB_TX/RX_TOTAL_PKTS",
> +		.reg_offset_group = {23, 22, 33, 32},
> +		.group_size = 4
> +	}, {
> +		.reg_name = "MIB_TX/RX_PAUSE_PKTS",
> +		.reg_offset_group = {25, 24, 35, 34},
> +		.group_size = 4
> +	}, {
> +		.reg_name = "MIB_TX_ERR_ALL_PKTS",
> +		.reg_offset_group = {27, 26},
> +		.group_size = 2
> +	}, {
> +		.reg_name = "MIB_RX_FCS_ERR_PKTS",
> +		.reg_offset_group = {37, 36},
> +		.group_size = 2

These seem to be duplicating standard stats from rtnl_link_stats64,
ethtool_pause_stats, ethtool_eth_mac_stats, etc.

You can add device specific stats, but please don't duplicate 
stats for which we have standard APIs.

