Return-Path: <linux-kernel+bounces-120608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB96A88DA32
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EEFDB21E3C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1082D381B0;
	Wed, 27 Mar 2024 09:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="Bv3ns0y1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aObx3p/a"
Received: from wfout7-smtp.messagingengine.com (wfout7-smtp.messagingengine.com [64.147.123.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B523A28B;
	Wed, 27 Mar 2024 09:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711531381; cv=none; b=uuYF4UVE5Sq1ph3Z+aDdlVmnjVnuLbVguuEiIdbQyMDiu1FNyk0nQZWZLTcZn5iJuJhcOIUFLnS8z0nPqaQQw5MIxn7VXilRoYsUN84zGrOjZ90eRl8HFxGANtI/KMye/gF0KlScdn83Rwu7WcFoZw2yWL7SIJm9sE4lrc8rbEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711531381; c=relaxed/simple;
	bh=Re5z3X7pBCz94DmXmRZdc2lzjhrBFzVyIsdRv3vt234=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=SSfa/X2mL4VT1HI0Sd9SeYrTbYPOkSLV4IAOVxdpyQu3UXsFROEmgt1De3AO9BHJ0h28ebJkepoXTy2GK2y/z/2RP0ehqe9Y10ixq9nE45ZL9i+GWQR+WrxqsUi08a61CjKkqd0TzbMB00NBLfqHATUR5dybNdHVyVx0P7UTmpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=Bv3ns0y1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aObx3p/a; arc=none smtp.client-ip=64.147.123.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 75B211C0009D;
	Wed, 27 Mar 2024 05:22:55 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 27 Mar 2024 05:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1711531374; x=1711617774; bh=EuhV5oR6Xt
	SBm/DNGntleXF/S1OUvOHdAvFWPaD79QY=; b=Bv3ns0y1U+nkyPBufPGObdsdvq
	tGcjRODX8qHyjeFkM6QI8p1JG2xCNygnPoylEshDObtoBG8H8DPPssjVQO+tnrCX
	8nc2Q9w1WDCm0XAtSPX1c0lsTvBKWIeDdiDXkd0n77aX7QKVHzpSg+p82aXHUQBE
	6ZaR8+h/ht9OqhBK3IkVvYQwzReKPkIJvCqwh5XLWb3808fQLIhGwjj8V0a29EEG
	USnt+sEy68Xqqt1ksCgih4o8+wZgc2KDrdDDuvKqcJrvycf7xtn0cEm7Ka8EKS+y
	y53NNvCOhx74w2dkUwx2iMPWrOeU4T+Gm4nTIZ2nEcmnNrax4PkNlGGzxhew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711531374; x=1711617774; bh=EuhV5oR6XtSBm/DNGntleXF/S1OU
	vOHdAvFWPaD79QY=; b=aObx3p/anYEx/+gNcxae1ppxtOMe0uoey9wDiYLRIgn5
	0EylZ+JJ4Zh3u/zvPwG7BTJm/a+ZKyn4h9PemfXBHLfH7inF8AayDY1FfS4ecXVy
	l6wSE9mxuVt/idSlWdnUMpmYgdc1DFWSKm21HVTth74FL9EIekLKI6TS1RUicdSC
	QNDHZYWerpygSJRPssHozwPA7fZfJCewMijK9+rOQ7lQ42NPctXa/JKu645yVwEJ
	MAoxQ+NNF7kc4crmgbwUvLSfQaXawZGJQ8ctKQI0EK16dkJsW1pE0TSDDMC3ZE8J
	s87QEcz4pTWxVCBBou9oadve43AGiESj0N1kOkgLZw==
X-ME-Sender: <xms:beUDZoUC1y0lQaZPUwlMgU2nEVXP7ErOHYi89K3dshUCC87x1_lw3Q>
    <xme:beUDZsmsYaFwr-YMg6bVARYbV2gIPNlVAG9HsPRyRx2p_Zg2TGO7mycwHJUjF3Fwk
    nYa2BeP9wUQXerpuk4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudduhedgtdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:beUDZsZ_fwYzTPkRd8ri3TN4glA4zeAXMpE0y0m8CoyYtU3Xh4yg4g>
    <xmx:beUDZnW3gBSej8EQ8HjifqdCr_iUGH_6ZSEYe5IlkHXl-4VPKB6fQg>
    <xmx:beUDZin_wDETtHzZou3o7e73zigpqXYCnmhfCA1fiLeWv3gcUTdbhw>
    <xmx:beUDZscWHt3wsD7uf-xIF5uIH21CCQqfn3gw6cNbkteTU5WyCLTErA>
    <xmx:buUDZg0z7rR8XfmmYBPhLjz1bLE_F2NQV-4beb7lU4qAMhFOb4x5cwSAekY>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5B925B6008D; Wed, 27 Mar 2024 05:22:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-328-gc998c829b7-fm-20240325.002-gc998c829
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <07c604d1-6304-4ff8-844b-03c3d5c727ad@app.fastmail.com>
In-Reply-To: <87edbwglle.fsf@intel.com>
References: <20240326144741.3094687-1-arnd@kernel.org>
 <20240326144741.3094687-2-arnd@kernel.org> <87jzlohhbc.fsf@intel.com>
 <cb853762-06d4-401c-a1c8-07a0c031b499@app.fastmail.com>
 <87edbwglle.fsf@intel.com>
Date: Wed, 27 Mar 2024 10:22:30 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jani Nikula" <jani.nikula@linux.intel.com>,
 "Arnd Bergmann" <arnd@kernel.org>, linux-kbuild@vger.kernel.org,
 "Masahiro Yamada" <masahiroy@kernel.org>,
 "Harry Wentland" <harry.wentland@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 "Lucas De Marchi" <lucas.demarchi@intel.com>,
 "Oded Gabbay" <ogabbay@kernel.org>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Andrew Jeffery" <andrew@codeconstruct.com.au>,
 "Linus Walleij" <linus.walleij@linaro.org>, "Joel Stanley" <joel@jms.id.au>,
 "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Nathan Chancellor" <nathan@kernel.org>
Cc: "Nicolas Schier" <nicolas@fjasle.eu>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
 linux-mm@kvack.org, llvm@lists.linux.dev
Subject: Re: [PATCH 01/12] kbuild: make -Woverride-init warnings more consistent
Content-Type: text/plain

On Wed, Mar 27, 2024, at 08:50, Jani Nikula wrote:
> On Tue, 26 Mar 2024, "Arnd Bergmann" <arnd@arndb.de> wrote:
>> On Tue, Mar 26, 2024, at 21:24, Jani Nikula wrote:
>>> On Tue, 26 Mar 2024, Arnd Bergmann <arnd@kernel.org> wrote:
>>
>> It works now.
>>
>> The original __diag_ignore_all() only did it for gcc-8 and above
>> because that was initially needed to suppress warnings that
>> got added in that version, but this was always a mistake.
>>
>> 689b097a06ba ("compiler-gcc: Suppress -Wmissing-prototypes
>> warning for all supported GCC") made it work correctly.
>
> Oh, nice! Then I think we'd like to go back to __diag_ignore_all() in
> i915 and xe.
>
> The diff is below. I'm fine with you squashing it to your patch, or if
> you want me to turn it into a proper patch for you to pick up in your
> series, that's fine too. Just let me know.

I think I'd prefer to keep my patch simpler for the moment and
get that merged through the kbuild tree, it already touches
too many places at once.

It may be better for me to just drop the drivers/gpu/ part of
my patch so you can just just take your patch through the
drm tree. I actually have a similar patch for the amdgpu driver
that I can send if you like this option better.

    Arnd

