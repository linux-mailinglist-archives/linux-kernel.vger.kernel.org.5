Return-Path: <linux-kernel+bounces-122387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D7C88F60E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 04:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C521F27EE3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 03:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297F132C9C;
	Thu, 28 Mar 2024 03:49:50 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4871A33CA
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 03:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711597789; cv=none; b=N6KvUG8HrngkNnv+rlVE5uUfSqGC2lrUjXfYj5PBqLxo+ZK+6OlfcIv16W5vn6RcN5UESjdgSj/+cYGUx/19sav5gniCbEGz2NUfWliGivdHCMfYYu2bjSjzLTTWMMGRKY5MoAGvPozZbqNlzzY5/F7zSmt7xA0813qeGMzZgu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711597789; c=relaxed/simple;
	bh=mAUx1yEeNe+9kjQokdI6BzA8oADEU6BgtTzq3V14yns=;
	h=CC:Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=t/mCSatHzlQ6SsY57RLtRoijbRuBeE2FgerTwrruQnXYhruvWJYXJ31nqHYlw3CU6GYFQVEIIVdCP4GswAWWadmVGvONS5zRq0lPodlNwZHgjDF+eADZ30Rkd8dMxpEoB//srUe2D4W1A+jBi4mNaRGmopAyJjGmMZzKpSWBM9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4V4qHY1519zNmXF;
	Thu, 28 Mar 2024 11:47:37 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id C1DF918005C;
	Thu, 28 Mar 2024 11:49:38 +0800 (CST)
Received: from [10.67.121.177] (10.67.121.177) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 28 Mar 2024 11:49:38 +0800
CC: <yangyicong@hisilicon.com>, <linux-kernel@vger.kernel.org>,
	<alexei.starovoitov@gmail.com>
Subject: Re: [PATCH -next] tools headers: Make linux/btf_ids.h self-contained
To: Gaosheng Cui <cuigaosheng1@huawei.com>, <ast@kernel.org>, <dxu@dxuuu.xyz>,
	<andrii@kernel.org>, <ndesaulniers@google.com>, <vmalik@redhat.com>
References: <20240325011059.1001518-1-cuigaosheng1@huawei.com>
From: Yicong Yang <yangyicong@huawei.com>
Message-ID: <53c2df6c-0422-732c-02d1-e803889e8781@huawei.com>
Date: Thu, 28 Mar 2024 11:49:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240325011059.1001518-1-cuigaosheng1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemd200014.china.huawei.com (7.221.188.8)

Hi,

On 2024/3/25 9:10, Gaosheng Cui wrote:
> Add the missing #include <linux/types.h>.
> 
> Fix the following compile error:
>   In file included from main.c:73:
>   tools/include/linux/btf_ids.h:7:9: error: unknown type name ‘u32’
>     7 |         u32 cnt;
>       |         ^~~
>   tools/include/linux/btf_ids.h:8:9: error: unknown type name ‘u32’
>     8 |         u32 ids[];
>       |         ^~~
> 

I also met this on 6.9-rc1 and this patch could solve the issue.

I suspect this is introduced by 9707ac4fe2f5 ("tools/resolve_btfids: Refactor set sorting with types from btf_ids.h")?

Since we didn't contain this header before and compiling was fine, could we only include
this header in tools/bpf/resolve_btfids/main.c where error happens (tested fine)?

There's a same fix in [1] and the glibc/compiler version was blamed there. I compiled on
Ubuntu 18.04.1 with gcc 10.2.0 and glibc 2.27.

[1] https://lore.kernel.org/all/20240315091434.10622-1-dmitrii.bundin.a@gmail.com/#t

> Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
> ---
>  tools/include/linux/btf_ids.h | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
> index 72535f00572f..7969607efe0d 100644
> --- a/tools/include/linux/btf_ids.h
> +++ b/tools/include/linux/btf_ids.h
> @@ -3,6 +3,8 @@
>  #ifndef _LINUX_BTF_IDS_H
>  #define _LINUX_BTF_IDS_H
>  
> +#include <linux/types.h>
> +
>  struct btf_id_set {
>  	u32 cnt;
>  	u32 ids[];
> 

