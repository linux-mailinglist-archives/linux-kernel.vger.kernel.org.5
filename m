Return-Path: <linux-kernel+bounces-131363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CED8986BF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87D8028F80A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5712584FDF;
	Thu,  4 Apr 2024 12:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="0dsmgDBu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SyMu+MEF"
Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15A9C83CDE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 12:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712232218; cv=none; b=ttzZ441hw8/49XxZd18d8hEMGfWJVqFgbvAGe7pGWtnAVdzZ00mTFH1Ocm6HnKkBwJfZ8qVW3eFbrog8Nb//LEgRIZ1ju08YGfqtS9VYBTT969lx2ySYblZgBu9wyHoXirrPlXjVCqlYZ0PBY4Jp17AB+RdHJcs+tz3DDQhmk9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712232218; c=relaxed/simple;
	bh=KsgXs3wD5VmOAeTmkeoRt2QldH7cpRU7zdP1IF6V1ao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hf/TxfipgZwMXXd1di1+5bc+slC1Ou+yaRP6DvTyBH9SpUpER4bA079Keju/J14jNQIROl9XEgSaczcYj7sqZ+QgWPm5MlQFnSYEzKs5wvIbKO2cyal4NzPc9ItlUlPjP8HNzmH320mfzkUIDt0DgmVpb1Yg1an7rMLDNxyeV9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp; spf=pass smtp.mailfrom=sakamocchi.jp; dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b=0dsmgDBu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SyMu+MEF; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id DC1DD1C00121;
	Thu,  4 Apr 2024 08:03:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 04 Apr 2024 08:03:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1712232214; x=1712318614; bh=88x9mxGPrlrm2/bVzjR/yAKPi5qnyN26
	p02qH751umI=; b=0dsmgDBuPnZAu/TkkrqdMUouB9Gi9muvjgwr6IftDzfPCFJ8
	DRoNQQcAd4nIH7qFXXQpDmhs/6VkwXOYXQV6UNI2QT2cNjno5gInKAUd9qBL8lgR
	95ri9f8CSwCUq1PO9TJ1aMQaqZIqdCDcDNuoqS8DVVsz9rF8oYAKt6g8MdVlgxAh
	Es8yvwfFwQMWs9KBLKLhPz9SySKU3q2E4uRwyAb62F57ghgL+8X3dZlZlRHzf+y9
	B9+GV8LY2714RFMbr94BpedLMMtAtDWpzurklJM8dDGry7NhmqHqRsxHq3O2Ik0q
	5YcZISaot8wEkfYVkVwHQM4+G36p01YYazyTsg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1712232214; x=
	1712318614; bh=88x9mxGPrlrm2/bVzjR/yAKPi5qnyN26p02qH751umI=; b=S
	yMu+MEFEI2BAvzdnyOebMqF5UVND4EH72vzZqaWIVeq2OEH6VRsWhIRv3sItlvJw
	9aQV7cfzG48In81HNoxjYlIbqlfPU1TpKlv8kKhZGEYR+WDtrIQ62Eeb/El4o9Z0
	lUupFO/YygMYh+Dvrj5V5VWHF4smrmLhX4FbVoaicb0/lkLVAeAsYx4WJE9ecLGc
	BDoLEKzajCpvYr0/o63M57bJ3hkM/MNcf1ZQMWdmKWdcr2O1tgnHY8y9IdQMgY/y
	2j1vJg8GPPAoh0FxHOyS9bwyTFhudFub3iKXuQ/CTVpil+D4I9j6fVi0HDiDA8QU
	GfNOCLuaPwlFT/z2PwUSA==
X-ME-Sender: <xms:FpcOZlJh_UeagPKv9qc3QoQVjZyHDt8Km0OfV9O0Xjphh_NfYxYRrA>
    <xme:FpcOZhI44GdJJW0W_R_do5GgvOYiZ5hQOf8Bj9xKFyCqYlC7rv-1nQTCf11WrjM8x
    vnS0dxErhDwZ2EaM2w>
X-ME-Received: <xmr:FpcOZttj0PAn4XWDT488Q5dvR-v7N1eNZSE6uE0asKjGyTgOcTIDF_2IVATRGHClCe42s7VDN8lLg4ASyQMtoG5YbXgG0eepjlY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefkedggeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefvrghk
    rghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghshhhisehsrghkrghmohgttghhih
    drjhhpqeenucggtffrrghtthgvrhhnpeefheffffduffehhfdvteeuvdfhkeekffdvgfej
    heeujeevhfekudefteelfffgffenucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhgih
    hthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehoqdhtrghkrghshhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:FpcOZmayOP-a52bsc0igkZ24M3gN9dJ23VUPNuY9i8fdAZxhfouqNw>
    <xmx:FpcOZsZdt8GZ6gIll1kgxu3LKFo0FyiHxM46Y4wdIDd5TwX3eGcZDA>
    <xmx:FpcOZqBtweASGhlLeU5NvpdpvoZoeAVmhyzOf6i6nUgoVxepa3zrHQ>
    <xmx:FpcOZqb-9rzkH60iNdMVhBQhJNiD83imMa8Zs0GpSuc9Vv2mJe2rKg>
    <xmx:FpcOZhO_rcZr6ZqVekcAiq5tapf1WR6JfZyq7upAv8AX4drkG2mrY2WL>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 08:03:32 -0400 (EDT)
Date: Thu, 4 Apr 2024 21:03:30 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Allen Pais <apais@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, tj@kernel.org, keescook@chromium.org,
	linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH] firewire: Convert from tasklet to BH workqueue
Message-ID: <20240404120330.GA303033@workstation.local>
Mail-Followup-To: Allen Pais <apais@linux.microsoft.com>,
	linux-kernel@vger.kernel.org, tj@kernel.org, keescook@chromium.org,
	linux1394-devel@lists.sourceforge.net
References: <20240403144558.13398-1-apais@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240403144558.13398-1-apais@linux.microsoft.com>

Hi,

Thanks for the patch. The replacement of tasklet with workqueue is one
of my TODO list, and the change would be helpful.

On Wed, Apr 03, 2024 at 02:45:58PM +0000, Allen Pais wrote:
> The only generic interface to execute asynchronously in the BH context is
> tasklet; however, it's marked deprecated and has some design flaws. To
> replace tasklets, BH workqueue support was recently added. A BH workqueue
> behaves similarly to regular workqueues except that the queued work items
> are executed in the BH context.
> 
> This patch converts drivers/firewire/* from tasklet to BH workqueue.
> 
> Based on the work done by Tejun Heo <tj@kernel.org>
> Branch: https://git.kernel.org/pub/scm/linux/kernel/git/tj/wq.git disable_work-v1
> 
> Changes are tested by: @recallmenot
> (https://github.com/allenpais/for-6.9-bh-conversions/issues/1)
> 
> Signed-off-by: Allen Pais <allen.lkml@gmail.com>
> ---
>  drivers/firewire/ohci.c | 54 ++++++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 28 deletions(-)

However, the changes look to be too early, since some kernel APIs
are referred from the change but locate just in Heo's tree. Thus,
any application of the patch brings build failure, like:

```
drivers/firewire/ohci.c: In function ‘at_context_flush’:
drivers/firewire/ohci.c:1463:9: error: implicit declaration of function ‘disable_work_sync’; did you mean ‘disable_irq_nosync’? [-Werror=implicit-function-declaration]
 1463 |         disable_work_sync(&ctx->work);
      |         ^~~~~~~~~~~~~~~~~
      |         disable_irq_nosync
drivers/firewire/ohci.c:1468:9: error: implicit declaration of function ‘enable_and_queue_work’ [-Werror=implicit-function-declaration]
 1468 |         enable_and_queue_work(system_bh_wq, &ctx->work);
      |         ^~~~~~~~~~~~~~~~~~~~~
```

In my humble opinion, the change proposal should be posted after merging
Heo's work, to prevent developers and users from being puzzled.
Furthermore, any kind of report for the performance test is preferable.

Especially, in FireWire subsystem, 1394 OHCI IT/IR contexts can be
processed by both tasklet and process (e.g. ioctl), thus the exclusive
control of workqueue for the contexts is important between them. I wish
it is done successfully by the new pair of enabling/disabling workqueue
API, and need more information about it.


Thanks

Takashi Sakamoto

