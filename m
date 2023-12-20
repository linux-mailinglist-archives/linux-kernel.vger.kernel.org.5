Return-Path: <linux-kernel+bounces-6439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D458198D4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:51:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF86E1F26394
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4CF14AA4;
	Wed, 20 Dec 2023 06:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uBDLmfcY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3657D1CAA6;
	Wed, 20 Dec 2023 06:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Ug8mRj7m5kStJlcslmiFbJ4Uquzoqj9stLwiY48O6pA=; b=uBDLmfcYzInVlzZAigKzo0GJx7
	OsIYq5Ej4w6pY/9x7NU9Uhsva47JF/or/iljn4xMu4TrDKy4x8lqBjbwpQ4FDkutxnXC5ZeJDNW2P
	h7ZlhcFgARiBU9HEOlhOXoc97mWD0g6p9pK8k0qdvdifB8LX9K56M8tS7nq0k79Nw5mWqOs0zu+vr
	vnKKtAOAAvUVuv3Yd8b9uEAvH2NE3BVz+hEhG42Rgat/J78z+k0LikknHaUO6dXLKRen0xuLE9wuS
	N3xNAvGswhO/skS3RUc98TVGuTeCuIhBZ6XRsfMZ5TsuswnpkSFyHEIdjWht0a4JH/fHltf1g37pz
	TukGDMog==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rFqQM-00GKeE-0b;
	Wed, 20 Dec 2023 06:51:22 +0000
Message-ID: <124652c4-081a-42a4-9f58-e5f156f08e90@infradead.org>
Date: Tue, 19 Dec 2023 22:51:21 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: cfg80211: address several kerneldoc warnings
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc: Johannes Berg <johannes@sipsolutions.net>,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <87plz1g2sc.fsf@meer.lwn.net> <87jzp92xfx.fsf@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87jzp92xfx.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/19/23 22:35, Kalle Valo wrote:
> Jonathan Corbet <corbet@lwn.net> writes:
> 
>> include/net/cfg80211.h includes a number of kerneldoc entries for struct
>> members that do not exist, leading to these warnings:
>>
>>   ./include/net/cfg80211.h:3192: warning: Excess struct member 'band_pref' description in 'cfg80211_bss_selection'
>>   ./include/net/cfg80211.h:3192: warning: Excess struct member 'adjust' description in 'cfg80211_bss_selection'
>>   ./include/net/cfg80211.h:6181: warning: Excess struct member 'bssid' description in 'wireless_dev'
>>   ./include/net/cfg80211.h:6181: warning: Excess struct member 'beacon_interval' description in 'wireless_dev'
>>   ./include/net/cfg80211.h:7299: warning: Excess struct member 'bss' description in 'cfg80211_rx_assoc_resp_data'
>>
>> Remove and/or repair each entry to address the warnings and ensure a proper
>> docs build for the affected structures.
>>
>> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
> 
> I try to periodically check for kerneldoc warnings in wireless trees but
> I have never seen these. Am I missing something or did you do something
> special (enable new warnings etc.)?

There are new patches from both Kees Cook and me to report Excess kernel-doc
descriptions, so now there are a bunch of kernel-doc warnings that we are working
to fix quickly.  :(

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

