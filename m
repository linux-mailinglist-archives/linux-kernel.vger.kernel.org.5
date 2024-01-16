Return-Path: <linux-kernel+bounces-26913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B9B782E7C2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6B2A1C210A9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183BE12B7B;
	Tue, 16 Jan 2024 01:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sakamocchi.jp header.i=@sakamocchi.jp header.b="fKHzEkzU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C8MS0Lvj"
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0FA1173F
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 01:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sakamocchi.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sakamocchi.jp
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.nyi.internal (Postfix) with ESMTP id 4424F5C008F;
	Mon, 15 Jan 2024 20:49:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 15 Jan 2024 20:49:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1705369792; x=
	1705456192; bh=KxitppHumM/i0dptyUHi/3WlX8ZzVJYfmUtn5jpMDEo=; b=f
	KHzEkzUWpfo9j/BvyKVQvlMUdaP8q2AGc+x+1bzK1/LMIkX3j0XsSZRyxYqb86rS
	NFTEisWQtSuvBVZ/DFaJKQfemyMqzS6drIr7NxVyWABDqWZ8VMV5FuYuNW5ATwTP
	zehbakqrb47lfeW0T+Tt8cpqVLVyK65fxPtfPyrz2avBEPocql/XDFe39brEeZSm
	VDMyftqk9V2K16QMAtBL0AsVD7olhlq2yfFRIWqnugoW23reLSMPiV8CNl74vim9
	mYEo3Os2zpFAcb1uzo9UhOd5LOBAA7srxoKQBgkdpaQOnIOAjRbi6ir7i6wiGq2P
	I9qhaacqAuCW6MXrR2z/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705369792; x=1705456192; bh=KxitppHumM/i0dptyUHi/3WlX8Zz
	VJYfmUtn5jpMDEo=; b=C8MS0Lvj6xtfi+1Q8F8zjdxMMfaxc/iJ2TKXDXLvydG2
	4VHygmsE0U14JkxneoZwGd7k9E3i1XjnV8SBm0CETevSy+XbbVOKGi4Y94/VnRtq
	1aERKgdZ6XA6rypjAaJxPk7OPKMzUizQ5eyG6i50Uq6qNck+VAOUJYaP2Wi/KaBK
	hx+AktrN96Fiomw29HTMREGCGR31wqbXYUFLq6oAsn/rL6xgQOjcHR+mNwa7mzOO
	6YpmvGsro9wRZJ5xZHPSh54OIbgG+/E8Q2/Duv04WjJ/OtRiRnvWsFllzL+sKemQ
	X1lyGDALg9RCb05mg6gm3d8bW4+0sRWtV/ZCkbkRWQ==
X-ME-Sender: <xms:wOClZfJj9Gfln2C7hO_cohyg9yVYgHRlnXt0XM-LnjfLc5JJzE5S7w>
    <xme:wOClZTIW6BsWHBQQI7d8b7-PDpNG97amr3C6AtbdTX64naSeBLf3CliZdh9KeJGDY
    70mKq-_88TOVC8QeJ4>
X-ME-Received: <xmr:wOClZXu3Oi_QfmG26AM-JbrQxbwyMqWXVYfKsb496i58Qvx6H9yg5IQTGpIEs20840GQHVXQcM3sTXSWuxeQKQfFJ9HuBOKeH6iR>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejvddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepvfgrkhgr
    shhhihcuufgrkhgrmhhothhouceoohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhird
    hjpheqnecuggftrfgrthhtvghrnhepveeilefhudekffehkeffudduvedvfeduleelfeeg
    ieeljeehjeeuvdeghfetvedvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhp
X-ME-Proxy: <xmx:wOClZYYNIPERo_LwLRYCAB3H0P0_sImAeFi7ds2ZCRsUgJRGnd8qMQ>
    <xmx:wOClZWbql16J6kIxxD2apOQLm_l3rfobsjCLUKuMRW8OxTAcPaHmRw>
    <xmx:wOClZcANNc64n9EDkYQ254lwPCZd_Mdgc17rX5Ob8HJ5lAlRrg1GiA>
    <xmx:wOClZdznBnGvgAYr2vjc6NMQWHPyQddsmH4x-jB4uLKd2c3ZqUgB5Q>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Jan 2024 20:49:49 -0500 (EST)
Date: Tue, 16 Jan 2024 10:49:46 +0900
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
	a.mark.broadworth@gmail.com, matthias.schrumpf@freenet.de,
	LKML <linux-kernel@vger.kernel.org>, aros@gmx.com,
	bagasdotme@gmail.com
Subject: Re: Regression from dcadfd7f7c74ef9ee415e072a19bdf6c085159eb
Message-ID: <20240116014946.GA89379@workstation.local>
Mail-Followup-To: Takashi Sakamoto <o-takashi@sakamocchi.jp>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	a.mark.broadworth@gmail.com, matthias.schrumpf@freenet.de,
	LKML <linux-kernel@vger.kernel.org>, aros@gmx.com,
	bagasdotme@gmail.com
References: <f878b188-3fe4-420c-9bcb-b431ac6088dd@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f878b188-3fe4-420c-9bcb-b431ac6088dd@amd.com>

Hi,

The change for 1394 OHCI driver, aimed at suppressing the unexpected
system reboot in AMD Ryzen machine[1], has been merged into Linux kernel
v6.7[2]. It has also been applied to the following releases of stable and
longterm kernels.

* 6.6.11[3]
* 6.1.72[4]
* 5.15.147[5]
* 5.10.208[6]
* 5.4.267[7]
* 4.19.305[8]
* 4.14.336[9]

Once the downstream distribution project provides the corresponding kernel
packages, you should no longer encounter the unexpected system reboot.

Note that the following combination of hardware is not necessarily suitable,
depending on your use case:

* Any type of AMD Ryzen machine
* 1394 OHCI hardware consists of:
    * Asmedia ASM1083/1085
    * VIA VT6306/6307/6308

When working with time-aware protocol, such as audio sample processing, it
is advisable to avoid the combination. The change accompanies a functional
limitation that the software stack does not provides precise hardware time
in this case.

If you choose to continue using AMD Ryzen machine, the recommendation is
to replace the 1394 OHCI hardware with another one. Conversely, if you
choose to continue using the 1394 OHCI hardware, the recommendation is to
use the machine provided by vendors other than AMD.

Thanks for your report and long patience.

[1] https://git.kernel.org/torvalds/linux/c/ac9184fbb847
[2] https://lore.kernel.org/lkml/CAHk-=widprp4XoHUcsDe7e16YZjLYJWra-dK0hE1MnfPMf6C3Q@mail.gmail.com/
[3] https://lore.kernel.org/lkml/2024011058-sheep-thrower-d2f8@gregkh/
[4] https://lore.kernel.org/lkml/2024011052-unsightly-bronze-e628@gregkh/
[5] https://lore.kernel.org/lkml/2024011541-defective-scuff-c55e@gregkh/
[6] https://lore.kernel.org/lkml/2024011532-lustiness-hybrid-fc72@gregkh/
[7] https://lore.kernel.org/lkml/2024011519-mating-tag-1f62@gregkh/
[8] https://lore.kernel.org/lkml/2024011508-shakiness-resonant-f15e@gregkh/
[9] https://lore.kernel.org/lkml/2024011046-ecology-tiptoeing-ce50@gregkh/


On Mon, Nov 06, 2023 at 02:14:39PM -0600, Mario Limonciello wrote:
> Hi,
> 
> I recently came across a kernel bugzilla that bisected a boot problem [1]
> introduced in kernel 6.5 to this change.
> 
> commit dcadfd7f7c74ef9ee415e072a19bdf6c085159eb (HEAD -> dcadfd7f7c7)
> Author: Takashi Sakamoto <o-takashi@sakamocchi.jp>
> Date:   Tue May 30 08:12:40 2023 +0900
> 
>     firewire: core: use union for callback of transaction completion
> 
> Removing the firewire card from the system fixes it for both reporters
> (CC'ed)
> 
> As the author of this issue can you please take a look at it?
> 
> Thanks,
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=217993

Thanks

Takashi Sakamoto

