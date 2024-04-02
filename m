Return-Path: <linux-kernel+bounces-128811-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF152895FDE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 00:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FB2D1F2431C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 22:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B8C38DFC;
	Tue,  2 Apr 2024 22:58:26 +0000 (UTC)
Received: from rockwork.org (rockwork.org [45.32.92.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20078208B6;
	Tue,  2 Apr 2024 22:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.32.92.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712098706; cv=none; b=i3gFXd8uel4hQfxfhJuhNxFl78OjWkubqSsCm0yGxU0FXsGcmy/404KHPBpm5RZaQuHhz5dnwwWi9bH8DnRI0+2Z3uTYNwED7bDJyC9D86Yix88wRCUb4ZZSuJnQVZKD4FVxE4+VUZie00AlQZAsO0fpRqRhTjEe9BQQyzWyit4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712098706; c=relaxed/simple;
	bh=78EsPwp8HmxyHLnUJ1YI+dld/1JCGKo579CD//N9rJ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K6Ff0X5i5s4ia6F0BcwilYQqbIwTdgu7Fj9xhLz1qA8YnbkFi/FgLqpKOQIzddHtR1mXvnxKRqgS0ffawci+ctwPz98kX5F/uTMM3d3YRZC8WW5vtmV5NLa5fXkSrhkx5aPi8n6BWCAzKbW7f90Kv+5GFgSiMc30UeV7zj+FaqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rockwork.org; spf=pass smtp.mailfrom=rockwork.org; arc=none smtp.client-ip=45.32.92.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rockwork.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rockwork.org
Received: from [IPV6:2408:8340:c40:3f70:429c:5146:4b05:d866] (unknown [IPv6:2408:8340:c40:3f70:429c:5146:4b05:d866])
	by rockwork.org (Postfix) with ESMTPSA id 56B335B42B;
	Tue,  2 Apr 2024 22:58:16 +0000 (UTC)
Message-ID: <d6d188a3-5604-4848-8b45-a7aff2535611@rockwork.org>
Date: Wed, 3 Apr 2024 06:58:13 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/zh_CN: core-api: Update translation of workqueue.rst
 to 6.9-rc1
To: Yanteng Si <siyanteng@loongson.cn>, alexs@kernel.org, corbet@lwn.net
Cc: zhoubinbin@loongson.cn, tj@kernel.org, wangjinchao@xfusion.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240331172116.257780-1-rockrush@rockwork.org>
 <2932e9f7-5d5f-4331-8043-7aa85e9044a4@loongson.cn>
Content-Language: en-US
From: Xingyou Chen <rockrush@rockwork.org>
In-Reply-To: <2932e9f7-5d5f-4331-8043-7aa85e9044a4@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/2/24 19:47, Yanteng Si wrote:
> Hi xingyou,
> 
> 在 2024/4/1 01:21, Xingyou Chen 写道:
>> Significant changes have been made to workqueue, and there are staging
>> works transferring from tasklet, while the current translation doesn't
>> include description around WQ_BH, an update seems to be helpful.
>>
>> Synchronize translation from upstream commit 3bc1e711c26b
>> ("workqueue: Don't implicitly make UNBOUND workqueues w/ 
>> @max_active==1 ordered")
> It seems that you cannot pass the build test. You need to find a way to 
> silence these warnings
There are some "Title underline too short" warnings, I'll send an 
updated one.
> 
> 
> /home/siyanteng/doc/linux/Documentation/core-api/workqueue:776: 
> ./include/linux/workqueue.h:493: WARNING: Inline literal start-string 
> without end-string
It's "%WQ_*" in workqueue.h, and didn't found note on this labeling rule 
after quick search, I'll do an in depth reading around reStructuredText 
and Sphinx. We may simply remove "%" here, or protect asterisk as "%WQ_\*".
> 
> ...
> 
> 
> You need to follow the steps below:
> 
> $ ./scripts/sphinx-pre-install
> 
>       install them.
> 
> $ make cleandocs
> 
> $ make htmldocs
> 
>      silence warnings
> 
> 
> 
> Thanks,
> 
> Yanteng
> 


