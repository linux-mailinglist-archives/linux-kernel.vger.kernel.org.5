Return-Path: <linux-kernel+bounces-126924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E7389447E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 19:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F27C01F21EED
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 17:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382114D9FC;
	Mon,  1 Apr 2024 17:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="xaiCOF+z"
Received: from 009.lax.mailroute.net (009.lax.mailroute.net [199.89.1.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 231F91DFE3;
	Mon,  1 Apr 2024 17:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711993895; cv=none; b=AYmaXjYzAbIaovBB7C/e3oifMZFBrLBZIvw2UZHrH7q0rDTJJUakIkM+MZsAfGkkhhY6I7WFRDbwypBJnvFpuLraKVgxz4fZNOoCW0KZcr6EjT7Chj91x7Jg9bgGIZYkJ9vUAQP0AaI8SeWz/IOhZVlwZFGVr9K/XWL4XkSJaAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711993895; c=relaxed/simple;
	bh=ioSWayF7uY/dgwbMcRfOuGfTwEGp+bs+y0xYOqeJp4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kl/UIGAkYT1ZG21nqe1bNupeVNletsERrTWYXII62hYnwl6RIwV3dtxzvZYU1pSTma8r211JFyui4GLTMrVgIlrxhZwEhcVuHkQuz1YQ3jykxA0S1YNhNzD2ihe+yiakFmkCV3tFm+E1e/7tJ2lmL7q78AXLLNtNGOWrFJDqqbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=xaiCOF+z; arc=none smtp.client-ip=199.89.1.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 009.lax.mailroute.net (Postfix) with ESMTP id 4V7dqT4KsnzlgTGW;
	Mon,  1 Apr 2024 17:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:references:content-language:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1711993890; x=1714585891; bh=/OTmkNbmoe0ZoUmaMXMYk1vr
	09M1+HtSGOgtYQirrCA=; b=xaiCOF+zIKeGRCeztiuU5Du0dElnRxNbejvpi12V
	JlMYjAZACh01rOHigixprn013YQxppKDobvDIqyrIPZwbi1t/m44wbRJ6vyxCNDD
	eQ3ItBsBmPWAXN/AnXhhuCsTeHm0TDIQ45zuLZDQUQlxBm2Rup2EPncjNP1bkWvc
	GhZ6ByJyiuvFgv9R0Ds+xjILlsa3QGXUp1QhUDmvX2uHHBfXwQAblZjlDBmaznOi
	tY8ePctirmA5ehlOPhCENvflwUdbBhJHfm167aljzO609WhRW2Rb6dU8rBiRLb7b
	DcskcX9wrNw2H2D8cij/bVFbk8TKBx7CzaJsownc31z/eQ==
X-Virus-Scanned: by MailRoute
Received: from 009.lax.mailroute.net ([127.0.0.1])
 by localhost (009.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id C5w9o98hycQw; Mon,  1 Apr 2024 17:51:30 +0000 (UTC)
Received: from [100.96.154.173] (unknown [104.132.1.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 009.lax.mailroute.net (Postfix) with ESMTPSA id 4V7dqN6X14zlgTHp;
	Mon,  1 Apr 2024 17:51:28 +0000 (UTC)
Message-ID: <2af548ae-8877-4e8d-8dc2-541b3d6e6330@acm.org>
Date: Mon, 1 Apr 2024 10:51:27 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scsi: sd: unregister device if device_add_disk() failed
 in sd_probe()
Content-Language: en-US
To: Yu Kuai <yukuai1@huaweicloud.com>, linan666@huaweicloud.com,
 jejb@linux.ibm.com, martin.petersen@oracle.com, mcgrof@kernel.org,
 hch@lst.de, "yukuai (C)" <yukuai3@huawei.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
 linan122@huawei.com, yi.zhang@huawei.com, houtao1@huawei.com,
 yangerkun@huawei.com
References: <20231208082335.1754205-1-linan666@huaweicloud.com>
 <6066205b-bdc8-4434-cc2d-3ce06004ae47@huaweicloud.com>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <6066205b-bdc8-4434-cc2d-3ce06004ae47@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/31/24 18:31, Yu Kuai wrote:
> I was shocked that this patch is still there. This patch is easy and
> straightforward.
> 
> LGTM
> Reviewed-by: Yu Kuai <yukuai3@huawei.com>
> 
> BTW, Nan, it will be better if you have a reporducer for this.
Agreed that a reproducer would help. No information is present in the
patch description about how this issue was detected nor about how it was
tested. That probably would have encouraged reviewers.

Bart.

