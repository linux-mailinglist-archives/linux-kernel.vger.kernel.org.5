Return-Path: <linux-kernel+bounces-161295-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DB6C8B4A59
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 09:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65FE61C20E2A
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 07:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369B24F8B1;
	Sun, 28 Apr 2024 07:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="vq3r65ry"
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98234E1C9
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 07:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714288234; cv=none; b=uSOaIp8mrP1PE3O8Zr7992OkhGuXQyIgFEZcfQMQxKDYmqkw7SKglUinzaPh9FZIkNFhRuMb9IJnShMxvhIm1YLFZmHR/Y4Ke9YKwMVNK+dqotr+0bZlTgnEhs/hibpSr7V3SsQiYulAaD7se01SG5oNnVW+oPEA8EGZdAFi6Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714288234; c=relaxed/simple;
	bh=CaPunSDq6gT4YNN+csrFn06xHWYnhTHm4ajhXQhYrcE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxHUdHBYme/+mUFkh8CmV8qN58hYNL0e2mHJ46iC6fSOQp1Ast8zPQE04NBtWvTGtTGXUkcuqOc2ovVVuRVWyK/PWmewUSk/XGvbXILDa0VFWaZXTu9gARvfKcVVgHWrgKkHiIp6zmoYZc+IieSe8ssvRCvC+LmQ2NNrbaGb9OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=vq3r65ry; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1714288224; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Sn2mnwAKlmzl6ZnCC0H7AzHnFBhpM/ri2hKnjQ/BtIU=;
	b=vq3r65rywdZC45zvFZ50WOo0PlDnt4tbREtWjoCze9foATZSNmF/kNmF7PnKK71QNIrjf0n7XwdnwcyllNyKbfoKHf29gOZjvdxfNWoKvsOwJo16Vc0Q+KHCArYs1fIN18WxUDQYMZBn9bDz0/vTjxDFkMpnQEyo86FO4QXf42A=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R321e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0W5Nfk3K_1714288221;
Received: from 30.221.129.62(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0W5Nfk3K_1714288221)
          by smtp.aliyun-inc.com;
          Sun, 28 Apr 2024 15:10:23 +0800
Message-ID: <398251ef-6fb1-4c47-a7c7-2035e24fa9a2@linux.alibaba.com>
Date: Sun, 28 Apr 2024 15:10:21 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v3 1/2] erofs: get rid of erofs_fs_context
To: Baokun Li <libaokun1@huawei.com>, linux-erofs@lists.ozlabs.org
Cc: xiang@kernel.org, chao@kernel.org, huyue2@coolpad.com,
 jefflexu@linux.alibaba.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
 linux-kernel@vger.kernel.org, yangerkun@huawei.com, houtao1@huawei.com
References: <20240419123611.947084-1-libaokun1@huawei.com>
 <20240419123611.947084-2-libaokun1@huawei.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <20240419123611.947084-2-libaokun1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2024/4/19 20:36, Baokun Li wrote:
> Instead of allocating the erofs_sb_info in fill_super() allocate it during
> erofs_init_fs_context() and ensure that erofs can always have the info
> available during erofs_kill_sb(). After this erofs_fs_context is no longer
> needed, replace ctx with sbi, no functional changes.
> 
> Suggested-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Reviewed-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Thanks,
Gao Xiang

