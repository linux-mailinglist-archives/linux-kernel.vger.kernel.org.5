Return-Path: <linux-kernel+bounces-125778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90A64892C00
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 17:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26243283376
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 16:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594A63BBDF;
	Sat, 30 Mar 2024 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y2tp6sQa"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161DDEAC6;
	Sat, 30 Mar 2024 16:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711815653; cv=none; b=mS6rVh5T/lZGK8wYPPxiInu59YJakJ7q1MXTMZzo+xYZwJGtSraU8JC5CpDXqofLK+Yp6Vt37MZIksZ4m3e1uACyQEnWLLtAT42lQXIqiaWAts8ZHDF3wNH6RRyLaSFLqHUPp5VjK6ZtJszYL/DUBgOMRVfEY5vozRoc0kwNnmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711815653; c=relaxed/simple;
	bh=JNC8qozkgWlE+Q6kdtHfr0XlvCkJCAqLu0MAE1TEAq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m+WrL2f7eXA8QKozheTgtynh9tR1Mkhmu0+yvSb/Waw66WKvAnc6YogIpWcM2U7GOSLy5Zn2f9hWYhwc0eQp2nA3c6dARB4QsGQuBesijf+qVWtaWiw5AfCQf3A1pP6jGz+TFDZYo4VIzWrvKRIyD+NoxFUtE6EHzLeocwsMVw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Y2tp6sQa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=cDTgdTBVRUAZH0p6pwQw4KmwuQ/wNotFO0UsYy13RVs=; b=Y2tp6sQaaVk+sBrRRF0N2ANzw+
	DJpIXWD4/mDjC2onipuC4uQQKeMs9aRsg/HT1VDwSIKGc3eP+vcLSjAkEbNMPmxTFdVHs6lWfg7Gw
	MRd9D7hy/FJ+Fu6galftDA1RcyU74rR0nEHQh8Q4Cxw6xr3YPPMLQOXe5cjp/5oS3B9U2a8qsTQYh
	/hPhHfrFJzmqDas7HWCJG9CrAVgTtD/r+gVTNc9TggRnbyE2zKQl5LZKhL3JxZMjhuQXGolftCOkc
	NuOgeZu/HfHF4oCfUz6DmYc0A3cejB9ptDTqCWReNGWxbCCDxIVLAhruxGaoU9AB6p90lRi48gqLZ
	zMJ8rFMw==;
Received: from [50.53.2.121] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rqbRm-00000003mZz-0NbX;
	Sat, 30 Mar 2024 16:20:46 +0000
Message-ID: <1c69304c-abaf-46e4-b58d-a4f9b30a8f5f@infradead.org>
Date: Sat, 30 Mar 2024 09:20:45 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: mac80211: remove ieee80211_set_hw_80211_encap()
Content-Language: en-US
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240329-mac80211-kdoc-retval-v1-0-5e4d1ad6c250@quicinc.com>
 <20240329-mac80211-kdoc-retval-v1-1-5e4d1ad6c250@quicinc.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240329-mac80211-kdoc-retval-v1-1-5e4d1ad6c250@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/29/24 13:27, Jeff Johnson wrote:
> While fixing kernel-doc issues it was discovered that the
> ieee80211_set_hw_80211_encap() prototype doesn't actually have an
> implementation, so remove it.
> 
> Note the implementation was rmeoved in patch 6aea26ce5a4c ("mac80211:
> rework tx encapsulation offload API").
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  include/net/mac80211.h | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/include/net/mac80211.h b/include/net/mac80211.h
> index 353488ab94a2..e6a11a982ca8 100644
> --- a/include/net/mac80211.h
> +++ b/include/net/mac80211.h
> @@ -7478,18 +7478,6 @@ u32 ieee80211_calc_rx_airtime(struct ieee80211_hw *hw,
>  u32 ieee80211_calc_tx_airtime(struct ieee80211_hw *hw,
>  			      struct ieee80211_tx_info *info,
>  			      int len);
> -/**
> - * ieee80211_set_hw_80211_encap - enable hardware encapsulation offloading.
> - *
> - * This function is used to notify mac80211 that a vif can be passed raw 802.3
> - * frames. The driver needs to then handle the 802.11 encapsulation inside the
> - * hardware or firmware.
> - *
> - * @vif: &struct ieee80211_vif pointer from the add_interface callback.
> - * @enable: indicate if the feature should be turned on or off
> - */
> -bool ieee80211_set_hw_80211_encap(struct ieee80211_vif *vif, bool enable);
> -
>  /**
>   * ieee80211_get_fils_discovery_tmpl - Get FILS discovery template.
>   * @hw: pointer obtained from ieee80211_alloc_hw().
> 

-- 
#Randy

