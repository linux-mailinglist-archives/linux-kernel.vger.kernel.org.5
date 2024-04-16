Return-Path: <linux-kernel+bounces-147044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CB6C8A6EA5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 795EB1C21E89
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A14912E1F7;
	Tue, 16 Apr 2024 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Og8X5hEf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NSbEcRhq"
Received: from wfout3-smtp.messagingengine.com (wfout3-smtp.messagingengine.com [64.147.123.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5F912CDB0
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 14:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713278565; cv=none; b=ZDUJdmcEoVFkuh+CSQ/FSe6tN0zKzVio7hChsv3lFc91+hKho8HLje/d3fMHeuqrJyux4W3UCK91QfCcKD0DuTA17GawcSf6LY2WJbzEh1iFIuQKUlCRcH0huT0WPFY73veGRtimzS/RJHcDz7LYwx7APZ8gojf27iKss7hI/i4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713278565; c=relaxed/simple;
	bh=jFF48U5d7FJuJgGfabTZlxC/tyfPeIxVSv12aazwzJY=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=H+4e+RQqlWBU93JRaMSH3TZrw5P1SXgH9c4y9kEl8BAP1UZd+yIViI4TvkuY+VR86+7J15v2NWMqBVHvkW1NgkRUkIFUvtIQhfmEIBOh34TRDwY3rm2wtjahiF5Y5fnFOWC7LtVEZLEWJMI+6n3X5i6V4xQKAOb6WGkij2ZWASk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Og8X5hEf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NSbEcRhq; arc=none smtp.client-ip=64.147.123.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 9BF481C0008E;
	Tue, 16 Apr 2024 10:42:41 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 16 Apr 2024 10:42:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713278561; x=1713364961; bh=EdTvxSTwIs
	Cxj3jYXy+//PQXrEdBAi8RS3AAbJKHaD8=; b=Og8X5hEfJiYR+7b1Mybt5cziAA
	C+BUeLrF/QnMaUmfO5wdRbKUJX/VglMq0UsNIqURNvqzTldhjeWHdCnqVAZSSJq8
	tjeOjvK9Rv5hOWXqQqnPRwxqncNjBkWx26vZtl7OmS9VAcXoxEJot1lA365hRyX0
	LRkuN6QTdEheQO4Jh59GIKBy03msAnzqaUzZB7lOohM009VxfuYG3EK0AUnbd1yY
	kQLosTJ/Dv/yvISIEAycfP/8k2iMA2wI4lT+30Lr3FM8PJ2mM5iKHNczjR5sgVG4
	n0NDeC5CxYpCGHG+shU2QsjF4QUQEImYEg01Kga8XF9p2xCkF5lFtlqxuGyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713278561; x=1713364961; bh=EdTvxSTwIsCxj3jYXy+//PQXrEdB
	Ai8RS3AAbJKHaD8=; b=NSbEcRhqiUQ2qtOcPCtssyQwO4Dt0iMmvTqMXH9Xl8ps
	BwhwrIxoyLQ2aSlt7kUZeK1IzsvwVEYFWxPTHtnwLgvEneEOmIlKccQKo60hrvX/
	Lfg71CggAF8v4vRIqvA0AI9dRpIVZM34JbkzD9eKgwVLxhI+2A+lh4sXgE552zhK
	z0lkjaNJTfT/OLszaqAn4nFP1dv/b8Hk43ugdxdz2mYd195nrMb/q735yldccmlm
	eCItp32K7Ne/a4PbGa+Lbb+/9bZnr2CTTkukuIFTjJj9Zmd4hMCos0IA+OA9exvV
	qD7+8XhJdPPKHpQl1w2OK1VKXvJ3TG9N7FSpW04JGQ==
X-ME-Sender: <xms:YI4eZlg3l50XB2848NYs1NfY34dZjIpCUcwBiBeKMtk33Y1Vv28LEw>
    <xme:YI4eZqC8MZIMWTWZ3G2WV9UofOYvtv1YnZ6gqurspjJASR2J4b8CG02BQHt5S-4Mz
    HVPFEdCNReKJi8arfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejiedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepieeguedvkeehveduieetgedugfejheeugffhtedtvdetueetkefhheduhfet
    gfdvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegr
    rhhnuggsrdguvg
X-ME-Proxy: <xmx:YI4eZlFohYniIbITPsFO8zlCJt32z0piFeMs_oScyNqzrhXUjtxGOA>
    <xmx:YI4eZqScFRdcSKvZwCyHhHAw2rqJUS-UNEPFzEdPM6yDdNVhl_dmDQ>
    <xmx:YI4eZizOYhoYm1N16P_cbmofAOJ2K-sBl4h1TSwkZDBQPs8cjwjkfA>
    <xmx:YI4eZg7tw7r3VMqMuY8giuSpEhqn186PuibUiERmVKlXgGvZNIFWCA>
    <xmx:YY4eZpkiIfEPNI903k57ptZ1yYF8bAY0Kdml1oeSejNaNeXemQ5YIKu5>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A89DDB6008D; Tue, 16 Apr 2024 10:42:40 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a5516289-96b6-41f4-8cbb-6c34c7bf7996@app.fastmail.com>
In-Reply-To: <31b4e05d-62c6-44cd-8038-7ac8d21320c3@arm.com>
References: <202404141807.LgsqXPY5-lkp@intel.com>
 <31b4e05d-62c6-44cd-8038-7ac8d21320c3@arm.com>
Date: Tue, 16 Apr 2024 16:42:18 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Ryan Roberts" <ryan.roberts@arm.com>,
 "kernel test robot" <yujie.liu@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
 "Andrew Morton" <akpm@linux-foundation.org>, llvm@lists.linux.dev,
 "Linux Memory Management List" <linux-mm@kvack.org>
Subject: Re: clang: error: unknown argument '-static-libasan'; did you mean
 '-static-libsan'?
Content-Type: text/plain

On Tue, Apr 16, 2024, at 16:33, Ryan Roberts wrote:
> On 16/04/2024 08:42, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   7efd0a74039fb6b584be2cb91c1d0ef0bd796ee1
>> commit: c652df8a4a9d7853fa1100b244024fd6f1a9c18a selftests: link libasan statically for tests with -fsanitize=address
>> compiler: clang version 17.0.6 (https://github.com/llvm/llvm-project 6009708b4367171ccdbf4b5905cb6a803753fe18)
>> 
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <yujie.liu@intel.com>
>> | Closes: https://lore.kernel.org/r/202404141807.LgsqXPY5-lkp@intel.com/
>> 
>> All errors (new ones prefixed by >>):
>> 
>> # tools/testing/selftests/fchmodat2$ make CC=clang
>> clang -Wall -O2 -g -fsanitize=address -fsanitize=undefined -static-libasan -isystem usr/include     fchmodat2_test.c  -o tools/testing/selftests/fchmodat2/fchmodat2_test
>> clang: error: unknown argument '-static-libasan'; did you mean '-static-libsan'?
>> make: *** [../lib.mk:181: tools/testing/selftests/fchmodat2/fchmodat2_test] Error 1
>> 
>> # tools/testing/selftests/openat2$ make CC=clang
>> clang -Wall -O2 -g -fsanitize=address -fsanitize=undefined -static-libasan     openat2_test.c helpers.c helpers.h  -o tools/testing/selftests/openat2/openat2_test
>> clang: error: unknown argument '-static-libasan'; did you mean '-static-libsan'?
>> clang: error: cannot specify -o when generating multiple output files
>> make: *** [../lib.mk:181: tools/testing/selftests/openat2/openat2_test] Error 1
>> 
>
> Hi Arnd,
>
> This change went in quite a while ago and is on;y just blowing up. I saw your
> comment in another thread [1] that Andrew merged your change to set -Wextra.
> Perhaps that's what has caused this to show up only now? *although I don't
> actually see -Wextra in the command line).
>
> I guess the problem is that `-static-libasan` is only supported by gcc. But I'm
> Makefile-illiterate. Can anyone advise on what's the best way to make this
> argument gcc-only?

Thanks for letting me know about the problem, I had indeed missed
build-testing any of tools/testing, so this might not be
the only problem there.

I'm not entirely sure how much of the Kbuild infrastructure we
can rely on here. If the .config file gets included, this should
work:

--- a/tools/testing/selftests/fchmodat2/Makefile
+++ b/tools/testing/selftests/fchmodat2/Makefile
@@ -1,6 +1,12 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
-CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined -static-libasan $(KHDR_INCLUDES)
+CFLAGS += -Wall -O2 -g -fsanitize=address -fsanitize=undefined $(KHDR_INCLUDES)
+ifdef CONFIG_CC_IS_GCC
+CFLAGS += -static-libasan
+else
+CFLAGS += -static-libsan
+endif
+
 TEST_GEN_PROGS := fchmodat2_test
 
 include ../lib.mk

Alternatively, if the cc-option macro is available, you could
try this one

CFLAGS += $(call cc-option, -static-libasan) $(call cc-option, -static-libsan) 

     Arnd

