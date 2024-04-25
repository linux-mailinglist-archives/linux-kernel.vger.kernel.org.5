Return-Path: <linux-kernel+bounces-158039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B49C8B1A87
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 08:00:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 197B728334A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 06:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462253CF51;
	Thu, 25 Apr 2024 06:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HN/4PB95"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9DA3A1AC;
	Thu, 25 Apr 2024 06:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714024831; cv=none; b=asBTR6LoRmrnN0JKeuydz1CnzJkEWhKzR9gPdJO/Jzgb1YjxHqzjl5NnRb7htRJnn0TGQ6TRmgFFaBTF8n2wao6NbBusWaqvaKF7rI/2xAuJPnY7hIcm3hxaHBs5OpDoisYXw5FGMpVDnBZqXSEsV532xuqZoFNKge+fT9r7hrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714024831; c=relaxed/simple;
	bh=WfpvmkAUhIxwM5Xp8odvYw4dS6f/rUuQUBeFZ5BtH88=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=aHqJZw9dQOS0SXmGdhSTLiX2fGu/E0gy1+VamN5DlsmX4PcaIZQrqGj2+bkLLNL2pu8U1TnnoLy8kg05Adrhs9X4xTlLd/uLAu/vNmLG/bOqDoHnXeUf1csRH+d7q9gSph3QGZHpQvKHP88eWynFEABh28BkE2xm6ydVKxUwgoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HN/4PB95; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE6BEC113CC;
	Thu, 25 Apr 2024 06:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714024831;
	bh=WfpvmkAUhIxwM5Xp8odvYw4dS6f/rUuQUBeFZ5BtH88=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=HN/4PB95D1mAtqLQig4LiFXZ9mYrgJT5E1YHppqiC+GjUUsuTzpr2bzUeiGIrupbL
	 006NXSuFDMqxHpCM7JTbgIf0GUlLMsCkY+MiJIPBlnNwgRVhoOFGmaPq3So/A5mCxF
	 JobIiR4t6tckVGH9voGGDL+vf2BPDsVmg8/5ck0jLzNA/buhKZOKuavHoFZXKHTk45
	 7US6NX7A0niFQTXOLHBKqHFs69LnOmwwF3bnRBTj7f81tInYkC9+qSvNZAVXDYmLWK
	 Yz4wuSvXbQ8avpsuGJ9Ne/gkSgUlAhG7fGswp+ORGL5NZGryj9FmbITVdjXrkXKDp8
	 qY7luRJkkTbxg==
From: Kalle Valo <kvalo@kernel.org>
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: Breno Leitao <leitao@debian.org>,  "leit@meta.com" <leit@meta.com>,
  "open list:REALTEK WIRELESS DRIVER (rtw89)"
 <linux-wireless@vger.kernel.org>,  open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH wireless] wifi: rtw89: Un-embed dummy device
References: <20240424182351.3936556-1-leitao@debian.org>
	<f46ae94488d1468e9a9a669320e4cfb9@realtek.com>
	<87ttjqgf2r.fsf@kernel.org>
Date: Thu, 25 Apr 2024 09:00:27 +0300
In-Reply-To: <87ttjqgf2r.fsf@kernel.org> (Kalle Valo's message of "Thu, 25 Apr
	2024 08:57:00 +0300")
Message-ID: <87mspigex0.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Ping-Ke Shih <pkshih@realtek.com> writes:
>
>> Breno Leitao <leitao@debian.org> wrote:
>>> Embedding net_device into structures prohibits the usage of flexible
>>> arrays in the net_device structure. For more details, see the discussion
>>> at [1].
>>> 
>>> Un-embed the net_device from the private struct by converting it
>>> into a pointer. Then use the leverage the new alloc_netdev_dummy()
>>> helper to allocate and initialize dummy devices.
>>> 
>>> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
>>> 
>>> Signed-off-by: Breno Leitao <leitao@debian.org>
>>
>> I think this patch should go via net-next tree, because wireless-next tree
>> doesn't have patch of dummy devices yet.
>>
>> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
>
> FWIW I sent the wireless-next pull request yesterday and once it pulled
> we will fast forward wireless-next to latest net-next.

Oh, I just realised that this is not CCed to netdev so their patchwork
won't even see the patch. Ping, I recommend that you wait for the
dependency commits to trickle down to your tree and then apply the
patch. That's the simplest approach and no need to resend anything.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

