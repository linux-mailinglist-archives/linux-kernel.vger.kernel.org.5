Return-Path: <linux-kernel+bounces-129418-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDA9896A7A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9A4B288BF7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25EB131E21;
	Wed,  3 Apr 2024 09:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="PtJtB1dm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EsRWW1ju"
Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C56130A64;
	Wed,  3 Apr 2024 09:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712136406; cv=none; b=KUNX7nSUnnbVZm4zyMOGlBcmglF3q1jFLmZHxFATgsmRpphR8DXywdGnpGrAEl1JEYjavDNDliUTJ8xtyqKu74WD9kLkTdjCgFtiVG9v9dpNQQE1NOEINE42n+aqVwRAUGUzS+ri5zLb2Uuo/McpyXQZcYOrtTAtN+nlumhKoNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712136406; c=relaxed/simple;
	bh=OnzHOLxE9cGGrMoPCNcuh88lhK2VsicsUp4hhGm9Yqc=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=pytury1kQSEZGFUnfblcnFp8z5QnNkLoyPSGe30lFMvBeanpSxG66+t2cVFo7Sqz8sfjK6gclb2fEtwcXRcNjzeqPQnpnXI1mDp4BMa5vCz5PpwSbB1x2JFy6lwKwnkL2wYqfHrvEP8JqAzzzoSyKZbyoTHmwAZoMBdYeKeFNUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=PtJtB1dm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EsRWW1ju; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5E00213800E0;
	Wed,  3 Apr 2024 05:26:44 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 03 Apr 2024 05:26:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1712136404; x=1712222804; bh=lrKIW/ayI9
	01WrmRB98tv8lHGvgkZ0yaZoAqI6em5QI=; b=PtJtB1dmh2NwvDakpz3s2u1BTe
	wEL4Rqofvcqp33jqvbs9k+P9b/6uRUYZ57euE97PEh03im9DzrKriPFe0MtUITM3
	zBXgbFsBTGCw7e9ObkxNHzJhfSSKa0oFmpDlJtJFtJRomiF6gPNv+rWCoZU7ipYr
	U42JvORDCIO4EBxN730+Tg/ig14C3OMf9ZUlM8TGhtjS7GbWrVmrzK0sCN2KwJ7v
	r7dXNkAC0SdQ30h1Xw1pcisPsO5SLURFqGwccHNBcTEBx4EBdADQpCequf2kQwcQ
	Btjr+No/gl62oEWGY5J0+Djr9QBfQGEZwRVw7Y36BvOMeKucV/FY5z9Ub/NA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712136404; x=1712222804; bh=lrKIW/ayI901WrmRB98tv8lHGvgk
	Z0yaZoAqI6em5QI=; b=EsRWW1jugPG0g6BJeoM5LQhyD17/rZAbOXYCM+JE+OR6
	rUTavQ7atBJxTjD0Wnn4fokzC8q+PdzyRegfKsJgIDCBUvrLo9oKAx5Nb5L3ATEO
	fiKP8Wy4y9/csYHvXDmoVJEY+Jc6L6UOnV/zifRO7ExeI3IEkjE15sfW5WIScVm4
	nWAWGsMRmTxnASFWEaz3C0cuQItyf/RGGcCLu0Yv4qkIe/ul98U9KXFbRT57B4cQ
	shV8oRGvC5EnL4I8PQVoAhsTiFi1kZBZb1YZbFqGZobSEUTisHWbeStxnlpvBUdd
	IwzGjEi52qr6EYZYVyusiK3EOauyLhobOO7NE6x51A==
X-ME-Sender: <xms:0yANZuQVd-JkGAyCv7guqQBg1yyNUwQaFkIfz3fWF03G0a2__SEAGQ>
    <xme:0yANZjxGhZgE_vwfKYDLZaL8QxM1KVTmiIIlTVG01fvF8RtHOEsBwaZcp8ChOaymL
    -i1LHe9i1TOVbdquik>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefgedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepvefhffeltdegheeffffhtdegvdehjedtgfekueevgfduffettedtkeekueef
    hedunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:0yANZr0niWy4gj-Wx93-ROH-wuDnV_CRDn_4Z_eUY-bW2AukOokmNQ>
    <xmx:0yANZqAlOT2DNj-hZfjWQ5wNHFIozvSVOURlbdCGYU5PxqEduap5kQ>
    <xmx:0yANZniJ5hQrlsEkvDp_-yB_7DusVcCrTGkJ4zT1wknVkJCEKCWbAA>
    <xmx:0yANZmr0MFFAxFeeXM0WIMFHS3kF0wqQ8JaeVcujvPK8WN_FZyW0yA>
    <xmx:1CANZnjX_AlxD928gaGSjDWOF47l4JU_4Bn3U0fSIiHOxubCObY8Cssp>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 193E5B6008F; Wed,  3 Apr 2024 05:26:43 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-333-gbfea15422e-fm-20240327.001-gbfea1542
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b66e2d49-37db-4262-91c0-dfd76c12ca24@app.fastmail.com>
In-Reply-To: <Zg0fJPx_LTXAWT_I@smile.fi.intel.com>
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-35-arnd@kernel.org>
 <Zg0fJPx_LTXAWT_I@smile.fi.intel.com>
Date: Wed, 03 Apr 2024 11:26:22 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Andy Shevchenko" <andriy.shevchenko@intel.com>,
 "Arnd Bergmann" <arnd@kernel.org>
Cc: linux-kernel@vger.kernel.org, "Masahiro Yamada" <masahiroy@kernel.org>,
 "Nathan Chancellor" <nathan@kernel.org>,
 "Nicolas Schier" <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 34/34] kbuild: always enable -Wunused-const-variable
Content-Type: text/plain

On Wed, Apr 3, 2024, at 11:19, Andy Shevchenko wrote:
> On Wed, Apr 03, 2024 at 10:06:52AM +0200, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The last such warnings are fixed now, so the option can be enabled by default.
>
>> @@ -96,7 +96,6 @@ else
>>  # Some diagnostics enabled by default are noisy.
>>  # Suppress them by using -Wno... except for W=1.
>>  KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
>> -KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)
>>  KBUILD_CFLAGS += $(call cc-disable-warning, packed-not-aligned)
>>  KBUILD_CFLAGS += $(call cc-disable-warning, format-overflow)
>
> What about line #43 in this file?
>
> Citing 40-43 below:
>
> # These warnings generated too much noise in a regular build.
> # Use make W=1 to enable them (see scripts/Makefile.extrawarn)
> KBUILD_CFLAGS += $(call cc-disable-warning, unused-but-set-variable)
> KBUILD_CFLAGS += $(call cc-disable-warning, unused-const-variable)

I sent a patch to simplify this earlier, the -Wunused-const-variable
series is based on that, but I kept it separate since I think the
33 patches will take a couple of revisions while the first series
should make it into v6.10:

https://lore.kernel.org/lkml/20240326145140.3257163-3-arnd@kernel.org/

      Arnd

