Return-Path: <linux-kernel+bounces-116744-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5539C88A33C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E97CF1F3D144
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:55:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22C9158857;
	Mon, 25 Mar 2024 10:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbJf+UDs"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA237158879;
	Mon, 25 Mar 2024 09:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711358761; cv=none; b=rMMRjEk5cHDRx5yXEL8ZdOCr0n4tivRFjlYGGAaWWiDaRiuAtMGlNvlATYYsq3XvSKgG2Amj+NK6OWw3oo8bFJWmdkFt5CzuZTcs7gq/gonOsy62KoFUcHrYRHXXK8PyWkkESs+tyy0atGDT3SaGrIJL+iw4uO4UWJxdiEI3ggI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711358761; c=relaxed/simple;
	bh=GKTtPowYB770kpGGywqSA4TpQAlQog2LM2yqoXhx+HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dBaetX0+nRapp+Ht9vs3St6EMHVmVYlZBCb89PMKKFbcAuWZgw7fKTCRKxCF7TCdb8NuCRfx8dyIQ+zrx2Ghl1WO3DSbXxl0jQXtYdOnl4dRbILAdG7wxXJg1hHkMLY7nd+v4TITh/hy48Eyi/Ij43Grjjx4RaPOh0m98dQvBz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XbJf+UDs; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5bdbe2de25fso2793183a12.3;
        Mon, 25 Mar 2024 02:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711358759; x=1711963559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GKTtPowYB770kpGGywqSA4TpQAlQog2LM2yqoXhx+HM=;
        b=XbJf+UDs4KEGPQ//BECuqJcpIUp/kAYT2qAo2KQK/x4H1mIuDjQ1qWojBP0Jzmvddm
         PfpnDD8X7D/G0uayqpd/+uyO/dTSrTWCThOz4fnROHs+3xOHKTNlggKxA0PRSKDK3TUJ
         iPJugbLNeNi5VIeGgTyMjjkwA3CXhrcjsGIWDDqF3HMrT4hH0GvewX0dX4BA0SyCXlhH
         kspGQtAUIkXgeEDCr+2M4uJTiAxVs0WTJ6pi12rV+//rC0xAg+qrV5juEHesfju0uaKH
         v01/hzQo01B+fcW4WIV2jxEcnvz6yjZfmqPN3sdFjaNx3VfjpIoLIyYpeojxbpjNDB8O
         DqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711358759; x=1711963559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKTtPowYB770kpGGywqSA4TpQAlQog2LM2yqoXhx+HM=;
        b=Pl9eXDzdtuRSX8HkWlmHaAmdrJWXonoQFJagMQcGnUXxw4RSZ+ofTlwwaXYxFIzAfN
         JI3GDOQRDLN2ySHRTaSkZc6WrCXkXGlgiiwH29cDOqYpJEudN06QDjlexQsnsLs7yYw6
         0VJEBLFn+pNmS4QmeXeEAGRPwolrZAmEfc40sYi9URKuECu3u48CuhkvT/AiCmCzwyLB
         wJ69AmgXNPIFXaC6MbCT4ipTM/0pjeOlSv2GHr3C4fyALI9kexupeoX80ZZfRdocuq/R
         754ohff45GJI8uGq7NyH79hNfvhJthAEUwWmMFMHwxDDPQZeFOtEKgjBSeO3fwadbkIT
         Cheg==
X-Forwarded-Encrypted: i=1; AJvYcCWqRu4EUjAQgJ0DvtBwxDBhBPIsBby+gXVPHVQlTDucwxaAolQgS3/OGqHROvnt+kOOSnleyO3jnND2+dT77oRHt8FhtNCKjBOdK0Fj8kw2l9MdtLtWIaNq/3tcWsLICzvn4khD8SgeR4i9C4yIgRfpXsVeaS1DVQ9c1NojmzX36g==
X-Gm-Message-State: AOJu0Yw7XHZXKM5xkgBgnX89ignaA+gVg9V7r16NOpbbWgsyoZw/ugig
	O4MNyKp5ry2AGlv0HHtu2QNKyORDFhjjKlacmrnz9UBskTVuJ2m6tWdB0zt9
X-Google-Smtp-Source: AGHT+IFTzxSRhBJUEYas4N5Fxt9ePU+dtAkFsdTMD85txraTNS0VOVkE+acPU3zRPtGSh1GTsBIjaA==
X-Received: by 2002:a05:6a20:6a0e:b0:1a3:c3e0:518c with SMTP id p14-20020a056a206a0e00b001a3c3e0518cmr3928099pzk.52.1711358759119;
        Mon, 25 Mar 2024 02:25:59 -0700 (PDT)
Received: from rigel (110-175-159-48.tpgi.com.au. [110.175.159.48])
        by smtp.gmail.com with ESMTPSA id qa14-20020a17090b4fce00b002a04f430937sm3706044pjb.43.2024.03.25.02.25.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 02:25:58 -0700 (PDT)
Date: Mon, 25 Mar 2024 17:25:52 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
	stable@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3] gpio: cdev: sanitize the label before requesting the
 interrupt
Message-ID: <20240325092552.GA75236@rigel>
References: <20240325090242.14281-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240325090242.14281-1-brgl@bgdev.pl>

On Mon, Mar 25, 2024 at 10:02:42AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> When an interrupt is requested, a procfs directory is created under
> "/proc/irq/<irqnum>/<label>" where <label> is the string passed to one of
> the request_irq() variants.
>
> What follows is that the string must not contain the "/" character or
> the procfs mkdir operation will fail. We don't have such constraints for
> GPIO consumer labels which are used verbatim as interrupt labels for
> GPIO irqs. We must therefore sanitize the consumer string before
> requesting the interrupt.
>
> Let's replace all "/" with ":".
>

Looks good to me.

Reviewed-by: Kent Gibson <warthog618@gmail.com>


