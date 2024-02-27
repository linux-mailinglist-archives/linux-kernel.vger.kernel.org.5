Return-Path: <linux-kernel+bounces-82476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD205868516
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 01:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44A11B2358A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 00:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEEC7FF;
	Tue, 27 Feb 2024 00:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E9Pw2iwk"
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD18C136A;
	Tue, 27 Feb 2024 00:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708994500; cv=none; b=SPEwa4LPvoQz9LQZyFVaHUEXFjxVVo79NUuC42VthElamH5E2bHxa4WZwyRe6UaBeZHcaUtoHIrOfewvzdI4+J4gxtFmCfkUwgOH27u4D3McJPYEXgfUwxKwdtwIPwupJkpVY+iK+blP98+D9YZXeZJ+ER12ho6+NKeU6PJMAwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708994500; c=relaxed/simple;
	bh=OCMg9lVSRi1dM4mQ/dHVKSvIT2dNp6Xad44VFS/XxqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C7iy0I6PwV0N3QUS5+N4hTY5cSKH6FzZ+gUuqwBEvI7vIPGLAWR1FUPnT201w+CAsPy4+HLsxvhITf5mgp0CPBIi1X/rumd+SjuPq3oh92X03dStYFLmV1hVZhz8wPkye+/48QxNS87eZfTCjFla5fkgYIYufHp5TCO2ilyKhhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E9Pw2iwk; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=E3yLeoY54L7an1gZ4crtQOnqHhnFkPcsPYy0GYM/xeQ=; b=E9Pw2iwkGDsfhccy5Lx+Hx4Mlg
	70ogJLDoMrg4GWhsksRjSilxhaGGnPUV9B0gNqASn5zii8g91A1xK/BiMkQge0f3CvchoM2ifOUTA
	rV7oYrED8mzqWgjAiArJdUZF2AyUc2gMfrI4WaHMWNj+BpA0EtnYQz7F4COSKeX3YoKtx+mLMkWcZ
	61mtJJyNA/6QYOLjRYnpD7t1gEPXBOa+L7JXPQG8hs1tWtdu4/ksWYVEBHrIH7n9SDw9mIAitqJrR
	qFVz9dVCE1rakSnVmhDSR5WJIT+OopKjwuMSfFk56SnUy7GjmT1GoOyFGzKEpCzpWOjoTRhSqWwg+
	Kj7ixWXA==;
Received: from [50.53.50.0] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1relXN-000000038CT-14fW;
	Tue, 27 Feb 2024 00:41:37 +0000
Message-ID: <43df625f-bd32-4dd9-a960-6d0f5c0304c7@infradead.org>
Date: Mon, 26 Feb 2024 16:41:36 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: submit-checklist: structure by category
Content-Language: en-US
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, workflows@vger.kernel.org, linux-doc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240226104653.54877-1-lukas.bulwahn@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240226104653.54877-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Lukas,

I'll review the file changes separately. This is just replying
to the patch description comments.


On 2/26/24 02:46, Lukas Bulwahn wrote:
> While going through the submit checklist, the list order seemed rather
> random, probably just by historical coincidences of always adding yet the
> next point someone thought of at the end of the list.

Probably.

> Structure and order them by the category of such activity,
> reviewing, documenting, checking with tools, building and testing.
> 
> As the diff of the reordering is large:
> Review code now includes previous points 1, 5 and 22.
> Review Kconfig includes previous 6, 7 and 8.
> Documenting includes previous 11, 15, 16, 17, 18 and 23.
> Checking with tools includes previous 5, 9 and 10.
> Building includes previous 2, 3, 20 and 24.
> Testing includes previous 12, 13, 14, 19 and 21.
> 
..

> 
> The recommendation to test with the -mm patchset (previous 21, now
> testing, point 5) was updated to the current state of affairs to test with
> a recent tag of linux-next.

ack.

> Note that the previous first point still remains the first list even after
> reordering. Based on some vague memory, the first point was important to
> Randy to stay the first one in any reordering.

Yes, I have said that. Stephen Rothwell wanted it to be first in the list.


> While at it, the reference to CONFIG_SLUB_DEBUG was replaced by
> CONFIG_DEBUG_SLAB.

I don't understand this comment. DEBUG_SLAB is gone.
I think those 2 symbols might be reversed in your comments. ?


> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> So far, no point disappeared and nothing new was added.
> 

That's a good start IMO.

> Points/Ideas for further improvements (based on my knowledge and judgement):
> 
>   - The Review Kconfig changes makes sense, but I am not sure if they are
>     so central during review. If we keep it, let us see if there are other
>     parts for review that are also important similar to Kconfig changes.
>    
>   - Concerning checking with tools, checkpatch probably still makes sense;
>     it pointed out in several places. If sparse and checkstack are really
>     the next two tools to point out, I am not so sure about.

I doubt that ckeckstack is important since gcc & clang warn us about
stack usage.

>     sparse has a lot of false positives nowadays, and many things are not
>     fixed just because sparse complains about it.
>     And I have never used make checkstack and have not found much
>     documentation about it.
>     So, maybe other tools deserve to be mentioned here instead?
> 
> I am happy to get feedback---I will work through submitting-patches next
> and do some clean-up there. While doing that, I might learn what really
> should go into a better future 'submit-checklist' documentation.
> 
>  Documentation/process/submit-checklist.rst | 157 +++++++++++----------
>  1 file changed, 84 insertions(+), 73 deletions(-)


-- 
#Randy

