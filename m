Return-Path: <linux-kernel+bounces-146814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EBF8A6B61
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 387A4B22188
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9DA012BEA9;
	Tue, 16 Apr 2024 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="pVcTVtmj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LZ+aO9Qj"
Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AFC12B153
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271494; cv=none; b=LHzvOOZhwZhGmkOr1EhPstR3wjdfZqwqDIcgpmGCUGBnjvkOFKPqZGfng/xQh35KP7mJ2M+Pz6D9NLzGPrLTYXmM/uTl8nhTdBdOXkgag5OTSL/lIZObQUwyL8m5DJx4rOxh+ZWF5ADxEPuxjp5ilbUUKvt105DGEl+Nomv1rxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271494; c=relaxed/simple;
	bh=eGEqkDoDAbn8qTwoaTu0Qw3WSxz0Od5NaS3D29YNg3g=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Q79B1PSvjq9hQISJzRoyyzWw9SgM86dmtX5y6M0Td/EVz9ZwTpp7wrNx0gPuFFr7pMD5fi8S2BJadqBQCYWMfLDjvC0bqhxwDlqIrAYxKYUsfsnU7nKTkGsJtgHVaabXmYKl8W8ipH0cV6x6AFY+7qjsOHr1VXo757oVtq9jzio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=pVcTVtmj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LZ+aO9Qj; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 3E4D31800087;
	Tue, 16 Apr 2024 08:44:51 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 16 Apr 2024 08:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713271490; x=1713357890; bh=oGZePYwsWO
	VhZKwH1GR51uFtjQyrsePZBjAOKUqbZLs=; b=pVcTVtmjxtvFC8kZ6qWmyHaaED
	A6Exub6aGKVWfpb15KefIzyAAo1IB5Chf40nbQOjw7PrcPMHTpOkSRpDcFzEd0Z/
	mZttWXvB6AXzwTtAvh2QklgFD68b6ksl+D9ypUOIdqe+uzYREbrXW5/O5zZzKZzg
	22hsTFNROsWN8vUY0DP2W3LRfW5SCwpw4mn7hWZ/qj2ZD19CLJos9zFd2UF3DGcf
	DmOrQR39bYMJ3rr7TgKOjF5Qmz+JTvOiiaPLoHBoKYbVFGSZXlrBXQiFgYzd8lT3
	a33Lfw1ZwuIGb9ZG+xCRvWdAvSDU5K5gqw4O23biWpFix0sQgheizH4gRt+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1713271490; x=1713357890; bh=oGZePYwsWOVhZKwH1GR51uFtjQyr
	sePZBjAOKUqbZLs=; b=LZ+aO9Qjhayseh7KTOjsLZkbnBOwOEQj3s8KcX/3hfdE
	v7C0qB709QB7wBB2oSO8LmwWo9Cye1x5tYAEwLyB6OlBT9vTNq/Cyz9zI+ioMKuq
	hyg/mAxBW6q84OwQi3ntHm/joLEbIxaBNdfbXUq1IOzSOBMfLICSXGnpN/Ge2I+O
	0CPHFT7T9ovFOeoUQRFuW2JsMcpA3WXvpbRQVuCsfl0X5w4+nFJ1XJPhXOVwYO/q
	RHgsze+mfkthHIMJvJ4r0CGYq4iOY+qhX66izKUH+BuKTC+C9tzz233RhXATsPQ7
	15E9Pyae0B10xoei8RqTD3wiIbcCdZLeeY5tT7sU7A==
X-ME-Sender: <xms:wnIeZm6-5_rExLHO91NOsIHVOjfOUXbE_O-G6yFMIfb9ecbdFjlKNg>
    <xme:wnIeZv4EIUOoc2ZAAj3Rd8KcMKbNGSl2qP3lRayou9yz5u52YB39QBwBlAHPdPdPE
    nfunvuGgH6q78NTpQ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejhedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:wnIeZlesExV9ephhROrmbSVBPchUpIPf3YRMIcHa6-ACWe1cb7CjOQ>
    <xmx:wnIeZjL3TT24ypPUBq7j4n963rrL3zTTbM-rXz2Wdk9TieuLKsf90Q>
    <xmx:wnIeZqLwpKAnNG9gB65Y1vHTpVZPpwLuqxVkCKHyXvqY67CL2HQODA>
    <xmx:wnIeZkydqmjP-uNJAp2G9iV1cZeyUZa9fTzPP7MPFJntwTeDW88OIg>
    <xmx:wnIeZsgZ7SC0ArpdgCdu8qbzOypXw1O2n8V_Wy1pe1FGoSeiEGIGvx_S>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 74B5FB6008F; Tue, 16 Apr 2024 08:44:50 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-379-gabd37849b7-fm-20240408.001-gabd37849
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d409712b-6fca-4571-8fe0-1da8c4ab769b@app.fastmail.com>
In-Reply-To: <402a5e3b-bdb5-40a4-8a44-2de497849c3f@moroto.mountain>
References: 
 <CA+G9fYtEh8zmq8k8wE-8RZwW-Qr927RLTn+KqGnq1F=ptaaNsA@mail.gmail.com>
 <3d139886-9549-4384-918a-2d18480eb758@app.fastmail.com>
 <f7d8cd55-5a14-4391-884f-0b072790fa41@app.fastmail.com>
 <402a5e3b-bdb5-40a4-8a44-2de497849c3f@moroto.mountain>
Date: Tue, 16 Apr 2024 14:44:30 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Dan Carpenter" <dan.carpenter@linaro.org>
Cc: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "open list" <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 "Linux Regressions" <regressions@lists.linux.dev>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Kees Cook" <keescook@chromium.org>,
 "Niklas Schnelle" <schnelle@linux.ibm.com>,
 clang-built-linux <llvm@lists.linux.dev>,
 "Nick Desaulniers" <ndesaulniers@google.com>,
 "Nathan Chancellor" <nathan@kernel.org>, "Jeff Xu" <jeffxu@chromium.org>,
 "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Subject: Re: powerpc: io-defs.h:43:1: error: performing pointer arithmetic on a null
 pointer has undefined behavior [-Werror,-Wnull-pointer-arithmetic]
Content-Type: text/plain

On Tue, Apr 16, 2024, at 14:42, Dan Carpenter wrote:
> On Tue, Apr 16, 2024 at 01:55:57PM +0200, Arnd Bergmann wrote:
>> On Tue, Apr 16, 2024, at 13:01, Arnd Bergmann wrote:
>> > On Tue, Apr 16, 2024, at 11:32, Naresh Kamboju wrote:
>> >> The Powerpc clang builds failed due to following warnings / errors on the
>> >> Linux next-20240416 tag.
>> >>
>> >> Powerpc:
>> >>  - tqm8xx_defconfig + clang-17 - Failed
>> >>  - allnoconfig + clang-17 - Failed
>> >>  - tinyconfig + clang-17 - Failed
>> >>
>> >> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>> >
>> > I'm not sure why this showed up now, but there is a series from
>> > in progress that will avoid this in the future, as the same
>> > issue is present on a couple of other architectures.
>> >
>> 
>> I see now, it was introduced by my patch to turn on -Wextra
>> by default. I had tested that patch on all architectures
>> with allmodconfig and defconfig, but I did not test any
>> powerpc configs with PCI disabled.
>
> I think this warning is clang specific as well...  (Maybe clang was
> included in all architectures but I'm not sure).

Yes, I did test with both gcc and clang where supported.

     Arnd

