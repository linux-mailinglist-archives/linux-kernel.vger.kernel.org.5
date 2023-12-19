Return-Path: <linux-kernel+bounces-5059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 283B081861A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 12:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D35E1C23785
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 11:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5241549B;
	Tue, 19 Dec 2023 11:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCLn8Aan"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F3514F79;
	Tue, 19 Dec 2023 11:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2A6C433C7;
	Tue, 19 Dec 2023 11:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702984458;
	bh=4dslH+bYawkfXaHXPZBzbHeEjQIgy5C0S5DQUgJOamE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uCLn8AanN0AhspbNLHhFt+V5YjWqp0f9Ywobt3FpVQ+4wacdEKkm701QAi0Z4HYeC
	 8CfzMqj+K2cwGcAz6kah1fJhH5ZxOJIrAGZWL6QxFy2HnDkdJPBAOree9A1V79oH3y
	 ky4RivFiTMf6dsb7ACb57UOv27ypC8X987bOE856eR1w2+CjuN85AJGLXmC9P0/NhR
	 qs2h5hnzOJV48miDVIx3TfYgsPrX+3K5wZJMQHgM3P4X0BjRVInWcoOOr6gXW5Y9UD
	 pixpKfH2Oqis+7O/Hg8Cfgh5iLlsgjYLPNOk5bSp9xjIV/9QNjjGxZEUq32HMjUpd7
	 a1Yc0bNEI+ipQ==
Date: Tue, 19 Dec 2023 11:14:13 +0000
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, lanhao@huawei.com, wangpeiyang1@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 net-next 2/4] net: hns3: move constants from
 hclge_debugfs.h to hclge_debugfs.c
Message-ID: <20231219111413.GI811967@kernel.org>
References: <20231219013513.2589845-1-shaojijie@huawei.com>
 <20231219013513.2589845-3-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219013513.2589845-3-shaojijie@huawei.com>

On Tue, Dec 19, 2023 at 09:35:11AM +0800, Jijie Shao wrote:
> some constants are defined in hclge_debugfs.h,
> but only used in hclge_debugfs.c.
> so move them from hclge_debugfs.h to hclge_debugfs.c.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Thanks, I agree that these symbols belong in hclge_debugfs.c.

Reviewed-by: Simon Horman <horms@kernel.org>

