Return-Path: <linux-kernel+bounces-98939-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC30878146
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:06:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D92A1F22670
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3314A3FE3F;
	Mon, 11 Mar 2024 14:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RrdbAr2g"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB0A1804C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 14:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710165950; cv=none; b=JR82+Qs3izLhv+68XixuG4XemSk+I4CQYhnY4lpDbl7lIrcelTE7SqQhJDPL9+d/k0vw4u1BHxW1rTz8oDnvMl/guSjm//sN4cGokSF3Kh+Jhv8zIWQGvnWi5QXnaChONR8saPujNAQKjIEQlteV2pI/aiZIukBJsKxRjECvRFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710165950; c=relaxed/simple;
	bh=UHMR4pqbVOsU7aLmYcmKHPDC47wVCRagl/RwfRJq63k=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=VToyh24Z3j1n406RWUnu8ILXnzoM+MgEBNxNBtfIdHY4i3C8Dz5a4lBryBEzh3OvSo7VilJh2wx0NmgwCmsIx5j7kWHaOhZkP79+y2E3fkasCMmD55IlKg1St1xPbv2ftP5IeAfoyqDlhM169qGSHtHvNKkZmJ8B2nV0VdEMxaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RrdbAr2g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A5EC43390;
	Mon, 11 Mar 2024 14:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710165950;
	bh=UHMR4pqbVOsU7aLmYcmKHPDC47wVCRagl/RwfRJq63k=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=RrdbAr2gSdjhpVdUBVPwYvAG4+DM+/qYkT05L4bnOO+la235nWy4j4FPFjdoOsM6w
	 guAHI05KdupyQoxAymBRuof8g6z2NDTM2A87A5QE0pTYOyWxCJnp+JqL3RPp5TD6wI
	 C4a9eFYmb4yCv0F9mqpXpCvUOBdou5kwkIyNPbuThJegi9X4od2mKpkMilbZkhXyd7
	 kusPYGGkciIOZ6QfOEsAXx8nI0Ci2WeajJ10zhBw9LqRiaDZVpN/JriVfMa/lDjLXQ
	 zeCSrVdLQZfEzneHRSSSIYaJWk/XfrjLb1yE0JE+TyOFwkSMYICfOkpS4U40Vl1ezu
	 ASvyAsULDBg7Q==
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 68A761200088;
	Mon, 11 Mar 2024 10:05:48 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 11 Mar 2024 10:05:48 -0400
X-ME-Sender: <xms:ug_vZTcns5F4VmSCmWfMFHId3q_1TySUB9svi28M7jXUMKjzZWEcfg>
    <xme:ug_vZZM4LR-RfsVVNtvCkpGCLxiYOIumDRJbGSaSg7X8TpXw8TVAVj-MIoktW5qc4
    EBKqnTmKtQEBtwS4cI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedugdeitdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtffrrg
    htthgvrhhnpeejvddvjeffveevffdvjeejgedukeegfffhkeektdduffffueekffffudef
    vddvgfenucffohhmrghinhepvghvvghrhihthhhinhhgvddrtghomhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugdomhgvshhmthhp
    rghuthhhphgvrhhsohhnrghlihhthidquddvkeehudejtddvgedqvdekjedttddvieegqd
    grrhhnugeppehkvghrnhgvlhdrohhrghesrghrnhgusgdruggv
X-ME-Proxy: <xmx:ug_vZciA-X89FEkRLmH215-3DCIfaE78E_Bfi-DInAFk0Bgv0Va0fg>
    <xmx:ug_vZU_xMhQH6SZHBrp1cIU0BKMmfi5uN5ICgrxlkRt0bOe_npcSrQ>
    <xmx:ug_vZft8lZE6MOdPg3eeqURAlEm5sOtM_senXg9kxOnU_aomYU47XA>
    <xmx:vA_vZalNjXxjw9dINZlH-FGuq_Ai571BMTrFHUfKs9bLNSBRXUSje_g8Tyc>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 94D7FB6008D; Mon, 11 Mar 2024 10:05:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e387ad3c-7646-49b6-a5f5-afd287556d8c@app.fastmail.com>
In-Reply-To: <20240309-sunset-v2-28-f09912574d2c@ravnborg.org>
References: <20240309-sunset-v2-0-f09912574d2c@ravnborg.org>
 <20240309-sunset-v2-28-f09912574d2c@ravnborg.org>
Date: Mon, 11 Mar 2024 15:05:25 +0100
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Sam Ravnborg" <sam@ravnborg.org>,
 "David S . Miller" <davem@davemloft.net>,
 "Andreas Larsson" <andreas@gaisler.com>
Cc: "Helge Deller" <deller@gmx.de>, "Randy Dunlap" <rdunlap@infradead.org>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
 "Kjetil Oftedal" <oftedal@gmail.com>,
 "Thomas Zimmermann" <tzimmermann@suse.de>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Alan Stern" <stern@rowland.harvard.edu>, "Jaroslav Kysela" <perex@perex.cz>,
 "Takashi Iwai" <tiwai@suse.com>, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sound@vger.kernel.org
Subject: Re: [PATCH v2 28/28] fbdev/p9100: Drop now unused driver p9100
Content-Type: text/plain

On Sat, Mar 9, 2024, at 19:15, Sam Ravnborg via B4 Relay wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
>
> The p9100 driver is only relevant for the Sparcbook 3 machine,
> and with sun4m support removed this driver is no longer relevant.
>
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Acked-by: Arnd Bergmann <arnd@kernel.org>
> Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Arnd Bergmann <arnd@kernel.org>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: Helge Deller <deller@gmx.de>
> ---
>  drivers/video/fbdev/Kconfig  |   8 -
>  drivers/video/fbdev/Makefile |   1 -
>  drivers/video/fbdev/p9100.c  | 372 -------------------------------------------
>  3 files changed, 381 deletions(-)

I tried to figure out if there are other drivers in the same
category and found the list at
https://everything2.com/title/Sun+graphics+cards

As far as I can tell, the only SBUS graphics that were
shipped on sparc64 are FB_FFB and FB_CG6, so we could
go further and remove BW2, CG3, TCX, CG14 and LEO as
well.

No need to change anything here for the moment, dropping
p9100 is already a step in the right direction.

     Arnd

