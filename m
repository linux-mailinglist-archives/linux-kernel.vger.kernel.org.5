Return-Path: <linux-kernel+bounces-2129-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4D41815838
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 08:20:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4942A1F2590E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 07:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C72134D9;
	Sat, 16 Dec 2023 07:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xBwjmUEm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263326FBA
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 07:19:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18524C433C8;
	Sat, 16 Dec 2023 07:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702711195;
	bh=g1hqMgI8g1l74P0c+B7FgDGA+41wsHf4KclcSInh/k0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xBwjmUEmjk4kcqt0RllDOAmBNmKEfL0b0TlmmfH/Ud1VwdUmym+1W3xYaQkuwRkQm
	 dCrMrUorZaXybE4I3TYcUEXjfg/H/gOvJ5tSjnu836mw/aJwPgmIB4cyOuNuskfAWg
	 xou3sGEnfP0Se87X/sJbUZ0J/vEO04NltMNimtsY=
Date: Sat, 16 Dec 2023 08:19:51 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ayush Singh <ayushdevel1325@gmail.com>
Cc: greybus-dev@lists.linaro.org, johan@kernel.org, elder@kernel.org,
	linux-kernel@vger.kernel.org, jkridner@beagleboard.org, nm@ti.com,
	yujie.liu@intel.com
Subject: Re: [PATCH V2 1/1] greybus: gb-beagleplay: Remove use of pad bytes
Message-ID: <2023121616-depict-unloving-525b@gregkh>
References: <20231211065420.213664-1-ayushdevel1325@gmail.com>
 <20231211065420.213664-2-ayushdevel1325@gmail.com>
 <2023121559-overfed-kisser-3923@gregkh>
 <e60f7697-1a1a-46a4-9def-b59cae9777a3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e60f7697-1a1a-46a4-9def-b59cae9777a3@gmail.com>

On Sat, Dec 16, 2023 at 05:39:30AM +0530, Ayush Singh wrote:
> On 12/15/23 21:50, Greg KH wrote:
> 
> > On Mon, Dec 11, 2023 at 12:24:18PM +0530, Ayush Singh wrote:
> > > Make gb-beagleplay greybus spec compliant by moving cport information to
> > > transport layer instead of using `header->pad` bytes.
> > > 
> > > Greybus HDLC frame now has the following payload:
> > > 1. le16 cport
> > > 2. gb_operation_msg_hdr msg_header
> > > 3. u8 *msg_payload
> > > 
> > > Fixes: ec558bbfea67 ("greybus: Add BeaglePlay Linux Driver")
> > > Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
> > > ---
> > >   drivers/greybus/gb-beagleplay.c | 55 ++++++++++++++++++++++++---------
> > >   1 file changed, 41 insertions(+), 14 deletions(-)
> > This doesn't apply against my char-misc-next branch at all, what did you
> > generate it against?
> > 
> > thanks,
> > 
> > greg k-h
> 
> The base commit of my tree is `0f5f12ac05f36f117e793656c3f560625e927f1b`.
> The tag is `next-20231205`.
> 
> I can rebase to a newer tag if you wish.

Please rebase on the char-misc-next branch otherwise I can not take it.

thanks,

greg k-h

