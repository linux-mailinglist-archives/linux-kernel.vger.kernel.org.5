Return-Path: <linux-kernel+bounces-95946-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DCF487553D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 425F11F23E32
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4E2C13175C;
	Thu,  7 Mar 2024 17:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="A7UbzPwL"
Received: from 008.lax.mailroute.net (008.lax.mailroute.net [199.89.1.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40470131720;
	Thu,  7 Mar 2024 17:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709832763; cv=none; b=eMHgw2bc2O3Wvu3f1+O/kAFZUTrZeEIR1uuBvnCHYQv7R+b8rR/TB2+GmiBY/UcxomzMLNGLqpZ7wrrFxhmIZa0pXw67ImnJegO/FYxweLQgf6FMxOUna95bhNEeRBj1rn2g9Lx/VpHIzoPfxsA41t7d93tNocAbphmXaV1xIQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709832763; c=relaxed/simple;
	bh=oWPUsnbZDOlxxLdfXs2o8PRtCjbbf+VNBb0sGJ8bFGM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YwJ0L/TmTCwPl7b2/REMBF0hqyDbt6BDBUL92V0L/PdfWsuEWW7IK7YhtIMaRiZN7Zj8ywgexkKDQCvC1VrHK4gRtn82fhMAJQf0u0v4PdzC1Rg+UqYUgTfYdx/BnExBjKrwI7XSY8nIH8FqbvTqxiOodRkhvsu9ONfIDDCPjSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=A7UbzPwL; arc=none smtp.client-ip=199.89.1.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 008.lax.mailroute.net (Postfix) with ESMTP id 4TrGbC3SFvz6Cl44X;
	Thu,  7 Mar 2024 17:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1709832754; x=1712424755; bh=moZ9+5orZT+OYhKZAyxdvu5O
	Nr7RA4cWiHxMkHcHcWU=; b=A7UbzPwLUvI5xkRJAWjK6KVDk6kivCCl0OrlXSZh
	E13AYaRjteHDMVTKP44VG51CWI8Hj7nROECMWJJoXDzYhVP/FUGmc6YZWRULR4dY
	9Lrpq0zzOM0ojpCpOUtXtCv1ikC9PhM/9wIrtkPD0cGs0fT6h3pQFptLRSbj3R1O
	MNFNop1FB4LIWN+ee+kMBgJy3jF/nbLR5xC08y8aoDcvTqUQ8gqFQSziM1n3W34K
	p6UW7kOEi2IUrbrd58vT0WWmrjpRuHWoTXaIErfZTCPgoeCZyegqrX/6/i61OBU5
	SPBwphJxvpx1Tf3tQMLcxiyaVA4SFvnGva39x0zc/cG0RQ==
X-Virus-Scanned: by MailRoute
Received: from 008.lax.mailroute.net ([127.0.0.1])
 by localhost (008.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 1gW_8sGIy35B; Thu,  7 Mar 2024 17:32:34 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 008.lax.mailroute.net (Postfix) with ESMTPSA id 4TrGb51T5gz6Cl44Z;
	Thu,  7 Mar 2024 17:32:33 +0000 (UTC)
Message-ID: <1181bcdd-1ff4-414b-bc0a-40e513fede08@acm.org>
Date: Thu, 7 Mar 2024 09:32:31 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WinLink E850-96: WARNING: at block/blk-settings.c:204
 blk_validate_limits
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: linux-block <linux-block@vger.kernel.org>, lkft-triage@lists.linaro.org,
 open list <linux-kernel@vger.kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>, Ulf Hansson
 <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
References: <CA+G9fYtddf2Fd3be+YShHP6CmSDNcn0ptW8qg+stUKW+Cn0rjQ@mail.gmail.com>
 <20240229142144.GA8348@lst.de>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20240229142144.GA8348@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 2/29/24 06:21, Christoph Hellwig wrote:
> On Thu, Feb 29, 2024 at 07:44:01PM +0530, Naresh Kamboju wrote:
>> The arm64 WinLink E850-96 Board boot failed with 16K and 64K page size builds
>> Please find the below warning log on Linux next-20240229.
>> First noticed on the next-20240220 tag.
>>
>> This issue arises only when one of these Kconfig options is enabled.
>>    CONFIG_ARM64_16K_PAGES=y
>>    CONFIG_ARM64_64K_PAGES=y
> 
> That means this device doesn't set a max_segment_size, or one smaller
> than the page size.  This configurtio has never been supported by
> Linux (Bart has some patches to try to make it work), but with the
> new block limits API we now actively catch this and warn.

Hi Christoph,

Please let me know if you would like me to repost the patch series that
adds support to the block layer for DMA segments that are smaller than
the page size. Despite my requests to not support such hardware in the
Android kernel, that patch series ended up as an out-of-tree series
in the Android kernel and will continue to be maintained by the Android
core team for considerable time.

Thanks,

Bart.



