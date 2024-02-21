Return-Path: <linux-kernel+bounces-75514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD7385E9E9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A48BDB255B7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85967126F3A;
	Wed, 21 Feb 2024 21:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="p2nuTRVx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PfKbLvBo"
Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7399F2C18E;
	Wed, 21 Feb 2024 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708550355; cv=none; b=gXFCkBlau/xB8Zf4S4QR8kLK3p4QgCIguhGlHi5A3TRrGb2YmabiDeikX7sgIsDw0+ed5RHy0GqMlgo9loRXM+DtyGF7GDeATYA68Csxw3clD7c9xNo0/+aCSUOrVCcJTUqNZt+gE16ka6+g0dQnLqIfzZiv0MpDBXyHYLzwd5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708550355; c=relaxed/simple;
	bh=97X9vWwElDBX2j+7AkouVd7P/8mxG1iKOcNpP9Ha5DI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=sMYMF3ilZgz8wU/eXGT0crR7CUeu8UfVaSkBUoSej/OlVYoEcvKpB9oYO+uibPYfN0sT9GTEQ6pBIaJOsWYcyboudT/ncJVxUYcVg/N2GSBPLEvb5MSGFl3bS20USjUV5OCBGvIniThcCp4/kriTLqaKoYxEpGCuz1vaCq0NABY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=p2nuTRVx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PfKbLvBo; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id CFC0818000C6;
	Wed, 21 Feb 2024 16:19:11 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 21 Feb 2024 16:19:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1708550351; x=1708636751; bh=r5OGsN9UUZ
	xaDhhopAOc2ckMG2rKraRBsXkdO5Q3UJM=; b=p2nuTRVxazqjgMtkddeKF2/BGy
	nY+19BeJH6MraCPXmMaO9UviPpzc1vEjiDb4pB3CEZIqWVr4nDp5XYGhZ7akBbl3
	XHd9t2mYl3lGWqAoGLm9hSfJOzqbshWjAG2XR4TZF15v92BOe9SvGTJJ7474zuy1
	iWXngUP90xvlp5uDl21Vz3KFEP5FJ1KdQNWFqW6B/AJCjzW9Ivl1RANka8hHdscx
	J5Z/1cW+It1J4DiplDVo2lJut3eSeG1tzFUaD8l6lqVFvHH5psqtti3y9xAzu6dV
	R+EgJD8DlGB7QL8KC+Kk7tcRqgateu7CogSwQXS7RD6kvOnFAQESAJjUyC2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708550351; x=1708636751; bh=r5OGsN9UUZxaDhhopAOc2ckMG2rK
	raRBsXkdO5Q3UJM=; b=PfKbLvBoe5cowpxrCZiKN3mfjKFFqeacoaMne4KCAndi
	eFFYw6nLrymTKwONTwhvZEYwXKWv9idIECwcDGiSYempMKOQ46V7RNqr0DDC+vsi
	fWWlVPLz/ics7aXk+/QcK3gYqScuXgy091uXc70t/pViXrzR3Ft9FNCsUEOmjgt+
	GflPw5Aa0wRNrdkl4lpz2jP5yE5FQTbreRCMANg1tXX8AUEsdZaMvmwZkXlocqfN
	r9XvZ8roCqc8B5T8GtXvRptG8rUPFn2LX6vxoRV9iwoSXULgGqen8iW4ucKiwkHB
	wOsjCwdXvLuwJZpdoqvsl9TqYHoQ7npE5jRrVhqUVA==
X-ME-Sender: <xms:zmjWZdsVAvc3hzdToQ3l2CodkJ_Kez8Q0NJcyb1qfje5FLRu7PpaKg>
    <xme:zmjWZWcsYGMnhilJG7d8DeLsQwdhEO-zxoeR7x5rvCZmya0P6-GV-lq1z95a9kSQL
    BMurtgarNzgcpL4QUI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfedvgddugeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:zmjWZQzKK_CKFR8jWTxFZe_VAv_GkKLSuu89sqRcoP-bf9u-Bf2hOQ>
    <xmx:zmjWZUM7H4onTOUFRfPZ8KioL5awqbMOGX6I_9f5pqhh_1TbEaklVg>
    <xmx:zmjWZd8xktaHQFYZT99VMRpVmZEwbsWCZmwG2iNsQgGOi--nNjRmjA>
    <xmx:z2jWZZRN0ZeBwKhFrpLVnLeIbhDyo25KsPsDLL3QqYg6L0AjGcD_i8p089A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id D00ECB6008F; Wed, 21 Feb 2024 16:19:10 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e33a59f7-cf0e-4b63-b994-752d1e77652a@app.fastmail.com>
In-Reply-To: <20240221202655.2423854-1-jannh@google.com>
References: <20240221202655.2423854-1-jannh@google.com>
Date: Wed, 21 Feb 2024 22:18:47 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jann Horn" <jannh@google.com>,
 "Andrew Morton" <akpm@linux-foundation.org>
Cc: "Masahiro Yamada" <masahiroy@kernel.org>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Zhen Lei" <thunder.leizhen@huawei.com>,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH 1/2] kallsyms: get rid of code for absolute kallsyms
Content-Type: text/plain

On Wed, Feb 21, 2024, at 21:26, Jann Horn wrote:
> To compile code for absolute kallsyms, you had to turn off
> KALLSYMS_BASE_RELATIVE. I think based on the way it was declared in
> Kconfig (without a string after "bool"), it wasn't even possible to
> select it.
>
> Get rid of this config option, as preparation for some kallsyms
> optimizations that would otherwise be infeasible.
>
> Signed-off-by: Jann Horn <jannh@google.com>

Nice catch!

The code was needed until cf8e8658100d ("arch: Remove
Itanium (IA-64) architecture"), and we missed that this
allowed the cleanup you now did.

Acked-by: Arnd Bergmann <arnd@arndb.de>

     Arnd

