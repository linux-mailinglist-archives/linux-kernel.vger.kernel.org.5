Return-Path: <linux-kernel+bounces-83524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF870869AD5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:43:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C010F1C249E1
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94921468FE;
	Tue, 27 Feb 2024 15:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="ETPl5htV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NT3iQKQh"
Received: from new4-smtp.messagingengine.com (new4-smtp.messagingengine.com [66.111.4.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C1E145B24;
	Tue, 27 Feb 2024 15:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709048617; cv=none; b=NwubN8dZ/zjZ8CI/Q6GufwonxBSbGf+SxU6O+VlTiW/YgFCl1tNtgBEz2XDcoSCSq1x8ShSE/XoofQ1ETL/QnoT9Q0MLGW4kJxrNGXX9F/eVHi8dbtboHPvSNE31DhbIKLmrbJnWKbXFE5rzm2XlTDeJRMG+eW/x8/W9r0XDO7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709048617; c=relaxed/simple;
	bh=cU4NQK+AdbTUX+Y3Ff4GljQ2WiAS3lPrBTsXg0ur6BQ=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=jsUNZKO5feq84WAJcXEF2e/fbbi6pfIu7Ghs4jQL6yGJH6qsY7tENCcMyC6phRBJaV1kpEfQ3I7dgC12Nc6uNUsi3uKwfv898UVPvO4uPgScqRyLrO4rWoclwL5HumWmozAHN55d3m02K0nG+cxLoYJEHwb8PyV4zte5rOyZOoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=ETPl5htV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NT3iQKQh; arc=none smtp.client-ip=66.111.4.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.nyi.internal (Postfix) with ESMTP id 634E9580A1F;
	Tue, 27 Feb 2024 10:43:35 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 27 Feb 2024 10:43:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1709048615; x=1709055815; bh=RvthbOEWI5
	7px7uX0Cq/SvB/Jiq4PKWj3XWiDYpTS5o=; b=ETPl5htV7hPJGyIFVjM2VDJlRJ
	JywnITINm7820fBfb3Xdg0RotosUKEfkEmxGh1k+JS9kphahurayiI13hznGLeIm
	MbYBqWKV+tP4RurXvAd1ZtPNforvZyb9z/g7ceDiz+h78r4tigeMSbrfwFNXmumH
	fOb9S6gVv3c+KVSaRDBSJ5Jy9abQDxTJL1hwwol+0A5h7wV+HeuevRDckJsJG7I8
	WqU9yoRi3mWoRn0p1BLR+fCwXX1WcoFnCDhz0jcdI7ggVlB3OHffV/iGZaVYIAOA
	1HUD8wJIFUuwEacMn4br7UHdx8Z+dBuKSQk8ZatJtUJOz78cHxKs+MMrHJlA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709048615; x=1709055815; bh=RvthbOEWI57px7uX0Cq/SvB/Jiq4
	PKWj3XWiDYpTS5o=; b=NT3iQKQhAWJtF8LpyAbu0f/NJkTT77zJv2vTIHAh557R
	s3yetq/9tlfhtbar0DclfTfRaeq7xkQ+ik4aXUEpTfXPxyCk6oBk8rf1+WzXO13w
	sbMmXJ7/z07mKQO+WWMYLvW+qj5Av6FRqV2SNaMJYCCuMqH1Y3ouHuo+Q1W4NY58
	o7RAS16zuI0wC5ecItjLV8splKg9jzheGY+Sk6ZsWoLLEt5Z6E6UFZo78D2+ULGC
	hUfm1nfzW+s+47M1DgWxSCrGezaUXnqzM70yM0DxsG+XPQAxBiqVUix3/13lyu72
	eVy63lHdCcF9TuLQO0QH+42d2xafCtvmGh0EZCRNOw==
X-ME-Sender: <xms:JwPeZWatQztnTOrjeTLXYpxnKqyIPALPJ3sPFo2X8oTnM0HHrVLd7Q>
    <xme:JwPeZZaUmJ-HHYf3CWZXh-2YOFlWdays-LpGDgdwmnmSO9YP-kFoUL6jkFSiosCH3
    FxGzUCOIOmG0PddvN0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeehgdehhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:JwPeZQ9gHg_e9TU2rmqVDT7C89NGVhl0jLj5gA86W34yTgnP27lyGQ>
    <xmx:JwPeZYrM844Y1piwZ1hoXvq4kob8AwbwFPpB3Tl0qH7ukJsUwZK_gQ>
    <xmx:JwPeZRrXDV8P06sK5xVATdSl45qkxwQgZgJRFS1QUcTyZDudKEvKpQ>
    <xmx:JwPeZR2vDyPGNuT2sbDOqkmm6IqOH7RitzSfnlNxpl1amFz_HmH3Fw>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 22FFFB6008D; Tue, 27 Feb 2024 10:43:35 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e1263cfd-bb21-495a-a849-f0ea795a6d9e@app.fastmail.com>
In-Reply-To: 
 <CAMuHMdVCWF50SO1TK5F5Q8sN08THKJ+F6gt9u5pD05gJUZ+E9w@mail.gmail.com>
References: <20240226161414.2316610-1-arnd@kernel.org>
 <20240226161414.2316610-2-arnd@kernel.org>
 <CAMuHMdVCWF50SO1TK5F5Q8sN08THKJ+F6gt9u5pD05gJUZ+E9w@mail.gmail.com>
Date: Tue, 27 Feb 2024 16:43:14 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: "Thomas Gleixner" <tglx@linutronix.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 "Kees Cook" <keescook@chromium.org>,
 "Anna-Maria Gleixner" <anna-maria@linutronix.de>,
 "Matt Turner" <mattst88@gmail.com>, "Vineet Gupta" <vgupta@kernel.org>,
 "Russell King" <linux@armlinux.org.uk>,
 "Catalin Marinas" <catalin.marinas@arm.com>, guoren <guoren@kernel.org>,
 "Brian Cain" <bcain@quicinc.com>, "Huacai Chen" <chenhuacai@kernel.org>,
 "Michal Simek" <monstr@monstr.eu>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Helge Deller" <deller@gmx.de>, "Michael Ellerman" <mpe@ellerman.id.au>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Richard Weinberger" <richard@nod.at>, x86@kernel.org,
 "Max Filippov" <jcmvbkbc@gmail.com>, "Andy Lutomirski" <luto@kernel.org>,
 "Jan Kiszka" <jan.kiszka@siemens.com>,
 "Kieran Bingham" <kbingham@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org
Subject: Re: [PATCH 1/4] arch: consolidate existing CONFIG_PAGE_SIZE_*KB definitions
Content-Type: text/plain

On Tue, Feb 27, 2024, at 09:45, Geert Uytterhoeven wrote:
>
>> +config PAGE_SIZE_4KB
>> +       bool "4KB pages"
>
> Now you got rid of the 4000-byte ("4kB") pages and friends, please
> do not replace these by Kelvin-bytes, and use the official binary
> prefixes => "4 KiB".
>

Done, thanks.

    Arnd

