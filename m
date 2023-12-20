Return-Path: <linux-kernel+bounces-6583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D7F819AA1
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F0CE287DA2
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C391CA8E;
	Wed, 20 Dec 2023 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GI7hnqtp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB971B285;
	Wed, 20 Dec 2023 08:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCAC5C433CA;
	Wed, 20 Dec 2023 08:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703061452;
	bh=GfqJslkpVvJ3XXYQWsdH3Ruo4ihIvvMcg5EcfmjxGJc=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=GI7hnqtpI6VaXQzN495QY3tIVkSflZjreGel/GxS8oQ3nZ9ZmU6bLn895EsY5Yt7x
	 mSguc3HxYHXT/vQih18qXo7EhThwMX2DdPIVwPOxEOr2DntH+mghugTC3yTtB3c9bY
	 CRcR86xaPdPr+eoKnfR1zvyIf5+Pn6H3EYwFCvH09478fvM8ZKyF8VkKYv4NPtGjhJ
	 8fvGwor+CYu9qYmNugki2U2ftA3j654XUhIY1A+ufY4LtFQfMd/j93dHXC8k0Qxntl
	 Y+S2siRDTbmwHOJ80CAJDjgSoI2pDOqyfwNbcGLvBgnKSMxnfVWiCGc9ZVIckeyjAf
	 EOX60QmRkAVAg==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailauth.nyi.internal (Postfix) with ESMTP id D362727C0061;
	Wed, 20 Dec 2023 03:37:30 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Wed, 20 Dec 2023 03:37:30 -0500
X-ME-Sender: <xms:yqeCZcFNU7SBn-nKxq85NIurnFIs4X6mhGvnKpm04Er1P7CYlOSFEQ>
    <xme:yqeCZVWdNfOFTXyNpTXpbos1Vy0O7339y6NyIMxGxX5XK2biBwK-msRpHSaiNFFkF
    wtr6Dr_Ie9rXzeLNsU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdduuddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtf
    frrghtthgvrhhnpedvveeigfetudegveeiledvgfevuedvgfetgeefieeijeejffeggeeh
    udegtdevheenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegrrhhnugdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidquddvkeehudej
    tddvgedqvdekjedttddvieegqdgrrhhnugeppehkvghrnhgvlhdrohhrghesrghrnhgusg
    druggv
X-ME-Proxy: <xmx:yqeCZWKz6nCCmSHfcq4QeVeL2WGm4qZcaChnjeLBMGEusGpBWctMPg>
    <xmx:yqeCZeHYU5DDezpABXI62ZU3K6Wv1MBrwzG2hqJydfUQMzgPJp65iQ>
    <xmx:yqeCZSVCPRJttaH8HwzSz-pVNnacHI-O_4mKqgUF_PgS8pnCUvZJOg>
    <xmx:yqeCZTuBVL4M2cnR5Dyb2ypY_KR-ivxJtqYiSrA8TmGHNLyZ9SMZrQ>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 99D9AB6008D; Wed, 20 Dec 2023 03:37:30 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1364-ga51d5fd3b7-fm-20231219.001-ga51d5fd3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f3fac40a-c3cb-4535-836f-328cb2f90c86@app.fastmail.com>
In-Reply-To: <20231220064341.GA847783@ravnborg.org>
References: <20231219-sam-sparc32-sunset-v3-v1-0-64bb44b598c5@ravnborg.org>
 <20231219-sam-sparc32-sunset-v3-v1-1-64bb44b598c5@ravnborg.org>
 <2fc75a39-a6f4-42f4-ab09-d7622cb23b10@app.fastmail.com>
 <20231220064341.GA847783@ravnborg.org>
Date: Wed, 20 Dec 2023 08:37:13 +0000
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Sam Ravnborg" <sam@ravnborg.org>
Cc: "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>, "Helge Deller" <deller@gmx.de>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Alan Stern" <stern@rowland.harvard.edu>, "Jaroslav Kysela" <perex@perex.cz>,
 "Takashi Iwai" <tiwai@suse.com>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sound@vger.kernel.org
Subject: Re: [PATCH 01/27] sparc32: Update defconfig to LEON SMP
Content-Type: text/plain

On Wed, Dec 20, 2023, at 06:43, Sam Ravnborg wrote:
> On Tue, Dec 19, 2023 at 10:23:05PM +0000, Arnd Bergmann wrote:
>> On Tue, Dec 19, 2023, at 22:03, Sam Ravnborg via B4 Relay wrote:
>> > From: Sam Ravnborg <sam@ravnborg.org>
>> >
>> > This is a copy of the leon_smp defconfig found in
>> > gaisler-buildroot-2023.02-1.0.
>> >
>> > Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
>> > Cc: "David S. Miller" <davem@davemloft.net>
>> > Cc: Arnd Bergmann <arnd@kernel.org>
>> > Cc: Andreas Larsson <andreas@gaisler.com>
>> 
>> I did not get a cover letter for the series, but I looked at
> You are listed as a receiver?!?

Found it now, I was just blind.

    Arnd

