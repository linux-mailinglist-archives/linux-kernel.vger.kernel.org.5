Return-Path: <linux-kernel+bounces-129565-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEA6896CA1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:35:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7909828BD34
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 606C413E892;
	Wed,  3 Apr 2024 10:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fOwJ6KsG"
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFA1433AD;
	Wed,  3 Apr 2024 10:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712140378; cv=none; b=GB+9S5hhKwqYWHnKspLgTYlmY86epQWSXBXY6o9sXKAGuTeD/ksCSFtaqoLFynzshyT2dlNjYJtnHVv4Lbb6xCSv96hwoHOKeSl3/sRuYdCr/JtbAQpMq+8oBKUZBuJJTMtnCDE3V2yMt6KkOvHGnOk0LRMs81eKvEPycyvUqOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712140378; c=relaxed/simple;
	bh=TuQToBcJWagQgdnlJiJ9zMpDG3Ir29ioaeCah1P0ou4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9pxO1h1v/YiI5Uctc4tVGyKOoHtmetWbuwrj5EBPlSxgqEXvCR24HHNJZUfkY4Lnot8MHZFeLyQ9e+nQK95OLzlDGs31lE3ZaG3urGa5Ez0FP81E9KPJFRDm+zYkwVUzkAWDXfsQBO+VKLLh04sPhAemr4jk8ClBYHrAYYJvvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fOwJ6KsG; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e2235c630aso28497575ad.2;
        Wed, 03 Apr 2024 03:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712140376; x=1712745176; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pkGYvIzRK5ysJihMo+fZVI2T2PN6dzHrKdzSveBIjqI=;
        b=fOwJ6KsGbdZo/4836UvT93nGNnyD+Hr5GPi3qWLusoUM5obu19aLZhyFwPA8Uo4GES
         XhseCo9wctA6xIR3Mkikp4ChQkJxZ/kGcymK1hRu5AuTscog3dwEQbvZ+gSbrLQh5tTQ
         OgM3iy0DX9DA2Ja+g9OxrOJi1c6xUyYk0zch5Umr/zk1IgK1V+jIOlVU8+9B4H2pxEeZ
         gpJFKOUdoyNhRDO+Ojqvl2BNUxi/YUBMFDOsNCE7rzYPEkf3v55DycEPlZD+somFFNAV
         VVg9gS9pxby1veLNsKvAHD75HnAzxJZXFIWpv5c+dmOI9NctAG6kcYcu8TPbd860DtI4
         omng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712140376; x=1712745176;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pkGYvIzRK5ysJihMo+fZVI2T2PN6dzHrKdzSveBIjqI=;
        b=stDht+pa6HWhqUrAa/X1SyA+Iq4+9Swib81l6eOn6wqnuAkJAQL/OzrL0R9Xb+n3I9
         zJcniEOMratBp8wFIbTOkyc5RJ4l6EHUQFIo1o4n4ZQOOpR8XFiq+EfJt9eileTmwqWx
         9bXV2NqQR5HzW2j50XRVxHL+PmgbyBcTVzUlXNIg9wugG3LQ/svLBX3S0RmJQswA9n4k
         zXgEuiY7+7vmMKlsVm6nDLQElzRoNZWOpDcR+Z07QEHhm7tK94kRL4LOhPdO3AFGrPLf
         XJ6yLfO2oN1fOukN2/THIoCkQlZaKOnUCUUVi42vLeJ4Qm0cOnd/XqN2mhRLeo2Bx8Xx
         ojtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVxSfXOP7JSABiTEoJ+AhJEjBGiOay1rnoUP6BBqyLHe2utolu4C61jhAUWlzMTC63gtikyEF5MqR73d1r+41eNWnwMO7Z8STatFQoyygyGI0XJk0UNQBLtV0SaYVxdetuTbeBthk6L7eEJqz49aMVy6wu9IgWsbJskhVINFd0HQ==
X-Gm-Message-State: AOJu0YwnnXTbnpYT+NNHCB8GUr/WvJ1fXTCLGkh1XESg06f6A9aRnreb
	cBAdwU8lH1jZSdgbCif2BXf8PceSIIeCFKeDB0bWkuwLo+PESlk+
X-Google-Smtp-Source: AGHT+IG5PsKX/BMksYk2dhUFSWAx4aZGMFmv5WxkNzXyM4yg3pHDGWn4lYUp0qJ88EaMOGNiCO+wSQ==
X-Received: by 2002:a17:902:e892:b0:1dd:b728:b890 with SMTP id w18-20020a170902e89200b001ddb728b890mr18325766plg.18.1712140376076;
        Wed, 03 Apr 2024 03:32:56 -0700 (PDT)
Received: from rigel (194-223-186-215.tpgi.com.au. [194.223.186.215])
        by smtp.gmail.com with ESMTPSA id d5-20020a170902c18500b001dddce2291esm12900909pld.31.2024.04.03.03.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 03:32:55 -0700 (PDT)
Date: Wed, 3 Apr 2024 18:32:49 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>,
	stable@vger.kernel.org, Stefan Wahren <wahrenst@gmx.net>,
	Naresh Kamboju <naresh.kamboju@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Linux Kernel Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH] gpio: cdev: check for NULL labels when sanitizing them
 for irqs
Message-ID: <20240403103249.GA8220@rigel>
References: <20240402114159.32920-1-brgl@bgdev.pl>
 <20240403094205.GA158151@rigel>
 <CAMRc=MePwq_rnWZUA6skVqiqjxTKNLXR7cdfrrVeeaxz8Osxmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MePwq_rnWZUA6skVqiqjxTKNLXR7cdfrrVeeaxz8Osxmg@mail.gmail.com>

On Wed, Apr 03, 2024 at 11:47:21AM +0200, Bartosz Golaszewski wrote:
> On Wed, Apr 3, 2024 at 11:42 AM Kent Gibson <warthog618@gmail.com> wrote:
> >
> >
> > It occurred to me that none of my tests cover this case, as they always
> > request edges with the consumer set, so I added some and can confirm both
> > the problem and the fix.
> >
> > In the process I found another bug - we overlooked setting up the irq
> > label in debounce_setup() - the alternate path in edge_detector_setup()
> > that performs sw debounce.  That results in a double free of the
> > req->label and memory corruption hilarity follows.
> >
> > I've got a patch for that - the unfortunate part being that
> > debounce_setup() is earlier in the file than make_irq_label() and
> > free_irq_label().  Those will need to be pushed earlier, so it is
> > sure to conflict with this patch.
> > How would you prefer to proceed?
>
> Can you take my patch and just make it part of your series?
>

Will do.

Cheers,
Kent.

