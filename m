Return-Path: <linux-kernel+bounces-153284-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1783C8ACBF7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D9B3B2149E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 11:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA52D146A9A;
	Mon, 22 Apr 2024 11:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SMriD5vl"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A06F145FE9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 11:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713784984; cv=none; b=uKKH8arGBC6cqdaS7dkaU+F3hMX0+dh0cBSZ4QJNrFBieqcS0G/4vz2SN+kjkb6eI0y5WZZFBZg1bTMVcRaanexKL8zvk7jtLAiSgaahSDFBqN/71vysuUZmvu6G+aMfgdaeYU6WA6JRyR/tAkjdR0gNYiolNTbihkj421C09MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713784984; c=relaxed/simple;
	bh=XGoajSu+/Do3RKNMn4jsKUYia62CDpDURgb1HAcIDEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IX27tUhKJ9viRVfChd+0Y25glyKTiXZZgGy0Hu1UKTj17QysCZqEE0gpT32CGvRlpzJevfXoPjTQKhJhYAMg4dRlmrbOzxM8Hbi6GZP1u1yH3kAPEwW5YBgwLHGg5RTS3qfBOqg3Qfhj47QlpIpo5MN6zRXpkMJudnG3EYgYfUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SMriD5vl; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a5200afe39eso467126366b.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 04:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713784980; x=1714389780; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7KxlxiaM2PGBV+BkGeXxmbLGJIAVZ06jcBBCJ5bRZFs=;
        b=SMriD5vlF+cYA17dkvNDqI3W4G1MSfctL9IlmKqsMIHxgUNoIlhZfKKxrDuayWZzPK
         8qUjN0Ru9DUySUXWCv8nCdQQJInpErUOUnF5piRGaACMfMfBwNFbzFu3l31Gli2Ucjvd
         lJ1sknoHDAEoPscFnxgP3FedYMlUy1EV4e2jBes9PhHkwpc8a1vaUS93fx28okXTZCXR
         6/B1WVG85GhMIz4MJrX2phumvDFv1Eva20q3flhNwSJySakQkVfb4RVrvqLN9Fr3Y94x
         ZNDKRT7+FI+lsGaZ1vzSGhCktGxhof6LqXhNvRCW6w+vH1teuRWrMy6YFjo6ubS7/qhX
         pryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713784980; x=1714389780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KxlxiaM2PGBV+BkGeXxmbLGJIAVZ06jcBBCJ5bRZFs=;
        b=ftGXe1NiistbiP4uVXL/6pyOfQOYUJptDtr3ST92+GOcVthRJnbfdzrNQ7ci1tOG0z
         qV8cVWZDu1vlqDQkNw0i8AYFJtFNpoo4ZomsGVqql6Yh8ZaPW37oP5lr6+0VK7Ur75PL
         MmgvrXK/B5cMsVtJUiF9ouvHbiJKnOJpFf90cS4UrNLwTmEvRchloEz4iHubjHGr7RlP
         i7fPL93Gknf3RxkVHCAW2wMgcTPuL+xUTP/dSbMm/qyy5XsP4b43Xcj8qy0pjLxTkS2D
         m0fCGjrBBklBH0LWs5wsOcxPevYoZ5rxizpJGo0OHY28ejtTjfPeq8hB6rJajWRPikYI
         kfjA==
X-Forwarded-Encrypted: i=1; AJvYcCXig10tx9bc5tKcKxl0d22z87xozyxVjS92VZx6lj8cXVCYk6JaThMvw/vpE7HvroDCEvAdKpMEcsUvCU5JMj5MpMbCm2//7FZrPEiy
X-Gm-Message-State: AOJu0YwqBCF/GuJvi3t6Tp6oQSwg2AIm1RD0Whk8s5nQd/INaCC2bKrG
	RqEekhxOLZr+o2WWNuVejOzsGXminRtp0gg0EJFdcVgXxYKAuOqXjw/oI16Bb48=
X-Google-Smtp-Source: AGHT+IF0sIK+G+eqh6ZNY5C0/zr8EDIQ7ynWfEBKk80BR2SveU6nr66XABxJ/pSEjMBgs40I7BL8qg==
X-Received: by 2002:a17:906:c1cf:b0:a52:3316:bc29 with SMTP id bw15-20020a170906c1cf00b00a523316bc29mr8835339ejb.3.1713784980311;
        Mon, 22 Apr 2024 04:23:00 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id k15-20020a170906128f00b00a473a1fe089sm5640374ejb.1.2024.04.22.04.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 04:22:59 -0700 (PDT)
Date: Mon, 22 Apr 2024 14:22:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Ezequiel =?iso-8859-1?Q?Garc=EDa?= <elezegarcia@gmail.com>,
	Ghanshyam Agrawal <ghanshyam1898@gmail.com>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: stk1160: fix bounds checking in
 stk1160_copy_video()
Message-ID: <f2e9cdcd-46e7-41ab-9d5f-c1237a0a6222@moroto.mountain>
References: <e43980df-1ca5-459d-b037-788dd7d9085d@moroto.mountain>
 <CANiDSCtjEPqEstuo92QeVK_rWkW9icsjKWakPyN19ETM+MJuuQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiDSCtjEPqEstuo92QeVK_rWkW9icsjKWakPyN19ETM+MJuuQ@mail.gmail.com>

On Mon, Apr 22, 2024 at 05:52:36PM +0800, Ricardo Ribalda wrote:
> Hi Dan
> 
> On Mon, 22 Apr 2024 at 17:32, Dan Carpenter <dan.carpenter@linaro.org> wrote:
> >
> > The subtract in this condition is reversed.  The ->length is the length
> > of the buffer.  The ->bytesused is how many bytes we have copied thus
> > far.  When the condition is reversed that means the result of the
> > subtraction is always negative but since it's unsigned then the result
> > is a very high positive value.  That means the overflow check is never
> > true.
> >
> > Additionally, the ->bytesused doesn't actually work for this purpose
> > because we're not writing to "buf->mem + buf->bytesused".  Instead, the
> > math to calculate the destination where we are writing is a bit
> > involved.  You calculate the number of full lines already written,
> > multiply by two, skip a line if necessary so that we start on an odd
> > numbered line, and add the offset into the line.
> >
> > To fix this buffer overflow, just take the actual destination where we
> > are writing, if the offset is already out of bounds print an error and
> > return.  Otherwise, write up to buf->length bytes.
> >
> > Fixes: 9cb2173e6ea8 ("[media] media: Add stk1160 new driver (easycap replacement)")
> > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > ---
> > v2: My first patch just reversed the if statement but that wasn't the
> > correct fix.
> >
> > Ghanshyam Agrawal sent a patch last year to ratelimit the output from
> > this function because it was spamming dmesg.  This patch should
> > hopefully fix the issue.  Let me know if there are still problems.
> >
> >  drivers/media/usb/stk1160/stk1160-video.c | 20 +++++++++++++++-----
> >  1 file changed, 15 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/media/usb/stk1160/stk1160-video.c b/drivers/media/usb/stk1160/stk1160-video.c
> > index 366f0e4a5dc0..e79c45db60ab 100644
> > --- a/drivers/media/usb/stk1160/stk1160-video.c
> > +++ b/drivers/media/usb/stk1160/stk1160-video.c
> > @@ -99,7 +99,7 @@ void stk1160_buffer_done(struct stk1160 *dev)
> >  static inline
> >  void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
> >  {
> > -       int linesdone, lineoff, lencopy;
> > +       int linesdone, lineoff, lencopy, offset;
> >         int bytesperline = dev->width * 2;
> >         struct stk1160_buffer *buf = dev->isoc_ctl.buf;
> >         u8 *dst = buf->mem;
> > @@ -139,8 +139,13 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
> >          * Check if we have enough space left in the buffer.
> >          * In that case, we force loop exit after copy.
> >          */
> > -       if (lencopy > buf->bytesused - buf->length) {
> > -               lencopy = buf->bytesused - buf->length;
> > +       offset = dst - (u8 *)buf->mem;
> > +       if (offset > buf->length) {
> Maybe you want offset >= buf->length.
> 

The difference between > and >= is whether or not we print an error
message.  In the original code, we didn't print an error message for
this and I feel like that's the correct behavior.

> And remember to add at the beginning of the function
> 
> if (!len)
>  return 0;
> 

That's checked in the caller so it's fine.

   260                  /* Empty packet */
   261                  if (len <= 4)
   262                          continue;

Generally we don't add duplicate checks.

> And I would have done:
> len -= 4;
> src += 4;
> 
> In the caller function
> 

I don't really think it makes sense to move that into the caller and
anyway, doing cleanups like this is outside the scope of this patch.
Really, there is a lot that could be cleaned up here.  People knew there
was a bug here but they didn't figure out what was causing it.  We could
delete that code.  Looking at it now, I think that code would actually
be enough to prevent a buffer overflow, although the correct behavior is
to write up to the end of the buffer instead of returning early.
Probably?

To be honest, I'm still concerned there is a read overflow in
stk1160_buffer_done().  I'd prefer to do:

	len = buf->bytesused;
	if (len > buf->length) {
		dev_warn_ratelimited(dev->dev, "buf->bytesused invalid %u\n", len);
		len = buf->length;
	}
	vb2_set_plane_payload(&buf->vb.vb2_buf, 0, len);

regards,
dan carpenter

diff --git a/drivers/media/usb/stk1160/stk1160-video.c b/drivers/media/usb/stk1160/stk1160-video.c
index ed261f0241da..f7977b07c066 100644
--- a/drivers/media/usb/stk1160/stk1160-video.c
+++ b/drivers/media/usb/stk1160/stk1160-video.c
@@ -112,16 +112,6 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
 	u8 *dst = buf->mem;
 	int remain;
 
-	/*
-	 * TODO: These stk1160_dbg are very spammy!
-	 * We should check why we are getting them.
-	 *
-	 * UPDATE: One of the reasons (the only one?) for getting these
-	 * is incorrect standard (mismatch between expected and configured).
-	 * So perhaps, we could add a counter for errors. When the counter
-	 * reaches some value, we simply stop streaming.
-	 */
-
 	len -= 4;
 	src += 4;
 
@@ -160,18 +150,6 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
 	if (lencopy == 0 || remain == 0)
 		return;
 
-	/* Let the bug hunt begin! sanity checks! */
-	if (lencopy < 0) {
-		printk_ratelimited(KERN_DEBUG "copy skipped: negative lencopy\n");
-		return;
-	}
-
-	if ((unsigned long)dst + lencopy >
-		(unsigned long)buf->mem + buf->length) {
-		printk_ratelimited(KERN_WARNING "stk1160: buffer overflow detected\n");
-		return;
-	}
-
 	memcpy(dst, src, lencopy);
 
 	buf->bytesused += lencopy;
@@ -208,17 +186,6 @@ void stk1160_copy_video(struct stk1160 *dev, u8 *src, int len)
 		if (lencopy == 0 || remain == 0)
 			return;
 
-		if (lencopy < 0) {
-			printk_ratelimited(KERN_WARNING "stk1160: negative lencopy detected\n");
-			return;
-		}
-
-		if ((unsigned long)dst + lencopy >
-			(unsigned long)buf->mem + buf->length) {
-			printk_ratelimited(KERN_WARNING "stk1160: buffer overflow detected\n");
-			return;
-		}
-
 		memcpy(dst, src, lencopy);
 		remain -= lencopy;
 

