Return-Path: <linux-kernel+bounces-6001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DB38192C0
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 23:01:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B758CB25208
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 22:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0A441C98;
	Tue, 19 Dec 2023 21:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="REx5fXq5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BABAB41874;
	Tue, 19 Dec 2023 21:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50dfac6c0beso6319364e87.2;
        Tue, 19 Dec 2023 13:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703023099; x=1703627899; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Kz9JF40z27Tc61PdR3QxG4vNBWOXy1nBSVjeHDCKSlI=;
        b=REx5fXq5HdYlzPpyxOZTXbXGgiJRrpkrzR0wEuD4CEUuLbM9DbDXcaIvZktR2IMJw9
         2HGMXeqEYH3X0v9GqOw9xXyMiOebNMfqMwQq8InjYXePGF98IKkx83esB9EWCAE0GAlR
         Dt3Xt15qRyJvq4wkW3TcKa7DroAkZWC2PTAdJak0gGHheJPbluW4aFeFJOfL8faizPe5
         v/Em5NmF+5e0afcDti/toyALGng92epnV7P3CRMDWSARjKPc4Mhfkt+T5UwGMZzsIe/N
         EhaWJPWWaJ91Jk7f+qiOgeIdbgqhoPmQeiqG4cbgAol9ihEclKvJPJ+Oq8pbEn3fEzwV
         0tVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703023099; x=1703627899;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kz9JF40z27Tc61PdR3QxG4vNBWOXy1nBSVjeHDCKSlI=;
        b=xPUtHw7eaLkaBn41r72iQit/23yIBH1BvbzYtKFyfLfSXa6x/BHinha0RhpG4/ZPhd
         Ja7sqw6mCX6PIMn0orm2SwEZlB19fraJ6NGjcctUqpZFuIcN6F7b+gz34NPfC5B1nlIg
         jgII5kLSZBh8xH5PBcxZ5S57n2VMkMLUNcgkiNm2il0Mj9ev1wR9wKTBx+5qFW30l1fL
         kCY0PyQ0kT54y9Fjc0KXEvcSVFIGGhwsDtJN7iEjE0OhNuOp6ETHkVnHcUVceBbg6pHP
         eQQ1v5qPrA2Eop4wa4AQbCJILJLmeTPngtJ4f7pjf/Ups4kqK3tVd7hCOv+UTMsVjXV5
         eExw==
X-Gm-Message-State: AOJu0Yzh3CJBT1J/3zPSzxOy/vUOXhjn5R0bpm5sYIkygZLI5IdWNqAh
	dmEcxhvCY9l3G/cFhH0j7As=
X-Google-Smtp-Source: AGHT+IGeE/9w5pHPPep+4WMt0OaCwQcV0qV9NOm1GXEkMYA1C7XmpnU1StQs7FjxHp0Oiwyx2ktz9g==
X-Received: by 2002:a05:6512:e88:b0:50b:fc9f:3031 with SMTP id bi8-20020a0565120e8800b0050bfc9f3031mr12163956lfb.90.1703023098612;
        Tue, 19 Dec 2023 13:58:18 -0800 (PST)
Received: from mobilestation ([95.79.203.166])
        by smtp.gmail.com with ESMTPSA id z9-20020a19f709000000b0050e37bb4000sm734026lfe.40.2023.12.19.13.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 13:58:18 -0800 (PST)
Date: Wed, 20 Dec 2023 00:58:16 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, 
	xiongxin <xiongxin@kylinos.cn>, Andy Shevchenko <andy@kernel.org>, hoan@os.amperecomputing.com, 
	linus.walleij@linaro.org, brgl@bgdev.pl, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@kernel.org, Riwen Lu <luriwen@kylinos.cn>
Subject: Re: [PATCH v3] gpio: dwapb: mask/unmask IRQ when disable/enale it
Message-ID: <yko4bwzrnlvncljpgyxlsvioqeyf3zxb255qexlawooqjxvedn@dkr7i7fame3n>
References: <20231219013751.20386-1-xiongxin@kylinos.cn>
 <7zdg5ujizncarxvdyahnusojiq44rzxx2zybqj4kzsonzr27gq@fm5wj7npqsk3>
 <CAHp75VceVAZYTNsJaYYRN+EMExFZSQARsJowd-CvDLRtuOPKSg@mail.gmail.com>
 <euhbczna4hk5sacb23i2xwqh2jewlek7cfceprfslpsiijhwk3@3d6vtybmgag5>
 <20231219-whispering-independent-bonobo-d14a04@lemur>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219-whispering-independent-bonobo-d14a04@lemur>

Hi Konstantin

On Tue, Dec 19, 2023 at 01:56:47PM -0500, Konstantin Ryabitsev wrote:
> On Tue, Dec 19, 2023 at 05:31:38PM +0300, Serge Semin wrote:
> > > > Also note all the tags you've already got must be preserved on the
> > > > next patch revisions. One more time:
> > > 
> > > > Acked-by: Serge Semin <fancer.lancer@gmail.com>
> > > 
> > > I recommend using `b4` for that.
> > > 
> > > it harvests tags from the email thread, so no need to care about
> > > possible misses.
> > 
> > AFAICS it doesn't pick up the tags from the previous revisions at
> > least if the new patch wasn't submitted as in-reply-to the prev one.
> 

> It's a known limitation at this time, but it will be improved in the near
> future and we'll be able to grab trailers across revisions as long as the
> patch-id remains the same.

Ok. Thanks for the note.

I am sure you are well aware of that, but in some cases the tags are
intentionally omitted in the new patch revisions for instance due to
significant patch body change. How are you going to handle that? Just
make the tags picking up optional? Perhaps making the tags handling
interactive with printing a text/context around the tag?

-Serge(y)

> 
> -K

