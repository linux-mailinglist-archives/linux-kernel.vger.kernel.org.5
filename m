Return-Path: <linux-kernel+bounces-34152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A050C83748C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:51:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5136928715D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C545747A70;
	Mon, 22 Jan 2024 20:50:53 +0000 (UTC)
Received: from mail-m17207.xmail.ntesmail.com (mail-m17207.xmail.ntesmail.com [45.195.17.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BED3D3A7;
	Mon, 22 Jan 2024 20:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.17.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956653; cv=none; b=gya9l4RRfZ00NaEavug8WjTpzCSa8hYYebPide7mqTWrOSxictC7EpTnzr6PxykK0IuWwfTaz8+9J/+vf4i5QJFTISm/6aOsE2RYp2rIlp03Wjz1AvhyHBUQBBSbOUi1ePr3xTBGUod1meZH7230uTTC1Twv08u+BerhPjkDLx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956653; c=relaxed/simple;
	bh=iKziXW5nSbJLL99tAPoPAh//iFGA+h98wNVjisnajQ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dl9GIyy5hiovh0IHBjuJx2JB8BpCj/ahoLGtbq/2qrifQKQUKHHTFN2Fh5xw+AF/iNp3ohHPkepf5wgIjGn9RL6NDR66eoiLeemgxkgQ7Sv9h0ZntLSKV8HGshxsZU76Hlm0IJgp0dE75CDGCgE8QxSXGuAwDDMn2RIkF4mTUtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=link.tyut.edu.cn; spf=pass smtp.mailfrom=link.tyut.edu.cn; arc=none smtp.client-ip=45.195.17.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=link.tyut.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=link.tyut.edu.cn
Received: from [192.168.2.76] (unknown [113.251.4.85])
	by mail-m121145.qiye.163.com (Hmail) with ESMTPA id 3AD9F80010E;
	Tue, 23 Jan 2024 01:11:59 +0800 (CST)
Message-ID: <b8823223-e735-4d5a-b90e-6e2f2a6cd104@link.tyut.edu.cn>
Date: Tue, 23 Jan 2024 01:11:58 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Documentation: power: Use kcalloc() instead of
 kzalloc()
Content-Language: en-US
To: Erick Archer <erick.archer@gmx.com>, Viresh Kumar <vireshk@kernel.org>,
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <len.brown@intel.com>,
 Pavel Machek <pavel@ucw.cz>, Alex Shi <alexs@kernel.org>,
 Yanteng Si <siyanteng@loongson.cn>, Jonathan Corbet <corbet@lwn.net>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20240121104344.5001-1-erick.archer@gmx.com>
From: Hu Haowen <2023002089@link.tyut.edu.cn>
In-Reply-To: <20240121104344.5001-1-erick.archer@gmx.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZS0pPVkhOTBkeTEoYGh5CSlUTARMWGhIXJBQOD1
	lXWRgSC1lBWUpKSFVJTkpVT1VDTllXWRYaDxIVHRRZQVlPS0hVSkpLSEpDVUpLS1VLWQY+
X-HM-Tid: 0a8d32285244b03akuuu3ad9f80010e
X-HM-MType: 10
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6N0k6Eww*EDwZPg4yAU4JUS0R
	Tg8KCzFVSlVKTEtOQk9ITklLSENLVTMWGhIXVUlLSUhLS0lLQ0I7FxIVEFUPAg4PVR4fDlUYFUVZ
	V1kSC1lBWUpKSFVJTkpVT1VDTllXWQgBWUFPQkhINwY+


在 2024/1/21 18:43, Erick Archer 写道:
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
> At the same time, modify the translations accordingly.
>
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [1]
> Link: https://github.com/KSPP/linux/issues/162
> Signed-off-by: Erick Archer <erick.archer@gmx.com>
> ---
> Hi,
>
> This patch is a merger of two previous ones [1] [2].
> As Hu Haowen and Jonathan Corbet suggested, the translation change
> only makes sense if the original file is modified. So, with this
> v2 version the original file and the translations are modified at
> the same time.
>
> [1] https://lore.kernel.org/linux-hardening/20240120120527.3866-1-erick.archer@gmx.com/
> [2] https://lore.kernel.org/linux-hardening/20240120122204.4287-1-erick.archer@gmx.com/
>
> Thanks,
> Erick
> ---
>   Documentation/power/opp.rst                    | 2 +-
>   Documentation/translations/zh_CN/power/opp.rst | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/power/opp.rst b/Documentation/power/opp.rst
> index a7c03c470980..1b7f1d854f14 100644
> --- a/Documentation/power/opp.rst
> +++ b/Documentation/power/opp.rst
> @@ -305,7 +305,7 @@ dev_pm_opp_get_opp_count
>   	 {
>   		/* Do things */
>   		num_available = dev_pm_opp_get_opp_count(dev);
> -		speeds = kzalloc(sizeof(u32) * num_available, GFP_KERNEL);
> +		speeds = kcalloc(num_available, sizeof(u32), GFP_KERNEL);
>   		/* populate the table in increasing order */
>   		freq = 0;
>   		while (!IS_ERR(opp = dev_pm_opp_find_freq_ceil(dev, &freq))) {
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


For the zh_CN translation,

Reviewed-by: Hu Haowen <2023002089@link.tyut.edu.cn>


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

