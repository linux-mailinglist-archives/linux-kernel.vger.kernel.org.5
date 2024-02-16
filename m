Return-Path: <linux-kernel+bounces-69284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CE2D85869D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 21:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C679B1F23598
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 20:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606671386B3;
	Fri, 16 Feb 2024 20:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="wSDTjiuN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YM3T/If4"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD71F1384A6
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 20:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708114773; cv=none; b=FvT3ClMJMIKHZz4UBs4rRVer2sM8ZH8Sey/iSP+L4kaCvhoKKsv8NK/kEGdHpgKS0cz3z38H8YpYnmWxft18F8O9/FYeq7TEgDX2foaLYb65u8eJbJUcwBnW+GywQ0AtZRK5gmYNZVQVmWRa8twWqt3F7eSCc5PG0gnxNOBOGVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708114773; c=relaxed/simple;
	bh=/bokmpfElf63z1ZydB/22t5ENMueGssT3gFl8Sqi5dM=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=RSthYeDq0UfBxWmu32tWj/Jaz/zSXaWTQSx+pc82st5BN7lJ0e3GzlgSfg929SMwT7xNUrWH+hi7hIRn1KdzW7rmhWomP9Q4SewEOPXvLXGWxqCqHT5w4PBhS4mNjYSq5G9abDGTnZDbd3wPoeDxOje//EZWJyXETizwhrJO3MQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=wSDTjiuN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YM3T/If4; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id CE29911400E5;
	Fri, 16 Feb 2024 15:19:30 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Fri, 16 Feb 2024 15:19:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708114770; x=1708201170; bh=jOuj0uRSw5
	sSrWJwEuWZ1IConb06mgLahGV1YyhDnQU=; b=wSDTjiuNZtJy0RGz54YzwuXmgI
	1NgUkVtFnYAiqR3kbdb56KGhBLPd4E2eAb5ATNxchvMWAOSjQNFPwF+8SMkQ28Wg
	qkSAF2qIGLcO+K+16X90XsJi7gDlls1zQYzQw7mvsVB17t/OZTmacil/vok+ggUX
	yHYFCh3qefBz38lavm05HV0rzdDjIYCXLAgnfmEpzo6zR5gZ3lfTdnyKq+Ptj7mB
	TGAVJknVqJ8WqafDUR2jaMglDBM6BTV57kxULWG68XODufQGFhuXZ4CN2yozKDe0
	m2h/Cxn/OQNpW0/eKc7/bC0d/Ah6rMMLAng90GiWCE4aiWDKhoJOsRKtmn+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708114770; x=1708201170; bh=jOuj0uRSw5sSrWJwEuWZ1IConb06
	mgLahGV1YyhDnQU=; b=YM3T/If4ZoM7paOwl27rbPb6cxMqLbnRBjodlMAr2D80
	rzHl+hqEvWdKyvJkS4wczFl1RmQGwRPYnCpGIgBNzbmBvK8Nd+yxtpQqKnkjgw/D
	yQUvcPSdV4EX36sWSmpo2t3iEjpQNA2Qy88dpWZM6rC+oOz+hR5F3kr6sGRegGmj
	Xl4msPwgJaunEh6Qr2w+XNjek8TZxrMb4gPvG4MBCtS7UfzPxec6CsOiPn/wi3Eo
	aCrBQtDXake8A/ZQfWuGfa0XtpYraHoPLDw9kt5ZWMs1oQXCSIl/MxVKsuay7Fxp
	sLjBskSSbJYx5eQAOtX8xjKDXySe7P+eMT0Zv7jGhQ==
X-ME-Sender: <xms:UsPPZR1wBBIeYj3tEDbpIUOaklY3bKZdHRpUb9etLS8Val9apnREEg>
    <xme:UsPPZYHmT3FyIqJNttulLPgR4HLueQ_TgoOUmviB2s6cD5GTTgzRHz2vPTGm3zczR
    THpMZh2qAyainlYyUM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvgddufeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:UsPPZR5jaVx0QHUlq_1Bk6uaT0t-VK9cUdGiLHeWDmUoRdFBJ7soaA>
    <xmx:UsPPZe2Td7BtCNx8_3YFtFcbMBRTd0pxLk9ps9G7Wc1toWvhFJIFGA>
    <xmx:UsPPZUGukLIZOtvB_lwi3WmocHPYeev9IWp32QXeq4qXybaU3vPLGA>
    <xmx:UsPPZfCJ_cH5U-CDvQnsPTvjpsBQ6uvQ3JgIbDX14eZ2Ws8YmRTV-w>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7BB0DB6008F; Fri, 16 Feb 2024 15:19:30 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e880e5c4-143c-4c51-adc5-e517f319579e@app.fastmail.com>
In-Reply-To: <Zc-ZfgVbAvAZVrPu@pluto>
References: <20240216163259.1927967-1-arnd@kernel.org>
 <Zc-ZfgVbAvAZVrPu@pluto>
Date: Fri, 16 Feb 2024 21:19:02 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Cristian Marussi" <cristian.marussi@arm.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Sudeep Holla" <sudeep.holla@arm.com>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
Subject: Re: [PATCH] firmware: arm_scmi: avoid returning uninialized data
Content-Type: text/plain

On Fri, Feb 16, 2024, at 18:21, Cristian Marussi wrote:
> On Fri, Feb 16, 2024 at 05:32:53PM +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> Clang notices that there is a code path through
>> scmi_powercap_notify_supported() that returns an
>> undefined value:
>> 
>
> thanks for looking at this, this series that I've just posted is still
> to be reviewd at all, so I would expect issues :D...BUT in this case I
> dont think that the clang report is valid since, inside the culprit
> function scmi_powercap_notify_supported(), a few lines before the
> reported usage of unitialized data there is a check (@line 816) on the
> 'bounds' of evt_id itself
>
> 	if (evt_id >= ARRAY_SIZE(evt_2_cmd) || src_id >= pi->num_domains)
> 		return false;
>
> so basically the mentioned if/else WILL be evaluated in some of its
> branches for sure and supported wont be uninitialized.
>
> Indeed, I removed from here (and from all the series) the explicit
> initialization at definition time right before posting the series.
>
> Having saidm that...maybe it is just brain-dead this approach of mine
> since it is able to fool clang & friends...I would add bACK an explicit
> initialization of supported all across this series in V2, if this
> sounds good to you.

I'm fine with any solution that avoids the warning. I usually
prefer the explicit assignment where it's needed over having
it as part of the declaration, and in this case I would
probably pick a switch/case of a set of if/else fi/else
blocks

     Arnd

