Return-Path: <linux-kernel+bounces-131568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABF8898998
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 16:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EBA81F2C82B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 14:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4F9B8528F;
	Thu,  4 Apr 2024 14:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="TTi7DkXO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uuYYX8pM"
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4FE01292DD;
	Thu,  4 Apr 2024 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712239702; cv=none; b=tRVGypsq1blzvtFD/VTxLixEdwWe8awBZXqktMtn2VovsH8SrMFTIyLeEI8CWhZzDssOrNItMTiJtmTCPrdP4Ewl/vxm0WEnCeyv5OPY/8YUSImUnNX+aOH+kYzaPXPWTrosQYYNTfWvfBlPP/BZgPbArMt8t9DDvOLgB3zCKcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712239702; c=relaxed/simple;
	bh=1bjFWCvwY4ohIIq4OBpqdx2ADu0JX5LSALPQRIoYYZE=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=e1CwX+PaSLB9cl3U5iOrV9CNTaeV2D3/5CuaUN/xKCLWtdrVIqiNdRj/vSzkkFAywsqjc1HLgzlWLvWlNclX2kn6oRV90spgyZBMETDsmaGSoS306JY7iKRJiKwler0lxsxQUy0l+kchYgWAmAbpViYwlCYZoUvlsYSTDelNoRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=TTi7DkXO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uuYYX8pM; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id ACB071800184;
	Thu,  4 Apr 2024 10:08:17 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Thu, 04 Apr 2024 10:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1712239697; x=1712326097; bh=N+EYyvLWA/
	1764pidiha23yH25rL43NPhdGDRm3VFBo=; b=TTi7DkXO2JErQaJb0mScNFsUOv
	Ss+oTwRiua3x1I+5B5mvMdi9nPtasukJWugr5CpHyYRxnOIvvKK121hd7Ck9H+SL
	stQo5kyzsyTe+0idyL0ID/nrKDicBBPRail/37wobyKp41hO7LWjcsBlPTJ8wSxg
	CgCRm3xTmEIjDmz7T7IZE7uO35smMcdGc8xc/Op2WSaWnZ6l2gSghydvEUIIyfEH
	bltcRCGN3V2ubt/6BddGSZAfcIDA1+o3TyyRpbYB7KS1YDIXn4KTuA937rzuswLT
	F4Wf04nmzuORreEv5hnxvDQ+3rCwvhyQ+trCk6m8vcTcq9KHfcFvDe6Zv5fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712239697; x=1712326097; bh=N+EYyvLWA/1764pidiha23yH25rL
	43NPhdGDRm3VFBo=; b=uuYYX8pMYU0SWFnQWsweQ28E0GRlxxYRT0voaidY4sqB
	tqKLxhUoUvPoNh93u26rJTm5ZSFIVOKnZ3WevqhyE22onSEuGfQDLHa1t3A+4zdj
	q4UT+LoQt8P4VVQhShqxkSNwfUO730DUBkTXQuxIrvPRoIOZBi+5iUD0jXsUhmr+
	heJe81RODGAkiiejUEL4AANUlmqoCjF66QvVZH1PyotncNx9g0gwmMeN5u2Nf5QG
	A6LzW3j0gnVkgXV/vObxTrJoBQuied3ViBJvD1aSWb8wJCEdEBIN5FV3RkgOI8px
	Ne83yEPpk20VTa4sbkpLUViY01PP8Qd8Nyo6fb75IQ==
X-ME-Sender: <xms:ULQOZpweIHBp5RM3Zs1jKtESHSb13qwmOhq6k53Xlr8WAefjyVRb8A>
    <xme:ULQOZpRM82Cn1UJCo1aQN1H2jqBjG_LBdOXtwbwpE5w-wB07ZrF0LKtF-I3QyFqm7
    auYsJIaHp8zcvfbxDo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefkedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:ULQOZjXrNMawndcDSle5TXDxDz9-DnCfBIG8lMFt0Q78PYegzMwMow>
    <xmx:ULQOZrgvmf_yree2eWcVvAynlZCxTGuL5dvMohqcL6TSMv66XdRdHw>
    <xmx:ULQOZrBl_D5JIAzIEnwl6xkNXTmg96VsA5JrBdhChLvtV43-AEwMdA>
    <xmx:ULQOZkII-nOeFzbgnGiSNJ1NROTu5OrlI0hsr-LQzCwzNzJhDApRzw>
    <xmx:UbQOZv4J3vWbq1plchMjr03X3AXp52mode6qC1AoUBQ-KR-_C5DuifsW>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 13AC2B6008D; Thu,  4 Apr 2024 10:08:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <63909b0a-7d76-418d-a54c-1061bd3b6e11@app.fastmail.com>
In-Reply-To: <20240329134917.579c3557@endymion.delvare>
References: <20240326144741.3094687-1-arnd@kernel.org>
 <20240326145140.3257163-4-arnd@kernel.org>
 <20240329134917.579c3557@endymion.delvare>
Date: Thu, 04 Apr 2024 16:07:55 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jean Delvare" <jdelvare@suse.de>, "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-kbuild@vger.kernel.org, "Masahiro Yamada" <masahiroy@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@suse.de>, "Nicolas Schier" <nicolas@fjasle.eu>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH 05/12] firmware: dmi-id: add a release callback function
Content-Type: text/plain

On Fri, Mar 29, 2024, at 13:49, Jean Delvare wrote:
> On Tue, 26 Mar 2024 15:51:30 +0100, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> dmi_class uses kfree() as the .release function, but that now causes
>> a warning with clang-16 as it violates control flow integrity (KCFI)
>> rules:
>> 
>> drivers/firmware/dmi-id.c:174:17: error: cast from 'void (*)(const void *)' to 'void (*)(struct device *)' converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>>   174 |         .dev_release = (void(*)(struct device *)) kfree,
>> 
>> Add an explicit function to call kfree() instead.
>> 
>> Fixes: 4f5c791a850e ("DMI-based module autoloading")
>
> Not sure if this fixes tag is really warranted. As I understand it,
> your change only removes a warning but there was no actual bug, right?

As Nathan already commented, it's a real bug. I also add 'Fixes'
tags for false-positives just to document what introduced a
warning. The Fixes tag doesn't automatically mean something gets
backported, though the stable maintainers often end up backporting
warning fixes as well, and it helps identify which kernels
need it.

> Looks good to me, thanks for doing that.
>
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
>
> Will you get this upstream, or do you expect me to take it in my
> dmi/for-next branch?

It would help me if you can apply it to your tree directly.

     Arnd

