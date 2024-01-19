Return-Path: <linux-kernel+bounces-30868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CB983254C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6A7181C235BF
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 07:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBD4DDA3;
	Fri, 19 Jan 2024 07:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G2ANVHJ9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF18D51A;
	Fri, 19 Jan 2024 07:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705650614; cv=none; b=AeKMvUhTT0V12YAelUWTCB1Nfi15Cm1bv4ZF/H5QZlxZjARUsiiH5gHX5MqphmBH7vh0bO6d4bsSM2vhlkHYH4b7IFDZbGycZaNHADHxDRl0ETlGSKYfn81Bdz7YXkTEXdVcg8hvIVpTO05mx/gMuB00R05hrZcksKOOj+k/CVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705650614; c=relaxed/simple;
	bh=JjuzPeeDJusOndPJB5nHYlqCcuovsdd3mDnUPIieTso=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=UlVKE//uNynsi+pDDQR1NWoa/w8hNuck5JpBZqbLniGz45KRpX10jGMR6ZY1wreQwhyiPkqBG0LaG0dM1aua2O4c8s8xCb9IQnr4zR2+TRnzvZN7jX21d/qgr5rG0v1fKeTiw8HFcKwyZXqWszp/KkS7fQTKS9AuDb7WIPi4EL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G2ANVHJ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2968CC433F1;
	Fri, 19 Jan 2024 07:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705650614;
	bh=JjuzPeeDJusOndPJB5nHYlqCcuovsdd3mDnUPIieTso=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=G2ANVHJ9/HMJ5xTii2nljbOfR+rfKawyMCAb+cXe9DonKUtBP/bCqfgeNU9QcUlMV
	 2iJZWSGCE6Vpvif82eHfvVMUXAY8xgjIw9AEtoi+eih2Vsg4rSUccklAk2Sz9mBZJC
	 FqgOQfGWfJGVXEGPP3HnseUuTSosoFE7S0w0QY7pjMi23JJIUVVtanvRLVYm2iMaEk
	 NaZRFwZY1XKe13djBvFz+lxPvmXkQ3XaUKcpUR9VqVxGU5X0zkbCuLz03vTtdWm5hx
	 70rd5aUCUafnU82KxDzSyomoWwpDAx07U7CUVTzVebfSZDzKOCoLfwz0dbpussCcEd
	 BTwi5laHAFRNw==
From: Kalle Valo <kvalo@kernel.org>
To: ath11k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,  regressions@lists.linux.dev,
  linux-kernel@vger.kernel.org
Subject: Re: [regression] ath11k broken in v6.7
References: <874jfjiolh.fsf@kernel.org> <87frytg7b8.fsf@kernel.org>
Date: Fri, 19 Jan 2024 09:50:11 +0200
In-Reply-To: <87frytg7b8.fsf@kernel.org> (Kalle Valo's message of "Fri, 19 Jan
	2024 08:34:35 +0200")
Message-ID: <878r4lg3t8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Kalle Valo <kvalo@kernel.org> writes:
>
>> Just trying to make everyone aware because I suspect this will affect
>> quite a few people: ath11k is crashing during suspend on v6.7 due to a
>> mac80211 patch, more info:
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=218364
>>
>> Proposed fix:
>>
>> https://patchwork.kernel.org/project/linux-wireless/patch/20240111170629.1257217-1-benjamin@sipsolutions.net/
>
> The fix is now applied:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/wireless/wireless.git/commit/?id=556857aa1d0855aba02b1c63bc52b91ec63fc2cc
>
> I'll try to use regzbot for the first time, let's see how it goes:
>
> #regzbot introduced: 0a3d898ee9a8 ^

Forgot to include the bug report:

#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=218364

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

