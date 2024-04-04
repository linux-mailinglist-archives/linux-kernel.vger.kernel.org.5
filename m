Return-Path: <linux-kernel+bounces-130859-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39DA2897E15
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 05:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C495C1F23D71
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 03:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC83220DD3;
	Thu,  4 Apr 2024 03:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XTMoMozg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180673FC2;
	Thu,  4 Apr 2024 03:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712203062; cv=none; b=YbQ/V74nP0fHIdV50Nkj+gmU9G5hHFoakoIMatyGyzZaeP03UX6ttXTfnUuxrevvLTkARTMcYaWeHQfl3Xnl/PD2MIci/ETxpcBUy9IfAYCHcYaCaUbz25aE+YgWC0OxEXHRgdyZmnQngVsuj67uXVJyJgJQ1nN4LyMOSIFjG68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712203062; c=relaxed/simple;
	bh=QcQykjmrkgn42T+2ukwvujAgs4TaBfSCN2Y9G52ZM8I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VpBfh6EneZmmxUkK6MGZdCdvGwjcA1MpdfPruknprP+mXAeSsO0jQQa4g8UlqlxGpuyg3Q/Q5YOnHHvqIjM62SN+i9JTRbcDz8X0JADuMqakqvpgS6cHyy2jiH5PFU53OwveOuhGZ3A81L3/vCO5LWIxdUcm+PXveSylkblb3ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XTMoMozg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730A1C433F1;
	Thu,  4 Apr 2024 03:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712203061;
	bh=QcQykjmrkgn42T+2ukwvujAgs4TaBfSCN2Y9G52ZM8I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XTMoMozgq1tMZQUsA0fXJ0+E8z19RsfjQU9ydUY6JfMbApzXHzfC4bFUHSTMitG1c
	 DCbyAIz6VSa+rFoFzTlWqvoaAw1Mqp3FVzMZxTnC7LRHtgI0Hy4qN6yBLaf5yHKs7E
	 FSKPc72q4LxpzY2gNr29oNBW5jR+kMne9rPI335nuw9ooVuypmxtQ9A3jsZLOvzOGc
	 LoQF+jVFM12E8pbsLhsTbICmIhvKY/TBFxoGymz8JzLWWKDKYqqMxbzxVpt/0hEUOI
	 IHT9Jc2ggE1v6vaNjkFwPeqtsWRh2ItIm8q930Hfo4DC7JBQ7/bvbN42Ij0b6pIG8g
	 HF8TiD7SnZT4w==
Message-ID: <573697bb-a3e3-4016-82e7-dec3c2804c90@kernel.org>
Date: Wed, 3 Apr 2024 21:57:39 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Edward Cree <ecree.xilinx@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Christoph Hellwig <hch@infradead.org>,
 Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
 Itay Avraham <itayavr@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Aron Silverton <aron.silverton@oracle.com>, linux-kernel@vger.kernel.org,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Andy Gospodarek <andrew.gospodarek@broadcom.com>
References: <2024032248-ardently-ribcage-a495@gregkh>
 <510c1b6b-1738-4baa-bdba-54d478633598@kernel.org>
 <Zf2n02q0GevGdS-Z@C02YVCJELVCG> <20240322135826.1c4655e2@kernel.org>
 <e5c61607-4d66-4cd8-bf45-0aac2b3af126@kernel.org>
 <20240322154027.5555780a@kernel.org>
 <1cd2a70c-17b8-4421-b70b-3c0199a84a6a@kernel.org>
 <0ea32dd4-f408-5870-77eb-f18899f1ad44@gmail.com>
 <20240402184832.GO11187@unreal>
 <cefa2b9a-4227-969e-d31e-c19a552b9c1c@gmail.com>
 <20240403190012.GV11187@unreal>
 <d75ee9d5-36a9-4056-a0f3-0c05b2e744aa@kernel.org>
 <20240403170149.7d2b8f2b@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240403170149.7d2b8f2b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/3/24 6:01 PM, Jakub Kicinski wrote:
> On Wed, 3 Apr 2024 13:31:46 -0600 David Ahern wrote:
>>> ... Patches aren't languishing for want of reviewer resources; it's just that it
>>>  takes *submitter* time and effort to bring them up to the quality level
>>>  that's required, and occasionally the vendor has to (shock! horror!)
>>>  tell the world what one of their magic knobs actually *does*. ...
>>>
>>> ^^^^ Content
>>> This paragraph alone shows that you completely didn't understand the
>>> discussion here.
>>
>> +1
> 
> "didn't understand the discussion" is an ironic thing for you to +1,

Come on, Jakub. The +1 was regarding Leon's entire response to Ed, not
just the last part you so conveniently quoted here. I agree 100% wiht
Leon that Ed's "Language, tone, and content of your email were
inappropriate". That is why I left the entire quote in the response and
not just the paragraph above.


> David. After all my emails about HNS3 RDMA you somehow concluded today
> that I want to make rules for the entire kernel:
> https://lore.kernel.org/all/6faa47b0-27c3-47f9-94be-1ec671d9543c@kernel.org/
> 

And as for that response (the URL you listed there), what else should
one conclude? That has to be a fair summation of your stance because
this entire thread is on a driver completely unrelated to netdev that
you jumped in on with a NACK. I have asked multiple times in this thread
and the one before where you believe your boundary ends as a maintainer.


> And I second what Ed said. I have asked multiple vendors preaching
> impossibilism in this thread to start posting those knobs. I offered
> to do a quick off-list review of the list of knobs they have to give 
> a quick yay / nay, so they don't waste time implementing things that
> would get nacked. None of the vendors bothered taking me up on that
> offer.

Again, entirely missing the point. This is not about configure knobs
that have a potential to be consistent across devices.

Sadly, this thread is not a spiral, ever so slowly converging on an
agreement, but a merry-ground just going in circles.



