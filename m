Return-Path: <linux-kernel+bounces-163067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 803318B647A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21ACC1F219AB
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B1081836D6;
	Mon, 29 Apr 2024 21:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b="TP56wFuN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Q365N2MQ"
Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7211836C6;
	Mon, 29 Apr 2024 21:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714425742; cv=none; b=FhPbE+ArO5CbLe/DIgmU5tuIxcEaWVtrURBwRV9vLl7VEJL6qIAOeAdnptTg33Itzv8GWKH9ttG/i5JWABXtlx49tKw6cOFOmL/2ebygDZTD4LZ0rRPcq43210iMsLNEsh7jHCkXG72FfeVlU44kEH1cLva4yWIlD4ZhEUElrIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714425742; c=relaxed/simple;
	bh=TfXq4JCL/Hs/bpkpYDBRIz7T31yLLfzQJKQtMc4ciJw=;
	h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RpOKxx/9nROG77jNQWzyaBkPlC50hJ+e/hlNZfKhPZHz1/JIE3SdbV7AI7Jew4SLHXVz5QgdJgvlYNorM29GA37X6gu2hjuZgnWjcHMrBDJ7y31+qc5nMArxbHNp32S0Lr9fj2iJNFtIZbu0h/GCyBFWUrVn6icAQLvJFwWAu2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca; spf=pass smtp.mailfrom=lyndeno.ca; dkim=pass (2048-bit key) header.d=lyndeno.ca header.i=@lyndeno.ca header.b=TP56wFuN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Q365N2MQ; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lyndeno.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lyndeno.ca
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 4FFE91800124;
	Mon, 29 Apr 2024 17:22:18 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 29 Apr 2024 17:22:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lyndeno.ca; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1714425737; x=1714512137; bh=sJmpB3SmOP
	+OJLwp4SoU1l4+ZfNDN+uqj3tieQq4ilA=; b=TP56wFuNTGk7610MT/EaapZxL8
	1YgTtUCuU4/gV2MmoguhOp4ze0XrAyx2XnypkKa6gFuWGxAwq6hMsMg9qulEfKaB
	ap7P87AzubbEJ2VtNvPd3+5eKD3KOJVrkD0kZUMdTOzXOmNZE524hcTRZbByNutm
	Ex1m67zReWM4lSRa0olnKdeW6CXMZI8KSzAAA5XNVjNbqVCiQaQZYTinPqjkWeMs
	i21OEXoXbw6kObW3wLYcxRc9ox+uWjPsWIlHEnryuqR6kmZbaOrcinR96h0UIGld
	Bt8hlwAaK801X5/7t34u7SalP7XLWnBIN0lHoIF46QsC02xcEyfzEuq7lgfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714425737; x=1714512137; bh=sJmpB3SmOP+OJLwp4SoU1l4+ZfND
	N+uqj3tieQq4ilA=; b=Q365N2MQAaDI79NIg93sNtJid9WamQDMmU4F1j2MzcAc
	vhf+xMxPgdROzQft7s0u4nf9c1YdxsZ5uZtTdg6HdcOepwdHMnnrjVXR8HoJh3a5
	BNoZZWtRKeWVnOxhcSONMNY7GM+tAkWKfCwdjh96QEChIzISjVaFjGD5tKBildVD
	2U+9HvAtVJcqFfg0wA0AOV34i0511qglq0RVzsXQAg6Cmcp9ltwX6ckZmsHTzGiT
	XVL/Ofx++GgCdLM8LBmCM705bJDxRpqJiPi7rcaqJUyqoGDsXTFArFZNE9OpqHJR
	aV1E49pvacq5HdTqn+3ORnMfrpZGelKwhxhyw/dnOw==
X-ME-Sender: <xms:iQ8wZqfrFi6RFngwPK4pakzhdRRB9OAgU9x7CSHYztV3wx9KY4gsbQ>
    <xme:iQ8wZkN8ZI9ZFUid0kaCKqlTDzTsApEaBlTYH4JTfEl4S3uJX6A-bbD-mW1T8tuDm
    ZELbYykFCFA49MI6SU>
X-ME-Received: <xmr:iQ8wZrhykfQrbhVwomhisXpiqx5ytFxdx2B6pDFMPAoaUXBmjyY815SK6wK9WWS4WSPTvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduuddgudehlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffuvfevkfgjfhfogggtsehttdertdertddvnecuhfhrohhmpefnhihn
    ughonhcuufgrnhgthhgvuceolhhsrghntghhvgeslhihnhguvghnohdrtggrqeenucggtf
    frrghtthgvrhhnpeejffeukeegieejhfdvudegtdekfeevveetgffhveefueffgfdvveel
    ieduhfdtvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehlshgrnhgthhgvsehlhihnuggvnhhordgtrg
X-ME-Proxy: <xmx:iQ8wZn-UgmWYqfJjenyzaSCW7zsf5gd5ktVnP4lhgAt89QIUwtPc6w>
    <xmx:iQ8wZmsYW80TcWkMO1XF3nGyp3QkEwpUW8qLEZCs3CIX99XRFCNUSA>
    <xmx:iQ8wZuEjRBUOtKG1BQHkDvAcbtSy1-s4efOW6iTX6aysXPdFYxFQFQ>
    <xmx:iQ8wZlP-SOp6NdxVGSnNa7iU93PBzsiMPPxhAgRlztPWzm1_t-OQZw>
    <xmx:iQ8wZnmbNJtHaGnVxTbFecOzt41A5__E7DOY2b6_-pssyhmpO7471KVG>
Feedback-ID: i1719461a:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 17:22:11 -0400 (EDT)
Date: Mon, 29 Apr 2024 15:21:59 -0600
From: Lyndon Sanche <lsanche@lyndeno.ca>
Subject: Re: [PATCH v3] platform/x86: dell-laptop: Implement platform_profile
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: pali@kernel.org, W_Armin@gmx.de, srinivas.pandruvada@linux.intel.com,
	ilpo.jarvinen@linux.intel.com, Matthew Garrett <mjg59@srcf.ucam.org>,
	Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org, Dell.Client.Kernel@dell.com
Message-Id: <NC3QCS.LEAYSBJ8Y8GC1@lyndeno.ca>
In-Reply-To: <5cbb8981-5e24-4dce-a78f-1cabc29f08e3@amd.com>
References: <20240425172758.67831-1-lsanche@lyndeno.ca>
	<20240429164844.7544-2-lsanche@lyndeno.ca>
	<5cbb8981-5e24-4dce-a78f-1cabc29f08e3@amd.com>
X-Mailer: geary/44.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed



On Mon, Apr 29 2024 at 12:45:19 PM -05:00:00, Mario Limonciello 
<mario.limonciello@amd.com> wrote:
> On 4/29/2024 11:48, Lyndon Sanche wrote:
>>   #include <linux/i8042.h>
>>   #include <linux/debugfs.h>
>>   #include <linux/seq_file.h>
>> +#include <linux/platform_profile.h>
>> +#include <linux/bitfield.h>
> 
> These should be inserted in alphabetical order.

Agree

>> +
>> +	// Clean up but do not fail
> 
> Switch comment style to /* */

Agree

> 
>> +	if (platform_profile_register(thermal_handler))
>> +		kfree(thermal_handler);
> 
> Don't you also want to return an error in this case?  Because this 
> means that the platform supports thermal modes but it failed to setup 
> due to other issues.
> 
> It's different than the case of no supported modes in which case 
> returning 0 makes sense.
> 
> Maybe like this:
> 
> 
> ret = platform_profile_register(thermal_handler);
> if (ret)
> 	kfree(thermal_handler);
> 
> return ret;

Good idea, I will propogate this error. Failure of module will then 
occur on allocation or platform_profile error.

> 
> 
>> 
>>   		goto fail_rfkill;
>>   	}
>>   +	// Do not fail module if thermal modes not supported, just skip
> 
> Switch comment style to /* */

Agree.

Thank you for this feedback.

Lyndon
> 



