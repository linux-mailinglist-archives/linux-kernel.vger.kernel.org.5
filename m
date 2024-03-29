Return-Path: <linux-kernel+bounces-124175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D33891368
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 90856B221F2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 05:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AD7A3DBA8;
	Fri, 29 Mar 2024 05:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="honVczlA"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4223E46D;
	Fri, 29 Mar 2024 05:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711691373; cv=none; b=VR6idHba6j84Qot7rR3Z1HqSMCBbX2pBNtP+RgWQuaJ2vVCdqxG/OQTHbu2ngX4ctVzjPpUGNY0hAdEjKaHrsNPM/9U00RFYoBDOPMCUD9G351O8IdigQ7PVJyvqbcELf1BOM9IoKpRO4kKCDDclwSA/ZD5mu9cQ/CWrCr1l3os=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711691373; c=relaxed/simple;
	bh=yMbuELm9c4KTYXgaH+maFdTfiwl79tFNix4zNoQ9N6w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gL0D2sMh+tFLGb1ZUlgRhKQ9G6JkRlfGKxl+LlnEjlCXFV+OprgANSfr33+0YnjL6n2/JoHu19H+ppqDuDiOjMzwAb84ZYXbGvh1k6hNWMiqOH3eO/USUO1mQZg2g9C9rLOUWDa7u/KIQZV1DYCVoGLirN1pVkHXNnKaEFJKDOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=honVczlA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=ior5B9jfDqtYQr4/5QANLVGoF4OjfEXWnrLCWIx/V8o=; b=honVczlApgtYSvKSPLmbaGwDy7
	fC/2T3b0jYg3uMVDV/32Ri9GpbZAQQHk4uc69Eym8C0pgmoqWZ78bXFRJMXnNupFsWIixfRvi5GI0
	xISLzXw3ypPdgMQxQ7mapAQiOyq30s1fVI78ppzHp2kvDPmf+Th9TqNZmDWIM2k9ge3blneFH+vG/
	T12mkXY0OF3EWHnivDKZsH0nrVTVa69OdmaZMMtXQOLKFIBR5NNs9alQnK/toxgGsb6GhQls651wz
	il8dW2b7wtELL81JZChjXc3oxj4oSyhBUpGgX6ZKW4bhJ1a0PX2D41PcfotAI+NHurNjkdfd9vDyT
	8F9s1nuA==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rq57F-0000000GwnC-04kF;
	Fri, 29 Mar 2024 05:49:25 +0000
Message-ID: <0529dba9-84c9-43d0-8a93-acea3ced6654@infradead.org>
Date: Thu, 28 Mar 2024 22:49:22 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: correctly document struct mesh_table
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240328-mesh_table-kerneldoc-v1-1-174c4df341b1@quicinc.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240328-mesh_table-kerneldoc-v1-1-174c4df341b1@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/28/24 22:44, Jeff Johnson wrote:
> Currently kernel-doc -Wall reports:
> 
> net/mac80211/ieee80211_i.h:687: warning: missing initial short description on line:
>  * struct mesh_table
> 
> So add a short description.
> 
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Link: https://lore.kernel.org/linux-wireless/a009a21a-56d7-4a1a-aaf9-feefa5acc561@infradead.org/
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  net/mac80211/ieee80211_i.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
> index bd507d6b65e3..3b3eb3162441 100644
> --- a/net/mac80211/ieee80211_i.h
> +++ b/net/mac80211/ieee80211_i.h
> @@ -684,7 +684,7 @@ struct mesh_csa_settings {
>  };
>  
>  /**
> - * struct mesh_table
> + * struct mesh_table - mesh hash table
>   *
>   * @known_gates: list of known mesh gates and their mpaths by the station. The
>   * gate's mpath may or may not be resolved and active.
> 
> ---
> base-commit: 8ea3f4f1a1b4242d5fc273f41aa7c86f6b40178c
> change-id: 20240328-mesh_table-kerneldoc-6b1e0a9e8344
> 

-- 
#Randy

