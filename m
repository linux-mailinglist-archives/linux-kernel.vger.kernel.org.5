Return-Path: <linux-kernel+bounces-148790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8B68A8777
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 17:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BFA31C21AFD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 15:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568701474A9;
	Wed, 17 Apr 2024 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="NV2uyAog";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VRn1Nbo9"
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA0B146D7F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 15:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713367451; cv=none; b=CQJb+WgkIpi6tKeguCao4X6w82uwAJQyU8l7wNW+XIJiTxFvT6TueyibCiBHiHfq4p4jB5FXXQW8BA8BshR5w9mDqvXnLDYQnGvvMaeC+2+2IPeUn6g4VtH2mCBGAc0Zx9VgKC7wAwt7gR30qcaPGgjPGuy4YAShWxYSM7C5TPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713367451; c=relaxed/simple;
	bh=dBpaf0LdjkMsh0JtjJlm/DSn8jHNFrkYbQ4msFH2NTI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=V5x9lxVF1VXnG/bJ5CcmRXXqsV0dHxgz57cJ82V+mZzEFY0TSTCs7orsCAcU176VSQ7A07yj3Wc0HlxBmn5e0tzQ09642t3kTDhOle5x2eqqxeIlRjMFg1ZZCqiLfK22R57Q9v6Saui3jySzaeH02BamZY6bxr6kDGssOjKDUe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=NV2uyAog; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VRn1Nbo9; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id D69051140141;
	Wed, 17 Apr 2024 11:24:08 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 17 Apr 2024 11:24:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713367448; x=1713453848; bh=glbLQI16xk
	GfNWJMZSibCWp76MpxWEXe4pp1qP1DFG8=; b=NV2uyAogy0VEIB/buZECVpOkFj
	clawIWQsU22GdyqvHSWkp3QXCEjH5NKEtGbffAAUNvim6QB/fp6vAVKSoDh9D/rD
	Eh0X10NcEL2vm75TFswthx69RdVLAFUSr8MXQ7J5BV3REgGQBDtnGY6H1eCnE/Tk
	uuAatkMwbF2HVVPSqwDyuSgQ+bvOB//WmF9tRyy5/WpjZLkhuxdnQ1ASkAWKzojW
	FHZU1qelP9xG6IAaMjEWTikKYHbAsiA9SE6nJh9Sf2MlVygHUl9U1asT7aJ0hvkX
	5OC3NLpjEDfbYpT/bY7wrG5IfaOsjdRtf1I9gsqv9FHfjjsJAPF1gK3j/crg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713367448; x=1713453848; bh=glbLQI16xkGfNWJMZSibCWp76Mpx
	WEXe4pp1qP1DFG8=; b=VRn1Nbo9siLDyEAdYXhVFRT4jCfCLLB0mVg4miS+kI8G
	bKXT6IjcI62H7tGBIoGIYWnYmsY0RjiYtPcRqlBUl6+f55ZqHz2+3/y2BWjMfVRI
	lgBULGU50220tuj9IAi3hlKLvFiTVxSmcarVqONI/ybtto0N+8o1YP+XcVCDctdE
	Ym+7RmoxPzI09FPSmyW8he31S/edGlBlcx0u9Tp7bAodocsg3/grxt68w0dmZWw5
	GCvdMeBxSALYGvL/SJNZPPEXU1aAuRdmFE/H4cZCkcheJxyphfBn8TBsEWQC8LL9
	FpCn/gnPi5ya9yiAhTICBOKwuX5rd6QqiBzW64Q1/Q==
X-ME-Sender: <xms:mOkfZmbyBxPDSDJl7H0MZi9gZeVx9KioE9CI2D08IPLWOzLaycTsZg>
    <xme:mOkfZpb1J3C_ewuyzWRLF23KZjOx8I-m-LLMzbUFnFLU1-YJuI9FHvmT8RStOMMcF
    9e0DEfQsS3gqgS_Zqo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejkedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:mOkfZg-tUBnZW_ZoRft1BrPudAfKJrwZ4Mu_1L5vBBZ_77Ycfi7UNg>
    <xmx:mOkfZoqVjBPX0y_h5QWg6M8Hjmbvt5fiWjgZp4eo93RfqiuHUafbOw>
    <xmx:mOkfZhpssWR8lcmgZOXdyP_QRcdi4fd68X9oUiVGeBl1pRNP1zAFSg>
    <xmx:mOkfZmT_iPvxx4iguY6k8T3f6DD_uokpAEcy9SR1zsnNCWdHW8FaLA>
    <xmx:mOkfZie9jqZ2fRj4UxDOluoHND8QrdzNsG917UcAYZCZxsmMDXz9PI0Q>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 59617B6008F; Wed, 17 Apr 2024 11:24:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e95bb670-7c20-496f-80e1-8b1891816764@app.fastmail.com>
In-Reply-To: <1f384d41-4c65-4efb-a171-26b54dacfb30@arm.com>
References: <202404141807.LgsqXPY5-lkp@intel.com>
 <31b4e05d-62c6-44cd-8038-7ac8d21320c3@arm.com>
 <a5516289-96b6-41f4-8cbb-6c34c7bf7996@app.fastmail.com>
 <1f384d41-4c65-4efb-a171-26b54dacfb30@arm.com>
Date: Wed, 17 Apr 2024 17:23:47 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ryan Roberts" <ryan.roberts@arm.com>,
 "kernel test robot" <yujie.liu@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 "Andrew Morton" <akpm@linux-foundation.org>, llvm@lists.linux.dev,
 "Linux Memory Management List" <linux-mm@kvack.org>
Subject: Re: clang: error: unknown argument '-static-libasan'; did you mean
 '-static-libsan'?
Content-Type: text/plain

On Wed, Apr 17, 2024, at 17:11, Ryan Roberts wrote:
> On 16/04/2024 15:42, Arnd Bergmann wrote:
>> On Tue, Apr 16, 2024, at 16:33, Ryan Roberts wrote:
>> 
>> I'm not entirely sure how much of the Kbuild infrastructure we
>> can rely on here. If the .config file gets included, this should
>> work:
>
> Thanks for the pointers. Unfortunately neither don't works as we don't have any
> of the Kbuild infrastructure.
>
> I'm not really sure what to do here. The best I've come up with so far is to
> just remove asan from these binaries. They are pretty simple selftests. I'm not
> sure its adding a whole lot of value anyway.
>
> Does anyone have any advice?
>

>> Alternatively, if the cc-option macro is available, you could
>> try this one
>> 
>> CFLAGS += $(call cc-option, -static-libasan) $(call cc-option, -static-libsan) 

I had another look at this and found example code in
tools/thermal/tmon/Makefile that you should be able to adapt.
Apparently the cc-option macro is not provided by default, but
there is a copy you can include:

# We need this for the "cc-option" macro.
include ../../build/Build.include
WARNFLAGS=-Wall -Wshadow -W -Wformat -Wimplicit-function-declaration -Wimplicit-int
override CFLAGS+= $(call cc-option,-O3,-O1) ${WARNFLAGS}
# Add "-fstack-protector" only if toolchain supports it.
override CFLAGS+= $(call cc-option,-fstack-protector-strong)

