Return-Path: <linux-kernel+bounces-6463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F14D819955
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30A681F217CA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA5B156E6;
	Wed, 20 Dec 2023 07:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGOXvsiC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DEB71D6A4;
	Wed, 20 Dec 2023 07:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B439C433C7;
	Wed, 20 Dec 2023 07:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703056825;
	bh=FamdYXFSfAwJfuU3q8bo/5Tud8VTp1JKVzw0CiL1Tik=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=DGOXvsiCgsSj/xiP2r1OvtqfaMRV44P40wkDVBDig273LsYltzDLRjHluAr7SLhkZ
	 NQuOJ2aY1MMQYhDAsRKJ177xLXAliHZVwTDOMJGdOPXKTxX003VFPK1BDZB4EL+rIx
	 Vs6NuVXcVgC0ErCceQR3Rxe4tIhOA2JjtANq+YIRSwrlfMjGu3PkbkhGplFCbU3R/w
	 jAKwPQzCytboYvVzTBqgF/LcHq7U58JQYnok0ITS1mxWTkf7/ZEHmE3Is6NX1USDDU
	 hsRDDM5ktNknyvfPdDTcGYNjmuSVzel//c7Fh4g+Fc7+Ug3LsC/BRBl+hc0/p3uAGm
	 A7Ft9vLhO24CA==
From: Kalle Valo <kvalo@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>,  Johannes Berg
 <johannes@sipsolutions.net>,  linux-wireless@vger.kernel.org,
  netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: cfg80211: address several kerneldoc warnings
References: <87plz1g2sc.fsf@meer.lwn.net> <87jzp92xfx.fsf@kernel.org>
	<124652c4-081a-42a4-9f58-e5f156f08e90@infradead.org>
Date: Wed, 20 Dec 2023 09:20:22 +0200
In-Reply-To: <124652c4-081a-42a4-9f58-e5f156f08e90@infradead.org> (Randy
	Dunlap's message of "Tue, 19 Dec 2023 22:51:21 -0800")
Message-ID: <87a5q5qr0p.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> On 12/19/23 22:35, Kalle Valo wrote:
>> Jonathan Corbet <corbet@lwn.net> writes:
>> 
>>> include/net/cfg80211.h includes a number of kerneldoc entries for struct
>>> members that do not exist, leading to these warnings:
>>>
>>>   ./include/net/cfg80211.h:3192: warning: Excess struct member
>>> 'band_pref' description in 'cfg80211_bss_selection'
>>>   ./include/net/cfg80211.h:3192: warning: Excess struct member
>>> 'adjust' description in 'cfg80211_bss_selection'
>>>   ./include/net/cfg80211.h:6181: warning: Excess struct member
>>> 'bssid' description in 'wireless_dev'
>>>   ./include/net/cfg80211.h:6181: warning: Excess struct member
>>> 'beacon_interval' description in 'wireless_dev'
>>>   ./include/net/cfg80211.h:7299: warning: Excess struct member
>>> 'bss' description in 'cfg80211_rx_assoc_resp_data'
>>>
>>> Remove and/or repair each entry to address the warnings and ensure a proper
>>> docs build for the affected structures.
>>>
>>> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
>> 
>> I try to periodically check for kerneldoc warnings in wireless trees but
>> I have never seen these. Am I missing something or did you do something
>> special (enable new warnings etc.)?
>
> There are new patches from both Kees Cook and me to report Excess kernel-doc
> descriptions, so now there are a bunch of kernel-doc warnings that we are working
> to fix quickly.  :(

Got it, thanks. Good to know that I wasn't missing anything.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

