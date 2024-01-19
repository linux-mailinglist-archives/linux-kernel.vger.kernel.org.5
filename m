Return-Path: <linux-kernel+bounces-30812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 05576832491
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B5B1F232EC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 06:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6B8BA49;
	Fri, 19 Jan 2024 06:25:44 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A05446AD;
	Fri, 19 Jan 2024 06:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705645544; cv=none; b=mnJXHDZnGYz+dQg5dApuVN8oGynwng2wnnaJstw2/zBaGtIOs5z/hfv2MczL0MJNy2E9p39XAtbbfShh3peTos0I1eXYUcLsBio6I4DMfyaI42wlPpT9jhbUqtUrr86Jxzl5JdrGTBe+/cKWlJQtx6tfB1igry4JxNw9Mgj/bFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705645544; c=relaxed/simple;
	bh=n0oMA9jH4bRR+Suw+AoQHKhq/uuTjcrp9SZ23w69f1c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:CC:References:
	 In-Reply-To:Content-Type; b=sV/kYDYeDjU1l9G8V0B1BclnQYjeP/Uz4KxRcQSMCFDnpAKDH6C+fbqqlbV8qp15AX3ivPFPPWpJefsL3EUqPPmbYiJp8xUMI9gt/ikcnRYrjpdJRlTYwddkkYcXgQqwgYIHgNvqx2bvRL0LevSW97Eqiac6vS4Cb/wVjJcOm3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TGV3B1sCqzGpvx;
	Fri, 19 Jan 2024 14:25:10 +0800 (CST)
Received: from dggpeml500001.china.huawei.com (unknown [7.185.36.227])
	by mail.maildlp.com (Postfix) with ESMTPS id E69E7140153;
	Fri, 19 Jan 2024 14:25:30 +0800 (CST)
Received: from [10.67.121.42] (10.67.121.42) by dggpeml500001.china.huawei.com
 (7.185.36.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 19 Jan
 2024 14:25:30 +0800
Message-ID: <770ebd0a-6b79-4dab-bd9e-3defd712b74f@huawei.com>
Date: Fri, 19 Jan 2024 14:25:30 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] some updates and cleanups for hisilicon/sec2.
From: taoqi <taoqi10@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<liulongfang@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
References: <20231229064421.16981-1-taoqi10@huawei.com>
In-Reply-To: <20231229064421.16981-1-taoqi10@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500001.china.huawei.com (7.185.36.227)

On 2023/12/29 14:44, Qi Tao wrote:
> This seires patch mainly add some RAS registers to enhance the
> DFX positioning function and fix some cleanup issues.
> 
> Qi Tao (3):
>    crypto: hisilicon/sec2 - updates the sec DFX function register
>    crypto: hisilicon/sec2 - modify nested macro call
>    crypto: hisilicon/sec2 - fix some cleanup issues
> 
> Wenkai Lin (1):
>    crypto: hisilicon/sec - remove unused parameter
> 
>   drivers/crypto/hisilicon/sec2/sec_crypto.c | 33 ++++++++--------------
>   drivers/crypto/hisilicon/sec2/sec_main.c   |  5 ++++
>   2 files changed, 17 insertions(+), 21 deletions(-)
> 

I want to follow up on the patch I submitted three weeks ago.
please let me know if there is anything I can do to help move this 
process forward.

Thanks，
Qi Tao

