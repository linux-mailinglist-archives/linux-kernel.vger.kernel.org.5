Return-Path: <linux-kernel+bounces-90509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12F2870066
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E39331C22063
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48F037157;
	Mon,  4 Mar 2024 11:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="eRq7C42j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ro/Zm46E"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791D0383B6
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 11:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709551632; cv=none; b=gpyuvZFIGl+36YPJQRby/1jL6HeFqilabvSg4Nhr8XCF05ALJxgRV0cKmZbb+oKiCWC2vqeQ6OAdiBWRY0AUfdFrPrJtaSvhcSLd0l85p3OGTF6XWRBrIelypvbSOfbg5PNSo04PpKsmta92C58nKklSgcChm1YCHXDIXI+ix+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709551632; c=relaxed/simple;
	bh=q+MR42ynKnzBEfpDhrIPiClecKa04mxXqTO3cHk85Qc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=rb/EU2bclsv8C0hd6N880m0hdiNVjrvoGnWDaoMKjjxeytG587BosX8b7FPAGnuCZDMdYg+PYNrcXoyfNEvt7+0Lo6If5miDq/lw6vfbeWX41Sg5TSAgjAr6clxyrcDHf06GU2pPqp4Gu5u9mf5esZdtJ6fCjO9uw1cImOdyNbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=eRq7C42j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Ro/Zm46E; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9137C11400AA;
	Mon,  4 Mar 2024 06:27:10 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 04 Mar 2024 06:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709551630; x=1709638030; bh=WCLCx6ZXib
	mkTszLQSSQ7hZc4cbzBKS93Xk+HpWXKXg=; b=eRq7C42jv0AVG+FYFsv3Xw43fr
	rV6E/nvYM21RbXjn3fXQBH8l2aFkmDTpyjwXVGR2ldOeN33m8y2reY8mm1+asd89
	XeLVDyzt5YFPIOFjDcyd7Q26dwvTRcA768lp9lDsIEJCr2KVTYYvhrmX8TafAqtA
	3694/F49vq711//XazCx4o/eFmoauA5E0r1o9aOtxZF+1mKDwbIZfA8ZT5MefHwd
	+RLVgmOi0uajoei5Mej9rjhM3ujtmmiiiVdtmgiUBqfjYhDUNICI12n5S2Mo7ELu
	7boySfVmDoipTB4Wp1va34ylhlEvGXudJXqUVd+OuJOqiQ8zAi6bt+n0d1tQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709551630; x=1709638030; bh=WCLCx6ZXibmkTszLQSSQ7hZc4cbz
	BKS93Xk+HpWXKXg=; b=Ro/Zm46EuO3nd92ZCxytDuo9hBCXLF/cZmtg1ONfP5cr
	t4xjhm7yOoMxI9q6gOnsvFAofIL/tXOiqSBHAeZi5E5AWiRNaA3jp2jt103MrRks
	8/2rTP82txkOYf+QfR4vl6w12h1Q+ZznZp2+dHgJApFn0OoP6YvmogL4yPbnlXNc
	pnlNbPpwEb0Wb7s5kg1/Pq4Qe5Zb8SfWslhDk29TKlZOq/wKw0BwpsbZwCKt4ypF
	rw0+hvsNEd99IHK907WWne8rF3k59uDovu9RB6GPHApTc8e+VnwbY664UJHiCRvs
	Tlm72+mjdZ8cYwYBakOM3qXC6b5NyeLwMNi+uOFc8w==
X-ME-Sender: <xms:DrDlZXntkvws9IQn3ORO4enwQBHkCLTp3pwe7sgcWrHt8y-DpeFqJg>
    <xme:DrDlZa3ua634C7USDJNZ4uDU0a2UaWOyRn1tRNqytbaRjC3KKL5O6y6Yntkju0cj6
    Ca0Fh8hZ-j7agBfI1c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:DrDlZdplQNTvcUoTNsECURnF4Qi8faEISXUABHp2IUIKdwdp2VnKKQ>
    <xmx:DrDlZfmlyHD6-nfbYFrL9r9pTKiz47WmMBQ-n-vXG3SrrviTV01q-w>
    <xmx:DrDlZV0lXHYkWXttK2dbV5v9zVXe79f74wqrPazIWUd0O-H7lfiinQ>
    <xmx:DrDlZevIOiRT-axKExEQu8-6neS-9FmHi2dnVdzCIa2tUktonrEUIw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 46BEEB6008D; Mon,  4 Mar 2024 06:27:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-205-g4dbcac4545-fm-20240301.001-g4dbcac45
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1baf9a7f-b0e4-45d8-ac57-0727a213d82d@app.fastmail.com>
In-Reply-To: <20240304112441.707ded23@donnerap.manchester.arm.com>
References: 
 <CA+G9fYvG9KE15PGNoLu+SBVyShe+u5HBLQ81+kK9Zop6u=ywmw@mail.gmail.com>
 <338c89bb-a70b-4f35-b71b-f974e90e3383@app.fastmail.com>
 <20240304112441.707ded23@donnerap.manchester.arm.com>
Date: Mon, 04 Mar 2024 12:26:46 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andre Przywara" <andre.przywara@arm.com>
Cc: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "open list" <linux-kernel@vger.kernel.org>,
 "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
 linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org,
 lkft-triage@lists.linaro.org, "Maxime Ripard" <mripard@kernel.org>,
 "Dave Airlie" <airlied@redhat.com>,
 "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: arm: ERROR: modpost: "__aeabi_uldivmod"
 [drivers/gpu/drm/sun4i/sun4i-drm-hdmi.ko] undefined!
Content-Type: text/plain

On Mon, Mar 4, 2024, at 12:24, Andre Przywara wrote:
> On Mon, 04 Mar 2024 12:11:36 +0100 "Arnd Bergmann" <arnd@arndb.de> wrote:
>>
>> This used to be a 32-bit division. If the rate is never more than
>> 4.2GHz, clock could be turned back into 'unsigned long' to avoid
>> the expensive div_u64().
>
> Wouldn't "div_u64(clock, 200)" solve this problem?

Yes, that's why I mentioned it as the worse of the two obvious
solutions. ;-)

     Arnd

