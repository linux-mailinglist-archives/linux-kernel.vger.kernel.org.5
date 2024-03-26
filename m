Return-Path: <linux-kernel+bounces-118887-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE72D88C0A7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 972912C442C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F124855E58;
	Tue, 26 Mar 2024 11:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uo8Pny64"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA7D548F7;
	Tue, 26 Mar 2024 11:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711452622; cv=none; b=uGGoui5Lj+ij+CtA6K2d+eETHYQ27Fp3kUvHCMxVAhC4cRQc/33TsZhsS0hMud/eoKJEaDkEvTsFH2w6YOJixEz7wawt6UkZJ4G6O/1xar+TxpGT+g2z31Xn9linq58DiXe+Ye+lM+ZUrbxs1cW8XMI7/sgvfPX9RmeP4GlZYkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711452622; c=relaxed/simple;
	bh=+QB+k9q7X2hM6H14jozXpfcuH+qkfGW+CjSA15dosBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cl8ciaNEqlJ203WKSV70CHPn9OZ1FMKvwizJRQgyNdaqZ+1I8fZGLNd4FwODRpksCJMDOKmDIg2sdEk5S48GeD6YHbUBCCsfg/y4/xy4G1Nj9oXpi981UbO/2j/Pg8iJt4t0r+ORUX42VXgm+RwHRzbfgGtcc9qtUorudbqMADY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uo8Pny64; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE7EC433C7;
	Tue, 26 Mar 2024 11:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711452621;
	bh=+QB+k9q7X2hM6H14jozXpfcuH+qkfGW+CjSA15dosBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uo8Pny64VQXHeZ5mqC4adPId0bEvhoSchLKYMZMNbcRL0uAcYlTM7DoeBCMmOONja
	 xtChP763RO3j1b/wp0DyRlrKq9hDimZOA0r+8Bx2ZqMvgw7ozmZaGjgRWoPG3QoSUN
	 48YjpKtJHV1z2Aud4c8oomshD/lL7cYQlLGT6sG/JFcdrbIozo0KJA4GwD5EGoq6Hu
	 HC10i/qZQfFP23Skln9hI5JRZc0EJx2Or6rHzHPDefSOSOyywYDGh2gqPUxWhtrD1u
	 5iCTxoyq3gsC2f38M455rC3yOIAf1grksF7f9nnB8OSGSpo3yxTk1A+Zjn7vTu97d5
	 MUNXDr4EzH0Bw==
Date: Tue, 26 Mar 2024 11:30:16 +0000
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	michal.kubiak@intel.com, rkannoth@marvell.com, jiri@resnulli.us,
	shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 net 3/3] net: hns3: mark unexcuted loopback test
 result as UNEXECUTED
Message-ID: <20240326113016.GO403975@kernel.org>
References: <20240325124311.1866197-1-shaojijie@huawei.com>
 <20240325124311.1866197-4-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325124311.1866197-4-shaojijie@huawei.com>

On Mon, Mar 25, 2024 at 08:43:11PM +0800, Jijie Shao wrote:
> From: Jian Shen <shenjian15@huawei.com>
> 
> Currently, loopback test may be skipped when resetting, but the test
> result will still show as 'PASS', because the driver doesn't set
> ETH_TEST_FL_FAILED flag. Fix it by setting the flag and
> initializating the value to UNEXECUTED.
> 
> Fixes: 4c8dab1c709c ("net: hns3: reconstruct function hns3_self_test")
> Signed-off-by: Jian Shen <shenjian15@huawei.com>
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>
> Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


