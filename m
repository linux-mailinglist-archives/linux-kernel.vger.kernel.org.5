Return-Path: <linux-kernel+bounces-68050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CCE7857551
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EDFA1C20A43
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 04:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD6A12B71;
	Fri, 16 Feb 2024 04:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+I4rfcQ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6CC10798;
	Fri, 16 Feb 2024 04:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708057206; cv=none; b=guqqYU6L6Z12OSxK7KXYWf+QAhyGr1H71I/2KtINgpALvKWZBqy09ppsEt1C4ow/pxeZjzDl+ea/NYb8YbnaLN6X62dCwV/pKzr1vAvBeF+CCxcTGcGApbURJGLv3Mk8r6RkWm0qPDd9V0y60leQUvTeptHfZMwbgpxVSaYBQ0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708057206; c=relaxed/simple;
	bh=yoCN2u6AlZre/xWpuCjc8x1e4IFG0nRoJIkjNX++Mvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CC1lri50/LQvGkxXUBqXoNwEcpoqCA/rQii6YnxdAFwwzPV4/YdE2rQSact/rrbE8lIHqfWKcTU/+NkrFjKrp0+K2OIEOO8tyg9Y6+c2noZwJNOaMuA4Y5EH94j0OJmM8RQN2qyKrpSOXYoK69X4KqZfL8GjwzVYqevaY57rfiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K+I4rfcQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17668C433C7;
	Fri, 16 Feb 2024 04:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708057205;
	bh=yoCN2u6AlZre/xWpuCjc8x1e4IFG0nRoJIkjNX++Mvc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=K+I4rfcQs3jFKoo0kTOmcpLC6Wnl2Q5qemZcSweyrOarFwIFu1vIQ/GQtF0lCRZ68
	 U/1XIzrZ1v6dFMee9RzZ96Inui1WfddQZR4gI5tSsiiF4doEU+5gphxOLgmCnQMgXu
	 xMxU9YXrVN3T2WktB8VjoquzJKTdkokGKC883Y4WzhvrcPys0LqCeCPESlmurlnwRQ
	 JrRlFxvM1oiZQLvNdVonV/zUb89Wgjcm4EcqnTd4Ak93mJySIZhvSuJKWiTy8MIUMl
	 VsM4khe7WSFIVpRwpiBlnxHz8NH8mSfREfr7BUGlx07x3pIlZxGihB5xm1lcRXCUdq
	 zm7xavuKJZoJQ==
Message-ID: <a3530f16-74ca-4580-a6ed-048a08f23568@kernel.org>
Date: Thu, 15 Feb 2024 21:20:03 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V4 0/5] mlx5 ConnectX control misc driver
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Christoph Hellwig <hch@infradead.org>, Saeed Mahameed <saeed@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Leon Romanovsky <leonro@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
 Leonid Bloch <lbloch@nvidia.com>, Itay Avraham <itayavr@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>,
 Aron Silverton <aron.silverton@oracle.com>, andrew.gospodarek@broadcom.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20240207072435.14182-1-saeed@kernel.org>
 <Zcx53N8lQjkpEu94@infradead.org> <20240214074832.713ca16a@kernel.org>
 <20240215132138.GK1088888@nvidia.com> <20240215171013.60566d7b@kernel.org>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20240215171013.60566d7b@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/15/24 6:10 PM, Jakub Kicinski wrote:
>>> and given Jason's and co. inability to understand that good fences
>>> make good neighbors it will soon start getting into the netdev stack :|  
>>
>> I seem to recall you saying RDMA shouldn't call any netdev APIs at
>> all. We were unable to agree on where to build the fence for this
>> reason.
> 
> Last time you were calling into the IPsec stack right? It's not just 
> a basic API. IDK how to draw a line, definitely open to suggestions!
> 

In general, each subsystem should focus on proper APIs that other
subsystems can leverage and not worry about how people wire them up.
That NVME, RDMA/IB and io_uring want to re-use the Linux networking
stack is a good thing.

