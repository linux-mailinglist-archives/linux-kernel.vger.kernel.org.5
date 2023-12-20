Return-Path: <linux-kernel+bounces-6581-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E225819A9B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6EE19B24A6B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB521C694;
	Wed, 20 Dec 2023 08:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEDYC2jQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61121CA8C;
	Wed, 20 Dec 2023 08:36:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF05C433C8;
	Wed, 20 Dec 2023 08:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703061417;
	bh=AdqAwz81NSKcWiMU11RDDZBgCQhJ9xWGLTtbQCSJNbU=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=mEDYC2jQqWm8vnT9Nkrs+3k0nHT+0K4lQ81FXcmNW9hquUi1VceiooL6YC+EoD/v3
	 E45aScEhmnrdWxm4r26Vnxr3Rh7k+dJidaRRZ4RSjKfvl7q1yxCo6V4LpWHEdDgPhB
	 ds7woxKIH/rFoQZYoLzGAzcU0D0XzSzCn4aVWulmweX5orveJg58kyG+GspFDnbkSb
	 qSVBse1t2OgkYQQZ1c2Jrq7v7yzV4JoTZ2LsotOOEz1ScV10Ljpsk80fA5wHV3vze7
	 xDgyn3V75H+2vBfcbDeCKMPzJyhox0V3p7xlDmTsj4T3jcyMiypTc9VYAHi2Tweq9O
	 M2Pe3ZFztQnhg==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailauth.nyi.internal (Postfix) with ESMTP id 8650227C0061;
	Wed, 20 Dec 2023 03:36:55 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 20 Dec 2023 03:36:55 -0500
X-ME-Sender: <xms:pqeCZVVgQ9feUAubE_UGRljNpRwTNFakBlr6_WNwG2tE7FM85ux4qg>
    <xme:pqeCZVl-jvy4st4hso5ixDc_suLOsRu9EGHi-PSiZ-09bn9KA78kCkw5CJCPvYAQh
    inqyHR-7xiP15wgrKE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduuddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedvveeigfetudegveeiledvgfevuedvgfetgeefieeijeejffeggeeh
    udegtdevheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidquddvkeehudej
    tddvgedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdrohhrghesrghrnhgusg
    druggv
X-ME-Proxy: <xmx:pqeCZRYanC1WLiEFsG4-MAjWuA71k30OI4ivWyXUx3Ddq9cT3QLZzQ>
    <xmx:pqeCZYVLEhDPnmxHjnu2xZge4p1LMU2JvFdnJbnWOeQMjLDlPoxCCg>
    <xmx:pqeCZflpg3gqgULnEtvhu0bbQ5eyV2JyOrf1ABOQrweuKE4PBe8Rww>
    <xmx:p6eCZS-EHB8GVnpcX6MaGvLUsgqvB2pxWXT_ilSCWGl1_CSKvPBxZA>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4B72AB6008D; Wed, 20 Dec 2023 03:36:54 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <01ea8c41-88cd-4123-95c7-391640845fc3@app.fastmail.com>
In-Reply-To: <20231219-sam-sparc32-sunset-v3-v1-0-64bb44b598c5@ravnborg.org>
References: <20231219-sam-sparc32-sunset-v3-v1-0-64bb44b598c5@ravnborg.org>
Date: Wed, 20 Dec 2023 08:36:36 +0000
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Sam Ravnborg" <sam@ravnborg.org>,
 "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>
Cc: "Helge Deller" <deller@gmx.de>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Alan Stern" <stern@rowland.harvard.edu>, "Jaroslav Kysela" <perex@perex.cz>,
 "Takashi Iwai" <tiwai@suse.com>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sound@vger.kernel.org
Subject: Re: [PATCH 00/27] sparc32: sunset sun4m and sun4d
Content-Type: text/plain

On Tue, Dec 19, 2023, at 22:03, Sam Ravnborg via B4 Relay wrote:
> TODO before this can be applied:
> - Ack from davem - as he is the principal sparc maintainer
> - Tested-by: preferably on a target or QEMU (see above)
>   I expect bugs as there are some involved changes!
>
> Ideas for the future
> - Apply the most relevant downstream Gaisler patches
>   - The ones introducing CAS should have preference as we then
>     can drop the cmpxchg emulation

One note about the CAS -- as far as I can tell, the absence
of the futex() syscall on sparc32 kernels means that no glibc
from the past decade can work correctly as it now requires futex
for its internal locking, though it does work on sparc64 kernels
in compat32 mode as well as the LEON3 kernel that adds futex
support.

There have been a number of other bugs in sun4m/sun4d support that
ended up making the system unusable during the same timeframe,
I remember sysvipc being broken in native 32-bit mode (but again
not in compat mode) and I think Al Viro has a list of things that
he fixed over the years.

All of these were found through inspection rather than testing,
so there is a good chance that other fatal kernel bugs prevent
testing in qemu, at least until the fixes from Andreas' tree
are included.

       Arnd

