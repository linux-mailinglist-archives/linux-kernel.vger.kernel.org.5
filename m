Return-Path: <linux-kernel+bounces-153506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D0A88ACED5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:55:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01ED728122F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 431E3150989;
	Mon, 22 Apr 2024 13:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="WRbIBn01";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I0eKgKrD"
Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DE8746E;
	Mon, 22 Apr 2024 13:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713794117; cv=none; b=S2+TjAXwY1VktP9xP870oWsOAnP34mj5ncEj9A8R1Gt/gEs6TTew16spLuKKM5hniZRkzRH7Ow1vh04tTtEf4FzRxY8GBRWv7ho316ISMlhBdjr6gVdV0uFRIvRfufB6EXafRACloa2g6H8v7kZJ5bEm0r9jhRmnZm2sBg6ODi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713794117; c=relaxed/simple;
	bh=irpm+XTWC7lpray6M1vu8lG2iOt8Ck81X/W0w85ewx4=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=N13PE0ba4NlgMB3PJoDsyqb4OmyfjocYqxz4OChbMhLiuQdo0XV+yE6hNxoyJONxEZn3CyK8R8yd4Pmothkobtg9TKReBdT+DOuJ9fpRMCZpTthRPZ19jyIZyKgrRo6MJgGQdIfaJLypKm/3OV6hp5pwHXMmULUrGW3b75OuVA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=WRbIBn01; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I0eKgKrD; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 5D7F41C00146;
	Mon, 22 Apr 2024 09:55:12 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 22 Apr 2024 09:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1713794111; x=1713880511; bh=dP7QCkFa2V
	pxgbo7VoSL0Ax5/oZR8Zm98IoSxqALypA=; b=WRbIBn01+ZTKiwdI+kbkFZYLlv
	DbnR+igCrIB7pg54qU3/sgTfBzX+NzVL6avdBv6bphUJoNdjj7jOpOZpxxKERIq7
	g57eE3+jVN7sEvdXClIGbthIhtfYsoFAkawL8ABBdvlZcS1Hz3kS4yzsCDVYPOEI
	fanwNiqQKn2110G2Crq+hitaUYyhBm4ssTbX11RpWo/BHMfpjJsIneKgikBN1GF1
	bBxlHEb8Y6Kn7aGlDSY0b2iIyTVb9LHLBAsgt6SlbA7bUZV6zZ5W6v2IEERRYo0m
	W33EzoFqYC1otRExYN+GNZxQ/A1QKp+WzM5DthIRLqJARgMjEPbzxEFsE2Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1713794111; x=1713880511; bh=dP7QCkFa2Vpxgbo7VoSL0Ax5/oZR
	8Zm98IoSxqALypA=; b=I0eKgKrDC+E6gWxO9Me5fy3ATo2uFYlCdYRqCeoQwYws
	xUc9dl6JIznVsG15WXqt0I0nNvOQxQTT28LGv0jHohdbeZTIOvEY5ggcYfus7x5g
	vkYsN3cr9LyBlOcoCpTRNm3AY/cUal3W5RxWUHvsNDsUtLroudk9wQNG19f/pIJE
	Pl7ypDFzQCpjO+CNd95GC8LR0trRoUAo+SrI+R/qMmskTQdmRvP6k4UqbfwwZPwo
	9w2ig/DwiHEo+HXlCb/WP3+KRQF9i9sNcihRDBWJpX+ZQv6stxNgxkowxbZpLnBK
	+1kOpLGgZmgYV1016rjkgVhwJFoVFcRLf2Oxka0fDA==
X-ME-Sender: <xms:P2wmZiTuiP3S70d73RwJIoMICgdm4i2Ny2KzRLnUuzBApE4U8UZXrA>
    <xme:P2wmZnzZZwI5pA6NtoUHHJCPtcXjFBprwaCbQuHliF2ft4M_SU8LyXPM08-s1pKlk
    pf39IiyjQHFk77eZS4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudekledgjeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:P2wmZv1ZTVFKUSoQkTre2JiKFEekZNnItFIGuVO3knRED9JUFc6P-w>
    <xmx:P2wmZuAK6LxqZ6Y5xdvMrYZBoPWohQBIbcZssMc0-kSlatRSZAWoRw>
    <xmx:P2wmZrilVWsz7DLaux6VO4KX5RyIaMbD3gJw3mMd8F9Mc82K9ucgkQ>
    <xmx:P2wmZqp74Xz4FQAnYl0B0SqA783ctvB8DfSQTvXDr8NYLq6VDDdwRQ>
    <xmx:P2wmZqOjldHJblvtYtnnBYvnJTLvlm4ouUbZe5jP52ax7Wfv4bfp1HnE>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id E1310B60092; Mon, 22 Apr 2024 09:55:10 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-386-g4cb8e397f9-fm-20240415.001-g4cb8e397
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <af6e26d1-1402-4ed2-a650-b58eae77273e@app.fastmail.com>
In-Reply-To: <875xw9ttl6.fsf@intel.com>
References: <cover.1713780345.git.geert+renesas@glider.be>
 <87il09ty4u.fsf@intel.com>
 <ff4f9e8f-0825-4421-adf9-e3914b108da7@app.fastmail.com>
 <875xw9ttl6.fsf@intel.com>
Date: Mon, 22 Apr 2024 15:54:50 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Jani Nikula" <jani.nikula@linux.intel.com>,
 "Geert Uytterhoeven" <geert+renesas@glider.be>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
 "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Dave Airlie" <airlied@gmail.com>,
 "Daniel Vetter" <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH 00/11] drm: Restore helper usability
Content-Type: text/plain

On Mon, Apr 22, 2024, at 15:28, Jani Nikula wrote:
> On Mon, 22 Apr 2024, "Arnd Bergmann" <arnd@arndb.de> wrote:
>> On Mon, Apr 22, 2024, at 13:50, Jani Nikula wrote:
>>
>>> I still disagree with this, because fundamentally the source symbol
>>> really should not have to care about the dependencies of the target
>>> symbol.
>>
>> Sorry you missed the IRC discussion on #armlinux, we should have
>> included you as well since you applied the original patch.
>>
>> I think the reason for this revert is a bit more nuanced than
>> just the usability problem. Sorry if I'm dragging this out too
>> much, but I want to be sure that two points come across:
>>
>> 1. There is a semantic problem that is mostly subjective, but
>>    with the naming as "helper", I generally expect it as a hidden
>>    symbol that gets selected by its users, while calling same module
>>    "feature" would be something that is user-enabled and that
>>    other modules depend on. Both ways are commonly used in the
>>    kernel and are not mistakes on their own.
>
> Fair enough. I believe for (optional) "feature" the common pattern would
> then be depends on FEATURE || FEATURE=n.
>
>> 2. Using "select" on user visible symbols that have dependencies
>>    is a common source for bugs, and this is is a problem in
>>    drivers/gpu/drm more than elsewhere in the kernel, as these
>>    drivers traditionally select entire subsystems or drivers
>>    (I2C, VIRTIO, INPUT, ACPI_WMI, BACKLIGHT_CLASS_DEVICE,
>>    POWER_SUPPLY, SND_PCM, INTERCONNECT, ...). This regularly
>>    leads to circular dependencies and we should fix all of them.
>
> What annoys me is that the fixes tend to fall in two categories:
>
> - Play catch with selecting the dependencies of the selected
>   symbols. "depends on" handles this recursively, while select does
>   not.

I'm not sure where this misunderstanding comes from, as you
seem to be repeating the same incorrect assumption about
how select works that Maxime wrote in his changelog. To clarify,
this works exactly as one would expect:

config HELPER_A
       tristate

config HELPER_B
       tristate
       select HELPER_A

config DRIVER
       tristate "Turn on the driver and the helpers it uses"
       select HELPER_B # this recursively selects HELPER_A

Whereas this one is broken:

config FEATURE_A
       tristate "user visible if I2C is enabled"
       depends on I2C

config HELPER_B
       tristate # hidden
       select FEATURE_A

config DRIVER
       tristate "This driver is broken if I2C is disabled"
       select HELPER_B

>   There is no end to this, it just goes on and on, as the
>   dependencies of the selected symbols change over time. Often the
>   selects require unintuitive if patterns that are about the
>   implementation details of the symbol being selected.

Agreed, that is the problem I frequently face with drivers/gpu/drm,
and most of the time it can only be solved by rewriting the whole
system to not select user-visible symbol at all.

Using 'depends on' by itself is unfortunately not enough to
avoid /all/ the problems. See e.g. today's failure

config DRM_DISPLAY_HELPER
       tristate "DRM Display Helpers"
       default y

config DRM_DISPLAY_DP_HELPER
       bool "DRM DisplayPort Helpers"
       depends on DRM_DISPLAY_HELPER

config DRM_PANEL_LG_SW43408
       tristate "LG SW43408 panel"
       depends on DRM_DISPLAY_DP_HELPER

This version is still broken for DRM_DISPLAY_HELPER=m,
DRM_DISPLAY_DP_HELPER=m, DRM_PANEL_LG_SW43408=y because
the dependency on the bool symbol is not enough to
ensure that DRM_DISPLAY_HELPER is also built-in, so you
still need explicit dependencies on both
DRM_DISPLAY_HELPER and DRM_DISPLAY_DP_HELPER in the users.

This can be solved by making DRM_DISPLAY_DP_HELPER a
tristate symbol and adjusting the #ifdef checks and
Makefile logic accordingly, which is exactly what you'd
need to do to make it work with 'select' as well.

> - Brush the invalid configs under the rug by using IS_REACHABLE(),
>   switching from a loud link time failure to a silent runtime
>   failure. (I regularly reject patches adding IS_REACHABLE() to i915,
>   because from my pov e.g. i915=y backlight=m is an invalid
>   configuration that the user shouldn't have to debug at runtime. But I
>   can't express that in kconfig while everyone selects backlight.)

Thanks a lot for rejecting the IS_REACHABLE() patches, it is
indeed the worst way to handle those (I know, as I introduced
IS_REACHABLE() only to replace open-coded versions of the same,
not to have it as a feature or to use it in new code).

> If you have other ideas how these should be fixed, I'm all ears.
>
>>    The display helpers however don't have this problem because
>>    they do not have any dependencies outside of drivers/gpu/
>
> Fair enough, though I think they still suffer from some of them having
> dependencies. (Wasn't this how the original patches and the debate all
> got started?)

I believe that Maxime said on IRC that he only did the patches
originally because he expected problems with them based on his
understanding on how Kconfig works. I'm not aware of any
particular problem here.

Let me know if you see a problem with any of the symbols that
Geert has proposed for reverting, and I'll try to find a solution.
In my randconfig test environment, I have several patches that
I sent in the past to clean up the ACPI_VIDEO, I2C, BACKLIGHT and
LED dependencies to stop using 'select' as I could not otherwise
get nouveau, i915 and xe to build reliably, but that means I
may be missing some of the other problems.

     Arnd

