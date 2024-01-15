Return-Path: <linux-kernel+bounces-25583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 270FC82D2FF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 02:37:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9F3B1F213D4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 01:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D24617CF;
	Mon, 15 Jan 2024 01:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F8wLW30S"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB5615A8;
	Mon, 15 Jan 2024 01:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6d9b050e88cso4236430b3a.0;
        Sun, 14 Jan 2024 17:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705282614; x=1705887414; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2L44BBktsfgGbx/HQrOtfP6m1NXjdR7rs7EZsZ5Jeeo=;
        b=F8wLW30S3xYmNReOYaqIX8mWAnIcqW+7a/8c1LdNUlfmYtd80kHryZh10C3Pgh71kx
         xiDOE/XsEonW9HYATH+ftTPjGj1d4jSkHehM0GU+zm1M4WzfobwHxa0TOyYRbXCd9geo
         KdwCiXV6Ij9NYE72KzfrawQ+usZ4uT18qPzkmnmue1HRf7POpE1NDx+JsKnZhsvanxbw
         micpXbUmZFo8lyGBBJralZJE+cb/pMoWDOu0eLCFT7wCgKZsQzRCOML1OJcIxzLTC3SQ
         4pnZOr9Ir+uzX7asQMtXqK/Q9BURm5IIWhjHcK0ybi88JahvIScV6G5B+Of/ZlZjovBl
         F62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705282614; x=1705887414;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2L44BBktsfgGbx/HQrOtfP6m1NXjdR7rs7EZsZ5Jeeo=;
        b=auOzLm9kzBcWeLpVAguSq6M/uZ4ogx+l4glxT3U0y5zTUmxmjUpP7+928hzRPgTCVd
         HO1bqvQK4lBvBaJRwtBrXv+nnaUhusp+tYYXP6rMis4uGhgUbm6G86dYWXYWJXb1qKwk
         3yO6uuY4O/uqIbz+GouKZr7Uwi9HVunoqt3aGmJeO0XsfU8W5vRENbR+p3ur5+jRt+OW
         zFUvzcWCp/JIQZFcjqC9B8EfeL3snuHNxPtfH8RAVeWLjRSWs4clcC7DL08IWcOseObF
         46fUoEqb4aa/O9z1Dn6m/VxkCsOOFcBvsZkTh+TjmVxaGFR5pRHPMX44UR81+Emkaozr
         wUqA==
X-Gm-Message-State: AOJu0Yx1d61n7bpLPSk+j5a9lyt2fZFqCcVNIdyxsktck8oISe++/Slh
	SFfTTnwOMEG0NjyckkjCRBw=
X-Google-Smtp-Source: AGHT+IGer0aNpFC8FvC+YpyC4QcfTIcSha2yJUFqz2+bBw8tarweyMJ7CNFKgqJMxQ0kugFA3tskqQ==
X-Received: by 2002:a05:6a00:1995:b0:6da:c7ce:e863 with SMTP id d21-20020a056a00199500b006dac7cee863mr2132515pfl.12.1705282614495;
        Sun, 14 Jan 2024 17:36:54 -0800 (PST)
Received: from rigel (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id g4-20020a62f944000000b006daca8ecb85sm6538839pfm.139.2024.01.14.17.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jan 2024 17:36:54 -0800 (PST)
Date: Mon, 15 Jan 2024 09:36:48 +0800
From: Kent Gibson <warthog618@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org, brgl@bgdev.pl, linus.walleij@linaro.org,
	andy@kernel.org, corbet@lwn.net
Subject: Re: [PATCH v2 9/9] Documentation: gpio: move gpio-mockup into
 obsolete section
Message-ID: <20240115013648.GB27189@rigel>
References: <20240115004847.22369-1-warthog618@gmail.com>
 <20240115004847.22369-10-warthog618@gmail.com>
 <CAHp75VccZmEVLWkGYZGGYbsGsvfWzPs3ERiABEV1CF3+TLUcOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHp75VccZmEVLWkGYZGGYbsGsvfWzPs3ERiABEV1CF3+TLUcOw@mail.gmail.com>

On Mon, Jan 15, 2024 at 03:20:08AM +0200, Andy Shevchenko wrote:
> On Mon, Jan 15, 2024 at 2:50 AM Kent Gibson <warthog618@gmail.com> wrote:
> >
> > The gpio-mockup has been obsoleted by the gpio-sim, so relocate its
> > documentation into the obsolete section of the admin-guide book.
>
> ...
>
> >      Character Device Userspace API (v1) <../../userspace-api/gpio/chardev_v1>
> >      Sysfs Interface <../../userspace-api/gpio/sysfs>
> > +    Mockup Testing Module <gpio-mockup>
>
> Not because of the alphabetical ordering, but
> historically/semantically shouldn't this be in between?
> (I'm fine with either way, just asking)
>

It is in order of most interest to the reader, hopefully.
The first two are arguable, but the mockup is clearly last there.
sysfs may actually be of more interest on average, but anyone still
hanging on to sysfs deserves what they get.
If the list were longer I would switch to alphabetical.

Cheers,
Kent.


