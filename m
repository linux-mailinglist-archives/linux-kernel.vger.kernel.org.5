Return-Path: <linux-kernel+bounces-111076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B7C288679C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EBDC1C21C38
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FAA912E7D;
	Fri, 22 Mar 2024 07:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="wh08Xc6P"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD8F12E51
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 07:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711093624; cv=none; b=mHc/82otcFWBpc57MgXAk+csFYZCYS7xpP+FS5Ew20jpyRFH/kwnjVXyYqkaN86Lx7F0dB02WrqWjWqnrYoJl0CNcLG58FofhaDLS1KTfu++IzIANnu1wOW3joDHJWOZdNui3IciVVie7D6Q71txlPNGjRPy4AesC0VouKezmBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711093624; c=relaxed/simple;
	bh=Yhw03HSz0idnna+yR34xpIkCEZSpOgZ5Sf0IEYITasY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=erQ43gHqADQFYtKj0c+QxL7ab2ESF0LPU27V2MtqSh7h4x1UdgBGTsv1bXanajCj7GlY25cUqB4SNjm0dfo5rNOsdEF1tXpxuVkTOa1J6RQoZiBgLTkjk43WQZ+cNp+yoY5zhcDahf2TUXAuapbM1JqIFuUM91fGwhGVa0RmTeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=wh08Xc6P; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-51588f70d2dso2052644e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 00:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1711093621; x=1711698421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPAa0wf/zbSEHcUANifsWrUgwG+6IErJ7w4tI2+ET3Q=;
        b=wh08Xc6PxaYRBwEUxMN6mhstqUU0qvYsZweCwbjK/MPBu7dlh+sDFexD82/7CXWarZ
         h/Kssvh0q2LaVpyjoYvToROOgB+INHmE0buwXzTq2ik+UmzTwaB/ixirseNFvMuLvvv2
         uJxc9XNVu5N8x+Z0KxGeyBLGvwAcqEQM8sLrRhyDtt0PRVam2LVNhTTyt2f/Yrcpjq88
         NKjswr/46Z/PojMJRVf+x/fa1VanyWfQmArTuvBjeFqzmbS3K1qI13LdyQmquV67TRdS
         pnTj9lrXwTv1bBXId4ZGHAsL88IH/F9pLdZq7+GZHguWtbKvc8Pq4Td/+eT+1QCFCSL9
         fywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711093621; x=1711698421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPAa0wf/zbSEHcUANifsWrUgwG+6IErJ7w4tI2+ET3Q=;
        b=WILYIOb8hi3t2ui/DFI4yIfag4IVOjqzZFvgYGSmKvhBzsLg76Fgu3lLBlgOnCZCuh
         9aJmQHa7azW7Cyio6I0qQL+I1SnW98yAsbRiPI5pBNGcrnxdcI6MITNnU2jCStttc9JC
         vBkVWWvuxLIhAuZ+bcywGbWVv9T8BEm5mM7ougX0XuxoSjO5bYvskpUA4MTxOHVLvwxp
         2DvU8lrpWNjovEtuKni20B76XOgQne9l5CSC5ScGshLzmgkyNqD1p+0Bs8+IPeE0lAYb
         /M1TNENIFa4gCSfgjwK2PanhVyfTuHbqiaopYV008F3L2eyMnyDw59kWsmyezfQG4Vku
         UHzA==
X-Forwarded-Encrypted: i=1; AJvYcCW4tI+yKaDql+9YyfuN1GxvN3Rbcy8NmPBnl6Ybk7SG1iPZAOQJMuwBBCF36f07U0+B91znJOOtiQaAfdGlx79U3hZmYJF1Gi3mpP6c
X-Gm-Message-State: AOJu0YxKCJzayJYl01lPmYBgYvJvk6i1b7a2xwZZaNN1p4ZooqADVm4o
	d+JBkdbk+EXGnmJqe71qoVujf/Etti7Hs12yowAyjEzJAoWLmqvnUXnwNXw9rVPZbomJ0TeZCyJ
	oso0IeNP2phX7krtvXm4cy/p8gIUw58VYMZN4QQ==
X-Google-Smtp-Source: AGHT+IGMlPmh6WdmqSWErCqF67TPp8BSJ8Ax+s3wvqQfGc+YdlHQhOmUL3UDDQEgmrblKQ0L8twrhkOtXf4xDSab2lM=
X-Received: by 2002:a05:6512:747:b0:513:d8e3:fe3d with SMTP id
 c7-20020a056512074700b00513d8e3fe3dmr939101lfs.26.1711093621110; Fri, 22 Mar
 2024 00:47:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320125945.16985-1-brgl@bgdev.pl> <20240322013034.GA4572@rigel>
In-Reply-To: <20240322013034.GA4572@rigel>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 22 Mar 2024 08:46:50 +0100
Message-ID: <CAMRc=MfQnZQU_t9-uDPp18vFikz_9eP6LtnWJYG0+KFgWjBcEg@mail.gmail.com>
Subject: Re: [PATCH] gpio: cdev: sanitize the label before requesting the interrupt
To: Kent Gibson <warthog618@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, stable@vger.kernel.org, 
	Stefan Wahren <wahrenst@gmx.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024 at 2:30=E2=80=AFAM Kent Gibson <warthog618@gmail.com> =
wrote:
>
> On Wed, Mar 20, 2024 at 01:59:44PM +0100, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > Let's replace all "/" with "-".
> >
>
> I actually prefer the ":" you originally suggested, as it more clearly
> indicates a tier separation, whereas a hyphen is commonly used for
> multi-word names. And as the hyphen is more commonly used the sanitized
> name is more likely to conflict.
>

Sounds good, will do.
> >
> > +     label =3D make_irq_label(le->label);
> > +     if (!label)
> > +             goto out_free_le;
> > +
>
> Need to set ret =3D -ENOMEM before the goto, else you will return 0.
>

Eek, right, thanks.

Bart

