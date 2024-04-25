Return-Path: <linux-kernel+bounces-158067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EA68B1AF7
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95861C216D6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84A684207A;
	Thu, 25 Apr 2024 06:25:30 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 511D741ABE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 06:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714026330; cv=none; b=hshuLFvgcFN1xRIZGYnUoui7ljJCSUFhPw/82seiN/5cx47I3JAvNFgccukxOyrV+9ssUTPgafKw+rFEZAoZntqoNcZLOSm1hCq3nabEUm4GPVSA7K19j3gChlh+EOBNy3ou8VibznEZcDfKeYW/efcEmiKi0r+xcPOfsmlgJno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714026330; c=relaxed/simple;
	bh=4DZjzfBRD8HVDZocHYyjAp46K3km4g7ourZSmI0J2N4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ikdUzKxc4LZvcJ/q9eWKnnqgOLnAKOzR3PsPQ0IgalFWJJuqn9r6rhW/41Esbft4dK+FGXRG8fwbgI1T+1yAwSe7/zCQREiYAOAUSK0hT2DJT+Xachx/TyM9kJ8DFWlgTmKXd1gb4xYOsWq00eQmOzC4JomO9OOZUbynRv0O44Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VQ5P16LyYzwSLJ;
	Thu, 25 Apr 2024 14:22:13 +0800 (CST)
Received: from canpemm500002.china.huawei.com (unknown [7.192.104.244])
	by mail.maildlp.com (Postfix) with ESMTPS id 8F9BE140258;
	Thu, 25 Apr 2024 14:25:25 +0800 (CST)
Received: from [10.173.135.154] (10.173.135.154) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 25 Apr 2024 14:25:25 +0800
Subject: Re: [PATCH v2 1/1] mm: page_alloc: Avoid defining unused function
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Rasmus Villemoes <linux@rasmusvillemoes.dk>, Andrew Morton
	<akpm@linux-foundation.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>
References: <20240423161506.2637177-1-andriy.shevchenko@linux.intel.com>
From: Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <68489f85-5579-5cff-eed1-55ae585916f3@huawei.com>
Date: Thu, 25 Apr 2024 14:25:24 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240423161506.2637177-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)

On 2024/4/24 0:14, Andy Shevchenko wrote:
> In some configurations I got
> mm/page_alloc.c:656:20: warning: unused function 'add_to_free_list' [-Wunused-function]
> Becuase the only user is guarged with a certain ifdeffery,

guarged? ifdeffery?

> do the same for add_to_free_list().

A Fixes tag might be needed.

> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Anyway, this patch looks good to me. Thanks.

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Thanks.
.

