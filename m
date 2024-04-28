Return-Path: <linux-kernel+bounces-161446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A823C8B4C10
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 16:00:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07852281A67
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 14:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C326E610;
	Sun, 28 Apr 2024 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g6WPpEdv"
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C049D3E493
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 13:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714312796; cv=none; b=CT1o2/E4z6iQo9nwXdlfAaGQ4C6KnTEIRkTQhNKlIYr6Igks5bN8LbSm/QyIcpMFPfaMm56KbWqVUhS7GsV8ONAquqnha+ahSrJfvFAoZasGBQ7Qn/u1a0q6INelxYe2GAIWdWHLUWK9WQab+mz3rKNEhvAszmNiCKVt34SEX9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714312796; c=relaxed/simple;
	bh=ifpvloXdEiAtjgG4eP4E91YicSxPPCb+dKd9T99W3/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c52oQ6CmXyYGEZtixVk+Rd6ToXtt/4/7+8jEXAv+VgMS28khW9atY1qmeZMIuxahY0wS8Vz8zfiHYqbd5EED4bPYk2BmE4yyPx3HO0BU/Q9TgKd5mzWMs4isokzidfU2i8N7Qovle0l2dWAp5NBH+BQzAbMg5H4u/dkedcaBwew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=g6WPpEdv; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-34782453ffdso3490427f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 06:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714312793; x=1714917593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZugnSPb4SAW1kpa7qzNAd6wZf57ZPRMniC6Lpv5AqXA=;
        b=g6WPpEdvj7ShLooUPO3L1ZPqZmICGM692Qz4XrnVlMr/vnKP+UqQ4bcJJyEY6IoIsJ
         Dyyt7sAzeIXfVe4IVVUuyfuiej9JiwRsmS5+UTmgfhuMvsvM02AUsU/xEVucNXwNU+hX
         H8Twk51qoBaIXhEO7hv+gtUbb5IiKGETzmnk7Up9XTQTtthwAbMxGFzGinAx3ZsLmHvF
         X4mGay+liVT0la+GC6FSNftjqenUtZj52czoTRZs+v45rTNYBmI+1x8Ma/2RsdD8mjy0
         5XF/wL8HksnhseqDTbKP8uVA5K1GrGzR5O1Rfwg4F72HJo3wkAE7KM1u77gFof3Z7HU8
         13ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714312793; x=1714917593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZugnSPb4SAW1kpa7qzNAd6wZf57ZPRMniC6Lpv5AqXA=;
        b=WmneuYTTHwgo49yHBy58rHd721c5Iy50Oi2AbZNZ+ujgxzld2APeJ51V8F07IZJk6v
         7UvVq1oTMrpY4wgMnDBaoST+J546J42jfPrDLgmI85jcBlz7+/wlWbQ7Z+hC+Ja5HuHh
         EWJDbN1neNnZATR9YtaMHvZCtyuZppAVHXgXCcyuBFy4DxScilv1K78+a//fR2jNcllx
         R2pm6vvr2241Bp2aKJmVl0AnHb6GEuSEINMjHOqw1ulfDoAYUN6WoPlG6hiZ3H2XFSut
         NcXYMTo6GvsX3QAsse+F95JGjrEnsQIubn7UPW/BN0EzhMSw9f0SQzEa9RB1nlwd/gNS
         LHLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuoWcvAf56ev+qPizu9ORU10vgbOxXVjc+jvmXg9HzicDou6Wn9a6BZnRYM18dkR84/6YBNq4iTpjSNddoEkn1oKuspgV/CCQ1bixN
X-Gm-Message-State: AOJu0YwIpA3szghTsaGSn34dIw6rzcfNFeLEj6rW2L36y4hfdfoaJ/a7
	Qn6bbF2BUoi2XD0XyNtPNGskA9EfmDlHtsGnPVsdPCyywkHqX5YBZ1UXFUxi9ig=
X-Google-Smtp-Source: AGHT+IGsE/EPW99tYDRYqKaO70aNIu/69G93grzhRIwvisgUrFWC4P5pO98zUtP9vShBN2ocCHTsBQ==
X-Received: by 2002:a5d:6306:0:b0:34c:7410:d6c8 with SMTP id i6-20020a5d6306000000b0034c7410d6c8mr5695266wru.49.1714312792901;
        Sun, 28 Apr 2024 06:59:52 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id f7-20020a170906c08700b00a51a80028e8sm12807165ejz.65.2024.04.28.06.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Apr 2024 06:59:52 -0700 (PDT)
Date: Sun, 28 Apr 2024 16:59:48 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: pipishuo <1289151713@qq.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: fixes alignment should match open
 parenthesis
Message-ID: <e028e6a0-be04-4e1a-8932-c2fdcd7b7185@moroto.mountain>
References: <tencent_58C9EBCB7FA35A38EAD077080863D46A5D06@qq.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_58C9EBCB7FA35A38EAD077080863D46A5D06@qq.com>

On Sun, Apr 28, 2024 at 08:04:34PM +0800, pipishuo wrote:
> This patch fixes the checks reported by checkpatch.pl
> for alignment should match open parenthesis
> 
> Signed-off-by: pipishuo <1289151713@qq.com>

This is your legal name that you use to sign legal documents?  Just one
word, all lower case?

> ---
>  drivers/staging/axis-fifo/axis-fifo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
> index c51818c56dd2..04f0e5b45a8b 100644
> --- a/drivers/staging/axis-fifo/axis-fifo.c
> +++ b/drivers/staging/axis-fifo/axis-fifo.c
> @@ -376,7 +376,7 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
>  		 */
>  		mutex_lock(&fifo->read_lock);
>  		ret = wait_event_interruptible_timeout(fifo->read_queue,
> -			ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
> +						       ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
>  			read_timeout);

Checkpatch is just a tool.  It's supposed to make the code more
readable.  Sometimes it makes mistakes and makes the code worse.

If it tells you to do something crazy then just ignore it.

regards,
dan carpenter



