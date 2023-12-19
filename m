Return-Path: <linux-kernel+bounces-6039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64042819373
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:23:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24CBF28A381
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4913D0CB;
	Tue, 19 Dec 2023 22:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aLpBgKcb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871673D0AF;
	Tue, 19 Dec 2023 22:23:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B0CC433C7;
	Tue, 19 Dec 2023 22:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703024606;
	bh=lZ30IhwGFLMBhfwISOG2BgYm93YxFRidrCef3XByU90=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=aLpBgKcbzkZv7iOaONsnHAW//tb1T5FpH+PqYlUDOB9W0XmOqlspwbh1Rx2Yg5xu+
	 gqcWA/TBW01zUGQe4JqU3Qk1vmr8/X3+9D8z5dSbnvnPT3MDPufz7suolpcnjOmc2a
	 VoML/aITwdqogKJkK+jEXkpC01G6u4p7EQ/qHP84uPlQvxdlydxyvUS9cpJY0VJUsz
	 P2XpBUxxZ7cdcEsur3tDHHEf/2p2Iyxt2MPdZud3byxi8ehi9SOrYcg9aDmtW3Ld17
	 EHcL5P0CtcwE+ienZ2CVonI4+32D8DJOG1ZAbVvJTWL+XItGJef6DUAbIcmkFki2N/
	 8QzEFizsG4quw==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailauth.nyi.internal (Postfix) with ESMTP id 69B3C27C005A;
	Tue, 19 Dec 2023 17:23:24 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 19 Dec 2023 17:23:24 -0500
X-ME-Sender: <xms:2xeCZcX6ponX-c0PqLmlTlJijU2kwXgM5zvNzn83-nAxyW-g5yIckQ>
    <xme:2xeCZQng9-zZHEup6793xn5LXCNVTaKpGa26yaLL4wTqzC-eBrwDUzgUskWE8SgtP
    huLbPb_WsloylwtGVs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvddutddgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedvveeigfetudegveeiledvgfevuedvgfetgeefieeijeejffeggeeh
    udegtdevheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidquddvkeehudej
    tddvgedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdrohhrghesrghrnhgusg
    druggv
X-ME-Proxy: <xmx:2xeCZQbSfuYkSOgv-VH-DNRi2peLhH--iP1usJ2V8WiZR-V3Uq6T3Q>
    <xmx:2xeCZbU8HCuSDgjla4TLiYne2QmcTX1BmQkAgUzptRSzK48fRYvclQ>
    <xmx:2xeCZWk7sOIhjbmHMbIAVToZKb7C0ayQ3rlzumWhb9DZ7-Fql5hSMw>
    <xmx:3BeCZR9nDJ8LXL-vTRFkSmr2QVYFPgoYdfR71TGFcShiAPNhHmZaEg>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id EFFF7B6008D; Tue, 19 Dec 2023 17:23:22 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2fc75a39-a6f4-42f4-ab09-d7622cb23b10@app.fastmail.com>
In-Reply-To: <20231219-sam-sparc32-sunset-v3-v1-1-64bb44b598c5@ravnborg.org>
References: <20231219-sam-sparc32-sunset-v3-v1-0-64bb44b598c5@ravnborg.org>
 <20231219-sam-sparc32-sunset-v3-v1-1-64bb44b598c5@ravnborg.org>
Date: Tue, 19 Dec 2023 22:23:05 +0000
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
Subject: Re: [PATCH 01/27] sparc32: Update defconfig to LEON SMP
Content-Type: text/plain

On Tue, Dec 19, 2023, at 22:03, Sam Ravnborg via B4 Relay wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
>
> This is a copy of the leon_smp defconfig found in
> gaisler-buildroot-2023.02-1.0.
>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Arnd Bergmann <arnd@kernel.org>
> Cc: Andreas Larsson <andreas@gaisler.com>

I did not get a cover letter for the series, but I looked at
all 27 patches and they all look good to me, nice cleanup!

Acked-by: Arnd Bergmann <arnd@arndb.de>

