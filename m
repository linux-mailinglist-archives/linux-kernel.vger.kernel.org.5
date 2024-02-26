Return-Path: <linux-kernel+bounces-81327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7740D867446
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 13:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1023D1F2E40E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 12:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAE45FBBB;
	Mon, 26 Feb 2024 12:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="uYMfSRXI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e7cYhdDr"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88505A7A6;
	Mon, 26 Feb 2024 12:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708949098; cv=none; b=E+4gBCiPYUvYnbNfBcTnk1drr62lM8QVI0+SPhFbwWwOh51r/O+D79ldkA65qgtcuQvHT6W6klLq40mBLtKi2Lqscj6OkJbpUbHBMF+XU1X+pzbvPoorupD0bzTETOacBpUWQlvqB3uv/Z7Vx0+MNvvnNP3AG/yrNEgoGcF6VRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708949098; c=relaxed/simple;
	bh=R2QaRajn7czQBQ1//3E8ZkjjMlx/gkcIwN6HI0iR8+U=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=l6Rqp4nh+lhizIZho+6Byyh45O5GCETsN9oHgPueAOK0gEeMMATM+flIS4QNGBpsUsOgV5v+r7qghKksd8rPlWxXiwE3P6giy/xHyKBHS9FCveLMQLP9DlfVYA22wFyvq8N5iisyp5cypCqiyhuOdIHLsl9kj8Qfmi/5jK/zYhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=uYMfSRXI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e7cYhdDr; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id AE2A011400B9;
	Mon, 26 Feb 2024 07:04:55 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 26 Feb 2024 07:04:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708949095; x=1709035495; bh=iemZvmTeFO
	K/omKnZsMGajImy7MZ2HwWu9q1V6U7FW8=; b=uYMfSRXITmoj9ocsfHzxm8aKti
	PqRTPqdrgGR5ZDmVoXAkr6w/gNFOsm0t6+HzaLzKot2mBJSVylLDXzE3EspKwzXE
	7ub/IGcb2GDao7VbHPqrMFfBcsDrV3WLUWDwnszWCaKYUibsILKPyzEpGnzjUE/d
	vridN4WPdTAFBHgvvVts7KKQfrpA+YNjchBKUohoSbYPzkhV7Hj42c0jYDgp8qf0
	nnZ2wLUR/aa9rZmvB/yXpSni6jS/7rGpwYQ7cQFAtGIe6Ia+0gi9kiTN4JOONbgX
	8kL0qAt7ICFDRcrpSTKOlBOKBOWCcSwltaHV0brTCzD1p+dsmLItR4/uCOOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708949095; x=1709035495; bh=iemZvmTeFOK/omKnZsMGajImy7MZ
	2HwWu9q1V6U7FW8=; b=e7cYhdDrh6puewqelVJean/lsK9sBAVvf+yk1LTLsr/3
	uBgw3UuCMMV09+Erwt+SBcxjR4njxxI8udc3JJzsqIjNYz4io/t7f+RvYltJSop4
	qk8Tp/s+Adh3egqyo+uKLLRlpGZs8jU3u2G+xgfhpAHPUA+H00xsrgbGIs4HgLQl
	wBpbIlMIo2ff77wtAbhAQ5GAzo85Iq+Deriapxj9e+DStDJxaOmfCA6wWQYKubg1
	1+sZalcqKKqeCUYVSc+LSgGiC1xyb9+PmJkdGFth9GOmn3MCg15UP2xL0i1hBLZT
	DNqJ+hgn/IFhf0LQ4TdsI9x8fkUzIpGChziEkCpRXQ==
X-ME-Sender: <xms:Zn7cZQiQTmsXP_9vUkiYmeJdIGJfqDDOU1z2RsaM2BlX0YpEajFT6Q>
    <xme:Zn7cZZCfMEUMDRptEg7LSoxDhpuiQ2cHVRQeCEBa6hhhkGg8vwfWqbkcLPk4xHrAZ
    1fpettYCfqRSADoTSI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgedvgdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeevhfffledtgeehfeffhfdtgedvheejtdfgkeeuvefgudffteettdekkeeufeeh
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Zn7cZYGoLxW9T6b5MiqYoAe7fpiZ4w7lIoijMv22jU5i4jz6yh_OXw>
    <xmx:Zn7cZRQRflBn4cHR51Wkk7Z595bMeo4-gIy9XZsZ4wJGA1WDZNQ_uw>
    <xmx:Zn7cZdwBudv7EEqMg-D817BStUu6hOoABVsgzgGfeYY0S_rk4vq29A>
    <xmx:Z37cZUkHIMs9LOPUenS1zw7X_ZHZRj1ezNoyaIEblIOWkyjuCJFX6Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 32952B6008D; Mon, 26 Feb 2024 07:04:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cc9e02b3-57df-4a7d-bd21-2d574bf4b878@app.fastmail.com>
In-Reply-To: 
 <y2lxeu5uvj7ezlv7kf6lox5e5xprmvrhqmf3gvzjsatlrrlub7@mvqzoyq5mnvd>
References: <20240226105427.7191-1-fancer.lancer@gmail.com>
 <20240226105427.7191-2-fancer.lancer@gmail.com>
 <34af21b5-a878-418e-a70b-299cab61b37e@app.fastmail.com>
 <y2lxeu5uvj7ezlv7kf6lox5e5xprmvrhqmf3gvzjsatlrrlub7@mvqzoyq5mnvd>
Date: Mon, 26 Feb 2024 13:04:33 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Serge Semin" <fancer.lancer@gmail.com>
Cc: "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Jiaxun Yang" <jiaxun.yang@flygoat.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Alexey Malahov" <Alexey.Malahov@baikalelectronics.ru>,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mips: cm: Convert __mips_cm_l2sync_phys_base() to weak
 function
Content-Type: text/plain

On Mon, Feb 26, 2024, at 12:27, Serge Semin wrote:
> On Mon, Feb 26, 2024 at 12:04:06PM +0100, Arnd Bergmann wrote:
>> On Mon, Feb 26, 2024, at 11:54, Serge Semin wrote:
s to.
>> 
>> Since the resolution of the alias is all done at link time
>> anyway, could you just convert these to an #ifdef check
>> that documents exactly when each of the versions is used?
>
> Not sure I've completely understood what you meant. Do you suggest to
> add a mips_cm_l2sync_phys_base macro which would be defined if a
> "strong" version of the method is defined (and surround the
> underscored function by it)?
>
> Please note after this patch is applied no aliases will
> be left, but only a single weakly defined method:
> mips_cm_l2sync_phys_base()
> This is what we agreed to do with Thomas:
> https://lore.kernel.org/linux-mips/pf6cvzper4g5364nqhd4wd2pmlkyygoymobeqduulpslcjhyy6@kf66z7chjbl3
> Thus there will be no need in the macro you suggest since the
> weak-version of the method will be discarded by the linker as it will
> have been replaced with the "strong" one. 

I meant that instead of having both a weak and an optional strong
version that get linked together, always define exactly one of the
two, such as:

#ifndef CONFIG_MIPS_CM_xxx
static phys_addr_t mips_cm_l2sync_phys_base(void)
{
       /* current implementation ... */
}
#endif

where CONFIG_MIPS_CM_xxx is the Kconfig symbol that decides
whether the file with the strong version is built or not.

This way you always get exactly one of the two versions
of the function built, the local version can be inlined
if the compiler thinks that is better, and the #ifdef
documents exactly whether the function is used or not
for a given configuration, rather than a reader having
to track down how many other definitions exist and whether
a config includes them.

       Arnd

