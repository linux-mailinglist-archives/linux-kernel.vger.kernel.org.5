Return-Path: <linux-kernel+bounces-134710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4B489B5D3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 04:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63C5AB212C4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 02:11:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063AB1869;
	Mon,  8 Apr 2024 02:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fFe/BU2T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EBC10E9;
	Mon,  8 Apr 2024 02:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712542290; cv=none; b=fqTM53tpVqDJ3GcOMUiNpTlb9FRhUZJD/0vZBXrpTm8axswXtHkFQZ8gUFzkzu+YzrkdNBer1MoVBTXg1EMmwwKzeTi4NNCI9QGPUjJOpGmlgZXooHoBRBqichlnD4KqV4WDFkrgFl4bvoLcSq1W6tZeV81UMyb0snoR8Bi42f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712542290; c=relaxed/simple;
	bh=asmZwSNHBAKQz1t1okuL2m8ib3XSi5a7JrXiy00ga0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ishcB8ZAVQjeROb1dkG/x8HDWiG4KWsCK831LWygN6EAI+0TQUeHFsXrwXuR95ewXYrJwmid5jOzakYFY6GPJGlw5Zv40DQgj405R4VSgrPsTs41HWhBmZa22IlQkNeGQiU0iGnjxe4YV99PDJl24gA+BPLf0ZdqJ3E+lLNfiMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFe/BU2T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98EECC433C7;
	Mon,  8 Apr 2024 02:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712542289;
	bh=asmZwSNHBAKQz1t1okuL2m8ib3XSi5a7JrXiy00ga0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fFe/BU2Ty7omNJGVlH/TfAQWMY25SHTytH2WTXsuH0MhBfkq06CSuB8TvHu4uC4vO
	 vZl3P4dOnuQzi/ae36s22IyQEIv4Y7JEm6P0ZM/KL7qgfhjq0eeQmQmOPwBitXUjIz
	 ju3NSpw3kL3gCCgMCo2kSj16u8Ziu0MUWi9sINudLnbYTapKuI+exkfqmSiD6gp7x/
	 ahjHJ2fC/w/Sa5jeg3aN6mHo6+56plNNGExztMDjfpcEvciEHhSJ0C9HqI0HJHMM+N
	 Baa8yTr7Lqh+7OdciPANq4oiRJI3MjSbYo9XW1f12IRouZrib5RFi6Hzk6iP8IwAIq
	 cr6hhdU/0dEig==
Date: Sun, 7 Apr 2024 22:11:29 -0400
From: Sasha Levin <sashal@kernel.org>
To: Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Karina Yankevich <k.yankevich@omp.ru>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net
Subject: Re: [PATCH AUTOSEL 6.8 02/28] usb: storage: sddr55: fix sloppy
 typing in sddr55_{read|write}_data()
Message-ID: <ZhNSUbc8Nbv_G8Ri@sashalap>
References: <20240403171656.335224-1-sashal@kernel.org>
 <20240403171656.335224-2-sashal@kernel.org>
 <cc6ee73c-fdb7-46bd-4f02-f342db846e4e@omp.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <cc6ee73c-fdb7-46bd-4f02-f342db846e4e@omp.ru>

On Wed, Apr 03, 2024 at 09:10:10PM +0300, Sergey Shtylyov wrote:
>On 4/3/24 8:16 PM, Sasha Levin wrote:
>
>> From: Karina Yankevich <k.yankevich@omp.ru>
>>
>> [ Upstream commit d6429a3555fb29f380c5841a12f5ac3f7444af03 ]
>>
>> In sddr55_{read|write}_data(), the address variables are needlessly typed
>> as *unsigned long* -- which is 32-bit type on the 32-bit arches and 64-bit
>> type on the 64-bit arches; those variables' value should fit into just 3
>> command bytes and consists of 10-bit block # (or at least the max block #
>> seems to be 1023) and 4-/5-bit page # within a block, so 32-bit *unsigned*
>> *int* type should be more than enough...
>>
>> Found by Linux Verification Center (linuxtesting.org) with the Svace static
>> analysis tool.
>>
>> [Sergey: rewrote the patch subject/description]
>>
>> Signed-off-by: Karina Yankevich <k.yankevich@omp.ru>
>> Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
>> Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
>> Link: https://lore.kernel.org/r/4c9485f2-0bfc-591b-bfe7-2059289b554e@omp.ru
>> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>
>[...]
>
>   I doubt this is worth pulling into the stable kernels, it
>does not fix any serious issue...

Dropped, thanks!

-- 
Thanks,
Sasha

