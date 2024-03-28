Return-Path: <linux-kernel+bounces-123766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02517890D7B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 23:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5662C29DCC5
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3D513BC3C;
	Thu, 28 Mar 2024 22:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1FYqTFq4"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBE012FF95;
	Thu, 28 Mar 2024 22:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711664177; cv=none; b=DGNVL0LWXsopWDbJNkAY2MjwRRM0fLxpEhv5Gf/eRdQxtwLqz78eXsKsv2hu7FSDPrJB2A/YMvEL70BosHNZsNhPVZcCACCiKBDy5KkJk8PVoojFDC8VmSMww0mtz+sjuav5jG6me+WCeJmkfUqz1yqPbIJlaQN51s8ec0d9SbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711664177; c=relaxed/simple;
	bh=fdtZQoLZf+k6qboyWg53YmVU9ZYYXUnvEjjAvY2Zbuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0LE/RkoPvPsjPHCiztSukqrfYv4P6cA/etmEGP1mUiyFY3hl2lILSd2RZfnjwA0CnUpQZDmgjYYUEECe2suj4rF3uicfXLxb1t85XoyJQ5xoOAzn8/XOREcaqO/MMIpx2yzzjqFmSm2WW9KtUFd9ZJhQ28SQw+q1ElcPFiNQaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=1FYqTFq4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=3ilz03y73fsrB9+n9Uy1QM7lLm0rRc6zHwaEe0RJkzw=; b=1FYqTFq4DcCU2YvlnoviU4q3hR
	iN522UQydezjRLomRP9sBO6dNPuBVE2ulNe+3qTQ4Fb80kPqgwrSdMrPKOD95BOfMpmx8qiNoVtwt
	+BKJ6PTbQfRvsXsHzCaQMiWJgU2JyffRmZphRmtiyF2KZ9ZfU8k8NSCK6K/KFLT0awC0+YlBF24hT
	KBKx3WRDqAixwQWCy4EgZjzZwoD0qgMxOmHYIiaxp3LMaNc4DiS2E/DeRZMjI38aqHgFMUWSZC0JL
	DI9FGUxeyhCFUmxoQ19OzXe3LQtCHdpJUTTLAVJd5z817HIept4Zjr9eaYcF+8qRZRVMxhuG676Y0
	KqPp6Zqw==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpy2Z-0000000FtcS-3SpS;
	Thu, 28 Mar 2024 22:16:07 +0000
Message-ID: <a009a21a-56d7-4a1a-aaf9-feefa5acc561@infradead.org>
Date: Thu, 28 Mar 2024 15:16:07 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80222: Fix ieee80211_i.h kernel-doc issues
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240328-ieee80211_i-kerneldoc-v1-1-e848bdec58f3@quicinc.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240328-ieee80211_i-kerneldoc-v1-1-e848bdec58f3@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/28/24 14:08, Jeff Johnson wrote:
> kernel-doc flagged the following issues:
> 
> net/mac80211/ieee80211_i.h:146: warning: expecting prototype for enum ieee80211_corrupt_data_flags. Prototype was for enum ieee80211_bss_corrupt_data_flags instead
> net/mac80211/ieee80211_i.h:163: warning: expecting prototype for enum ieee80211_valid_data_flags. Prototype was for enum ieee80211_bss_valid_data_flags instead
> 
> Correct the documentation to match the code.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

These seem to be corrected in linux-next already.
However, I do still see this one:

ieee80211_i.h:689: warning: missing initial short description on line:
 * struct mesh_table

Thanks.

> ---
> This file is being modified by a quicinc.com patch and my review
> process flagged these pre-existing kernel-doc issues.
> ---
>  net/mac80211/ieee80211_i.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
> index def611e4e55f..458f63ce9a32 100644
> --- a/net/mac80211/ieee80211_i.h
> +++ b/net/mac80211/ieee80211_i.h
> @@ -132,7 +132,7 @@ struct ieee80211_bss {
>  };
>  
>  /**
> - * enum ieee80211_corrupt_data_flags - BSS data corruption flags
> + * enum ieee80211_bss_corrupt_data_flags - BSS data corruption flags
>   * @IEEE80211_BSS_CORRUPT_BEACON: last beacon frame received was corrupted
>   * @IEEE80211_BSS_CORRUPT_PROBE_RESP: last probe response received was corrupted
>   *
> @@ -145,7 +145,7 @@ enum ieee80211_bss_corrupt_data_flags {
>  };
>  
>  /**
> - * enum ieee80211_valid_data_flags - BSS valid data flags
> + * enum ieee80211_bss_valid_data_flags - BSS valid data flags
>   * @IEEE80211_BSS_VALID_WMM: WMM/UAPSD data was gathered from non-corrupt IE
>   * @IEEE80211_BSS_VALID_RATES: Supported rates were gathered from non-corrupt IE
>   * @IEEE80211_BSS_VALID_ERP: ERP flag was gathered from non-corrupt IE
> 
> ---
> base-commit: b68b2beadfd30907faae944358de3a17acf6fdb6
> change-id: 20240328-ieee80211_i-kerneldoc-d28d95f5c5d3
> 
> 

-- 
#Randy

