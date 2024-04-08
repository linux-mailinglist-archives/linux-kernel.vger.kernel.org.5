Return-Path: <linux-kernel+bounces-135803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF05F89CB8C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 20:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ABD6289F06
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:16:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500851448C3;
	Mon,  8 Apr 2024 18:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="X4lqC6PP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="brA1246/"
Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACBB143C67
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 18:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712600166; cv=none; b=t2qb7o8qPYTjABuAfgdDcUhkhZsl51PVzMenRMxV7TQab2uMdTeGF0ZlVI5ZquU9cCwR0z+JmjptRJNnk9NG+j+JAPuMMIMJs9o36+e9IABwWLnOXzS4FAlWcuETKB3dgEZwCUOVyGmEM5gn20axREYWv1InB1VkXMbjJjYzBsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712600166; c=relaxed/simple;
	bh=MDYifrGyvwaoGVS+wMS9G7XMJdOcFm56x3yKmUDlCjw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=cvr8IAzWJJENKdI5vlG44jA9vZ+k8MYnAyZcaltORDBnRs41N1qswDuny63EV0lE/nFA6l5FpH7CdvgDGHvXHHs664/BpNlyQ4dgiMEIqGFWC1BUpL5+cG00qwPHednxHzDgdu0hP+MYYg3gY1UqjugqwunqMUfhKuIxA/nwpjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=X4lqC6PP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=brA1246/; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 0FFE718000A2;
	Mon,  8 Apr 2024 14:16:02 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 08 Apr 2024 14:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712600162; x=1712686562; bh=uabcAv4sm9
	QYZcdZ/b6FrksBhz9HMv6R7WfGoejGE2M=; b=X4lqC6PPRq8/BS0cG3KhmAVnat
	HyqBcPaVzsEiVwxpPN3rbtDmRgU9knT33j8At7hboS2MTa3cumVGjQNlivQyxAFZ
	L7EbB76mAopFndsMBr6RHuGUF5XcOmPchlxjgtFCyd+D/gx+aTna7a+j0t3DqjuT
	RpqwRCs3gc37ez6LlxXOaQOxlXNfk4OrMaL50j9snDNaixyf3hT5mTL+PxTgtMxj
	dZiZrfcTReOxtL5EvkK3Ueo8EeI/XVLuJ9/gfwWvI151T56yHXBrWcb7H6TSGdL8
	VkW20KJQxR3KhRn6GXZDVLuLaoO0YwE5Vi28y5CNcTqA7KTjENrgTZ3VCmOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712600162; x=1712686562; bh=uabcAv4sm9QYZcdZ/b6FrksBhz9H
	Mv6R7WfGoejGE2M=; b=brA1246/ZjazOoL77tMsNgpiLQe1cwwZOea1I4nVQ8o2
	B3LnC1bTfVbLaB4oq8qWOMQM8Vo1TVX0Uyc5ozULKQQdzkbgbJcW0yaVJusIz6av
	Ots8tZz3d82uE6Incvjvqap5+iORqpx3eIuZJzoKR2ILAO0ZI3gKmdh4WTFFjLwH
	56Ab92ae/0M0cMxh5Z+VeazcLG6joIoQ9oEhEN21wTr9lavJ/j0fKV2RePHl86Pk
	9WPwxMVlf2YJeFlBQQ4W1VxKcldDMgiemwLTfleOd13w1IS+nlYZXFbAS/004Yyr
	oPVvXlPbAkYg40PpXQj9eYFQbFtLuxwkdlvBBr6TnQ==
X-ME-Sender: <xms:YTQUZqFuRf12gSUgJ3dJ02nzi9xAT0Ly0HakoA6MZ7Sr7A_dVA532g>
    <xme:YTQUZrXcVhpbdvYvIT8_G6RScF0exkcbj6xOwoo7QxYOSzqOzp9AEb13zUZShDwT0
    TqVhpz3b2qNnT2DPDw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:YTQUZkLvgqU3sMf570ndvKnvzIbeptNstKCcvm46jO3Cc9iYV8jguw>
    <xmx:YTQUZkGXcC3v2o_4RxhoGZEoaSxyIqjrL8Jv5jiHW24URKjMYynmCw>
    <xmx:YTQUZgWRBIsXSMvq5S9tALxMlE17MR-_rd9RK5VtUUFQhaJTRdoMmw>
    <xmx:YTQUZnPZvtKfGHXe1c1RD1AbH6Ii-sJPuE1wgyoHOxUnqLEljbQWbg>
    <xmx:YjQUZhvT4js17EwuALwlK4b_kVBv0x1QVL9g6iY3bJHwOJeV-kbyOm82>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B6FB7B6008D; Mon,  8 Apr 2024 14:16:01 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-368-gc733b1d8df-fm-20240402.001-gc733b1d8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <132c99af-bbac-4dad-84b7-7ed016517d0c@app.fastmail.com>
In-Reply-To: 
 <CAFhGd8oHht+uMBouT7_AXZt4DMRJi=A7_=fyhZ2Hf_ne+8xE8w@mail.gmail.com>
References: <20240328140512.4148825-1-arnd@kernel.org>
 <20240328140512.4148825-10-arnd@kernel.org>
 <CAFhGd8oHht+uMBouT7_AXZt4DMRJi=A7_=fyhZ2Hf_ne+8xE8w@mail.gmail.com>
Date: Mon, 08 Apr 2024 20:15:30 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Justin Stitt" <justinstitt@google.com>, "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>,
 "Franziska Naepelt" <franziska.naepelt@googlemail.com>,
 "Johannes Berg" <johannes.berg@intel.com>,
 "Yang Yingliang" <yangyingliang@huawei.com>,
 "Erick Archer" <erick.archer@gmx.com>, linux-staging@lists.linux.dev,
 llvm@lists.linux.dev
Subject: Re: [PATCH 09/11] staging: rtl8723bs: convert strncpy to strscpy
Content-Type: text/plain

On Fri, Mar 29, 2024, at 00:01, Justin Stitt wrote:
>> Change both strncpy() instances to strscpy(), which avoids the warning as well
>> as the possibly missing termination. No additional padding is needed here.
>
> Could you also clean up the strncpy present in
> drivers/staging/rtl8723bs/os_dep/os_intfs.c so all these are cleaned
> up at once?

I originally tried not to mix the general conversion with the
warning fixes, but it looks like it has the same issue in theory.

Not sure why there is no warning for this one, I guess it's because
it copies from a fixed-size source of the same length?

Anyway, it's clearly related here so I've added this for v2.

> Maybe we could use the new 2-argument version of strscpy() introduced
> in Commit e6584c3964f2f ("string: Allow 2-argument strscpy()") for all
> 3 of these too.
>
> It looks like:
>     strscpy(dest, src);
>

Done now, after double-checking that the sizes actually match.

Thanks for the review,

      Arnd

