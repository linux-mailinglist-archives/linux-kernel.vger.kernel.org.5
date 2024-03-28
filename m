Return-Path: <linux-kernel+bounces-123224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160628904B8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A88F296E46
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE8C12FF80;
	Thu, 28 Mar 2024 16:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="XJta8GHb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NJts7+Fx"
Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A2212D747
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642548; cv=none; b=l1/hLXDyCVJf4p2FZZNmZTztXBYfRoNsrrGm/KFebnvZY90jI+lSxn5oANcVlfwx5xVKTCrTXmnHMaF5izfiL/E+kEoTBd81bEv38MpM4Ce9NLkhH7b1nVZC6cxNPIbPuuR+JMPjKJGJQ2s2cx8FS92PfRrMsntFFCpt6Ul3SqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642548; c=relaxed/simple;
	bh=v02XpB7OV8DkGlQt/Qz7rW5MYJ43YTUITJ885h0GBeg=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=p4K5Q/RlnXEsYSUPoQK6INl7VM0twDBmHCHiT2INYi7gkTKLRjAgQHpVuzbmyVRD9koXGzQ2eXEbZij+oa2Wuhr7L9cDB7+l9lFezMYoE2uLr0Ad18WzJYouxxZf20a3+Rt4sh5Y+BDXYQxkXirwA2oDCatCL2Q5ZIo1MAEhlKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=XJta8GHb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NJts7+Fx; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A4D31114013A;
	Thu, 28 Mar 2024 12:15:45 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 28 Mar 2024 12:15:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1711642545; x=1711728945; bh=Nlqxr/bvKc
	QEet5k+iEZxfxFtReH0oxeGe+9rBIGChM=; b=XJta8GHbCf6pJaGPWD3ptYx7JV
	xdSb1fthKz4oLLtTwnpXfBVL83pe0gRmNKs9450ssZHTQ5eN33S2xF/vzA1l35l6
	H1oVeBWZ2NmEAJKt89YFquSXwoIPrxRtyRakpe4QBYPeM4LcQTlt0Q06TdvlfXSA
	gI+gIKTxYPLZvvCi1A2Zg2Xtmu1qcG+Wl8sK44KwDPIGMmeb7t62ZaZHwZl6UpkZ
	+X48xh7bnB1kc13cAcKm9FyxUniP2pwPaqtBLV9L9M60IYjq7MOykjNUsw8M7KLj
	UhO/DLLDTs+eMmZcgeCOefqSb/VRN9/aFLvPkgT4f/CNjZnz8Bz0gYuYzMiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711642545; x=1711728945; bh=Nlqxr/bvKcQEet5k+iEZxfxFtReH
	0oxeGe+9rBIGChM=; b=NJts7+FxDHcJEL5pK+4tvgMNRJbgRA2+uP27FsZCB44P
	C8d2y2ChIiNjD04/Rngq/Q1qSrd2q4sTZkDAcBckKrtvFhjkDtp3Iv52QxBLIJaT
	ADQYPcmHRvd37LmrsR8IJDzn9kpD55ym/4FHXkAzD577Z9ezm2+K+fyPhTWyXR2n
	u5YX+l/qi8UxZYZZL7I4aMXwcSsgUQ5JTjnxQ8r4yM3hN433fJB3ohQ6HWEPgFgY
	8NsqQbQ6crGqBAd9Oz/RfHb2tkVJzsncwsFt4Avs3cOWIaw3up/nEtBJ+vTEbNT0
	Ono90XDTK4Sdu9+sDms2HaMRDdcG4/BfnoJTljNV3Q==
X-ME-Sender: <xms:sJcFZqcR8kgCcpwbD-QLPlGUkfk3XPUlB-n1ClWDGHj9oeZSDHRCIg>
    <xme:sJcFZkOq1-qb-FJlMz0DH5Q-68eY78ITC0ZpiH4p64boRGBPxOVS2uTd31My_aglK
    PYJvpqYfUx1IyI116c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduledgkeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepueekhfevteeileejffeguddtveehgefhgeeutedvjeetuefhiedvgfffiefg
    hefhnecuffhomhgrihhnpegtohhmphhonhgvnhhtpggtrhgvrghtvgdrnhgrmhgvnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegr
    rhhnuggsrdguvg
X-ME-Proxy: <xmx:sJcFZrgI8Mf_I7da4ARH9bs6t5-4cn4nDCGJsfuIavnYiSBfivE3-w>
    <xmx:sJcFZn9yjKftteDQ_A3aAjK3AiyPZ8wTuWQNF04vqhbjjTxZVMofXw>
    <xmx:sJcFZmueAnERE-gR1h9UDgvpxcI2nvfyM1DKbMnButcH6mW7NBnggA>
    <xmx:sJcFZuEx_M1i-WPC2k7xvwBKwLtqwqWZ8a6HOLZLeXzqiC6G-TGR4g>
    <xmx:sZcFZgIxL0KMwaRdEJ1oOcQIw4J8SUvVwdtjk5FW402DUrGyyS44kQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id B501FB6008F; Thu, 28 Mar 2024 12:15:44 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <05702c97-f210-4d5f-94cf-c2f98027e29b@app.fastmail.com>
In-Reply-To: <508e4ede-ab78-418d-9aef-f657827b6dd1@moroto.mountain>
References: <20240328140512.4148825-1-arnd@kernel.org>
 <20240328140512.4148825-2-arnd@kernel.org>
 <508e4ede-ab78-418d-9aef-f657827b6dd1@moroto.mountain>
Date: Thu, 28 Mar 2024 17:15:21 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dan Carpenter" <dan.carpenter@linaro.org>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
 "Florian Fainelli" <florian.fainelli@broadcom.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Broadcom internal kernel review list" <bcm-kernel-feedback-list@broadcom.com>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-staging@lists.linux.dev
Subject: Re: [PATCH 01/11] staging: vc04_services: changen strncpy() to strscpy_pad()
Content-Type: text/plain

On Thu, Mar 28, 2024, at 15:42, Dan Carpenter wrote:
> On Thu, Mar 28, 2024 at 03:04:45PM +0100, Arnd Bergmann wrote:
>> diff --git a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
>> index 258aa0e37f55..6ca5797aeae5 100644
>> --- a/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
>> +++ b/drivers/staging/vc04_services/vchiq-mmal/mmal-vchiq.c
>> @@ -937,8 +937,8 @@ static int create_component(struct vchiq_mmal_instance *instance,
>>  	/* build component create message */
>>  	m.h.type = MMAL_MSG_TYPE_COMPONENT_CREATE;
>>  	m.u.component_create.client_component = component->client_component;
>> -	strncpy(m.u.component_create.name, name,
>> -		sizeof(m.u.component_create.name));
>> +	strscpy_pad(m.u.component_create.name, name,
>> +		    sizeof(m.u.component_create.name));
>
> You sent this earlier and we already applied it.

Sorry about that. I normally mark patches I send as applied
in the subject but it looks like I lost the annotation
by accident.

> Btw, I just learned there is a new trick to write this when it's just
> sizeof(dest).
>
> 	strscpy_pad(m.u.component_create.name, name);

Ah, cute.

     arnd

