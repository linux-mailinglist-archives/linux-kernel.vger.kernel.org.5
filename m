Return-Path: <linux-kernel+bounces-106558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0187D87F044
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:14:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935781F21F5D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE6A56B6E;
	Mon, 18 Mar 2024 19:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="orIhn1/d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9FE458209;
	Mon, 18 Mar 2024 19:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710789208; cv=none; b=L5LrjsPCi9w+C1u9yQW/75Def3lrQd6fv5ln3sJjye+tvVD2CsP+s490Uhnx+rMifAxewKHS725KMGOKnMoackOo4NKKEiDp3rEPIUIHg9KhrDB5F/pgdzpaOLhDYQN7+WOA5YJpuvvi6CwhYLCHgWuF2QFBFHeDsmCXo7iRb60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710789208; c=relaxed/simple;
	bh=g3OpJ2WmV+FZJE+8M2WBoafZTplReYZUKjMO+eX5RQI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=jSFpEzDUVlhIS/AwpNlMILQPlF/lAXf+swvHLKlMzmzuVe0EhKzSaic6zGQvrOZJbwOdAGY1E7XWYAYfT96jM/4FmlMft+OQuRyji0VBFFy14xdMMXZNj44zp6kGqomHjRiAbETeDUGOHrgewfWwUaY2mNfV87sinM0U04hio2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=orIhn1/d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62E5C43394;
	Mon, 18 Mar 2024 19:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710789208;
	bh=g3OpJ2WmV+FZJE+8M2WBoafZTplReYZUKjMO+eX5RQI=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=orIhn1/dm1QGLuuhDj7vCaZPAhboHKV2GIrsPlJ4yErZMbGHt/MV+xtdIcBsXeqgW
	 xtGbFgWviOV6m6L7On19eE0d2TH2t4xS8bp13wfPxn+FbCO6A0QrbiG9jPTRXcgVwm
	 YF1MmFcCTINK8o/P935lRfAwWZudiU6wE6XYzgwEpJy96+i4bBOLTedH6aBro6sih2
	 QBCALxs6KkUnvg0orvLXnGHfy0XotTvvd0vF86+ym8TvjgIKpYo0P2PPkql4qPU9p8
	 iuWrKSL9tv+Iyzapl2HfNNU2m0+aazVQ5s4KXEepSO/hEQRu2lZ1IC4eoO8Ro027Et
	 o4ndfozFFFx1g==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id E1E871200068;
	Mon, 18 Mar 2024 15:13:26 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 18 Mar 2024 15:13:26 -0400
X-ME-Sender: <xms:VpL4Zc7DTVO6ahUR0C9nfK2uduZB3NQfsrgeXbkzlnqPDk5YfPvmbg>
    <xme:VpL4Zd6O5cOkq6HLsB9lOkX-P7PzZQCys-sUS0d-EbQ-D_wmqaHGGzLThbRuNX5fP
    GY4za1G9xV2nYlLwdE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrkeejgdduvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusehkvghrnhgvlhdrohhrgheqnecuggftrf
    grthhtvghrnhepvdeviefgtedugeevieelvdfgveeuvdfgteegfeeiieejjeffgeeghedu
    gedtveehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    eprghrnhguodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduvdekhedujedt
    vdegqddvkeejtddtvdeigedqrghrnhgupeepkhgvrhhnvghlrdhorhhgsegrrhhnuggsrd
    guvg
X-ME-Proxy: <xmx:VpL4ZbegIdepxIWufOinCPkBfB4L8_nx0q3zvyYmW2EGHaeRunzsww>
    <xmx:VpL4ZRJETe_p4fLlkhXwG8h2dUtsojHdPJopkPfB7yCxjn0B7ersRg>
    <xmx:VpL4ZQLs6ee0IHf962xtLGamYz7DDVtHUAudLz8v_oeTzhkqXZY7aw>
    <xmx:VpL4ZSzlYbekp-yod14FwOsZ9AYMr2rUoKbBJLbj8RYcsI-P6rHkzQ>
    <xmx:VpL4Zf8kZo1mD7qofWIED-qSjq5LzD2bc5er9Nn8rGX1IHBT9WT0HXvAG_Y>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 48FC7B6008D; Mon, 18 Mar 2024 15:13:26 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-300-gdee1775a43-fm-20240315.001-gdee1775a
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <28ceb124-b634-44e0-bcd4-848fc3b0be7a@app.fastmail.com>
In-Reply-To: <87le6fih5w.ffs@tglx>
References: <20240303235029.555787150@linutronix.de>
 <20240304005104.622511517@linutronix.de>
 <e20d88d0-5fb9-4307-be67-88b04ae9a188@roeck-us.net>
 <CAHk-=whK=G1o6RtS9DS3wEGF1KU7WLgLL1+6Se86bj8m7wwqrQ@mail.gmail.com>
 <87y1ajjsv9.ffs@tglx> <87o7bfjeae.ffs@tglx>
 <CAHk-=wiP+XMGHr8NU13sSOG_oasNZN02O9_c1PzCJNG7+O-GPw@mail.gmail.com>
 <877ci3j80k.ffs@tglx> <87le6fih5w.ffs@tglx>
Date: Mon, 18 Mar 2024 20:13:05 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Thomas Gleixner" <tglx@linutronix.de>,
 "Linus Torvalds" <torvalds@linuxfoundation.org>
Cc: "Guenter Roeck" <linux@roeck-us.net>, LKML <linux-kernel@vger.kernel.org>,
 x86@kernel.org, "Uros Bizjak" <ubizjak@gmail.com>,
 linux-sparse@vger.kernel.org, "kernel test robot" <lkp@intel.com>,
 oe-kbuild-all@lists.linux.dev
Subject: Re: [patch 5/9] x86: Cure per CPU madness on UP
Content-Type: text/plain

On Mon, Mar 18, 2024, at 18:27, Thomas Gleixner wrote:
> On Sat, Mar 16 2024 at 02:11, Thomas Gleixner wrote:
>> On Fri, Mar 15 2024 at 16:23, Linus Torvalds wrote:
>> The amount of subtle SMP=n fallout has been kinda exponentially
>> increasing over the years and it's just putting burden on the wrong
>> people. TBH, I'm tired of this nonsense.
>
> And for the fun of it I hacked Kconfig to allow a SMP=y NR_CPUS=1 build
> and checked the size of vmlinux:
>
>                 64-bit          32-bit
> SMP, NCPUS=1    38438400        22110177
> UP              38393703        21682041
> Delta              44697          428076
>                      0.1%              2%              
>
> The UP savings are not really impressive...
>
> Let me look what it actually takes to do that.

FWIW, I did some experiments a few weeks ago on 32-bit ARM,
using a fairly minimal kernel in a virtual machine, and
checking the runtime memory consumption rather than compile-time.
In a kvm guest with 32MiB RAM, I saw a difference of multiple
megabytes in memory usage:

Linux testvm 6.8.0-rc4-00410-gc02197fc9076-dirty #1 SMP PREEMPT armv7l
root@testvm:~# free
           	total   used    free  	shared  buff/cache   available
Mem:       	26932   14956   1732   	    52       12800   	11976
Swap:      	16360    3632   12728

Linux testvm 6.8.0-rc4-00410-gc02197fc9076-dirty #2 PREEMPT armv7l
root@testvm:~# free
           	total    used  	free  	shared  buff/cache   available
Mem:       	26932   13744  	5648        32       10092   	13188
Swap:      	16360    3880  	12480

There is a little difference between runs, but this does seem
significant enough to keep it. The SMP build was with
CONFIG_NR_CPUS=2 (the smallest supported compile-time number),
but running on a single-CPU qemu instance.

      Arnd

