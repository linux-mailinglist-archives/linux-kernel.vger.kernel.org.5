Return-Path: <linux-kernel+bounces-161285-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 564588B4A1C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 08:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05C55281F92
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 06:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79EB3FBAF;
	Sun, 28 Apr 2024 06:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+lPl8TV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1AEF516
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 06:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714285394; cv=none; b=nLDyJAB6LFzgWWlJD6mD0MbcR+bE8iMpA6IbDOPOwpilOUNEfEq/0Cf2p/0kK059yKMhisc0UZnrW8Ty/cKHybaw/CWwYXhNptxSctPJZY9dU+DmD1ZCUWXdAQKo4BrD3IGswEgin6/EwpIXE68aZHVsSk4O4HK0xXGqZYEB8YE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714285394; c=relaxed/simple;
	bh=m0OqPdtIXueXfol5rrnW7lUXAvbrctuBw6kVnWMpc9s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xji7nsZtmhb9zTWO3irtQaRpN5ijOK08Bt5pyoeT21NH2XskV5t1NajjIvw1BR4GnyPxy2M4x4BI2+pwpNaslwCyOjUbClK0b6iOa+8iIVIUASaCYjaL2VcNcXjPIwLzJGe4WBlRwgsmrq4uazFeSDA9rNrz81WAOw0gNyLUSlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+lPl8TV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95446C113CC;
	Sun, 28 Apr 2024 06:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714285393;
	bh=m0OqPdtIXueXfol5rrnW7lUXAvbrctuBw6kVnWMpc9s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D+lPl8TVSA8tUf/yOBrFcL/BD/PZJ9JIToOeaF+aLpdL76femwaggUwA8HEI9KYlB
	 r8Y+RhhZuZqgTY9FtH048kRavnTRFEKtJkop6rmHwJROpwEYDunI8w7Eos8OYkWO2p
	 iriNXHN+QQLtBXagTNqmqbzThHLNd5kOiUyR/bAS1mdVJbNQdvVsNBfOK7Rl38DNGq
	 Zio/olmDsdfpzanVtPJYw6j/b5B9Cr6aQihwoXM1BODE73SuvitBvbOlFzh8Lpou+/
	 CqkYtcyub2V5y8lIubq7/ev/aKZUVQi9GMAdu64zuBpChEbzh1DFURDffADVlljLzK
	 orwuSU7HgCFRA==
Message-ID: <e8b33c6d-2d9c-461d-ae47-bbd74d7f203b@kernel.org>
Date: Sun, 28 Apr 2024 14:23:08 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] erofs: modify the error message when
 prepare_ondemand_read failed
To: Hongbo Li <lihongbo22@huawei.com>, xiang@kernel.org
Cc: huyue2@coolpad.com, jefflexu@linux.alibaba.com, dhavale@google.com,
 linux-erofs@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <20240424084247.759432-1-lihongbo22@huawei.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240424084247.759432-1-lihongbo22@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2024/4/24 16:42, Hongbo Li wrote:
> When prepare_ondemand_read failed, wrong error message is printed.
> The prepare_read is also implemented in cachefiles, so we amend it.
> 
> Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Hongbo Li <lihongbo22@huawei.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

