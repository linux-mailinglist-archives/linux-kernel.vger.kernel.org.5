Return-Path: <linux-kernel+bounces-15559-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1251822E1E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 14:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C81BB231BD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 13:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506BB19471;
	Wed,  3 Jan 2024 13:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zZgNzAT9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CFD19477
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jan 2024 13:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a27e824d65aso79260866b.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 05:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704287989; x=1704892789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jtywbxVuxT2TUpm6U6r8okBkpt1BBOM7f3JX2DpH98w=;
        b=zZgNzAT9H62NLZwe2Vn5p6U7ca8/6RUjei4Kpc1H8EihEtlDwHQ6LyB4z6aYO992n/
         +5A+U1pgR4X4DUxdnowVYi5+3pxvwQa2UbHdenaUuxBl6KsFcxbQLm9sHGrrnYUC+QvV
         fhJ55Z7e5BCG/keMhR5vGfRvkxWeLQ9CZcv0r283tZkA8daJEQ4A4QvoDQzbmqzLFVRp
         jghdxVTYAsJEF2SM+sLnoDjgRyt0R+/y1ZWP13vnXYj+djzVKE4xa4OCRMAbnqiei7kV
         cLILix+R5+Oz/Q8mdMw1ASU3qYRxNRCFnWcGzLat1XRFesDQ52SFmgxPN3rxB1U0MWf9
         OR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704287989; x=1704892789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jtywbxVuxT2TUpm6U6r8okBkpt1BBOM7f3JX2DpH98w=;
        b=RO5aW1D6+Ny41rk9ywRPBPHRlqlcWkT0UyptW4VXn/NQb2nz4J8ghIJ+Jeg6k7+Hd5
         r1bMOqjxrZlq6cleooo+8vDdVOuo5yM2pDlWam3p24EfUXBeRc2C/iOAIbjEVO7hNM4l
         sG0OBa8Dhaf2hWstxSr9sRO7vr+1VAXaffyHi0/e/nKZcIWFUOLahopcszAKFTp3f3ou
         F+4h0+OAgHl8hNtxuIhpbgKAuJc2R0RUSmmKGvJxsCytCcYAEzuU6DYTYwet7LPVVBUG
         GQrZGVXNAeEgBEflq9ZPy9M48qSnRqq2InHoj20pfvtWdKADKC/jgXIYQ5kEj9JCaXIm
         WShg==
X-Gm-Message-State: AOJu0Yzo2rYCPBkeAqZy062YzyEelW80r8LsOderytuWCNkPVKa+4kNZ
	3+Gm9X8JJf0zNwo1+UEq97yqNB/2kEUNxv6Tx+uiiOegKEE=
X-Google-Smtp-Source: AGHT+IHNoYN35Vs/ZpZGj1g1p1q3OOIkM466Dld/eRoFvZmBhON9ESinwvH56JaeY8c+WpY5YAWAUQ==
X-Received: by 2002:a17:906:d9cc:b0:a28:86fb:68fb with SMTP id qk12-20020a170906d9cc00b00a2886fb68fbmr932790ejb.71.1704287989415;
        Wed, 03 Jan 2024 05:19:49 -0800 (PST)
Received: from localhost ([102.140.209.237])
        by smtp.gmail.com with ESMTPSA id fw22-20020a170907501600b00a26b44ac54dsm11532222ejc.68.2024.01.03.05.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jan 2024 05:19:48 -0800 (PST)
Date: Wed, 3 Jan 2024 16:19:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Ryan England <rcengland@gmail.com>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	outreachy@lists.linux.dev
Subject: Re: [PATCH v2] staging: rtl8712: fix open parentheses alignment
Message-ID: <f9b34a72-42e1-43f6-b03c-5a3d05773862@moroto.mountain>
References: <ZYSemFbzTlgLROMc@kernel.ryanengland.xyz>
 <20231222094735.5554b67a@namcao>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231222094735.5554b67a@namcao>

On Fri, Dec 22, 2023 at 09:47:35AM +0100, Nam Cao wrote:
> On Thu, 21 Dec 2023 20:22:48 +0000 Ryan England <rcengland@gmail.com> wrote:
> 
> > Adhere to Linux kernel coding style.
> > 
> > Reported by checkpatch:
> > 
> > CHECK: Alignment should match open parenthesis
> > 
> > Signed-off-by: Ryan England <rcengland@gmail.com>
> > ---
> > Made corrections give the 100 line limit. Resending v2 as no change was
> > made other than including this comment below ---. Thank you for the
> > correction. Here's to learning with every submission.
> > 
> >  drivers/staging/rtl8712/os_intfs.c            |   3 +-
> >  drivers/staging/rtl8712/rtl8712_efuse.c       |   9 +-
> >  drivers/staging/rtl8712/rtl8712_recv.c        |   3 +-
> >  drivers/staging/rtl8712/rtl8712_xmit.c        |  60 +++---
> >  drivers/staging/rtl8712/rtl871x_cmd.c         | 159 +++++---------
> >  drivers/staging/rtl8712/rtl871x_cmd.h         |  37 ++--
> >  drivers/staging/rtl8712/rtl871x_ioctl_linux.c | 203 +++++++-----------
> >  7 files changed, 173 insertions(+), 301 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
> > index b18e6d9c832b..7554613fe7e1 100644
> > --- a/drivers/staging/rtl8712/os_intfs.c
> > +++ b/drivers/staging/rtl8712/os_intfs.c
> > @@ -221,8 +221,7 @@ struct net_device *r8712_init_netdev(void)
> >  
> >  static u32 start_drv_threads(struct _adapter *padapter)
> >  {
> > -	padapter->cmd_thread = kthread_run(r8712_cmd_thread, padapter, "%s",
> > -					  padapter->pnetdev->name);
> > +	padapter->cmd_thread = kthread_run(r8712_cmd_thread, padapter, "%s", padapter->pnetdev->name);
> 
> Your description claims to fix "CHECK: Alignment should match open
> parenthesis", but this one is already aligned, isn't it?

No.  It was not aligned.  There was a space character missing.

regards,
dan carpenter


