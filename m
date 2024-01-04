Return-Path: <linux-kernel+bounces-17081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44E4682480C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 19:17:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7A801F21DC4
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 18:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774AF28DD4;
	Thu,  4 Jan 2024 18:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KuBHsCl1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BBC28DC6
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 18:17:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D219C433C8;
	Thu,  4 Jan 2024 18:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704392220;
	bh=YwcaSzQoFbc89lpvPyLjaM3jD78fBs12wpNBs2VV3iw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KuBHsCl15hYejYCQQA6x1hQqTB/AtTaEdAml9pt8WhI5sy71VQoCT7STWNYouDj3s
	 O6lf+4Y4nEefvF02gtF8H8IXT9+Cechx99B4YDclAs/1qZmSCHe6DckRXRvyYEbMGc
	 gZUxjliDXJbxoavH9Cu4wh2iXJi1CXaWru+iALWU=
Date: Thu, 4 Jan 2024 19:16:55 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Tanzir Hasan <tanzirh@google.com>
Cc: Carlos Llamas <cmllamas@google.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Christian Brauner <brauner@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	linux-kernel@vger.kernel.org, Nick Desaulniers <nnn@google.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH] android: removed asm-generic/errno-base.h
Message-ID: <2024010439-magenta-wing-8857@gregkh>
References: <20231226-binderfs-v1-1-66829e92b523@google.com>
 <eacd168f-22dd-4e11-8907-0c79ee33f595@wanadoo.fr>
 <ZZboVgcBljOgrJAI@google.com>
 <CAE-cH4r270umQbs82w=tXAJtK5J5V=Z9zJun_8jYOKJsHWb7qw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE-cH4r270umQbs82w=tXAJtK5J5V=Z9zJun_8jYOKJsHWb7qw@mail.gmail.com>

On Thu, Jan 04, 2024 at 09:32:37AM -0800, Tanzir Hasan wrote:
> On Thu, Jan 4, 2024 at 9:18 AM Carlos Llamas <cmllamas@google.com> wrote:
> >
> > On Thu, Jan 04, 2024 at 04:36:00PM +0100, Christophe JAILLET wrote:
> > > Le 26/12/2023 à 18:09, Tanzir Hasan a écrit :
> > > > asm-generic/errno-base.h can be replaced by linux/errno.h and the file
> > > > will still build correctly. It is an asm-generic file which should be
> > > > avoided if possible.
> > > >
> > > > Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
> > > > Signed-off-by: Tanzir Hasan <tanzirh@google.com>
> > > > ---
> > > >   drivers/android/binderfs.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
> > > > index 1224ab7aa070..d04ff6029480 100644
> > > > --- a/drivers/android/binderfs.c
> > > > +++ b/drivers/android/binderfs.c
> > > > @@ -29,7 +29,7 @@
> > > >   #include <linux/uaccess.h>
> > > >   #include <linux/user_namespace.h>
> > > >   #include <linux/xarray.h>
> > > > -#include <uapi/asm-generic/errno-base.h>
> > > > +#include <linux/errno.h>
> > >
> > > linux/errno.h is already included a few lines above.
> > >
> > > CJ
> > >
> >
> > Good catch! Then we should just drop the errno-base.h include.
> >
> > --
> > Carlos Llamas
> 
> Thanks for bringing that up. I will correct it and just remove the
> asm-generic header instead.

Please just send a patch removing the duplicate as I have already
applied this one.

thanks,

gre gk-h

