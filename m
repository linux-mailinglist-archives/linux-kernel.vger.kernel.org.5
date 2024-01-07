Return-Path: <linux-kernel+bounces-18816-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7BF582636D
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 09:48:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2610EB21AF3
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jan 2024 08:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A2C7D272;
	Sun,  7 Jan 2024 08:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mBPFC6DZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8178012B69
	for <linux-kernel@vger.kernel.org>; Sun,  7 Jan 2024 08:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D2BC433C8;
	Sun,  7 Jan 2024 08:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704617296;
	bh=y4TRGGpI+/ml6LOIl+zJ3q2Dsu3lbx11HTOffjZ29Ao=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mBPFC6DZphpwY0KPi/oVKUdRbVwu/de+XIckhplPWaFQKzks0VOc7/mTGvvyNfUJx
	 s71yxRziR4uCWF10IUNpWxheIutxG2mPQXAVU4khzUFCJ0vKr1XXpuRkCFQ988QGTW
	 IYlypkRbmJYJSfRgIuuX4u9aqWOoCi/IUlqMMUEQ=
Date: Sun, 7 Jan 2024 09:48:13 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Tanzir Hasan <tanzirh@google.com>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Nick Desaulniers <nnn@google.com>, linux-kernel@vger.kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] android: removed duplicate linux/errno
Message-ID: <2024010712-sandbar-eligible-969a@gregkh>
References: <20240104-removeduperror-v1-1-d170d4b3675a@google.com>
 <ZZmBUtX82fE1c47z@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZZmBUtX82fE1c47z@google.com>

On Sat, Jan 06, 2024 at 04:35:30PM +0000, Carlos Llamas wrote:
> On Thu, Jan 04, 2024 at 07:31:36PM +0000, Tanzir Hasan wrote:
> > There are two linux/errno.h inclusions in this file. The second one has
> > been removed and the file builds correctly.
> > 
> > Fixes: 54ffdab82080 ("android: binder: binderfs.c: removed asm-generic/errno-base.h")
> 
> I'm not sure that we can I this tag before the patch hits mainline. I
> suppose it's ok since char-misc doesn't do forced updates?

Yes, char-misc does not rebase (like any sane public-facing branch.)

> Greg, is this fine?

Yes.

thanks,

greg k-h

