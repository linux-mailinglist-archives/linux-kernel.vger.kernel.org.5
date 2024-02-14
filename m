Return-Path: <linux-kernel+bounces-65672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D5B855044
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:29:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 011F51C26400
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873A712837D;
	Wed, 14 Feb 2024 17:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="bFxtjj5V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dUQQDeNV"
Received: from wfout1-smtp.messagingengine.com (wfout1-smtp.messagingengine.com [64.147.123.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F84127B7E;
	Wed, 14 Feb 2024 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931410; cv=none; b=UcBW+L9N3mpETJ0rCJzOR/K/ySzO2xFzeGRBMIxFaPeAO9rquNu7EFi3zd0qjaFc351LMmTMNFT3WjI3mFTNpopHurARR0g1uNvwDA0noq47MAchtxGVQU5UYtQv+w4Z91/7fb9DqQoJhiU+T48Qk6NBzdizHhGfsiNRDP3eUMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931410; c=relaxed/simple;
	bh=gqEfZ2kRHvUVNQMPzyx6hDHwmUUqj5fHtD/Rz18BEQA=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=esSj04JcgiWd5ujaMa3u8IOLVcIbbqf8FNNgMbRvjd4WWm+LUfrolBqq/nil0pDqBbdGHSYL1gZ/r63DVFZY9WqfP2bj3t+FpO8ZhIPG4Yu6dyrBzDcQAUYr0HXpWxq1ILYbCfbx2bgjPJcVzKZdZXKpwSdJPj8SrMPDg+tL3sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=bFxtjj5V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dUQQDeNV; arc=none smtp.client-ip=64.147.123.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfout.west.internal (Postfix) with ESMTP id 82B9F1C00080;
	Wed, 14 Feb 2024 12:23:26 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 14 Feb 2024 12:23:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707931406; x=1708017806; bh=y+Eh983YcJ
	xk/dsxkD7Ix5UZbVz6STVGhdNqxRo7eIQ=; b=bFxtjj5V8SLfNb5SOG3mEwBNIg
	huUAMTfBUWmS+RH0DxnO5Sl8y8n49N4auwlAiC2H+UQNoj2z0v7Tvx1X+2GPja94
	S0Vq9SgAincNDRgTQXKTpW1WdLwOP/94PXVnxA9p3lJ60NmRu/BDQVmsWzIWlMBD
	WsLr6521qelYqIEk8OST89dNnl6sKKaC+F4+q3rxrUG8GDP5TQ+5r7/HXRPkTI+9
	9QrYVNAPKFPo8Y5gGESTOEWefMK6rMkHRTQwimqeat0ccu65T5p2/9VKvdgv7d8R
	5PLukkvfZ0yi/IsD0I11ZcLZ57RIDb4sDhqvDrWrL/FIxC4lo7rT0++RwqWQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707931406; x=1708017806; bh=y+Eh983YcJxk/dsxkD7Ix5UZbVz6
	STVGhdNqxRo7eIQ=; b=dUQQDeNVUjm/GXz7mWysde/xhg7E995GTiVH6hMf+5mq
	oHlw23juOB52LvdrLEuMBcFglFiPoZfCr7bM7jU1D4l8lEeA1/Ydc9CueT5YrTHx
	I+zkNxD5emIHQ1hDKQ9FIiDjl65mwWnIXbK2u+OXKNMIsqA9aKuOTmopkGj3x3fA
	04PtvchYkMmpJ4ag434tHI+DULvkl6ELnltH53lCXmS0s9B3EiEV9hONF60vBPLk
	/9B32MDWPAAzX3KFNi8mx+MXv41+DWLRPL8YWeykMwHWyua6Bi+T35v1gHY/gUpz
	TjiYIJNv2NtF7a38wxYDqkNL1Np3cgOPJURhk6zuPw==
X-ME-Sender: <xms:DffMZYtQPWQJfcRC1E8ded2J768DNWvDeK_-ah5oBJlIaYq3X51Hjg>
    <xme:DffMZVdJktaPxHkh9vTmVyKz7XfW2aYPHSlq2xWbtlnEsLGD84pPU1jnLUpMX2Sin
    zy-FBtaSIJT3IkdziA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudejgddutdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:DffMZTy8wc9ElqdfJvHVmUrRPQYxfiFzfaYwK8AsrXzkw0Lb2gdYtw>
    <xmx:DffMZbN5zlial-ID2wAyfZdzi5LpmSRLXQUcIcaa9Pc7amZ_GPyBlA>
    <xmx:DffMZY9niPhsoIsQxE-EiPCTCW3iL_mrIPM_ptFKYk5rje0KRqWuRA>
    <xmx:DvfMZVPXjG3WRzWJicu-jlrNuW9pfrH8JGCiityRjbfHiA_StKNP3q1xohs>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 5FA83B60092; Wed, 14 Feb 2024 12:23:25 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <886629be-a492-4c8c-aa79-d13847cb228a@app.fastmail.com>
In-Reply-To: <8634tv57i2.wl-maz@kernel.org>
References: <20240213225619.11726-1-rdunlap@infradead.org>
 <867cj75q52.wl-maz@kernel.org>
 <c6e55baf-4f0c-4342-971a-713ed55f5a51@app.fastmail.com>
 <8634tv57i2.wl-maz@kernel.org>
Date: Wed, 14 Feb 2024 18:22:53 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Marc Zyngier" <maz@kernel.org>
Cc: "Randy Dunlap" <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
 "Geert Uytterhoeven" <geert@linux-m68k.org>, "Rob Herring" <robh@kernel.org>,
 "Philipp Zabel" <p.zabel@pengutronix.de>, "Peter Rosin" <peda@axentia.se>,
 devicetree@vger.kernel.org
Subject: Re: [PATCH v2] of: OF_IRQ: select IRQ_DOMAIN instead of depending on it
Content-Type: text/plain

On Wed, Feb 14, 2024, at 17:35, Marc Zyngier wrote:
> On Wed, 14 Feb 2024 16:06:06 +0000,
> "Arnd Bergmann" <arnd@arndb.de> wrote:
>> 
>> On Wed, Feb 14, 2024, at 10:52, Marc Zyngier wrote:
>> > On Tue, 13 Feb 2024 22:56:19 +0000, Randy Dunlap <rdunlap@infradead.org> wrote:
>> >>
>> >> diff -- a/drivers/of/Kconfig b/drivers/of/Kconfig
>> >> --- a/drivers/of/Kconfig
>> >> +++ b/drivers/of/Kconfig
>> >> @@ -80,7 +80,8 @@ config OF_ADDRESS
>> >>  
>> >>  config OF_IRQ
>> >>  	def_bool y
>> >> -	depends on !SPARC && IRQ_DOMAIN
>> >> +	depends on !SPARC
>> >> +	select IRQ_DOMAIN
>> > 
>> >
>> > This seems to be moving is the right direction.
>> 
>> Can we move the 'select IRQ_DOMAIN' under CONFIG_IRQCHIP
>> then and remove the individual selects from the irqchip
>> drivers? It looks like CONFIG_OF (other than sparc) now
>> unconditionally enables OF_IRQ and IRQCHIP anyway.
>
> As long as it also works ACPI, it should be OK.

Out of the four architectures that have ACPI support (x86,
arm64, loongarch, rv64), only x86 doesn't always select
IRQ_DOMAIN already, and x86 selects it for almost all
configs:

config X86_UP_APIC
        bool "Local APIC support on uniprocessors" if !PCI_MSI
        default PCI_MSI
        depends on X86_32 && !SMP && !X86_32_NON_STANDARD

config X86_LOCAL_APIC
        def_bool y
        depends on X86_64 || SMP || X86_32_NON_STANDARD || X86_UP_APIC || PCI_MSI
        select IRQ_DOMAIN_HIERARCHY

so it's only disabled here with

CONFIG_64BIT=n
CONFIG_SMP=n
CONFIG_X86_32_NON_STANDARD=n
CONFIG_ACPI=y
CONFIG_PCI=y (implied by ACPI)
CONFIG_PCI_MSI=n

As far as I can tell, this specific configuration is
currently able to save a little bit of kernel size
by avoiding IRQ_DOMAIN, but we are probably better off
enabling it here as well for consistency

     Arnd

