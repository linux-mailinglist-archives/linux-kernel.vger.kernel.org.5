Return-Path: <linux-kernel+bounces-117842-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4778D88B053
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D598C1FA56EF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AEBC8836;
	Mon, 25 Mar 2024 19:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ih6wb6o4"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E90045972
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711395762; cv=none; b=YL4Rc9GjtYlYF/DhNPW5XP774eInZoLwTqziWOB4yUabeJ8//cGAeyZvWE4qKBQHWMlrxuzCvvToSi4uPqnEDVghrwjrQL21SwO2wS/KjOrxAR2K1pCECQaoDs6b76PJU8LLWQ+GmxXNDQ1QSurylUUidwpoScoGlRtAgtoumxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711395762; c=relaxed/simple;
	bh=iR4RWM9SW15Ytpe+zLkScY//gHwgLlOIGaQIIcnl9hw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a904aYKQnvEiBbbLQ9ym16pDD/V3eIrvdEZrahe5iJ05z9sA0zXDtx1acu+7IA0LWQIQ5dqpSzqDtjRAoFc1WpA8docoFJUPazO1+0BmB71I8EC9GJtypt8RTB1CZGu22qrcNVJdPlcCa2Ttk1CWD+DOWPq9JMoj7eIWorWkhys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ih6wb6o4; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso4943688a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711395759; x=1712000559; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KuzOZKWfexqxW20YM2/HIeua9/M06pZ/a0UxyioS85Q=;
        b=ih6wb6o4s5yhwKkXv0+wXl9+wjtl592HUj8MUkwbJYKsvqRqj42Ks9CVsKZmDkRAZu
         YvRQ1tqKyoWKB2gn9fMOtul3avux0yJi1/D+h7VmZ3LAylYSsXfwIuJAYecXgTas2W+r
         G+8ZYSPJOqUxWLuyD8vvITh9x5nr2DIVDF2qrXHSbfQjmTypWIj9NIkpS9Cshe3LKFup
         b/p0V/sKF3TxkaIW3/4PAKqAwdeTD0geX/he9vz91Syl3ok6c5nqjRQJn6PSCnLgfUm1
         fXlOhoXIQJ299PDDskHXuQosxx9bKInQr1iUoHKxAbV7UPrOy7hpcV6RSSBIdfO9TgC+
         ljzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711395759; x=1712000559;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuzOZKWfexqxW20YM2/HIeua9/M06pZ/a0UxyioS85Q=;
        b=acFFCz1uMvUDXBHKtvrZ/tR0xZ3QGh9BlszGgJAiaru4e1NIMmdSCrYyC3IbAaEpjI
         j7wRm3SAsDys/+pp/N9lbN5krzKT9FqewDelV/QRrbsb/6dNO9W6WZtlmauiHxZPqi6E
         7lxeQIFyaQY4kJKfplzCGUtyXfCYXnSdwcXXOFg+sao9dHt9OkopfSES9KZUqbM6x6sh
         ho1mF6CxLkZiLevFNXJrPvdq9LTQl1KgLBz5JuxsYFB+XptgAeBhUkfjuCPB6OVwvg6s
         NdF66DI/bd9YQoj8KWtKhVlsIVCW2GtaEdl4QoOXpb0OeUdN8CCwKFw7vyxMp1kF6Ngb
         7mTQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrr836xjqSxk8+L3rkE30gj1pzNAeB9EI/QQ95E3llZAIBmRrRvXJPCDZs26U6aM4K7E3YGbz8NTEfNhGpkR0fxCDXi6GPbDAXie7R
X-Gm-Message-State: AOJu0YyMMrGlw6vEYQ5V8I6ombbwPXz34+HnHtEHf6rIW6rNxoRWgbE/
	jDTjXxoR7reyLYslhU4CjSaOGX2ncm8TObxMSxI31vHajNlHodj6Z5yVp496rPY=
X-Google-Smtp-Source: AGHT+IHJIy9p7akZElmhV942HZMfhlm4dCbkmPK86uIB7i5F9c7KRMFn/SQ4Eba22ZuVgffwIIA3og==
X-Received: by 2002:a50:c357:0:b0:56c:1884:90cb with SMTP id q23-20020a50c357000000b0056c188490cbmr1784534edb.5.1711395759202;
        Mon, 25 Mar 2024 12:42:39 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id cn28-20020a0564020cbc00b0056bf2e2c898sm3307359edb.1.2024.03.25.12.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 12:42:38 -0700 (PDT)
Date: Mon, 25 Mar 2024 22:42:35 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Prasad Pandit <ppandit@redhat.com>, florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-arm-kernel@lists.infradead.org, rjui@broadcom.com,
	sbranden@broadcom.com, linux-staging@lists.linux.dev,
	linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Prasad Pandit <pjp@fedoraproject.org>
Subject: Re: [PATCH v3] staging: bcm2835-audio: add terminating new line to
 Kconfig
Message-ID: <201b6c82-1ebf-4dc2-9221-4fc87d1dd565@moroto.mountain>
References: <20240313114126.1418453-1-ppandit@redhat.com>
 <2024032540-scrubbed-reluctant-8860@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024032540-scrubbed-reluctant-8860@gregkh>

On Mon, Mar 25, 2024 at 07:04:15PM +0100, Greg KH wrote:
> On Wed, Mar 13, 2024 at 05:11:26PM +0530, Prasad Pandit wrote:
> > From: Prasad Pandit <pjp@fedoraproject.org>
> > 
> > Add terminating new line to the Kconfig file. It helps
> > Kconfig parsers to read file without error.
> 
> What in-tree parser has a problem with this file as-is?  If it's an
> out-of-tree parser, that's different, and the tool should be fixed, no
> need to touch the kernel files for no good reason.

It's annoying to cat a file when it doesn't have a newline on the end...

dcarpenter@moroto:~/progs/kernel/trees$ cat -n drivers/staging/vc04_services/bcm2835-audio/Kconfig
     1  # SPDX-License-Identifier: GPL-2.0
     2  config SND_BCM2835
     3          tristate "BCM2835 Audio"
     4          depends on (ARCH_BCM2835 || COMPILE_TEST) && SND
     5          select SND_PCM
     6          select BCM2835_VCHIQ if HAS_DMA
     7          help
     8            Say Y or M if you want to support BCM2835 built in audio.
     9            This driver handles both 3.5mm and HDMI audio, by leveraging
    10            the VCHIQ messaging interface between the kernel and the firmware
    11            running on VideoCore.dcarpenter@moroto:~/progs/kernel/trees$
                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

So you could resend with that as a justification.  But, yeah, it's a
good idea to fix the tool as well.

regards,
dan carpenter


