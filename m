Return-Path: <linux-kernel+bounces-578-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCF1814332
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 09:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0D831F2306F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3CE10A34;
	Fri, 15 Dec 2023 08:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JKVp61II"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE4012E40;
	Fri, 15 Dec 2023 08:03:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34F3DC433C7;
	Fri, 15 Dec 2023 08:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702627425;
	bh=p9x1fXgVjeCici0BVx/zhFbZXBS2ONfRfVclygpC/1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JKVp61IIC+9onKloh5tAwcWq/WXWqCw/PsDYjyi953raW7v0lsSP8zGwnYt3q+0IR
	 rptS/NCci7c/SCk4RWJQelYO75hLFGuoJG6YejmX8u+ReEdjLR5xzjZ9VEP9SiBJrl
	 gkE7QBKFcOytBSjv4/IOdIEIFjjO4CZrMPLa00IFlCRmHu2frzXL22iq+3L7UxAV+K
	 skC3/T7XmzCjvzlPalUxO34YxTZQqivLsEF2BrpxEGDSg5z6bdg4TpAcJR0FL+5Xpe
	 TYKPjO/6OlQDrgTi1fkZ1/QTcQt1sN03VYWQv8Z4G1fSyEZtIo4Sm9BGskWuI7q2c3
	 xh2S55gywsqdQ==
Date: Fri, 15 Dec 2023 08:03:40 +0000
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, lanhao@huawei.com, wangpeiyang1@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 net-next 3/3] net: hns3: support dump pfc frame
 statistics in tx timeout log
Message-ID: <20231215080340.GW5817@kernel.org>
References: <20231214141135.613485-1-shaojijie@huawei.com>
 <20231214141135.613485-4-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214141135.613485-4-shaojijie@huawei.com>

On Thu, Dec 14, 2023 at 10:11:35PM +0800, Jijie Shao wrote:
> Continuous pfc frames may cause tx timeout.
> Therefore, pfc frame statistics are added to logs.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Thanks,

I agree it is good to include this information, which may relate to a
timeout, in the existing log message for timeouts.

Reviewed-by: Simon Horman <horms@kernel.org>

