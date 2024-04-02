Return-Path: <linux-kernel+bounces-127346-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AB27D894A1F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 05:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BCB2B24266
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 03:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C145C17BA2;
	Tue,  2 Apr 2024 03:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeoTVboq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B98168B1;
	Tue,  2 Apr 2024 03:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712029177; cv=none; b=BoC4f+tnemD8WawLufzBV9rRjEJq+9H8Pw+sdenJFzc2xPFpl65yj56FKSkDLMDTfqeWiiECMC3B7G8/oxTzYPuNJoUBm60Z4zC9dckm1ncrLI7uQtNf1qRPy7WuGRPgXqFLHIeCxDa7UEBvLCZ1bLVxMlE/YkADXHt6bzVqRyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712029177; c=relaxed/simple;
	bh=AhZFt650FjHiZiK7t3kloCcpXnANwBg3DLM9eGPOABI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bPhJVrYqlob9DYoWDItRVizHhO6+30e2JhJdlnTHsM2VdOChFsS3GxSGIoon3wL5NQNoIMaSzVh3xhtjLoxaNzbbnyMJJl/KsDTsPalgYS3FNuvACDtPz7M+r6+NcYbY5++WQHEtIc1M8UE5fcfMTlc4vmyS5uxtuCRa6fFQNlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeoTVboq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2407C433C7;
	Tue,  2 Apr 2024 03:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712029176;
	bh=AhZFt650FjHiZiK7t3kloCcpXnANwBg3DLM9eGPOABI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NeoTVboq0hrFXwwVfLw3RBjVGzAbH9+N67EkM03olDz3wrXwUCVdx0BO07Z6dme+X
	 73bDSlintCyyBuIHxfHB5/TatZTUQM68vZQdvBky2R/3qjfouMzSdGraQCge2N/25o
	 0bY9rf4kLN+Xqu7zFNNMXFfN1Fqs5PTaYQLFT5ZnMbF6jo/P3gq1hc4cr3kLtLKu9j
	 eKFJnZMxzGV7Xx+hDIeXa2nUSWg4z4iF2GxOkyWKik0b7rq3otb1tmk8POSoh242Ac
	 ynKsJsF/vH6pZLmh/jwJw93m3xYLoKAe5NpfFmx56mxjk+Nt9+TAFaStVWZKZZrJmB
	 M1sGPBm2mw9Lg==
Date: Mon, 1 Apr 2024 20:39:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <jiri@resnulli.us>, <horms@kernel.org>, <rkannoth@marvell.com>,
 <shenjian15@huawei.com>, <wangjie125@huawei.com>, <liuyonglong@huawei.com>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V6 net-next 3/4] net: hns3: dump more reg info based on
 ras mod
Message-ID: <20240401203935.58be6396@kernel.org>
In-Reply-To: <b679e900-22e3-47c6-b9bb-7aba56efcf31@huawei.com>
References: <20240327114330.1826631-1-shaojijie@huawei.com>
	<20240327114330.1826631-4-shaojijie@huawei.com>
	<20240328191130.47242c8f@kernel.org>
	<d6c779a5-e4b1-4f21-b4f0-6b37b212890f@huawei.com>
	<20240329081501.4460ad4d@kernel.org>
	<b679e900-22e3-47c6-b9bb-7aba56efcf31@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 30 Mar 2024 10:35:51 +0800 Jijie Shao wrote:
> >> Generally, driver will reset to restore the normal state.
> >> After the reset, many registers are cleared. Therefore,
> >> it is difficult to analyze the reason of RAS.  
> > Perhaps I'm missing the significance of the reset when it comes
> > to counters reported via standard APIs. Are rtnl_link_stats64
> > going to behave differently across a reset than these debug entries?
> >  
> 1. These statistics are the same as rtnl_link_stats64. However, these are not updated in real time.
>     They are updated only when users query them or driver updates them every 5 minutes.
>     However, these are cleared after the reset, which makes debugging difficult.

This explanation is a bit hard to understand because you use 'these'
and 'they', and I'm not sure whether you're referring to rtnl stats
or the debugfs stats :S Please make the commit description more clear
when reposting.

> 2. Currently, only a few MIB statistics are required, not all.
> 3. Are you suggesting that we use rtnl_link_stats64 to provide MIB statistics?

Reporting via the standard APIs is the first step. You report pause
stats here, for instance, but do not implement
ethtool_ops::get_pause_stats.

If the semantics of the debugfs stats are useful for debug that's
fine. But (1) support the standard APIs first, (2) clearly describe
how the debugfs ones differ.

