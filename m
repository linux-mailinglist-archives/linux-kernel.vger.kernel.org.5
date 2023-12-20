Return-Path: <linux-kernel+bounces-6392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 900DF819851
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 06:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9C4DB22FC6
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 05:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7AF11732;
	Wed, 20 Dec 2023 05:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rbxzw+l7"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5192C16403;
	Wed, 20 Dec 2023 05:52:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E64C433C7;
	Wed, 20 Dec 2023 05:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703051568;
	bh=z+L9PI6kli5nZdtjmw6TPPngwiXMCNwjQXBOgKSPlZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rbxzw+l7Bdx9oVbdz8zr5v82cQZufrjuvBTLcPYPxf/etamCmyJEev3Wv/UuzbO+B
	 1RRYP5iME/P30r03xSe7wrFZVU6jJ+p1rMSf8BqBaFFked6tbCHnatO4ymelrCM7kp
	 Yjt7dsH6Hs+PpA8fw8+G4TSQciCSN4d9IszpYhME=
Date: Wed, 20 Dec 2023 06:52:46 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: sam@ravnborg.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Arnd Bergmann <arnd@kernel.org>,
	Andreas Larsson <andreas@gaisler.com>, Helge Deller <deller@gmx.de>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 24/27] sparc32: Drop config SPARC_LEON
Message-ID: <2023122034-chemist-tipping-8146@gregkh>
References: <20231219-sam-sparc32-sunset-v3-v1-0-64bb44b598c5@ravnborg.org>
 <20231219-sam-sparc32-sunset-v3-v1-24-64bb44b598c5@ravnborg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219-sam-sparc32-sunset-v3-v1-24-64bb44b598c5@ravnborg.org>

On Tue, Dec 19, 2023 at 11:03:29PM +0100, Sam Ravnborg via B4 Relay wrote:
> From: Sam Ravnborg <sam@ravnborg.org>
> 
> The only support sparc32 CPU is LEON, so there is no need for a
> config option to select it.
> 
> Signed-off-by: Sam Ravnborg <sam@ravnborg.org>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Arnd Bergmann <arnd@kernel.org>
> Cc: Andreas Larsson <andreas@gaisler.com>

For the USB stuff:

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

