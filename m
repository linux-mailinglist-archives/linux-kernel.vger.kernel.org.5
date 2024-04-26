Return-Path: <linux-kernel+bounces-159863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E13638B353D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89B8B284DA1
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38150143C55;
	Fri, 26 Apr 2024 10:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oe53OgAY"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DA813FD6F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714127102; cv=none; b=p+ybNk3Hh+h2MSg5Sz85epfOyWOI8LiTdvgSABdlLKtqBTtT3blQez/TjQSE90OKqRefJd+OZl4xNg8KhUD/21FiKccAMGEcdIez8IJrh+PseJ4rwCty5pX6v305juGHMsJqLpQW3gFCp7cjnNoFd6z7iggzqDNIPZwhkezdxqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714127102; c=relaxed/simple;
	bh=JUtYLcijeqtGgZ8mfyDZQwp8GVzEzE3g72PvSnGWSH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=II90clQHFu45BIl2RVeCyzsAGDNs5W6SmtImhs+s3atfxHjbJgmf4cSCF0sa8hS3O8X28HG9HsptASIRyCmp+qiEdmj863LeFZHoRTOp4ihag784sv0BiZ9bRir1jzTs6uRhHUq7Zmk6Hv5AUWydXqwVoVSVFUa73HJ2slvNqb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Oe53OgAY; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d8a2cbe1baso27456601fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714127099; x=1714731899; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GjocIOOFPslcP8Raryx3+Znst2AiVINzNQa4zeiKjOg=;
        b=Oe53OgAY+dB0aXmMA7c9ZnzbLT+ZZfBtAGQFgZHOFqsmy/39RCYZOlZ9VL5ovYe7bt
         CbQ0uR93upWke5g/2PaCpGPwYvzZXvbTlpxfkkVTADtGgZzHa1B8aNJj30Tb6efB8VY5
         fh+RHx3axB0EKzVtJaFMBITK2NnTZagmK7Lhc/ce7K1q78EJ49LnBmSQdCV8cm+wvCLQ
         kVe6HJVbfxav6YPvR9qCs+IicS9xIR9ACk5JFDaGTlsM0HnaTQkoq4VvO8n/XfBXy8kv
         62EIQWOq8Y7Q0auHE30gU8tVwz/hiWu/xC1XZJLFvVuYRqrnVkzdb7JJzMpztYdcB3KZ
         JGNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714127099; x=1714731899;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GjocIOOFPslcP8Raryx3+Znst2AiVINzNQa4zeiKjOg=;
        b=gkrgGMrLyMUemcQIbA4MR9yIh5ydOjrIo3Sq6+KG94DipIdwVUcPA8Fq2zUB/auOD2
         JO29KaTHk7S4NaNyhLU3ZAg5xqeYEhLPZg6m6J2CG81jRBvBo8elTAjVEV3FJAaqoDX7
         yIJgpfOvcL7RANLTcMvQqewI7ak3bGiqg6RbWFoEpDCOUV3WOKnvBt6bhUvw4OlgfSwW
         rphnLl70tGqcxIgMwGNTh/hbPBkhvNs6zKe+i/yHJ+vRASd3ecMdqSe06suAzuj65m0a
         UiAsf9MoUNy7QBIVMNOIlcNod4NkllTjzzv3Fyk9FTwENOTKQfpuh0qaAsM5SELMwHjy
         HdYg==
X-Forwarded-Encrypted: i=1; AJvYcCUupO3rgJhBarC33XDmZ4Eemt5TY6TrnJjevAmJTsEoLP2yog0+vP/Qba30O6xlYRpip+5t14aYuHQywjeTOqUqSCvUm6GYpaKVhjGc
X-Gm-Message-State: AOJu0Yysl/XHAl6Te3KLp4oBGTQY71T3tNzgRI7x47roM4PRGWFnMgz2
	gV0VcrzMfEjGhRZjZnk8Cub+7rLB8cf6rjBwDOXv6NMNpJF1LCCXSswRxx5mb04=
X-Google-Smtp-Source: AGHT+IGgmAfjUIVoeeYSKxjoNIsQG/xY+gLn8l7W0TLaues56cOcGo5fz9ODPKIQ+ni+nA+iuZuBZA==
X-Received: by 2002:a2e:9792:0:b0:2d8:5e8b:7de4 with SMTP id y18-20020a2e9792000000b002d85e8b7de4mr1773028lji.6.1714127098593;
        Fri, 26 Apr 2024 03:24:58 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id m15-20020a05600c460f00b0041a964b55ddsm1133147wmo.1.2024.04.26.03.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 03:24:58 -0700 (PDT)
Date: Fri, 26 Apr 2024 13:24:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Sungwoo Kim <iam@sung-woo.kim>
Cc: daveti@purdue.edu, Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: L2CAP: Fix slab-use-after-free in
 l2cap_send_cmd
Message-ID: <5639ab86-2d12-45ce-864c-80fbc0c79094@moroto.mountain>
References: <20240426072006.358802-1-iam@sung-woo.kim>
 <cff764c2-a3d1-4a12-9260-54122e7a1fef@moroto.mountain>
 <CAJNyHp+eCq1p_gTbxAJBKouAw-oQ=j5xwyjk5o-91pf_hGdrAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJNyHp+eCq1p_gTbxAJBKouAw-oQ=j5xwyjk5o-91pf_hGdrAg@mail.gmail.com>

On Fri, Apr 26, 2024 at 05:35:01AM -0400, Sungwoo Kim wrote:
> > > +
> > >       return chan;
> >         ^^^^^^^^^^^^
> > This doesn't fix the bug because we're returning chan.
> >
> > As soon as you call l2cap_chan_put() then chan will be freed by in the
> > other thread which is doing l2cap_conn_del() resulting in a use after
> > free in the caller.
> 
> Thank you for pointing this out.
> No caller uses the return value of l2cap_connect() if the kernel
> versions >= v6.9.
> So, l2cap_connect() can return void.
> 
> One caller uses the return value of l2cap_connect() in v4.19 <= the
> kernel versions <= v6.8.
> In this case, the caller should unlock and put a channel.
> 
> Question: Can different patches be applied for different versions like
> the above?

Ah...  Very good.  I assumed it was used.  The the commit which stopped
using the return value, commit e7b02296fb40 ("Bluetooth: Remove BT_HS"),
has been back ported to earlier kernels as well.

Generally, we just write code against the latest kernel and worry about
backports as a separate issue.  We sometimes re-write patches slightly
if that's necessary for the backport.

I'm not an expert in bluetooth, but I think your patch seems correct.
Let's make l2cap_connect() void as well.  Wait for a day or two for
other comments and then send a v2 patch.
https://staticthinking.wordpress.com/2022/07/27/how-to-send-a-v2-patch/

Here is how you write the commit message:
========================================================================

[PATCH v2] Bluetooth: L2CAP: Fix slab-use-after-free in l2cap_connect()

KASAN detected a use after free in l2cap_send_cmd().
BUG: KASAN: slab-use-after-free in l2cap_send_cmd+0x5dc/0x830 net/bluetooth/l2cap_core.c:968

[free]
l2cap_conn_del
┌ mutex_lock(&conn->chan_lock);
│ foreach chan in conn->chan_l:            ... (2)
│   l2cap_chan_put(chan);
│     l2cap_chan_destroy
│       kfree(chan)                        ... (3)  <-- chan freed
└ mutex_unlock(&conn->chan_lock);

[use]
l2cap_bredr_sig_cmd
  l2cap_connect
  ┌ mutex_lock(&conn->chan_lock);
  │ chan = pchan->ops->new_connection(pchan);  <-- allocates chan
  │ __l2cap_chan_add(conn, chan);
  │   l2cap_chan_hold(chan);
  │   list_add(&chan->list, &conn->chan_l);  ... (1)
  └ mutex_unlock(&conn->chan_lock);
    chan->conf_state			     ... (4)  <-- use after free

To fix this, this patch holds and locks the l2cap channel.

Also make the l2cap_connect() return type void.  Nothing is using the
returned value but it is ugly to return a potentially freed pointer.
Making it void will help with backports because earlier kernels did use
the return value.  Now the compile will break for kernels where this
patch is not a complete fix.

Fixes: 73ffa904b782 ("Bluetooth: Move conf_{req,rsp} stuff to struct l2cap_chan")
Signed-off-by:



