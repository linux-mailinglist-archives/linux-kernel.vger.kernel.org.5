Return-Path: <linux-kernel+bounces-76730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F2AB85FBA7
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B314F1C25005
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 14:56:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8484D148FE0;
	Thu, 22 Feb 2024 14:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDY6U8s/"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB59146016;
	Thu, 22 Feb 2024 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708613765; cv=none; b=KmAJUjegpi2EkwqlUHU9Y5cmhhTVUEG1q0WVC627Q0vCrXkPxzaCovIrNgQjevUO8GOYTu4itUzi2TE315o18Y/mBr6RBvx/hy/9BTm83rlDEO9LyLEZzs7nf2sD25n7Kv+Y1nbfdPiy/h9jm1x76F+oLqdc3uyd3tR98rPucJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708613765; c=relaxed/simple;
	bh=ecw4lqubRpOHc/IfijyA/TcpxTcfIAKGIF8jGm3nfpk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHt83FcTAiMNnCdQXU2/nQjv84KVDdJ1LrWaPVQl1MsSWxal65VznoBGPrP9VY7fuWUEr74rdhPZiyWCTZIU5DgMSWwlP3lLsQFS2iR0NDK+0z1gQAMjdqf2KXiSEH9CvOgW61yRk82rkBqOyK4uBCBgrR+NiQQ0CFC+daKaeNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kDY6U8s/; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-512d6bcd696so951094e87.1;
        Thu, 22 Feb 2024 06:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708613762; x=1709218562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z7WYw3+2f5P/txmKRfw5XaSYS9W+HgJcTS8hlvbh0fM=;
        b=kDY6U8s/r7YD64k+TQtWhcCBJPH0JZpURuWNPKVvafOpI3YUGR8f8AmFzygVNqTgWH
         6s3jxf8lfxa8j1Aym0J9cSUrZt96ki0AqCApCafCj/4NR+cH1r5FMueaMt7c4QHQNYSJ
         Dx1NYMJxSXgA4UHlxbn9kJtUlmGbUWrmche7MUAyhtr8sVkoBU7FpkO681NtEUMcphWQ
         5a0zbw6JZ5sIwCvzcUSeyeeHvy7XNO+w8WFXfjj9QglGPBCsMr+aUqgFt7pUfvCXXH7t
         L9PPU93uP5zP5b6YitdyTdcwaNq21oAcfIvsuFRRV2Ra4bYXR8oRUiunZS+JHzKiTl6Y
         GEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708613762; x=1709218562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7WYw3+2f5P/txmKRfw5XaSYS9W+HgJcTS8hlvbh0fM=;
        b=vVtMXXVbFbiOqiMSm63Zy9fapWiA+adtisy4xo85OeuEc9ElNWj6ZFztwdN8bw0Int
         pEUYOnxVmcwD9hhlKWgTkwKOGW7G4HOn8TxK7eI/b/0ijD9QykwlhPudejnNCBs8f4qP
         NaYsffEm22Cp6Mtn9zT6nWWUgqS/k5afJdAiz+A+GJNxxveYiYf9x9iwew0pYMsbazxP
         N2PPwfD3taQ1PxZYqjlNbbyeejKzR75mz331VzzN4C4fa3l8R0p/U91ZJKYKVk6D3XrY
         q8Nx63TVJOoZ+9Ajm7l97foBIfZeek8LCZjggQ3/ZPSyjNXbmQhXDBvks7vGDCHzT/zG
         RVVw==
X-Forwarded-Encrypted: i=1; AJvYcCW9tTqxqHs0TbNAmkuvXzVMrg6yboUwyAE8puW9JVPz1/U9Lc6mlzC957K+EdVHe/IYpK7amGyePZ6R3igJUcaiW1/rpB2DYk6zLHTzbu9QT6KrabOBzkNBZTLbHrMlqZaDCP2zKUrpuMrH
X-Gm-Message-State: AOJu0Yx7oaXMu+sTzCpK55niwoux72PZjrXP/8qR1H5fHtjAIUhTLjq/
	6GgthckvxXycjcktk6YiSDg/B6dnOvwDAU/wDajqHDrj+gB8o91Q
X-Google-Smtp-Source: AGHT+IFRoCgfm1uvbmwVo7lh58a1qPSYdaOpXyxm9ct+rmRpcg5TutslbWsddQGijspE3jTC1HwWZg==
X-Received: by 2002:ac2:4244:0:b0:512:bf09:9316 with SMTP id m4-20020ac24244000000b00512bf099316mr1009742lfl.8.1708613762208;
        Thu, 22 Feb 2024 06:56:02 -0800 (PST)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id e3-20020ac25463000000b00512da71b15dsm354732lfn.105.2024.02.22.06.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 06:56:01 -0800 (PST)
Date: Thu, 22 Feb 2024 17:55:58 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andy@black.fi.intel.com>, 
	Serge Semin <Sergey.Semin@baikalelectronics.ru>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jslaby@suse.com>, Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>, 
	Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>, Maxime Ripard <mripard@kernel.org>, 
	Will Deacon <will@kernel.org>, Russell King <linux@armlinux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/4] serial: 8250: Add 8250 port clock update method
Message-ID: <v26ilx3hggj37wlsgoeyzcedv2doa54vevjqlhmklambdvzkzt@xa2gsjoselyc>
References: <20200723003357.26897-1-Sergey.Semin@baikalelectronics.ru>
 <20200723003357.26897-2-Sergey.Semin@baikalelectronics.ru>
 <ZczD7KPbeRnY4CFc@black.fi.intel.com>
 <raryiklwhctwxcfj3ulbnjcl32owagiccmxpwzmszlh3vm343y@h2ehupm7uiga>
 <Zc5oYJY6W_MCpwhN@smile.fi.intel.com>
 <ow5mvkxa4g7mub3faiytsij4cyaaralcbzyn675jny5355han7@azw65mhkpwjz>
 <ZdNvBtOlxo4FlLUH@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdNvBtOlxo4FlLUH@smile.fi.intel.com>

On Mon, Feb 19, 2024 at 05:08:54PM +0200, Andy Shevchenko wrote:
> On Fri, Feb 16, 2024 at 08:19:37PM +0300, Serge Semin wrote:
> > On Thu, Feb 15, 2024 at 09:39:12PM +0200, Andy Shevchenko wrote:
> 
> ...
> 
> (thanks for the detailed explanation why you have done it that way)
> 
> > If what you suggest is to replace the serial8250_update_uartclk() body
> > with a direct uart_port::set_termios() invocation then I don't find it
> > being much clearer really. The serial8250_update_uartclk() is
> > currently specialized on doing one thing: adjusting the divider in
> > case of the UART-clock change. If instead the entire
> > serial8250_set_termios() method is called then for a reader it won't
> > be easy to understand what is really required for a 8250 serial port
> > to perceive the ref-clock change. But from the maintainability point
> > of view I guess that it might be safer to just call
> > serial8250_set_termios() indeed, since among the other things the
> > later method implies the divider update too. Thus the maintainer won't
> > need to support the two clock divider update implementations.
> 
> > From that perspective I agree, directly calling serial8250_set_termios()
> > might be more suitable despite of it' doing more than required.
> 
> Would it be possible for you to cook the patch (and test on your HW,
> since it seems the only user of that)?

Agreed. The patch should have been just landed on your work and
private inboxes.
Link: https://lore.kernel.org/linux-serial/20240222145058.28307-1-fancer.lancer@gmail.com

-Serge(y)

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 

