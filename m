Return-Path: <linux-kernel+bounces-31815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF87B833508
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 15:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8956D1F22333
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 14:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28BAFC0C;
	Sat, 20 Jan 2024 14:34:21 +0000 (UTC)
Received: from mail-m17223.xmail.ntesmail.com (mail-m17223.xmail.ntesmail.com [45.195.17.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744A3101FB;
	Sat, 20 Jan 2024 14:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.17.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705761261; cv=none; b=mB5QVslfzWuLBySYRWbF0sFRyZH8wjBjRgPG7Omrp5wODuUCE2yrxOWSpSplgUeRI/Agk0Xl+/VD0/U+SwLEs0MlGwkeEStcRatTFH9ZgpAlvNkkLH2VG9np6oj0Ss7x+/vK4whu6x8zQC36my/KuqZL1Of7MEW2d61ycW5DcjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705761261; c=relaxed/simple;
	bh=4URthSY15sK7lJQCcSoPDUQBFNGS3hbY/fKmxox0XI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fHyF/p+dhpwQV1Y/8z9VXf0WdUv/Vfz40i6FWFVWPRXD2MQIGlHUdVK+WEUNQrAZ5g54SqcjVucDyY/aYezc5K125YjLms65uJTDpWlG6xivU7pdHin2v4wh6XnvRW9bgURqOTGqBJSXFOsAeakqMa4WR2y2j7EqaatVDV0WV70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=link.tyut.edu.cn; spf=pass smtp.mailfrom=link.tyut.edu.cn; arc=none smtp.client-ip=45.195.17.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=link.tyut.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=link.tyut.edu.cn
Received: from [IPV6:2409:8a0c:267:1bc0:8491:d680:3103:8d17] (unknown [IPV6:2409:8a0c:267:1bc0:8491:d680:3103:8d17])
	by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 2914A800084;
	Sat, 20 Jan 2024 22:24:43 +0800 (CST)
Message-ID: <a567932c-d878-44e5-836f-90fa15999ba6@link.tyut.edu.cn>
Date: Sat, 20 Jan 2024 22:24:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/zh_CN/power: Use kcalloc() instead of kzalloc()
To: Erick Archer <erick.archer@gmx.com>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20240120122204.4287-1-erick.archer@gmx.com>
From: Hu Haowen <2023002089@link.tyut.edu.cn>
In-Reply-To: <20240120122204.4287-1-erick.archer@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlCTBpKVkNCQx0eTx4dQklKSVUTARMWGhIXJBQOD1
	lXWRgSC1lBWUlPS0JBQxpLGEFJTUxBShkYS0FDT0JKQR9NQ0tBSEpLSEFDH0pMWVdZFhoPEhUdFF
	lBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Tid: 0a8d274275c5b03akuuu2914a800084
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PSI6Fgw4NjweEAoeEk8OGRws
	NDpPCgNVSlVKTEtOTE1LTUNPS0lDVTMWGhIXVUlLSUhLS0lLQ0I7FxIVEFUPAg4PVR4fDlUYFUVZ
	V1kSC1lBWUlPS0JBQxpLGEFJTUxBShkYS0FDT0JKQR9NQ0tBSEpLSEFDH0pMWVdZCAFZQU9LSEo3
	Bg++


在 2024/1/20 20:22, Erick Archer 写道:
> As noted in the "Deprecated Interfaces, Language Features, Attributes,
> and Conventions" documentation [1], size calculations (especially
> multiplication) should not be performed in memory allocator (or similar)
> function arguments due to the risk of them overflowing. This could lead
> to values wrapping around and a smaller allocation being made than the
> caller was expecting. Using those allocations could lead to linear
> overflows of heap memory and other misbehaviors.
>
> So, in the example code use the purpose specific kcalloc() function
> instead of the argument size * count in the kzalloc() function.
>
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>
> ---
>   Documentation/translations/zh_CN/power/opp.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/translations/zh_CN/power/opp.rst b/Documentation/translations/zh_CN/power/opp.rst
> index 8d6e3f6f6202..7470fa2d4c43 100644
> --- a/Documentation/translations/zh_CN/power/opp.rst
> +++ b/Documentation/translations/zh_CN/power/opp.rst
> @@ -274,7 +274,7 @@ dev_pm_opp_get_opp_count
>   	 {
>   		/* 做一些事情 */
>   		num_available = dev_pm_opp_get_opp_count(dev);
> -		speeds = kzalloc(sizeof(u32) * num_available, GFP_KERNEL);
> +		speeds = kcalloc(num_available, sizeof(u32), GFP_KERNEL);


If the translated version is modified, I think the original file should
follow as well at Documentation/power/opp.rst line 308:

diff --git a/Documentation/power/opp.rst b/Documentation/power/opp.rst
index a7c03c470980..dca35018214a 100644
--- a/Documentation/power/opp.rst
+++ b/Documentation/power/opp.rst
@@ -305,7 +305,7 @@ dev_pm_opp_get_opp_count
          {
                 /* Do things */
                 num_available = dev_pm_opp_get_opp_count(dev);
-               speeds = kzalloc(sizeof(u32) * num_available, GFP_KERNEL);
+               speeds = kcalloc(sizeof(u32) * num_available, GFP_KERNEL);
                 /* populate the table in increasing order */
                 freq = 0;
                 while (!IS_ERR(opp = dev_pm_opp_find_freq_ceil(dev, 
&freq))) {

Thanks,
Hu Haowen


>   		/* 按升序填充表 */
>   		freq = 0;
>   		while (!IS_ERR(opp = dev_pm_opp_find_freq_ceil(dev, &freq))) {
> --
> 2.25.1
>
>
>

