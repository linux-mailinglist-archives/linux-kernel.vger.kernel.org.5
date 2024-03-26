Return-Path: <linux-kernel+bounces-119149-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A5B88C4D8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 15:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17B91C61ABE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 14:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74ECE12D21E;
	Tue, 26 Mar 2024 14:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="IfAd/QhD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JfDwFEmQ"
Received: from fout3-smtp.messagingengine.com (fout3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CC012D1E9;
	Tue, 26 Mar 2024 14:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711462391; cv=none; b=AgnOgmrrDUqGScoOja6GPsRrfss2NketQXl8Uw6KBsFhUavl2zwI6mZq3Q0XkWvb3KUylRjYQ+cM0Fo9bilHRkk8wOsgT3XdmDBdTlfmkfddmRHi+w5gwMGdCIO7eVvqKGrN/6F60T5x44AWunMhTuAnQZk61Vr4h0G9YaAsv4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711462391; c=relaxed/simple;
	bh=C07QoGZwFIqiiGLDYtIT/bDm7g2eW60WzjZK/2lcL1o=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ByZvyNI5SOS03lp+RedS25cWWM26I8JBomJwzzWEx46+5eXJkXZ4cBaU/TJDDDbvqhZRHZ42tllryR2dEnH/rVw+l6rHyePdoDChre1VRRxkoUKwKzJUF+MNaorMFskD0nN60z7d22H71JYTcsJDxonRzAjMBFCRiXfpVZh87hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=IfAd/QhD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JfDwFEmQ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 0A94A13800C7;
	Tue, 26 Mar 2024 10:13:08 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 26 Mar 2024 10:13:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1711462388; x=1711548788; bh=qwEl2RbjTY
	FZ3+lGDXzFX22ORlHVarQEQDkkqeWQ6+M=; b=IfAd/QhDJkneIhSG1PMAHOgbo/
	mcVTxuJiD/yHg9YhAnYnZUftiTZkSefCnZODbx157mbtsl6c9KOoEEJw5GVPRs1t
	4pKyrlXc3PE5L1IOIP/0QKVBGs2yNstleCl35baKMMtsQLa/DCZ9omCnFOXrxM+y
	YaYt9yA5nphdbfUHbwQZtnDC0awtsvnxQpY+mpuYRV5vowZLKiTpjW2SxhNU64J9
	QEujTdGbAPcin+SRXLf4b3DAFEoCsr1einZXn7xfTAyugJwP1Y7DB1BCHA4QcLNU
	W3mYGxECmUf0jcgzAIchIFVXoDxcpt1cuObldDCcZ8Gj/2s0oXUvqlT/B0Gw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711462388; x=1711548788; bh=qwEl2RbjTYFZ3+lGDXzFX22ORlHV
	arQEQDkkqeWQ6+M=; b=JfDwFEmQ8TcsCAzZifaUtTGemxt/kA2wS6Wxfey7Yrya
	l1oV15QGJN9tspkG4Jvphm8fXiHE1lt5cDzZ25+/63XjMn6rFfQU+eeRl4nU24hB
	X0tKZ5Nu46ni4fT5FqyWmxwJ3xI6uaVtB2N4O7Lbw1bTI5p8da/L6Yodjz8J+R8q
	ogHIG+CeJOu0FnKMAf/qjCuXVgtbbVxzKWXtsf7heSNO1o4a/4ikWT1IunJsfH9V
	/7xEQoh7k5cXmeRO0CP4Xce0r/kEMyXQC98+AlkvWtY9rdipL2M8JQ1zJ4NdW4Ww
	ffU0Tz3dJ0CCmJUX5g/Vs/d8eJJzaG4+1xVcg4Z3jg==
X-ME-Sender: <xms:89cCZpuStysZle_lcQ6e_39Ge5HGVApzWhrBgJRpBZ7vqbresYYPXA>
    <xme:89cCZifKumP_QBFxyJCgRHqsmRNzZ787fJzS-XrEjRDlnMRPIRio5ynT7nwaMU-A9
    jK-uuXPoZOIDizT5RE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:89cCZsx0e212wvfgtlWiXcYU5tqkhNAczCkNZP9wfA0EO_X-u8xnVQ>
    <xmx:89cCZgNvc2GXUQRxPl1yyEz95GvFxNjCeFcRcPNikptFpkl7RNlJhQ>
    <xmx:89cCZp-66mD18GWucmFFBGYq9XMM7lTwSeMdRgUXwKURHsg9kvBKUw>
    <xmx:89cCZgXsFpVb_mBNe5-9MAf1AXATaTe_lx4ptHKhkMWsgMY3wgHsLQ>
    <xmx:9NcCZpzUasImbbYFeND7Zcn2AAUpgwINPS0QeIIbxpl3ss3JyIsxjw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 96BB1B6008F; Tue, 26 Mar 2024 10:13:07 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-328-gc998c829b7-fm-20240325.002-gc998c829
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5fb74d31-a5f7-4fc0-96f0-f69158829df3@app.fastmail.com>
In-Reply-To: <2024032349-corporate-detached-0dc9@gregkh>
References: <20240322173930.947963-1-arnd@kernel.org>
 <2024032349-corporate-detached-0dc9@gregkh>
Date: Tue, 26 Mar 2024 15:12:46 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Luis Chamberlain" <mcgrof@kernel.org>, linux-modules@vger.kernel.org,
 "Rafael J . Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] module: don't ignore sysfs_create_link() failures
Content-Type: text/plain

On Sat, Mar 23, 2024, at 17:50, Greg Kroah-Hartman wrote:
> On Fri, Mar 22, 2024 at 06:39:11PM +0100, Arnd Bergmann wrote:
>> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
>> index daee55c9b2d9..7ef75b60d331 100644
>> --- a/drivers/base/bus.c
>> +++ b/drivers/base/bus.c
>> @@ -674,7 +674,12 @@ int bus_add_driver(struct device_driver *drv)
>>  		if (error)
>>  			goto out_del_list;
>>  	}
>> -	module_add_driver(drv->owner, drv);
>> +	error = module_add_driver(drv->owner, drv);
>> +	if (error) {
>> +		printk(KERN_ERR "%s: failed to create module links for %s\n",
>> +			__func__, drv->name);
>> +		goto out_del_list;
>
> Don't we need to walk back the driver_attach() call here if this fails?

Yes, fixed now. There are still some other calls right after
it that print an error but don't cause bus_add_driver() to fail
though. We may want to add similar unwinding there, but that
feels like it should be a separate patch.

>>  
>>  	if (!mk)
>> -		return;
>> +		return 0;
>> +
>> +	ret = sysfs_create_link(&drv->p->kobj, &mk->kobj, "module");
>> +	if (ret && ret != -EEXIST)
>
> Why would EEXIST happen here?  How can this be called twice?
>

My impression was that the lack of error handling and the
comment was ab out a case where that might happen
intentionally. I've removed it now as I couldn't find any
evidence that this is really needed. I suppose we would
find out in testing if we do.

     Arnd

