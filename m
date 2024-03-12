Return-Path: <linux-kernel+bounces-99817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F419878DD8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 05:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33FA51F21EC1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 04:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3045DBE6F;
	Tue, 12 Mar 2024 04:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LrEYiI7a"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747B8BA39;
	Tue, 12 Mar 2024 04:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710217793; cv=none; b=QNtVnOi7jxmFPQdOvBjscfmgEGgPILmEAv/XiSd60iOKhSQ7LAqEZF7vVlqvHJHdbERIRvNRklXkecFp4yMimBS0yh1fiQUWgv3G4sE8Qlg8lKcSuSwhHFzZFOYuMF5zQkfWCcQ0MpXYuMPd3T9Mg2nxfR7FS7CgKyeyAtgiTmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710217793; c=relaxed/simple;
	bh=AxGmfUk93j0r9GrCAFh2R0FX+9kE5tYC1/l1zMpnn2w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KVRhDe9bVRK/1oy+qbA8vjLiMLLNeL+IbemTw8AE8aOmfbVUFBFCcW8yomgJQpEQJIzx9IeteosP/1j5NyvVv5/4GSAxu9/Ghu1HjIcw4PkujaXHtaGW/RBKip/vlLwTAo2aUq+XqptIWzvbeVHh+2PPVYRcHNnLwmIdzQwrNDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LrEYiI7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8B6C433F1;
	Tue, 12 Mar 2024 04:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710217793;
	bh=AxGmfUk93j0r9GrCAFh2R0FX+9kE5tYC1/l1zMpnn2w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LrEYiI7aXGX2LbBiDjEaosojCJ2v3qRGWf99o3oMK1Gp6TFjrNWTX8LuOJb0dE8l6
	 Pf9JxFjFTIXBLrxVJWwVAnCmk57ZaeStwyLZ09P6nDSIZUhFqBJzRnz5YbJatbDzxd
	 9A8JqNTnkfnWGuHPW9D8w/eMpW9HAjutfMog7LkmJyhy8pAbb5+LQLWGbmFEX/okS1
	 eCgCStyMWS7YYY4EfeF0Tua2hClwCZPZjiuB76AiVXikmKu8K6fy4OaIqydVV3O1f6
	 dGJd9bEVM+iWiKXWzJtF0pGO+81oZ/8xexAVc0kNNUvxBgBvod7k+AW0Uzl5cuB2Gz
	 ItXcNt6ZZiEBQ==
Date: Mon, 11 Mar 2024 21:29:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
 <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <jiri@resnulli.us>, <shenjian15@huawei.com>, <wangjie125@huawei.com>,
 <liuyonglong@huawei.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 net-next 0/4] Support some features for the HNS3
 ethernet driver
Message-ID: <20240311212951.6b877b58@kernel.org>
In-Reply-To: <20240309100044.2351166-1-shaojijie@huawei.com>
References: <20240309100044.2351166-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 9 Mar 2024 18:00:40 +0800 Jijie Shao wrote:
> Currently, the hns3 driver does not have the trace
> of the command queue. As a result, it is difficult to
> locate the communication between the driver and firmware.
> Therefore, the trace function of the command queue is
> added in this patch set to facilitate the locating of
> communication problems between the driver and firmware.
> 
> If a RAS occurs, the driver will automatically reset to attempt
> to recover the RAS. Therefore, to locate the cause of the RAS,
> it is necessary to save the values of some RAS-related dfx
> registers before the reset. So we added a patch in
> this patch set to print these information.

## Form letter - net-next-closed

The merge window for v6.9 has begun and we have already posted our pull
request. Therefore net-next is closed for new drivers, features, code
refactoring and optimizations. We are currently accepting bug fixes only.

Please repost when net-next reopens after March 25th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer

