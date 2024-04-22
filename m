Return-Path: <linux-kernel+bounces-153091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584398AC8EA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 770D41C20E5B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 09:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0D5131191;
	Mon, 22 Apr 2024 09:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uwoDz0hg"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B69A12DD98
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 09:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713778221; cv=none; b=OopFpRTNe1g5FEvM4s8SyxcOYs4a5HGtIt1rlNpv2HuHPnAhJ020jD1xWvo6zk8h2plklyp4IfawaqnrtcSqdhhKvRc0S4XC02li+e7zeGuJuJ1kYMBME9oi5dWWva7d0YlqJcZlXLNlMwezcIzDUQkzCwBf6qote7KaWEoy5VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713778221; c=relaxed/simple;
	bh=yDvYw01yiHc7nujH8Xjx48EXH2L2OGKkcsQS/tBq8PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7dxjg48vTYWUtN3eHMitHPKrPKjYY9Ud3mpWSwx+4I2PV074GP18SX6GCndF0coLTkQBiU19Mix5zmJmd4UyRBeY2xZTI4ZIBDD8b2C4olVmOrwqaKbcFcNdS9p7x7NN9Ws3mGPFZrSwUA7h+X1Lziepli9mdSYbqd39M1nfSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uwoDz0hg; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a51a7d4466bso440983566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 02:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713778218; x=1714383018; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=K8YSYfmq2ar9LNSgI84bvOXDhp3dJ/k4bhfd8YT4V9Q=;
        b=uwoDz0hgD4HGZHf911YzeFUv7iy3MclHBfgkb8QpPUUrWg2/1Dh7Df9u47QWvqbpWu
         ywqBdPRnNeqKV8Bq4p45Q72AEya92MD/Ky+20APs71C7KcV4fqNlpA3O3KxkuBy0AB41
         oJyMbevl0LBOMjYRqi9e40t8dH/QbllVJr+YPbM0FY83EzkwUjXTXhEysRVJ0/SEDUY4
         7c/CSLXAPdQEwsIx9g7mb2mkd5MrBiymX1S6WQQqviGvbVK0B4Abu6Z+9zMsb0HoaRLe
         8D/2J8lZgKFlQJ8wogKNIfoiINljPN8h+hEmGh/sX3209Hb0ebkAO/QZeWMmI0luBDAL
         FmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713778218; x=1714383018;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K8YSYfmq2ar9LNSgI84bvOXDhp3dJ/k4bhfd8YT4V9Q=;
        b=kNnLU8BOU39AJk/BFRoY4EBWlqDnB4pUBxq36uuw11Px9FrC87e2jG3c1sOVMuERp8
         SVdxcCR0vA7mzS+E3yj6Qf8u9RCrdgTWdqwBZys8BSwIUsYOzwXZVY0yhCVn53njzv6Q
         nrnjICVv0IZV9iHQ8+Ti7mttn3gmrbKyeS4BO6+EOA4VqtWrGEEkymZMXQdoBvUEiQ4T
         y6KwZ7UVQ069p7Ag9ANc7aWD0UIYJdA3FfBnbjFVVjJ3GkwM8qEe1A0BCxcn0m06zJWL
         5csYfn1C2EMLQoA80oPJQv2uZ8VJkvXNBlKn4nDUz8qn6xUQOQGnjgZ9/N02ht8ez1CT
         6YiA==
X-Forwarded-Encrypted: i=1; AJvYcCXcVbHYsUCs1cRL71XFbwe7f/3nPDzmKPS2F/eJmujIe6X6ayFGjMCM5hP+lAd3QXO+Bc/roomLwCOWh/5dGJkqb8AvEwPO5viHdbMG
X-Gm-Message-State: AOJu0YxdhqMM/wJ6fHkAimG7fP51sqBmKgtNifpBjgQVMWzfsO48SBvb
	YLl9La3YTOYf8b6cHIWiP5Cidj6P7DCiICqsXRvZ7zam0HfgSvdBZ9Cpgew9RB0=
X-Google-Smtp-Source: AGHT+IFKo514P5vAAaJrUKnUxzQU7bYY8q+k1QwRXeF9G870dQzPUOmYTAUZIMgfxW22F+xHzZeOUA==
X-Received: by 2002:a17:907:7714:b0:a52:5a02:2432 with SMTP id kw20-20020a170907771400b00a525a022432mr5237564ejc.50.1713778217567;
        Mon, 22 Apr 2024 02:30:17 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id 17-20020a170906311100b00a5599f3a057sm2868731ejx.107.2024.04.22.02.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 02:30:16 -0700 (PDT)
Date: Mon, 22 Apr 2024 12:30:12 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Ezequiel =?iso-8859-1?Q?Garc=EDa?= <elezegarcia@gmail.com>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: stk1160: fix some bounds checking in
 stk1160_copy_video()
Message-ID: <f17042fd-890a-4a1e-b51e-6aead9986128@moroto.mountain>
References: <ab56c444-418a-423d-8528-cf04d5d458ef@moroto.mountain>
 <CANiDSCvGc2hv-6+THH28vE6uaTL+go7144hSYafkhp21uaM1Cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiDSCvGc2hv-6+THH28vE6uaTL+go7144hSYafkhp21uaM1Cg@mail.gmail.com>

On Wed, Apr 17, 2024 at 08:48:23PM +0200, Ricardo Ribalda wrote:
> Hi Dan
> 
> On Wed, 17 Apr 2024 at 19:51, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > The subtract in this condition is reversed.  The ->length is the length
> > of the buffer.  The ->bytesused is how many bytes we have copied thus
> > far.  When the condition is reversed that means the result of the
> > subtraction is always negative but since it's unsigned then the result
> > is a very high positive value.  That means the overflow check is never
> > true.
> >
> > Fixes: 9cb2173e6ea8 ("[media] media: Add stk1160 new driver (easycap replacement)")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > This patch is untested, I just spotted it in review.
> >
> > When this bug is fixed, the two checks for negative values of "lencopy"
> > could be removed.  I wrote a version of this patch which removed the
> > checks, but in the end I decided to leave the checks.  They're harmless.
> >
> >  drivers/media/usb/stk1160/stk1160-video.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/media/usb/stk1160/stk1160-video.c b/drivers/media/usb/stk1160/stk1160-video.c
> > index 366f0e4a5dc0..bfb97ea352e7 100644
> > --- a/drivers/media/usb/stk1160/stk1160-video.c
> > +++ b/drivers/media/usb/stk1160/stk1160-video.c
> > @@ -139,8 +139,8 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
> >          * Check if we have enough space left in the buffer.
> >          * In that case, we force loop exit after copy.
> >          */
> > -       if (lencopy > buf->bytesused - buf->length) {
> > -               lencopy = buf->bytesused - buf->length;
> > +       if (lencopy > buf->length - buf->bytesused) {
> > +               lencopy = buf->length - buf->bytesused;
> >                 remain = lencopy;
> >         }
> 
> I think it is a bit more complicated than bytesused.
> 
> bytesused does not take into consideration the actual position where
> it is going to write.
> 
> What we really want to check is if
> 
> offset = dst - buf->mem;
> if (offset + lencopy > buf->length) {
>   lencopy = buf->length - offset;
>   remain = lencopy;
> }
> 

You're right...  There is a comment explaining why we multiply the
number of lines written by two, but it doesn't really clarify anything
for me:

	/* Multiply linesdone by two, to take account of the other field */

What's the "other field"?

I kind of suspect that the stk1160_buffer_done() might be wrong as well.

	vb2_set_plane_payload(&buf->vb.vb2_buf, 0, buf->bytesused);
                                                   ^^^^^^^^^^^^^^

We're calculating the space left based on ->pos which can be reset to
zero in stk1160_process_isoc().  But ->bytesused isn't reset, so
potentially we could end up in a situation where ->bytesused is greater
than the ->length of the buffer.  Should stk1160_process_isoc() set
->bytesused to zero as well?

regards,
dan carpenter


